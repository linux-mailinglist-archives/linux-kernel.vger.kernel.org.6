Return-Path: <linux-kernel+bounces-271181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAB944A77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CF3288528
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361118FDDF;
	Thu,  1 Aug 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9p8dZ7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78518DF7E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512085; cv=none; b=orjT7utReQ15668YeRBJ2tk9T6i8saKjdcyQZIEKRye4MxnP0PXkVTxMcx638IVseuHLRXh94Hh4bv5gWDwTb/e0ZocLsWDJIaQQmpbT9kb9kIQItUejRB6550QJpPwkfGn8ebdvr2/4v04riJFIPzKDml4/6MswakCRuXqnjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512085; c=relaxed/simple;
	bh=wWd9g3zIcfY15cDSHDDrQHJzRZeFP2sDNPFuFyjKKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmOo8l0TUIpOoQPBXRJduwgYZr4BqOKjGjFeWfcGJZYH81lBRbJk5ChJYkLHS9+16CZjmmRs120Uj4tFOoy9Wo40jsGZ9TSI0TeHQSS2T9PFNFmEAwt2lwWs7/NCHot8ot7lkKB9us733QAq9L3jSkgE3sniVmi/di1Hd/C6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9p8dZ7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC23C32786;
	Thu,  1 Aug 2024 11:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722512085;
	bh=wWd9g3zIcfY15cDSHDDrQHJzRZeFP2sDNPFuFyjKKv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9p8dZ7iHs2NVwjzzVE7/qqHJJkxLiJp6clKYWcE2VA+i1LWhq/JdhS5jsRR9RTkt
	 j4DJY1624XMbT+ElkSyhIQSnjJcEM6qlMR95HTSb8AbEf3WfFUMjp/RN0GKhS1N7RI
	 a13XGcpbH2StJX7ESa42+uEYNeVQftLbepJzXPN9pzUByb8DMxScmVmhM7K2oiVjz6
	 Vx9R3bmkjHlo2FhA4ZVwFauKl0N2KdEZcIcWNah67wPVYT/FSEYjgdnDAflsg7Op/i
	 WEfMWv4L9iuPj9XpeapC4r/HflBeESmEsi5AKeu/kJhfXGrho4g1LO89kagtPvACxk
	 6WtiDuBjQB9Kw==
Date: Thu, 1 Aug 2024 12:34:41 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Message-ID: <20240801113440.GB4476@willie-the-truck>
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 25, 2024 at 11:36:56AM +0100, Ryan Roberts wrote:
> On 25/07/2024 10:10, Anshuman Khandual wrote:
> > Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
> > creating page table entries. This avoids referencing page table entries
> > directly.
> 
> I could be wrong, but I don't think this code is ever operating on live
> pgtables? So there is never a potential to race with the HW walker and therefore
> no need to guarrantee copy atomicity? As long as the correct barriers are placed
> at the point where you load the pgdir into the TTBRx there should be no problem?
> 
> If my assertion is correct, I don't think there is any need for this change.

Agreed.

Will

