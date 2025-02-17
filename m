Return-Path: <linux-kernel+bounces-517421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8640A38080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD8188BB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56B217657;
	Mon, 17 Feb 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJm40Mts"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA78217664
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789074; cv=none; b=YcFtxjhBspD7Uuh/205uI19wlg5LA+fan5GMM8UCTf9gi9DyyZxHrN5ylIv/tE2esVCGFZTWJtlvxGG8u0p/yfL6cypeSDGO6TL1WjuvOnD2Mi1VLqm9IkClDB3u+8ellSuF37ReB5gwoBmFoEBICWZb+gSAH9fqZdSEadTgiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789074; c=relaxed/simple;
	bh=lAVINVnHlWjTWaGVpFZbbokZJSBj5vEpW5VZeY4f3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW2CfAiGQGMOhxXp2UM8SnJiF+kMXV2OHDZeM0vgSzzTsGL2dY8HjY3gwhPWmRA3f0LVLhji81w0h2qwBXfoAgxeA4Bn5cBRQUIY3MIttpFCkcSSLJDb2BnJ0MXL2kiWTjBrn8hnqwqzvNdNHgoXAN9EoI1cVjEQQk6vaVsUcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJm40Mts; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so6055601a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739789071; x=1740393871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEbDsC7zOesvvA0J5tAlZE6+h1PCWgc42liU2tI3McI=;
        b=wJm40Mtsm01IIjp0pJOT9kUXukQqG0N/QpN4wHm0TM361GJW7JlaAgT3oyUTjIUmR9
         qImGSRYTQStQPs3aewejzhkhbqgzNANqZ01ON08QqiD173a7oSdoQJezq9r36rVNu+tn
         S7NFB8wriv6dZdZJHuoxC+4HVhJy7lO2y2DWRYggtzZ5pWGJ8a+WM7Il2EoApe+s3Q7c
         M+XjuBv4OrZjf0tn1i40Jn8MuRh0362PKZCrh0gAEDBCIsNziAVqk4cYPEIkZTQlTY7Q
         T2XLazv3HeyFXDpstHmRg2pRWvSu0WNwnYElogPcvV0U5EO07GxRo6fVmLra+OqQVBA3
         Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789071; x=1740393871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEbDsC7zOesvvA0J5tAlZE6+h1PCWgc42liU2tI3McI=;
        b=oFZj6j2iYW3To3rzG97PATH27bycWsC+tYFNwCRTPg9KzY6SIzkUl+ZPqSxE49me4X
         LsQlgaekdQBCBumnkpJh8v/jybkAMHs4Ph7XEDu+7ALyg7RodPsynv8+HAmc4PrJsyo3
         mWVBmwkddj051tVy/gnCpiem8S9llNO4NIfnKPE3e7ACIbEfoYTwe41wERdT0YrmdlmZ
         tApM5Yk+YxL9QMx3kmHo0DMQmUZioBPZwqtv5rHcXJevnvwX5JZQuyhHR7YNIYou3m2C
         5Q11os0PiVTRwRatQSVv5XyorQ/cO6WmeOddq1D2zfuarlmVyZOojx1fuXNJm0psCDpN
         thrg==
X-Gm-Message-State: AOJu0Yz/ubQDH9eHcCxMWacaJJQYzXGQKYdwGppcxFwxgZyf/cKR4Ini
	RasD5BY+soexVuKkm0MFilK4XFPl1gKeJ1SIXcoV9TFoW9GdYexVKRlemkRlMW4=
X-Gm-Gg: ASbGncst8hu8hrb+seo2pvdTa25WiwDFxDssxht7BdGCw3Jezx2VPryJgFIZOtJr7bN
	3xg9bkDCrXucaUAkGnE8T6VT+IyFYLdURZtASjA/rJWRuNuvHI4yGl3aDoSn594daMkSmN+2NBf
	sy3snw2K+3EE4So5+Zps6LiE6xJTi7jtQeozgzpMYUU7A16KZSwTjfn1pdLXr5vRVpC4yPyJvWJ
	Ezb8Ep14ezKD0KSh0KksI8I+zhHJkSwxGL5tnHUNtF8bb7iLU6v5Iy8hhem6x9U7AiSfeLmdtBD
	CVBcWtOJwHMJelEmno6cHZ4=
X-Google-Smtp-Source: AGHT+IE+qR+XkSpEa4n8UFFb2YUXaqm+JYBZqs/0Cfmj9Y8tSfbfIbKyD0WPukltsMDTzYdEa4UX0g==
X-Received: by 2002:a17:906:7312:b0:ab7:ca44:feb8 with SMTP id a640c23a62f3a-abb711304d9mr1001080366b.52.1739789071395;
        Mon, 17 Feb 2025 02:44:31 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb88c69c1bsm330535466b.110.2025.02.17.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:44:31 -0800 (PST)
Message-ID: <b304d582-9328-4e1b-9e34-5604125b0c06@linaro.org>
Date: Mon, 17 Feb 2025 12:44:29 +0200
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
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <c4b48faeae8531e670ea5909800d1a0bfed69862.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 12:23, Johannes Berg wrote:
> On Mon, 2025-02-17 at 12:16 +0200, Eugen Hristev wrote:
> 
>> This series comes as an RFC proposed solution to enhance pstore and
>> devcoredump with the following functionality:
> 
> ...
> 
>> This patch series attempts to solve this by reusing existing
>> infrastructure in pstore and devcoredump, and provide a copy-free
> 
> ...
> 
> You mention devcoredump multiple times, but it almost seems like you
> don't even know what devcoredump does? I don't see how there's any
> relation at all, and the code added to it seems to have no relation to
> the actual functionality of devcoredump either?

At this moment going through devcoredump is not something that impacts
the idea of the implementation.
The whole reason of going through it (because things work without it as
well), is to see whether this has any kind of impact or not, and if
there is any kind of fit/reason of going through it.
Devcoredump is involved because the whole core registration is similar
to a core area that devcoredump could use.
For example, would it be interesting to have a handler going through all
devices, and have the dump areas already registered ?
Meaning, when there is a request to generate a core dump, one could
directly dump this area instead of calling back the driver, and provide
that to the userspace instead of the driver calling the dev_coredumpv by
its own.

> 
> johannes


