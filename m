Return-Path: <linux-kernel+bounces-560419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D07A603CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A417F537
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4781A270;
	Thu, 13 Mar 2025 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxMHWsAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C71F4C8A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903127; cv=none; b=me+DL/11kUDJ3PXuCcEMoMbefDUpQv7xth4zuge+ZzRyIPNxxLb1mGV5k0aLc/5bdf1R1xMKuf4NkdX/2mqSp5WFrKcWVSnw4mmvmfa4e7pofKavrlmTjZsHReLHb3Cp5JSQk93Y3eyDVmEXZfRvgAErhvmiCot5Pi1m+uSHiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903127; c=relaxed/simple;
	bh=CMEdgnjugZeUToy/g7hT35ZGBDAhS0urRzVAaSlc6YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMaaCfTak8Zgk1+LcKmkSiIozidgvYCEgEW5t51PiHKVUAoUqbQRtNo/ZrSuvOukBby80LNm3bv4lyiqx7MK3pe6wreu9NZLjbxSCQ1K/qHIRAqcTKoZHfj51kyM1h1jSiFdiHz70xyUwaMNLQDZrpgyYAt50wkAiuwNAuXbZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxMHWsAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B77C4CEDD;
	Thu, 13 Mar 2025 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903126;
	bh=CMEdgnjugZeUToy/g7hT35ZGBDAhS0urRzVAaSlc6YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxMHWsAx+I68z884Usre4kpVRjdwCLYi9Cq1J01YOTPDs39rR4XfLx0jDR/jZkxEB
	 U/cQxUbF73mJOREp1r1jnijY5jUgWxQfC1gpfVZL7tFedXS94eVIaDq5t0Vafl4PZa
	 tuNQAy8NY4WdxtDTusyMrwB5mhDEntOXQ2IjidDq0f/xhr+5J7N23e4bNv1wyShjji
	 ES2JKPSRFa7C10a79AKPCi0IQIq0E9cIwQE1nI6QD7Lp19479h4WQA9zmrEbB+jF5d
	 pqat+hZhrdwGPGEtHF1MZ411fRJ7fOXYgqWQ++8U8niwLL2ikMHPH10daj84LwYm08
	 HcbpBME82LTHw==
Date: Thu, 13 Mar 2025 21:58:41 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
	broonie@kernel.org, maz@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64/sysreg: Sort sysreg by encoding
Message-ID: <20250313215840.GC8101@willie-the-truck>
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-4-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115162600.2153226-4-james.clark@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 15, 2025 at 04:25:57PM +0000, James Clark wrote:
> It's mostly been sorted by sysreg encoding, but not 100%. Sort it so
> new entries can be added without wondering where to put them.
> 
> The following python script was used to sort, keeping the top level
> SysregFields and comments next to their current Sysreg entries by
> splitting on "EndSysreg":
> 
>   # cat arch/arm64/tools/sysreg | python3 sort.py > sorted-sysreg
>   import sys, re
>   def key(block):
>           reg = r"\w+\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)"
>           match = re.search(reg, block)
>           sort_val = ''.join(f"{int(n):02d}" for n in match.groups())
>           return (sort_val, block)
>   sysreg = sys.stdin.read().split("\nEndSysreg\n")[:-1]
>   sysreg = sorted(sysreg, key=key)
>   print("\nEndSysreg\n".join(sysreg) + "\nEndSysreg")
> 
> Tested by diffing sorted outputs:
> 
>   $ diff <(sort arch/arm64/include/generated/asm/sysreg-defs.h)  \
>          <(sort before-sysreg-defs.h) -s
> 
>   Files /dev/fd/63 and /dev/fd/62 are identical
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  arch/arm64/tools/sysreg | 1006 +++++++++++++++++++--------------------
>  1 file changed, 503 insertions(+), 503 deletions(-)

This looks like unnecessary pain for backporting...

What do we gain from sorting this?

Will

