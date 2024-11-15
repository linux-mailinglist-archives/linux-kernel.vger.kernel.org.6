Return-Path: <linux-kernel+bounces-410937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A59CF0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A652E1F2414C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B011E25E1;
	Fri, 15 Nov 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3LZMvoy"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DF1E2308
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685468; cv=none; b=UfQQ8KEzs1q0GBgqpCJ0A5aQ1HM2OlzRPkhhBcrPlCLK4iQOv/l+t5k2gGnIWZF5HbqyM1aETjX3NxfsS9WkEMO5n8FxGe4NWHNxArigWhMZpCaM/BbZrXGO7ffUzeMSdjl+Dcnv+9XmTbVqzeRRCPzemb6Ocrz7q6cyqcOs9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685468; c=relaxed/simple;
	bh=cYteiJgMiep2Jq7WbhqHKVo4vq7FKDPN+YhaqgkeWz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHI6NuuzfdjPScGh9nGWuaghB8ch3QIruMklxkYZzY+LBjVQmESdvDW9GP20w9TVn05r844+oXa6biChs+SYEN5OjQueQB6cC1XbcKN5gIAFC05n6sZw3zEQZxwJt9d9gw3emGsP3+ZTQm3C/RL/4opWaGHRhByAwwW0KUsMikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3LZMvoy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da3b911b9so1011365e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731685464; x=1732290264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdH3pqIftktD7b0Hp0V8fou6yJyhDjg7N0Ilt5wq04c=;
        b=P3LZMvoyRGvz1daLY5wfEQy04Nr6/+k8mZG8Lou2rJdfrc6tcEkU/vzobkgH7UuVq4
         QMIfQSsnaOckLywjdyOvtVmIj8B6M59O4WIJ5ARrwzK9pEMl9WfCU9wea9SPUMC6ikCD
         9L3o2ZO9M1htqsmobT8lqplNub+5IvCMa3U9mnZu2moQsQiyuBznD7tr5JqLrcz0XPsW
         zESichWDpd+5g2NKRv08lPrwe3FnsKBWVbGuK6dr5xI5An66sfx3Pjbpu3tsVMipNJ/n
         9/laZxiosY6jkk6b7eCMGG8Idnlif26At6luK6T0dEzRrPII10l6wTjKUBioh8xBcaUR
         V19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685464; x=1732290264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdH3pqIftktD7b0Hp0V8fou6yJyhDjg7N0Ilt5wq04c=;
        b=A8Gmgzg20am/5/UTSRfpz8Ho9ZH/Ik+fN2Ex3RyAzSs+b6omRwjzOpklcrt3jHpO4m
         7AQMIuzXMf3TUgpV2KbqF/ZN9tnv4204CzUsxDQmc6/M2UI0k3hV1+jmMFC/sJD+h5qI
         m5xi1DIX2AszX6qDbbn/K745Fmi3u/8sy2e2cJR6+z6CR578UI1g1+WDlLnWXvvyCsj2
         lb/8HBZw0SXpFLqLXw9pwn+vKYQkE1abg7nknL2pO4UyCA/eGVaCk2S83sLuGsnai+uW
         hHpqPvbsnqnkYltUwvFqois8nUG5//D+LgzNAXRfCsuUYYkl6GTg1FVwpzszSB3tPd/a
         7S3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmEulgLfXAy7iYNcEhfukXag9+7PBHfnyqg4bVLBgAurIufentilvvn46rF5v6lwsbLS9E7NuMgdQ5E/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4disgVlCDYt86M+kOfy/f6S0G2lJYOWxMBkv2m483NRJ/VdB
	Zp0XDY1cKJgBvOIOtKJ6O+3wwrjqFGsWATC8tFRZFzTFukjyPUlILB+V8hTWul4=
X-Google-Smtp-Source: AGHT+IGJ1Z97R/E2OYInl5zxgQC6tLV8/0ODPyzxE/Ts3mGJtyeMxbpeIcLnxKLkaL3O0Q6QejEvhg==
X-Received: by 2002:a05:6512:239a:b0:539:f7ab:e161 with SMTP id 2adb3069b0e04-53dab3bf59amr1563656e87.45.1731685464495;
        Fri, 15 Nov 2024 07:44:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da654896esm609949e87.238.2024.11.15.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:44:23 -0800 (PST)
Date: Fri, 15 Nov 2024 17:44:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pmi8950: add LAB-IBB nodes
Message-ID: <aplxl5e6pakuvpv2sgfesib5e36fw2znyt7a2izwumoodokpmy@ochpnj3w6pcz>
References: <20241115-topic-sdm450-upstream-lab-ibb-v1-0-8a8e74befbfe@linaro.org>
 <20241115-topic-sdm450-upstream-lab-ibb-v1-1-8a8e74befbfe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-topic-sdm450-upstream-lab-ibb-v1-1-8a8e74befbfe@linaro.org>

On Fri, Nov 15, 2024 at 11:20:53AM +0100, Neil Armstrong wrote:
> Add the PMI8950 LAB-IBB regulator nodes, with the
> PMI8998 compatible as fallback.
> 
> The LAB-IBB regulators are used as panels supplies
> on existing phones or tablets.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

