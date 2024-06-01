Return-Path: <linux-kernel+bounces-197741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2498D6E92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D00B26FA0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669861400A;
	Sat,  1 Jun 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dYPPpLVk"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5D17BAA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224544; cv=none; b=H5KgZpH/XuYphLeKPWaUwgD5DJW6HZoilZAhY/sb6CxJ7htdaCdECmstzbYBhe2vMx9UQ5DGUNePemCjswwmdIxzytsKsrWsJieVZbxV6YnIBokoDynTUI+BjbzvtDITMPQgGP3yDWNN/6HFEEiprI8tmp4dX5AcV6DIlKofvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224544; c=relaxed/simple;
	bh=B9324jrCRuoLykBmRFI6OOQuz7bwhY/LlFxXvFLkOx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfJh2OP2AOHFq7z21N6hzXKJ7Fi+jn1HLcXqZbhb98QeNsAyLiviSxRJB2YzG4aafosz3cQ9JDtEsXgz4sxOicAzhLSxq3oH5b1KcOXWD49/NT+NUzeNSA3H23eVuq5ZMk/8UgumVjubDy6lU1ywQclXUuWUq0BiFUf3dcZE1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dYPPpLVk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lVawVG9pTJlXD2tj4sLgjn88reNfe8+zGvwXvo7eDU=;
	b=dYPPpLVkdpZhB4LBTAFAEfdTWvUbO8S3HryY6Ph0qOX+4UJsmzmfxO8ZhdIKoFqbmiPw5e
	r0c5rVQ2nh1Xt8IQWZdGR0uwpHmH9eNzclVCbnXFcigVW5V6iFKOIB//w1MQqoLFa0r916
	/gY/FfOvYcSuUzM3bRMPEYSUM/2z0Wg=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:48:58 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/14] mm: memcg: make memcg1_update_tree() static
Message-ID: <twgci7nrmnurzjpd7nnezzmudkxu2zcg2atsvw2ziutpu5bggf@jad6m2i6yl7g>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528214435.3125304-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 02:44:32PM GMT, Roman Gushchin wrote:
> memcg1_update_tree() is not used outside of mm/memcontrol-v1.c
> anymore, define it as static and remove the declaration from
> the header file.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

