Return-Path: <linux-kernel+bounces-225671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DC913387
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14733B23281
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FC155332;
	Sat, 22 Jun 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsvyzqC0"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D114BF8A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056933; cv=none; b=BlAYo8gPb6Wm3IDiD/0KKzhgt2YrJFTQkfQYD02kvKZ04DXci2O92zysQsqSX5KoPlzzJeeXK9w2kHALIBLgfMk5kLOz0fbHBoCeqOsHupAglllEjhNuw2ZxQKQH3gN/o7/+GdNbYbs6nL2EStWzWxV+W80nlZ71AF9WjbOB9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056933; c=relaxed/simple;
	bh=64yO8JfGv2L2EdkUtYfsGwvZ48+tCTCotY2TqOzKbQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF24ZezmQjUCBNf/Z3IZ5uJ/NNKFC1lvD3Tegq1c6PrAFbjmEyt0bQrjcX0d8V6kKztR2N1Hb3frDMhBKwZxgOPO3r+bS2fBDRMPiA9S1i6y+xNAiqkEnR+NxHIXw2fEMf8dtIl2rMmyTONOpro/83tbxTUBBpotKVb7QsNSS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JsvyzqC0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cfe600cbeso3378005a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719056929; x=1719661729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Si+0+Udt3TumPYpj87u59+KPSMEelqrx15xLL3IUjzg=;
        b=JsvyzqC0/Zr6zOkTWHxPCxqgTt0b4572BhpuVl3gLusJv2iOqmxwf6xAyt8OARjS0R
         vTxBhd0xcu81TV1gZz/yMbvM3UAxEgyyKq2rYUWCLtDWT/vLilcil3ABsQ5rzRVSbdsF
         CFYzpZuuC8/hdJeEYng2OwkgvVQ/HD+f9+HJE/SwwPf7tvkSTsaF3+l6a9CCtcGIzqBc
         VDwNnmB007BMbbfb6VzEUzmhLxyhKbXz7GaToCA4YQk5M7kThTHAwl8q8g4/2Q68PPaI
         uYqZX3G/F4/F5hlK3LZMKXmwz5gTGQn64BTdoT79Xa/gExuIz8Bxdl5kxUKSE5m2usqo
         5NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719056929; x=1719661729;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si+0+Udt3TumPYpj87u59+KPSMEelqrx15xLL3IUjzg=;
        b=SWrPS9QCaZemUeMGLrUtGOodZIQdEffkvhXnBxN4irYvoNe70qxLvOC/dMO3e8yMNn
         r4MiLF//1von8DwjjHqrZmtsJx4TRSXiYRf4KKiTdzTRycOs22dLr13LKKEwHCX1X0La
         OCNGemzgKhlIy7Zk++rP9emlGjl5z+HlOeqE5VPRLrz/No8c3Ph1jr1HmNfE+2XPyzrg
         Zf4Fq0TSVaJSrMH0MQhlfeOnppM2f/sOm7g/bcK8qCcXmhCg8U9X/xDcA8DFOSpWk1XL
         XDmWFxguyptZzMXJ7SvQqBhlrcc4sJDYF79HDBaOjxZo4XHWmNii0UjN0jHXdLlLhOvX
         r4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV30FLidxf2XCXQbYBVMVTppQy7eDHb8aApRanRMqkkwCH8Ce8WTRyCOgoOBsgmYLzyppP5uz30TvaZNTNSLSzbm2B3JotxvPS3n4f5
X-Gm-Message-State: AOJu0YzwTzdrkaK5WfVrWHMLItVDn5pcBd7AWmYNUGgPEPjr4iwTQE2a
	gXLFx1T5xGLh0Qga3K3eHCummHDs/RiJidZxmT0HYqlhb9LybvkvuzgDwY3jTaQ=
X-Google-Smtp-Source: AGHT+IETsmUp0wg345dn1k6YoCEgM27JTx2/WGxNpwXA2lrAy+TNHTbiIiNfA5B4wb3j7PDAkVxgug==
X-Received: by 2002:a50:c30d:0:b0:57d:261d:f825 with SMTP id 4fb4d7f45d1cf-57d261df8b3mr3767209a12.21.1719056929128;
        Sat, 22 Jun 2024 04:48:49 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3041208esm2237898a12.30.2024.06.22.04.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:48:48 -0700 (PDT)
Message-ID: <2fcf909c-10c5-41b4-9962-d085e7e2bf5c@linaro.org>
Date: Sat, 22 Jun 2024 13:48:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ARM: dts: qcom: msm8226: Convert APCS usages to mbox
 interface
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240619-msm8226-cpufreq-v1-0-85143f5291d1@lucaweiss.eu>
 <20240619-msm8226-cpufreq-v1-7-85143f5291d1@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240619-msm8226-cpufreq-v1-7-85143f5291d1@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.06.2024 11:02 PM, Luca Weiss wrote:
> Since we now have the apcs set up as a mailbox provider, let's use the
> interface for all drivers where possible.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

