Return-Path: <linux-kernel+bounces-358603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6099817C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A6D1C267E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97091C9DEA;
	Thu, 10 Oct 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3InYi2z"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542D1C460C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550847; cv=none; b=RjmZ9YD6HgZr32ykKYfwujW1xvmcXqGq46w88bQ/VsombP+f5UfOIkPeRbbgwruvXKUJ4opEeQmisBaXZtc/qilxfJhVX46RCutckXt1kmNhP8tqkRV2UxsLZS2EhK2Woq0Kfw21sPOHSvUVy+zB4pyZaCBIINFpoE+OnNYH7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550847; c=relaxed/simple;
	bh=64GymSvExgVvMNrrSC/SBelYlL0m/E5g24LZPGyj9e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u66wL18gnYGh3vQDznQfoIFRFIw7Q60ElpbGH/3g8+jMToxeYKOFMGNKzXfI0SiepfEa6ZXv15uW39bpVMlLQSpcRH1B8o9m13JkuwPlT9U3fI+It/5b7irJC30s1EJfC9oT44F7kE2LnGFY/bKNm50Svjz4DgTrTu596NX3DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3InYi2z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so808042e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728550844; x=1729155644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6ZUbOP6vnOr8QwFFV3qZt5HFAnMj7EcqvRJRb+VMhk=;
        b=Z3InYi2zSIry7QhIMv3ulvkGctQ8QJ0O2zBbJO5hiN3kxWQfyXByPPvhLwDZ+Ke3G3
         sCVeTBCZ07bP8cV2W0eleT54iyQTm5XwtRq5FzBw/JZ03ywAst8Fvtuta+DTSxTsAus1
         0gqIXkRl+nMtKrgGXWF7w2MpjRiY7TpV6yBF0bLQG6UKCMToOqXQHbgu6s1oCOcFvKZf
         I5zRCxHrslh6wkLDh+rEXDgtQWoPbAbOrt2NZaEdx1M5Ng01zcehVckUzMqih5tJYmPY
         LkhVJ9bFfBfwyXKk23C7+9Zk/k5SEQ6dIZ1aOT7i7+PPkly+MfNEFVsCJn4GPQHlHWad
         NdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550844; x=1729155644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6ZUbOP6vnOr8QwFFV3qZt5HFAnMj7EcqvRJRb+VMhk=;
        b=vJ/iTUNoOCkSzCys+Q20qXyQmcezPGZfLYKLWT1kbfFDrX4Z9PuN+nnkwjMWxXDAhM
         paJb7IfMoyNwycwDM8BSpGBECVnJxA+62g6A60GuBjgK9v6p3eeEpEvrLZDMlu+fROEQ
         BDZMmJZGqEsO1Mml7K2lHVpVD2Qrdw+EmTuH162l7AikWm6ugH12U1jJ14S+S6y/reAp
         pHLuould3Es/Enh068+hJfDJFQCZJmzEeh+avWrfIm5auU5c3/cZloyFNUGpH42+p4j8
         fdupTv3i2vP3HQh1QS2VlxYczfaHUzhFWD40iawYbJVxDxgk0QQjXdDCrepaFeHNAZ1V
         Wgow==
X-Forwarded-Encrypted: i=1; AJvYcCWP6kb/mDJYpEnaRtEHphHLEl4jv6/cXZ2nenkd/FcknKkXX5suHePpe1U9DhZ054BiSsE1qlYUUY9ivcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKnrrpjRIu/yx57YYArr6g7o6Pk+nEiSvMFQ6vBTKQwfjbmJyX
	nx1UnYXnQtExb+S03anlG6Q4mZRJJfLruYAz3GlmqzX3gPLkO22G6orbmdfS/oA=
X-Google-Smtp-Source: AGHT+IEhYmdPXd92bozGQrprD0sAK40chJEpD7T9tbzKjLmQAmUi+aGlgtqHNb//yZcy9ovMlVedPw==
X-Received: by 2002:a05:6512:3da6:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-539c48ea908mr3653639e87.29.1728550843489;
        Thu, 10 Oct 2024 02:00:43 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7edea7sm906254f8f.93.2024.10.10.02.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:00:43 -0700 (PDT)
Message-ID: <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
Date: Thu, 10 Oct 2024 10:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1> <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
 <ZwcnVKn3wVSSMcaL@google.com>
 <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/2024 2:20 am, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 9, 2024, 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> 
>> On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
>>> Hi Alan, Arnaldo and James,
>>>
>>> This problem was solved in [PATCH 0/2] perf trace: Fix support for the
>>> new BPF feature in clang 12 (Link:
>>>
>> https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1-howardchu95@gmail.com/T/#t
>> ),
>>> sorry I forgot to cc you two.
>>>
>>> Alan's thought was correct. Thank you so much! :)
>>
>> It'd be great if any of you can test this change.  Now I only have
>> machines with clang 16.
>>
> 
> I'll test this tomorrow.
> 
> - Arnaldo
> 
>>
>> Thanks,
>> Namhyung
>>
>>
> 

Tested with clang 15:

$ sudo perf trace -e write --max-events=100 -- echo hello

   0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6) 

                                            =

Tested-by: James Clark <james.clark@linaro.org>


Unrelated to this change, I noticed that with older clangs or with 
BUILD_BPF_SKEL=0 that commit b257fac12f38 ("perf trace: Pretty print 
buffer data") changes the buffer address to print nothing, and the '6' 
return value is missing. Not sure if this was intended or not:

  $ sudo perf trace -e write --max-events=100 -- echo hello

Before:
      0.000 ( 0.009 ms): echo/772951 write(fd: 1, buf: 0x58c415257440,
         count: 6)                           = 6

After:
      0.000 ( 0.009 ms): echo/760370 write(fd: 1, buf: , count: 6) 

                                             =

Thanks
James

