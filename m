Return-Path: <linux-kernel+bounces-168911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8F8BBF9D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8037F1C209F7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C516FA8;
	Sun,  5 May 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjZ2kmYV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52728567F;
	Sun,  5 May 2024 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714894618; cv=none; b=nH6gr78yW7xme1ipO2DOERZ5wG2lUKMr+z7CG2cq+CepodoCW8cJzLk/AxtKIPN1Y6T4thOwdy0BnPuh99O5SVgtyONinJbXyeos9k/zzGt50/h0BTZrRnqE5E0qcCgoyWanV0uhjH3p+9R01TzF4El+/flqGqjiu/r3ZHb7IZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714894618; c=relaxed/simple;
	bh=kF+BXbMdzjv9zJwYvETsu6yuoGSvo6HZ2u28p8vg1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPSA/AMTs9+ImLe9oSDIUz9o4IJCb9/S5TAlA2H4rp49jb5HgVz0pgBprkPv8nPulP6p8A6Py+Xk5XXEcqhtLMmFUhvxg5ZcdddSdfQEX/Su3x2Rry6lEKTR8MEzuTwec6MeCnXcFghbJdJkDWsctZS2ivGnrX6RJxDeFclcaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjZ2kmYV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so1032000e87.0;
        Sun, 05 May 2024 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714894615; x=1715499415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV9tEny9NKUbEgU1EhkDp3KbnE7GbZyEn7aGZ4ZCiGY=;
        b=NjZ2kmYVgI/ulciGhreJq3aSl2R2I2r1uQEC/SKHOjvMo2dIMR6BfRVFpzP2ZswfRy
         0ICxKxtvjDJB81ui1WtP9vpyVjnqqdqZZ1HfySzCTMiHIuZl+F91rC0OBCjjhoc5NYEC
         pgh9jJi1fq6ErU1RU7ZBMJUSH9qgRWcq0jD1nNOe3R+N825AGeTnYk+MvFpzZbhTsR8y
         /OlbTwRV/+VKcSTtG8cys9V16ZtOY6mCX0TOxNCs55Qys+P1nZoIn0IjrS4gpFgvLWd3
         ymRnrzhqxQMtcmuFjdsYA/QCW8lfsFfXwxKl2R1omeQ1biL/NoF1f8o2NJ04ftphkN2i
         Qzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714894615; x=1715499415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV9tEny9NKUbEgU1EhkDp3KbnE7GbZyEn7aGZ4ZCiGY=;
        b=UVURVUjEjz47veeS9Bswpsg2wnCjWRFaWE6YNwwUQ2xorKKA1VUf6JMEnHGVdqE5aQ
         HfNPJIS5lwjLyXzvnoaYH4RYcH62csTfgs0CZzB2FjY2xlWM7NW89pPD+YsBwgdl4dbL
         Ht/55ar4I/YQ37sakRVEh4QwINgvMlGxkfmclXgiWEZpPz6anS6d+q6cKBeFnBgExzNk
         7UwroLx2/equQckjX/D1NU+OSnK9RBNA6bl6bh+nMey9rlD0ZL2Le5yu2JMdgIBnownK
         vUobOG5w8vInH0uwBfMrd2O3Axe8/iiMEXfTRwXJhKm8+BKTfpz8UStPb+pvGleVFVZq
         Z/9A==
X-Forwarded-Encrypted: i=1; AJvYcCVNrN9oeVAwFoAntYRng/KflYreps2FLIouHFk2F5aMn5GxovzXNO3S7yOHmgOA7ndTSJPCPh5W8E93UBcfo6eFHTsk2EF5PL7P3tRdjY36/ZDQmiMT34OAa+rchz81FzNk7dMifBdX9MWQquuqxl0/iXU/gnV3HjE0mNM7SrJn/BU3NBQy
X-Gm-Message-State: AOJu0YzGBKro+RrhJ9XsVBPbPlMXxj8wTubKeet6VPE7P6TJWpl2HEgN
	Z/WezfPUd6PhWaLPpp4Saosh0xMDbPVxE6TfVgWup2YVEQvCPyeFDvBzyqks/35S34a+EAghN9V
	xCiPF+Zi8jzzENmxZd/6eMgMcrJ8=
X-Google-Smtp-Source: AGHT+IEhm1kOZjjK2ZFI6f9D/6GM/IBpz99QMQr9mvR814WhujoDVJK3uBymnjH6FbQ1lNiuvR+8f/dPCun7Wnovqlg=
X-Received: by 2002:ac2:4e88:0:b0:51a:c2fe:9f73 with SMTP id
 o8-20020ac24e88000000b0051ac2fe9f73mr4834131lfr.51.1714894615147; Sun, 05 May
 2024 00:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417134237.23888-1-bavishimithil@gmail.com> <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org>
In-Reply-To: <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sun, 5 May 2024 13:06:42 +0530
Message-ID: <CAGzNGR=pvv67UJtNnkDUMhrpnPjNCCYEGeCaM7e_9=4G+Lcfgw@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> How did this happen? I see this was in v1, but I am quite surprised to
> be listed here. I am for sure not a maintainer of this binding. Choose
> driver maintainers or platform maintainers, worse case.

I might have overlooked this, will fix it. There is no driver
maintainer for it as far as I know.
Should I include the module author?

> Not much improved here. You miss $ref and optionally constraints.
Something like this
    $ref: /schemas/types.yaml#/definitions/string
    enum: [mcpdm]
Didnt really understand the "optionally constraints" part.

> Missing constraints, so replace it with maxItems: 1
Similar to how clock-names are handled?

> List the items. I asked to open existing bindings and take a look how it
> is there. Existing bindings would show you how we code this part.
  clock-names:
    items:
      - const: pdmclk
    minItems: 1
    maxItems: 1
Something like this?

> Just one blank line.
Removed.

> That's wrong address. Old code does not have 0. Please do no change
> parts of code without reason. If there is a reason, explain it in the
> changelog.
>
The checks were giving a warning if 0 was not included hence, I'll put
the real address if needed then.

> Include header and use common defines for flags. Just like all other
> recent bindings.
>
There's no defines for them, this is how it is in the dts :(

Best regards,
Mithil

