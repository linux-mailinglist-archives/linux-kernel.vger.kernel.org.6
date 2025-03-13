Return-Path: <linux-kernel+bounces-558877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3FA5EC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273483B158D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6251FBE9F;
	Thu, 13 Mar 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDubTPKP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5513A265
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849991; cv=none; b=NqOyC3McoTpCwgtbTdsIYMl8vP7hbXAC4SqncpEr/4NPkXQfhW3usPldsYjkLlaqNptyuEbajidUg30RnXquXpZvqOy6aWr7O6iuZqxZcRp6p/lnLg5i/bMMoovccIzZcHz8Aj/3PpHm0uPTGJNjefERJB1fHrWO+8fVc4o9pME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849991; c=relaxed/simple;
	bh=RlkKnSO9Op5zAuttnqf+oaANcdhLjxjpG9k30kOAXL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+XUAAP+p58Tzc3O3EaMgHPqV4uBRnxv2+kJK5oVALcKJ16IxOupT1C2RjZX26lVVWyjyvoY2DAUjolwfeiMBI1dewJME428pcn72TbsY9F7y+jDDwNn23JjEzD/CrXNwMS1QFMgXrUExfwvv76ZkrsQFb2rXfyDuHX4WpB3k74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDubTPKP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac250d158a8so7625866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741849988; x=1742454788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxpm2eADKTJ0HNPt8dE5MWzYOLLZtxS5F6staQWLbBs=;
        b=fDubTPKPRCta2Kj1PUeWnQE4aWrLBJ/NIeYkMy7Od6OeHzyEVK1Oe5uEQHwZ/eRG8e
         UGf8RhXCfQZp378rK4PXl28GQTd4WPzWPqB1C8bNCtCIJivTF7h9XuuQLMEHwJP2kFBj
         rSs3/J4kGIzzXS1mAINPa6GStEfDX1Larz1PXZ3eikbmfialrJ9f4tek8Y7RcoO5HsmW
         v8zx9p3VkeR090s9qyRMrv25V7VIRc1wgaZgfisyYcADisEeINIzyvpPuI9wjkvT2SEs
         u68GrH+StgJN/daN1fcvJc6O7Y2YbSuMnp/FxdknqkethS2qDmcM3JGRaTHktQbP5q/J
         MmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849988; x=1742454788;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oxpm2eADKTJ0HNPt8dE5MWzYOLLZtxS5F6staQWLbBs=;
        b=BHJyTJOr+KB7SMAou4Uv4UmQsYUKrmd53zcJkp8bv7jPa0AdE5Hhc+drHw4nHnweEl
         8WJowfB1VlXn9g2ig/O5EQY9Ic/KOnYlNdDtPO50qxDewkL5m+9221CGlb2THhccAjbJ
         X/+kpc34dCJieTkgoWb7X9IyvTpxx7emvnQ2wT62AARJ9dwxIRAjc36lRnoZgnFSR5sw
         Ggpclmon8ZTJmdyfMFpklzKVDaD9JV3wkfW4ckxaxNUtI1A1Xa+MQtHkWtq/K8cVjp1u
         GVsuGTOR3+l0+T8uAtBc7JZI0OVcXqmcHS43geZvmMf8kxyEDxAZ+PicNU17BUEQQONE
         qRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpMJqjNinJ2RjDKTLWkoKrvBrOkfb5ZFwiwROOGKPlQpjFG63B+A7ztMyTJ3s1q2XbXRqotkA/gJ9EqzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCF+y8jGmFC68Q/gIECJno6qO0xBeMnzte+r/2vHEBlQovdiOj
	jl7HvTZqIPRZ2q8aXrKE+/4y0N/7cjB4h/ldMabzels0woLCDzKBVDNeFPQ/DXY=
X-Gm-Gg: ASbGncsWvVEOr5gHBX65cMZi4LIZH8CsYNDeg9sR7eu/WaXrChd+Z9tt0v0cKjsL9Nz
	qVl9gkPW1hic2LXFSHxafPbJfJZMj2cqxkXVJsT4YwqSX6K3cSOkBNErPuSzmfFyYWGY8E5wrgN
	CT0FbfF03E6zI8cYBPBb5GWA8/k77j7RS3Z0ybRM4cGUY8qHbf+GaJMfLpDEcq1t+6EcJLktrzl
	ENCVIhwCrnhl950HL7eqoqICcYCIFzBMfIYAF5Bd8fzV7sTV0aVIwxtYa2QFdt7zRP4jxo7EwmO
	68BJFg3kw73mQJJj1JH1z4WCDcKTeSt8MCT0GZuZWsxlk3KMXNcjvwNUOaVU0bA=
X-Google-Smtp-Source: AGHT+IFUhUiFu/mjetItfFFKDDSk1YQbc4560vtLNugH5OGNSZVSqwqkrR3M4x4BmHABYaUJnnfcLA==
X-Received: by 2002:a17:907:3e0a:b0:ac0:b71e:44e7 with SMTP id a640c23a62f3a-ac2b9ee628fmr460280266b.12.1741849988300;
        Thu, 13 Mar 2025 00:13:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac31484b234sm45565866b.77.2025.03.13.00.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:13:06 -0700 (PDT)
Message-ID: <13c6d57b-0235-4c8d-95ef-111f87d6c25d@linaro.org>
Date: Thu, 13 Mar 2025 08:13:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: Add cros-ec-ucsi to cros-ec-typec
 device tree documentation
To: Jameson Thies <jthies@google.com>, tzungbi@kernel.org,
 ukaszb@chromium.org, bleung@chromium.org, heikki.krogerus@linux.intel.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org,
 swboyd@chromium.org, akuchynski@chromium.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250312195951.1579682-1-jthies@google.com>
 <20250312195951.1579682-2-jthies@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250312195951.1579682-2-jthies@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2025 20:59, Jameson Thies wrote:
> Add documentation for the cros-ec-ucsi device tree definition. Defining
> this node will load the cros_ec_ucsi driver which is used for USB-C port
> control on PDC based ChromeOS systems. Additionally, update mantainers
> list to reflect changes to the ChromeOS USB owners.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "device tree documentation".
The "dt-bindings" prefix is already stating that these are "device tree
documentation".
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

