Return-Path: <linux-kernel+bounces-312336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C496951F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA70284D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21990201244;
	Tue,  3 Sep 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbqxNpYX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F420011C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347916; cv=none; b=QSO07ht+9kH1HOVweDkQ82UhX0t+9jgJ1BpRCmCcyt9E+aLVEg6Fu/G1wtxKJDM1wijGzSX8I6HZuh+LBJh7EEtbaqKQgUXRReFphC3uS8aFctGKF7nPTEEoIjrj9C9ueAPgbmLp9a7M+3yk80vAJ9GtcRwYKWX5VuMuvaMfAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347916; c=relaxed/simple;
	bh=9R2R23jf1PEhDM/oJgEjpe7S91A3RSK2laatLt/3BHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lycOxI7ZWVghPmakHea8lTEy3UssnarQMJZ1fBtE32k3DStKdc9DOPe7ke1GWif4r6+1gdDyaVTq2d/1sPJvlgBfmpPAqkGk9TPkaBoKPGywfr9SyFJc8DZ70iBQWeOkVemfX5sNaA6UQmh6jqqRTXJJM176al2wc87X0REeXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbqxNpYX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1082267a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725347913; x=1725952713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O1FUH7RDqc8uXX+mkPWVfnuu8rhsu2/+E91M6Uiz5sw=;
        b=GbqxNpYXi1cmt8b83A2CBRCxMzulZeHIhgBRL+89rvCk3c5rJCOctv2ncTyyE5sK05
         kLPLh+Gv26bsu2x3vkSaYffcg3NNMaIWQ+Puok5H9rrs6Mw6ppmiu1p18tShSU/LRXCe
         onvuuzfFY4kteuNPAP4Ome5pWQaTG/w/XFf3nim8sqmq3LHJY45g5uDta6Ld+QAKslu9
         48hpPzaWEapYbIgj/S4xQ8oyVhrkRSH7E2/8K5XAQQNl2LisT94VHWeLP445XB5rYvGD
         Qk5/xn8zok2BwqI46PeubcsAiSQQ5Vup6s9+37Wi/wKnGnXqiWFCAoRZ1U/c9gCLfLtK
         HK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347913; x=1725952713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1FUH7RDqc8uXX+mkPWVfnuu8rhsu2/+E91M6Uiz5sw=;
        b=fUqeL7zfvusTcjL9kkhcgwTbGDc8bmlv822kAmgUuUpZ0KDy3fZ8jrf9J1Mu5az9E4
         6qC9yjjZC8N3YTU/OJ7KrHlKMDCfSvs2kMxkpAoI2674qkkK7xSabKTIR/noztC7JWwK
         Kkr7EExXIS8MRWxY4wy4XX29ooPRFO7zPb3M354Z3fnOkgPp6/vyP8e4sWIJ33gVi2p8
         a9p7t2jmgK6T5eDNnjo3MD6NTF7CbiIdJVY+8YbkSfGXWq2LztHyenT2tqAmR//astjN
         HcAbLFcFXCkSoKAnv8Jhivg9nBuOvcPdHicDrBxUmBFTtUoWGHjrc+foP4XB8b/FwDR2
         BaWA==
X-Forwarded-Encrypted: i=1; AJvYcCV5dIBz+Hik4T8Y5AqFLgnwQ6WZEzj03baRae0EWzyIYcoV+rF6J7mV8N/eHIjugK8gHPBoQfQ9pkAzC/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsNJfgMFF+GVrVEsTtQ6zPcQZe4HvjyBiFxLkLF5yTTpxMqHp
	i+qoP6HwK8TGvOdub36cUvvaYCJD91QTJ4TBzjpOKs2+7DHiHHGABY1ZHpv4sB4=
X-Google-Smtp-Source: AGHT+IH7o8OBuxsYo0So55zp2XL6wxWiUBp8CJS3P4zLH8eKh+LWdli7JkGefznOKzzc3ienqUEupQ==
X-Received: by 2002:a05:6402:5186:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c2200de37dmr16495409a12.2.1725347912777;
        Tue, 03 Sep 2024 00:18:32 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm2703971a12.79.2024.09.03.00.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:18:32 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:18:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <Zta4R1FQGcXPDLk6@tiehlicka>
References: <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
 <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>

On Tue 03-09-24 14:34:05, Yafang Shao wrote:
> On Mon, Sep 2, 2024 at 5:09 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 02-09-24 17:01:12, Yafang Shao wrote:
> > > > I really do not see why GFP_NOFAIL should be any special in this
> > > > specific case.
> > >
> > > I believe there's no way to stop it from looping, even if you
> > > implement a sophisticated user space OOM killer. ;)
> >
> > User space OOM killer should be helping to replenish a free memory and
> > we have some heuristics to help NOFAIL users out with some portion of
> > memory reserves already IIRC. So we do already give them some special
> > treatment in the page allocator path. Not so much in the reclaim path.
> 
> When setting GFP_NOFAIL, it's important to not only enable direct
> reclaim but also the OOM killer. In scenarios where swap is off and
> there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
> result in an infinite loop. In other words, GFP_NOFAIL should not be
> used with GFP_NOFS. Unfortunately, many call sites do combine them.

This is the case with GFP_NOFS on its own already. NOFAIL is no
different and both will be looping for ever. We heavily rely on kswapd
or other GFP_KERNEL's direct reclaim to allow for forward progress.

Unfortunatelly we haven't really found a better way to deal with NOFS
only/predominant workloads.

-- 
Michal Hocko
SUSE Labs

