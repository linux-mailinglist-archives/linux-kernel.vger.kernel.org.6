Return-Path: <linux-kernel+bounces-231744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE202919D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDD1F23590
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE4D53C;
	Thu, 27 Jun 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bik/OV8V"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEECA50;
	Thu, 27 Jun 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454512; cv=none; b=b1pQ2eRZoDdLsnHkKVa3RtNGdbBqQ9ZTJ52gf6SJXK/GTtsBdpG6CUc4CXOhRz1gycN5KuhnjE85y3EjyR8VYsMOsxpTGx4dR+rbGwMQ/jHw3bCYWg6zJxV4wR7LHiTKNWw9jFkxuu3xAHzYivdn63fTH5dcG/bJ8g3XypnWONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454512; c=relaxed/simple;
	bh=it0/8Zz+qHOZNt43zZcQ12BfnWDF1gD5SpFSFNdkaI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgkDVaVJSrEka5lW9+9D7L2M185Fa3p0d7maMC1OowDx56VEzDpvj2Bkwg8sG2xW1A8OsOza+qnEQEUzjN66N6Xq5HVa9A1y310ad9pPbqAtIWnieLZWGDmpTs1CJpwoY2YyS8lwWGMYUwiclzi10Wwjl5ALpuOLycxYF3AD+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bik/OV8V; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-376069031c7so28404225ab.0;
        Wed, 26 Jun 2024 19:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719454510; x=1720059310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuXF7M1aIy1YQUxUnC9JmsA/FUZjc7MkV6Eh2ulEEnE=;
        b=bik/OV8VAYf+hLYwbvZoJ0YMrvrGIPG9MKPkJrskm/nIjXi2nohmGpC44iFOhR26dP
         CpRltJyrmqV788bWErJLZ22PC6UinJiv3dx6r72fM2eRZsn2x+O448RG5Vk6fAsyzUV2
         DKepCqUCbHPiMbVfooBqjyPbQ+HHHcgiLxc6tuAxktDwF1DszDVErFTSjoBFhEJjwBYl
         i/9zZqo71pIZNeDTsBVCLTFHKvrRGjUlFzX1ndWdgtX1Iy4vE9bRBoBKP+a78mgBjzfD
         9bD9JfEH/m8nfuinYw6I59RNjsop1RiluA8Tmfw/T/nm/tw2SyrVUoeophcIl98EPaQI
         r5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719454510; x=1720059310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuXF7M1aIy1YQUxUnC9JmsA/FUZjc7MkV6Eh2ulEEnE=;
        b=V3va6FBNtq3w5ePH+Kb7ksiG6WUd47L25jqjNLpvrY3/Vvv/Xfp+OG8a/xqeEeKP8N
         abVsYrdsTO/rcm61cwp+zwNR8tj/Aq3idZaGqK+w7/BjIqdnqbHSFHbeILtroiQp7eBR
         95dFzHbPRAOsqqnKj5bvdjb5HMIYBvvWhwVKQZq5KiJltbAhTeRrwFFggbJRZSFD8CxP
         SdqnuyzlZLKzH8cyoE6Ca6yAglZ+6eadiMvO02LjztLzxqKJ60r1w6D44/r9dmdWHXDj
         dtb5TF/LWCZiQKmifdeZom7wqf9Kuc9w7mcf78iYoRcewCyuqiMi6QhUuUx/4SvIkmdL
         Tizg==
X-Forwarded-Encrypted: i=1; AJvYcCW1vlOHHClrXCVZF+azci8sAj27/RmbUlOb1byP0hofJ1YiNl8GKCNc68YOZ8vOBXDpe7iEXJkzM+Tazc6+1+XjegqZCrEmj8pSX3Dbv5eL0LvyEuok+spyQvnvGYw3OwA7KgjcFg9PC9Bz3o0gEda5kfKKw0Z1g9JRSnUtZckW8nbMGaqe
X-Gm-Message-State: AOJu0YyDfKruBA4r+GB/A1t/MBNQCjyv6v0v+mHr1U/lF+cvnkBWDwH8
	HwuG5nbeQHMYJLsofBKazVg1Wm65utIpHSiLIcdELJ/p3kywkh88uSI/qWzP9GWGuCRh4m9tVeQ
	4ay20V9HErl4uCvljUIK+VZO9Ih4tIg==
X-Google-Smtp-Source: AGHT+IGOzhKPL9eKGJjIhALK4BPHJBjQ60D8IYPD6gShN5cqmADVfO7MTE9p9CDoxXv2wAYMp4daMjVAPSQagAWhwTE=
X-Received: by 2002:a05:6e02:1a68:b0:377:14b2:71ad with SMTP id
 e9e14a558f8ab-37714b27360mr80377005ab.13.1719454510190; Wed, 26 Jun 2024
 19:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
 <1719291415-1168-2-git-send-email-shengjiu.wang@nxp.com> <293fb3d5-9b77-4321-8b31-d060cf96565d@kernel.org>
 <CAA+D8AMQv_=X3hC5uQbrDBN0EGo3U6EToGFVjUYcOVHpf5b=aQ@mail.gmail.com>
 <549edfff-24a5-403f-b35e-8929cc14c81f@kernel.org> <d7117060-734a-4f8b-bb05-a9a9473a53d1@kernel.org>
In-Reply-To: <d7117060-734a-4f8b-bb05-a9a9473a53d1@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 27 Jun 2024 10:14:59 +0800
Message-ID: <CAA+D8AMnevQCLfExKUk2bo2wfCHjn8Bp9cVuRaDsW_Zt4aK+fA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 26/06/2024 11:34, Krzysztof Kozlowski wrote:
> >>>>      items:
> >>>>        - description: WAKEUPMIX Audio XCVR Interrupt 1
> >>>>        - description: WAKEUPMIX Audio XCVR Interrupt 2
> >>>> +      - description: SPDIF wakeup interrupt from PHY
> >>>>      minItems: 1
> >>>>
> >>>>    clocks:
> >>>> @@ -88,6 +89,7 @@ required:
> >>>>    - dma-names
> >>>>
> >>>>  allOf:
> >>>> +  - $ref: dai-common.yaml#
> >>>>    - if:
> >>>>        properties:
> >>>>          compatible:
> >>>> @@ -112,7 +114,7 @@ allOf:
> >>>>      else:
> >>>>        properties:
> >>>>          interrupts:
> >>>> -          maxItems: 1
> >>>> +          maxItems: 3
> >>>
> >>> I have doubts this was tested. The existing example should fail,
> >>> although I did not see any reports. Not sure why.
> >>
> >> it is tested, because the minItems is 1. so the example can pass
> >>
> >
> > That's a very unexpected change in dtschema. It indeed passes, but is
> > not correct. Why interrupts are flexible? This should be constrained.
> > Let's wait for Rob's confirmation that this is not a bug in dtschema.
>
> Yep we need here minItems as well, so this is strictly constrained or
> please explain why this should be flexible.
>
Ok, will add minitems:3 here, and update example.

Best regards
Shengjiu Wang
>
> Best regards,
> Krzysztof
>

