Return-Path: <linux-kernel+bounces-444397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535759F0624
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7FE188A113
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D71A7275;
	Fri, 13 Dec 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0Vnkxhl"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32D1A0B07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077594; cv=none; b=pL02zoo6K6eXBpSlTh+EguY6DAuun3EYPv7W6ekleZ3BgoYHd+L9to2cfa+i0jryg5Kw2SWwEpTrqcaOIGqENcEp8w//CTiUysQKKUT/zVtJeWbRfPcZc+JMQQk1IQsxiFMT6kCP9i47YCSB0mAJO6+WFjsKnSiDN1/8vBdKaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077594; c=relaxed/simple;
	bh=L8+jNle5JOhNM89zVW8yJxWxsKfxalaeG6wDpSPmqMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mREvZPGALoapmWV+WYBskkMAXtr0IW7K4Voq/z8rpSm75Rw2Un2s+ZQCjRIa0Zz9Z2mDKDkCHK+rab4amTtkSgrPoi/nO/6OypLCA86bbCINTD2akB+fs4yj+eAdePbjXEgkBeNQ7rNwZsvTlf0DBrzo9/2U0V6wmmY3YIthIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0Vnkxhl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so2287316a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734077591; x=1734682391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ax9fIlDokPVT/m7zwVLOWjC58ZMH8YcqVCp3qT1D65k=;
        b=G0Vnkxhl3ohCH/sf1DOHWJbTbaUDPHVTs5/eb1g/+lPtadMKzBM9PgAwrKenUG6rkj
         g56FLrMnSRyXal49JLnyIMEQY/UAgTeXdIvM0EYJ+tgJSAqmlFe0nK1XKoC9x8+Dtdjh
         MhIA2IRaLl0aVvm6uuJBwzPHHVe+tlYI+9bJaWUpmA7l/+WHnNw1MIA50TlSclK0TZqL
         kil8UqFKZAvzJ04ZNCYIOA/e2MQLdvQlDdJ6DYoceVFZ2yn6RtMPy0kto5MtBOFfoQT+
         2bU0tKqRT1ioMANQJ2IayZCv3W9kle3lmQ727HHJq25kgKqQaOG6zNDTAxzsiNqNr6M8
         Ni6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077591; x=1734682391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ax9fIlDokPVT/m7zwVLOWjC58ZMH8YcqVCp3qT1D65k=;
        b=HROV93rHUzM7j45c9Ao02FGCJH1cJ2ISzFqNimQgX5WLFYM33o6cD3WqM8JfDsHBFa
         H9LCtT1dI7/z4vx8MR29zwxLlGqwx+LHxITKJCBpS1pHVV3HdIQTGenp/roklFM1ogI8
         uu6IWfmPZnzVjLvXbDlF7Tu/SBJ+0+DABpuI/nNgPK4hhMIgoO0AkCNALtWaYNnxSEhq
         VtwvmKskqE523+a8+SyBXRe4hdoDwKBitEYe5IndhbL+tgiieMt1tYJ4jnvRz1YZnE9z
         kKTIAIOsdwLhHxlLpuvQO1uvFWqKA/Oy0xqSsnZJFI/DmrzlmbKC7El97QP/l8XZ9sfs
         kiMA==
X-Forwarded-Encrypted: i=1; AJvYcCXmKR92X4UQASIJT/wwCqzSJcTdrwUZ5X/PUyHBg0dy3mSEAjUoMXSrU12mcCTz6zjJY1FAq4nFmK53SeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexmMNlytFXO3hPH8NwZkzA/P+J/ajGVekuo3KGnJphS4KSyf9
	0TEKM4owPZ+5hKTwhZVEnQqoL1a0WAgzsR2481dBlUJISCU7dzHb2EpZdwHuPYs=
X-Gm-Gg: ASbGnct+NAFEjKtrHcseeQ1Nfxz+UWtwAMVfRCC3Q6shoTNDWktisJZgZ7Cjhjul8Hc
	vtJBhDS3Y63vWzopWDebDPm1YYadlPNwuD2AJgrCV0yNx6fGU2iIukeSd/FLGvci0OzWhvV363u
	QZzTUPWvGTuN6H3ATTquIvP3S/1l9D/BQ/7BG0A+qkxmQmyeCnOVzL9QekmvLnNNJoV/b07NMxx
	JwJg/g5z4nGpgL/8MhJF55PyjfZBPIciRVVM5njRZ6YSypQJoH7EH4eokyfl0dW
X-Google-Smtp-Source: AGHT+IEu1OlplbyTKyMNJiSwcJM/aHzieHb5jY3kjHadk0/91d7Jwi8sJXlwCnYq4jjEgabYRNsm0Q==
X-Received: by 2002:a05:6402:40c2:b0:5d2:7199:ad4 with SMTP id 4fb4d7f45d1cf-5d63c2e7f94mr1392853a12.6.1734077591474;
        Fri, 13 Dec 2024 00:13:11 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cbd14892sm9718785a12.39.2024.12.13.00.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:13:10 -0800 (PST)
Message-ID: <467966de-ae91-417f-b315-62459af93b7d@linaro.org>
Date: Fri, 13 Dec 2024 08:13:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: mailbox: add google,gs101-mbox
 bindings
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: peter.griffin@linaro.org, devicetree@vger.kernel.org,
 daniel.lezcano@linaro.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 willmcvicker@google.com, vincent.guittot@linaro.org,
 kernel-team@android.com, arnd@arndb.de, Krzysztof Kozlowski
 <krzk@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 ulf.hansson@linaro.org, andre.draszik@linaro.org,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241212-acpm-v4-upstream-mbox-v4-0-02f8de92cfaf@linaro.org>
 <20241212-acpm-v4-upstream-mbox-v4-1-02f8de92cfaf@linaro.org>
 <173402453635.2828943.15564980222849076434.robh@kernel.org>
 <90720b8f-340f-4f27-ae51-df98b2e5e820@linaro.org>
Content-Language: en-US
In-Reply-To: <90720b8f-340f-4f27-ae51-df98b2e5e820@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/24 5:53 PM, Tudor Ambarus wrote:
> 
> 
> On 12/12/24 5:28 PM, Rob Herring (Arm) wrote:
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/mailbox/google,gs101-mbox.example.dtb:
>>  /example-0/soc/mailbox@17610000: failed to match any schema with 
>> compatible: ['google,gs101-acpm-mbox']
> 

It seems I had an outdated dtschema (2023.11) and couldn't see the
error. Updated to dtschema-2024.11 and now I see it.

The takeover is that I shall periodically check for updates, or maybe to
try to upgrade dtschema and dependencies before each test.

> ugh, I remember I fixed this, compatible in the example needs to be
> updated to 'google,gs101-mbox'. I'll send a new version tomorrow.
> 
> Thanks,
> ta

