Return-Path: <linux-kernel+bounces-544539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D0A4E289
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E3A3BE9B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320482627F5;
	Tue,  4 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoKOa/gi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9223A9AB;
	Tue,  4 Mar 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100235; cv=none; b=JHwYdG3WzV//ZuVkACqVKp0iVgVZTrmD1Gb/3Eb1YJxPyPkd435t2PN+j0cOgXL3SPEw/7LpNB3uKEZpAWAgaSh9sa8NfVNFW9eqofsOliiHWTB61fLg/LLX9WuqwrDirwx87Rs0aVYrOwcCIS9oWPknTrzxdaCxzy4jU7NaWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100235; c=relaxed/simple;
	bh=Qual+ve5thf+vI/agmYtffTam++x2ApTEKb+DhHDAno=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A7pDTWAlEdvNE2NIKB0YAks5M+x2dTZM6SB2pXHyeIf2A8re4cZRmeu7D8bi0BoCK8GWF8EgfnEvVf1zWVa+NSALNvBb6MY3DpmEzKx7aHvFEGjpmL7TM6FnBHJ0PMQ13Pj5uvZDnADL2qBE9cFEKIbwUXcx+Qg0decAaAvO+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoKOa/gi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741100234; x=1772636234;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qual+ve5thf+vI/agmYtffTam++x2ApTEKb+DhHDAno=;
  b=VoKOa/gio4yfFki/W2+VFymhP/XToQnI76OLunUvzk/DsAEQA4KZxYNv
   CT43qyK3uvkD7hvwqQ06cBcB22FXGKWYM1hfCTcAFe4QWyM37kzIwSjnD
   IBWCMFnYIs8Kll5OB5BIlPR2fNGja68gqehGi1yb71hPv4/zdYouH7iIP
   d1fDb6Wq+e0U9Nr8tKkGr2YRko35jBUUc4ykOMso5otQaSIx/jXTd0tO1
   1Prnt9zmIj2n6tWj/ewZSQ1yJqui1nYbrCpiWSKGvhsjA/ytLEuLBHN6+
   PSU8TMeO2jpdFcNaWE3r9b7+t5E2rsQWUjgtRSeJ3e2Z6IZeVFxJKmY1R
   A==;
X-CSE-ConnectionGUID: kPDth2jHQW6vQu7VDUaQFg==
X-CSE-MsgGUID: vN4M6CfURTCyMBfzOifYhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45671327"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45671327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:57:13 -0800
X-CSE-ConnectionGUID: 24oyge/hTxGFJr/pHYDaQQ==
X-CSE-MsgGUID: NSsGcZaDTcSMQimrsVZmOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123328484"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:57:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 16:57:07 +0200 (EET)
To: Tadeu Marchese <marchese.kdev@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Tadeu Marchese <marchese@hp.com>
Subject: Re: platform/x86/hp-bioscfg: Fix buffer alignment and conversion
In-Reply-To: <20250304062319.86270-1-marchese@hp.com>
Message-ID: <3c30721a-cc1f-2d4a-d5df-f9cdec0af5e8@linux.intel.com>
References: <20250304062319.86270-1-marchese@hp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Mar 2025, Tadeu Marchese wrote:

> Use PTR_ALIGN to access buffer in hp_get_string_from_buffer().
> Remove code that escapes characters with backslashes.
> Use kstrtouint() for unsigned string-to-integer conversion.
> Increase the string_data buffer size by defining MAX_STRING_BUFF_SIZE.
> 
> Signed-off-by: Tadeu Marchese <marchese@hp.com>
> ---
> This patch ensures proper alignment when reading the string size from the 
> buffer and simplifies Unicode-to-UTF-8 conversion by removing 
> unnecessary character escaping.
> 
> Issues fixed at the module initialization:
> [  433.823905] hp_bioscfg: Prerequisites size value exceeded the maximum 
>   number of elements supported or data may be malformed
> [  433.837747] Unable to convert string to integer: 4294967295
> 
> The buffer size was too small for string attributes such as 
> 'HP_Disk0MapForUefiBootOrder'.
> 
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 82 ++++++-------------
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  |  6 +-
>  .../x86/hp/hp-bioscfg/int-attributes.c        |  8 +-
>  3 files changed, 33 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 0b277b7e37dd..b537fbaac15e 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -51,19 +51,21 @@ int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
>  
>  int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_size)
>  {

Oh great, thanks for looking into this! I recall raising this custom 
string conversion madness during review but back then the patch got 
applied without my comments being addressed.

> -	u16 *src = (u16 *)*buffer;
> +	u16 *src = PTR_ALIGN((u16 *)*buffer, sizeof(u16));

What happens here if the PTR_ALIGN() actually aligns the pointer by 
skipping over the first character?? Is the string going to get read 
out-of-sync with the true character boundaries??

>  	u16 src_size;
>  
> -	u16 size;
> -	int i;
> +	u16 length;
>  	int conv_dst_size;
> +	int result;
>  
>  	if (*buffer_size < sizeof(u16))
>  		return -EINVAL;
>  
> +	/* String size is in the first two bytes of the buffer */
>  	src_size = *(src++);
> -	/* size value in u16 chars */
> -	size = src_size / sizeof(u16);
> +
> +	/* Get the string length considering it is u16 */
> +	length = src_size / sizeof(u16);
>  
>  	/* Ensure there is enough space remaining to read and convert
>  	 * the string
> @@ -71,54 +73,22 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
>  	if (*buffer_size < src_size)
>  		return -EINVAL;
>  
> -	for (i = 0; i < size; i++)
> -		if (src[i] == '\\' ||
> -		    src[i] == '\r' ||
> -		    src[i] == '\n' ||
> -		    src[i] == '\t')
> -			size++;
> -
> -	/*
> -	 * Conversion is limited to destination string max number of
> -	 * bytes.
> -	 */
> -	conv_dst_size = size;
> -	if (size > dst_size)
> -		conv_dst_size = dst_size - 1;
> +	conv_dst_size = length;
> +	if (dst_size < conv_dst_size)
> +		return -EINVAL;
>  
>  	/*
> -	 * convert from UTF-16 unicode to ASCII
> +	 * Convert from UTF-16 unicode to UTF-8 and ensure
> +	 * the string is null terminated
>  	 */
> -	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
> -	dst[conv_dst_size] = 0;
> -
> -	for (i = 0; i < conv_dst_size; i++) {
> -		if (*src == '\\' ||
> -		    *src == '\r' ||
> -		    *src == '\n' ||
> -		    *src == '\t') {
> -			dst[i++] = '\\';
> -			if (i == conv_dst_size)
> -				break;
> -		}
> -
> -		if (*src == '\r')
> -			dst[i] = 'r';
> -		else if (*src == '\n')
> -			dst[i] = 'n';
> -		else if (*src == '\t')
> -			dst[i] = 't';
> -		else if (*src == '"')
> -			dst[i] = '\'';
> -		else
> -			dst[i] = *src;
> -		src++;
> -	}
> +	result = utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
> +	dst[result] = 0;
>  
> -	*buffer = (u8 *)src;
> -	*buffer_size -= size * sizeof(u16);
> +	/* Update buffer to point to the next position */
> +	*buffer = (u8 *)src + src_size;
> +	*buffer_size -= src_size;
>  
> -	return size;
> +	return result;
>  }
>  
>  int hp_get_common_data_from_buffer(u8 **buffer_ptr, u32 *buffer_size,
> @@ -999,37 +969,37 @@ static int __init hp_init(void)
>  	 */
>  	ret = create_attributes_level_sysfs_files();
>  	if (ret)
> -		pr_debug("Failed to create sysfs level attributes\n");
> +		pr_warn("Failed to create sysfs level attributes\n");

This patch should be split into a series with each patch doing a single 
thing as you seem to have include changes that look independent of the 
string conversion cleanup.

>  
>  	ret = hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_STRING_GUID);
>  	if (ret)
> -		pr_debug("Failed to populate string type attributes\n");
> +		pr_warn("Failed to populate string type attributes\n");
>  
>  	ret = hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_INTEGER_GUID);
>  	if (ret)
> -		pr_debug("Failed to populate integer type attributes\n");
> +		pr_warn("Failed to populate integer type attributes\n");
>  
>  	ret = hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BIOS_ENUMERATION_GUID);
>  	if (ret)
> -		pr_debug("Failed to populate enumeration type attributes\n");
> +		pr_warn("Failed to populate enumeration type attributes\n");
>  
>  	ret = hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_BIOS_ORDERED_LIST_GUID);
>  	if (ret)
> -		pr_debug("Failed to populate ordered list object type attributes\n");
> +		pr_warn("Failed to populate ordered list object type attributes\n");
>  
>  	ret = hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_PASSWORD_GUID);
>  	if (ret)
> -		pr_debug("Failed to populate password object type attributes\n");
> +		pr_warn("Failed to populate password object type attributes\n");
>  
>  	bioscfg_drv.spm_data.attr_name_kobj = NULL;
>  	ret = hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
>  	if (ret)
> -		pr_debug("Failed to populate secure platform object type attribute\n");
> +		pr_warn("Failed to populate secure platform object type attribute\n");
>  
>  	bioscfg_drv.sure_start_attr_kobj = NULL;
>  	ret = hp_add_other_attributes(HPWMI_SURE_START_TYPE);
>  	if (ret)
> -		pr_debug("Failed to populate sure start object type attribute\n");
> +		pr_warn("Failed to populate sure start object type attribute\n");
>  
>  	return 0;
>  
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> index 3166ef328eba..99a95c709061 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> @@ -17,11 +17,11 @@
>  
>  #define DRIVER_NAME		"hp-bioscfg"
>  
> +#define MAX_STRING_BUFF_SIZE	1024
>  #define MAX_BUFF_SIZE		512
>  #define MAX_KEY_MOD_SIZE	256
>  #define MAX_PASSWD_SIZE		64
>  #define MAX_PREREQUISITES_SIZE	20
> -#define MAX_REQ_ELEM_SIZE	128
>  #define MAX_VALUES_SIZE		16
>  #define MAX_ENCODINGS_SIZE	16
>  #define MAX_ELEMENTS_SIZE	16
> @@ -131,8 +131,8 @@ struct common_data {
>  struct string_data {
>  	struct common_data common;
>  	struct kobject *attr_name_kobj;
> -	u8 current_value[MAX_BUFF_SIZE];
> -	u8 new_value[MAX_BUFF_SIZE];
> +	u8 current_value[MAX_STRING_BUFF_SIZE];
> +	u8 new_value[MAX_STRING_BUFF_SIZE];
>  	u32 min_length;
>  	u32 max_length;
>  };
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> index 6c7f4d5fa9cb..3e8f99b4174d 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> @@ -38,7 +38,7 @@ static int validate_integer_input(int instance_id, char *buf)
>  	if (integer_data->common.is_readonly)
>  		return -EIO;
>  
> -	ret = kstrtoint(buf, 10, &in_val);
> +	ret = kstrtouint(buf, 10, &in_val);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -55,7 +55,7 @@ static void update_integer_value(int instance_id, char *attr_value)
>  	int ret;
>  	struct integer_data *integer_data = &bioscfg_drv.integer_data[instance_id];
>  
> -	ret = kstrtoint(attr_value, 10, &in_val);
> +	ret = kstrtouint(attr_value, 10, &in_val);
>  	if (ret == 0)
>  		integer_data->current_value = in_val;
>  	else
> @@ -185,7 +185,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
>  		/* Assign appropriate element value to corresponding field*/
>  		switch (eloc) {
>  		case VALUE:
> -			ret = kstrtoint(str_value, 10, &int_value);
> +			ret = kstrtouint(str_value, 10, &int_value);
>  			if (ret)
>  				continue;
>  
> @@ -328,7 +328,7 @@ static int hp_populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_
>  	integer_data->current_value = 0;
>  
>  	hp_get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> -	ret = kstrtoint(dst, 10, &integer_data->current_value);
> +	ret = kstrtouint(dst, 10, &integer_data->current_value);
>  	if (ret)
>  		pr_warn("Unable to convert string to integer: %s\n", dst);
>  	kfree(dst);
> 

-- 
 i.


