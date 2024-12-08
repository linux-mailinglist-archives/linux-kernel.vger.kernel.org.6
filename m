Return-Path: <linux-kernel+bounces-436273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF2E9E83BB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C7318848EC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02229D0D;
	Sun,  8 Dec 2024 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="VV2SPvv+"
Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CB17C77
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733637342; cv=none; b=kuJaX6gnc3BRa3YUWyTEIDIONUuE8ZnthwODV0vmF5QRqRXh0n4XeF+2+3F7IqdgJzdp9Pxj3zBAHSvS/QbZ8zurNLT9GWRxjqRTjtn3LM1jlO6Xu5JO/w2S6s/51S739qwc5TVpzA5cs9aBhkE4FrMO1HBQhMeo1d/0Lf0P+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733637342; c=relaxed/simple;
	bh=CkjchI+aljfOC/6jWml6WBBRd4uTYjIMrjIAso9SxnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKHRWMNA8bYR6isgXdXhtRqMTIepbNw73BQ8lH47+erNwyycw/W0mWstVO1MIuK/yD5qknZX3f7Fdw/dtWLrchwHQx1tEmb6KmvsYjvow/pymSC+F54WP5bvQ3kUhGlordi6HJ+pjq1e3kYX9KsKmEeDKt8sQxp5oYHPeIpztOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=VV2SPvv+; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1733637339; bh=YeScObqTekTog9a+I9adrv0epKDAE0AR9eWawCbySNM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VV2SPvv+lRqDcONEbiwp6HTu333GTi2WM09jUDRevkvIh2im7JarlHBz+5DpAvDrmF97gbvlZx/QFbvF8kxQMkECtst3jiykbW7nVJ3yNNlAx/QCrjMW27ZxKG0nsNcDZxzfmN0wY9vrRrs0mt9qxJnMoJvQEIf5JpXEHepDUmp9YxbQYKssBU3waSe/VhvbCZxL7MV/+xnk/AUfIvzXgdXiu2hQNmwYpTJ2MiHj4VOCRbLBpMOf8MGiHctB8akUtMqm1ANNey6EC8pooyIZJU0+VL4EHoEcPGAEl9lxTJFPSHYDP1HPbrc7Ilb/7zHidPhWqgC72HUM2ZIQfZ4Kmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733637339; bh=qeiDLFGebo5wW8eSPDMIEb0ubZqkrxQhk2KVYcLqueb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rGcZtNubAb4iagQ/Iyws2mWTg42CI5B7tI6pS0I+l2yoer+RoonVskuwvprZqd/R9ulGEYC5XvLX1zmo3QQ/mfYFVZkeX/xxFT+NT6SbOQ6v14ooUe6mZZeqbBPIwcHctZjeN9KEjH8PfNGdlJSi2mcFvxDgBwAkZTiKoYBUXmMack86P8FYr9oa5iY6ojpQIvcjdLc7UNYuQkMxTVTjn5RbU5P0T17YY08YsJ2IoRNYh3nYonJ7nGRMPKNj3V6L3K3bDyQZjnBH2fKpvceXwmiNmO6iXOUNns2HwZqiklBS4jBemFhosKxgQH6e9tKxXEUUHJ7XbU1HY6MYDUSL0A==
X-YMail-OSG: tGzYvaAVM1kzDlsBpCmaIRA2N_i5058M_HDcJ2hUSRe41Lk3dOBH5FO4Kci97pD
 J.4ZKcqGoK2iWyLfBXon2gn6CI0mFRV0GKJQK2z9RorSFPrGZyEiatYEanOTIbkNnbS.z6l7JSmD
 sU5rjOab8qs6cjeBqOK_LwpJY2jW4a7oQDKj9N9fm8VftQDggwaDjyl65a83AuZJh_BWlrN_WbSq
 Ad1U.F1Smjzr5t5oP4607xpJidgVwNkCTVGPagMFnvZeTuj9hskVgDMuOupABiyYs7UailKa0Xgl
 CxSRwC0EhppASTLXno48qYBPJxQNVyMlkNvqAnMtSBOZ5YJ1Bns1ZdEGUmijt7471yb54l9TFwAB
 DjpmWaPQTOwghPFYZkdIMITWSz0L3BgktVmKaXzmMZmLGuReRGl7BPmnGshEYwtRwpTna0QPH1Eo
 fQGFdIMJ8ZieeH_oSgXAhFykkEqbB7ij56ZJnKAF7RlKql3.qFrH6XhHz2VTCWq.TUDcZbU_ha.i
 vR6wr3_AXFlas3h.l3JwVZSZBbKo8D8SDOnc0euJ926ap7kfUD6wNBkwT7CINUiO5R1wLN1yDYq4
 XU8f8ZxYYBfwcq3EeK.3Bpq94W8vM7bvHwSlB3Y63E9wm62_7PxgWav6oi7SmB6Pe_1G0oraNpwi
 .NOnI_tPuoBVfAUGNqceZOuBlKGt5QOWtWX82vmPFjNjK43eabyvDbaa9KzpoN00ELaDPsoVT7zq
 6eZvy4soWKdGJCv1G2adNtAQwXhS2o0i3BIWw10lq2HZsRwEibR_gv_uTNCtfjoWnu4hCOBihPHD
 MWnqL6rWaSYJNfOGZ6pwJU5u2iEXQs0E6.0UGaTQsLtKOxehCtFNSYyHq_hXZ5CbD6dJghqJtD2W
 9P3PhTcu5etVMV7VOdIS.Ngt8IsL_s.XWwrd6YGGNwEJ2ppVTbE5wO1q8jbZG_efE1vv3YRI30LH
 e4AMvU94ZEUHtbeGLfGvovNvtYsmd1Dox86Ztq_EY6F_K1U7DrSDHMtFXigMBqFXbiTsWR530Pun
 lVugIsbUFIGleGctxqM1o0H6yqwvQR.bdWRY7NsD.KDP7ZQKQuY6UADjoOwEbBrXosN9Q38V6VL6
 eRIWjWrWCKknHZUefF9jLkKE3mCRrBvPbnrvAEIBzkH6ciL7tRN89_TgpppNcGqaaWuOFVk.ooZw
 JtRK2QWba1pf81XNeJf4_Yr74aI17yiZTH93_meQIEyzs1Jntm6gl25__VU.CkUMy.QGPcDwVQNk
 jksouJV5cY8OrEetquXlN4i7Z0pJP8QrEYy914DcL_yHc0B8nh7sHIqcboeceAy6rf6NxCrZGaaC
 ojB4X80aSQfRaMsnLP1Rwdsq5B0RBS1La7XM2hoYTxkQdlUuSnNoezV7oi9bH4fnyqdSkkvIMEEw
 BLs4Ac.x1Ollr_Zv4lVSKnSkLmFjRXOoBZvuNNVe9s1s7iJUwIdk7hOgAzTLo8bPDt09TyqDeauy
 P2tPLilcDXAKJbEy6b9bE_lGNQPsr8.0UrwBmMvbWFQNCjX6Kq17hLopTR_H79D.1dHHu.yQjSl4
 RLrQICyeBuuXQFi6FDB6RkV9O2gv9_vZEofm0S6R3zW5ExH7wDL6A3YeYXSaeMGU8g_phZ6wdPCh
 Wun6MOutGC1meMS9YmEqm.YjmtUKhWua_K82WuuU3QXhUEtmVg7YivPfgL_0TubeyIiTuYGuAOnZ
 h0h43gfNM7oynI717QTutM5KOjj9b1FOoN6POm55OxJhcfequqrjzHmihrCiQRoVrn2HsMh.MIo9
 pVPamQQ0cX8IjpmoVPbSxixHFe.8.w.wKnY8kxV3ATdeS35d9RtzxP_vXXvCGI.t4XH9x.2K5F7e
 uHJMcv7CwDWxSGMYLb45PFrnzrL1cc74GBlrJsjWz.f14sGYEg716TM39Ok2LnKXsUE9ZK9ZTlVN
 c130mpZ81lhhGd.dEs6DkWmuuRg3Hme9Xcf3cEunpdR9zpIlI2cGuOMt27Fq0gqhsZ8VNmKu0.E3
 2_csSPw75VXCB70n60n.635cYLh6TE0f.EKOwQemKdfnB6r_N5gwnqB30z6IcqwU6EOQbKMkJQw0
 mg6ZNs6j5BWuiHBQjZSfFZyRrUy4ZzqkThGuQFN1hIQV_g2GnzBL2Z1aG9E0uDtOrgUrDQ3CTrYC
 kgbfsV7K8oLmYYaGznGjeMPP2byNU7c6lBavwh2CV1aqgj5aKT52JaNGM0EDn9J_1MBTybNXLyms
 dNNXDQtb0LieGaZRRWA9A9sSVgzTnMkpLazcvMXsYX1J3T1n8QGklaGdYYA--
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 65b25c8d-86d6-43ad-9995-8b05c74a11d3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 8 Dec 2024 05:55:39 +0000
Received: by hermes--production-bf1-66bb576cbb-554bg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54139d18044aec77cb126bc82e559aaf;
          Sun, 08 Dec 2024 05:25:12 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Sun, 08 Dec 2024 00:25:12 -0500
Message-ID: <3271291.vfdyTQepKt@nerdopolis2>
In-Reply-To: <2024120700-expansion-pretense-b6e9@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <3758619.RUnXabflUD@nerdopolis2> <2024120700-expansion-pretense-b6e9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > device.
> > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > 
> > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > reviewing them), until that happens.
> > > > > > 
> > > > > Oh, I thought that I didn't need a real name
> > > > > 
> > > > > I found a recent thread that seems like it suggests that I thought
> > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > Or do I need to wait for that change to the guideline be merged?
> > > > 
> > > > That change has been merged a long time ago, but as far as I can tell,
> > > > this signed-off-by you used here does not meet this category.
> > > > 
> > > Oh, what would it take to meet that category? I've been using this nick to
> > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > GitLab name
> > > 
> > What if I made the signed-off-by (and committer name) this email address? would
> > that work?
> 
> Do you sign documents with your bank with an email address in the line
> that says "name"?
> 
No, I guess not, the no pseudonym requirement was dropped, but if my nickname
doesn't work If I really have to, can it just be my first name, instead of my
full name if it comes down to it?

Thanks



