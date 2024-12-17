Return-Path: <linux-kernel+bounces-449283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57469F4CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981C7188BB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6961F4287;
	Tue, 17 Dec 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iVer/6qF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="k9qSOWSM"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB71F3D57
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443071; cv=none; b=iwu/RvJLJJpINf3hURpZ5+0gW7qIyNDzzGBi7s5tlqTkIhI6wYdxATR7v6uE+GwlAy8BYy2zS9rK8B5QyEyKqe7xEo9tIJJDwbtGi5xKstI6Mo1vd4c5y15e4OVTmzqD3yhlKrUkjEcD8/E+gB9OYWfzOra2zegF2uQU7zxQXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443071; c=relaxed/simple;
	bh=Fz2nipNydPboYMcYKzMpIjR2a3kQWZ5l0Yk661B97Sg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iW+atkB3G3ilSL3ZFUk038RlZx+6z4WYI9gpKaVSFqc5j9ijeBTGck0L0QjSosW3McdyjVRs40pTD3UyBowtni17IEOXNTI/DpQ6vlIOHt6CVe2qDIgKmMZImJs/kzIVRq7NY78dNFffqn/Z/NwbuoCJY5jbTtvB6Qtp7DxBdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iVer/6qF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=k9qSOWSM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1734443067; x=1765979067;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Orzx5OoS6b6VHqMGyTqYJJk9MyacX0GuWpBG2KX96gE=;
  b=iVer/6qFlttXiH2t96wdIWeult1tkxoik5JXA0mhFPowuLs6zmPiXgjk
   T6/4JeZLoe69o6VVUOdT/KggDDqySN9QdH/y7uFesbtUhUZzvVGJVUEuz
   ShYvBJ0o5vxf44EzWGM/JyLWu/rzvKMCnruKjXVoUgT4QO3av2joqq+pF
   X9uCq1pjboWuYYyHW7U1nTfgX1XiNXttgufDdFrIZ+vXl2iAeDgzPTfwJ
   9R9d9YhYTJtNHwiJz6jCDzTfwRVOOZScSf2HqnshLLIquSRKbZ1nsNGbN
   2RmOPcVaGjsL8IGNwsd6mq6GTclbXy+q7t4iHXTLiDklC2wXd+Axo7/AU
   w==;
X-CSE-ConnectionGUID: 6kmYzyg0RtGJm5WRSeV2mA==
X-CSE-MsgGUID: vNGZj87bQyuzo6hcMMwZNg==
X-IronPort-AV: E=Sophos;i="6.12,241,1728943200"; 
   d="scan'208";a="40653663"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Dec 2024 14:44:18 +0100
X-CheckPoint: {67618032-20-F04831A1-C5AE3AEA}
X-MAIL-CPID: 2D32DC99E547F0082D66A4E555B49B9B_2
X-Control-Analysis: str=0001.0A682F27.67618032.00BC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79394177AC3;
	Tue, 17 Dec 2024 14:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1734443054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Orzx5OoS6b6VHqMGyTqYJJk9MyacX0GuWpBG2KX96gE=;
	b=k9qSOWSMdnOHxkGtjvYF+vZeDcgAsMtpJ0ovLD7yd62CCm5Jtip2DnBmvnEDI9MwBnQNuw
	yvA33V82GXKs0fnJqdzn5+fG30Te1mciKK1TkQteYfEPY7ZSXLFiquByuJ/L2VFMuqU/ez
	c/gta5L75EYzOc15atRzAM9k+hXWt73SwGCtsIbg/5i4BXvsoKdPSJ8LF1C/CH6v6bXmM0
	VrX8Rvoxh77PEoDCq5ZaKD7/97XGdsEzlpVqU5oNPtuE+Pb7y0RlYXQBO1Nf+l1AbQpD+O
	4jCEwnn6c04Ix95MwwPcs/tUZpyeex5Nwyb+D+uhB6DQZx1lOrO0a3xFqe0FaA==
Message-ID: <3b8ed7fbe4fd879b34b40c74485e2871849ddc93.camel@ew.tq-group.com>
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>, 
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J.Wysocki" <rafael@kernel.org>, 
	linux@ew.tq-group.com
Date: Tue, 17 Dec 2024 14:44:12 +0100
In-Reply-To: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
References: 
	<20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-06-24 at 11:20 -0400, N=C3=ADcolas F. R. A. Prado wrote:
> Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> SYNC_STATE_ONLY device links") introduced an early return in
> device_link_add() to prevent useless links from being created. However
> the calling function fw_devlink_create_devlink() unconditionally prints
> an error if device_link_add() didn't create a link, even in this case
> where it is intentionally skipping the link creation.
>=20
> Add a check to detect if the link wasn't created intentionally and in
> that case don't log an error.


While it was concluded that this patch was not needed to fix the author's i=
ssue,
I have come across a similar problem that I have not been able to solve:

I'm currently working on a TI AM335x, and after updating to a recent kernel
(currently 6.12.4) and fixing the ti-sysc driver to probe in a few cases wh=
ere
it was broken before, I'm now seeing the following messages:

ti-sysc 44e31000.target-module: Failed to create device link (0x180) with o=
cp
ti-sysc 48040000.target-module: Failed to create device link (0x180) with o=
cp

The direct cause of the failure is the same as noted in this patch: The
44e31000.target-module and 48040000.target-module devices have already been
probed at this point, so applying it would hide the error message.

The attempt to create these device links results from a call to
__fw_devlink_pickup_dangling_consumers() moving consumers from
/ocp/interrupt-controller@48200000 to /ocp. This happens because the interr=
upt
controller driver (irq-omap-intc) is declared using IRQCHIP_DECLARE(), so i=
ts
fwnode doesn't have an associated device.

As the existence of fwnodes without device is the whole point of
__fw_devlink_pickup_dangling_consumers(), I imagine that this is a valid ca=
se
that should be supported properly. Would it make sense to reconsider this p=
atch,
or is there a better solution? The condition for hiding the error message c=
ould
also be made stricter by introducing a new fwnode_link flag to mark links t=
hat
have been moved by __fw_devlink_pickup_dangling_consumers().

Best regards,
Matthias


>=20
> Fixes: ac66c5bbb437 ("driver core: Allow only unprobed consumers for SYNC=
_STATE_ONLY device links")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/base/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..5eaafe3a280c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2187,8 +2187,13 @@ static int fw_devlink_create_devlink(struct device=
 *con,
>  		}
> =20
>  		if (con !=3D sup_dev && !device_link_add(con, sup_dev, flags)) {
> -			dev_err(con, "Failed to create device link (0x%x) with %s\n",
> -				flags, dev_name(sup_dev));
> +			if (flags & DL_FLAG_SYNC_STATE_ONLY &&
> +			    con->links.status !=3D DL_DEV_NO_DRIVER &&
> +			    con->links.status !=3D DL_DEV_PROBING)
> +				dev_dbg(con, "Skipping device link creation for probed device\n");
> +			else
> +				dev_err(con, "Failed to create device link (0x%x) with %s\n",
> +					flags, dev_name(sup_dev));
>  			ret =3D -EINVAL;
>  		}
> =20
>=20
> ---
> base-commit: b992b79ca8bc336fa8e2c80990b5af80ed8f36fd
> change-id: 20240624-fwdevlink-probed-no-err-45d21feb05fd
>=20
> Best regards,

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

