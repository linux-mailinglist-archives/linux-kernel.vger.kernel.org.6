Return-Path: <linux-kernel+bounces-294804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B422F9592B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E68B283BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F712B17C;
	Wed, 21 Aug 2024 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DGnFV1EU"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A01CAB8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207152; cv=none; b=Dh2LMVyfjihMk/ml+FTMvRwap8pryiGXZjmMB9c7ivGoHNOA5MWeHAnterRIOf25DPMCmJGpY4M0iSN7IdyCg2Zzcf6hkzQFvWhd0AOKNEnezjscWVCH90GpsdFOI1DxQHJWmBq1Y9QcEUX1xh60Z9LWWhSN7LWS4yIGWk04Wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207152; c=relaxed/simple;
	bh=R5fEJy0GCh6N3mDgJOW1+F5kRZNG6B/iI9GuuW7stzM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DJD5l+zsS9K1kYnYGcueur8fQ60/iA0Wtp5k78J/eGecPIYSlahVDPkk2casNdBRCXpyaVs79lryH4OcfUgV7VvwLIZ39NMY7B7IWmN5P59pU+SVoJzpURjzcb6JpluTp3FM88gxyre+MKqCQycQ5sYS1J+7WuNIEeE+KUr9Jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DGnFV1EU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724207147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdD86dx7SlkL1+HkWIB0Rnscr1O+HO7MtpZ5C/Sh/II=;
	b=DGnFV1EUK+az/hLuabciJid6T2KkehHsROiXTGcfezcK3sxJZzH2JgkHkzrZIGM5d7gx3M
	RNY/vURgiRbD12XWAtOCY1jb5xGHNFZwslpu/XwM+J5vk0wqptQdWHNbrycXGmQGUpdGQu
	ahzsWvAv9tFcW2JDvERTlBobQmVeICQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] mm: shrinker: Use min() to improve
 shrinker_debugfs_scan_write()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240820042254.99115-2-thorsten.blum@toblux.com>
Date: Wed, 21 Aug 2024 10:25:01 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D45C9977-F9D8-49F4-89F1-9BDE8384DB9F@linux.dev>
References: <20240820042254.99115-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 20, 2024, at 12:22, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> 
> Use the min() macro to simplify the shrinker_debugfs_scan_write()
> function and improve its readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


