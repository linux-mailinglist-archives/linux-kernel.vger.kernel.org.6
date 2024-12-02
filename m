Return-Path: <linux-kernel+bounces-428471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C59E0EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54DAB25DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C71DF972;
	Mon,  2 Dec 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vuJvXkZu"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1931DED48
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178546; cv=none; b=ejXTid7sJkcRi+i18kf6V498jcWkYWPwMeTj5DjP2VhB4JGoxq5mXphunZJd0dE6S9593heGussDFurWuiidv0gP4C+sqcg1M2VkbkPb0rmQXNPK3hubES6GbOvycWklxhy9PiUcJdpda3uuvUxMZ/dQZx/KwhOaqpzg9nHkLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178546; c=relaxed/simple;
	bh=n2TfjVmJC20UHcPtLwO4DLorV+1qP7imoQkD4OcOJSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZuNdt6W9L1siy3dwgjTYLGwCLZySlbCH0h9t0DiqMddbFxScMjTIyUDe4lg+Yf9pUZcoR2rQX0xIWhauJXFjsrgfWER43NTu79kVATPyFOf1QhQ/oRbkmzSRdTwj2h19/y54QJ2oXipHD1ehqjhci79fMcJuqoLtK7pkbd6If8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vuJvXkZu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Dec 2024 22:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733178541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbMiJKXbGIpnnAFpChGg32S5tXuusLJ9GzDuJMfkPPk=;
	b=vuJvXkZuXz7C7nMSV0bsec0WJbaHHTipejDMtQtXjcuop70BrFbX1Jx173AZbYju14o2jM
	jlfl+OwEvaKTqrGpEdZjEtVMqOAumPU8VyLd7uTs+fj0K1dRlkO8axIKY/cqZ3yVIubMUB
	S4n5K1DNkL17tgoGZcgCCFAB9XiIxiw=
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
Subject: Re: [PATCH 2/4] mm/swap_cgroup: remove swap_cgroup_cmpxchg
Message-ID: <Z040ooI5zqFDxJ-E@google.com>
References: <20241202184154.19321-1-ryncsn@gmail.com>
 <20241202184154.19321-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202184154.19321-3-ryncsn@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 03, 2024 at 02:41:52AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This function is never used after commit 6b611388b626
> ("memcg-v1: remove charge move code").
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

