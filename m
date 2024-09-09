Return-Path: <linux-kernel+bounces-321920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23228972128
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC481C23B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE3189B97;
	Mon,  9 Sep 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fEvNWv72"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C042189B82
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903357; cv=none; b=EG8flG0aGC7LPFA9yLKtmM659QzLvYC8MQbhQI6hiGtgIz53QZTqTbW+Iw3BFm12APSXiCeWrRflGaf7XrfurOmvsWLb6Q6hZorx1bisynTCzErmEoPt9ylZV1t4cu8+SvgohnQa2JcjJLGLO6p9g3B0Q7Y8sw4MkcLU3oKLklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903357; c=relaxed/simple;
	bh=9aw8PX64D6pSR+Ia9H9ANt7478SV+HKrI2YmwF/5mhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDCKQ78iLe8wI/LbFT3kPEsTPYM/1hUEfAZWcmBAGTrMTsRtQgXTHGC5GIE1x3hC1r4soB8ZDJFOrLVVgK2PWzGtqR0PIM6ab1JcNlc05aBEviqFXP6U0jz5AnGhGah1iXDUaLpNGaGt6oecGZdwaPb8bej71zb0vDMrLPyLo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fEvNWv72; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Sep 2024 10:35:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725903353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmKGYO/dpVEt+1a6FmkaafuRmzIOS9aVPE12GwYuRE4=;
	b=fEvNWv72S5tUhzNe5wF1JK4/WPod8FcE1f8TVrEx0SOovu43xmmBOPRZ3zfUmhcqm5a1Yl
	8tpbYrLKAvarjZPqv6f5fbSbduXmlhZg6ZQSHHMM2iuJimAItIXQHPT4EzmJfzaCsWRi88
	9FpH3+8srxHeTsH2u/fSM6UbbNoW6jE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Message-ID: <qbx65gqigbmohnrmrdi2bx3mfl7posce4salvuoaqsm2y4kyz6@lb62sbxapqqp>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-2-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-2-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 09, 2024 at 06:32:20PM GMT, Michal Koutný wrote:
> Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
> users, drop them altogether.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


