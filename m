Return-Path: <linux-kernel+bounces-238127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBF9243E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2301F275FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17891BD512;
	Tue,  2 Jul 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIavHQ5P"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64421BD509
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938749; cv=none; b=MB1h14nPIojhIt2cYvEYumNwj8wEHTviSfE6iflemBFBn9WoTIVf0G8g7R8U3QIwRMFOrWmjJP/SyNTjcP/Gi97wcvXRLl2UYB8NL4I4QvHF0qU5CXywr7SK1Q3QrnN0DJbmR8+ZVmnj5ZLE+ZMpdaSDed0pGLtIIlrsXDIHBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938749; c=relaxed/simple;
	bh=Wl+tnsOYCLNKKFW0UKfvPEfM9LnzpqxnNJBS1fLJs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbsl3sdnr4HVVq4Uti0JyD5K5kQmL+DEMKLNjqhGdF0/T+ZijINxtgf3h3IgFiciDK9lpWhSrJjPdQ86ctRCAoTrgm5tB2dQVsbskRaDMEIySf95QVmn5ndKM12lE67dwPRAvnJXiOhx1p/Ll2DF12qaXUoxKg0euSG1EPaUUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIavHQ5P; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sunyibuaa@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719938744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl+tnsOYCLNKKFW0UKfvPEfM9LnzpqxnNJBS1fLJs0Y=;
	b=OIavHQ5PMQZoEqcZL1HQyR7TjCX1RAvI11iOtZBvp6TbfVrA1OdViRyaYPOW6Dne2y1ajN
	Dig1y+6egNgvkus7i+J3l0xwiFjWCyqzoDbPsilZMC8kvS4pKBkkr+Ta3HuAhpB9TbufzV
	xcfQwWsfKu446tCOBS4pP2jjwuY9t10=
X-Envelope-To: tj@kernel.org
X-Envelope-To: yi.sun@unisoc.com
X-Envelope-To: jiangshanlai@gmail.com
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: ebiggers@google.com
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: niuzhiguo84@gmail.com
X-Envelope-To: hao_hao.wang@unisoc.com
X-Envelope-To: yunlongxing23@gmail.com
Date: Tue, 2 Jul 2024 12:45:41 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: yi sun <sunyibuaa@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Yi Sun <yi.sun@unisoc.com>, 
	jiangshanlai@gmail.com, jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
Message-ID: <voitnfv6ipsi4dh4i7hufaq3o3ta2z36paan35yitdwmpl3jvh@2cbmzlv3qlyl>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
 <20240701075138.1144575-2-yi.sun@unisoc.com>
 <ZoLoJ-uBo9qyAlMg@slm.duckdns.org>
 <ycmaxfuqpnj3vnmseikx7m7jkzsp2t2qtlncgub44xhxohs6du@hucdavhpcvpi>
 <CALpufv3bAsMey1DFb8HPbp8gPZWBU-6rrhvRWwVQsxXhPXOvdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpufv3bAsMey1DFb8HPbp8gPZWBU-6rrhvRWwVQsxXhPXOvdA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 02, 2024 at 05:27:19PM GMT, yi sun wrote:
> Yes, adding the io priority attribute to work will bring huge benefits in the
> following scenarios:
> The system has huge IO pressure (these IOs may all be low-priority IOs),
> and a work (we hope to complete quickly) is also doing IO. If this work
> does not set IO priority, it will be blocked because it is difficult to get IO
> resources. And if this work sets a high IO priority and passes the IO priority
> to kworker, then this work will be completed quickly (as we expect).

Why are you submitting IO from a workqueue in the first place?

