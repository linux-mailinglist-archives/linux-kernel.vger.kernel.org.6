Return-Path: <linux-kernel+bounces-179388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728C8C5F97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A1AB220C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A038390;
	Wed, 15 May 2024 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO4xKWD9"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB0A945
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745963; cv=none; b=dnENL0dAs8Pwp1rnDrHD8QGLu7jJxitHZPnpwmp+JOOydegY3/Ev0Wz7O14myFVpIOJ79iwEfDAxFmG1xWgxQMtGpwyCtYlIB+imB+WQTo2mNHcJON8+FBP/6huicWQPjfWMELbi1vVMbcG0v3g2R455v6m2WG206z6weHbqP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745963; c=relaxed/simple;
	bh=t6d6UScPyU9A9NHD0oQBmyqM/8f5ijxM8L661Hn7/SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jb2wC1rSrOFZfH3vUN5sRovs+zVQfeHXUi0IuyTfByGVUgbymKHxi73IiClU2dhhpqdOEKBUipoxc18gG3BB8wE0l2OYZDt2AgXfNVGYj7SRF9gyDX5nQcitl/D/W8jKcET1UzMZIEtGqA2PkVlc06oz4l56tDnsNqXXa5KyUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO4xKWD9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792bae4137bso616568785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715745961; x=1716350761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zplpIrl9jD+p1UBCYDwyxt2ZoR4+V1S7OThiv9o2w7g=;
        b=RO4xKWD99eYOoYl7p1Y3aSFXKpjfrQBoTWI8xCYyalzEaKhcD1pLfCylar63kkphHr
         c/TcPi46rjOq0PXViwkT7/khsNX+X29UlaqtuusCBUtsGHTE/wh8euG+A7VZ9+Q7o+zq
         HcFqRLc87sjdidpix3FcJal0gaALbPB3Jh27crF8xoAeqgkdyBH6CpxKA8w/ZtOGuAm3
         G6NS0AiZKlUArH8u0gthr4ztzzBrhHldFK+GYSLKDyBpMlhY2HqLDz+KX+/COx5k5ghH
         li+fmAxry79925hz40zpXSaHMJ/vsmKEO/7Gt6ykN7Nw9oa48O9eflrRHZEj5vn5GqVU
         oX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715745961; x=1716350761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zplpIrl9jD+p1UBCYDwyxt2ZoR4+V1S7OThiv9o2w7g=;
        b=lx1pOuIMpjgVC8/DjSlCTYgYmw+adMW98SAba1ftdA4Ib0UiLGPhIGRJhXbwWIIn11
         Wl0hYDYBuVIaVC8iTkxQh05YeKWCg17Zx3H0VkBfifwB8NmMBRf+p61uy5mAtfkyghmO
         qrQxF6NN/3dYXlQJ3vNoPg+RFxzEVNd5N2v3lvT2JTi31wmVZ7KQkQD9+Ih87N1XGw83
         2HJlFp7fCyJyCmeHwBEVppkfzB7Kn4Bxhyg7xUgfsdbd0dOzzkfqP9dpMMfQtX6NNhSl
         PAZt+wEsPAFRDxjFgED7+vbFTD3Y+RwqIaW1xqNrYrKRVdEtx3Sl9ZuMv0ARUqBYm2Aa
         CWGQ==
X-Gm-Message-State: AOJu0Yybc2YFWeWKahLNNdHzEOvwwsVMPIBIiOMOI8HYjl/tZvUbyLo/
	uj9HYtjnHg/Y2GSxZF2P7l76rqWcIA0kvsvH15WMPlJSvJZxJVY/
X-Google-Smtp-Source: AGHT+IE79TdNLhVHsq0UCqQGvMkvKw9pxZxga19LBOc1Vz83cMetrtEqSOhp8yEVKI7DjbLuCyE6wA==
X-Received: by 2002:a05:620a:c05:b0:790:dffa:439c with SMTP id af79cd13be357-792c75f4b43mr1440883185a.50.1715745960962;
        Tue, 14 May 2024 21:06:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27779fsm635866285a.21.2024.05.14.21.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:06:00 -0700 (PDT)
Message-ID: <b7d6fdcb-4b01-4bc1-8e4b-3cf4ccb951e3@gmail.com>
Date: Tue, 14 May 2024 21:05:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Andrew Lunn <andrew@lunn.ch>,
 Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: linux-kernel@vger.kernel.org, OlteanV@gmail.com
References: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
 <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
 <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
 <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
 <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>
 <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/14/2024 9:17 AM, Andrew Lunn wrote:
> On Tue, May 14, 2024 at 05:08:24PM +0100, Stephen Langstaff wrote:
>> On Tue, May 14, 2024 at 1:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> So try to making FIXED_PHY = m, and load it after dsa_loop_bdinfo.ko.
>>
>> In my configuration FIXED_PHY is selected by several other modules:
>>    │ Selected by [y]:
>>    │   - FSL_DPAA_ETH [=y] && NETDEVICES [=y] && ETHERNET [=y] &&
>> NET_VENDOR_FREESCALE [=y] && FSL_DPAA [=y] && FSL_FMAN [=y]
>>    │   - FWNODE_MDIO [=y] && NETDEVICES [=y] && MDIO_DEVICE [=y] &&
>> (ACPI [=y] || OF [=y] || COMPILE_TEST [=n])
>>    │   - OF_MDIO [=y] && NETDEVICES [=y] && MDIO_DEVICE [=y] && OF [=y]
>> && PHYLIB [=y]
>>
>> ...so it looks pretty tied up with the MDIO support which I guess I
>> will need for the real PHY!
>>
>> If I sorted out building the dsa_loop_bdinfo.c code as a built-in do
>> you think that would solve the ordering issue?

I have re-created the issue with CONFIG_FIXED_PHY=y and for a reason I 
do not yet understand the following rule:

obj-$(CONFIG_FIXED_PHY)                += dsa_loop_bdinfo.o

does not result in the kernel image containing the dsa_loop_bdinfo.o 
object symbols. I am fairly sure this worked when this was submitted 
back then, so give me a day or two to figure out why. AFAICT the make 
rule is simply not executed.

> 
> Probably.
> 
> Florian test setup shows it can work.
> 
> This mdio board info stuff is based on the same concept for I2C
> devices. However, it is simplified a bit, since it is not really meant
> for production use. What i suspect the I2C version does is that when a
> new board info is registers, it walks all the existing I2C busses and
> sees if there is a match. The MDIO version is missing this, it only
> runs the match when a bus is added. So it is less forgiving of order.

Yes that is fair enough, there could be improvements in that area. Or 
nowadays, given that software node(s) are a thing and that we can apply 
overlays to PCI(e) devices, we might consider doing that and ditch 
dsa_loop_bdinfo.c entirely.
-- 
Florian

