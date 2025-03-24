Return-Path: <linux-kernel+bounces-574068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDFA6E035
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6934B188C927
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8A2641D5;
	Mon, 24 Mar 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GByonw+x"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EE2638A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834995; cv=none; b=A1/LGd0nxN6abNQx7hFMrPbEWNc5/H/1SujvsWnO7TtyfHV7DvRVj2U4EYJNb9Gt3jNdX2XwPKgOBn8FCCmXKJMLJ5rC4qyI+Vx/sa4MXe/pA3EVrtigAdGdH4cQYA7Y1U3MOAL0KHr/n9bHoF6nZY8OmVJ/3CpRRwGOEcqkxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834995; c=relaxed/simple;
	bh=LviRtfZ2Zkhdvc1v2tQGyN26tUVva3KWP4SpMnY0qFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ku7Fjp+3x8MCyhmJlVDTvMw2EI6027lvXkongqD9q+J3nLvDEG+x1mEgI7R6eZ2pk70RH/FTXYyiCMTijKUC9RhcD3V5wkHClClpux+GjRXitzm3Rq8GTqy5SLsaj746j+aurUBEmkF+shO9uxSGklGRVi2s+4qlhcJOVr8NiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GByonw+x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31438295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742834991; x=1743439791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKZOx3qp50UyeT4k9CXml4Zn6aQsxicd61ejBpyhlHw=;
        b=GByonw+x/a/1AjebGTc6VSwGRiKm7N6ggsMu7tsYjwDCnzPoQ3pTN+GwxNg+BQeKbb
         R4joKHKJNfmX6J4sEklmxh+ZaCVdghWhObGMgPQkCva8cJIUsi+ZtNO4Iu1yabCQ5xBe
         iGBYkJYT18sflhoL5FkDkvAwddFWLehrTTJtGrv5fvCbfQueDreLBYO8aUkGedaY2Q1p
         bqx/BwS2alQ3YIpxljP0GrlRJ/ncNXIoV4c46Ka5SgWsEYaGJAiSg65bc8LI3BXiycWz
         WWc9UNK0u1qN/uzTeZkfZRz+vUJXZBH4hshzOIjTttoMoUqj2+djiYxdfzdBRH3+8AGs
         iRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834991; x=1743439791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKZOx3qp50UyeT4k9CXml4Zn6aQsxicd61ejBpyhlHw=;
        b=j5HIECIEoljzp54k70nUD0RLRxGfV31d94O6+Q8ZJtc2NImWZVVoc+7Ep/HbifQ54H
         bAeUzAMTlpVUchD+JXJREb9u3mln1U17QqczN1fPIZ7ZCwOt/zF6rGt1yTYQw3NG7+LJ
         eq7v0GhNtdSGMWvNpekPYvyZ6ye3BaolZ2euqjLVONGpT9vc9FIAHjdj6emQbhyt+dhE
         Fg1q7FGxYqUuZB8DlfztcEKXQWnGTY7V2KA70/LJRSzjqYceF24RK/sovB8QthTLu+FL
         504DobQoENIbePGyDlNtMQwNz26KUwOxD/pk4NQj2MbiyooEgDnG3/xvcgYb4Y5ajbrB
         0D2A==
X-Forwarded-Encrypted: i=1; AJvYcCUBn/ef0QFZq5uWCBvLTP8mvgFFzwZIaoEEDNgSgLxC/MdubLbfUF225omSHTuVZWzuYNAwW+4AY1CQApg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHNWcIoO4nfh5qlm8fwvW+7HTI9OyFWuW0e+qatwLQqvGCHcV
	31Zdc8M0TUaJqEUdmYZhk0tpsUZIpYm6NzfkgAE3Yk439E+8lTNKvlJyj6Dmybc=
X-Gm-Gg: ASbGncuPst1CJGxcT+rvRXLeYF7S3Sk/FIkeolkscJw9Fp38sJ2wHLxcDz6OocS3q0U
	5Ta1kJcgA5xRLtJQBfEn05go9lXvkid93WlC0cwG7qdRM/rlw3FlNcdbO4q4NUW91bTBh5Qnj6l
	ypnFSkLsD/PxdGSbij1Z4OynH7IhylyXN0dOvXylmta/m7bhqj1L4Bm24YZKNquLw99gsm/54UX
	E6Wt2DrTf+Xz17VYmj7TntIUCaPsP+RsmiOkol2D31uIU6Nv7Sz5kLBsSohDwcw98t+SzNgrsj5
	vEFla46irXqEDOnjaPcvIlX89VV/zrxWjs2oOrL47C0mxAYS+ga0aLvAgErK/SyLv9+W8WE5aw=
	=
X-Google-Smtp-Source: AGHT+IEgPD+xDa6jr2Is2O2+Xj32Sel7N6UWscGct1y1fK9hAAcLY0xxiUzIYdVwngw880A7Z6/vOw==
X-Received: by 2002:a5d:6da5:0:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-3997f958f34mr10938614f8f.46.1742834991401;
        Mon, 24 Mar 2025 09:49:51 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9e6450sm11505850f8f.70.2025.03.24.09.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:49:50 -0700 (PDT)
Message-ID: <1f090804-2ad6-4ab4-a6a3-aa5d482f320b@linaro.org>
Date: Mon, 24 Mar 2025 16:49:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Peter Rosin <peda@axentia.se>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org,
 ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
 <20250324130057.4855-6-srinivas.kandagatla@linaro.org>
 <CAO9ioeX9RTBAeL3+9STn+=oEYR0wtaF6yoa=esNddEvqLQyO9Q@mail.gmail.com>
 <e4e94fbf-172f-4cfd-becc-cb2836ac1fb1@linaro.org>
 <ctcqkdbv6zh2rabkkr7tlhxlcfsn5nazjfbsnbbu4l4blyakft@pejdsvnazfh6>
 <324d5789-6309-4a64-bbfa-3afa0632e7ff@linaro.org>
 <8fbc8cd7-f8e7-e33b-74df-cdea389ac9a4@axentia.se>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <8fbc8cd7-f8e7-e33b-74df-cdea389ac9a4@axentia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/03/2025 16:33, Peter Rosin wrote:
> Hi!
> 
> 2025-03-24 at 16:58, Srinivas Kandagatla wrote:
>>
>>
>> On 24/03/2025 15:18, Dmitry Baryshkov wrote:
>>> On Mon, Mar 24, 2025 at 01:58:06PM +0000, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 24/03/2025 13:50, Dmitry Baryshkov wrote:
>>>>> On Mon, 24 Mar 2025 at 15:01, <srinivas.kandagatla@linaro.org> wrote:
>>>>>>
>>>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> *snip*
> 
>>>>>> +       int ret = mux_control_try_select(wcd938x->us_euro_mux, state);
>>>>>
>>>>> Hmm. Does this really work? You have selected the mux in probe
>>>>> function, now you are trying to select it again. If I'm reading the
>>>>> code correctly, you will get -EBUSY here.
>>>>
>>>> On successful selection of mux state, the mux will be kept available
>>>> (mux_control_deselect) for any new callers.
>>>>
>>>> So we will not get EBUSY for the second caller.
>>>
>>> No. wcd938x_populate_dt_data() selects the state by calling
>>> wcd938x_select_mux_state().
>>
>> At this point we also released it (both in success and error case).
>>
>> This will hold on to the previous state unless we have defined a fallback idle-state.
>>
>>
>>   Then you call mux_control_try_select() here.
>>> As far as I understand, it will return -EBUSY as the sempahore is > already taken. Moreover, this is not how the MUX API is supposed to be
>>> used. The driver is supposed to hold a state while it is still in use.
> 
> Dmitry is correct. A mux consumer is supposed to keep the mux selected
> while it needs the mux to remain in a certain state. Relying on details
> such as idle as-is and that no other consumer butts in and clobbers the
> state is fragile. Mux access is not exclusive, at least not until a
> mux state is selected.
Thanks Peter,  I agree that its fragile to depend on idle as-is flags.

Will update accordingly.

--srini
> 
> Cheers,
> Peter

