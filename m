Return-Path: <linux-kernel+bounces-312432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52D96968F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17DE1C2384B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABC201240;
	Tue,  3 Sep 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IoREj6dn"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D6200117
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350985; cv=none; b=ijNn5SbzFTBCBABw+Ofg0/ERVMN3AIx5NE42gpVec9S866iuqZ70vlYMJvO4tpEe7jERpdbo0D3BEG4Bz4lHcJsPvAMbGoKjDJgRNdTuFAR3y70GPI36BYohjXYNlTVXRhUMJ6dlQtu8SHLsUq/E9ZbEG+OcrbSg3oafgulpi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350985; c=relaxed/simple;
	bh=JRPOowXembhUekChI5Qc6kmpWJxft+zST75uxO5CFmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/RzAMVeIFLjUT7cNNmBZLB8tFEuNFBH6ikwidopZBvopc1+tAkEXTay2cPoMuflSRPQ8iuiR0I9JaQQbgseIUHlYz3Z4mHqshQU7qiTNMDBEz0aj38fHkWVwTm44vhd83WXUMcGcwCKoYyxIz/Y6KgPsL6qdpwZTHXAcpg+CUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IoREj6dn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8696e9bd24so574444166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725350982; x=1725955782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojV6UElN9wXuS/0J1carDitgIkM/X8KA7SapANSlFw8=;
        b=IoREj6dnuLyS2lzZl5UXY+YzdP1j4ZrZp+QXEvXGEcocgQpTRIMr2T1lgLpgITfZR4
         wQx3OMHng7DkxOfO6dYV1W5alvp4CwrsYCfiz9SWZFNXt06vHRhtrOpSvKcvDYaEBKHu
         pN1zma/9d0trsc3wNeIHNJ8tlHQc3bm3dWFTgJIzKyOE99vp/kreBYTrISU2xZCsrCcD
         aWaTcwrXZ/NPKjjPF6I7AhZzMirxWAz+D/rIpejHIokC/6hHqLzLH7rKs9tVjiggSL9J
         kEga6/LkLJrddcEQ8LX3wb3Ce1Hm/gtAlPiWz93laH3h1E0g85O181dDQPFU5dg0/spJ
         z/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350982; x=1725955782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojV6UElN9wXuS/0J1carDitgIkM/X8KA7SapANSlFw8=;
        b=Qh/o2ADtvP0/geyUNHX2zDGULWYqNk/xBcRQoEpSSWxt8gL4hOgZluhfg8q+sOoPJe
         xlqOeZ6DlZ61aECawopwbI7CA/cFXOpUuuPJsTiWGw+g4wLN1LKEpkLTfO9U5iuLse+R
         4abpEyq/PqC9iSyDN7GAzQ7M5hQc+b7G/lMU4APddzQ4GIln2csCG2p/wGZLUuQVsZqs
         cOGATzM1/vCM1lu1WxXpOK4GG3Xjk/9d1EbMy4xwi+nPi3q1j9mvGNQ9VZ2t8aOP1KhD
         37SeHgkNfqqgjNdA9aZto+qa7HC1Z8RYKYDwFUfeNoAQOSjmLev61ASg41hXqPiFbL7x
         6eKw==
X-Forwarded-Encrypted: i=1; AJvYcCUQiGv/zbnuif5vG49X64o3A7ntMSXwrnzfDgVtz4D2OFKAUgelG14UR2/1NvAYcMg4jU0pvn6jMLdEbR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tf1Bls/dv+imA3dnpLP1ZfGQAM1d6kg9oAi0GYxSML/LLe9u
	WVUGlngvnKlefg3IfejSjl6ZCC4WvjnYWy60yxKqv19jFER2tx63/feQm8zrIQM=
X-Google-Smtp-Source: AGHT+IGWsxakA53kfoA6Q+nDGvgrE3zDIwBUGKKTInbMEKE8xdX7CFyQ+Eon3wn1kzgfjsX/YSRYyA==
X-Received: by 2002:a17:907:7e8c:b0:a7a:ab1a:2d71 with SMTP id a640c23a62f3a-a897fad365amr1098707966b.59.1725350981532;
        Tue, 03 Sep 2024 01:09:41 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196babsm651441966b.100.2024.09.03.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:09:41 -0700 (PDT)
Date: Tue, 3 Sep 2024 10:09:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: ying.huang@intel.com, akpm@linux-foundation.org,
	mgorman@techsingularity.net, dmaluka@chromium.org,
	liushixin2@huawei.com, wangkefeng.wang@huawei.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Message-ID: <ZtbERGm8CJsOwx73@tiehlicka>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
 <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>

On Tue 03-09-24 09:50:48, mawupeng wrote:
> > Drain remote PCP may be not that expensive now after commit 4b23a68f9536
> > ("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is needed
> > to drain the remote PCP.
> 
> This looks really great, we can think a way to drop pcp before goto slowpath
> before swap.

We currently drain after first unsuccessful direct reclaim run. Is that
insufficient? Should we do a less aggressive draining sooner? Ideally
restricted to cpus on the same NUMA node maybe? Do you have any specific
workloads that would benefit from this?
-- 
Michal Hocko
SUSE Labs

