Return-Path: <linux-kernel+bounces-347091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD698CDAE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998291C216A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E75192B79;
	Wed,  2 Oct 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwpNrX1L"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00881754B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853714; cv=none; b=jwm+9ZyQ9wxixhWa2tn43bv84aLs0s7EiwMhPRGTLAkhtA3lm4KRAWKVflIqfVNTPyY1ZZX5UUpAb8bEySnquofIfcna3C9hGpYLtQB7GUGeC+sitv5gy7feTtMpbLqcMf49pJdrmz6GvdiVLxlSHVmV3wFAlAW7K+y+XJMS0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853714; c=relaxed/simple;
	bh=8nafJtlKWZ4rWfrAVtGHxv8giv2TXP3EVwUBGfjNdGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htnInUS0vVfzzt1zouiN+1gz2TfVqnJjEI8kW0Jz2Z9D6DRBPtqF6HNkYyjVWdGpnove9INgnONoxcLKfHRezvY49PFwdcGDCzvxcG1hjaNtrby4i2cqqZ5RaPcMaEbccedxUje21RHTxg+CLeJOR+7JRaYDs1VIBDUU29gfCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwpNrX1L; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5389917ef34so7375090e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727853711; x=1728458511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcxw+NXlbQYd2z3U+0QFvfVoViuw+WbPZb8OCyvpD9I=;
        b=ZwpNrX1LomqnXbykrhEpwOhPPjw0kgAMkeFeudpGwD7wUW5JlWAZ91lsJ/s7I48uhJ
         cUu/FKrNk+DP1ZjoHP8M11sr7Rno+pLEH1b3cr0eP7Wct6fB8+UlYMSYuLofctYGZ5vV
         kmKccI3uzc6ptSB4UKERXIieh1Iuo5X4O2UNRzshnOi1o7mRAPLcOy0R1zOCa/LhPCCa
         96dW784lJkaM1f585SHBww29s+9HnW033DRSxz7T+MLwoEZpLTWa5S1moVRc71ZovT57
         B/3605DpIkW/ZRxBHr2/WNJwTfO75LPl88DjtPJjOpQNS9fmYYO84Cra+JhXlZBW4fUS
         raXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853711; x=1728458511;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcxw+NXlbQYd2z3U+0QFvfVoViuw+WbPZb8OCyvpD9I=;
        b=Vympb6Il/a+LymDKSC0RrpvFSoeqgVMdcBmbqGlXg5ntMF+bwSuz4GsbZ86YZiZtdU
         wUwE7xbjRfNFBoovvR+oehDw9fz4FIfQ4kUD4BMVMhNpRPa4JofQuD5oLwLqUjpbs0k7
         3nRVnKbM819V9R3rQETod0rqKopbmk/guNPAwRHUFp2VWI8RDmFXvtJonBJfjZ5iWWnt
         S9ksupiwy00gvHX1RyDe3j4/cQ2aFXQ/G9QH49+x8y98L6UOPQFbfX9pWz1/odZ6yBYm
         a79ai6tBtnFEV2mG4tA8AwiXUq8CllSWKgyKNarYoeb4WVZuPMxJezPSvYLq1o+jpB2L
         W+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNfEFG/Ue+LYIzpJaTCtSBxVUMRESoRAkkjjtTKX2xU5Bb8veA0LN5Pgd5qnUivg/t17Q5OuXUaFb8nXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlINz+A3NIbofNMl36OrQau7TRZ/C+5DMGK/QwqWgn6KuZzyBe
	HoBDXCz0GXNGjyPWY7kQkdoiWdNCQBGWY0DkzedFBXx2xeuOspRdKQ+T8dmzfdU=
X-Google-Smtp-Source: AGHT+IGYEjiX3HVw4SMn5kvL8BZQqkqDYDjYG+HTGdx9kWlGvm0S8XCDXetAMEW+Me4ck+tpIzH8UQ==
X-Received: by 2002:a05:6512:3e26:b0:536:7a24:8e89 with SMTP id 2adb3069b0e04-539a07a636dmr891580e87.49.1727853710771;
        Wed, 02 Oct 2024 00:21:50 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248c672sm7431319a12.60.2024.10.02.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:21:50 -0700 (PDT)
Message-ID: <cc4e9ddd-1a36-4496-89da-347c0eed23da@linaro.org>
Date: Wed, 2 Oct 2024 10:21:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] mtd: spi-nor: core: Allow specifying the byte
 order in Octal DTR mode
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-4-alvinzhou.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240926141956.2386374-4-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.09.2024 17:19, AlvinZhou wrote:
> +
> +	/* SWAP16 is only applicable when Octal DTR mode */

the comment is redundant, I can already see the condition in the if
below. No need to resend, I'll amend when applying. Looking good.

> +	if (proto == SNOR_PROTO_8_8_8_DTR && nor->flags & SNOR_F_SWAP16)
> +		op->data.swap16 = true;

