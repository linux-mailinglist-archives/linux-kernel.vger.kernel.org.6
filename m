Return-Path: <linux-kernel+bounces-364489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E899D542
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414CD1F23F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149441BFE10;
	Mon, 14 Oct 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlWCavob"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16893CF73;
	Mon, 14 Oct 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925591; cv=none; b=mXDVlnA5cy7wxm6WE88oNBGhpLITDCi93beQGN+nUEocIf2+RrtmdWyhr3ZRSh8PLxZNxB1Lfj3+seEGGjs45u9RfUcXZTTlvss246bx+QbgcPDQLkvZkiLVBWiAg0F4a6clJKjKgUZglZND+y6Vfg9xZMHJ46lxqV09O4FPUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925591; c=relaxed/simple;
	bh=/dnktnE3qxcyfDL5/O4PC4+jajYbFDpcdzF8Kx+P3TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWycbuHI8R9aCXIwAUAtm7dyxdJViU9wvGzxp6f/rvolud7+wffDGo078LRZKV+78BfWHakfjyLPbtn3NQti1y/RIvBnCVvcbu8P9zaHKN1MJVe460GpEevgQMAMokcEXFRUk1+D7HBz2jE/CoDEF+3dAc60d0lq4CIeIRMQBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlWCavob; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431286f50e1so25244725e9.0;
        Mon, 14 Oct 2024 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728925588; x=1729530388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmj5wqoQXUBwHs0IOpYFvV74qYSXZb3xJuEp56/YMRI=;
        b=YlWCavobvPqT8eU93633+hLmSOQzMIhiTt/23F2JkMsQ+pnUFP5WkXK363dXWUDYJv
         oM43Bv/Fm1YFJUirejNU39DeCk3LaXdr4NzzKFtVJzhWB7RKzKy4fQWvPuFcla2USR3k
         TLtz5slDgiBotFpIY3un4fcsjh1XMowZole9+dg8JUdVITKVtTrtUtw331CkMHtvoEY9
         kL3OeUmUfevl5SIOK/Q8InfatYUg3DpUNNjcMRaCwuc2bHaQPRGpYCUiv16syg02PVjI
         PsqN1pwzLvPRwK6CusAqSxJDAu3nGRf57Rvrkvhgt8fNcXcUaw4RSdqPU9xZwUnkDhqI
         2cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925588; x=1729530388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rmj5wqoQXUBwHs0IOpYFvV74qYSXZb3xJuEp56/YMRI=;
        b=vJdBLTTydgv9Z7vGAg0gk36+uZxRkAPUnRf/dOveOuIXAt5HVUAM1XuzZuiSHslUzw
         wawN4KPZly0DvLgF5ggvI6C4RUUZ8S0WF5CXHRtiZXp0XkH+HNhnZ0TEAF+MFqJpSbdY
         aHnRrm869e9gp+otFkKcLppsBTBsR+aa6/cgAz0G62Qq9Zc0LYeofmNdRsY48SzJCdJy
         rGCM/m/V5TRxxKVtYIXhGDAjm4+yIOrgO60QgjSg5EZiX/uLIdsryaEzWD/O9N3HETGv
         NaAlUyJ2tfwxpXvDl1FCdZNYCoqracpFbTwNZ2FrtS/lkZtLtc1l+2pIQUly/8HLK0kU
         DUjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpwyM6mixTMxGLnWLYil/YG8FHC3KB7n0gO0/of2rH6CLMcDD44us7z4+miUtMQGoO5qdcwYwQc+nIucCB@vger.kernel.org, AJvYcCWIXQAw47jrTnkKIP3yXaAfmYowfcst13RtG+WF4WBvbfqEA9JYA+Evxw4MEjWH/j3liyuFQTWEGo4p@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUvnCZL/+l18uiLnGSxawn2nHE8tyD66ufB05rE1KGr7FcOCy
	wDTauX/b4cSFfFkhFpKiiODTGfKJR9RKpwW7wDUTelB50KwGhXzwKL5YlNpxPUUPj2XhxEZ0jFh
	wk9Y1GLLJnvRdeqWBfrK/VUIvgXU=
X-Google-Smtp-Source: AGHT+IEnFBWqjIOaGaZbba4zXDyEvBojrp8MCtPj5r2Zz8Cpo7iDNvO9gYkZEdez0FW0jPJ2gr8hJaZxyWKJkHBNtJw=
X-Received: by 2002:adf:b359:0:b0:37d:4c40:699 with SMTP id
 ffacd0b85a97d-37d5ff25593mr8736543f8f.5.1728925588008; Mon, 14 Oct 2024
 10:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014113026.78853-1-cenk.uluisik@googlemail.com> <20241014113026.78853-2-cenk.uluisik@googlemail.com>
In-Reply-To: <20241014113026.78853-2-cenk.uluisik@googlemail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Mon, 14 Oct 2024 12:06:17 -0500
Message-ID: <CALWfF7+DzqYYPZAE4zGMX3jUnbzG+tUEuAJeMQM0_Chn_Vq04w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum
 to Orange Pi 5 entry
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andyshrk@163.com>, 
	Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jing Luo <jing@jing.rocks>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 687823e58c22..62bb6587da8f 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -1051,7 +1051,9 @@ properties:
>
>        - description: Xunlong Orange Pi 5
>          items:
> -          - const: xunlong,orangepi-5
> +          - enum:
> +              - xunlong,orangepi-5
> +              - xunlong,orangepi-5b
>            - const: rockchip,rk3588s

As Krzysztof mentioned in v3. The binding commit should come before
the devicetree commit. You'll want to reorder your commits. Otherwise,
if you git bisect, you can get an error with only the devicetree
updates without the changes to the bindings.

