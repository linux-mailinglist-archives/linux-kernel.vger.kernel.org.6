Return-Path: <linux-kernel+bounces-205502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E048FFCDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE621C25133
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED041514C3;
	Fri,  7 Jun 2024 07:17:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5E1CA85
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744623; cv=none; b=ga6ff4jpEG27clAwxJf18qoYdjJKbIuTS1ODiponAyoZYYyZcYU1xjb41naY3I1Npgx+wsUaSv91vz47ez/qwr+D5OLN2+7xdubrP+n6I/Rb9n4dnpWr0tZ5cr0r1st9O3fcEeF7fwH8fc6htuKgqCpjUdZDdrq+aMZ8tIZofrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744623; c=relaxed/simple;
	bh=8WvqJkqe65PzAvUZHZ/2BOpTJE0tqmbk0H6pD8IsYUE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kqEkiBDZVD/KJFKeHZGjih1xsf0EX2jqMwNpLsFbViXF+2/6lAbLYm8XvociIu8BE7KDN0NgD6Xkk/ylq4anfZ6saA1jyXhFBwk8t2y7jvhX1bBCANDiqdqXShsCoZCuZgr1qgP8FKbasQhao+rKkJmXLwR3LNxNgA8RIIdJ/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8dc9db8deso195062339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717744621; x=1718349421;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WvqJkqe65PzAvUZHZ/2BOpTJE0tqmbk0H6pD8IsYUE=;
        b=lPLh/trj7oCjYGSqeck7qv/BlSalehCGIGst/cXUY6NcUqhTOr9qxu2k9b7dOHxsdh
         7c4Ef/tE62LtnE+0Uh3Luqp8uXP6zL5fQJCGbW2RBLGqB9cykCBwJnLxOsW4zE0Xx9bD
         doWS/IzMnygJUm2lVi1hu7OAJf/DAwB5p7g2oYj5ujwHRWfPf21xkXubCAMGosXoJaUh
         0uCxZUZSGbjwI7Vnp/eyMdPm58i2riifM6CYr5wrDEdJYE2kuDMidbV6hskU7coQR7Ia
         71yq/Yr8ENCB+h+k72OogMQzdSTvxQH4tPkhqI9d0u+omrFD5nUp9TOyrw3MDtqs6Br5
         xZDQ==
X-Gm-Message-State: AOJu0Yw+DjpydTaNYdZlPMvIH40+gf8pSAhaKR5mv73kVmf4DIk8rvhH
	jglMqRMTOWqEHQ5C2PNZ94AWuqoHLCp2NBJ5Kln/Vo4rs6b8Ltb2S2lNpgROQu12oFiKPIrJyGF
	6dhTYEouNnNVIScgb08VTPO6AWPUtbQuuFx52VZE2y9DNjBHkeOUUagQ=
X-Google-Smtp-Source: AGHT+IEkK+wnJcqklmkmQ5mR+PuEUf45142QYu1pnhCNxUIOHBzx3/egPaQjkUnaFut53YsiqfIfX/mbY8F0v8hqMxP3V29OkEHr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:36c:4c63:9c93 with SMTP id
 e9e14a558f8ab-37580398747mr1198375ab.3.1717744621123; Fri, 07 Jun 2024
 00:17:01 -0700 (PDT)
Date: Fri, 07 Jun 2024 00:17:01 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f51538061a47957d@google.com>
Subject: Re: [syzbot] Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: 000000000000fcfa6406141cc8ac@google.com
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 5=
8fa9471b2c0e2ad0efdc2d36b643dc312020cba
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

