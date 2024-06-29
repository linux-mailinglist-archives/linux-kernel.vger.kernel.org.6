Return-Path: <linux-kernel+bounces-234722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9191C9CE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F191F231E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4CA29;
	Sat, 29 Jun 2024 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eiEeRi7m"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F164B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719621643; cv=none; b=XAoHWLZ1tAtBX2oyQRg4WjuSf35cu/0AW/Ftk54H7e+Fp5OayGgSgKTiaFZF7LiirWxS4H5d5bBD2oq9FX+yhzHzyyUcICTV6KBxbw+KgQpWL6fw3/M71lBsF9So9LuuS0RKAwVrgT4ZDbru1puKTqnSj5NZCoClT/Q+7N5s1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719621643; c=relaxed/simple;
	bh=tUPGZ3tZqPxZgg/FQvwGXepUrP2cqlKJ8cDLXVABtV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nlw1g6DWdEgoxTYw4jJTJpSXvZon7dYjLPl6p1+mLiIyM77lAZIadsz8gzP1IJhNES98yf6d1a2g/uTlOTQ57meMtnAp/r++RFQhbKIv6la0KvC2kTDPRKY2gWWS2P3H3CU7+sy6BA4V+KReAJuVcjfEtg5cYtDctcBCIAox1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eiEeRi7m; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719621639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pyTOdlF3ax1ckwiA8cNe8sSlczuIvSiiD2TPbc/1EMs=;
	b=eiEeRi7myv1MaWT25mt3gXv+jrpRwdz2/EKE/0QZIbI4PicP75tz6d972izQ48hpZrPXXA
	Z4Q7OXe950qcotP6Pd/eNKpf4hwosRO5Ck+pTO6BNlL3q2BczzFH+xxeS0LQebhS/km5KA
	ugSSlUVptgQEnl8yDIw7F0H2PnV035s=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:40:36 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 3/9] mm: memcg: guard cgroup v1-specific code in
 mem_cgroup_print_oom_meminfo()
Message-ID: <bcnfr34kvjchhc3jubpmblny3pvhgxkfhqbp5dt7h3l7zldswo@dl3atdfqrpyp>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:11PM GMT, Roman Gushchin wrote:
> Put cgroup v1-specific code in mem_cgroup_print_oom_meminfo() under
> CONFIG_MEMCG_V1.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


