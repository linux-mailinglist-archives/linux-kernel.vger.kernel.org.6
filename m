Return-Path: <linux-kernel+bounces-256706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C31935240
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA341C20C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C44145A19;
	Thu, 18 Jul 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QK8kHQfm"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD01459F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332013; cv=none; b=sWvL3PjtYFXte49ClReziEeIeWmddSKYsH7ptFL7eGZGlevGNn0DBPTJdjcL//moKp5QzaxmWAO2QbaMZtSLHNdkGh55x1klIvG1yZhMk0A3neWHyWVMKUAtlKIGM4YlAXdFq/dK+WpJpF+4eeO0OiYU2pyr7bIV0tV86Dntbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332013; c=relaxed/simple;
	bh=kzWORm6SuvaebzRysuNkfCQVCvljqnpJ5Ea/vPeoqdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Dfe/nGoULuNrl7T8ELaKZb57u4aTpiGhrYymlLherzvzT20SqjyzZm0ZLkBd48V3R68DuLC1qdEMNlu+pWiBHcdiqyYgnUnY2a/k3qpzE8PqARRQbU5ypVv9B3ThOJGG6ZDpJrxYDdqBrMMSFYiPRmtY+nYdS/t2niWNNnhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QK8kHQfm; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: songmuchun@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721332008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSregXPsYAdLpJ32tUMyFkFjP1/Em/6OT6zvIe33cXk=;
	b=QK8kHQfmsi5HBkWkeLugs8bBPe2sbNzGZjHx5bRZj9DlKSzh0RAfKBtMbvrmqoLFZQRjV8
	AgFkuMucQMNm2bXMdP1NWA6dZzY1RwTriBKaIC+PmsGf8rft/nl6flYMT6pD1/mwDargiz
	6Rdn9En3DjQqwoZbdFLsPkCYG6rdxOQ=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 12:46:35 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: remove mem_cgroup_from_obj()
Message-ID: <qimvdyf5tcu5uob75mn2j6ohx64affxlhnhzxgebxwr2plfmjg@tpajkur3s2wc>
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

On Thu, Jul 18, 2024 at 05:18:21PM GMT, Muchun Song wrote:
> There is no user of mem_cgroup_from_obj(), remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

