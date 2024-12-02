Return-Path: <linux-kernel+bounces-427682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143EC9E04B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20BC168D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D1204080;
	Mon,  2 Dec 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/69w67s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32636202F89;
	Mon,  2 Dec 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149114; cv=none; b=q2zBUrcRsj2Ipxh1tY/UrFp1oH/V4/ViSGddgY66fpWa3q4sixPOmqEhcFUEkYkDgolBcnElVLtryyrRaqM9YhmMzcEgwNp95cccA1n2T1f/pHFN3rydnb+oU+VlzwIr+wQrx7UAuHpDj+x+fkk9kc8Lbx7UCN635DxOt/yXqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149114; c=relaxed/simple;
	bh=0us+gBlX39zhRsFXi17z48PewGbGA42YA6AgkVkWDUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlEKFc3PpQnqYKAxvVvJjtS48SoPpZOgNSp7aidZmFIkj8oz0VPCR+6EGaDVI8pDGcQ0vXCPxKahyqoV181lDgTZ90ENNqipPN4ndAhHlSc/uLuHYJNgvewb+58DkAVJ0drbuBdV1pFP5/dnkfvo/wvICxbd6H8c21DHcGMPuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/69w67s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E66C4CED1;
	Mon,  2 Dec 2024 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149114;
	bh=0us+gBlX39zhRsFXi17z48PewGbGA42YA6AgkVkWDUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b/69w67sxxIFP0Cgljr6UtXL2oFZg+H0Wx5j9HUlvc4NjUYmstMhEuSBn5FhyCSjc
	 pX/UQwi66WRt0b1hJnJibvWd/7j8sr9YdVUnTWuY8TphSY4jrkPhbdJcVsukXMHxqv
	 uylSVeco87mylYuhEQwcES9IuBrfP6yZMjyQ+kmlOgbN4BoMW07uwG00y2NJx6T+tK
	 dNbyVDRZfxZ9m17qqOAtppmfqdkB9MA9oxSYZQuD9Okq8FiD80Kfz9ck7CDLu/451L
	 aWVniBFRlCeXzeGB0cdTHl0GAjJqj5XQ+o3PPVxJk9z5lf00M15kb8KnWbe0li7mK8
	 pRGTACOK2Sx2w==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef9b8b4f13so8274987b3.2;
        Mon, 02 Dec 2024 06:18:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtRbgHraOaPbUHkxC1+bPUbdYpI9XKe1mBdzErDnQVOt0baMpp8HkMNYWI2SwIdPdRyIyZRmXRUkj1@vger.kernel.org, AJvYcCXgdOmMbCDz3qW7XDxs+IwXL07fWxYu18ffF88eKx5JGH3V6//6L18zICdT+7d8kmppgxA9O6vqyxjUlKR2@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDEivBYZn4QrRNKWkuYtV6fk3HsXOAZsJkHkXlSMP4I5k+eUC
	GpdMEm+EdP3UDeZOQuq8823wde0H8zQD1opW8PTraspPZ70h1SCpJXYiOSF4rp+YxvXIpYLkch4
	E56l027aNAHtzFRFkIw4QZTlkWw==
X-Google-Smtp-Source: AGHT+IEhlb7MKU5lFFZroCSWTiCTT/MZ9My6mW0Op1qXva0iBbegNgizd/mgraVhnPlb+GYAYPu5wgFmxjfTHHaZhu4=
X-Received: by 2002:a05:6902:1247:b0:e39:998b:48cb with SMTP id
 3f1490d57ef6-e39998b5610mr7207837276.1.1733149113254; Mon, 02 Dec 2024
 06:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au>
 <87plmi7jjz.fsf@mpe.ellerman.id.au> <20241127214232.GQ29862@gate.crashing.org>
In-Reply-To: <20241127214232.GQ29862@gate.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Dec 2024 08:18:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhp8bW66koP8JPSkXmrCjA+oQh6NZte_uphiLTC_=7Rw@mail.gmail.com>
Message-ID: <CAL_JsqKhp8bW66koP8JPSkXmrCjA+oQh6NZte_uphiLTC_=7Rw@mail.gmail.com>
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Saravana Kannan <saravanak@google.com>, 
	linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 3:47=E2=80=AFPM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Nov 26, 2024 at 02:36:32PM +1100, Michael Ellerman wrote:
> > Michael Ellerman <mpe@ellerman.id.au> writes:
> > > "Rob Herring (Arm)" <robh@kernel.org> writes:
> > >> While OpenFirmware originally allowed walking parent nodes and defau=
lt
> > >> root values for #address-cells and #size-cells, FDT has long require=
d
> > >> explicit values. It's been a warning in dtc for the root node since =
the
> > >> beginning (2005) and for any parent node since 2007. Of course, not =
all
> > >> FDT uses dtc, but that should be the majority by far. The various
> > >> extracted OF devicetrees I have dating back to the 1990s (various
> > >> PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
> > >
> > > I have various old device trees that have been given to me over the
> > > years, and as far as I can tell they all have these properties (some =
of
> > > them are partial trees so it's hard to be 100% sure).
> > >
> > > So LGTM.
> >
> > Turns out I was wrong.
> >
> > The warning about #size-cells hits on some powermacs, possible fixup
> > patch here:
> >
> >   https://lore.kernel.org/linuxppc-dev/20241126025710.591683-1-mpe@elle=
rman.id.au/
>
> The Open Firmware specification is extremely clear that a "missing"
> "#size-cells" property means this bus has the default value of 1.

And the default for #address-cells is 2, but yet every architecture
except Sparc has that wrong.

If I have a node without #size-cells, is the default of 1 used or do
we check parent nodes? My read of the spec would be the former, but
the kernel does the latter.

> https://www.openfirmware.info/data/docs/of1275.pdf (page 186).
>
> DTC or FDT might want to do things differently, but expecting decades
> older stuff to conform to its ill-conceived unnecessarily super wordy
> stuff is, well, not a plan that is likely to work very well :-)

That is not the intention. The intention is to identify what doesn't
conform and exclude those systems from this check (or apply a fixup if
that works).

Rob

