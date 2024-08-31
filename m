Return-Path: <linux-kernel+bounces-310001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7269672EF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 20:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B2A2833EF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2754148837;
	Sat, 31 Aug 2024 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="ylVd4Od3"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40E1D556
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127907; cv=none; b=TYQAd+7buf2VJENwLobGWrHIPhaOYGQkeY0oUv6fTj+K83LmpnqVibT9Xr3DHR5mftImu0RhfusoNT0XiuYSMIX3LX7KVx0jRXCU8eecVxIZkVS0BkC8i1DvillIkXAEGJBdxEtbBF7Wz2AU5E1E36Yg/ojcM1l+2pn2sti9340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127907; c=relaxed/simple;
	bh=JyNaWK9K0s83lLJcoD0b4TQy7rpDyJf4ZrqoMGJ3XMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZwOHHnmUqWrDFXTs6woQHR2MLP/ThSl5AqtwQaxKb1waIxaLBRpZ5SnI7GMrmqsu/znKzSIrILLOr64HhVe5OoKIKlZAKrZjQAVAVeuWFpCMm+iGJUiSdzNNbu9O95VrKmusT6Mpbm5OLo9vx5mPb3nllIPVhB5AWCA/VhBzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=ylVd4Od3; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-202146e93f6so28752635ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1725127905; x=1725732705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+5XzVjLCMuTjYv9Ok00f+cf4AkYWNfkNc3fqTvrp/0=;
        b=ylVd4Od3VL+WmqB1I4T0C2lG7VDHTntSF72nV4SGHvOC2LHkUjywoXw0Fp3i4gK5cv
         7zU3f61uWRP75a1Wz2xBjbm26zW5Sc0qqDK14UCLf3wLachsJp/JaN/3V9YdLHD662in
         VwX9HvlvYhDI0BHxiH+ICK0aUwqmWcrK58bRbNu3HWJRL6Oopm9HRAYYzsb+Q3nDRVPe
         ziJFKLiD/oN04DR+AEkcEthpjujMqZs24girL6KlAe+8JvxLFjOUBsBvPEXfkwYXmJ5P
         VUWIKkz+egpSJ+YuMGmcv6bN5mQYzT2EIIlHWYPG/PKbzf06UQuJACgfOaCHf0mcFVZ9
         xq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725127905; x=1725732705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+5XzVjLCMuTjYv9Ok00f+cf4AkYWNfkNc3fqTvrp/0=;
        b=O/e8tX+cEJkGS3v4TpAdTMIj85/OW+WgJoISk01jKFRdrh1LP05bmDQ2SA7PPXu5V1
         w/GcHAz08PrnRMI/swjgzdzxsUqone3EHZq+etyDmrlTO0TDWWi5LdUmX8k4sBeZ+9vn
         buepqFtUEiLdfBxUM7i8kkctqX5HWuHIHmiDpKO1CHn+U0/19XH22eNjZAqJ630WY8I3
         GmvaK5JryFjIgixS4S3wMItP0JjJHWtW1xhJAZ9EqIl38b077c7bRqH1ESQCrv76PfGP
         SXli15LLH5QH33rLbUArBQLw/lsHp7vrvrwuJudNGtsvOUqUY1KnLB0RQNGWwvmdI7SA
         YSXg==
X-Forwarded-Encrypted: i=1; AJvYcCWrfQ+qK6DqO7PZ6PPu3/CbgNZA//Tim7RbrNyyPGNvSg5zdWk1ElBxLEqBV37QEf115DANSiUpA3q0g3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymp9DRlMDZF3xtRgXzAAVlcwE3sM3DsuiOqXpwcdxGxnH8FGu7
	z8RcfetOmp6Jsya/43faMrYRjejWbShl79QZbXNqpeMN1UiFddG+21xqnS9wzw==
X-Google-Smtp-Source: AGHT+IFQNwjO5fnCQzoxZ9MZgPdmCvdFiQl6lsMfwMOKhxYBfGKuDEbEGB1vFlHxRZvrR2ve39znhw==
X-Received: by 2002:a17:902:d481:b0:202:45a7:84d1 with SMTP id d9443c01a7336-2050c46e83amr105743905ad.52.1725127904987;
        Sat, 31 Aug 2024 11:11:44 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d03fasm43302265ad.114.2024.08.31.11.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 11:11:44 -0700 (PDT)
Message-ID: <e2558820-f36f-406d-8f83-95c7188c0ce3@beagleboard.org>
Date: Sat, 31 Aug 2024 23:41:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
 <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org>
 <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
 <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> But here you can have subnodes, no? These could then be just
>> enumerated as usual.
>>
>> &mikrobus_board {
>> 	mikrobus_gpio: gpio {
>> 		gpio-controller;
>> 		#gpio-cells = <1>;
>> 	};
>>
>> 	spi {
>> 		cs-gpios = <&mikrobus_gpio 1>;
>>
>> 		spi@0 {
>> 			compatible = "mydevice";
>> 			reg = <0>;
>> 		};
>> 	};
>> };
>>

Hi, I am now working on an approach for mikroBUS based on the apprach 
described here: [1]


I am thinking of the gpio-controller approach you seem to have used 
here. So I wanted to inquire if there already exists a gpio-controller 
driver that can create a proxy controller that forwards stuff to the 
underlying actual controller. So something like the following:


&mikrobus_gpio: gpio {

     gpio-controller;

     #gpio-cells = <2>;

     gpios = <&gpio1 0>, <&gpi2 1>;

};


spi {

     cs-gpios = <&mikrobus_gpio 1 GPIO_ACTIVE_HIGH>;

};


There does exist gpio0-virtio, but that seems to be for vm context.


[1]: 
https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/


Ayush Singh


