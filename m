Return-Path: <linux-kernel+bounces-530246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36AA43108
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8613B252C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBC20C47C;
	Mon, 24 Feb 2025 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bU8SkymR"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92120C00E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440346; cv=none; b=JKYM6guaR+sVhOMY/qn8SCGUZfKW2GGLBUuLtwUJ99pJQMqGj3udTcJHmrY1QoqnrwbW5A15c4LJD/trywKuhM2RWBFvoKnX/Wgex7DTrEjtDPoRVrdfS8M70fi1KQ6moMF2Dh6paFY0DRvsgwmY1oB4cQ1KleasF8bO2FcTaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440346; c=relaxed/simple;
	bh=3lVc+5dTZiFq6wniYAuvLFwKTWVN+4997r/543iUdgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoMCCZzeT8lguMximU8Tm+LieB6mFhcdgixqMa8rttTzCkwLsIC1sRPTNSm0fYNphVzbPDF4OhG1k106P2xFpgQ/b8cPbvxH2+1wvAVd8WxTy7TEi1LNltlOpDGQw81q/ukQTxnI7boGy8jVGnL7xHv/KHxSBk73EKDpH7cflG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bU8SkymR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8559020a76aso128960939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740440343; x=1741045143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OigUoZkxEnMYhFf3bc5EZSymLsAcud3EtHTg6CnR24=;
        b=bU8SkymRymsfb6ksl/WHIyuMkwt42yfFMreECVeOnwCf2uHf1SQ+wPm2lVglPhVVzV
         udz1P0Bsfyi4LhL71XaH8rhAQmrkMd65KveffVoXNGYBAHRMlHS2wQgNk0fVkBoV1xPc
         baCihYSsJQ7nnjIarqVUZ5JYZGK8rRZ0E4vY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440343; x=1741045143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OigUoZkxEnMYhFf3bc5EZSymLsAcud3EtHTg6CnR24=;
        b=Kb3zm5vRVvuHImi7RleoUhO/w3pTd5BCps+SDDVqapImls9I3pk6/MyQzszi8nnoLV
         blG/A7M9743WZ+jlezrNjqy8wvI3s+1TKJYQK0PAbqAYhB1zyUwAmjuTeWUaCUt53hNh
         INhu0eFt9m463aJg9ZhEBElm0Vd14UyVLVy4N/L35mdxJj3YfYicKM3e+JGTTIoMZpnS
         uxunetXOJ1tJAT/WHx0PZyPj876Ndnrqz3EogC+7Hr1vNq4uFnQpF1Ww1HDcd3Ee/lu0
         273sm8kJpYoC7lFXaqnQhS0ClnG1Hlxw2SUf+vG7mAJquVBc6Xmgjg/msuGpzp/BSJdP
         IJfA==
X-Forwarded-Encrypted: i=1; AJvYcCXFAujIc8LxYQMO2Y47y6g+HrU+RBohqHW1FY1c7v3MLjAQiA49vxhSFhRa28mBW+hCh4XcHridy9NIGh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqOzIMrvxZGWKbdP7kWaEc0KVesfGHXrnqIEIhv7BiDepdTst
	LA3XTHljk1U+eodMOhsRRnrDS5z5r9jmYOgkyR1bKWFAnz/jC3IUm8MWUM1G1sI=
X-Gm-Gg: ASbGncuTas4iaa55hx4eUeGycoik53jqHN+DufHBLIQ/mCxp3aDcIWiXobhOQW9QP7H
	V8cMt4SaysBfff5yeSn4km+roQU0OwJ2k33GK9xhDuXAwlTuT61EiVLeFAbk5Amh6eX6cUb7jeM
	/ZjPnh8ZPLSyemsyOtshaNgkLN6zkzQUKubEmCewdekMre6UCzIvH6pEEaq0ONGM2JNMZ1RVBXv
	YVNVx0WCXuXlioKP0dO0K+1mmbOIgMSBwwtaOLszjQRY7eLFHn2loG70pxT253cAURhs/sn7Mxg
	FLEj0uDQBlH+S5wN90g/s+tzXS8Nq/Kbkvs3
X-Google-Smtp-Source: AGHT+IHwgh0Tkg2+nCDdsaRpCpyME0bSd2DyoWo9EL78dGtAoeJm0IkIF6S9zRdlQR3TVricsokBug==
X-Received: by 2002:a05:6e02:144d:b0:3d2:b34d:a25b with SMTP id e9e14a558f8ab-3d3048a664cmr11647415ab.16.1740440342885;
        Mon, 24 Feb 2025 15:39:02 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744b536sm134991173.17.2025.02.24.15.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:39:02 -0800 (PST)
Message-ID: <2bac45a3-bc90-4740-a7ae-051de52eac60@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
To: Steven Rostedt <rostedt@goodmis.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Cc: realxxyq@163.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yiqian Xun <xunyiqian@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250221033555.326716-1-realxxyq@163.com>
 <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
 <20250221122842.379198f9@gandalf.local.home>
 <20250224192105.GA48-beaub@linux.microsoft.com>
 <20250224142624.47733377@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142624.47733377@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 12:26, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 19:21:26 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
>>> Beau?
>>>    
>>
>> I applied it locally and ensured it passed (seems timing related).
>>
>> Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
> 
> Thanks Beau,
> 
> Shuah,
> 
> Please apply this patch:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thanks. Applied to linux-kselftest next for Linux 6.15-rc1.

thanks,
-- Shuah

