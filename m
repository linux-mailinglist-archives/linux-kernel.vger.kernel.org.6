Return-Path: <linux-kernel+bounces-408687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7D9C8250
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D62BB22B86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27761E884D;
	Thu, 14 Nov 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DZlzHfUp"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E11817
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731561116; cv=none; b=k8JbuwwkkgfY79zLMR4WNVeYVq5oaCnv2UHuHBIpo5IDBcApEpR5x+KCJzRYVVA+sgvCAXgmKNCaik/ya417Y0mKaTTScsIUo5/dQ3Ut5iZj/iEQ5QFsVQGpo6StlSK67JY0/B10dUbjUplFX4kbVv5O47JiCQDUAj9rVq7wcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731561116; c=relaxed/simple;
	bh=c3dcKoL4WLruIcooV2HPhh0m8G1xsVHw+IHF3MibMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwmhkW1W8gH5uxGMBQRxzsvF4+b6Rcu/zHPcIgrbk3JaaokaxwLnOmHt41H4tjVYD+pHW4/4Vp8oXDvEiq6EhZC0ArcLAFVXWPhWBW2k2vFcETKZnevKXdoKzj5Ym9RV6Z6AzJMyiFaPV3YrDXZDp1TX+JJsCHE58DufT33yKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DZlzHfUp; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d525be53eso115090e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1731561111; x=1732165911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3dcKoL4WLruIcooV2HPhh0m8G1xsVHw+IHF3MibMAg=;
        b=DZlzHfUpS2ijcOVdCGdwrfuzJBAdPqi3YVz21iT34wPYCpfiE8acrckyzP1Kxwwdkx
         dUGI3CDlrq9yWFJ2M2G1xx0sdNtRLMwzKIffeoubY1+9krJW8oDgS9ljzoegoSYMrpJs
         gKtjI8YWWW/k8O+Ue/AkNCCAw5zhFyCe29tl28ZvOjpBIvwfnRSwVukgWgZyHWHT2uva
         ORjxzl/Qrq5VFK6Ih/7GxlPAKRr4Uvq93VBzZEpRWJbtrZNMrKMsrjWyPNqalKo8ymbN
         TxaDin2gyR2t/cQ/+OE1R06nes1VmcjDLw8Di3bIY4WE9qD5s9SW5lq9XbCplvJJ+SMU
         MZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731561111; x=1732165911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3dcKoL4WLruIcooV2HPhh0m8G1xsVHw+IHF3MibMAg=;
        b=abLl+wrABvb9T19o+x5ItPrRuAScsxynPviSx8WssnmmsXM8N4maAt9xm/V9joEbNA
         Iws5ONsw7wehRP43An6GaSKBFgMn8L2BDX324iyglB8jBpIbuP72oaMa3BfyIImri5Yr
         35OzSldCDtaJtzXfbIRHEnQCZpCIksM8cdNY7dhmA02z5l0QLT5XdZnEY3w7JvqI29YK
         OG5bTGC1+mVzKEdgqowXawsivRAKsu8z/5uqDsvZYwGY8uouHbrh/24XCkPo7/GqsgTF
         yK19XzN01fKyjU/YD1ABd5VOI0RTYBjo+8PIXWgFGmOg+B/cXRt/cpdAqqKCEkIb/1Rk
         es4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJyK2lHhFL28xFB0hRtncyU0chawdTTCqk+AcPSHTa/vQ6Ik9Zs6m0f9BxHJ8NuJzmUVXr55WeT55nyT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepZVEl3DFLd078X/c4jF//czcCkkN9/kjJ7m7g5cTJZtQRZH+
	5m5+X0uXyRUECfrMg4ewACPW7gOC3lkbA58gE+sjPVfDohf8yLTusOU829Pn/U0=
X-Google-Smtp-Source: AGHT+IFZ4DfAibLftq1VV4x/hGd1Ryn4sDGwR8BGeWjB+nopbPLzJbUpHSkdTXZpWmAsl6A62+QQpQ==
X-Received: by 2002:a05:6122:1797:b0:50f:fe39:a508 with SMTP id 71dfb90a1353d-51454328779mr6314099e0c.11.1731561111549;
        Wed, 13 Nov 2024 21:11:51 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9e9824sm1505441cf.26.2024.11.13.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 21:11:50 -0800 (PST)
Date: Thu, 14 Nov 2024 00:11:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Message-ID: <20241114051149.GC1564047@cmpxchg.org>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana P wrote:
> So my question was, can we prevent the migration to a different cpu
> by relinquishing the mutex lock after this conditional

Holding the mutex doesn't prevent preemption/migration.

