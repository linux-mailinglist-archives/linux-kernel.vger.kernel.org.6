Return-Path: <linux-kernel+bounces-233702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C991BBBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDCDB239BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000715539D;
	Fri, 28 Jun 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqnCYgHL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C9154444
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567693; cv=none; b=lK4+RnsLxbyfz4JuStcPdf0yYu0edMqf34ulNO3TGb+4Z7/uvmdzFUPcbitWmZsh9OzS2RmfTZ3/zVBLS590MBbKABkZhjpq0L5a6x7tb2XZihka8goq+/VO2TrkEuKBJkitxsa3949XyPrrjOIGdrzKW5XV/Lf6o41hn1TNeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567693; c=relaxed/simple;
	bh=tVEgmpllYVknMfJoknc4RL0kqVdAzaKIv/+L42tFl3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRlpih5/7pldoEgZT787v6EuxO9v+ukDgIvIgCCjZgszVSezU8y1mYdqYAOP+gpjXH/lCEA7VOQJv/QbvM1KKz0ebI+v7uC4A7YdxaaVL4gKrAAGOklvCgS/8cHwE2j1HvHi/rFPcM6Yn7HTrx3qHqC383zxuxUaWpKuSj72TwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kqnCYgHL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36743a79dceso951621f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719567690; x=1720172490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVEgmpllYVknMfJoknc4RL0kqVdAzaKIv/+L42tFl3M=;
        b=kqnCYgHLtrA+wfcXS5LIzuLl073kIzp+5DLtUsQMKBuejxoJfkdQhIOe8KuhcCMAds
         j58QpBqzWC9GfzobhI2zgiBrUVi//xEGZP3jz9PaQ8g6Zp0Nq+4CpIIYRcR9vz63K0OX
         HI4g5SSgBGhnc7HmUuT4JbfVvpWiIqC4arj2n6sJVo1bS1oNrQV50bE21V7xH8W0/TVW
         PcuwOXu344SeIUsmeaP1Pj39fAMReYMpzf/9SCAa2LT8BwURxdX/bIdIhQpI53Yanb/E
         WHZsfhgvzUIQlNh8p9b2LNYFr8DZGOrsLeQOf3cEeDXAuHE9JfpGdexF/3vzovNQhBDl
         Pk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567690; x=1720172490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVEgmpllYVknMfJoknc4RL0kqVdAzaKIv/+L42tFl3M=;
        b=iThJhsTW4570+s5Xd5MdFZ4LlVJSrZqxK7U5liXGiFpmCpWPplmdUxdMQ3OtrxIcwW
         dHITuBnfva5zr1pWszg/vtCa5+/K1k16Ut2ANyIFvnDDRdYVDJcJYcrq8uj4XiX8+cjJ
         K1PTJdxnpbgjBAF4YTtVRBmFg6QHkDnwd7MiTuXQn9AOzlZx+LW78sDAjKMKtPyFXv2V
         X2xwf8LUEjwGNDh+TMLBfGLWip8n+xIv6gbp2YUJeoKCtBzygL8xMd2Nn0QWC4hCGu/8
         I0+pLIRvofSYwIFelWYDpwhvkETfjY+Gi46NOCX8yue+P7xlD6vO08tBU0wQVpDTRaUv
         yP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSLcvW/S2dKqp+Tzyn9KcnC3jvuN7xxGgfKBXR0rSOQmWVMwwpclgv17nabgCPw17RvL9bHvHxsYQMdsKIJuaYg4J3Q2q5A/8WPvc9
X-Gm-Message-State: AOJu0YwhjI1t2cJ0I9lZ2cvWT84uRIB1aS8uPdgOWC4U+Oxmd/tPDrXj
	N0qt9jothKTfkxSOW2q+ehFowF6IOZF4a2k3RbX5xXNVhdqcVoDdRKAvAtH2f5U=
X-Google-Smtp-Source: AGHT+IHbI/TgEs3+bVgph0HaYhgOP7yCzLVzQ4yGSROGza3QUnuTQHGw7yvZ+TECrn6gMliVeuqtEA==
X-Received: by 2002:a5d:410c:0:b0:362:70f6:697d with SMTP id ffacd0b85a97d-36760a7e2ffmr1001841f8f.16.1719567689950;
        Fri, 28 Jun 2024 02:41:29 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba2dsm1716761f8f.73.2024.06.28.02.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:41:29 -0700 (PDT)
Message-ID: <25c3e788-1551-4779-9178-393d2a26e147@linaro.org>
Date: Fri, 28 Jun 2024 10:41:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 2/5] media: camss: csiphy-3ph: Add Gen2 v1.2.2
 two-phase MIPI CSI-2 DPHY init
To: gchan9527@gmail.com, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-b4-sc7180-camss-v3-0-89ece6471431@gmail.com>
 <20240624-b4-sc7180-camss-v3-2-89ece6471431@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240624-b4-sc7180-camss-v3-2-89ece6471431@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 13:13, George Chan via B4 Relay wrote:
> +/* GEN2 1.2.2 2PH */
> +struct
> +csiphy_reg_t lane_regs_sc7180[5][23] = {

Small nit

static const struct
csiphy_reg_t

not

struct
csiphy_reg_t

e.g.

/* GEN2 1.0 2PH */
static const struct
csiphy_lane_regs lane_regs_sdm845

---
bod

