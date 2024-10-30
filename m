Return-Path: <linux-kernel+bounces-388760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B949B640C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D389B22B08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD51E5721;
	Wed, 30 Oct 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8jmrLrj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E991E47CE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294835; cv=none; b=qg3rnYLI99mxW01ugwlRj6C1vq0BR5gjzIgRqQafmR9ueJ7BKQSnilwyrY1K7wimtlHEHXe2i1bGtSyjyM+Ho0JmYwtE0EGVzcMdS4Hyl/w5q+lJJhPhGPN+LsarA50/CZ1hA2A8q2H3UgpMslkEhiLV/x+qAwv///8djHuCVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294835; c=relaxed/simple;
	bh=9e6O0Inrc0S2NfXiu9DIaNbgV/fEN0h4Z1kjcHVaOPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an4OkZzAKd9c6pqCYT7PswlhyqeBtaJueiPMsbNp/vrVbKZ11jGc+Nc4sfhFaK2Utc2uNiGKQlVRGwQ8iEA4DVv+GH3b0X6jBDVb+A+6FKSITu4hBv2tY2/z+nbWzh7ueCR+oOSwncRdv3UEWzW3SdHSyQrGpS7bbhWXNJP0udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8jmrLrj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so1046937766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730294831; x=1730899631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HtbxSjryw90OYXsSzx4HPo4i/eL/q8xZDQ/o/edBKU=;
        b=E8jmrLrjs67D2k/B0W14vfZg7oDpAdOLWsbHQF5c1IBVs5lDgDV6duLC6/+ZO2+/j4
         KhARoESYNMb3EvgvVpQTvuOdY5chEmmA1tTrVvw+VRMWmM20MEaYAdKUACP5Ewv3ShZ9
         n2iHfT1vOENtkzO38PNbrteOwyBRUTdYF11XmJvNpVtUznoOtHs0DvSp3nI5Bu6Xq8Um
         clyyhCP5iPc9qWQcdJVTbUJFo2or7FdktAysFMZfBu6SMwu84aA9v2ue5wXIYrROatFE
         DpIOEjEcniQbJQJFfeoAg/yAnEwTUu+9GHECWUZg6rgS442omo9ZkKrG7Sz/zhwG8OwQ
         MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294831; x=1730899631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HtbxSjryw90OYXsSzx4HPo4i/eL/q8xZDQ/o/edBKU=;
        b=SKBFJVX9TjCgzfgFc0cSV7GAyN3P8aPmssb/xqKvKgk1NTvkORqbHKGrSHUK+9O09O
         wWzdFi3pzHZ+/ByX5EQhhvONf6qpxYv/WIw+Cn5JjIgFFu1Dyv+vv5ROzNM1F0QD6LLr
         5KkPecjvZgiuBzOiud9HXzcEC5QxcYWZat6GQq1y8GgKTnvasGpu3TLxA+m9mxrGlilT
         TLYF7iGVeGzSszR66Z0SOZNwLVlmrqv2JrTaaPxjQ4uL+L79jI4Et3KgzFSflfeQzUei
         kNpptKm25ecgX9mw7AgJkDCMBcBpxeWJ0pb4PVeXxVZnHW8NgQzThcxXt3D2n60UrYmn
         OmCA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5I39te3YKg6pr9bcSLidO8/SwABbaRx/AoB6sW3OafgMPFQw1xCfEdP2QPcf3iruc+OV9zmEwfwN2HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUyHfW6b/IR9dap4RO1TGe7RroE6IuaeJr1pw0hqaIcp0c8Ja
	7RVepq0Wy8O9/HldoAnotYtqqha0AOVtCVQtvpHMYGNGc1q179h1mlWxXbLTMjQ=
X-Google-Smtp-Source: AGHT+IGNnCF/FyNFK8tuf24boPmjQ1iWz91QATCHGLGVRRgZ9UV9vllz/ZNEqKzDBnkV52IH5/GP6w==
X-Received: by 2002:a17:906:c112:b0:a9a:26c9:ac14 with SMTP id a640c23a62f3a-a9de5d6ed92mr1556299966b.1.1730294831015;
        Wed, 30 Oct 2024 06:27:11 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbde87sm566397766b.23.2024.10.30.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:27:10 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:27:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
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
Message-ID: <ZyI0LTV2YgC4CGfW@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>

On Wed 30-10-24 15:51:00, Gutierrez Asier wrote:
> 
> 
> On 10/30/2024 11:38 AM, Michal Hocko wrote:
> > On Wed 30-10-24 16:33:08, gutierrez.asier@huawei-partners.com wrote:
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Currently THP modes are set globally. It can be an overkill if only some
> >> specific app/set of apps need to get benefits from THP usage. Moreover, various
> >> apps might need different THP settings. Here we propose a cgroup-based THP
> >> control mechanism.
> >>
> >> THP interface is added to memory cgroup subsystem. Existing global THP control
> >> semantics is supported for backward compatibility. When THP modes are set
> >> globally all the changes are propagated to memory cgroups. However, when a
> >> particular cgroup changes its THP policy, the global THP policy in sysfs remains
> >> the same.
> > 
> > Do you have any specific examples where this would be benefitial?
> 
> Now we're mostly focused on database scenarios (MySQL, Redis).  

That seems to be more process than workload oriented. Why the existing
per-process tuning doesn't work?

[...]
> >> Child cgroups inherit THP settings from parent cgroup upon creation. Particular
> >> cgroup mode changes aren't propagated to child cgroups.
> > 
> > So this breaks hierarchical property, doesn't it? In other words if a
> > parent cgroup would like to enforce a certain policy to all descendants
> > then this is not really possible. 
> 
> The first idea was to have some flexibility when changing THP policies. 
> 
> I will submit a new patch set which will enforce the cgroup hierarchy and change all
> the children recursively.

What is the expected semantics then?
-- 
Michal Hocko
SUSE Labs

