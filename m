Return-Path: <linux-kernel+bounces-566471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F65A6786B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61450189B146
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F920FA99;
	Tue, 18 Mar 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bWEYhkwg"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323277464;
	Tue, 18 Mar 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313203; cv=none; b=nOHFPVUNFscOfzLGdLexHtRlKsrUMFSKxUwVsBFcTC9y+CO1Abnyh2q9iDfbH6eISOtlj1tDj0Akh4CJtZlsLR3EMSiTPKhFZq+sEt1keqy16k4QsHMipSY9aaSdEF5ycTYvgjdduWmQ+KuQNyf8TNvUaet5Mio7Smxb+faMDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313203; c=relaxed/simple;
	bh=/L/vb59tMICXkWyQfLdayIVVHIj+CbXfwoPWYrJWspg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRXtpSrIFSyEgmHydegZOZHPFS8shSveJRun3EUGeiTiT4QgvncX6h/UI3puKAPuaiaXKn5aQEnbYQRqlk3Us5OnXYa7fpq+adrtdUyvmDMhtfSl5C/KYgkEfk8vJ7xxWtSLfDdjBhfKJCiHE39ttrug68W/i4V0QyalOqcQimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bWEYhkwg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 779D7443FC;
	Tue, 18 Mar 2025 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742313195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAWNBG+PNBdOBSynjb6NA8R0b0TjTIkaOpMrZv7LLCU=;
	b=bWEYhkwgJbIncuTobP8+YhQR2CafKyxtki7qRzVUWrDvZ5JAQBMsAmoIvg21Watx/9DXk3
	T1ubG2RlF2Pr9srzxvUB2oH484qP/OsB0ijj2JACGS0lPnoV1+sGXuwP0f5DfyzPn6Uxob
	Biz8Q9Kd/6VPKSIz8WnzzrouA9d+KUHmZGllzzmTOEN3axjeV+9KAM3qgNoAvZ8gm2Nde5
	49ge5xqZkkn8JkaWCpa2gKnP/nUvQrihs91E9F3qx/K994G8WcUDTopho/SyvrPXNhWYPz
	y+wleBNzR/JC6VuyFunE1fVOUiPzkH45O0fcA5H28pG/xDLh8BuZj1OIXZiG3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <robh@kernel.org>,
  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <linux-mtd@lists.infradead.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <git@amd.com>,
  <amitrkcian2002@gmail.com>,  Bernhard Frauendienst
 <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v12 3/3] mtd: Add driver for concatenating devices
In-Reply-To: <20250205133730.273985-4-amit.kumar-mahapatra@amd.com> (Amit
	Kumar Mahapatra's message of "Wed, 5 Feb 2025 19:07:30 +0530")
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-4-amit.kumar-mahapatra@amd.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 16:53:14 +0100
Message-ID: <8734fa8hed.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegrmhhithdrkhhumhgrrhdqmhgrhhgrphgrthhrrgesrghmugdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 05/02/2025 at 19:07:30 +0530, Amit Kumar Mahapatra <amit.kumar-mahapatra=
@amd.com> wrote:

> Introducing CONFIG_VIRT_CONCAT to separate the legacy flow from the
> new

CONFIG_MTD_VIRT_CONCAT

> approach, where individual partitions within a concatenated partition are
> not registered, as they are likely not needed by the user.

I am not a big fan of this choice. We had issues with hiding things to
the user in the first place. Could we find a way to expose both the
original mtd devices as well as the virtually concatenated partitions?

> Solution is focusing on fixed-partitions description only because it
> depends on device boundaries.
>
> Suggested-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/mtd/Kconfig           |   8 ++
>  drivers/mtd/Makefile          |   1 +
>  drivers/mtd/mtd_virt_concat.c | 254 ++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdcore.c         |   7 +
>  drivers/mtd/mtdpart.c         |   6 +
>  include/linux/mtd/concat.h    |  24 ++++
>  6 files changed, 300 insertions(+)
>  create mode 100644 drivers/mtd/mtd_virt_concat.c
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 796a2eccbef0..3dade7c469df 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -206,6 +206,14 @@ config MTD_PARTITIONED_MASTER
>  	  the parent of the partition device be the master device, rather than
>  	  what lies behind the master.
>=20=20
> +config MTD_VIRT_CONCAT
> +	tristate "Virtual concatenated MTD devices"
> +	help
> +	  The driver enables the creation of a virtual MTD device

                                          of virtual MTD devices

> +	  by concatenating multiple physical MTD devices into a single
> +	  entity. This allows for the creation of partitions larger than
> +	  the individual physical chips, extending across chip boundaries.
> +

...

> +static int __init mtd_virt_concat_create_join(void)
> +{
> +	struct mtd_virt_concat_node *item;
> +	struct mtd_concat *concat;
> +	struct mtd_info *mtd;
> +	ssize_t name_sz;
> +	char *name;
> +	int ret;
> +
> +	list_for_each_entry(item, &concat_node_list, head) {
> +		concat =3D item->concat;
> +		mtd =3D &concat->mtd;
> +		/* Create the virtual device */
> +		name_sz =3D snprintf(NULL, 0, "%s-%s%s-concat",
> +				   concat->subdev[0]->name,
> +				   concat->subdev[1]->name,
> +				   concat->num_subdev > MIN_DEV_PER_CONCAT ?
> +				   "-+" : "");
> +		name =3D kmalloc(name_sz + 1, GFP_KERNEL);
> +		if (!name) {
> +			mtd_virt_concat_put_mtd_devices(concat);
> +			return -ENOMEM;
> +		}
> +
> +		sprintf(name, "%s-%s%s-concat",
> +			concat->subdev[0]->name,
> +			concat->subdev[1]->name,
> +			concat->num_subdev > MIN_DEV_PER_CONCAT ?
> +			"-+" : "");
> +
> +		mtd =3D mtd_concat_create(concat->subdev, concat->num_subdev, name);
> +		if (!mtd) {
> +			kfree(name);
> +			return -ENXIO;
> +		}
> +
> +		/* Arbitrary set the first device as parent */

Here we may face runtime PM issues. At some point the device model
expects a single parent per struct device, but here we have two. I do
not have any hints at the moment on how we could solve that.

> +		mtd->dev.parent =3D concat->subdev[0]->dev.parent;
> +		mtd->dev =3D concat->subdev[0]->dev;
> +
> +		/* Register the platform device */
> +		ret =3D mtd_device_register(mtd, NULL, 0);
> +		if (ret)
> +			goto destroy_concat;
> +	}
> +
> +	return 0;
> +
> +destroy_concat:
> +	mtd_concat_destroy(mtd);
> +
> +	return ret;
> +}
> +
> +late_initcall(mtd_virt_concat_create_join);

The current implementation does not support probe deferrals, I believe
it should be handled.

> +static void __exit mtd_virt_concat_exit(void)
> +{
> +	mtd_virt_concat_destroy_joins();
> +	mtd_virt_concat_destroy_items();
> +}
> +module_exit(mtd_virt_concat_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Bernhard Frauendienst <kernel@nospam.obeliks.de>");
> +MODULE_AUTHOR("Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>");
> +MODULE_DESCRIPTION("Virtual concat MTD device driver");
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 724f917f91ba..2264fe81810f 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -34,6 +34,7 @@
>=20=20
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/mtd/concat.h>
>=20=20
>  #include "mtdcore.h"
>=20=20
> @@ -1067,6 +1068,12 @@ int mtd_device_parse_register(struct mtd_info *mtd=
, const char * const *types,
>  			goto out;
>  	}
>=20=20
> +	if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)) {

Maybe IS_REACHABLE() is more relevant?

> +		ret =3D mtd_virt_concat_node_create();
> +		if (ret < 0)
> +			goto out;
> +	}
> +
>  	/* Prefer parsed partitions over driver-provided fallback */
>  	ret =3D parse_mtd_partitions(mtd, types, parser_data);
>  	if (ret =3D=3D -EPROBE_DEFER)

Thanks,
Miqu=C3=A8l

