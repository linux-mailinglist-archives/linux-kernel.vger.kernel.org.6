Return-Path: <linux-kernel+bounces-262633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC893C9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016FD2815F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C651369B6;
	Thu, 25 Jul 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b="UlcBtrw5"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64973E556
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940481; cv=none; b=DWMY+Dr49uyawY5QHHROLaA3SFImz82XIGo0uVLbh4KyLXFqXquB61YCMEnkJJi3ua6MMwC+ZxJtChAnLwnA10gbJdrQKJ6xqtv6rRaaTLfhV8ldhhIMbP0EAirCs3gOYFA1nVScJf9k7CVCzf8WfmnkCjveEl0VmBAs+aR6g9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940481; c=relaxed/simple;
	bh=tCc7yzfwMwX+3wHm11uN8y+ogivJbHvtbMIOTwN5S10=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UjG8iFrdaQD8ycEgeS4f25+f1vwULFZBvdVe3dzvgpQWlAaGgQI41vknIYqtremgApqUU/9dYVy9VJ+iUtvKmPfaPFHTAIx14676lv4KsTmTJg9M8Hwozp0mhBAMw98lBudyyzLEYECE609Hc/CqlPIJMfweNyHCVhm8ORBGIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com; spf=pass smtp.mailfrom=mentovai.com; dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b=UlcBtrw5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentovai.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a3e468a9so9956356d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mentovai.com; s=google; t=1721940479; x=1722545279; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDVR3WOcutJRJbF1ISjhWZ6SEFHi8sF6jbKuLCY1/p4=;
        b=UlcBtrw57z5DFff+al+sZ6OH4r7jSvQ1alrf8cRDyoul4s2UJoxT2MOKRpnd4LiVJ/
         6pAZRjGUmdvQVKRQVqZUiQsiSeMTC/eIwYL1TgMMBKlQVO6a68u64X2FFu7LHMkpLW3y
         FqH9Gz41cotWh7/pccCr4XvPiJ2m/JNBVXuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940479; x=1722545279;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDVR3WOcutJRJbF1ISjhWZ6SEFHi8sF6jbKuLCY1/p4=;
        b=GGg+9CC1ZTYmR9WpolhiGUvnd7y8ekJxZrVGgelgCC0z926BUpvkiXDUVvN4YYgzDd
         AngLLXhQw24TmZrGndc2YAq56x0sbCI4OcQ+RQUAxs1Y6dX1AyRy5NippkRuSgkPaorP
         wf55/SUhMNP7eCW2Uw4D9P+WgrfaYOrNp1q83R3Aa0LGs+1QbluxZoy4DpmTqiwRijl2
         /sQJWosw9WDcbTLIgmY636VopNkZbqXn3Dot1uljgfVLJqpbKois5rX+oFewour8HaTS
         hRc623xCeHHXcQIhiOK+Ma4Qw6HLdBisxOh9EGnUBK79OpoY1g+KvD/OnJemq25CdYsD
         Dmzw==
X-Forwarded-Encrypted: i=1; AJvYcCV9t7A5EZ7Z1RSGCOw37Z8i6VeGghFo0G6yi1K2s3erFHEU2zhm8RJMA6PSd32YXFn5dvcbpZHl+1EAIIMLWrprbEJqSLYmK0fMzFNG
X-Gm-Message-State: AOJu0Yx+nokjCUA44oq37+XGuXMwgYZ0+yUtTKER3HobVZSmZYPDvr2f
	Jrf2JfHp2lNuTe91hV0luTVbyOedPXG3jFeEmEEOXQyzkXal7B/0KM8mC+dAM/vR060KXUY9MgV
	3kvWzyQ==
X-Google-Smtp-Source: AGHT+IFiCqO0eALgHXDnMjwjSkiPUpvhtE5QV3jaP735DrNnryAZp59sy10aVVD1GnajR0Hgb6fSEg==
X-Received: by 2002:a05:6214:1c07:b0:6b9:5b57:f690 with SMTP id 6a1803df08f44-6bb3ca2fe58mr49398106d6.25.1721940479206;
        Thu, 25 Jul 2024 13:47:59 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:a8a9:9eca:3c60:83f7] ([2600:4040:9ce0:6400:a8a9:9eca:3c60:83f7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3facb1e9sm10380386d6.119.2024.07.25.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:47:58 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:47:57 -0400 (EDT)
From: Mark Mentovai <mark@mentovai.com>
To: Simon Horman <horms@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Oleksij Rempel <o.rempel@pengutronix.de>, 
    Jonas Gorski <jonas.gorski@gmail.com>, 
    Russell Senior <russell@personaltelco.net>, 
    =?ISO-8859-15?Q?L=F3r=E1nd_Horv=E1th?= <lorand.horvath82@gmail.com>, 
    Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
    Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH] net: phy: realtek: add support for RTL8366S Gigabit
 PHY
In-Reply-To: <20240725200143.GM97837@kernel.org>
Message-ID: <cb4710ff-c55c-e7e7-487d-a0e1c6f10972@mentovai.com>
References: <20240725170519.43401-1-mark@mentovai.com> <20240725200143.GM97837@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Simon Horman wrote:
> On Thu, Jul 25, 2024 at 01:05:19PM -0400, Mark Mentovai wrote:
>> The PHY built in to the Realtek RTL8366S switch controller was
>> previously supported by genphy_driver. This PHY does not implement MMD
>> operations. Since 9b01c885be36 (2023-02-13, in 6.3), MMD register reads
>> have been made during phy_probe to determine EEE support. For
>> genphy_driver, these reads are transformed into 802.3 annex 22D clause
>> 45-over-clause 22 mmd_phy_indirect operations that perform MII register
>> writes to MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII
>> registers, which on this PHY are reserved and have another function,
>> rendering the PHY unusable while so configured.
>>
>> Proper support for this PHY is restored by providing a phy_driver that
>> declares MMD operations as unsupported by using the helper functions
>> provided for that purpose, while remaining otherwise identical to
>> genphy_driver.
>>
>> Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
>> Fixes: https://github.com/openwrt/openwrt/issues/15981
>
> nit: AFAIK, the line immediately above is not a correct use of the Fixes
>     tag. I think Link or Closes would be appropriate instead.
>
>> Link: https://github.com/openwrt/openwrt/issues/15739
>> Reported-by: Russell Senior <russell@personaltelco.net>
>> Signed-off-by: Mark Mentovai <mark@mentovai.com>
>
> Also, as a fix, this should be targeted at the net tree.
>
> 	Subject: [PATCH net] ...
>
> Please see https://docs.kernel.org/process/maintainer-netdev.html

Thanks for your feedback, Simon. I've sent an updated (v2) patch, now at 
https://lore.kernel.org/netdev/20240725204147.69730-1-mark@mentovai.com/.

