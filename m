Return-Path: <linux-kernel+bounces-253524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8993227A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E623C28270D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33815195809;
	Tue, 16 Jul 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSr7Jrpg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CE4C74
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121024; cv=none; b=pELdTqdFSW99mjccIne0pw4P9dfMp89RGfLBb+YGJbqlVwb5H5KZpqDnzfp4R8kQ3ytkdrRedGoJj/M1IC5XquNNM+Zt/TvOP/Z/pN9kN/fGjxCJtUa32ikRxvqHB3Vx4/pwtfDUnw+O6TmDNGYzRA5z0566XLcSHZQA1gdF0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121024; c=relaxed/simple;
	bh=YQTpwHzj19jUeZSWEKD+B6nfNJ6GFvEW+HxBiISSB8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmElQumFLGY9Cqeyw0nzto7xO8MeFCRXmiIoxlPbTJMldxhL3GJrqdKV8J5Tbmxg0NDSm0Pq7Zmwwbxki+05qW86+TjFy92sKCrVv6G7M2CW3JOOXjZgT9ytsY7uEbBP6DPCO4nI2IFcHB7H6d3JWLhU9SpFQFiYmlLr+72Ulro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSr7Jrpg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42795086628so35224855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721121021; x=1721725821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmDu6LpHxXI1mpawm8JNyqvXpkeHQourXad6ibcL1gQ=;
        b=xSr7JrpgdI/xvt1+r31pszxIYDkMqWlr+asQd138vuINEh2y70Mq2dRWyqbUjBZTRv
         cjd5Of++aQDByLmgnorE4tdyIxqZF3oGNzPVYT5JAf8mm+Ldap4ld/X35qVDIydpRAuD
         PHcnxwAxkRJQtnjvfudMMRepVHDM0W0qIqns9eYTqefOIbiDWl7fI/NSImAzxb268b/E
         43ygKFoFgOnvV0YLjq3tzdTKfiRePnU/eswOmJQxy2YbhSoPFmDqm8sHV2+zcJP906F8
         /yg8WAhWm6wmRmXfhwmtr6DknODqm54jqWK+AlmsB5oG2hCtAU1pmKBlEssXP++hSmHJ
         Mv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121021; x=1721725821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmDu6LpHxXI1mpawm8JNyqvXpkeHQourXad6ibcL1gQ=;
        b=vInFabwG9ldboykGD8WcOCPkiLpt9RROFcwebfxRA0mxiGkx4hO3/WOwU7VToFHDMB
         0aQYtyAtfaIr4mvT2Ez1gL1Zga0977f4LbbDBCTRrQAdQzLblrOJN6MnInZH0WqiQ0mD
         4XegOhGXxfCz3UJummRB9T0jqrzqqkEWODzajGAAzsJW5veWRN/4UWaNRaSx2OOClkuy
         K4INICFybdd2PFDvkTAMFVxYHZJ9GDy+fwsCCwNXZ13A3OXnqO14RT5Y8fTZ5N2BulZV
         MhJgskYBFng86xN93EmIMr5euuPRUsTKoNBTdZb8CPLEdsZbdwVkPoArStXQ9BeqkH1D
         /X0g==
X-Forwarded-Encrypted: i=1; AJvYcCUoSTBRYm6fg5PXowsWGk7H0LuD0FVAQrvG8YQtrkKqNRrC8OXzprZrjQ/rMJ3wbJqmNqZx0eMjL4PcAxqeeGFacZzi1qKVphd38IBn
X-Gm-Message-State: AOJu0Yw0fTSS9E3RfzQZOVGWAs+tOq7n9naw8e4038Rm1D92z6QzxcK/
	Xwp/bTs5+29k6nHlQtyZO3pk1vWP8uWL6EvphtvLEn8jeQS3Z20YUrSly3Hhleo=
X-Google-Smtp-Source: AGHT+IFjvmlm1Pa2B5lJ+/r3HN/TpnBw7eNCgE3IgOOP1k1lCoLOaVZdKhlUdILsSRDrICcc2rV1oA==
X-Received: by 2002:a05:6000:1fa8:b0:366:e89c:342e with SMTP id ffacd0b85a97d-368261dddcbmr1035125f8f.53.1721121021283;
        Tue, 16 Jul 2024 02:10:21 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb979sm8456418f8f.75.2024.07.16.02.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:10:20 -0700 (PDT)
Message-ID: <1e5aa1e1-e5c4-49bb-a43b-a119710a000c@linaro.org>
Date: Tue, 16 Jul 2024 10:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240715143342.52236-1-leo.yan@arm.com>
 <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/07/2024 6:17 pm, Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 7:34 AM Leo Yan <leo.yan@arm.com> wrote:
> [snip]
>> +Android NDK compilation is deprecated and no longer supported.
> 
> I think this is objectively worse than just removing the file. It is

Objectively worse is a bit strong. There was some discussion on the 
previous version about the reasoning, but the point is to leave keywords 
so that someone re-writing the NDK docs in the future can find it and 
then the history will be preserved rather than putting it in a new file 
with a new name. Or even someone wondering why their build command 
doesn't work has at least something documented about it, even as a negative.

Of course this all depends on whether we decide the Android build 
_should_ be working or not which looks like is also being discussed here.

> likely the perf tool can build with clang/LLVM, I do it every day, and
> the special case for Android is likely more about the libc (aka
> bionic) which gradually over time has been becoming more full fat -
> perhaps we need to carry somethings in tools/include for missing
> definitions, but we build with musl and that's a PITA in this regard,
> we've also been reducing the tools/include dependencies for perf trace
> beauty support. We don't use ifuncs in the perf tool (Android's
> linker/loader historically hasn't supported these) and the weak symbol
> games should be okay and something I aspire to make less in the perf
> tool over time. As Android uses Linux then it should work and should
> be supported.
> 
> Thanks,
> Ian

