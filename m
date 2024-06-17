Return-Path: <linux-kernel+bounces-217101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E2C90AA90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1141C1C217D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8518FDAE;
	Mon, 17 Jun 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOdXaef5"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4D18C326
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618537; cv=none; b=fpnSj6SokKZi0MpI2WRce1avKtw/CD6bQHJ7z/xPeyoyUXoYHS3ho+XPaESUhmrjkKvlYpnCetOaDMs6u3nphp2ZWsuq/O4JFkqCivEbIAqbmmLz+EWZkRtlvHGGtcyXfaAQYGJeTm8WFBE3u6zt4d2U9tdUbYoEoiu1OV0dq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618537; c=relaxed/simple;
	bh=qtA4vdLpStckZ4K+HJdtG+Yn+DDVup8OpUIHT1OfTTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdOIjP2lDHABRSTu4aGNbdoJNZVBLCogWdA1sxgHfwIGm9+V8bInFiMx4hPgx/8pkzgsINhQ6p97lpO913BeacMujXbGKUnyYi7lOn8vsSORZ/JkfwQybq0eVhKVayiYYtxJbGz6goFhLz+4nqTCplARmwCKyJbRAJxAOuYu+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nOdXaef5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so49827881fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718618533; x=1719223333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej4HKaTXNbtrLZvPteJwUzGUeQdd3JpTOE58bTuRP4g=;
        b=nOdXaef53XeEmVn3q8HDoZ9MFOhX4JF9mJ3/7uU/HWs/gkNi1Ron/Fvz/1kJd3PhTA
         4ZC93SVl93LuXk5eW3978yTgo5UBLAk7+J6453tR5CkiSqkIOWSeeKEp3TA4Do6+9nvf
         ZPLdzsto2icMJ0/IazAB+R8n9zLnQVHjTAgKyCvJSBjeXqU9RZDHLG45qTUhSjxcZ2/f
         RXfj7IAPZobrnFR1F9Xo/KEiM742SUofrv3BEh7Vm6GdQHMHQ8z/apWD/puasXPncybJ
         TXYxb24V8SxnKbfu2mVMcWKRC4a+8Q/jNHJWIZSFCuvMd+KY+olsrs3pUBl2f/mHIs9u
         A1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718618533; x=1719223333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej4HKaTXNbtrLZvPteJwUzGUeQdd3JpTOE58bTuRP4g=;
        b=P+MgLmsIMkXf9yfxY4lHeJMv8SmJg5KWkD+bOZ5LLkA94/uKXN068GCngUkJAgFbfH
         2sl8GjCfgH6UQEqsTxthvRy92ZUAl93a4K8MgmybryVIHxEP/6rC1COID9hi3szUE+j1
         o96fK1ZIrLz5DWGKwdM98PdaBSUra/vdYeYkQ5YOf1ryb6f3L+ri97OKcQIA8nNy6zY0
         Ng5M/d8Nu1MjLnl0GEdkqQAp4NzdWI3M8x8aZ+SrwLsyjOnzrySF4n3kbxKlxgRktLf6
         ef47eYVteqcjSYQaH49VyG1KJLvnRi5Q+jjGdvB/Lsdj85CRnQiXnbVOdRf+U/YXfPUM
         GZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWHw3VdmcpQzjwSYH4tpUBp7uP4r5GdjC4hjKvXlQupJIjuoirw70KpwmK+ogdn4sDhG6qRJL6PzK14AfhQPqXAeoBg+i8UDM1+Z4yz
X-Gm-Message-State: AOJu0YwpyijPzG699oDnJMb3cV1hOd2UqzPNS6P7EGcgYg0wJGHX+V8k
	Y/laR+Kdaq/7clNPtUtSW6xiYwg+6iz3Zmul5Ax7QkmxMLa1gMfdr9Sk7UevCbc=
X-Google-Smtp-Source: AGHT+IH7zs1ElNWSLauUoxe6oUcxbMknt8N4yLuI0xWzD1LWnvcGVtunFezu9q6l/fZs7aoYPEqeug==
X-Received: by 2002:a2e:2e0f:0:b0:2eb:e840:4a1b with SMTP id 38308e7fff4ca-2ec0e5b5e75mr59433771fa.7.1718618533565;
        Mon, 17 Jun 2024 03:02:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c16c91sm13197401fa.63.2024.06.17.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 03:02:13 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:02:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Naina Mehta <quic_nainmeht@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org, 
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sdx75: Add remoteproc node
Message-ID: <mkthvgckbcttjh5d6ikv2tgmxyix6au4vcqobrcy7ukf3rtyn2@yyg2tvfkoawo>
References: <20240617093428.3616194-1-quic_nainmeht@quicinc.com>
 <20240617093428.3616194-5-quic_nainmeht@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617093428.3616194-5-quic_nainmeht@quicinc.com>

On Mon, Jun 17, 2024 at 03:04:27PM GMT, Naina Mehta wrote:
> Add MPSS remoteproc node for SDX75 SoC.
> 
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 47 +++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

