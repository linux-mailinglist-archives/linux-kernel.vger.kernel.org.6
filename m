Return-Path: <linux-kernel+bounces-200378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C38FAF27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC428757F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C391448E8;
	Tue,  4 Jun 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDdhVlHm"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A8132C3B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494265; cv=none; b=u03ckGNDAc4H50vb0S7oPmI41oA5TNSC5RyEC2iHTvb2DC15tl5OKP7+o+fOHGpKVtC1IvLKB+SJShGtu6grDKqDxxAp52BstdJtzOvYu670Jwng0nqAngkjXibTwDZGidabVdfU79LAG1tMNNfrcjVSlXO/v71jMpBqLJ3pf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494265; c=relaxed/simple;
	bh=Rhltkdqa0LirydicuC2JlXlckT1RGhjedHdiiIeFNo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hpN+h2jUyjQ243rcmMEL2EX8fomFr2/3Csi6ZMzmo6pyhKRxH64TV8QCg8r0CP9toN7WcHfaYaU37AbfCWq574ZzhjOuvR61IDJerCSHQJX/0F8DVQCClmHg7/Ul0HyLvWb/7Hvrxq2T+5PXedGxPqzHDgmAae17xnweMgHW6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDdhVlHm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68a288b8a4so168855966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717494262; x=1718099062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YIlHWOD6fPX9OUWe4yPdCebJ7mahJYdAM8sZOo6QrW8=;
        b=fDdhVlHm4WmUlM7qoV/QkzB09IeuZGSvHe3qMyX7I+NJAGPeuBbIFAkaMdCKPCUed/
         Nd5HUvA0riQyirLxathH+gpo181BaUPxP6IIi6g4IYr+NH3QUHapDyJx4t8OK0f5dpM9
         7l+kavHs7BDukBQ42vwPXOOIPWdzhngY+tVm/4s9PyJY/ocaQTZ+V9ymWViH2tu71Siu
         E58IbxSECcFvZINTWEVcag1FgHT656Hu7vwikrcBNXcgMNKRo6YygTfgQEGJve/sZgxE
         gNpcnmLmItnqmy2Zw5xbpPUuZqpfpJYHW/NjamzouDJkRH6T1cYMCviuTsghT8iEo+or
         LpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717494262; x=1718099062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIlHWOD6fPX9OUWe4yPdCebJ7mahJYdAM8sZOo6QrW8=;
        b=TCpFd3PbvnObYIz9f+b6kgZvkc6m2QtFKfzdXtv4fsUITiAX6bq/HbYWdvE/EJgSY+
         loHrWj64UmVIjGf9xjJysilONBZbeRV9zgTZ1ttmp5A3hv5YHX10tErhQ4/KccjXqsRe
         B30OXWTS3CZ4PuvshgyLJLQmYQ7+rrFde8hnjH/fGtpiQUcBH9SZxfIO0h5jBjTQWhom
         Ssvr3LjwGmgDyT3a55iNBuIwsrniN1BhFNS9lYXCZh1py2ii+GilG76TT1vBbjUjMEm+
         m5YbkTx0w3EzJWD3tRTwzuzTIxuqsLGdlopsyX0ciHHNSzTiJwoINMC1DxPuOre9LkZ6
         G/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUc4/ZyBX6QCgnEonks2y/TaHS8QKN1enXOA9ab3aAgXXEwCNZaj+7IdINC/9xudxvlB65wNVhg6Cn+jXfrBVXVjYoSLe0bUuLMIZaR
X-Gm-Message-State: AOJu0YyYvles+8vGcgCjkxtUfG7zpn/+PNcSyv6ruIgKS7w1gUh7Et4i
	vAixCMYYAOivPQRA/TAx8elwTvmObwv/6D7X8kCUe3O4Pel/3fuuq7mfjlFQVY0=
X-Google-Smtp-Source: AGHT+IF4WDwubGz7lj6hfOWgiPF/RXnBE+CSyiCwcDTC9+95fISbH5npZcubhTH2DN0W9ZRr07yh2A==
X-Received: by 2002:a50:9e61:0:b0:579:f196:487f with SMTP id 4fb4d7f45d1cf-57a363ffbf2mr10474770a12.31.1717494261378;
        Tue, 04 Jun 2024 02:44:21 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a76d47a57sm1897989a12.27.2024.06.04.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:44:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:44:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] can: m_can: don't enable transceiver when probing
Message-ID: <bf035b23-4b26-4135-8051-99de9d2f7c88@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530105801.3930087-1-martin@geanix.com>

Hi Martin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Hundeb-ll/can-m_can-don-t-enable-transceiver-when-probing/20240530-185906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20240530105801.3930087-1-martin%40geanix.com
patch subject: [PATCH v3] can: m_can: don't enable transceiver when probing
config: i386-randconfig-r081-20240603 (https://download.01.org/0day-ci/archive/20240603/202406031513.ByfTbHww-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406031513.ByfTbHww-lkp@intel.com/

New smatch warnings:
drivers/net/can/m_can/m_can.c:1725 m_can_dev_setup() error: uninitialized symbol 'err'.

vim +/err +1725 drivers/net/can/m_can/m_can.c

3b464affd89821 Marc Kleine-Budde 2020-12-12  1671  static int m_can_dev_setup(struct m_can_classdev *cdev)
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1672  {
3b464affd89821 Marc Kleine-Budde 2020-12-12  1673  	struct net_device *dev = cdev->net;
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1674  	int m_can_version, err, niso;
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1675  
3b464affd89821 Marc Kleine-Budde 2020-12-12  1676  	m_can_version = m_can_check_core_release(cdev);
b03cfc5bb0e11f Mario Huettel     2017-04-08  1677  	/* return if unsupported version */
b03cfc5bb0e11f Mario Huettel     2017-04-08  1678  	if (!m_can_version) {
3b464affd89821 Marc Kleine-Budde 2020-12-12  1679  		dev_err(cdev->dev, "Unsupported version number: %2d",
5e520edd91f0cd Faiz Abbas        2018-01-16  1680  			m_can_version);
5e520edd91f0cd Faiz Abbas        2018-01-16  1681  		return -EINVAL;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1682  	}
b03cfc5bb0e11f Mario Huettel     2017-04-08  1683  
3b464affd89821 Marc Kleine-Budde 2020-12-12  1684  	if (!cdev->is_peripheral)
b48b89f9c189d2 Jakub Kicinski    2022-09-27  1685  		netif_napi_add(dev, &cdev->napi, m_can_poll);
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1686  
b03cfc5bb0e11f Mario Huettel     2017-04-08  1687  	/* Shared properties of all M_CAN versions */
3b464affd89821 Marc Kleine-Budde 2020-12-12  1688  	cdev->version = m_can_version;
3b464affd89821 Marc Kleine-Budde 2020-12-12  1689  	cdev->can.do_set_mode = m_can_set_mode;
3b464affd89821 Marc Kleine-Budde 2020-12-12  1690  	cdev->can.do_get_berr_counter = m_can_get_berr_counter;
6cfda7fbebe8a4 Oliver Hartkopp   2015-01-05  1691  
b03cfc5bb0e11f Mario Huettel     2017-04-08  1692  	/* Set M_CAN supported operations */
3b464affd89821 Marc Kleine-Budde 2020-12-12  1693  	cdev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1694  		CAN_CTRLMODE_LISTENONLY |
80646733f11c2e Dong Aisheng      2014-11-18  1695  		CAN_CTRLMODE_BERR_REPORTING |
fb7d6a81c22017 Pankaj Sharma     2019-10-21  1696  		CAN_CTRLMODE_FD |
fb7d6a81c22017 Pankaj Sharma     2019-10-21  1697  		CAN_CTRLMODE_ONE_SHOT;
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1698  
b03cfc5bb0e11f Mario Huettel     2017-04-08  1699  	/* Set properties depending on M_CAN version */
3b464affd89821 Marc Kleine-Budde 2020-12-12  1700  	switch (cdev->version) {
b03cfc5bb0e11f Mario Huettel     2017-04-08  1701  	case 30:
b03cfc5bb0e11f Mario Huettel     2017-04-08  1702  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1703  		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1704  		if (err)
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1705  			return err;
d6da7881020f9b Jarkko Nikula     2022-05-12  1706  		cdev->can.bittiming_const = &m_can_bittiming_const_30X;
d6da7881020f9b Jarkko Nikula     2022-05-12  1707  		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_30X;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1708  		break;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1709  	case 31:
b03cfc5bb0e11f Mario Huettel     2017-04-08  1710  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1711  		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1712  		if (err)
7d4a101c0bd3c6 Vincent Mailhol   2021-12-14  1713  			return err;
d6da7881020f9b Jarkko Nikula     2022-05-12  1714  		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
d6da7881020f9b Jarkko Nikula     2022-05-12  1715  		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1716  		break;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1717  	case 32:
5c7d55bded77da Pankaj Sharma     2020-11-26  1718  	case 33:
5c7d55bded77da Pankaj Sharma     2020-11-26  1719  		/* Support both MCAN version v3.2.x and v3.3.0 */
d6da7881020f9b Jarkko Nikula     2022-05-12  1720  		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
d6da7881020f9b Jarkko Nikula     2022-05-12  1721  		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
f524f829b75a7d Dan Murphy        2019-05-09  1722  
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1723  		niso = m_can_niso_supported(cdev);
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1724  		if (niso < 0)
e96c73eab56aed Martin Hundeb�ll  2024-05-30 @1725  			return err;

s/err/niso/

e96c73eab56aed Martin Hundeb�ll  2024-05-30  1726  		if (niso)
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1727  			cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1728  		break;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1729  	default:
3b464affd89821 Marc Kleine-Budde 2020-12-12  1730  		dev_err(cdev->dev, "Unsupported version number: %2d",
3b464affd89821 Marc Kleine-Budde 2020-12-12  1731  			cdev->version);
5e520edd91f0cd Faiz Abbas        2018-01-16  1732  		return -EINVAL;
b03cfc5bb0e11f Mario Huettel     2017-04-08  1733  	}
b03cfc5bb0e11f Mario Huettel     2017-04-08  1734  
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1735  	/* Forcing standby mode should be redunant, as the chip should be in
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1736  	 * standby after a reset. Write the INIT bit anyways, should the chip
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1737  	 * be configured by previous stage.
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1738  	 */
e96c73eab56aed Martin Hundeb�ll  2024-05-30  1739  	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
e0d1f4816f2a7e Dong Aisheng      2014-07-16  1740  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


