Return-Path: <linux-kernel+bounces-383795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB659B2049
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D83328119A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFC1822E5;
	Sun, 27 Oct 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apevzner.com header.i=@apevzner.com header.b="C6v1KJ9m"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E81BF37
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060438; cv=none; b=oyugHxEtQpreCB08gfB4ONCwp5cT8Qsh9pEPdyjavFZR3G6jCEe6hZXE8pFtyw5yv1+VO1E9qljYk3fZUq1hZWJyDX2HR0fDarmk5bvcjFO4/GUmaMSUFM3/uA5UuSBOQ607KoLKpH8S60+PBg8bZaZ08Q/IaKIgDdNUN3Sx+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060438; c=relaxed/simple;
	bh=NDjKwj6KYq8eyzvWnAuMCVUjblMxJAeNZC5/nLC9ZUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0KhCvIffgOY7dAhWbOE61I2RxOSdJS1UcpXJFHBp/SO0rofjPTrIRAKezfIPeKq4kIVG73G01BG09RsI3MybymkM6wptMD5lFhBwTfmA5AiPyV0h9/zbPlFVphQa9Vi/l+UdzkNI8gt1Na1dYGm3lN9zetpJIxtgK8vC77yTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apevzner.com; spf=pass smtp.mailfrom=apevzner.com; dkim=pass (2048-bit key) header.d=apevzner.com header.i=@apevzner.com header.b=C6v1KJ9m; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apevzner.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apevzner.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c913aso4538980e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apevzner.com; s=google; t=1730060433; x=1730665233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA/SMxSLqXVatL6zizWumFPrrDcbY7I4o2XKLGYPLFM=;
        b=C6v1KJ9mRfmPcfaBMWcZ8E6roNJAJX9zWstTC9Zlyxqi8k+p6W8s/W22qpyzQ7i7Ef
         BY9fqr08zX/a7pTcUPbay5d5g07jcKhaTC2iQG7UJkVB1Pi5PVeheZZTqc7XG47EJERY
         RN04TsncTXHMA/z2aAfrohhNpxr+s/FTWgpR7dva2zGampu9C4eQWBUURAqSsOQ2ndNl
         IbOSeUUdYdtE0SweGlxoNpEft0Qa8N/Z45mfh3VyGfrukFcyqowomygd8oQfApgDXn69
         6IF8IhQKjirDyMILUg2FEyKi2+S9f9LbR00J2Ky5wUrdqDJVjdHnRvLaPBz8+hqEhljc
         IiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730060433; x=1730665233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA/SMxSLqXVatL6zizWumFPrrDcbY7I4o2XKLGYPLFM=;
        b=e+N+ztSrFLdqBpfqHxVRec0lGAmpbvJXiIU0pyGzS2yitvcHd4Cj8KJt/wbchO33O8
         n5U+tVVSX1LQo8ZxpfiqZMZ8GblbGHD3sX6q2Kvw2vQV0Z9Pm4zAyqydwrRG6Y8DovYc
         AJGu0KFIFJ1jIUhkfoPzzdtfYR4elIA+OwC47nSIoFR8RYx7aNTUXWO00aF++/AlVkyr
         8OjMUdikaqGHxDI9Uvbn287IuXKDtXE5kWYCYYfy8umlmelPfzpfLMU/1CAaFkpwHUKQ
         i/f1NaGh1E0sd2dYw+u8+yJ7X0DziuO5o4+TGEM3W764iNwj2in3CecLIjGSnQdLL1KW
         7vCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxWhohG1eQ89Bhlk5YFaSouxIvuVfJ+O2CwqIQ0ubUKpXITaJJLgtyLCS+4RuC3dyfcYiJBaDyMoyJNPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2q1ICDs6EnJJ/S0yMY074zyoGnaVmuEryyOdfkBtfoaga+HY
	sTxziFdTEkKsjfohQc5M08VdrSKl81NpIc6Be8+VDjdayp8jSHicoYRtEKYxVsCDPfNNgfbxc1/
	D
X-Google-Smtp-Source: AGHT+IErIhzF7Pbcl1dtNSnwSsVR0KjX1OS+Oz3o2xs9b3TCYCjYRRu96N0ZL8qgAQFuLXA9VCLPvw==
X-Received: by 2002:a05:6512:2347:b0:530:c212:4a5a with SMTP id 2adb3069b0e04-53b348d3775mr2266413e87.22.1730060432434;
        Sun, 27 Oct 2024 13:20:32 -0700 (PDT)
Received: from [192.168.0.6] (ppp85-141-194-121.pppoe.mtu-net.ru. [85.141.194.121])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-53b2e1cbe9dsm873320e87.225.2024.10.27.13.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 13:20:31 -0700 (PDT)
Message-ID: <9aa26719-0614-4b83-b638-ac48b69be4e5@apevzner.com>
Date: Sun, 27 Oct 2024 23:20:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
To: patches@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2024101835-tiptop-blip-09ed@gregkh>
Content-Language: en-US
From: Alexander Pevzner <pzz@apevzner.com>
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody,

My name is Alexander Pevzner, and I live in Russia, Moscow.

I'm probably one of these "Russian trolls", mentioned by Linus in his 
message a couple of days ago.

Regardless of that, I use Linux as my primary OS since 1.2.13 kernel (so 
about 30 years for now) and I've contributed few lines of code (or, most 
likely, few thousand of lines of code) to make driverless printing and 
scanning work on Linux, so if you use one of those modern multifuction 
printers, this is very likely that among other stuff you use one of 
couple of my projects already on our personal computer.

As for me, the free software movement is the important thing. Really 
important. It makes people to cooperate. Not only individuals, but 
people from competing corporations. The free software movement sometimes 
"glues" people stronger, that money interest, which often works to 
separate people.

The whole history of the humanity can be seen as a history of ugly wars 
(the war is always ugly regardless of its reasons, because it always 
kills the human in a person).

 From another side, the whole history of the humanity can be seem as a 
history of cooperation. It was cooperation that allowed us to get out of 
the caves into outer space, to create computers and to write operating 
systems and other software for them.

Any war will some day end and any government will some day become part 
of the history, but the story of human cooperation has a chance to 
outlive the history.

In that sense, free software works in direction just opposite to the 
war. It lets people to cooperate, to see humans in another person's eyes 
(and code). Even when we are separated by the war.

And it puts a lot of responsibility to the free software leaders, 
because they not only manage lines of code, but somehow define edges of 
the future of the entire humanity. At least, in some aspects.

As a professional, I'm trying to cleanly separate software development 
from any kind of politics (probably, the same we all expect from the 
medical doctors). When I receive PR for review or a bug report, I look 
only to proposed code changes or bug description, regardless on who send 
me it.

The Linux Foundation is the community of software professionals. I 
understand that this is US organization and it is sometimes obliged by 
the US laws and regulation.

What would I expect from the professional organization in a case like 
this. The following:
1. The clear public note, that according to some US regulation the 
people from the sanctioned organizations cannot longer act as kernel 
maintainers
2. The personal communication with each of them, with explanation what 
is going on and verification that these persons are under sanctions
3. The clear public note, now with the list of affected persons, 
explaining that they will be removed from the maintainers list and with 
the great thanks for the work that they have done before.
4. Inclusion of these peoples into the kernel's hall of fame (the 
CREDITS list)

Nothing of this has be done, unfortunately. This is very, very pity :(

--
With the best regards, Alexander Pevzner (pzz@apevzner.com)

