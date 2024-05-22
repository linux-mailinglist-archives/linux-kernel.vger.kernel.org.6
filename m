Return-Path: <linux-kernel+bounces-185940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4828CBD18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A02815C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C967E782;
	Wed, 22 May 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcYERscd"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F37FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367125; cv=none; b=WZ7QVkTiW3TWGkApU1uQ4u//EEkMRLXKd4nT1HF+jX+E1f1aOYL1tOk80mjbFApzxsVNq67EU3FFweQ4PIY5In1JsvQQXs+XKbFEDdLgqMMiHXot7Woa3DSJny6oGkzVRFr+kc6O/X6i2V7f/jpq1qtEgcueeL0lqDLdd6lcxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367125; c=relaxed/simple;
	bh=UUF1Xl3WF/inRUVbCOLgMd/fbD1vWfQB+LFC7jXVyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFpB82fZztdklHWXV9nuEaVqrkuCk+H2SG4sC2n+QoJ7/fCPn6WXqleu1eBrdjh6a8T8h2LRrw/ezjV/BCqBMEbFnHt2Zcki0GPCeweZ4lTfBRHnwgGWqcV34P/ohSW8OB72Wx2+7Zbn/N2TDpXCLxOB7espCgxPrtM6EERiTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcYERscd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso11956a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716367122; x=1716971922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+G67b4GxIThbEafe87WEoBwf+8+QKS2G2eyvZIlV5E=;
        b=HcYERscdHmNwFiGCriBRIuSZu3R7fTkcZfYGgArgGupJaW15Hs55T5q3BYApokuC3F
         y9myIM50uMcGHo7W+8VjKbmAVcGOofKn3WqPBv1BU+VHVADhw74mO/fSSlcinAW0rWHh
         BpuIAq4E3FmpNxRe7WDV4IdBvAm281HybSwyOpvbXPcjE2ppiDGboNJ2CvEhvBrcj8ng
         hozjtqMTJvxeYTnsJlDSsT6OANXpA3WIxtUHb/9qqL1YB4MFnNuyWfduLi2nr5W/w/Pk
         OsxHh+YrTfbk8umyzztXZIGo5pX09v93VFK67xei3iUEfMhaXXPaC31S8iqrkAndcd4P
         Nf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716367122; x=1716971922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+G67b4GxIThbEafe87WEoBwf+8+QKS2G2eyvZIlV5E=;
        b=KvVLHuf0beiinae48Ir14ZAGrN+wMfMDuWeVG9BJ2OiXBzZaJDmz8P+/1Czzifl5sy
         FoVblyG4I6ek9DinCdudRXgmUaRui/sDiRqwAReXmzKm2PAfdUHqeqjgLuCJVTARF360
         gjPLi6VXwsB1i1+YfetBdOt381wNCLdg6JKtzkg93l4LcMidxGLD8FP6VCG90mfQU5D6
         uRFzEcYDbnI+sKiff8v3YwdEYaRLkODmpi9e3vfwJj5IuH9RILH/0pnrU9FZ7sEi8OyF
         j7CnMLZqetaWbUXKMF+cWLSlKp5zR6IbP2F2GJedXVFe6ySCoKYALEjgwwSwEkR+pnJO
         Qu1w==
X-Forwarded-Encrypted: i=1; AJvYcCUFZNmRGzDOLR4jR1IQUCbLghP2ZnbTCA/Vxy5sgxX2ATrRpLW84ZkPsjEh/XXMt9uf1Nnf04UyeRqkbUFBflm990dm8th99UhxULQM
X-Gm-Message-State: AOJu0YygptOdEWyzK3Aw2DJSn7rEjmnZwwaLzj7DTAAm8LXEsj/Prly9
	CUrXOuUeBsB+mgJge1gnwv0ufTfuAoAzZiJJ57JM1LB5MlOYvk12p4wtz/TZRw==
X-Google-Smtp-Source: AGHT+IHH7O6UHB3CPQsag/IvObOgeU2NNagvZ48JB2VhjbHMXHJqB6094MVSZkbPabRRQ/efkorrQQ==
X-Received: by 2002:a05:6402:2904:b0:578:33c0:f00e with SMTP id 4fb4d7f45d1cf-57833c0f3a4mr63801a12.0.1716367122156;
        Wed, 22 May 2024 01:38:42 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f1664c7dsm275885f8f.86.2024.05.22.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:38:41 -0700 (PDT)
Date: Wed, 22 May 2024 08:38:37 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
Message-ID: <Zk2vDeQ3feZ3hsf0@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
 <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>

Hi Lance, thanks for taking a look.

On Wed, May 22, 2024 at 12:25:30PM +0800, Lance Yang wrote:
> Hi Brendan,
> 
> On Tue, May 21, 2024 at 8:57 PM Brendan Jackman <jackmanb@google.com> wrote:
> > @@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
> >          */
> >         if (early_section(__pfn_to_section(page_to_pfn(page))))
> >                 zone->present_early_pages += nr_pages;
> > -       zone->present_pages += nr_pages;
> > +       WRITE_ONCE(zone->present_pages, zone->present_pages + nr_pages);
> 
> I'm not sure that using the WRITE_ONCE() wrapper would prevent load tearing
> on 'zone->present_pages', but it's probably just me overthinking it :)

Hmm.. this isn't for load-tearing, it's for store-tearing. I have a
feeling I might be missing your pont here though, can you elaborate?

I have just noticed that the original "big bad optimizing compiler"
article[1] only says store-tearing has been observed in the wild when
the value being stored can be split into immediates (i.e. is
constant). But it doesn't really seem wise to rely on that. From what
I can tell from tools/memory-model/Documentation you are really out in
the wild with unmarked accesses.

[1] https://lwn.net/Articles/793253

