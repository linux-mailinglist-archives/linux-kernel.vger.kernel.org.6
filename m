Return-Path: <linux-kernel+bounces-410595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6269CDDB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB03281071
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07B1B6D12;
	Fri, 15 Nov 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="Qxe4IQKm"
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8D19CD08
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671329; cv=none; b=X5sjiqkteFMdDaXKt4uBjDvQ+2VRPCygmWrxyhnS6T4LKKyr1xLxobaAOg9T/+xasPMIEkbdhEcUmrpS87Zid95Cmg4VWiES/IXjhjGqhTxGix9wxkJtDrZQzZGrDPOuDYsy01mMYHcdLKltLksp3cCmjLSXXgGfRAEoD8qvMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671329; c=relaxed/simple;
	bh=OnDf94qXqJME3uv2xgfbcT2B3dWTZAKRDr8mjMcS1Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzD9aRBznArRv5akSBoZwbZIE2ZGOO4pg2CrntjQnXf+d7jLikRgR5A+pjAjYDAPJw237PssAH1I+aQa36fFrpzRv/fsyJI5Styuz+VIDPFGwRI6rS8jnQEuWE7coINq6yQwek7X+0OrQERQR1luUwAhoOioUmP2iA7F0Xu9uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=Qxe4IQKm; arc=none smtp.client-ip=106.10.244.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1731671325; bh=ymy4YE4+32rvowGxGzjT8scqBj0xagLUgW/EaGm0XEw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=Qxe4IQKmEly0N8UiGAb98vMMzwDqZ6rL1wuGgBW2jJsMP9D83JAfOxfxmigOoss0z8LVYzl1HGd4CkbxjEKnKve6HMIPeFfhzv8grDqqW5NBYkruwMO0sRZ+GeIw3uY4RIZLK6RTWLNbQk2CrTNbsR/CeOdyahP8nWjPkUQhBjZCSRAooNqeGdKaJrrWMCrloZUmIAQ/gf7/eQjdN8reOruViJKg0b0RlQVOmfV8UZ8xbwM392FeXXr5TOQa+UCwRbO+UGLkfKwbRXqucJnfhpvu65B52w+qTUAmLZVYCR1SjacKbKPqHWGajB/YS1/VjG1in9NUAOukoVarOS2e6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731671325; bh=iLE9mFCD+xIQafzddIOo8fSiZzBI0W0CEH000RPu6zc=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=gXhr8360XiXZEuhTgQAQBi/UtLYemXQ3cBQOq7+lRpHyBBsCSHcZTtB9/P1mA3gv0N2IlkTf9Z25XF7rDklTsFURBkYCCs2Wl07tjIUaRHiLruKBC4bJPY2hWbrvhN7zSNe+i+dkG/No0z2ycYCkkbi/sMzYzX45NhVQfwtgyWdMtn9J6iU44zGyaQRkeGjyPRu2A7BQVmhGj+C7P9iFsem+nAzUY9B8CZdV9eVutrszzsbV43GzzSKvJxTM/QSxm0I0alTZ49lltu8guFamk3WHBpNO4/pRhJEWNO74j3ssGansyYkXSjxA2c9sTKdgXf57FbIXo+zRGqupKoc56Q==
X-YMail-OSG: du_03PUVM1nbu2lPdtHThzF5TV29CnBdY6lXgjxfvaxZ5Y_Bqe5zChd2btCY7aZ
 rOppWLxupWCZ6p_EIvfOdhVo6ezHUCxgLUUMICiXdjsRtx1CJJMu6xiJU6xBHYwNDzY2byNu.J7B
 0PDKYyt5Io5VpoL829OtGKv7KFGG7lV_PUd4bFREOf0ShMZOk0xL6yRroZYilH0fILAmJSq2aZBC
 W0.848M2I8b9SdTApUycXImFmZfl7Mc.MKJEkeLCHWnfU4IedfPd6WGfRQPNWlnAbgjV_ZCKuQn4
 w3o8d1KpMePySeHGx7NMyX95v3IBjyn36o6l1zJqlUe4kOoMcrx42ZREhb_ADs2H7MttdJxiGj4f
 RmL4OfxzRimzO7jAdyVL6nWmrgk3Sj6wJ09nXVbx.vG_3bWsHbmuD25ZFXm6LpWCV3P61QZ_N1Am
 b9iZc2PlVntlM.TiUv8jHea6zaXX.vmBSBfKh0ILO7x_RUFS0Vo.B6X1BZbmIVyLRA5HbUTzlfRB
 dt8opp7nElPt1yEnNXdGkVokdwhfgNopiaB4Ev1._3F.LeMlKJTIyJoUB4su0Kkyt8K_ILyWlcUg
 iXWdUz8CHIk4DNj4P8PJgLGQ1cw3K8IqvzMTYknsCo3dbH8Ayj8FQcDLnoUBS1BsmYAtNbjIZgcJ
 0HXytukyagDlCHWgLtLXLM0cSu_Qra0kimGyFkJmb.m1m31smrzLbJUKnlLrViuP5Ays_1bpKbQi
 v23imAJfcty2yFZJEdnvVGQcmrePJIQSIwiUVc9GP85a7gBezucXNMPeIEji2V2tCGvIC4QdZS5n
 BlGnIRmDojFXW3HoqVdFSyA8UKIfAEZ0Il4386.z.8cHSHv4bHkyK91A7UZZtEHaa9GDtRssD4dm
 xTvPIUM00x6wedevSxIB9NIp1ghuw9kV9Gxh5ybzR16WWMjYcFEGjc4S8CEuLyg.JKzPgZeu4zTo
 YnkFHQAloy0GBPcWSk02f_dDJX_RwWqYfNGl6LXGxUpRM4xHtAQvC1byOIibAR6Pwqhyc_4PdmU4
 Xh5fWVDBu0O6_FNhmKVpF0SsbssnfvAlSXPoR5vtabDc26.HkDFp7ojauy3zHsUX.q1tjIAjbd1z
 ANjHoQcix2G5Yl5371xkER7Kg5NYPuZNBw.Pq4jNYnqd1J3C.ZJwLLFjRbGM8DT5yJbI7tXmix1N
 KcDSn85pupsggtt1SBfFOQKmRegDctJr8Y7BejFr9YWNyDFwKDk2LkwWAZa8HfqJ6J.HJhDTGI.j
 UzKZVaI8RHcchbdaXX.QnTB_k6cPpcaCVI9ubIgKKrJjEmFRIuIN87F_YkKFa2LWCN13yzV6UQKK
 vqxz0io.MSZzXw_Q5.IzjGmSQO7f13rl75qqgU8R5stt5jD43LfEgf4p2YATapbt9yGvTlV.GXUp
 0ImS_gz2IgJ76.K0t69HsPzEunt_KibwE8QNHl4ZSbSPsGAqfwoDZpKNUcJs8FfsWVwb.37xQd2r
 1Rs1nak_aB7Lsbf3qs.EmMhRaX0RPU47..wAPt1SkJnmxyiOqQcud8AcJfxKHbDhvAMvV98cbSWR
 u8VsmnOoqDZAGO0hF4ZpczuD27CrC5hz3uH91sj.oZatcqK7KyrZdwhvqc8EOXa22kSr_jjDW5RF
 rFDd9MwCeKQgh6E.e.stTHxKWk9vH1zAEmQPkZGRuoRWBTngooXAPwgoI00MxKNUuCuC0FCXdm.3
 yn.6QaG8x3JBKtcns7ZCBfZSIEFJyVERx.xs.ijmTyaYABPZM4sXjOYz8vm7WB5eYPbUFiRx4ZEP
 hTh.2HBzyoDmK89JZ8_826mjawBHNWm3QJ_nzL.JNzeCeub5fTnGtN_UcH2kIHKcE4YMtp9OJp6d
 rDYM07SCv.5NpaECwAy8TX.ZW5svQIZ84w8YZAUf3GHOirwaqMFpV93bEM49FSV8ZrjDbpKhVnwW
 wJgpJs1iN2NcC36.QTNy2fLQe7NjK_OCunI6g3lPyTINouv_.yrhmNQ4cGvNCxcKxmjd.8_SWHcb
 wfmoaX7G1tVQimuFpma9ZuG14FiAc9g0vT8aPEx_Gkz7OjYComjSk7iZmR7wF6mQOCPB.i_dptP7
 .1yhcgIEgvgNWF1_TkxzkjQ3OWBJdmVE1XAeC3Iy3ZbFfLF5l8jaFUa8eKqXmjvKbftH9u9FNnXG
 jhNqNQc.vwx_BWsTxjcTNth58tWxqkLFkQ4D9iYJ06UA3g0NT5frdJyr50blCmYsDt0ayfosna1G
 VGvBLAAxeFWkryTt8ZCPwpLKgnIop
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 18578443-bbd6-4016-88d0-db83ff0caa55
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Fri, 15 Nov 2024 11:48:45 +0000
Received: by hermes--production-sg3-5b7954b588-zm2md (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ab1e331c5efdc675a72082945876b22;
          Fri, 15 Nov 2024 11:38:33 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:08:29 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use strscpy() instead of strcpy()
Message-ID: <2purmecq5zso5dlheclxftxfalzazwgdunwvjap3ukhpp2bj57@7txx4wiaed2p>
References: <20241111221037.92853-1-abdul.rahim.ref@myyahoo.com>
 <20241111221037.92853-1-abdul.rahim@myyahoo.com>
 <8fef8eab-cd82-4e05-ad9b-1bb8b5fe974b@wanadoo.fr>
 <o6dz6grwkknan6er5lig6i37ocfekn6i3fljltptn7aol45sfl@n5amdhwr7wmt>
 <e7cfb6b2-51a4-4c8e-9c43-20653bd1443f@wanadoo.fr>
 <bigyu3u3rawsy5c5oxpe7xpmq24jhuxdrnklplaqjs2san7jxh@k3k2ypxcdspk>
 <62b1d5d1-a648-461f-8002-8373e600ef31@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlevuqj6vbf35pos"
Content-Disposition: inline
In-Reply-To: <62b1d5d1-a648-461f-8002-8373e600ef31@wanadoo.fr>
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


--rlevuqj6vbf35pos
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 09:53:46PM +0100, Christophe JAILLET wrote:
> Le 14/11/2024 =E0 10:14, Abdul Rahim a =E9crit=A0:
> > On Wed, Nov 13, 2024 at 10:28:36PM +0100, Christophe JAILLET wrote:
>=20
> ...
>=20
> > diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> > index 0e5b3c7b3756..48265c879fcf 100644
> > --- a/fs/ceph/export.c
> > +++ b/fs/ceph/export.c
> > @@ -452,7 +452,12 @@ static int __get_snap_name(struct dentry *parent, =
char *name,
> >   		goto out;
> >   	if (ceph_snap(inode) =3D=3D CEPH_SNAPDIR) {
> >   		if (ceph_snap(dir) =3D=3D CEPH_NOSNAP) {
> > -			strcpy(name, fsc->mount_options->snapdir_name);
> > +			/*
> > +			 * get_name assumes that name is pointing to a
> > +			 * NAME_MAX+1 sized buffer
> > +			 */
>=20
> It is a matter of taste, and I'm not the maintainer, but my personal feel=
ing
> would go for something like:
>=20
> /* .get_name() from struct export_operations assumes that its 'name'
> parameter is pointing to a NAME_MAX+1 sized buffer */
>=20
> CJ

https://lore.kernel.org/lkml/20241115112419.11137-1-abdul.rahim@myyahoo.com/

--rlevuqj6vbf35pos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQGANE32qobQCmkOMwCzg70Hch2QAUCZzcysQAKCRACzg70Hch2
QPNVAQCRSkBTTIi1KB8EvapDt7zQyOobiFBctV3d1gbdb2zxMgD/fKrBzPgS64Ax
o4tWD1kRcyJ4FQbNA/Der1k5YuLiHQk=
=fFEH
-----END PGP SIGNATURE-----

--rlevuqj6vbf35pos--

