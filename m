Return-Path: <linux-kernel+bounces-205503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E19368FFCE0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3691F220E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA4154427;
	Fri,  7 Jun 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVbTnKqK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F4C13C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744674; cv=none; b=XQAepEjBmvoDuq8MI6pl74dKnORBdMw7poiwsnOhj9d+RReJac4UdIcXlhnuAlLLhlpLlRFHI04a+dV6//w8fYljuwQnaGr8g5OgzsmmWeiuoAOGPSAnXOVQtkkiy2AHmMdr+30Szh+d/llDjp6PWhjyDiVdSinyW9va58DAsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744674; c=relaxed/simple;
	bh=YiEZ3bX0ayB1nOs74MObDCAeLmQirzoQwjpYGOfJuoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJJTXqQrIMtxnvnrErFNbDc3wFed5rY1CZvaO9bePe9nxcY+2awM5jhUYBF2Vun7tSqXPUVsX+PYEYvIcjQnzTz7Wr6RamSaYK12SrpKIgjj4EseOYPIZkUAhhoVGqoo2AMSHgN1LWyJG0/6+OKvHJJK6/D1hnI0+HK2YjR5fOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rVbTnKqK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso172583e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717744671; x=1718349471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goOM+D3enUA/KRbqdIW8pJqTSuZzDywMtVI+QwHEMOs=;
        b=rVbTnKqKn/Q0OTO4Qd7CovK0dlC7NSa3W1pOkCw9kYzUr0ZPyBotMHV89OFOQoEMGM
         IuaEjI9LzNmrdgLCMYDYgbszWLXy74D1GwhIbYoPxSOtfzOObhF+kz9ZMQl+82lfZoHa
         YgPz6MDWzNXSuOZdseGjiaFtbLJn5bfAm1T/HiHp5wxe+uP59XatsuZcLrjizT4l9DJr
         gkVUnyMio12P4ssVKdjlQQol4mpPzui7/hkU6LoRrJr7t+9xudeNmNKX8shhGPhQKJQr
         Vpt4pG0OgSmOJUmuqeQSg8Hopb0RTqKN7VcKqtDZCbNnW97K86eLFGANG9WvwOxGGJE0
         wXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717744671; x=1718349471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goOM+D3enUA/KRbqdIW8pJqTSuZzDywMtVI+QwHEMOs=;
        b=dq7XQRIE3ri2DTkzvRAqLj9R1+2m/uszY4oUGMfjHoRaB3opuLDybdVijUWmCiytg3
         T3k+SvzG8jtWIVYtRl50z/VM2nhNhDS3bBkMnOjo5muUefXwCF12QhhR54miTVTsrccv
         mjHaORJM9D8zMYJcpTGhRry0KdehwZTwiZbGXzEd7hCi8dBH7dbYqvr97lAEwdbOwH+8
         7g3cRA3UIshTuPhQtyJRAX1YJLShUIhDeEIqhyBnqeaJTbxx1GoQOhkkyOZswVBPLgPW
         a5KvZP+MyLYAi2JRDt/vvn02Yi9THtzCqQN+SW7tZR5Swr1MUJ2VRSf7tCHXnOf4N+TT
         ZOtw==
X-Forwarded-Encrypted: i=1; AJvYcCU+dc4yzKyr8JEHlizxv5iueVOtT1Pa6CHrY3htrbAQF4fPXS41Oydrl/ZcgcFbRLGtctY468zVK57yfVc3tyRgr3uj3KT9Ukqo4iN+
X-Gm-Message-State: AOJu0Yxaq/qLYCiVIHz5K/PXPdbhV+xTtmyjsBiTJoBbXmpPh8qXGfLo
	OzoSO6YQ1pIe34AIE0CjQwBpac4Rn2FKeSovFP0WIG5UbV0w/5+cprch4Yl/W8c=
X-Google-Smtp-Source: AGHT+IFayl6a5cyRp7UrKG/w8IISxueREsY73BBE8MGwS5t+Zc6w/UW44a5gLOBjcSSlpsNSb9jMLQ==
X-Received: by 2002:a2e:a487:0:b0:2ea:7dbd:adbb with SMTP id 38308e7fff4ca-2eadce83583mr10384791fa.50.1717744670594;
        Fri, 07 Jun 2024 00:17:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41bf12fsm4287171fa.105.2024.06.07.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:17:50 -0700 (PDT)
Date: Fri, 7 Jun 2024 10:17:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jens Reidel <adrian@travitia.xyz>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm6150: Add vibrator
Message-ID: <ckf2kobxwzlc64lulwroo2gkyoms5kzeufu55id75nsm6y26ug@cgyawalr65bx>
References: <20240606181027.98537-1-adrian@travitia.xyz>
 <20240606181027.98537-3-adrian@travitia.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606181027.98537-3-adrian@travitia.xyz>

On Thu, Jun 06, 2024 at 08:10:27PM +0200, Jens Reidel wrote:
> Add a node for the vibrator module found inside the PM6150.
> 
> Signed-off-by: Jens Reidel <adrian@travitia.xyz>
> ---
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

