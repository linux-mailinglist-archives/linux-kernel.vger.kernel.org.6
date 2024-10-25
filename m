Return-Path: <linux-kernel+bounces-381954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1739B06A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C6C282F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5841534E9;
	Fri, 25 Oct 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aps3RB1f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9C290F;
	Fri, 25 Oct 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868422; cv=none; b=S8lFkafrSmGzPHlwoaqltEzb5PBH83Qj6EA7mJqLC5izyp7VQNVY4yzgyIwFygmMDwt6fPZbuhSYEB8wRyrlbJ5SArQvi1E96y2lYsH/TMm2oRmgkqi7xc+8RjffRh/Q5Qnr/w8m7p6M/JfqvK44vOxyuEya279oTtx6g19SVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868422; c=relaxed/simple;
	bh=jcuOBnTQ9nGR8T/gweEpKZFTk3dIJqfKF1aIEMo8e6o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WZPLvKb8KgoVrWme84q3VHb5XFIFdhPCLkBYSyF3PtXwpO8cX/oTYy5UZAkYkov5hpfIfxp5OJA8ByDgZ1JhMIiKPYGoZM7XxTw4n5hnnj/5P1uuLVzpEpHghGMKG58px3qLbSfu4KRs7ICCzwZ6CM8UY4/SpUjlabi0ShE6phA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aps3RB1f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729868421; x=1761404421;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jcuOBnTQ9nGR8T/gweEpKZFTk3dIJqfKF1aIEMo8e6o=;
  b=Aps3RB1fYECyi0+JzpIort8K3NliHbr3UVLgWlSGBx6pdyHctqJZGJrf
   BpprefoHRYuJtcMAUtk887QMcNqeU6vTT6FAKorRL571YYOsiLLy/9sTW
   W4aXSwVNyF1UbMYP5tuZIdDh2X15t0EsTJLueSATL5YmYHJRkHQTOKz3M
   KrTCl768UbB9j08/Rrt5YjLWr2txjIAL6gHcQQify8munwSbniDSRjAsQ
   KCMwAONc99qv1Yz8xX9uuMFAiRnAue3SrnUnr9DR+AuTbqQ/YwbUSEK1a
   0RXGSA+9LOwUiuDfVfXUK8R60Fbi/pz38ulCkyHrrOZ+6xTSvXZPptjqb
   Q==;
X-CSE-ConnectionGUID: iTSbyf7YSDuO0AEptsvYQg==
X-CSE-MsgGUID: n/nOVaFvQLWRioK/dNKJnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29657354"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29657354"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:00:06 -0700
X-CSE-ConnectionGUID: WvqHZtgVT8mjvZZ+WqGcSA==
X-CSE-MsgGUID: VpUANam/RnOTNdcOodH2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111766739"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:00:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 18:00:00 +0300 (EEST)
To: chen zhang <chenzhang@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, cezary.jackiewicz@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    chenzhang_0901@163.com
Subject: Re: [PATCH] platform/x86: compal-laptop: use sysfs_emit() instead
 of sprintf()
In-Reply-To: <20241024015605.15238-1-chenzhang@kylinos.cn>
Message-ID: <d85ddd5d-df2c-75fe-2ec8-3444969014b3@linux.intel.com>
References: <20241024015605.15238-1-chenzhang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, chen zhang wrote:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
>  drivers/platform/x86/compal-laptop.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
> index 5546fb189491..ba95f342fd59 100644
> --- a/drivers/platform/x86/compal-laptop.c
> +++ b/drivers/platform/x86/compal-laptop.c
> @@ -67,6 +67,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/sysfs.h>
>  #include <linux/power_supply.h>
>  #include <linux/fb.h>
>  #include <acpi/video.h>
> @@ -368,7 +369,7 @@ static const struct rfkill_ops compal_rfkill_ops = {
>  static ssize_t NAME##_show(struct device *dev,				\
>  	struct device_attribute *attr, char *buf)			\
>  {									\
> -	return sprintf(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) != 0));	\
> +	return sysfs_emit(buf, "%d\n", ((ec_read_u8(ADDR) & MASK) != 0));	\
>  }									\
>  static ssize_t NAME##_store(struct device *dev,				\
>  	struct device_attribute *attr, const char *buf, size_t count)	\

The macro line continuation backslashes should be aligned.

--
 i.

> @@ -393,7 +394,7 @@ static ssize_t pwm_enable_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct compal_data *data = dev_get_drvdata(dev);
> -	return sprintf(buf, "%d\n", data->pwm_enable);
> +	return sysfs_emit(buf, "%d\n", data->pwm_enable);
>  }
>  
>  static ssize_t pwm_enable_store(struct device *dev,
> @@ -432,7 +433,7 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>  		char *buf)
>  {
>  	struct compal_data *data = dev_get_drvdata(dev);
> -	return sprintf(buf, "%hhu\n", data->curr_pwm);
> +	return sysfs_emit(buf, "%hhu\n", data->curr_pwm);
>  }
>  
>  static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
> @@ -460,7 +461,7 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
>  static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
>  		char *buf)
>  {
> -	return sprintf(buf, "%d\n", get_fan_rpm());
> +	return sysfs_emit(buf, "%d\n", get_fan_rpm());
>  }
>  
>  
> @@ -469,12 +470,12 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
>  static ssize_t temp_##POSTFIX(struct device *dev,			\
>  		struct device_attribute *attr, char *buf)		\
>  {									\
> -	return sprintf(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
> +	return sysfs_emit(buf, "%d\n", 1000 * (int)ec_read_s8(ADDRESS));	\
>  }									\
>  static ssize_t label_##POSTFIX(struct device *dev,			\
>  		struct device_attribute *attr, char *buf)		\
>  {									\
> -	return sprintf(buf, "%s\n", LABEL);				\
> +	return sysfs_emit(buf, "%s\n", LABEL);				\
>  }
>  
>  /* Labels as in service guide */
> 

