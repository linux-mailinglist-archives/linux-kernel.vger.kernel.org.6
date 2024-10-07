Return-Path: <linux-kernel+bounces-352783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02987992417
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823C6B22261
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947113B2A9;
	Mon,  7 Oct 2024 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nD9wd9sZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB852F76
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281159; cv=none; b=BtwuMnPqfNNEx+YbV8ktl+mv+KSwR+j55giJyTuEgo6xHm7BMbZ6QSp7gcQbIgz1/FzlbzUohc9dMOM5BN5SS1xF8Mk84FWoCxXMwmsE9dSy2Y8TBsGmArt7Xj/amueu/TO0xq8YwsloIw+rjRrcC5Ll6JSplCeo6aNjIMyxYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281159; c=relaxed/simple;
	bh=neUI4jFvkFODg3BmVWKKLUTct0+l5aNT91MjsIrv8gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/SIW0lNIkRg9iZOLCQPWWdDvC9o/8Ka/mTWs2wavEmXDA+ASdUIqr5pkXMQg5F+WTGfhgMnScSUbI0Nlsm322569LvXmYvglD8yjan+y+RCYK9FKLipJFVC3vhs5YQ/kafE3KCCXzBJqHqucmVvmpXPcj1K90BAGWFZTn65TEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nD9wd9sZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cc8782869so40850725e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 23:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728281156; x=1728885956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8k4HEY/VFQSv1rAW2U5ni9Cjd5OHBI0YL4rik5SZ2w=;
        b=nD9wd9sZ+b0GDgvkBF2AYl4jbGqPcax3ylokO51+qL50pDpAz9TC0tSKW/UodDIKzv
         JKdgugS7Dm6Rgquw6lietGaCs860wOi9TNm2SOJD6t9dnG9RhoWV3ZpnQfwIUzEv9Bwk
         1JbcWr+FukkS2hb3UQyXbntc8wgFqWVIMQ1RSGgX1WsGnRh2hdAJVhUQhsY53U5LAG7C
         ypHvBF39wvCewNJEEfQxg9ljmdXI08LBShEAjerPR0fiBLzsmOVVMSpIYpzJumgW+z7G
         9o3hrLW0ygULCaKkW9uoRu81TIdxj9JI/ckzguZXlYpVv6++wFoOipI3tPCgDoslz1b1
         Btbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281156; x=1728885956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8k4HEY/VFQSv1rAW2U5ni9Cjd5OHBI0YL4rik5SZ2w=;
        b=P8lbMkWI4gOyGpW+yHVcTSLaQQla8EAjPE3/HXY8ySu+kZfCqzaCiNXkdm7F0ux/3h
         CpnSlb/Z3Kh5Tddb3VcCb1Z+Nc1Nc31nb9InR5zh6nVyI8Aox7oeSD8vrll3nJHrJmkv
         3je2dKVU/46328LgliKCNfVymFUlMqYw6rAVdqaRyANmFnJy3Ax3VaO3QG3T9HCwlusW
         bFDyggzt/XVqkxDh9I5lRtyh+JK2BtODN+qdd6fyH9qaZ5V6EDRMZ3FeRQYEpYm8f9GV
         EYM+Sw9xUgT7ZC1vK6oJTYLQ8ZVzFHmW1taVKWKXHYGAhNRaqKt7n/aKmlPbiplBF5rn
         UXnQ==
X-Gm-Message-State: AOJu0YzCAw028asIX+ofUO4MIebBIp4BHGDezuKwgeNeI0FNc9TSog0F
	4XsKMK6CgAUaQBIExdQIyzN/DlS3pfPZi6X+Bn3laKCMp6CjF5N25Ml/KL4owZ0=
X-Google-Smtp-Source: AGHT+IGu3uDIRDK3PWn9rg8gMLard76NwT+DxS5e/kOLQhosIg0x6I8SGe5fUJB0pT+oGAsC7H2P4g==
X-Received: by 2002:adf:e5c4:0:b0:374:af6e:b4d3 with SMTP id ffacd0b85a97d-37d0e79ff04mr5471340f8f.35.1728281156186;
        Sun, 06 Oct 2024 23:05:56 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920ca4sm4859230f8f.63.2024.10.06.23.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 23:05:55 -0700 (PDT)
Message-ID: <7f82da49-0f81-464e-bce4-569292210b10@linaro.org>
Date: Mon, 7 Oct 2024 07:05:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: add async request mechanism to empower
 controllers w/ hw queues
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 marcan@marcan.st, neal@gompa.dev, alyssa@rosenzweig.io, broonie@kernel.org,
 andre.draszik@linaro.org, willmcvicker@google.com, peter.griffin@linaro.org,
 kernel-team@android.com
References: <20241004165301.1979527-1-tudor.ambarus@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241004165301.1979527-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/4/24 5:53 PM, Tudor Ambarus wrote:
>  void mbox_free_channel(struct mbox_chan *chan)
>  {
> +	struct mbox_controller *mbox = chan->mbox;

oops, I dereferenced before checking chan for null. I'll fix it after I
get some feedback on the overall idea.

>  	unsigned long flags;
>  
>  	if (!chan || !chan->cl)
>  		return;
	
Thanks,
ta

