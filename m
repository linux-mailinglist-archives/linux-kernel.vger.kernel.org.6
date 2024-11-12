Return-Path: <linux-kernel+bounces-405215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4969C4E75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDDAB20BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E5209F24;
	Tue, 12 Nov 2024 05:59:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CB208960
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391145; cv=none; b=NdbDq+Jlad8i+8QBe7Lg8ay1Njz54OwvbY/jZFwco0ICJE8cNK63YzxveDT0BQ80tQ7uC/Np4vpM2kgeLjc5Pl4qCC6KDnGoLVCWnw7EZvl34eNcTjUmNG9x/fUov1rsYHB0fwMAA/7FIzmR88Uj+qva6VzRo0LlWVhTe4TbKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391145; c=relaxed/simple;
	bh=+9DsEu3B8T2u6ZvBX8TyGBuWkYtzv1k7A7MJYS5QaH4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p0URKJuga3B7V1ZEMgxYUfbMoNNDjAMY1DncQjPwEDnimnyoKhSFmKE9EIEjdStVopqW9aoR7bd3T4l3+W6f24gnQAGli8TLPgFmcKtiQVppSC+oFBn4LdNqJo9W4on0RQ6kAKO7/59PJKjdiXdGedz8NjjJ2v3HlpShnZfdYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83adc5130e3so565387639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731391143; x=1731995943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U33q3ptGykLVXIAYKPBi1XmbTq4SvNjOtCBsD4Dnmoc=;
        b=QNMpDfLckL9dzx7Cp548ocIfwX69lM7s5ZMvGW1ldrKk5cvSnzMH/ScWuWZ9ka3NVb
         90eFyo3AwZ5ntCofGrZsDnyh1icRLqdfsEpzq0bVJOdqniveqyzKMPI+iZd51+SYiR7j
         Gun+4oRvJ73yuJnulSMj55VFCveQjHUQh2lIei5jtaU+ibtW+a+3cILczhHaxeSY4TcQ
         wcjHXYGiBcTpDIK0p+V1Vvid+I44m3dhuqYPzZ+t6tDoIQOCstaJBR10Mkv5yfXY7lcZ
         P2wc1MFWvd6WKEFeHM/Mlkv8x2SaKjCA1ao1Fx1OZE2YH4ILSkMmq0K+YnmpVEJ2X9+S
         NkIw==
X-Forwarded-Encrypted: i=1; AJvYcCWNK0YkkApd00xB3UrlNH39Ipg1U3l5jmEM2yKYxYv/Caaoi7wH1NbnUYZ0+yebrh84xi4qTP5XIIJufR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2lZEKPBWIvvfrrbi6xTfLGqHhMuoTkx7wtxwOMDML9d4AkQG
	E49Daov5V44zxJ5ljfJHg6xZXCuXmHIN1wp3Xp1qdaELMIxzmHI7G3+t6QkbaJe6h6jsDSggBBv
	FLTr21NaM5kS8VtGSGl1Fupoz5dv4qjNn0wYRmbMe29/mTLzS6tkqfpw=
X-Google-Smtp-Source: AGHT+IESqfpqwkWHyS+1sEUEtImXMTF8pIWANjrD3TQFvAcaYavXkKYrgbUttU7md4GiVnGtLGD2m759PqLSAwPZWXceo040ufXZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3a6:c472:765e with SMTP id
 e9e14a558f8ab-3a6f19c9f3bmr181070205ab.11.1731391143362; Mon, 11 Nov 2024
 21:59:03 -0800 (PST)
Date: Mon, 11 Nov 2024 21:59:03 -0800
In-Reply-To: <tencent_202369496E43BB4449F766177026C5536F05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732eea7.050a0220.138bd5.00d5.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
From: syzbot <syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com
Tested-by: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d078c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135afe30580000

Note: testing is done by a robot and is best-effort only.

