Return-Path: <linux-kernel+bounces-577488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C07A71DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02C87A6973
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E223E235;
	Wed, 26 Mar 2025 17:52:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD22192F5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011552; cv=none; b=U2623v7971PRiHfa9ZAU/xhqpzDrZun3aTba7zPYgHprd/y/WqYmlhOGvgTXnwEswOF7XywpFMEMHWaOs5WQcpjqDHAWMy3KnCBtw8omxdsCYPtwdtJG/VMbKH+T1o5RRRFdWKYIoL8YfTHDPYDNa741h0XJGeT13XmfrDoYQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011552; c=relaxed/simple;
	bh=Iaq7yK6zy8uujh45HJBkSRq9vxWAxMA2c/4QyJhG6rg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bpoGx7d18gi++spV8reJHrBU5qcRLl4KMlQy02pmwNm/L446uJWl73kAjlf7uFRQQIyupQxMNmqmDOp61doxxIaJHvdmiOnJv7lvGgk5y3A37bUZEStEA1YmwOWceQEC3iWqVHAwODRoFYYmiJCWz2HVLjqxww8lLiF5Rf8JTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d453d367a0so1300565ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011550; x=1743616350;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaq7yK6zy8uujh45HJBkSRq9vxWAxMA2c/4QyJhG6rg=;
        b=WhTM+oVQkfbbOcipidEC9NqEpt1oWD3daD6Gn2bxKasY4n3MIUuhkza/eonPDtCZXV
         G4q+auhVbjqUIDLQwrHsGs9ISwetrnU5cic5KRbCoEsnGQwRDQ3lEmPwkkgrz/f5b078
         pdL7hCto4Lzt2BTj3z+GSZOTPnIqoJEQ6QlKHPj3CXh3gxG/QywieFcgIa4hdG2Gi3pK
         jzpLSFe3a/m4sDCwoKIYXJL1q+6ftjyHGAlmIKmV8L+iOedjomZSvEObD6eoSm9k/Mr7
         LCfdRsCTTq2ktst46+7NMbrlV3qZ0aZfiT+ibgHWl8wT/AfEvcJUR3cxQl3MCfy+TfkP
         kbQw==
X-Gm-Message-State: AOJu0YyZ/ltWjndZGx2QvSEe7OsKVF7egPO90uS1G+OJTy2/K4IcQMDg
	C5G6OHGzMm/CHKTGrTSG3pdBW56AMmG9Cv6RApABzJb8WKPhd2twm/pinvOj3EA9je8fxRGmrav
	QHBejGriViK6a+uvizwVq2CRIa3OHc5BHAwoTjvmhGvoiMNx8L4mtBVY=
X-Google-Smtp-Source: AGHT+IHy+rKOw7EjTjtHWlql/UeDxhcMYpLD8AFUEne7W7zctKCHqOJ90BkSW7A8g/qbN1bw3qPjlnBYULziZ++MjRYeh3+ps35Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3d4:712e:29eb with SMTP id
 e9e14a558f8ab-3d5ccdc53c1mr7232555ab.5.1743011549906; Wed, 26 Mar 2025
 10:52:29 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:52:29 -0700
In-Reply-To: <67cd170b.050a0220.23b02d.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e43edd.050a0220.2f068f.0008.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 bch2_extent_crc_append (2)
From: syzbot <syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_crc_append (2)
Author: richard120310@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 48a5eed9ad58

