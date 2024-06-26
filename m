Return-Path: <linux-kernel+bounces-230296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C2917AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D0C288819
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0A23BF;
	Wed, 26 Jun 2024 08:29:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BE160796
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390543; cv=none; b=Evn8hR/tXeuQ9H2TIaipnwhlq0fytlPNYsC0P5MfEbkDoTtjUC/REJsuXIlsbwrF96IWG/C6lDctUkgSedjHP1sBXgqCpHwXYcH3j5VMjyF3O+UHGvltCcae3dyUGTbZDLi9kBjilj4JYNrCnU3E1Z9OWe5QvJSNWI2NPBRtyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390543; c=relaxed/simple;
	bh=e1Kf2GbwZLvfE90s6c0/Y5wnIQjvF4O4IVPLgGghC5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzV1Mto1377CScbkIZG91m2VoEcDZQIa9uoFFTpps1ERdKDV0x1n3zqb/kSCP4pi2i65078Cf7JBx0oMGPsTP/us3ihEtd8FVnf+IoJKJnwAu7Uy3QCNYivjfileRqNZpO9GqCIeNVZ0JabrYitL1+SYl/cCnOh2Vr1Gsm51isQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sMO1Q-00064a-Jz; Wed, 26 Jun 2024 10:28:56 +0200
Message-ID: <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
From: Lucas Stach <l.stach@pengutronix.de>
To: Daniel Vetter <daniel@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Daniel Stone <daniel@fooishbar.org>, linux-kernel@vger.kernel.org, Oded
 Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie
 <airlied@gmail.com>,  etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Date: Wed, 26 Jun 2024 10:28:55 +0200
In-Reply-To: <ZnvDJVeT3rz-hnv9@phenom.ffwll.local>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
	 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
	 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
	 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
	 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
	 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
	 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Mittwoch, dem 26.06.2024 um 09:28 +0200 schrieb Daniel Vetter:
> On Mon, Jun 17, 2024 at 07:01:05PM +0200, Tomeu Vizoso wrote:
> > Hi Lucas,
> >=20
> > Do you have any idea on how not to break userspace if we expose a rende=
r node?
>=20
> So if you get a new chip with an incompatible 3d block, you already have
> that issue. And I hope etnaviv userspace can cope.
>=20
> Worst case you need to publish a fake extremely_fancy_3d_block to make
> sure old mesa never binds against an NPU-only instance.
>=20
> Or mesa just doesn't cope, in which case we need a etnaviv-v2-we_are_sorr=
y
> drm driver name, or something like that.

Mesa doesn't cope right now. Mostly because of the renderonly thing
where we magically need to match render devices to otherwise render
incapable KMS devices. The way this matching works is that the
renderonly code tries to open a screen on a rendernode and if that
succeeds we treat it as the matching render device.

The core of the issue is that we have no way of specifying which kind
of screen we need at that point, i.e. if the screen should have 3D
render capabilities or if compute-only or even NN-accel-only would be
okay. So we can't fail screen creation if there is no 3D engine, as
this would break the teflon case, which needs a screen for the NN
accel, but once we successfully create a screen reanderonly might treat
the thing as a rendering device.
So we are kind of stuck here between breaking one or the other use-
case. I'm leaning heavily into the direction of just fixing Mesa, so we
can specify the type of screen we need at creation time to avoid the
renderonly issue, porting this change as far back as reasonably
possible and file old userspace into shit-happens.

Regards,
Lucas

>=20
> >=20
> > Cheers,
> >=20
> > Tomeu
> >=20
> > On Wed, Jun 12, 2024 at 4:26=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso=
.net> wrote:
> > >=20
> > > On Mon, May 20, 2024 at 1:19=E2=80=AFPM Daniel Stone <daniel@fooishba=
r.org> wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > On Mon, 20 May 2024 at 08:39, Tomeu Vizoso <tomeu@tomeuvizoso.net> =
wrote:
> > > > > On Fri, May 10, 2024 at 10:34=E2=80=AFAM Lucas Stach <l.stach@pen=
gutronix.de> wrote:
> > > > > > Am Mittwoch, dem 24.04.2024 um 08:37 +0200 schrieb Tomeu Vizoso=
:
> > > > > > > If we expose a render node for NPUs without rendering capabil=
ities, the
> > > > > > > userspace stack will offer it to compositors and applications=
 for
> > > > > > > rendering, which of course won't work.
> > > > > > >=20
> > > > > > > Userspace is probably right in not questioning whether a rend=
er node
> > > > > > > might not be capable of supporting rendering, so change it in=
 the kernel
> > > > > > > instead by exposing a /dev/accel node.
> > > > > > >=20
> > > > > > > Before we bring the device up we don't know whether it is cap=
able of
> > > > > > > rendering or not (depends on the features of its blocks), so =
first try
> > > > > > > to probe a rendering node, and if we find out that there is n=
o rendering
> > > > > > > hardware, abort and retry with an accel node.
> > > > > >=20
> > > > > > On the other hand we already have precedence of compute only DR=
M
> > > > > > devices exposing a render node: there are AMD GPUs that don't e=
xpose a
> > > > > > graphics queue and are thus not able to actually render graphic=
s. Mesa
> > > > > > already handles this in part via the PIPE_CAP_GRAPHICS and I th=
ink we
> > > > > > should simply extend this to not offer a EGL display on screens=
 without
> > > > > > that capability.
> > > > >=20
> > > > > The problem with this is that the compositors I know don't loop o=
ver
> > > > > /dev/dri files, trying to create EGL screens and moving to the ne=
xt
> > > > > one until they find one that works.
> > > > >=20
> > > > > They take the first render node (unless a specific one has been
> > > > > configured), and assumes it will be able to render with it.
> > > > >=20
> > > > > To me it seems as if userspace expects that /dev/dri/renderD* dev=
ices
> > > > > can be used for rendering and by breaking this assumption we woul=
d be
> > > > > breaking existing software.
> > > >=20
> > > > Mm, it's sort of backwards from that. Compositors just take a
> > > > non-render DRM node for KMS, then ask GBM+EGL to instantiate a GPU
> > > > which can work with that. When run in headless mode, we don't take
> > > > render nodes directly, but instead just create an EGLDisplay or
> > > > VkPhysicalDevice and work backwards to a render node, rather than
> > > > selecting a render node and going from there.
> > > >=20
> > > > So from that PoV I don't think it's really that harmful. The only
> > > > complication is in Mesa, where it would see an etnaviv/amdgpu/...
> > > > render node and potentially try to use it as a device. As long as M=
esa
> > > > can correctly skip, there should be no userspace API implications.
> > > >=20
> > > > That being said, I'm not entirely sure what the _benefit_ would be =
of
> > > > exposing a render node for a device which can't be used by any
> > > > 'traditional' DRM consumers, i.e. GL/Vulkan/winsys.
> > >=20
> > > What I don't understand yet from Lucas proposal is how this isn't
> > > going to break existing userspace.
> > >=20
> > > I mean, even if we find a good way of having userspace skip
> > > non-rendering render nodes, what about existing userspace that isn't
> > > able to do that? Any updates to newer kernels are going to break them=
.
> > >=20
> > > Regards,
> > >=20
> > > Tomeu
>=20


