Return-Path: <linux-kernel+bounces-417052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582ED9D4E50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D020283269
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58F1D90B6;
	Thu, 21 Nov 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKIaOVPF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7JXJbPce";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKIaOVPF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7JXJbPce"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292751D86C3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198207; cv=none; b=XzIzg/XnPo1mwAaAqzPCEZrRXdrofqXiW7jZy5ZSMfUSyeuYaa1fEdZvVZw/gJddHEU75aEvuE9uxTJu/GELb6c1l1cjF0gsyjzQZSGO5ba3eDACCEEhlSRVmVPEQpA5tCaiMxGzXgTH4+dgg7Zqa2NcbLxdCFxYuNMKg5YOse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198207; c=relaxed/simple;
	bh=kjzxQw9Jgk0GhcXGPGJ27l2cm0VJN+00QAw5KAQ2Dr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9uRMzRLU5eM6OqCYCK3xDH4k0uh5u5zCC5SyhG5ayD045dLf+Ifk6lPb52vwkzAlQfnL7XwIF0RcSRUDrXJyi5EoBjI8yoIPYMekc9FgIXs/TZYn/9avl+ydHjjUaBrQzt1Kddl4Bj7lYX1htJXsGmLaw1x1hfUoQ4Rp2OiOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKIaOVPF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7JXJbPce; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKIaOVPF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7JXJbPce; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A30F1F810;
	Thu, 21 Nov 2024 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732198203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgW7eCUefXeGk7/iqxt8C2VvYQjtB5JSpMdrCGoVXU=;
	b=zKIaOVPFD/apt6TjsVvNNc/kvTMJDYuDRVFcsxHmblw4Ro030TAZwwO72qssR/tDq8MjGZ
	lNIsZ2nDxytx81vofIe3mvwYJzOb/fMlgXgZYd9X+jWRScZdXfsBm0kg4FXOKeHe4abc3I
	ycv+7ZZXAuSbV7px7PnPAnKA/xr5RLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732198203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgW7eCUefXeGk7/iqxt8C2VvYQjtB5JSpMdrCGoVXU=;
	b=7JXJbPcezroNAGSYg4HEK9+DC8rfsnRw3ylMWmjQ9F0B+50wvLEoKDR5b1SXHZq3Qmr+5Z
	Y2quMFVjwq95+8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732198203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgW7eCUefXeGk7/iqxt8C2VvYQjtB5JSpMdrCGoVXU=;
	b=zKIaOVPFD/apt6TjsVvNNc/kvTMJDYuDRVFcsxHmblw4Ro030TAZwwO72qssR/tDq8MjGZ
	lNIsZ2nDxytx81vofIe3mvwYJzOb/fMlgXgZYd9X+jWRScZdXfsBm0kg4FXOKeHe4abc3I
	ycv+7ZZXAuSbV7px7PnPAnKA/xr5RLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732198203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOgW7eCUefXeGk7/iqxt8C2VvYQjtB5JSpMdrCGoVXU=;
	b=7JXJbPcezroNAGSYg4HEK9+DC8rfsnRw3ylMWmjQ9F0B+50wvLEoKDR5b1SXHZq3Qmr+5Z
	Y2quMFVjwq95+8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00F9113927;
	Thu, 21 Nov 2024 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vVlEOjo/P2cHNQAAD6G6ig
	(envelope-from <pperego@suse.de>); Thu, 21 Nov 2024 14:10:02 +0000
Date: Thu, 21 Nov 2024 15:10:02 +0100
From: Paolo Perego <pperego@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Bakker <kees@ijzerbout.nl>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Dave Penkler <dpenkler@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging:gpib: Fix a dereference before null check issue
Message-ID: <wgcv5wesq3q3xank6elouewntisernnw4agfziqekkeirftx6i@ajucs5yqsvus>
X-Responsible-Disclosure: https://en.opensuse.org/openSUSE:Security_disclosure_policy
References: <20241120144653.377795-1-pperego@suse.de>
 <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
 <6ca90e87-965a-4895-ba72-8144540f6e4c@ijzerbout.nl>
 <b843f8a9-1562-458c-8f6a-c59b1037b756@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="usyxdlybbhffcxno"
Content-Disposition: inline
In-Reply-To: <b843f8a9-1562-458c-8f6a-c59b1037b756@stanley.mountain>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ijzerbout.nl,lists.linux.dev,vger.kernel.org,gmail.com,linuxfoundation.org,arndb.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--usyxdlybbhffcxno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:37:30AM GMT, Dan Carpenter wrote:
> On Wed, Nov 20, 2024 at 08:54:16PM +0100, Kees Bakker wrote:
> > Op 20-11-2024 om 18:04 schreef Dan Carpenter:
> > > On Wed, Nov 20, 2024 at 03:46:53PM +0100, Paolo Perego wrote:
> > > > This commit fixes a dereference before null check issue discovered =
by
> > > > Coverity (CID 1601566).
> > > >=20
> > > > The check ad line 1450 suggests that a_priv can be NULL, however it=
 has
> > > > been derefenced before, in the interface_to_usbdev() call.
> > > >=20
> > > > Signed-off-by: Paolo Perego <pperego@suse.de>
> > > > ---
> > > You need a Fixes tag.  But I'm pretty sure the correct fix is to remo=
ve the NULL
> > > check.
> > In the whole agilent_82357a.c module there is no consistency whether
> > board->private_data needs to be checked for a NULL or not.
> >=20
> > If Dan is correct then it is better to drop the NULL check, not only he=
re
> > but in a few more places as well. There are at least 10 functions were
> > there is no NULL check for private_data.
> >=20
> > Run this command and you'll see what I mean
> > git grep -3 -e '->private_data' -- drivers/staging/gpib/agilent_82357a
> >=20
>=20
> I had looked at similar issue in a different driver:
> https://lore.kernel.org/all/2d99b7a6-f427-4d54-bde7-fb3df5e19e53@stanley.=
mountain/
>=20
> Here the NULL check we are discussing is the same thing.  The private dat=
a is
> allocated in attach() and freed in detach().  The detach has no need to c=
heck
> for NULL because we can't detach something which isn't attached.
>=20
> The other NULL checks are in agilent_82357a_driver_disconnect(),
> agilent_82357a_driver_suspend() and agilent_82357a_driver_resume().  And =
there
> the NULL checks are required because it could happen when the driver isn't
> attached.
>=20
> I also did a quick glance through to see if any of the functions which di=
dn't
> check for NULL should get a NULL check but they all seemed okay because e=
ither
> the board was attached or the caller had a NULL check.
>=20

Hi all and thanks for the fruitful discussion.=20

> So I think we can just remove this one NULL check and everything else mak=
es
> sense.
Please, apologise if I'm too newbie here to understand next step on my
own. Am I asked to do something, to submit a V2 with the correct Tag or
the patch is good as is?

( No pressure to be accepted, it's just my willing to understand and go
into the process :-) )

Thanks
Paolo
--=20
(*_  Paolo Perego                           @thesp0nge
//\  Software security engineer               suse.com
V_/_ 0A1A 2003 9AE0 B09C 51A4 7ACD FC0D CEA6 0806 294B

--usyxdlybbhffcxno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEad0ki8u8+tnCnxjUEWmTq+eyM3gFAmc/PzQACgkQEWmTq+ey
M3h+jg//T4XH1hcC2mL9nmPOlAz9d0mB2Di090O279J3rt8P6+9qoGToyu+9zXMT
Wf74fmdy0osMHGxPL/1QtwaD0aX00aygJBq2icmzkLOkNs+o7G38wdCqsNSAYunN
328TE2U5PJWiEvc1/LAtuQ29FohO0vxe1baP4TtyLUXfXS9J1/mVC8oj+hYC1Pgl
UEeAV7d7dvjgpCSlwFncXFJ7CQZ0S0/a8l8ziN9QoBm5MQjPwdn2GH9Jr34H1MDM
0IgQjBBnMohpQ8Pcs7N4L02+vcbJoP6JMAdd0ew/p74zU2kwSL5qdUjHTCA3O18p
B6VKQVBVr4vo+CJ1PnjU6ixSu7PVGTaeRxIU4bZ+xonqiAXdAJcsoS8eIAK2zisb
Ar4NU2wrcL2thMxZGBPwL10qrzah0w6LnuUNC0kI78u/z/FOYjh8YD8HU7/+oOua
XFM9vMiTcp4fk7VNw7Fh5duulzJ2pVguFbl/J/JiePI8r0P7zTslr+Bas6vTIOGj
+RiB4OUw4THsad+CRfrygEr4XnP8420oQMcbq/aFWy3Y/V3lhxnYWnhkCDxr80Ey
K8WecqHaAa0115wSDwVe61811fG01fTRDNa6/Qevm8/vcppXz7lHftc9tpUAhr8c
PFC1ocvQpB4H36itoWg4/f1FzQDg89KsHlBQLqTGJEuiM+hb+Pc=
=KOHf
-----END PGP SIGNATURE-----

--usyxdlybbhffcxno--

