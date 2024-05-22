Return-Path: <linux-kernel+bounces-186299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B78CC260
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02361F2489A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26F13E3F4;
	Wed, 22 May 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgGc5zFS"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71D17FE;
	Wed, 22 May 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385593; cv=none; b=YpvgpPDdB5atIAqhkFECyWInZ30vR4dmX6EkeJMzbYN4DTe/V+lrhroDrC/PnpRvvFPXEdALkwYO2K1t4uaeRO8QXb6xlLRe687UwyEMqVJ+Ij1mafrf7RyHZv3IBrPT27LPQNS6FCa9bq3v5CwaJQBZcZMswJg03+IWBx6xdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385593; c=relaxed/simple;
	bh=KW3QPfT+M+XDHqovS5XZajSpndhxlzoh3ai0wU2VZKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHAcsvpP9a0hVME+Zm/4UYw5wvFmZNSoOJqfRduHIXmcVxQYlc6X34gJM+SeBLicKa3ONNO2vFbIh/g0glP/gJ1doUunvj27izDOActwWRT4J4rqBXUB0ZK5JQg4zXYN26/2GIOAdGDwzVpack707kdWcxBirkcNIaTl31v3J/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgGc5zFS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f72a29f13so6860095e87.3;
        Wed, 22 May 2024 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716385590; x=1716990390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9C9NNXV0hMStFuJ4aZTCnVgpwlU5ODPSnfkybc4i+0=;
        b=mgGc5zFSs8OlijborUBznbb+YqbuW6RKUg/koDl+MCb4rx1NFqDcni6UC3K6G+YNBZ
         T/7W04cHkqqpMywoJr72sImk/hsTX5u0beeBH/Hz9BoidMgvc3+dZDj6jQGz1RruAqwq
         wkmVFVzn9iTOctwJ4oaYjfwpKzNnMjXhOVcP0o7oS+IM6JDk03s2RxP2gI+H3of6f27C
         Gp9ta7zaeADYiYRbxFJgLsPS4NRQM8hC+1PtJYRT+hj8Cq5YacyVQcKyPAWceHz0Dib6
         9xmpZHW7DhvtKB5U49fFP1s9qDWpJOyrYM4DfNh0laCe5Asd1NIBDKWoSV/QzYKwJeGu
         rLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716385590; x=1716990390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9C9NNXV0hMStFuJ4aZTCnVgpwlU5ODPSnfkybc4i+0=;
        b=K4gpRSN9WenL1bqDY9m/CKz6pi3km/R2uJuPnoUtlXearHU7kyuTuV/NnZt2QjNtvf
         4MsnW94DjGI/z4Bx0mnRWeuUV8huRRdkRESq7/eAoGNDGBEybdXIhqIM8AnoH0Lg5Z3d
         HTNPsa74p1dsjZk9JrqCaC7QayrC8ndis78Gi2ALriik6bD2f26z9T4st9s0LMoiAHSL
         0f+e5gzlRNFmElUEsvE7upnbMlEkhnCXxkmQcUwyBIj7Je7WYTPVA4yL6na/Fv3axphR
         yBhs+ncyTmcmA+NGy72PLwOvxUi1keGCBTibzYopa3LpyuW21xgbWideW49O+8UaYyyY
         eR9A==
X-Forwarded-Encrypted: i=1; AJvYcCW8E4pZNJ1Qimjy3EPkLH4eO3YaUz9Yopsbe+dDNUjqF1jAgfTUlriCwkFFVDuRc1Av6tk9HMze/oQ4OxGjrTVSyHM7n38+WWDyd3CpKu27JWj4HGeC68TqTDkGiXk937H/vk/P2dht0Yt+3+1cD6Arssy3v1Rx96b+r1K4nwSgSdXOsxOs
X-Gm-Message-State: AOJu0YxCcwNdVhRnGbz5MYQr3iFb9xYrbCywYwjIPrypV21S5sDsnOTx
	CMmt/7VBYOIiqRSAy7pnb0iDpMnFQAxIc8IOBpPTJ63F8dpri7y7WTJOnVoHlMRch2fDt7iEfmS
	JUfljpfnia2PlOCxvFKoZdwE6YNk=
X-Google-Smtp-Source: AGHT+IFT8wdjiOr1ByviMTeNutSbBh2TWjvOqDLA+wRm0Yd+/UX1gIx+CIQ7K81c2njy28EbqgM2iXZIF1Q3//SVIcY=
X-Received: by 2002:ac2:520a:0:b0:51c:1cdb:566f with SMTP id
 2adb3069b0e04-526bd0d1b79mr1551550e87.11.1716385590122; Wed, 22 May 2024
 06:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522075245.388-1-bavishimithil@gmail.com> <bcc9999d-b912-417a-8ae8-f4e252d1bd8b@kernel.org>
In-Reply-To: <bcc9999d-b912-417a-8ae8-f4e252d1bd8b@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Wed, 22 May 2024 19:16:17 +0530
Message-ID: <CAGzNGRkc5NJbJpZuUir7dv-C3A=6p_kxp56zrVp6N8+DviPkig@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> You are not making it easier for us to review:
> ====
> b4 diff '<20240522075245.388-1-bavishimithil@gmail.com>'
> Grabbing thread from
> lore.kernel.org/all/20240522075245.388-1-bavishimithil@gmail.com/t.mbox.gz
> Checking for older revisions
> Grabbing search results from lore.kernel.org
>   Added from v4: 2 patches
> ---
> Analyzing 15 messages in the thread
> WARNING: duplicate messages found at index 1
>    Subject 1: ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
>    Subject 2: ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
>   2 is not a reply... assume additional patch
> Preparing fake-am for v4: ASoC: dt-bindings: omap-mcpdm: Convert to DT
> schema
> ERROR: Could not fake-am version v4
> ---
> Could not create fake-am range for lower series v4
>
> ====
>
Hey, sorry about it, its my first time with lkml, could you explain
what seems to be the issue here?


-- 
Best Regards,
Mithil

