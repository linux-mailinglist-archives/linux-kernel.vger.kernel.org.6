Return-Path: <linux-kernel+bounces-205620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131928FFE31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F221C23862
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990215B129;
	Fri,  7 Jun 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixqdpOuB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0E15B0E1;
	Fri,  7 Jun 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749742; cv=none; b=o7q9KUeVsHYsYkJU536c+emArkvaQQlJnpTLQCBPNyCQHZE40dpRQMx8tqSQBEWugfZXtN45V11xKmaSjreZRs7Q6O7YMfpIY8CNHTEFPRC2h459gfoY2Iopl2YkEL49G2hAznUaT+dA+w0W91z03dyXT9Txib+6fTnfeQF1Rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749742; c=relaxed/simple;
	bh=gKD+CT9f7p/wT8kKDWc+BkVADz15maGFszW302e203U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY7YZIg6vfsDJWi3dNbjiPsK98gQS1/NFdirRqAu5NfAPSr6W9BwWizwoSNAuaS9LmckHgKguMduvoPNdesGz1Lrz1VFCHLt4+rW2JsVFOJ4wnTH+hgx7mrngpmZqutY0t/hoUvmHU07XvoCEhdJL2rQORhW4Y7Kf3zmfA0PfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixqdpOuB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so2260308a12.0;
        Fri, 07 Jun 2024 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717749739; x=1718354539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKD+CT9f7p/wT8kKDWc+BkVADz15maGFszW302e203U=;
        b=ixqdpOuBi9SfMGyqw2y4EoqvVNGyaWWO6cSa+kh8tGA80zv9ZEK7UEfwwy2Tz6xHCB
         /0FVOcpHd5R54cBN9LJO7YpgNj+sKJjaOyxhfQTyVNi4+lmcq531G41op/r1dxlWRL3+
         2yYfvyRNAQ5UK8K7GVqWDwtoLgtUvwuBLMkgfX4qDl+5wicncOgAU8BfDFDKZ6od62yE
         A2GAPSK7f2GxiDUbmTOOZn4us1x9NQSbKeHFbFAFgetWc8cQF37c/uA4VHS/er3PsPKi
         /lwmRRKjtFEfaIQSbFzG+7R2Fxnv7/0V653S348v/EuZtIHDU+JlFiO36H78VrxTqN1T
         Cu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749739; x=1718354539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKD+CT9f7p/wT8kKDWc+BkVADz15maGFszW302e203U=;
        b=AsMMIOL1ypi41wJsaJhOMm3fRL9IxidFs0lAJmqmcp0p20vgv6Z3Qawxca4JP0cuwz
         tRO3LWUGaGkRCWDreN1jFmOeKBZVrCKAtonZDzXeiD8CZ4vwXangBhDNRDKJUdTKnY7N
         VX5oVxaHiyjChvqg35q7crAjbK3yUbdxXVSN91FGStXTX9prCTFMPcI3TOGdn7lnaOfV
         UpQspddvng5XhpHqwQNHEku0mp85Fi+wQmMVA3qvi4cEUtTD98YavVseV5STOjbp/zCn
         QuRoN4uMLtZJj2JRTn5+PYNb2q/UFIEqkjj1jKdOIbL8M3hVokz4VwXuSe8I1Ub0Ld/i
         Z+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXDoxMP2ukUrNHAF9pPsna55t6zfBxDM6v+vIJa6oSOp3aaxigfZYeNpIfQqFo3pR0G5fbEIes7LKGPK7V1pq8NIGskYH5tyln4uX1NBf7UbUNFBgzOPeq+vppwrDbjyQvYKB09DhdSytn4i29Ex0Hv6nRgJklqdSO/m8Oo9ZVK5i6ADyMG
X-Gm-Message-State: AOJu0YxXuHoUXe4Tm/XjU0X5zELK194P8Qaf+KD5+yAHenfV1pfvmRwX
	h2yF5cSyei3zmnthiQoLYsgBNVQly8ZxtahzmnaDemSMafavIsMqQypJhO3z4IatgZl5SPcE6mW
	2lKVb1T4bzKgSeMMJhmpcF49rvQM=
X-Google-Smtp-Source: AGHT+IF8hs7c9n2gzMIzh4tdo5RrOfiFRubVngRyaE1i8HeeLwxSf9mRnWBLBk4mBykjVzOhpW+tsTAHkT87qXeYu3s=
X-Received: by 2002:a17:906:b7c7:b0:a62:b36a:eafa with SMTP id
 a640c23a62f3a-a6cdaa0fa87mr159211066b.57.1717749738582; Fri, 07 Jun 2024
 01:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607055725.38057-1-animeshagarwal28@gmail.com> <87frtps29l.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87frtps29l.wl-kuninori.morimoto.gx@renesas.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 7 Jun 2024 11:42:06 +0300
Message-ID: <CAEnQRZCXtoXWmNaoCrLYcSCO=V=O_+yUVoVJmnPkpysUYxBQNw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:19=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Animesh
>
> > Convert the AK4554 sound codec bindings to DT schema.
> >
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
>
> Thank you for the patch.
> But no one is using AK4554, we can remove it instead ?


So we just remove the device tree binding file, right? And later if
there is anyone who will use the
codec he can later add the yaml file.

