Return-Path: <linux-kernel+bounces-286389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09205951A54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F61C21B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AE1AED4D;
	Wed, 14 Aug 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YS7Fsndh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5411AED44
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635819; cv=none; b=KDz183MMXMXl9pnEy+mVm3DPzFHOqU+OTLjVi9V9Go49gSuHZaVlzzE7r9gxUkvccH4xmCWJX8BVzU1KkfAjmE45n3LgqT5B8SVH43a4FvZigCh8xey47Lvfp/U8mD9IwCWCPjKePQ9upfZfuhmSAfij0K6phGp5e6alJY7TASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635819; c=relaxed/simple;
	bh=TB/0oHN5F5NutnVQ1VWFaykvrUJTjk/6Yb5WW2uT8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6EHXovdmKFkxP/P8rDftfLWEAC9Z85Yqlm5vZA7Yh1a8r4uoMQophNr7KwcNMQeKth9SSd/rFgEU0BaI5zhfDCy+ozbHxlcZx56dks4kLog/cpfOKUgelGuLug00wQMrv6Pxf1RBi7hnhrpfIMAWp6EIAUjEZ7Y2cNbxLrques=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YS7Fsndh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47aef524so4474315ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723635817; x=1724240617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u39ng7G3Zk1YPobD4C5U+D2PWpoaCE9N8Zqv41C64w4=;
        b=YS7FsndhK3EA4mr8eYrQXKght7/mm7PlXOgK65uRhsCrJTwqvThQpT0NLfWZqq8bAM
         lAL02hd4nhN+xCoYFsMeJO+4H8qyd4uB9ao62kda0Om6X9bn3Prw2zQItOBB2cWq1wEZ
         MzFba5s4CVBm/fjDxz/kWKl41EMoM/bX3jcdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635817; x=1724240617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u39ng7G3Zk1YPobD4C5U+D2PWpoaCE9N8Zqv41C64w4=;
        b=Asg03zwEl7yzFIbEdddRoKDbUwD3Xd/KOE8qK+1xTCoSP3dZAyHRJMhtk0unUFIdLb
         Knjb7FMjSayHJaqpivjCggoOQDBBASC+/rLdcTqJCh6gFEf6VhNMQdmYKn3STB03xoo8
         TCI87hihze69iyKlTXRistVWMJWAdF1q9sOtgXKbx1s8+xgB330skfTts+qYn9AwAKuM
         8kvjsJwmn2vhNZta5pjiiEOg9kszYrtDe1rrNARBT8Z9hp3afyW7HxI9/KYOFDGHvDXt
         Z4iFiFhGH0/FH4ABbrxvPSnIcwSMVxYeM6tz/juonRDoLcxcBCAGgnmEWgDlz9uLRAa7
         EMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWH5swNW55C8JVH4XX8ch0zV5pV0ENLhwKb14onzS/KtErtw931qCEG9uzEBR3xOQgQyjc2kh4wzBGlCAstOicsU5UPpKjldj3aeBLu
X-Gm-Message-State: AOJu0YxXYafgkvPZQkxRa8raK13hs8Ulbf/xNEPAl1T7LmLiFQF7q8K9
	TcNrvBzI/Wrl7pNR/zZGyqITasShcBga5Qk6TSjaLpp7xkOG4Ek1ZHX0aijUf/Y=
X-Google-Smtp-Source: AGHT+IEz4zBtaa0fPbf9nGtUh5Q7nwM6G4j1+p2RsMPWqPZhHyGalhtvg6CVchZywIYfMtCQ354e6w==
X-Received: by 2002:a17:902:f0cc:b0:1fb:1ff1:89d2 with SMTP id d9443c01a7336-201d647f0f5mr17105525ad.6.1723635816658;
        Wed, 14 Aug 2024 04:43:36 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93e2sm28176755ad.141.2024.08.14.04.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:43:36 -0700 (PDT)
Message-ID: <9016df04-041b-4837-9590-1c5159609826@linuxfoundation.org>
Date: Wed, 14 Aug 2024 05:43:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Add required dependency for kprobe
 tests
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <171823033048.152840.662759412433336839.stgit@devnote2>
 <20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 18:53, Masami Hiramatsu (Google) wrote:
> Hi Shuah,
> 
> Can you pick this? I confirmed this can be applied on v6.11-rc3.
> 
> 
> 
> On Thu, 13 Jun 2024 07:12:10 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> kprobe_args_{char,string}.tc are using available_filter_functions file
>> which is provided by function tracer. Thus if function tracer is disabled,
>> these tests are failed on recent kernels because tracefs_create_dir is
>> not raised events by adding a dynamic event.
>> Add available_filter_functions to requires line.
>>
>> Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

