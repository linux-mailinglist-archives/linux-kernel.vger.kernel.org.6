Return-Path: <linux-kernel+bounces-309757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78096701E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0910D1C21747
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDE1E52D;
	Sat, 31 Aug 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYxFf9Wc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128C29B0
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089572; cv=none; b=triAsmg0c8hcHZb/OFSSKtaOxe2S6DNsCBL7x24PRhcN9gUmYIKY5roEfHx0kjX/qN8gPQpf4Y/ft566DSnPxUoFsgX1KpxOSvNDTi9BSY0YwhnwPv23YCvBq/OiTC2o3L0VMtIF/gWLbkUB4ViXScY+dwytFa5J6+iYeJx1Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089572; c=relaxed/simple;
	bh=HZ0ybC8pX2XgQuC0gj0GbmtuX/ZZdUeCFQ1FnNhn0vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYMsBS5VHfrayGAraEsQUb6MZkxHD3kdoUJdPBWagpkJI2co37KPkT6O/b1ELiPy8VTnHKO2ADHlL+F0DsBMtDFFX33bfurm+NgQhgyxX/hqZwA/ssbUfv3L8kZijgj+a31SLBi3Qpg1lGkIVppxb/CN6PwuI80GYXjo7zF4ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYxFf9Wc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5343e75c642so3416621e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725089569; x=1725694369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS8ULx5Wy3Uin8uMU+jA2lsKZWXO0jfHJrS2BmvfGak=;
        b=qYxFf9WcNWTZfbf+QTzd49Mb2tR7NS12ya/QTReoJm4v/HZ5+gTLzBtff64kHqFIMy
         cUKPrsDPpC7YwnB24dNsDhghkKycuXtgRlO8Q7ls7rYCTP4ngPkAP8HVgJoXhwQOP9xe
         FiAR0DAqBgCD3EZkDTfu/bJFMbyE7xY5tbjQEd8OMm8Z+ftyLJIcRltoYYO2A0uBAm8U
         0N1fWKC8EM+keNtcUSJFC3NFivxpNoCm+Fm7Ot677xCtkrF05YlD3p+P/hIk+27Vy/FO
         aMqiT5mXIJyMDj9DYRmPjAPDvIT26zSgYIVu+6kleUbuKaaG35zWB1PHUA9Qn8A3n6YN
         8BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725089569; x=1725694369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS8ULx5Wy3Uin8uMU+jA2lsKZWXO0jfHJrS2BmvfGak=;
        b=P1+Jp0hHzAQ75IeuV0bBT4VCObxomsRsDDD2KmAs7uDzsEg9Hj8uTf/Aas95mBKraL
         t2tPTzFRd0nCP+nfUzPBs0eZL7jBGPRRhUU0g6fzjWlc3KWDJ8/JuA53/8LxCaZpEYJj
         dGyGOJaH3qKiFBy4h47ORwa7XRs2i0FacZKJFurj93YIOo7+Iw9bGG1RbFb1n6enO+tT
         AzNllyFZX57aV8DBpxPEHv8Grsc3zW9+uHRkzcaasbxbLAdoldZHqohKHCWFLULZzkDB
         zSGPCtuRisVS5WewKKivZaml7E82JS6CYgiiW76faZNwybQeBvEMB7H93nJBdCUpDxkN
         cIvA==
X-Forwarded-Encrypted: i=1; AJvYcCV+xZjKdK16hRXeIVk2fdv98o14o1Yjh8rjAiRQma96OFn/wOrxXra+Rc2nIKco5n/bC7hbJMuB/ejzJPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhFeBGU0ZWl1wTVxpP4j43uRoz1BOFYWMyPGsy4e8bSbm9cFL
	fcpsugRbhVARDswWEEmwQcpw1ytkjc0KTn++CrxjMn3xXlOnYDxdyl+SzKtixRA=
X-Google-Smtp-Source: AGHT+IHSwIZuGkOF6avHB4MdTpBlMLY/846/wnZaz9dipDFZweWYq6Dgrc9xbu2b5L3gvviZCMkIRQ==
X-Received: by 2002:a05:6512:b26:b0:530:ab68:25e6 with SMTP id 2adb3069b0e04-53546ba080amr3149891e87.48.1725089568293;
        Sat, 31 Aug 2024 00:32:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540840badsm881573e87.185.2024.08.31.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 00:32:47 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:32:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, swboyd@chromium.org, dianders@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/msm: register a fault handler for display mmu
 faults
Message-ID: <4nryt4ujiefvf4xikundjlynt7bpv76qffobczm7j3s6u5qrwz@7p5gqnhy37kz>
References: <20240628214848.4075651-1-quic_abhinavk@quicinc.com>
 <20240628214848.4075651-2-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628214848.4075651-2-quic_abhinavk@quicinc.com>

On Fri, Jun 28, 2024 at 02:48:43PM GMT, Abhinav Kumar wrote:
> In preparation to register a iommu fault handler for display
> related modules, register a fault handler for the backing
> mmu object of msm_kms.
> 
> Currently, the fault handler only captures the display snapshot
> but we can expand this later if more information needs to be
> added to debug display mmu faults.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

