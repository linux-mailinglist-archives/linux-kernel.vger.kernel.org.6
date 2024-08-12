Return-Path: <linux-kernel+bounces-282987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A409694EB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0029FB223B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1E175D24;
	Mon, 12 Aug 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M71H/EgT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE17276D;
	Mon, 12 Aug 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460158; cv=none; b=PtQ2wZ8E7gLN8YixoMc1fbcQj1DN4xmWrQ8pQ7HhdadkIy7bvkgvLR9dF7j/zjaqjZfZSKWT4W2qHfDWlSu+6PJGSskZuBmsz9CYyJz7w8MRy80DiHWm+tRN/N45nQVWLtWBanN6vRD2uq3y9pnClcykoge9nEOQ/LWLIFTCd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460158; c=relaxed/simple;
	bh=xmEeYdtNuW+3cnR/EzmNjnBz/EcZvKiGmJvgSfY+js8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SkaKRLH0PO9IxqlpzK+/RdbrD0G2Y4xnnB1oDBw50mMEStY8ZuO4ohZu2o/nkD64R3o3Kqp24bNe2ANivyJk74l/SZKoslRsnUvkheOeEgDYyXUyJR5hcE3yy5qsRH9wHIiOllaydAKCqXcJG3XEZ4K+RkyqkkJHGSENvPqJ/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M71H/EgT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723460157; x=1754996157;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xmEeYdtNuW+3cnR/EzmNjnBz/EcZvKiGmJvgSfY+js8=;
  b=M71H/EgTP+46hbhsPU+hhtH2NvaQ04eAqSOnmwSTmNsjbd8u5GtcFdqw
   JcUvfr2LTMbNzHI5Sx73C3BxVYiPw9Bo2TPdCkF7O/nUKrJnCM0960HQK
   KJw1h1FgmMdF7k3XYNF/DX8iBVLAgYp6VtU3AfYySV1lgqa+ujeZv+hDk
   aMaMc9IZ9rhr+XBiQGfTgVqVWU0R7DWOtC1mb3d4oqgAQYbb8zhLa1Ttz
   s6Hq3nycqenTuPE/HPCw6lD8qSwAG9LjM4GnROEB73iJf3pBvwdxGzsuq
   rIpJFJggz0SYD2KBP1GnkCzQSYyrdWL9/W8fHSACjYmjtTmcqapLDhcdl
   w==;
X-CSE-ConnectionGUID: 2aqigP5fR5GjHUIWTnkYdg==
X-CSE-MsgGUID: XdpeXcqjTcuTdXiv/1GPGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32713770"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32713770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:55:56 -0700
X-CSE-ConnectionGUID: 0GqZU1jMTLGV4mu+Q094Ew==
X-CSE-MsgGUID: GDlU6+cSRB+PkB26h8+/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58939258"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:55:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 13:55:50 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ISST: Simplify isst_misc_reg() and
 isst_misc_unreg()
In-Reply-To: <20240731184256.1852840-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <f6f3ca5a-8179-e678-aa8d-aeeacdcddb31@linux.intel.com>
References: <20240731184256.1852840-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1021919508-1723460150=:1039"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1021919508-1723460150=:1039
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 Jul 2024, Srinivas Pandruvada wrote:

> After commit '1630dc626c87 ("platform/x86: ISST: Add model specific
> loading for common module")' isst_misc_reg() and isst_misc_unreg() can be
> simplified. Since these functions are only called during module_init()
> and module_exit() respectively, there is no contention while calling
> misc_register()/misc_deregister or isst_if_cpu_info_init()/
> isst_if_cpu_info_exit().
>=20
> Hence remove mutex and reference counting.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel/speed_select_if/isst_if_common.c    | 42 +++++--------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c =
b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 3065f149e721..febfd5eeceb4 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -651,10 +651,6 @@ static long isst_if_def_ioctl(struct file *file, uns=
igned int cmd,
> =20
>  /* Lock to prevent module registration when already opened by user space=
 */
>  static DEFINE_MUTEX(punit_misc_dev_open_lock);
> -/* Lock to allow one shared misc device for all ISST interfaces */
> -static DEFINE_MUTEX(punit_misc_dev_reg_lock);
> -static int misc_usage_count;
> -static int misc_device_ret;
>  static int misc_device_open;
> =20
>  static int isst_if_open(struct inode *inode, struct file *file)
> @@ -720,39 +716,23 @@ static struct miscdevice isst_if_char_driver =3D {
> =20
>  static int isst_misc_reg(void)
>  {
> -=09mutex_lock(&punit_misc_dev_reg_lock);
> -=09if (misc_device_ret)
> -=09=09goto unlock_exit;
> -
> -=09if (!misc_usage_count) {
> -=09=09misc_device_ret =3D isst_if_cpu_info_init();
> -=09=09if (misc_device_ret)
> -=09=09=09goto unlock_exit;
> -
> -=09=09misc_device_ret =3D misc_register(&isst_if_char_driver);
> -=09=09if (misc_device_ret) {
> -=09=09=09isst_if_cpu_info_exit();
> -=09=09=09goto unlock_exit;
> -=09=09}
> -=09}
> -=09misc_usage_count++;
> +=09int ret;
> =20
> -unlock_exit:
> -=09mutex_unlock(&punit_misc_dev_reg_lock);
> +=09ret =3D isst_if_cpu_info_init();
> +=09if (ret)
> +=09=09return ret;
> =20
> -=09return misc_device_ret;
> +=09ret =3D misc_register(&isst_if_char_driver);
> +=09if (ret)
> +=09=09isst_if_cpu_info_exit();
> +
> +=09return ret;
>  }
> =20
>  static void isst_misc_unreg(void)
>  {
> -=09mutex_lock(&punit_misc_dev_reg_lock);
> -=09if (misc_usage_count)
> -=09=09misc_usage_count--;
> -=09if (!misc_usage_count && !misc_device_ret) {
> -=09=09misc_deregister(&isst_if_char_driver);
> -=09=09isst_if_cpu_info_exit();
> -=09}
> -=09mutex_unlock(&punit_misc_dev_reg_lock);
> +=09misc_deregister(&isst_if_char_driver);
> +=09isst_if_cpu_info_exit();
>  }
> =20
>  /**
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1021919508-1723460150=:1039--

