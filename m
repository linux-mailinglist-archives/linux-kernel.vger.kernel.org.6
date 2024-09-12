Return-Path: <linux-kernel+bounces-327138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C197712D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D658A1C20F08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695961C3F3B;
	Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpmHzHuB"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43271C1724
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168169; cv=none; b=LEeyhtWh5E7c6dMuOKzKH5nvS+bOr3vPsr9sLe6nWbimS8daBJzAxpJ84hawoljq+ozy35+669BZoF0O13daRtTjdl8lHwh8KanHS6S4GsEYJB2WewGxHu/upLMuslGzzXGsQ5YokuSfbqvAbSnCv9/8AYhCiIHeHtLJfg1F0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168169; c=relaxed/simple;
	bh=RIZ6UHMWXZJemRm/+dKzRuGaErQaocw672nPCSORCRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TiqmbtZ6BUAVGKWJfS3Fbez1Y0nS30hw3PAMBcNeptR25Hy2Cm5f/tH289Do+21xSUJMDVkd4KTKTqsQ+6BH1JcLDKFV8nD/849uuQPTJj8MChQGmHb7rzhOlW7cSbHStqCHShEPcFBvGf593kGQUlBHywa1ZN1csZChgsJ6HXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpmHzHuB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f74e468baeso2515491fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726168165; x=1726772965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gA1EZdK+FIlhj8yx6CB1xUSnqvOWPyr9g86P+6dBE6o=;
        b=YpmHzHuBxYDS8U8/z785dCWCryObNGel69/RIzOKqyDZHRm5oPOVUb5tsWqj9dq6Ta
         Hm9laAjnruHppS2k8IWSW7B3QXruDgnX+mDk+ORQhHpaXVg0+ndsUVhm0XIkeHUFXOow
         wzPwOwUC+MNpDlcatS9hmWo1BmpNYXzE+bkOD7GbXMMkSPiL1+fpF3FZK4QDvYSIJ1rn
         ZCm1Uyxzg/oHcVOZ3MHETPfOZIp0L1tYVsWJRLiXravjjBLlwYdi8OlnfVP1xGVS/iCM
         dJ1OcvN8yi4NgqEe6Fb1gBxkQg2XITXsz3K+UKVUdLvwylTvBmfiocywCyOj4SW3kFHq
         vgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168165; x=1726772965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gA1EZdK+FIlhj8yx6CB1xUSnqvOWPyr9g86P+6dBE6o=;
        b=hF9BjVnhvkIcIJyaelAElXIHkzIE4EU96ACVDSbwRKb2OY9o0VGOpPzb6TvvtQUw8P
         k23IMf1mGOwEui1t0Dkrj+CaODmvDz9HTAhSCaR5S8lT9slkr9lnw/lfih29AHmSQbjL
         jASzP/Bf0/rgJMLEE3Y2Pzpedq0IRQ2rGn3EevUkxoSZBumq2FpCeD7KEJp5BdAfNQMY
         C0bwxDh0X73YXZ2moRqPW6Dxrg54isovys+QRn8Hoplo+vI28xCmeZox367Jy4R21SRv
         OoSoIOI0m95xZpBdu+9jwk+Ta3B8MJX0BkNcxpW9sbLBj9brb5RLYERH1DvL+PontHn8
         LKMA==
X-Forwarded-Encrypted: i=1; AJvYcCVMzUCM7MGFZxV3c4MBN1Pw20xjkqV+Np7nqlW4v4m73mVNeUN8qtWsaadtlkuIue5AAxkRI26paOc72Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuLvlSLWAYxHV+twaIRJohT3l3fdWm7/8YaC2NGp8fSK/LMxy
	fD3VPMzW6tvQKcMHopcDhQrhStVXquJLIrGmhWTxAwPWrdfql+tK
X-Google-Smtp-Source: AGHT+IHLbqMRSyfw7vNBoZ2CJ+MAXkLxljrCR57eGq3uZHtcHPjP2eILjkvD9eIW2nNJ7KE8spebDw==
X-Received: by 2002:a2e:e09:0:b0:2f6:4f17:aead with SMTP id 38308e7fff4ca-2f791a02290mr1702631fa.21.1726168164175;
        Thu, 12 Sep 2024 12:09:24 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8557:476b:8cfa:99ee:514e? (p200300c78f2a8557476b8cfa99ee514e.dip0.t-ipconnect.de. [2003:c7:8f2a:8557:476b:8cfa:99ee:514e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76edasm6859788a12.77.2024.09.12.12.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 12:09:23 -0700 (PDT)
Message-ID: <65c67cb1-59d5-45dd-9e05-6b82a0f0181f@gmail.com>
Date: Thu, 12 Sep 2024 21:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] staging: vt6655: Rename variable apTD0Rings
To: Xingquan Liu <b1n@b1n.io>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240912162609.21517-1-b1n@b1n.io>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240912162609.21517-1-b1n@b1n.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 18:26, Xingquan Liu wrote:
> Rename variable apTD0Rings to ap_td0_rings
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Xingquan Liu<b1n@b1n.io>
> ---
>   drivers/staging/vt6655/card.c        |  6 +++---
>   drivers/staging/vt6655/device.h      |  2 +-
>   drivers/staging/vt6655/device_main.c | 14 +++++++-------
>   3 files changed, 11 insertions(+), 11 deletions(-)

Hi Xingquan,

Please use a change history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
So your next patch is v3.

Please do not break lines of the description to early. Up to 75 
characters can be used.

Thanks for your support.

Bye Philipp

