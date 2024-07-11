Return-Path: <linux-kernel+bounces-249187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E192E831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0832B27210
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89D15B125;
	Thu, 11 Jul 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qs1btg7f"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E982C7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700396; cv=none; b=HwH31aganof7SDvGYOtzBSrUZTYcIunV1upEGuhOpdltqCwtoQmH3kXuDsQGMmkO3upmQ0xXteedDNNwx3dV4VlMpPZtol9u5qlsBrEQeIk1TDFKSSTn1q6cqJ6FsRX9wtg3EOKQ+AUaB1DieJbEFpV1Uo48o6bYY1XwYEJYjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700396; c=relaxed/simple;
	bh=vam5BQTSEe4vGiw5E8f8xTv0ZY91ZCsGOuYhgXtFd6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNFqOwTqwrvZ77Y9F9Lwffh3lbt08agPAVcJnMiT5ewcmeRefNO8qnt4539D2I39l2xGjjKVguRoBkagc7SMNXl1HFzIGSQUxd5QDJOVZ5QG10xQ3UYMFRevoBS/93v81rJrzBjjNQsW8mw4XHs4QxRhyQcW4hFXZAi0XSE6KzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qs1btg7f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso5907275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720700391; x=1721305191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8VLmBAaRi79unaSRfBc2UCQY1MxGEsWkzfoNGJDc2k=;
        b=Qs1btg7fiMtFOM8ncn4oVH7HRsI2/+Q95sMMVMq+s+QVsWIEFHR7mH5S9a06rBTdal
         /0gkNqqfvl/Cbva9b1kR44vVYBfIjUA2F4lF1wq1i9YsWqExbYhFUTNiLyP76DLd3Qeg
         TYwmSnozsgqNQL2iJ7Co98SMzulQhbZJDD7TjUo2bY67nDJZq4hqGeOwMArJKUliBq/D
         DwcghQKwJCuiWgCaUye+3lJuOqZnH8kqQIqd7iKlsXOQcasfQvor7/rnrDe3VKVDO+An
         KDqYol+m0oaKZy+6CRgN6u28hIq+fkPlOKUZveJoDYGGG+EhusgaKDP0uNI/yQvr5Trv
         5TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700391; x=1721305191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8VLmBAaRi79unaSRfBc2UCQY1MxGEsWkzfoNGJDc2k=;
        b=gkUHEBzaT5KhVp+/a/YBwYRnNfp9nXuwbzv3NDHC0P29uknwLeBhDsMhdrZKXFCqL0
         PLuI8mdILi75vLIYuOyk+eHqqZAuM056lMr9rL0+viln6Uryo2K2sybuos7aCiLryD4x
         g4lvBj9auPHdl3VhsZrbU+6uLfAjQdCtixJbCyfPouoyHrr6KZiLuJad/wujTw0D3voQ
         odz5adpbgb5O9zDVccaw6p/edXVIOmpksso16n0OYnlSEgFzqpvAGX169PTCqYyUu1/a
         MMR/qiGMn3BFnktCMVjibZIWad0B74TSVDHUXlu1tgt0MXRJf7bPN+3Ze99JgW6hqe/7
         igrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOGBVmCac6P9cmLjwEANS0FlZv1+YhDjD/9T2blYM9B21sLrZvlzJYjlmQPh5a8M/d8DXZkjfbDCCgTqkzFHrkbfOFP1YRLL2pOwfE
X-Gm-Message-State: AOJu0Yz2ebVLkqpEL46xHhGuW92uIkZoNi68cEp3v9Pi3BYHqZ5cOL/j
	C14PzKi9raDT1hddMyEBrH5ppHWIsrCeH8axeY6dkwrj8085njA/ON5s3HMKrUA=
X-Google-Smtp-Source: AGHT+IFQZsFLLyzTtk6n5XtvpkhGvimfD/dOwR78iKn4PTCZzgaSyQb0dQfjCRBKdQCvxX1TJNZ1Mw==
X-Received: by 2002:a5d:58f1:0:b0:367:8900:c621 with SMTP id ffacd0b85a97d-367ceaca897mr6159414f8f.56.1720700391459;
        Thu, 11 Jul 2024 05:19:51 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde456f5sm7695360f8f.0.2024.07.11.05.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:19:50 -0700 (PDT)
Message-ID: <5a9939d7-dd05-4ce8-9231-5ae7af32b09f@linaro.org>
Date: Thu, 11 Jul 2024 13:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: venus: hfi_cmds: struct
 hfi_session_release_buffer_pkt: Add __counted_by annotation
To: Kees Cook <kees@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710230728.work.977-kees@kernel.org>
 <20240710230914.3156277-2-kees@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240710230914.3156277-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 00:09, Kees Cook wrote:
> The only direct user of struct hfi_session_release_buffer_pkt is
> pkt_session_unset_buffers() which sets "num_buffers" before using it
> as a loop counter for accessing "buffer_info". Add the __counted_by
> annotation to reflect the relationship.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
> Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
> Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index 42825f07939d..1adf2d2ae5f2 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -227,7 +227,7 @@ struct hfi_session_release_buffer_pkt {
>   	u32 extradata_size;
>   	u32 response_req;
>   	u32 num_buffers;
> -	u32 buffer_info[];
> +	u32 buffer_info[] __counted_by(num_buffers);
>   };
>   
>   struct hfi_session_release_resources_pkt {

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

