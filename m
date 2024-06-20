Return-Path: <linux-kernel+bounces-222074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE1390FC83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231DC1C213EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E23987D;
	Thu, 20 Jun 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD0q0WJx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714311CA1;
	Thu, 20 Jun 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863720; cv=none; b=HrPn4Fud+YCYXkfH/3/Un9oW7QoiEJeph5onLJq/Uv3AGn4PttN74AguboINRoIkLXMjri4iZHjyRujgAvf/rM9vYLGvYJQRfLycbHWPcc2Vo6sU1b0MqaOsQRYQ315nkTi6j3E1UKlrSks/fF3lpaVYbUM3bBUV05dypSmGKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863720; c=relaxed/simple;
	bh=Rc+VirWrROEbeTv+kJ3nKd+Djh4oCtQsSZQlfekJW6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZTiO6XD1+d8wGCkIyJELTgNB55ZYkgNbfgoP1dRq1ie7x43ZmRpYjgKI1SAn41IEMz4EKC3bOGVqi0W/IV+iBjLXWIFyAjlUjsehqFG0Yqye19V1HK9kl/FuBMRsrrgfwWZtMAPZCwHpkx/E0C5Vfy0NnMIlUL34LkFJq7ps8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD0q0WJx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f0e153eddso60135566b.0;
        Wed, 19 Jun 2024 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718863717; x=1719468517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeiXGWZQ/Zr88W+0NRIB8FKWoLlz1ugYTG4uxICqU+U=;
        b=YD0q0WJxbX/IUcZd21+zYrn3l0IXNOgF8n9qrnYIW4i01l71XCJxcZaju9/NSVJce4
         V8ydyAdJnuU6yYmaWfHX1xGJ+mT0uSBTZtCYlJyzZgv16cKJfdCNUl0Fn+J3T9mKqEfp
         scJd+VSJgmEJmLm+fx9G87tUyq/6WaV5c0tSUsmTXvJrBclzrQ9wTbpyGzWrbdlSmhD7
         absEH4TsMoToIzXRuNK86sMQYPSeZXGYjcMAnkbnmilg5Wh6Iyt7nLAxGOp3ib+7FKih
         TPziCU4YsjrJw8f0jmK4Lg+1cQB3WHu1paqIXLRZa+rgThp4qqhBzKpKkdogZC7JnA+y
         FYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863717; x=1719468517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeiXGWZQ/Zr88W+0NRIB8FKWoLlz1ugYTG4uxICqU+U=;
        b=MvogWvw+XiFjbnuADLWxEhDCUV3r+WXjB/J19pIqNviVwyP+XFThbQSfTvrJEBSLMN
         /2TQ92h91Sgl8h8vvRRvrUntG1EjifrXFKRcXWb39yjVhGn6qysP5VS3Za4pUQ/aFkId
         VATen4NSnLsyzL75yTF1PLLYxXVo5OKtf1w3GQpgbd/2Kzj73zzBKGU6c77D82ASuGBm
         Pwk1tnsAEdeQqdBYt/8Xw2YfCJdRrRmoQ+4JkT4OP3CvQ2L+eP3nTJUtP/VqTMW+1xed
         6S2lLAc1W2jNje33zdGlYncDKQN/ideL3tKQAExSVNRXAumLS6fj8RpJfFr7wtciogaE
         2NEA==
X-Forwarded-Encrypted: i=1; AJvYcCVnhCB3is/H0w22vn4Kn1XpBu0oq03Jp8yrqN+eRjXbVw82QE94rjQpg3bQu/ieMz201xSVgEBo0jqzBPHQFnQ8d1W0jI/xQuJbQnDp0bj5WAR7qLX1Gkhyf/9KlacHDuSyirp/6t8fubHtIQm+p7swjAEaWUAxairSVGx372zB4h7AGyaq
X-Gm-Message-State: AOJu0YwW1rQ4RKRhB1vRby3lwTbPG80PbEuEvFLxbGqeqKWGAnsYhoh0
	YteDPqbYgOfE0DgSg+wTIi2htyIAvzre0yCphhAciOEWbPH94QS/RHH9rDaeCMRulS4AYFIz2VL
	1vGH8L+TnV7jx88Nvf7tISeZys48=
X-Google-Smtp-Source: AGHT+IHCDr6oYDv2WL0VlnDTf1vI5IOfripbN8omIMfwZxDOmOLWDkENGixYeqA7vsYTTJoQej3FqxTf2fw5PlK446s=
X-Received: by 2002:a17:906:e28f:b0:a6f:4f2c:1936 with SMTP id
 a640c23a62f3a-a6fab648d67mr258851366b.44.1718863716917; Wed, 19 Jun 2024
 23:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619070356.80759-1-animeshagarwal28@gmail.com> <f3ce758b-fa9e-4eff-984e-ace10553d683@kernel.org>
In-Reply-To: <f3ce758b-fa9e-4eff-984e-ace10553d683@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 20 Jun 2024 09:08:24 +0300
Message-ID: <CAEnQRZBvc6TR4Nnvp41oTKAU+EBdtuC0GnuDAGwO2MHDA8bV=Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: rename wm8750.yaml to wlf,wm8750.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:29=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/06/2024 09:03, Animesh Agarwal wrote:
> > Add vendor prefix to wlf,wm8750 dt-schema.
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/{wm8750.yaml =3D> wlf,wm8750.yaml}  | 2 =
+-
>
> Same as in other cases (why they started now?): why only one file not
> all of them? Anyway, that's not necessary.

There is only one yaml file from wolfson which doesnt have the wlf, prefix.
For consistency we think that we should rename the file :).

