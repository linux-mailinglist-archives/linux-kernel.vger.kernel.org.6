Return-Path: <linux-kernel+bounces-432232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834499E4804
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEA283670
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3961F541D;
	Wed,  4 Dec 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jm2oHuzf"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B84191F70
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351930; cv=none; b=iyEGrWc6JqoqisUnMurHS/OCeuYcDligyYLoEKZSG/ury+0IZyVacpNtFFaJDhz3x4HazmWdvqccSq3iUaE9uOBeFrTSi+orY6XKdNYgvWUeuo+L3WVaRQQ/z2IQM6iHlfBHv0MvB2m+WMckGRoE8H6fqOA6dPqAvxAcIGWbjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351930; c=relaxed/simple;
	bh=KJLX17C7gU6BadOMdJW53aMXiqKx+n3qDA7Afh/ADZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kewmF56gzHdGhM9wO72UYqHXcUBJsJFKSSH4/axeyHRxsU6xtK/Dufv2qz125LoiMszzYtpNCtBqvdREwRIxJGxp2xceV0IISD876rwcQ95eVDcuJYwk6yn5LUvBma7zq5aD4fblXJXXYZrvhiG2fp4wypzUkQWREGlePdoLAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jm2oHuzf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so350855e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733351927; x=1733956727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaiSwDbrMYKMDUjpZaBVp9SW03Bxx8afy8F+RulJTZs=;
        b=jm2oHuzf3nYE7jMiYdViOm8NedeftZijfUS0qeUayCbZiibU0sfDFT/VUSuCOXXSCG
         hEl9z/R8KfcDwRXafAHCrWOutOhztgh6gdawHpK0p8gJQB8bk9Rasy4hbVLYqVxdnHlo
         ABxWXDR67f1n8deqMHAt9SY4VNPYj9jS1tO780L0G1JfdCuskCkWdomCbDOhRxmtlZVd
         fa/a3RM42/+AzZ8mMwmo9k/Ew+gWW2vaQ1ErFNpX7kVPODU17ioAxwSIGo25B3qil4RT
         KpZw/y+pfwtlRlHN/fllr9E3RynWa51OVIBZ2CjrwibaZiKYBWlXFqvKqgNWYwzfuj5v
         GoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351927; x=1733956727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaiSwDbrMYKMDUjpZaBVp9SW03Bxx8afy8F+RulJTZs=;
        b=R0DJBnC/fx+myVKjrExIU0OEjyEM92j4xMRS5z+nuZtdSZ9Yo19sSXqj3v0L90pzqz
         YJ3SR7lolYNjUqNaF9PnCfDDRvchqzdFMvariM2oEQ4HZAS2fM4sfSQjjLsUw4PAj14K
         eObzuKHQh2tCfgs3PquSpYh84qupGRKXaATVfI1pfPgoytBPVK1wYgZCKMbvPzRDWavF
         pcuEq4dqoY8Rl+1XDx75XHXPwCjF7jyF57NYejaHocaf9rTL8x+YcFTpIAEwifIe/psy
         maKFH9wyKPwqs3ufJczGuVsvRyX4NnqdRY36tozXAUNUg0eOYm2fSl02a/FkStOaRzfD
         uDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJsnpmRA03oWvGBXcsbRnZHI0GlcBCHAhHUXZbfcXMnBBpnL1Ylo93dXQlBhYTdmveZ/xSsMAOWZ9F5do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3FOTjCLkYGoBxVv09NZdLEgStz28JYP27nxgP/h20a+tzuDI
	r2pOzqluUmT5P0ZEPvnULCsLVgSTgEhIAUgTzooygFMsKkoHaL8WTFAw5ei376w=
X-Gm-Gg: ASbGncvc+AleLsCRlCEFkkrMtoPRx8rhXQa6YUCoHMAOhTyD+KHR/uWBNkeondqwZQg
	RHuWLmQusurECU5nINwPTmwIt5uwqVyUMvpM28RTj7xAGElT3EG2cpAUm6R9LIjHTqGT9f7ca2B
	4B7qpNC7zXJQ27R6hGsUfTUAmFjtPVIrfSYKqaT6tYUGB467gckDZi/4u6xJZkIelHz3MhrsmIN
	t9Obs227MsHVNAcF7ALRv1HKI1YB/O7LaTpHr2Vj0lEOjtuKekHfaLWGPynJ5eaiDuOUe2C86Xj
	s5enOI91JoLkgs+f/U3NIKHNS7+N/w==
X-Google-Smtp-Source: AGHT+IFRPqvjPiQx+Q57Fj0xvxu0oKNkY5X+QdBxKXoQgr7IIB2rslmWg5kV7euTl28oWng6NSpDpg==
X-Received: by 2002:a05:6512:3b12:b0:53d:a86e:42d7 with SMTP id 2adb3069b0e04-53e12a2e9dfmr5167020e87.49.1733351926740;
        Wed, 04 Dec 2024 14:38:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947be2sm25534e87.12.2024.12.04.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:38:45 -0800 (PST)
Date: Thu, 5 Dec 2024 00:38:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5424: add scm node
Message-ID: <4epsd5nmugjwdu2xwzqzwkihqiaf6bppg62mvllycjvn4637oc@bcubp6qjcdcb>
References: <20241204133627.1341760-1-quic_mmanikan@quicinc.com>
 <20241204133627.1341760-3-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204133627.1341760-3-quic_mmanikan@quicinc.com>

On Wed, Dec 04, 2024 at 07:06:27PM +0530, Manikanta Mylavarapu wrote:
> Add an scm node to interact with the secure world.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

