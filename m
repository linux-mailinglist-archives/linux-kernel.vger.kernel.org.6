Return-Path: <linux-kernel+bounces-383347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD209B1A67
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2286F1F21CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD3225D7;
	Sat, 26 Oct 2024 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNYL7xub"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D6762E0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729966964; cv=none; b=WDgX44kV0/9TBIK9AHgDlcMmHvGw5tKtiWB/UXp2AFFzXD2P7I9Mg9QgT2Zv9czuURafPOtaQcy/jea3lD1/SpogpZ2cuP1MsOxCTspTjEtS1GzLeyBsNYBfUSZY0HcN9s2tlEgn8EGvbOBshfwasRMD0QK09bMKeJfzp0d/6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729966964; c=relaxed/simple;
	bh=n7mgA67sCLDv7LoWKGSko2GKJr0IOHWllRJcXYWVWhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPglfgs67s+CbxR+x9QGbSDlvVLP94/Ad2ZiuzHSGfP+sZPm74C2dol69zUBhYkluxCz3jJ4PE4f/YgKfPYurxWnfuXr0qJqN9neMbe66NXm+SHexfGLvdBszYvPOfLYSUoqRmvGJwpBDnnwgdmgdkeOtvXAaklpjygbDiLH7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNYL7xub; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso29297991fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729966960; x=1730571760; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSP/VyPryBYvoapS7TREWTrIOwGrwP3c8PZiaT4KBao=;
        b=MNYL7xub9jaDCakAUni3MFhM/0p7ivVkkcK4kYl+ZftDFPi0p04iWPio/wTmM4FN+7
         Ts3x5p6oF57gWQ1Bh/IK6T3DTvZFDKAfBsCf8iMd9c0geMuLMJ/RXts2IM9idvZ45IFm
         fJxp66l+o+cBr9q2mDW/qf7eTFAhEweC0CFNN2B+02nQHk3kdTR/e5HaQdtITqfSgwnV
         dMaSjeb/4CvaFeqPMLEpuabf1Siac+n/n6xreMVVubVx450d78nFlApWnC/WfUG5Kz/V
         qZ1YGqQUAnNa2zXmTL3XNBaXGpvOadrOCkcZquKHmlPCN/1Mf8d4JXyP4UN2hoQ+4Lkp
         NYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729966960; x=1730571760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSP/VyPryBYvoapS7TREWTrIOwGrwP3c8PZiaT4KBao=;
        b=Z2Vs7ypXkQJ3skwJdgHo7tLSw/Qzvw0yS02Gc8xSHnIrVpH15gv1/OMfi94nIQd41H
         5wYrGtmvWF47NxIq7efpd8IDRJiW4gpWZrpKRlnFk0+cw3hl6xYf3Gnkaxv1HpdPiaCB
         X0wezoCCZA5LxaCWnXbE9bUv1+Tn66ucG56jwxAEhF5WEWL+IeykQ0BnM26bi7Sirg5u
         SR0O5m8pR3Cma/nmmtmU2PBOpvU0h+HhfX28P2qVOWV+FdrIc7Ki+M9lcCOLeSlK4xhW
         BUeRjj4i8w2HUCCmIsJIV2SxbCKfh2RL8erXz6CRZXdxWy4YB7gEUeNcEdvKCgjqpJj9
         asZg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpcrGcJhsrmbgVkbqrMXfhFDJeTU/pxGA5sDfoMr279m88oe91jzPKrPR+x7wqcvv0P1QQZoLLIVzptw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAjREcKvIzBuyMs5xJumygSydp84oc02YYkCsDRElaLtRUqDQ
	dRald4glQb9M9WBCjAoYfHvW6uorYktwv3FDTBNqnCiGdcct8+9oq8WiEPuxpy4=
X-Google-Smtp-Source: AGHT+IHHDUrc6hNGi+o4QSGxJ2FyXrM6WJ8pfHJhQqbb+GQyMhLKPNZF3QHMsYfea5LJ2KDUVqLGJQ==
X-Received: by 2002:a05:6512:6cc:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53b348c707fmr1031069e87.5.1729966960295;
        Sat, 26 Oct 2024 11:22:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1adb14sm566590e87.162.2024.10.26.11.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 11:22:39 -0700 (PDT)
Date: Sat, 26 Oct 2024 21:22:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miquel =?utf-8?B?U2FiYXTDqSBTb2zDoA==?= <mikisabate@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: Fix reference count on CPU node
Message-ID: <cxjadrf6uilgkoq3xaxekt3zpera65qbsdlhxosthpzgu43gqp@23zooyzmos62>
References: <20240917211325.639765-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917211325.639765-1-mikisabate@gmail.com>

On Tue, Sep 17, 2024 at 11:13:25PM +0200, Miquel Sabaté Solà wrote:
> For the qcom-spm driver, an early return was not calling the proper
> of_node_put call for a previously acquired device node.
> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

