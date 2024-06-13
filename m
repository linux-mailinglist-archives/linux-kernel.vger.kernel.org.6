Return-Path: <linux-kernel+bounces-213794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A0907AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8868D1C21C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EC14A62B;
	Thu, 13 Jun 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD//rAHn"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A314A617
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302344; cv=none; b=TUTmjdjqs1LurLbSLpRdVeAhwhKVGAy+op3xrvPnowJahr+005iuzZ+TNV0oLDKBNOmEdQGaIqFmfgHCqJwMYygm/pG3+uJvf7Em5kk3IeM6Py2Vcw7DjVz+EHQz77RnHyUp5J9bgjxExrHXsdbnntjtGHP/uwH4vV9DrhCFYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302344; c=relaxed/simple;
	bh=09bkj0aYiRhYPThOrEXj9DZrwqjxIISXp/K4ALT9sCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MinWai1kHgoHcq20tNpmYiCO0rGZ/1LjbpkpNW9pmYjLxcWG8710FrtZdgRuiXew9S61py4eXx6aK8dNZl1AjZKresCYx2ZgaNiJOv7sIVVPgks8xf7lqT+TM6Gn+WGqn1lQRxW6LunD/0/aVZeOjLEQVnDGjJ9Jep7W65vTsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD//rAHn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f4a474636so13309866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718302341; x=1718907141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QEkxYFxJcB/Qc3+AFrMvOaUS2Xwfl9Pd1HSoosJHfmM=;
        b=mD//rAHnwpChLykcumK2/fOTmUbDhoHEhLBvKcPVqcZlnLXmM+O5AbaLwk+xX56XjK
         NWi2SS15hOq5l2drwQceOXocjqOnpRBf0Ea8Tthrga8L6sCshHnLDls6K6hDKfD+/zxb
         Xpt4lLCdRpExWMuiz3Qs5LrYvcoFkrbRYBSZlUjvUcUEjTjq8jt6R0EEh5OQjbnhwQWm
         sAsgReJ1onEQBfP8TZ6ayEjjcqPAdJHprHC6esifoBMa+YHvgfnf96QqsaPchqJqG/Cm
         W+5q7m+H0weGkVbSUz5xiZ1UJYA0Nyl+mJiP0TJXC0XXYJAwqhbi3AG1R2atj56ZEC5/
         faiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302341; x=1718907141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEkxYFxJcB/Qc3+AFrMvOaUS2Xwfl9Pd1HSoosJHfmM=;
        b=KmHqVTTO6z4TH7eha3Xw712hymYRwhzH2gbT8I9uk0txK6Hn3lKyBPcb6IhRykQp4p
         0BCnc7kNoqvt+Ts6wruerS22+Ikoh+EmVLUjD8ufgPtdpYseMpns6znMJ7YOdWOdQVi+
         uXMEB7QZPmeHyR3zjoxqL++T2sTrYMmEwj449Pq+/LI3uv7EBNzuUBEV00Yu4SIgVYoH
         NDEO+xYeLpt1dwZKs3d4fmPa0D9K175HRWk9qYYW78Q6AXC9ifTR82PUBTCTUXr/JDud
         YcPQ09AdxiJPp6ty7xPmu1zDjQbWfnEomG+FwtkBlkguJbLAd8Cj5fe564/+4I35SMFu
         5Niw==
X-Forwarded-Encrypted: i=1; AJvYcCWxHre7NT4HbqMc9sxfgzjd5iz+yH36beJR3YJHY0PJeffFlppD9nIDiAyhb/77H2dgpnuVuAwpcbSz/j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JQ2cvUa6ytF/Mm8rVv3USvAYEgfXHTu5pX2OE+Sm2tNxliIY
	XuxmMSu8NtlOsMbxJM/6jFpNlH/wNTp19p7D3WRLQa/4375sa4Gr
X-Google-Smtp-Source: AGHT+IHLdAy6PcmCufcU/Hj/bfUFKCJ6XRnfpYJV7AdmG6mHhlAQE2I9MyPtMQFbh9R27xr8Wkhdzw==
X-Received: by 2002:a17:906:48d:b0:a6f:f1f:1d5 with SMTP id a640c23a62f3a-a6f60de5efamr34230266b.6.1718302341020;
        Thu, 13 Jun 2024 11:12:21 -0700 (PDT)
Received: from [192.168.0.103] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9978esm94520866b.200.2024.06.13.11.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:12:20 -0700 (PDT)
Message-ID: <100e5c87-d06b-4d17-b036-2e48fb234a08@gmail.com>
Date: Thu, 13 Jun 2024 20:12:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: vt6656: Remove line from TODO
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240613132853.2249-1-engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240613132853.2249-1-engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 15:28, Teddy Engel wrote:
> Remove checkpatch.pl line from TODO as no valid checkpatch recommendations
> still present.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> ---
> v3: Bump version number + add version history changes.
> v2: Revert the parentheses removal changes.
> ---
>   drivers/staging/vt6656/TODO | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
> index e154b2f3b247..876cdccb6948 100644
> --- a/drivers/staging/vt6656/TODO
> +++ b/drivers/staging/vt6656/TODO
> @@ -11,7 +11,6 @@ TODO:
>   - switch to use LIB80211
>   - switch to use MAC80211
>   - use kernel coding style
> -- checkpatch.pl fixes
>   - sparse fixes
>   - integrate with drivers/net/wireless
>   

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

