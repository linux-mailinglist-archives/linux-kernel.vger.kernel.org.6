Return-Path: <linux-kernel+bounces-218352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3BF90BD14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FEFB21511
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D7198A2F;
	Mon, 17 Jun 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leoAZ6vs"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBE19047C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661314; cv=none; b=ltDCcFelsYu+7TOG/Y5qjtQTDR/v/sm6thP7uU4Sqqh/5561I0rHdl9QiCZNOikNay7y31v0hBh7K38N4UQczXGGGFOT6HtUB9l92CwS4ENPoUK7VVF0nJQOJkFgsEvqJWjcuaWW041qSDVZHd3xKm+oihgeVnv9KcE8b6PEYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661314; c=relaxed/simple;
	bh=Py+KNRJaW+/lSx9cY+2oWKzQohB7EGvojPl8oVn/uMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6yHZxDviTphI2f4TxvJYXh3s1wFpmA/UqW1eqSaZBlVj6hiRklSY3nZfgEDpd7EE4D7cFrt2Fi0XiRDXJf5wF4NN1LbnTil5SNSSS1x8roKTAt/F1ofJd2SNwD77ietTfsRgf0MPfSUBuK3qY3/OSBPLGpeAjKrDPwCzt46pSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leoAZ6vs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so3724210a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661312; x=1719266112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk8nvrIUZdssQGlugDSJF3BINNXuqWBGddaelb8JFaQ=;
        b=leoAZ6vsCkQUuNfz3F+Itobz1R+Tflx7qjpnLPgGmLrbV32rYAnB50hstSb/q7PBl7
         UBFCqGamArmYbHwZ86V2f0JIVMzTTNvITH5smjUe4phKngIoubjLDtphhn0AsOuPnpFN
         f50UDROoKoejYSVJ1DnBjNRQDoq65z1Z2dKRxws3VZnQxCDgwWqlMZAQmp3iV4jfI9wB
         yd6hFZTCUr0KEMtUMcL+aoY114uxGJ9gtbva0hsFY92DShKLBxD1CqlX04zODewHGq1z
         QbYsMVfPPi9GLan1YG5Eg7pyWzRZR9QPYwWeehg1S8QAjPnYjQWU+OaH4LRwyQ3MyU3r
         trVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661312; x=1719266112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk8nvrIUZdssQGlugDSJF3BINNXuqWBGddaelb8JFaQ=;
        b=kENrSFv5MJJFal8ZY5ElvNVRsCBuRGUpAfiRsxtclcEcfUYa0tMgLooe6hdQ0Utn7p
         MKR1asQofw72n7qu9dnUJdlHJ8kP+XCFIfIq0UElPfuIDOfT2WsiSGFYmOKN/vJl8SCY
         FrYgLWJ0R92pFL0mPiRXLiUY2lYG/85wocXI5cRG4e6w8Fq8fIjpqpkT826+CiyyZWlm
         zRJGSyi+0RyZXd9PmUJm5rVPthqb9eygx02WUthLm5b77rPEo9IhLvDR63ZBJZ0rM7Mu
         xRUhzx2XHegWDJ2MVrcIvAjmdCnZhNBJeTheapwBxwh+FEueWXSmqrZAk4PDMp7uCXx9
         O8OA==
X-Forwarded-Encrypted: i=1; AJvYcCVUCIE/PPhBkX6o59Vc+kBw4HSILylJhnyS8wJ46PeJtrw80GAfXyFZbIAlk20pUzMmlhpeqBy5J5fjQdjee0Fy2CTNZpCTth6/oAUs
X-Gm-Message-State: AOJu0YyjPFgqMUmJ3brPhE4LXE0t2Mhj0oOi8J83H7/QNQ0eAQW6ZNcy
	27kBEvK65K7DXoxrGROB2mAWhllwJoGM+LfKH7FlpzmpRU25qIyoc0pIVA==
X-Google-Smtp-Source: AGHT+IETArDFEVAbnaKCHGvS1DXciTibScR1A3shqGvgvauhr9kXZFH014jqqk7iCTfCZfZLn7MuDg==
X-Received: by 2002:a17:90b:11d7:b0:2c4:dc4f:2c0b with SMTP id 98e67ed59e1d1-2c4dc4f2d90mr9749894a91.15.1718661312060;
        Mon, 17 Jun 2024 14:55:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76ab1c8sm11777688a91.52.2024.06.17.14.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 14:55:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
Date: Mon, 17 Jun 2024 14:55:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 10:22, Mark Brown wrote:
[ ... ]
> 
> The range is *entirely* defined within the driver, it is 100% a software
> construct, the hardware only influences our choice of range in that we
> can't place it on top of hardware registers.
> 

I _think_ what you are saying is that I'd have to model all registers
which are to be addressed through regmap as virtual registers with an offset
outside the range of real registers. Something like adding 0x100 to the
each register address and then accessing, say, the revision register
not as register 0x02 but as register 0x102. I would then define the matching
range from 0x100 .. 0x17f and the window from 0x00..0x7f.

Hmm, yes, I see that this should work. I don't think it is worth doing though
since I need to be able to access some registers outside regmap, and I'd have
to define two sets of addresses for all those registers. That would simplify
the code a bit but one would have to remember that register addresses through
regmap are different than register addresses when calling smbus functions
directly. I think we'll just stick with the current code and keep the paging
implementation in the driver.

Thanks a lot for the advice.

Guenter


