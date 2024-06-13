Return-Path: <linux-kernel+bounces-213599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28439907770
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8241C243A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295BC130A66;
	Thu, 13 Jun 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW0y9V7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FF1420BC;
	Thu, 13 Jun 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293507; cv=none; b=VYvV+jz/D1p7XTGHqYOvN9qpN06WTcP93+Zm24d8/gkna3j6ORrN1bfGhuNAGj6rRtjwSIkS4q2n1jnsBpQlNN7dShobwF2UtOPF6AxVm+eFFXP3+cwP7GJ6hc8cJwiW6kL6hYoSA3kfJsKR5a1SLyRzq7YluD9QfdpURo+QiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293507; c=relaxed/simple;
	bh=U9qVg6ZJBN28D55q6SGvvtPai72j88kMw2EojUSMvos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKLMosuf0zV6FbGSKFvZikCv4eoN6tpRSjgU8C/uFBbpAxRLaMUh008OISe41ehP12YquTeHj8wM48Pyy/MNY3/f8M5JJgu/TIL5MXdqCagEkb9Qilhb0cL/ubsfxU+cOqWAx5QbwUwpUILchHhUXE/IMDiaC+r5vlcjwnLjLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW0y9V7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01906C2BBFC;
	Thu, 13 Jun 2024 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293507;
	bh=U9qVg6ZJBN28D55q6SGvvtPai72j88kMw2EojUSMvos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oW0y9V7o7Azoq2ZB8VEw9X7r6Ey19nTFYpIVHHMFMEavxl91nqPVygekzKS0SvMeK
	 cIS9k5qgYTcJiNLOP5qb//D71iauKi+iBkhEcL2v3g+eD4jLw8Ncnwxoz+Hs2K8TZ3
	 N4+VQ7BNZ8W5yoW3wcRC/Kobzj3qrHJ3WPS5CcpAVKoj/Ato+icnuGguSoKAaIc8ZB
	 e+877fpodufMAyHE5WNBlpRNhvUuOZiKDhWF93cEkDB+dA0//vj/IsmBInR/UCerxA
	 9jTaXPbamtIbmJLNx6wAPpI41RXt7h37lOf6L1k2GDtAiWDadssrKAjsLEkpkvcS5q
	 /FTjYblUjkKTg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so1516419e87.3;
        Thu, 13 Jun 2024 08:45:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYYRKHC4YCLJVa1UWrdO2beovQtuk/sF0SdjJ8Fn+lWwIfiUzJz5RPlRNfwrSwL/YTdf3Ej6RoaOHoYgIC3V96iaczBJqyRFz2HVclg0o6QjMoRM49ZQ0ogqDyIRffaVXIKAiqhX2Tdw==
X-Gm-Message-State: AOJu0YyRubk+4Ei99cvxUDA9fhyFioveZE9EaHGvnrHEzNzj8BWwkrJ1
	wl5+ij2i8JlAWwUOySlNSqqWRBJx3UgYmxKsL4KU9wx2NRkS3CZopZXNCodjZ3e4T/0b81f4J7i
	I60ock/9ez0NPOrYRSK5GMIr4fQ==
X-Google-Smtp-Source: AGHT+IEDZenob3DLme+dvcEfaG2iU+9qiwaD7cyt2kVksiFNPxI8W5qjeSbPsJJAsGJkPEmpdJ7KOcELGumm7mO8hFg=
X-Received: by 2002:a05:6512:3b89:b0:52c:80bc:9dae with SMTP id
 2adb3069b0e04-52ca6e55affmr139085e87.9.1718293505351; Thu, 13 Jun 2024
 08:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613150134.66329-1-gychoi.dev@gmail.com>
In-Reply-To: <20240613150134.66329-1-gychoi.dev@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Jun 2024 09:44:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UQ+Epe=_UyR-nkTWsbT6Q9HeEqX6__9nb+Uv1vzZCmA@mail.gmail.com>
Message-ID: <CAL_Jsq+UQ+Epe=_UyR-nkTWsbT6Q9HeEqX6__9nb+Uv1vzZCmA@mail.gmail.com>
Subject: Re: [PATCH] drivers:of: Add null check for bus in of_match_bus
To: Gyeonggeon Choi <gychoi.dev@gmail.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:02=E2=80=AFAM Gyeonggeon Choi <gychoi.dev@gmail.c=
om> wrote:
>
> Added a null check for the bus variable after calling of_match_bus.
> This prevents potential null pointer dereference errors in subsequent
> code, where bus->count_cells could cause a crash if bus is NULL.

Go read of_match_bus(). It never returns NULL and if somehow it did,
we'll BUG() first.

>
> Signed-off-by: Gyeonggeon Choi <gychoi.dev@gmail.com>
> ---
>  drivers/of/address.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index d669ce25b5f9..85f986d25870 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -504,6 +504,8 @@ static u64 __of_translate_address(struct device_node =
*node,
>         if (parent =3D=3D NULL)
>                 return OF_BAD_ADDR;
>         bus =3D of_match_bus(parent);
> +       if (bus =3D=3D NULL)
> +               return OF_BAD_ADDR;
>
>         /* Count address cells & copy address locally */
>         bus->count_cells(dev, &na, &ns);
> --
> 2.39.3 (Apple Git-146)
>

