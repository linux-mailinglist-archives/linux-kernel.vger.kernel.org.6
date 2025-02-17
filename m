Return-Path: <linux-kernel+bounces-517531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845FA38212
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA2F1886332
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F0219A67;
	Mon, 17 Feb 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmtCzBvw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A4219A97
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792397; cv=none; b=RixG7p9NjsdWILaARa1DQtJh7If2H3JksuKZZ61D6nkIm2sNxBuSc6LbpmXsujUUvW7QkaBLdMPDoEOXZrwNOphrEQSOhStvyP4vdWvK7Qse7kdvPrM+V5U4acGB6dVz2Gb/uNi5w27NQusrk6wh11OaSR6nFbj9V5CXJP8vWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792397; c=relaxed/simple;
	bh=y9aptTQXNYwZKKmxoBhOneyZpOKIv8I4pxKZr3Nf0A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZcmcQkOH54sQLFZ1No/a5iB4/2Ki6t3O4zs7/uafvgcUTBEBwnfzyGrnHAJ8JyhAzYrDcPTfbyL/zU6TaYFpW7c63qaScspgr7KNtKdvdV7sU7/uaiqLjq0TMf1nzk6VKj19HNTv2ewR6Cmc78dTZ1FfNA2zEjsI0MUStLGJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmtCzBvw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso6081797a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739792394; x=1740397194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55tmFZvlDhfQ4udOwAM8HxDBVvHY3WF0+nddp767ALw=;
        b=UmtCzBvw80F1leNMUtmsQmLtwSNQck3QQ73scQ2dQa6WOzSmOaNoYwdi9NEoWNjz/B
         O3x2wL5Ge3w+PpGPjezCc0xUvgaclFdhswBauKLt/XrQYWt3qpyvZclvuwAgyQAxqa8q
         Te/SIUc4ZzS+2aDB58nPiHlcYTevn6XWJhBQUaRuhQtjD/tSoxAsYX4Jz2Oa5Xd6lxQJ
         D1IkktOzEPGm3gXBziYNPtTbQA/uNS/XunJL3ES9JMfdMeteJf7hh7Fz4OF194FHkd9T
         /E/1RxQ59nIO2eXMqtSKfYWkDJcmIyOyg2L0OIzOs+gcU/GGf5+8rQE8YLE4H98v745b
         lhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792394; x=1740397194;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55tmFZvlDhfQ4udOwAM8HxDBVvHY3WF0+nddp767ALw=;
        b=Ye9x5H1u/pwbKljXlgkCC4+p9XlVWC7Z/hDiwCgYgQvZB+Dz4/N/g13HjIeh3+Uwr2
         feROjzK2GZ/5g2F5aOEAyMoCXc+02thgdkDANH1PwzUfME+zwrzOjU56ZNL/PnP45mx4
         5IATSL1URHHaxhm5Zx7jFvSSU/oCH94gixdx7acx9p4MEFiVHl3bGvEi03ZOHHg6DNwp
         Yamj0YiOl1eZY5P93lqs+8BLMf+5aot67XP/tpV2A+7Y+qs1bSsc8tz+apdvHyh6vt43
         10EQugM/gx893cjrKiAQFbPZRF6zQsAdhtOAYGrBbO0MbxQrAGmryI+ejj9GYa4t4Hpc
         JB9Q==
X-Gm-Message-State: AOJu0YyugDKHukT2hgHf/clJ0MguUQuNy3WzXdfSwRV9CBTR7Mz4DN6I
	pLkQcz/yY7M24ZZsB4xnxprfCLd4xbvjc1w1ab5fPFIBH4dE0heldq02m7NgSDE=
X-Gm-Gg: ASbGncuqaauY9T7F0tXIDZm4IpzfYgCPZRqIa2Bow5EJsG9w2cKuen2CaJ9EUWRYKOl
	Ma0md5ktmFlFQgp2gyi+OZnqRcjh39VrrsRKoIlEqVSucQzbeLu73BrpopmWqFJoG4doPNEi3/B
	LwW2BHW5UIWIL6pLu3qaIEzijR7D3t9TraKh/FJHIJ53BXVv/LjIRe4zoGK8bqP5TvDNKY7z1uK
	CCtT7Aa66oJU/XPkEi/AnoRX0ZhDz0f+X70xQY3sqqkB321WE01tMcnN41MiTI3jiXntbNoVN7m
	9vjjnR6AacgCqFAWBc2e6a0=
X-Google-Smtp-Source: AGHT+IGo+bcNzZNZe9/7oqui44xN8WcwrHBLDxTE5jOoOEjQDNDVEBhQceJwnI6a/LC5g+Y2YvDAyg==
X-Received: by 2002:a05:6402:26d1:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5e036063de6mr22010855a12.17.1739792388094;
        Mon, 17 Feb 2025 03:39:48 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53397f47sm866703466b.127.2025.02.17.03.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:39:41 -0800 (PST)
Message-ID: <885a9312-484a-4b60-bec0-5adf8f1e4a0e@linaro.org>
Date: Mon, 17 Feb 2025 13:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 00/10] pstore: directly mapped regions
To: Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
 pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, quic_mojha@quicinc.com,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <c4b48faeae8531e670ea5909800d1a0bfed69862.camel@sipsolutions.net>
 <b304d582-9328-4e1b-9e34-5604125b0c06@linaro.org>
 <59333d4aa8a3bb3222967d70d10d9288cece444c.camel@sipsolutions.net>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <59333d4aa8a3bb3222967d70d10d9288cece444c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 13:19, Johannes Berg wrote:
> On Mon, 2025-02-17 at 12:44 +0200, Eugen Hristev wrote:
>>
>> At this moment going through devcoredump is not something that impacts
>> the idea of the implementation.
> 
> Yeah. I don't think it _should_ go through it at all.
> 
>> The whole reason of going through it (because things work without it as
>> well), is to see whether this has any kind of impact or not, and if
>> there is any kind of fit/reason of going through it.
> 
> So it's just a trial balloon?

Yes, that's why it's marked as an RFC.
> 
>> Devcoredump is involved because the whole core registration is similar
>> to a core area that devcoredump could use.
> 
> Yeah but ... 
> 
>> For example, would it be interesting to have a handler going through all
>> devices, and have the dump areas already registered ?
>> Meaning, when there is a request to generate a core dump, one could
>> directly dump this area instead of calling back the driver, and provide
>> that to the userspace instead of the driver calling the dev_coredumpv by
>> its own.
> 
> I'll be blunt ... so you _really_ haven't understood devcoredump then?
> 
> It's really not doing this. It's not meant to do this... It's intended
> to dump data from inside the device when the device crashes.
> 
> Please remove devcoredump involvement from this series.

Thank you for your feedback.

> 
> johannes


