Return-Path: <linux-kernel+bounces-568344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D1A6942E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1D424024
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EEA1D79B8;
	Wed, 19 Mar 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frzTHNsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C558248C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399867; cv=none; b=jmFPDteM6d2BJ2XJWIFDU6KtC7/GJ2wvRRxqng72WPWRvl0oJgs6MnEk4IZ6eqLKE24aQ3xtQ6M6Ob8CoH4Frn1yOE4h+l0f+PDjrrcZVj3kPFb4HOVRVNznnYmTJmnfG64rEFvn8fBd2nPWLjHwkZbwDNEXwwP5/Ti6zkfVVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399867; c=relaxed/simple;
	bh=gCYFLRg6WoCBiXW/ebcMi7Yod4kWcH/GShwnOhU0PMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2qQdwYX+yhayhVKdQwBCRlTy/eUod3olytwFAuHQUK54Vx04khreLtvtjVGe5f3o1Y9MYVqCTpXutmvjdJNsKy3/RksteU4JeqT3G5OMk0w5EZj5ZsS1PN8r3JrM7BoHNVVldVCiGPh1Y3nWAWlizx/ZrIsSiKKBTcBnkpp0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frzTHNsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE69C4CEE4;
	Wed, 19 Mar 2025 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742399867;
	bh=gCYFLRg6WoCBiXW/ebcMi7Yod4kWcH/GShwnOhU0PMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frzTHNsruxXzheZ+V6399nrt6CpJGLCjaoRfyGO0GAFoIuHjQnJ/xYD3YNrdeGxGt
	 LesZ4MfbvcCwTv90nxsoXCzlmLh1VmtGYAUb7zzVzOk8IJyMGsnAzv/8E8MzvlUmez
	 oSod1GJoWNEKnibXf1x3C4kceTb55+UScKLzV1rXS3Ku9+cs68rztCWaOnPNg7O4IT
	 LpZTG0r+B9lO6Sj2CUtMMcQiD4H5BSmbwGgAVaapMfH072DXJrot9z4NxvrJRLb8e5
	 ECmPbVqd3IuwuGm3s6bKmd3CRWkkmtUtsU3yFcGod2Rt6rcW8Ee+UQJkmtjHgvxYBx
	 FE5NK7sd2tp9A==
Date: Wed, 19 Mar 2025 09:57:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Wang <00107082@163.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: nvme interrupt counters got reset after suspend/resume
Message-ID: <Z9rpeIsNlf6SBWi6@kbusch-mbp>
References: <20250319153910.18684-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319153910.18684-1-00107082@163.com>

On Wed, Mar 19, 2025 at 11:39:10PM +0800, David Wang wrote:
> 
> This does not happend to counters for other interrupts on my system.
> Not sure whether this is designed explicitly this way, or happended to be this way to make suspend/resume work,
> or there is some bug behind this.

The nvme driver completely brings down the interrupts on suspend and
creates new ones on resume. They might have the same numbers and labels
on the other side of the resume, but they're not from the same original
allocation that tracks these stats. Hope that helps.

