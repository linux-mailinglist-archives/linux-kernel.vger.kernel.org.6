Return-Path: <linux-kernel+bounces-349203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A998F272
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB531C21986
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4ED1A08AB;
	Thu,  3 Oct 2024 15:22:12 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5F4779F;
	Thu,  3 Oct 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968931; cv=none; b=PR49fzODC9qNMAoFju20sPcXjeD+W43lHmTEcgYhpg9q8RY66gzfK+Nof6+o0rY9YoIpc9ysBAOL7IerONtSJkTjKfeUQLL5VV1+GzuBes+5ULeq8czCtGcv6NPUHkLsrhXz1plkgWbk4Wb2JX1Db7/KJmDpjHHJPDQwyxcUztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968931; c=relaxed/simple;
	bh=ykGMWjUKIDhhhzJrM9GpYwxSH8y2AXPqMcCTCatD3zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw4/UbjOrKieaCX4WP+5xcu0s6qMlEJmils1wROgqE1PZlYdmtVIZZw8nJobhbPnAvk2bJNT97f5FAGjA5HZtLfdM4aA3PAm0L0OVx8XMnbxZCLOqZvXF15uSKKEgVud8xJEHfmD38k4FwvpKPpRGNLd4u80MZ47sgp5tFTwdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82aac438539so46782339f.1;
        Thu, 03 Oct 2024 08:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968926; x=1728573726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4LKO0jgH7DyX+MQ6doJC00PWEp4e1Pim8oJtlmMS+s=;
        b=kPN1Hf3+nGy1X1OoNzjtLbDGRXNBHpM+5K/7xScq4kpJmbvXIahoaytpJmxaeMY9Is
         F0K3ILBcBJPDix4Cjib2KVoSEU3HezOcNsXMvUq6gDYFSNbeEoE+V2ELl5yrT+dWHs79
         YQXDsAXRi3GPaNHUxQNjteSQyeKHzzYFmeweWuHBXxLP9LhRU81lISjW2RdtX4/WLLdC
         7KviXJrgDk8iO4qD3Z1jkfX+HYK32kw4yCsWMOQ+vgbQ6umvNglxf/Mc52O0FcMqvYNz
         HdX2vfRbmgDeKqjnmgYzWA3XK8ltWumUIwllS4C6xnwsUlkV0diDaBJjF6V5K9cKQz7S
         jxYA==
X-Forwarded-Encrypted: i=1; AJvYcCU4bypI69Kjtl/XTjb+56SXF5CeU605uX5jxdd9bexiLWrgQIepbI5imcx7oWi+1wyp08b22d9oqzJk@vger.kernel.org, AJvYcCWU2/Tl3la9k6Nl9uwESRnrDItUShVfKuzBUNIoxs1lTF/lYlAsYIdM25r7VRqNZODrKmUOE9KKes4glc7U@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNQe19I0WZZNTs6cK5e990X4Sakih1huUiRbhz9WNf5mkUdQh
	trWC7c5rkYcJZJsGWLcrOhAB/cdcCr0Z7dp+TcjB2hZaDZzMwhxO8uSr8stvytY=
X-Google-Smtp-Source: AGHT+IG7UHCB5lSUQEIn8j8MT3InMhzfwC9MujIcd3nscEIpIduYkrWFkOeEu5S4hV7RckdeytWqQg==
X-Received: by 2002:a05:6602:3f93:b0:82c:eb15:1ab1 with SMTP id ca18e2360f4ac-834d8435d7dmr586683139f.5.1727968925565;
        Thu, 03 Oct 2024 08:22:05 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe376aesm29565039f.46.2024.10.03.08.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:22:05 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa7c3b482so43577739f.2;
        Thu, 03 Oct 2024 08:22:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr2U9mu8xemFu/+6aDTGMHZMMqxORtt8d0sixuK9a10WoMoyy2s71+TjR4FYQDucS40d6latDGcblrj2dX@vger.kernel.org, AJvYcCVrqURXKGhY9iUesr0CFFhlCyfvYacDoB4+miNbO1c5j+O6HC2UD5hgcxrufMRRJyAK6VywkzgksRaU@vger.kernel.org
X-Received: by 2002:a05:6602:29c4:b0:82c:ed3d:3a59 with SMTP id
 ca18e2360f4ac-834d84ba9fcmr818278039f.10.1727968924668; Thu, 03 Oct 2024
 08:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003111444.543964-1-andre.przywara@arm.com> <20241003111444.543964-6-andre.przywara@arm.com>
In-Reply-To: <20241003111444.543964-6-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Oct 2024 23:21:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v64OYNUsfCAUnh2QEYec-AHWyugG+sXBc3XRCz3jtUrDmg@mail.gmail.com>
Message-ID: <CAGb2v64OYNUsfCAUnh2QEYec-AHWyugG+sXBc3XRCz3jtUrDmg@mail.gmail.com>
Subject: Re: [PATCH 5/5] regulator: axp20x: add support for the AXP323
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Martin Botka <martin.botka@somainline.org>, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> The X-Powers AXP323 is a very close sibling of the AXP313A. The only
> difference seems to be the ability to dual-phase the first two DC/DC
> converters.
>
> Place the new AXP323 ID next to the existing AXP313A checks, to let
> them share most code.
> The only difference is the poly-phase detection code, which gets
> extended to check the respective bit in a newly used register.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


> ---
>  drivers/regulator/axp20x-regulator.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index 3ba76dbd0fb9..e3cc59b82ea6 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -1341,6 +1341,7 @@ static int axp20x_set_dcdc_freq(struct platform_dev=
ice *pdev, u32 dcdcfreq)
>                 step =3D 150;
>                 break;
>         case AXP313A_ID:
> +       case AXP323_ID:
>         case AXP717_ID:
>         case AXP15060_ID:
>                 /* The DCDC PWM frequency seems to be fixed to 3 MHz. */
> @@ -1527,6 +1528,15 @@ static bool axp20x_is_polyphase_slave(struct axp20=
x_dev *axp20x, int id)
>                 }
>                 break;
>
> +       case AXP323_ID:
> +               regmap_read(axp20x->regmap, AXP323_DCDC_MODE_CTRL2, &reg)=
;
> +
> +               switch (id) {
> +               case AXP313A_DCDC2:
> +                       return !!(reg & BIT(1));
> +               }
> +               break;
> +
>         default:
>                 return false;
>         }
> @@ -1565,6 +1575,7 @@ static int axp20x_regulator_probe(struct platform_d=
evice *pdev)
>                                                   "x-powers,drive-vbus-en=
");
>                 break;
>         case AXP313A_ID:
> +       case AXP323_ID:
>                 regulators =3D axp313a_regulators;
>                 nregulators =3D AXP313A_REG_ID_MAX;
>                 break;
> --
> 2.25.1
>

