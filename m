Return-Path: <linux-kernel+bounces-365351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AF99E0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF2A1C21237
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF651CACFD;
	Tue, 15 Oct 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wfWkQlgl"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B518A92A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980727; cv=none; b=G216vL3M+oW1w3sPD5fQRWmKva8Eem6HwuzQGH/YFo6qZYEjarnOXHcdzelvphiT9A/j20Tu5DjXtXjTuyw+OPzLLbHHUAgEYSl7QA+ECneUgSUD/IYsYh05kvyxECHhvEnZ6zvFuksQ+TnE7Y6XjwKEitMdxp3RXHwZGpAhQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980727; c=relaxed/simple;
	bh=ueSFrkszLY4uRIf4RU7rh/vFDbnAK4TtJhw+OCiZToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwnnNjv5++1RURucvCiAQfNEelu5wwp2g3BOFnCcdz2AB9KOXsVwwsO0V5+9EgnIyMSnC1U1XHTv+RKKVRYjr8H6PeEmJznv5XcdbL6y5bKNicdUcRMNNNSeNyDwnDnr5vFKL4SiNKZWDAEOa3JCUb7IexfbTUfGWdFly0GgTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wfWkQlgl; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 354C12A01B8;
	Tue, 15 Oct 2024 10:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980219;
	bh=ueSFrkszLY4uRIf4RU7rh/vFDbnAK4TtJhw+OCiZToU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wfWkQlglbIJWEIBO1Xp4qwMJyd2jZpvbQvFWiS1++T6KeRmSw7MDhHcra6Xi9p8l8
	 q+A1oAf/I7l6ztrWjpF/0FUGfJANvt5XbRdE3x6IS0MbeqMrk3UmbBIa92v2fI0xp6
	 XuwJ0goqTUWNfYxbLY4Yzj3zS6dBSLzdU9qmK462se7THSsRme6L46FeDZX/i8OG0t
	 MdL84hAWQG+7WvGDZGWKZe3XnLe/Urbvzbektfqia6OaBX8MPtmaKImYwV8Q+Ookvp
	 yxkzNPSG7vSeQK4wTIYhvIroQU5/ghab5Pr1ukkLx8l2XZ2rQnh0Hp9eGZrJvirRkZ
	 6+k29672QLIOA==
Date: Tue, 15 Oct 2024 10:16:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.12-rc
Message-ID: <Zw4k-j6i45F4n4W6@8bytes.org>
References: <20241010114221.GA13611@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010114221.GA13611@willie-the-truck>

On Thu, Oct 10, 2024 at 12:42:21PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.

