Return-Path: <linux-kernel+bounces-170849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129838BDCE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126831C23126
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FB13C909;
	Tue,  7 May 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DBdTuImE"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948313C81C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069070; cv=none; b=QX1WfQIiQCck0cKAf23TfxDe6LhGXpIZjaXHlv+Ih8aFxrxHh4f2ggB2QbjBUkNC+eovEji3Qyh9VI+HLn98J/PBzAgLHWBkIFzWMmQ0uknm9or0Bm737o8bDCp1SBjhfZQdHetlplYDqeh0h0Z5eVS+/PYXKv3mH9TM+8T+V2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069070; c=relaxed/simple;
	bh=0ykBxAOHnnyFYoBMTLFf57HmlIaOOKJXi3ApXDLq7OI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bX9AZvELaE5DpXa48gcI2mJ6Z0/ED6Eg0VapT5Cpzy7hBd23jWwiJjuiDPVNx6A19Yf8EBJIYlw8RHwYEG0biwNnEN8aUNBKmrf0EgWLpZlDEZYm1WV3ZA+qRoVD3zt0qd0WXJTqGNAAwEutPyqyiiRCtxiexSzx+e1BE4uTn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DBdTuImE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDC2060002;
	Tue,  7 May 2024 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715069065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsjTpPdQhp8xGYXA1tswPY/6gILWdgf1jxKsPkJpD10=;
	b=DBdTuImErvsqqyGScDzRjFP6Ovas2ZBQNaI3ew3vfdC+96+QHodwGpMNmeBcjkuS8qn+cb
	M2ELFwQoWEKVoK/tD2bfRNBtlzQiOMDxjAXfxkqAmtgdy0isoav5SA+rA8pAgv6dvTg6pS
	ijCrywnACX7Nyj2c0DG9hZQPLp965b8+JbK9BzdMyYvTOqeHFdKcWSDY4HjXrS0qAvIP69
	maeaj3TuseAdMJtr9YGK0D0+aEUBisgJ++0osrV46VsRW776IqCjrRUXu+untSJgFGL/Y0
	j6K0ui2o+/kLLdBQ/EabG0R/CeoLbcWzY64vuZCETVXIbRZL48IhC3StsbUXog==
Date: Tue, 7 May 2024 10:04:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 imx@lists.linux.dev, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i3c: master: svc: fix invalidate IBI type and
 miss call client IBI handler
Message-ID: <20240507100424.611181f1@xps-13>
In-Reply-To: <20240506164009.21375-3-Frank.Li@nxp.com>
References: <20240506164009.21375-1-Frank.Li@nxp.com>
	<20240506164009.21375-3-Frank.Li@nxp.com>
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

Frank.Li@nxp.com wrote on Mon,  6 May 2024 12:40:09 -0400:

> In an In-Band Interrupt (IBI) handle, the code logic is as follows:
>=20
> 1: writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI | SVC_I3C_MCTRL_IBIRESP_AUTO,
> 	  master->regs + SVC_I3C_MCTRL);
>=20
> 2: ret =3D readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
>                                     SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
> 	...
> 3: ibitype =3D SVC_I3C_MSTATUS_IBITYPE(status);
>    ibiaddr =3D SVC_I3C_MSTATUS_IBIADDR(status);
>=20
> SVC_I3C_MSTATUS_IBIWON may be set before step 1. Thus, step 2 will return
> immediately, and the I3C controller has not sent out the 9th SCL yet.
> Consequently, ibitype and ibiaddr are 0, resulting in an unknown IBI type
> occurrence and missing call I3C client driver's IBI handler.
>=20
> A typical case is that SVC_I3C_MSTATUS_IBIWON is set when an IBI occurs
> during the controller send start frame in svc_i3c_master_xfer().
>=20
> Clear SVC_I3C_MSTATUS_IBIWON before issue SVC_I3C_MCTRL_REQUEST_AUTO_IBI
> to fix this issue.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI ha=
ppen during start frame")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>=20
> Notes:
>     Change from v1 to v2
>     - improve comments.
>=20
>  drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 94e4954509558..032fe032ec433 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -415,6 +415,19 @@ static void svc_i3c_master_ibi_work(struct work_stru=
ct *work)
>  	int ret;
> =20
>  	mutex_lock(&master->lock);
> +	/*
> +	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
> +	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
> +	 * ibitype will be 0 since it was last updated only after the 8th SCL
> +	 * cycle, leading to missed client IBI handlers.
> +	 *
> +	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
> +	 * at svc_i3c_master_priv_xfers().
> +	 *
> +	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_=
IBI.
> +	 */

Thanks a lot.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

