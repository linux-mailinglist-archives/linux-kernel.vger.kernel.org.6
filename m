Return-Path: <linux-kernel+bounces-421016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4B9D85A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2988161B94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28898199EB7;
	Mon, 25 Nov 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5CcNBqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDD1714AC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539158; cv=none; b=LH+KCzuONXsfIEdwZOHh0AOHwGLDGhAS7aJucjalznMbBWZQ8uThvHuItwWWTQi5UXKZ6gK4Apq3buKbimAPlZMBIjrNmBz75jayDQI0+F8nWjDNx/zXSwgjYjrfXM9AHiZss/LKgr4XTzgE3m1YdxTvQAuh2fVXM7XFJGasaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539158; c=relaxed/simple;
	bh=Hvasdb7Y1B9JNzgx80X5SPlj6UThep3Ym8D7Ij/hhvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvboK1+aNOOnG0XPu4r7EdWJfTFv3QJqG9NLCJilT/deBm7SqZaUrOHt2mPdz/2RjBCJEuS2oyAwe9k1o8QHxvp3jR/oaKhPYB+Az/VOsjPxEKr6r0djjcAqPjWPzkxSJubWm1uFeW4UrN9IhSi6zZ72JLKF+7x+sjzXwhLKmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5CcNBqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2021C4CECE;
	Mon, 25 Nov 2024 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539158;
	bh=Hvasdb7Y1B9JNzgx80X5SPlj6UThep3Ym8D7Ij/hhvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5CcNBqh3Hb+M0sCt6BGXda2YzgJG5Ut9EFIKKRwaTfRPGbPAomowUnQ7uhh/fkBJ
	 a/qq7CgwjXByye8wN8ZS2EH8PHLFkr+3Gj9zFMcnoNX4xSz1CpZ6rFTsS5/X1qglWA
	 CdoA/IqOWY+MyR/yH3k6vL7+I4K3WCYb0UEeULXhHmA6oNxkT9e+qbShVy9vDsdl0c
	 rhUW8IsCz6Cyg90jfWUy3Z2tDaSKvF2L5HQLuBfEtd7LVmd8UO/uu+68C4R5R/9dbB
	 qSzEU5UBswIL+lErWcBbvh4se5NcB+wnjPuwniiPTaNsy7lkTIgw5jBN9xj9EzQJtR
	 w6fjbgaJp2LhA==
Date: Mon, 25 Nov 2024 12:52:33 +0000
From: Will Deacon <will@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephane Eranian <eranian@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Ensure port and device id bits are set
 properly
Message-ID: <20241125125233.GB858@willie-the-truck>
References: <20241121001334.331334-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121001334.331334-1-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 20, 2024 at 04:13:34PM -0800, Namhyung Kim wrote:
> The portid_bits and deviceid_bits were set only for XP type nodes in
> the arm_cmn_discover() and it confused other nodes to find XP nodes.
> Copy the both bits from the XP nodes directly when it sets up a new
> node.
> 
> Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  drivers/perf/arm-cmn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Catalin -- here's another perf fix for you!

Thanks,

Will

