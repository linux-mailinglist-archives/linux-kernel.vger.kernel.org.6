Return-Path: <linux-kernel+bounces-223585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94352911522
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D161F21E49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE28005C;
	Thu, 20 Jun 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="fYXhP9XW"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB852E859;
	Thu, 20 Jun 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920279; cv=none; b=D9hedBRr+Me09CLyVEBckGZXZVHp4vnWitSCzUXfl1wpDIjmPI5F4srex0EfVl4LCAJdwCWtWhBOgz9JKqSIwKn7y+ucl1d+r/fI+aMVDG1Y0oY+iQYIxeQfzadSvh3ktrajJXw8//p45zBu5TOTB3lPyP7VF1L/eE8EF1dKErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920279; c=relaxed/simple;
	bh=jS4tGX7Yr+F4Pgav2Qb5MERvvFle9VrE1JzJPH9w6gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNTcuXX12D+rgWXGE0FTYpAo0vejQNwDACS1o7a3zWYNER8zT9HPzmNnwIz1uopZBx9UrWbJ10UXzwPX7+bHmnCvzPMjfEQVIZeVp/936owQbj2j/kwNKGJaB3pcFU1O+z3gyEcRoHO6yhPLaWTrxCkkatYrUKDhWUQMuLniTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=fYXhP9XW; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 52E40240AE7;
	Thu, 20 Jun 2024 23:51:16 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 31768240E86;
	Thu, 20 Jun 2024 23:51:16 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id 12B7C80102;
	Thu, 20 Jun 2024 23:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718920276;
	bh=jS4tGX7Yr+F4Pgav2Qb5MERvvFle9VrE1JzJPH9w6gw=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=fYXhP9XWv8R9NfFyLu0p9bECXAvkCoG4tyq8CP7rG1v5IXS6ngMg8+4KGjyvD9mtI
	 KV7gCoiQfTOwCW6cCR9nQ3ZP4cNRo/zTq+hPc9DDXdQV485NhL4RMdxr8xai66jyXw
	 Julp268jMYuAEbxy8rhDXTkunfszXMInjK3BqxXHbH+ipgA0tlubvqYHioU8X3cp3c
	 mjDy7VGxhvkyYqmF3ubRJKBTEhM7QgOdvOrAr/9eWRHc5Z3hf0KWzbeWhlHeEDDPiJ
	 5sQ61TOjhMrjt2TtDOjWtqPZ/3qYP3hrOymgkpOruzRi4oXghwyrO/lOyVhQ5y2j+J
	 pzTHuhS4Ppfrg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 84B272409AB;
	Thu, 20 Jun 2024 23:51:15 +0200 (CEST)
Message-ID: <7cc3d7c4-d0c9-45f3-ada9-d0e0d3fe7cc2@mail.de>
Date: Thu, 20 Jun 2024 23:51:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Improve LEDs on NanoPi R6C/R6S
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240612205056.397204-1-seb-dev@mail.de>
 <20240612205056.397204-4-seb-dev@mail.de> <2564239.kdYZ1jHi8b@diego>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <2564239.kdYZ1jHi8b@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1112
X-purgate-ID: 154282::1718920275-4EE221F9-E6050407/0/0

Am 20.06.2024 um 20:42 schrieb Heiko Stübner:
> Am Mittwoch, 12. Juni 2024, 22:48:12 CEST schrieb Sebastian Kropatsch:
>> DT validation doesn't like the 'linux,default-trigger = "stmmac-0:01:link"'
>> properties, since "*:link" is not a valid value according to
>> [Documentation/devicetree/bindings/leds/common.yaml]. These LEDs do
>> have the specific purpose to show if an Ethernet link is up though.
>> There is one LED for each Ethernet port and they are labeled WAN and
>> LAN.
>> Using the 'linux,default-trigger' like this does work perfectly fine
>> with this solution. I could not find another way to achieve this. Please
>> let me know if there is a better way.
>> Maybe it would also be valid to add an entry to the DT bindings file to
>> allow "*:link" as a value for 'linux,default-trigger'?
> 
> correct. If needed, things should be added to binding.

Alright, I'll add this to the binding at
[Documentation/devicetree/bindings/leds/common.yaml]

Should this be a completely separate patch or is it preferred
to add a patch to this NanoPi patch series?

Cheers,
Sebastian

