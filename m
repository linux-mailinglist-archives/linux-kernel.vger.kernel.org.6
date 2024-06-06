Return-Path: <linux-kernel+bounces-204089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A68FE3F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321D81F27607
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD019069F;
	Thu,  6 Jun 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0oAAg54"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED66193070;
	Thu,  6 Jun 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668779; cv=none; b=eeNtxivw4+Vp0mLK002qZuo8+pVzDsULrA6/iiD2uOw0+LfU6JBMuLcbnWKX0VEVHJ2U8iWeTlxjIlOgQnJuHuU/9kwlLBLi1zu+MkdY4yw0z3SoXHSnbP7GMpJ67LhbbiRlUhRauO4i92S0aOLkxUWkAM3wuMXKMUlBrdzl2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668779; c=relaxed/simple;
	bh=6Uy5q4elvDKhtFVRvt/yFW+qIAdrjmGYOYzK4xro7+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5Eyc9yqbINdR1h+gRvRaDmWDVpPCez8nBTg1BvoKlSxfIMAhrHW/A2f4RzwUEWo260u4qsaHspooRSCxP7LatGuVBqrFogyN9D5cb4VU8AYKAm706My0k/M63MrIdiZUUhnZlbJSmW5sr5ORLMRImdV7/Ll4tOUyzHNSsdah9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0oAAg54; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so14058461fa.0;
        Thu, 06 Jun 2024 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668776; x=1718273576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwwGGDviOkEqNMI4ZeyME6vD2otTizBZGZrZCysEeXs=;
        b=J0oAAg54a2s8REwQAcbWucX9zQmshjYXIt6wxi04BrfMkJn44AQ5sYHFWgkayTSSBL
         Cq0caGk+JRTBy1uttPzUh4wK5pDLCyo8r4sckIzLbl8M5xP8NmDTP9WR66VUJjbHX48Y
         mJXTKCq0rJxP8EM6IkN3VZ33pYN0uldfFohLPih+toKKbcnyANg3N32IzA6qvlBKLEC4
         oT8yCbQw2wcruWCgfTMATqcz1tKqAn9PoDEOQ/GsQvYOKFhwTRg1/oubxtx7YVf9+G4J
         6TwjiEU3ZliyRYgHx4/NatMsuXEeIwkiMZiaPoTKLW+hz6nuOrnfk8PruClrW2eq/g+E
         up1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668776; x=1718273576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwwGGDviOkEqNMI4ZeyME6vD2otTizBZGZrZCysEeXs=;
        b=uySMzTO3qegcH/iQv+aeFeegz0A13sMRPavnJ76E3xYzEaU64Mk56Xj0BOcgh07xRb
         gidYj4zT+5h+WytPk5PXon3iMeR700hGO1lHaATyuKP69vwbAOqKP1Pzp10/66fEYgLW
         2oJsWJ06N+lWZp7cb/M9v3vs14J6qIg0+R6yb+PwpyoTeK66RwIFXSLvz/F8NcvsrvFt
         MHUYHafL7LYl/zj6mUoaFsjcBTrFllfzNOSOZ7A2OoKnPb4XLKdRwMrdPA7XJtTsn6Je
         k4Ejt5frkYfJG6VrXrFW8K6qzCcVdK39y68483B09Y6/FhpD8G4Dxmxg/EgQZoZlQUEe
         2ogQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNfzQ6+w561m2W+yq6ZAwGhDgbP8MiY5HSffQ0kmms1AGMDjRzVjT5v1d8Ch0nufthlWZpMvchzVCuUnRuE7Y5JPJK7AM5lvHtmpqSJFIDnatxbAO59TH61mjgAQJKTgc3tbGid8nTjCGwgn4Dvsj+DbXl1fucs/mhsehk8wtGU3eFfQ==
X-Gm-Message-State: AOJu0YwYF5QDHsLT1fJKovfS7xy3/Tepo8NDSAbEEk5Pz/lg1o2HvURd
	SY157XYxdybqhJ+PvQeyLKBOKKwrcrSH83QyKQCJpZRX0yg6NqE=
X-Google-Smtp-Source: AGHT+IERDa7mrBB8yKBaPAZ+hETVUsn6IFbG49e1yW7WhBHVEIh7oLLq5qPqjNGKWMPo9qPJolTPeg==
X-Received: by 2002:a2e:a543:0:b0:2d8:5af9:90c5 with SMTP id 38308e7fff4ca-2eac7a68650mr46400261fa.39.1717668775339;
        Thu, 06 Jun 2024 03:12:55 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:7ad9:7718:9ddf:523c? ([2a02:810b:f40:4600:7ad9:7718:9ddf:523c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d13esm48762385e9.24.2024.06.06.03.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:12:55 -0700 (PDT)
Message-ID: <e379af59-a997-4774-96c1-33739b715ad1@gmail.com>
Date: Thu, 6 Jun 2024 12:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add SFC support for RK3128
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240605205209.232005-1-knaerzche@gmail.com>
 <20240605205209.232005-6-knaerzche@gmail.com>
 <fcff0181-b6de-4e47-b7ff-47baac061b3e@kernel.org> <7129744.aoefvbuG5b@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <7129744.aoefvbuG5b@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko, Hi Krzysztof,

Am 06.06.24 um 09:37 schrieb Heiko Stübner:
> Am Donnerstag, 6. Juni 2024, 08:41:19 CEST schrieb Krzysztof Kozlowski:
>> On 05/06/2024 22:52, Alex Bee wrote:
>>> This series adds support for the Serial Flash Controller (SFC) found in
>>> RK3128 SoCs.
>>>
>>> As without using some "id holes" we would run out clock ids in the binding
>>> and would have to touch the ABI, I added patches which removes the
>>> CLK_NR_CLKS macro and uses the recently introduced
>>> rockchip_clk_find_max_clk_id helper instead to find the highest clock id.
>>>
>>> changes since v1:
>>>   - added patches to remove CLK_NR_CLKS (Connor)
>>>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets.
>>
>> You sent now v2 immediately after. Confused.
> it looks like Alex had some mail trouble yesterday.
>
> The thread you Acked patches in actually is v2, just missing the label.
>
> - original v1: https://lore.kernel.org/linux-rockchip/20240605172154.193047-1-knaerzche@gmail.com
>
> - "unlabeled" v2: https://lore.kernel.org/linux-rockchip/20240605205209.232005-1-knaerzche@gmail.com/
> - this as v2, but as reply to the previous
> - real v2: https://lore.kernel.org/linux-rockchip/20240605210049.232284-1-knaerzche@gmail.com/
>
> The last 3 are identical, just the sending process was somehow fumbled.
Yes, that's why I replied to the first message in the messed-up thread
explaining it a bit:
https://lore.kernel.org/all/9da22443-b5c3-4fbc-8cb0-d6bebab55da4@gmail.com/
Anyway: To make it a bit less confusing, I'll send v3 with Krzysztof's acks
included.

Alex
>
>

