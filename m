Return-Path: <linux-kernel+bounces-177226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA28C3BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0018F1F21584
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2BB146A64;
	Mon, 13 May 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr7VaLCo"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FD1465A8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583094; cv=none; b=oCjq5h2T7wKKtQqywCbvm/3WM9da4a+810s7v61QO6pw3w22V8wi2PEVBagkceW8p3y5ocKRjnl8X0ndLB4V4L8Hc1f1i6VdHFU8VUUJQTY4AE04QbhhnjmWlqeACRsaWMkybKEltlYDxdsojEQqt2xIAOU+oO0KzDxbkm6ZLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583094; c=relaxed/simple;
	bh=aOc3stdhNTM7VjP3EPUkCBORXbQ9jEkdpsXSziZ+/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTIioR/C5QQpuRijO3Vty9uKQuQFcqC22lDJsuSmfDIjbrWp73isZNUrvKRB+HGkRKXMdXV3YWmrQkBNB+lXkPhY1GFTgG01uQ8jSJdXLdU3BV81HO31RR0SfBv9bhHZRkaBQSqLzadMpe/oJgPTO2RwuVzx4dszgdPmOUR1YZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr7VaLCo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59cc765c29so6112266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715583091; x=1716187891; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A6RoRJ02d55IkQCuFsHu80Ik1WWzpnYqgvIAQSq8ZIw=;
        b=Xr7VaLCoSjaTnh8+mSY2MLnqGLLMc98xM/lcF6cBW0d4F16N2o/2im+Qb4QDWa8A9J
         HbLlB/nnVRo8jSI5JdU1up9Kw8n2aHw3LfsxRsyWFk4rm4qyYYqf4NwKAW1Atr+v21Am
         oItUNmIzX5IjothJwbvBMVVOPyRDO96NAGl40FWeASPN2ZcPOc1ZM3gYG9s9xVeCqvk3
         zMzeacIKSgdtrCr/do9TAqbw9rin3mIkqszDV1iG1tuZhN8zJ4kHYYACnLticQvEf2Mc
         UCMIKV1aU5FdFzlACwC6L7F4G/1YflgVR0KWWCKSQqxI0+uv/Tj6TSf6HaZNmNuquDcj
         WbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715583091; x=1716187891;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6RoRJ02d55IkQCuFsHu80Ik1WWzpnYqgvIAQSq8ZIw=;
        b=nVS8DVzBKbKMww8LEwUgGIQQWevxGdxL1g728nyRQR10WomYrjCjzb12LQxNwE3MgB
         Xmj2eb9MQdrY1Wt1A9v8+M8ow7qPrP3CoZ1Kw9eoHF61gcxZP+1TKFoEmNSYA/GqZsB6
         iNPmZMmmpARD6sevZLpS34yziz8PYJevpOmRc6e7O49EvOqk/9rfWZv0fegCc4EyVUb+
         47W2EDWeVMhtX12oXUxwikosWhIO2/cHrjaHebJafJ5EGbOxlJ0dJFqfcjPGXrCV9DJE
         tLZlSWJx0f3StNDBbjV0+OZ01x9/2xdNEb+rUyVAlO+DYUt3X2XQ80zYFoMUIYWoenfd
         gqfg==
X-Gm-Message-State: AOJu0YxgfHfFA3s6324edSR7RF7JIhtqhCIHlEouzb5865vIAwZ7G3vs
	DPnzTa1S/83bH+SEz1PW96SfxEYOclt2Z2TnCwYGRqqBoi5jtIBSy4Wl5Okr
X-Google-Smtp-Source: AGHT+IEmXgJMCFlIO5ulEzs4i7G6qimyTlzKQMhWNbLAHqx+vsifxImUqvAEVToiUjovztr8QbRMkQ==
X-Received: by 2002:a17:906:b081:b0:a5a:5c98:c594 with SMTP id a640c23a62f3a-a5a5c98c636mr202744766b.65.1715583090993;
        Sun, 12 May 2024 23:51:30 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17555sm549047566b.189.2024.05.12.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:51:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:51:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/boot changes for v6.10
Message-ID: <ZkG4cMe1TFI5w7sc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/boot Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-05-13

   # HEAD: a0025f587c685e5ff842fb0194036f2ca0b6eaf4 x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57

x86/boot changes for v6.10:

 - Move the kernel cmdline setup earlier in the boot process (again),
   to address a split_lock_detect= boot parameter bug.

 - Ignore relocations in .notes sections

 - Simplify boot stack setup

 - Re-introduce a bootloader quirk wrt. CR4 handling

 - Miscellaneous cleanups & fixes

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57

Brian Gerst (1):
      x86/boot: Simplify boot stack setup

Guixiong Wei (1):
      x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Ingo Molnar (1):
      x86/build: Clean up arch/x86/tools/relocs.c a bit

Julian Stecklina (1):
      x86/boot: Move kernel cmdline setup earlier in the boot process (again)

Xin Li (Intel) (1):
      x86: Rename __{start,end}_init_task to __{start,end}_init_stack


 arch/x86/boot/compressed/head_64.S |   5 +
 arch/x86/include/asm/processor.h   |   6 +-
 arch/x86/kernel/head_32.S          |  11 +-
 arch/x86/kernel/head_64.S          |   2 +-
 arch/x86/kernel/setup.c            |  32 ++--
 arch/x86/kernel/vmlinux.lds.S      |   3 +
 arch/x86/tools/relocs.c            | 371 +++++++++++++++++++------------------
 arch/x86/xen/xen-head.S            |   2 +-
 include/asm-generic/vmlinux.lds.h  |   6 +-
 9 files changed, 219 insertions(+), 219 deletions(-)

