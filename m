Return-Path: <linux-kernel+bounces-250710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DE92FB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15241C2269C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EC16F905;
	Fri, 12 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMdt9gcJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FE17108C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791504; cv=none; b=jfwcWFGvqNB5G1kIEvWF6roSN/UKiI5fczYAO6iZws53Ivj9SDApbU8DLJMXV7XbobWDU2jSDoQ3u7Ab0n+uVOyc278xEAB2ui1C9Ppg9SWDjJ62bgUt65EJsEpqqX35blVjMvpIGKrtRik15La73bYlY11/BXEv1AqHBEyK6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791504; c=relaxed/simple;
	bh=T4H+8IrrmrAPxWFvSUM2MhUOGIEV5vFXnhSXl/h/Rqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNTcrFjvkDSfoX/JSxOhdtwqf0Bnn2WtiK3IU0+smldC0K+Xy5AquO5HoH/60Cg2n4YiaBpDYfgSTy13sk2UU/EYzo7QG2ZhUEp7gwAInF1OeHh2sHbZNecQ17JM7pmds7BA2PrqEyab/nQDNziP7sjEkr2zszYoAIoKzif3+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMdt9gcJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so16122705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720791501; x=1721396301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cC1jAi1iv6WdqEK+EAzRU4oNQ4sXJVOHSwTyXKEqpio=;
        b=BMdt9gcJBTT6iTeXHxpNtOVkFEZ1WlV2zyLJ68qA4m5uRvIyyhtrlgEa2LBBlt1Pxf
         xWBu7XvXRsyIwhsVoFy5FUJeEoBArcfkgUBDEot5qmV87bAUvVgBc8qVplHa1qjQDzCd
         5a1sGUt+T69pRBCyebeQxXK+MKtJY270oiDialzb6qNuJByTFmWea3sZqlWuOkcOaLGL
         E7j54Q2QsA8sH2kMG9NGNb2ubSgekBarhCCZW3qoCpiKatqnO0jthmKnCasusv1liswY
         zYaLK08R+Fugru56hLVuSCsP4f5Rw4/R/yzmqKXV2cCNEGPlRXlhRSOKxgIdN0z8MvPl
         RTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791501; x=1721396301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC1jAi1iv6WdqEK+EAzRU4oNQ4sXJVOHSwTyXKEqpio=;
        b=NilC3ennPj942TrDooC2L/+CKk3gdKe/0l02ICg/cZEImKwr+xIx3Jogwtx+cxooRP
         20WspiTvAcV956UD+2M5hO0cNEds4v9eujzSZ05T5/xkndgYE2cxldvfpDHnJYAXdMbh
         /668l+wtQU0B4JKjWaBPTUvruwThBtNTcxFq/hZfn/nwznqGCEEch5R45ITldwWQ0c3/
         Yvk52+dAxGqk/JZ9mDhxIuo1herF3iazkf0+3unC2FLDxBQMBDANYSsOcVUszcGDOTsO
         JSJAabmh1FpCEr3Dq1YbWhSud5wdo/XBHnYPEpTx5TBsKSofor1i3VVqib3SaTQgS+eM
         55xA==
X-Forwarded-Encrypted: i=1; AJvYcCUgK0PZ9zlLcr/buDN8nVVGfy5Mz4phL83PLAfV0VrNjLkEStstj2dJO9k5QIMkHQQjCFd+cgU9rITOMtTc5hWkv829rPJPNdo3++62
X-Gm-Message-State: AOJu0YyVYXGQ/DPQtjNtPyj4p49+33qmb85waGVqRzQdSmOR4f5rviLO
	01VGLw9DKFof95l44M+qeD0gXC8/DJP4FqDmux93Id/LSTH/0P/s5NyGOvxTWnw=
X-Google-Smtp-Source: AGHT+IEhyKGkl/VF/a4vHFezgDI+nStbpoqP8KMLCsMj4wEfKGgRy7eiqctDREifaFXVEsurbSfJFg==
X-Received: by 2002:a7b:c052:0:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-426707cf827mr88262375e9.14.1720791501208;
        Fri, 12 Jul 2024 06:38:21 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f265ce6sm24098085e9.16.2024.07.12.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:38:20 -0700 (PDT)
Message-ID: <83301e3e-e049-4af4-9f0b-29bdfc201543@linaro.org>
Date: Fri, 12 Jul 2024 14:38:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building
 document
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Changbin Du
 <changbin.du@huawei.com>, amadio@gentoo.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240706182912.222780-1-leo.yan@arm.com>
 <20240706182912.222780-8-leo.yan@arm.com> <ZpC3-p0kG7dGkp_5@google.com>
 <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <3b16778b-f825-42a2-b53d-17c9b8c22a52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/07/2024 12:02 pm, Leo Yan wrote:
> Hi Namhyung,
> 
> On 7/12/24 05:58, Namhyung Kim wrote:
>> On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:
> 
> [...]
> 
>>> The Android NDK (as time being the latest LTS version is r26d) changes
>>> toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
>>> anymore. Therefore, the Android document contains obsolete info for
>>> building perf binary with NDK.
>>
>> Do you know if the version prior to the change is still used?
> 
> Based on the Android NDK wiki claims [1], since NDK r15 (backed to 26th
> July, 2017) "GCC is no longer supported. It will not be removed from the 
> NDK
> just yet, but is no longer receiving backports".
> 
>>> Furthermore, the Clang included in the Android NDK is problematic for
>>> cross compilation Aarch64 target. The building reports multiple errors
>>> with the compiler aarch64-linux-android34-clang.
>>>
>>> Thus, delete Documentation/android.txt to avoid confusion.
>>
>> If so, maybe we can keep the document little more and add a note that
>> this works only for some old versions.
>>
>> I'm also curious if it's still broken after your fixes.
> 
> When I tried Android NDK for cross building perf, it is still broken after
> applied this series.
> 
>  From my testing, now using LLVM for native building works well:
> 
>    make LLVM=-15 VF=1 DEBUG=1 -C tools/perf
> 
> But it failed for cross compilation. Since Android NDK system root does not
> contain some dependency libs, we must use extra options to disable some
> features (e.g. NO_LIBELF=1 NO_LIBTRACEEVENT=1). The commands I tried for
> cross building but failed:
> 
>    make ARCH=arm64 CC=$NDK_TOOLCHAIN/aarch64-linux-android-clang \
>      LD=$NDK_TOOLCHAIN/ld.lld AR=$NDK_TOOLCHAIN/llvm-ar \
>      NM=$NDK_TOOLCHAIN/llvm-nm STRIP=$NDK_TOOLCHAIN/llvm-strip \
>      OBJCOPY=$NDK_TOOLCHAIN/llvm-objcopy \
>      OBJDUMP=$NDK_TOOLCHAIN/llvm-objdump \
>      READELF=$NDK_TOOLCHAIN/llvm-readelf \
>      HOSTCC=$NDK_TOOLCHAIN/clang \
>      HOSTCXX=$NDK_TOOLCHAIN/clang++ HOSTAR=$NDK_TOOLCHAIN/llvm-ar \
>      HOSTLD=$NDK_TOOLCHAIN/ld.lld VF=1 DEBUG=1 NO_LIBELF=1 \
>      NO_LIBTRACEEVENT=1 EXTRA_CFLAGS=-fgnuc-version=0 \
>      -C tools/perf
> 
> Given the test result, my conclusion is the doc for Android cross building
> is not useful for a long while. If we really want to support it, I would
> like to suggest to take a separate task for fixing LLVM / Clang cross
> compilation.

We could replace the entire contents of the file with something like 
"Android NDK compilation deprecated -- no longer supported". It might 
help someone in being able to recover the history of the file by leaving 
in some keywords. If you delete it it becomes very unlikely that the 
history will be found by someone trying to get it working again.

> 
> Thanks,
> Leo
> 
> [1] https://github.com/android/ndk/wiki/Changelog-r15

