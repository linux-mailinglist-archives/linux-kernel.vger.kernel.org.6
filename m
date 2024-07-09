Return-Path: <linux-kernel+bounces-246572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD892C3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60E9281CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5C182A4F;
	Tue,  9 Jul 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NlB/DIDI"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44F1B86E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552084; cv=none; b=jpRlak8yix4qyUCQfItU0UwnRdD/l8xechhujttJ/+c+ZwrUFuI+Wz4lpyUSA0g6l4E1AjWQhkNW1+kO2/D2C0HAdoxEUwR46prLLvGqgUvSOnJrZY1Oy8EAzGspFCT2+dzqdH4fOehHnRaTxxZst8WH/LrMaI+o+fRUis+sg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552084; c=relaxed/simple;
	bh=rei3Y/rflO0sJmcsABr6+fL4nBcc3PsxXOHV5anzNqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfVS5aknOeiMDSQkYada3by2wmWP5Qjtw+GVG/FQ5rrRTATlzksoP+P8HF1nf/s2KWNyrSmlFaE//ncA0/LziqHUDB4HgQ4yrebFX157l6R90NXYavmGHm55yOzNMxWA3s61N8BLhN17+oyEKbiAN0uK+Q1YtD/PmxezQcn4VMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NlB/DIDI; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb41831704so19495239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720552081; x=1721156881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsWYO+mO6pfybl6hF359Rm3V5NZHRQbanLk3Net/gWY=;
        b=NlB/DIDIm6sGiYm4PchAK2PMdQADJpdXywtztRhH2UG3O+pK+gqylMrg08kCaO37xZ
         GD86n0gt/2SRcascFJOIYaKm5tQSDZy+j0GAbYLbJpAqC5yTu9FnAfN1bKYWI/humPfX
         q6NAcQCus6d1/C+ICDqKTWcnjg6TQussa0YYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552081; x=1721156881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsWYO+mO6pfybl6hF359Rm3V5NZHRQbanLk3Net/gWY=;
        b=kf/Pgymb8ql+h6/4bzXkZx3xJLbT6Fs687U9Vt9MgugJErBcUVfM4ztOI5qndO8wIh
         xnvbmnBMGeQJvWzXz2ZCRUZeNQclytSMwp6yYjfKymqu+kJcSwr0NUi3jCUM0Kr6IcSg
         kcGW5q4go5G08GU1imBei/fwBzSnUQTT8ucuthcmTfTuCyjN43jkbjDqrwL13RxvFAPW
         F+Qd21At04fs8qUjrCrbFQOmRfjgzFj5/P+v6VbbZgnrjcUar/vV8epEq04KmAc6xXbj
         R//Tuv6kNVLyLg6XvlOHqUcVb4Haf92HeH6rQwk1lSFbyAIBLJCpb/mZGm/RTbnxSpZ0
         fbgA==
X-Forwarded-Encrypted: i=1; AJvYcCV4fUhRMtwHl2umjzPX0yip70quNNvPY+si0ljEy3D6lXhwTDX45FeMU3FUfElpS/UQpMD/C9YOfB6b8s5wG15zwHZoUcGT/T0BoFo3
X-Gm-Message-State: AOJu0YznlWV0dk7QAjGHluEWCkSmRy0kkAhFIJWxjKx5e47E1ePi4uOD
	DxRhmajWwS8mH6+DhDW2iS0aX5PGuuqaPEyO01KQi+uiy22bugDbID4QdK1JfuY=
X-Google-Smtp-Source: AGHT+IFjWd0i1e1pvCH0fJ8NRj1l2jwsPnsIwaAX38VUhDk9gD1dgXXMmZOlDTIebBSbKJo4kQ3swA==
X-Received: by 2002:a05:6602:42d3:b0:7f9:89a2:b846 with SMTP id ca18e2360f4ac-80002696c0fmr312703539f.2.1720552080855;
        Tue, 09 Jul 2024 12:08:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b0d3d5sm637695173.42.2024.07.09.12.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 12:08:00 -0700 (PDT)
Message-ID: <73fa271d-c607-4880-b796-7d6be31d9085@linuxfoundation.org>
Date: Tue, 9 Jul 2024 13:07:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] selftests/breakpoints:Add return value in main function
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240709095109.3813-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709095109.3813-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 03:51, Zhu Jun wrote:
> Main function return value is int type, so add return
> value in the end
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Please add information on how this problem was found. If you used a
tool, include which tool and warning from the tool.

thanks,
-- Shuah

