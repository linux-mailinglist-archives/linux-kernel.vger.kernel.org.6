Return-Path: <linux-kernel+bounces-577169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C8A7196F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283BB3BFB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138421F17E8;
	Wed, 26 Mar 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKLUqt1R"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8F1F3BB6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000536; cv=none; b=q75sQV0FhICHkjnvuaxlQbQvt9uTqmnpElAjLIs2iKLwgSVXZWT7awBNIqUUNCnunl9eKs/TVq9afQYBVkY24lefP6SSfKljcj1dE4f9/11T2iASXicF3TReTHcq012XOffV5VCpzLAE7iWX/HJBqX0fl37FXSFx7TCSnPBndQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000536; c=relaxed/simple;
	bh=V9OPN9ZbeHaXk5j2cNowUnTpyiTZNQfQrH6Jh2QA1EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL5ZI1HvlUzX3uQjugYvaK7xiSx7nLVkhsir6+NwdB6MgVX2uRL3qx5R9wXVRsXwzbokAmBbNdgEykaxf8Wh7I1KgRENn9ujQesAo+mG1mdR8dc5ChqKo00q7IMJ5QAQvGay2RCANscPLX11LNgkrtA0jhiJScRVO4++M16hhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKLUqt1R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913fdd0120so3847473f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743000533; x=1743605333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7F63w5WbLJMRPxYzdb7qfC13R+bJpmQhvYwda9HcaI=;
        b=iKLUqt1R0jYGBxutzkmCFp3S/hyd2nI/oAS5cvHC4Q3r8YLPrxaMMk80CB0cADdfei
         y3GH4py+9YotW7Gb7TGwKSyO5xR9gAHL7yU/NJEo2/xXd0TOSxzKkMu33mjCSANPKxf3
         q6/NV2O5sf3qKitahjyy2QNCCpU/Q52SK95YDpIAivVYwjFebMhzB0lFwjnWFZDWLDvb
         cIsSskN50bBS8sakBGAUbPGWiIa9bml6u9bPU23c8iyw9ZCAk7ADX1bDpxXF7hYILyai
         ijtnVlfOcDrPIYV2xltXGIGjki4wVwd+KXKHvOBchvAtBnsVt1HBA8kYQ69UH9eO/foS
         nbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000533; x=1743605333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7F63w5WbLJMRPxYzdb7qfC13R+bJpmQhvYwda9HcaI=;
        b=MW9hTbI8coi50PUo1LSYI162cZUmsghR0E4HY2LtMoZeXjqkOj5VsTNplvJrGnWe7n
         YPL8ILU9+s8aJZVK3XjL3tO2I+zAqlwRCNJoiMTpmtfYhDLsunnCBjA3uFyvc0vBamH/
         T91LLc4Rgs1pnJn37diZ7w55zY641YK67eI0fy6P03zXnJeqN1PosD7CENDjlZ8F+AFE
         8BFfaO8vBw1bYb6F/T9v278Ckl33jOGW8Q7+dEGfsVPnewPUpsfKfQtyz5tes6QFh3M1
         a6iqapkXFsn/Jrv/WJNZj5i2xWlUt9i2zp3wD4Fb4L8Giw4VVqXUngLpqCadGXhVj6NP
         sRiw==
X-Forwarded-Encrypted: i=1; AJvYcCVaeeOpImoqZQG9zSSvP2nJavI5ZWVJ+qEzBhN/EcbADwVZ76Ir8uzuUzzpmhjPd7pK//ho+NxKEYkKa4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSwxIFx0UXqG/UeZQOuyIPM9G6vIR22E75IF9xztZfSfnUpvH
	edYabsiiXiAGTVivQB8397oLnOu5MDYZR1a1m47IKD+6pUwwXk2NNtLYa25js7E=
X-Gm-Gg: ASbGnctQvTJPKJJsk2zfJOMtRaTey1S0YLep2aAHscmPm1eXmWuDNSACF1EfJcXpFJj
	d8ibJOIBh2GSKo2Bw3p83gZzXvHufFVOe8odN9n14T9ZwwDiPRp/fHJJ4lUXPwtG1uzCzqkmE6R
	XEk5GnDuz4LUjXesR8Ed4fO0vBqeXj5YNWu/JtZewZ9OLU7uqiZkXBkvatyk2Y9U8OU3cn6/6yD
	0kB8oWTPongBWjLSVyBA71RbS6pCgyQK8vTVkdZMZOaV8AECKIL1vRptJvo0liRjIVqmse2dCNh
	k6iFKpjaPYg89DCY05DqFi+S86JmBcUiP+MN7GeEyxvm3gVrAuK/rpA=
X-Google-Smtp-Source: AGHT+IG054URsTL05MtZIrzYoZ2nRY1iaq/5fvUAR6DYti36wbbvJ51FuVkhLdk4NeF87evX5MRxvw==
X-Received: by 2002:a05:6000:1864:b0:391:10c5:d1ab with SMTP id ffacd0b85a97d-3997f8f61d0mr17080409f8f.5.1743000532936;
        Wed, 26 Mar 2025 07:48:52 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef1f7sm16901316f8f.82.2025.03.26.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:48:52 -0700 (PDT)
Message-ID: <fbad733f-d034-4d63-ab82-ed867f0ed5d4@linaro.org>
Date: Wed, 26 Mar 2025 14:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/25 2:25 PM, Mukesh Kumar Savaliya wrote:
> Hi Mark, thanks for your comment.
> 
> On 3/26/2025 6:34 PM, Mark Brown wrote:
>> On Wed, Mar 26, 2025 at 02:09:54PM +0530, Mukesh Kumar Savaliya wrote:
>>
>>> This change introduces a new field `dtr_mode` in the `spi_transfer`
>>> structure. The `dtr_mode` field allows protocol drivers to indicate if
>>> Double Transfer Rate (DTR) mode is supported for a given transfer. When
>>> `dtr_mode` is set to true, the SPI controller will use DTR mode
>>> otherwise, it will default to single transfer mode.
>>
>>> The QSPI controller driver uses this flag and configures single or
>>> double
>>> transfer rate using the controller register.
>>
>> We should have a flag in the controller indicating if it supports this,
>> and code in the core which returns an error if a driver attempts to use
>> it when the controller doesn't support it.
> Have added below in spi.h which can be set by client and controller
> driver should be using it to decide mode.
> 
> + bool        dtr_mode;
> 
> since default it's false, should continue with SDR.
> I believe for QSPI, it supports SDR or DDR, but it's not applicable to
> standard SPI right ? So not sure in which case we should return an error ?
> 

Please check how spimem is dealing with DTR, same ideas shall be applied
for spi transfers.

Cheers,
ta

