Return-Path: <linux-kernel+bounces-286666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CBF951D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66644290BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557C1B4C2B;
	Wed, 14 Aug 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XoFViLeC"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4D1B8E88;
	Wed, 14 Aug 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646594; cv=none; b=M4TdRaUQG26soSYGe0rOf/w6bWwGN2cAjKJKnUgIRQgu6GsbheZaBl4OHBZQ69WOQuiqzF6OieTeQ6zQrQAOEIg0iVjBsrl+pZNm6jburqS/jkmGgj+Xpr3MXnxpYdMaS0PyyDd9mEAY6dli+uMe9vMGUcD1HMXG9Zv80mZt2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646594; c=relaxed/simple;
	bh=yLouSTwOlbX5tjaF0vA36ZH3O5OsXtRlgfxR+F7ovqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tFUtGDK/FRTc7fNlZOTUeCW7zzBqjFfYYIvzGIQDLzZAxwfOYe5ZQtGTtla1T20P7YhdB2QVnCM6uQKjDBfaYYZcvlEEWdtPslJOMNSN9ite7NWBEPw5eLHUZjyHon3mvBfLaGfkTBT+fx5x/3SDa1zGWjgbC+tm48xqWLBsnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=XoFViLeC; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fjWYlXHURzMvazFX69sFcrsxkhMV8rtJ9vxGR6z3YW0=; b=XoFViLeCZOr/NL2+kTMmOrBFdy
	pYfJrUZvoDPdfFQD4rruwBC8ol5JKxOrW1p8nzyPlH6orOOHxIrSdPsQz5k3+haVt4lFVAGMkroHU
	BTSOe5Dd2+iqmCaZyh8yNtHbDMsNuqo+CJM6G821C3Z0GUtjD8nbnkMNbplOFk+LQZpvquQ0xhKi8
	l82v5U5+8GkVDSqyJdKI0+AxXH7qltXC8FKB1rAp6coZCNrdExczp1Il/eTCqiK2ypoFUJLeZ3z92
	sVL0/48WlgqA0ukxzBO4xO1SplXnYYQNRQQxOFzpZ+o4ldKO1EojMxs/A0XfFf+gQSsCdMuxSMqdA
	9SC5zsOw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seFDN-000ORW-UE; Wed, 14 Aug 2024 16:43:06 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seFDO-0007Id-0O;
	Wed, 14 Aug 2024 16:43:05 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Jessica Zhang
 <quic_jesszhan@quicinc.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add JMO Tech
In-Reply-To: <ec3462d8-e300-4273-9ce5-5380b506821e@kernel.org> (Krzysztof
	Kozlowski's message of "Wed, 14 Aug 2024 16:25:00 +0200")
References: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
	<20240814-drm-panel-ili9881c-lcm-jm800wx-v1-1-22a5e58599be@geanix.com>
	<ec3462d8-e300-4273-9ce5-5380b506821e@kernel.org>
Date: Wed, 14 Aug 2024 16:43:05 +0200
Message-ID: <871q2r5fnq.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 14/08/2024 15:10, Esben Haabendal wrote:
>> Add vendor prefix for JMO Tech CO., LTD. (http://www.jmolcd.com/).
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index a70ce43b3dc0..5d2ada6cfa61 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -758,6 +758,8 @@ patternProperties:
>>      description: Jiandangjing Technology Co., Ltd.
>>    "^jide,.*":
>>      description: Jide Tech
>> +  "^jmo,.*":
>
> Wevsite is jmolcd, so prefix should match it - jmolcd.

Ok. Even though the companies name is "JMO Tech CO.,LTD", and does not
hint at "jmolcd"?

/Esben

