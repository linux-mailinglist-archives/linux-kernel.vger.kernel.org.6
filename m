Return-Path: <linux-kernel+bounces-559992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7934A5FC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD31897FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1126A0A9;
	Thu, 13 Mar 2025 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ePgxiZE4"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27761268FE4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884128; cv=none; b=msWjkQ3mpCdCdnpeLGS63K12/WyWnfMaSyX9punDe1FU1F4eCRHBW9q5uICp3XNaFjfqQLra6V6eUK6eVuqsN6zdsi3XzEpEnlGwjtF1NgeI+aEF5vL4rfrEbtf+GwC26RqzyVkd8lniig0b/+WAQPSOclUa5Y/7+vAgOc6poiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884128; c=relaxed/simple;
	bh=HPDzCwQbaj/df6/ADC5zGbw7wwOPAh4iSEDcZas6KIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j10rml5DIPRBbeQO4W3WWFuP0mNC0Sral5YfqN6y6g3O+A16TxLWARf+sps8l5mfGocf3ZTS8x8BvZiVr6KnF8wYsHZuLQ0n5WmoEz4JsKVYIFJNxM/Vh4/hDe2Ty8pojGXDOtkz5nqF3y7i2XC23eKItEPvBrsiugo7Yb10HkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ePgxiZE4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f28172dso76372685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884126; x=1742488926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xNl+N7q/9OaetzEUva/jSWqSKwZzi+icZYg2l4BR/w=;
        b=ePgxiZE4R+c4SB8PWOTCty4MqsDCdtvABFirjXAcmiY9hmiHUTse01fRwfeCjyofpd
         sCTNXTt97Zadvs9IUA3GUX5rSi94lIJyWni20EYjrAsDQf80Dtr/SPBHQDDBNbj95OZE
         IoeHBRkdBYociSij3i23MYeY/W9K+jkZLt5hCpd7wGMfLEHekbW/H/X0jAetHWcuwQHO
         HY2EHc379OBcpkwTFZm1sT1uWNpMSuk84HJ8ea5pZ8FYuGV1LB6Klny7JLg5bYJIdvBf
         DVPpz5dpv5LXXVrI8MKJVu7ZBiF0SwlYNXThV9s2vba2foZjusGK1LMyEfr+Fh0AA7oW
         /5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884126; x=1742488926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xNl+N7q/9OaetzEUva/jSWqSKwZzi+icZYg2l4BR/w=;
        b=DEnUg+d6IqSF2ku0U3h+QD+rF2shPv5rk7JpD4ewnJ3uyZt2CAfii6qQ1fq0BHeMvF
         v7+Av8zGkTBswsiqn/KwXrVlbyvIHV+FQoEkLNKB1BgS9Yc16Aj/LQPMXgj4WpPJVSeM
         YLR2B8hCtTOO4xH2fbyneOeAxpgvfHu5ErrfSbxZRol459uYbNVEzFmis6BOJ5K12Y2F
         THuZrYtkqlYXAIof5ItApToDlTqpgQzBXnArV818Pc1Z4vD1OBBAZFTK6DyEgAjxZpxy
         Jn8lC8xUMPtwifuCuE2Ethgg4gMK2TLL/gbPB7tLePrWVwV9IvuO4KZVxDNuh43eFKru
         8C9w==
X-Forwarded-Encrypted: i=1; AJvYcCWmiM0prZNw89c28YS3Db12UA9eWmgHMJU8czFyF7QhBV3r+x64gZgHitSY17iJeMDJJpuBClDvitsS3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxaKWlCoGKA4zAgZeSbTQaooGjr/vbStQ4+SFrqslyMZjRkls
	m6eNHm5sID2DHsV6b/C70w55jcOTgmFpxL420FtKJnvhlOtx1G/5CScAt4tY5mc=
X-Gm-Gg: ASbGnctxYJiAXqmLVjXVhRK23rB3epN0uGZ20bPuyZ64/vZDMhwljvVvPZwRI046cRU
	S51CLbkQ17hqqtilH0MIJl2EDmmHjh4Ieu04hpTGEZH1i1xlDGP313PEl7aXfZhe/00aqhi7j67
	/vKZX4W+htxPn0/Vl2tKxx+OojH86qqCQCLrdcD8/G98PUqnISPEHIZpCkHQyX7sS+xu6xkbg9F
	OXK9Q1ByPGdARWVVv64z4/DlMOGCn9Pbdla3/Y6hN3nTGNf+LJfh9U+HRqvJfjdkbtr5gH5Fx1o
	HtgMU9FMF3fEhkE0BKdhoSEgnoY3d/vwDWcPMec5Meb2FxomjjwBd/kqu2LXzq5YN3psyUiG4yx
	ht122ZYxQe0K9RCJV3pDARoFtOos=
X-Google-Smtp-Source: AGHT+IHaB5FwZypTre9bnElu4UDtRtYp5sIvDPiHQLQTt/iuCUfLb7vvYamZOzrYkeW67XJ4d1mSDA==
X-Received: by 2002:a05:620a:800f:b0:7c5:467f:d131 with SMTP id af79cd13be357-7c579fa4e92mr61386685a.36.1741884125950;
        Thu, 13 Mar 2025 09:42:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9d8absm117900385a.55.2025.03.13.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:42:05 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:42:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in
 sysfs for weighted interleave
Message-ID: <Z9MK235uVDmK1oYB@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
 <20250312075628.648-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-4-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:27PM +0900, Rakie Kim wrote:
> Sysfs attributes for interleave control were registered both at initialization
> and when new nodes were detected via hotplug, leading to potential duplicates.
> 
> This patch ensures that each node is registered only once, preventing conflicts
> and redundant sysfs entries.
>

After looking more closely at patch 2, this seems to suggest we're not
understanding the OFFLINE/ONLINE events well enough to use for this
purpose.  I think this patch won't be needed once we address the
concerns in patch 2 - and more generally if we discover it is needed
this should just be rolled into patch 2 rather than kept separate.

~Gregory

