Return-Path: <linux-kernel+bounces-575204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E149A6F414
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0E416CF22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268D255E46;
	Tue, 25 Mar 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNWGHtSO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873584FAD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902303; cv=none; b=oqLewf3HmJ+PmBJy3NO1AZ61t3afqOztKhwnyKu7W2Xbk1M2bkapZW+ZpNTUgJfAkFOdqfb8TiwRhhp8UBvZzxKdWjsXkGru+XPjnsou377f8I2/yUY1+ijwFBx7hbi3Z9Tr7Lk/ZWENl7Dbfd4thQNYZ/LaICUxbYns7w+DsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902303; c=relaxed/simple;
	bh=PRCkhUoMQ6g2UHIWOjNniZkLd4i8GufpIVXhAQO7x30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxJz/gHxxpk21M9aSKTFBj/hTCoQMcPWT5B5qEDkoAhO2MmghA++88SCHrelA/jLbNk3W67blz0RgEhizPU6L049MHKREM6ldTspjNxxSv3BGB8TIROlkivQ3egVoq3hRM1o8jo9Zg71moHYP3Wn+ya02gvlHtsf/3JFT1kcDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PNWGHtSO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so50666175e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902299; x=1743507099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QF8iMLChVD2wmw4TZ+6R++EN5zuFEsavx2RM3Q9DF4o=;
        b=PNWGHtSOEn1ASGlFOCsHdCXWv5Y+QkCRWtFmHpt7518HpiynY9w0keUnoo99fNCHej
         4+qjLqjW/YKNrBoVjio/VyMH4yqXaEDpgKNiFp+8yVpQt+WzuLruh02gp6H64sN6vm1u
         f8DNbbmo/CF2ULuID/PrVxv2Q5nWKckL9MAKKUasW4SRAAGc61wCMZqfxq+H4Sdo8qOS
         PkrAc9IHiPIgJB9SEUg99XfTDW4EmO1ArsYZmjQ3rym5Fh03x0E71Hp096OMxsuZoEEP
         Hffm/aF7eCTyald6lQOPTbWk8LPbSU06Hk7cky7OdK4Sr8xkcI5hznrjJm0YZ/i5j2dv
         Qmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902299; x=1743507099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QF8iMLChVD2wmw4TZ+6R++EN5zuFEsavx2RM3Q9DF4o=;
        b=hMkDCPD2rpFstgY2MpHfYpxN7VPb7UvaGcj+7FLXVmQVvKnmyDgxoSVMdD88NaWC+4
         WU/CMUZNLkeb0VgQCAZ9NCnjyuJ0FX/v7F7aNjubK2vhB+ClH9nFzJL0kbYhhLEv48k1
         Ld6u2V30GaYxs9qWZZOowpRpHF+6xUXGmgxY9f/FPE842Bx0Kn8CDx44eFCsPHDEd/1U
         v5/iAl0mIQrwJtTu+emLEBWPYflVoObWXNNLbmauHFTreBngAgpPSBd989gTRHy737lW
         jEvovTp/3xVSXx2pHqmK+DBGtNnWpVesGYG/B8dsRyLcW6D6ZYZ5A9Ez8yeyNrbcpq22
         Qb9g==
X-Gm-Message-State: AOJu0YxNftoxft8uI1hm5OBJszSwz1FsU8p8ymFPO/35LUFst0LrvdKJ
	aW141RQbGBAicoziLNY6QGEpF80OWI1hzv0Fz5/YKnIw+2Kg0QVA0Kpjb8/t0zrAZH1og+sRazp
	ioMY=
X-Gm-Gg: ASbGnctczU/dwVU8swZctMmrMzPiXokH4UyOOK1vkrxvHZqUUXZnwh2uQ382fSGU92u
	JZKA7h8TkGvdY8IUHKEhFUsy+pjySK9GbnQG0fQZC+V1eHtE2bP+IXcrvKtB7IF0uxOI9nQS4gO
	Jez2s3YpWiltpLRWOp8vjZLgbSi1TijPtV2achGmhsQWexdFFuFf0LSBxfuMcPMr0wQDYetE8Rj
	xwDiFL7fbQvE59O7NmAmaY58o+1j9LJimw1QQRvNfzdX5rkKmdewnM46SHMM32MzjL3fpQNQTK3
	RSLufDIhay3rfCAQzthNEK3B719wVRF3Od9cOox5f0dX/lWipbetz+l9HLFL7GQ=
X-Google-Smtp-Source: AGHT+IGly7NDll+ilLJ+hQiXtzHbfhlspH+Ks6gTLuRgNmP3XYLRHTziE46w3miIZVyvsek6KC8z2g==
X-Received: by 2002:a05:600c:1ca0:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-43d58c9a7b1mr126947695e9.11.1742902299385;
        Tue, 25 Mar 2025 04:31:39 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f76sm13640811f8f.37.2025.03.25.04.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 04:31:38 -0700 (PDT)
Message-ID: <c064ac7c-00c0-4d52-9dfa-35941ae37b81@linaro.org>
Date: Tue, 25 Mar 2025 11:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] nvmem: patches (set 1) for 6.15
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Just want to ping you incase these patches fell through the cracks.

Normally you pick nvmem series much earlier.

Pl, let me know if there is anything that I can do to help.

Thanks,
--srini

On 09/03/2025 14:56, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Hi Greg,
> 
> Here are few nvmem patches for 6.15, Could you queue
> these for 6.15.
> 
> patche include
> 	- updates to bindings to include MSM8960, X1E80100, MS8937,
> 	  IPQ5018
> 	- add support to bit offsets for register strides exceeding
> 	  single byte
> 	- add rockchip-otp variants.
> 	- Few enhancements in qfprom and rochchip nvmem providers.
> 
> Thanks,
> Srini
> 
> Changes since v1:
>   - Merged fixup "nvmem: make the misaligned raw_len non-fatal" into
>    "nvmem: core: verify cell's raw_len"
> 
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> 
> Akhil P Oommen (1):
>    dt-bindings: nvmem: qfprom: Add X1E80100 compatible
> 
> Barnabás Czémán (1):
>    dt-bindings: nvmem: Add compatible for MS8937
> 
> Dmitry Baryshkov (5):
>    dt-bindings: nvmem: fixed-cell: increase bits start value to 31
>    nvmem: core: fix bit offsets of more than one byte
>    nvmem: core: verify cell's raw_len
>    nvmem: core: update raw_len if the bit reading is required
>    nvmem: qfprom: switch to 4-byte aligned reads
> 
> Heiko Stuebner (4):
>    nvmem: rockchip-otp: Move read-offset into variant-data
>    dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
>    dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
>    nvmem: rockchip-otp: add rk3576 variant data
> 
> Rudraksha Gupta (1):
>    dt-bindings: nvmem: Add compatible for MSM8960
> 
> Sricharan Ramabadhran (1):
>    dt-bindings: nvmem: Add compatible for IPQ5018
> 
>   .../bindings/nvmem/layouts/fixed-cell.yaml    |  2 +-
>   .../bindings/nvmem/qcom,qfprom.yaml           |  4 ++
>   .../bindings/nvmem/rockchip,otp.yaml          | 25 ++++++++++++
>   drivers/nvmem/core.c                          | 40 +++++++++++++++----
>   drivers/nvmem/qfprom.c                        | 26 +++++++++---
>   drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
>   6 files changed, 97 insertions(+), 17 deletions(-)
> 

