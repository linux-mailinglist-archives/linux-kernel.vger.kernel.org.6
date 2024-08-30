Return-Path: <linux-kernel+bounces-308268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D29B965993
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C761F22A17
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F8166F15;
	Fri, 30 Aug 2024 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iJH07Lwc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE83165F07
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005416; cv=none; b=mS/3cePfWxQqJsvecamGs7goObCHa6WOgzTYq+sbjOr5PRxcWoNrPc7Gx9/697/J9NBO2n5rBt9GJGhSoMVC2+rHA9108Rf3alDi89WfUJX5W9QoiUFlSKJb5LWiH+ZhgNBySWdKFj369+81fNigPFFXBJWQgqUDWtiPjSWS59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005416; c=relaxed/simple;
	bh=O586LEmPjPX2HiPnhS5pv8/gtaBBHNlXFpbm4jWmWSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzHzMhAC0vRPKmUM+346jehcUlUWvb03esP3ziVnHWs18HrOFqyW0WNSEPZp4J1Ni9DN8T8vWFcCAZhlxA2VTl3RAOccV1GKAlnuIWXzQqEoiH8bx37GaQDYpadmMp2C3hHBDYDl8Thg1ciH3NEXKGGTTG8M29HSmzj2Hqe+Pfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iJH07Lwc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so13330685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725005412; x=1725610212; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Css1DS/twF3J6CTksvvGFwq/UDTMQRJ6E1Ahqfi3MtM=;
        b=iJH07LwcLVXLpvxAzNhck3hkQubEQvzOSRSn3IpArrDpEPVuTKQLOzAgQBx+9LJQeB
         8+udVi9TEGAYChM+J3eGXf/S3R4/sDvC5n/T+yhh8SRjTO23oQ+CusOK5Qvk2ACaaAwh
         EgKc81Aml0bjvh5aTDysbVl9imtNZqEpXiEZby6zudn8l7DvpYrGd4KiuMv2Ak7fI87a
         mqM21+UMH68l+O+EeSLmB5f4X7sRYm3sOCCxaJCcuHqvTLDp5CFob2TMXcOgQMZeI/0L
         8baltIaJWB945VyIREc5j+Im4KCM+eyIsFkWTRnjjpIoEu1CKsD+quOIWKXFHq4IHryM
         HnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005412; x=1725610212;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Css1DS/twF3J6CTksvvGFwq/UDTMQRJ6E1Ahqfi3MtM=;
        b=IgD4OifxNGQOZrxDqK6+clp+6GMgX75nahc05F8fI1521lyxx39Cj1IQchfoOoqr5D
         vujKZYEa2w6AtH2mm+Rem0Uq3aPZogkafxi3Kr3TlnJAonamX53xGPslcH/a+/3UFu3K
         l/ZqZ0aKC4MzZYA8T0sI82645zcOlLMbJ3dLUrP5lyP8rqFLArMvpHsZ0geRCraZtHjL
         7HHJLlbbPP6pKrT+NaOipbt3+UA/HxQJuKd4gUnRQArSqqz2srUyFt0bB+BfbJnWzbJE
         dsTjtIZRjAnb+1qsH95XjC1PNohRTDKPYYLZGclgzCWvOSFKUCCTczwsGBjtLXt4j9ay
         wnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrJIHX+XrpGwRhGuF9Xp1dCDwLfK06OeEBr1dNUeTo6o42iWYuni5PF0Pk1+lQBg2dzHlRIFei71ix8cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nbE5TweSfZToLxmLK6elr44/SrArjJnE1NINW7RJ0BMpv/Ta
	ebHTcjLF/8uYX/kEXwl8DdQcQxq7sdqMWg85mp21N9AAskiVB/z9TZM6ILrENZI=
X-Google-Smtp-Source: AGHT+IH8H5uUNTbFEsKnYUdKRjBzDDZGcrGLT+W24BeFBC1OCMxsf8Ey3WOHr8h+hmPJhmnT5iK/wg==
X-Received: by 2002:a05:600c:3b8e:b0:42b:a9d7:93 with SMTP id 5b1f17b1804b1-42bb032c82cmr45411815e9.28.1725005411476;
        Fri, 30 Aug 2024 01:10:11 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90cb:5cec:cfdf:966f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbd46b60bsm4808145e9.1.2024.08.30.01.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:10:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: xianwei.zhao@amlogic.com,  Michael Turquette <mturquette@baylibre.com>,
  Stephen Boyd <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Chuan Liu <chuan.liu@amlogic.com>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: fix C3 PLL input parameter
In-Reply-To: <0e74dbc8-88ed-43db-95ef-0fe55d92091d@linaro.org> (Neil
	Armstrong's message of "Fri, 30 Aug 2024 10:00:38 +0200")
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
	<20240830-c3_add_node-v4-1-b56c0511e9dc@amlogic.com>
	<0e74dbc8-88ed-43db-95ef-0fe55d92091d@linaro.org>
Date: Fri, 30 Aug 2024 10:10:10 +0200
Message-ID: <1jplpqsa71.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 30 Aug 2024 at 10:00, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Jerome,
>
> On 30/08/2024 07:26, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> Add C3 PLL controller input clock parameters "fix".
>> The clock named "fix" was initially implemented in PLL clock controller
>> driver. However, some registers required secure zone access, so we moved
>> it to the secure zone (BL31) and accessed it through SCMI. Since the PLL
>> clock driver needs to use this clock, the "fix" clock is used as an input
>> source. We updated the driver but forgot to modify the binding accordingly,
>> so we are adding it here.
>> It is an ABI break but on a new and immature platform. Noboby could
>> really
>> use that platform at this stage, so nothing is going to break on anyone
>> really.
>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock
>> controller")
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>
> So you mind if I take this one via my arm64-dt tree ?

There is no conflicting change in my tree so it's fine, yes.

>
> Neil
>
> <snip>

-- 
Jerome

