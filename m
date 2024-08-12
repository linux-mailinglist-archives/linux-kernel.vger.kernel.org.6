Return-Path: <linux-kernel+bounces-283347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7D94F13D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A1D1C220D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE856184530;
	Mon, 12 Aug 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbD9cVYc"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941717C7CB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475032; cv=none; b=NA/ISRImhYiptWKWt6AfNeOfwAXYGQaONUM8yUpBtp5yC9G2va/lAqWKfgOXXGu7zduedGPvSIqMhEA6CVs0MLFfQbQJrmaPZYJtg47jNsatEE/FDjyp/qClXAv2u7xlO4zngW49E3txMt3yqOF882Z4yKbFPViK339JHiFFJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475032; c=relaxed/simple;
	bh=Wxf95/7xZrC9XwE1yk43JofkaXpWLc49atap09H0tog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ME57+NYRXIXVmgJon8KxGfgn4oodLH+S6Be8fNSUJBiEwyuTkADiA75HPPs8ktfmHYMSNeyevRRzUM6YPfKGcAiapxAWk+7Q0yx5lMMTu4j1iZxzOmOiJDkneJg8vf4NStbFO2B8Z0YatibEWTVUHq4iBQiIRUX/jt3qTeFoESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbD9cVYc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-369cb9f086aso2673331f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723475028; x=1724079828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuDQEzhLbfCsKb872rcJdwN1AQNn7kR/XWS1IhrM88E=;
        b=sbD9cVYcmlU7ja5p49iljhJ6PHIBXh2/nHY+ZcHRm+7TxPysqUvxUWhZxl1DPG8y9r
         BRhwczEUoRYnjcNmtl8TfA3ck79CDEKj+87HQQOMIiG39QOStzVGnoV+Ng6ws/bFHwll
         VSeMqThTMjFyn0yn9uhMY+90wj+SH2OgEybkWpRNaTFXt3ue2lzxd2ROhHCRhvn1OD9Y
         Ah3UsViqhRPsICg3G7znM3BcWuCNrGXkZbaqCTto1/sgk6mQT2mq3uIPJPng8lxZW+3w
         QGH3BjdARsE2kFyffVgi1D+WbzcrP59DQL5IwGqD+zjTqe/Acv9QaOxB7ZQq7dW6i1IK
         s01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475028; x=1724079828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuDQEzhLbfCsKb872rcJdwN1AQNn7kR/XWS1IhrM88E=;
        b=hhNICc6+YvtWh2ECquu8glEyNBcpRoFrhPj6lMG/144UO98R1l/2LtRjxIgd7jO9OC
         /X7V8pWk0SPgAowu0NFG5v9capeSQV3cXArTqJAbvcNWZCwTSNLtNY6qBNVgaUb2PaDd
         hoKYnXL7/jdNlVhnK7QrL4qRgiqB0Tvi96LwO9HJSHbn8ftoS6YDMQu5DaftQrJqdsfE
         HlllrxFbQjQu34GEGY7nAcx73/jgAh5AjyvvuxbqPPkLo3QN99ptBrTAgRyAgot6DdTb
         dOfYvU4br1oOTsmkYG7xv5Rs3fDamJyj8cqnNYzR98WURnKbmq8Z4FZbu10xKhEPylFl
         Vf6g==
X-Forwarded-Encrypted: i=1; AJvYcCXszmudOFc6RfLY31MRgSYTNVCkD9Ky+8K6gQVe3PUHCDqDNkiCsZ9/hTlzRYWFuABNTB6OC0h9+YyiD+VJKOPj02AI0ePR3fKMzW+m
X-Gm-Message-State: AOJu0Yw33RmzrQSiTCXoYSN8i1mj7fBaX+KhbiZV/XmAb0hsRGGBCdqn
	acVjuTvkYNqAhbzFFHRl94MRvWw/uHBa+vhGCA7YOUrGnHSBedJ9jJNNm8uxF+MpaNDA8YE9R4/
	0vU4=
X-Google-Smtp-Source: AGHT+IFFSAPnFh48tuuyx4nfdB94kZ30QIZLHyrA1XRTFHdUoc2QgON84c+1iAy9mgLSRlwf3h/aRw==
X-Received: by 2002:a5d:640e:0:b0:367:880f:b8b0 with SMTP id ffacd0b85a97d-3716ccf0559mr440023f8f.8.1723475028315;
        Mon, 12 Aug 2024 08:03:48 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef61sm7762167f8f.57.2024.08.12.08.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 08:03:47 -0700 (PDT)
Message-ID: <0640d530-404d-40cf-9737-0d7468dd0177@linaro.org>
Date: Mon, 12 Aug 2024 16:03:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] media: venus: Remove unused structs
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
 <20240618-cocci-flexarray-v5-1-6a8294942f48@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240618-cocci-flexarray-v5-1-6a8294942f48@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/06/2024 14:37, Ricardo Ribalda wrote:
> This structures are not used, and have a single element array at the end
> of them. Remove them.
> 
> This fix the following cocci warnings:
> drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I realise I'm going against the grain saying this but, I believe these 
structures - which document host <-> firmware data packets - the ABI - 
should be retained in the header, even if they are unused, since they 
are documentary and potentially of future use.

I'd rather fix the WARNING than zap the structure.

---
bod

