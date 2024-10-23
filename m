Return-Path: <linux-kernel+bounces-378769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294899AD546
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ED31F23B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361E1E2611;
	Wed, 23 Oct 2024 20:00:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686181E2606
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713604; cv=none; b=txqdKnZBZAjgyiGxRMcm6IaaLZ5/7lLPWSC4Jgon60iWr1/QVGZggAupKKYmD47yP2oJpvXojkKOY3RPDCCTnr8sf0NrNDD15RDaQOreruTBF5HA6BW8Ztj96rjzntmaE87P7nOT8IxCYPeoFoUFtOe3Az47FY5ywMDEScg09SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713604; c=relaxed/simple;
	bh=3i2TTTMVvE63P7ks4HWcxgSaVPyPz2Ix62EMTgjJpIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZonY5MDIbJpUBB73fMDYIzbriFyQhlgZB9heTEFWTXjC54wNtmgLbzRE3Qpz1txM7ZUC4FvobzvA0NlkvCPrUt4Mg+J65ApL8+VCLnA7gK+f8DxjeZsi4GIScvKEbrFCeofnOhHqOu+YQV/Ko5eFx+QtDmoSfLpycQWJkRXFzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so1804515ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729713602; x=1730318402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vfwbD9UsVroydM+rVo46zEDwjw3+kWz3iRXXjs701U=;
        b=hj2SVwZGRrc4tRw7sSiAPlMXwoi9YYAZEMMUp+7teqYmTgBaZAKBctt1U9RWuv3puc
         adMPwLyxxTQi/EmdetHH6KZRFFA7OHRrw0dbj5b8z922mzFYE7bV3Hmo4HXA+V+v4CGf
         BPQC6ljV7HT6VKg9TivHyE9jRQpz9sGpLkVM4eXSTqVNhzvU0h65OWDGNUCbbC69+hQy
         ptvaiOj/fGgOWb5Q78lig0HkxkH/vTN5n5Fn6W/7V92n1RbcZtU+FA45toKKtpxkcxI3
         ggahSd+5Br+dxHHsS8BXs2j9PhtfCqgcG2MVI+b9XmmvuXDezu75JxxEfFEiPbQM+RzI
         dhVg==
X-Forwarded-Encrypted: i=1; AJvYcCVBoE8x50Qkl6nkgXYy06S7ayTP6ujRP+BWQ69HlSMZpasUYSejTtIh6dbBMduzQI28QCC8QwO9HvFDWE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+YE56cyWYG+slfLDdkIzoEOK5UTyknqfZI8qD/YTx708DUS0D
	VKVlU2n2uEXwAPr3styZxnmIB6ySN/Sfff18YJUlwCPLVUprJCD3/nd7RZvXZD91CYV0V8ht4en
	qWglQYJxIWIwtPAURrJ1/9JoWYkoCRnRaIdVxke2YEIuFuzP8gFgNvlY=
X-Google-Smtp-Source: AGHT+IFL9IQlsMFSEKF5gHxMAvhcGBDk6YzU3Ult9E2CV41ChmG1Ky7bdyxnJIXhj3a4zccaN/Q10MFwGFGWBPXuCCcZy+UCinwS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a4d59d808emr39692435ab.20.1729713602537; Wed, 23 Oct 2024
 13:00:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:00:02 -0700
In-Reply-To: <32ac6a1f-4427-4ffc-8b18-d4942be5b751@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671955c2.050a0220.1e4b4d.0095.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com
Tested-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135b3640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=089fad5a3a5e77825426
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1691265f980000

Note: testing is done by a robot and is best-effort only.

