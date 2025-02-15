Return-Path: <linux-kernel+bounces-516017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA0A36C08
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EC5171DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52E1624F2;
	Sat, 15 Feb 2025 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdbMv6dC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C9144304
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594807; cv=none; b=b6Rdo+cKJEdrXzKGsS5RkcbC4WYixjUbdGSuiQS6Eqm8CWgqH8yh2lcAUNxDchmg9Nh2oJjzcbwYlqUp75wrR5fMZ5z2ZryWlBG6WTy2GYDX/zhH/PpQLbpdGta6WUvaYfPsMwNxLBLDhdaqkhX2x0ZW/4l/RnXjxLLJAAyw2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594807; c=relaxed/simple;
	bh=C2igDQMmg66F5Rwd10UllTHaBSp1jfeEQJpCwhoE718=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5z8kVxShMFkYJkPXgjwrv88y5/gPjBre0wZpL/AcS4Ctn+tzpS82QOw/RlhBFimfytbp0SiyjAgMi3pJs/GA+51DkrWDmqIYq3eT2Wwl/8i019ThE1pYXgKElBDpnSrEVSy5/aIekXpz/729+4yeVlLqSzzI+0VDKXM1dWeQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdbMv6dC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f61b01630so61214715ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739594805; x=1740199605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlGkSHC+29Qdb3t6NyOcNTdZSBupXOOp5HcUMYyzx6Q=;
        b=cdbMv6dCX/t1uxiKYQTluBF5tN8NhUNlzULJfXUw+LCkzi9j39z1F5MSo1eiXDSVy5
         buinJXryB1i7A89vJEEeleOTP2b9PzayivFSV4P84F/Uv56PPWJ6IPW0S8dNzYBwjqYJ
         PghAREuhGapf6SOoXuem8k8/Oo0PTGWzkqLrWmv4coqxG+gmgtPfLLFdK9Hm//livFlS
         qO1pvTLrAp6Z2Pu+zEiY+NisQ1wX4DkqPNSWrSVkpqeuE3J26aoqKZXzfA0kvS/nmqCH
         JbxiUbSb+IR2J3Uc3YXXoMrQhWzL2qiQH+ErEJImQdvysX5l/rIm4A4SGuuVT8Ogb75Y
         9Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739594805; x=1740199605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlGkSHC+29Qdb3t6NyOcNTdZSBupXOOp5HcUMYyzx6Q=;
        b=Bg4HBVlEwssnYnzMDWTxQcba9smZB9T8OpefkGpKU1sbzCwrcRHzHcdoOM9bsHh+9k
         R6xPrrSLKb+Q8BZC8lshUFnkzkbangmuEu38YK151LvFmU+Pz/Lv6vJtCF0BeCbDM7xr
         R72uYry/dnKs/I8J6Cw9MJz2WJdMr4h9jpPyS9gzUqfM2Tps4/rfmzZFkyQPmjoyfgAh
         SG2nflMLvS0OAZnv+t2rroqNaAEndoi9VEAkb64gndFkiaY+BqspZQHaQWJ9ihBvtwL8
         EgcNiRkVWTvd4zErVN1rNWxWGE7EAKd2JklxtLdYlzFR976F+oaBUaCXs4s64tgNsIdH
         ixGg==
X-Forwarded-Encrypted: i=1; AJvYcCW2GhJi+KdySX2bCrqxAJrJxSCTGrCkllmczveVh5fJl8+woddhvSdHolZxDCoWcKGbPRSdDSMv826fqB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbEfvdkbtC8y/s8w7ZYXJqQkGXIX++hvf6d/aKQuqaXBgsr92
	FB9Ar1bTjo7iFdYP/E3nYr3MPN30GsO6Mfrma0zNAKstcp54qEzd
X-Gm-Gg: ASbGncsxKX21X4sRbNKGCyWW4UWZ4iFZQ1n/Y7ub+DXOZIK/pMifWhJxM/i1yUMlx+K
	FtnahF3fK3DGk38wReRhmiwEsHI5iRPemUkKqeMW5GlIiMqBAx7woK24qIUHdwaOvbq/oPVr3eN
	OuE5C35ny7fe4exHzhDnFXmCcojctJ0DzKCfLYAbC4arq2XyyWvF9g/j2o9J0HH7LLIwHEtKrkH
	4awruSuZaqgl7NnS8gBS3VA8c7a7ykZCdflBBVKJqDPp+vq8v1wKvnjQ2XE3kYT0Xwfa1iayube
	w8sj1o8pIeJv9whkIh9A
X-Google-Smtp-Source: AGHT+IHU0NxPN0WsVg2OChmjHxCLUmIhi80OjWz2ZHonA7rsDZ4Md+KHEPqpwXgkcNQb0PKNJdZCkA==
X-Received: by 2002:a05:6a00:4fd2:b0:730:949d:2d52 with SMTP id d2e1a72fcca58-73262158ademr2966681b3a.3.1739594805107;
        Fri, 14 Feb 2025 20:46:45 -0800 (PST)
Received: from [10.3.72.248] ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a92d302sm3768366a12.70.2025.02.14.20.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 20:46:44 -0800 (PST)
Message-ID: <260b1542-a9b3-4541-abbf-0edb796918f2@gmail.com>
Date: Sat, 15 Feb 2025 10:16:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: sony-td4353-jdi: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250214172958.81258-1-tejasvipin76@gmail.com>
 <20250214172958.81258-3-tejasvipin76@gmail.com>
 <CAD=FV=U22kToVeyCBy_TV5hNKuMZv-QBUg0WTyXsMSu=bHLd3g@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=U22kToVeyCBy_TV5hNKuMZv-QBUg0WTyXsMSu=bHLd3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/15/25 6:12 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Feb 14, 2025 at 9:30 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> Change the sony-td4353-jdi panel to use multi style functions for
>> improved error handling.
>>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>>  drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
>>  1 file changed, 23 insertions(+), 84 deletions(-)
> 
> Nice diffstat and so much boilerplate error code removed. :-)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

If I rebase both the patches into 1, should I still add the Reviewed-by
tag?

> 
> Note that I'm on vacation next week and it might take me a while to
> dig out of email when I get back. More than happy if someone else
> wants to land if the bisectability problems I talk about in patch #1
> are resolved. Otherwise I'll get back to this eventually.
> 
> 
> -Doug

-- 
Tejas Vipin

