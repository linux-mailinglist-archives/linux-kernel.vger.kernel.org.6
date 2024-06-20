Return-Path: <linux-kernel+bounces-223706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195191172D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49C12834DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FAE625;
	Fri, 21 Jun 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWUZpZhk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C6197
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928656; cv=none; b=AcCZYJkWPkzjHcB8Kbd0JxA7h/vAz7wtV61P3ohwk+wCxgjSl+pisHCbj3AauSUR3/M7EacxcvTLjOutmj5XWRH4I3JBZgZN05qesDdM3inWUELet0oxKXhL5LsqGnKJDZRV0S6UkPkcPUPIweQELMB/9NRhpD+N8Rk6HNKC8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928656; c=relaxed/simple;
	bh=DVc+oZ8IpmajrWn8uMMOY6RL2NOLHfDxJNeCdHePKgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb7nRnxPc1zn/V1fXpWlG7xEJVAOnJs2r8gp2pNDlndGuwE+4fK83wm7pPUosFTVFxwCKrohMokll6sUowLACdRJvROClhnqAXr/QF5X7jI3zDspMqJ5HqBY3jbewbOWoIKXS+zpU+DMJYxgNKUMSP2ERamtytraPBCvs7hQgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWUZpZhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A5C2BD10;
	Fri, 21 Jun 2024 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718928655;
	bh=DVc+oZ8IpmajrWn8uMMOY6RL2NOLHfDxJNeCdHePKgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWUZpZhkar/bqgnu5QJIUR2WDZmrEDCqDQl/Wt9gCmNpuMJLA8RZ7aFzGwtt6L6lU
	 X7/5/EvkILpOcBMSMR8MmL77N5k+UcTmddkUN998iHeaxqq/0byRHWYbIZ+XpYsN+c
	 DEW/vRk9M0Z/yRExKwYEvfxTwndWbskG9LwaDC0zAqptY3Y+d2BInEYenQ2ul33HWF
	 /un6QR868O/pDMl5JRnh0qbCtPygFX+30BM9qnZIRbat6ekFDNveQH7HK6tfgun0g6
	 DlpLrcuAbNwWctRWfbk0kvmyAib6nuI/G05ioQ84d6s9DGxnWIq2bHu8JrYWsu10tr
	 ZYh4Ylb90JT7g==
Date: Fri, 21 Jun 2024 07:56:56 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Cyril Bur <cyrilbur@tenstorrent.com>, Deepak Gupta <debug@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
Message-ID: <ZnTByNTDWnVdtiDr@xhacker>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org>
 <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
 <CANtDSipXbYSuz6NakbXw-8k0_ZN5hdT7VWMushXvQ5VB0Am_Ng@mail.gmail.com>
 <95a081a9-2307-4e5b-8ae2-082be16b327e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95a081a9-2307-4e5b-8ae2-082be16b327e@rivosinc.com>

On Thu, Jun 20, 2024 at 10:06:15AM +0200, Clément Léger wrote:
> 
> 
> On 20/06/2024 02:02, Cyril Bur wrote:
> > On Thu, Jun 20, 2024 at 3:04 AM Deepak Gupta <debug@rivosinc.com> wrote:
> >>
> >> On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
> >>> For readability, maintainability and future scalability, convert the
> >>> bottom half of the exception handling to C.
> >>>
> >>> Mostly the assembly code is converted to C in a relatively
> >>> straightforward manner.
> >>>
> >>> However, there are two modifications I need to mention:
> >>>
> >>> 1. the CSR_CAUSE reg reading and saving is moved to the C code
> >>> because we need the cause to dispatch the exception handling,
> >>> if we keep the cause reading and saving, we either pass it to
> >>> do_traps() via. 2nd param or get it from pt_regs which an extra
> >>> memory load is needed, I don't like any of the two solutions becase
> >>> the exception handling sits in hot code path, every instruction
> >>> matters.
> >>
> >> CC: Clement.
> >>
> >> I think its better to save away cause in pt_regs prior to calling
> >> `do_traps`. Once control is transferred to C code in `do_traps`,
> >> another trap can happen. It's a problem anyways today without CPU support.
> >>
> >> Although with Ssdbltrp [1] extension and it kernel support [2] for it,
> >> I expect asm code would clear up `SDT` bit in mstatus. Whenever `Ssdbltrp` lands,

Hi Deepak, Clément,

Currently, SR_IE bit is is set(setting means enable irq) in c, could the
'SDT' bit be cleared in c as well when Ssdbltrp lands?

Thanks
> >> I think `do_traps` should expect nesting of traps and thus cause should be saved
> >> away before it gets control so that safely traps can be nested.
> 
> Hi,
> 
> Indeed, every register that is "unique" to a trap and than can be
> overwritten by a second trap should be saved before reenabling them when
> using Ssdbltrp. So that would be nice to preserve that.
> 
> >>
> > 
> > Is a possible solution to do both options Jisheng suggested? Save the
> > cause before
> > calling do_traps but also pass it via second param?
> 
> I guess so if it fits your performance requirements.
> 
> Thanks,
> 
> Clément
> 
> > 
> >> [1] - https://github.com/riscv/riscv-double-trap/releases/download/v1.0-rc1/riscv-double-trap.pdf
> >> [2] - https://lore.kernel.org/all/20240418133916.1442471-1-cleger@rivosinc.com/
> >>
> >>>
> >>> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> >>> alternative mechanism any more after the asm->c convertion. Just
> >>> replace the excp_vect_table two entries.
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

