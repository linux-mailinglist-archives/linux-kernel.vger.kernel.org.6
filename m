Return-Path: <linux-kernel+bounces-254792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5F9337A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F10F1F242CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341A1B948;
	Wed, 17 Jul 2024 07:13:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D518EB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200386; cv=none; b=rgZqL39t1Xg09LctH0rFQ7VGRzRv6+oYu9RlwJDcd/CugNr0cbGWl3IbmFLSDOB32Y/EnNOYCsg1fw6zhHo/nyKA421RVtTsDXG79WtzfMYtUkkcTuXi2OKh9f5Qpb3cYg4ALbYnK3nJ444j41HRsp7TxE4X9/Wg79BhQ4Bs7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200386; c=relaxed/simple;
	bh=7iE1cPVpc8Rfetpz5YFYDXwzbGn+DbT5iB1qawTdko4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MCow/hMS+5erhNZmf4Bf8M2dth+Tqwfx72s/rq0woMHzhUsJle/6G/IxWnkNr5F38YTeYnJHRIrXa45//XGzqjgvjBiC+xTvBAE8Aqv3fBqw8oZocpBfd/3CGHZuj0XC96tG1Vh9/MbIM1iLW8ECqd6rsVUVtmlw87QuJUBbp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso106412239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721200384; x=1721805184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViRurahp3YZwL58fWiClcK2PtH3by/OEm5V9oi/OEME=;
        b=Ry4f0NfXyw+1bzpRaYbzP32I3UETl4Jp9ac5CVWdmHne5x98Y7IJPQUb3UMaMTDzhN
         eMpwqPCGt+r4e030BtvOHUwE1KTLeiMvgdfFSHpAihvRVTEG5Sneja21jaPxWjiPR4LI
         o3ZoNs80nyAfgHch/P+4eq2WjUgiCKN9wR/zpSpqDGEfMcjm9+NUnm1KJROVp7mKy6Nu
         AkNLir00ZhXioUYnq+ZJuxU8+Ck2N0cnpEWavV9JbeHPABi+A+yKiyjRnrM7uBw1PhnI
         btryCfjGIS4nMMholYyE+nN8b620HN3XvgJQ/0mON8llZVxfTTdg5F+hkTioLzZ9pHcu
         pt9g==
X-Forwarded-Encrypted: i=1; AJvYcCWIBa151OckIBzTLL4G6rDN4LNgU4EsJHldDF3Z7x7TJYF1ma0LvPS97RVcnyKWm2zvmvcTtGBF2kb++HRHJkP+Uc8es+s/lcXSLlgb
X-Gm-Message-State: AOJu0YwhQ1ykzpQjck1ImRjXldP6xvGxI0h14YmeJVwmRRF3yfPhN/84
	d4UfRoZp64Ul4y1/crNkPO75NOWZjnP54guaVFOi0clzMyWTdVQzgPzFdTbwnGZlmI7zlwd7+g4
	XAydiMvudR+8tvuzxoBNYiihcRZx0WYtTWAkucIldqKIgYE7hXowtV8k=
X-Google-Smtp-Source: AGHT+IEJuKOpD2Pe6mHiL7V6ckpBT4Nsuw1TsP85/x7sJiZtZLHAS/WYO2OWcDbD3K4i7Pca1MQlsXHv4XDv0UxRHC7eMhscKqZ7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1690:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4c215d2578cmr49258173.6.1721200384198; Wed, 17 Jul 2024
 00:13:04 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:13:04 -0700
In-Reply-To: <c2d1b569-9b50-42db-991e-a295b3e304bc@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cdbe0061d6c315a@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in attr_data_get_block
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed

2024/07/17 07:12:44 parsed 1 programs
2024/07/17 07:12:44 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
write(/proc/sys/fs/binfmt_misc/register) failed: 17
SYZFAIL: write(/proc/sys/fs/binfmt_misc/register) failed
 (errno 17: File exists)


Tested on:

commit:         d57431c6 fs/ntfs3: Do copy_to_user out of run_lock
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1570832d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

