Return-Path: <linux-kernel+bounces-553371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C65A58836
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4233AB668
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864D21D584;
	Sun,  9 Mar 2025 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiRxylOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB4160783;
	Sun,  9 Mar 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741552939; cv=none; b=NlDn1D7DK+43/DFLtkxm7q8IkNLmW69+zaj/o3zJucitEitQTmsFZwFqveb5pph8G65aN2Ii4TLwrS73yYclsZZfsRjBi6VwbPFfzuaxSQSaPm4OIWPtyfwrSC5IavARR04RKSStIayxaWOIXSQMfZJjOxsz/rrzgJjzKG0Jc2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741552939; c=relaxed/simple;
	bh=jTfqTCbDUL9De+VnUopmQtOgbCkPufvbtvYfClQfw3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGgZgc8ha02K/ZXsGAFkdTSxaaBa2jZ/jhR/Ug0iTaCrbaWU1DTGngrSK/MKL2fK6cFrPg1PQcVuCLyn+o5IdA7aOT9OZ4F46Mc5xKSHLVosd1lNM3ZJvhxZVBc8kioV37oJqQ5RiDyxoOZhvQqNzTrXdRRchCF+KsGGnj/2qaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiRxylOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80657C4CEE3;
	Sun,  9 Mar 2025 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741552938;
	bh=jTfqTCbDUL9De+VnUopmQtOgbCkPufvbtvYfClQfw3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiRxylOyLMLaJ81IdMWw8ncRE02cscEzs8gNprls/nRLpwRkWvRLIruRbc8cSUgVk
	 u18ftdQYxxz1oeRSdaCWkZ9Tm4+klEs3T0H/AKBNVbvvxRESVR27ywt+Hz0sODXUQ4
	 Maq931lEl6zr6M0qv3vfYoHDw2bbNQJ33+4u1UYcdiFcT2ZemrO7ecq/rcP4MffB9P
	 lgdENq+VeZ+NWyIGvnCMPjcubCCptvDadloW4984f5GgT+YUQFCD9IK7cCxRol4fGk
	 XQPY0ChzIPp3HBaDmA4d7aX7iTSbv1cPhKlzv5zHUz0xikesxujYrUzk43A/NdSeeK
	 HeXuHcaJdiyHQ==
Date: Sun, 9 Mar 2025 21:42:11 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>, wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, ivprusov@salutedevices.com, jack.yu@realtek.com,
	zhoubinbin@loongson.cn, luca.ceresoli@bootlin.com,
	quic_pkumpatl@quicinc.com, paulha@opensource.cirrus.com,
	rf@opensource.cirrus.com, nuno.sa@analog.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, yijiangtao@awinic.com
Subject: Re: [PATCH V2 2/2] ASoC: codecs: Add aw88166 amplifier driver
Message-ID: <20250309204211.GA960576@ax162>
References: <20250228034958.181934-3-wangweidong.a@awinic.com>
 <202503081433.xufVVq8t-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503081433.xufVVq8t-lkp@intel.com>

On Sat, Mar 08, 2025 at 02:20:22PM +0800, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 1e15510b71c99c6e49134d756df91069f7d18141]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-dt-bindings-Add-schema-for-awinic-aw88166/20250228-115709
> base:   1e15510b71c99c6e49134d756df91069f7d18141
> patch link:    https://lore.kernel.org/r/20250228034958.181934-3-wangweidong.a%40awinic.com
> patch subject: [PATCH V2 2/2] ASoC: codecs: Add aw88166 amplifier driver
> config: x86_64-buildonly-randconfig-004-20250308 (https://download.01.org/0day-ci/archive/20250308/202503081433.xufVVq8t-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503081433.xufVVq8t-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503081433.xufVVq8t-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> sound/soc/codecs/snd-soc-aw88166.o: warning: objtool: .text.aw_dev_dsp_update_cfg: unexpected end of section

Neat, it looks like LTO allows clang to figure out that through inlining
that...

  | static int aw_dev_dsp_read(struct aw_device *aw_dev,
  |         unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
  | {
  |     ...
  |     case AW88166_DSP_32_DATA:
  |         ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
  |         if (ret)
  |             dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
  |                     (u32)dsp_addr, *dsp_data);

                                       ^ This is an uninitialized read...

  | static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
  |         unsigned short dsp_addr, unsigned int *dsp_data)
  | {
  |     unsigned int temp_data;
  |     int ret;
  |
  |     ret = regmap_write(aw_dev->regmap, AW88166_DSPMADD_REG, dsp_addr);
  |     if (ret) {
  |         dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
  |         return ret;
  |     }
  |
  |     ret = regmap_read(aw_dev->regmap, AW88166_DSPMDAT_REG, &temp_data);
  |     if (ret) {
  |         dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
  |         return ret;
  |     }
  |     *dsp_data = temp_data;

when either of the two error statements occur before this assignment...

  | static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
  | {
  |     struct aw_device *aw_dev =
  |         container_of(cali_desc, struct aw_device, cali_desc);
  |     u32 dsp_ra;
  |     int ret;
  |
  |     ret = aw_dev_dsp_read(aw_dev, AW88166_DSP_REG_CFG_ADPZ_RA,
  |                 &dsp_ra, AW88166_DSP_32_DATA);

                    ^ because it was not initialized prior to this point.

Initializng dsp_ra to 0 in aw_dev_get_ra() resolves the issue but that
may or may not be correct, it just shows where the issue lies.

Cheers,
Nathan

