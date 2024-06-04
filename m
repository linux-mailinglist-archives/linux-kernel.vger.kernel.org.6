Return-Path: <linux-kernel+bounces-200510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F08FB10B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037D3283A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398B1459E0;
	Tue,  4 Jun 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IICL0nSE"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AF144D3A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500301; cv=none; b=sS+8EylLlLtZ3Mrhy2e6UtXSGD5UebGkPmDA+ibJ+DWQHJkZibT1M4rh/Dsgt/+Uzvu+EOLJJ/f30/mRp0PNOJpYBR4VzuHAsi8sCjZrupuWrsKiVWMLh116pU3lQ2sH7uv3D3aKvCD7OxUBRxlxBeW2ouhoA5LJr5UQj5RqqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500301; c=relaxed/simple;
	bh=DtUeQV1ibqKPq8E36su3OXKep5Fe4xTp9Q9KaaYfPT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/9kJEQ3vImgDCwejhGI0PYku3m97/cFAFNBi9b6/++bc9Z9VXdjCRuedbSAGhVFsAm61p7HdU6P+IkXJzaBonpJVQBhE5vbCVZsPkVCRZ3MUvzwu90QgxOBz01TDaUBZOwIMeDCENXZbOfOFBS9tqVcqES1gElVCXwShMRwYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IICL0nSE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so3505170a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717500298; x=1718105098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVoi3iNWHI3Z7TLG9tBj+kYKQu1J8puEVn0QYvkaoGM=;
        b=IICL0nSEsvhoAbnc+dFgCuERPvwbWmUS6MUNFaLbW8m2p+LwBP20Ndb5LdKPFOj1RZ
         HBJQVaNeIU2RtCftg75ClS+uVWmWOX28z5i2ut8GUNDpxG9qtmrc9lTyciD53pnGd/58
         /cmqXly9ZyQOHm5ThTedbJt7UhovSvMh99wKHPRIpUolgj29TrAB318ZRbRuxVREMHx2
         BlYN4G2QPKNMx6jEwHw7vZPWw3cgT5GdyAkgOtQR9KP+M8Wfl3zDmKMRxeCOF4qKUmCH
         b9A3SRlmSG3awgGo9q+KhjQR4MXgsCQa60Dq6B1rIoZy2XpL5tugV6i/UiE0JQJkcWxa
         YLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717500298; x=1718105098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVoi3iNWHI3Z7TLG9tBj+kYKQu1J8puEVn0QYvkaoGM=;
        b=kEK+Y5DNM2hcpRV7khrBGF8G3nU18oLUJgEOLgsDFaN1GXIif+uRkHh96dGkT8ultK
         50Hy534Q/JXBNsPvMXOsujecPZXQx7MbMwZ9lrJiSS3IIN+kCVG2NsbCQFO7enuGxrgE
         D4vSAdYkyLqJcH5TuaVRuWQzo/W6LTuFKYkAeN/FKZAknmikznRA98W7ltQXNIcsiMt2
         jvFagLBeYIPgdUpBpAZFxOiSbuE26YemhCsy/Em86oWDAGSH7sjDwWV7lW696Ax4xg6i
         gnxIvwQAHy4oXmGEVshKmi1wIT4T5UbqtsTGQbkMjnjdXlpAWde8ufTbvtCxrB4Lhlop
         ylyA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4s0REgpAMwwQVYvn/pURP0LFRRrWIgQ8MoJEXfw+gpUfyxyGCuzgdaz13r6Bxv2lURNM8c22X+gm09OPebwnfrXR+D4t4rJxis2E
X-Gm-Message-State: AOJu0Yw8UKnWv8+/QNTCjU76qNI8Bhc6KfKG9AvM8mBlYoMQq/TUqEQ4
	qPmGCHku0TdxQdnmm2fnf0vE/6IiJFW69fWCtmk20N3W2G7EXLvs57rZ2t3SG4A=
X-Google-Smtp-Source: AGHT+IEZd47sJXTMV8uM1ryMX51yN7d49TYJ8zD0MZBF2jijVLZJHBuPnjltlGAa6xBy/w1X1wK6lg==
X-Received: by 2002:a50:9992:0:b0:57a:2546:2512 with SMTP id 4fb4d7f45d1cf-57a36456201mr8060554a12.34.1717500297614;
        Tue, 04 Jun 2024 04:24:57 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bbed6bsm7185517a12.40.2024.06.04.04.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 04:24:57 -0700 (PDT)
Message-ID: <980b0b63-ffea-4bbb-ba47-a0c84de5eba4@linaro.org>
Date: Tue, 4 Jun 2024 13:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] misc: fastrpc: Add static PD restart support
To: Bharath Kumar V <quic_bkumar@quicinc.com>,
 Ekansh Gupta <quic_ekangupt@quicinc.com>, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-5-quic_ekangupt@quicinc.com>
 <f0dbb385-6aea-4721-92fa-a1f560fc7c5a@linaro.org>
 <2f52b206-3fd9-4508-b9bd-23efc5fb637e@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <2f52b206-3fd9-4508-b9bd-23efc5fb637e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bharath,
> 
> Thank you for reviewing the driver and the patches. Your feedback is 
> greatly appreciated.
> As you mentioned, our current driver is a large file containing various 
> APIs to support multiple features. We are actively discussing 
> modularizing the driver to enhance clarity and improve understanding. 
> Additionally, we are in the process of creating basic documentation, as 
> well as feature-specific documentation for better clarity.

This is really great to hear. I hope to see some patches moving things 
in this direction.

Kind regards,

-- 
// Caleb (they/them)

