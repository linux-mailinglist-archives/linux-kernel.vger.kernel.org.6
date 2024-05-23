Return-Path: <linux-kernel+bounces-187781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E18CD85D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAD31C21059
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233A1802E;
	Thu, 23 May 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+b2/vN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A72179AD;
	Thu, 23 May 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481507; cv=none; b=rWOaRcU/7Jysx+WqOKSazl12q0F7cuKHVjgKVEp2Y7ycgzdYlBmYBhEebLGujU6UGBNJs0HSwdEfUxVPn+6S2PioQL4WBLgHmCC2vqrtHLfuovqzRQjO06ceeSvKXUuPRfxAcuEhsk4GgQpcziid97cMnySLyZBZ5CaQiqCzRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481507; c=relaxed/simple;
	bh=0d9jGHiS/2QcS8go3KAI4U3yHH1hr3uqvHpXEVKGgwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQwTGKCNqDVRRZsRRsJOPHB6QgY0KgMn30ttp38JTEJUjYWxcOU5JoMh/y+kWqLbO8kUvdXpgw89mayMitAKS2mMOXuKhD33apK34U3N+SpVsZrXm370/vpVcGCVYI+WdMchMWkIwKaliOJaoBnfDKOmQYBOkcHnoA0SKHS1VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+b2/vN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C75C2BD10;
	Thu, 23 May 2024 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716481507;
	bh=0d9jGHiS/2QcS8go3KAI4U3yHH1hr3uqvHpXEVKGgwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i+b2/vN05CZGzYkIwZ0aOh6tjKsNf4GI4YmNbyMrgsigZ4qiYbcAOh1oR4hrcXEBe
	 iw37vTu0Jci1CJaOjgMCJelJ7Sd+A+2Xb7TNiHU7cjidIKK/Tt/BRmU/5iLxCc9Pn+
	 hJwRIEeszXM0jB43I+RDa6nUK6YJ8uXIPdWODbmkyQRB8J7x6Pc57PhItUsWIlfix0
	 rx4UQL5+aQWCUHHXxsw2gHVb62+GZsbfzt3AIWeIcvas5umd4SKVfa9nQe6sGrbs/Y
	 ej1qC5zGh1+f0WpYHXE+592YWGubzePnPSKKBL3Z8nSPrZ1wJPjt+VKPqrrN84bVaJ
	 PdWEQEwFnz1AQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f45104ef0so8009946e87.3;
        Thu, 23 May 2024 09:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNZ9Vhx5GqcEnbOC7/mK7X0ja2thLMR9GzKNBJ+TyWk/ZivZRlb4MdTEAwBBCxwqRWkIuXbplcXuA3a4emFqbSAMhwt96jDo8hkns8fc3fRw7mua9DDdFTqQyCZBpKCW8FdkUig6HSaw==
X-Gm-Message-State: AOJu0Ywuww89WNGWtfPy0pkW5B1yL3KIGHDOTLTxUwSEnMVMq+HC2B3Y
	Wpwxn96NE5E9VekmuLgQR4WY5Zh2Up9cnCVJADunLqJ/G58MMWBZ7T6bLlqPOzBKU/VLczgKfZE
	tBiTpaS01kXoSA+pBDslNFGLqNg==
X-Google-Smtp-Source: AGHT+IEwyaYcKJXBDjUkbrJmbuC4zU8pOxR/uiL3UmvR1pJ9hgEoj1G35B71P9d7FtZvw5LZNl1t3vm0CcbNfJN05Ng=
X-Received: by 2002:ac2:5b51:0:b0:51f:6324:4b77 with SMTP id
 2adb3069b0e04-526c068ea87mr3215856e87.49.1716481505373; Thu, 23 May 2024
 09:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522075245.388-1-bavishimithil@gmail.com> <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org> <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org> <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org> <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
 <dc31c4ba-1bea-4056-a68f-87d742eb8da3@nxp.com>
In-Reply-To: <dc31c4ba-1bea-4056-a68f-87d742eb8da3@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 May 2024 11:24:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJp133hGSkja9tabtsE9D7MSA9JErVkmkcy91piHMgfwg@mail.gmail.com>
Message-ID: <CAL_JsqJp133hGSkja9tabtsE9D7MSA9JErVkmkcy91piHMgfwg@mail.gmail.com>
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Julia Lawall <julia.lawall@inria.fr>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:30=E2=80=AFAM Daniel Baluta <daniel.baluta@nxp.co=
m> wrote:
>
>
> On 5/22/24 20:05, Krzysztof Kozlowski wrote:
> > Dear Daniel, Shuah, Julia, Javier and other mentorship managers,
> >
> > I see some contributions regarding Devicetree bindings which look like
> > efforts of some mentorship programs. It's great, I really like it. Only
> > sadness is that no one ever asked us, Devicetree maintainers, about som=
e
> > sort of guidelines. This leads to sub-optimal allocation of tasks and
> > quite a strain on reviewers side: for example we receive contributions
> > which were never tested (tested as in make target - make
> > dt_binding_check). Or people converted bindings which really do not
> > matter thus their work soon will become obsolete.
> >
>
> Hi Krzysztof,
>
> Some of the faulty patches are on me! Sorry for that. We had an
> unexpected high
>
> number of people sending contributions for Google Summer of Code and I
> couldn't watch them all.
>
> Now, the application period has ended and we have 1 intern working for
> the summer!
>
> Will follow your guidance! Thanks a lot for your help!

To be specific, there are several ways to prioritize what to work on.

- There's a list maintained in CI of number of occurrences of
undocumented (by schema) compatibles[1]. Start at the top.
- Pick a platform (or family of platform) and get the warnings down to
0 or close. There's a grouping of warnings and undocumented
compatibles by platform family at the same link.
- Prioritize newer platforms over older (arm64 rather than
arm32(though there's still new arm32 stuff)).
- Fix warnings treewide from common schemas (i.e. from dtschema).
That's not conversions, but related.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/6918723853

