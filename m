Return-Path: <linux-kernel+bounces-219425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AF90D117
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900B01C24354
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3619DF98;
	Tue, 18 Jun 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRfgILo0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB71581E9;
	Tue, 18 Jun 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715961; cv=none; b=iZqbk7gdO4s2tAbZCPuje3aqdhSwVAkS2YjqBBlq012mJQw0h1JcACqki71D5GRNbGh/jhREH6OgizvUJ3qSO7aPgoQEYmQHyQeHbOEyFxb8JEabuBeandqyp4x/Ei7r2ntYDp8S6UO8F4/3Eg63I033UgISIKsmPL6Ou4kciB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715961; c=relaxed/simple;
	bh=eF497iTWQ/oy3PQvzjizG/eU/LZDe+qLwMKE+tBtp3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X458up9RpGDy35wuDZ8nHr2BmDyf8DjSwEp61LX80nyQK5nq0woUcFrRVsipyn34aVjCYEPZzmCaxR5Y6bg4wkRAy/NsEBC/S6L6tS5BgSqAYLXsTwfhmTzGjbIgZqq09bIcJ8Zw8K0xwI3fiTZz0NfWREfieOkhZgLAlYDUyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRfgILo0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bbf73f334so5178552e87.2;
        Tue, 18 Jun 2024 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718715958; x=1719320758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz2POXzlje0Rk92k3Asl8aSkFWAo/SOEkU2cZBWovB0=;
        b=YRfgILo0V+7ggy59bwiItLfSq3ZnRQN2na0BX/xeAxW9XKlkJj8NyMkfMxbdktOniI
         yNdgl8clf2e0za/NudnsqlmaX7blOj3p0a7X8wQxY5c4c8UKJG2bmtfDvTMZ7PBAzQt7
         YgOqP+o1ChZq8HyJa4C9AqP8qOpN2Vbt6X5gU9NeFVkGyovmbb3i4o1hgsr2QJV2mCST
         A/q0Ansrm7eHVDVQrLwCPCDsyxtZMfKc87xTZS2sId4vxPnXJsx3rTAboY6t9OYvmsXs
         D5SbgvMdxUt1WE8a19kykd3O1qTxHI0POLJSQR1p/xLk51taAO1wHth+SfyVtCfQNx2G
         cMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718715958; x=1719320758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz2POXzlje0Rk92k3Asl8aSkFWAo/SOEkU2cZBWovB0=;
        b=S823UbM2byTsObGtjA00pYa1f43MN4q/VqRhldCmzMfhYookwzjz7j5jPlpC9SbTFj
         GhnGOUq0LqJXQCBrPEawC53VLr6nvNuOJ0LOY/wIf+m1rTIUd00zCioBJUXSTDmGNhGk
         ueJhIBdSOYMaoR69ASwG0Zu8DtK2qjAQc4iE/IXwBDg80PxcbldBmBc8ChpDgltPFzRO
         rBcFKfy0thdLgINCsnUZRkFGte4BK+QbCzn6oGLFUSbjnZ3AyRioN9OJis4FqPbZOXzZ
         MOw220fo4AsZEYNNLUQEWLD1Z19jJZRx/fQufvrz3MW9Ydb7SABIfSpTStr6MPnjkz61
         TkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw2UK06rPdvdoEib7f5trBR4QPWmSII3B61jy6FV6hsSnfBTvpFxc+x7jSoi35UzK5D7ejnIjW4k6bUGQBvz3/O5RncV1a25gwUg==
X-Gm-Message-State: AOJu0YxB0jxH0ttRg9Bes10ek00BajYTUu8rPWl+hI9/dVn0jcxHEJ0/
	PW1By/BjMDsKCjwz5DN0+NjNHl+RNMBGyDEm23q/zyU3PQlQGjKC
X-Google-Smtp-Source: AGHT+IFkWxc6pexL44K2yH98VVFydVomvNRifmX98LXDDM7htKW6C5Gq43bAc/V0TD+tZp6EJj5ywA==
X-Received: by 2002:a05:6512:558:b0:52c:8318:dc14 with SMTP id 2adb3069b0e04-52ca6e66feemr7610912e87.25.1718715957839;
        Tue, 18 Jun 2024 06:05:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cc067b35asm390974e87.103.2024.06.18.06.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:05:57 -0700 (PDT)
Message-ID: <15685ef6-92a5-41df-9148-1a67ceaec47b@gmail.com>
Date: Tue, 18 Jun 2024 16:05:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Introduce irq_domain_instanciate()
To: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
 <87msnju0x3.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87msnju0x3.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 16:57, Thomas Gleixner wrote:
> 
> The result can be found at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> 
> Matti, can you please build your extensions on top of that?

Will do, but it takes me a while as I'm on a vacation. I'll try to cook 
it up when the next rainy day hits us ;) Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


