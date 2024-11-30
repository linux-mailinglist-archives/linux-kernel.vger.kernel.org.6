Return-Path: <linux-kernel+bounces-426062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651399DEE65
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B2A1615F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18F12CD8B;
	Sat, 30 Nov 2024 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tr2bvQwA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0C78C76
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931188; cv=none; b=rnVTm/HA8uA4cM3y471wNDhsFo0iaSvyvq39H6H6VXAUW9Vt24Mf5n79RES33eDWCzMugWsIJvu+l4Pk33uJgvlW6lGTTXltSNw1IA/qViCWqif0SnLGD1DQfVH1B6b5+rMSGtQESNv+pgak+xUWS3pA6Lz3VrLugCnrtt+2UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931188; c=relaxed/simple;
	bh=nLzGw4fY9pPe6TJ8BvW0z1cK5A9YBYMULnyUl4VIxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3cmAZNdaviB9OqJOIyQ/vjKPjHovgYC/49UUg9jyEQrX2JZA6vz/HSC+DxMyjttZfTVB06ATT8OCfEA0Z3VSR/JqBKCc9+8bPf7jJNiSu/Azkw/6L+nWiqi2Dj+IgXCsgwDn8NhhcAlC18M0Fu2GufUX0jNT9jD5WfMe6ChUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tr2bvQwA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df67d6659so3993101e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931185; x=1733535985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4PlVmw1LkahlUXOIX8n7OSEzoIK20J0gufnIIJtzoE=;
        b=Tr2bvQwArtPagIagX3nt4bmcM2C/xqchCvjbCpz+R++1/qNWrBhD2yZD5A/QVyLrkb
         OgDlMTNPdbXnBHN6J6KkERtmwGTi8nDHpEW6p3KHJ2/IxITVoRMNeON+Qz+A1sKvogfJ
         YOhwQLzwFyOzyNlIZfe5AUXCcI3H7qfJ7pbg0IrDxESzAe3PQBHuMSURY05ifk6GrU3g
         sCh3gQLRtun/0Cgzxzge9fv8L9xQRLXEgQz+ke31bb20zTPVD88xsHwytvdqDwN0iU5q
         4cbjCy08+yjuc4lIHgkHH7ou0hdqxjJcow9zUehb+TgWE5iRi/8KDzMqG5A8KjACw06f
         j9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931185; x=1733535985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4PlVmw1LkahlUXOIX8n7OSEzoIK20J0gufnIIJtzoE=;
        b=EIkZHS1UhvDZW3l6NfeTtXZH1ksltcTvu/WC3htxXiEKWFTfpdS0jWdoAUG2OoSHcP
         x5G0t6JSwO117okgeiXNpKCi06ICObveVIbU/kp7RccRQ2WRyEd9tIcRtwwGaHZVXsUq
         Zm6un9CNUF5/mpMNDSg9xA6Z/cDug9WUJ2M/QH6aZtJ1869+UnXWDW6wBvZwBo1r8nvQ
         Ayd9FafldQsmhiuUa3Zn1b+qFW/LYy8CoiZNgPflQW2q91BsMdTukA7mSAfzsjVLU/m7
         2GJXcU3RnoylGPfSjVNEekXtimjV+UnlaKhLFPQXC8Qyj6akU7qTT0ugJ/NLmrHs7ssQ
         HR4A==
X-Forwarded-Encrypted: i=1; AJvYcCXhDIMb+cI19YkxNuquS0pSTieyQUwGMlgJyYWcq7+p4e+XE36LNDivMKmo4Ncc8EH5coZpccR83A33ENU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcg4jNI3Hf1c57FH7ZY5T9T2vC9BPNFwBzFJAl16V/yfQOht3
	rN5nGhP83FlR21jU5t1/ksEA1+pdFqxX9l8mmXrUcqHrc9ZmbrwQ3Uoec4+jkeY=
X-Gm-Gg: ASbGncvGtOhqZ7Y5SSE81nOCbNxyDkBziD3FZx2g7TOitW+p5QRdYPtt0F7AnXpYENZ
	jUjcdPItl5rQcg9RCX1DR/1tQTr7Yz/YoNkG4vweb7+iYUPa7yV0OUSkL+/1fr3Hxp317tpltcx
	d4kRAgjSW5bJoeYeW2bDlO+RFUl9ntF6Pcx4SO+MzJdCQBKf8CeipHk8vf6ONjEnR+UK/4c4Aiz
	jWrgQ9pQTOZcT6kMBJe/aOwCSkAeLeydtApMqyg2L08PUTReGnCYDxdmlMc6TJSRzlpBVIkijnx
	aR9qx/nJdK4ckblaBS7cjEnMtV/sPw==
X-Google-Smtp-Source: AGHT+IFy7zoXZyEEJLmZhuv+3OHzOtIXv6pmGJpjBzPnl2Yo4ctu2uv+6diQz+Q9t538nZ+tQkXOZQ==
X-Received: by 2002:a05:6512:3ba2:b0:53d:e602:c0ec with SMTP id 2adb3069b0e04-53df01171d5mr11709184e87.49.1732931184641;
        Fri, 29 Nov 2024 17:46:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644341bsm628900e87.99.2024.11.29.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:46:23 -0800 (PST)
Date: Sat, 30 Nov 2024 03:46:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc: Jingyi Wang <quic_jingyw@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: add base QCS8300 RIDE board
Message-ID: <jho443tdtovkc77fmmco3liftultswemsgrqdjq5p4fvt6c5j7@hb4sgokel47j>
References: <20241128-qcs8300_initial_dtsi-v3-0-26aa8a164914@quicinc.com>
 <20241128-qcs8300_initial_dtsi-v3-4-26aa8a164914@quicinc.com>
 <hswfcxj6vlutl7covrbqqzueljv6nkm3q4qrgccii3zh72qrig@spfbtrvrar5f>
 <3bdca75a-39aa-4ad8-a3f0-8124a0977c06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdca75a-39aa-4ad8-a3f0-8124a0977c06@quicinc.com>

On Fri, Nov 29, 2024 at 11:13:28AM +0800, Tingwei Zhang wrote:
> On 11/28/2024 9:29 PM, Dmitry Baryshkov wrote:
> > > +#include "qcs8300.dtsi"
> > > +/ {
> > > +	model = "Qualcomm Technologies, Inc. QCS8300 Ride";
> > > +	compatible = "qcom,qcs8300-ride", "qcom,qcs8300";
> > > +	chassis-type = "embedded";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart7;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > > +
> > > +	clocks {
> > > +		xo_board_clk: xo-board-clk {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			clock-frequency = <38400000>;
> > > +		};
> > > +
> > > +		sleep_clk: sleep-clk {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			clock-frequency = <32000>;
> > > +		};
> > Move both clocks to the qcs8300.dtsi. If you wish, you can keep
> > frequencies in the board DT file.
> > 
> Dmirty,
> 
> Move xo clock and sleep clock to board DT from SoC DT are due to review
> comments in [1] and [2].
> 
> As you and Krzysztof discussed in [3], there're pros and cons for different
> solutions. There are three possible ways.
> 
> Put these two clocks in board DT is aligned with hardware. These two clocks
> are provided by PMIC instead of SoC.
> 
> Put these two clocks in SoC DT can reduce duplication since they are not
> supposed to be changed on different board.
> 
> Put these two clocks in SoC DT and set frequency in board DT.
> 
> We need a unify way to deal with this kind of nodes and keep it consistent
> across Qualcomm SoC.
> 
> Who shall make this decision?

After an offline discussion I've send [4].

[4] https://lore.kernel.org/linux-arm-msm/20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org/

> 
> [1]https://lore.kernel.org/all/10914199-1e86-4a2e-aec8-2a48cc49ef14@kernel.org/
> [2]https://lore.kernel.org/all/be8b573c-db4e-4eec-a9a6-3cd83d04156d@kernel.org/
> [3]https://lore.kernel.org/all/4kopdkvbkrpcpzwteezm427ml5putqvzsnfkpmg76spsple7l5@mg7v3ihwxnit/
> 
> > > +	};
> > > +};
> > > +
> 
> 
> -- 
> Thanks,
> Tingwei

-- 
With best wishes
Dmitry

