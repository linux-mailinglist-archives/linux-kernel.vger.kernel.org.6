Return-Path: <linux-kernel+bounces-415658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1F9D397C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3ADB25FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858C170A3D;
	Wed, 20 Nov 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLL8dVXv"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A92197A87
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101810; cv=none; b=Od51zv4bKciOpBWwlaM/NWBqboGFDJcbRV+NbUXUEON59/MnuwEjJy62vSQ8ZdyfuL/xa0SKdFPTwbqUr+uXiK9Njx8woF3dCz6F/EFJ0RevK8tSzbwbME90lV+aN7oTCaNKScM0WzOLy+5WYJi44r3yAlE51EHx5zQPokAI62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101810; c=relaxed/simple;
	bh=+346Z4vZk9sJJwp8fihTpLjY0lLHfn5QUkit0YNCs+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeljNq2aCFv+H/R5xKU3QUuOfCOlei0o96PFAWbn/9KQEyHJgWHUm7XLLp9NbpxiOIJfnBuyRGaQBETNxK4JAR4pe04bq5gLFdt6RRZK5fOWxOVKAYC34h07a5vTBihsDbr7BsuvNxkrGzj1Q7wG+i5iQvl1VRfm4Tpc1/c9vOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLL8dVXv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so21750481fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101806; x=1732706606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WT2RCqlUIDm/ELnv9korMButZmCsfo2C9ysxQ6aiop4=;
        b=QLL8dVXvT2RkpUkrSItnlQodu/1V9tCapZdrsz3Ri1dFVRYKOxMLyDefXorb5voYRO
         EOYh19ZJbp+RGGapxGNtLllkbgG28wN0E8kvRQSYF/+R+BDQYaS7vGCOvzeXqSTsgK6d
         9GdXV7xk90dVHFyC7R2iQ8cLGqbB56fgd+B5mJ7/0jsrMK1aqrW+0CivNXZ/B6SaBw0H
         7f3gLNy7Sy3lLBjEHxFrM0yE8VESW2y5cS/+Kpl9V9wK1u65rDHkk5luJsK6dd4vaMKE
         nsiAPaffVHyGyoq8exIqdrPZMFhmzoF+6p39BEslAQ2tzm4XUmJp/hbw4BdYn1/KgQgN
         EH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101806; x=1732706606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT2RCqlUIDm/ELnv9korMButZmCsfo2C9ysxQ6aiop4=;
        b=bS7ywEFU3BhWgyASc6AgSzmMeoAsPx6ZUl4Hb9lG8ErZwqKi9OfMk51Ea7DJ2BHCln
         eFzKYttJ5RQ9PTw6yB6obT3AyFNHL0CYclBMz8g5Eiml3dkzMITOluQIT3rTWlXjWEvp
         iURbL27p4TWExmGMc5iMSGSsoDC2ST57m4N8XWnUZQzFNHwBLYthDCJySHINFIaUw0Fr
         P2auP5ZNTa6F7pOJV7/K19isK2A5svaSDXpL9Orwepfu0nVGxkMrQGypgkEx77u1qI5X
         QQRMtV03OilbXaEQt0GL/TqchVPUmhTpt3KFyM/poePwpCRcGEx+2Sm575qe1dp14Fkv
         UfHw==
X-Forwarded-Encrypted: i=1; AJvYcCWbs797p5L2LMadtdW6zAYBxLb5GUh/1RUR2pB+JLhdC6aW8pe3SWWMnrfPslpvHAX48BTjMV4aAu2Rm7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYROZKWLbyDbgCKTUb/blheLd26JUyoR2pw0ChsBflQJZ/MioL
	CmdltuSIh2vVLLTUHfnOwHVYOah0dN3lmmKVoBmvA6u7L8sjGt3xqNQ+d5FizoM=
X-Google-Smtp-Source: AGHT+IHlWqD5qY6mZos/KGF9OT2gcVFgyhFfOxqvT3sp19oGHOiRw2YZmTcuQSlRb/odj042eZ6wnA==
X-Received: by 2002:a05:651c:549:b0:2fb:4b0d:9092 with SMTP id 38308e7fff4ca-2ff8db110cfmr13383421fa.1.1732101805832;
        Wed, 20 Nov 2024 03:23:25 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69959c55sm14730341fa.39.2024.11.20.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:23:24 -0800 (PST)
Date: Wed, 20 Nov 2024 13:23:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sa8775p: add DisplayPort device
 nodes
Message-ID: <2umtgmw3axxaokrpd2ybleypzmkr4auosi4u3swnch6fvuevjz@qjqyeekx77q3>
References: <20241120105954.9665-1-quic_mukhopad@quicinc.com>
 <20241120105954.9665-2-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105954.9665-2-quic_mukhopad@quicinc.com>

On Wed, Nov 20, 2024 at 04:29:53PM +0530, Soutrik Mukhopadhyay wrote:
> Add device tree nodes for the DPTX0 and DPTX1 controllers
> with their corresponding PHYs found on Qualcomm SA8775P SoC.
> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 218 +++++++++++++++++++++++++-
>  1 file changed, 217 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

