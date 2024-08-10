Return-Path: <linux-kernel+bounces-281714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3F94DA30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F43A1F21FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D701B1386B3;
	Sat, 10 Aug 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qAZCCvTN"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C623C062
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257572; cv=none; b=CK+Oqs208DU9VVF3NS+LC7L5zd/fGc99ccsuaYOqitZQg1MrhxwHf/9XtEkUq38Sxw6M9DgKXwlseNXBvUPQ2Mu8OaP6+wxgI9MM4VmiXIOIxqiYu0PPo/uTFRQOOCgV7Frv9MJi4gAsrCDEb1iojw7MrY4d72gjtv80M7UgaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257572; c=relaxed/simple;
	bh=+weEgowa/sf3AGpmMQCdg5onlZflD/OQ1Rk7FS6GN4A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s2aJ4PgTLQHVWmuVmXoGH76feRhnMSP31SyvOFym2SQnZPLjsHeXh7dOAicnVhM2ezpfxAG2vmGRMEsRrgNLJlaMN0udOvBHYyiVzqlaqiIgxs1hflmTVinwNwYBujtZnqod5hWKdFp3RAV7kd4+L9Eket5goRtmNtm8PJlkPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qAZCCvTN; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723257566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI+Vi4pbj0gTCrjL7DMWl6AgcfOJvlF0DoxzDvU62co=;
	b=qAZCCvTN+nVPafsEp6qVwXKPq06wHrt4RBcMMu7V+s7rzc1tzF7VlhTLNgg8wqeK4awn8Q
	l93xiM3ku8MTrGEowOu+XmXcm0jLvQv7VINKf6if/UjuSDBbgOSin4YgpHzitU85jEBZ7v
	sQ9SgslhesrDKyrfPL1z2CsAR1ynrfg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Date: Sat, 10 Aug 2024 10:38:50 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C0B6D310-2EE0-4DCC-B41A-E682C1E018AA@linux.dev>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 10, 2024, at 01:26, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


