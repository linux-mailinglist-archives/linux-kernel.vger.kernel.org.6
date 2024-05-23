Return-Path: <linux-kernel+bounces-187818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06238CD8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C002831F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5B6EB74;
	Thu, 23 May 2024 17:07:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A685AD2C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484032; cv=none; b=CDs2tQc114pBSf+M1YPlLI5Q28X/gWBlQDoHKfS2EAnxcLTgNAYIwOY1B04g8w7YxQh24mYAR+XGpV2nPUrpiEQayhICT2p8bN5lHbFv07GHHKWKIUKetMfFzG6eBhrrjp6WTTg3+fxxEZRP8sSPfAqPQeE85Muo+kGsPZn482E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484032; c=relaxed/simple;
	bh=6gSCyEIu5zPIbY9kgFjP5bVY1DREQG7gIcxL+TAUGPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmAwlUTrNT2SRqqFJ0ipn/BlsxoDFcvebnA86hUQsjYhukeYDo1zL7mpcggKTxagDPEB2nFPtBwH3bbuSg1GrDQ10Och3d8oHKBSjQWg5k0yLSXIJWZcsNvT13Ah0bpnlMyn98YXX03eacIZp8kN45B0zhvFjpDQtB30caIudmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D2C2BD10;
	Thu, 23 May 2024 17:07:10 +0000 (UTC)
Date: Thu, 23 May 2024 18:07:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, anshuman.khandual@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <Zk93vBqAD3LgmbGb@arm.com>
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520165636.802268-1-yang@os.amperecomputing.com>

On Mon, May 20, 2024 at 09:56:36AM -0700, Yang Shi wrote:
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index db1aeacd4cd9..1cc73664fc55 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>   * "-" means "don't care"
>   */
>  __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)

While this class includes all atomics that currently require write
permission, there's some unallocated space in this range and we don't
know what future architecture versions may introduce. Unfortunately we
need to check each individual atomic op in this class (not sure what the
overhead will be).

-- 
Catalin

