Return-Path: <linux-kernel+bounces-279515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC194BE45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36522B22198
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D118CC10;
	Thu,  8 Aug 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LORMl6VL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB263D;
	Thu,  8 Aug 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122869; cv=none; b=nwA8OK09Vo5sIbcu1rj2JNNLqqHeq9gw9NQaj1Bw6bOSL8OETVNk6RRjn1pwEneDnBNsUdAhpa5TBxmSOQmgpfyQaWAcOMHKLnWBFWRfQL5uMkfyvClQ8rjfcAeXzT/LfXMNO4UdMBEAT4rCfwElM5p3PW0q2weqCh4r9uvRRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122869; c=relaxed/simple;
	bh=mANp6lmpKbMk6O+n3GLxoSI4sbUhtmOQhXsnYHzX4HU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vx3qZlsWK85MfsUfG056887dyofXmY4sIQyFDboLbWsodwhvxbW4LIPX0VUADTkrAKJmiqABiSBBeH1GAs0jo1tlPmdPM5V8N+CtUg23dc2KSrykAhavEVxCfoZpzqfQ7vZiHbcf6+yVJqEpsYzX8I6oTzz0dOWTxwhbwMrfz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LORMl6VL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723122867; x=1754658867;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mANp6lmpKbMk6O+n3GLxoSI4sbUhtmOQhXsnYHzX4HU=;
  b=LORMl6VLxXTBypIvuFdaVzG83E4LPWHBi5MJCGqL5YgwbX8I9N7mFZ1w
   1Y3c5r8HyV7xXawDVUNAv31Eprck2K5PK2e1A2Di5d0jNvcR0Iu5253//
   fQZdiggPASuIP+0lfPcUmU6QDZnZ6lTIZhK8kFt0w7FCtHLlUIU+/K8UM
   bz5R8ASA94PDkJijom1UW6L5KPzopJjGWsbPgjxILbMx8PJqDEnIdHfDg
   L3Xvx1FWtILhEnG/IlHjg7ScTPpNxiaCiCyW4vrVIM9YzjQmizOp5GreU
   lQ7gS4mYd8i6AbdZiUHuRd8GyC2Hy4a+Kx33ZAtql++ALy1fUheZ3DE0f
   A==;
X-CSE-ConnectionGUID: TvNY+gkxTrGxLu8M+PwVtQ==
X-CSE-MsgGUID: 2zUp2ni4R/qQb5oSasSUKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="43766195"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="43766195"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:14:10 -0700
X-CSE-ConnectionGUID: aj/3tucSRKuKzafMFlbE+Q==
X-CSE-MsgGUID: 7QmFCw5VTqO9OZmfqrf7vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61596794"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:14:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Aug 2024 16:14:02 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan
 support
In-Reply-To: <20240714165054.2261305-1-kontakt@matthias-fetzer.de>
Message-ID: <ee9624b2-5b24-9976-4746-c622fcba21a6@linux.intel.com>
References: <20240714165054.2261305-1-kontakt@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Jul 2024, Matthias Fetzer wrote:

> Fan control on the E531 is done using the ACPI methods FANG and
> FANW. The correct parameters and register values were found by
> analyzing EC firmware as well as DSDT. This has been tested on
> my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
> 
> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 159 +++++++++++++++++++++++++++
>  1 file changed, 159 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 397b409064c9..a171a2b39ac9 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7751,6 +7751,28 @@ static struct ibm_struct volume_driver_data = {
>   * 	EC 0x2f (HFSP) might be available *for reading*, but do not use
>   * 	it for writing.
>   *
> + * TPACPI_FAN_RD_ACPI_FANG:
> + * 	ACPI FANG method: returns fan control register
> + *
> + *	Takes one parameter which is 0x8100 plus the offset to EC memory
> + *	address 0xf500 and returns the byte at this address.
> + *
> + *	0xf500:
> + *		When the value is less than 9 automatic mode is enabled
> + *	0xf502:
> + *		Contains the current fan speed from 0-100%
> + *	0xf504:
> + *		Bit 7 has to be set in order to enable manual control by
> + *		writing a value >= 9 to 0xf500
> + *
> + * TPACPI_FAN_WR_ACPI_FANW:
> + * 	ACPI FANG method: sets fan control registers
> + *
> + * 	Takes 0x8100 plus the offset to EC memory address 0xf500 and the
> + * 	value to be written there as parameters.
> + *
> + *	see TPACPI_FAN_RD_ACPI_FANG
> + *
>   * TPACPI_FAN_WR_TPEC:
>   * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode
>   * 	Supported on almost all ThinkPads
> @@ -7884,6 +7906,7 @@ enum {					/* Fan control constants */
>  enum fan_status_access_mode {
>  	TPACPI_FAN_NONE = 0,		/* No fan status or control */
>  	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
> +	TPACPI_FAN_RD_ACPI_FANG,	/* Use ACPI FANG */
>  	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
>  	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
>  };
> @@ -7891,6 +7914,7 @@ enum fan_status_access_mode {
>  enum fan_control_access_mode {
>  	TPACPI_FAN_WR_NONE = 0,		/* No fan control */
>  	TPACPI_FAN_WR_ACPI_SFAN,	/* Use ACPI SFAN */
> +	TPACPI_FAN_WR_ACPI_FANW,	/* Use ACPI FANW */
>  	TPACPI_FAN_WR_TPEC,		/* Use ACPI EC reg 0x2f */
>  	TPACPI_FAN_WR_ACPI_FANS,	/* Use ACPI FANS and EC reg 0x2f */
>  };
> @@ -7924,9 +7948,13 @@ TPACPI_HANDLE(fans, ec, "FANS");	/* X31, X40, X41 */
>  TPACPI_HANDLE(gfan, ec, "GFAN",	/* 570 */
>  	   "\\FSPD",		/* 600e/x, 770e, 770x */
>  	   );			/* all others */
> +TPACPI_HANDLE(fang, ec, "FANG",	/* E531 */
> +	   );			/* all others */
>  TPACPI_HANDLE(sfan, ec, "SFAN",	/* 570 */
>  	   "JFNS",		/* 770x-JL */
>  	   );			/* all others */
> +TPACPI_HANDLE(fanw, ec, "FANW",	/* E531 */
> +	   );			/* all others */
>  
>  /*
>   * Unitialized HFSP quirk: ACPI DSDT and EC fail to initialize the
> @@ -8033,6 +8061,23 @@ static int fan_get_status(u8 *status)
>  
>  		break;
>  	}
> +	case TPACPI_FAN_RD_ACPI_FANG: {
> +		/* E531 */
> +		int mode, speed;
> +
> +		if (unlikely(!acpi_evalf(fang_handle, &mode, NULL, "dd", 0x8100)))
> +			return -EIO;
> +		if (unlikely(!acpi_evalf(fang_handle, &speed, NULL, "dd", 0x8102)))
> +			return -EIO;
> +
> +		if (likely(status)) {
> +			*status = speed * 7 / 100;
> +			if (mode < 9)
> +				*status |= TP_EC_FAN_AUTO;
> +		}
> +
> +		break;
> +	}
>  	case TPACPI_FAN_RD_TPEC:
>  		/* all except 570, 600e/x, 770e, 770x */
>  		if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
> @@ -8147,6 +8192,17 @@ static int fan2_get_speed(unsigned int *speed)
>  		if (speed)
>  			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
>  		break;
> +	case TPACPI_FAN_RD_ACPI_FANG: {
> +		/* E531 */
> +		int speed_tmp;
> +
> +		if (unlikely(!acpi_evalf(fang_handle, &speed_tmp, NULL, "dd", 0x8102)))
> +			return -EIO;
> +
> +		if (likely(speed))
> +			*speed =  speed_tmp * 65535 / 100;
> +		break;
> +	}
>  
>  	default:
>  		return -ENXIO;
> @@ -8157,6 +8213,7 @@ static int fan2_get_speed(unsigned int *speed)
>  
>  static int fan_set_level(int level)
>  {
> +	int rc;
>  	if (!fan_control_allowed)
>  		return -EPERM;
>  
> @@ -8206,6 +8263,36 @@ static int fan_set_level(int level)
>  			tp_features.fan_ctrl_status_undef = 0;
>  		break;
>  
> +	case TPACPI_FAN_WR_ACPI_FANW:
> +		if ((!(level & TP_EC_FAN_AUTO) &&
> +		    ((level < 0) || (level > 7))) ||
> +		    (level & TP_EC_FAN_FULLSPEED))
> +			return -EINVAL;

I'd split this into two to make it more readable:

		if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
			return -EINVAL;
		if (level & TP_EC_FAN_FULLSPEED)
			return -EINVAL;

I'm not sure if -EINVAL is really the right code to return though in these 
cases.

> +		if (level & TP_EC_FAN_AUTO) {
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {

Curiously enough, the comment above doesn't cover offset 0xf506 but the 
comment mentions 0xf504 that is never touched anywhere? Is that a typo?

-- 
 i.

> +				rc = -EIO;
> +				break;
> +			}
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
> +				rc = -EIO;
> +				break;
> +			}
> +		} else {
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
> +				rc = -EIO;
> +				break;
> +			}
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
> +				rc = -EIO;
> +				break;
> +			}
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level * 100 / 7)) {
> +				rc = -EIO;
> +				break;
> +			}
> +		}
> +		break;
> +
>  	default:
>  		return -ENXIO;
>  	}
> @@ -8284,6 +8371,19 @@ static int fan_set_enable(void)
>  			rc = 0;
>  		break;
>  
> +	case TPACPI_FAN_WR_ACPI_FANW:
> +		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
> +			rc = -EIO;
> +			break;
> +		}
> +
> +		rc = 0;
> +		break;
> +
>  	default:
>  		rc = -ENXIO;
>  	}
> @@ -8326,6 +8426,22 @@ static int fan_set_disable(void)
>  			fan_control_desired_level = 0;
>  		break;
>  
> +	case TPACPI_FAN_WR_ACPI_FANW:
> +		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, 0x00)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		rc = 0;
> +		break;
> +
>  	default:
>  		rc = -ENXIO;
>  	}
> @@ -8359,6 +8475,23 @@ static int fan_set_speed(int speed)
>  			rc = -EINVAL;
>  		break;
>  
> +	case TPACPI_FAN_WR_ACPI_FANW:
> +		if (speed >= 0 && speed <= 65535) {
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
> +				rc = -EIO;
> +				break;
> +			}
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
> +				rc = -EIO;
> +				break;
> +			}
> +			if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd",
> +					0x8102, speed * 100 / 65535))
> +				rc = -EIO;
> +		} else
> +			rc = -EINVAL;
> +		break;
> +
>  	default:
>  		rc = -ENXIO;
>  	}
> @@ -8701,6 +8834,10 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		TPACPI_ACPIHANDLE_INIT(gfan);
>  		TPACPI_ACPIHANDLE_INIT(sfan);
>  	}
> +	if (tpacpi_is_lenovo()) {
> +		TPACPI_ACPIHANDLE_INIT(fang);
> +		TPACPI_ACPIHANDLE_INIT(fanw);
> +	}
>  
>  	quirks = tpacpi_check_quirks(fan_quirk_table,
>  				     ARRAY_SIZE(fan_quirk_table));
> @@ -8720,6 +8857,9 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
> +	} else if (fang_handle) {
> +		/* E531 */
> +		fan_status_access_mode = TPACPI_FAN_RD_ACPI_FANG;
>  	} else {
>  		/* all other ThinkPads: note that even old-style
>  		 * ThinkPad ECs supports the fan control register */
> @@ -8766,6 +8906,11 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		fan_control_access_mode = TPACPI_FAN_WR_ACPI_SFAN;
>  		fan_control_commands |=
>  		    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_ENABLE;
> +	} else if (fanw_handle) {
> +		/* E531 */
> +		fan_control_access_mode = TPACPI_FAN_WR_ACPI_FANW;
> +		fan_control_commands |=
> +		    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_SPEED | TPACPI_FAN_CMD_ENABLE;
>  	} else {
>  		if (!gfan_handle) {
>  			/* gfan without sfan means no fan control */
> @@ -8915,6 +9060,20 @@ static int fan_read(struct seq_file *m)
>  			       str_enabled_disabled(status), status);
>  		break;
>  
> +	case TPACPI_FAN_RD_ACPI_FANG:
> +		/* E531 */
> +		rc = fan_get_status_safe(&status);
> +		if (rc)
> +			return rc;
> +
> +		seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status));
> +
> +		rc = fan_get_speed(&speed);
> +		if (rc < 0)
> +			return rc;
> +		seq_printf(m, "speed:\t\t%d\n", speed);
> +		break;
> +
>  	case TPACPI_FAN_RD_TPEC_NS:
>  	case TPACPI_FAN_RD_TPEC:
>  		/* all except 570, 600e/x, 770e, 770x */
> 


