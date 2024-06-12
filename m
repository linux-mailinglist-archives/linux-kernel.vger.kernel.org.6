Return-Path: <linux-kernel+bounces-211459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9909051DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB31C206A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937116F267;
	Wed, 12 Jun 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixEJTeCt"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8116E882;
	Wed, 12 Jun 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193588; cv=none; b=qV96ylVLL/2CoyDpbSPXnfoxfox9KC3Wr2aeRjBMctSYCQ5q4tF2SOG9oFqnB9CzSeqXpfcT3oh6zLTyRlJUTtmzLUz7o5ARJdNuF9tFLmPXNshxhnFY4yujXa4zZkLw2Zxcn5smt6uARInQNJv8nxuA/bI5tAk+ORwl6lXMrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193588; c=relaxed/simple;
	bh=g+KF8NdttgCTb5bfAiBABlmcgbDcCXSiriG2NAgXuKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1Lb1ILVeAZ7yJSliouYr88GMZwGlfBpXC83nhixGEwH8r5wgQpzYq6lhie8Q/1JRMrRA3rv1vODksReJyT80WDagK87dio4ivnsKCwe1P4nnX/4RPg/cceMSC9OQFm6bJPDJP87avLnrnGYHWzNundvT3rXVKNJ2+i+Sf8IeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixEJTeCt; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f6338a4so3372769fac.1;
        Wed, 12 Jun 2024 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718193586; x=1718798386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rw4oq0Ohf7tU3ClnNhFQL/oCvaY2J0yWIQIMUVmHN0=;
        b=ixEJTeCtTOVvkp2gDvfhUuvxB28UEj5iDD9i2SxMoY9ahlAvLOlSgHhbeCGQ7s4mYf
         fIqugPjmMJkwgTHyuETClCprJTe67oDXavgWPJefQof/19hnhlKo5K1n2ToOzNFHlvqK
         pyyORjwhCeG2ERQbcl45Ov4Z5HnZWViI7d+9NrwnyYqyxFAUFXWs2uzZdse9m5WqaiBm
         K+/iajScuggrufPcJwToda6gBh0KSg41TNNCqNbkhPLZ3bqZdVOx9jNgMYJlpQO8IF38
         bRBH2q2F0YaJxqdQ64O8rffTPyUWmFad+NDFTGokWt3KoKt9tCGicviKdOOVrh8mPLER
         LnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193586; x=1718798386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rw4oq0Ohf7tU3ClnNhFQL/oCvaY2J0yWIQIMUVmHN0=;
        b=AnGkD9ehjWx0Tr/P02DMerokqkBr3rL9LOfsWgSCHi6nkuW9RPbqF7636shk+ir288
         9lCCaGIe1Lwatct0rJXdlkywFqL/euIln9JutfYtmrdh3wnoGcFmdLJudI2d3CcvOxNA
         qfnGNreXTo9xZKDF0/+m/imog1hYJD7dU+dZOkdh0UiniNgQoZWSELk0cmVD2AMoJkJk
         HZCdho7YB86UWU01Kn6d/9Sw1tjR2ZT7h+BQ2MTITUMpIfkCVEfIETXlZUC+zawZPoBZ
         h4cy3aAbX2Dcl+fOEJbawFINTfe7D4wNo7RohPLf0Xb41jhUeqNvDSoLbyGPyk/4/IuN
         RI/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9/fCMkHcjkwcLuXx23IEW34TjC05Qb2oVMKD0AyXslt9cqTzPzKVWio3z4PkwAfof0ObcL+GQYYNegPYCJSh2Dx3xZFrexajkRjcfBvfJuaOj3M+k1oypCBAiHV6n6xPFQe94gAW7hDoii5DzOL4oR42pRERX4yZtoMjayCGzt33j/PxX
X-Gm-Message-State: AOJu0YzaGmVIOVDMyYNmdpJxK9LEXh00fTfWHKIC6J2VVr+Fk3aybSPn
	4z8xWYvJYUT5Pdfmq0+7mRMbiWKEL0BC/rUQjoYzzzL+tpFffZbBfLHJR/plS9gNwshoCV5bNkM
	+bS41boFCYSsD4IVjBM4ueJztI3Q=
X-Google-Smtp-Source: AGHT+IFFf4hE4u3P0SMg8Z9wDg4GkGs4lvBLHNeR6wq+yEuT+bu0jRI3VhYDYsU3aM/1SnRiCtH56OVzz4nlSeUuYMo=
X-Received: by 2002:a05:6870:c0d1:b0:24f:c892:d02b with SMTP id
 586e51a60fabf-255147aa8a0mr1721343fac.0.1718193585675; Wed, 12 Jun 2024
 04:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611124405.63427-1-animeshagarwal28@gmail.com> <20240611200048.GA2966276-robh@kernel.org>
In-Reply-To: <20240611200048.GA2966276-robh@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 12 Jun 2024 17:29:34 +0530
Message-ID: <CAE3Oz81AP-5RGK0Xef72XT3x4Je1tu223BMwk7-mzKrJWKqTbA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: wlf,wm8782: Convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 1:30=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Jun 11, 2024 at 06:14:00PM +0530, Animesh Agarwal wrote:
> > Convert the WM8782 audio codec bindings to DT schema.
>
> Missing "ASoC" on the subject. Mark may not see it.
>
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/wlf,wm8782.yaml | 47 +++++++++++++++++++
> >  .../devicetree/bindings/sound/wm8782.txt      | 24 ----------
> >  2 files changed, 47 insertions(+), 24 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8782.=
yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
>
> This is yet another binding with no in tree DTS user. That's fine, but
> not what I would prioritize converting. There are several ways I would
> prioritize what to work on.

I'll resend this patch adding "ASOC" in the subject, thanks for the
advice I'll not prioritize bindings that do not have their DTS in the
tree.

> - There's a list maintained in CI of number of occurrences of
> undocumented (by schema) compatibles[1]. Start at the top (most
> occurrences).
> - Pick a platform (or family of platform) and get the warnings down to
> 0 or close. There's a grouping of warnings and undocumented
> compatibles by platform family at the same link. Pick something that's
> widely used like RPi or RK3399.
> - Prioritize newer platforms over older (arm64 rather than
> arm32(though there's still new arm32 stuff)).
> - Fix warnings treewide from common schemas (i.e. from dtschema).
> That's not conversions, but related.

Thanks for the tips. I'll work accordingly.

Animesh

