Return-Path: <linux-kernel+bounces-303513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4A960D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246591C223A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047F1C68AE;
	Tue, 27 Aug 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTcXAHYx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABE1C688B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767688; cv=none; b=De4Y35/9sSx9t+PjUBCUNvQ5sA94/PlB4dTTLM0e00ViIqQSlSqIIEmfvfM9WfWc4rz7QlgmhXLZplHQfz2JiZyPxqDY06f1gJifTO9NZTyikobRc61BL3VYmpZwfwqJhIzRomGz6M0R5OHMjzH1WPDri1r3gPbPIa5I7Zsoe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767688; c=relaxed/simple;
	bh=ZBUTCv3zmcq8wCzDWDN1pjb0U21sMh9Mda4jt580So0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPb920vP3B2tOGgxExsw1zLaoO5IMxB9QCJ6LbPUd7x1Ge2aF/swwm+sK1+1fRyh5uOwr0bKJEB3cZ2/AOfwzGGK/jJF93fxP93SqR66Uk46tco23wwoKWwaLXIE68zSdLU8UKF1oyjlX64I7dKQw6CSTLK4vitbFxC+CWbMMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTcXAHYx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86a37208b2so496102066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724767685; x=1725372485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpeTd/yl72bFm2R7iWr/Y3ABLQEY7ujZ2y0DqdcJWHA=;
        b=JTcXAHYxTLz3YI7TiGWxx3JlWzqk2K/lCs/y3pWVUZtkC07eIGNHcLarh8hehR/546
         4lUJEtKWmLfFsbWvD5OwT6NbH/lRCf572aauykAh38xCP0cXCiupNjohFcGgZwX/WT7s
         W8GdCWwmjyAbnloWS8Y7DqoEp4VbyrE/YM0g4HGMD9+hnj+c7KFrVwA/jwVKcsj0UHaK
         Zb5mO/gs+VF1Jwxg01dOgjBYkiFEhwtPxqGya+t5+uoZngJ5ziDp0pcHTNuk5gpWaZ8S
         cacDSmp7uQ4smnSeoQdjjBTQDXpZMH5cvMA0IyBotW+pTbOM8u3GYkJ95ZXRthzPm9zo
         Ookw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767685; x=1725372485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpeTd/yl72bFm2R7iWr/Y3ABLQEY7ujZ2y0DqdcJWHA=;
        b=txOP4XoFBfRqJIGFs4Pv38sPitNmWfPDJp9szz0vu9JgjYUpyf7sXMdBH+JESC8Mks
         mYYTVkhY0gvJVp9q4WpHpmYA2oGzcaWAMBKQnG1yCN0JLV9d8BhsHsA3ij1hlNdo5X63
         jIYlK4MUZ9i2wlSJB/pNGOdbUYjitEhVVxG39YfDjmqIhp6HGbyuRQgZRF9QU9se1P5W
         MBDWBRPEtMXJXOl7AQ8Bohv9tcORFjyARessUB4xJjzp4Inr592cK0SEQNfdP3/mHWvV
         Bwzgq6UnJAhIRUE9soTJQxXU6AlzA4xDhN5Q4zqtN1gzHgDJOBZePPIqk/8iNz8HMZlk
         AYtw==
X-Forwarded-Encrypted: i=1; AJvYcCXaV4Ko18Fzjz7mVkiAtB03senrBO9p2bwlWvhfnWtgghutt9+Ns6z0hpxB4ajZ4tVAC5xVyAqrsy08xCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/4Seiv0nmhVnOpQ8MKcnZh52OwIJoCBYaGaFV4Tr0l20S7L/
	9iR7gMvvY2FIg1ITl8aeMlRnDN74eXpW0CGm8LF/3bSa+OrlB1wBbcpUzLihOL4=
X-Google-Smtp-Source: AGHT+IFnXxZ6TInJiGYBFSrV4NvTQ5kX2P4kKzBITbVc2Gps66StZ4WmlWBUcCNAhc9WsjoqwzWKiA==
X-Received: by 2002:a17:906:d7c8:b0:a86:812a:d2ca with SMTP id a640c23a62f3a-a86a52b7413mr988954466b.25.1724767684873;
        Tue, 27 Aug 2024 07:08:04 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878455sm114015066b.160.2024.08.27.07.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:08:04 -0700 (PDT)
Message-ID: <74126160-57f9-4abf-a26c-3491c8f3dd78@linaro.org>
Date: Tue, 27 Aug 2024 15:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] media: iris: add platform driver for iris video
 device
To: quic_dikshita@quicinc.com, Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240827-iris_v3-v3-0-c5fdbbe65e70@quicinc.com>
 <20240827-iris_v3-v3-3-c5fdbbe65e70@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240827-iris_v3-v3-3-c5fdbbe65e70@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2024 11:05, Dikshita Agarwal via B4 Relay wrote:
> +static const struct of_device_id iris_dt_match[] = {
> +	{ .compatible = "qcom,sm8550-iris", },
> +	{ .compatible = "qcom,sm8250-venus", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, iris_dt_match);

The enabling patch for the compat strings should come last - if its 
first then the time between the compat add and the last patch is a dead 
zone where things are bound to break on a booting board.

---
bod

