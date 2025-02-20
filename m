Return-Path: <linux-kernel+bounces-524580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B623A3E4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4D16B8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECDF214215;
	Thu, 20 Feb 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BGS0hS45"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B41DE8A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078752; cv=none; b=dzB5yv1L1U0os8F9dYvx9uHNJE4k/OlF545yhOzR2X5DFRKDKJ82kCR1tgHjK12xaFB9MWKM51H8pMWMnDO6mBBR9KSOgdDYH9E8t0UoAMWIuzGDdvTmx3YOAHMslLEueXdHLeRlx5rMaTnDpbYZHvzZfQiVeMLYhm32KPGoyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078752; c=relaxed/simple;
	bh=VZmi4uAjCpF4lmF/IbIIhmzOmQp3atFYFy48K2slH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nClZFQ9mJ4ql8Cf8/mxe5nr1SzSstymmrMeWz5ck2GQ5anJh2Kavo9Ze+p43Ics8TCbrGIn4+73B5IAPBVexk0Dzo8rXvUv3UfbpVezO3vJHimRCTxV6Nur2TIjj6i/PXmKeBuaYovbzmQ55FrX2wjhklUdgapDQWDiXDGfJNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BGS0hS45; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 19:12:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740078747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fidfch7gAmW5M/uugpuYNwk9WCKKxmCy901S6f8OsTI=;
	b=BGS0hS45SLklipGImsQ6gDeIllh0bU/Bz8/b5EvP93tdi4rD14k8V7n6v7koFarowTm554
	lg/myvi+WPlZq2NJuQoq8GjMvGvAdB34r1em5XvnAgvEkVv1shqkQ6tB+EJxj8GssDSpE4
	1QhqVZIPtwXdqgoTvjT70rbqbZORfWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/17] zsmalloc: rename pool lock
Message-ID: <Z7d-lcg_ZMWA3DUC@google.com>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
 <20250214045208.1388854-11-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214045208.1388854-11-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 14, 2025 at 01:50:22PM +0900, Sergey Senozhatsky wrote:
> The old name comes from the times when the pool did not have
> compaction (defragmentation).  Rename it to ->lock because these
> days it synchronizes not only migration.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

