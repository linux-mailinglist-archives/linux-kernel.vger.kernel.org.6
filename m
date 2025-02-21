Return-Path: <linux-kernel+bounces-526095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF7A3F9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8584D1889777
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1751FF7C9;
	Fri, 21 Feb 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sI7rcoyx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E811E492D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153255; cv=none; b=VfAWMiYLjORyFy7ed9bJLJDKHuw2gby0kJ5o83ylRKobOI2SCozdLaQAt06lKD3HsBoBts1wfWF4OIxZPpEIckmRFTj6R5ws8upvptRAnh1WeTr7I48iOjVH/l5cR8v1kT2tZlar3XA6E8tfg92LNfNmwq3uB9s9DfpLNSfUmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153255; c=relaxed/simple;
	bh=CfCvpuTqzzhtP20uji2W7izjB3m2XqIJiZMIaE37t6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw2L6FkEs0r+i/3uCvBPmn09Nxo4qo/n4TsJsDvo8PgBisXdE+vvx79PGeeYPLsenERob5SzzasRP40l1hPxyD0XXLww7Ai0GVTvqv7hH1MEU5P3B9pXb4Ad1VJf8wP4dz5g7u/jZVggNzDQIYuKQFgzAFz62IXR3cz3VQLdrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sI7rcoyx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5decbcd16d2so423173a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153250; x=1740758050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EzQ0Vltnd1y3D0bPYM5ely+Sh/YWbfp392aoVTkuNCM=;
        b=sI7rcoyxR7KavyGtkZtC8+U//s3qiy87i80U/7XzFnsfMziANaUEsK25X3GqdlDP2g
         O+2U8OdWnklM59OGThNIxMO+OV0HEwDN+6XAdyZ2H+6kjJXDF+88N7jR+I7jQFrXsedf
         KFqOzfqAVAoMT+OlxMfq9kGqubu+4FiqPCQQ6QOj8WltxiFpnXVQw5Dxs7suI9FzORsq
         KOY6N7+z/7SqCkkUfzlDh2N1ZqIqtrVdeHBMFKyZ2J66fwy9BOiQbTmUu9o5kNBVQVo2
         40iddnCyx2fKTCowaOSuETpDGLVZIzgfnNwGBOUQQvhL9VaUW6S/Z3xxFDq0YZBvt9UD
         5DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153250; x=1740758050;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzQ0Vltnd1y3D0bPYM5ely+Sh/YWbfp392aoVTkuNCM=;
        b=cZLuNqP8gA8+kipfWBeN1hwx3GfOCNiolY/sgIY2V+slg7WTOob26XLeWjkZjxu1+E
         LhOjZVslxWoiu+M9lNMdwbXgf9J5Twhmy8IFCg8IGcqUZmoADqrhB84aQtZpIA1keRTG
         dVYiQk3IHDG/OXyMMWkkWEofUpoxJrsAWl8+VG3x8AnVDjnGt8wRLhTsdHwcrB2zTsNo
         Com3Xv/rsF2G+Ebc4oM3U2PkEot8zdhvW4mOJVsi2aVGYkm2DcuOQce5sGAoPPQDKaN2
         jATRXUgIS3FSb0kxngXxb4PRHDOEBDSq9jFOIgx9aNt5SBX6nG1bEmslf9rS8Ab1GQB/
         6FAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwC8PaNEktf+Vg9n8F68uik9k26kugxuEznhmSPPYD89jLqatob42gwGe2OT/bmReHENJ7P3psivFn58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXtCaW2I9zIfx4s9bFtzhpPqpJfCoEzBtjhu1SnAFh75l39kj
	DgWHmBg5ZWwidsf+VODylYfjJIA/erkD7XdXqFbWAy7I0vCRp4UARCK3rNsUxKo=
X-Gm-Gg: ASbGncsh/YGef5y+vQsOKPX7q0X43a5M0xREaeyZecHYyxzesDHounuGTKjqA555JJa
	BOl0Gm+NM/UnIyjlYRVvEo/q2lBVF3dz3/4M4PwgBbnHJwwSoZjlGSYcw64rxkTivHByqUjou0i
	3E9eYxd2/O+I6k2AC0mWzEqxk2NJdqMXg1JNF4z3vcZWfTMv2j8iPD6x+fQLqw1ICCnAvNHN4da
	L9Sypl8L2fhQCDQMw14wLDcoTJzQ0sg2QdzFqHuDeuQocNLKGuF++ImSofv7y7O8gW9Y7K9gr4L
	SooAkI0uEk3EA1RiyB6/2Zr1n4mUcXIVLvM3d7YhtAW10N30YaC309KkdlpvkSynRcEqf4hDYYs
	nICj/mw==
X-Google-Smtp-Source: AGHT+IHCxNakJnPxBfmF3PThAWb7w33DYWx2nK7ZR/nCbdPYSZPxxF9wogu035bPESWbRTKcZDlEZg==
X-Received: by 2002:a17:907:2ce3:b0:ab7:cb76:1b0f with SMTP id a640c23a62f3a-abc09c13ac8mr152984266b.12.1740153250156;
        Fri, 21 Feb 2025 07:54:10 -0800 (PST)
Received: from [192.168.0.104] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba3d765acsm918800766b.130.2025.02.21.07.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:54:09 -0800 (PST)
Message-ID: <72bb815d-4992-42f0-ac5c-90e971d7a62c@linaro.org>
Date: Fri, 21 Feb 2025 16:54:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: remoteproc: Add SM8750 MPSS and
 CDSP
To: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20250220154132.199358-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250220154132.199358-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2025 16:41, Krzysztof Kozlowski wrote:
> Add remote processor PAS loaders for SM8750 MPSS (modem) and CDSP
> processors.  Both are compatible with earlier SM8650 with minor
> differences:
> 1. SM8750 CDSP has one more sixth shutdown interrupt.
> 2. SM8750 MPSS lacks fifth memory region for Qlink Logging, according to
>    downstream sources.  There might be other differences, because the
>    modem currently crashes after starting.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---


As Dmitry suggested:
https://lore.kernel.org/all/7ge5bnzqggaeoyme57sjbchehdla5icblyjc6jiop6f64bfk5y@gobmmlvp3cie/

I will split CDSP and MPSS, so this can be applied gradually (if needed).

Best regards,
Krzysztof

