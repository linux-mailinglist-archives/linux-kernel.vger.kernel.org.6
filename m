Return-Path: <linux-kernel+bounces-187485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D108CD268
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BB9B21A23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096F149DF3;
	Thu, 23 May 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/m+ByQR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F0149DEC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468145; cv=none; b=Ovt1evkYGpnqWTrDS6gLHm/Xm9UNDPsLf06pQrSq4JCYgh5MVBIjws7K5MnHLciCaABj1CIT/K1ngdIISTFYyAyZV5E8m2MeF3+dwVlNE5NVR3wlSv8azidarFFUM1kQBjkrOCZJbRLN6bFcrsEAxzta1tzCr5/f8VhShYFlQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468145; c=relaxed/simple;
	bh=NxkdAdrJdInDnQmRVOBymr54RQlzSPSCJD6k5LWkhYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qJM63qHyC/y11UUGobxOeOAKOOaWqhrScJiUlbbbHEyIow166OV2UCcCms3Q60gpcrfx+xCz/Ds0vRofrjC7QiGsNxPYcBNY8VUOeYtSvQ3VDBm4OgCN2ZKoF+MTPBa3fWI+JiXK/0USS3IAq1cjyLmsjXdhlwaXmUdmb0KAS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i/m+ByQR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e576057c06so72848301fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716468141; x=1717072941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFU7oe29wmWrSHAWUNO1lKOXXAdRLnYpFR9nmVzit9Y=;
        b=i/m+ByQRqn8Nd+LNIObZSaInmdiknv2iVi28VA+/w3Y6mXM/aaobtCzek/vuWp1hyu
         Kz9p7+KjYW7olySkalcUQNyjcMF/r3gkhZhgCT+lM5qBy9i42TnVjVZswORcKAJNRHFE
         05WE6pPGVud9tHrCpTQKPl62vb5/OyP35mggQdMtodUYLodh3jo3vqnFhz8AvaVtEVxb
         O7BT2Fio8cQmZGfRhvNXmc3VCBB5dQgHn77QvWasfb3wA0fUw/OWxZ56gmzTVOTTuAgC
         LC3+AWsCcdLhUauKokr9i53WfcWJyJ8Ra2Tug8j3GuOP3CbY0/PhsUOY+7v+GfjQ6LZi
         9S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468141; x=1717072941;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFU7oe29wmWrSHAWUNO1lKOXXAdRLnYpFR9nmVzit9Y=;
        b=ci2pM2Sxkw4Ae8a3fALe5wqN9DCSTrGJdAcf0PgGR3o6/8SmhShbZX7xiwrVEUfn/F
         Qd6nNg/ByzLRE5zot/PDbnwfdEVAG4zr2XVqG0LJBHNsUedWQsk0g5vOMbPuulwVxlo7
         09yGbntJrgNCaq4D9009pCWD0MswegEFyAW8UHE/PBRcGJqQ+GXqmZW2Mt14XdxnZfx6
         f/1+11XKPBmRxl4Uv067x3zwdQoM75QXz3r9M12meJ2twWqr5R2Xf7sX1+2tczGzs4dG
         I8VleFcdUjLjjKc/1Th+RerbGiasQ3ZGpoyOooN73+aYo+trKD9pZNFaygGXrj42hstO
         W8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUdukY88s+/4HV3FvrQrWXyNXNs9zoKK19DoBSR32o2sTyvhnWhregdEesWT9bgZ3lejukm/MlqF5KXTQx5oOnLkMisU04D/BumkJk
X-Gm-Message-State: AOJu0Ywu6k/+jpioRZaWltz/lluRRIDq4y51VF+mY8Ii+qamQI8ro6oF
	0wTVHBRdYzEcZuzbJpRnlgc1ug6A4OSOreyHs1TyJJpzYNqvG9e1otc+hVTb9dc=
X-Google-Smtp-Source: AGHT+IG3pezFMtkMlzalGpaEUoGKwhfiLMGTt+4yA3z1pbJAP8F/Z0+LeagQc9XdwWQbIpirFEUQzA==
X-Received: by 2002:a2e:a549:0:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2e9494f2a5bmr38375081fa.22.1716468140465;
        Thu, 23 May 2024 05:42:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fc82eeb4sm26079305e9.0.2024.05.23.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:42:20 -0700 (PDT)
Date: Thu, 23 May 2024 15:42:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	swboyd@chromium.org, nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240515-083021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: alpha-randconfig-r081-20240516 (https://download.01.org/0day-ci/archive/20240517/202405170824.uhEslLI0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405170824.uhEslLI0-lkp@intel.com/

smatch warnings:
drivers/iio/proximity/hx9031as.c:1118 hx9031as_raw_data_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1240 hx9031as_channel_en_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1466 hx9031as_threshold_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1491 hx9031as_dump_show() error: snprintf() is printing too much 8192 vs 1024
drivers/iio/proximity/hx9031as.c:1513 hx9031as_offset_dac_show() error: snprintf() is printing too much 8192 vs 512

vim +1118 drivers/iio/proximity/hx9031as.c

5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_data_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
5e5a419c9407f6 Yasin Lee 2024-05-10  1112  	char buf[BUF_SIZE] = {0};
5e5a419c9407f6 Yasin Lee 2024-05-10  1113  	char *p = buf;
5e5a419c9407f6 Yasin Lee 2024-05-10  1114  	int ii = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1115  
5e5a419c9407f6 Yasin Lee 2024-05-10  1116  	hx9031as_sample();
5e5a419c9407f6 Yasin Lee 2024-05-10  1117  	for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
5e5a419c9407f6 Yasin Lee 2024-05-10 @1118  		p += snprintf(p, PAGE_SIZE, "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
                                                                         ^^^^^^^^^
This doesn't work at all.  It should be BUF_SIZE instead of PAGE_SIZE
but also PAGE_SIZE is a fixed size where the number of bytes remaining
should get smaller as we write further into the buffer.

Also use scnprintf() instead of snprintf() unless you need to check the
results.  The normal way to write this is:

	int off = 0;

	hx9031as_sample();
	for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
		off += scnprintf(buf + off, BUF_SIZE - off,
                                 ^^^^^^^^^  ^^^^^^^^^^^^^^

				 "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
				 ii, hx9031as_pdata.diff[ii], hx9031as_pdata.raw[ii], ...

5e5a419c9407f6 Yasin Lee 2024-05-10  1119  						ii, hx9031as_pdata.diff[ii], hx9031as_pdata.raw[ii], hx9031as_pdata.dac[ii],
5e5a419c9407f6 Yasin Lee 2024-05-10  1120  						hx9031as_pdata.bl[ii], hx9031as_pdata.lp[ii]);
5e5a419c9407f6 Yasin Lee 2024-05-10  1121  	}
5e5a419c9407f6 Yasin Lee 2024-05-10  1122  
5e5a419c9407f6 Yasin Lee 2024-05-10  1123  	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
5e5a419c9407f6 Yasin Lee 2024-05-10  1124  }
5e5a419c9407f6 Yasin Lee 2024-05-10  1125  
5e5a419c9407f6 Yasin Lee 2024-05-10  1126  static const struct file_operations hx9031as_raw_data_fops = {
5e5a419c9407f6 Yasin Lee 2024-05-10  1127  	.read = hx9031as_raw_data_show,
5e5a419c9407f6 Yasin Lee 2024-05-10  1128  };
5e5a419c9407f6 Yasin Lee 2024-05-10  1129  
5e5a419c9407f6 Yasin Lee 2024-05-10  1130  static ssize_t hx9031as_reg_write_store(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
5e5a419c9407f6 Yasin Lee 2024-05-10  1131  {
5e5a419c9407f6 Yasin Lee 2024-05-10  1132  	int ret = -1;
5e5a419c9407f6 Yasin Lee 2024-05-10  1133  	unsigned int reg_address = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1134  	unsigned int val = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1135  	uint8_t addr = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1136  	uint8_t tx_buf[1] = {0};
5e5a419c9407f6 Yasin Lee 2024-05-10  1137  	char buf[BUF_SIZE];
5e5a419c9407f6 Yasin Lee 2024-05-10  1138  
5e5a419c9407f6 Yasin Lee 2024-05-10  1139  	ENTER;
5e5a419c9407f6 Yasin Lee 2024-05-10  1140  	if (count > BUF_SIZE)
5e5a419c9407f6 Yasin Lee 2024-05-10  1141  		return -EINVAL;
5e5a419c9407f6 Yasin Lee 2024-05-10  1142  
5e5a419c9407f6 Yasin Lee 2024-05-10  1143  	if (copy_from_user(buf, user_buf, count))

We don't know that this is NUL terminated.  What about if count == 1
and the rest of the buffer is uninitialized.  Same issues in other
functions as well.

5e5a419c9407f6 Yasin Lee 2024-05-10  1144  		return -EFAULT;
5e5a419c9407f6 Yasin Lee 2024-05-10  1145  
5e5a419c9407f6 Yasin Lee 2024-05-10  1146  	if (sscanf(buf, "%x,%x", &reg_address, &val) != 2) {
5e5a419c9407f6 Yasin Lee 2024-05-10  1147  		PRINT_ERR("please input two HEX numbers: aa,bb (aa: reg_address, bb: value_to_be_set)\n");
5e5a419c9407f6 Yasin Lee 2024-05-10  1148  		return -EINVAL;
5e5a419c9407f6 Yasin Lee 2024-05-10  1149  	}
5e5a419c9407f6 Yasin Lee 2024-05-10  1150  
5e5a419c9407f6 Yasin Lee 2024-05-10  1151  	addr = (uint8_t)reg_address;
5e5a419c9407f6 Yasin Lee 2024-05-10  1152  	tx_buf[0] = (uint8_t)val;
5e5a419c9407f6 Yasin Lee 2024-05-10  1153  
5e5a419c9407f6 Yasin Lee 2024-05-10  1154  	ret = hx9031as_write(addr, tx_buf, 1);
5e5a419c9407f6 Yasin Lee 2024-05-10  1155  	if (ret != 0)
5e5a419c9407f6 Yasin Lee 2024-05-10  1156  		PRINT_ERR("hx9031as_write failed\n");
5e5a419c9407f6 Yasin Lee 2024-05-10  1157  
5e5a419c9407f6 Yasin Lee 2024-05-10  1158  	PRINT_INF("WRITE:Reg0x%02X=0x%02X\n", addr, tx_buf[0]);
5e5a419c9407f6 Yasin Lee 2024-05-10  1159  	return count;
5e5a419c9407f6 Yasin Lee 2024-05-10  1160  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


