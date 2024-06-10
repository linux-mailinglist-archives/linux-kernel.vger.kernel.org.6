Return-Path: <linux-kernel+bounces-208216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F9902270
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EC71F253AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8208286A;
	Mon, 10 Jun 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wfup0CYm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC505824A7;
	Mon, 10 Jun 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024978; cv=none; b=J2dM5mA0GT8KnUc+vJOlutBuK67nxW59Lb5mgPfgmyHarL4ZvxeSMWEZ0pM1d6+5q29LLNQ3fJcPwrfLuJrAaJOOtWe8ajsMChMEKpRJpVM7RDbG2AAsy0Do1xng2uD7n4+y46A3D0pcHCYLQhnM/Qo5o+82cz2iMANrouDisXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024978; c=relaxed/simple;
	bh=gB7jeHRb5DV8C61HuQ5QxIaXRVVU6HY9VOTvC2TQzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKGfzKLKRl0JkHNeaKV6hXequTnJGRudlvIGqRbH3loB2VB26kJRNlDkqZsr+UPuHQAmyVWM7dfkYu08qANC+EuWLCDABCo3VpRPZ5yMPjAtzrPZ756+6tXYHQlnD9Cb7hafEshYhZ4U68NYcMMzLV0H0B0duFhCPM2Ps6b32jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wfup0CYm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718024977; x=1749560977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gB7jeHRb5DV8C61HuQ5QxIaXRVVU6HY9VOTvC2TQzCQ=;
  b=Wfup0CYmdQU4vPJkeZcRy928aiUAR0EgdcgRHyRyCpuu8ktnEZYA+urK
   H/OXuiB619ArJM5wdJwkv9Nq4/jcK7E9GY8GoxhU3NZgSXdLUy3XvJL3O
   e/XuZd281jeshCHZfHFspX+zr3enkdSk5OCFZtHF+U0WVHkEiaMU445nQ
   bbkD4oJsCok3tt319QOsvFCb7UWc6vAFuMYRbEK/Ykjnu22f8m/5847K8
   MJCmC93LeYgDB79+Mu/kXiOcLNrDx8/LB5D8eOF5tmXOvlUH1drSszD60
   dUtniqGKc4+3H+iebsYtlMXWpkh/dIa9MgZ2fif3izZp38QcgS+N13rmq
   Q==;
X-CSE-ConnectionGUID: 32DO/0JJScGtnd0Q6CT4bQ==
X-CSE-MsgGUID: b1oGLuBYQ/6lfyLtTcGIEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32218237"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="32218237"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 06:08:39 -0700
X-CSE-ConnectionGUID: mD5k3pUFRkShc5rQpufMKA==
X-CSE-MsgGUID: Xwb2FoFOR7K6K9mCkt37Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39172672"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa009.fm.intel.com with SMTP; 10 Jun 2024 06:08:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Jun 2024 16:08:35 +0300
Date: Mon, 10 Jun 2024 16:08:35 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: diogo.ivo@siemens.com, dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: don't retrieve PDOs if not supported
Message-ID: <Zmb605vjKBNS+lDn@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20240609214328.6580-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609214328.6580-1-mpearson-lenovo@squebb.ca>

On Sun, Jun 09, 2024 at 05:43:18PM -0400, Mark Pearson wrote:
> On systems where the UCSI PDOs are not supported, the UCSI driver is
> giving an error message. This can cause users to believe there is a HW
> issue with their system when in fact it is working as designed.
> 
> Check if PDO_DETAILS are supported as a feature before attempting to
> access PDO. If not supported return that zero PDOs are available.
> 
> Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
> are not supported on this platform.
> 
> Suggested-by: Diogo Ivo <diogo.ivo@siemens.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Note this patch replaces my previous submission 'treat get_pdos not supported
> condition as info instead of error', based on feedback from review.
> 
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cb52e7b0a2c5..cadea8d328ed 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -641,9 +641,13 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>  static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
>  			 int is_partner, u32 *pdos)
>  {
> +	struct ucsi *ucsi = con->ucsi;
>  	u8 num_pdos;
>  	int ret;
>  
> +	if (!(ucsi->cap.features & UCSI_CAP_PDO_DETAILS))
> +		return 0;
> +
>  	/* UCSI max payload means only getting at most 4 PDOs at a time */
>  	ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
>  	if (ret < 0)
> -- 
> 2.45.1

-- 
heikki

