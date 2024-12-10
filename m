Return-Path: <linux-kernel+bounces-439653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C89EB23F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F029188B1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE11AA1EC;
	Tue, 10 Dec 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqrTCuDD"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2C1A9B5B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838739; cv=none; b=h96NlLj5Lro8Sl84UJYD6KpWgrNXCBcNtVDsLNMn90A+ZIWcIqB1x3r0Hijxtdx0o45p/KowPDQa0jXOj+9ECe2iJE8YRTH+7C6yj8I+UbFi1TPdiNRNQxFuu0yAKnmB/pBtjnOwjK9pf6oksrjlVCd/G0Hzgt3KvAc0Q/BoKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838739; c=relaxed/simple;
	bh=x0YzXghQ+gAKuEwKFhdi6SRVXz39dHzpMAssWYnJg+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njSjeOKr2xC2ZoW6aVn+cHAiR9w16DAvAdste8GlWQerlsEmngVokgvDzvvQJB6ovUXOturCYbKMKkv0ZUbPOJdJ6olRxtlw0XoLrS6wpPhvbA3417WejuMySjRo1l8t/IALeew/0ELLerOnw/xaTmSUxWBKQA0uMZWbnwUqPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqrTCuDD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2408784f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733838736; x=1734443536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvsJcHnWFJkaRdXIOYYPtjthmV89MakBwrZsJYDK4Qk=;
        b=oqrTCuDDPhHCWbEBWkNNZaCM90uYmRvXQb9zRZa5kiv5vR/Lt7EIJUlCr1aUNGyu8A
         J2jFg1U9ubHVCn1BYSulIkZuiU/FCH7MXQVtdjuLQQCFYfV0OfYsnnmr1a7upiTfOrtr
         DP2uXTLFosJQRZWAtdcTKlReeB1zA5MWCD34qBO4fg4foBSDb/H3YTUgbh+RLspjA2Fd
         j9+oq6926ZdWkbSRcAsqmKlxG6+5K6XwqedOkHSk1s2VAOR1JtW/a6N/YIzxtCGim0tR
         q21f1f59k9dxCTRrRW2ZeGpdPMZ+cOp0Ke10NnlrMPc2o3JS3Lf3HeKI+JBLe+BKLkpK
         n7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838736; x=1734443536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvsJcHnWFJkaRdXIOYYPtjthmV89MakBwrZsJYDK4Qk=;
        b=gPNsQAlqetjbpbfT6gzLJbxrR5IPEN9EHJWAkL8V8pyTSRnnrLL9VmzOfe0GXkQERH
         twYum7ua3eSQmHz4oqPM7pHPw9jBKPs3tZ1MgXLFyVdgAvrpnL5yAF2ZfYfVPdysFRjv
         jRm/NcQINrAwQfx3+EGNfz9Ob+U6YeOD1MVsnCI7fYji87TcyREgTiQfENmmNG4hB2wz
         4cOSH/z4yG8lpSHAxlk3YbO+MKt/ikA2TkPq6NOS9jgcn9GKnZQRjBKol3STcGjvmnGv
         9SbU1ikYN1Kq+eOK7jVgcCMl3g19mcfpREZlxV2buqshuuonisGYx7YMfcWQBiBHxUF9
         tWjg==
X-Forwarded-Encrypted: i=1; AJvYcCVm3ShUw3nWxX1GZuMyNWBTYlh+kNnxYnQShuf1BqZv588F8SSJ2hsvXAWWpjS5/+KkDUDeb++awlIOKoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3bIlRxeo0MUklkDzUY5u3G8GzdtbqGo9YUcOcYLkdj0GPHhC
	SXc1vgIXFURfoZo3mikORsxPu5fNSTVNxweXo77m1DFfI6IDHccqCH/JEKBmcMo=
X-Gm-Gg: ASbGnctNQ0EsZDx8tbPaxOPq61qKzSIMxw/StYtKqUSSat+Eb9qY6ex3QV0OFKmY3Gd
	h6XUDS+6hI45dhJ4JrVCZ4GxKdoPhZGJ1YRy9AvQcbAPPdi8A6qnAI5g3Qp77BxLouVn/M2X7+8
	zASIjczlmeY/kv0fWNPK7Gla0cqouZSy4MyX9jtzyoVZf15Xh4J3hXxl7Onz7LEfUuvAwe/suVy
	2Ia7spkHKea7uXud0/Z2cjHB8pDjLOB8gw5FUQn+xV1htwmQBFF6Dsq5uPjvPABWp72aic2
X-Google-Smtp-Source: AGHT+IFQ6nYMzgv6s9MPm0QEXnXj8O3sBLDqM8CxTrOU96IG8xBvdz2PcHy2jFxRyvN3ca+1FwMClg==
X-Received: by 2002:a05:6000:42c3:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-386453e2a8cmr1917700f8f.22.1733838735834;
        Tue, 10 Dec 2024 05:52:15 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3861ecf4119sm15806378f8f.14.2024.12.10.05.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 05:52:15 -0800 (PST)
Message-ID: <3e16b2f5-5aeb-4988-bf6f-63c7309f53a4@linaro.org>
Date: Tue, 10 Dec 2024 13:52:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] nvmem: imx-ocotp-ele: fix reading from ELE OCOTP
To: Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>
References: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2024 11:22, Sascha Hauer wrote:
> Commits b2ab0edaf484 ("arm64: dts: imx93: add nvmem property for fec1")
> and 0d4fbaffbdca ("arm64: dts: imx93: add nvmem property for eqos")
> introduced NVMEM cell bindings for reading MAC addresses from the ELE
> OCOTP. This doesn't work as expected due to bugs in the driver:
> 
> - imx_ocotp_reg_read() interprets the incoming offset as 32bit word
>    offset, but it really is in bytes which means the driver reads bogus
>    values whenever the offset is non zero
> - imx_ocotp_reg_read() reads wrong results when the offset is not 32bit
>    word aligned
> - MAC addresses are stored in reverse byte order in the ELE OCOTP, we
>    have to swap the order before passing them to the upper layer
> 
> This likely went through unnoticed because the bootloader normally adds
> the MAC addresses to the ethernet nodes and in this case they are
> preferred over the NVMEM addresses.
> 
> This series fixes these issues.
> 
> Sascha
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Changes in v2:
> - Add Fixes: and Cc: stable tag as requested by Fabio
> - Link to v1: https://lore.kernel.org/r/20241023-imx-ele-ocotp-fixes-v1-0-4adc00ce288f@pengutronix.de
> 
> ---
> Sascha Hauer (4):
>        nvmem: imx-ocotp-ele: simplify read beyond device check
>        nvmem: imx-ocotp-ele: fix reading from non zero offset
>        nvmem: imx-ocotp-ele: fix MAC address byte order
>        nvmem: imx-ocotp-ele: set word length to 1


Applied thanks,

--srini
> 
>   drivers/nvmem/imx-ocotp-ele.c | 38 +++++++++++++++++++++++++++++++-------
>   1 file changed, 31 insertions(+), 7 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241023-imx-ele-ocotp-fixes-f7b216171e1e
> 
> Best regards,

