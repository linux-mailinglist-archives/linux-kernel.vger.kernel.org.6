Return-Path: <linux-kernel+bounces-366514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF0499F6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2072872F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8591DD891;
	Tue, 15 Oct 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtFcaoR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28421F584C;
	Tue, 15 Oct 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018699; cv=none; b=nQtnJHMLc4lBc8ZTwdZmQM5BVPNStuLl6XmOMaWJ3fbXqpZeRCcXxzAy3wL+Z5sjRos8hL36RINJ2T6iNy4fik044Es3VZgjUkZ3z9+4C/8S8oqdhsCrvatN/gNaWa2gCsuagquy1jgWOmDV1X3u9kyGVVYs7h/swnADNoEd3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018699; c=relaxed/simple;
	bh=ZjqiGp0bj+NvwU7B6mmFLsuKUZkeVnU+4eHPsa2EBzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQkP219gemRLLwsASKKGA68R4RJZI8oZRxm/25QSqS9c7copxsxf5dElrGtrdJEZl+jTfnQi6sfAyRESBC+XlK51Op32IVZD8P3lGX/xudTN/2GbFyZAtNwqrRfjYd3NdNb9bgs9bey8dQSxb4tjAkEx7v0gjk8lRbtTj+ZTrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtFcaoR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73477C4CED3;
	Tue, 15 Oct 2024 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729018699;
	bh=ZjqiGp0bj+NvwU7B6mmFLsuKUZkeVnU+4eHPsa2EBzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TtFcaoR+aVP+J0hnIJgtQ3lqio6ivLPFln1dEkOCWhenXo8hSjQ0IlhEoZXbzzgKi
	 WzKul87p6iZhQoM4MicGkvQcDo67RBYSmRxt6bYbqCzm+wuadF41c0ryWxDKLhD1hT
	 bFpg+Sf+7jnkDYBxHYVPJ+MKgfXfkDHTZNXUb1fpy80O0lO2cJJoesoLrghPJpFOXV
	 ehbkSxdsODL026a5SgEnXDLuvlAC+zE50eL5QQw6AKueNmt88CUO+9ctdICxe3k3C3
	 +rv/vzJRJnwMK/y9KBk/sOPrpW7fh2QKPKyD2Vp7H/Eu0grduCLs321M72Lkn3atx9
	 s2YILATZdB42A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so6831957e87.0;
        Tue, 15 Oct 2024 11:58:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2AtESMgJ266SuVrx/ZAfgfdkGq+Rav1dwKbHX5LIXkjlB9YTbLtrPEc8Wz0SnxcDjlWK570aq3ijizZWo@vger.kernel.org, AJvYcCXjv154+gCBCJzJpgoLwZdlTQ95FdJ7Vcf8uJK6MqlAK3+Iq312tw0dZp3YTEzXK5Y0nE7v+poiEzJZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30vh0W+Tw/7gMNfaEtw1VvCKwzBZSjwvGioXo9aEAbvqCekwJ
	9nmSVi6cDgXIRWTs4ddk2JIGHPnnkeVNFmHoC67/nfQamRuhFy4+7TpzrSa7njN05v5NuQb3Osp
	iy4jf0zTvhMjeKi+ZMz7johSZdA==
X-Google-Smtp-Source: AGHT+IHkkm5bMw4k3U4hArlnSreaKl/mJGb5HPD1RKkpSUkGXrbr0rml8iZfYZLX59yuK1lgj1Fv5ddxye3/AwhrWkU=
X-Received: by 2002:a05:6512:e85:b0:539:ec29:1cc3 with SMTP id
 2adb3069b0e04-53a03f2da18mr1016189e87.30.1729018697767; Tue, 15 Oct 2024
 11:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012073543.1388069-1-victor.liu@nxp.com> <20241012073543.1388069-6-victor.liu@nxp.com>
 <4a7rwguypyaspgr5akpxgw4c45gph4h3lx6nkjv3znn32cldrk@k7qskts7ws73>
 <07b47f70-5dab-4813-97fa-388a0c0f42e9@nxp.com> <dvcdy32dig3w3r3a7eib576zaumsoxw4xb5iw6u6b2rds3zaov@lvdevbyl6skf>
 <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com> <lcogrc6uztckwwwsuag5tlk5otidmo7rudsl7zshe3wpfot3wc@ziljns5phhfe>
 <20dfe41f-7aca-4321-a5e9-5c6b8513b400@nxp.com>
In-Reply-To: <20dfe41f-7aca-4321-a5e9-5c6b8513b400@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Oct 2024 13:58:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLK_90n0xnrwDAymLyF5uKPqmfjg0XBU-1DSrWRi35ziQ@mail.gmail.com>
Message-ID: <CAL_JsqLK_90n0xnrwDAymLyF5uKPqmfjg0XBU-1DSrWRi35ziQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS
 to HDMI converter
To: Liu Ying <victor.liu@nxp.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, 
	will@kernel.org, quic_bjorande@quicinc.com, geert+renesas@glider.be, 
	arnd@arndb.de, nfraprado@collabora.com, o.rempel@pengutronix.de, 
	y.moog@phytec.de, marex@denx.de, isaac.scott@ideasonboard.com, 
	biju.das.jz@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:01=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> On 10/14/2024, Dmitry Baryshkov wrote:
>
> [...]
>
> >>>>> My suggestion would be to add a single root-level property which
> >>>>> specifies which port provides even pixel data.
> >>>>
> >>>> That won't work.  The LVDS source side expects the ports of
> >>>> the sink side specify dual-lvds-{odd,even}-pixels properties.
> >>>
> >>> I didn't notice that these properties are already defined.
> >>>
> >>> As these properties are common between several schema files, please
> >>> extract them to a common schema file (like lvds.yaml).
> >>
> >> I'm not sure how to do that. Is it obvious?
> >> Please shed some light.
> >>
> >> Only two panel schema files are defining even/odd pixels now -
> >> advantech,idk-2121wr.yaml and panel-simple-lvds-dual-ports.yaml.
> >> Maybe, extract them later when more schema files(especially for
> >> bridges) try to define the same?  I'd like to keep a low profile
> >> for now.
> >
> > I'd say, please extract those now. Adding third is more than enough and
> > should be avoided. Extracting is pretty simple. One patch to move the
> > definition and descriptions from panel-simple-lvds-dual-ports to a
> > common location (e.g. lvds-dual-ports.yaml). Leave the required
> > constrains in place. Second patch is to add oneOf constraints to the
> > ports.
>
> oneOf just sits below ports so that single-port and dual-port
> are documented separately?  That won't pass dt_binding_check
> as the v1 binding has proved that warnings will be generated.
>
> > port@0 might get the same oneOf + the
> > dual-lvds-{odd,even}-pixels:false case, allowing a single-port
> > definition.
>
> I don't catch this.
> Below snippet is a draft lvds-dual-port.yaml.

Please make panel-simple-lvds-dual-ports.yaml use this.

> How can it be referenced in ite,it6263.yaml?
>
> ---8<---
> allOf:
>   - $ref: lvds.yaml#
>
> properties:
>   ports:
>     $ref: /schemas/graph.yaml#/properties/ports
>
>     properties:
>       port@0:
>         $ref: /schemas/graph.yaml#/$defs/port-base
>         unevaluatedProperties: false
>         description: the first LVDS input link
>
>         properties:
>           dual-lvds-odd-pixels:
>             type: boolean
>             description: the first sink port for odd pixels
>
>           dual-lvds-even-pixels:
>             type: boolean
>             description: the first sink port for even pixels
>
>         oneOf:
>           - required: [dual-lvds-even-pixels]
>           - required: [dual-lvds-odd-pixels]
>
>       port@1:
>         $ref: /schemas/graph.yaml#/$defs/port-base
>         unevaluatedProperties: false
>         description: the second LVDS input link
>
>         properties:
>           dual-lvds-even-pixels:
>             type: boolean
>             description: the second sink port for even pixels
>
>           dual-lvds-odd-pixels:
>             type: boolean
>             description: the second sink port for odd pixels
>
>         oneOf:
>           - required: [dual-lvds-even-pixels]
>           - required: [dual-lvds-odd-pixels]
>
>     required:
>       - port@0
>       - port@1
>
> unevaluatedProperties: false
> ---8<---
>
> --
> Regards,
> Liu Ying
>

