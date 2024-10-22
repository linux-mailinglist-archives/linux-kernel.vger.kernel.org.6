Return-Path: <linux-kernel+bounces-375872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EA9A9C23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53F9B21C46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A3156F34;
	Tue, 22 Oct 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA6D2yrL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB51547EE;
	Tue, 22 Oct 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584887; cv=none; b=lZXP6OY6aZ/bcNrE8IH/9K4H8l4ld7965GhCx3vkUmNn9ejhXJ5xRozpmSLB/p0zJNyrHIVNFxivaZbX3PKTgd8F4GjBC52ax0gRnsevU8Zv8TrEx5y03qMn1I0oYV1KPgnGpSmxG1V4KGXOE+Y0XSV7q2h++LVfNbqQLk4c6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584887; c=relaxed/simple;
	bh=z9H87Oo1rqWSGDogdLSAaNqoSibq86I+DEkflnrb8zM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tnQgmTMdlreQzh/ElKURV63qTHPFB6Yi9Jvq5cMzN7o5cKCroJNdfopfglxBfH+3T62VWWRLxonHRdxBSUeH5zu7130MT2kpJybST/qoP159ZrOKoCEmG2gwEz0fuekgCy/vJ6JA5VL0MWDQ/0JsK95ynSwAvCQyio9TcpVAxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA6D2yrL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729584886; x=1761120886;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z9H87Oo1rqWSGDogdLSAaNqoSibq86I+DEkflnrb8zM=;
  b=UA6D2yrLZAj0auKN1G/jY88Vq2JFwcnja9jqOBck/+OOeyC6LcJJjYJj
   BW9XhECq16hnf1Sz8fm4H/iDkCaHqaR99IhiOS6HTmsEsIuQwu/ysuNHX
   DUC6Lu98XK0AlqD5gqDWi5CfuMY5gxp7njetlEULUekXDLLr+nmE/2fLw
   QCdCTd03vaJUn1n4Fxr90HYDtPnusiQ+njRhMIUfu/++/uJtIAC65lul1
   o+Sb0TUpxY0KrHTOW0oJ9Hr7dulO++uBueUFGPJ7UmQKtRBoiba4/oXN5
   LYUfryJcXuuIXZDfhf48BJaF0mCMpaZ7ZZgUBB2bAUZlcVJopylNflgwn
   w==;
X-CSE-ConnectionGUID: 1Isop3qaQuCfEBI0ZS1ptQ==
X-CSE-MsgGUID: pAe5qsbKSVKy00V554YZuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29306602"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="29306602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:14:45 -0700
X-CSE-ConnectionGUID: r57HXnrZR1uMo4Rj3glekA==
X-CSE-MsgGUID: 0j7d1Y+ESb2Zp4RRuDa+8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79424610"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:14:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Oct 2024 11:14:39 +0300 (EEST)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] platform/x86: think-lmi: Multi-certificate support
In-Reply-To: <20241021193837.7641-4-mpearson-lenovo@squebb.ca>
Message-ID: <3635398e-f810-c42b-9c6e-f9e0bb19e298@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20241021193837.7641-1-mpearson-lenovo@squebb.ca> <20241021193837.7641-4-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Mark Pearson wrote:

> Lenovo are adding support for both Admin and System certificates to
> the certificate based authentication feature
> 
> This commit adds the support for this.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  .../testing/sysfs-class-firmware-attributes   |   1 +
>  drivers/platform/x86/think-lmi.c              | 141 ++++++++++++++----
>  drivers/platform/x86/think-lmi.h              |   4 +
>  3 files changed, 116 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> index 1a8b59f5d6e3..2713efa509b4 100644
> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> @@ -303,6 +303,7 @@ Description:
>  					being configured allowing anyone to make changes.
>  					After any of these operations the system must reboot for the changes to
>  					take effect.
> +					Admin and System certificates are supported from 2025 systems onward.
>  
>  		certificate_thumbprint:
>  					Read only attribute used to display the MD5, SHA1 and SHA256 thumbprints
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 751e351dfc42..fca190232c24 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -169,11 +169,12 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   */
>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
>  
> -#define TLMI_POP_PWD BIT(0) /* Supervisor */
> -#define TLMI_PAP_PWD BIT(1) /* Power-on */
> -#define TLMI_HDD_PWD BIT(2) /* HDD/NVME */
> -#define TLMI_SMP_PWD BIT(6) /* System Management */
> -#define TLMI_CERT    BIT(7) /* Certificate Based */
> +#define TLMI_POP_PWD  BIT(0) /* Supervisor */
> +#define TLMI_PAP_PWD  BIT(1) /* Power-on */
> +#define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
> +#define TLMI_SMP_PWD  BIT(6) /* System Management */
> +#define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
> +#define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
>  
>  static const struct tlmi_err_codes tlmi_errs[] = {
>  	{"Success", 0},
> @@ -678,18 +679,35 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
>  	return count;
>  }
>  
> +#define NUM_THUMBTYPES 3
> +static char *thumbtypes[NUM_THUMBTYPES] = {"Md5", "Sha1", "Sha256"};
> +
>  static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
> -	int count = 0;
> +	char *wmistr;
> +	int count = 0, i;

Reverse xmas-tree order.

>  
>  	if (!tlmi_priv.certificate_support || !setting->cert_installed)
>  		return -EOPNOTSUPP;
>  
> -	count += cert_thumbprint(buf, "Md5", count);
> -	count += cert_thumbprint(buf, "Sha1", count);
> -	count += cert_thumbprint(buf, "Sha256", count);
> +	for (i = 0; i < NUM_THUMBTYPES; i++) {

Use ARRAY_SIZE() + add include for it.

These days, the usual custom is to use unsigned int for loop variables 
that are never meant to be negative.

> +		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
> +			/* Format: 'SVC | SMC, Thumbtype' */
> +			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
> +					   setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
> +					   thumbtypes[i]);
> +		} else {
> +			/* Format: 'Thumbtype' */
> +			wmistr = kasprintf(GFP_KERNEL, "%s", thumbtypes[i]);
> +		}
> +		if (!wmistr)
> +			return -ENOMEM;
> +		count += cert_thumbprint(buf, wmistr, count);
> +		kfree(wmistr);
> +	}
> +
>  	return count;
>  }
>  
> @@ -720,8 +738,15 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
>  	if (!passwd)
>  		return -ENOMEM;
>  
> -	/* Format: 'Password,Signature' */
> -	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
> +	if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
> +		/* Format: 'SVC | SMC, password, signature' */
> +		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
> +				     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
> +				     passwd, setting->signature);
> +	} else {
> +		/* Format: 'Password,Signature' */
> +		auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
> +	}
>  	if (!auth_str) {
>  		kfree_sensitive(passwd);
>  		return -ENOMEM;
> @@ -735,12 +760,19 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
>  
>  static struct kobj_attribute auth_cert_to_password = __ATTR_WO(cert_to_password);
>  
> +enum cert_install_mode {
> +	TLMI_CERT_INSTALL,
> +	TLMI_CERT_UPDATE,
> +};
> +
>  static ssize_t certificate_store(struct kobject *kobj,
>  				  struct kobj_attribute *attr,
>  				  const char *buf, size_t count)
>  {
>  	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
> +	enum cert_install_mode install_mode = TLMI_CERT_INSTALL;
>  	char *auth_str, *new_cert;
> +	char *signature;
>  	char *guid;
>  	int ret;
>  
> @@ -756,10 +788,18 @@ static ssize_t certificate_store(struct kobject *kobj,
>  		if (!setting->signature || !setting->signature[0])
>  			return -EACCES;
>  
> -		/* Format: 'serial#, signature' */
> -		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
> -				dmi_get_system_info(DMI_PRODUCT_SERIAL),
> -				setting->signature);
> +		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
> +			/* Format: 'SVC | SMC, serial#, signature' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
> +					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
> +					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
> +					     setting->signature);
> +		} else {
> +			/* Format: 'serial#, signature' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
> +					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
> +					     setting->signature);
> +		}
>  		if (!auth_str)
>  			return -ENOMEM;
>  
> @@ -776,24 +816,59 @@ static ssize_t certificate_store(struct kobject *kobj,
>  
>  	if (setting->cert_installed) {
>  		/* Certificate is installed so this is an update */
> -		if (!setting->signature || !setting->signature[0]) {
> +		install_mode = TLMI_CERT_UPDATE;
> +		/* If admin account enabled - need to use it's signature */
> +		if (tlmi_priv.pwd_admin->pwd_enabled)
> +			signature = tlmi_priv.pwd_admin->signature;
> +		else
> +			signature = setting->signature;
> +	} else { /* Cert install */
> +		/* Check if SMC and SVC already installed */
> +		if ((setting == tlmi_priv.pwd_system) && tlmi_priv.pwd_admin->cert_installed) {
> +			/* This gets treated as a cert update */
> +			install_mode = TLMI_CERT_UPDATE;
> +			signature = tlmi_priv.pwd_admin->signature;
> +		} else { /* Regular cert install */
> +			install_mode = TLMI_CERT_INSTALL;
> +			signature = setting->signature;
> +		}
> +	}
> +
> +	if (install_mode == TLMI_CERT_UPDATE) {
> +		/* This is a certificate update */
> +		if (!signature || !signature[0]) {
>  			kfree(new_cert);
>  			return -EACCES;
>  		}
>  		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
> -		/* Format: 'Certificate,Signature' */
> -		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
> -				new_cert, setting->signature);
> +		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
> +			/* Format: 'SVC | SMC, certificate, signature' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
> +					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
> +					     new_cert, signature);
> +		} else {
> +			/* Format: 'Certificate,Signature' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
> +					     new_cert, signature);
> +		}
>  	} else {
>  		/* This is a fresh install */
> -		if (!setting->pwd_enabled || !setting->password[0]) {
> +		/* To set admin cert, a password must be enabled */
> +		if ((setting == tlmi_priv.pwd_admin) &&
> +		    (!setting->pwd_enabled || !setting->password[0])) {
>  			kfree(new_cert);
>  			return -EACCES;
>  		}
>  		guid = LENOVO_SET_BIOS_CERT_GUID;
> -		/* Format: 'Certificate,Admin-password' */
> -		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
> -				new_cert, setting->password);
> +		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
> +			/* Format: 'SVC | SMC, Certificate, password' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
> +					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
> +					     new_cert, setting->password);
> +		} else {
> +			/* Format: 'Certificate, password' */
> +			auth_str = kasprintf(GFP_KERNEL, "%s,%s", new_cert, setting->password);
> +		}

Have you considered creating a helper for this if/else construct to create 
the string? (you've basically repeated it multiple times by now with 
limited change to only parameters AFAICT).

>  	}
>  	kfree(new_cert);
>  	if (!auth_str)
> @@ -873,14 +948,19 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
>  		return 0;
>  	}
>  
> -	/* We only display certificates on Admin account, if supported */
> +	/* We only display certificates, if supported */
>  	if (attr == &auth_certificate.attr ||
>  	    attr == &auth_signature.attr ||
>  	    attr == &auth_save_signature.attr ||
>  	    attr == &auth_cert_thumb.attr ||
>  	    attr == &auth_cert_to_password.attr) {
> -		if ((setting == tlmi_priv.pwd_admin) && tlmi_priv.certificate_support)
> +		if (tlmi_priv.certificate_support) {
> +			if (setting == tlmi_priv.pwd_admin)

These two if()s combined look the same as the old ode, why are you redoing 
it?

> +				return attr->mode;
> +		if ((tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) &&
> +		    (setting == tlmi_priv.pwd_system))
>  			return attr->mode;
> +		}
>  		return 0;
>  	}
>  
> @@ -1700,12 +1780,13 @@ static int tlmi_analyze(void)
>  		}
>  	}
>  
> -	if (tlmi_priv.certificate_support &&
> -		(tlmi_priv.pwdcfg.core.password_state & TLMI_CERT))
> -		tlmi_priv.pwd_admin->cert_installed = true;
> -
> +	if (tlmi_priv.certificate_support) {
> +		tlmi_priv.pwd_admin->cert_installed =
> +			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
> +		tlmi_priv.pwd_system->cert_installed =
> +			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
> +	}
>  	return 0;
> -

Stray change.

-- 
 i.

>  fail_clear_attr:
>  	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
>  		if (tlmi_priv.setting[i]) {
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index 4728f40143a3..f267d8b46957 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -41,6 +41,10 @@ enum save_mode {
>  };
>  
>  /* password configuration details */
> +#define TLMI_PWDCFG_MODE_LEGACY    0
> +#define TLMI_PWDCFG_MODE_PASSWORD  1
> +#define TLMI_PWDCFG_MODE_MULTICERT 3
> +
>  struct tlmi_pwdcfg_core {
>  	uint32_t password_mode;
>  	uint32_t password_state;
> 


