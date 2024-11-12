Return-Path: <linux-kernel+bounces-405970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B8B9C5973
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1171F23C98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA501F892C;
	Tue, 12 Nov 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNoZer1X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B91F81AC;
	Tue, 12 Nov 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419182; cv=none; b=ecRlGaWf1m9oATbrn20xs6E/AkvJYbJD9dvXADfMS1e4M+wDLu8xHCLe2dRCYFlPh2I/1V3aPFMUJmoRo9PIT5+vPHCmIjRlZSi24P98wommMLM2RwtaLZgcZYzmUTaWyHkLurDoQ6QUY8IJTmbQ71NqBe+0vx52M83+wtVeUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419182; c=relaxed/simple;
	bh=k6W+HKSuc4CzrIJX0IoN770edZbxi3Ko9sF7Bizv6jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqQROuQpVV9hs2Ob5O+vlZKUkoG3wI0l0HS4xBXuFS2/lacT9eh6tMDiMQqkJi0TjWDYQRDFHxYw5C/vWBiMJNrOYulg4WZ7irtGyon4eiVTjm/QOi64wTrwd550h475zoJIXvs1Ecbkmu+rVihpkGquSxYrOHGBv6HG/CNTB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNoZer1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F160DC4CED9;
	Tue, 12 Nov 2024 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731419182;
	bh=k6W+HKSuc4CzrIJX0IoN770edZbxi3Ko9sF7Bizv6jw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VNoZer1X/koJEZkkYAW1p0Z0nOFRO0+PMkNpldz6DxOUXGN+OlMI7iisT8AJDWnrK
	 OkMROkHg2++QDnze9P3GkePn3jfLgM7Ks9HLn7N20/LQO+v1rZs7QFOZB2mn5B5Lyx
	 8q1+qafWxSs+PZCR6PtnK8NDwfH872dw4mL6JALKeW8iK3MXvY90Igb2zUHVuKyOn0
	 fITIpv4TlPNBsdPgoFXgHxYW5umzTuzvDzbvCCtpyCssd9LSy3ptPKfpJ5jPvNEwPA
	 ox12mW2Fth/lucCe6rjtEEgha/+i8ZzYRLVTufz7IcuRDM8WpvBa+0Z3jN+RLwZvOt
	 TyRuE76r+7zcw==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e29218d34f8so4053074276.1;
        Tue, 12 Nov 2024 05:46:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBkUaVQNChELmampcuxwx98SlPJ9c3Mdc2MJ9d1Rv7zsrQk6Vc6XpV5LyGAT8x94DUITzDTfAxuJ/V@vger.kernel.org, AJvYcCXiDWlJAyCJsBGP712Rt08Cac4M8i6W6Qpz5mDJbsrt9/qVvWJ3ly7CCmqVphnH2AZZyyNK198nOtVfOe3T@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjABTmpUui31XR4CWXYaY3HwjpBJnR71mVd8YkTnk3B8b40K7
	Nk4kC7JgepCgdb2Fg98mqRJ6jcA3DA4N9ikcdrCj88B9MQFmVYUIUK5vN2QNTEpOajsFnRxjJhT
	3dfloNaQ+w0WrQ+QJ2v24286mog==
X-Google-Smtp-Source: AGHT+IEn0C0WfCG7tbpSyf5xX7DxWFdOpXhSBoAZ5hwE4Pr7xdWiEcgqvO/UcDsq9RdhhFj/OdlcAN30PYOvXPkThlA=
X-Received: by 2002:a05:6902:1507:b0:e28:e700:2821 with SMTP id
 3f1490d57ef6-e3380067b96mr12346210276.25.1731419181152; Tue, 12 Nov 2024
 05:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
In-Reply-To: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Nov 2024 07:46:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJAQswTo2eWxLw62wqb-2i=_9W84_v_tW+TSW4kgNK3_A@mail.gmail.com>
Message-ID: <CAL_JsqJAQswTo2eWxLw62wqb-2i=_9W84_v_tW+TSW4kgNK3_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] of: add support for value "false" to of_property_read_bool
To: Josua Mayer <josua@solid-run.com>
Cc: Saravana Kannan <saravanak@google.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Jon Nettleton <jon@solid-run.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, rabeeh@solid-run.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:41=E2=80=AFAM Josua Mayer <josua@solid-run.com> =
wrote:
>
> Boolean type properties are usually considered true if present and false
> when they do not exist. This works well for many in-tree board dts and
> existing drivers.
>
> When users need to overrride boolean values from included dts,
> /delete-property/ is recommend. This however does not work in overlays
> (addons).

As soon as someone needs to delete a non-boolean property, we're back
to the same problem. If you want to fix it, you need to fix it for any
property.


> Geert pointed out [1] that there are several invitations for using
> strings "true" and "false" on boolean properties: [1], [2], [3].

There's always bad examples...

> Add support for a string value "false" to be considered false on boolean
> properties by changing of_property_read_bool implementation.

Any existing s/w will treat 'foo =3D "false"' as true. It's an ABI.

Rob

