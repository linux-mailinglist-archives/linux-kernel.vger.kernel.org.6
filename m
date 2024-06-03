Return-Path: <linux-kernel+bounces-199259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C268D8486
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D230D28A779
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028381207;
	Mon,  3 Jun 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vnk9rxj2"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BF1E504
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423234; cv=none; b=agU8pfOq/ffI8AkdXW6l7j6kZJ9j9Bv7rxO86zDsWUrQ7HV+PbQzAxInE0+ne6+9UKmGljXDI08jGdpD0/nR7FTQfBcN1mjQzu1a7ITR8iv2aElacAsn19WdAaLQ0ux42m71+Qo+ujsF+CdJCg564RZyeUbL0J+W/J4zciY2PQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423234; c=relaxed/simple;
	bh=Tq+fTOP9a85zGx81hI5MmId6I7YXI6owwkdLPoka3YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnhWhKOI+0AIjKcjajt+b8V6t5703NN6m2DKfQ+lG1OmI1sEoceAaSuLC9Pe7CrHS+dAW5DJGHJVHxhFTpf0HT1RXetB07HgPBcpGr566NqdoWTUCoxJnAMpK1YAKPnJqOXd+IGITSckCPLIGJTSwlpqq8Ck0DLX3cUYXbwIyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vnk9rxj2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5293F40019;
	Mon,  3 Jun 2024 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717423223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUiKeSDAw5PSWaHAWumiSmz2tV9iwBOhkTk5YbNtRJw=;
	b=Vnk9rxj2LrJ31ASbDAuodEeVDzQEiuJI6BXER38I5f8OLktmjqg4+Ot1G7uXJrLWYDCMPj
	r4c1Ejhl02HzHSrCCx+M31d9nMPrNl6Ewk55kp1kGd1EowRllfKsbSxfY8PiOVyq6xH6YD
	m/8WOmH+Ojb/qlevO6BD5LPiCUpo0HG5MHXTF+fRt4pjI0aJ7vdJBFRg8appj96hZhvHQf
	KtEY+gP+5Ao7sQMYTeQqKbNEi9AsPbIK+yKoVP4sbrORpGDW2PLjnyj+P7OUfwMkUAasAX
	+39x0pHa2zrVb3Rwxi931X2VeKDeY7yNKIX0zirc72/gyF1cUoQEeq40ch5sxA==
Date: Mon, 3 Jun 2024 16:00:18 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org (moderated
 list:SILVACO I3C DUAL-ROLE MASTER), linux-kernel@vger.kernel.org (open
 list), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: resend target address when get
 NACK
Message-ID: <20240603160018.29498c2f@xps-13>
In-Reply-To: <20240531163301.1401281-1-Frank.Li@nxp.com>
References: <20240531163301.1401281-1-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Fri, 31 May 2024 12:33:00 -0400:

> According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3:
>=20
> If the Controller chooses to start an I3C Message with an I3C Dynamic
> Address, then special provisions shall be made because that same I3C Targ=
et
> may be initiating an IBI or a Controller Role Request. So, one of three
> things may happen: (skip 1, 2)
>=20
> 3. The Addresses match and the RnW bits also match, and so neither
> Controller nor Target will ACK since both are expecting the other side to
> provide ACK. As a result, each side might think it had "won" arbitration,
> but neither side would continue, as each would subsequently see that the
> other did not provide ACK.
> ...
> For either value of RnW: Due to the NACK, the Controller shall defer the
> Private Write or Private Read, and should typically transmit the Target
> 						    ^^^^^^^^^^^^^^^^^^^
> Address again after a Repeated START (i.e., the next one or any one prior
> ^^^^^^^^^^^^^
> to a STOP in the Frame). Since the Address Header following a Repeated
> START is not arbitrated, the Controller will always win (see Section
> 5.1.2.2.4).
>=20
> Resend target address again if address is not 7E and controller get NACK.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I'm not getting 100% of it, but looks okay, so:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

