Return-Path: <linux-kernel+bounces-218360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E159990BD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF14B21BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8071991AC;
	Mon, 17 Jun 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wE5y9/cW"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C551922F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661993; cv=none; b=IoDOOIpBhM4LMlbqGERrGDvy228VW+6nLa9UAat7HAnB7Dp56bzeOMPJFAaHkQGrc8XKbHFG/R+oVSjXJWsniLXuwkn2hfUICCFLKy+aawkjtJUDAGaYerRXPrGA13YtI84Z9AWoUwHPU7siAQMWntoA30nUaeJqvsIdD/MZccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661993; c=relaxed/simple;
	bh=tIyamNXa6tz8ejQbRuDu5e+MvelcKNwLxIvKpXCtWQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho7J2ZAU78225Kjsd7Oi+wn0azq0oabl+oBuG1ixklRuXFl+5kXPLFhw696E63IUqb1su88CyKqB+RejLP7mUfTvB7x7BnoQbLt84uJ/x2R1FI07+7rvdboJfKVq0mxTziBLGquHBhMp6bLbaPkmZJqhmmNlrXb61Tm1fdIOZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wE5y9/cW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f96445cfaeso2687402a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718661990; x=1719266790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XF9Wi3widohQqYKmTsBWFBb17VuT3MEixtc9IGoIIpU=;
        b=wE5y9/cWk0b+wgSx91Sh/vY/BidJPkHZAgtkFsEmOOaBq8DvrPVfAJqxnxReX0HiQV
         IqH6O858EBb5BaKrYuIjnKtO7dyx7o/BREilUxCacLkFieBWyuuiJH4rS8NySTvOP3aR
         Vk9Zze9JDuXv07U9zSRpRmH6SQgbaRkSuWp2gLcyozPCUs2yYreI3ULpjyY/H4C6vFki
         /XoTgz+IFUNLUqb1v2N+QAsqAnQY+Aduv1wUn/0+41mQY4qV2DwjCV/jxww/vWKA55qp
         fOLNfjiwDmSlDXmnzyY7J82dyBsHbxAyYYtl1L/eyJoU3PjjN4n3D+nkAIB+Sy4Ekde5
         bugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661990; x=1719266790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF9Wi3widohQqYKmTsBWFBb17VuT3MEixtc9IGoIIpU=;
        b=PAHZTVaNwlabsfhSGUQTRzZdeSuPHmeUgtX5N9OfBXE7pHEHgFnkpCa9KkOUbaI3Ln
         ZFOB28uyk+aPLkpar4dcZWNELEr8rjhp+yNz2XNVK6CFduKEsWEwyvr6PoBlOOWDKy0k
         Wz2DImZEy8hd7fdKAEta2E2gvK1ZIuK0j3PzkBefDY6CnES5CG2yskQpEehAk9pXrmD9
         EgfV3fdIAPKiwYtI061PCamdfMKKhUHgDsbyXauU2wf9rwPmLYxbGoG1OuRmyEFjHF1m
         /DqsoWIGpE0FVr+ucczphoSLZZAxWGrTjm4z252ujjsepOECKdRCq9JQjPzJr4DftdtF
         m7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdM7T84kqd161bBhAM5UH+YGdS7e9Flk5T0LhLcFhQWxbOd+ojtDN5EYY8XCelYkLwuydAiVatCc64SgjPgRJYrJZKJei89zHsENwD
X-Gm-Message-State: AOJu0YxGFwIFUsnlRJ5r7FGrrnUlZKUMjum2ME8vregfYzOxc6LnqpO9
	B2UwASKByrvSZ5W8ITnR4Fu4pDLVuVaQP6+OHwjiaF5GAIvQG68I6RJ/9PzaWhM=
X-Google-Smtp-Source: AGHT+IE75SHCMWvDYQLrp6u3YCWArtUacqZgbyNMxMD3rVRg2JMJAssMRMdQpEH1lQInz5P2xqzTwA==
X-Received: by 2002:a9d:6c53:0:b0:6f9:9e11:e7ca with SMTP id 46e09a7af769-6fb9375cfd9mr9479894a34.11.1718661990596;
        Mon, 17 Jun 2024 15:06:30 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1e3c0esm1678596a34.41.2024.06.17.15.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 15:06:29 -0700 (PDT)
Message-ID: <993ef797-51e8-4a57-adf3-1599d9fccba6@baylibre.com>
Date: Mon, 17 Jun 2024 17:06:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
 <171865982439.3455065.3692466445202658610.robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <171865982439.3455065.3692466445202658610.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/24 4:30 PM, Rob Herring (Arm) wrote:
> 
> On Mon, 17 Jun 2024 14:53:13 -0500, David Lechner wrote:
>> Add device tree bindings for AD4695 and similar ADCs.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v2 changes:
>> * Drop *-wlcsp compatible strings
>> * Don't use fallback compatible strings
>> * Reword supply descriptions
>> * Use standard channel properties instead of adi,pin-pairing
>> * Fix unnecessary | character
>> * Fix missing blank line
>> * Add header file with common mode channel macros
>> ---
>>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 290 +++++++++++++++++++++
>>  MAINTAINERS                                        |  10 +
>>  include/dt-bindings/iio/adi,ad4695.h               |   9 +
>>  3 files changed, 309 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: single-channel: missing type definition
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml: common-mode-channel: missing type definition
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

I think the problem is that I don't have a well-known commit as the
base-commit in my cover letter (oversight on my part).

single-channel and common-mode-channel are recent additions to the
common iio/adc.yaml so the types are defined there.

make dt_binding_check did pass for me locally before sending the series.

