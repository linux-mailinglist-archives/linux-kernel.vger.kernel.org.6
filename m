Return-Path: <linux-kernel+bounces-221336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F147D90F215
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2EE282530
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B3152166;
	Wed, 19 Jun 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX7jc9qY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A2150987
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810755; cv=none; b=o7Y6bRSIuasYbkWDXV1W+bjumRt7GD69THSLcz0UuPQNQj8A5mUShhTg/GD+SW0VWhWuQgGRKQ7Tpe+CpZFEHW2+nsckvw5yoZ7Bg2tKRD+IbtZ55YWrbuHlmLKwgeRr4c3lhPXV95O0X6GpZGSqVo7/HeG1rIOKyud/Trt3pNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810755; c=relaxed/simple;
	bh=/lNGqqqjyjXkzDJYjuWIgiRgUpo/dE1KLA+7wNIMC2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS+8vzBHjNAGzt4MMhTm6qLAcOxVhQaJwCZ385/O7WlkHdEP2vVBm5oMO/mx37vMBp4vMP2Ev45cDPXZKaWrSfoDmu/c92dOLk9BCvuI3r/Hvq8w1Z+KV8K391PZl4eCQ84pm0/xuwObxCwunZXAiFdO5YfAogUJaaXHxauNn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX7jc9qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42AC2BBFC;
	Wed, 19 Jun 2024 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718810754;
	bh=/lNGqqqjyjXkzDJYjuWIgiRgUpo/dE1KLA+7wNIMC2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LX7jc9qYTiYzkhKLX1o4Rt/bIQtep/45xFP/ZfdTO7Dr/L6WLtplEm92a5M9s/GM1
	 mlM1yF1C1KkrAzr8p62wG7qQHrXh+K5tU19Vx9u8uyTqayx46QmUtFwHTaZGzFcT2w
	 KKy7K12IXgV8Sw38n4rgAGXYXiLtUz/S1gbQigFt0m7M6g4dMhuhbM0IID22Zd6L55
	 fioTZ2HKsWgFju2ZJPves9EuoAkACWLo9fcBWWV6UWWXRbYRgBXRMokcbnLq+bSWZ/
	 behDbruvkMX5ubDDCsgZQroFL/lFALb27zHho7Klg0O+/Ja7+2vDd6z90g5gYr70I+
	 J/txLVxJemdBg==
Date: Wed, 19 Jun 2024 23:11:53 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] riscv: convert bottom half of exception handling to C
Message-ID: <ZnL1OV1GQxV4nS2h@xhacker>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <CANtDSir9O+B1mZx-k+j0+bHo03A653itida8f34frFaY2doM0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANtDSir9O+B1mZx-k+j0+bHo03A653itida8f34frFaY2doM0Q@mail.gmail.com>

On Wed, Jun 19, 2024 at 08:16:58AM +1000, Cyril Bur wrote:
> On Mon, Jun 17, 2024 at 3:21 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > For readability, maintainability and future scalability, convert the
> > bottom half of the exception handling to C.
> >
> > During the conversion, I found Anton fixed a performance issue
> > and my patches will touch the same exception asm code, so I include
> > Anton's patch for completeness. I also cooked a similar patch to avoid
> > corrupting the RAS in ret_from_fork() per the inspiration.
> >
> > Mostly the assembly code is converted to C in a relatively
> > straightforward manner.
> >
> > However, there are two modifications I need to mention:
> >
> > 1. the CSR_CAUSE reg reading and saving is moved to the C code
> > because we need the cause to dispatch the exception handling,
> > if we keep the cause reading and saving, we either pass it to
> > do_traps() via. 2nd param or get it from pt_regs which an extra
> > memory load is needed, I don't like any of the two solutions becase
> > the exception handling sits in hot code path, every instruction
> > matters.
> >
> > 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> > alternative mechanism any more after the asm->c convertion. Just
> > replace the excp_vect_table two entries.
> >
> >
> >
> > Anton Blanchard (1):
> >   riscv: Improve exception and system call latency
> >
> I've retested this patch with the rest of the series applied. I can confirm
> that the performance improvement is still there. Definitely thumbs up on my end.

Thanks! The 2nd patch is inspired by Anton's patch. The remainings
are just to convert the asm to c in straight forward style.

If possible, could you please add your Tested-by tag? Or even better
review the series ;)

Thanks
> 
> > Jisheng Zhang (5):
> >   riscv: avoid corrupting the RAS
> >   riscv: convert bottom half of exception handling to C
> >   riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
> >   riscv: errata: sifive: remove NOMMU handling
> >   riscv: remove asmlinkage from updated functions
> >
> >  arch/riscv/errata/sifive/errata.c         | 25 +++++++---
> >  arch/riscv/errata/sifive/errata_cip_453.S |  4 --
> >  arch/riscv/include/asm/asm-prototypes.h   |  7 +--
> >  arch/riscv/include/asm/errata_list.h      | 21 ++------
> >  arch/riscv/kernel/entry.S                 | 61 ++---------------------
> >  arch/riscv/kernel/stacktrace.c            |  4 +-
> >  arch/riscv/kernel/traps.c                 | 57 ++++++++++++++++++---
> >  7 files changed, 81 insertions(+), 98 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

