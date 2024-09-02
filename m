Return-Path: <linux-kernel+bounces-311799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA2968DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61864B21830
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE51A3AAF;
	Mon,  2 Sep 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGU2/0r7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7D1A3AA6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302596; cv=none; b=gtzNhI8V9CogWW3XJo22YOG8QgyeTxk+SD/CzOQBGVSdcs6LEgPa5RV4pFffTtx8hqVvy/oMk36HyZERYaIaR3po6OLKTiBE3jEW+kW6NG4jMXrSYWDIj5CGwMcavDstiAgIZ6dUHNo9TMst7ZWSTEg0RIC9J2uC5tga4z4QIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302596; c=relaxed/simple;
	bh=1bbiaZ0NWXgadUCHZY6bnVNo9uK6o9FPeWUhkyQFo7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvagxEVSP+oCuY1yUl4yRHDAIr+fsBe57vfiMhmkSp2U6hcyJPZP3jmPspK7cadJHJw9WxXXlCxb2P6B/OdMoZqwTmjUyaPaTS4xpxNu7ZuWU7CdJemNz0uaunJS/uvjfEWtTEG0ODXp+2dgBjaRjAr1NrOuMRRConJcZixSRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oGU2/0r7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533461323cdso5626197e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725302593; x=1725907393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qcoVRQb/pS6osGt1mWOLTNXwlWse+J6Rw0TSoP66u4=;
        b=oGU2/0r7BGPKzRNmjaEdTxuN6IVvKO8eFomOG1f8uEaX3ZnFtvSzRIipizfrvEx/36
         ecVnZsOeNSW9MoSZqYjOJgVdzTtrgiPM55waFW6iosgFQDvwMep9asoknpm0wPIMbezU
         PEVkyDll2z7IyHiOHvwMy09qNpjKiakt1mPtPe8TjxX4x5EZW9+ym6JlDnh9Uqk/lW12
         6lFQVthYCPDhgwdt2dO4GNO5cbqDA4jUoVsea7DsFrEpmNl4BATAvohpmV0ZnBSJMDjR
         isdWY6uagzNnP/ewr677rWLtDTzsvy3wY+c5Dwfrk5EPNo2RjX1MYkdu2zzXaeqvy99X
         Hrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302593; x=1725907393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qcoVRQb/pS6osGt1mWOLTNXwlWse+J6Rw0TSoP66u4=;
        b=LBNWzFJmdAJY6FdBadi/57S9bjI4h58fxCX4QcxYDAZvM1yYZ4izT1Yc+LGYc8MRB7
         Syx0nkXag9lKvd2G7ZmE/roD4YBbTDTKWk43nIUCzKGpY5lZ1on1IkVn+sVJeIoYczVF
         XQbp2KvGeLuP13xNvu41XEXG1Er8N368gkCeoUN9SJJyj9+KazXC5yzv9KJOLhekzrv+
         1VhBMzxO3b+pllOtiinsTHuSlT/2ozQLy5toOAOvTvq5gDN7neYgsWyt9sgGK+EtNvXB
         qjvKDRQ/2WLCExDXqU5w/LqYjztdZmzp6+4Ce6IR6KVeRHH6rURyyzoeS3/JNl9+P1Vd
         nGkg==
X-Forwarded-Encrypted: i=1; AJvYcCXevK4Vs+ZxXEBWJeSx6TKu95V9Ma/F7XxCQqKN7zrxw2HE+1pQWX9eet2xDe8Lih2Geu1sr5eN6vmzOzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTEeffgDf5+GWguFs1E/BeQTlBiPLNKcajraNq5mA9zF66LY8
	s0Gy/QzBma5GhJiyHLUG2OCujNr9p+SwgsAKCK54E7MQHBJg1WOkvMngBU0DZuM=
X-Google-Smtp-Source: AGHT+IEKj8e0DGH0IXL1EvzsJMVmLAGBgaS9VocL7h1EUrManS+QZRdErDq+tnhJINDLOvsL3YRdDw==
X-Received: by 2002:a05:6512:3c81:b0:52e:a7a6:ed7f with SMTP id 2adb3069b0e04-53546bbdf6amr5700636e87.60.1725302592251;
        Mon, 02 Sep 2024 11:43:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841332sm1715733e87.203.2024.09.02.11.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:43:11 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:43:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <quic_kdybcio@quicinc.com>, 
	20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-romulus: Set up USB
 Multiport controller
Message-ID: <ag2rteealf3j6ejc4mdixlinrgx6orhkfzpi6wyuj4sgq25azf@5pemq5ymn5th>
References: <20240902-topic-sl7_updates-v1-0-3ee667e6652d@quicinc.com>
 <20240902-topic-sl7_updates-v1-2-3ee667e6652d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-topic-sl7_updates-v1-2-3ee667e6652d@quicinc.com>

On Mon, Sep 02, 2024 at 04:50:34PM GMT, Konrad Dybcio wrote:
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
> 
> The USB MP controller is wired up to the USB-A port on the left side
> and to the Surface Connector on the right side. Configure it.
> 
> While at it, remove a stray double \n.
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
>  .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  | 59 +++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

