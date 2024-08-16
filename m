Return-Path: <linux-kernel+bounces-289899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E1954D15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EA42895AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2F1D0DE4;
	Fri, 16 Aug 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwbM9O56"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E71CCB30
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819529; cv=none; b=nN/egSmfBni/bIyuApq5sn2l4zbNUrPWzRx1cW7GFa+XH2X2MvlgYupqxSf56RnI2iKnUo5NYttX7TxakPRC8N/Ws3Lh/Txwo7kcXH+SrB14fWaUthgjFwsxd+987Bd6tno7TsDp+ouq+YhpJqanAPdKv/f/j4+aGZ0ghN3V4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819529; c=relaxed/simple;
	bh=BI7MuylcQK3ZXHmA98uj6u1YKYT1+iGrzoZMjdOEJ9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+SitruMkTdf+3CXlRmQ/OyzFACoTzsleuHGR9exxubT1c8Qp8pTiYIoXLpgF0pq4RSdP/dKbGPmWrK/i56ya9Cvvc3YJ8xIdbEqQWM8h8cxafemD7hVd/oQ2YRSae2KP6nyNJsHNa/vMm6S/i9XH+miFSSSFWXeLnu080u2W2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwbM9O56; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37196229343so412053f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723819526; x=1724424326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pM0IxVfUAgz/aVGrXk4MOjMvyy59N50bkR2SdLwMpVI=;
        b=JwbM9O56UoplVzla+bADGTCJW/uRJ+qoO1Ls0ctaMKnQ0WuaNgPnqJcIo0bN+cBGmz
         1LMGRM12XIcR4AlnUwf/dcp05DByp1EEbBSI3S4UW3dw5HOMjcXO4rfwpIDKiz4ebBkc
         uMUm/tnsA8DYoDl9rhB354p3gokhCYw4Wk2mEY4PMVZoEE0P7iLQR3Tqp6NRyheFd44P
         073Ci1HCF6HFic7267vI5H5f4xMsRmEEcO+KpU8tFzukqY/c+Ln2D4jVSV0zUXPZosLT
         rNJCdqzcBuaL6wyWW/ezmtna+lYzbyMUFJfDFPkC7H5ptT8uhY5tR0heCUEv0ilfW65N
         vFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819526; x=1724424326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM0IxVfUAgz/aVGrXk4MOjMvyy59N50bkR2SdLwMpVI=;
        b=esiPEe0reuAXm895PyOPM4horFuy0Cjp2wWRRCL6q/eIqlw0sH5TKaABc4DX6FdoUb
         xG28dRaHxxGKWcKexDEnIrq+j8JgWXOhwdUvG4E0Tc2pfLII6eF+BnOM5pVsTE5wkZql
         o9bBlOaaNTWICczJ696ZTPs7nIybQKhjB1ykGSge2cp+IiHuGy7alCdlDU1dV3skl91i
         2G0YygDnw9BTg/AdB28dn+aSeXOJywiR3qf336bDKbwccMAidJi5N9CJCzQ+HOfdXOW0
         a31X0HUv/+ccjhyFHeihV/BJzE+EwBZCicr/OTWqZphYP6GkUA/B4tHecgCEfAZyyMOv
         KQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCW10iUNtdRGDRSUghyK9iu1WRHQQtFRUGYuDFwcoJUH6k2DFquLzt7wjCDohW1ZNYSvMw3TOaEknm1+88crnFu4p5vK+N3732T8d9VO
X-Gm-Message-State: AOJu0Yxx+Pk2NHmV5E1IAN55ZEKDsUHhnz7map4HRKAXAPsLdGxLDbu/
	N8GLLgPLatojYAI4jqSUMNZaHWB5z7bKS8zIdWWVsTamg2kV63QEzC8PT+sURyU=
X-Google-Smtp-Source: AGHT+IE+6LiCeGLtwEyOTB58wu64M6S8/9DUPY48nOkbc1RupL99ZjvumTXM/hq9C9+KYVAfnNaHXQ==
X-Received: by 2002:adf:f7c5:0:b0:371:7e19:b9c8 with SMTP id ffacd0b85a97d-371946a797cmr1782914f8f.58.1723819525665;
        Fri, 16 Aug 2024 07:45:25 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed78480fsm24288965e9.34.2024.08.16.07.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 07:45:25 -0700 (PDT)
Message-ID: <5b9af1ec-b327-43e1-ad36-067153f7fd98@linaro.org>
Date: Fri, 16 Aug 2024 15:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] media: qcom: camss: Add CSID Gen3 support for
 sm8550
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-13-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240812144131.369378-13-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 15:41, Depeng Shao wrote:
> +	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++)
> +		if (csid->phy.en_vc & BIT(i)) {
> +			writel(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
> +						csid->base + CSID_BUF_DONE_IRQ_CLEAR);
> +			writel(0x1 << IRQ_CMD_CLEAR, csid->base + CSID_IRQ_CMD);

IRQ_CMD_CLEAR is for the CSID block not per RDI.

I think you need to move the write outside of this loop too.

> +			writel(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
> +						csid->base + CSID_BUF_DONE_IRQ_MASK);
> +		}

---
bod

