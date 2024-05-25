Return-Path: <linux-kernel+bounces-189518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2148CF124
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E253E1C209CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD6127B6A;
	Sat, 25 May 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alcVc9AR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4F29CE5
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716666804; cv=none; b=P/QYtb4ZqAh0NihLW+DmyY5EYn05blN70hgsS0eD4/0dvWy5+V//ZvSIEShs/iTrcrDcJyrgqzhBw3hO/kIipoDrJkZeKYHHF6zfmsWNs88vWCzW6Lhk2t7NMraaKpuog5aIzaVPr1HcWzgeKw+hBPSOIDOCvlvVICAbTX1AQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716666804; c=relaxed/simple;
	bh=M/3s1GxCdbe10Q+Ris65wPXVXEe1DMs6c1mNw58Yb4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHrau3BQ7ROAroaEEeHFIjBaf+PRmesRSpb8sdlfz3tSwqRkPzBkEkVet/WPWu283thuyXRJrIjlrE8B3Y6TyUcSYuWDm/8GfsAECCqRkNN35W0HU5VyJ16vZ6hFwvQEP6j1BzyGDNF4fIAMFUCcnTO63wc+F2Tm1/D7FR3yPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alcVc9AR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35834c76cffso7641f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716666801; x=1717271601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPqPzXoshwO3X5GrkiASssYjgVLQm4/xRukqmuyA2Sg=;
        b=alcVc9ARYRLN/dZHezGHKFAF8ck/PwMxlKXMbOo6lmaiZ6tbgfk4qlVWVKRqiAdtE+
         ECxpCtydqQabaCZs8M32birfK/76Yn3b0o/2WSZRc4QhpFzXrCmk6GMoRda9FQUKebRg
         6lreLOQZEI+nswt9ttNOuP3IIuLr9AqZpcuaASX8vzwOq7RINaA+02AoHN56a3WA8bwv
         Ey/UD1fVBKpFDWOO91SRbWNyC/vM45/Jf3opEV65RU4K/+2YsnCpYKpoSK8/Fgo4pKZI
         E7zbSLrhHEesenvd713ZEJxJa47bAt1UWhkdvfSwA9mSPlMQ1QQ8KcQYZAprI/3S+txd
         TkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716666801; x=1717271601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPqPzXoshwO3X5GrkiASssYjgVLQm4/xRukqmuyA2Sg=;
        b=qLZoh/2pj98PXCgFSy2INadLD1wmmIhw2YAST5OzRFqcFekOKHmVGaREHdeNwEiq44
         OQmeWkfXsHL5fOYRvbhwpXaQAbm8fDeBRHSuIEnL0x2WmsUfF9xmHaTRuSDarcT5IC22
         LihW0Bv47GjEbYPn5Hi2keYuhVC3XcShsGtH45UMnDTIf5MeMsjlwogTVn7Dsogz3I6k
         /8ys8INz3atBUS9oocbc5C01fI2J/EWeCW3fTQlhy3Ly/da6pFwlB6OdRWRJwGesgi0V
         n44k5gHuHFNe63bCFbfU0P+LU0pMbGzxAOkKJskjSq2QFkBoz6b0PbHmTSqfJXidY0wi
         OkLg==
X-Forwarded-Encrypted: i=1; AJvYcCXHGIjAl3d2bP9XOdjS1sYhXTev22DEIYTXHHwH37mR5Pw+8HPJdOp/Ole1lWk4AZIeslLaYX0ORtvJiypJZjlrI3J0/RayRaGDJRi7
X-Gm-Message-State: AOJu0YxWzQ10Yc8ZN9+31JO2Iwl1F1EpiR1+S+odwA8MutBpJZC+MUju
	kWXRUz0FgUZsl5w75Cp4KvRJm8jcZqVCYx27g0qk1a1IjxEFAn1z
X-Google-Smtp-Source: AGHT+IFe6BKMaPWpLr6rOrgLIvvYyuPJtLKEx/wU3Add+KxVCLzTLbbpch0b4hOOGRd2/PyWAZJeBw==
X-Received: by 2002:a05:600c:3b88:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-421099b03e5mr40154515e9.2.1716666801145;
        Sat, 25 May 2024 12:53:21 -0700 (PDT)
Received: from [192.168.44.127] ([185.238.218.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee7e1fsm90288625e9.6.2024.05.25.12.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 12:53:20 -0700 (PDT)
Message-ID: <5f591c67-235c-4afa-bf87-8fd01dc0e5af@gmail.com>
Date: Sat, 25 May 2024 21:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8192e: Fix spelling mistakes in
 rtllib_softmac.c
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org,
 tdavies@darkphysics.net, garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240524041235.61184-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240524041235.61184-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 06:12, Roshan Khatri wrote:
> This patch corrects some misspellings to increase code readability and
> searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
> v3:
>   - Added the missing patch history on v2 patch
> v2:
>   - Updated the patch description as suggested by Phillips
>   - https://lore.kernel.org/all/1aefa708-b1fe-4246-bb67-36f25919c766@gmail.com/
> v1: https://lore.kernel.org/all/20240523035952.59724-1-topofeverest8848@gmail.com/
> 
>   drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
> index 97fdca828da7..0fc97c868f81 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac.c
> @@ -421,7 +421,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
>   		 *    So we switch to MAC80211_LINKED_SCANNING to remember
>   		 *    that we are still logically linked (not interested in
>   		 *    new network events, despite for updating the net list,
> -		 *    but we are temporarly 'unlinked' as the driver shall
> +		 *    but we are temporarily 'unlinked' as the driver shall
>   		 *    not filter RX frames and the channel is changing.
>   		 * So the only situation in which are interested is to check
>   		 * if the state become LINKED because of the #1 situation
> @@ -934,7 +934,7 @@ static void rtllib_associate_abort(struct rtllib_device *ieee)
>   
>   	ieee->associate_seq++;
>   
> -	/* don't scan, and avoid to have the RX path possibily
> +	/* don't scan, and avoid to have the RX path possibly
>   	 * try again to associate. Even do not react to AUTH or
>   	 * ASSOC response. Just wait for the retry wq to be scheduled.
>   	 * Here we will check if there are good nets to associate
> @@ -1359,7 +1359,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
>   		return 0;
>   	timeout = ieee->current_network.beacon_interval;
>   	ieee->current_network.dtim_data = RTLLIB_DTIM_INVALID;
> -	/* there's no need to nofity AP that I find you buffered
> +	/* there's no need to notify AP that I find you buffered
>   	 * with broadcast packet
>   	 */
>   	if (dtim & (RTLLIB_DTIM_UCAST & ieee->ps))
> @@ -1806,7 +1806,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
>   
>   	spin_lock_irqsave(&ieee->lock, flags);
>   
> -	/* called with 2nd parm 0, no tx mgmt lock required */
> +	/* called with 2nd param 0, no tx mgmt lock required */
>   	rtllib_sta_wakeup(ieee, 0);
>   
>   	/* update the tx status */

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

