Return-Path: <linux-kernel+bounces-437339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD549E91FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E8A18820F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA72216E22;
	Mon,  9 Dec 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot/9dmc4"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F81E48A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743158; cv=none; b=axgWx4FtrdADbZbrm/RcP9nAsx/ImdrBoNjzQLq+0WCHVWYKwLA7P9tDojfHtyrJygOuBKJIDbMMDBKHaB0XSoK096AbHF/D9bWW4ivmxx9PUHovzZcsNhC7NtXp03cQMM+V/wh4mwAwjjeleJqjt4sTC9sbodwaOcl9Re97UCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743158; c=relaxed/simple;
	bh=EvNBtcuq66wlU4z6cIC7cBgd2PLoedbD/n/wBA3pDus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSl0xNbil4p/b1w+KyBxVWgTENcEdMPc8ILZRhfhc6KMMVrEL9mcHOI2gSgW5lKl3loWA9gpehhC6f5saodePUYMTSwkn6jn/l0spfjIP1P/WpgvHaUQu0kZZzhf7ZKKhiid2hgGz7RP4+8toflb9s70dE4ygFOP2WDHRz8C9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot/9dmc4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2155104f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733743155; x=1734347955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEaS0oTkc/etYl+1hpLKLxIspdSSIIqHv8Jv//XY3V8=;
        b=Ot/9dmc47fIhNQ4dD+R6JPkRAHg1ie6khujg3wPPG9ARkPvyj2HJNIkuKTOOZvoFIt
         bqyzg/h+LGEyzu3sOL4d+YvCwqoQK4OyR46/B2tVDB6f/5DEFqmq16c0KLfhJ5B2fBgc
         AVda6DrjEdzGOUdHmOO5xeefv5XJo0KFJSRorkCOIoX16kkzy9N/dTxdLqVStkX3BOyo
         8A8lRnThnJZDqXy+kNmEyKT4VVdkevw/5AJLEN08b4nqdIoF7i5YtQb+2AsdyrOjToku
         qYR4SbAcbDg11TdPuZhw/mtIYS5hNWu0EOrt/DONwe74gAvJ2XWN7qfSnN/A6Yd1dhl9
         vypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743155; x=1734347955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEaS0oTkc/etYl+1hpLKLxIspdSSIIqHv8Jv//XY3V8=;
        b=X7W301DKV/KmCscm2jzz9Ic3Gqn4pzCmQCWZy1HveMGU10BYNdywWIxwQrwo/eafSz
         ixq+dxLnF/IBuSBn1AL6Hd7oZwxCwWRSx6SalLZBVeJKKl2sX/kbQI42mQnfOg3HMjj6
         TTdULb1Sk0Rc9LDDu08cvDc5kdpTGGpM6wBZHQjUtWqCPO/7lt29nQTgbisDL7GSQa/f
         LnZu8C2wDTMsm87RdVoleGi3axiuK0p70NgUdK/pR7h4jyFvbpyVhoWH410H8R7zqogU
         V4RNyMlQgC1T1p8c5sLhe/yNt2ZC0IIVHxuAOpYndVzwxm5bMA6/0waPa+wLISc8QDLZ
         n13A==
X-Forwarded-Encrypted: i=1; AJvYcCW2qsXyv0wENbSmsa9uOjGOcGXG+Y0J6mXsIJV6jzFZQ+raTCxkHdv4e/9baXhsbTkaQrJsKPm2+tfpjqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4i8DutZlu0duQm+FLMpRhfNcf7nbk6/VKGmZu75USep85GLV
	cpCLsBIiMGh9vrBkhbG1kK+sHqU22teoo/Yu2kiYdEB0lomTfWoxAf5ktCWk6jc=
X-Gm-Gg: ASbGncsv/OMWo5af+DzULdVDErSDahPOZI+Gef3m435QBWybhm/hHYIMOO9GOfIQCFd
	nUOh/6MWeC9qBdn9+gUbAGm+QXgbmPeM1AlbeGPMeMq1bf+BzD5AEujxQ9FnwTBP3RtVuK/GooL
	5JgkRXTibqyTlXXccEOO9VFbLyy5KIfQnK2m0m0DWnWG+RGYqGyDvlp3nJgy4It9Q21zHEY4gyC
	6BcoOK7YLRJ76+BZ9+8S4b7LwWuFFMLC4zw8NsjJu5Wb3Cus6hAoMo=
X-Google-Smtp-Source: AGHT+IEOw6Y2qfshQI8PWqV2AbSlpXw9I5f7b9iOiCuMN6pqeJhfrRidRhlF2d20YiBeUwISSDGC+A==
X-Received: by 2002:a05:6000:1a86:b0:386:2aba:a7f6 with SMTP id ffacd0b85a97d-3862b3e752fmr6170429f8f.49.1733743154863;
        Mon, 09 Dec 2024 03:19:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434faba810csm24283085e9.18.2024.12.09.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:19:14 -0800 (PST)
Date: Mon, 9 Dec 2024 14:19:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:173
 mlx5_fc_stats_query_all_counters() error: uninitialized symbol
 'bulk_query_time'.
Message-ID: <c90846fa-7296-4d68-9d1b-81de0b6a611a@stanley.mountain>
References: <1ce44712-7b81-4ace-aae8-7284974b11f1@stanley.mountain>
 <59b9f96ace8fe9b6fc1de39ff060e4deeb712ff6.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b9f96ace8fe9b6fc1de39ff060e4deeb712ff6.camel@nvidia.com>

On Mon, Dec 09, 2024 at 10:09:59AM +0000, Cosmin Ratiu wrote:
> 
> Hi Dan,
> 
> Thanks for the report. But this came up during the submission and the
> conclusion was that this is a false positive from Smatch.
> See the discussions:
> https://lore.kernel.org/netdev/0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com/
> https://lore.kernel.org/netdev/66ccbb841794c98b91d9e8aba48b90c63caa45e7.camel@nvidia.com/
> You were also part of that thread and you reported no issue on your
> side back then:
> https://lore.kernel.org/netdev/fcecb18a-1a30-400d-b8ec-1806d856d145@stanley.mountain/
> 
> I am not sure what the conclusion was on the Smatch side, whether there
> were planned fixes or the whole thing was just forgotten.

Ah, yes.  Thanks.  I have written a patch to silence this in Smatch, and
I'll test and push it later.

As a human reader it was the unlikely() annotation which confused me.

regards,
dan carpenter


