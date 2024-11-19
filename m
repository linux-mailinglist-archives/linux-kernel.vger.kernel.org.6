Return-Path: <linux-kernel+bounces-413993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3539D2194
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1B1F22A13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB997158870;
	Tue, 19 Nov 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Da4alwdR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A3157472
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004960; cv=none; b=EAJTce5yE4MhaEH1fTa61a7A0vwzDvm0G+viV0FAa+9TZGe89q7ZTiepfa3rx5iV6yEXMRMoANbNPUdoPNoiYwm5zrZSHraOg55rbl2lLZkq4C+RlqVIohA6w3zZPvCDSHVKblzDwZ2SIX1DiNNELpfxgUarT46ep9cfevyBnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004960; c=relaxed/simple;
	bh=bJDNNakkOymO9UdeCGUCR1wRhNYK1cwKNsqVhZJe8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFTlmHEzWccJ6ofG8LSqxtqCyfbU+upbHCkOGkpPTpWHdqMYlrxd4P6VV09aC1B96zNrs3ybNi+W8/jy4QAr7slFRAYD+yIhHv4ys5p0e+9c2Lt1F+L+youWQ9W6A/xjihFEHpTxnTAxYSGpFWBUadq4MW/jssrgWv5FPLQFETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Da4alwdR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa4d257eb68so28817466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732004957; x=1732609757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jH4xv+sR4Al/gOR3OXvEI7SwC+hrXa/pJ8uLUM/+9U=;
        b=Da4alwdRhs/cq/tWnxPCOytcmmskj3O0QqbjaxrERQXO3Qr2a7i39eBXgjtAZal4nc
         QlQYoN/qXf56pzLSuRU2+I6p0jJFXmreqlKW+JoObSC8LCQwNQLSPo9EleGg8uyUzf7+
         HZXgWbCPHUTvUM0dLcGCzCySGhanDg6mI/ifZtfaLbiYTyIvRDQyaNnxIHvsFh4ILD//
         JhAPbiEwb1WXm2h4ln5YtFmFfUFE+ZGgIlftdiFeIRvx9TQNoHAgujc4VM2Ltn0JpqrY
         3amjLNy9H5ZyBGusfosPiKoxaR+0rJSCbC57aQGJkMNxSD12w4vb5x20NcXy9IfUxlT1
         HIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004957; x=1732609757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jH4xv+sR4Al/gOR3OXvEI7SwC+hrXa/pJ8uLUM/+9U=;
        b=cgwBrUXDo8EC1nbE+L+z4OtntWjuthA0MlWyGOdYAPqBEanJpQiHzqIXBa/vgzo6cn
         EgFhG2RCAUd0tsDU+bNAZHxF3nzl5e1zfAhTaUAg2yZs8pVnwDS6YWrtSU99MWcoNAJQ
         M8L1Fq1R6PgmiiPd5anl2THWsiauoqM8HgCxOZqQF52I/WtZvPO4BTL3j1GNcQdZzggq
         y2iqrlCoLrUOLBArOpNPIQpKe+DRD7lfABjG1UcaNjU4M7OZwdqnBS3EANdBcMt3wI1q
         yvO/gegjeSyNJpNpT3aoKdrqkYWYDKxORYwU2IT05Cb/NNPjEWJEVtr753fyTQkuthbA
         bBlw==
X-Forwarded-Encrypted: i=1; AJvYcCUSkZQKD+I6Hu6Nn4FDrGU91ovzSsSjyL5NCi94Mu89kCDtZOgCQhHlJ3GTKZWUHFTvnsw78IbCNd0nZ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8br5hfLyJhTRRsWTShOG01+Vzq9YTeD8TtM8yG64lmGY6PoGY
	Mk59gwtpT7L+8mIDq42rFvLCuTPbMfDXRvPF3Ra1dxFXcUfPWVhGjWO/TvVSj6k=
X-Google-Smtp-Source: AGHT+IEaZYns8YIqU8fVZizD6+A1wmyvYG60rg1tB1S9LYpkKleiNedOiGTxf1SR/nyQ4V3LKUmHkA==
X-Received: by 2002:a17:907:7f0e:b0:aa2:be2:f1d1 with SMTP id a640c23a62f3a-aa4c7e17d55mr213141166b.10.1732004956734;
        Tue, 19 Nov 2024 00:29:16 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046afdsm622185266b.163.2024.11.19.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:29:16 -0800 (PST)
Date: Tue, 19 Nov 2024 09:29:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Question about vmalloc(GFP_NOFS)
Message-ID: <ZzxMW-AzPY7C27_L@tiehlicka>
References: <112f93f3-455a-4b89-94c9-d12844d972ef@virtuozzo.com>
 <377a6aef-46a7-4492-a44f-b2a46869a9d0@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377a6aef-46a7-4492-a44f-b2a46869a9d0@virtuozzo.com>

On Tue 19-11-24 15:24:03, Pavel Tikhomirov wrote:
[...]
> In commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc") we
> add implicit memalloc_noXX_save/memalloc_noXX_restore at this code path:
> 
>   +->kvmalloc
>     +-> ...
>       +-> __kvmalloc_node_noprof
>         +-> __vmalloc_node_range_noprof
>           +-> __vmalloc_area_node
> 
> So kvmalloc should be safe now with GFP_NOIO.

Correct.

> Should we correct the documentation?

Yes, please. I think it would be useful to explicitly name the above
commit because pre 5.17 kernels or those who haven't backported it are
still in same position and that could get dangerous if they try to
backport [k]vmalloc GFP_NOFS patches. Thanks!

-- 
Michal Hocko
SUSE Labs

