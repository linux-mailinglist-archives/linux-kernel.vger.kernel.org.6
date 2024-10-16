Return-Path: <linux-kernel+bounces-368172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE209A0C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84148289DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85620F5A1;
	Wed, 16 Oct 2024 14:00:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3F20E02F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087245; cv=none; b=dXBIA1KxBep0hATySJzUYySIKNO0jDPK1rpq9y5+ewe0IUxrj+GFIjVCgeS8vF70NqM9a3BLfmEHmjdNbL7Mq1RbvaLSRHH4JGNvJTP1CyiYHibLJB+0Cnu+XXaKgE6UvNuqc62O98CQcvs6cN6t0UTMHBO30G9QoMtT5OT4zmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087245; c=relaxed/simple;
	bh=kUPSjHIdo5b6UCkSq3DGtR3b5FmmhIgn/FXMmb/nNT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/LSS8hifgKajlUfhYeJCVkQn3PRkx6pKHZ8b/r+0GB34G8yiHnmvHl2j7FjNSTPk0odm8gUVZbA2fwSjHvJluHoNLQljGvAu7vozRl1zUIDYM/BheeVvVRBUkzkpPn5HKbbOQJkBbi/zlut61sTteQ9a5T/4ElNPx9roGDK+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1t14Zm-00043n-RE; Wed, 16 Oct 2024 16:00:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1t14Zm-002Hk4-EV; Wed, 16 Oct 2024 16:00:34 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1t14Zm-00ETUa-19;
	Wed, 16 Oct 2024 16:00:34 +0200
Date: Wed, 16 Oct 2024 16:00:34 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Avichal Rakesh <arakesh@google.com>,
	Jayant Chowdhary <jchowdhary@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 0/9] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers and fixes
Message-ID: <Zw_HAsXJuJZaYTpO@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
 <2024101636-studied-job-41b2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GtOdYJ2fcxIKD3mT"
Content-Disposition: inline
In-Reply-To: <2024101636-studied-job-41b2@gregkh>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--GtOdYJ2fcxIKD3mT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:47:00AM +0200, Greg Kroah-Hartman wrote:
>On Sun, Sep 29, 2024 at 08:59:20PM +0200, Michael Grzeschik wrote:
>> This patch series is improving the size calculation and allocation of
>> the uvc requests. Using the selected frame duration of the stream it is
>> possible to calculate the number of requests based on the interval
>> length.
>>
>> It also precalculates the request length based on the actual per frame
>> size for compressed formats.
>>
>> For this calculations to work it was needed to rework the request
>> queueing by moving the encoding to one extra thread (in this case we
>> chose the qbuf) context.
>>
>> Next it was needed to move the actual request enqueueing to one extra
>> thread which is kept busy to fill the isoc queue in the udc.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> ---
>> Changes in v6:
>> - fixes in: ("usb: gadget: uvc: add trace of enqueued and completed requ=
ests")
>> - Link to v5: https://lore.kernel.org/r/20240403-uvc_request_length_by_i=
nterval-v5-0-2de78794365c@pengutronix.de
>
>Breaks the build for me:
>
>In file included from drivers/usb/gadget/function/uvc_trace.h:60,
>                 from drivers/usb/gadget/function/uvc_trace.c:11:
>./include/trace/define_trace.h:95:42: fatal error: ./uvc_trace.h: No such =
file or directory
>   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>      |                                          ^
>
>what did you build this against?

I somehow managed to drop the CFLAGS for the uvc_trace.o
which was "CFLAGS_uvc_trace.o         :=3D -I$(src)"

This was just fixed in v7. Please try that one:

https://lore.kernel.org/all/20240403-uvc_request_length_by_interval-v7-0-e2=
24bb1035f0@pengutronix.de/

Thanks for testing this,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--GtOdYJ2fcxIKD3mT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmcPxv0ACgkQC+njFXoe
LGQiBA/9HUyodl0rGm8dfbEJHHYrzriPAaDBltGvHRxSUCCSAgoQr4BO+XKuKNNe
+GQnaCad5VZ72c5Z24mwd/4ElictvI5EDw79viJGN6SYMiAXLD2dr5Y+g4DvnE74
MwezEjJleACmT8k5HMgxA565ksu5s3Hd1Nha43ai+d2gm8G04TPbQk5ehum9QwZ2
7OJ8RrByaFhMP/PHOsz60WD17le+jdlPdZoP2W4Dij0H3wJDaUN2xiSHi9jK3vVp
mi3MJf4i9ZYoi68kul9q9qqA0ZMsVPXXtIo+AbeGkhcqMOtJ3zTe4fohHjfktpWI
TlT4QH/llGtEt5/1QeBddO7aQQlAtMfsAFV/4NHA8Ir1dqatXuEd42WRUzS6fmDY
CLvaGgk1pRNaWLUbnEPR68HmgDl6Ku9Zw9OHG+Qv0TtPZnDE6z1/lyrVfybpaQe5
bNw9f+TCe+ZRLyXAE0+KOJdcn8u1sFdYxCbdZF5WoRMMqoiIp3Jnsoz2ecPV69Ue
klAlIqBlbbLUYiR7ONrCVI0fFtGitgN5cyzpZL9PMnLnnhsPw+evMEEWqUtyrY/l
1b2PSs7uKdi23HnWq9V0oUPj1NrMwoqC4JicruqPSKfaR5NSlqMfkgPo7hqdteMt
n2VvMItQ3+6PmEsHse9eU6lXAX1xpgixMFYYQRQp7GEolx0zA6Q=
=+JYY
-----END PGP SIGNATURE-----

--GtOdYJ2fcxIKD3mT--

