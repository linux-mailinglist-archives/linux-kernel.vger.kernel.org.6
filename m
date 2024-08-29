Return-Path: <linux-kernel+bounces-306467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92A963F69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242B31F25C97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3C18CBFC;
	Thu, 29 Aug 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECUPFfOb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0218C91E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922173; cv=none; b=BVgcma4rPFn9es9LEyo1jJ0Fl76d+jdV0GwloZb6pil6NTp7AEtCAhA1+VhpF37145N62SkNrtSI1yQy1fOtdUenJNvWZbt43pqTvSVeIJJ3OcBgmYWt9qPzZTUbYb4glxnIZHus//RG8cnYwS9nuy2Fz4PXeDYmPw+GS103LmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922173; c=relaxed/simple;
	bh=gkKATRNNDNIPhS3Vg4S0CIL1kfKHfczkzAV/Zg7RGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS3UEsttSkr9NgNEEgv2UslKLjvJczG6jy0kk1PonmDE0ACSwvPGJK+FaWmhcH/LwN0fzpxNbYi/sUw97znbRr7y5sqqviZUZ6NredMapeXMh+k/nBjb2OmTA/R/nVSykFU0IPnm6wkqoEASjcIPFM+c6UdtImQJKHJhQ7//QRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ECUPFfOb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5343eeb4973so596672e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922169; x=1725526969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yU74Z1taMGbV+l39s12NXbpyp4bl/SLE0B6UFkVkWLE=;
        b=ECUPFfObkfdd3vRIWzXq5/8OC2z8A3/XB1q7ubc84q4yf87eotvSg6MLLF04LaDIYG
         CLS/B4HXx3AzVRmqHRD350I07tdOgIxRUjrjOZEu1phEv0/p/wHlC7LmjR/6iTOsuoHz
         50uxVqL+XCWUOQrLrDcIakXd7ywD2pRzdpV6xgxXcsGwHX/Dl/2V4VRempMvQ20l5iyu
         NjJKDsZ88C731ij/ivYjPVjsViU3k/UOKIuyj4HtCdVP6JojOg1XWb5AOg9oDfcf0n6c
         oQuXFHWUU5A2bh7cfdkt4dpzEVd+wSoMRpyttyzGeB7/2HJpjgI/PJrNAUwZh81538hX
         3eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922169; x=1725526969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU74Z1taMGbV+l39s12NXbpyp4bl/SLE0B6UFkVkWLE=;
        b=nIJ6kvD8pwE2Fw2SKTtEY8uXj6xZ4p3BUVLJDDTtXUQD5670svxDZJZ694sYmAaFlt
         X8emjLpitVN4q4qSOYwz+vznLUMP/+GdJVJrCL9p/vs2/3REWQXcdTrJIXxTQRYnRoPD
         7ioeUttCmKDkyhPRxYt94tC+a1KeDNM83G7TL+RLpWrIpvqzxXQQZdqzrybrgLE4nNVS
         R6mN52YI7JSKK7V+73jxaqup0T0Gyd3j33wtlsOqRVfQO3qWQHARFoiVzMKpI3fSjEfS
         feXHidBg1KvDVMq5UoF6cLxnww0dHxpEE1Auz8/7GvvN+ppfPVEKUJqghM43zkzgen67
         TX/A==
X-Forwarded-Encrypted: i=1; AJvYcCVbN6dWKmEDj1n+Nf9wT+LyS7183T+T7ugpRsnd0Q+mVUYwTV61UT4U3bW112/po6ivcPm0X17u4roj9Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqeE/9XORvnjFHiXuIEQA016C6eTKKU7WLSJt32/WSy6wiwJn
	gwQrArG2puyNeY8FtpPA8fudQa64aBxMDT8rNcqQH0KllTaRrKQ3g7SVNIRfhp4=
X-Google-Smtp-Source: AGHT+IEOG/Fqff23S0qeqzOkwCb6zYTfMyOgmyR3JgJ5MsKUOkzSuMuafc5IyicZkjqzBwKINyngaQ==
X-Received: by 2002:a05:6512:baa:b0:52e:8071:e89d with SMTP id 2adb3069b0e04-5353e5acc6fmr1722676e87.40.1724922168807;
        Thu, 29 Aug 2024 02:02:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407abdb9sm99698e87.72.2024.08.29.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:02:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:02:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 07/11] phy: qcom: qmp-pcie-msm8996: Simplify with scoped
 for each OF child loop
Message-ID: <3omsbwonwputnyns5h6rq52bsafqb6is42jk6ty5pv7z2wmyvs@jeb33bmeotyh>
References: <20240826-phy-of-node-scope-v1-0-5b4d82582644@linaro.org>
 <20240826-phy-of-node-scope-v1-7-5b4d82582644@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-phy-of-node-scope-v1-7-5b4d82582644@linaro.org>

On Mon, Aug 26, 2024 at 12:07:23PM GMT, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

