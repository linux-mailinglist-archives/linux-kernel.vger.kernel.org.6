Return-Path: <linux-kernel+bounces-522096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2AAA3C5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C72917A6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79462144A7;
	Wed, 19 Feb 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BLa5LO6m"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23B214209
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985315; cv=none; b=h2+GmKG6pz9XjvB6Z06iKnjcBE0SsxCdTBNnUj/fFcvg9sUL2hUqaSiTnGYIGB4xopbhLbY7jpl7nV5OKF/OYhc19icqlK9R/pV7QkudEfPrF+CwHwDn/gC0SzL1WOVCflX2fa6BehkcknHz3rWMt9vuX5Apn1DGk8TA0w4s5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985315; c=relaxed/simple;
	bh=xMRa3eKJ9cKzQW0KGgR880jcYJteHrfhxEXjZKFI2A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzCQiTv1qnu2mv27P6BLmcp6e4rKhWfoYROCY3/oF1SlantRKpZFYpH6dVZ4MEqbUPlZ63UTtmV3bTMJiK/2ZKIOEBTMyui8mrBBMIlF2PtXzMoRRm36WFUwWMPjfR6gP3fWy4nYkNIxOczS9JFL3JXIm0AFvrcJ5eu1m3X+neY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BLa5LO6m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4398738217aso32525165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739985312; x=1740590112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xMRa3eKJ9cKzQW0KGgR880jcYJteHrfhxEXjZKFI2A4=;
        b=BLa5LO6mb+v3asRhqDATgS1H4iVYkm2EiRdEB7NRVDbpegwJ8ZWCKEirDUs69DZPVc
         2Cu6xTF5neXulnpN55y3RPQ56rYBfjPYx9Ovj/D19wia+kuImSmRNNXIxQIyO6m75IW9
         0GVORNUPVhjPIqYvDJTY7yXzA0YA2cBzcQB88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985312; x=1740590112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMRa3eKJ9cKzQW0KGgR880jcYJteHrfhxEXjZKFI2A4=;
        b=fXZ4tQPKqjhiFq4KtFl9X816ueyMLcwn/dPFr6z+tPhHGVfkL5ESlDWKqQ6WlXTZmi
         kBcIViA2YQ0woEEhHP9TLm9gpJzUhf97ZLcfzIYvhtCnI0+kw523fcNL656cMTE3T9jz
         O2TPyV5Yf4FqWdSEygqhSkDCipLUpHbkjSNK0Dy0A55rdFn7YLYvmTUna1diCvt7pMPq
         TRl7CjvCLKqfk/KVQDnc4o45mbdRlYoMoldSLeLaCUp0Ym+W83kOCbiYaqGbZ4KF5/kv
         tB1AQ4ifdJpIhzgdZVpPFNn9sZEyP/bSYQ/1hvxAt9dccwUKbGVjHrXx7nHL6Ef4H4ND
         VSPQ==
X-Gm-Message-State: AOJu0YwYWSM8woNhHEjW9LFMOQT+v+uuABCVGLUWzVQMzmdO8aG2Ye1X
	rIZUTg8oJuoq00/NAqJBejNG/AxEdAWg6s6fA5plYE5/Hqzze2q3/SIbOyjSy2Y=
X-Gm-Gg: ASbGncuIIbq0BiIU+YJUA3+CxMk2HwkSp7wYjSq78p6NH1EX5xRG9C0fEtCY2a6Bbfj
	7KS+R596/e3TEEKDOM3T1ScGWopMh+EIdpeqZBM853uHWDeGxkAid7TBWGdW6pk88RGn95IM1+W
	JfAh3oxLaIdFU3D5RG82dVFzs3s/NlxBwXMtMHjC+6L+Pox7IzUzIO7/CGLWbC9nIWtKG8uFXeD
	usdNMK0A1QL7Niue33XrLRsD9Xib/opyaCXemruIsWTThtSn0AANkFMrOv8vXGolsBtUWUqc3BT
	gsUrH+J40U5/Tzd9wKEUdTMO7BBCYYmDrFgCXxE/barce4LcsIhmycU=
X-Google-Smtp-Source: AGHT+IEpqVxY1V/LXReR3fxGvXZ1HzJABP+vEqTby2Byma+209RxsV5cS91eupKMTIqHtCVgxK7shw==
X-Received: by 2002:a05:600c:3596:b0:439:9496:17df with SMTP id 5b1f17b1804b1-43999da1338mr39434075e9.13.1739985311707;
        Wed, 19 Feb 2025 09:15:11 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399d55fc1asm19780035e9.35.2025.02.19.09.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:15:11 -0800 (PST)
Message-ID: <0302239b-e787-43e1-accd-e9904de56782@citrix.com>
Date: Wed, 19 Feb 2025 17:15:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com, jpoimboe@kernel.org,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
 jmill@asu.edu
References: <20250219162107.880673196@infradead.org>
 <20250219163514.791951626@infradead.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250219163514.791951626@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> Scott notes that non-taken branches are faster. Abuse overlapping code
> that traps instead of explicit UD2 instructions.
>
> And LEA does not modify flags and will have less dependencies.
>
> Suggested-by: Scott Constable <scott.d.constable@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Can we get a bit more info on this "non-taken branches are faster" ?

For modern cores which have branch prediction pre-decode, a branch
unknown to the predictor will behave as non-taken until the Jcc executes[1].

Something size of Linux is surely going to exceed the branch predictor
capacity, so it's perhaps fair to say that there's a reasonable chance
to miss in the predictor.

But, for a branch known to the predictor, taken branches ought to be
bubble-less these days.  At least, this is what the marketing material
claims.

And, this doesn't account for branches which alias in the predictor and
end up with a wrong prediction.

~Andrew

[1] Yes, I know RWC has the reintroduced 0xee prefix with the decode
resteer.

