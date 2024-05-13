Return-Path: <linux-kernel+bounces-177268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3CD8C3C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737862819F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF7146A90;
	Mon, 13 May 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgNetoPO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA43168DA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586082; cv=none; b=Fk0fJzivMxrJgfseADdyFFFYaIQfHMJs8X/J5c68hpsuTcNgm8XRl3VYd5Q82eNlA5caW9oLotsEEtjxr+JnPfwQLOJaGcnvCa14XiApk4gCp9VYAMAkGok8o1ofDLh/RciFw+H2w9dCRDP4b7hOpdAs5xRSyc55J1BWKkBsN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586082; c=relaxed/simple;
	bh=NbAMICyDlsstIGEO20j7o3KsOH1uqM6Bwf3uWxd8iWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bzRjNdDzcXNxV6kLAlm6OxHDwk8a8hz+1SPDmVev9E7wfKchNafF1HGesSJqDVFjZF23nMpNqC8gwLfnRBr6MiuOCSmq3Aehxr5JGyPl6vNm01rTziFGrlS4g3/RMpeBbaNcLGmtHBE/4uxhOl/NIvCaT0qjv32AvuA4G5Z+b8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgNetoPO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so223507966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586079; x=1716190879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fn+9ZGrINURnOclbL6L6sCXjIt+zNDYATi/tXCjDVEg=;
        b=BgNetoPO3c+aimnrj/tOsWXActgmwL/dbLsCeuFdlvE9MUzdhKrMglrPCDdozFdPUA
         vfoST4DuLXao0g9huRBwYz9IMZJPS9Oay8WBwl4IjvqeycHY2fpY4hDE6NzklYbr9W5i
         OdDtS2i/QxMfDT26dvdj56aAkohOepowAJojdn3d4lYQE3m4+hBFflBgIyyqNS0sEKCS
         8aEMVOyK3cc8StO+DpotDF0yuqJUwOorNydxunx2kncGBBcFihGWmp5rmL9rgcC4NN/9
         fyV0NeXdWVcV5SAmkTwN25YNQCpJrOi1JXuw4Rh9aR0az4NsqvKzfrXYN5Wnim0NiRNE
         7cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586079; x=1716190879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn+9ZGrINURnOclbL6L6sCXjIt+zNDYATi/tXCjDVEg=;
        b=l2D6Qfa7XJ6W4GHnRAwanzi4eBdNHfw/kI+xIcLVmpkWZifMGr4o8HMQ5ohRpLU9LI
         l4CbZWJ/ZZfLaEAOY+3+AAAasgedbJ/Liz1oZnDq01sk0KCb03qoF6pvVbmVv6D2Gdtm
         cXoWTgV/XRddye1jxv/K6iQmuOLHkKDJRD07if+Zkgd1Iwhl/kmnj6Z7BdMFdjSkICMn
         uc4oeKJ3ovwe1k+2u+jhK5PqXB7iZ5iBjP8yrJkh4F3lVMrInBapNHx+Xwn7H8YPaWOU
         vA+dx6AMJoWlCJEFPUnrhHIHvtloovj6J676c51ngqE72xILM/6Qpo0RrAoXXP72aPHo
         OhmA==
X-Gm-Message-State: AOJu0YzmeET/F9MZiu8F9uua84aTeN7ThpUxmiC3kiP4KpaThL02YX1i
	Px23yZFot1XxFpMPA1igUvvwd2OYrbHVn6eYAIn8BDSHv4FGEMOiEusA//Lg
X-Google-Smtp-Source: AGHT+IH7B7TUKKmo0a9qlEiLS37SzXCE8nK5No9VAMrv0RcsoXU2hztTOUoD+PYHXqxG95W8OITHBw==
X-Received: by 2002:a17:906:1358:b0:a59:9eab:1622 with SMTP id a640c23a62f3a-a5a2d665e06mr539096866b.56.1715586079014;
        Mon, 13 May 2024 00:41:19 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d10sm556021266b.198.2024.05.13.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:41:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:41:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/fpu changes for v6.10
Message-ID: <ZkHEHFVzn8bhhGIl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/fpu Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-05-13

   # HEAD: af813acf8c06db58c6e21d89d9e45e8cd1512965 x86/fpu: Update fpu_swap_kvm_fpu() uses in comments as well

x86/fpu changes for v6.10:

 - Fix asm() constraints & modifiers in restore_fpregs_from_fpstate()

 - Update comments

 - Robustify the free_vm86() definition

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/vm86: Make sure the free_vm86(task) definition uses its parameter even in the !CONFIG_VM86 case

Li RongQing (1):
      x86/fpu: Update fpu_swap_kvm_fpu() uses in comments as well

Uros Bizjak (1):
      x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup


 arch/x86/include/asm/vm86.h  | 2 +-
 arch/x86/kernel/fpu/core.c   | 4 ++--
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

