Return-Path: <linux-kernel+bounces-329223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB9978ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773621F23D56
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC613D278;
	Sat, 14 Sep 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+3axpA2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17E13A27D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726298414; cv=none; b=Oq3SRc4+PPmflIS1OAbMktY7B7F2NYBmTWOOu2ogIJga7q4/wGLGc9dmgRmV2LP7g0MuUL6iov0otWCYtkD06JLLeMGFMQVd6StdEAhoCYC/Rp8VUQOQ343rbMi8IDJlXDtux9PccqoJXrTgDW4ymBCOIExwi7Z59SJS0bA6yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726298414; c=relaxed/simple;
	bh=vUqu35v/RHRRdjOIWlabA82GDwl80rWgemxzi+UrVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsTIXTSMSnTqi5oc7q4JGJBEG1LhiQjdfwtPjU0nq+ygItqPpi6PBVlcQtTr9Sen4WrvujqoPZ4E3BDhcaKaiQqdxtXAsqtyCepXEq5ALF2H/HwKLzxtvKXPNBO9IL7txMpU+wt4jmhacafoMUrEFUN92shi6gk+wTL+4simqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+3axpA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D47C4CEC0;
	Sat, 14 Sep 2024 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726298414;
	bh=vUqu35v/RHRRdjOIWlabA82GDwl80rWgemxzi+UrVh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+3axpA2F2l+jrO6wbWLl227a2er1619kCaSapwqVmEMU22DVHzZsbWHri3XcO48I
	 J9k06Sx/dvoaCJPoN3UeIVAtHCphEAC7r7cpsM3+UARWPTgf1NgTfTr4Lc99aje77q
	 kr09vDCmiKVHVAFI+Vzu0wgS74mdGuBQ7/WtV7CmF1osCLe+3kgE5QsZoWq2UI4eVS
	 IMTVhCo4yg9Pp2TiX3k2uB0oXn46dlA/ZuyQ13qCFJX3QlscgY9LOP6y3KMi4J4js+
	 vhyecXJbxRC4FliwMI3rV9C8BFhCABubj+6Ital26/BKLnRtHaWCJe+voGICEWwBkS
	 KZmR+Jj2hOxFg==
Received: by mercury (Postfix, from userid 1000)
	id E77FF1060578; Sat, 14 Sep 2024 09:20:07 +0200 (CEST)
Date: Sat, 14 Sep 2024 09:20:07 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: andriy.shevchenko@linux.intel.com, rdunlap@infradead.org, 
	linux-kernel@vger.kernel.org, 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in
 ssi_protocol Driver Due to Race Condition
Message-ID: <wcynr6qrl72i5gsibxvj2aldh6ohea6x2wbqwwf2dfuszipvhp@nzz45sllypav>
References: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqvokrgn6bzeb2xd"
Content-Disposition: inline
In-Reply-To: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>


--fqvokrgn6bzeb2xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 11, 2024 at 11:19:15PM GMT, Kaixin Wang wrote:
> In the ssi_protocol_probe function, &ssi->work is bound with
> ssip_xmit_work, In ssip_pn_setup, the ssip_pn_xmit function
> within the ssip_pn_ops structure is capable of starting the
> work.
>=20
> If we remove the module which will call ssi_protocol_remove
> to make a cleanup, it will free ssi through kfree(ssi),
> while the work mentioned above will be used. The sequence
> of operations that may lead to a UAF bug is as follows:
>=20
> CPU0                                    CPU1
>=20
>                         | ssip_xmit_work
> ssi_protocol_remove     |
> kfree(ssi);             |
>                         | struct hsi_client *cl =3D ssi->cl;
>                         | // use ssi
>=20
> Fix it by ensuring that the work is canceled before proceeding
> with the cleanup in ssi_protocol_remove
>=20
> Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
> ---

This does not even compile :(

During module removal the network device is unregistered (and thus
stopped), which calls ssip_reset(), which should stop any activity
regarding traffic exchange. That's the right place to cancel the
work.

Greetings,

-- Sebastian

>  drivers/hsi/clients/ssi_protocol.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi=
_protocol.c
> index afe470f3661c..3506c70e3505 100644
> --- a/drivers/hsi/clients/ssi_protocol.c
> +++ b/drivers/hsi/clients/ssi_protocol.c
> @@ -1155,6 +1155,7 @@ static int ssi_protocol_remove(struct device *dev)
>  	unregister_netdev(ssi->netdev);
>  	ssip_free_cmds(ssi);
>  	hsi_client_set_drvdata(cl, NULL);
> +	cancel_work_sync(&ssi->work)
>  	kfree(ssi);
> =20
>  	return 0;
> --=20
> 2.25.1
>=20
>=20

--fqvokrgn6bzeb2xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblORcACgkQ2O7X88g7
+pqqbQ//YRTQFnSgTMI9EnzwIYtATipHhfgPnvTvmPI0wdLFkTDbZK5eSwUPPwQY
wMnocy+GdGX7rk5nxWosyz7TH59LBfsw0S3FCiGeNxSjWkzpi56pqYBsf41L+5fr
j4VL2wX9HgiXKCtcpLdk7J7VLC+oee70d/q/Kz4HA5iWWxjT3hAMrPErdPikrcfG
idAn66b/uKQSXWkjy5lz2RnHZqzggaLTeIo1eZPe87yXL7REcsPgMDUGAaGnb5Uv
WncDiTSoOyJGcmJYBMRlpgXZkREE2nIPEOXNjZBxWBOyDbh8Y2B16jILU5UvMFfr
sdH/2CKmtsrUPhqwwtWaTcFFisXZFoeBDmEdMBkSywuubUT6nrs38knGL8w6Zefj
N2JqCF7GguDR1ulQ3Iddvn0sc9eOBeWuYW+996wvAtbVV++D2unxmSuZje5nVi31
bnGthZFAuIMagrXTZUJsKe7sP1jq3MES5lvcFz0w9zBuYavzcYOdpNO4APUPU1R+
ZWsSfquDsyuDfiZfh1v3yjzAjDCWmq2BHxFCqOdNhXRLLP3pipqfnxYAvDpoUlhS
ew6kxbt9fYbN2xnS11EPPrOgYv0FnheDFBisfjeCJtKHToADTvqnTonNyj9LxnoB
UJ54rV4wGUFhDLCx6pwc4HaY8TycOK5kAU1kC0UvgwsoGEEtP0g=
=pyF8
-----END PGP SIGNATURE-----

--fqvokrgn6bzeb2xd--

