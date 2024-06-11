Return-Path: <linux-kernel+bounces-210552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2E904572
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A74928196A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A2142620;
	Tue, 11 Jun 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tkf6+iDU"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCB6FE16
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136081; cv=none; b=hLJk/Xvj3mlAXE1HD7birskY5mG2gEMMVLIXzmEfjNOxS0R89PPbfjOzsl4ZVxttVwMu6QYurJTAl9MO2jxWTtra6/mXi2Sina5zsLAxGIStIAom5UyIhSZx57kkgBx0j3D69qAA0aK4KymIKalZbXvPdTC2sUtrCE2z5UCIjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136081; c=relaxed/simple;
	bh=nj4txX9NOXHr1GSCcPh3azn4AKxGp53EaR108BbIBFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcbFahVcjWbAYIYn7syHyn+sAauIsvQICeb4TXY+Ahi2Wt0P4HpJviJQfc4GSGHMud8VnY0FmrYwX3N8jbIMOZd4+yv/2FZVfnUbbSApYAcSFZBRkIePXM8WSk3/lRYJVcmeuEq/AOgYdXGjt5uBF4KIHI+jVt0igkhbEqxJ2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tkf6+iDU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b06b78e716so19692846d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718136078; x=1718740878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofRb2SrWSloDhDcm+em+RivA2vCOFT1sC1oLoIGdbIU=;
        b=Tkf6+iDUJ46jL2ZixIp0tCBp2ryK9HAgEk0c0RBjAbTMqC2VeRuEP6ffgsRwNgHejE
         DB7G/bPZFEhor0dx7xZwMXLhXesHfLzSTXlT/x34eHQxCaoFN4WjidNlnbkzqrRShK0D
         o8xmH0KcYWpTcG22zf9tjxu2+IPpZba/4EL+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136078; x=1718740878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofRb2SrWSloDhDcm+em+RivA2vCOFT1sC1oLoIGdbIU=;
        b=XgwHN8QS9F3XZRmPVB4fxTmkV+5y//BCLsKUCLY+N22X+qnHxTsW+d/Jy0eB4CiEeD
         gTG1l79oc2qWYLWQX4mYL4+SJfGJiugIZ28v/zQQqE6U2NB28aEeihkYGcDtqTzZqrkJ
         xUcI8FwxvbulD6iR08zW8z7JMGs0ovuhKgelJdnCj+r1DnBRrdM4Iei5Z4SM7p1k7eA8
         gT1ieK+89oP7g5xAHH7pIglqwqgMmLoOheAg3evdTHGJLA7nB7AP0yk6lIrUvLnU62ZQ
         Ob1S7MEsjkubcwMMe+cWq2PZYx10HD7MAkSMXLCjMfYsTLCdRgH5f1cw6X4KDCXKJmGh
         kazw==
X-Forwarded-Encrypted: i=1; AJvYcCUvW3DuKBshEM3n4afdaTsI6LbXzG4CzGhpuEGYX6Uly1XNrH6HEyh6o+Te8ztOFfJAEB2K4C+LgXKhOCBVnibnZHb26MeZF7mzXjfJ
X-Gm-Message-State: AOJu0Yx1GuyPHgO/YPBrOF3Pva2VNOzXtBcAhEH0e0li7mxQP+cPgwGD
	4+q+MpZ4x/TpuJ0D1hwb0Ytbajjezv3HQzecjXPzhp9v8zdBwYsD1si696SKSKMnKgq2hl6NJ/N
	AmCV4lRjIv/Z7QUb6mzhlYOTF7OJaZOtyAg6islT5TOtPAhA=
X-Google-Smtp-Source: AGHT+IGRUCqn3QJCs8/9hdjyKDSm0DH/nr44i9ZEurwfmAC2CHa4R2FqywjruzcI4fdTDvXZQEvAoAxzDbY/DUchLYo=
X-Received: by 2002:a05:6214:4883:b0:6b0:65cd:c09f with SMTP id
 6a1803df08f44-6b065cdc35dmr119734166d6.18.1718136078389; Tue, 11 Jun 2024
 13:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605094843.4141730-1-wenst@chromium.org>
In-Reply-To: <20240605094843.4141730-1-wenst@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 14:01:07 -0600
Message-ID: <CAFLszTiZ8PUvxHx4kfLZf18RqSczRwxCmCxZ_y6J2rpu03pA=w@mail.gmail.com>
Subject: Re: [PATCH] scripts/make_fit: Support decomposing DTBs
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Chen-Yu,

On Wed, 5 Jun 2024 at 03:48, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> The kernel tree builds some "composite" DTBs, where the final DTB is the
> result of applying one or more DTB overlays on top of a base DTB with
> fdtoverlay.
>
> The FIT image specification already supports configurations having one
> base DTB and overlays applied on top. It is then up to the bootloader to
> apply said overlays and either use or pass on the final result. This
> allows the FIT image builder to reuse the same FDT images for multiple
> configurations, if such cases exist.
>
> The decomposition function depends on the kernel build system, reading
> back the .cmd files for the to-be-packaged DTB files to check for the
> fdtoverlay command being called. This will not work outside the kernel
> tree. The function is off by default to keep compatibility with possible
> existing users.
>
> To facilitate the decomposition and keep the code clean, the model and
> compatitble string extraction have been moved out of the output_dtb
> function. The FDT image description is replaced with the base file name
> of the included image.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This is a feature I alluded to in my replies to Simon's original
> submission of the make_fit.py script [1].
>
> This is again made a runtime argument as not all firmware out there
> that boot FIT images support applying overlays. Like my previous
> submission for disabling compression for included FDT images, the
> bootloader found in RK3399 and MT8173 Chromebooks do not support
> applying overlays. Another case of this is U-boot shipped by development
> board vendors in binary form (without upstream) in an image or in
> SPI flash on the board that were built with OF_LIBFDT_OVERLAY=n.
> These would fail to boot FIT images with DT overlays. One such
> example is my Hummingboard Pulse. In these cases the firmware is
> either not upgradable or very hard to upgrade.
>
> I believe there is value in supporting these cases. A common script
> shipped with the kernel source that can be shared by distros means
> the distro people don't have to reimplement this in their downstream
> repos or meta-packages. For ChromeOS this means reducing the amount
> of package code we have in shell script.
>
> [1] https://lore.kernel.org/linux-kbuild/20231207142723.GA3187877@google.com/
> [2]
>
>  scripts/Makefile.lib |  1 +
>  scripts/make_fit.py  | 70 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 49 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Some possible nits / changes below

>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 9f06f6aaf7fc..d78b5d38beaa 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -522,6 +522,7 @@ quiet_cmd_fit = FIT     $@
>        cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
>                 --name '$(UIMAGE_NAME)' \
>                 $(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
> +               $(if $(FIT_DECOMPOSE_DTBS),--decompose-dtbs) \
>                 --compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
>
>  # XZ
> diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> index 263147df80a4..120f13e1323c 100755
> --- a/scripts/make_fit.py
> +++ b/scripts/make_fit.py
> @@ -22,6 +22,11 @@ the entire FIT.
>  Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
>  zstd algorithms.
>
> +Use -d to decompose "composite" DTBs into their base components and
> +deduplicate the resulting base DTBs and DTB overlays. This requires the
> +DTBs to be sourced from the kernel build directory, as the implementation
> +looks at the .cmd files produced by the kernel build.
> +
>  The resulting FIT can be booted by bootloaders which support FIT, such
>  as U-Boot, Linuxboot, Tianocore, etc.
>
> @@ -64,6 +69,8 @@ def parse_args():
>            help='Specifies the architecture')
>      parser.add_argument('-c', '--compress', type=str, default='none',
>            help='Specifies the compression')
> +    parser.add_argument('-d', '--decompose-dtbs', action='store_true',
> +          help='Decompose composite DTBs into base DTB and overlays')

I wonder if we should reserve -d for --debug? I don't have a strong
opinion though.

>      parser.add_argument('-E', '--external', action='store_true',
>            help='Convert the FIT to use external data')
>      parser.add_argument('-n', '--name', type=str, required=True,
> @@ -140,12 +147,12 @@ def finish_fit(fsw, entries):
>      fsw.end_node()
>      seq = 0
>      with fsw.add_node('configurations'):
> -        for model, compat in entries:
> +        for model, compat, files in entries:
>              seq += 1
>              with fsw.add_node(f'conf-{seq}'):
>                  fsw.property('compatible', bytes(compat))
>                  fsw.property_string('description', model)
> -                fsw.property_string('fdt', f'fdt-{seq}')
> +                fsw.property('fdt', b''.join([b'fdt-%d\x00' % x for x in files]))

This looks right to me. It would be nice to use an f string but I
don't know how to do that with bytes.

But do you need the inner [] ?

>                  fsw.property_string('kernel', 'kernel')
>      fsw.end_node()
>
> @@ -193,21 +200,9 @@ def output_dtb(fsw, seq, fname, arch, compress):
>          fname (str): Filename containing the DTB
>          arch: FIT architecture, e.g. 'arm64'
>          compress (str): Compressed algorithm, e.g. 'gzip'
> -
> -    Returns:
> -        tuple:
> -            str: Model name
> -            bytes: Compatible stringlist
>      """
>      with fsw.add_node(f'fdt-{seq}'):
> -        # Get the compatible / model information
> -        with open(fname, 'rb') as inf:
> -            data = inf.read()
> -        fdt = libfdt.FdtRo(data)
> -        model = fdt.getprop(0, 'model').as_str()
> -        compat = fdt.getprop(0, 'compatible')
> -
> -        fsw.property_string('description', model)
> +        fsw.property_string('description', os.path.basename(fname))
>          fsw.property_string('type', 'flat_dt')
>          fsw.property_string('arch', arch)
>          fsw.property_string('compression', compress)
> @@ -215,7 +210,6 @@ def output_dtb(fsw, seq, fname, arch, compress):
>          with open(fname, 'rb') as inf:
>              compressed = compress_data(inf, compress)
>          fsw.property('data', compressed)
> -    return model, compat
>
>
>  def build_fit(args):
> @@ -235,6 +229,7 @@ def build_fit(args):
>      fsw = libfdt.FdtSw()
>      setup_fit(fsw, args.name)
>      entries = []
> +    fdts = collections.OrderedDict()
>
>      # Handle the kernel
>      with open(args.kernel, 'rb') as inf:
> @@ -243,12 +238,43 @@ def build_fit(args):
>      write_kernel(fsw, comp_data, args)
>
>      for fname in args.dtbs:
> -        # Ignore overlay (.dtbo) files
> -        if os.path.splitext(fname)[1] == '.dtb':
> -            seq += 1
> -            size += os.path.getsize(fname)
> -            model, compat = output_dtb(fsw, seq, fname, args.arch, args.compress)
> -            entries.append([model, compat])
> +        # Ignore non-DTB (*.dtb) files
> +        if os.path.splitext(fname)[1] != '.dtb':
> +            continue
> +
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data = inf.read()
> +        fdt = libfdt.FdtRo(data)
> +        model = fdt.getprop(0, 'model').as_str()
> +        compat = fdt.getprop(0, 'compatible')
> +
> +        if args.decompose_dtbs:
> +            # Check if the DTB needs to be decomposed
> +            path, basename = os.path.split(fname)
> +            cmd_fname = os.path.join(path, f'.{basename}.cmd')
> +            with open(cmd_fname, 'r', encoding='ascii') as inf:
> +                cmd = inf.read()
> +
> +            if 'scripts/dtc/fdtoverlay' in cmd:
> +                # This depends on the structure of the composite DTB command
> +                files = cmd.split()
> +                files = files[files.index('-i')+1:]

spaces around +

> +            else:
> +                files = [fname]
> +        else:
> +            files = [fname]

I do wonder if the code from '# Get the compatible' to here would be
better in a separate, documented function, to keep things easier to
understand?

> +
> +        for fn in files:
> +            if fn not in fdts:
> +                seq += 1
> +                size += os.path.getsize(fn)
> +                output_dtb(fsw, seq, fn, args.arch, args.compress)
> +                fdts[fn] = seq
> +
> +        files_seq = [fdts[fn] for fn in files]
> +
> +        entries.append([model, compat, files_seq])
>
>      finish_fit(fsw, entries)
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>

Regards,
Simon

