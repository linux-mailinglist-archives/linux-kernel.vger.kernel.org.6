Return-Path: <linux-kernel+bounces-197731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675EC8D6E86
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FD21C2140A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F812E78;
	Sat,  1 Jun 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dBl/WnMI"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475717BA6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224215; cv=none; b=VoyoNh0RzDxKUpeKHvDtrQnQIwRil9qlVDKTact7l5g437itU98Wb+XtZEzwR+qZU/7dIh2TTwDTzcSpNOHFYs1/lCIv4hcv01wvN4lzbcvuO0iudo00dLuzLQ1cgVw54GyiiRe+dEG3tw8me51t4JJPPEPGQCh7pdBUtYTcEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224215; c=relaxed/simple;
	bh=1neg2pFmhNeph310BFdFkMAreGxNJtOLLdePpDN64RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5ietBCQeZVfBAqOniHi8oUQC2mplYpkUfG1MFjZ2A5dHD68n3ZmMuJi4H4jAHpXRS3t2De8Jj8Cppc7bmnoHswW37DWD5KZZnZI7X5vdQpTkk5lA0gjwXWUOrYYg7YlAs3VUHlqRBfvmlCscROBKDYhomxIeMQHOb+nlbmgJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dBl/WnMI; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teoqNuAvrJCLEKwidgU1n3pxSETEfYeucdBQ8Ael8Ug=;
	b=dBl/WnMIRwxceWPgc3dd8EBjRXcqqEdICerSLhl41mxcjtpWHo2Sxo/SCH9CyP/d8pOQ3/
	IvmBKFY2QatcKAjmX5HQrNoSrlw/iVvhi3nim5B7OfZWE50QG09xZjo2q3vzCN/uQbTde9
	XPEHLfukfQGGrtcqkeI4LaryFKObkfU=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:43:26 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/14] mm: memcg: rename soft limit reclaim-related
 functions
Message-ID: <dhku4gb3gfclgpylosmaspjvfde5cg64ea7oqj7brsb5qnvjgi@e6nq3a2z6oje>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:55PM GMT, Roman Gushchin wrote:
> Rename exported function related to the softlimit reclaim
> to have memcg1_ prefix.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

