Return-Path: <linux-kernel+bounces-257607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDF937C97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B994282447
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DF1482FC;
	Fri, 19 Jul 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiQXQEav"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0291474D9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414461; cv=none; b=Fjc0hPRtCBnXdZG8rNd+epOpB9YdeKUKXZxWHJJL+WV0yWYRaKj/mJzujEqnKgFSwzbTDO4zunpaJhdZxi6dNk0+3zEgF8cmvwPmEozXyXW0/baAj9CgWbgMPw7xxcnvGZcb4EdGpR396KagW0wplX/Nd8X2oTQNmyVK/nDU11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414461; c=relaxed/simple;
	bh=JfpOWmTYnFlMGNHzhT4nChoyfKvPflu7pMbCcwOJb6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaYxjXxfLv/v42b6vUZrKi9gwj5pmjhH0urG33BMG31hoSWYoOJIdslPYwffu23FVhzWImJyc6eD52nb4O+zb0lS12lSqWOx9XSIeR5FVhtuaNkGHGxfP2LB1EcEaQLNqKiYL8gGVTJVqIoXknJAW1UPo7WmN5l3GTrXuLdDWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiQXQEav; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so1241505a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721414458; x=1722019258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RNo02eFy6LAkKvZP67Eai/lEkSpazeYDVemwn3oMQ1Q=;
        b=qiQXQEavO3QMjB3PomXr/G1iTsdZdkBy4ImOGTmXJirO0BtN/UA6aAtT7hjZ6Z0sLq
         qAHPu+aeHuharHqRgkL5sMboFHo+rf5EpTkDJDPkSCX39TJomTOtar3HtoIzB1H7SlJv
         vEjE3D5uHkkafph+DzyQPFqpC8DMhQr/h0ZCbJYb/A88SqVrS9tQ17jzFb/wK9Bdu9OW
         YB3kN/ersaoAmOcr+O5SnYmAEi568UJm9IxldVh0czyS5xnlCSZ6yR5NisMCOSmoezKJ
         MjNe5PV/whqFw3ARZeB+ZGIPGZSbHSqU/hsmwE506kdsy9bWS4mbnLOjCy2Eu1Qy64XL
         hKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414458; x=1722019258;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNo02eFy6LAkKvZP67Eai/lEkSpazeYDVemwn3oMQ1Q=;
        b=tjLebDaYP5I5qQioFhSEy4ivmJ9u7fi9JXoktYeBM2tQH0Hy2IFWLA7PktRWzXAImE
         uE6sT/PV+n29uPT6qjxyJAQboPZ9Z5h06BjACbRqAyIIc3yHjAkN6OIVBESmq/462pfn
         lj+URWV5TX+1c495zlHG84RlYfuFbNDIPrWOHsT2afeoHuu/1QOn5Z6chAFHW6AW8p4v
         Vtx+j7QWpYQwb1ZO59kNxswWtJWEm5ji1lBl4pExurNCHvTK2QrYieqt0tZyGhorkEn6
         vt6rMwQYZWmNvUx8JMjRD+2V0ixYDC2X4K9UF4LunwQs45fTK0EZ9bkqs9BRd32MBr9E
         Vg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBJVcnt79TQFeh7U852cdyEhhbMDP5Nny2ZMfd7WWyktxhWojO9DZtasOTI4TgVPCoz5hPAa+ketzTe6lqEWlLnVv/CAXkcQTYxa2d
X-Gm-Message-State: AOJu0YybRqho9Z6xFPdqt5kREY/Y437lnhck+KWKOt6A7SYI3/aBAYYc
	TfP7LRnbdppro/pYes0N3HIWZHmmER63/sUWlOMg9YMtQaH02hPeUOjqBnGcLxs=
X-Google-Smtp-Source: AGHT+IFtNaIwUMvhXn+10LwfC3emux0h0JOm1qjBvFbc94DkjE9Q2n05LsSQkhiQns3NBMgwlBa3pw==
X-Received: by 2002:a50:c050:0:b0:57c:9d54:67db with SMTP id 4fb4d7f45d1cf-5a3eee849b2mr545943a12.9.1721414457897;
        Fri, 19 Jul 2024 11:40:57 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f87dcsm1539883a12.68.2024.07.19.11.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 11:40:57 -0700 (PDT)
Message-ID: <03867a8a-6289-43f3-9140-8a56845ee0d9@linaro.org>
Date: Fri, 19 Jul 2024 20:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: clean up PCIe2a
 pinctrl node
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240719132522.9176-1-johan+linaro@kernel.org>
 <20240719132522.9176-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240719132522.9176-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.07.2024 3:25 PM, Johan Hovold wrote:
> Clean up the PCIe2a pinctrl node indentation which should use tabs only.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

