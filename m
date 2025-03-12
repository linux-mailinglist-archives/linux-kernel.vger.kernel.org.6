Return-Path: <linux-kernel+bounces-558420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26242A5E5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915493AE1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54E1EE7DD;
	Wed, 12 Mar 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UsGLiJTX"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B53D81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812793; cv=none; b=k+7txbHzLmot+eRPo189GUKzw3WbgGv2Uy1Whb708RJx8IRM9as0XvB7eb0qWsybLqpXChrk7GDn9zw95sQA9jfClBtwv+eOjIqDLRepTIBdAupPbbCHB1Q4j/3/jxrvkHt7kOUuPkvZcaET9T/AqBE3YDLt7F0sNFjeD9m4KQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812793; c=relaxed/simple;
	bh=PcRePMx73CHCWzk8k2iV+6/77GKqcJT0NReb5v5VepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vr80Yy1cl4D2J842MZVZoEbbDtlSXrZa6/KUoSn7vw0APruzpQtpqiZ8Nv81WnoB6sFBcgoWc9a1fkPqPeK5KReuPuB5Xwftr+j84tZVZK2G6SqBnhodvyKRMPJH3r1Ln7JtOeYeIHWBm5uprgfopRCRzRMwBrm3OMZ8taIh0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UsGLiJTX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 13:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741812789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xx6hDBqC7+beBO1/VfyQkCDCm7ON1f33mSCbGvlmfNI=;
	b=UsGLiJTX1GaOzd1cKuRZ+jd6dDCOro8uvPOiZsGzJBoqnxePWoIlM83JRLQYfOMK44WTL6
	TS3TV+uz3bxaHwrKghs7FcvUDu274mlmkCsbjrYYha9ITmWwydoVq+v3rFfDr6FTDHzqJt
	V/6DFKsf06zx9JrXkss29DS4xLC9Vfg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/madvise: split out populate behavior check logic
Message-ID: <sjgymc3obocmguvggi3eotsl2dpw5qannvi6dh5hez4ake6idt@xot7rfb5z4uy>
References: <20250312164750.59215-1-sj@kernel.org>
 <20250312164750.59215-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312164750.59215-3-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 09:47:48AM -0700, SeongJae Park wrote:
> madvise_do_behavior() has a long open-coded 'behavior' check for
> MADV_POPULATE_{READ,WRITE}.  It adds multiple layers[1] and make the
> code arguably take longer time to read.  Like is_memory_failure(), split
> out the check to a separate function.  This is not technically removing
> the additional layer but discourage further extending the switch-case.
> Also it makes madvise_do_behavior() code shorter and therefore easier to
> read.
> 
> [1] https://lore.kernel.org/bd6d0bf1-c79e-46bd-a810-9791efb9ad73@lucifer.local
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

