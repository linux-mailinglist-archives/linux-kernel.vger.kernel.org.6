Return-Path: <linux-kernel+bounces-173183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6768BFCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D8D285F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED082D90;
	Wed,  8 May 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6VCsAAm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A9823D1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169217; cv=none; b=tKQWg6lWTSub6xmxGEB7QTtljPoiL1ZASiIx+xxK2MDgv0698gtyfK1QDj0An1laIouI6SJFX3hN1hV4o8036Dpum1b6NOIdsRvMnTpnuZM5ru+Q6ib9hcTktXYmLBc4KxA4/Hj1wAuWFTy9IsXZu8VC8+lGoAzbMShpVE+YwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169217; c=relaxed/simple;
	bh=hYwn+JI3hSrV50VTfmR6XV0Ay3DMP/xwKfK4TzcbBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irnrXfo4soo24TPvIFE/xqtlTcE82Bds/ZwgO6hcrkkHF6I7lzrC+GmyA/E7yPVFNa2eZiKE7b++thQ3r5WucZjGIOe6o3f4n9V7np3Q/Kq4jZ8hc11vs78dKhO9GX+5S4JEvOoU//JMXxkutilTmmHjO6OWI6aklm0csl+iNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6VCsAAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F62CC3277B;
	Wed,  8 May 2024 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169216;
	bh=hYwn+JI3hSrV50VTfmR6XV0Ay3DMP/xwKfK4TzcbBFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6VCsAAmBEfWQLdNhiQFeJ6vEKrVRN5tmq+kb5I3MWPg3GFOLaYVWAGEgFkX5Ye64
	 vOnpV7tyk1mdhwHk3kiH7i5ys+Q9km6CyFSOkhH8lxmFshLQfzCSYzCCNQbnoKBBFw
	 68RDN0eUWsRIkWoXVb69ukGEG9DdfDX/ukPPawbXnPcKabHgnCc3XT9yeuAKnLWZRk
	 ONIVHK589AIF8B/wFRsX9O/9Ni9OGLLD08b90OZ3uHHQQXPn5O5kVJvxlL008Tv7he
	 CUvTD/OOrQ6zCumarW22kFgvu2M3rzLApki0b2LaR5W7GwALtzW3RErBIEOUO2nL3H
	 GzmJ44I4e3cZQ==
Date: Wed, 8 May 2024 20:53:34 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjtnvjlJpfNn7qVT@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
 <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
 <20240508065402.GA7462@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtC14iJaOWxhpsjn"
Content-Disposition: inline
In-Reply-To: <20240508065402.GA7462@linuxcarl2.richtek.com>
X-Cookie: Accuracy, n.:


--mtC14iJaOWxhpsjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2024 at 02:54:02PM +0800, Alina Yu wrote:

> May I modify the code into this ?
> I'll add 'richtek,fixed-microvolt' property in dtsi; remove 'regulator-min-microvolt' and 'regulator-max-microvolt'
> to prevent fail caused by constraints->apply_uV.

Adding the new property seems fine.  You still need to permit the
min/max microvolt properties for the case where the regulator is in
normal mode and can vary, you could write rules that ensure that the
constraints line up in the case where a fixed voltage is specified but
I'm not sure it's worth the effort.

--mtC14iJaOWxhpsjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY7Z7sACgkQJNaLcl1U
h9Aquwf9H+G8Hr6XIT+TdTjeWbKbmYnY5RaWfJdxK43T7eNU/oHJdAsLluk2/pVx
K/fkI82xYzAFuHBcOolpKy3Vxp7tMt2W3+edHzxSQWr+wWcJLlHWEpSWHrfjxMA/
1rCfVnpKZPZUJM+3CShDOHwWdwEtGQMEtH/+GTjxl/DJV3UCybGBQq+1O/0QPg0b
bXSFJtrpu56D5ePvApQKSBvrE6K9KPw5cgRh8/1SWLOIvQZNOnc5WybUuTRt6Q4O
IAJiS86ZvbvHOq4jK0dSYOzmRXjSknDrb2qzaQKCN4k7WJ3bWuwDm5i4MRUgITUI
qnqEDr00RhOleKjbf4AD4YG+GO7z2Q==
=iHZI
-----END PGP SIGNATURE-----

--mtC14iJaOWxhpsjn--

