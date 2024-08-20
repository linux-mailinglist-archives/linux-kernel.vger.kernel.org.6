Return-Path: <linux-kernel+bounces-293082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE8957A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC11F237DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C3A955;
	Tue, 20 Aug 2024 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNLI7ch0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999E101C4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114606; cv=none; b=FO3qg+8b5L9XZt3GRkQBFha+XSvqiuRCaa0uSJpHTjQvXJj5+nFcLq55jVAT0f//uFG3J219xzzw/7c8JoUiSYfB3NnU1OpDX7kMOdWWYPM+b1w5p893M45YCd9JKXBZ/u8Bb1w1C027MxzEvVMFARgvrZT8exrfOzxenL8ZhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114606; c=relaxed/simple;
	bh=XtYrfZiozxfmaeOZ1goxBVZ0Ujmn12Vv5JPi8m4Gnx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDD5njCQkKmtuCLuPq2YskI6UuYEeS7GUd6zNOrayqeFuSqfbJR6qtGTL3sUpYITJjqWpy4b8i5+ow53+pp9eApwe3TYsq89JsVI7AaBRZUAU55/5FLrCH48HvJFWqPrBOR++HmCPTrlDnl5xIxZwrK9r6XwYes8Ka1k01dyHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNLI7ch0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso3692a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724114603; x=1724719403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h08XLcouV8ctMHeHfm4Qn2GO+dX4YjaNC9jUG/X1dRs=;
        b=JNLI7ch0WbO56QhhOQnq9KR2IZbSqrIw+WPQ+unLuQsFZvEJYhtwMzytPnbGaHrtiN
         eE3HEx/G+4r2UNZEjoLfEKdTetmgq3bG/apuK8N0TVPK3QQEMa+G9l5+duq+kZp8IjYE
         fKHbOli7UifiYxkz0ofsdWNYhesipK4pAJSKYvN7jsO8+o3f5jPs2PIfihLdMFUGSA6d
         BRtisXYzqUQ7Ilg5S4EV1QYcycX5XoSzV59i70ssn4F5hlLladTeF172hGLaxUjazLUb
         rqeoOP5TTekDmksYT+tgWemlsB3NZoST9yomHmy2KmfWax4AKVvKY29t7Eb4JvRPA+rz
         vtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114603; x=1724719403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h08XLcouV8ctMHeHfm4Qn2GO+dX4YjaNC9jUG/X1dRs=;
        b=IZpIqtWqlgzW15bNGmFM0o99n4ge4/T9jqxzs42GmWwYnWYw+FPh6qhkiZj4MhZUSY
         nRJkwDdVLYJsw9gWyAnNQcoh+cHC5TcuKs4JVkwrlmQZyAFI5FA4JZVjShTCWYAljnXV
         xOC9MKCsS0Q+rqsxBRPCfP7b6WhZ/UtoXHBIkaVF2/hTtLMpuYzEpToCgrp1z5OOOJis
         ujHX9lVQAtH+87M4S86B3FKxZg7fx1BbmnspFBh+zmvdpUN7v2+yHtit661GGyhnHWgj
         A+320alWgYwvkBMp8Krr3Rd2l8JJEm2IjwHpVuIascxDrJAbeuU7Q/90Tuzv8JvL3C9c
         y94Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd+HGstoKD83rUwcxNsRFp0dFrbNI2x8KsJcE0lo+Q35hJyvS7nPNSEBs6w4wJ6+SapdL/jibV0L7I0/KMEsJAXsNN13Na3eay9jFM
X-Gm-Message-State: AOJu0YyV86Z/AwpUAiHsbgO6n1yvGxG/VgNCWdVNqUHHWBbuFs55BISG
	FpeS+leghX8Z4tmoyFPOrTvLd/c2nbWDQsfSa/pcM0rcPEzpeMeQnwRGFEfdVo6HhQ5nIKm1I4+
	ive8CozOFSFGAl/s3QaAc5NT3q1jgZ9PyCqE/
X-Google-Smtp-Source: AGHT+IGCRS9VVUhNY3XyW+Uv/RkSJSZiEH4jeKVuQwFg+gD2lMusd8GhyeKyy/UFIQrg5tgHS8vjUMVhH9tEGGHDXqM=
X-Received: by 2002:a05:6402:34c4:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5bf0e593022mr15264a12.1.1724114602199; Mon, 19 Aug 2024
 17:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
 <ZsPf02GrdMiyZP8a@pollux> <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>
In-Reply-To: <CAG48ez3AEU+LD-i7Qwo3kreJ0zGQEZOnthFX++QTUOMxe3e40Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 Aug 2024 02:42:46 +0200
Message-ID: <CAG48ez3nUfUS3Ec=tMS91w20N2vY-D+_c_k19-=5hs0-_MLmfA@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: Block path traversal
To: Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:23=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Tue, Aug 20, 2024 at 2:14=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
> > On Tue, Aug 20, 2024 at 01:18:54AM +0200, Jann Horn wrote:
> > > Most firmware names are hardcoded strings, or are constructed from fa=
irly
> > > constrained format strings where the dynamic parts are just some hex
> > > numbers or such.
> > >
> > > However, there are a couple codepaths in the kernel where firmware fi=
le
> > > names contain string components that are passed through from a device=
 or
> > > semi-privileged userspace; the ones I could find (not counting interf=
aces
> > > that require root privileges) are:
> > >
> > >  - lpfc_sli4_request_firmware_update() seems to construct the firmwar=
e
> > >    filename from "ModelName", a string that was previously parsed out=
 of
> > >    some descriptor ("Vital Product Data") in lpfc_fill_vpd()
> > >  - nfp_net_fw_find() seems to construct a firmware filename from a mo=
del
> > >    name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), whi=
ch I
> > >    think parses some descriptor that was read from the device.
> > >    (But this case likely isn't exploitable because the format string =
looks
> > >    like "netronome/nic_%s", and there shouldn't be any *folders* star=
ting
> > >    with "netronome/nic_". The previous case was different because the=
re,
> > >    the "%s" is *at the start* of the format string.)
> > >  - module_flash_fw_schedule() is reachable from the
> > >    ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked a=
s
> > >    GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace=
 is
> > >    enough to pass the privilege check), and takes a userspace-provide=
d
> > >    firmware name.
> > >    (But I think to reach this case, you need to have CAP_NET_ADMIN ov=
er a
> > >    network namespace that a special kind of ethernet device is mapped=
 into,
> > >    so I think this is not a viable attack path in practice.)
> > >
> > > For what it's worth, I went looking and haven't found any USB device
> > > drivers that use the firmware loader dangerously.
> >
> > Your commit message very well describes the status quo, but only implie=
s the
> > problem, and skips how you intend to solve it.
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware fil=
es directly from the filesystem")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I wasn't sure whether to mark this one for stable or not - but I thin=
k
> > > since there seems to be at least one PCI device model which could
> > > trigger firmware loading with directory traversal, we should probably
> > > backport the fix?
> > > ---
> > >  drivers/base/firmware_loader/main.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmw=
are_loader/main.c
> > > index a03ee4b11134..a32be64f3bf5 100644
> > > --- a/drivers/base/firmware_loader/main.c
> > > +++ b/drivers/base/firmware_loader/main.c
> > > @@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmwa=
re_p, const char *name,
> > >       if (!firmware_p)
> > >               return -EINVAL;
> > >
> > > -     if (!name || name[0] =3D=3D '\0') {
> > > +     /*
> > > +      * Reject firmware file names with "/../" sequences in them.
> > > +      * There are drivers that construct firmware file names from
> > > +      * device-supplied strings, and we don't want some device to be=
 able
> > > +      * to tell us "I would like to be sent my firmware from
> > > +      * ../../../etc/shadow, please".
> > > +      */
> > > +     if (!name || name[0] =3D=3D '\0' ||
> > > +         strstr(name, "/../") !=3D NULL || strncmp(name, "../", 3) =
=3D=3D 0) {
> >
> > Seems reasonable, but are there any API users that rely on that?
>
> I tried grepping for in-kernel users and didn't find any, though I
> guess I could have missed something.
> I suppose slightly more likely than in-kernel users, there could be
> userspace code out there that intentionally uses netlink or sysfs
> interfaces to tell the kernel to load from firmware paths outside the
> firmware directory, though that would be kinda weird?

I guess if we are seriously concerned that someone might rely on that,
there are several things we could do to mitigate it, ordered by
increasing level of how annoying it would be to implement and how much
it would nerf the check:

1. add a pr_warn() specifically for this case, so if it does break,
users know what's wrong and can complain - I think I should probably
do that in v2 anyway
2. add a module parameter to disable the check, so if it does break,
users can immediately work around the issue
3. make the whole thing just a warning for now, and revisit it in a
year or so to enable enforcement

My preference would be to implement number 1 but not 2/3, but if you
think that's not enough to merge it, I could implement 2 or 3...

