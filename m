Return-Path: <linux-kernel+bounces-190284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7868CFC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3504B1F22898
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A7763EC;
	Mon, 27 May 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vH/DuRUr"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041717BCD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800702; cv=none; b=mbRaDB63hjLwtg4SjMCnWg5htfobsCeZjroskN3XVDZsJPZwuLvKuw5YexHY+boCFaIE9ZjbAowee9kqWtJgrmHnqO3/AYiUf2Du1ndMfKpkVCf6lSLkbK8R8uKHpl15jLxxpgFd5XTZSa+i0ePXLDfjr/8kMCE5RBLaHJOTrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800702; c=relaxed/simple;
	bh=lCkatABB5qE+80NuM/7gtP5bXQbnqCgUTAsUJEIq+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYHrVeQ3GtimUEX79SeyLC/zoRqgZBeH9oi7pLgo3ZxrEp503nGvcTD1y34unFGnRsFLFheZsKJnqPamLjazsqyAGAda/AHdGTv1e0EcaKBjp+GHexL2QfWgtfxXR64t0gxXHTKV3AKJCLVBKjgQjCDXcTP2Aj09lge4bV0Q5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vH/DuRUr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so133371911fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800698; x=1717405498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kct0tf/YJNMu/6x33HcGbT8GgyNCLw0zNoUOIeT2KM=;
        b=vH/DuRUrazwpsUeARhxX/qEDI9gBteXOp+wjxhisPGaf90zNm+mklvN8jXeScZD5Z2
         dB40fs6dR8GVqAyve0mgL2hnxV7Rb16Gl9taMfqxUs198MKs7cCYgWL5M7a1JMROXMzQ
         CbQUpbgYB3jh9+2763H1Fs1HuOB/BWfcD02tHuCpxKxhclbTcq/liM8JMdskfk0s997R
         c5HyUdkqGJlfi8s4Y05Xl5AWOeFdwC2e7i6C6Z1GYTKRVPKjcsoT6wWkpINIAxjGQc6J
         NYa2uUNoypN+y61ceze8VniyVWwzJtuxdpIHrxu86toElVHDiZyWS4inDCyixQF2AJrn
         OSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800698; x=1717405498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Kct0tf/YJNMu/6x33HcGbT8GgyNCLw0zNoUOIeT2KM=;
        b=IlWjmVeCUDZzMbch+GA0fU+tTTazjUz+UiIXH1/mdYpcpNi9fApSjk4GtCVyZyX8Y2
         6B/ZgshiMiF5gLQv4Zl4PkT1sG0kbCWMPLMc3laB/tpRPg6DvVlE0K1lBexJcoU9Aa54
         j8ffnq8xCcCe9sV3XdELM0w+zNzitoXO/K5KBtk36lDMU7mtC3JcK+HVZ+icVDrLtJzo
         9WntPbDgdLIXJMyC6eVpkGQdjs+SMo2wiXrLbm3eBi8SZEoSBroYKqeoOlSz6s83WYU3
         PZAm+7hNEys3zT6BzD4nl7ZnVmKwHLbWRC56YZeVIwEzGa1gOAaKhw9KuUxbn/w6Oo4A
         OTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRzE8jAlbdf5FokKR+2nMDhPTmYraX1nRvJeCW7HLREPnNhz+D2uXbnBryiFEMCTEhvLdfzYRdM8V46QRZeRK7yYYmwQeJM9FLBJBc
X-Gm-Message-State: AOJu0YwIHr1Ca4CwIqXj1IR73ljpia+yepynjpKxkyKNah5jH7RSolXR
	Pj94OUxI3FIfSrRUDqLb7BFIflpm5KNqw95EKHU/9o6BUPyonaTXSWaYAB2Bmd8=
X-Google-Smtp-Source: AGHT+IHEtnRhG/oZq/nIMTgh4haWtjmSaREwjwmnH+XtrXGGNLA2aYrcPng3SWVQ7vbKRRjs/4F1Lg==
X-Received: by 2002:a2e:9646:0:b0:2e7:bc7:b6f6 with SMTP id 38308e7fff4ca-2e95b2566d8mr68365361fa.38.1716800698324;
        Mon, 27 May 2024 02:04:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4ab4sm18760821fa.13.2024.05.27.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:04:57 -0700 (PDT)
Date: Mon, 27 May 2024 12:04:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13:
 allow 4 lanes for DisplayPort and enable QMP PHY mode-switch
Message-ID: <mfcofztvemowz2opn2fckszz4z44unhuxnhyaqvstbtqewzgzf@y4qo3ja74deu>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-7-a03e68d7b8fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-7-a03e68d7b8fc@linaro.org>

On Mon, May 27, 2024 at 10:42:39AM +0200, Neil Armstrong wrote:
> Allow up to 4 lanes for the DisplayPort link from the PHYs to the Controllers
> and allow mode-switch events to the QMP Combo PHYs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

