Return-Path: <linux-kernel+bounces-221656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F090F6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AD11C2441C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5565158D66;
	Wed, 19 Jun 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzL1LY7q"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5A158D65
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824668; cv=none; b=Yh1pfb9PNT2l7zicpirt271nZVqkiEEQUNYa/HUha4AZwNa8MQlnVApq50UISX23Y8v3IF8NAtX9gMuGL+Z8+rRzTVL8Qrb+1kzgrcNKJ2L//EsqDNJ2ci4QGpLI439rlIb9nzyvkiccAkCyrMi/GYHJ47RPaSE/GWDCXRew0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824668; c=relaxed/simple;
	bh=1f6nJxwFba9DqcGw62muYo8R6CFQWJeLoHkZBBpzB8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIYuxkSh4nHYP1QOXvQgSt6n6s2jRh0AFgNFvEdB17jZa6qetB/VYcOBVocjQ8j03EOaZeTbrIvk6qaz9R19VLGLYzbrvwXI7fTz6L7ECeOxd3uT24hDcKdH3c5cXfO7wimeYBRtXrArZfRhjKOIozpdcVOLf2SERrQPJCPYd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DzL1LY7q; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so265049a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718824665; x=1719429465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6lEiYCUbYz4T/jCjzT/Chkny3UAUAGhEY6ZMmlWnJc=;
        b=DzL1LY7qjPs8m6/PcadyIjV6RD78Nm/DkzHMeCV7kxbZCr04Zyc0VzOl5HS2r8umCQ
         y1qyRV8sc4IbyNnsGAvmIBYSqTHJeQjJEvT0vMis8J4h5F8q76si9/zWso6+KmmD79Vl
         mmneABNZahSw/eFEKazksGFzB8kZX6yBrlmhg6NwsTsBBbCihLrJBtaSL1TC7BicTExg
         y2bN8K1lZp8Y9YOGQxfrABGB/yKcMIfnSLl3T1GOQxG+SbWHowZBmVBE2+PUojs6MSHq
         EJWa17nXJ6gxSxuI5F09GEypM7Zy1oHTWRpiostTklgrpvnCrSiXaOvpCVYMktgUIUVC
         8T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824665; x=1719429465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6lEiYCUbYz4T/jCjzT/Chkny3UAUAGhEY6ZMmlWnJc=;
        b=VqLjw0khHldQxZYuACTuEc1DoDIEQP2m2mOo/Zy5H53bTfUMi7+Pv1+H5Q0lV5OGRB
         FhmXIlTt9PM/zWGNceYhSoben3whr9GC/Y4JSY5brB0aO045mASxozFPPLwxT48S9lbx
         dX9k6QaqRhKyxrhWmJ9n99PPAjLyzMvwRF02pt2M7Z8OiozKEnMPiIHEesLsDmBoT2GZ
         RCmQzK4EEBgGxrQxLe3OzrjpUXdiW9MrVjcc9lvYJECdaOkF546IJne4ez6RFKXrX97+
         tR3oy/W/BQaK0f/WCPtCXwXFZnu/vxCtFQJNxU8262jp4v1c91ooG+jV0DZsWewQg3MH
         cbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNamgbu1brgkmJ5yMb5AxXy8FSG7Lfn2b1rbPO9RjpZ1Lyy1AW+f6wN/O4YXq9zwy/T/7O2i6BrRFtebo8vMHbW+Ww3RP7t8JXZHwD
X-Gm-Message-State: AOJu0Yy94qjIr76DtR897/o8RMH+2EensU6dgO5rMgqMzKHEkxskrDJK
	YS19rWDIao+g4ZXTgBWg1SMe6aeNA7lGrO83sVId6ofGjjNc+QvUbPbTI8REdTI=
X-Google-Smtp-Source: AGHT+IGj6k332wSqup8rGDwTMoa0gt8RHUTehGLRGJ1I1Zn1p3Ya0Wruu5YmLmNeQVUfoZf3JBxyuQ==
X-Received: by 2002:a50:9f6c:0:b0:57c:57af:6e88 with SMTP id 4fb4d7f45d1cf-57d06a1a6aemr2498410a12.9.1718824664686;
        Wed, 19 Jun 2024 12:17:44 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4dba:9578:7545:6874? ([2a00:f41:9028:9df3:4dba:9578:7545:6874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743adf1sm8651050a12.93.2024.06.19.12.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:17:44 -0700 (PDT)
Message-ID: <7f6434e1-8a7e-4e03-8932-c8ae7a04aa91@linaro.org>
Date: Wed, 19 Jun 2024 21:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Use mboxes in smsm node for all dtsi where possible
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 18:42, Luca Weiss wrote:
> With the binding and driver patches queued for 6.11[0][1], it's time to
> update the dtsi files to use the new binding.
> 
> [0] https://lore.kernel.org/linux-arm-msm/171840533352.102487.9576671528001022676.b4-ty@kernel.org/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=drivers-for-6.11
> 
> @Bjorn: I think this makes sense to only apply these patches for 6.12 so
> that also in the arm64 tree the driver will exist already, so git bisect
> is not impeded by that.
> 
> Patches are just compile-tested.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

