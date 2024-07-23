Return-Path: <linux-kernel+bounces-259912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0745939FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11131C2203B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24F14F9FE;
	Tue, 23 Jul 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0rNvF7k"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04088287A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734007; cv=none; b=VqyR/amNcD+ehEFH+fxILJAMrQl1ICUEL1zKjwnPzX2SofxMuk+R76cGsUmg6Va706Dr0GA5Pd1OhbZ4QwkxU1CysArI0GraHSEF1iFjxH0WqSHuln9GsJABMMbrTq2OhRjdcj9FuZBRChrxbmDUw13xlR8DeRSz5jKFuPAOcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734007; c=relaxed/simple;
	bh=uukS8unNQTNfi7V08N60xATjdGjwpz7J49msdrRzOXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7z31a5RnV1S4nN6kzzxsoXFhHSB3pUMxb0wP/wpxXgSGDz9+5P9HRPQ4SjVSo6rRN8VezcponQslkO5gmHWiQuWxFY0LAiShhlLZi50K8hooeWnkumH7yLMHIAD8H+pCfFaoO7BbJK5wiy7UBhHrZJ51wq4MksxPGXv1b1FF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0rNvF7k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a797c62565aso527249766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721734004; x=1722338804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2eAKhPE9UpfacyjVC/NQVFaAz/fytRYw1JCu65Kd/6c=;
        b=W0rNvF7k3VuEAiH2Dm+4G5FomGH1Iuz1p01wrW7p66LsQdNCZYFgHuPT2VultH6JAh
         KkPfDJQw5lq7WSp92HLKkJLRjIVpU1pvbvnYSEM/Z0Zm52oLUE/uRqslgKgbeiRCclZC
         CoavrB3bUZdEp8UmBp7m9CTRh/yU3hv2+BhMchV4zZxgq4fhhwJawNZb82ZXURxX9PHJ
         Fb19+LEf32osmwLJsbZDlIIoB/GznMv6AO/UiKibnS05i8NkP7rtoyXB5daLK97u/7oZ
         3o82ByC4bDMl+mzkcF1ncS0RH4xceJanpzewK/Au3dbz7SAceN0ZJlbywden6iXI2xBZ
         5Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734004; x=1722338804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eAKhPE9UpfacyjVC/NQVFaAz/fytRYw1JCu65Kd/6c=;
        b=HGeGI0thly0gabsR41XeQgU/A6Cg7I/k9yqV6cKZ6z2E2S5ruevDYkTMGEkh4IEmMY
         xw/CkWOzV2A7rJFgxxxemwZIt2RDZ6mAQLp/akF2GLMPXSpeHZLyETejbZbXYcqIU8ZY
         NX3PTi+LY9n1Yzs+HHweXu5/AI4MEQKVSgVIPeedLYbBjxTpOGzymDIKGO6TdUCZRdjV
         EoWc3JDTEOxH0JoKvMzYWAJGVfdYgSuQrLOwan266ley224ixr+U9KtmRZDpHXRegMWS
         sU9CJ8JcB85Xnxvjz8bxSeQ7ajRFpt7jKsq6EvBE0ZQwDdtifPwnwt8bmCgclWeufjMj
         lfmA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3j9Q0/56tzxxdsnhbwTcr2plFzAMZxwNY9teaLtxIXiKDYtVFmZjOeY7HSB6V1oUKB/aNxQq/8FS7KRMjtaS0U4qUveKNRXd4DFs
X-Gm-Message-State: AOJu0YzqujWJ3qZ6TfMLiJ9MqOsQ7dZc/SBSxVc4zYu1jURBQQeRVh+I
	MjPKIMqDg+Y2eo4FX/NQliUL9YWB2b20qvX9CVgLmuCWkL2dgNyjWfDLf9Tyy+w=
X-Google-Smtp-Source: AGHT+IGI1FInoieLydgmQj0ZqVuA70hO4yajq19rN9Ap9CNW68hXFzzROuzzrRKlflkpmokjGZgqHQ==
X-Received: by 2002:a17:907:3e1e:b0:a7a:8e98:890d with SMTP id a640c23a62f3a-a7a8e988d1bmr166052766b.16.1721734004036;
        Tue, 23 Jul 2024 04:26:44 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa2577f73sm27984766b.67.2024.07.23.04.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:26:43 -0700 (PDT)
Message-ID: <78fe95b3-1892-401f-93b1-1aefd3e0e90c@linaro.org>
Date: Tue, 23 Jul 2024 13:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] HID for 6.11
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <20240722-accomplished-delectable-kingfisher-cc89b9@lemur>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-accomplished-delectable-kingfisher-cc89b9@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 8:17 PM, Konstantin Ryabitsev wrote:
> On Mon, Jul 22, 2024 at 02:46:39PM GMT, Konrad Dybcio wrote:
>> this commit broke b4 for everyone starting next-20240719, as it's
>> an empty cover letter with b4 tracking information
> 
> I just committed a change that ignores any cover letters not made by the user
> themselves. This is not a perfect fix, but I believe it should help in such
> situations.

This sounds very reasonable, thanks Konstantin

Konrad

