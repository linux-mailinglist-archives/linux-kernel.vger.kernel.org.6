Return-Path: <linux-kernel+bounces-213036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FC906A32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F091F21F44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26891142648;
	Thu, 13 Jun 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="uyLS1+TX"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6B13D8B5;
	Thu, 13 Jun 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275253; cv=none; b=gkMgO2iG++Ev2EMtNaqdUwQqbdVoRgH2nZBXZIzyPzeuz0v24N+NAh+qIio9Hl7fokfQWNQU9l/VjuehTVaUCVpJLC3xR7kf+hCIB6zwon1+e1yaHDmYJQOxOZjrmWewvY2K/r4hUP/UCKFM5SXKTmRyDM7MsrRdDPoVcW6V0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275253; c=relaxed/simple;
	bh=3OWlZ0HHdHz0zJ3iWyJmfmYpc2zC4ZmLwyCFp2i+7yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gvo6F+q+egvcYGr74vzj3okTD6Zsp5WbjgsQGUVcgzzUuxUuvTPO0+zHE8+WsuIU962WiHI/QnhppOncLBT4qkDY3lhU8EAgapGKis4kS+jNCYkhz7P38d60jOPat2eAieNYitA2/N/oVw1q58Typ+Dg3gPfNm6gF3YUNydQJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=uyLS1+TX; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 9FC675EF21;
	Thu, 13 Jun 2024 13:33:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qXdo9x30J0U0-d6heW2Be;
	Thu, 13 Jun 2024 13:33:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1718274835; bh=EQQoH5X23jTA0B4DCR21/ZfmNUL5R4vDKFEbtMz2jjE=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=uyLS1+TXRkc3ujEdmjdXeJG76Em9/saX2bpREIfYTjtGKBuxNZTvBhY0V4clc60wC
	 tXFfDZy4DlqPgowBw7uImpFuPyrLpKN05Cn6d0/TgRiq5mvPIfpGbR/u2DdFjMGqPB
	 e82nXzdoG+FSyEu09/NOTJrxMoy+YK0Qc3KEabcg=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <495e50aa-6819-457d-8503-00440abc97e3@yandex.com>
Date: Thu, 13 Jun 2024 12:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, sebastian.reichel@collabora.com, s.hauer@pengutronix.de,
 cristian.ciocaltea@collabora.com, andy.yan@rock-chips.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240613085812.4020-2-shresthprasad7@gmail.com>
 <cc66cca1-33db-4f30-afcf-d256a959896b@yandex.com>
 <9ce15b81-a8bd-4833-b15e-3e6f240dcf03@kernel.org>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <9ce15b81-a8bd-4833-b15e-3e6f240dcf03@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 12:12, Krzysztof Kozlowski wrote:
> On 13/06/2024 11:44, Johan Jonker wrote:
>>> ---
>>
>> Add ack request from phy maintainer here.
> 

> Why? What do you mean for that? Why phy maintainer needs to ack patches
> he is going to take?

See my text below:
From my past converting phy documents experience asking was needed to smooths things up ...
Let me know if things have improved.

grf.yaml can be busy at times. Let Heiko take care of the merge order.
Ask for an ack from the phy maintainers in your commit message below a "---"

> 
>>
>>> Changes in v3:
>>>     - fix `reg` in example being too long
>>>
>>> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
>>> and `rockchip/rk3399-pinebook-pro.dtb`.
>>>
>>>  .../bindings/phy/rockchip,emmc-phy.yaml       | 79 +++++++++++++++++++
>>>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
>>>  .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
>>>  3 files changed, 80 insertions(+), 44 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>>> new file mode 100644
>>> index 000000000000..85d74b343991
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
>>> @@ -0,0 +1,79 @@
>>
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>
>> You are converting an existing document, so GPL 2 only.
> 

> Which copyrightable part was copied? This comment is not correct in
> general, because conversions are dual-licensed (there are exceptions,
> but that's the generic rule).

Was told to do so in the past by the maintainers(Rob??) for text documents conversions.(Can't find exactly were in lore, must be in one my first conversion patches)
If someone was submitting as GPL2 long time ago then the derived/converted work still hold the same license.
Let me know if the consensus has changed.

Johan

> 
> Best regards,
> Krzysztof
> 

