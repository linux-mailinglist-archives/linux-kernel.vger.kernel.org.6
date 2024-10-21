Return-Path: <linux-kernel+bounces-373685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3B9A5A39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F491C20F49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574511946BC;
	Mon, 21 Oct 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZH9KSgR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFB3232
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491493; cv=none; b=VqhpOgfPBzR9XZZpxcLPIy029k23CU5UpoXnlvWzBK0uDjw9THfVgBgllCVC7mqP9JiNtvggoqsjBwEd6hb04uMPkoSSH/8XntkjHx7Ae7PvvqqZ5L2k1JwSNtgbPWIiqxSXUJyXbwUlZZ7r2UOycDVcmIe4eGim9S5ocApln/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491493; c=relaxed/simple;
	bh=1PKIcib9+8q3lrOU6fVnEN9cqbdUgXxB5GKCZlSw6os=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VX9AHssZ6kfIMpKF/x4kaA22aNVna9Oc8x6WwQy36Tnb+XnljZLqgml5OceFsdCOQ9vM18cGiptVMN0SkVQ5GOzuHQDICfq2qtKEHWTzsZx+sZ4At0ui/F2x/R631io5Zouy7wRfnMgyNoZO6LuwDKJfbxClMHIOG5X5hH2Apbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZH9KSgR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d41894a32so2595385f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729491490; x=1730096290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qX4zIhNfxYlQrlR7WHo7Qz8LQENp4Om9Aokp2bYEp7U=;
        b=MZH9KSgRAo1RQipIYZKoFb0c664AGFCW4MAS2EKM1eB3sCNPPV3LYiYo9eJwBwizBY
         G6yNEYxl0oYHr0mVh8G7mfMHVQnwkAylGPWrxYpPFxmmuWxb3Ye//vbBfO1owhTfCS2O
         Ml4rt5Mn4bxFxa6BVYaxTBw6hgV1PacqWE1X67VYhdoiw7Y6hfAISxQBn4S/O8pV492M
         rlN/7Fm3kAwwgeJWe4teoD0V9z4Q024qinAsCklYXu3wiYGKncPHoCUQytqxipiYtx9B
         /T4dW6aAjJ0JnN1FbqY4195rw0wvXKrwCDWUvMV59AxPyD1Yw8TO+HzW04RYInCuIaXV
         YVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729491490; x=1730096290;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX4zIhNfxYlQrlR7WHo7Qz8LQENp4Om9Aokp2bYEp7U=;
        b=TBR1BMyfavU/mcSCrCGpR+WijXPEkbZ15wcXKEHAwIYmJz2pBOXUdm4TYJra2CFeVR
         v/Eb5eHrSg3hZMcgCd9F+iq0GFQ2Jg1y5vNpzXfCcUL+NU0IpM6nBKchev5lDCnuMhNU
         RPMWWxZSIF6j3sMDn5hIBaSd+MCEXKZ4Fgfu1e/5BPh6IEjpAuxZGFkS+ZRIxCVDh3qG
         4DEJJl29h06SMefqQ1MCUhbcUfC4y5hSSxefcnXcCTpYAQzIOCcQ/sxLlsu70tbhbzl5
         yxXTGeSyMgJu5K9xzkf5pwxqNP2OIkCKAodxaWo6fRbht8ePAbF3AmJHKKIaEEi8OsYV
         40Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVytO7oovK8YWtHLgEjgVXBgacKqeWptpSWQJVqVw9XqT3LJJXbXeqLmnADgdbPxz4ny9USnLADm4zleWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXkjbNQVhcxPGfa9mpgiYTQmIvT0o0bQsuZ0C8GiWsSGTlM5m
	2s4tfPooRHVK8Q+o/GL+ZENL2k5DiQzUnPf7qMJ78HJ9urdRucnZtF579FV2bH4=
X-Google-Smtp-Source: AGHT+IFzCvQqkE64bi/xeJMd7XgYjjCcYTd15/aGONceMWdvvyWn015PNuTIjGOK5MpJw4Jfe1ZObQ==
X-Received: by 2002:a05:6000:e83:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-37d93e2492bmr9009274f8f.21.1729491489769;
        Sun, 20 Oct 2024 23:18:09 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb4dsm3378273f8f.97.2024.10.20.23.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 23:18:09 -0700 (PDT)
Message-ID: <1df84f83-40d7-4719-a9f9-dfa10d25c667@linaro.org>
Date: Mon, 21 Oct 2024 07:18:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mailbox: add async request mechanism to empower
 controllers w/ hw queues
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: krzk@kernel.org, alim.akhtar@samsung.com, mst@redhat.com,
 javierm@redhat.com, tzimmermann@suse.de, bartosz.golaszewski@linaro.org,
 luzmaximilian@gmail.com, sudeep.holla@arm.com, conor.dooley@microchip.com,
 bjorn@rivosinc.com, ulf.hansson@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marcan@marcan.st, neal@gompa.dev,
 alyssa@rosenzweig.io, broonie@kernel.org, andre.draszik@linaro.org,
 willmcvicker@google.com, peter.griffin@linaro.org, kernel-team@android.com,
 vincent.guittot@linaro.org, daniel.lezcano@linaro.org
References: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
 <20241017163649.3007062-2-tudor.ambarus@linaro.org>
 <CABb+yY0_NSLAs-mP=vHeNsfKRcS2hcFWmWfcvsr=nFcXQOi5uA@mail.gmail.com>
 <a7274a6e-1da3-47f2-8725-b0c534bf6608@linaro.org>
Content-Language: en-US
In-Reply-To: <a7274a6e-1da3-47f2-8725-b0c534bf6608@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jassi,

On 10/18/24 8:49 AM, Tudor Ambarus wrote:
>>> The active request is considered completed when TX completes. But it seems
>>> that TX is not in direct relation with RX,
>>>
>> Correct, and it is not meant to be.
>> You are assuming there is always an RX in response to a TX, which is
> Not really. If there's no response expected, clients can set req->rx to
> NULL. Then the controllers know that no response is expected and can
> complete the request when TX completes.
> 
>> not the case. Many platforms just send a message and only need to know
>> when it is sent. Many platforms only listen for incoming messages.
> these 2 cases are covered with the req approach.
> 
>> Many platforms have TX and RX but not as parts of one exchange. In
> I don't think I understand this case. Is it related to what you describe
> below?
> 
>> fact, only minority of platforms expect RX after each TX. Btw, what if
> Right, I noticed.
> 
>> some platform sends only and always after each receive? For these
> This case is covered as well with the req approach. One just needs to
> serialize the requests:
> 
> ret = mbox_send_request(dc->mbox_chan, req1);
> ret = mbox_wait_request(ret, req1->wait);
> if (ret)
> 	return ret;
> 
> // req1 completed, send req2
> ret = mbox_send_request(dc->mbox_chan, req2);
> ret = mbox_wait_request(ret, req2->wait);
> if (ret)
> 	return ret;
> 	
> This shall work regardless if the client expects a response or not. If
> no response is expected, but just a TX completion, then the client can
> set req->rx = NULL.
> 
>> reasons, it is left to the user to tie an incoming RX to some previous
>> TX, or not.

Is there a specific driver that I can look at in order to understand the
case where RX is not tied to TX? It will speed me up a little.
Also, if you think there's a better way to enable controllers to manage
their hardware queues, please say.

Thanks,
ta

