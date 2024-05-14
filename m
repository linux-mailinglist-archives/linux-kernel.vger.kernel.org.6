Return-Path: <linux-kernel+bounces-178764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA08C575E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AC71F22087
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100501448F3;
	Tue, 14 May 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BvVikmGe"
Received: from sonic322-28.consmr.mail.bf2.yahoo.com (sonic322-28.consmr.mail.bf2.yahoo.com [74.6.132.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A971448E0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694711; cv=none; b=tnju/FjhHpobzvUz5mekTUJgi558CIb6f9F1IN8eM3C6wym3rIjugwYkPO07rk66d0D/CDoMCnqIyEw6JF/2VlDWWheUvYj7UYgSCBxE1s0VKRoaWjy3W3IUhoOKUIeWWpGvOkUd8GHDD5sPzmVM+9b7+Zfg3hU0pCmO6VWh4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694711; c=relaxed/simple;
	bh=RcsunZHCHVxsblJVqQpy+YXF1pJ6HVfEq0vl2cIKrI0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DJ1lrlg3uNbvA2O44ZScxL5uJug4Qx+LAo27GeQTMRwtR435Z8Ja6FYhMg2yIpaEyygxZGw2YE+eoWz9dQGWmbAqyrvYgofFgPjmQdkX60De5jQq32sDX9sYeJMDF4+n4DlDXtN82Lu0JBqTT0OrNddwlXjMF737QmhfqrRP4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BvVikmGe; arc=none smtp.client-ip=74.6.132.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715694702; bh=RcsunZHCHVxsblJVqQpy+YXF1pJ6HVfEq0vl2cIKrI0=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=BvVikmGex6E/UXmqDQN40yQpHJ9NPSlJhP/J3VmFhJZ5OEm335kA2UjYaK0+MT1bVYTp2p4OHQe3DPFZC7Pa7Yqn+5swaWXnfwYcGB3u2cEQJ7941wNmm0436cmyfdho8Ykd5Rb8UlohiAM+h96UEsIldfjQ2U6+q0522vdP0WyHQdj6daqiAdFqoIDQjVbH95en9jq0lhiIslBydaqDuTNF+50WpHnDbCRNi3JlOlNNRgePte8I2lXha4Lr7J9PrnL3d2hbZXfMqEXJcMQzhUL7c0bbt/PnRcX/kXIMQjQ09dFOUX2/QQDxur+8tgo6XCtU5iNLNIu1KOiyvB+8Cw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715694702; bh=XNcnfzaYr4e24c+8hDEI3Mtbi4Uo67OaWEdq0iOoo85=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Jgzfdip5m9/tG+9MhhtXCcaCoTj2CiKc/E6M5aYPQZa+0+takknmYYhQ/zidbVznue0/LOfvB+R7whOwcbjTJx4h4T0WdlvTH6MuTZY9KJDrKZ1I/B1nnpPx4JsZ+GQGAcCitFLmpeZIarYXVIT3mwwg4w9hH1mqNDZmedLyqGZHp1Y5A8JpbnNRJttdyzupYmJMG5/eXAxymqbvEUUDgbIb1lRJ0gG+yo503gyQA06Y3SMIp4XoxHAqh9jc8LXBUgkCWu1h2PgJ4cg5pFVY/QfCgQhzumeMSqHEjyhshn5JZFgQk888e7TQLoNP3RJuDrWaWLx+BWRlrN0sxLkKrA==
X-YMail-OSG: kipyjfoVM1mfMeAAMKFky4cPdHIyeRSedZW8HnVlldkEEV6BtR3fjY4w55nMaG2
 kS8mIKMcU6QeRkEcYRtfYdmnBWMop7PBDh8EjvJc6kywxfztKwoQEKV6gj59YalX8USGombGnOIA
 caswN3t02MLSr4m4bSGu9AktOgL6J4QPkG6sgYB2ZsMKfM1JedRFCel6ONi9w1p22msXy6sax3dL
 A3Wdz9eQ04oakMv8aneGUV2ozOE46S06ow.OU960fQmfTKEhuNa.ZHkMZyLrZwvzJwUOTtPlCpdg
 ec1056_mZWklW4cAgg8XRJjhl13oIniRL9.gF65jRpfHKGDzTOFF4P5sdriV4nn.8lgPrN33rKFx
 MPsbFhcjWKAceFkvYCUiETXUAvOU3UAxdS0_c3BD9CAplVCFRQqZ3.lmka1FG0T0a7sxy1E.20ZS
 UusbXkvRnUQ2IbBj0RrkBCSRcaJpZZVtwSVATMjmjcswV.fAslVAg_W0IsIOZCcKWapHYDCntSwU
 hSQ.4Jlji_g59.Puwkv_8NYVhGjmQde0bvOzdJ6pGPmRvFaVpmi8IREn_WLWQSeP_MsXMlsbJyP5
 At4.ozhsyYYsmdVaZ0Bmj0zrcG1g8OzsuSPm9Za_asgmVukbCMw_aCoBZ3QTBF83Inm9FXm.0iuj
 .iUNbarEhHQlNgChVNo_pS.SaKmA2rujArI9_vlsA2VD38_8SZiOxc_fc_DvJA.iPEaBV58fKmbF
 NrEIOxmmOIjhTI.vPu._p_T8OVPRYlPS.T2UaOQeyWKJ9BA9Ynr.gYZMnZXKMpo59EXH2YUFpJDA
 MQNeFd6XMbvOzeIzEerMJAYBBFRlYHqDYXPb9.91KWcH2eFRpKjOEMvUXdu6SqQd1uN0.AD12PyI
 xH4XQ7UBNF2wuvnHJHpy9iXS_xPdNtydEIz8CoCJ9W9nnBwuMvRAOik0u27kBdlkUu2.RkBF3cOO
 1XrivILmthLg_eBMCgu5RC2XqG2MNexJDevO1y_nRRXxjZisDGPYkywldlvtUn_BHEdOyAD7giQK
 Tj5MsY86nB2Alj1Qoomu85Lznr_QkM.CN4pavWMQO6hI.rC.XrxkYbG8PhEH5J1wbJaPq6K.Nps3
 7kObWivJpdmxg7DUZJuU2BKHySQSYdTagWDy0Rc70Bs8YMoLiPWtbFVDHuePv8nQEb4aGJeIFZSj
 XdSaOCTKNlrmyQJIkth2cvzVa6d.0uvF_KcMTTd5ttsDd5ADoTlIDnrXq02LoqYhP7k7LLgBvUdq
 CxLj_vOXqKDOHDvxlLwbTprTbPdq1.o6_FBG4ftEyIswIIOzGCBlOy9syZJyqG5M0tu5tjHwVUIN
 hcPoEpGBArgMKTzwWSO7ynanVXnYwP1n3AXFWeztUtFwD1sYq6Xw5mO2fzkj.V0JdeSIF_YRYGud
 r2LDSf5QbacJG3asqDD2o2P4r6DOX__dby2sdjw9yf21GUloRz.XAxPWMPW7tRuNsnNVBkjqpPX5
 wwnYWZcEqWVDl1s4GqeQoen_oPc5pTk6NGLYhdX8Q8fyc1L.Gjoo4Wcx.hePr96TBZR9Bw_WzZUb
 alYt8JwnljKht.U1GbJ4SbardpDuPe1x5Nq8Wv7GKXY_RSODbWkr6FOE1Lh6KA3lFfGjQ7TXLd_J
 ok7NAxa3bgYzBlL02ZMErQAviYrLuKmBxkkToQw_Z2eVYTJRgubPjWn9OWtcag54OaVnD0BCnsQ1
 yjVLVWU1Z0KG3IelDJ4IpnxYZYd.0h45CVHayjLTefS9FOVd0qIDOvnvIdMMIz27d4.EhGL.ifUZ
 1w3Ew2Hd665GIVTM_JHuqk9TXik8CQH4HAvjg2VfwdEC6GIKzeVMo8vcn3L7JFlIgTvNpdZyTqPq
 vfqMm1KZNImit9RGl7Sntcb1hTr9JsgIuti2.1o8TYkB.Yb_a9_5K9PeRJ3iRSsSIqzknqCodsIm
 HqjK2AfRucKcLvuqVsc_.7E_eN.vfMKGw3sYoiYDkmvlyTv_HARVzPkHR5ESdVxRyjnnxIWjk85w
 Dvu7WFoIsALwoyi_TzydEQvYLi5p.2jK6UoOAtLbBZZwYxqqAenVQgbxve6sJzmH9NdVqtGftBzv
 desvrg1VjpIej35V1I7S5qC8UiNONtYsBg9pI4IpqZK4SDm8CIsiJrIcPoPx2Ia2VhfoQ5z1xffT
 14DSF5oxlyzPpAJU2cyYJKcn.DBOzm7iJT0wyr3oQVsRNGymc8qe_GB_r4pVJcBzsZsF_cTSjVkm
 5llnFZz9oc44JNIK3PpBQy7cnL6tk
X-Sonic-MF: <vkrevs@yahoo.com>
X-Sonic-ID: 3a3e683c-2ea7-4187-9e19-0306338d883c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 May 2024 13:51:42 +0000
Date: Tue, 14 May 2024 13:51:40 +0000 (UTC)
From: Vadym Krevs <vkrevs@yahoo.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, 
	Linux Serial <linux-serial@vger.kernel.org>, 
	Gilles Buloz <gilles.buloz@kontron.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>
Message-ID: <563463792.1252370.1715694700555@mail.yahoo.com>
In-Reply-To: <386fae3e-5286-e13d-4171-3a6e87cb1567@linux.intel.com>
References: <ZkLv3wn62jqMVpSF@archie.me> <CAHp75VcjeJ5oZy2JjbyrKn+GVvixJKmfh3Yj1p-HxcJHrm0Wzg@mail.gmail.com> <606328522.1205749.1715678929830@mail.yahoo.com> <CAHp75VefMFJMAHrKmDf1joSkKOcaRMJWse8yM63Nt5v2W7w3Fw@mail.gmail.com> <6bfafddc-cf5b-4829-e09b-2622aaf83093@linux.intel.com> <645803059.1237606.1715692880298@mail.yahoo.com> <386fae3e-5286-e13d-4171-3a6e87cb1567@linux.intel.com>
Subject: Re: [regression] [bisected] commit
 6bb6fa6908ebd3cb4e14cd4f0ce272ec885d2eb0 corrupts data sent via
 pseudoterminal device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22321 YMailNorrin

On Tuesday, 14 May 2024 at 14:30:54 BST, Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:
=C2=A0
> On Tue, 14 May 2024, Vadym Krevs wrote:
>=C2=A0
> > On Tuesday, 14 May 2024 at 12:03:25 BST, Ilpo J=C3=A4rvinen <ilpo.jarvi=
nen@linux.intel.com> wrote:
> >
> > > On Tue, 14 May 2024, Andy Shevchenko wrote:
> > >
> > > > On Tue, May 14, 2024 at 12:28=E2=80=AFPM Vadym Krevs <vkrevs@yahoo.=
com> wrote:
> > > > >
> > > > > It's a standard setup for an out-of-the box default install of op=
enSUSE 15.5 with KDE. All tests done in Konsole with bash as shell.
> > > > >
> > > > > stty -a -F /dev/pts/1
> > > > > speed 38400 baud; rows 57; columns 217; line =3D 0;
> > > > > intr =3D ^C; quit =3D ^; erase =3D ^?; kill =3D ^U; eof =3D ^D; e=
ol =3D <undef>; eol2 =3D <undef>; swtch =3D <undef>; start =3D ^Q; stop =3D=
 ^S; susp =3D ^Z; rprnt =3D ^R; werase =3D ^W; lnext =3D ^V; discard =3D ^O=
; min =3D 1; time =3D 0;
> > > > > -parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts
> > > > > -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrn=
l ixon ixoff -iuclc -ixany -imaxbel iutf8
> > > > > opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 ta=
b0 bs0 vt0 ff0
> > > > > isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tosto=
p -echoprt echoctl echoke -flusho -extproc
> > > >
> > > > Thank you!
> > > >
> > > > Yeah. SW flow control is enabled, but I don't see which character i=
s
> > > > being used for that. Anyway, let's give Ilpo a chance to look into
> > > > this.
> > >
> > > Thanks a lot for pinpointing the commit with bisect. It turns out thi=
s
> > > is a quite bad corruption bug and I'm quite surprised I didn't see (o=
r
> > > notice) it while testing the patch.
> > >
> > > Could you please test and confirm the patch below fixes the issue?
> > > --
> > > [PATCH] tty: n_tty: Fix buffer offsets when looked ahead is used
> > >
> > > When lookahead has "consumed" some characters (la_count > 0),
> > > n_tty_receive_buf_standard() and n_tty_receive_buf_closing() for
> > > characters beyond the la_count are given wrong cp/fp offsets which
> > > leads to duplicating and losing some characters.
> > >
> > > If la_count > 0, correct buffer pointers and make count consistency t=
oo
> > > (the latter is not strictly necessary to fix the issue but seems more
> > > logical to adjust all variables immediately to keep state consistent)=
.
> > >
> > > Reported-by: Vadym Krevs <vkrevs@yahoo.com>
> > > Fixes: 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF ti=
mely")
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218834
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > drivers/tty/n_tty.c | 22 ++++++++++++++++------
> > > 1 file changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > > index f252d0b5a434..5e9ca4376d68 100644
> > > --- a/drivers/tty/n_tty.c
> > > +++ b/drivers/tty/n_tty.c
> > > @@ -1619,15 +1619,25 @@ static void __receive_buf(struct tty_struct *=
tty, const u8 *cp, const u8 *fp,
> > > else if (ldata->raw || (L_EXTPROC(tty) && !preops))
> > > n_tty_receive_buf_raw(tty, cp, fp, count);
> > > else if (tty->closing && !L_EXTPROC(tty)) {
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> > > n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(=
tty, cp, fp, count - la_count, false);
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_c=
ount;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_closing(=
tty, cp, fp, count, false);
> > > } else {
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (la_count > 0) {
> > > n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > la_count)
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard=
(tty, cp, fp, count - la_count, false);
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp +=3D la_count;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fp)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fp +=3D la_c=
ount;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count -=3D la_count;
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (count > 0)
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n_tty_receive_buf_standard=
(tty, cp, fp, count, false);
> > >
> > > flush_echoes(tty);
> > > if (tty->ops->flush_chars)
> > > --
> > > 2.39.2
> >
> > Yes, I've tested the patch against the 6.9.0-rc7-local-00012-gdccb07f29=
14c kernel (last commit 45db3ab70092637967967bfd8e6144017638563c from May 8=
th) and it works just fine.
> >
> > Thank you very much for fixing the problem so quicky.
> >
> > Kind regards,
> > Vadym
> >
> > P.S.: Hopefully, Yahoo mail has actually sent this reply as plain text.
>=C2=A0
> Thanks for testing.
>=C2=A0
> Can I put your Tested-by tag into the fix?
>=C2=A0
>=C2=A0
> --
> i.

Yes, of course.=C2=A0

Tested-by: Vadym Krevs <vkrevs@yahoo.com>


