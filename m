Return-Path: <linux-kernel+bounces-577247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78EA71A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B364C7A5753
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7311F3BB2;
	Wed, 26 Mar 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5SOdSUX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188601624D2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003066; cv=none; b=cNLPdpVnhHlCTHMeZ1O6JFSUrX68eJYmluo57cyMI1w0cf4Iu9brr2/gKEzD8+BMISLm6opjeesUOaA9sxSgdjvIk0YaOHJubsADcYyZAU1Zg4oDZDQDpoYkWs2p0kx8F0SJudfhQ7u06rWXKwOKa0gHF1CP3QPJoPDpwrg/7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003066; c=relaxed/simple;
	bh=Y4vFj9mdr7X7qQ6aExqVvI3fPQmFAtldVPv4Rkf19RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRn7TxMaGW6HkqeBmlLrhRlM55thUNPqnxkziA6z0VV/K73YZ7VtfgDXDsegXhAXPDBkG7cfzBi+NiRttPPaZxYvskW+g+TRzM4OQT6vMaygg5+TQZFNpyiqNHY1Bj3wSRt3i1IrahZuhj2HvMcM08jD7xEJIrn+TbThEGbYjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5SOdSUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB3CC4CEE2;
	Wed, 26 Mar 2025 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743003065;
	bh=Y4vFj9mdr7X7qQ6aExqVvI3fPQmFAtldVPv4Rkf19RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5SOdSUXfhCwbKxTrWW8eUl2rJBc4qOkXyEII3R8KQF6pfJHDP1rdQSGxmRquhIsz
	 c7kVHi/Qve23utzYR7Ux1j/2jHCb2SKM00cPy9ImYwQnfvBjYRAXPY7amnASbi3iQJ
	 oKPik0gIgE4uPyC0OMhg4YhskKOKtxB+iDueoldW+DYUzkWq+g953BEOJfKOuJ5P0y
	 WYjioRQJHIiCLZ+WBFx+1CQ7aQdLR05g7N9KGaarA11IqdFVGbO5IN/sWN2Myv6FHK
	 rPJus8TPEh2C3PI2Ie57oKuMDm3PTkZ7mZEscMVX04hE4KSLjWVZDyX+JdXLmcV3ea
	 0SW+ZYpJQ5tDg==
Date: Wed, 26 Mar 2025 16:31:03 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
Message-ID: <20250326-nondescript-imposing-termite-ef544a@houat>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
 <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xljvre3piktzwusy"
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>


--xljvre3piktzwusy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 01:24:10PM -0400, Anusha Srivatsa wrote:
> Take the panel reference and put it back as required
> using the helpers introduced in previous patch.
> drm_panel_add() and drm_panel_remove()
> add a panel to the global registry and removes a panel
> respectively, use get() and put() helpers to keep up
> with refcounting.
>=20
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

We should defer merging that patch until we have converted all the panel
drivers to the new allocation function.

Maxime

--xljvre3piktzwusy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+QdtgAKCRDj7w1vZxhR
xcgEAP4jVoYMoW1VilpZgQ3wYPe9tqKxZdppGc4ou9hkfMBOaAD7BXzeKqRh0ZbN
i3DeDx3A1kehMK0eKvQbxav62tLI+wY=
=kfDW
-----END PGP SIGNATURE-----

--xljvre3piktzwusy--

