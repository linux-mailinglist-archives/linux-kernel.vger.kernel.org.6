Return-Path: <linux-kernel+bounces-388928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0799B664B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42762B2274B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD01EF936;
	Wed, 30 Oct 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Lrr13xIA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504C1EF92C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299529; cv=none; b=GfUS3I0ExOQs/H1MH8rbc7HdRRn8hNVFE1m2ouOSfXXuxJEYVeZmVbrarKltgUI7fxvRu9B89c6Ny2MHY3AseqTRsusfdwst5SRoon1S+PBK7JeYtkTi/yZ8/00WeD2R5EAh/wdK34nSg1ICj80enDpOEVZNXwtV2PutrX+CFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299529; c=relaxed/simple;
	bh=KDd7q3izCIy2uvDUHvhTjP4ypFwyOPbe7o9FvoUAM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcpDc/2In6/iPd5HapvxrBsBNDANzcmQDejpSqNz0bUH062V2D+s/IxXWTTDSB4Q93bZZZ8mVSHhl8mgM1GshSHMKY4MjlXtKtl2NADS6csT/8YVRwyz724UB7GeosRofWBTXTpNZL7c1p/F1dVzIIfjRLkec1IK11by5cfGE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=Lrr13xIA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431ac30d379so27910405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730299526; x=1730904326; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoDDm8JP2udkrNnIMKPZ0hp9VS+cBdfycpwS1j/FcSQ=;
        b=Lrr13xIABXUsQxCdwbtR9/zCPuHmCNB1klafpPDyXYSTkRMvkMKoA5dTcKFJaFtBe4
         8MMcvgBBe5mYmeK5rcMmhu9YKe0DJaQzcSgkqlDcchl04KHwVhY7c8moVLiwruHPJaUt
         7/AxYbdgKOaheMN7v76w0MI4EWKjqxMRskN2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730299526; x=1730904326;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoDDm8JP2udkrNnIMKPZ0hp9VS+cBdfycpwS1j/FcSQ=;
        b=A+dD1d580RORZd7oRDAZYaRuLEu6dMW0AemSGq4UKUUHydVq9dOLJAeSh/ltmhOsZx
         QyNCBgM8y+VTw3YfKQ/1dD+Nd8BnF7dbcBX9gWiEnc53u7Sc2Qydojh2x5WTckIXr1CG
         hYueFpoW1jfJebvr9YwcBEHiPQqBO7nQQRNSqIL1aD0fTzvb1/8j8oMBAps7YCi3B641
         SQ53NsZYQVc+Xx1+MbWf19nPLtcXUZwtAbcAhxqoPn853QwRejIaD6i4lYgQ/VHd5m1D
         B51sQ1MZIL090iBgF5DP6vz0KodNwV4zf5wly2cemY8XbPQ8Gn5MF5ktwdUFM3Fg7lKZ
         L/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUsRdEkNa/zfF0/wOVSl+9oVlTutWaFi0aJ51tZ1dD/foYHmn52ykmwVm+rLVp3v+/sp6cw1uSnqU4e4AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSHobPlYut2WVF3faQSjKp6Xs4d5aAcdx01Mc4o7/WOTNoUBo
	qoAS8iD6rvDrKCDLHqNVZFBX4W884wldzTk5EdW+yNo/dUgmwgZgtcRWau33NQM=
X-Google-Smtp-Source: AGHT+IEPjKO/h/MskOFjZ6ZLRebfzAiOStur116BnuhCa7N+oewBVmpTVB5mh8kB+XAVvtST6mt7RA==
X-Received: by 2002:a05:600c:3c8c:b0:431:4fa0:2e0b with SMTP id 5b1f17b1804b1-4319ad146b1mr126147855e9.28.1730299525369;
        Wed, 30 Oct 2024 07:45:25 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947b2bsm23699315e9.25.2024.10.30.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:45:24 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:45:24 +0000
From: Chris Down <chris@chrisdown.name>
To: gutierrez.asier@huawei-partners.com
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stepanov.anatoly@huawei.com,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyJGhKu1FL1ZfCcs@chrisdown.name>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

gutierrez.asier@huawei-partners.com writes:
>New memcg files are exposed: memory.thp_enabled and memory.thp_defrag, which
>have completely the same format as global THP enabled/defrag.

cgroup controls exist because there are things we want to do for an entire 
class of processes (group OOM, resource control, etc). Enabling or disabling 
some specific setting is generally not one of them, hence why we got rid of 
things like per-cgroup vm.swappiness. We know that these controls do not 
compose well and have caused a lot of pain in the past. So my immediate 
reaction is a nack on the general concept, unless there's some absolutely 
compelling case here.

I talked a little at Kernel Recipes last year about moving away from sysctl and 
other global interfaces and making things more granular. Don't get me wrong, I 
think that is a good thing (although, of course, a very large undertaking) -- 
but it is a mistake to overload the amount of controls we expose as part of the 
cgroup interface.

I am up for thinking overall about how we can improve the state of global 
tunables to make them more granular overall, but this can't set a precedent as 
the way to do it.

