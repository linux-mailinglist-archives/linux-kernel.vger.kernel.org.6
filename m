Return-Path: <linux-kernel+bounces-428470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E09E0EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F079BB26C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82D1DF748;
	Mon,  2 Dec 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="awzMsTDZ"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172A1DED48
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178450; cv=none; b=HfTJj541PK0P/9cFDtxw2Y6HfaKpPc5SDn4ptJCdG0C6avzjc6a8v5lONTzNP2MAvL9+KrkA1Ovdyevz9nZ/jvZdN7PrOIK8D2CLs9VEXupr5OpA1huIRADPtn6F1D97qMOeI8nSXsLQ/VQpJpgBzr05VdggSlXm2k45W2rXW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178450; c=relaxed/simple;
	bh=wLcvplHLJe5my7/BWsVXlIbu2Z7Oyjf7wGztUASKajo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cck04L21IGsy13aU/MDYnYDm+lNf3ApKtBoGEoVqoiogURnaoXVJrC9aNm6aOgIInSn9tyQgtPlzIE519gudS0Y2Ri/dZ/pCM9W4QjffjIa7/PvlqS42cNyCdeKhZNPJsb88kkuc2eNiKJDzaM7od0n2OGD4FmmqYhbOZ/uj1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=awzMsTDZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 22:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733178445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHTGhTKKvmj7dDpdv1pQCiZn76VhaFtfYm7VpOCh5/I=;
	b=awzMsTDZrHUCkLGt3kSJVqPYpz9nScq5R/1ysyaWrHKgHNPsGEuW8c9/vUX/JKAIYoM5de
	Tf+CUwfqQ8+/PT97dydXn4pbEghIC+DZcc3cEJLIIdUBvStDknZ9Ue2aiZEYoPAfKJY3lN
	b7SiWf/QKSlom5XfChWwByf3WjbW06Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
Message-ID: <Z040RS6-Kr8aImJg@google.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-2-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 02:41:51AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> which is already checked by the caller here. Skip it by calling
> __mem_cgroup_uncharge_swap() directly.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

