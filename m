Return-Path: <linux-kernel+bounces-212590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66C9063BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62E0B220EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C28F37C;
	Thu, 13 Jun 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZ77nGfI"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17F132104
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258801; cv=none; b=B4+dQEv9y3zkmwOB/ocTSvJ5gPKiFakBdt7A0SvQkPCxXyraOREo9flGrV2gWRyVxH56zUOcnjW4xE34W7BZ2Ch7OJFDnlcCW1nxEAwfukhU1Dj8Dxdg1aM5xfsa2z5sEywWINa97WNLR0DT+0oyEL4CMKoy3P/d7cXl1eohLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258801; c=relaxed/simple;
	bh=4g07QZieUxmsDqIl1YNP1f5lYgtIe9M1543QyG+q1+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHPpxtSwwNZB6aoM39u+v4MvPNZtffWE2sEB+Oqz7nie7Z47v0iYNFNEd2fKeSO7cupMkkTfdCq0paQFwz1fKUazgXX+VvH4v9w7vsVbsLF+IQg+QGUsToQUw0YaRIPU5/fPVBrZpwLa2kRKOxvrO7R/ccXYeoAakrCqVohQ5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VZ77nGfI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso5774791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718258798; x=1718863598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSH0DjDhwB3L1CLHpcobJ5fXoLIXqFfrAAYmwFu4jJo=;
        b=VZ77nGfIuVS7KpqX9unH4WvpmouGmH15epoANpn3eSJBNR8Yk6CMSSlgKY8aHq72sT
         65LG1HZE2e+/0SgUtmTG9mZOSbix2uNKh2qP8JeBulgd59lQowoY0/05Gj2E0l5NzFUc
         iUIBoqP1y8mbfvFv+6wf1M8Bt55DBrSlQqf4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258798; x=1718863598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSH0DjDhwB3L1CLHpcobJ5fXoLIXqFfrAAYmwFu4jJo=;
        b=FLqsRPj3TgJL9w7YzVqPF5Xf2EmLC4Dfba3w7IQkJryYgbJYNQ9QFzJ6joWno7+pVA
         ABDZF5rZcrv4JTbqZa5hyQMlAcfMtk81o83Q0Ru2JW9OHGKXQpVHpho94IqyXLQYqNw7
         Pk1rquLLU8QQlacdUNdppsABT41a15M6m10PVQ6bLQf4bs7IQOutGKTxHWR4WOfBrNoO
         9iBCNdACi5MZSmGTPLHUJ68WXnUiL6ROqm8FIdPo8rA+oub4WQYNJh9iYYW00QDp79QA
         x8I61O1WXX6w4yKRQZ/Zz/JNh/nO8oU292lWwBShdZVamQhDgPfI2Y6UW98FWPLKtjDP
         esGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgFvuCY4M7iGpv8c35GBAEVgz1JG3paNkRz/RYN2XXpfZ45OyqxxmHg3yN95AffQvctD/DhWrRhnFqtwkUrjLnV1fdCm3Kcr4YZy8b
X-Gm-Message-State: AOJu0YzY1HqysR7Z79V3BpdNf6Hcq7J1acm33bt7XebFO3kwCEQ2G0Gq
	tek3y2xduvtfk0DCLSyYvImN6k62jOkfaI+XWO/5Bsww1/sf5s0sbo6+c6ZuTwNMhXGyGh6KDUm
	06e8EwleAUOhoHk15KLBfUnTut9Qtw0P7WFo3
X-Google-Smtp-Source: AGHT+IFzq9XuAIM2Q2ahpj3Sd3BXnntejul4oBikhxZEOqFO5hUX59O0xTtJhBGjgP/s2o6c8hCCxKlKJXnzarOUzM8=
X-Received: by 2002:a05:6512:23a9:b0:52c:9e25:978d with SMTP id
 2adb3069b0e04-52c9e259f8emr2257164e87.45.1718258797636; Wed, 12 Jun 2024
 23:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605094843.4141730-1-wenst@chromium.org> <CAK7LNAQrPfpScYKKg_Mwoj2RyWe5_e_xn6YZRm+t_w2X4+3kYw@mail.gmail.com>
In-Reply-To: <CAK7LNAQrPfpScYKKg_Mwoj2RyWe5_e_xn6YZRm+t_w2X4+3kYw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 13 Jun 2024 14:06:25 +0800
Message-ID: <CAGXv+5E1UsHyxier94=ah0P_g5QfdwLgNzc915QjdtXQqTN8ow@mail.gmail.com>
Subject: Re: [PATCH] scripts/make_fit: Support decomposing DTBs
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:33=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Wed, Jun 5, 2024 at 6:48=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
> >
> > The kernel tree builds some "composite" DTBs, where the final DTB is th=
e
> > result of applying one or more DTB overlays on top of a base DTB with
> > fdtoverlay.
> >
> > The FIT image specification already supports configurations having one
> > base DTB and overlays applied on top. It is then up to the bootloader t=
o
> > apply said overlays and either use or pass on the final result. This
> > allows the FIT image builder to reuse the same FDT images for multiple
> > configurations, if such cases exist.
> >
> > The decomposition function depends on the kernel build system, reading
> > back the .cmd files for the to-be-packaged DTB files to check for the
> > fdtoverlay command being called. This will not work outside the kernel
> > tree. The function is off by default to keep compatibility with possibl=
e
> > existing users.
> >
> > To facilitate the decomposition and keep the code clean, the model and
> > compatitble string extraction have been moved out of the output_dtb
> > function. The FDT image description is replaced with the base file name
> > of the included image.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This is a feature I alluded to in my replies to Simon's original
> > submission of the make_fit.py script [1].
> >
> > This is again made a runtime argument as not all firmware out there
> > that boot FIT images support applying overlays. Like my previous
> > submission for disabling compression for included FDT images, the
> > bootloader found in RK3399 and MT8173 Chromebooks do not support
> > applying overlays. Another case of this is U-boot shipped by developmen=
t
> > board vendors in binary form (without upstream) in an image or in
> > SPI flash on the board that were built with OF_LIBFDT_OVERLAY=3Dn.
> > These would fail to boot FIT images with DT overlays. One such
> > example is my Hummingboard Pulse. In these cases the firmware is
> > either not upgradable or very hard to upgrade.
> >
> > I believe there is value in supporting these cases. A common script
> > shipped with the kernel source that can be shared by distros means
> > the distro people don't have to reimplement this in their downstream
> > repos or meta-packages. For ChromeOS this means reducing the amount
> > of package code we have in shell script.
> >
> > [1] https://lore.kernel.org/linux-kbuild/20231207142723.GA3187877@googl=
e.com/
> > [2]
> >
> >  scripts/Makefile.lib |  1 +
> >  scripts/make_fit.py  | 70 ++++++++++++++++++++++++++++++--------------
> >  2 files changed, 49 insertions(+), 22 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 9f06f6aaf7fc..d78b5d38beaa 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -522,6 +522,7 @@ quiet_cmd_fit =3D FIT     $@
> >        cmd_fit =3D $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
> >                 --name '$(UIMAGE_NAME)' \
> >                 $(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
> > +               $(if $(FIT_DECOMPOSE_DTBS),--decompose-dtbs) \
> >                 --compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
> >
> >  # XZ
> > diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> > index 263147df80a4..120f13e1323c 100755
> > --- a/scripts/make_fit.py
> > +++ b/scripts/make_fit.py
> > @@ -22,6 +22,11 @@ the entire FIT.
> >  Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> >  zstd algorithms.
> >
> > +Use -d to decompose "composite" DTBs into their base components and
> > +deduplicate the resulting base DTBs and DTB overlays. This requires th=
e
> > +DTBs to be sourced from the kernel build directory, as the implementat=
ion
> > +looks at the .cmd files produced by the kernel build.
> > +
> >  The resulting FIT can be booted by bootloaders which support FIT, such
> >  as U-Boot, Linuxboot, Tianocore, etc.
> >
> > @@ -64,6 +69,8 @@ def parse_args():
> >            help=3D'Specifies the architecture')
> >      parser.add_argument('-c', '--compress', type=3Dstr, default=3D'non=
e',
> >            help=3D'Specifies the compression')
> > +    parser.add_argument('-d', '--decompose-dtbs', action=3D'store_true=
',
> > +          help=3D'Decompose composite DTBs into base DTB and overlays'=
)
> >      parser.add_argument('-E', '--external', action=3D'store_true',
> >            help=3D'Convert the FIT to use external data')
> >      parser.add_argument('-n', '--name', type=3Dstr, required=3DTrue,
> > @@ -140,12 +147,12 @@ def finish_fit(fsw, entries):
> >      fsw.end_node()
> >      seq =3D 0
> >      with fsw.add_node('configurations'):
> > -        for model, compat in entries:
> > +        for model, compat, files in entries:
> >              seq +=3D 1
> >              with fsw.add_node(f'conf-{seq}'):
> >                  fsw.property('compatible', bytes(compat))
> >                  fsw.property_string('description', model)
> > -                fsw.property_string('fdt', f'fdt-{seq}')
> > +                fsw.property('fdt', b''.join([b'fdt-%d\x00' % x for x =
in files]))
> >                  fsw.property_string('kernel', 'kernel')
> >      fsw.end_node()
> >
> > @@ -193,21 +200,9 @@ def output_dtb(fsw, seq, fname, arch, compress):
> >          fname (str): Filename containing the DTB
> >          arch: FIT architecture, e.g. 'arm64'
> >          compress (str): Compressed algorithm, e.g. 'gzip'
> > -
> > -    Returns:
> > -        tuple:
> > -            str: Model name
> > -            bytes: Compatible stringlist
> >      """
> >      with fsw.add_node(f'fdt-{seq}'):
> > -        # Get the compatible / model information
> > -        with open(fname, 'rb') as inf:
> > -            data =3D inf.read()
> > -        fdt =3D libfdt.FdtRo(data)
> > -        model =3D fdt.getprop(0, 'model').as_str()
> > -        compat =3D fdt.getprop(0, 'compatible')
> > -
> > -        fsw.property_string('description', model)
> > +        fsw.property_string('description', os.path.basename(fname))
> >          fsw.property_string('type', 'flat_dt')
> >          fsw.property_string('arch', arch)
> >          fsw.property_string('compression', compress)
> > @@ -215,7 +210,6 @@ def output_dtb(fsw, seq, fname, arch, compress):
> >          with open(fname, 'rb') as inf:
> >              compressed =3D compress_data(inf, compress)
> >          fsw.property('data', compressed)
> > -    return model, compat
> >
> >
> >  def build_fit(args):
> > @@ -235,6 +229,7 @@ def build_fit(args):
> >      fsw =3D libfdt.FdtSw()
> >      setup_fit(fsw, args.name)
> >      entries =3D []
> > +    fdts =3D collections.OrderedDict()
>
>
> I am fine with this patch.
>
> Just a nit.
>
> Is there any reason why you used OrderedDict() instead of
> the normal dictionary, "fdts =3D {}" ?

I had wanted to use it as the main list of entries; using OrderedDict()
preserves the order that the DTBs were given. That didn't pan out.

I'll replace it with the standard dictionary.


ChenYu

