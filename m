Return-Path: <linux-kernel+bounces-245693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5292B630
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08292836E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B881157E61;
	Tue,  9 Jul 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzsbke4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D808156F45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523373; cv=none; b=ca+7KNvD7XSQcyButQXQzPvA/VBgTHeFRfuujUy255q4vaItCgTeVAyw0tztYox0oKcgMyC35CXTXXQySUwSj5Rf6UcNFxY8PFCCSql/ure73G92Qx5daGp983vJ/MY7Ln5J0y7AUNzmwxuJp/8PEG4AH8QinTNVWvxoqZSQ5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523373; c=relaxed/simple;
	bh=FXUkXbQUEspDSkw/HVpFFZAVrtoTx09LZKNLAG6JZuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpJVUDdjRY9fEC0VfZ3XJ7tI2/l4STXUbEuJuauQRrwuQ0IewAEXmGy7/OJ20HFGZWUnKJfhLq6/SRdS7MeImdc/IKGevSkMjIEDNsD7WOKp2o2S37x9skNFvGn+28v8XFAvXHx3pghV0CzWp210vyX1FlsA53LmudT3gRQt6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzsbke4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF727C3277B;
	Tue,  9 Jul 2024 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720523373;
	bh=FXUkXbQUEspDSkw/HVpFFZAVrtoTx09LZKNLAG6JZuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzsbke4/exLO4Xl4SqTLG6hiifRc34fVQtWOddtnZ+EUJgKmI7p9pwohDxy+ni4FZ
	 R9sOC46KJBzU1KRFruWYGkpDgVBs8BqW2FuKFwR4pnF8HQzDCVZnkDzD3y0pJKZ00p
	 qq0SxVQp+NXk7QeR6KToscr5lFlpkfDHcAbU2YvE4B9vE9n73gDov2XKtHYoaeb04+
	 J9URmF7sjiuuvE3+JgSLdzPaBb/9CuUMu1V4wmjH4Rr2BVROuE6A4X2Oquo5bAb5Jj
	 PHiDdCO7T5r4MSWjOVIaiQY+6jbh563cQW8dJu/2DGuMUfSHLdPetKCXA2GoKIvwMQ
	 ElEkddqarH3aQ==
Date: Tue, 9 Jul 2024 13:09:30 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for
 firmware loading
Message-ID: <20240709-exuberant-tentacled-oxpecker-bd1ea0@houat>
References: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
 <109c6f19.2559.1907b817a99.Coremail.andyshrk@163.com>
 <0bf4701d98833609b917983718c610aa@manjaro.org>
 <2fd3aabd.785b.190914ec1a6.Coremail.andyshrk@163.com>
 <f0fb9feed2d9262bb4d7c8ade836af62@manjaro.org>
 <909d072.9028.19096c2429a.Coremail.andyshrk@163.com>
 <31062b80d3f9e11c339c400a70464f43@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mrun7l74cyv4hvms"
Content-Disposition: inline
In-Reply-To: <31062b80d3f9e11c339c400a70464f43@manjaro.org>


--mrun7l74cyv4hvms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 12:10:51PM GMT, Dragan Simic wrote:
> On 2024-07-09 11:10, Andy Yan wrote:
> > At 2024-07-09 16:17:06, "Dragan Simic" <dsimic@manjaro.org> wrote:
> > > On 2024-07-08 09:46, Andy Yan wrote:
> > > > At 2024-07-04 18:35:42, "Dragan Simic" <dsimic@manjaro.org> wrote:
> > > > > On 2024-07-04 04:10, Andy Yan wrote:
> > > > > > At 2024-07-04 07:32:02, "Dragan Simic" <dsimic@manjaro.org> wro=
te:
> > > > > > > After the additional firmware-related module information was
> > > > > > > introduced by
> > > > > > > the commit c0677e41a47f ("drm/rockchip: cdn-dp-core: add
> > > > > > > MODULE_FIRMWARE
> > > > > > > macro"), there's no longer need for the
> > > > > > > firmware-loading workarounds
> > > > > > > whose
> > > > > > > sole purpose was to prevent the missing firmware
> > > > > > > blob in an initial
> > > > > > > ramdisk
> > > > > > > from causing driver initialization to fail.  Thus, delete the
> > > > > > > workarounds,
> > > > > > > which removes a sizable chunk of redundant code.
> > > > > >=20
> > > > > > What would happen if there was no ramdisk? And the firmware is =
in
> > > > > > rootfs =EF=BC=9F
> > > > > >=20
> > > > > > For example=EF=BC=9A A buildroot based tiny embedded system=E3=
=80=82
> > > > >=20
> > > > > Good point, let me explain, please.
> > > > >=20
> > > > > In general, if a driver is built into the kernel, there
> > > > > should also be
> > > > > an initial ramdisk that contains the related firmware blobs, beca=
use
> > > > > it's
> > > > > unknown is the root filesystem available when the driver is probe=
d.
> > > > > If
> > > > > a driver is built as a module and there's no initial ramdisk, hav=
ing
> > > > > the related firmware blobs on the root filesystem should be fine,
> > > > > because
> > > > > the firmware blobs and the kernel module become available at
> > > > > the same
> > > > > time, through the root filesystem. [1]
> > > > >=20
> > > > > Another option for a driver built statically into the kernel, when
> > > > > there's
> > > > > no initial ramdisk, is to build the required firmware blobs into =
the
> > > > > kernel
> > > > > image. [2]  Of course, that's feasible only when a kernel image is
> > > > > built
> > > > > specificially for some device, because otherwise it would become =
too
> > > > > large
> > > > > because of too many drivers and their firmware blobs becoming
> > > > > included,
> > > > > but that seems to fit the Buildroot-based example.
> > > > >=20
> > > > > To sum it up, mechanisms already exist in the kernel for various
> > > > > scenarios
> > > > > when it comes to loading firmware blobs.  Even if the deleted
> > > > > workaround
> > > > > attempts to solve some issue specific to some environment,
> > > > > that isn't
> > > > > the
> > > > > right place or the right way for solving any issues of that kind.
> > > > >=20
> > > > > While preparing this patch, I even tried to find another
> > > > > kernel driver
> > > > > that
> > > > > also implements some similar workarounds for firmware loading, to
> > > > > justify
> > > > > the existence of such workarounds and to possibly move them into =
the
> > > > > kernel's
> > > > > firmware-loading interface.  Alas, I was unable to find such
> > > > > workarounds
> > > > > in
> > > > > other drivers, which solidified my reasoning behind classifying t=
he
> > > > > removed
> > > > > code as out-of-place and redundant.
> > > >=20
> > > > For some tiny embedded system=EF=BC=8Cthere is no such ramdisk=EF=
=BC=8Cfor example=EF=BC=9A
> > > > a buildroot based rootfs=EF=BC=8Cthe buildroot only generate rootfs=
=E3=80=82
> > > >=20
> > > > And FYI=EF=BC=8C there are mainline drivers try to fix such issue by
> > > > defer_probe=EF=BC=8Cfor example=EF=BC=9A
> > > > smc_abc[0]
> > > > There are also some other similar scenario in gpu driver{1}[2]
> > > >=20
> > > > [0]https://elixir.bootlin.com/linux/latest/source/drivers/tee/optee=
/smc_abi.c#L1518
> > > > [1]https://patchwork.kernel.org/project/dri-devel/patch/20240109120=
604.603700-1-javierm@redhat.com/
> > > > [2]https://lore.kernel.org/dri-devel/87y1918psd.fsf@minerva.mail-ho=
st-address-is-not-set/T/
> > >=20
> > > Thanks for providing these examples.
> > >=20
> > > Before I continue thinking about the possible systemic solution,
> > > could you please clarify the way Buildroot builds the kernel and
> > > prepares the root filesystem?  I'm not familiar with Buildroot,
> > > but it seems to me that it builds the drivers statically into the
> > > produced kernel image, while it places the related firmware blobs
> > > into the produced root filesystem.  Am I right there?
> >=20
> > in practice we can chose build the drivers statically into the kernel=
=EF=BC=8C
> > we can also build it as a module=E3=80=82
> > And in both case=EF=BC=8C the firmware blobs are put in rootfs=E3=80=82
> > If the drivers is built as a module=EF=BC=8C the module will also put in
> > rootfs=EF=BC=8C
> > so its fine=E3=80=82
> > But if a drivers is built into the kernel =EF=BC=8Cit maybe can't acces=
s the
> > firmware blob
> > before the rootfs is mounted.
> > So we can see some drivers try to use  DEFER_PROBE to fix this issue.
>=20
> When Buildroot builds the drivers statically into the kernel image,
> can it also be told to build the required firmware blobs into the
> kernel image, for which there's already support in the kernel?
>=20
> Of course, that would be feasible if only a small number of firmware
> blobs would end up built into the kernel image, i.e. if the Buildroot
> build would be tailored for a specific board.

IIRC, it can, but it's not really convenient from a legal point of view.

> Otherwise...
>=20
> > > As I already wrote earlier, and as the above-linked discussions
> > > conclude, solving these issues doesn't belong to any specific driver.
> > > It should be resolved within the kernel's firmware loading mechanism
> > > instead, and no driver should be specific in that regard.
> >=20
> > IT would be good if it can be resolved within the kernel's  firmware
> > loading mechanism.
>=20
> ... we'll need this as a systemic solution.

The general policy has been to put drivers that need a firmware as a
module, and just never build them statically.

Maxime

--mrun7l74cyv4hvms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZo0aZQAKCRAnX84Zoj2+
duQXAX9Ms7O+/0tW/78X0hREfX//aho/GXBlOL08FaPaawYipsYuGwkuSK4xC+TQ
3SVdsKIBgMufiC9PXKOysm7HIFZiDuMPBNPHv80tBJqv56TzkdtGbOh1EsHigFIM
nMK0oN9Ezw==
=Grb7
-----END PGP SIGNATURE-----

--mrun7l74cyv4hvms--

