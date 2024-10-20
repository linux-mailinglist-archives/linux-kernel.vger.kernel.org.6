Return-Path: <linux-kernel+bounces-373168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C129A5337
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62A61C20DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CBF38FB0;
	Sun, 20 Oct 2024 09:16:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038120E33D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729415767; cv=none; b=QgPKPWA8fIXoe+c47N6/v67von0RbKLtJ3bzHhGea62XroIlDtAmUNhmBN7cp8hU1mTNqUL8TlVK3kUEknG269V15Kmb+wzWd6IdTLwwGUIq6r5XlfwsljHOW3zba6IboELEEXj7eGksu3a9/qgqvbu/Wx/5dITuID6zc6dE0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729415767; c=relaxed/simple;
	bh=2/+kO7rmRRl+iWKmkYAnpiH/FbBFooPKbNEw/Ph4hKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=st7p0CvEjxwIuLX4cVtQt1ljZUJm3c5SxV6OngD7T2yo0+IhbP8pf3FnZkzRZ2428yldzkmv2KMu8srZqY62clHnLwtEaCIsvnp3ck2s3YKwgYSfEK2AMuClKGwcqsrBY2NVnY64i31yvcANdqLIkVghz9UXNb5N/VRenERIIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bb31e3cfso31213445ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 02:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729415764; x=1730020564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wNcm3joPwoSDpa9+V3sP+X13HBmfcPQvUcjbiW3EBA=;
        b=wucaZrW8F7xByRCeqG1VhCF6kqZEsOtFaqpWsrZxfk5NnARE+bElutlMIj8t2esLZY
         DsnvEcKKOeQx30weyFWYSOa6qHMFGuP9otTOcx07Gb+TsTfCNMm6niTOkFMoxzRX6KzW
         Nl1CslHm3+xZhbYb51K2uXo7sxRKVaC38WiicGj9k8yupKVrq7UPGOJA/BK1hJFKJ5+h
         wZmxe7hDEVsyvAD8iDK1MffJt+olzzZdsv+EtRAL12X37p5HJOOSEpSI/6ZYCg0idQp5
         f+4lMi/CqW5M9CqmD5Z89WIDkk94f/9UIQV2CVYyuSr+QVLe19DKMMCWhwTrPAoY9gwa
         FUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhi15O5t/y1nVpnmay3eO1tdnPcnogGrkyy1EDF/X523V0i1l6ee5ex8rFUyPyWdIo54yObYQD+Zx1EaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIKlUX+kr6v1seAMwekEEOC2rDMuBxI5fpIftbb9omDWY4Nk/
	8sFSsfF18l0Gh5d5cCcMniSVeHLl+GVxvwtoVDCZjWkxz0fwCrUeJR3FaYRoBrM+ElSfLo+R2cc
	X3t+z75WXi8jucFP6j3T+rP/SG9Ub9YdRt+Iz4iln2DdwBAMWTtWqMJ0=
X-Google-Smtp-Source: AGHT+IGKGPylLUHl0/eUv0mOCmK0w9ZTrTn5UThRLcZgiVbEgO5WtTF7PRW8O1Jv1cgt4CPJkzdB98U3YE5d40LO2HZCCIvomnZX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a3f405e51emr65655775ab.9.1729415764675; Sun, 20 Oct 2024
 02:16:04 -0700 (PDT)
Date: Sun, 20 Oct 2024 02:16:04 -0700
In-Reply-To: <20241020080658.2124-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714ca54.050a0220.10f4f4.0030.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in uvc_status_unregister
From: syzbot <syzbot+9446d5e0d25571e6a212@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9446d5e0d25571e6a212@syzkaller.appspotmail.com
Tested-by: syzbot+9446d5e0d25571e6a212@syzkaller.appspotmail.com

Tested on:

commit:         f2493655 Add linux-next specific files for 20241018
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a88c87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=838d70a59aaad5d2
dashboard link: https://syzkaller.appspot.com/bug?extid=9446d5e0d25571e6a212
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b320a7980000

Note: testing is done by a robot and is best-effort only.

