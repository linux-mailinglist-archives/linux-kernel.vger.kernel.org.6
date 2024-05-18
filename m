Return-Path: <linux-kernel+bounces-182837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A58C90B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D661F21CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5839FFD;
	Sat, 18 May 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5mokFHO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28139AD6;
	Sat, 18 May 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716033561; cv=none; b=O1AGu9lsqSbPxDnrMIsySMeYLRAsVvRgd/NKycluFT3eCBlEdkCMYm9c2X+tAgmUaX/xkF5niCJ6sM21PueHuQ4EWakkOg5DfjV7VCgKbLFqojQMfy7FUYfOzqD1ihGzAue3sjIiJ/LSYs1FxlILvlU2GpbjUc81rGB+RipsjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716033561; c=relaxed/simple;
	bh=h/YDw9e+GvAmjq4NsLkeVDATVHfq7hH7wvoAYef2hM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoJsX+afs+aB3bhH+WyuFyUlwaocdLFLYLOzzdUT8raB2XsepioRAIHRwWye3jaggAhGuaU0kr1+YFqQH/3v9IQyjPy1aCAmDfBz2gKx3CYMk6ggRDYkxkX8KspazD/xCsJgMExiuwXQXO/IK60utFM4uW2SfLfc4VqucXCZ/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5mokFHO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5241b49c0daso207807e87.0;
        Sat, 18 May 2024 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716033557; x=1716638357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc19eVviu7JJuAUpj9uZHiIfNgeyna6FnUnwirddH64=;
        b=N5mokFHOMVOwD5HpqCZKoCyv5zXZbEY6lx+XF9Hab1QhULOxyxOrAGxrCFAE/sl7L4
         pernaazSjnfh4beoM29RP/mQv9Dhx2KyWYOJbqJkTAivE97/rFoQXouMlA5JxAOZSWpK
         gCw7SPpiHhQPrJ6GIZUrwKBHdUbvHXyreFCYsZns6U59n0pzMeh9YvA9868H/V5lXTdt
         KrLQbgh90MEcbX9mGh03IOHdpv8e/pXDpw2gSGfarcqsM1rMqv3SYDFvobAw+J2TVbV7
         gxlR0QSNX2yyrJtAaDQs27b+EE7t3uPiC11lq0HoLaNdieLnMhQCwf4ZRGAOxkTSj8+u
         0RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716033557; x=1716638357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc19eVviu7JJuAUpj9uZHiIfNgeyna6FnUnwirddH64=;
        b=IwZDJuPB8QFRGCvKPrSqkYf4sWKu/EKr/BgDfAxR0A54cYPnftNE05Px8RUDYXenGr
         9Fnv53hIRWkKe41sfJ0loFZAYGvc1wfPwHjwUUHeuKMvG6j3E/RCrtv0A1yQxp+/v9hZ
         s/STJ4wekOd0TbTEcVzPO9f1QNiImEmc9cd+8/0iOkcO8RszzBHUB1IeLqcsguRPys/1
         NunSOgSE+pRG26Ttpbc5qJaMdGX9uwfjg/Y3Ot29KzK243UW5ziTEBOjdm6dpN0Mwban
         MpC7TRGou86CP8CzeaMCTt7L8V7xHhpjhzNBwTxkNPt68tKEyVIBsatK7uQwJTVHXj4I
         77+w==
X-Forwarded-Encrypted: i=1; AJvYcCXfpX2igiZShn9+PXhmovLM2iNYYgWhxv9+g6XS6JLml16zvnnVd248ssAFgRFdbR595jge3jI4UsEHarrlmEd3AsKA6oL7XNsaete/XkUqXUDnGOmL3Z0ySswof+VZ2AJPr0ERqUCeLA==
X-Gm-Message-State: AOJu0Ywb4JR5Tjj3v3Us/r0Zc5ugvAL7WoxL1Vd+riGBk33E0pR7vnYR
	jlciI7JO7r9Kkq5L2NB8F+EoiIecg6vw2HatfY8Wwr3mSlME//mZaogcSyArH/HqzRVTM+ggqKm
	ZmwqBapLOYgwKDnf3JfTd5Qb2Uj0=
X-Google-Smtp-Source: AGHT+IHvl79K6tstzDrDN68qonDbKlQ1IcFQ6PlUtbJxtnwIiOvlNg9vIel8q3/tO1WcfjQuW2IKXfzhYf2oLzvITt8=
X-Received: by 2002:a05:6512:3f03:b0:520:9df8:f245 with SMTP id
 2adb3069b0e04-5220fb7688fmr21340642e87.1.1716033557338; Sat, 18 May 2024
 04:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517083644.3920-1-bavishimithil@gmail.com> <171593784468.974781.7311451940963803133.robh@kernel.org>
In-Reply-To: <171593784468.974781.7311451940963803133.robh@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sat, 18 May 2024 17:29:05 +0530
Message-ID: <CAGzNGRkdD4YEa1PyPfd094D4po9wC8DLHr7u3eeQZu=WETRxCw@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>         'description' is a dependency of '$ref'
>         '/schemas/types.yaml#/definitions/string' does not match '^#/(definitions|\\$defs)/'
>                 hint: A vendor property can have a $ref to a a $defs schema
>         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> Error: Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.example.dts:28.25-26 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
Alright will add desc, otherwise is it good to go?

Regards,
Mithil

