Return-Path: <linux-kernel+bounces-341310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D66987E15
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD05B2155E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799215D5D8;
	Fri, 27 Sep 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfTU9tY4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A815A4B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416863; cv=none; b=Qr099qFsZRFO+sPSrZOw3BvA9cZIfYeBRCIutzZaKO/14FEW+oBBaXGkpsVdnODA7WdLjoPk3vi/snfcBbS4RoJCaI5QRXvPsJrRpqeDnpcd568UVTKbvH33v9iQFxjhg0bc1QLPhVqVm/Crw+LjTYEJwMRMQ0Q3yQGr9lZZ/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416863; c=relaxed/simple;
	bh=1CZjH2GMmNuFosenJ1gD9k7hroucOKjhqv8TIy3/mc8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRzN8s/e7xrBNzKBNifVG+BYrCgYIGFyDk4v4IrJMvYaFAgP5s+kgz3JnEYB6lvwLDk+xKcHzcnZbLrl+p5TOpuCzeRHuuLuk2OhpSxVDkGejqLpVMcpxYZqx5+3cE6il7Pmd9NEhaVH88nK4yVZVF35+1cfk9qYpD4V3oPvk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfTU9tY4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727416862; x=1758952862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1CZjH2GMmNuFosenJ1gD9k7hroucOKjhqv8TIy3/mc8=;
  b=GfTU9tY4CEc2y0hyaKpoDzuhM2amvvXk/EZA3tqsv6J1tbPVT3K4VHjz
   Ac2Mcg6eI3MG2RXOg+cEFldJc6hnxYassduC44D8eQ9LfKF8jwjZhpzJP
   7eoRiXjkQ1LmjKef73nhyDxBic7k+w7t5406F6G3WMEcEUqfa2Qhn4dhz
   HqblXSfwFdj4E+kofhrx9yYyMIFtiFW5+rebb+CMYH9/e1lY+0KAC/3aK
   xZkMOa4HvjM02Fv4+R3+mIngoHafwkExOoIVOtMnPeQE92flsZaz6A5KO
   OX2rVygyDP9FF4PvwIHYVUirT7Z046izKRexVR+3S6yX6mlxBLEkj/r9F
   A==;
X-CSE-ConnectionGUID: qh6+9Bo/TqWvTVINbPauyA==
X-CSE-MsgGUID: d4JFX6/0TDOqkPkB6iotng==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37688040"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37688040"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 23:01:01 -0700
X-CSE-ConnectionGUID: cWBA5kK/TniPT3mMxwECjg==
X-CSE-MsgGUID: ANCoz9TRSrSdrfya8d1uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="76782972"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Sep 2024 23:01:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su42E-000Lai-15;
	Fri, 27 Sep 2024 06:00:58 +0000
Date: Fri, 27 Sep 2024 14:00:40 +0800
From: kernel test robot <lkp@intel.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/pressure/sdp500.c:130:undefined reference to
 `crc8_populate_msb'
Message-ID: <202409271341.0dhpXk7G-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
commit: 6ddb86d93cc08c00eccc1a14980f7260e4fbe2bc iio: pressure: Add driver for Sensirion SDP500
date:   8 weeks ago
config: sh-randconfig-r054-20240801 (https://download.01.org/0day-ci/archive/20240927/202409271341.0dhpXk7G-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409271341.0dhpXk7G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409271341.0dhpXk7G-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_probe':
>> drivers/iio/pressure/sdp500.c:130:(.text+0xe8): undefined reference to `crc8_populate_msb'
   sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_read_raw':
>> drivers/iio/pressure/sdp500.c:74:(.text+0x200): undefined reference to `crc8'


vim +130 drivers/iio/pressure/sdp500.c

    40	
    41	static int sdp500_read_raw(struct iio_dev *indio_dev,
    42				  struct iio_chan_spec const *chan,
    43				  int *val, int *val2, long mask)
    44	{
    45		int ret;
    46		u8 rxbuf[SDP500_READ_SIZE];
    47		u8 received_crc, calculated_crc;
    48		struct sdp500_data *data = iio_priv(indio_dev);
    49		struct i2c_client *client = to_i2c_client(data->dev);
    50	
    51		switch (mask) {
    52		case IIO_CHAN_INFO_RAW:
    53			ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
    54			if (ret < 0) {
    55				dev_err(data->dev, "Failed to receive data");
    56				return ret;
    57			}
    58			if (ret != SDP500_READ_SIZE) {
    59				dev_err(data->dev, "Data is received wrongly");
    60				return -EIO;
    61			}
    62	
    63			received_crc = rxbuf[2];
    64			calculated_crc = crc8(sdp500_crc8_table, rxbuf,
    65					      sizeof(rxbuf) - 1, 0x00);
    66			if (received_crc != calculated_crc) {
    67				dev_err(data->dev,
    68					"calculated crc = 0x%.2X, received 0x%.2X",
    69					calculated_crc, received_crc);
    70				return -EIO;
    71			}
    72	
    73			*val = get_unaligned_be16(rxbuf);
  > 74			return IIO_VAL_INT;
    75		case IIO_CHAN_INFO_SCALE:
    76			*val = 1;
    77			*val2 = 60;
    78	
    79			return IIO_VAL_FRACTIONAL;
    80		default:
    81			return -EINVAL;
    82		}
    83	}
    84	
    85	static const struct iio_info sdp500_info = {
    86		.read_raw = &sdp500_read_raw,
    87	};
    88	
    89	static int sdp500_probe(struct i2c_client *client)
    90	{
    91		struct iio_dev *indio_dev;
    92		struct sdp500_data *data;
    93		struct device *dev = &client->dev;
    94		int ret;
    95		u8 rxbuf[SDP500_READ_SIZE];
    96	
    97		ret = devm_regulator_get_enable(dev, "vdd");
    98		if (ret)
    99			return dev_err_probe(dev, ret,
   100				"Failed to get and enable regulator\n");
   101	
   102		indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
   103		if (!indio_dev)
   104			return -ENOMEM;
   105	
   106		/* has to be done before the first i2c communication */
   107		crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
   108	
   109		data = iio_priv(indio_dev);
   110		data->dev = dev;
   111	
   112		indio_dev->name = "sdp500";
   113		indio_dev->channels = sdp500_channels;
   114		indio_dev->info = &sdp500_info;
   115		indio_dev->modes = INDIO_DIRECT_MODE;
   116		indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
   117	
   118		ret = sdp500_start_measurement(data);
   119		if (ret)
   120			return dev_err_probe(dev, ret, "Failed to start measurement");
   121	
   122		/* First measurement is not correct, read it out to get rid of it */
   123		i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
   124	
   125		ret = devm_iio_device_register(dev, indio_dev);
   126		if (ret)
   127			return dev_err_probe(dev, ret, "Failed to register indio_dev");
   128	
   129		return 0;
 > 130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

