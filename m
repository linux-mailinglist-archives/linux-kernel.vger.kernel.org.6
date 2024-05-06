Return-Path: <linux-kernel+bounces-170124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB68BD224
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424941C21A40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380C155A5B;
	Mon,  6 May 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSktj6lM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22561DFE1;
	Mon,  6 May 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011789; cv=none; b=F//bzBvvb3hQ90482F/rX+uWmQ8z7rnAmTAOh9IdHksHv+TU8kfmJxXU75M/WAtYDP0bV5nwjeBPT38cTJ2FENo0l5Jnv/Bo/XuyKL5oW7xS5gq5GfBhH1+ghL/+FacfrN8rqMYYtknlnnEmEoj7AWXW4dw4XIwYRQLiJGrIQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011789; c=relaxed/simple;
	bh=SrNbSPw8B1dvhrQcKhEXT3H4a1Sk9DiPXwP39x2ECm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egNqjvF++RYRAMIBrf84q4gKQxTa6PE1Dd3UXmM9tPOOTATSWV87mB5xyWMl7252oAGHQhhw2G6hOtCUkqLH7rI1s0iRXIM2DwxH5MuJlZ4BFxaQuQItH9AwIt9wc1ywhCvA4Die2mQKjNnasun3O6m/Z4LH9ecXPYQNWnUG1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSktj6lM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed835f3c3cso20161165ad.3;
        Mon, 06 May 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715011787; x=1715616587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDDuU5aSJYHA153x5Q41/Tx22bOo+9Q69kwxa75Ur9M=;
        b=PSktj6lMmGy6NeRkw2IWADqiGcrhqrJ0WdBWz9N43QljsFIQX+0AJaFtOP1VoFjeIj
         UHrCBlVzfGWB36snAzFx0lzt4ptTRc6CW7ArnYak/rMiLi6+qv8PbyF7NQgtgngLJc6t
         Dr7rjET+kmp1fITSjAcxK8xFv5wYVhD4X0roLHuEv7kN+w0gkAxVpEC5gmZws73HGjub
         jERvbQjnjFeZluIJ2zUGjCgCib11rJxoabxJNumFYsHly49qzVIRBNxWI7VCiVE27UXY
         1PzGv2pDRo6r0gou0fOuR/e9q/OLe4qEXTMeINSmNVPicPlxtwNhJTYypqSX/wDcr1mK
         wnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011787; x=1715616587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDDuU5aSJYHA153x5Q41/Tx22bOo+9Q69kwxa75Ur9M=;
        b=lSj/gPvywN5+AxN6bD6dhLQJHgaWgAGvonl22X9quyNTS5qFSGXCrDxLon75Jh8IT6
         /Lh4vZD/TCEYZ+GOT5Om8g7O9q6KJq35SkpLAyxzSxFugEVAToAXCZsDTZKIXavfWh6G
         I4Jf0UrNF213rAbeJSQ1g6SxlCd4hHMLfX+u3nXIJYjapWL6CEH0UMyyLJmqJoCIJ2yV
         chl8K+4ufg4nuOUm6etq9QUFur0jibf4GF+qdoE3cJQHpfb41gEexeCkh5DGxVA/tCJr
         jSQ00mxmpPbZMH7/6qoubuB8kwmJpTFBnnOCKz/AdTqsnXjeLxzGckau8u/ldZXkJhf5
         HMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXayuvgkdJOkN9LNoNx4W2cSzkvqTnlhakbHe2rg9S9Y1ZAUGK1v1vuVn8gGWgxH8SPBJphfnwlzC/3Hc6i2V77cWK780gXAq+awtfSQBx33321PJ3MOgjOzwqhu10CDVsVVPgfj/2H
X-Gm-Message-State: AOJu0YwhMREk0oax27NL5vl+yOFsr5cMjG04mm3mRurkZ5UpXGcz7kXT
	jQGxnAvMYfBDV9SxUVbc2oiWZFcezrbO8Zl61NCqQZoOT5cfhxtT
X-Google-Smtp-Source: AGHT+IGKtWPyB+i22ehtSBs3lc2oT2cGevZvqtKLFM7UTIRD8Gl2cPCvcxtB0LKkjgDA6VNzpSErMA==
X-Received: by 2002:a17:902:e54d:b0:1e6:7731:80 with SMTP id n13-20020a170902e54d00b001e677310080mr15396695plf.11.1715011786871;
        Mon, 06 May 2024 09:09:46 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:88b5:d592:a102:f8f1? ([2402:e280:214c:86:88b5:d592:a102:f8f1])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170902fa8700b001e3e081dea1sm8447603plb.0.2024.05.06.09.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 09:09:46 -0700 (PDT)
Message-ID: <da7a6e8c-fdda-42d3-ad42-c34e585d0ef8@gmail.com>
Date: Mon, 6 May 2024 21:39:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 linux-next] usb:typec:mux: remove indentation for
 common path
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240426164705.2717-1-prosunofficial@gmail.com>
 <Zjib5xNdpeNVfgtV@kuha.fi.intel.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <Zjib5xNdpeNVfgtV@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 06/05/24 14:29, Heikki Krogerus wrote:
> Hi Sundar,
> 
> On Fri, Apr 26, 2024 at 10:17:05PM +0530, R Sundar wrote:
>> Nitpick, Mostly common path will not be indented.  so rewritten this
>> function to check device_node pointer is null and removed common path
>> indentation.
>>
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> 
> For the record, I'm still uncomfortable with the name - why not just
> spell out your whole name?
> 

I understand your concern.  " R Sundar ",  is my whole name.

>> ---
>>
>> Fixed nitpicks in code according to comments received on other patch as
>> below:
>>
> 
> Sorry for missing this earlier, but it looks like this patch only
> modifies the nb7vpq904m driver, so I think you should specify that
> already in the subject.
> While at it, you could also specify the only function that is being
> modified in the commit message (this is just a suggestion):
> 
>          usb: typec: nb7vpq904m: Remove uneeded indentation
> 
>          In function nb7vpq904m_parse_data_lanes_mapping(), the "if
>          (ep)" condition is basically the entire function. Making the
>          code a bit more readable by inverting the condition so that
>          the function returns immedately if there is no "ep".
> 
> thanks,
> 

Thanks for the suggestion provided,  will modify the commit message and 
send the updated one.


Thanks,
Sundar


