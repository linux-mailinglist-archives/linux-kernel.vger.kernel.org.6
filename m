Return-Path: <linux-kernel+bounces-232302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9959F91A689
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E306B1F26A05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDA1591E3;
	Thu, 27 Jun 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CdeiiqH0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AD13DB99
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491299; cv=none; b=d17pE1zyljDYiuB5b6tNJW3GoH9Iz5BWkxvA6nVrVDKU1P90oTORfta6LpE77WIEbWRjnl8Hd1oAx8TCZ3LJb7DvaxkilPHAEN7VUc8hgBg2TJSiuTgogygMeG4oh8prtVKJv2cFMmU8v8RvVxpA0WWuFLNRgTbMOfvOFLImQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491299; c=relaxed/simple;
	bh=tFSN4W00mTqYFY0cLVQAkN5HTKo5FawBcqjCBOjFEJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiF3p3P5ZuJeUVAHLrmuAmWf3Hj9onO3AS0go5ohrdrcW14kbNNRGPvHRjHjxBr5CFZVRFhbaomIoFY4P+6LKMu38HupTZPegwcEFF4bXKnlItJoSFqCkvryW8cegDdQjeyqwCAI1xuTJxhYxb0k42jHJUzGoEFbZoKy4sY7G44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CdeiiqH0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72477a60fbso609296766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719491295; x=1720096095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vxkmg7koMpVkTe5+wfSB7VkyONJOg6GFCymB0A2Rt40=;
        b=CdeiiqH0T/6zAJhNJUL5zvkNzyIS1cp7uvUXNd7NYteY3oULliHaddYsHxkbHja6bv
         ATSqW3nx4BCc6zBDJLddXh1ZD6k6DG1DpnfGX58zdZibY7lmo336NQBTO9wXsx7DhbFF
         ZE8nRZq+HNlmJsedVziyzS84RD9z2XpTNIPeaVrPqwQA4gfbDtmFppYFHoT1KmidS5yb
         snAo6nENrNzr0x/ENh8y8AxOAd3zODkbSbdYCiJ53SDzqRtdlkJwoqWsBGgDF69DiLOd
         64NwuDywNqsSW8J0uOVccLZ70og6fd9ru4W4pYGb3q47eafqpKjHBc7JjQkGs67N7LNe
         XoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719491295; x=1720096095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vxkmg7koMpVkTe5+wfSB7VkyONJOg6GFCymB0A2Rt40=;
        b=NDTcCpNtvBAEHnRzDe4mzDY0rkv1PCeN6/1OJcDM8qImUAJRKEiOYaDMHUargHMOro
         8Dflv/zO52WiJqZ/NkDJUEd5XgzinmXClsey7+BFVEFOdA5/B9ZNfcHp8J7pTpA+TfRr
         22vy6jTTN8oThAicmD62fSuQRo3CgkRMMlsMxYwV1y0mB8MKnZWUnzH1FGNo09iI2H10
         LCptzTdwX3TDk5JY7F52Xd3wC9BI/aX3vZ/B5Awq8NIiw1JQshcCPZedhmjaG6xa7WGA
         ni8/ShAhTliMCaN2vrxI+AjOp9VU0KrL65v1Xh8Z0V8W7Q4Dyl7G8lMEqrFSetBGM08K
         VxpA==
X-Forwarded-Encrypted: i=1; AJvYcCWDo4i95P6gzQL57EZWtubikYrDC3pOUske3XfGeIWUAqhtifC/wQYVVmZuq7H5NHKR1iGeTAlL3YCWONk495ahYZ3HsbngbCeND4ES
X-Gm-Message-State: AOJu0YxbF2SL74suQBno5jtvU+x22BmzQ5kKqVuRh4rEVkJbzRMCLsaa
	KmlHbc0YN+rtsNniqBPtDLIvvj5mw8jDjLu8uISG6KfCuimj6SmlrYjtAn9UCEc=
X-Google-Smtp-Source: AGHT+IGurxJJATpwG7EtHwaW+klVG1VvQC7DA3L5X2NUxWOPqVPzSQ1ALQgjTQrj+u7r+BbIuVGiNQ==
X-Received: by 2002:a17:906:c0c1:b0:a6f:b5ff:a6eb with SMTP id a640c23a62f3a-a7245b8f013mr917042766b.24.1719491294602;
        Thu, 27 Jun 2024 05:28:14 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7c9ad6sm54586966b.209.2024.06.27.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:28:14 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:28:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn1a3RoRFMWK4XnL@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>
 <Zn1Tg6_9NyxJE7Tk@tiehlicka>
 <CAJD7tkb9-qzYGOMHu1DfCSsWmRfCuK5Vi3NBmTz6d-dvaeAAtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb9-qzYGOMHu1DfCSsWmRfCuK5Vi3NBmTz6d-dvaeAAtw@mail.gmail.com>

On Thu 27-06-24 05:00:18, Yosry Ahmed wrote:
> On Thu, Jun 27, 2024 at 4:56 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 27-06-24 04:33:50, Yosry Ahmed wrote:
> > > On Thu, Jun 27, 2024 at 12:13 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> > > > > Both the end of memory_stat_format() and memcg_stat_format() will call
> > > > > WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> > > > > is the only caller of memcg_stat_format(), when memcg is on the default
> > > > > hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> > > > > the reduntant one.
> > > >
> > > > Shouldn't we rather remove both? Are they giving us anything useful
> > > > actually? Would a simpl pr_warn be sufficient? Afterall all we care
> > > > about is to learn that we need to grow the buffer size because our stats
> > > > do not fit anymore. It is not really important whether that is an OOM or
> > > > cgroupfs interface path.
> > >
> > > Is it possible for userspace readers to break if the stats are
> > > incomplete?
> >
> > They will certainly get an imprecise picture. Sufficient to break I
> > dunno.
> 
> If some stats go completely missing and a parser expects them to
> always be there, I think they may break.

If they break, we will eventually learn about that with or without
warning. It is true that WARN* is so vocal that people/tooling might
just report that even without breakage but that to me sounds like
abusing WARNING. There were times when this was not a big deal but now
when WARN* are getting CVEs because panic_on_warn this useful debugging
tool has become a new BUG on.

-- 
Michal Hocko
SUSE Labs

