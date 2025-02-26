Return-Path: <linux-kernel+bounces-534983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5AA46D95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E8E188A828
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516BB25B665;
	Wed, 26 Feb 2025 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkDdi7dT"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75425A34D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605804; cv=none; b=JkazOhUejEZJaF8LSa2NLE8FYC7bqfU6URpBHKJwCIG/mQeZ4nL92EixWDacGRL3nEjYytMFAfGRXNvGVLzqtQNKlwiNwBCoBi9M/osJkIfzOGjyhk0n7cCrj6TiNmlgKofpzEsrwrZd5+Jcd8c70AYPjkHlh3jWU1npouD52sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605804; c=relaxed/simple;
	bh=5c954FZ1IsL2zYxnLVV42fDVvzLlL/UhkP5UBwhFIrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4liix2DD1WkWyzT/Twl0kgiQ7lPkv/21JMO+qOwFivtWhVgssA8srkYt1yB+O4YQlznLOKkoc4FOMvE7qS+8eVkAiIDJEqfzEVgdAfclcLq1h6kN8wzw6PcmupUl+EXxWwF/hU73cuovtMKLzYx3ER58gGb3isFdWRqGb6xcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkDdi7dT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2212a930001so6376455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740605801; x=1741210601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J3EjXP+NiLIXMW4dRj4K5uwF3K6wA15u88DzQQtavhw=;
        b=BkDdi7dTlC+arHf/AGIf0Qt082w4RW1u4r++hgbGlhrarFED0YvZPnmuyXsB7W9z8U
         PYEZgxVlWmJrBoQewXIj9IplP3DX4YVuAxUeX261ZSrEYsgDxOs39c545T1Dw5UdtWCw
         qQJrj66LTIreTbWRJLweLxnhl8ECvkAx35wXyoSdPJ89OeXDTeE2nTNQqk3nxGy2O0uA
         QkNKBQ8w6se+EBmxBIpclaR316brpu0GN3l9ASz+D/+JNmhAZi3L8TfkilOhscI887Zc
         CtG0TV8YZwYva+WZKxy5l6plQyI/bYSane2u2K30792GhkLCxu/RvP9FK7SBURLr1T3l
         LJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605801; x=1741210601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3EjXP+NiLIXMW4dRj4K5uwF3K6wA15u88DzQQtavhw=;
        b=MMMNQnD6hRvewiWsM7M5hziBkmeCRXT9aIdxFGmI93SMJlwzIc4GapWS9dzlWZL7LL
         +W416bBgs3XwF0yA2enOWCyDA8JbDmAb838MYkYYRDSa7O7nC1ZjjXifTZeqyXM7atf7
         DmO1DopnimWY2/Zy9u3Ap6SB9ril7RE7C0855hic3Wyj+fCdXDB5lYSeL8Cb5bKjdF5Q
         WtVD3oi0VO+Zn+RLu7yAdy5Ii7uvpdbsifEMUhYq1CK2V/CBy+u5zgh8skuAludHncJa
         8Ko0buN0tuWMwrqB/N1z5IIf7rzIz1mXe3767SmsdmoDP2hNNKRi/7vbck8hLc7yWfa8
         IA+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4t+3Ma2rrvFb6RgQkUOI9IX1iHBygGBMemTcGZAVdQ6g5dW/uwLuhJdItsnNdIe2mz0v87GfK1s/Yts8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrZ6bnwfZSPWzda90K0Ovl1KUJGzvCzUrcy5A33NDzaaEAPKY
	bB0MovrQGTcf+DlsBCIFCOh+m/oyDKp/d2OQbdY62CQ5t2w7p1NldUgDtBumdQ==
X-Gm-Gg: ASbGnctNMz3PAE6RxAm69Zydmqmv+SmqQ7AgjbnI7wdaflR54EsVTl7CvMGDuRrgg5f
	0s/nb1Fp0Vc0ZQ6VKHpx26dKRL+/0JKAcjXygMSy/GthMCDEiFe9ohwL+WPP3Ql+LeePvEtLbkm
	N++L2plwIz70dj+EAxbQoo4XMLKZ71iZPGs6Q8riSp4jWZW+xNW2uB+0eRu+g6O/0Nud5bh+hjW
	k0bVqSYTFan9iI9i011uRr8dEPH8efycuxeDuFKiv20wUEq7jfP2dBVS9amw4FY1yi9UZ+WfWqK
	ZV9QF/t8B60q+beUTxWHWx3Oje2Xi0UJa32mnmBbHl/RtYh4pbYyngk5QJ43xi8Ju+rVqPsw
X-Google-Smtp-Source: AGHT+IGlj+AkHNM5ogaSILuA9Lcd5E/pZaPJQMHMy8ybuI24p8eRv0xMkCx0vWI/wdKBYp78UuaZ/g==
X-Received: by 2002:a05:6a00:1813:b0:732:6221:7180 with SMTP id d2e1a72fcca58-73426c943c4mr37186690b3a.5.1740605801093;
        Wed, 26 Feb 2025 13:36:41 -0800 (PST)
Received: from google.com (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe51432sm21196b3a.70.2025.02.26.13.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:36:40 -0800 (PST)
Date: Wed, 26 Feb 2025 13:36:35 -0800
From: William McVicker <willmcvicker@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Marc Zyngier <maz@kernel.org>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
Message-ID: <Z7-JY1jQnEVzEley@google.com>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org>
 <Z70aTw45KMqTUpBm@google.com>
 <97ac58b1-e37c-4106-b32b-74e041d7db44@quicinc.com>
 <Z74CDp6FNm9ih3Nf@google.com>
 <20250226194505.GA3407277-robh@kernel.org>
 <f81e6906-499c-4be3-a922-bcd6378768c4@icloud.com>
 <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+P=sZu6Wnqq7uEnGMnAQGNEDf_B+VgO8E8ob4RX8b=QA@mail.gmail.com>

> I thought downstream kept kernels and DTs in sync, so the dts could be
> fixed?

For Pixel the kernel and DT are in sync, but I'm not sure about other devices.
The problem in general though is now everyone would need to do a special
coordination when updating to the newer LTS version to make sure their kernel
matches the new DT.

On 02/26/2025, Rob Herring wrote:
> On Wed, Feb 26, 2025 at 2:31 PM Zijun Hu <zijun_hu@icloud.com> wrote:
> >
> > On 2025/2/27 03:45, Rob Herring wrote:
> > >> Right, I think it's already backported to the LTS kernels, but if it breaks any
> > >> in-tree users then we'd have to revert it. I just like Rob's idea to instead
> > >> change the spec for obvious reasons 🙂
> > > While if it is downstream, it doesn't exist, I'm reverting this for now.
> >
> > perhaps, it is better for us to slow down here.
> >
> > 1) This change does not break any upstream code.
> >    is there downstream code which is publicly visible and is broken by
> >    this change ?
> 
> We don't know that unless you tested every dts file. We only know that
> no one has reported an issue yet.
> 
> Even if we did test everything, there are DT's that aren't in the
> kernel tree. It's not like this downstream DT is using some
> undocumented binding or questionable things. It's a standard binding.
> 
> Every time this code is touched, it breaks. This is not even the only
> breakage right now[1].

You can find the Pixel 6/7/8/9 device trees on android.googlesource.com.
You can see for zuma based devices (Pixel 9 for example) they have this [1]:

  &reserved_memory {
        #address-cells = <2>;
        #size-cells = <1>;
        vstream: vstream {
                compatible = "shared-dma-pool";
                reusable;
                size = <0x4800000>;
                alignment = <0x0 0x00010000>;
                alloc-ranges = <0x9 0x80000000 0x80000000>,
                               <0x9 0x00000000 0x80000000>,
                               <0x8 0x80000000 0x80000000>,
                               <0x0 0x80000000 0x80000000>;
        };

I understand this code is downstream, but as a general principle we shouldn't
break backwards compatibilty.

Thanks,
Will

[1] https://android.googlesource.com/kernel/devices/google/zuma/+/refs/heads/android-gs-shusky-6.1-android16-dp/dts/gs101-dma-heap.dtsi#147

> 
> > 2) IMO, the spec may be right.
> >    The type of size is enough to express any alignment wanted.
> >    For several kernel allocators. type of 'alignment' should be the type
> >    of 'size', NOT the type of 'address'
> 
> As I said previously, it can be argued either way.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20250226115044.zw44p5dxlhy5eoni@pengutronix.de/

