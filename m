Return-Path: <linux-kernel+bounces-179538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58698C6118
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9294B1F232B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485241C84;
	Wed, 15 May 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNaYmnP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0FA40875
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756586; cv=none; b=Ed7QoN0ZV5V3v8Ubg8KzAEOL0A64Gwgsq1cLXFQN6SXK8kJIsskd5TX7DAmq8UJoUEKGvi+XLJ327O0hGbtCar4NUdeHyB4oeq/SD6t81FtHphyG9IDk9XwVRPr+S/CBzKWIEGYWlNc32fQ7l8JFzq4woWmnG59nUCTMnl0mAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756586; c=relaxed/simple;
	bh=B4qEMf4EVGsDCaOxKzxxINbFJU5l8ld0fYiuh99Vrd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MX9Af8a3R35eWHRRv62V2iBuax03di7hra0E/DhXVWNfDWDzTxkymaFYDtg19j58eIiKUjo8Th0Ffrczv3nRRA7pU3y+jazUpGDlkvlkCdIz9ZgtnRXfx6jLvitBHbCUQ8sBGN10T1mXEbK8ujZnqSU0zML/kE0LH26faJkFRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNaYmnP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6A2C2BD11;
	Wed, 15 May 2024 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715756586;
	bh=B4qEMf4EVGsDCaOxKzxxINbFJU5l8ld0fYiuh99Vrd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DNaYmnP6lqeZPyPEH4NDgKmSjYmC9W/HLk2KbeeSAN78X+py65STTCNKA1KvSaEYT
	 ZVPx29xw1qFyhgp30weJoH1zCvmxl3BevfyrAKof0HHTqq9b/OvZ40yXJ8LNt79RKM
	 5BVm2vdbtuCkaqSyVOvsxo+iBWsDfHBDGoqanZ/E4l0vQnmupevWqbQe0pMXibnPor
	 xjIQSIpV9CgHcOKLX0Xc+iQrBrRxyMnsEG3DJMcI82+vQcHCP1oVOoFCwgYVlSUwM8
	 bxCDPmgE4k+MG2+8MzwYcC9bXWBDZ7wPZzOkfzAaYnMbkiwU/lw4LZ7XnyeQvqLai3
	 9xKzdqSQMXGJQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 8/8] riscv: mm: Add support for ZONE_DEVICE
In-Reply-To: <20240514140446.538622-9-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-9-bjorn@kernel.org>
Date: Wed, 15 May 2024 09:03:02 +0200
Message-ID: <87pltntv4p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> ZONE_DEVICE pages need DEVMAP PTEs support to function
> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
> ARCH_HAS_PTE_DEVMAP for riscv64.

..and this patch has rv32 build issues. Will fix as well.

