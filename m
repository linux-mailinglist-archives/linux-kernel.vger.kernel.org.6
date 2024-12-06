Return-Path: <linux-kernel+bounces-435554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3789E7949
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D42832C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAC1C5490;
	Fri,  6 Dec 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER/3AA0k"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA61C5484
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514621; cv=none; b=cQlGYki4Q7c8iCfnje+wMe1PH1g51Pe8hQMqY4jyaSN45Xt3PxkBFo/foXxyonaMHJE8B90ZHlekc7pzqpZkTCeYRdjY4SdY+4+9r1aYIXz0MBzd9968KuAZVDJPU2aeG77TMsH++vAZVFv2vQ+tgLhukekxrqqbAL0/Xnjzkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514621; c=relaxed/simple;
	bh=7Wb7LqwxuNOLv536ZY2v738t45HETn7WLnFlPxrRhVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfYa2GAxREsQ1ncxKDvW4+0Paj+Vhhsrl2FMR9jxz1kMcGwCopO6mdWfQM4PjEaOHzZmjmpBVTgelgtIqNMmlOo9lcap7uo4wKa+hehVXx1NHEAriG/PmBumFvyCUuyhC2ubr5oGzcOtzaVDEOXJmVAK+FjapyhYfjpjP48e7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ER/3AA0k; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bc7d126b2so1048991241.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733514619; x=1734119419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgYtVUqUlEZ8VSuTq+I8ySRpCil6RgGzEne2MvLY5yE=;
        b=ER/3AA0kmA182GVHA9YrD8xXq/+Q3CHqtf7tospYx8hqK+9HTxLuMZZE4jPR+hhszf
         9St8yIJ9zHszsi5oSaylwaQsoCz/VOj+Z/adJVJxeJSY3Ee/JYm/mCBS+/IiTUJWdILG
         GwcnWedN2saeglmDwX20ep3kL3rlnM5zSxuq4+g4B38umnQc3gW6KzAWiRlV+AHoQlgC
         iTNSzb8riiqvZwfCnCKxRV/b6ZFq07/ollk4YWGhcg7F+z7xbzsMtOjmz5yDO8FwwIpU
         YjgJEspXPP+41fxXuXQZwGu9Vo/OSxuXqyk188ZAW/55A2RLkjsr9S99/lWe/iE3w3aL
         2fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514619; x=1734119419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgYtVUqUlEZ8VSuTq+I8ySRpCil6RgGzEne2MvLY5yE=;
        b=SH8aKaWBNHUFsFi9He1nyRdCYWPwMZByxsjRSlIzj14dxEQhj0AKLOYl4Pi83CWNzw
         hJ2pP6am472kR9Brn68TK78ggnyAlNNTJnENYAcJA0fW8UpVhe+LZuAR3Zjh48dr86tr
         6JnPZsIgeE3Lg2UQR5jfCGi5Capfmshn35xFcb1bjR59X6d3pDSEu+3PTBj+iMYdoJuV
         829II32k286K79SV3jxMyqkonjYfUNtQOeglRr7eC3bAZcpXsXJY19FlJxBQOG6wDn0t
         IfSzZuKF81p1Bmb0U/dq3pfoC1rkgKAvatOWOYOGX0TB/Vl9ArHCbjwq78PX7Ct0ANHh
         /9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNN8gDNLgXeoFcU7NTGRsci8jE8JGliyXr0hZAk4W0yaITXWni3FYgx0OYWXtLOwoD66/khA6eXG/HlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyZkh7+Jjbo2b/O18JVZGGQFH+TCPJBrkwG4XEJNqzXCZ3ZHT
	ENT6nlz6dWoYU0Si9YyTmVfddE0D8e3z5hHkrRJPC9368DWKTKnxksvKqTYgHPE=
X-Gm-Gg: ASbGncs/UqgExvsupS1KGM5gvxvyk3yLQ2O3QuyeS7CZdzRX24SGrnlr7wWTcaA2w8M
	TO4COgwFCKJl+ColYxl9NpXdiCSEnS9roHVyKHbXvu2r1Idkkhj4al6C7G2oeThb4EYvySSSiyk
	RRRzzK1yBsTRhyhE3TqrJHeoi2f5mAF9/2GP8giZ6UIGMeGFzYNPOpHgb2S0//8dGe8j6b37oLX
	fCAnzfwYWlMuWjbZSosAxOav8ndpog5nsEc6QtoH+lLwcaZSMPvBu+WTwUJT3Cqn3Abwg7jG3i3
	/l8bjicF
X-Google-Smtp-Source: AGHT+IEeWUUJbrxyEjeWWA+oNy8sSHBMGYhIlHk+x4xxBQvnZSCGxkbHgUu85h0IP51FdasOJcUIAQ==
X-Received: by 2002:a05:6102:5486:b0:4af:4ccf:e99 with SMTP id ada2fe7eead31-4afcaacd044mr5735787137.22.1733514618823;
        Fri, 06 Dec 2024 11:50:18 -0800 (PST)
Received: from [192.168.1.124] (49.93.157.89.rev.sfr.net. [89.157.93.49])
        by smtp.googlemail.com with ESMTPSA id a1e0cc1a2514c-85c2bd4f2fasm552887241.32.2024.12.06.11.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:50:18 -0800 (PST)
Message-ID: <2eedbbe1-6b4c-427b-a369-5b08dc27deaf@linaro.org>
Date: Fri, 6 Dec 2024 20:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] firmware: add exynos ACPM protocol driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com,
 peter.griffin@linaro.org, javierm@redhat.com, tzimmermann@suse.de,
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
 <20241205175345.201595-3-tudor.ambarus@linaro.org>
 <ce757b8e-4e6c-4ba9-9483-b57e6e230fdf@linaro.org>
 <vxqi23hxw7bmtfs5wk3u7szganpv5aa74b26xrvpmbehkltodw@dpum7zrxdz44>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <vxqi23hxw7bmtfs5wk3u7szganpv5aa74b26xrvpmbehkltodw@dpum7zrxdz44>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/6/24 14:28, Krzysztof Kozlowski wrote:
> On Fri, Dec 06, 2024 at 12:39:56AM +0100, Daniel Lezcano wrote:
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +config EXYNOS_ACPM_PROTOCOL
>>> +	tristate "Exynos Alive Clock and Power Manager (ACPM) Message Protocol"
>>
>> Given the importance of this driver where a lot of PM services rely on, does
>> it really make sense to allow it as a module ?
>>
>> Some PM services may be needed very early in the boot process
>>
> 
> If it works as module e.g. on Android, it is beneficial. I think the
> platform was booting fine without it, at least to some shell, so I can
> imagine this can be loaded a bit later.

Usually the firmware sets the frequency to the maximum in order to boot 
the kernel as fast as possible. That may lead to thermal issues at boot 
time where the thermal framework won't be able to kick in as some 
components will depends on ACPM while the system stays at its highest 
performance state.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

