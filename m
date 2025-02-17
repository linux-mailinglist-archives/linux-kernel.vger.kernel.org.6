Return-Path: <linux-kernel+bounces-516890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752FA3795D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2DC7A1A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A414293;
	Mon, 17 Feb 2025 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lt23Kj1u"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E732C8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739754156; cv=none; b=uiqXiaPC6q7BTMPcSQjQTg7mILcMOX32sz9A246E9zVXGzgBc55KHBXZN5J8x4PaWgcW07nxKF13y7kTMO6dsOecs4EfB9svZWcXEpigF7G9bA9VD2iwKSFjt6gvYiJGW0tQd8DwDu0NrSe9bKrYxwoJIdHOhcVvBPJrIa01LEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739754156; c=relaxed/simple;
	bh=jjosS3aZUMXEedsYcOAXbzAXrH6Y/r6xI9fycqxAiRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG9zL5Nm2siqcIIyk/RQCRj8wpKo1GcaKJOp9T9bA8knWQVgSQ3hLTejvBYjUJZEQ3OvVhd04DmBsYNh3YGzC8sNsFguE0rUzpT/b45AOAkdRgH0JAqx05XRksYJplzwnsegl97hvUtRanB+3+nzznD2YbxCzDLXjr1zvE6avLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lt23Kj1u; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30762598511so37017701fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739754152; x=1740358952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmVoaUC7xmottqYOSTQwsqCPbMXfYjnNRObpBfTCAVg=;
        b=Lt23Kj1um2DEUVEo6lY7VAHgQxCgzmtmhY6jiD3/7+iaRf/Ws6cHz71BjorvCPLVPT
         in/O243syxXOU/E+2FoOnk/Q4kaa3QTC7ViWvAxfhDpe1CeVGmYGJyPTAjTOk7dbOp5t
         upD+eVdR7vyyZ88zfd6AF8QgB/uS56TTEUL+biyr5Pw72dRf7jbJBv4HVhw9bEnCUrfT
         7DMGaYI7W688AmPyAiZmRgUCKdvHXqz8kiUU5JtsyrV44RjNRDpCW2o/qmaEzgrtEobE
         EqBtHuuFsYihJYtcH0C/hF4fojACkFzjFu8Zb4McbFG0c4/d3eaId7fjbAgXhZYfNVLL
         JK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739754152; x=1740358952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmVoaUC7xmottqYOSTQwsqCPbMXfYjnNRObpBfTCAVg=;
        b=iGsSs+qJQI8m+OUfa0bkG+uNKURmPpIr4lX++fx+/g0Mi1I3lAli9Wn5L0r3pjJIFP
         /WyUdyZ4SE+69AtvF5F0AYO9GS+FagAYKJb8fsS7+GgXzcnhu1kVf/3sPbarEN/u8vtS
         RFMbUrAoPppBMYFWfHyCsNiJtauJeJDu6iJhNoV65Q7LcwYWf1mKQ75lhFs7+vBumrVu
         uhecsZl6LZLPdi3x4MfKzLP2Gg66+U2bzp1GdZB8qq31+fITRkI5fvCdfBTnfZV0mvcC
         BUr1vMRxhbzu0ZGFe/iAHo7Fxtkut4k6Da83wq7gbb+TUYtcnX5TbMfFlo/ogDiFSLH3
         9Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCXBhJWKGpGOTmgoeguZGcMNsR0NLxQH9etWuRFaw6L2sUkeHa/aAQsUV63k6J1URwFym/l85hCTsTrgP5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAfEqlb9EKj5p1x5ndm68VCFLMSkErnKaVOR8g852p8J24Fv7
	ZvpTXsR30A2Zf4lDsryd4jjMXv6JwJM7ZRWVHMyBBnleL1AZN4ASoDm8A1HE7+I=
X-Gm-Gg: ASbGncuG4S4Q7Gr1kHcxy1jcd58D3BW5tW3MR+5jPHI4qgUK7uOCif2RtkA0D03U9nh
	CBDBjUoV7SSGk63nyNS11idySVXZcMQt6CMeoFbFfzQfGd2SeK91utvTmaPzEaiP5Oe9qlTGGKj
	YYZcCa9CaR+aDBJfGvmOTcLRU1KmeCDrnVoJzkDWXbZTLBCKMqBFckz5MuFBEalUcsVYuMAs7lm
	CjjFZJIcc14Pki6Q8q8BrIZA+xHyjCDNWqecbfR2BjEhVVdFcOcMCvOpYNVA6lQvtdCjzhy63bo
	XbOUwjp6cXwZKy3NeK4fWHAXM6Ru52BrBNzgoUKjjZR7RXiNt+AsyUUeV4AofA8QS0obAx4=
X-Google-Smtp-Source: AGHT+IFPwUrmmmXBHJJnUZE4/VwGf1KAeqSIPxBvFuGYKNJVD/VttkBx++6RhfEVEpAxmgh2tIp5hA==
X-Received: by 2002:a2e:80d8:0:b0:308:f479:5684 with SMTP id 38308e7fff4ca-30927a59cf0mr22977031fa.17.1739754151764;
        Sun, 16 Feb 2025 17:02:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309298dc5eesm7625121fa.95.2025.02.16.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 17:02:30 -0800 (PST)
Date: Mon, 17 Feb 2025 03:02:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 2/7] interconnect: core: Add dynamic id allocation
 support
Message-ID: <6j576swreyqcyu7ryxtyojjmo7clfwb7fibw2aeuvif5vzexpq@du2farsldpti>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-3-quic_rlaggysh@quicinc.com>
 <bwiuhfgv4jw7tlwjqffgrxvskxbpf4forz46nn5g3vihz3z5od@w25y7hdprykf>
 <f40f6b9d-8f31-4ce6-a912-1aa484863d5e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40f6b9d-8f31-4ce6-a912-1aa484863d5e@quicinc.com>

On Sun, Feb 16, 2025 at 10:08:51PM +0530, Raviteja Laggyshetty wrote:
> 
> 
> On 2/10/2025 4:20 PM, Dmitry Baryshkov wrote:
> > On Wed, Feb 05, 2025 at 06:27:38PM +0000, Raviteja Laggyshetty wrote:
> >> The current interconnect framework relies on static IDs for node
> >> creation and registration, which limits topologies with multiple
> >> instances of the same interconnect provider. To address this, update
> >> the interconnect framework APIs icc_node_create() and icc_link_create()
> >> APIs to dynamically allocate IDs for interconnect nodes during creation.
> >> This change removes the dependency on static IDs, allowing multiple
> >> instances of the same hardware, such as EPSS L3.
> >>
> >> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >> ---
> >>  drivers/interconnect/core.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> >> index 9d5404a07e8a..40700246f1b6 100644
> >> --- a/drivers/interconnect/core.c
> >> +++ b/drivers/interconnect/core.c
> >> @@ -20,6 +20,8 @@
> >>  
> >>  #include "internal.h"
> >>  
> >> +#define ICC_DYN_ID_START 10000
> >> +
> >>  #define CREATE_TRACE_POINTS
> >>  #include "trace.h"
> >>  
> >> @@ -826,7 +828,12 @@ static struct icc_node *icc_node_create_nolock(int id)
> >>  	if (!node)
> >>  		return ERR_PTR(-ENOMEM);
> >>  
> >> -	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> >> +	/* negative id indicates dynamic id allocation */
> >> +	if (id < 0)
> > 
> > Nit: I think it might be better to add an explicit define for that and
> > to decline all other negatdive values. Please leave us some room for
> > future expansion.
> > 
> Do you mean to replace the value of ALLOC_DYN_ID from -1 to some
> positive value like 100000 and to use it as initial ID for the nodes
> requiring the dynamic allocation ? This explicit define can be used as
> check for dynamic allocation and also as argument to idr_alloc min value
> argument. Is my interpretation of the comment correct ?

No, it is not. I asked to add an explicit define for -1 in the ICC
framework and make icc_node_create_nolock() reject all other negative
values.

> 
> >> +		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
> >> +	else
> >> +		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> >> +
> >>  	if (id < 0) {
> >>  		WARN(1, "%s: couldn't get idr\n", __func__);
> >>  		kfree(node);
> >> @@ -962,6 +969,10 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
> >>  	node->avg_bw = node->init_avg;
> >>  	node->peak_bw = node->init_peak;
> >>  
> >> +	if (node->id >= ICC_DYN_ID_START)
> >> +		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> >> +					    node->name, dev_name(provider->dev));
> >> +
> >>  	if (node->avg_bw || node->peak_bw) {
> >>  		if (provider->pre_aggregate)
> >>  			provider->pre_aggregate(node);
> >> -- 
> >> 2.39.2
> >>
> > 
> 

-- 
With best wishes
Dmitry

