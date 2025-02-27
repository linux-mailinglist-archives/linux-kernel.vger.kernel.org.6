Return-Path: <linux-kernel+bounces-537147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D673A48886
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BB7188BC70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78926B95D;
	Thu, 27 Feb 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxY9lPvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CB26B2D2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683115; cv=none; b=hvJZUWEhdnIhusEVhqxyYVlWa4E7s1CI7esA9dnd4xujUAiL23dTQdUWwruMO0rwrhJ0vTf2ZLpEiAi9iPZdFO3yF322UOFhC1lIFQucANiUcFS88WxwQMdAs16sUaw2G4z13nyKsRBcDX3gRSfs5IM5xeDO/AAPZCHvnS0sInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683115; c=relaxed/simple;
	bh=RPW6V/T6HXEi5rvr9aOYqdqxSJ3mOponB3TpMeGiaV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA9sSglRzvPsbj5IxiVo+2TURNgvj11LEABvxc7YbW1J8PIzE5U7Qfx5dI3I4KtiYweHHJPZ/sYIPnzTwrtd6gMq1sK6A+iZVLJ4f1EZn+DlWJu1M0RI5PW/vn9gS6I4lQOLtQxXpAdm1CIHb4Ym0HmPFOXlhFrsdDApSEL35WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxY9lPvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62658C4CEDD;
	Thu, 27 Feb 2025 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683114;
	bh=RPW6V/T6HXEi5rvr9aOYqdqxSJ3mOponB3TpMeGiaV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxY9lPvlz4Jctr4Ru3yWyqQ338JxI9ZLwiNlM+o3+oBAYGsZnm6W1LGvoNmJrtZcH
	 Wrum2wIlcL3K2Zc/vG90wDOvRoYEu4PPXLGnuaw4bweJ2h2gSgjAD1FCd9JA3iFMA3
	 7FIVD8Lqe1FsZrHLWJCqn0TpOgO+ZQpOZrczzwhvTHo+a4MkJJiDuwVcU4E0TOHcg2
	 Haftf/qomG1IznCELlZM5ZumQTvLjusIicQYC0JuwV3soBROanBWhoREanVr1UeBvV
	 Iq4wvV75URiGtu3g4l8YdFpqWviJJbH7QIkaOj88HqJjkidXFguK3mMyxbkxTSRV6M
	 Vb1cWDqB9BofA==
Date: Thu, 27 Feb 2025 20:05:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8C3ZcMgHuBtIjFR@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227184502.10288-3-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> The kernel has largely assumed that higher xstate component numbers
> correspond to later offsets in the buffer. However, this assumption does
> not hold for the non-compacted format, where a newer state component may
> have a lower offset.
> 
> When iterating over xstate components in offset order, using the feature
> number as an index may be misleading. At the same time, the CPU exposes
> each component’s size and offset based on its feature number, making it a
> key for state information.
> 
> To provide flexibility in handling xstate ordering, add a mapping table:
> feature order -> feature number. This new array stores feature numbers in
> offset order, accompanied by an accessor macro.
> 
> The macro enables sequential traversal of xstate components based on
> their actual buffer positions, given a feature bitmask. This will be
> particularly useful for computing customized non-compacted format sizes
> and sequentially accessing xstate offsets over non-compacted buffers.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> This lays the groundwork for handling APX, which has feature number 19
> but appears immediately after FEATURE_YMM, occupying the space previously
> reserved for the now-deprecated MPX state.

So why not just reuse the MPX feature number and have some sort of 
extended feature bit that tells us and userspace that it's APX? The 
xsave area is getting reused anyway - causing all this indirection and 
trouble ...

Since we don't really do much for MPX in the kernel, and APX is not 
supposed to be used by the kernel either, it should be pretty much a 
shoe-in, right?

What's the scope of MPX support in actual processors out in the wild?

Thanks,

	Ingo

