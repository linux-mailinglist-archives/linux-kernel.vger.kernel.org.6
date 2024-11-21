Return-Path: <linux-kernel+bounces-417260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57F9D51A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3B52825BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18A1ACDE7;
	Thu, 21 Nov 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5S8C4bW"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066F1A01DD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209813; cv=none; b=WoScUQADyUGIcRvLqaho2hTDjScCgTw6WPaJiBLC6SD9fz/CyzWilxOXvqHGzQCTrLdcvPF+Erb1TfCdfQzt+9BksIuHMZAcwYA1rUobleEtbIgrsnHaimL6wke3ZA5kDt7EGwNzlB2LvQzW7vaCpLE51p4hbooVliGaWCZeWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209813; c=relaxed/simple;
	bh=yCHjjbvtrfT1JCkVsNvo5JIEc/EKUG7w/UabrT+59Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1a0P0lj/CebRkUchoXjjpZY3+WcEuEs+EFYF2gnvgxx3yVOohMNGZx4hgGXQZgs+LVV6pdh7UQfZePteHe+pkVexTxbOPYlCrOjrdl+Y3WI2UxPFGauY/0a580LbfnlgDuaKNaIZd8RAz1dj+eWH8Vjujz+hWaCG+m0Nm0YSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5S8C4bW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1050403e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732209810; x=1732814610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWVCCsWBP9SsU0WWdjRRTAwc2KuY3q4MRUVtiMXkZXY=;
        b=P5S8C4bWwr/ENCnutwKF3T0d2bNA4QuI5IIlDZi9LleO/2w9tmGpOdI/l5C2rkyjmb
         rfiqaP2c6R8ISPW7MBVAlnjtUvWwGG3V8B+ne40pId5p6MikC5mr0BpgCP+feOET1wVT
         jdBkctzct3ADj7Qa9RpcGUxrZyPk5aIfGO8vCegEZlZ/nalO7fgr7cw6uQqxCgINf2Qc
         gC0jrF2RVT6jLj92j1LJ+1NvWh5Uaq58t5A6UIFJzu9dI1vM5keN6QIlK1oFdxRgkj6R
         jr427i2RYgQ5E0/BFIwJFNwctplrrB7yMwb+7TEpRrIQoHvv8t2xCOv5lGRm0o96tKqX
         7oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732209810; x=1732814610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWVCCsWBP9SsU0WWdjRRTAwc2KuY3q4MRUVtiMXkZXY=;
        b=eUega5VYlSYjAtisFM+jR4T4HCOZhTLjhJwA5YzMmpq3Bgoe6T1k7bq3m0a7MShJdT
         8YL6cwe1CTm+wZzFX1R6YKH5PEU3u5WXOoN0aC4nlXQbGRL9cLpKXCSdbXZTcITvyo8a
         UMEwShdqSz4ZroSp2IKo1spIyLC6a/R7lCz9nY4N81yPe7mFHRuaEanVYQ6/8dnz1uuC
         7bpxz7H7A+wdMgZf4ft3rkDnP0peQr2nPa+DipxlIzAu5Cvy2iPMtJZFkSLJT0gz9REP
         itaggbu2ZMnhzL0w8Q4jlZWpq4sUAHzpAQ6uf6lBY7hZc9ins3sP0dF8G7aQhMkXaOiU
         joWg==
X-Forwarded-Encrypted: i=1; AJvYcCVxSlFXg59KPe/qSYb99hHO+NPApTXK6zBi4o0nhLOVww8FZ23pRY6ahTPeFZ2Piano18gPz6Y+5Xlzddk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3D/N7qItjq27QR6WVIOqZ3EK8Qk+40Jk157N326hB9e/CalOa
	39jNSX6iOP+PMr9WDZOqaLv/NEdoQ/nVweYLT9zD7j6nlctzcNd9lSTKpdkauxrd6aph9ApRt8v
	d
X-Gm-Gg: ASbGncvGtfzsc6jSN48j0YX3jGathzmcziWAHE3oSNOPvBI+Y/kge5AyrFtForgEvch
	gdaR7HvZ1YsnFzwMKZS7JMjt8NoyA7rGwz0nUhf0L2KQ1Mk8vwBR+sw64Xs1j1i0zmLmsIMDQal
	C+HQID/w57gq6HfHoPAAuuEf/ONi5RvjD403dvk9s2Qet001wKITidCgMk0NDGlmuc1oLHBQL7f
	C1Wu/EXTJDNbIAbWqWhURYvk423gxkHzUe/LCZ9r0dkpbq3dw2xTrRxe2UlxhwgrUDRmhirldPR
	G9McX2iOozBnH2+STLqk1+OE6TjIcg==
X-Google-Smtp-Source: AGHT+IFNyWzb4+jLBwNmRWwEb/xejdO0xHw6ZZB4QrLGg8Zjcsh3wc7VZOCIAYezqtv7SN1TcZuhhg==
X-Received: by 2002:a05:6512:4012:b0:539:e97c:cb10 with SMTP id 2adb3069b0e04-53dc136cfaamr3468964e87.40.1732209810156;
        Thu, 21 Nov 2024 09:23:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451903sm23560e87.89.2024.11.21.09.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:23:29 -0800 (PST)
Date: Thu, 21 Nov 2024 19:23:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add support for usb node on
 QCS615
Message-ID: <xmqvfbzg7xl3lp7amnbmro4ivs3dhkdvv6pjx2wffrfidsixa5@grlcvuk4gbsl>
References: <20241121063007.2737908-1-quic_kriskura@quicinc.com>
 <20241121063007.2737908-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121063007.2737908-2-quic_kriskura@quicinc.com>

On Thu, Nov 21, 2024 at 12:00:06PM +0530, Krishna Kurapati wrote:
> Add support for primary USB controller and its PHYs on
> QCS615.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 110 +++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

