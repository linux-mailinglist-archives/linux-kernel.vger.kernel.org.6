Return-Path: <linux-kernel+bounces-522499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D3A3CB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D1E16AE20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49FD253339;
	Wed, 19 Feb 2025 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+fORw/e"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F61C1F21
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999503; cv=none; b=UCTkQ+ktjpdoVwSzPRxk28few3peq8Afr/LqnOTNL354AHsXAG8tI1ybT9diC5AJR3FbxUYfqNOTxBidUQ7x+WIBBbvDFmZMJj+nLOIw7nGfbAMjHuxJoiehUKHAPVP2AHK3ifvqipEgpxQjdC9nTQc4dl/yKJId4wk826bGYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999503; c=relaxed/simple;
	bh=PGa2rQkVCqGcvdXSluNZLLuuyUMqnsgHGaONK+L9V6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rthX/XNrOpOfuZLvVjuTAkry+c6o2NTzxN3bOmiiSk3cBWHdY1d8uk1I+w45uDIjZqjeAm0+5WCLWjTfcheVRiHIXCRxDL1gRx10yuNtXuDjfmQbwnFsJDrbG7fUXZnHWQBZDxS//Guo27DsP1EiDXMk1G7HdSbWjA7Vz7tJlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+fORw/e; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d193fc345aso703965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739999499; x=1740604299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7tT1yGSGZCPiLi9cXfTaPfy6ZirM2yQLUSmm+s4CHQ=;
        b=O+fORw/eYI6jQ0Gyl1bCr7f5dwvESaJ0z9fYsJRInKyAnlIpfieJQjhlpScW53v9t4
         az6i5akq1zr2KiPXCXA6Z7CNiuRoyBbPo87utrbAzlV0GGoMgmZdFeuokviRD5FSNXMm
         96T/zbJkOC6m63nFcCz5l8DmK5bQpOI2ZcInk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739999499; x=1740604299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7tT1yGSGZCPiLi9cXfTaPfy6ZirM2yQLUSmm+s4CHQ=;
        b=r8zXmxtPmuZesfSKObT3dUYJiRXIe/QaQIkINSB0lvogjXrO+AS2bQecGXmzxAnM+7
         6njsTezCc8vkG/0yoeEq5V5LJnSIh0zuI37oweAR75wpxqO2BrSIj1nq4b+G6rMAMKZx
         MdwG8ppdyXM+iBhyOzEYMvYndfg8mJ6HPObu9rEt/d4EjpnDWdNlkkHbonmbCltZ01Kw
         VXwMYa5r9EjbzkIHplNSzezX3/9LkIySucNKt4yhsJ+SYQeM4AhjGnrvYqauQzEw2Xtg
         iwo51QsoOlqtdrYatoMrYMAYLjs2YREOLGWiOkZZCy4DtEatJNHECX7eNGX1L2C9i+cu
         2pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWf6W6dQkWTaf+ztBpLNs7aQjFPL5DZTfX3D2vzmrj70A25WnZO8AMHZ1N3nR8XjOt+zZkB4is2IYBeO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMMwhCoS+ixLBg9Sdbc48iiFn8jj24rqpXHGEsp7Lzm9rJ7sk
	9WToP/OhcJ6mIDi4DpasD2vicBLCXo3IRqX1uXp4LLATE2mJqutFcHhCr3/5ChY=
X-Gm-Gg: ASbGncutTZcuyxyo8cPBrDHKrXvOjRry9nodrKlG8zXxAtjtxRjmR1qfb00q4auWN7v
	AYPl3WWCkJBtVpH7VimsRAdcIDeqOTpAKXiJ1SPoYNGgpQ94CL/K5VFpTwEoSKcPMKP0AJKDpHz
	AT9ZhTeRXT1z9fQxC0+faVJSkPZkRN4WG29fWCk0M4jq8G2r89cKFOUIi82dg0hM8eGpgCIf3KN
	oKT3hXz1D7eftupKjSYa02Q9KAbD/nHipnoLryev6z6UuqEbspB1rZHou7WGES+aKKxxu4aAnSt
	q7QKke1CbZdsReCp1FWfOVOZuA==
X-Google-Smtp-Source: AGHT+IHbiMmd6pm4ztK7iXzR9xSSArO8wZLiPdQ+1D9ZO47Ndh+1S88a89JINVkpcr76FT7K9xHfWg==
X-Received: by 2002:a05:6e02:12e5:b0:3d1:97dc:2f93 with SMTP id e9e14a558f8ab-3d2b538ad3cmr49413385ab.20.1739999499041;
        Wed, 19 Feb 2025 13:11:39 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eeaa4f5958sm1178326173.32.2025.02.19.13.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 13:11:38 -0800 (PST)
Message-ID: <bed99965-09ad-4468-a5dd-f9615ffaf54e@linuxfoundation.org>
Date: Wed, 19 Feb 2025 14:11:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vim2m: print device name after registering device
To: Matthew Majewski <mattwmajewski@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219190501.295976-1-mattwmajewski@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219190501.295976-1-mattwmajewski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 12:05, Matthew Majewski wrote:
> Move the v4l2_info() call displaying the video device name after the
> device is actually registered.
> 
> This fixes a bug where the driver was always displaying "/dev/video0"
> since it was reading from the vfd before it was registered.
> 
> Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
> ---

Thanks. Applied for 6.15-rc1 to be included in pull request to media
maintainer.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=vimc

thanks,
-- Shuah

