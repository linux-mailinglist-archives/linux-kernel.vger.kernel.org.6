Return-Path: <linux-kernel+bounces-213065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A11F906A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081BEB22CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E5142649;
	Thu, 13 Jun 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbYZWqlP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965D13D534
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276276; cv=none; b=SN7r9q/3HTk6zl9LNEp5iZI7KDDPP2lpgTcO+lZzKR1lFp8MZ9InDYUo64QA/aSMRan9J14jGL0zbrMkLMl+3xNlvgCT3vQGiaRCij++Tlot4QnQxmbayeRHTA4su8KBTt6zE9H81LAeiFXgG/2tFbl/394a78SSjKVgEz/4GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276276; c=relaxed/simple;
	bh=BbpVijy2wp/Kl0kxvEakExC/cp1LpghJDDlawQMWkrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZJg9Auyj6u6GPTGwItrTxYVj2Ngax18BWqk2oXdtcqUiwD88w+FP1C3ILnxkDdhOhEpoZokL0QMquQ31sCToy7ZJl0dhz1W585b9CLf0tfDysL/rGga0FPXCKejgUF/mQwk2jabzmQAtH4/arK4I7EJ5mgsYo6UdHSRHAmpebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MbYZWqlP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c9034860dso1113399e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718276273; x=1718881073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjOhHNOacsMW4MB4hjQYhSrZ5af1JEJEzNmI8PwgHzg=;
        b=MbYZWqlPy1WXZhADf/AOT+dlzWGsuN8l8t8OgtuDw23m0WGLxT7vbhxX1P+xekN1LH
         FPP8QSObs5ak5IWfJEBJn1vIWuO2ZMiaanXNmEHXUwAvqhkDRLJtTHDCRn2+yU7YaQOp
         g4kZU6Q8RwzjSW9Z7Z5tgXR5f3jcRQHVdpYvAiPW6rCNFeu0XvNFLuWykOln9JaHtYXo
         cK90s+zu8VnBYpDvwLw+To7t87Yuj37/XMHevjABgVOMT/4nmmwzx8yh3DYnKOaGLX4E
         nZeCVTAD5nHaW8MtqKP4gh4abRUmlH0Wv5Iv8KzNBbyKOLDVxbANdHLjSrQ/lRZtO/LJ
         ZU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718276273; x=1718881073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjOhHNOacsMW4MB4hjQYhSrZ5af1JEJEzNmI8PwgHzg=;
        b=esB8ms2rsc33h+x9Z5xNeCLEg7qS7Wcwr/OrD0Aj5uPLTI3WW+KhNTSF90clEh6EsY
         hJV04tavGRRBjSf0+2pKTQKJPxRBp+jJpQaAC9/x44t7Jzb85/J892Pb2SztVDQrjUvV
         p9lkteq5vz+dQ8t5l6k/fWnbRqsIhCbo0j/HnUbf1/XW4W9SPkBplB3Zz4R/mdaLrwt0
         EyvloSGn7mxoSvFoAYitYI3BoSju1YHmSZrMJMNCoHvJKwvqIQA/gt7cHjPA0o2D83FR
         JvW/1H7yXHUHO5938tYFhYawfRPPlu7zkKhvpiGHiaRUaEbd+lD5odnT/2CxgueqA7+S
         Zjcg==
X-Gm-Message-State: AOJu0YwP9ATuOI6dDK9byxBUS7lvByrYlcm0CI9NKYjcQPmaFsxt1Ud9
	a08Sly22Jz8R6n1ZQIH4yWzGDSWWz9uqy/bwnBweibf5F41Su/lZdJwirVdaVM4=
X-Google-Smtp-Source: AGHT+IGbicDiaCIJkOAL+0Rjmm4rUZwfFW4J5Zoz2JYkWj7C7cqiiUK3ah9YkVF21mxgc45Hb/drBA==
X-Received: by 2002:a19:e00a:0:b0:52c:8811:42f7 with SMTP id 2adb3069b0e04-52c9a3d2020mr3424759e87.19.1718276273406;
        Thu, 13 Jun 2024 03:57:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825955sm162210e87.22.2024.06.13.03.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:57:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:57:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, sui.jingfeng@linux.dev, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, mripard@kernel.org, sam@ravnborg.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 3/3] drm/bridge: sii902x: Add pixel clock check in
 atomic_check
Message-ID: <depev66c3pk2bxf7hrd6mk6jgzpv3uhpy5o5frgsoytsjcre4z@5dbjsia7gtg6>
References: <20240613083805.439337-1-j-choudhary@ti.com>
 <20240613083805.439337-4-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613083805.439337-4-j-choudhary@ti.com>

On Thu, Jun 13, 2024 at 02:08:05PM +0530, Jayesh Choudhary wrote:
> Check the pixel clock for the mode in atomic_check and ensure that
> it is within the range supported by the bridge.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

