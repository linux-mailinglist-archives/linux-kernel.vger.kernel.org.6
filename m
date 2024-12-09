Return-Path: <linux-kernel+bounces-438561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364E9EA2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BE41885DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28981F63F7;
	Mon,  9 Dec 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEv64krJ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF241F63FF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786727; cv=none; b=VbfBREQZ1flDiTGnlT7cEUjPEnzddpe7c9sFB0XCpO+dJZbJmKHEVx6NWIUgwpux9PVTm5awGncIWpaZgUtPH9IuQzbfRz8FhN5IojaPCxda12dP1ah25ZNTFoMdSDGhfPh0pvRecawUxmuApm8SNOTE0v/Opd+UDxIQe8E5IiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786727; c=relaxed/simple;
	bh=CEaXlqPK5rRfzn025WErMmuun7BXlY5qWgtpEUff2SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sod4UdY6O7Dv1RNZV+LxpSGygtzQKOZWMUf9aRIswQTNnzGPVUhN+FBTxdyi7xhxJy0uTJHBQsxSMgU+xWHrStp7uu5lm6nBwR4U01EV8agDKm0n3cQlrLpKylDd9jRYQ/6vrwivFrJCbD6ekZZVdaKuUse/ogkaQaNpBPOtCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEv64krJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so5738849e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733786723; x=1734391523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4s5xgP9DEjlrG5WmtT9MKzX5el9XOMTjRzcfUdtNd0=;
        b=AEv64krJHOW3bIpvg9guTw5YASn2r3RPOXtZOEyMU7cguznwi4xQS4NsLn3xZ+ee/+
         avOQYZGQM1XkgSvUsJAW/NBXBy75YwVjYB5yPB+sY6roxK98zeNNtCKLgnslBYew6LXu
         2UepWZtx+FpIJb6q5Ckz/vJMyr+sMl+cG/q9m7RYNiVbQBI9VATzwR/eQOtn5TIDSPRD
         NdQLTGtR4CFs7eVTayPClNCDGCfbQFljkOu+p6Y1iyfMqlvCQyjF3sZ2Xw1ti3KUkxep
         PiMusThBp2V/DTvVTJVjrlyH4CGeYMKTvJT7jt9oAOlC9qcsRhuEqvOBaM13tx8P/34v
         ZpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786723; x=1734391523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4s5xgP9DEjlrG5WmtT9MKzX5el9XOMTjRzcfUdtNd0=;
        b=R3Z5YFPIy5qI3jjqMiPVWnLghJmE+wBFflNMlGeJQR6zS7X4f/1D23QNjubDI4IRTj
         rrcN4Mkuh6iWAz1RAI5TQI0cdRrRjWxqpbphh+3QJGDZ1u9QUbDwMHtLAm8zEFuhkBAM
         g33QKH73o5fw5ZeP7uPeTeTAtOXbs0XgWVAy+g5oc0s9qYqap0Wc6w+kBnJ3B21OYfnI
         t46qowFyKsam3f55Ep7ljcDiT/++QFF8iSllNgVE8uxzmnS9tFdX/kAO5oB+vc2uDnLl
         e6AsU43AXehWAxuPu7aQmkX38XsLpxd1ebGFCzc8uGm/IzUz5AoPEYy4zzSx2orlctkg
         k6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX2/CIgohpznsSxjpQnXMacVz5jXMo+HFyJY1Pjmucf+JHt7EDSvHTNM6DDXILR8HhMM3sxWjq5rvyLLa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgKVCSzmdtIeVNgrZdqrhbR3XtPzWA4cnwQgkgk0ZuB2iNOxL
	v9h6DkonYIA2mpaKvrcE3En/9RyYNcQe1Ib8eqvqHwXR4HnQ7XIC29mZDTJFl64=
X-Gm-Gg: ASbGncvzK9+Y9ll8NjyHlrAJx6QMC8+Kco9yN+nFsc4e20xfL/O4rnUwyK8YSXS5Z5e
	hMS6u2JgDtQNvlE31YaaCoOPAwiB5z1m3KQU1LEJ/wAIcy6j7nT7YX4j1vayK5ynmWM1+viyPJQ
	teLkJcMQDsc5VY9376kFnQZs4/+c/6UxQRY9nsBa+aJgJbOLRXN54DcHAEtyGBVzMtKF4qQFLz+
	N5gX0ZMFIM7R+/y1l3pxNeauL1DQS8C5DtOTPVieVlThhg5/h50VEGRejQ7rCEMwp4FwyXWa9zH
	MvER1x37jr+qC/h61VCudD3B0LqeJz3izQ==
X-Google-Smtp-Source: AGHT+IFRsv8O8Y8cCQbsGE4N+L0kx2T/KSebIoitD/nAH3VMhwWh9rOyIPp38ojwD+AvvA4aNdBmOA==
X-Received: by 2002:a05:6512:1089:b0:53e:1c3e:34 with SMTP id 2adb3069b0e04-54024104806mr952924e87.38.1733786723383;
        Mon, 09 Dec 2024 15:25:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39f3b193sm983113e87.143.2024.12.09.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:25:22 -0800 (PST)
Date: Tue, 10 Dec 2024 01:25:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wasim Nazir <quic_wasimn@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add support for QCS9075 Ride &
 Ride-r3
Message-ID: <iu6ssjczkdfkhfy2n6vxf3f3c2pepsepslzvnh5z4susxgxgqa@engwsvhu533x>
References: <20241119174954.1219002-1-quic_wasimn@quicinc.com>
 <20241119174954.1219002-6-quic_wasimn@quicinc.com>
 <9e351979-be01-4d38-9b94-cc23efac4c3f@kernel.org>
 <Z1LaN9nFr5msfq61@hu-wasimn-hyd.qualcomm.com>
 <cbed17c2-d839-42cb-8a33-b59538bfccf3@oss.qualcomm.com>
 <c639ca40-9e4f-4882-8441-57413e835422@kernel.org>
 <Z1c9wMxQ5xSqvPmf@hu-wasimn-hyd.qualcomm.com>
 <8cf9edc0-a0cb-4fd0-b10e-2138784dfba3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cf9edc0-a0cb-4fd0-b10e-2138784dfba3@kernel.org>

On Mon, Dec 09, 2024 at 08:30:07PM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2024 19:58, Wasim Nazir wrote:
> > On Fri, Dec 06, 2024 at 01:49:51PM +0100, Krzysztof Kozlowski wrote:
> >> On 06/12/2024 13:14, Konrad Dybcio wrote:
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts b/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..a04c8d1fa258
> >>>>>> --- /dev/null
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts
> >>>>>> @@ -0,0 +1,12 @@
> >>>>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>>>> +/*
> >>>>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>>> + */
> >>>>>> +/dts-v1/;
> >>>>>> +
> >>>>>> +#include "sa8775p-ride-r3.dts"
> >>>>> No guys, you are making these things up. This is EXACTLY the same as
> >>>>> qcs9100.
> >>>>
> >>>> 9100 & 9075 are different from “safe” perspective. They differ in
> >>>> changes related to thermal which will be added later in devicetree.
> >>>
> >>> Since this can't be inferred from just looking at the changes, please
> >>> make sure to add that to the commit message
> >>
> >> Any include of other DTS is clear sign something is odd here. Including
> >> multiple times without any added nodes is showing these are not real
> >> products/boards .
> > 
> > We're adding DTS to reuse the common board changes, with plans to
> > include the differences in upcoming patches. To provide more clarity, I
> > will include patches in this series to highlight the differences between
> > the 9100 and 9075 boards.
> 
> Sure, still do not include DTS. Just like C files don't include C files.

So, is the solution simple, rename .dts to .dtsi and include it from
both .dts files?

-- 
With best wishes
Dmitry

