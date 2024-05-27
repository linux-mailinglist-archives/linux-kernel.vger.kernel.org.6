Return-Path: <linux-kernel+bounces-191027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E564D8D0638
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B6FB31ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5C15F32E;
	Mon, 27 May 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UhRRbq14"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5350535A4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822083; cv=none; b=d2wSlw/F5HGS6RBZR5roGZPRSA6iK0w8Y1Dlj9Q+2h60f014gYSSrUcprRXL8Pn4LNDRRqUHkPbqkii0r5oYPAiavDem/IsgSQDOCQMvs192rzzN63K1VZlQMOH4DHbXSg0EEtSuyNsjj6z5boCM9xlGZos10VWC4kGGWLJfqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822083; c=relaxed/simple;
	bh=3ADeBLQNJV7D7FSC+IouMdBONs3glNiIL5WXghicbWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqswFusO/tVaIcGi9N2g5OcOr2e+NMIw0n+4raNnc2Ci6K0rmOBrmHcvnzKSGj3eovMTDng3BmmsU1R7dAPz8IPaXH1SCsE6sR3HPQ3EvpljfIxnjIQ042pxXJ+NAmPfVzD71VaE9cN/ott/7S/mMgh6Am/5UFo1kV0aKXI7u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UhRRbq14; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a626776cc50so385322766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716822078; x=1717426878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBaleJfDX7TKwBM116gPab+mpvnp6V9XCtVH05KL/8Q=;
        b=UhRRbq14l9bmqFBmcA/n/INUteZlStubdt5sqSxu/zA/YqHNj2gpBXgcB9mddmCb+8
         aaY5NswL73F1azIiSJ13bs3Su5tVqHYB1RzdmIwaDs9m2ekr+//BVHipPdQCLHKjedo3
         xXy0t8wVJwXVAT4Uszfv1HgOoc39Qw3s7Wh2O6XOOZ8nmedARBdBDAt02zwpE6nrTHSv
         hJGxP2ZoQfwzNMt8Q/AbG9eomqJrbcUqg3713C1o8Gx7fsoFr1aC4BcKJyV4yEzaujB9
         Qm4XgAH0hh1dSgzzQBmGdlOEUTcXBhhTLzbUN0DzAUBMUsPARI/Po8ogrLLOx8pfZj2A
         MPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716822078; x=1717426878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBaleJfDX7TKwBM116gPab+mpvnp6V9XCtVH05KL/8Q=;
        b=v3wWDKquMrR45ntSDZEvnCc9W9SHJDDVbALI0PqW0y+fv+SiVLS/0lsDI9py3nFamV
         YRSTJakd3QoxyaLTgqCLRA2vVcTFFomv4Pd2W+uYKYygSd1zn3I0/6lJ3LFjSJlL1hKf
         dUtLxZhbUql6UI1NYQ4hJIKQGy0fcqIO2/nPqBSheIVsvmegHk28IqXxRKpDDY93rxso
         TFx6y5AAXGFI4KdNf2zHkuWKIVG+L3qS5UX4cTQSmZGaqp4xivbYNJA6qgHmeEUioLdk
         3svUYmSJQ+7uaMtILZbILCJm80TK79PA7/NZUaAqCakMTnAJC9bzARREJtnZK2Iw/3RI
         WPBw==
X-Forwarded-Encrypted: i=1; AJvYcCXb/cIpEPrUcN7SE17gUz91yu1IuaH31pJ2us6x5vySo89W8tDzVRZHVXQ9NH+z2U8fsz5cuCsNGL4zDT4+wIJlpOEggCI2uwwbxq3J
X-Gm-Message-State: AOJu0YwIslKrotkjIOiUSavPKh7ORy/E3YnjVJQb98U+RngIwwmnfl6P
	EyJTh5bLgrhT0LryFO4FY77VjHdOO07VTuSnKV4uwn5bUJVRGjL/iJTvsvuqAgo=
X-Google-Smtp-Source: AGHT+IE0GsSsoOy5TV3e14pqUvRZT4HMEZud7lJYSXIDbKYwkcYaGSuuOBvas3WyiJLP79z3A85Nlw==
X-Received: by 2002:a17:906:c088:b0:a59:db0f:6bd7 with SMTP id a640c23a62f3a-a6265116365mr581125766b.71.1716822077855;
        Mon, 27 May 2024 08:01:17 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93b538sm500311166b.71.2024.05.27.08.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:01:17 -0700 (PDT)
Message-ID: <8176c55f-980c-4dcb-9e17-8c9c948ce216@suse.com>
Date: Mon, 27 May 2024 17:01:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] usb-storage: alauda: Check whether the media is
 initialized
To: Shichao Lai <shichaorai@gmail.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org, Markus.Elfring@web.de
Cc: oneukum@suse.com, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
 xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240526012745.2852061-1-shichaorai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.05.24 03:27, Shichao Lai wrote:

Hi,


> The member "uzonesize" of struct alauda_info will remain 0
> if alauda_init_media() fails, potentially causing divide errors
> in alauda_read_data() and alauda_write_lba().

This means that we can reach those functions.

> - Add a member "media_initialized" to struct alauda_info.
> - Change a condition in alauda_check_media() to ensure the
>    first initialization.
> - Add an error check for the return value of alauda_init_media().
> 
> Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
> Changes since v5:
> - Check the initialization of alauda_check_media()
>    which is the root cause.
> 
>   drivers/usb/storage/alauda.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..40d34cc28344 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -105,6 +105,8 @@ struct alauda_info {
>   	unsigned char sense_key;
>   	unsigned long sense_asc;	/* additional sense code */
>   	unsigned long sense_ascq;	/* additional sense code qualifier */
> +
> +	bool media_initialized;
>   };
>   
>   #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
> @@ -476,11 +478,12 @@ static int alauda_check_media(struct us_data *us)
>   	}
>   
>   	/* Check for media change */
> -	if (status[0] & 0x08) {
> +	if (status[0] & 0x08 || !info->media_initialized) {

If we take this branch due to !info->media_initialized and only due
to this condition, alauda_check_media() will return an error

(Quoting the current state):
         /* Check for media change */
         if (status[0] & 0x08) {
                 usb_stor_dbg(us, "Media change detected\n");
                 alauda_free_maps(&MEDIA_INFO(us));
                 alauda_init_media(us);

                 info->sense_key = UNIT_ATTENTION;
                 info->sense_asc = 0x28;
                 info->sense_ascq = 0x00;
                 return USB_STOR_TRANSPORT_FAILED;

>   		usb_stor_dbg(us, "Media change detected\n");
>   		alauda_free_maps(&MEDIA_INFO(us));
> -		alauda_init_media(us);
> -
> +		rc = alauda_init_media(us);
> +		if (rc == USB_STOR_TRANSPORT_GOOD)
> +			info->media_initialized = true;
>   		info->sense_key = UNIT_ATTENTION;
>   		info->sense_asc = 0x28;
>   		info->sense_ascq = 0x00;

It seems to that we need to evaluate the reasons for taking this branch
and the result of alauda_init_media() to compute the correct return
of this function.

	Regards
		Oliver

