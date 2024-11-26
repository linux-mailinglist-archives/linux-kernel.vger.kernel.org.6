Return-Path: <linux-kernel+bounces-422621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300079D9C14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6911B25489
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE31D90C5;
	Tue, 26 Nov 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UthGqOPD"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5C1D0DEC;
	Tue, 26 Nov 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640472; cv=none; b=RWDM4VEDv34g/BWG11PNmxHu9jo8rd0U0xmQbwvD/+vPhtQwB9z+k/bqejvkWuY5ux35GviMhQUoBuYrOrKA6ejR38hfJwO1INcT6r0s2SeTXstbA8cY+lz4o62lIFrYo0vrRfk3ZHmsBqs+O20KTtltKtE2IlX9Yb7is63ByZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640472; c=relaxed/simple;
	bh=ZatdLTgZuMLhV9FfTllw/+llDgZAW17X6HodikMN+1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdddfLs+Ut5JG9SHVTXUjwkJ7xI4rXpsHshjrabTb1pPhb1/NDbfPO9UD6BScRucKqBXW52BLi9pm5lltUpBDbKPI19fVm27VPlpodDvNFDQmJxcn/U8aR/qHL6vC7wS+fxsQKjazQXnZVQsoQ429QXCF1LuHRFe/kKp1o7dx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UthGqOPD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5314849276.2;
        Tue, 26 Nov 2024 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732640469; x=1733245269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6rC4JORljy68YEdx8irUeLm2zmoqEL3AApISoooOchM=;
        b=UthGqOPDqxfGm/54Zq75jl/pMzN/PiD+8iggLEERkA9MUBAuJpZFC8yIknS5NJHEh1
         wPVKTmtFFT72ruyIOp29oZ/kfIw/5RYhYU0MzKH3BNKJbwiQ6iF0YK3gsg6DzjQgU65i
         p1MHIpjEC75pKTSFLz2ylRJNuADyYm/hB4K8KRqLIK9f/NIWXORzD2nBkcBrffP+C0Nu
         UFlqeFYy3TQsSYYy8hLDUaPBioej1XeqECl4ZkTjZUkgKZyU9LDYanuhMVocQomQtVCk
         QjfAyLb77Mowyd3wqBc/m24XKZb3wtI2Iw9CxvIX4EGrYXj4BvLRaX9g5dGpMPm5pQeY
         gDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640469; x=1733245269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rC4JORljy68YEdx8irUeLm2zmoqEL3AApISoooOchM=;
        b=f/Pjbke6PPTI0gudcgDzRUFZOr/0qPBybPikwXxKEXZuYYQ6JGMM1aDErXy59owdo5
         XHN5Q/hEvp5Ct7rT0EX2gh9dDsfc9HZLAgRld2YBqCzgmLjbiD6m7jLyvGrzpfLuqYw1
         Y7BHCV4Rrr7ONUwbIVebJMBEgcQEGMBp2iww4s798bpmpejtFJDSDdsFnFLZxnD9YzXx
         8rwCcn1THkBEvAISZS2g1qZ07DNE43lbdyPihi9WrcaCz1Tb9JlhK9xPys2H6lvvmBH/
         dzwK2bjA9MEipEi5HCrmKmqONV0rJa6kFJ2cc4t4/CqKwFXU+BN9oj15ozefQurrUowe
         2tdg==
X-Forwarded-Encrypted: i=1; AJvYcCVzpN6pTbjRoWV/ZEAAo9zOoZMJrKHKuBgo1LEiAWFCjgOazYFLID/4TqLSFtaQC18G+7TytGPpwZf+BkZ2@vger.kernel.org, AJvYcCWtYdfa5MV4fkxYFyQhN4iLrSnUvAyCwZgZ8tCCwk8jk/mmz7JC+DW1/PqQj+TNoiPOyNALiNJFaOCo@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqnmqupPAkjCr4bK0dZqaa+bxAveDUUAQ1wBU8xP91qLyD+v1
	6xoV8uwf5DZ8BXUmf6XY8/NGCTg1P2GrL2PoCrcKhiC5FGljo8U0Q/IbWNiLpKvLs4eDYD69eIi
	i1SNAgeuWb0PZOfl/mMnNdBdZU4A=
X-Gm-Gg: ASbGnctPVdTnLADpK0ZNDR5KFeRGO7ZnVzr0U1sxfgb/xe7wncaExtlKK9qHBSo2eTH
	EHsgdANicDQwFv2anQB67pMNpUW7DoSmA
X-Google-Smtp-Source: AGHT+IFd396UsokWwA15Q5p/KFcRLABdHgY43zyTynmP3tmYwQ6jofpQFOVNZv8hTAfYU9pttSvOZX2EXzH2X5cAsqw=
X-Received: by 2002:a05:6902:140b:b0:e35:dede:fe02 with SMTP id
 3f1490d57ef6-e38f8bf5ae0mr16167825276.44.1732640469435; Tue, 26 Nov 2024
 09:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com> <20241126-adpdrm-v2-1-c90485336c09@gmail.com>
 <050d1398-cfc2-4921-b82a-95eecbcddba4@kernel.org>
In-Reply-To: <050d1398-cfc2-4921-b82a-95eecbcddba4@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Tue, 26 Nov 2024 18:00:58 +0100
Message-ID: <CAMT+MTSwCf=iwmD3t=E7T81K_d+o-5XpCxov9fk=_oUnwooA-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: Add Apple pre-DCP display
 controller bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 17:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > +allOf:
> > +  - $ref: dsi-controller.yaml#
...
> > +patternProperties:
> > +  "^panel@[0-3]$": true
>
> These look unusual. Is this a DSI controller? If so, then reference
> dsi-controller. See other bindings how this is done.

This is a DSI controller, as referenced above. Those properties are from
dsi-controller.yaml

> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - apple,j293-summit
> > +          - apple,j493-summit
> > +      - const: apple,summit
>
> Summit tells me nothing - no description, title repeats it, so I suggest
> using device specific compatible.

The j293/j493 are the device-specific compatibles, those are chassis names
for the specific laptops the panel is present in.


> No, these cannot be true without definition. Again, please open existing
> bindings and use them as example. You probably miss here some reference,
> but max-brightness for panel is a bit confusing. I asked already and did
> not get answer: isn't this backlight property? What is this device -
> backlight or panel? If panel, then what bus?

Per my response on previous version, it's both, kind of. This is a
self-emissive panel on
a mipi-dsi bus, which can change brightness in response to mipi dcs
backlight commands.

