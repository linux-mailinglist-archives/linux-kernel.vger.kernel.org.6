Return-Path: <linux-kernel+bounces-369747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7A9A221F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A56B2574D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF21DD0FE;
	Thu, 17 Oct 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OfuWY1fx"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46B1DA0E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167693; cv=none; b=o87j1Jcu1t7D5n6yrjVsBaYHgxoUms0Mvv1KcC3hI2z1V+1Yf8a+bSIiWyxlK/tcSZMGUQoMs0SE0fJNvyihrCg6L9aHRBKpyElWe9S5f1hfcTv2T8NhX8bMM84FWA3JfX+TY74BTmQBULTTVuj/jVcn3oOXXWQVqGZAjpOy4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167693; c=relaxed/simple;
	bh=dZiXlD5sbB2j6jzh26ifCQe+UHqF9fZSmuz2zam6EZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiwVmOVU9xF2fQYXLSof6tRho7HIkSxvNjxVu/o7BFhREQGTIpp/ji9WJlKXY3YdMortsJjywWdim1kGkGKvADeHeNnaGymDt0HTE6vgBwz9nYspqyNSKV62ro4cyowl5zj4BOlU9SB02VNGZgmHVxwg/oT+p/xmP44v5+omVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OfuWY1fx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so1069860a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729167686; x=1729772486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upV9IxmbyLh24y5KvmoZk8IuzsVT/v4PISDDNTLkG6M=;
        b=OfuWY1fxb7KBr/PsajSOdYJSb2WYTVh4Bk+hg+/Dw70NMkYlSZ81jCaC/SoVhumcQ4
         cSe/kOkWUkBbgf61Q/LAbRQeLzBJ1Z8fr5uyoUG5oKqBaDza6UVDR4EMKrDQimGG1wOE
         a7prgsmTAy3wua8BQ8HlQfMBH4nSPayaEXt3hgfoRcqAtjcWtiKvu3rOGWmDTgk3RkTx
         0405CPDrKuOyuNd+zKvKEMykc3K5F3LlFp1Tf5uwwngNFxEqBioPVR0f8T0gauH7sOx+
         2nfzOs9U/SiBR1UFTofM3XDZ5CXx7H74fN5RkwR0Rjo+CuPWvEiEc6SlGkZ7KVTV+oPZ
         D+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729167686; x=1729772486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upV9IxmbyLh24y5KvmoZk8IuzsVT/v4PISDDNTLkG6M=;
        b=PXdU4h/zQASD1wW/PoLmuC8zLvOTykyJ+gCBSU3s44tQKx7GLdUKLcqLASYQ+2Jfn3
         PitoFCdS59EXwxXZA8kEa3n8BZdTuljsC/gBZJ4jgpH/8TV/yGC8ueNYV4TabzlByZLy
         wxhTiWNhfL3have0XmE/xyMb8i5/dnqOFM53Ubr4el/4ZJfKsg/9TVxtsZjh+ENSPGan
         zxEnm6Z/3XrMDOa5/mo4Y9gFWfMnj1oS0B1jYa3EtVpQ7gG5v3SCnIu5yN+gOPRJtgkI
         BMav8IkAoAPgH3r79YR6h/OmiL/oLB18l3Gx9+7+PvM1lYMrraE7/9tiYO3orT4OHbCu
         XYtw==
X-Forwarded-Encrypted: i=1; AJvYcCWODq4cfIEVTOtyTdTgLmX6dRkL84Rw+6gMXAo4MSG+rb3NpCP0y5Co+oHB+kR+XJ9r2Bup+fQJI+V/ppg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6wqk7XQTcJMUMDXV2EcwHeFKU5wzaWuc3cR3gmyvvS4KEpch
	9Tj7S+nkwxZngSCi4BJEi3pWeTro/DNakrh8FQVKEPXuSBwCQWswkG284yKNr9M=
X-Google-Smtp-Source: AGHT+IGq5ucbFHU1tVBUcI+q8DDYTzRsfdUSa7DEcY8Ig4Lc722w45PjwM12vp8ybtkKQFy10/mN6g==
X-Received: by 2002:a05:6402:13cd:b0:5c9:3fe:c7b9 with SMTP id 4fb4d7f45d1cf-5c994e6dfd2mr5839341a12.0.1729167686207;
        Thu, 17 Oct 2024 05:21:26 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d5077e6sm2733482a12.48.2024.10.17.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:21:25 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:21:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <ZxEBRd0jEtVEGWki@tiehlicka>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
 <ghebtxz4xazx57nnujk6dw2qmskyc5fffaxuqk2oip7k2w2wuf@grnsquoevact>
 <315d4258-ea96-4008-8781-9205f41cec6c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315d4258-ea96-4008-8781-9205f41cec6c@arm.com>

On Tue 15-10-24 11:55:26, Ryan Roberts wrote:
> On 14/10/2024 20:59, Shakeel Butt wrote:
> > On Mon, Oct 14, 2024 at 11:58:10AM GMT, Ryan Roberts wrote:
> >> Previously the seq_buf used for accumulating the memory.stat output was
> >> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> >> If 4K is enough on a 4K page system, then it should also be enough on a
> >> 64K page system, so we can save 60K om the static buffer used in
> >> mem_cgroup_print_oom_meminfo(). Let's make it so.
> >>
> >> This also has the beneficial side effect of removing a place in the code
> >> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> >> quest towards supporting boot-time page size selection.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > 
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks Shakeel and Johannes, for the acks. Given this patch is totally
> independent, I'll plan to resubmit it on its own and hopefully we can get it in
> independently of the rest of the series.

Yes, this makes sense independent on the whole series. 

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs

