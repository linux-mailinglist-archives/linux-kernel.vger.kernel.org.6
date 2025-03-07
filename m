Return-Path: <linux-kernel+bounces-551950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F3A5734F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4F1897B69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C477257AD8;
	Fri,  7 Mar 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJjPCiM8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7A19DF8B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381448; cv=none; b=uFDxkDtRtcrhez+EmCD2hoWuw5FmxP03HKdNthkL7lHlDokXQSEauvUQnTxJFvR7sOPz35/Ko1XeyBGEM95RaOQSAuaqG2BvRpFVWb1x4SLazrkJFxunXG1Teu69WT3aYrW3WVusJniMBaGWD+GxX9Q3LOh/Wf9peMkvuC4crQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381448; c=relaxed/simple;
	bh=pgHG6PuUFq9BV3LnyjIGDUfInVsqrHH40CeU6knbHd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGbH1ai065OuzjEgRhtl4PnUtN7LUL/SfBsps/R0W4d+H4zUxeZ4taHD70tvkiXrv50jy31/t/sdHKh6QxkBmh/tGEjNeLUWD8zJFLsnObOazs9tV9g4W75jJRH2JbYjS7n9Cbf6IC9fdJCbOxMnVSFIRAFIRSWXgrjv3NHSHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJjPCiM8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1228179f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741381445; x=1741986245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7lIJgOA1tjiMK/XknTysFy21ttJ28wSLFCbPOi8VqE=;
        b=SJjPCiM8CWNCDmhirDOF4i400m0CuWcKgvhcjh6Vsp8D43PZP9qtVWBfMUzzKvoBgD
         cFjv7mXHG/Ld/HEGjSJGFcK60BpoVLL1YhTVZW4Dg4sMWWqB1fNwCiaL4MOAtVlid/uB
         DFLTow9JNUyQuXl6CqTpz5Oco/fYpU3DlLyNM4ilA3QdEP5jSfdzgljiK1BU6rXKaBrZ
         nZQJL1Sf4gqHxwG5qZEYPsZr4u5LWs7cUcEcfvwuK1NCNHbAmWQ3TNLcrtyBX1FSUA46
         RfvE9wCvMEfKiC3hjQtGr4VZRaOvn4OahOuxMJ14vcxhepg3t+Q56J/nZPxlHYIOJPTJ
         zWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381445; x=1741986245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7lIJgOA1tjiMK/XknTysFy21ttJ28wSLFCbPOi8VqE=;
        b=Yqo0/kJrOj2Pjt8HYgcBWDCwtTW/sapOGch6PJEcEvLZDw8cEvE3Knkk+sTio70C0m
         oqL312Jn1lA8MrxbCo81OSZyclFijeMuMSUmNUw0LtBYosALMDEzbeVSM9q8BcIHT9rs
         tRE666j50m3Wq6vR3V/jqDc8bYBJA5Neo1yxM/hEyY5VKvH1WUrwrN64e61WiJWcNb15
         9dz0BPydUxzhWlH/Dvg2p7EqXotRGyqex5tYfy3LbYsFUmv0dqtfH3Pf1UN9LKdnrdHD
         bjnF4LHMKbSTjxYKzyJ49Q6pC8uUd+adWe1i+wAdj/CKb0m0Rc3PWSwkPQ9GelNQdmv5
         L8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUtusj9ZCyi5+kCGmwrmWfqQemIDjlm3U2YjfK/8irQLXLCJ+s/50K3Zbpsc7Ot0BmDqSOqd0o7EnQa0JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IvLNm+NHWccBrNPShICrvye3tQBHFOLVBvlg/fShWC+kLW6h
	idLNF47s/fRBPvxAk9uHWXPJEiIlEUNN1NPQe62a+Yg97DWDBB1ishqMh9/hXhE=
X-Gm-Gg: ASbGncsPNC7RUghmNkVcycCvrvxY9iLe627UvWtAsUF0drteyYpQ8YUhBzsSNAAnqUd
	IGGIyZ5r/9ROuZOP4yyDSs4sHkejHQVzSpneCo06PIrE2BO/BqLpeOf9svYZhSsKFGyPIZNgjMq
	KAIG/grP3nk+12CdXkdbooh0+mVtvR220VORS9OtPAy6OR4Duv4jvqkWYrjAZJq1qpROzxdVqGO
	4lU/zPVz8iL1G8Cbu6MbDpPOmbo+mYvr4Ri+n8YmKJ+Z5lohZBYKAk9eJfVn+0AloxnW+B/CXrb
	u+IlLEPpRzlEAqPEzPAsRnGOA1s2EoK8+IjT6gESJbZ8JwvnXhsqWYrFH4lXCRzaOEmb5VbeQyM
	t2dPXMIjU97Il
X-Google-Smtp-Source: AGHT+IEHmJNHvM1w44v+C92puTP3sQXrQ3+Ct5w1xj+tmPdoOze0tviwD10Rz14zJ1VGNl40QZCaXQ==
X-Received: by 2002:a5d:47c8:0:b0:391:2889:4ea4 with SMTP id ffacd0b85a97d-39132d06142mr3560982f8f.9.1741381445333;
        Fri, 07 Mar 2025 13:04:05 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm6359734f8f.46.2025.03.07.13.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 13:04:04 -0800 (PST)
Message-ID: <4eab7108-4e57-42df-9141-b213327395af@linaro.org>
Date: Fri, 7 Mar 2025 22:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/20] tests/acpi: virt: update HEST and DSDT tables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <c8f4dcf726b8813f00c917062184ad3348edd647.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8f4dcf726b8813f00c917062184ad3348edd647.1741374594.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> @@ -1,39 +1,39 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20240322 (64-bit version)
>    * Copyright (c) 2000 - 2023 Intel Corporation
>    *
> - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> + * Disassembly of /tmp/aml-DMPE22

The other path is more meaningful IMHO.

>    *
>    * ACPI Data Table [HEST]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */


