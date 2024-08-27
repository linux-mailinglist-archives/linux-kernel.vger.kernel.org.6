Return-Path: <linux-kernel+bounces-302583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE5960088
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D53928336F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB54DA1F;
	Tue, 27 Aug 2024 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS+NETbn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DBDF59
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734409; cv=none; b=bQqk4sZhjaFnT9VTQewWp/sJJrkRobWbILLQ+V3XRANXKUi005zC59wbQAzGk9rqZ4cPglB9oEEgFtHJzbSXZnBideMB3cUReA8lEWLSBk+9EeRwsV5nQ5wzssEvadJXfAKoaW8QZhxIrL02MQIQUfWU2EINMmi3L2Idn7ywNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734409; c=relaxed/simple;
	bh=q/hQZP8UzpGL/LhuzuoMykaERVhMUp5s2HScjglDtU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IBeqt3mPIATjBW6paS9YzfPT5Ukbbtvlq6GrudY+HZFieUgtFVWdjUdQtSb25ukjDEKHFBJFRxKzaW3UO75wLUgyMWx2gofgzFE/5Z+8UaqAI/x2gbqfyLaGiz+qVvJ4tpjo9UKN8P7bEiClojMyRij9v24Hz3q/6xZwzmRtfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS+NETbn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86a0b5513aso409250566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734407; x=1725339207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GTp+zaC29qJ57UbVln4wBICMkhO3MDkLmyDFbXQyWmE=;
        b=eS+NETbnuRtaOWjax7HU/GVXTEkKxnITBlzi1iE4TNeUyJT7NTPqQarqiEvs23Bzlz
         BGUXtUjsybLFgT82ZMUiARMWk/4DPK8bQhlZA8Un0pouQJ6NVxESj30w2JnYNMSH3j++
         rJSnnecxxTS4dHt6s0bTcM51aALcvpZLDDzJ7ba9G4+6MX/RDEgq175exxyhhxyyJJHn
         Le/0UCD6o29BsqHmFfOwWJaS40lWLZ1r5A7Vd065oWZKIHf7I7i+OJxFgKhgw2zQjfXe
         JVa6xjo4HhxUx3pZWGh2DlixdEiDSgGCjVPsyNZKIj0aeI95yMMfCqKkXZZrk367zrO0
         yE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734407; x=1725339207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTp+zaC29qJ57UbVln4wBICMkhO3MDkLmyDFbXQyWmE=;
        b=Rm51vLYJx0cElUKVnGaTZsjeBa3qvXPClEG2fyt0Y0+12EfPYZ8Whap4e7sLSGaJId
         izWnhxJLF8Dk/ZouaOkH0yOa+ovqD+xOz7Av7+jzQl95xn1ixzzTaK+LwmcuGEj+/2nZ
         dKluMIN/VZahBHoqA+17GXbJWr5fTD7biQtjQzcytoqGTW0MQZ7txYMEHvEKcTZXZuZZ
         n35XAUUH8pCeFtxGgX06jBipz2hiTNHRyZDhfxN7rndKfyk4qOnaObx/C1Pj64BsGj4b
         Eb0z0cNLcBz+cVOlWxy6R6BQ7t00CjHYqjpNFOh4rbsmdm4DhesnjPK1MTWxWxaLaHup
         E7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWqpBrHC3Pqinw+5p0GIliYX8Hg/ESzE4JnyldF6XBOzQeAXqDAA2EW1F3MFKyT5IAyR/GSAkwltFCuxJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZvrcAChPJ7fkksp99/xTFp5s2HXVTfV4Qudi04t6uSD7WIUs
	sM39gc+VZCIV4Qo5FQnSKsRHtZlHS81M33fvppX9A7XxkpduBqla
X-Google-Smtp-Source: AGHT+IHkJ/mM6p0n3CXzIgSEp9TLTiC012zCp0zk9t0yY4TQHoZJH1K0IWibkZS+5i9MKoII5Qke+Q==
X-Received: by 2002:a17:906:f59e:b0:a7a:9144:e23b with SMTP id a640c23a62f3a-a86a52b6124mr723732366b.19.1724734406319;
        Mon, 26 Aug 2024 21:53:26 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d658sm59276266b.99.2024.08.26.21.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 21:53:25 -0700 (PDT)
Message-ID: <e94dc4ae-28c4-42d3-8df7-fb68e4829f8b@gmail.com>
Date: Tue, 27 Aug 2024 06:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] staging: rtl8192e: Fix multiple assignments in
 rtl_wx.c:529
To: Alien Wesley <alienwesley51@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240827001107.10641-1-alienwesley51@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240827001107.10641-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 02:11, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: multiple assignments should be avoided.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
> v4: Squash v1 and v3
> v3: Fix typo in commit message.
> v2: Removed two spaces in front of "=".
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index fc8e7f73b2a4..67c4793e0fc1 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>   	mutex_unlock(&priv->wx_mutex);
>   
>   	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
> -		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
> +		ieee->pairwise_key_type = KEY_TYPE_NA;
> +		ieee->group_key_type = KEY_TYPE_NA;
>   		rtl92e_cam_reset(dev);
>   		memset(priv->rtllib->swcamtable, 0,
>   		       sizeof(struct sw_cam_table) * 32);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

