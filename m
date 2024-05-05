Return-Path: <linux-kernel+bounces-168939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20898BBFF7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211201C20992
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DECB65D;
	Sun,  5 May 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUaJVexN"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5A567F;
	Sun,  5 May 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714903200; cv=none; b=tYvjUIJRE7ZH5Z4hY8YT3NofRvrBMLljdHIVhzY6lhFE0v+2sPReFjrKaRPpUO89zQ58iOrUe6J7yz+2oUBPQWmVM1ozCcE1FcSzccBbBUfTS4PqOxup44md3Ws+I5XpIcLZvIOaTDKp+btGPoC3AAv8mnmuQc7lgWzdQn1c2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714903200; c=relaxed/simple;
	bh=WjqcudRZG79zEdBc9lj8LC/nE2+uRAM7JJ+N4z0GaV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5df/o9a2zIRnaLvg0ZNTVAZghF9E55+3F4tKyA44a8GFZz/JEotWFcL13OKk2e9OOeldM5/9F1i/01llSH6AwoGhNyr26uLxV2ha+kGAmC9oZGmWXw3nEAY3EPS3tGFvxtnGVFYMV4LWdU+pSfYihc/9R8ZOK1kuKxNgHEVUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUaJVexN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df83058d48so12119761fa.1;
        Sun, 05 May 2024 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714903197; x=1715507997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnOYLn7A3Dzrt0EMeWWO5zlZhCq8i4H9V/YCQDvuc9U=;
        b=kUaJVexN5oB4NCaHv4s/Tjosl6zvvBBLhiG2D03ikY4Y2EZX8mMn/FG6q1xtR2hTuW
         Y5hRzhJru0QeCu//+Gbf6s3XqtDd3Zh2cOAJycLAibn8Eh/lQ8X9pAA2atwpzMQuktRG
         gm5LpEBQb4KQfUr4cj5UHozZ7sG68kM3P3csvqcyxl0rm9erkwgRDH7yh4//7NUkODez
         cOQyOjJlBIPNBA/ZwN6wlk1hsGdkEmEd6/SRtXnuJk3Dskv/6mhD3EHRQbVsyEOOrz1W
         He/+FRR2HaZrwQTtqDgarOaisEJ9fX7L2gtiIbqvmBAABDoODPR5PbUNNRcIk3r76Pmi
         oM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714903197; x=1715507997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnOYLn7A3Dzrt0EMeWWO5zlZhCq8i4H9V/YCQDvuc9U=;
        b=I/uuULxz8v6J92jEWfKPlHhwpZ6c4j/u7fnoRES9t6phuBTmdI5Q9G0p3wOaipLLIZ
         oWoPRCQJju753ZndNOgBtR6gNlc5bTNA1bBhWPUNzsv6muCszZA+LxgyCprw3Om9UO8I
         /yy6pLRnZ732d0Tb6ekiItPLO3X/CKUH6wqAN6mmLM04XypglQ4m0GiyvmeXxBX8DDeV
         9m1WUpA0eVIpazfee8wALLAvfki/jtC6Lr081HjgrSiB2MPXeorYXQFJ76eVNXOy4gvT
         cck0BG7PWlldlzdA/NG8bD0CvWVRnC+nyeKJQ89Uu8EYU+i12YMngVdsYJs3CgJN+V2V
         zm+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4GxvnRlf9QNy738czH0GHhP1IzE1iDr1RL/LI8yrKSf3zl8Uuc68LrjwUYo74HUFR9Uqc0+NALcX8JRkw31K+Ve/Hh3Gf2CF8No7P8iqnyMn9TI6+EWv1PDtFhhH3tHNnnklXSpyXnf2gbkqmClWonEYDX+ggGmSMZJ/cxa0vmtrwrtbE
X-Gm-Message-State: AOJu0Yw9Plw+kC6812wo/WWe8tKv+jn5rbLTjo1PxCrkuO5u/hfYIvVu
	GE/oZKlGPQ6WjUvAD+V5/GXc76K4tpgKVhXmb0MQ97kesn3D2E7INNB1CGC1rBERhg45kl52gRq
	nHnzsw1p2Rso4B4z4JGuux/PzjY7U6eVNCJ3U+g==
X-Google-Smtp-Source: AGHT+IHYw9oXLwIFgqrXTGRWT0MPYTc23B1WtRMrcOZBCOXwRFrQFAfLrcpHBGbFINGr30T8hYxstm0uO166Fa7dSbk=
X-Received: by 2002:a19:8c50:0:b0:518:8d15:8810 with SMTP id
 i16-20020a198c50000000b005188d158810mr4370888lfj.14.1714903196330; Sun, 05
 May 2024 02:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417134237.23888-1-bavishimithil@gmail.com>
 <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org> <CAGzNGR=pvv67UJtNnkDUMhrpnPjNCCYEGeCaM7e_9=4G+Lcfgw@mail.gmail.com>
 <676ce61c-e850-4046-ad0f-e3382be3fe0c@kernel.org>
In-Reply-To: <676ce61c-e850-4046-ad0f-e3382be3fe0c@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sun, 5 May 2024 15:29:44 +0530
Message-ID: <CAGzNGR=rDrd6LyAC2yB4XUcxn=H1VdY8LQO99NEOBR1sLGGT0Q@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Or platform maintainers or whoever is interested in this hardware.
Aight will do it in the next patch.

> >> Not much improved here. You miss $ref and optionally constraints.
> > Something like this
> >     $ref: /schemas/types.yaml#/definitions/string
> >     enum: [mcpdm]
> > Didnt really understand the "optionally constraints" part.
>
> Sorry, you stripped out *entire* context. No clue what you refer to.
Its regarding the ti,hwmods prop
ti,hwmods:
  description: Name of the hwmod associated to the McPDM, likely "mcpdm"

> >> Missing constraints, so replace it with maxItems: 1
> > Similar to how clock-names are handled?
> >
> >> List the items. I asked to open existing bindings and take a look how it
> >> is there. Existing bindings would show you how we code this part.
> >   clock-names:
> >     items:
> >       - const: pdmclk
> >     minItems: 1
> >     maxItems: 1
> > Something like this?
>
> No. Do you see code like this anywhere? Please only list the items,
> although without context impossible to judge.
>
Quick search on sources gave me
Documentation/devicetree/bindings/usb/dwc2.yaml
which I used as reference for this prop
clock-names:
  description: Must be "pdmclk"

> >
> >> Just one blank line.
> > Removed.
> >
> >> That's wrong address. Old code does not have 0. Please do no change
> >> parts of code without reason. If there is a reason, explain it in the
> >> changelog.
> >>
> > The checks were giving a warning if 0 was not included hence, I'll put
> > the real address if needed then.
> >
> >> Include header and use common defines for flags. Just like all other
> >> recent bindings.
> >>
> > There's no defines for them, this is how it is in the dts :(
>
> It does not matter whether some particular DTS uses values or defines,
> if these are the well known constants. Again, stripping entire context
> and replying after 2-3 weeks does not help me to understand this at all.
> Between these 2-3 weeks I got another 200 patches to review.
>
> Best regards,
> Krzysztof

compatible = "ti,omap4-mcpdm";
reg = <0x40132000 0x7f>, /* MPU private access */
        <0x49032000 0x7f>; /* L3 Interconnect */
interrupts = <0 112 0x4>;
Not really constants as they do change with platforms (omap4 vs 5 for
example) but
So do i just make up the constants for it then? Those just seem like
magic numbers.

Regards,
Mithil

