Return-Path: <linux-kernel+bounces-447322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF219F3082
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AAC1884EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D8204C02;
	Mon, 16 Dec 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQx9hEte"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3934CC4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352118; cv=none; b=Oe4Sqdx+bPDKpCjgryMZHEcUpll65jxDPyhtOm56Ev7SHYm/n1M4mSTXJBQnHqeX/Mn5Q47CLLJbfjbytwnKCa19nZ2N1mFseVLVP2uC9tHn1BrYz0mQb4rn7F6YHoTqME28s08+ot5mU4DKDYGZ8uI62TlDheMltk7yoRx/WE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352118; c=relaxed/simple;
	bh=4RFvCkZrInw7CqbriwYyKrDhmISsz93cM76PyATj7N8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDrG7Fur7ieK8JNdzMHxkxGfH2RC2lG92CBQ01R88Ac+N9si+CYELlKvdpZ+k1FtYeOa/39DrVQU56Z7zuWWmo7jlRU+7j9NaErMVpvKwg1NvzTYJeDzg6m7RchGLpxCIa84GRUNTX3AN9er7fO4pg7aiwQ3gEfCFu4ASjHONps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQx9hEte; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734352116; x=1765888116;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=4RFvCkZrInw7CqbriwYyKrDhmISsz93cM76PyATj7N8=;
  b=RQx9hEteigzzB7itKGaiiMkikM+oQcUCZMg+lrjwNckr0Miy9GHlqQ/U
   fldDtRPS6ZJw+shF5L0Uwjb0WMp1kXwkxuizr6AFugdXBVuFlflyCvmL9
   GhVrFgDKnYQ9CQZ4lR5sBtBy87jXZmQ3nAavMweS1yCG1peThGdj3OTQ+
   xh5xdntRKjuEM7F/7YOshQFTzh85RcmSoeGuYXDvgQXB5VCRghKAE1ome
   nT3BqnH042FTFuN/uqiedl7vGsrIX7OkbzXEVWItacTurhossrKf/KXUY
   F41aL47pg3wJuZmJW/azJ3Ky6ShbYrUEtIBgL7tnHjpf2/WLHM0ni4y+W
   g==;
X-CSE-ConnectionGUID: wk/h7LuWSU2ZztDH7y9gDA==
X-CSE-MsgGUID: P7I3/KA/StmLA5kWMZArOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22318244"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22318244"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:28:35 -0800
X-CSE-ConnectionGUID: xjgEhNbtRgqZI0a1vvWdLQ==
X-CSE-MsgGUID: 9F7A9lH7T+ml0QWmQt6BBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97980606"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.245])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 04:28:33 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Ofir Bitton
 <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] accel/habanalabs: constify 'struct bin_attribute'
In-Reply-To: <20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net>
Date: Mon, 16 Dec 2024 14:28:30 +0200
Message-ID: <87ldwfstg1.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2024, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/accel/habanalabs/common/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/haba=
nalabs/common/sysfs.c
> index e9f8ccc0bbf9d4dabec1b51072d07170c51ffc9e..9d58efa2ff380c8773bd79bea=
613dc79a5a98020 100644
> --- a/drivers/accel/habanalabs/common/sysfs.c
> +++ b/drivers/accel/habanalabs/common/sysfs.c
> @@ -368,7 +368,7 @@ static ssize_t max_power_store(struct device *dev,
>  }
>=20=20
>  static ssize_t eeprom_read_handler(struct file *filp, struct kobject *ko=
bj,
> -			struct bin_attribute *attr, char *buf, loff_t offset,
> +			const struct bin_attribute *attr, char *buf, loff_t offset,
>  			size_t max_size)
>  {
>  	struct device *dev =3D kobj_to_dev(kobj);
> @@ -443,10 +443,10 @@ static DEVICE_ATTR_RO(security_enabled);
>  static DEVICE_ATTR_RO(module_id);
>  static DEVICE_ATTR_RO(parent_device);
>=20=20
> -static struct bin_attribute bin_attr_eeprom =3D {
> +static const struct bin_attribute bin_attr_eeprom =3D {
>  	.attr =3D {.name =3D "eeprom", .mode =3D (0444)},
>  	.size =3D PAGE_SIZE,
> -	.read =3D eeprom_read_handler
> +	.read_new =3D eeprom_read_handler
>  };
>=20=20
>  static struct attribute *hl_dev_attrs[] =3D {
> @@ -472,14 +472,14 @@ static struct attribute *hl_dev_attrs[] =3D {
>  	NULL,
>  };
>=20=20
> -static struct bin_attribute *hl_dev_bin_attrs[] =3D {
> +static const struct bin_attribute *const hl_dev_bin_attrs[] =3D {
>  	&bin_attr_eeprom,
>  	NULL
>  };
>=20=20
>  static struct attribute_group hl_dev_attr_group =3D {
>  	.attrs =3D hl_dev_attrs,
> -	.bin_attrs =3D hl_dev_bin_attrs,
> +	.bin_attrs_new =3D hl_dev_bin_attrs,
>  };
>=20=20
>  static struct attribute_group hl_dev_clks_attr_group;
>
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241216-sysfs-const-bin_attr-habanalabs-8c95e852dd8a
>
> Best regards,

--=20
Jani Nikula, Intel

