Return-Path: <linux-kernel+bounces-387114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF19B4C18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC9DB2286D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D9206071;
	Tue, 29 Oct 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2P4xbx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EC1361
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212366; cv=none; b=ThYGCraip7qjhb/LQ2Suh2TODe2l0JslQODDpZL8aJicTVKDDkoPybWI4/HoTkTCDRKcrLlV+eziTApc9Et28bJDTZZ6GbE8EBz34YeWnRzsJ0r0l1wjkJg83p65kcVWmMbethj/OYqYbm+ggxufq+2/BsBctQBtyTQuxJgVNPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212366; c=relaxed/simple;
	bh=WItBgIV0GU3wi1md6pB8e4p7+yA2r/J9W+RyvNglabM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMMfl/5nsxbGFhIK7XRrqb6eV3SjMQXIgfAdpHCXvCw4y5Pd98uJw/5+FgcMHCqAEsw/L6BbbnKTn65gBamdw2g+S0328SnxPEQ3Zsp2cEdEtKIJsrteCdWGMJtTzaDaQOdnuiRQW8+yv115tcjsVzD0B1m7V1+9UgwI1zemO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2P4xbx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A98C4CEE9;
	Tue, 29 Oct 2024 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730212365;
	bh=WItBgIV0GU3wi1md6pB8e4p7+yA2r/J9W+RyvNglabM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2P4xbx15mT+nMxefjeR1EdHhLgLB/PN8lNtorsMTnwNptsLCWEUl6DLpFLx6pFeu
	 7O36qjFYAgELwaaZil29H4kQyoiGc2XJgJtZiISO5y0o/uuXqg5JeNqrcUnKz+LbmD
	 59jXnD6XZktL/r6TJtd7yhvphjBEBEc/BVvwisAVuYmc3zCvYKWkd0NUBSpMmqQQEp
	 YcGs46KScVoGbbK9dWFKwzIZk1KHYa0H+eo3yKzKH5awl87ZpGWUnmUwmH/iOkpUFy
	 GfbYIfD9cqk2koogAPMBE5BhvN7rBed5pH6O8lCp/1G+zauKwQJZIhNrZE98GhnX4s
	 e+F/mw5dpH7yA==
Date: Tue, 29 Oct 2024 14:32:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH] regcache: Store values more directly in maple trees
Message-ID: <697a0b84-af26-41fb-bdd9-3092f84eb4a3@sirena.org.uk>
References: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
 <CAMuHMdW6KvV+HQPY28ASeGJo_xejqRFFatmFD_2ST9R+Gt-d0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xaG+bMQxe8olAZVs"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW6KvV+HQPY28ASeGJo_xejqRFFatmFD_2ST9R+Gt-d0Q@mail.gmail.com>
X-Cookie: May be too intense for some viewers.


--xaG+bMQxe8olAZVs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 03:26:41PM +0100, Geert Uytterhoeven wrote:
> On Thu, Sep 26, 2024 at 12:20=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > + * On 64 bit systems uintptr_t will be 64 bit but unsigned long 32 bit
> > + * so we can store the register values directly in the maple tree.  We

> ... as this assumption is not true: "unsigned long" is 64-bit on
> 64-bit platforms (and 32-bit on 32-bit platforms).

You're right, I'm not sure what I was thinking there.  I think it was
confusion caused by the spurious warnings generated with u64.

--xaG+bMQxe8olAZVs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcg8gAACgkQJNaLcl1U
h9A+6wgAhGmzPJDimNqE+yKSh+2VQOzfXTpPhjBOXRdVLlfWSQZfK6u1zVzH4iF2
fIrWZVa70EEIOZXIKc9J5ZGUCnFbRIuaQbj0TB9MAT3kZRSfVi0dNaa57cjVFLOv
iO5ZV/3lu8XnaliP93savM+4xq4U6HzQO8TtPoBgPbeqdtZ5OjkGNQXWVnOgPZLA
e+golil4ovVrZz/zf9wARvcYr3kMbdT97lb46EzjmFe6gAn/ZkiOUicv+UmhJqSk
l0u4YcMzLhNorYUPwdrF0YaN9Bypd0aJFBa06D3lGTJ4c9vCKwSRvgPZM5AewkJ3
fhJPLMGjHvAuXJ2Afs16YRRoFv+XaQ==
=96Eg
-----END PGP SIGNATURE-----

--xaG+bMQxe8olAZVs--

