Return-Path: <linux-kernel+bounces-256721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B18935281
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59ACBB2174E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE886F2FA;
	Thu, 18 Jul 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NMpYR3on"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B1EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335660; cv=none; b=t/Y/MkJ0pfn4Mzl5j7qZR3U7fb7eix26jYTf1VZ4haEyU7UbI0yKFsYbvhNbUfVRCSFxUjTpspKDMmHGWdvCd9GkwjUi3Y6uLPPmbM+Ak1kbKKtNR3uP43SMKpJabJvpJEENF1k8NUCIeAe4Nh85Ox1/Q8Kqg0/zCAk2vJV3bzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335660; c=relaxed/simple;
	bh=lGgyq9P3mH6zM/ZfDvR2sw95wkGj8OY9qKb6kPsJydc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLNU+UA+x07lCWPqdqiuEZFWwTlk0EY2RqdUTzwjxvbpVSsBvWTpBt4KIQ96Kn6eaokSCRlXq/rNcbPVby2Kj+fVpGO+55VuPYZqRvISUNq1tDu6EcGLab18P4irBEhjDLW6AaNlm/Z2JdpajeSpCN7uusmasCqiP5Y7FjbTTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NMpYR3on; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: songmuchun@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721335655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRU8ymrF68GQy+BG8rFynst/ToLkyQbb1E2sopO6mxs=;
	b=NMpYR3on6DaFtwZLSs9t0P9ftHVT7bXEDOWP+6XA81fUM9rE+6NIBg64srChX8y9wfKHAE
	2FLqChRfuCOPMj/4O57XBcQLMgccOvSz9VVYg07IRYBE63lcW32uVb52zaO5cDVaY18UT2
	Yu2WQWBzug/XX3lvcDVH9x/0VrNZaBE=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 20:47:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: remove mem_cgroup_from_obj()
Message-ID: <Zpl_Yl_V-Em4Dd2k@google.com>
References: <20240718091821.44740-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718091821.44740-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 05:18:21PM +0800, Muchun Song wrote:
> There is no user of mem_cgroup_from_obj(), remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

