Return-Path: <linux-kernel+bounces-547588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF16A50B58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA5D7A4AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C02253343;
	Wed,  5 Mar 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4Wt/sTU"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2425290E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202398; cv=none; b=hmILqf48uVcGnPVky+E9dwemZS8XSSp7LHobXzUA7jMLspSWLVbqMZNKNlXEZTgCnR/kfq6Ii8qU6nLVKOdHUSYQXLtVoXKUk8u6UX45eqx29iZGPHU+Dvz5gAGvHqJGhGByGJtPCtYcoRQs9dXfbbUXydtxZMdMePpsnpqwAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202398; c=relaxed/simple;
	bh=N761hwS+w2ZmFSz2hBZ1TfeINp3SnC4yAw2xZFHNmCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4lIVld38x5fDv8g6vsHlhgZydZQ2qIFdGAqwGWon1vOpr19rIxsaOwWA+5KOz5BnxJWgICQcO9Fy5EX4O2RTvThgYm2soIgZxGPLK069hQFsfEGOI4BK1sEFTOBHkC9P4e32jZ4/yfpG/gLe05tiyI2amLsKiiRBqdN44myxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4Wt/sTU; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 19:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741202393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dbkia67ueSV6cjdkjckzotwlbJdsnWCbOKHIw0ZXs8=;
	b=w4Wt/sTU9lP0yZfFS/CRFyS9hI9UZqgN4ieXlcdCIIHRCqLP8rzawdXhNxV9hNQmEEdERH
	SEGB5Y2nJ5fQZRSP4/2d4M0FLBMHARwY+q240VtohaGi+XvRrfx18YBI7iYPesz2sPgbhP
	G0M1N1Im8U7BpHChr5BxbLP9f8q36Ao=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, david@fromorbit.com,
	zhengqi.arch@bytedance.com, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/shrinker: fix name consistency issue in
 shrinker_debugfs_rename()
Message-ID: <Z8ij1cHYljL_xQwg@google.com>
References: <20250305071759.661055-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305071759.661055-1-liuye@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 03:17:59PM +0800, Liu Ye wrote:
> After calling debugfs_change_name function, the return value should be
> checked and the old name restored. If debugfs_change_name fails, the new
> name memory should be freed. The effect is that the shrinker->name is not
> consistent with the name displayed in debugfs.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by：Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

