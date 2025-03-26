Return-Path: <linux-kernel+bounces-577407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6040BA71CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFD3169D59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24951F63F9;
	Wed, 26 Mar 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8FhkIKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58B78F43
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008671; cv=none; b=YVLG9uZicdsLoLEpx4PtZccd7WfWnF6hzEGdaD70kwR2J/IhigDsaLF6+tSzp3cySs/XlLcYS35jv9WbKuC3IC0ifI09Js8SQfvDhpkkCY1SacFB369tZcOnznt1jDVZs1lMkus8nekOHAcUFMEWcZtxl2vCnr5bG3BxYcIP0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008671; c=relaxed/simple;
	bh=eYZ1X+n9G5/eODDDq0WeZaZ+W1JG9ClHqRA6twyVa50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgSFFoQsx+AX48y/bvJ6YZIZve5F4/tTskJ4EUWEmESQPor2mYoi8EHF9aDVH8D1cBvwcAFbBvwEovYsnK7+jSDW5VcwqogCHWad+aI1EXoxfzI0er4IG8w9jSY2c/7oqKHtvzjqGRFqXAY/rxVAZNFWNzn8ZsSwDwbqugj5PG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8FhkIKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA0C4CEE8;
	Wed, 26 Mar 2025 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743008670;
	bh=eYZ1X+n9G5/eODDDq0WeZaZ+W1JG9ClHqRA6twyVa50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n8FhkIKFyA2Bv3+veBkQH7clbm5xCU/8dk+6HJlQJxkciB0sHZvCmuPKWoD50mKwD
	 Weci5flybD4vzMJMmfnp6QHQT7+RoBUeAIDsspoufMd3l3doRwSQwnm3qc5FTR7RJG
	 85+/8u8IDSEN0AuVtgotpS3Go6WNbTFAuVrzNF/acbR5tOcEj2iXhzDEYfm+7m/bJO
	 1pcTbVwa2xxi1xQJ09hUi+2J1o8f5HKmk+fqxNLtSZmREU8mqhwfSZ7UqQVPVeu6mX
	 3wL8DR3yBfkg4IKXRczsmTYTCEJ9bP3XQqGr5n2uEJZuDwJBkWEWSqEPnO0B3R8IeI
	 5t+1qKpTXb+6A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Yao Zi <ziyao@disroot.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Ying Sun <sunying@isrc.iscas.ac.cn>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Han Gao
 <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator
In-Reply-To: <20250326051445.55131-2-ziyao@disroot.org>
References: <20250326051445.55131-2-ziyao@disroot.org>
Date: Wed, 26 Mar 2025 18:04:27 +0100
Message-ID: <877c4bg1us.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yao Zi <ziyao@disroot.org> writes:

> Commit 58ff537109ac ("riscv: Omit optimized string routines when
> using KASAN") introduced calls to EXPORT_SYMBOL() in assembly string
> routines, which result in R_RISCV_64 relocations against
> .export_symbol section. As these rountines are reused by RISC-V
> purgatory and our relocator doesn't recognize these relocations, this
> fails kexec-file-load with dmesg like
>
> 	[   11.344251] kexec_image: Unknown rela relocation: 2
> 	[   11.345972] kexec_image: Error loading purgatory ret=3D-8
>
> Let's support R_RISCV_64 relocation to fix kexec on 64-bit RISC-V.
> 32-bit variant isn't covered since KEXEC_FILE and KEXEC_PURGATORY isn't
> available.

Hi!

This patch does fix the vmlinux loading for kexec-file -- very nice!
However, I haven't been able to get kexec to successfully boot a kernel
from qemu, i.e.:

  kexec -s -l /path/to/vmlinux # fixed w/ your patch
  kexec -e # hangs after "Bye..."

Same when I try vanilla kexec (kexec -c -l /path/to/vmlinux). kexec with
an Image works for me in qemu.

Before I start to bisect too much; What config/qemu did you use to test
this?


Thanks,
Bj=C3=B6rn

