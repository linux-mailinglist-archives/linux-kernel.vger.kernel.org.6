Return-Path: <linux-kernel+bounces-230142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521C917907
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A68B2403C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14915F41F;
	Wed, 26 Jun 2024 06:32:53 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24C15B986
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383573; cv=none; b=pbsrMEXOXpoOMothkb58gkrlEtPPNtuLNet05eL0yZOXIUfKdE0fcpWzDEp7Hh+WLZtlpzHaQtr3JahFQGDwk7Htf1L0aLGT/jt6zYntdYryQl66Nl02PaEyaU+1V2vBy3oFCYXD9hhhw6ufFsCYFyppOfZn4B4Ua/xo4qL7WGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383573; c=relaxed/simple;
	bh=N74YcQvmg8iVmci4tAIRK5oBJGz9q78xL5e5HBd2Ko0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJ0cAi4pgNKdSXPfagKg1v3toxmoJm8mqZbWOsNkaNfSkiHv2Jj/ueppOiRxULrnHXvJvIHSf1BrBQmw8NrPUeXejNez0n23fCVR1AbDW8l+bciFjK6JYWuY8jpGRpc52E12+LDi4VCoAO4c4Ii7qyXpVJKEKSSkbGTNJvOuNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 95113A9CE9;
	Wed, 26 Jun 2024 15:32:49 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjmXiI6aXZXQ; Wed, 26 Jun 2024 15:32:49 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 72F68A9CB9;
	Wed, 26 Jun 2024 15:32:49 +0900 (JST)
From: takakura@valinux.co.jp
To: songshuaishuai@tinylab.org,
	alex@ghiti.fr,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com
Cc: aou@eecs.berkeley.edu,
	bhe@redhat.com,
	guoren@kernel.org,
	xianting.tian@linux.alibaba.com,
	akpm@linux-foundation.org,
	takakura@valinux.co.jp,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [V2,-fixes] riscv: kexec: Avoid deadlock in kexec crash path
Date: Wed, 26 Jun 2024 15:32:20 +0900
Message-Id: <20240626063220.91754-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626023316.539971-1-songshuaishuai@tinylab.org>
References: <20240626023316.539971-1-songshuaishuai@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 June 2024, Song Shuai wrote:
>If the kexec crash code is called in the interrupt context, the
>machine_kexec_mask_interrupts() function will trigger a deadlock while
>trying to acquire the irqdesc spinlock and then deactivate irqchip in
>irq_set_irqchip_state() function.
>
>Unlike arm64, riscv only requires irq_eoi handler to complete EOI and
>keeping irq_set_irqchip_state() will only leave this possible deadlock
>without any use. So we simply remove it.
>
>Link: https://lore.kernel.org/linux-riscv/20231208111015.173237-1-songshuaishuai@tinylab.org/
>Fixes: b17d19a5314a ("riscv: kexec: Fixup irq controller broken in kexec crash path")
>Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>---
>Changes since V1:
>https://lore.kernel.org/linux-riscv/20231208111015.173237-1-songshuaishuai@tinylab.org/
>- update the commit log as @Ryo elaborated 
>- rebase on Linux 6.10-rc3

Reviewed-by: Ryo Takakura <takakura@valinux.co.jp>

