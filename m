Return-Path: <linux-kernel+bounces-429404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F69E1C51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70C1B27568
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DE1E4908;
	Tue,  3 Dec 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R1at3V5p"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521101E0493
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227621; cv=none; b=tancT8n/oBaPmtTY/ppEZ57vhhnR82ZW5qxsDy5jHXm9rZWMGuic2NzjHS75ULO/geuc9c5J+JHkHhSQfelSJrbhQr96hLJ46Qzt25azg0k/oIRmcdRF66LHYAYfLRQAdZH5eTn0R2s4w36sBIxkhaqn3RM9UFPfGxo/SROdgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227621; c=relaxed/simple;
	bh=rcmXn6SmVROxvS3DSftWdwD0oXgbrxkJtwmvwrZoaE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adXB+Hjz2ZShsqq0CxffNd8Bc/eBP2N9OQqrzAKMTFEjT3ZcaqnyB+q7sYFY9xGfvxKZE9m7fff4gHoxFhDsh8syInlN3qvlUm2JWXBbyycjoL1JDSXBAz8khWocB5lwFLI9XV/a0e7bqqSlLTmxOoTl3ZMukCbBVU124Y8/QJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R1at3V5p; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso6229401e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733227617; x=1733832417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFDejC31knt+Dzmuq3kTKhViHy7faZed0f+Vhmx1X8Y=;
        b=R1at3V5pJ11ec2SBUZOtPUnv6LDQ6/hXR++mBA1ym0gT3PXbzKhF0dK9I55K7h7XG3
         TedzJxcJp58fkKo2Rm9Uu7tqUQ2JNfGJBzKtS046BIoO/OKOFVJmHRfUklDfKcnOO+Db
         NUhw+ksIgGBxDKyU/KYLyR3PofqYm55PZqd1C1Kqg019HqpaRcULEe/P7nFRcUIynHpK
         dimjXfO6mPvdIrjg+EnA6BcDUvFWKHH63OiqwR0xK9tngtrzEyjR/O/mtHhcZMidJN9f
         NNAWU7SAiJ4qsB2xHeD+7DTRnebrkXhknoT/i8J2EctC907VDZtaWvjwZPmN1JcDN6SW
         zM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227617; x=1733832417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFDejC31knt+Dzmuq3kTKhViHy7faZed0f+Vhmx1X8Y=;
        b=NERAUnqrLBZBvXJn6OrCjl65r7e0n3mNhnn6Z9Vb86HDiA8vXI2u2IM3hnN6rQhTjI
         gBTZoILuhHZVr1a/TXA/7s8Pnjk5TAWw0fq9CJXp9pNB8+6YqJfRCC/UbtFla6o282Uh
         Iw7MUXMTHetHs5c2bowTuDLdV09BRuH51R4bTQWRKUq0QNuN6MLRWQiQYofgyB07Of11
         8Ni02c5tfA02wMtOisVBbWjJ5Ro4m9B+f49AqvdePIzqpePiLh5u1m+H4XMkER9aNC7q
         r52ZNrhPGA4RYMhZ+rOGmuF6wILHNEMzSzdX0CJxvcyVgMCg6R6IxqD9Sd5uGl8LTh9i
         abuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhE3iNqKgny6iAGiV4DXKKm3woO8xxtZVXsFqMH/8YgqaVc0r9JHeVhWq8A0dF7yQN3/oB+erKopuEVQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BGgXioTJ6U70YKUbc4MMELdIcDXjp3wWyVdYzn5geGHLRiHA
	3DTTmMz+7N/hTTWlNr035k5M0V2M6n3qjoufJjGDS+gyfbsagbxsNlF9xJr/GXc=
X-Gm-Gg: ASbGncvM0Z/X1yX/y7rbRS//aT7B0i+u98KF1d0YhgHa8+2uPII42J2Rb1GMPfqBaur
	6BooDt4cc8fj/+o6FAPTiap+xbhEvfz12GP5UY4pQGUIFCtHJXZLna4U1467uGyQPXrsfTZkZMu
	TTw+hDTOh8HWTy68IUyrVlwtmypCMbLLTHkDjRIoYYFyOtxbzohK0yHnAXlduYsPpMfIN9lXisc
	j4JBwi1ALF1ARDodffBbjN8K1Kb1Ab2H574kw1oOfJRYGb9BCvAKqrH8z4FwlE=
X-Google-Smtp-Source: AGHT+IHIoxztg06DqW3PS7QUchQ0kxiPBM0kNP7mXYFXxmLJA7F+1P+NWdlACZN3VBVmeFzCdZ9mTw==
X-Received: by 2002:a05:6512:ba1:b0:53d:f177:51d1 with SMTP id 2adb3069b0e04-53e129f349emr1210846e87.13.1733227617451;
        Tue, 03 Dec 2024 04:06:57 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df797sm615573366b.68.2024.12.03.04.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:06:57 -0800 (PST)
Date: Tue, 3 Dec 2024 13:06:56 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frank van der Linden <fvdl@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
Message-ID: <Z070YE81kJ-OnSX8@tiehlicka>
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>

On Mon 02-12-24 14:50:49, Frank van der Linden wrote:
> On Mon, Dec 2, 2024 at 1:58 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > Any games with "background zeroing" are notoriously crappy and I would
> > argue one should exhaust other avenues before going there -- at the end
> > of the day the cost of zeroing will have to get paid.
> 
> I understand that the concept of background prezeroing has been, and
> will be, met with some resistance. But, do you have any specific
> concerns with the patch I posted? It's pretty well isolated from the
> rest of the code, and optional.

The biggest concern I have is that the overhead is payed by everybody on
the system - it is considered to be a system overhead regardless only
part of the workload benefits from hugetlb pages. In other words the
workload using those pages is not accounted for the use completely.

If the startup latency is a real problem is there a way to workaround
that in the userspace by preallocating hugetlb pages ahead of time
before those VMs are launched and hand over already pre-allocated pages?
-- 
Michal Hocko
SUSE Labs

