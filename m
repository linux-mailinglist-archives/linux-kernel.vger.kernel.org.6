Return-Path: <linux-kernel+bounces-217280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07E90ADBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BC1C23224
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39148195389;
	Mon, 17 Jun 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwNnwxhe"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F93194C82;
	Mon, 17 Jun 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626468; cv=none; b=avwdEWP1CM55SynNIv/znW3VkHSjaJOe0i56cBozVyhuqy7GJdAbSkrmApyVn6eDKs2gbZBnYboQdGEpG+blj4KjbezKgU1+OgVraxMaRTJX/7s8Ubu+vCjeWqIUGmDchbuRXs/SfhqsVEKTnQQaJC/5T+UwyN6UuIc0fZ71Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626468; c=relaxed/simple;
	bh=4bAAmOpl6FKwhAImZc9MoVAil/T3Q4eKQpJqKDPSXz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/FgHuj2ZmbhOcrIJGwd3rQPrh26qD4T0H2YXxq+ddgwfWvjSD33j4NV8zovuuQuE9c7ixgTOGxSUM1svFCwaekmoTyqzvezAHVpkPuu2MWUukvdR9MmWk4+GVKzAzDuvhk+KErJKEILZq4MAMHg9jeWyA4YCorLGRjSSY6CLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwNnwxhe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso563227266b.2;
        Mon, 17 Jun 2024 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718626465; x=1719231265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bAAmOpl6FKwhAImZc9MoVAil/T3Q4eKQpJqKDPSXz0=;
        b=TwNnwxheByrHm4rklP55w8tbFpebp8EemjIKuCp/iROJSnvlrguyzAUVxGL+1gq4XJ
         IaPiusOEZVfZdSDU/Axi292M8HvUZW7oe5K+KxfewpSPMQwSYxFFGJiX8lS73ZdOBsR0
         cq6HGv2KVIwuOmdWW1pshjELNcroPeCkSgDXFOm9eKc4/gaEt8LX4BZfASTSAP+ioj5P
         0HSzdO1N3COJ6F86078riGDgwGjTWsMPSkcea02ieiN/6gyW+ULpXOkywBP/F08kXs4V
         hGnCvFnc1V7h3hTGiwZgQ9uomTD2slkJnctb+3wSJooVIolBOyMjHpOxaQIkSBoU8ZS5
         CpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718626465; x=1719231265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bAAmOpl6FKwhAImZc9MoVAil/T3Q4eKQpJqKDPSXz0=;
        b=krJyBSAtwE1dltcpyaQUSfKxVnpVNb5WCAzPmoBF/GSUoC5bQqB1xuoexgjI9eSEfC
         frxQ7l0X+6uYmVPrz3omCp5NEuLWailoL4UhcRuxMRozTwhPN/Y5fxq9gLriiEpzo9DP
         sJ/SS4Kw/RFg6pwf/HCn9BR7w8YLClSrpNJ9xoql+WGyqPY7DVrUeH7RM+KRGtrcfyAA
         o4qTPJ+QpAVzSM+JBB26GPaE3m+tDTa407vyu32Y+I1To7wZPpFWICnhgD0b9A7ClY2F
         xOHJnm5p0f+Hf9SwSzrCc7xvg3teaV9BkXBbwqt2TWhgf5o0eC6/kZHwA9maVAo9LutV
         K8QA==
X-Forwarded-Encrypted: i=1; AJvYcCVyJMS5lKYFzpo/gm9a/6+sqSJLcLUylQSAtJgeyyNlcPl+9Vp8CJrKOd+JKv6twfXP3XD8ePLZDgIllvJWKqhz0s+7HyAkfmMTUjswMbZoWMLc2SMj+NJ0qWxAkH8i8L0cqUKLbgr1pMEu/NVt/fa77pB31n+I8zvqOBQwMMl4kcFv2I0Q
X-Gm-Message-State: AOJu0YzAa8Sn61emNBTB9+JCOLLza1J7fAbb5jUMLw6rcKQqlAvto7Ww
	9iUIMR4jzsO0r1oZEKfq1gk7ZlCeKUIqYEQ3f9WF3sYI2Z7XRkAbvmbP5KkCn/RUH5J83zRZcN/
	a+wrPExWk/8D0z3BmmTa70kYHMfo8OBVT
X-Google-Smtp-Source: AGHT+IEXqa/5TA1IoPPweCwAqdFJZXWW4kSILJRkB4PFMtqcZm1jzzatXPtjR6JaXBAoXVqSKTfL4W1PPt9K/SXZZsE=
X-Received: by 2002:a17:906:810:b0:a6f:55e8:b361 with SMTP id
 a640c23a62f3a-a6f60d402c8mr586958666b.41.1718626464877; Mon, 17 Jun 2024
 05:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614033812.51312-1-animeshagarwal28@gmail.com>
 <b214c9db-fd82-4d5f-9cc2-96857da1bef5@kernel.org> <CAEnQRZBPv+OAmNBHe8fWziw8zJKFkH8vd-oe_G-e3OVSX_sTRQ@mail.gmail.com>
 <316c0751-17dd-4fc8-b424-bc8e875aaf83@kernel.org>
In-Reply-To: <316c0751-17dd-4fc8-b424-bc8e875aaf83@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 17 Jun 2024 15:14:13 +0300
Message-ID: <CAEnQRZDu34eq2JQTjMGhWj1THOQ9XFOxRAVN__2ATHY5eq36QQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ASoC: dt-bindings: Convert realtek CODEC bindings to
 DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/06/2024 13:18, Daniel Baluta wrote:
> > On Fri, Jun 14, 2024 at 11:32=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On 14/06/2024 05:38, Animesh Agarwal wrote:
> >>> Hey all,
> >>> This patch series converts two of the thirteen realtek audio codec
> >>> bindings which are still in txt format to DT schema. I have chosen
> >>> these bindings as they have in tree DTS files.
> >>
> >> ... and the point of DTS is?
> >>
> >> To validate the DTS against bindings and see if they match.
> >>
> >> You received such feedback already.
> >
> > Hi Krzysztof,
> >
> > I'm afraid I don't understand your comment here.
> >
> > Animesh is saying that we are now looking only on bindings that are
> > actually used in the dts files.
>
> Yes and then one should compare the DTS with the binding, because old
> bindings are often incomplete.


Got it. Means that if DTS has more properties or so we should document them
in the yaml file.

One thing is that the bindings/properties should have never been added
in the dts
without documenting them, but that's another story.

OK, thanks for clarifications we will follow this advice.

