Return-Path: <linux-kernel+bounces-384808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0E9B2EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E341F2117F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1311DDA24;
	Mon, 28 Oct 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnzjNH0t"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DF1D8E0F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114135; cv=none; b=jJsnJMxRVGwTKcRM7/vNy7LtqDVJSsQ5Oe578g305T+CtVOP/TV1cfN28ycU4eVn6sP+wJsMjAHxWYehRztY79IvuxtY2v5cUnAoqdmsvkEiRG/wMvoaet2ywbsiYRptGuDhIkix4XkNxF8LCWyyud71rxSHmBneGdPXJMda+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114135; c=relaxed/simple;
	bh=ynL2y9WuMgj3dveWKiLhJfkJgELagAbwDV6WYmDHEoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNc90+YNG40biEglIvX6Co4I44HOeOQGVvWmPdX4dyOfgcM1JJn6vPd1Pjm0kC1mX/x131QCwEN4Vvs2Qy8oxNjTmqFpJfEBcESDSe5OrjuFZRVwU6TcxVLkDrdkStweR6EvKjtnxbgn9QrVNUY70fJWtiACvz4LBY7iNfARspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PnzjNH0t; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a482407e84so1333653137.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730114132; x=1730718932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGypUE8EH0PE7RgIhsdX64LwM1rfHWiWWyyBVGZ2vjM=;
        b=PnzjNH0tklVo7h46dVzkUbce47Y2fkQW1no/fPrvtOpqxCygGeyHQkb5GQjqBINTLr
         9l74ml6DDl0Ni2PzIzmG1mAJyczBg8XKS0AuX7hiH14NTa3v+LTJCMzqOo25rHVOTJVe
         J1gRQj+G3+DpJ+hLY1SomoMghKMwm+d9hAazo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114132; x=1730718932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGypUE8EH0PE7RgIhsdX64LwM1rfHWiWWyyBVGZ2vjM=;
        b=Q4fn56OG66ffMEP6qvK6lfB9cPw1flxcWZEmjSzI546piqNTEgZ4OgBiWZ5K8HP5dG
         1/5i7by6L7+kx4q6MMxUkE+pe7Q+AXKmG9RtWwZJx389ajKryH+lAnA6MBEjvAtwYSXw
         P5ZnZJBE64LWtWJIrs7vRYQvAru9UmbM1c+35mTcNrVlbScT3nlLhL+AT1Mjye/zofjs
         X+RG/nxW3f+T4ghxSxiU5CBbzja6blnVvW5/0o9kp66nIw78KXqrHfozjjTg9NGXYscm
         BAIUvK/kCW4q1IbSzovFhUZeucp02FpM6tEO22RVOwpRcRlGgbsxFSsECV6GbGJY9pK/
         JmQw==
X-Forwarded-Encrypted: i=1; AJvYcCWRBUx5Eg+caXjfmo+d0vRpSXINQ7kY9k+y+KJ+O3jQyiSct1FUWKOY1duiP3SaYDf8z1g3e2z6UtXCp/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1inJne9UbpotZyTlqVS1evYB7ds3ESuRiH0PYb1OJOzGvdBy
	a6dE224A5ARNCGgoM7dWUP1tpohUoEJm8Wuw/kB+4vF5LcRdam780qN3WZjCmzqChajZK3T+upQ
	=
X-Google-Smtp-Source: AGHT+IFSJWWrYhjHwclP57z3Y4Zlkvk5yioFt+cs6XiVadxx3pLUr9oUm3OEr3jXtBn/0r7hh0c4nA==
X-Received: by 2002:a05:6102:1610:b0:4a4:93d0:df13 with SMTP id ada2fe7eead31-4a8cfb8572amr5371191137.16.1730114132193;
        Mon, 28 Oct 2024 04:15:32 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c5238d84sm1007942137.12.2024.10.28.04.15.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:15:31 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d2c02875cso764594e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:15:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJn6UzFzXLJW5/1UY9dttkDxFvsJxN9ImM+VjEns3alQMJtHVLL3hpLZ/jThNe0cismU8RKXskpxEcvsA=@vger.kernel.org
X-Received: by 2002:a05:6122:2207:b0:50c:5683:ad56 with SMTP id
 71dfb90a1353d-5101501204bmr4351974e0c.3.1730114130593; Mon, 28 Oct 2024
 04:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025104548.1220076-1-fshao@chromium.org> <20241025104548.1220076-5-fshao@chromium.org>
 <r2qtuopc6d2vygxghgydole5ixxr4z5weougk7ldadyma4zi56@sp34zufvzdaq>
In-Reply-To: <r2qtuopc6d2vygxghgydole5ixxr4z5weougk7ldadyma4zi56@sp34zufvzdaq>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 28 Oct 2024 19:14:54 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng0n25qrrBGa-Qm7XPBwSdW733tV9faa1q1s_z01RSJ5Q@mail.gmail.com>
Message-ID: <CAC=S1ng0n25qrrBGa-Qm7XPBwSdW733tV9faa1q1s_z01RSJ5Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ASoC: dt-bindings: maxim,max98390: Document
 maxim,dsm_param_name property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	Steve Lee <steves.lee@maximintegrated.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 25, 2024 at 06:44:44PM +0800, Fei Shao wrote:
> > Add the missing "maxim,dsm_param_name" property in the binding.
> > This property specifies the customized DSM parameter binary name.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yam=
l b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > index 5bd235cf15e6..fa4749735070 100644
> > --- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > @@ -32,6 +32,10 @@ properties:
> >      minimum: 1
> >      maximum: 8388607
> >
> > +  maxim,dsm_param_name:
> > +    description: The DSM parameter binary name (e.g. dsm_param.bin).
> > +    $ref: /schemas/types.yaml#/definitions/string
>
> NAK, you cannot document properties post-factum. It's not a property
> coming from 2014.
>
> For me, this is obvious that this is for ACPI and if you want to use it
> for DT platforms, go through proper review.
>
> In any case: NAK for this and other ACPI properties.

Acknowledged, I didn't know that.
This was directly from a Maxim customer and I guess they didn't remove
it when porting from ACPI or something.
I'll drop this and update DT in another series.

Regards,
Fei

>
> Best regards,
> Krzysztof
>

