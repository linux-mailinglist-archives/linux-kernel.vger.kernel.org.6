Return-Path: <linux-kernel+bounces-512804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919EA33DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0564A161E49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37404227E99;
	Thu, 13 Feb 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kzck7Mel"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4F227E96
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445901; cv=none; b=mNPlk/T9ZJrixHBedpVi9Etk2coh/tgsEgRWHzRrXY3KRROuENavWWFgtHuEscfxHg28Ua6uYsPGipj3TEWoSQr3VlJz2MIzM4thittASGKjWHV0Pt1ZIDD+0J9FOTrzTgvu1TS/UHZb+xaQxyK0E9aOGusRz5gDntyp1Dek1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445901; c=relaxed/simple;
	bh=TrqZQ55skZTEXJEjUlXW0jtm/l2cPFM8QthEOGpqvUU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qgg273c1caj/lFbIPhRIEQgiHw338+rlOzCSNA8HzR3An6y5+6BNIajl81Z3EGAMmSOVkHKtRMcLnRh5WZ1qMtJBMkEE9HNbgOGkp4AXTMbY+Q3+/3pTDVKsVMQA0s8GDxLokDJD1kXurGe5FQeJY0CstUj4cAZLMnTvbPqrYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kzck7Mel; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739445886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdHz7WZoxJQP/6i9ahhNRirmtERVrbghz+wuhiC82JQ=;
	b=kzck7MelYDJxOSs2OcrmS9Gs1IT+TP/TVAqwA5gr/i2VAyNgkmCa0yGDpk18rPkp6namMf
	8CRlgv6XYKf8LyGjjTx1NaTfc9Pe7yjYx8MT/jeQeZye6SWntn3cgHf5gjGDkvwImMbD/g
	qAfaHzMcf4oERyXNWwvhuHQ35TCtvNQ=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] scsi: hpsa: Replace deprecated strncpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250212222214.86110-2-thorsten.blum@linux.dev>
Date: Thu, 13 Feb 2025 12:24:33 +0100
Cc: linux-hardening@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 storagedev@microchip.com,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34BB4FDE-062D-4C1B-B246-86CB55F631B8@linux.dev>
References: <20250212222214.86110-2-thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 12. Feb 2025, at 23:22, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers [1]. =
Use
> strscpy() instead and remove the manual NUL-termination.
>=20
> Use min() to simplify the size calculation.
>=20
> Compile-tested only.
>=20
> Link: =
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings [1]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> ---
> drivers/scsi/hpsa.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 84d8de07b7ae..9399e101f150 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -460,9 +460,8 @@ static ssize_t =
host_store_hp_ssd_smart_path_status(struct device *dev,
>=20
> 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> 		return -EACCES;
> -	len =3D count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] =3D '\0';
> +	len =3D min(count, sizeof(tmpbuf) - 1);
> +	strscpy(tmpbuf, buf, len);

With strscpy() it should probably just be sizeof(tmpbuf) without -1, and
then add +1 to count for the number of copied bytes to be the same as
with strncpy().

Like this:

	len =3D min(count + 1, sizeof(tmpbuf));

This subtle difference between strncpy() and strscpy() regarding the
number of bytes copied isn't really documented anywhere, is it? The
documentation I came across so far seems to focus mostly on the
different return values of the two functions.

> 	if (sscanf(tmpbuf, "%d", &status) !=3D 1)
> 		return -EINVAL;
> 	h =3D shost_to_hba(shost);
> @@ -484,9 +483,8 @@ static ssize_t =
host_store_raid_offload_debug(struct device *dev,
>=20
> 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
> 		return -EACCES;
> -	len =3D count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] =3D '\0';
> +	len =3D min(count, sizeof(tmpbuf) - 1);
> +	strscpy(tmpbuf, buf, len);

Same here.

> 	if (sscanf(tmpbuf, "%d", &debug_level) !=3D 1)
> 		return -EINVAL;
> 	if (debug_level < 0)

Maybe someone can confirm my reasoning before I submit a v2?

Thanks,
Thorsten


