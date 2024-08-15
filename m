Return-Path: <linux-kernel+bounces-288539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884A953B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6908F1C21D87
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D0149C53;
	Thu, 15 Aug 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="aLejQePq"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40093214;
	Thu, 15 Aug 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753629; cv=none; b=k2MtbGZnnSzcmcB3komRYOOOmjIb38aFWOoaWhTz/6Mqofu8q/RHZe4RrCXh4tIuUgkkTxCAzlI7KI8mgKBH6cf0mL9xeDAaS3BrxXzU7Ccjroaqo4AMSByU7rOuohrFMLrpjTb5IITsdBKnmqjtklkug+SCkW/cJBCGuDGEI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753629; c=relaxed/simple;
	bh=U+Ubxxosxhos1Nw0ZxMYYX6oDwOaBNCSZ54ABwnaGgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIQdalGIyEzVDg9Tcv+E/gYA1S5sx/H50A0Pp/p3WGr0XU/XP+nfyognTqR1ONFBb8QEuiFqHFj303+DtTf832ydlBdce5s3n60NIeL0TjntPHzdKXB8M379Sbxf4xQGIjcC1F+hc+GW0vKhA1Gnp6QL70dTvqK0sxFsRwuxI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=aLejQePq; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4WlGcj580mz6xmD;
	Thu, 15 Aug 2024 22:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1723753029;
	bh=U+Ubxxosxhos1Nw0ZxMYYX6oDwOaBNCSZ54ABwnaGgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aLejQePqr8CGCVQ5xxAf1vE4hvlK2sAJqMX3pDvKNm98l3ua/FGEUJeSxH3RE79ea
	 vvdDS9W23PVgpkj5BKwdusEdXyrbJBDio9tAMgwiTZ0vpj21CiG6kZcrQSPIdVddP+
	 NLK+3fHND5uxEBMIGElQrE5POgVxzll1LGT2kt8Q0a62U+pBWBj7LTUF6tg3IDGrt7
	 7/Yg9a+NHZqMchIBhyAGYPvJ8+T53etpF82vz2bvFazye0rk3YH3TPoEx/iGbw5mf5
	 BEO8ViqwDqY9ccKjKr8ShGRftkFgc2kmjAmwsN4+SZb1JN/fPduss7dNxC6tYS5xCN
	 5cS/ZNVbmqd4g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4WlGcj4Qryz6xm9;
	Thu, 15 Aug 2024 22:17:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4WlGch2Pnwz8tXc;
	Thu, 15 Aug 2024 22:17:08 +0200 (CEST)
Received: from [IPV6:2001:9e8:1a67:f900:bb12:a61:3ff9:ebce] (unknown [IPv6:2001:9e8:1a67:f900:bb12:a61:3ff9:ebce])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id 5DF434046B;
	Thu, 15 Aug 2024 22:17:03 +0200 (CEST)
Authentication-Results: mxf9a3;
        spf=pass (sender IP is 2001:9e8:1a67:f900:bb12:a61:3ff9:ebce) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=[IPV6:2001:9e8:1a67:f900:bb12:a61:3ff9:ebce]
Received-SPF: pass (mxf9a3: connection is authenticated)
Message-ID: <d2d7b7ec-c7db-4cde-b669-df727b93748f@matthias-fetzer.de>
Date: Thu, 15 Aug 2024 22:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
To: kernel test robot <lkp@intel.com>, hmh@hmh.eng.br, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, ibm-acpi-devel@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
References: <20240814213927.49075-1-kontakt@matthias-fetzer.de>
 <202408160253.fMJW95oi-lkp@intel.com>
Content-Language: en-US, de-DE
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
Disposition-Notification-To: Matthias Fetzer <kontakt@matthias-fetzer.de>
In-Reply-To: <202408160253.fMJW95oi-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <172375302389.6135.1622073007362957735@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: 5DF434046B
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: calp7oG2ZZ/5ZuRXx2ZYYpuvxkhEFbbpfJDeIx1VQOQ9Q4bNMu11f6XF



Am 15.08.24 um 21:00 schrieb kernel test robot:
> Hi Matthias,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.11-rc3 next-20240815]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Matthias-Fetzer/platform-x86-thinkpad_acpi-Add-Thinkpad-Edge-E531-fan-support/20240815-054239
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240814213927.49075-1-kontakt%40matthias-fetzer.de
> patch subject: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support
> config: i386-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160253.fMJW95oi-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408160253.fMJW95oi-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/platform/x86/thinkpad_acpi.c: In function 'fan_set_level':
>>> drivers/platform/x86/thinkpad_acpi.c:8214:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
>      8214 |         int rc;
>           |             ^~
> 

I guess just removing the variable and returning -EIO directly should be
a good approach.

What do you think?

> 
> vim +/rc +8214 drivers/platform/x86/thinkpad_acpi.c
> 
>    8211	
>    8212	static int fan_set_level(int level)
>    8213	{
>> 8214		int rc;
>    8215	
>    8216		if (!fan_control_allowed)
>    8217			return -EPERM;
>    8218	
>    8219		switch (fan_control_access_mode) {
>    8220		case TPACPI_FAN_WR_ACPI_SFAN:
>    8221			if ((level < 0) || (level > 7))
>    8222				return -EINVAL;
>    8223	
>    8224			if (tp_features.second_fan_ctl) {
>    8225				if (!fan_select_fan2() ||
>    8226				    !acpi_evalf(sfan_handle, NULL, NULL, "vd", level)) {
>    8227					pr_warn("Couldn't set 2nd fan level, disabling support\n");
>    8228					tp_features.second_fan_ctl = 0;
>    8229				}
>    8230				fan_select_fan1();
>    8231			}
>    8232			if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", level))
>    8233				return -EIO;
>    8234			break;
>    8235	
>    8236		case TPACPI_FAN_WR_ACPI_FANS:
>    8237		case TPACPI_FAN_WR_TPEC:
>    8238			if (!(level & TP_EC_FAN_AUTO) &&
>    8239			    !(level & TP_EC_FAN_FULLSPEED) &&
>    8240			    ((level < 0) || (level > 7)))
>    8241				return -EINVAL;
>    8242	
>    8243			/* safety net should the EC not support AUTO
>    8244			 * or FULLSPEED mode bits and just ignore them */
>    8245			if (level & TP_EC_FAN_FULLSPEED)
>    8246				level |= 7;	/* safety min speed 7 */
>    8247			else if (level & TP_EC_FAN_AUTO)
>    8248				level |= 4;	/* safety min speed 4 */
>    8249	
>    8250			if (tp_features.second_fan_ctl) {
>    8251				if (!fan_select_fan2() ||
>    8252				    !acpi_ec_write(fan_status_offset, level)) {
>    8253					pr_warn("Couldn't set 2nd fan level, disabling support\n");
>    8254					tp_features.second_fan_ctl = 0;
>    8255				}
>    8256				fan_select_fan1();
>    8257	
>    8258			}
>    8259			if (!acpi_ec_write(fan_status_offset, level))
>    8260				return -EIO;
>    8261			else
>    8262				tp_features.fan_ctrl_status_undef = 0;
>    8263			break;
>    8264	
>    8265		case TPACPI_FAN_WR_ACPI_FANW:
>    8266			if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
>    8267				return -EINVAL;
>    8268			if (level & TP_EC_FAN_FULLSPEED)
>    8269				return -EINVAL;
>    8270	
>    8271			if (level & TP_EC_FAN_AUTO) {
>    8272				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
>    8273					rc = -EIO;
>    8274					break;
>    8275				}
>    8276				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
>    8277					rc = -EIO;
>    8278					break;
>    8279				}
>    8280			} else {
>    8281				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
>    8282					rc = -EIO;
>    8283					break;
>    8284				}
>    8285				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
>    8286					rc = -EIO;
>    8287					break;
>    8288				}
>    8289				if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level * 100 / 7)) {
>    8290					rc = -EIO;
>    8291					break;
>    8292				}
>    8293			}
>    8294			break;
>    8295	
>    8296		default:
>    8297			return -ENXIO;
>    8298		}
>    8299	
>    8300		vdbg_printk(TPACPI_DBG_FAN,
>    8301			"fan control: set fan control register to 0x%02x\n", level);
>    8302		return 0;
>    8303	}
>    8304	
> 

