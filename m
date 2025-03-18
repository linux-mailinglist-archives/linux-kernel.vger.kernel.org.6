Return-Path: <linux-kernel+bounces-565235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB23A66435
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BED7A6E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E00149C7B;
	Tue, 18 Mar 2025 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESTHhjxm"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB970825
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259075; cv=none; b=tPfzrfQRCOYssIPZwPCKhamx8/QqXjaeNbZZ5ol3AlEYmtZCKKswKrEG/hnSrjozRc1XBunDOBN8SA7eg6gXFhoQopSkhFVHWgAZXpttMO5VBsooUf79+gGUfOpCQjiUC8ES8tznANI2t4Rw67QeY4svBpH1qcjh/DfRfAUSbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259075; c=relaxed/simple;
	bh=RwhuAq/c7qHy/rH0mzwICs/ltPd/pHx3+H40hrm603A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akSg/2qODKrEI4atdyK5RfP2VrnlTpamm7dIlPF9/Nl8k66LY8mV3k+axCHOJhd/nkzb+I6CaxVNR9T3Svm/TuR1BNgnUM+Yl096e7lf7pWg22BAkxPpQvjZxfjXJ4Bf/VIiEWDIYErwV/yKqO2vnjgV+CvmXG9hH8Gk38ljO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESTHhjxm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 00:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742259061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UA+S9ijBBuQefZIvauH3YzP1rEzc6s9swtHO60s8uN8=;
	b=ESTHhjxmk4yJHum91VRyK6GyODQ+fB6QDAnqhgJG/4vJo70QJVReC4QgZ/upcDODSQiaI/
	KDPdd8arnvTPORC8rxzA7nbozCIuGSlpV67/rMNroCPfe61Q4ZTK7Ne4T6lH+ZyYkZphXf
	fGW0wpmZ7VaEhwB2lIyFgVczytLeQTU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 3/9] memcg: introduce memcg_uncharge
Message-ID: <Z9jDcNVVncb_XWDF@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:24AM -0700, Shakeel Butt wrote:
> At multiple places in memcontrol.c, the memory and memsw page counters
> are being uncharged. This is error-prone. Let's move the functionality
> to a newly introduced memcg_uncharge and call it from all those places.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

This is a nice one!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

