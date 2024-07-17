Return-Path: <linux-kernel+bounces-255073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BE933B52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14183B21D48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0317F389;
	Wed, 17 Jul 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T16oisUv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE20374C2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212987; cv=none; b=jQyb2f8U7Ja5IVC644pNDZ+AFD6ETdaCDBxpdjk9e5+W/zLyW2eMZYjIwdk3PqZUcZ9P+wzeUX6Z8MCJI6kaKK5IhXmnEbw4Q6LamewFAzU2szR0uvjulaJInL6hsFfUA7S6vgQ18FYD/2KYd9efnkszZEhKfEpXjGD+JWValCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212987; c=relaxed/simple;
	bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6JHWrdkH5iBEQne2Oe5WllXIkHafwOyJ3OqeYq2tmFVWcEjCAepKxmJLEPvaLB8V/0Ju57iLEtY4v4LHDm/mxBSVViwIIOiskv+GNZKoDRFYIOoL88Q2cZB2LNJ0FL4vz7GCvBAyjEU0iSsUAQBi9PyjT1p3glUI1IIRuxFPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T16oisUv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so7976915a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721212984; x=1721817784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
        b=T16oisUvxmtCSzkNI7xBOX0/YgRwBRxzjro5YbOIduudpSw7joiQQK5ve4r9rm+H+k
         rNCFDnhBwBnS9YRhh4Hlnc0uvvzlHh+mJwSNohs1hnooYWoTk7+5oGgDqLCYI1zZVAVU
         FzNR7UT6FCU1b9ArL2gIaj1vuYhL5P+cniBnpJ7FlXzu36h/O7A98a2spIpUR7D6CrGW
         hb4AC7l7WaiEa5ZKesmmoagqBVXNMe6TznlOhPIqowiH93uKfzK4IVH4uNYaYQMNrVbi
         JXJk3sfvZRrBPJeJvEtHDZ75MtB0+mf4InRhtXZKY+JR855ZByzbgknqhS2CjqW//gJv
         meqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721212984; x=1721817784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDYIVpkI2wrskYjogiULwXKO7ktZv1aJ7DZ3Nb1BvBc=;
        b=RQjs3IwKTL199lU5FojUa/W9ONwkyybeIZ0hdug3oN1Mn/js9QNwQdGN9Rr/6U+jHO
         688CXFTAeJIRgFj13v6bDhUMFKcUXT4bw2BuTAKcqz1wwAmFBqj3ldThtmeq7nceMMiN
         sQl6k5LYHvGPwG9jsFHBn2HWKwYzICCkY8try+0zEt05q8FLApzJrGFbUWjCkh+Fqw9l
         JFnvLrqbL/O0e61FYT/1ClJ/UVZv86gHNpNJ7iqYgmmI8CFNfi2I890xMk3KXgEETiDe
         GEJsWpiHmFjy7gGM3xwBvcjIbjyk2Rp8a2i6tB1OWqMvH0RtzPvLDYSRlC/MXux8nUWM
         y9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDwpAALGNJfD9cmhjc4Ujy4rHFICuTJ/ZaHtln0pR2gcyBN5E6KL4a2IIu+VpzBc+NCxnCJ4COosoDkWfKVyeX+sDTzxd/ycZx5X7
X-Gm-Message-State: AOJu0YzJl1paSZihJCkrw4EpNqdcCHJWpTaoczbxjnJpaX53d2u23Dzp
	asFnkLzGebTfYbLIfeNA+cJx3NUh1p88zAS1WO4BqxMoRhP6bO8tR3Lsvu69ewRLuNpTvVGayG3
	eepU=
X-Google-Smtp-Source: AGHT+IFACSw0wcYk59/gj6GZBVlzplPmhNUj87R9Hfdq8QZPBr1o+WVmHKWfiYT/gpdP86UdBlCbXQ==
X-Received: by 2002:a17:906:2b4a:b0:a75:25ff:550d with SMTP id a640c23a62f3a-a7a011557b2mr86405166b.26.1721212984397;
        Wed, 17 Jul 2024 03:43:04 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f27cesm429797366b.124.2024.07.17.03.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 03:43:03 -0700 (PDT)
Message-ID: <2d8ac288-da60-490a-a6ac-ebe524e3fc21@linaro.org>
Date: Wed, 17 Jul 2024 11:43:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: qcom: camss: Remove use_count guard in
 stop_streaming
To: Johan Hovold <johan@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Milen Mitkov <quic_mmitkov@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
References: <20240716-linux-next-24-07-13-camss-fixes-v2-0-e60c9f6742f2@linaro.org>
 <20240716-linux-next-24-07-13-camss-fixes-v2-1-e60c9f6742f2@linaro.org>
 <ZpeJmWTfZGUXsc7K@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZpeJmWTfZGUXsc7K@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 10:06, Johan Hovold wrote:
>> The use of use_count like this is a bit hacky and right now breaks regular
>> usage of CAMSS for a single stream case. As an example the "qcam"
>> application in libcamera will fail with an -EBUSY result on stream stop and
>> cannot then subsequently be restarted.
> No, stopping qcam results in the splat below, and then it cannot be
> started again and any attempts to do so fails with -EBUSY.

I thought that's what I said.

Let me reword the commit log with your sentence included directly :)

---
bod

