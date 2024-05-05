Return-Path: <linux-kernel+bounces-168890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCEC8BBF50
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBA1F2167A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A73D8E;
	Sun,  5 May 2024 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHEUNN93"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91F17FF;
	Sun,  5 May 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714886459; cv=none; b=jX6BYYE7EX2PRC3y/nP4c9bMUXUwfCfMgjyeiBdvG3s11Qq9Am+ufXpvAuN1zdwTK58XlOxHj2TWbbDFm6KsvQIzmvXlcgv0b18yXhXHojuwMESXv6xtr8a5dn82xMxQZsY6xkpAgfp309fwxajkg7p5v991yg65mrcOX+neMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714886459; c=relaxed/simple;
	bh=nC6Z/HJC20OmHLzryYOjpxrk/Qut/kde/pRKSle0cFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKN4PHKsVcFaR6tWG1fRJXylkxxSwVQCCa4nyfYGfKAqS4JuVyt+VaBPwAYADtcqXwQuc9YqNmD9x5tpq388PrxTgtN6Iqio8oDLak6nuU3STjcXWknB+GAHyiOtgn+Dzj4PJt69bwprjC3cd/Y1h7gBQB49I5LtM+uagcOs7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHEUNN93; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b338460546so688525a91.1;
        Sat, 04 May 2024 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714886457; x=1715491257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gMn+BR9RQx2vxREiKnQ7+NVvFwlE93xnFnB8nM0/NQ=;
        b=VHEUNN93ZetH5UWnHDKXFf/cHexjgb2dXKjdFXhZ2btt2nRnym8MYvXdzfGtBKD9CJ
         oyzk80mporGxocAbpDfSBS/cG10hDa/zb4SzT9hNgle4+6tbzqOJn9uFnhO6QEOrpy4J
         ojKpb3ChS+/sAQMCCu2ynB7v8bpcwgbAK0CK8T9UzP5EEeGYPJsAx3GpTXdWgrz5oFyL
         qTwm9qQif5ZPn8k313EO/RT8SE2AyaWrEsDIV5QBXROqFoKFMPe5JwNm9pToiNIprqZR
         R6+L6OO4y4Pt5AXjgckbQrAeHuP6rbpu/avou76L9qPYHOMGuQpPW5ZQ7K5vt0gsAX8C
         7ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714886457; x=1715491257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gMn+BR9RQx2vxREiKnQ7+NVvFwlE93xnFnB8nM0/NQ=;
        b=DbxA1k4qOGAS5llGxSdy4sTFRVr1Ei1fu9fikZJyZcdk017f+fpa+/eFJ22Klyrbp3
         tqH0qvKfmkei8F8NQ1h/0j/+oGWvIEHK9XDlpUbnjROcTGyQgoG0pIoFVX3Rvr9lq8vj
         +9wp/w65iswYlBlPGhVTwOE+4/6Pk12q/z0kxn+6KzkreFkgxhWTSsS6xo2nbhyTEqdd
         s5i5RdDBZ2/rmlbIiMGq/VKzogtg/COy++v0/FJtnjV4fBS0LG96CN0IYmSn1gWdPYLb
         mWk04XpK/1RyH4advVkXrrhdjBBx9VV+Qo26DVfwzs2qMN2KGD7va5SGOEyKv4cKxkSO
         o4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN4RE7h23Ep6jKRbLS52abYNPvL7Idqh6O7MKhuPqyOMWVmm7bjjts8FvRQM+b/jplU87ma4adRi1fPwBL8wFh4AHMoO0aSitlJ3ZA67yC7baQPXnJQuWXUZhy/Ft09ch49Bq+AM4S
X-Gm-Message-State: AOJu0YxYUWv0q+Rp5zqPAx8CqIU8fh6z4GXaIfGy1ZxUWMiBTABYoNhl
	P5wyBghEhreZMU7PRfBhXoKXsCMx4mhzozX28eyWd5UxP+XMCFDk
X-Google-Smtp-Source: AGHT+IHY3DF81k4z2ufQCLvcmibVb6Nyy3avI53nitB/6kPVYJ8UKnCNk/FQnAiI7Ugq7cAojanIGA==
X-Received: by 2002:a17:902:ef46:b0:1e4:9616:d967 with SMTP id e6-20020a170902ef4600b001e49616d967mr8733452plx.15.1714886457362;
        Sat, 04 May 2024 22:20:57 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:54ee:ba66:1638:6278? ([2402:e280:214c:86:54ee:ba66:1638:6278])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170903054300b001e904b1d164sm5884513plb.177.2024.05.04.22.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 22:20:57 -0700 (PDT)
Message-ID: <9574a4a1-a7b8-4f35-88b0-754c4396b02e@gmail.com>
Date: Sun, 5 May 2024 10:50:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: mux: replace of_node_put() with __free
 [linux-next]
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
 neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr,
 u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
References: <20240410175804.5195-1-prosunofficial@gmail.com>
 <2024050443-coerce-bonus-977a@gregkh>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <2024050443-coerce-bonus-977a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/05/24 21:48, Greg KH wrote:
> On Wed, Apr 10, 2024 at 11:28:04PM +0530, R SUNDAR wrote:
>> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> 
> Please fix your name up for the next version.

Hi,

This version of patch is sent  before comments provided for naming in 
patch v1.

The name and nitpick was fixed after suggestion provided in patch v1.

https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/


Link for patch after fixing name and nitpick:

https://lore.kernel.org/all/20240426164705.2717-1-prosunofficial@gmail.com/



Thanks,
Sundar

