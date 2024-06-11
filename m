Return-Path: <linux-kernel+bounces-209916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B4903CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1BEB242B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B7117D883;
	Tue, 11 Jun 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIc0qDhp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA917D378
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111656; cv=none; b=DAvKYJ9L55v8d68mdb6WdUOBSwqmnne8e109IdfJWDZ1YwfMf+elhmFyjjm1d2lHwFTRmcFaVuioUH4l3LZgBtLscDt0oT4wu8tJBE05VhzvRAg0rY22UZ/AKwaUrq4fgPM5tVtXqvg2D0JCm1X7ROzWdcTz7TEvMBII6nz7j3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111656; c=relaxed/simple;
	bh=S6N9yC288X6gryfChW2ktbFCp196YoFEzJpWyYA5Nyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyPpG8pFBxRC+gGJqXuSPb4eAYp6cXTNYB7+SV3DBdOEXrmFOjbfrN04CVra5fpWIeCSD/deRUUxv0oSzcjc566wpNRgkQU+PEm4GsqcZ0OUQxo3DNDjBJi1V711eeBZHn0hTjvE6FsRj+jIeXdlIQZutdzwyXUkPyE9jkttTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RIc0qDhp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c7fbad011so3538180e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718111652; x=1718716452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV5K0Ro3eY4f2QViP69c0fhla1OvAvhf/tnKE0VUbIg=;
        b=RIc0qDhpnHtKZQP9/OLQwYa6G3ehQCNbQLTMyBJrKHprTgFu5wLy/GYsawk5hc8J0p
         a+YNGcNnm818eFB0IyJxelf5lInYbnFm+4oJe4JYiJbBzUyfCQdbInMKKIF4CGrfKiuY
         JNoos/5b9H9udKNp55VxyJYir3b48b9DQwNeu3l0jCYtGEtoKc0V/92Su/WFgAgr2T8Q
         wXxyhdq+Z3uaWqUYceQjXLkb8GRNXWLczVsE+yYx7jCAZQaDFKnlBZYZHG0aIW90D6Rz
         WlpXg4M6J2Ju8FbZGwVkD3QW1bBkqG+WsrJb7UoDdPXl4kPybYg4W7V+gQu3XDG+YlyS
         vK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111652; x=1718716452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV5K0Ro3eY4f2QViP69c0fhla1OvAvhf/tnKE0VUbIg=;
        b=TGHKefF5f2Y3xgAq4S5fsRz593ilWqfLWNQUXmdt3RR/QqHn4SR2kTLvRZGSd4wTtg
         Qn2CUVxxea8YRpYoK8qSFQaeGpO1E83j4LcCH4akMd4T74CvEOufTR6OiThEk/ps+XG3
         PDgq5dlBiVsMeP61qdeZWikDFUN0k9MHWDyZ44Puc1aRF7vpTHz8bwV43uirFE40VE3B
         ZO3mHOdCTgEQSabR8/9ly9ur2RqexynXGRsZfwqvvWdtfjSHIlAObPYuEg4TviUPGo5i
         gNRkcBIt0IksPzBnt2iCB9SpJko92LkduDvLiUXWXGSUdqtjLKbgVRaF2GWYvgIb/AG/
         9wbw==
X-Forwarded-Encrypted: i=1; AJvYcCWk69yzOs0taDk+3wDUQy7713UeMeR2+kyn9LE1sWKOgN5J7ay3vhOZq7Ob5Jdc1gV0d+85l/JJknRpBfvTjqMD4YXs/6eJjBeC3b0K
X-Gm-Message-State: AOJu0YxDx5DenMz82jZ9w5ga/cVEITlPBoKOUS4rtKa4TQA8phbxbure
	NeL8kDreDdDCveWir1WoXDkgT03S4fxzd5eicgmF+gGRy8TqXljtZasoX0LRIHIh9TbjQIV/LAy
	HUZNGGDsyvz9Uw7SDu2PYxiTEDjFgWs3bwE2YgQ==
X-Google-Smtp-Source: AGHT+IF2Jwr6mle3VYNit5lXohZkzWkv9DlMg9O9TILeDdaKuQee+IU2Jv/y1ncE9tDVgUoKH69MUibYVhklRfOIPqo=
X-Received: by 2002:a05:6512:693:b0:52c:85aa:a597 with SMTP id
 2adb3069b0e04-52c85aaa64amr4870009e87.36.1718111652171; Tue, 11 Jun 2024
 06:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611113204.3004-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240611113204.3004-1-paul.barker.ct@bp.renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Jun 2024 15:14:00 +0200
Message-ID: <CACRpkda9q53s95K5egjvDii1VsEc2E=bJxbeij56RFZ5=cS4uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Configure GbEth for RGMII on RZ/G2L family
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:32=E2=80=AFPM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:

> For devices in the RZ/G2L family, we have so far relied on U-Boot
> correctly configuring the Ethernet interfaces in RGMII mode with
> PVDD=3D1.8V before the kernel is booted. Instead, the required
> configuration should be described in the device tree and activated
> within the pinctrl driver.
>
> Changes v1-v2:
>   * Rebased on next-20240611.
>   * Changed the approach taken in the pinctrl patches to be compatible
>     with changes made by Prabhakar for RZ/V2H support. I haven't picked
>     up Reviewed-by tags on these patches as they've changed a lot.
>   * Clarified that patch 6/9 also affects RZ/Five.
>   * No major changes to the dts patches so I've picked up Geert's
>     Reviewed-by tags for these.

LGTM
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I expect Geert to pick up the patches and send me a pull request when
he's pleased with this.

Yours,
Linus Walleij

