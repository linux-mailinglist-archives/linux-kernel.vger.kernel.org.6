Return-Path: <linux-kernel+bounces-204272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B68FE687
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD520287B75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAA195981;
	Thu,  6 Jun 2024 12:32:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D5178CC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677124; cv=none; b=n8Yo4ALrSbWq+a0jn0it2fonlmhfzr087i4DCuSo975mTFZQAC/3jcOGz9ZPN+ikP2mwLtuHbT3U5G5MjgjcoHMuCgj2qSUwe8UkcDAWW+nluuISV4w5lStib1JRNrEbVBa0EvtYWuC684axK2qIHU7WSE7fBQOnlmjWSu88HCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677124; c=relaxed/simple;
	bh=ScSA40ju2NET/NWx1ou3fLsqqMazpwyKb1UfbHbEZs0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y0vY4VSH1IVJVs5A4hE0/FUv3+N9ApqvmV5I90o+zW8mCedpo76jZKxAtgE/zhXpDn9PXyAaRKUlD2sLzTODGwiTDWCB8BH/M2FMR2Iame1HMNz7Le+VBkaqcFoB3iXGWRWY3QjbR29e2et/6QpuJ/rWRhvgwDDxEd06NDNvTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb3ccd3990so89839939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677122; x=1718281922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLF3WrHdPJVT1hI93QmK+HzAqo+AYcFuCOIoaBg6bRY=;
        b=FxLgliqgbMt2uTgNb00VV/Zr7fMn5pXWOpGJbt6QMJFMIHT4Jm8T3GAjzPYY3ezHeS
         Iam0w2o5AIfD/hsnr4wYu3bNB5UwWPrdC0D1ifc5f3wdtEMY6aNaE6RMGbGeBRHbnfG0
         xsBlzjpQen0+nyh16E74xlbV0FlMFf6/PN7XPodq0t+DEs54jVyBFN+/oUdcOpjEr6SZ
         9nrTxuUm0MvRSp+siMX4pyo6AatKpbP7VUymTQtOSCV9+myKpGRFY/F8tJA6n4p/RKwY
         MXMCFY6BLYtax1SWBfBPOsqVDCfqHHmiGzhdi4QDC9miHQ7NWGFNgts7tZTKU9mTCxnP
         58vg==
X-Gm-Message-State: AOJu0YzLoHTrdC1oauXxeBR70sB2RHvRN4d/LlfJ88wEL4/8yZyfJt+U
	kYSInBLQ+DqOisacVilIi6zeSCTKTzLqjiblPqBNjN0ovigqoRsspeX4/L3cswLkiO2T6iHiXdb
	25QTYh5D8OXCx8LJfEbnSXoa/CAV8VclK1fR4Co1K2LHPVpvJlnvJCMc=
X-Google-Smtp-Source: AGHT+IG97j+fbIkhE1yox6EjLpe9FUHjbivpDv26KLrg3OqgwVIffKE8Krm9Uj0Csl1gLBMguOn55leBsBYrn9zNZj51+SAER+fP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c011:0:b0:487:666:652e with SMTP id
 8926c6da1cb9f-4b63a90a4d9mr98251173.4.1717677122318; Thu, 06 Jun 2024
 05:32:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 05:32:02 -0700
In-Reply-To: <PN2PR01MB489159F2619858474EF92FC5FCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b70680061a37debf@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
patch: **** Only garbage was found in the patch input.



Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1038e65a980000


