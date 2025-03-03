Return-Path: <linux-kernel+bounces-544939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBDA4E6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2981887D16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6331293B65;
	Tue,  4 Mar 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLLZj/OQ"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D7293B53
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105348; cv=fail; b=tkZ4SihsJPvfqVXjHfodzt4XoWGNmGxcrSxEEV/ayRAyNBa+jldzQsxxOsAqQomKCgLm86bquQw0B0jcsEbs5nBuTSjoLW8miNPxzINZr+BmQ+t+/ygiCbn6Qj9pIxdU9lU/p04Eb7bcNhgJ6uMMV8cqysPjPMUCbrYCTf0dxQc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105348; c=relaxed/simple;
	bh=fucGwyTcxn0EQjulUzMsPm26wgEi2YA6IYSbA6vBeK8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OTzk0XHTBD5Y9LDwUHOM4qUvuoKQ8alzTlS/8/bBaMpPJJl3zXCMqT+FP+M/QL3IWf+mpBQ90jfplsFqZN/YFYwaVYd/5P7Bla/41I2tt8wfSrAr0CbHTMkJndors0N32Q4PK79RlVXh3GPwRh2vVAr8yIrqysL0VjL7MjatVZ0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLLZj/OQ reason="signature verification failed"; arc=fail smtp.client-ip=198.175.65.12; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 6C35840D4DFC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:22:20 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gsF4DRRzG2xJ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:20:49 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9C42742730; Tue,  4 Mar 2025 19:20:37 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLLZj/OQ
X-Envelope-From: <linux-kernel+bounces-541685-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLLZj/OQ
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C95F041ECD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:17:43 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 751D22DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:17:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D0E188C517
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DBB2036EC;
	Mon,  3 Mar 2025 12:17:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABC1EF0BC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004224; cv=fail; b=uoFldqP3ordpstjAyrbvilf4rKWin57tn3UYKxU7SZCHe0J4+OuJyZB6qOtwAgKafFe+qR2QUHdN6lx0lt9/9pM6vYB1oZ+K35wgue8x9zoLC17RD0T2P7Hi/VxXMNPvCMroztEVKpmETstNByaNggwuehxH2L3olWPm0SX2e6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004224; c=relaxed/simple;
	bh=4XcMGz8TNkI5GembpOqbqE+GfbAfdX4HZX0IpJP/ZEk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nAvE7/Qgj55VsFG98UzdgCqK+QTA0V1p7YQp/lfdf+O3s2aVmgmuiUTC+f+SDCJIVWywChC6sH1PCWmKzN1/aOjf6tAQmaYiZBZq2TxA3T7mhBPpvR/5DZnSrkuIzxoLVDem4dVN/wcGaBQz4uHqpzqp99lpZbPNliLtQoB4p3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLLZj/OQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004218; x=1772540218;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=4XcMGz8TNkI5GembpOqbqE+GfbAfdX4HZX0IpJP/ZEk=;
  b=JLLZj/OQwhCB9TAaUtwL8cEvVNh8MfnOQwagNH6GuyDKVsi6d+nPB4Vl
   299yCq+4rF8ZN9607IRyRtjV/IAdmubayau6zS0toXRS29rdqch4m/4PW
   /4plsoCbmPg6Qx5gGq9LrRz/D+OjI80fHI0pD0IUL9rYCR0tgIdW0ZOYl
   MD6MRBUf/sDZ+xydRfcq/oMm2y6xDLfwuxyAKQKbp9dQQGGn6ZeNv7okH
   pyjOycAZF3rEduWVnZXm5un8jNy6O7cWdLPdR3U1o9LsJjlG9QYZMgqmf
   nK6/LEHmVJMiFI2b65t/LGACveigFlbf9FVwsTwnY0nFaxM8e1DEbzg+D
   w==;
X-CSE-ConnectionGUID: zeghSCjHTxC5JLitVS89HQ==
X-CSE-MsgGUID: QhMHXUtATX+Sf27yK/4mxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53267030"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="53267030"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:16:57 -0800
X-CSE-ConnectionGUID: CQ3YNc2ZRQi7lVWAS2GAvg==
X-CSE-MsgGUID: qndNhXmMTeCR12OBEACJMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="148803822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 04:16:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 04:16:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 04:16:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 04:16:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXBJn77jjXanHc/BmuSGe1tpghS+J55G7VvtyiFlKS6KFWF5OOZteE+Pf5XZ5TKxOFlGmwzlaPySmWHoLVM/KQ3Ifd19ll6X1QYu/AgkIBnlzWKtix6TTdF2PRJ+KruWBHPRD2lX+klNJEUhOsAxAU9ZBkItWZGSB/Rjyne4fNDwke8gZoJchejDZDQGE3SFqU+3PkVQ0PtbvcwwU1+3N48B9X2lc07U5IEb5yHy9lS2Uqn3EJ4YVguabZzrmgifC+8oMXu03z/CtibbWMfTyHaaXuKvZQpIvPX9eFpGz5IoQFSi9JHj9CVHxMIYXS4j0CcPv/dfCn4V56YSxLFpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/xU7kcoLk/29Ik+Co6VqAKL+ulr/Jy8vMybi2o4g5g=;
 b=DfvgW8D6/Vcdh5wD+yCJ5vTX3/N2ruNmnlJKPK4tW4AWHxtVZHDq7veRPXuDHFjefC0NmveUb4tabUi6qdtSY1olnV/a4Zl1/nytdp8oPWhbZKu6gybIBdhlFE9RbYs/NRGQo9O2y4EkY1Z1D6g9vKDQUozoDB+tnr7kDHys+x5/xLgO0HEsnXnahvPSdt0929roQSZHevby9+qwswELSs3xRjdOzS5TsUmQiPR5/pKG3K8/bc8Q9q+lcc2J/TpmG1yLQnPYsLFXwakx7Xq0gkrXSzApR4jME06QsAZufvk3442JkclUfuNAmFm8g4zNcLSeasQeQ2uawI8oEBmrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Mon, 3 Mar 2025 12:16:39 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:16:39 +0000
Date: Mon, 3 Mar 2025 20:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: arch/arm64/boot/dts/mediatek/mt8183.dtsi:1827.22-1839.5: Warning
 (avoid_unnecessary_addr_size): /soc/dsi@14014000: unnecessary
 #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
 property
Message-ID: <Z8Wdn/gFkVwAbwsk@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 30555fc4-9119-450c-c361-08dd5a4d3fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?v+rmHIfxHdEBtLA2HyhwKPvULvh3s4En0AmaGwiOVBMnTr/SKayq37G0v5?=
 =?iso-8859-1?Q?mLb/XagmCpMYFYLW2BofITa49D8gZxl9+NfIm6H3QWSen3wVUMZkUHfjk5?=
 =?iso-8859-1?Q?W13phw/UA/djyEthcLigqJjAY1/IheLlX8qY/Ujg8HNp5nWgUvxinZ+9Ir?=
 =?iso-8859-1?Q?Sy0FWCYhS0iHJ/xEIgCk/7Iz+9b1KA2f+rnNj5GQcHkoQhSOnglikpOpyh?=
 =?iso-8859-1?Q?YWZ2x2d7QPcFNUSuA78IDHWfl+i9HCsX2b/Y5wLWZmUyw/UnOHgcoUBxLl?=
 =?iso-8859-1?Q?euEsx+kmhEyZU5kAimSeaZ9cZ7AQTeccoK9d0NXnphnR9mqqwB/eyyigFx?=
 =?iso-8859-1?Q?DDtb4Hn2k0En/vvCmaEb8BkPOEhOe8x33PNiWyzQ2T/mA5VuvmX4bzlXHx?=
 =?iso-8859-1?Q?Yfg4QqshY+4rEZQB5Vbgs5nPxC6e+gu76vmvlKCVAwxns3+LG1zHnRzQxO?=
 =?iso-8859-1?Q?iVg3/IIFXc3om6/HPJkmEr5/n0aJGhqDSrol4eMPnPUMf87smA6GK+MyKO?=
 =?iso-8859-1?Q?arAlTqlv70R19wMZ652etfMze/9cKV9yF2rbue48WzzjRMc/EkKifpWXiY?=
 =?iso-8859-1?Q?jkVlkNJr/c+Vj10eRafoONHcvsZuMire4ySW96nG4lPc80hHs+T6OVSPeJ?=
 =?iso-8859-1?Q?mkqk60/LcM9NK53E45nMatNLh94pKgo8R4etVWoAb1XBy87x4V1F9C3Xgu?=
 =?iso-8859-1?Q?ONm79ogPhQfE9SBvFhiK1xN04l1OhOBd5yDArZQ3CtS3zDetvKJ14gvqCB?=
 =?iso-8859-1?Q?iHGZ2/n8EEFrJo9dWJPa+P1nFCu9Wr7x8zUdZ1h94+ZHWNVbOTYfFztMZr?=
 =?iso-8859-1?Q?lTM2tnB8pqm04BI3IiV1Tud/5gjgZ+uOmb2Q1njwIYzAONhg6WoQfdzvVA?=
 =?iso-8859-1?Q?XKEQI4kGZixeJFY7Y/sr9fu3wUt92epgCPtKRtPoh+sG+6h4digXuBXQ+t?=
 =?iso-8859-1?Q?pe/rw/NU4gaH6D8fbGfvAdTBjMV8xSDc98XNSV8db78rGZQWA9xqLYyNMI?=
 =?iso-8859-1?Q?pdQXA3g7cznVwBVmFJRd5DNGLCv2KNVSVEzVR0rzliotv5N74gpjljuKXk?=
 =?iso-8859-1?Q?WR0Gk0sMwBOtTwzbGaBlCGYNxmlMMx+9aBQvDA/p7lpMDd78HvY37yprBH?=
 =?iso-8859-1?Q?DJXtboSQ4Jc6IV9Z5pIYznxzMtHJHY2RwacbW9IQDW0kiQLrUv4K67whB8?=
 =?iso-8859-1?Q?ZwZCw/wATSksksarvy+bcwSHbtTgqJXKnek8Dd9cvGgvsLYwa7AZha2RiY?=
 =?iso-8859-1?Q?ueV/rwjSHKIfAC5Y2Sh7k/BQYslgvQV/FyPuSmqRmadQd7BgcqJMN4L8fj?=
 =?iso-8859-1?Q?qm0+Jm5P1Q+a7aPeKb3Dq91J+wau+THQp91UEoMcxIBmZW9KivUlyCh7yD?=
 =?iso-8859-1?Q?o4O6ruwBAQZW6dyf7TSCq1ASkjUfS8qdae6vQcaBBTE+DI/3xStJzCLxla?=
 =?iso-8859-1?Q?i/BRGyhKTdxxMAFo1afG6V+w3doqS29tnI6mEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ArioR+9a6lrq0+73bfOtE5p7eX2phOJo/AKw/IY4zoLMJjgy/PT6J9zWmi?=
 =?iso-8859-1?Q?jj4LzBRh2iR5QNdEjLuGb4d9yRb1yi4vUJz+Q0GVcKd12BhR79UI1Ux165?=
 =?iso-8859-1?Q?SPZ6Ca2ZdrHc6rk7gOSaYS7zRXCDfTFYby5KInjssWiEkuZxJjfZh2hBOg?=
 =?iso-8859-1?Q?h4Lzy7Yp/LQGcLlX47KE92JxtcKVoqjffcXrKX4RJ+2/CsMhKFsqFpqtT+?=
 =?iso-8859-1?Q?tjLsqvYPSeu7AWwa1c2poqrcOAfCoenXXZs+RA0MYBtvDcLlgKlVT2dywn?=
 =?iso-8859-1?Q?+wS+uGnTK3oQysY20qg2Aca3abvS+z8D24vC137j1R49XLYtNBueNlZ/Yp?=
 =?iso-8859-1?Q?uMMQE4Y9bTvIi9DVCPUAWdJ4OiNn+dmNuzo6EnDPx7EGIv5RWAN5PlIXZT?=
 =?iso-8859-1?Q?CWTwWQAX4VS/3QiFdgonWRs2ntBHuAHea2BIaKR4Myd4NGXytztKWPac8l?=
 =?iso-8859-1?Q?Ti+LxL4cPb+VPt2UGcK2AJCGdHNpFcM00cmvh8790y+uLZ5tcqAXQnVz4m?=
 =?iso-8859-1?Q?m2a8IGQ3vwmQMax53jgEab3TwMYlj4qNm1Zq+/KYpdhMCjCcJumJaLr1Eh?=
 =?iso-8859-1?Q?hzZIMOV6pINyFysK4Fh1L1VYwhXwjKwEg5qeJ3OXp1n5MKdtmv63dME5rM?=
 =?iso-8859-1?Q?Gt1TTxTXRTr5eHsue08ZppFBbR77hQhhXHbzat6FuGV3xOJGMVh/Rff//D?=
 =?iso-8859-1?Q?dUdXK+RtU3PO22jyfhrIIeIVukeyF6o72nEHSVEgGlTgrFh7KXqmsTfZJn?=
 =?iso-8859-1?Q?KExuvRqGZFOPnSdPnqQkq2vgGcC8HbDjdlQBi96x0ip2SNlBkMLBtIHIuM?=
 =?iso-8859-1?Q?aKnV4pPkqFM0/VBmcF70R8kqdU0DfbIRlUR0wg1OBdEiRpqCXsra42b2xQ?=
 =?iso-8859-1?Q?39ghXPw22ZGSFp4rECkT5duA2kSr3lheGGIdrlOqCNSIjIR9W8jEDSANPs?=
 =?iso-8859-1?Q?likvNqaCQO9yXQpCBvO5RgzKh6U0Zsrj/srWbHJjCXXOezvrf5HCBpHa4c?=
 =?iso-8859-1?Q?DktlOZJuk1OxoCawOaxigBuqlGfVLfuhChtrqJGDWtyDWdKetQAaFA+gXV?=
 =?iso-8859-1?Q?i+j6cq+3RvKj7eRGaBFhx5vZtZWG5x78h954ESYIGcuREjYo1h7/XcQ3y3?=
 =?iso-8859-1?Q?kCaCEUXFo2a48wp2lNHbn9qucZMmjQ5QPJt2gR6SeBj8jJxpdBAy9PBohA?=
 =?iso-8859-1?Q?5leRery7jnAxh3u1k1ZOy6iw2ZlJwL7R82OlHxlAgdA6KGkvGjNEKMUrTU?=
 =?iso-8859-1?Q?FthSrSsx9SScBvmB0gR7uCED7y8llPsb49GUtaqsTq0wGjWdYA2uF2bvJ0?=
 =?iso-8859-1?Q?OsGmCLx4oeeyXmf9jqFd/C7gexBJLTMmgjwMij9MQtttNyp+h0fGCrU+hx?=
 =?iso-8859-1?Q?uUlQflFPRhuKHdyRiEb2qT4T2DqegJpbFDbA/sDrB+1he/Scxgv5CN/XYe?=
 =?iso-8859-1?Q?KlKRNtxktlQy6qBWA+hbKJUy/W5FqS7pyIOX9/a29EJYSvolPFokHrRbkX?=
 =?iso-8859-1?Q?wuKiUx9nbGEjNbDWolDqew60+RxQw3IN3hVQn9qwtXHjEivzYBHy0xiSQY?=
 =?iso-8859-1?Q?2YxKDdkJlihuV113yVNAiXw1S08XLCmB3/lbHb5ScQR1NNuH3XZeSZE4Ta?=
 =?iso-8859-1?Q?7hMqkLY4cyLNmMe6XMA4YeklNF/givz27SaRCcIP5ydfDQ6KIJRM3ygg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30555fc4-9119-450c-c361-08dd5a4d3fbf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:16:39.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/O+tOoFc3qOh+AzJnBODArH5HZN22fWoPqn8sWYdaNEGfWgCyeYzLEF96J49q7zHMzT9FoSKL+RxrSWFEhGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gsF4DRRzG2xJ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710059.31328@i2/FsmKz0Z/p2DTC7kxBkQ
X-ITU-MailScanner-SpamCheck: not spam

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
head:   7eb172143d5508b4da468ed59ee857c6e5e01da6
commit: 98ef7cef1b3a5d73b5023c8661534768810dd941 arm64: dts: mediatek: mt=
8183-kukui-jacuzzi: Simplify DSI endpoint replacement
date:   7 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 7 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/ar=
chive/20250303/202503031517.LKmW00Xb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250303/202503031517.LKmW00Xb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202503031517.LKmW00Xb-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/mediatek/mt8183.dtsi:1827.22-1839.5: Warning (avoi=
d_unnecessary_addr_size): /soc/dsi@14014000: unnecessary #address-cells/#=
size-cells without "ranges", "dma-ranges" or child "reg" property

vim +1827 arch/arm64/boot/dts/mediatek/mt8183.dtsi

e526c9bc11f858 Ben Ho                     2019-05-27    18 =20
e526c9bc11f858 Ben Ho                     2019-05-27    19  / {
e526c9bc11f858 Ben Ho                     2019-05-27    20  	compatible =3D=
 "mediatek,mt8183";
e526c9bc11f858 Ben Ho                     2019-05-27    21  	interrupt-pa=
rent =3D <&sysirq>;
e526c9bc11f858 Ben Ho                     2019-05-27    22  	#address-cel=
ls =3D <2>;
e526c9bc11f858 Ben Ho                     2019-05-27    23  	#size-cells =
=3D <2>;
e526c9bc11f858 Ben Ho                     2019-05-27    24 =20
251137b8fa97ef Qii Wang                   2019-08-22    25  	aliases {
251137b8fa97ef Qii Wang                   2019-08-22    26  		i2c0 =3D &i=
2c0;
251137b8fa97ef Qii Wang                   2019-08-22    27  		i2c1 =3D &i=
2c1;
251137b8fa97ef Qii Wang                   2019-08-22    28  		i2c2 =3D &i=
2c2;
251137b8fa97ef Qii Wang                   2019-08-22    29  		i2c3 =3D &i=
2c3;
251137b8fa97ef Qii Wang                   2019-08-22    30  		i2c4 =3D &i=
2c4;
251137b8fa97ef Qii Wang                   2019-08-22    31  		i2c5 =3D &i=
2c5;
251137b8fa97ef Qii Wang                   2019-08-22    32  		i2c6 =3D &i=
2c6;
251137b8fa97ef Qii Wang                   2019-08-22    33  		i2c7 =3D &i=
2c7;
251137b8fa97ef Qii Wang                   2019-08-22    34  		i2c8 =3D &i=
2c8;
251137b8fa97ef Qii Wang                   2019-08-22    35  		i2c9 =3D &i=
2c9;
251137b8fa97ef Qii Wang                   2019-08-22    36  		i2c10 =3D &=
i2c10;
251137b8fa97ef Qii Wang                   2019-08-22    37  		i2c11 =3D &=
i2c11;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27    38  		ovl0 =3D &o=
vl0;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27    39  		ovl-2l0 =3D=
 &ovl_2l0;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27    40  		ovl-2l1 =3D=
 &ovl_2l1;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27    41  		rdma0 =3D &=
rdma0;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27    42  		rdma1 =3D &=
rdma1;
251137b8fa97ef Qii Wang                   2019-08-22    43  	};
251137b8fa97ef Qii Wang                   2019-08-22    44 =20
95eacb24f3739d Rex-BC Chen                2022-05-16    45  	cluster0_opp=
: opp-table-cluster0 {
95eacb24f3739d Rex-BC Chen                2022-05-16    46  		compatible =
=3D "operating-points-v2";
95eacb24f3739d Rex-BC Chen                2022-05-16    47  		opp-shared;
95eacb24f3739d Rex-BC Chen                2022-05-16    48  		opp0-793000=
000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    49  			opp-hz =3D=
 /bits/ 64 <793000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    50  			opp-microv=
olt =3D <650000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    51  			required-o=
pps =3D <&opp2_00>;
95eacb24f3739d Rex-BC Chen                2022-05-16    52  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    53  		opp0-910000=
000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    54  			opp-hz =3D=
 /bits/ 64 <910000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    55  			opp-microv=
olt =3D <687500>;
95eacb24f3739d Rex-BC Chen                2022-05-16    56  			required-o=
pps =3D <&opp2_01>;
95eacb24f3739d Rex-BC Chen                2022-05-16    57  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    58  		opp0-101400=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    59  			opp-hz =3D=
 /bits/ 64 <1014000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    60  			opp-microv=
olt =3D <718750>;
95eacb24f3739d Rex-BC Chen                2022-05-16    61  			required-o=
pps =3D <&opp2_02>;
95eacb24f3739d Rex-BC Chen                2022-05-16    62  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    63  		opp0-113100=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    64  			opp-hz =3D=
 /bits/ 64 <1131000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    65  			opp-microv=
olt =3D <756250>;
95eacb24f3739d Rex-BC Chen                2022-05-16    66  			required-o=
pps =3D <&opp2_03>;
95eacb24f3739d Rex-BC Chen                2022-05-16    67  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    68  		opp0-124800=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    69  			opp-hz =3D=
 /bits/ 64 <1248000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    70  			opp-microv=
olt =3D <800000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    71  			required-o=
pps =3D <&opp2_04>;
95eacb24f3739d Rex-BC Chen                2022-05-16    72  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    73  		opp0-132600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    74  			opp-hz =3D=
 /bits/ 64 <1326000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    75  			opp-microv=
olt =3D <818750>;
95eacb24f3739d Rex-BC Chen                2022-05-16    76  			required-o=
pps =3D <&opp2_05>;
95eacb24f3739d Rex-BC Chen                2022-05-16    77  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    78  		opp0-141700=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    79  			opp-hz =3D=
 /bits/ 64 <1417000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    80  			opp-microv=
olt =3D <850000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    81  			required-o=
pps =3D <&opp2_06>;
95eacb24f3739d Rex-BC Chen                2022-05-16    82  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    83  		opp0-150800=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    84  			opp-hz =3D=
 /bits/ 64 <1508000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    85  			opp-microv=
olt =3D <868750>;
95eacb24f3739d Rex-BC Chen                2022-05-16    86  			required-o=
pps =3D <&opp2_07>;
95eacb24f3739d Rex-BC Chen                2022-05-16    87  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    88  		opp0-158600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    89  			opp-hz =3D=
 /bits/ 64 <1586000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    90  			opp-microv=
olt =3D <893750>;
95eacb24f3739d Rex-BC Chen                2022-05-16    91  			required-o=
pps =3D <&opp2_08>;
95eacb24f3739d Rex-BC Chen                2022-05-16    92  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    93  		opp0-162500=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    94  			opp-hz =3D=
 /bits/ 64 <1625000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16    95  			opp-microv=
olt =3D <906250>;
95eacb24f3739d Rex-BC Chen                2022-05-16    96  			required-o=
pps =3D <&opp2_09>;
95eacb24f3739d Rex-BC Chen                2022-05-16    97  		};
95eacb24f3739d Rex-BC Chen                2022-05-16    98  		opp0-167700=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16    99  			opp-hz =3D=
 /bits/ 64 <1677000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   100  			opp-microv=
olt =3D <931250>;
95eacb24f3739d Rex-BC Chen                2022-05-16   101  			required-o=
pps =3D <&opp2_10>;
95eacb24f3739d Rex-BC Chen                2022-05-16   102  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   103  		opp0-171600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   104  			opp-hz =3D=
 /bits/ 64 <1716000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   105  			opp-microv=
olt =3D <943750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   106  			required-o=
pps =3D <&opp2_11>;
95eacb24f3739d Rex-BC Chen                2022-05-16   107  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   108  		opp0-178100=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   109  			opp-hz =3D=
 /bits/ 64 <1781000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   110  			opp-microv=
olt =3D <975000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   111  			required-o=
pps =3D <&opp2_12>;
95eacb24f3739d Rex-BC Chen                2022-05-16   112  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   113  		opp0-184600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   114  			opp-hz =3D=
 /bits/ 64 <1846000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   115  			opp-microv=
olt =3D <1000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   116  			required-o=
pps =3D <&opp2_13>;
95eacb24f3739d Rex-BC Chen                2022-05-16   117  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   118  		opp0-192400=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   119  			opp-hz =3D=
 /bits/ 64 <1924000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   120  			opp-microv=
olt =3D <1025000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   121  			required-o=
pps =3D <&opp2_14>;
95eacb24f3739d Rex-BC Chen                2022-05-16   122  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   123  		opp0-198900=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   124  			opp-hz =3D=
 /bits/ 64 <1989000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   125  			opp-microv=
olt =3D <1050000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   126  			required-o=
pps =3D <&opp2_15>;
95eacb24f3739d Rex-BC Chen                2022-05-16   127  		};	};
95eacb24f3739d Rex-BC Chen                2022-05-16   128 =20
95eacb24f3739d Rex-BC Chen                2022-05-16   129  	cluster1_opp=
: opp-table-cluster1 {
95eacb24f3739d Rex-BC Chen                2022-05-16   130  		compatible =
=3D "operating-points-v2";
95eacb24f3739d Rex-BC Chen                2022-05-16   131  		opp-shared;
95eacb24f3739d Rex-BC Chen                2022-05-16   132  		opp1-793000=
000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   133  			opp-hz =3D=
 /bits/ 64 <793000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   134  			opp-microv=
olt =3D <700000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   135  			required-o=
pps =3D <&opp2_00>;
95eacb24f3739d Rex-BC Chen                2022-05-16   136  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   137  		opp1-910000=
000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   138  			opp-hz =3D=
 /bits/ 64 <910000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   139  			opp-microv=
olt =3D <725000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   140  			required-o=
pps =3D <&opp2_01>;
95eacb24f3739d Rex-BC Chen                2022-05-16   141  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   142  		opp1-101400=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   143  			opp-hz =3D=
 /bits/ 64 <1014000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   144  			opp-microv=
olt =3D <750000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   145  			required-o=
pps =3D <&opp2_02>;
95eacb24f3739d Rex-BC Chen                2022-05-16   146  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   147  		opp1-113100=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   148  			opp-hz =3D=
 /bits/ 64 <1131000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   149  			opp-microv=
olt =3D <775000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   150  			required-o=
pps =3D <&opp2_03>;
95eacb24f3739d Rex-BC Chen                2022-05-16   151  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   152  		opp1-124800=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   153  			opp-hz =3D=
 /bits/ 64 <1248000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   154  			opp-microv=
olt =3D <800000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   155  			required-o=
pps =3D <&opp2_04>;
95eacb24f3739d Rex-BC Chen                2022-05-16   156  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   157  		opp1-132600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   158  			opp-hz =3D=
 /bits/ 64 <1326000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   159  			opp-microv=
olt =3D <825000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   160  			required-o=
pps =3D <&opp2_05>;
95eacb24f3739d Rex-BC Chen                2022-05-16   161  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   162  		opp1-141700=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   163  			opp-hz =3D=
 /bits/ 64 <1417000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   164  			opp-microv=
olt =3D <850000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   165  			required-o=
pps =3D <&opp2_06>;
95eacb24f3739d Rex-BC Chen                2022-05-16   166  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   167  		opp1-150800=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   168  			opp-hz =3D=
 /bits/ 64 <1508000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   169  			opp-microv=
olt =3D <875000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   170  			required-o=
pps =3D <&opp2_07>;
95eacb24f3739d Rex-BC Chen                2022-05-16   171  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   172  		opp1-158600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   173  			opp-hz =3D=
 /bits/ 64 <1586000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   174  			opp-microv=
olt =3D <900000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   175  			required-o=
pps =3D <&opp2_08>;
95eacb24f3739d Rex-BC Chen                2022-05-16   176  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   177  		opp1-162500=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   178  			opp-hz =3D=
 /bits/ 64 <1625000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   179  			opp-microv=
olt =3D <912500>;
95eacb24f3739d Rex-BC Chen                2022-05-16   180  			required-o=
pps =3D <&opp2_09>;
95eacb24f3739d Rex-BC Chen                2022-05-16   181  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   182  		opp1-167700=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   183  			opp-hz =3D=
 /bits/ 64 <1677000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   184  			opp-microv=
olt =3D <931250>;
95eacb24f3739d Rex-BC Chen                2022-05-16   185  			required-o=
pps =3D <&opp2_10>;
95eacb24f3739d Rex-BC Chen                2022-05-16   186  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   187  		opp1-171600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   188  			opp-hz =3D=
 /bits/ 64 <1716000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   189  			opp-microv=
olt =3D <950000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   190  			required-o=
pps =3D <&opp2_11>;
95eacb24f3739d Rex-BC Chen                2022-05-16   191  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   192  		opp1-178100=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   193  			opp-hz =3D=
 /bits/ 64 <1781000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   194  			opp-microv=
olt =3D <975000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   195  			required-o=
pps =3D <&opp2_12>;
95eacb24f3739d Rex-BC Chen                2022-05-16   196  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   197  		opp1-184600=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   198  			opp-hz =3D=
 /bits/ 64 <1846000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   199  			opp-microv=
olt =3D <1000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   200  			required-o=
pps =3D <&opp2_13>;
95eacb24f3739d Rex-BC Chen                2022-05-16   201  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   202  		opp1-192400=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   203  			opp-hz =3D=
 /bits/ 64 <1924000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   204  			opp-microv=
olt =3D <1025000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   205  			required-o=
pps =3D <&opp2_14>;
95eacb24f3739d Rex-BC Chen                2022-05-16   206  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   207  		opp1-198900=
0000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   208  			opp-hz =3D=
 /bits/ 64 <1989000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   209  			opp-microv=
olt =3D <1050000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   210  			required-o=
pps =3D <&opp2_15>;
95eacb24f3739d Rex-BC Chen                2022-05-16   211  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   212  	};
95eacb24f3739d Rex-BC Chen                2022-05-16   213 =20
95eacb24f3739d Rex-BC Chen                2022-05-16   214  	cci_opp: opp=
-table-cci {
95eacb24f3739d Rex-BC Chen                2022-05-16   215  		compatible =
=3D "operating-points-v2";
95eacb24f3739d Rex-BC Chen                2022-05-16   216  		opp-shared;
95eacb24f3739d Rex-BC Chen                2022-05-16   217  		opp2_00: op=
p-273000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   218  			opp-hz =3D=
 /bits/ 64 <273000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   219  			opp-microv=
olt =3D <650000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   220  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   221  		opp2_01: op=
p-338000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   222  			opp-hz =3D=
 /bits/ 64 <338000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   223  			opp-microv=
olt =3D <687500>;
95eacb24f3739d Rex-BC Chen                2022-05-16   224  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   225  		opp2_02: op=
p-403000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   226  			opp-hz =3D=
 /bits/ 64 <403000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   227  			opp-microv=
olt =3D <718750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   228  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   229  		opp2_03: op=
p-463000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   230  			opp-hz =3D=
 /bits/ 64 <463000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   231  			opp-microv=
olt =3D <756250>;
95eacb24f3739d Rex-BC Chen                2022-05-16   232  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   233  		opp2_04: op=
p-546000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   234  			opp-hz =3D=
 /bits/ 64 <546000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   235  			opp-microv=
olt =3D <800000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   236  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   237  		opp2_05: op=
p-624000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   238  			opp-hz =3D=
 /bits/ 64 <624000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   239  			opp-microv=
olt =3D <818750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   240  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   241  		opp2_06: op=
p-689000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   242  			opp-hz =3D=
 /bits/ 64 <689000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   243  			opp-microv=
olt =3D <850000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   244  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   245  		opp2_07: op=
p-767000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   246  			opp-hz =3D=
 /bits/ 64 <767000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   247  			opp-microv=
olt =3D <868750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   248  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   249  		opp2_08: op=
p-845000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   250  			opp-hz =3D=
 /bits/ 64 <845000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   251  			opp-microv=
olt =3D <893750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   252  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   253  		opp2_09: op=
p-871000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   254  			opp-hz =3D=
 /bits/ 64 <871000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   255  			opp-microv=
olt =3D <906250>;
95eacb24f3739d Rex-BC Chen                2022-05-16   256  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   257  		opp2_10: op=
p-923000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   258  			opp-hz =3D=
 /bits/ 64 <923000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   259  			opp-microv=
olt =3D <931250>;
95eacb24f3739d Rex-BC Chen                2022-05-16   260  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   261  		opp2_11: op=
p-962000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   262  			opp-hz =3D=
 /bits/ 64 <962000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   263  			opp-microv=
olt =3D <943750>;
95eacb24f3739d Rex-BC Chen                2022-05-16   264  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   265  		opp2_12: op=
p-1027000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   266  			opp-hz =3D=
 /bits/ 64 <1027000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   267  			opp-microv=
olt =3D <975000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   268  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   269  		opp2_13: op=
p-1092000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   270  			opp-hz =3D=
 /bits/ 64 <1092000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   271  			opp-microv=
olt =3D <1000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   272  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   273  		opp2_14: op=
p-1144000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   274  			opp-hz =3D=
 /bits/ 64 <1144000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   275  			opp-microv=
olt =3D <1025000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   276  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   277  		opp2_15: op=
p-1196000000 {
95eacb24f3739d Rex-BC Chen                2022-05-16   278  			opp-hz =3D=
 /bits/ 64 <1196000000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   279  			opp-microv=
olt =3D <1050000>;
95eacb24f3739d Rex-BC Chen                2022-05-16   280  		};
95eacb24f3739d Rex-BC Chen                2022-05-16   281  	};
95eacb24f3739d Rex-BC Chen                2022-05-16   282 =20
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   283  	cci: cci {
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   284  		compatible =
=3D "mediatek,mt8183-cci";
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   285  		clocks =3D =
<&mcucfg CLK_MCU_BUS_SEL>,
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   286  			 <&topckge=
n CLK_TOP_ARMPLL_DIV_PLL1>;
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   287  		clock-names=
 =3D "cci", "intermediate";
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   288  		operating-p=
oints-v2 =3D <&cci_opp>;
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   289  	};
f3ceebeb0c9bf2 Rex-BC Chen                2022-05-16   290 =20
e526c9bc11f858 Ben Ho                     2019-05-27   291  	cpus {
e526c9bc11f858 Ben Ho                     2019-05-27   292  		#address-ce=
lls =3D <1>;
e526c9bc11f858 Ben Ho                     2019-05-27   293  		#size-cells=
 =3D <0>;
e526c9bc11f858 Ben Ho                     2019-05-27   294 =20
e526c9bc11f858 Ben Ho                     2019-05-27   295  		cpu-map {
e526c9bc11f858 Ben Ho                     2019-05-27   296  			cluster0 {
e526c9bc11f858 Ben Ho                     2019-05-27   297  				core0 {
e526c9bc11f858 Ben Ho                     2019-05-27   298  					cpu =3D =
<&cpu0>;
e526c9bc11f858 Ben Ho                     2019-05-27   299  				};
e526c9bc11f858 Ben Ho                     2019-05-27   300  				core1 {
e526c9bc11f858 Ben Ho                     2019-05-27   301  					cpu =3D =
<&cpu1>;
e526c9bc11f858 Ben Ho                     2019-05-27   302  				};
e526c9bc11f858 Ben Ho                     2019-05-27   303  				core2 {
e526c9bc11f858 Ben Ho                     2019-05-27   304  					cpu =3D =
<&cpu2>;
e526c9bc11f858 Ben Ho                     2019-05-27   305  				};
e526c9bc11f858 Ben Ho                     2019-05-27   306  				core3 {
e526c9bc11f858 Ben Ho                     2019-05-27   307  					cpu =3D =
<&cpu3>;
e526c9bc11f858 Ben Ho                     2019-05-27   308  				};
e526c9bc11f858 Ben Ho                     2019-05-27   309  			};
e526c9bc11f858 Ben Ho                     2019-05-27   310 =20
e526c9bc11f858 Ben Ho                     2019-05-27   311  			cluster1 {
e526c9bc11f858 Ben Ho                     2019-05-27   312  				core0 {
e526c9bc11f858 Ben Ho                     2019-05-27   313  					cpu =3D =
<&cpu4>;
e526c9bc11f858 Ben Ho                     2019-05-27   314  				};
e526c9bc11f858 Ben Ho                     2019-05-27   315  				core1 {
e526c9bc11f858 Ben Ho                     2019-05-27   316  					cpu =3D =
<&cpu5>;
e526c9bc11f858 Ben Ho                     2019-05-27   317  				};
e526c9bc11f858 Ben Ho                     2019-05-27   318  				core2 {
e526c9bc11f858 Ben Ho                     2019-05-27   319  					cpu =3D =
<&cpu6>;
e526c9bc11f858 Ben Ho                     2019-05-27   320  				};
e526c9bc11f858 Ben Ho                     2019-05-27   321  				core3 {
e526c9bc11f858 Ben Ho                     2019-05-27   322  					cpu =3D =
<&cpu7>;
e526c9bc11f858 Ben Ho                     2019-05-27   323  				};
e526c9bc11f858 Ben Ho                     2019-05-27   324  			};
e526c9bc11f858 Ben Ho                     2019-05-27   325  		};
e526c9bc11f858 Ben Ho                     2019-05-27   326 =20
e526c9bc11f858 Ben Ho                     2019-05-27   327  		cpu0: cpu@0=
 {
e526c9bc11f858 Ben Ho                     2019-05-27   328  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   329  			compatible=
 =3D "arm,cortex-a53";
e526c9bc11f858 Ben Ho                     2019-05-27   330  			reg =3D <0=
x000>;
e526c9bc11f858 Ben Ho                     2019-05-27   331  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   332  			capacity-d=
mips-mhz =3D <741>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   333  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
95eacb24f3739d Rex-BC Chen                2022-05-16   334  			clocks =3D=
 <&mcucfg CLK_MCU_MP0_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   335  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   336  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   337  			operating-=
points-v2 =3D <&cluster0_opp>;
cc10317db0d5dc michael.kao                2020-01-03   338  			dynamic-po=
wer-coefficient =3D <84>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   339  			i-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   340  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   341  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   342  			d-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   343  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   344  			d-cache-se=
ts =3D <128>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   345  			next-level=
-cache =3D <&l2_0>;
5323e0fa9394d3 michael.kao                2020-01-03   346  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   347  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   348  		};
e526c9bc11f858 Ben Ho                     2019-05-27   349 =20
e526c9bc11f858 Ben Ho                     2019-05-27   350  		cpu1: cpu@1=
 {
e526c9bc11f858 Ben Ho                     2019-05-27   351  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   352  			compatible=
 =3D "arm,cortex-a53";
e526c9bc11f858 Ben Ho                     2019-05-27   353  			reg =3D <0=
x001>;
e526c9bc11f858 Ben Ho                     2019-05-27   354  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   355  			capacity-d=
mips-mhz =3D <741>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   356  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
95eacb24f3739d Rex-BC Chen                2022-05-16   357  			clocks =3D=
 <&mcucfg CLK_MCU_MP0_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   358  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   359  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   360  			operating-=
points-v2 =3D <&cluster0_opp>;
cc10317db0d5dc michael.kao                2020-01-03   361  			dynamic-po=
wer-coefficient =3D <84>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   362  			i-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   363  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   364  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   365  			d-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   366  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   367  			d-cache-se=
ts =3D <128>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   368  			next-level=
-cache =3D <&l2_0>;
5323e0fa9394d3 michael.kao                2020-01-03   369  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   370  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   371  		};
e526c9bc11f858 Ben Ho                     2019-05-27   372 =20
e526c9bc11f858 Ben Ho                     2019-05-27   373  		cpu2: cpu@2=
 {
e526c9bc11f858 Ben Ho                     2019-05-27   374  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   375  			compatible=
 =3D "arm,cortex-a53";
e526c9bc11f858 Ben Ho                     2019-05-27   376  			reg =3D <0=
x002>;
e526c9bc11f858 Ben Ho                     2019-05-27   377  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   378  			capacity-d=
mips-mhz =3D <741>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   379  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
95eacb24f3739d Rex-BC Chen                2022-05-16   380  			clocks =3D=
 <&mcucfg CLK_MCU_MP0_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   381  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   382  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   383  			operating-=
points-v2 =3D <&cluster0_opp>;
cc10317db0d5dc michael.kao                2020-01-03   384  			dynamic-po=
wer-coefficient =3D <84>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   385  			i-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   386  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   387  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   388  			d-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   389  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   390  			d-cache-se=
ts =3D <128>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   391  			next-level=
-cache =3D <&l2_0>;
5323e0fa9394d3 michael.kao                2020-01-03   392  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   393  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   394  		};
e526c9bc11f858 Ben Ho                     2019-05-27   395 =20
e526c9bc11f858 Ben Ho                     2019-05-27   396  		cpu3: cpu@3=
 {
e526c9bc11f858 Ben Ho                     2019-05-27   397  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   398  			compatible=
 =3D "arm,cortex-a53";
e526c9bc11f858 Ben Ho                     2019-05-27   399  			reg =3D <0=
x003>;
e526c9bc11f858 Ben Ho                     2019-05-27   400  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   401  			capacity-d=
mips-mhz =3D <741>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   402  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
95eacb24f3739d Rex-BC Chen                2022-05-16   403  			clocks =3D=
 <&mcucfg CLK_MCU_MP0_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   404  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   405  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   406  			operating-=
points-v2 =3D <&cluster0_opp>;
cc10317db0d5dc michael.kao                2020-01-03   407  			dynamic-po=
wer-coefficient =3D <84>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   408  			i-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   409  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   410  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   411  			d-cache-si=
ze =3D <32768>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   412  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   413  			d-cache-se=
ts =3D <128>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   414  			next-level=
-cache =3D <&l2_0>;
5323e0fa9394d3 michael.kao                2020-01-03   415  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   416  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   417  		};
e526c9bc11f858 Ben Ho                     2019-05-27   418 =20
e526c9bc11f858 Ben Ho                     2019-05-27   419  		cpu4: cpu@1=
00 {
e526c9bc11f858 Ben Ho                     2019-05-27   420  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   421  			compatible=
 =3D "arm,cortex-a73";
e526c9bc11f858 Ben Ho                     2019-05-27   422  			reg =3D <0=
x100>;
e526c9bc11f858 Ben Ho                     2019-05-27   423  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   424  			capacity-d=
mips-mhz =3D <1024>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   425  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   426  			clocks =3D=
 <&mcucfg CLK_MCU_MP2_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   427  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   428  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   429  			operating-=
points-v2 =3D <&cluster1_opp>;
cc10317db0d5dc michael.kao                2020-01-03   430  			dynamic-po=
wer-coefficient =3D <211>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   431  			i-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   432  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   433  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   434  			d-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   435  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   436  			d-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   437  			next-level=
-cache =3D <&l2_1>;
5323e0fa9394d3 michael.kao                2020-01-03   438  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   439  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   440  		};
e526c9bc11f858 Ben Ho                     2019-05-27   441 =20
e526c9bc11f858 Ben Ho                     2019-05-27   442  		cpu5: cpu@1=
01 {
e526c9bc11f858 Ben Ho                     2019-05-27   443  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   444  			compatible=
 =3D "arm,cortex-a73";
e526c9bc11f858 Ben Ho                     2019-05-27   445  			reg =3D <0=
x101>;
e526c9bc11f858 Ben Ho                     2019-05-27   446  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   447  			capacity-d=
mips-mhz =3D <1024>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   448  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   449  			clocks =3D=
 <&mcucfg CLK_MCU_MP2_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   450  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   451  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   452  			operating-=
points-v2 =3D <&cluster1_opp>;
cc10317db0d5dc michael.kao                2020-01-03   453  			dynamic-po=
wer-coefficient =3D <211>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   454  			i-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   455  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   456  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   457  			d-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   458  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   459  			d-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   460  			next-level=
-cache =3D <&l2_1>;
5323e0fa9394d3 michael.kao                2020-01-03   461  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   462  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   463  		};
e526c9bc11f858 Ben Ho                     2019-05-27   464 =20
e526c9bc11f858 Ben Ho                     2019-05-27   465  		cpu6: cpu@1=
02 {
e526c9bc11f858 Ben Ho                     2019-05-27   466  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   467  			compatible=
 =3D "arm,cortex-a73";
e526c9bc11f858 Ben Ho                     2019-05-27   468  			reg =3D <0=
x102>;
e526c9bc11f858 Ben Ho                     2019-05-27   469  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   470  			capacity-d=
mips-mhz =3D <1024>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   471  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   472  			clocks =3D=
 <&mcucfg CLK_MCU_MP2_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   473  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   474  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   475  			operating-=
points-v2 =3D <&cluster1_opp>;
cc10317db0d5dc michael.kao                2020-01-03   476  			dynamic-po=
wer-coefficient =3D <211>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   477  			i-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   478  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   479  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   480  			d-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   481  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   482  			d-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   483  			next-level=
-cache =3D <&l2_1>;
5323e0fa9394d3 michael.kao                2020-01-03   484  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   485  			mediatek,c=
ci =3D <&cci>;
e526c9bc11f858 Ben Ho                     2019-05-27   486  		};
e526c9bc11f858 Ben Ho                     2019-05-27   487 =20
e526c9bc11f858 Ben Ho                     2019-05-27   488  		cpu7: cpu@1=
03 {
e526c9bc11f858 Ben Ho                     2019-05-27   489  			device_typ=
e =3D "cpu";
e526c9bc11f858 Ben Ho                     2019-05-27   490  			compatible=
 =3D "arm,cortex-a73";
e526c9bc11f858 Ben Ho                     2019-05-27   491  			reg =3D <0=
x103>;
e526c9bc11f858 Ben Ho                     2019-05-27   492  			enable-met=
hod =3D "psci";
cc216dfd5615f9 Hsin-Yi, Wang              2019-05-27   493  			capacity-d=
mips-mhz =3D <1024>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   494  			cpu-idle-s=
tates =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   495  			clocks =3D=
 <&mcucfg CLK_MCU_MP2_SEL>,
95eacb24f3739d Rex-BC Chen                2022-05-16   496  				 <&topckg=
en CLK_TOP_ARMPLL_DIV_PLL1>;
95eacb24f3739d Rex-BC Chen                2022-05-16   497  			clock-name=
s =3D "cpu", "intermediate";
95eacb24f3739d Rex-BC Chen                2022-05-16   498  			operating-=
points-v2 =3D <&cluster1_opp>;
cc10317db0d5dc michael.kao                2020-01-03   499  			dynamic-po=
wer-coefficient =3D <211>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   500  			i-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   501  			i-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   502  			i-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   503  			d-cache-si=
ze =3D <65536>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   504  			d-cache-li=
ne-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   505  			d-cache-se=
ts =3D <256>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   506  			next-level=
-cache =3D <&l2_1>;
5323e0fa9394d3 michael.kao                2020-01-03   507  			#cooling-c=
ells =3D <2>;
68163cd12ca5d8 Rex-BC Chen                2022-05-16   508  			mediatek,c=
ci =3D <&cci>;
6be021b1f00d11 James Liao                 2020-01-15   509  		};
6be021b1f00d11 James Liao                 2020-01-15   510 =20
6be021b1f00d11 James Liao                 2020-01-15   511  		idle-states=
 {
6be021b1f00d11 James Liao                 2020-01-15   512  			entry-meth=
od =3D "psci";
6be021b1f00d11 James Liao                 2020-01-15   513 =20
6be021b1f00d11 James Liao                 2020-01-15   514  			CPU_SLEEP:=
 cpu-sleep {
6be021b1f00d11 James Liao                 2020-01-15   515  				compatibl=
e =3D "arm,idle-state";
6be021b1f00d11 James Liao                 2020-01-15   516  				local-tim=
er-stop;
6be021b1f00d11 James Liao                 2020-01-15   517  				arm,psci-=
suspend-param =3D <0x00010001>;
6be021b1f00d11 James Liao                 2020-01-15   518  				entry-lat=
ency-us =3D <200>;
6be021b1f00d11 James Liao                 2020-01-15   519  				exit-late=
ncy-us =3D <200>;
6be021b1f00d11 James Liao                 2020-01-15   520  				min-resid=
ency-us =3D <800>;
6be021b1f00d11 James Liao                 2020-01-15   521  			};
6be021b1f00d11 James Liao                 2020-01-15   522 =20
2a7abd3efbe317 Enric Balletbo i Serra     2020-06-25   523  			CLUSTER_SL=
EEP0: cluster-sleep-0 {
6b55297581eaf4 Ikjoon Jang                2020-02-25   524  				compatibl=
e =3D "arm,idle-state";
6b55297581eaf4 Ikjoon Jang                2020-02-25   525  				local-tim=
er-stop;
6b55297581eaf4 Ikjoon Jang                2020-02-25   526  				arm,psci-=
suspend-param =3D <0x01010001>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   527  				entry-lat=
ency-us =3D <250>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   528  				exit-late=
ncy-us =3D <400>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   529  				min-resid=
ency-us =3D <1000>;
6b55297581eaf4 Ikjoon Jang                2020-02-25   530  			};
2a7abd3efbe317 Enric Balletbo i Serra     2020-06-25   531  			CLUSTER_SL=
EEP1: cluster-sleep-1 {
6be021b1f00d11 James Liao                 2020-01-15   532  				compatibl=
e =3D "arm,idle-state";
6be021b1f00d11 James Liao                 2020-01-15   533  				local-tim=
er-stop;
6be021b1f00d11 James Liao                 2020-01-15   534  				arm,psci-=
suspend-param =3D <0x01010001>;
6be021b1f00d11 James Liao                 2020-01-15   535  				entry-lat=
ency-us =3D <250>;
6be021b1f00d11 James Liao                 2020-01-15   536  				exit-late=
ncy-us =3D <400>;
6be021b1f00d11 James Liao                 2020-01-15   537  				min-resid=
ency-us =3D <1300>;
6be021b1f00d11 James Liao                 2020-01-15   538  			};
e526c9bc11f858 Ben Ho                     2019-05-27   539  		};
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   540 =20
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   541  		l2_0: l2-ca=
che0 {
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   542  			compatible=
 =3D "cache";
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   543  			cache-leve=
l =3D <2>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   544  			cache-size=
 =3D <1048576>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   545  			cache-line=
-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   546  			cache-sets=
 =3D <1024>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   547  			cache-unif=
ied;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   548  		};
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   549 =20
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   550  		l2_1: l2-ca=
che1 {
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   551  			compatible=
 =3D "cache";
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   552  			cache-leve=
l =3D <2>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   553  			cache-size=
 =3D <1048576>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   554  			cache-line=
-size =3D <64>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   555  			cache-sets=
 =3D <1024>;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   556  			cache-unif=
ied;
34a39d4764849c AngeloGioacchino Del Regno 2022-12-06   557  		};
e526c9bc11f858 Ben Ho                     2019-05-27   558  	};
e526c9bc11f858 Ben Ho                     2019-05-27   559 =20
6f117db4123931 Krzysztof Kozlowski        2022-04-19   560  	gpu_opp_tabl=
e: opp-table-0 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   561  		compatible =
=3D "operating-points-v2";
a8168cebf1bca1 Nicolas Boichat            2021-05-21   562  		opp-shared;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   563 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   564  		opp-3000000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   565  			opp-hz =3D=
 /bits/ 64 <300000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   566  			opp-microv=
olt =3D <625000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   567  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   568 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   569  		opp-3200000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   570  			opp-hz =3D=
 /bits/ 64 <320000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   571  			opp-microv=
olt =3D <631250>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   572  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   573 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   574  		opp-3400000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   575  			opp-hz =3D=
 /bits/ 64 <340000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   576  			opp-microv=
olt =3D <637500>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   577  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   578 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   579  		opp-3600000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   580  			opp-hz =3D=
 /bits/ 64 <360000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   581  			opp-microv=
olt =3D <643750>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   582  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   583 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   584  		opp-3800000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   585  			opp-hz =3D=
 /bits/ 64 <380000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   586  			opp-microv=
olt =3D <650000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   587  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   588 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   589  		opp-4000000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   590  			opp-hz =3D=
 /bits/ 64 <400000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   591  			opp-microv=
olt =3D <656250>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   592  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   593 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   594  		opp-4200000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   595  			opp-hz =3D=
 /bits/ 64 <420000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   596  			opp-microv=
olt =3D <662500>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   597  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   598 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   599  		opp-4600000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   600  			opp-hz =3D=
 /bits/ 64 <460000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   601  			opp-microv=
olt =3D <675000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   602  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   603 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   604  		opp-5000000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   605  			opp-hz =3D=
 /bits/ 64 <500000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   606  			opp-microv=
olt =3D <687500>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   607  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   608 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   609  		opp-5400000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   610  			opp-hz =3D=
 /bits/ 64 <540000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   611  			opp-microv=
olt =3D <700000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   612  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   613 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   614  		opp-5800000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   615  			opp-hz =3D=
 /bits/ 64 <580000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   616  			opp-microv=
olt =3D <712500>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   617  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   618 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   619  		opp-6200000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   620  			opp-hz =3D=
 /bits/ 64 <620000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   621  			opp-microv=
olt =3D <725000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   622  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   623 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   624  		opp-6530000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   625  			opp-hz =3D=
 /bits/ 64 <653000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   626  			opp-microv=
olt =3D <743750>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   627  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   628 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   629  		opp-6980000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   630  			opp-hz =3D=
 /bits/ 64 <698000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   631  			opp-microv=
olt =3D <768750>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   632  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   633 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   634  		opp-7430000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   635  			opp-hz =3D=
 /bits/ 64 <743000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   636  			opp-microv=
olt =3D <793750>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   637  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   638 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21   639  		opp-8000000=
00 {
a8168cebf1bca1 Nicolas Boichat            2021-05-21   640  			opp-hz =3D=
 /bits/ 64 <800000000>;
dbe602b27793af AngeloGioacchino Del Regno 2023-03-01   641  			opp-microv=
olt =3D <825000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21   642  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   643  	};
a8168cebf1bca1 Nicolas Boichat            2021-05-21   644 =20
e526c9bc11f858 Ben Ho                     2019-05-27   645  	pmu-a53 {
e526c9bc11f858 Ben Ho                     2019-05-27   646  		compatible =
=3D "arm,cortex-a53-pmu";
e526c9bc11f858 Ben Ho                     2019-05-27   647  		interrupt-p=
arent =3D <&gic>;
e526c9bc11f858 Ben Ho                     2019-05-27   648  		interrupts =
=3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
e526c9bc11f858 Ben Ho                     2019-05-27   649  	};
e526c9bc11f858 Ben Ho                     2019-05-27   650 =20
e526c9bc11f858 Ben Ho                     2019-05-27   651  	pmu-a73 {
e526c9bc11f858 Ben Ho                     2019-05-27   652  		compatible =
=3D "arm,cortex-a73-pmu";
e526c9bc11f858 Ben Ho                     2019-05-27   653  		interrupt-p=
arent =3D <&gic>;
e526c9bc11f858 Ben Ho                     2019-05-27   654  		interrupts =
=3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
e526c9bc11f858 Ben Ho                     2019-05-27   655  	};
e526c9bc11f858 Ben Ho                     2019-05-27   656 =20
e526c9bc11f858 Ben Ho                     2019-05-27   657  	psci {
e526c9bc11f858 Ben Ho                     2019-05-27   658  		compatible =
=3D "arm,psci-1.0";
e526c9bc11f858 Ben Ho                     2019-05-27   659  		method =3D =
"smc";
e526c9bc11f858 Ben Ho                     2019-05-27   660  	};
e526c9bc11f858 Ben Ho                     2019-05-27   661 =20
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   662  	clk13m: fixe=
d-factor-clock-13m {
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   663  		compatible =
=3D "fixed-factor-clock";
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   664  		#clock-cell=
s =3D <0>;
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   665  		clocks =3D =
<&clk26m>;
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   666  		clock-div =3D=
 <2>;
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   667  		clock-mult =
=3D <1>;
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   668  		clock-outpu=
t-names =3D "clk13m";
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   669  	};
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01   670 =20
e526c9bc11f858 Ben Ho                     2019-05-27   671  	clk26m: osci=
llator {
e526c9bc11f858 Ben Ho                     2019-05-27   672  		compatible =
=3D "fixed-clock";
e526c9bc11f858 Ben Ho                     2019-05-27   673  		#clock-cell=
s =3D <0>;
e526c9bc11f858 Ben Ho                     2019-05-27   674  		clock-frequ=
ency =3D <26000000>;
e526c9bc11f858 Ben Ho                     2019-05-27   675  		clock-outpu=
t-names =3D "clk26m";
e526c9bc11f858 Ben Ho                     2019-05-27   676  	};
e526c9bc11f858 Ben Ho                     2019-05-27   677 =20
e526c9bc11f858 Ben Ho                     2019-05-27   678  	timer {
e526c9bc11f858 Ben Ho                     2019-05-27   679  		compatible =
=3D "arm,armv8-timer";
e526c9bc11f858 Ben Ho                     2019-05-27   680  		interrupt-p=
arent =3D <&gic>;
e526c9bc11f858 Ben Ho                     2019-05-27   681  		interrupts =
=3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
e526c9bc11f858 Ben Ho                     2019-05-27   682  			     <GIC_=
PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
e526c9bc11f858 Ben Ho                     2019-05-27   683  			     <GIC_=
PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
e526c9bc11f858 Ben Ho                     2019-05-27   684  			     <GIC_=
PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
e526c9bc11f858 Ben Ho                     2019-05-27   685  	};
e526c9bc11f858 Ben Ho                     2019-05-27   686 =20
e526c9bc11f858 Ben Ho                     2019-05-27   687  	soc {
e526c9bc11f858 Ben Ho                     2019-05-27   688  		#address-ce=
lls =3D <2>;
e526c9bc11f858 Ben Ho                     2019-05-27   689  		#size-cells=
 =3D <2>;
e526c9bc11f858 Ben Ho                     2019-05-27   690  		compatible =
=3D "simple-bus";
e526c9bc11f858 Ben Ho                     2019-05-27   691  		ranges;
e526c9bc11f858 Ben Ho                     2019-05-27   692 =20
2208b284bee05d Chunfeng Yun               2022-06-17   693  		soc_data: e=
fuse@8000000 {
de1033881e9363 Michael Mei                2019-05-27   694  			compatible=
 =3D "mediatek,mt8183-efuse",
de1033881e9363 Michael Mei                2019-05-27   695  				     "med=
iatek,efuse";
de1033881e9363 Michael Mei                2019-05-27   696  			reg =3D <0=
 0x08000000 0 0x0010>;
de1033881e9363 Michael Mei                2019-05-27   697  			#address-c=
ells =3D <1>;
de1033881e9363 Michael Mei                2019-05-27   698  			#size-cell=
s =3D <1>;
de1033881e9363 Michael Mei                2019-05-27   699  			status =3D=
 "disabled";
de1033881e9363 Michael Mei                2019-05-27   700  		};
de1033881e9363 Michael Mei                2019-05-27   701 =20
e526c9bc11f858 Ben Ho                     2019-05-27   702  		gic: interr=
upt-controller@c000000 {
e526c9bc11f858 Ben Ho                     2019-05-27   703  			compatible=
 =3D "arm,gic-v3";
e526c9bc11f858 Ben Ho                     2019-05-27   704  			#interrupt=
-cells =3D <4>;
e526c9bc11f858 Ben Ho                     2019-05-27   705  			interrupt-=
parent =3D <&gic>;
e526c9bc11f858 Ben Ho                     2019-05-27   706  			interrupt-=
controller;
e526c9bc11f858 Ben Ho                     2019-05-27   707  			reg =3D <0=
 0x0c000000 0 0x40000>,  /* GICD */
e526c9bc11f858 Ben Ho                     2019-05-27   708  			      <0 0=
x0c100000 0 0x200000>, /* GICR */
e526c9bc11f858 Ben Ho                     2019-05-27   709  			      <0 0=
x0c400000 0 0x2000>,   /* GICC */
e526c9bc11f858 Ben Ho                     2019-05-27   710  			      <0 0=
x0c410000 0 0x1000>,   /* GICH */
e526c9bc11f858 Ben Ho                     2019-05-27   711  			      <0 0=
x0c420000 0 0x2000>;   /* GICV */
e526c9bc11f858 Ben Ho                     2019-05-27   712 =20
e526c9bc11f858 Ben Ho                     2019-05-27   713  			interrupts=
 =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
e526c9bc11f858 Ben Ho                     2019-05-27   714  			ppi-partit=
ions {
e526c9bc11f858 Ben Ho                     2019-05-27   715  				ppi_clust=
er0: interrupt-partition-0 {
e526c9bc11f858 Ben Ho                     2019-05-27   716  					affinity=
 =3D <&cpu0 &cpu1 &cpu2 &cpu3>;
e526c9bc11f858 Ben Ho                     2019-05-27   717  				};
e526c9bc11f858 Ben Ho                     2019-05-27   718  				ppi_clust=
er1: interrupt-partition-1 {
e526c9bc11f858 Ben Ho                     2019-05-27   719  					affinity=
 =3D <&cpu4 &cpu5 &cpu6 &cpu7>;
e526c9bc11f858 Ben Ho                     2019-05-27   720  				};
e526c9bc11f858 Ben Ho                     2019-05-27   721  			};
e526c9bc11f858 Ben Ho                     2019-05-27   722  		};
e526c9bc11f858 Ben Ho                     2019-05-27   723 =20
e526c9bc11f858 Ben Ho                     2019-05-27   724  		mcucfg: sys=
con@c530000 {
e526c9bc11f858 Ben Ho                     2019-05-27   725  			compatible=
 =3D "mediatek,mt8183-mcucfg", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27   726  			reg =3D <0=
 0x0c530000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27   727  			#clock-cel=
ls =3D <1>;
e526c9bc11f858 Ben Ho                     2019-05-27   728  		};
e526c9bc11f858 Ben Ho                     2019-05-27   729 =20
e526c9bc11f858 Ben Ho                     2019-05-27   730  		sysirq: int=
errupt-controller@c530a80 {
e526c9bc11f858 Ben Ho                     2019-05-27   731  			compatible=
 =3D "mediatek,mt8183-sysirq",
e526c9bc11f858 Ben Ho                     2019-05-27   732  				     "med=
iatek,mt6577-sysirq";
e526c9bc11f858 Ben Ho                     2019-05-27   733  			interrupt-=
controller;
e526c9bc11f858 Ben Ho                     2019-05-27   734  			#interrupt=
-cells =3D <3>;
e526c9bc11f858 Ben Ho                     2019-05-27   735  			interrupt-=
parent =3D <&gic>;
e526c9bc11f858 Ben Ho                     2019-05-27   736  			reg =3D <0=
 0x0c530a80 0 0x50>;
e526c9bc11f858 Ben Ho                     2019-05-27   737  		};
e526c9bc11f858 Ben Ho                     2019-05-27   738 =20
7781083fd609f8 Seiya Wang                 2021-11-02   739  		cpu_debug0:=
 cpu-debug@d410000 {
7781083fd609f8 Seiya Wang                 2021-11-02   740  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   741  			reg =3D <0=
x0 0xd410000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   742  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   743  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   744  			cpu =3D <&=
cpu0>;
7781083fd609f8 Seiya Wang                 2021-11-02   745  		};
7781083fd609f8 Seiya Wang                 2021-11-02   746 =20
7781083fd609f8 Seiya Wang                 2021-11-02   747  		cpu_debug1:=
 cpu-debug@d510000 {
7781083fd609f8 Seiya Wang                 2021-11-02   748  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   749  			reg =3D <0=
x0 0xd510000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   750  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   751  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   752  			cpu =3D <&=
cpu1>;
7781083fd609f8 Seiya Wang                 2021-11-02   753  		};
7781083fd609f8 Seiya Wang                 2021-11-02   754 =20
7781083fd609f8 Seiya Wang                 2021-11-02   755  		cpu_debug2:=
 cpu-debug@d610000 {
7781083fd609f8 Seiya Wang                 2021-11-02   756  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   757  			reg =3D <0=
x0 0xd610000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   758  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   759  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   760  			cpu =3D <&=
cpu2>;
7781083fd609f8 Seiya Wang                 2021-11-02   761  		};
7781083fd609f8 Seiya Wang                 2021-11-02   762 =20
7781083fd609f8 Seiya Wang                 2021-11-02   763  		cpu_debug3:=
 cpu-debug@d710000 {
7781083fd609f8 Seiya Wang                 2021-11-02   764  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   765  			reg =3D <0=
x0 0xd710000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   766  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   767  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   768  			cpu =3D <&=
cpu3>;
7781083fd609f8 Seiya Wang                 2021-11-02   769  		};
7781083fd609f8 Seiya Wang                 2021-11-02   770 =20
7781083fd609f8 Seiya Wang                 2021-11-02   771  		cpu_debug4:=
 cpu-debug@d810000 {
7781083fd609f8 Seiya Wang                 2021-11-02   772  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   773  			reg =3D <0=
x0 0xd810000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   774  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   775  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   776  			cpu =3D <&=
cpu4>;
7781083fd609f8 Seiya Wang                 2021-11-02   777  		};
7781083fd609f8 Seiya Wang                 2021-11-02   778 =20
7781083fd609f8 Seiya Wang                 2021-11-02   779  		cpu_debug5:=
 cpu-debug@d910000 {
7781083fd609f8 Seiya Wang                 2021-11-02   780  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   781  			reg =3D <0=
x0 0xd910000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   782  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   783  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   784  			cpu =3D <&=
cpu5>;
7781083fd609f8 Seiya Wang                 2021-11-02   785  		};
7781083fd609f8 Seiya Wang                 2021-11-02   786 =20
7781083fd609f8 Seiya Wang                 2021-11-02   787  		cpu_debug6:=
 cpu-debug@da10000 {
7781083fd609f8 Seiya Wang                 2021-11-02   788  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   789  			reg =3D <0=
x0 0xda10000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   790  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   791  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   792  			cpu =3D <&=
cpu6>;
7781083fd609f8 Seiya Wang                 2021-11-02   793  		};
7781083fd609f8 Seiya Wang                 2021-11-02   794 =20
7781083fd609f8 Seiya Wang                 2021-11-02   795  		cpu_debug7:=
 cpu-debug@db10000 {
7781083fd609f8 Seiya Wang                 2021-11-02   796  			compatible=
 =3D "arm,coresight-cpu-debug", "arm,primecell";
7781083fd609f8 Seiya Wang                 2021-11-02   797  			reg =3D <0=
x0 0xdb10000 0x0 0x1000>;
7781083fd609f8 Seiya Wang                 2021-11-02   798  			clocks =3D=
 <&infracfg CLK_INFRA_DEBUGSYS>;
7781083fd609f8 Seiya Wang                 2021-11-02   799  			clock-name=
s =3D "apb_pclk";
7781083fd609f8 Seiya Wang                 2021-11-02   800  			cpu =3D <&=
cpu7>;
7781083fd609f8 Seiya Wang                 2021-11-02   801  		};
7781083fd609f8 Seiya Wang                 2021-11-02   802 =20
e526c9bc11f858 Ben Ho                     2019-05-27   803  		topckgen: s=
yscon@10000000 {
e526c9bc11f858 Ben Ho                     2019-05-27   804  			compatible=
 =3D "mediatek,mt8183-topckgen", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27   805  			reg =3D <0=
 0x10000000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27   806  			#clock-cel=
ls =3D <1>;
e526c9bc11f858 Ben Ho                     2019-05-27   807  		};
e526c9bc11f858 Ben Ho                     2019-05-27   808 =20
e526c9bc11f858 Ben Ho                     2019-05-27   809  		infracfg: s=
yscon@10001000 {
e526c9bc11f858 Ben Ho                     2019-05-27   810  			compatible=
 =3D "mediatek,mt8183-infracfg", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27   811  			reg =3D <0=
 0x10001000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27   812  			#clock-cel=
ls =3D <1>;
a845ad16212e32 yong.liang                 2019-12-26   813  			#reset-cel=
ls =3D <1>;
e526c9bc11f858 Ben Ho                     2019-05-27   814  		};
e526c9bc11f858 Ben Ho                     2019-05-27   815 =20
72704ac62334bd Enric Balletbo i Serra     2020-06-25   816  		pericfg: sy=
scon@10003000 {
72704ac62334bd Enric Balletbo i Serra     2020-06-25   817  			compatible=
 =3D "mediatek,mt8183-pericfg", "syscon";
72704ac62334bd Enric Balletbo i Serra     2020-06-25   818  			reg =3D <0=
 0x10003000 0 0x1000>;
72704ac62334bd Enric Balletbo i Serra     2020-06-25   819  			#clock-cel=
ls =3D <1>;
72704ac62334bd Enric Balletbo i Serra     2020-06-25   820  		};
72704ac62334bd Enric Balletbo i Serra     2020-06-25   821 =20
da719a3567a31a Zhiyong Tao                2019-05-27   822  		pio: pinctr=
l@10005000 {
da719a3567a31a Zhiyong Tao                2019-05-27   823  			compatible=
 =3D "mediatek,mt8183-pinctrl";
da719a3567a31a Zhiyong Tao                2019-05-27   824  			reg =3D <0=
 0x10005000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   825  			      <0 0=
x11f20000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   826  			      <0 0=
x11e80000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   827  			      <0 0=
x11e70000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   828  			      <0 0=
x11e90000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   829  			      <0 0=
x11d30000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   830  			      <0 0=
x11d20000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   831  			      <0 0=
x11c50000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   832  			      <0 0=
x11f30000 0 0x1000>,
da719a3567a31a Zhiyong Tao                2019-05-27   833  			      <0 0=
x1000b000 0 0x1000>;
da719a3567a31a Zhiyong Tao                2019-05-27   834  			reg-names =
=3D "iocfg0", "iocfg1", "iocfg2",
da719a3567a31a Zhiyong Tao                2019-05-27   835  				    "iocf=
g3", "iocfg4", "iocfg5",
da719a3567a31a Zhiyong Tao                2019-05-27   836  				    "iocf=
g6", "iocfg7", "iocfg8",
da719a3567a31a Zhiyong Tao                2019-05-27   837  				    "eint=
";
da719a3567a31a Zhiyong Tao                2019-05-27   838  			gpio-contr=
oller;
da719a3567a31a Zhiyong Tao                2019-05-27   839  			#gpio-cell=
s =3D <2>;
da719a3567a31a Zhiyong Tao                2019-05-27   840  			gpio-range=
s =3D <&pio 0 0 192>;
da719a3567a31a Zhiyong Tao                2019-05-27   841  			interrupt-=
controller;
da719a3567a31a Zhiyong Tao                2019-05-27   842  			interrupts=
 =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
da719a3567a31a Zhiyong Tao                2019-05-27   843  			#interrupt=
-cells =3D <2>;
da719a3567a31a Zhiyong Tao                2019-05-27   844  		};
da719a3567a31a Zhiyong Tao                2019-05-27   845 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   846  		scpsys: sys=
con@10006000 {
d3dfd468857479 Tinghan Shen               2022-08-11   847  			compatible=
 =3D "mediatek,mt8183-scpsys", "syscon", "simple-mfd";
37fb78b9aeb75d Matthias Brugger           2020-10-30   848  			reg =3D <0=
 0x10006000 0 0x1000>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   849 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   850  			/* System =
Power Manager */
37fb78b9aeb75d Matthias Brugger           2020-10-30   851  			spm: power=
-controller {
37fb78b9aeb75d Matthias Brugger           2020-10-30   852  				compatibl=
e =3D "mediatek,mt8183-power-controller";
37fb78b9aeb75d Matthias Brugger           2020-10-30   853  				#address-=
cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   854  				#size-cel=
ls =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   855  				#power-do=
main-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   856 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   857  				/* power =
domain of the SoC */
37fb78b9aeb75d Matthias Brugger           2020-10-30   858  				power-dom=
ain@MT8183_POWER_DOMAIN_AUDIO {
37fb78b9aeb75d Matthias Brugger           2020-10-30   859  					reg =3D =
<MT8183_POWER_DOMAIN_AUDIO>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   860  					clocks =3D=
 <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   861  						 <&infr=
acfg CLK_INFRA_AUDIO>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   862  						 <&infr=
acfg CLK_INFRA_AUDIO_26M_BCLK>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   863  					clock-na=
mes =3D "audio", "audio1", "audio2";
37fb78b9aeb75d Matthias Brugger           2020-10-30   864  					#power-d=
omain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   865  				};
37fb78b9aeb75d Matthias Brugger           2020-10-30   866 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   867  				power-dom=
ain@MT8183_POWER_DOMAIN_CONN {
37fb78b9aeb75d Matthias Brugger           2020-10-30   868  					reg =3D =
<MT8183_POWER_DOMAIN_CONN>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   869  					mediatek=
,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   870  					#power-d=
omain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   871  				};
37fb78b9aeb75d Matthias Brugger           2020-10-30   872 =20
63859d711a13c7 AngeloGioacchino Del Regno 2022-06-23   873  				mfg_async=
: power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
37fb78b9aeb75d Matthias Brugger           2020-10-30   874  					reg =3D =
<MT8183_POWER_DOMAIN_MFG_ASYNC>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   875  					clocks =3D=
 <&topckgen CLK_TOP_MUX_MFG>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   876  					clock-na=
mes =3D "mfg";
37fb78b9aeb75d Matthias Brugger           2020-10-30   877  					#address=
-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   878  					#size-ce=
lls =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   879  					#power-d=
omain-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   880 =20
9e1b7d00bbe112 Hsin-Yi Wang               2021-01-29   881  					mfg: pow=
er-domain@MT8183_POWER_DOMAIN_MFG {
37fb78b9aeb75d Matthias Brugger           2020-10-30   882  						reg =3D=
 <MT8183_POWER_DOMAIN_MFG>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   883  						#addres=
s-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   884  						#size-c=
ells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   885  						#power-=
domain-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   886 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   887  						power-d=
omain@MT8183_POWER_DOMAIN_MFG_CORE0 {
37fb78b9aeb75d Matthias Brugger           2020-10-30   888  							reg =3D=
 <MT8183_POWER_DOMAIN_MFG_CORE0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   889  							#power=
-domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   890  						};
37fb78b9aeb75d Matthias Brugger           2020-10-30   891 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   892  						power-d=
omain@MT8183_POWER_DOMAIN_MFG_CORE1 {
37fb78b9aeb75d Matthias Brugger           2020-10-30   893  							reg =3D=
 <MT8183_POWER_DOMAIN_MFG_CORE1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   894  							#power=
-domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   895  						};
37fb78b9aeb75d Matthias Brugger           2020-10-30   896 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   897  						power-d=
omain@MT8183_POWER_DOMAIN_MFG_2D {
37fb78b9aeb75d Matthias Brugger           2020-10-30   898  							reg =3D=
 <MT8183_POWER_DOMAIN_MFG_2D>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   899  							mediat=
ek,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   900  							#power=
-domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   901  						};
37fb78b9aeb75d Matthias Brugger           2020-10-30   902  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30   903  				};
37fb78b9aeb75d Matthias Brugger           2020-10-30   904 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   905  				power-dom=
ain@MT8183_POWER_DOMAIN_DISP {
37fb78b9aeb75d Matthias Brugger           2020-10-30   906  					reg =3D =
<MT8183_POWER_DOMAIN_DISP>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   907  					clocks =3D=
 <&topckgen CLK_TOP_MUX_MM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   908  						 <&mmsy=
s CLK_MM_SMI_COMMON>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   909  						 <&mmsy=
s CLK_MM_SMI_LARB0>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   910  						 <&mmsy=
s CLK_MM_SMI_LARB1>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   911  						 <&mmsy=
s CLK_MM_GALS_COMM0>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   912  						 <&mmsy=
s CLK_MM_GALS_COMM1>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   913  						 <&mmsy=
s CLK_MM_GALS_CCU2MM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   914  						 <&mmsy=
s CLK_MM_GALS_IPU12MM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   915  						 <&mmsy=
s CLK_MM_GALS_IMG2MM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   916  						 <&mmsy=
s CLK_MM_GALS_CAM2MM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   917  						 <&mmsy=
s CLK_MM_GALS_IPU2MM>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   918  					clock-na=
mes =3D "mm", "mm-0", "mm-1", "mm-2", "mm-3",
37fb78b9aeb75d Matthias Brugger           2020-10-30   919  						      "=
mm-4", "mm-5", "mm-6", "mm-7",
37fb78b9aeb75d Matthias Brugger           2020-10-30   920  						      "=
mm-8", "mm-9";
37fb78b9aeb75d Matthias Brugger           2020-10-30   921  					mediatek=
,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   922  					mediatek=
,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   923  					#address=
-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   924  					#size-ce=
lls =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   925  					#power-d=
omain-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   926 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   927  					power-do=
main@MT8183_POWER_DOMAIN_CAM {
37fb78b9aeb75d Matthias Brugger           2020-10-30   928  						reg =3D=
 <MT8183_POWER_DOMAIN_CAM>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   929  						clocks =
=3D <&topckgen CLK_TOP_MUX_CAM>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   930  							 <&cam=
sys CLK_CAM_LARB6>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   931  							 <&cam=
sys CLK_CAM_LARB3>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   932  							 <&cam=
sys CLK_CAM_SENINF>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   933  							 <&cam=
sys CLK_CAM_CAMSV0>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   934  							 <&cam=
sys CLK_CAM_CAMSV1>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   935  							 <&cam=
sys CLK_CAM_CAMSV2>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   936  							 <&cam=
sys CLK_CAM_CCU>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   937  						clock-n=
ames =3D "cam", "cam-0", "cam-1",
37fb78b9aeb75d Matthias Brugger           2020-10-30   938  							      =
"cam-2", "cam-3", "cam-4",
37fb78b9aeb75d Matthias Brugger           2020-10-30   939  							      =
"cam-5", "cam-6";
37fb78b9aeb75d Matthias Brugger           2020-10-30   940  						mediate=
k,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   941  						mediate=
k,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   942  						#power-=
domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   943  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30   944 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   945  					power-do=
main@MT8183_POWER_DOMAIN_ISP {
37fb78b9aeb75d Matthias Brugger           2020-10-30   946  						reg =3D=
 <MT8183_POWER_DOMAIN_ISP>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   947  						clocks =
=3D <&topckgen CLK_TOP_MUX_IMG>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   948  							 <&img=
sys CLK_IMG_LARB5>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   949  							 <&img=
sys CLK_IMG_LARB2>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   950  						clock-n=
ames =3D "isp", "isp-0", "isp-1";
37fb78b9aeb75d Matthias Brugger           2020-10-30   951  						mediate=
k,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   952  						mediate=
k,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   953  						#power-=
domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   954  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30   955 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   956  					power-do=
main@MT8183_POWER_DOMAIN_VDEC {
37fb78b9aeb75d Matthias Brugger           2020-10-30   957  						reg =3D=
 <MT8183_POWER_DOMAIN_VDEC>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   958  						mediate=
k,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   959  						#power-=
domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   960  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30   961 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   962  					power-do=
main@MT8183_POWER_DOMAIN_VENC {
37fb78b9aeb75d Matthias Brugger           2020-10-30   963  						reg =3D=
 <MT8183_POWER_DOMAIN_VENC>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   964  						mediate=
k,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   965  						#power-=
domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   966  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30   967 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   968  					power-do=
main@MT8183_POWER_DOMAIN_VPU_TOP {
37fb78b9aeb75d Matthias Brugger           2020-10-30   969  						reg =3D=
 <MT8183_POWER_DOMAIN_VPU_TOP>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   970  						clocks =
=3D <&topckgen CLK_TOP_MUX_IPU_IF>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   971  							 <&top=
ckgen CLK_TOP_MUX_DSP>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   972  							 <&ipu=
_conn CLK_IPU_CONN_IPU>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   973  							 <&ipu=
_conn CLK_IPU_CONN_AHB>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   974  							 <&ipu=
_conn CLK_IPU_CONN_AXI>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   975  							 <&ipu=
_conn CLK_IPU_CONN_ISP>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   976  							 <&ipu=
_conn CLK_IPU_CONN_CAM_ADL>,
37fb78b9aeb75d Matthias Brugger           2020-10-30   977  							 <&ipu=
_conn CLK_IPU_CONN_IMG_ADL>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   978  						clock-n=
ames =3D "vpu", "vpu1", "vpu-0", "vpu-1",
37fb78b9aeb75d Matthias Brugger           2020-10-30   979  							      =
"vpu-2", "vpu-3", "vpu-4", "vpu-5";
37fb78b9aeb75d Matthias Brugger           2020-10-30   980  						mediate=
k,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   981  						mediate=
k,smi =3D <&smi_common>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   982  						#addres=
s-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   983  						#size-c=
ells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   984  						#power-=
domain-cells =3D <1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   985 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   986  						power-d=
omain@MT8183_POWER_DOMAIN_VPU_CORE0 {
37fb78b9aeb75d Matthias Brugger           2020-10-30   987  							reg =3D=
 <MT8183_POWER_DOMAIN_VPU_CORE0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   988  							clocks=
 =3D <&topckgen CLK_TOP_MUX_DSP1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   989  							clock-=
names =3D "vpu2";
37fb78b9aeb75d Matthias Brugger           2020-10-30   990  							mediat=
ek,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   991  							#power=
-domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   992  						};
37fb78b9aeb75d Matthias Brugger           2020-10-30   993 =20
37fb78b9aeb75d Matthias Brugger           2020-10-30   994  						power-d=
omain@MT8183_POWER_DOMAIN_VPU_CORE1 {
37fb78b9aeb75d Matthias Brugger           2020-10-30   995  							reg =3D=
 <MT8183_POWER_DOMAIN_VPU_CORE1>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   996  							clocks=
 =3D <&topckgen CLK_TOP_MUX_DSP2>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   997  							clock-=
names =3D "vpu3";
37fb78b9aeb75d Matthias Brugger           2020-10-30   998  							mediat=
ek,infracfg =3D <&infracfg>;
37fb78b9aeb75d Matthias Brugger           2020-10-30   999  							#power=
-domain-cells =3D <0>;
37fb78b9aeb75d Matthias Brugger           2020-10-30  1000  						};
37fb78b9aeb75d Matthias Brugger           2020-10-30  1001  					};
37fb78b9aeb75d Matthias Brugger           2020-10-30  1002  				};
37fb78b9aeb75d Matthias Brugger           2020-10-30  1003  			};
37fb78b9aeb75d Matthias Brugger           2020-10-30  1004  		};
37fb78b9aeb75d Matthias Brugger           2020-10-30  1005 =20
a39f842541038e yong.liang                 2020-02-17  1006  		watchdog: w=
atchdog@10007000 {
f866c471542e6d Crystal Guo                2020-08-03  1007  			compatible=
 =3D "mediatek,mt8183-wdt";
a39f842541038e yong.liang                 2020-02-17  1008  			reg =3D <0=
 0x10007000 0 0x100>;
a39f842541038e yong.liang                 2020-02-17  1009  			#reset-cel=
ls =3D <1>;
a39f842541038e yong.liang                 2020-02-17  1010  		};
a39f842541038e yong.liang                 2020-02-17  1011 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1012  		apmixedsys:=
 syscon@1000c000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1013  			compatible=
 =3D "mediatek,mt8183-apmixedsys", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27  1014  			reg =3D <0=
 0x1000c000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1015  			#clock-cel=
ls =3D <1>;
e526c9bc11f858 Ben Ho                     2019-05-27  1016  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1017 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1018  		pwrap: pwra=
p@1000d000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1019  			compatible=
 =3D "mediatek,mt8183-pwrap";
e526c9bc11f858 Ben Ho                     2019-05-27  1020  			reg =3D <0=
 0x1000d000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1021  			reg-names =
=3D "pwrap";
cac33c104a1007 Hsin-Hsiung Wang           2019-08-22  1022  			interrupts=
 =3D <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
e526c9bc11f858 Ben Ho                     2019-05-27  1023  			clocks =3D=
 <&topckgen CLK_TOP_MUX_PMICSPI>,
e526c9bc11f858 Ben Ho                     2019-05-27  1024  				 <&infrac=
fg CLK_INFRA_PMIC_AP>;
e526c9bc11f858 Ben Ho                     2019-05-27  1025  			clock-name=
s =3D "spi", "wrap";
e526c9bc11f858 Ben Ho                     2019-05-27  1026  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1027 =20
a8013418d35cc7 Fabien Parent              2022-07-26  1028  		keyboard: k=
eyboard@10010000 {
a8013418d35cc7 Fabien Parent              2022-07-26  1029  			compatible=
 =3D "mediatek,mt6779-keypad";
a8013418d35cc7 Fabien Parent              2022-07-26  1030  			reg =3D <0=
 0x10010000 0 0x1000>;
a8013418d35cc7 Fabien Parent              2022-07-26  1031  			interrupts=
 =3D <GIC_SPI 186 IRQ_TYPE_EDGE_FALLING>;
a8013418d35cc7 Fabien Parent              2022-07-26  1032  			clocks =3D=
 <&clk26m>;
a8013418d35cc7 Fabien Parent              2022-07-26  1033  			clock-name=
s =3D "kpd";
a8013418d35cc7 Fabien Parent              2022-07-26  1034  			status =3D=
 "disabled";
a8013418d35cc7 Fabien Parent              2022-07-26  1035  		};
a8013418d35cc7 Fabien Parent              2022-07-26  1036 =20
1652dbf7363a6c Eddie Huang                2019-11-12  1037  		scp: scp@10=
500000 {
1652dbf7363a6c Eddie Huang                2019-11-12  1038  			compatible=
 =3D "mediatek,mt8183-scp";
1652dbf7363a6c Eddie Huang                2019-11-12  1039  			reg =3D <0=
 0x10500000 0 0x80000>,
1652dbf7363a6c Eddie Huang                2019-11-12  1040  			      <0 0=
x105c0000 0 0x19080>;
1652dbf7363a6c Eddie Huang                2019-11-12  1041  			reg-names =
=3D "sram", "cfg";
1652dbf7363a6c Eddie Huang                2019-11-12  1042  			interrupts=
 =3D <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
1652dbf7363a6c Eddie Huang                2019-11-12  1043  			clocks =3D=
 <&infracfg CLK_INFRA_SCPSYS>;
1652dbf7363a6c Eddie Huang                2019-11-12  1044  			clock-name=
s =3D "main";
1652dbf7363a6c Eddie Huang                2019-11-12  1045  			memory-reg=
ion =3D <&scp_mem_reserved>;
1652dbf7363a6c Eddie Huang                2019-11-12  1046  			status =3D=
 "disabled";
1652dbf7363a6c Eddie Huang                2019-11-12  1047  		};
1652dbf7363a6c Eddie Huang                2019-11-12  1048 =20
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1049  		systimer: t=
imer@10017000 {
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1050  			compatible=
 =3D "mediatek,mt8183-timer",
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1051  				     "med=
iatek,mt6765-timer";
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1052  			reg =3D <0=
 0x10017000 0 0x1000>;
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1053  			interrupts=
 =3D <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
ce8a06b5bac75c Chen-Yu Tsai               2022-12-01  1054  			clocks =3D=
 <&clk13m>;
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1055  		};
5bc8e2875ffbc5 Dehui Sun                  2019-10-28  1056 =20
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1057  		iommu: iomm=
u@10205000 {
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1058  			compatible=
 =3D "mediatek,mt8183-m4u";
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1059  			reg =3D <0=
 0x10205000 0 0x1000>;
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1060  			interrupts=
 =3D <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
33c7874b44324f N=EDcolas F. R. A. Prado     2022-03-01  1061  			mediatek=
,larbs =3D <&larb0>, <&larb1>, <&larb2>, <&larb3>,
33c7874b44324f N=EDcolas F. R. A. Prado     2022-03-01  1062  					 <&lar=
b4>, <&larb5>, <&larb6>;
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1063  			#iommu-cel=
ls =3D <1>;
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1064  		};
c6080916310b6d Enric Balletbo i Serra     2020-11-27  1065 =20
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1066  		gce: mailbo=
x@10238000 {
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1067  			compatible=
 =3D "mediatek,mt8183-gce";
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1068  			reg =3D <0=
 0x10238000 0 0x4000>;
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1069  			interrupts=
 =3D <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
e55c56df43dd11 Fabien Parent              2020-10-18  1070  			#mbox-cell=
s =3D <2>;
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1071  			clocks =3D=
 <&infracfg CLK_INFRA_GCE>;
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1072  			clock-name=
s =3D "gce";
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1073  		};
d3c306e31bc7a2 Bibby Hsieh                2019-11-21  1074 =20
eb59b35331469f Zhiyong Tao                2019-05-27  1075  		auxadc: aux=
adc@11001000 {
eb59b35331469f Zhiyong Tao                2019-05-27  1076  			compatible=
 =3D "mediatek,mt8183-auxadc",
eb59b35331469f Zhiyong Tao                2019-05-27  1077  				     "med=
iatek,mt8173-auxadc";
eb59b35331469f Zhiyong Tao                2019-05-27  1078  			reg =3D <0=
 0x11001000 0 0x1000>;
eb59b35331469f Zhiyong Tao                2019-05-27  1079  			clocks =3D=
 <&infracfg CLK_INFRA_AUXADC>;
eb59b35331469f Zhiyong Tao                2019-05-27  1080  			clock-name=
s =3D "main";
eb59b35331469f Zhiyong Tao                2019-05-27  1081  			#io-channe=
l-cells =3D <1>;
eb59b35331469f Zhiyong Tao                2019-05-27  1082  			status =3D=
 "disabled";
eb59b35331469f Zhiyong Tao                2019-05-27  1083  		};
eb59b35331469f Zhiyong Tao                2019-05-27  1084 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1085  		uart0: seri=
al@11002000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1086  			compatible=
 =3D "mediatek,mt8183-uart",
e526c9bc11f858 Ben Ho                     2019-05-27  1087  				     "med=
iatek,mt6577-uart";
e526c9bc11f858 Ben Ho                     2019-05-27  1088  			reg =3D <0=
 0x11002000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1089  			interrupts=
 =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
e526c9bc11f858 Ben Ho                     2019-05-27  1090  			clocks =3D=
 <&clk26m>, <&infracfg CLK_INFRA_UART0>;
e526c9bc11f858 Ben Ho                     2019-05-27  1091  			clock-name=
s =3D "baud", "bus";
e526c9bc11f858 Ben Ho                     2019-05-27  1092  			status =3D=
 "disabled";
e526c9bc11f858 Ben Ho                     2019-05-27  1093  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1094 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1095  		uart1: seri=
al@11003000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1096  			compatible=
 =3D "mediatek,mt8183-uart",
e526c9bc11f858 Ben Ho                     2019-05-27  1097  				     "med=
iatek,mt6577-uart";
e526c9bc11f858 Ben Ho                     2019-05-27  1098  			reg =3D <0=
 0x11003000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1099  			interrupts=
 =3D <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
e526c9bc11f858 Ben Ho                     2019-05-27  1100  			clocks =3D=
 <&clk26m>, <&infracfg CLK_INFRA_UART1>;
e526c9bc11f858 Ben Ho                     2019-05-27  1101  			clock-name=
s =3D "baud", "bus";
e526c9bc11f858 Ben Ho                     2019-05-27  1102  			status =3D=
 "disabled";
e526c9bc11f858 Ben Ho                     2019-05-27  1103  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1104 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1105  		uart2: seri=
al@11004000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1106  			compatible=
 =3D "mediatek,mt8183-uart",
e526c9bc11f858 Ben Ho                     2019-05-27  1107  				     "med=
iatek,mt6577-uart";
e526c9bc11f858 Ben Ho                     2019-05-27  1108  			reg =3D <0=
 0x11004000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1109  			interrupts=
 =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
e526c9bc11f858 Ben Ho                     2019-05-27  1110  			clocks =3D=
 <&clk26m>, <&infracfg CLK_INFRA_UART2>;
e526c9bc11f858 Ben Ho                     2019-05-27  1111  			clock-name=
s =3D "baud", "bus";
e526c9bc11f858 Ben Ho                     2019-05-27  1112  			status =3D=
 "disabled";
e526c9bc11f858 Ben Ho                     2019-05-27  1113  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1114 =20
251137b8fa97ef Qii Wang                   2019-08-22  1115  		i2c6: i2c@1=
1005000 {
251137b8fa97ef Qii Wang                   2019-08-22  1116  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1117  			reg =3D <0=
 0x11005000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1118  			      <0 0=
x11000600 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1119  			interrupts=
 =3D <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1120  			clocks =3D=
 <&infracfg CLK_INFRA_I2C6>,
251137b8fa97ef Qii Wang                   2019-08-22  1121  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1122  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1123  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1124  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1125  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1126  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1127  		};
251137b8fa97ef Qii Wang                   2019-08-22  1128 =20
251137b8fa97ef Qii Wang                   2019-08-22  1129  		i2c0: i2c@1=
1007000 {
251137b8fa97ef Qii Wang                   2019-08-22  1130  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1131  			reg =3D <0=
 0x11007000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1132  			      <0 0=
x11000080 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1133  			interrupts=
 =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1134  			clocks =3D=
 <&infracfg CLK_INFRA_I2C0>,
251137b8fa97ef Qii Wang                   2019-08-22  1135  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1136  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1137  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1138  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1139  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1140  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1141  		};
251137b8fa97ef Qii Wang                   2019-08-22  1142 =20
251137b8fa97ef Qii Wang                   2019-08-22  1143  		i2c4: i2c@1=
1008000 {
251137b8fa97ef Qii Wang                   2019-08-22  1144  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1145  			reg =3D <0=
 0x11008000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1146  			      <0 0=
x11000100 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1147  			interrupts=
 =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1148  			clocks =3D=
 <&infracfg CLK_INFRA_I2C1>,
251137b8fa97ef Qii Wang                   2019-08-22  1149  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1150  				 <&infrac=
fg CLK_INFRA_I2C1_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1151  			clock-name=
s =3D "main", "dma","arb";
251137b8fa97ef Qii Wang                   2019-08-22  1152  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1153  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1154  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1155  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1156  		};
251137b8fa97ef Qii Wang                   2019-08-22  1157 =20
251137b8fa97ef Qii Wang                   2019-08-22  1158  		i2c2: i2c@1=
1009000 {
251137b8fa97ef Qii Wang                   2019-08-22  1159  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1160  			reg =3D <0=
 0x11009000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1161  			      <0 0=
x11000280 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1162  			interrupts=
 =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1163  			clocks =3D=
 <&infracfg CLK_INFRA_I2C2>,
251137b8fa97ef Qii Wang                   2019-08-22  1164  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1165  				 <&infrac=
fg CLK_INFRA_I2C2_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1166  			clock-name=
s =3D "main", "dma", "arb";
251137b8fa97ef Qii Wang                   2019-08-22  1167  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1168  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1169  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1170  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1171  		};
251137b8fa97ef Qii Wang                   2019-08-22  1172 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1173  		spi0: spi@1=
100a000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1174  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1175  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1176  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1177  			reg =3D <0=
 0x1100a000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1178  			interrupts=
 =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1179  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1180  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1181  				 <&infrac=
fg CLK_INFRA_SPI0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1182  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1183  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1184  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1185 =20
4a5191c5dd28c9 AngeloGioacchino Del Regno 2024-04-10  1186  		thermal: th=
ermal-sensor@1100b000 {
b325ce39785b14 michael.kao                2021-03-16  1187  			#thermal-s=
ensor-cells =3D <1>;
b325ce39785b14 michael.kao                2021-03-16  1188  			compatible=
 =3D "mediatek,mt8183-thermal";
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1189  			reg =3D <0=
 0x1100b000 0 0xc00>;
b325ce39785b14 michael.kao                2021-03-16  1190  			clocks =3D=
 <&infracfg CLK_INFRA_THERM>,
b325ce39785b14 michael.kao                2021-03-16  1191  				 <&infrac=
fg CLK_INFRA_AUXADC>;
b325ce39785b14 michael.kao                2021-03-16  1192  			clock-name=
s =3D "therm", "auxadc";
b325ce39785b14 michael.kao                2021-03-16  1193  			resets =3D=
 <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
b325ce39785b14 michael.kao                2021-03-16  1194  			interrupts=
 =3D <0 76 IRQ_TYPE_LEVEL_LOW>;
b325ce39785b14 michael.kao                2021-03-16  1195  			mediatek,a=
uxadc =3D <&auxadc>;
b325ce39785b14 michael.kao                2021-03-16  1196  			mediatek,a=
pmixedsys =3D <&apmixedsys>;
b325ce39785b14 michael.kao                2021-03-16  1197  			nvmem-cell=
s =3D <&thermal_calibration>;
b325ce39785b14 michael.kao                2021-03-16  1198  			nvmem-cell=
-names =3D "calibration-data";
b325ce39785b14 michael.kao                2021-03-16  1199  		};
b325ce39785b14 michael.kao                2021-03-16  1200 =20
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1201  		svs: svs@11=
00bc00 {
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1202  			compatible=
 =3D "mediatek,mt8183-svs";
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1203  			reg =3D <0=
 0x1100bc00 0 0x400>;
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1204  			interrupts=
 =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1205  			clocks =3D=
 <&infracfg CLK_INFRA_THERM>;
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1206  			clock-name=
s =3D "main";
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1207  			nvmem-cell=
s =3D <&svs_calibration>,
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1208  				      <&t=
hermal_calibration>;
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1209  			nvmem-cell=
-names =3D "svs-calibration-data",
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1210  					   "t-ca=
libration-data";
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1211  		};
e9ff6cdad87343 AngeloGioacchino Del Regno 2023-11-21  1212 =20
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1213  		pwm0: pwm@1=
100e000 {
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1214  			compatible=
 =3D "mediatek,mt8183-disp-pwm";
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1215  			reg =3D <0=
 0x1100e000 0 0x1000>;
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1216  			interrupts=
 =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_LOW>;
2f99fb6e46b0e9 Enric Balletbo i Serra     2021-01-13  1217  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1218  			#pwm-cells=
 =3D <2>;
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1219  			clocks =3D=
 <&topckgen CLK_TOP_MUX_DISP_PWM>,
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1220  					<&infrac=
fg CLK_INFRA_DISP_PWM>;
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1221  			clock-name=
s =3D "main", "mm";
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1222  		};
f15722c0fef05a Hsin-Yi Wang               2020-11-24  1223 =20
afca1c66fb3312 Fabien Parent              2020-12-09  1224  		pwm1: pwm@1=
1006000 {
afca1c66fb3312 Fabien Parent              2020-12-09  1225  			compatible=
 =3D "mediatek,mt8183-pwm";
afca1c66fb3312 Fabien Parent              2020-12-09  1226  			reg =3D <0=
 0x11006000 0 0x1000>;
afca1c66fb3312 Fabien Parent              2020-12-09  1227  			#pwm-cells=
 =3D <2>;
afca1c66fb3312 Fabien Parent              2020-12-09  1228  			clocks =3D=
 <&infracfg CLK_INFRA_PWM>,
afca1c66fb3312 Fabien Parent              2020-12-09  1229  				 <&infrac=
fg CLK_INFRA_PWM_HCLK>,
afca1c66fb3312 Fabien Parent              2020-12-09  1230  				 <&infrac=
fg CLK_INFRA_PWM1>,
afca1c66fb3312 Fabien Parent              2020-12-09  1231  				 <&infrac=
fg CLK_INFRA_PWM2>,
afca1c66fb3312 Fabien Parent              2020-12-09  1232  				 <&infrac=
fg CLK_INFRA_PWM3>,
afca1c66fb3312 Fabien Parent              2020-12-09  1233  				 <&infrac=
fg CLK_INFRA_PWM4>;
afca1c66fb3312 Fabien Parent              2020-12-09  1234  			clock-name=
s =3D "top", "main", "pwm1", "pwm2", "pwm3",
afca1c66fb3312 Fabien Parent              2020-12-09  1235  				      "pw=
m4";
afca1c66fb3312 Fabien Parent              2020-12-09  1236  		};
afca1c66fb3312 Fabien Parent              2020-12-09  1237 =20
251137b8fa97ef Qii Wang                   2019-08-22  1238  		i2c3: i2c@1=
100f000 {
251137b8fa97ef Qii Wang                   2019-08-22  1239  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1240  			reg =3D <0=
 0x1100f000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1241  			      <0 0=
x11000400 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1242  			interrupts=
 =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1243  			clocks =3D=
 <&infracfg CLK_INFRA_I2C3>,
251137b8fa97ef Qii Wang                   2019-08-22  1244  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1245  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1246  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1247  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1248  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1249  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1250  		};
251137b8fa97ef Qii Wang                   2019-08-22  1251 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1252  		spi1: spi@1=
1010000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1253  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1254  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1255  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1256  			reg =3D <0=
 0x11010000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1257  			interrupts=
 =3D <GIC_SPI 124 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1258  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1259  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1260  				 <&infrac=
fg CLK_INFRA_SPI1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1261  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1262  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1263  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1264 =20
251137b8fa97ef Qii Wang                   2019-08-22  1265  		i2c1: i2c@1=
1011000 {
251137b8fa97ef Qii Wang                   2019-08-22  1266  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1267  			reg =3D <0=
 0x11011000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1268  			      <0 0=
x11000480 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1269  			interrupts=
 =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1270  			clocks =3D=
 <&infracfg CLK_INFRA_I2C4>,
251137b8fa97ef Qii Wang                   2019-08-22  1271  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1272  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1273  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1274  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1275  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1276  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1277  		};
251137b8fa97ef Qii Wang                   2019-08-22  1278 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1279  		spi2: spi@1=
1012000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1280  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1281  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1282  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1283  			reg =3D <0=
 0x11012000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1284  			interrupts=
 =3D <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1285  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1286  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1287  				 <&infrac=
fg CLK_INFRA_SPI2>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1288  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1289  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1290  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1291 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1292  		spi3: spi@1=
1013000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1293  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1294  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1295  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1296  			reg =3D <0=
 0x11013000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1297  			interrupts=
 =3D <GIC_SPI 130 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1298  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1299  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1300  				 <&infrac=
fg CLK_INFRA_SPI3>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1301  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1302  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1303  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1304 =20
251137b8fa97ef Qii Wang                   2019-08-22  1305  		i2c9: i2c@1=
1014000 {
251137b8fa97ef Qii Wang                   2019-08-22  1306  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1307  			reg =3D <0=
 0x11014000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1308  			      <0 0=
x11000180 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1309  			interrupts=
 =3D <GIC_SPI 131 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1310  			clocks =3D=
 <&infracfg CLK_INFRA_I2C1_IMM>,
251137b8fa97ef Qii Wang                   2019-08-22  1311  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1312  				 <&infrac=
fg CLK_INFRA_I2C1_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1313  			clock-name=
s =3D "main", "dma", "arb";
251137b8fa97ef Qii Wang                   2019-08-22  1314  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1315  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1316  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1317  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1318  		};
251137b8fa97ef Qii Wang                   2019-08-22  1319 =20
251137b8fa97ef Qii Wang                   2019-08-22  1320  		i2c10: i2c@=
11015000 {
251137b8fa97ef Qii Wang                   2019-08-22  1321  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1322  			reg =3D <0=
 0x11015000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1323  			      <0 0=
x11000300 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1324  			interrupts=
 =3D <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1325  			clocks =3D=
 <&infracfg CLK_INFRA_I2C2_IMM>,
251137b8fa97ef Qii Wang                   2019-08-22  1326  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1327  				 <&infrac=
fg CLK_INFRA_I2C2_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1328  			clock-name=
s =3D "main", "dma", "arb";
251137b8fa97ef Qii Wang                   2019-08-22  1329  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1330  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1331  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1332  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1333  		};
251137b8fa97ef Qii Wang                   2019-08-22  1334 =20
251137b8fa97ef Qii Wang                   2019-08-22  1335  		i2c5: i2c@1=
1016000 {
251137b8fa97ef Qii Wang                   2019-08-22  1336  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1337  			reg =3D <0=
 0x11016000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1338  			      <0 0=
x11000500 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1339  			interrupts=
 =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1340  			clocks =3D=
 <&infracfg CLK_INFRA_I2C5>,
251137b8fa97ef Qii Wang                   2019-08-22  1341  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1342  				 <&infrac=
fg CLK_INFRA_I2C5_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1343  			clock-name=
s =3D "main", "dma", "arb";
251137b8fa97ef Qii Wang                   2019-08-22  1344  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1345  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1346  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1347  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1348  		};
251137b8fa97ef Qii Wang                   2019-08-22  1349 =20
251137b8fa97ef Qii Wang                   2019-08-22  1350  		i2c11: i2c@=
11017000 {
251137b8fa97ef Qii Wang                   2019-08-22  1351  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1352  			reg =3D <0=
 0x11017000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1353  			      <0 0=
x11000580 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1354  			interrupts=
 =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1355  			clocks =3D=
 <&infracfg CLK_INFRA_I2C5_IMM>,
251137b8fa97ef Qii Wang                   2019-08-22  1356  				 <&infrac=
fg CLK_INFRA_AP_DMA>,
251137b8fa97ef Qii Wang                   2019-08-22  1357  				 <&infrac=
fg CLK_INFRA_I2C5_ARBITER>;
251137b8fa97ef Qii Wang                   2019-08-22  1358  			clock-name=
s =3D "main", "dma", "arb";
251137b8fa97ef Qii Wang                   2019-08-22  1359  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1360  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1361  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1362  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1363  		};
251137b8fa97ef Qii Wang                   2019-08-22  1364 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1365  		spi4: spi@1=
1018000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1366  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1367  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1368  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1369  			reg =3D <0=
 0x11018000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1370  			interrupts=
 =3D <GIC_SPI 134 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1371  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1372  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1373  				 <&infrac=
fg CLK_INFRA_SPI4>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1374  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1375  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1376  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1377 =20
8e2dd0f9249119 Erin Lo                    2019-05-27  1378  		spi5: spi@1=
1019000 {
8e2dd0f9249119 Erin Lo                    2019-05-27  1379  			compatible=
 =3D "mediatek,mt8183-spi";
8e2dd0f9249119 Erin Lo                    2019-05-27  1380  			#address-c=
ells =3D <1>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1381  			#size-cell=
s =3D <0>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1382  			reg =3D <0=
 0x11019000 0 0x1000>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1383  			interrupts=
 =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1384  			clocks =3D=
 <&topckgen CLK_TOP_SYSPLL_D5_D2>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1385  				 <&topckg=
en CLK_TOP_MUX_SPI>,
8e2dd0f9249119 Erin Lo                    2019-05-27  1386  				 <&infrac=
fg CLK_INFRA_SPI5>;
8e2dd0f9249119 Erin Lo                    2019-05-27  1387  			clock-name=
s =3D "parent-clk", "sel-clk", "spi-clk";
8e2dd0f9249119 Erin Lo                    2019-05-27  1388  			status =3D=
 "disabled";
8e2dd0f9249119 Erin Lo                    2019-05-27  1389  		};
8e2dd0f9249119 Erin Lo                    2019-05-27  1390 =20
251137b8fa97ef Qii Wang                   2019-08-22  1391  		i2c7: i2c@1=
101a000 {
251137b8fa97ef Qii Wang                   2019-08-22  1392  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1393  			reg =3D <0=
 0x1101a000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1394  			      <0 0=
x11000680 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1395  			interrupts=
 =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1396  			clocks =3D=
 <&infracfg CLK_INFRA_I2C7>,
251137b8fa97ef Qii Wang                   2019-08-22  1397  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1398  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1399  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1400  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1401  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1402  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1403  		};
251137b8fa97ef Qii Wang                   2019-08-22  1404 =20
251137b8fa97ef Qii Wang                   2019-08-22  1405  		i2c8: i2c@1=
101b000 {
251137b8fa97ef Qii Wang                   2019-08-22  1406  			compatible=
 =3D "mediatek,mt8183-i2c";
251137b8fa97ef Qii Wang                   2019-08-22  1407  			reg =3D <0=
 0x1101b000 0 0x1000>,
251137b8fa97ef Qii Wang                   2019-08-22  1408  			      <0 0=
x11000700 0 0x80>;
251137b8fa97ef Qii Wang                   2019-08-22  1409  			interrupts=
 =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
251137b8fa97ef Qii Wang                   2019-08-22  1410  			clocks =3D=
 <&infracfg CLK_INFRA_I2C8>,
251137b8fa97ef Qii Wang                   2019-08-22  1411  				 <&infrac=
fg CLK_INFRA_AP_DMA>;
251137b8fa97ef Qii Wang                   2019-08-22  1412  			clock-name=
s =3D "main", "dma";
251137b8fa97ef Qii Wang                   2019-08-22  1413  			clock-div =
=3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1414  			#address-c=
ells =3D <1>;
251137b8fa97ef Qii Wang                   2019-08-22  1415  			#size-cell=
s =3D <0>;
251137b8fa97ef Qii Wang                   2019-08-22  1416  			status =3D=
 "disabled";
251137b8fa97ef Qii Wang                   2019-08-22  1417  		};
251137b8fa97ef Qii Wang                   2019-08-22  1418 =20
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1419  		ssusb: usb@=
11201000 {
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1420  			compatible=
 =3D "mediatek,mt8183-mtu3", "mediatek,mtu3";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1421  			reg =3D <0=
 0x11201000 0 0x2e00>,
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1422  			      <0 0=
x11203e00 0 0x0100>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1423  			reg-names =
=3D "mac", "ippc";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1424  			interrupts=
 =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1425  			phys =3D <=
&u2port0 PHY_TYPE_USB2>,
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1426  			       <&u=
3port0 PHY_TYPE_USB3>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1427  			clocks =3D=
 <&infracfg CLK_INFRA_UNIPRO_SCK>,
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1428  				 <&infrac=
fg CLK_INFRA_USB>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1429  			clock-name=
s =3D "sys_ck", "ref_ck";
d3cbc7f82caa9b Chunfeng Yun               2021-03-23  1430  			mediatek,s=
yscon-wakeup =3D <&pericfg 0x420 101>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1431  			#address-c=
ells =3D <2>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1432  			#size-cell=
s =3D <2>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1433  			ranges;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1434  			status =3D=
 "disabled";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1435 =20
d1c9c70a882321 Chunfeng Yun               2021-03-16  1436  			usb_host: =
usb@11200000 {
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1437  				compatibl=
e =3D "mediatek,mt8183-xhci",
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1438  					     "me=
diatek,mtk-xhci";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1439  				reg =3D <=
0 0x11200000 0 0x1000>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1440  				reg-names=
 =3D "mac";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1441  				interrupt=
s =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1442  				clocks =3D=
 <&infracfg CLK_INFRA_UNIPRO_SCK>,
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1443  					 <&infra=
cfg CLK_INFRA_USB>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1444  				clock-nam=
es =3D "sys_ck", "ref_ck";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1445  				status =3D=
 "disabled";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1446  			};
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1447  		};
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1448 =20
13dd23cfc6e259 Kansho Nishida             2021-07-06  1449  		audiosys: a=
udio-controller@11220000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1450  			compatible=
 =3D "mediatek,mt8183-audiosys", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27  1451  			reg =3D <0=
 0x11220000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1452  			#clock-cel=
ls =3D <1>;
13dd23cfc6e259 Kansho Nishida             2021-07-06  1453  			afe: mt818=
3-afe-pcm {
13dd23cfc6e259 Kansho Nishida             2021-07-06  1454  				compatibl=
e =3D "mediatek,mt8183-audio";
13dd23cfc6e259 Kansho Nishida             2021-07-06  1455  				interrupt=
s =3D <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
13dd23cfc6e259 Kansho Nishida             2021-07-06  1456  				resets =3D=
 <&watchdog MT8183_TOPRGU_AUDIO_SW_RST>;
13dd23cfc6e259 Kansho Nishida             2021-07-06  1457  				reset-nam=
es =3D "audiosys";
13dd23cfc6e259 Kansho Nishida             2021-07-06  1458  				power-dom=
ains =3D
13dd23cfc6e259 Kansho Nishida             2021-07-06  1459  					<&spm MT=
8183_POWER_DOMAIN_AUDIO>;
13dd23cfc6e259 Kansho Nishida             2021-07-06  1460  				clocks =3D=
 <&audiosys CLK_AUDIO_AFE>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1461  					 <&audio=
sys CLK_AUDIO_DAC>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1462  					 <&audio=
sys CLK_AUDIO_DAC_PREDIS>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1463  					 <&audio=
sys CLK_AUDIO_ADC>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1464  					 <&audio=
sys CLK_AUDIO_PDN_ADDA6_ADC>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1465  					 <&audio=
sys CLK_AUDIO_22M>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1466  					 <&audio=
sys CLK_AUDIO_24M>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1467  					 <&audio=
sys CLK_AUDIO_APLL_TUNER>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1468  					 <&audio=
sys CLK_AUDIO_APLL2_TUNER>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1469  					 <&audio=
sys CLK_AUDIO_I2S1>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1470  					 <&audio=
sys CLK_AUDIO_I2S2>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1471  					 <&audio=
sys CLK_AUDIO_I2S3>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1472  					 <&audio=
sys CLK_AUDIO_I2S4>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1473  					 <&audio=
sys CLK_AUDIO_TDM>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1474  					 <&audio=
sys CLK_AUDIO_TML>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1475  					 <&infra=
cfg CLK_INFRA_AUDIO>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1476  					 <&infra=
cfg CLK_INFRA_AUDIO_26M_BCLK>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1477  					 <&topck=
gen CLK_TOP_MUX_AUDIO>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1478  					 <&topck=
gen CLK_TOP_MUX_AUD_INTBUS>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1479  					 <&topck=
gen CLK_TOP_SYSPLL_D2_D4>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1480  					 <&topck=
gen CLK_TOP_MUX_AUD_1>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1481  					 <&topck=
gen CLK_TOP_APLL1_CK>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1482  					 <&topck=
gen CLK_TOP_MUX_AUD_2>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1483  					 <&topck=
gen CLK_TOP_APLL2_CK>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1484  					 <&topck=
gen CLK_TOP_MUX_AUD_ENG1>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1485  					 <&topck=
gen CLK_TOP_APLL1_D8>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1486  					 <&topck=
gen CLK_TOP_MUX_AUD_ENG2>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1487  					 <&topck=
gen CLK_TOP_APLL2_D8>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1488  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S0>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1489  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S1>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1490  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S2>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1491  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S3>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1492  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S4>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1493  					 <&topck=
gen CLK_TOP_MUX_APLL_I2S5>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1494  					 <&topck=
gen CLK_TOP_APLL12_DIV0>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1495  					 <&topck=
gen CLK_TOP_APLL12_DIV1>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1496  					 <&topck=
gen CLK_TOP_APLL12_DIV2>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1497  					 <&topck=
gen CLK_TOP_APLL12_DIV3>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1498  					 <&topck=
gen CLK_TOP_APLL12_DIV4>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1499  					 <&topck=
gen CLK_TOP_APLL12_DIVB>,
13dd23cfc6e259 Kansho Nishida             2021-07-06  1500  					 /*<&top=
ckgen CLK_TOP_APLL12_DIV5>,*/
13dd23cfc6e259 Kansho Nishida             2021-07-06  1501  					 <&clk26=
m>;
13dd23cfc6e259 Kansho Nishida             2021-07-06  1502  				clock-nam=
es =3D "aud_afe_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1503  						  "aud_=
dac_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1504  						  "aud_=
dac_predis_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1505  						  "aud_=
adc_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1506  						  "aud_=
adc_adda6_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1507  						  "aud_=
apll22m_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1508  						  "aud_=
apll24m_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1509  						  "aud_=
apll1_tuner_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1510  						  "aud_=
apll2_tuner_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1511  						  "aud_=
i2s1_bclk_sw",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1512  						  "aud_=
i2s2_bclk_sw",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1513  						  "aud_=
i2s3_bclk_sw",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1514  						  "aud_=
i2s4_bclk_sw",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1515  						  "aud_=
tdm_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1516  						  "aud_=
tml_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1517  						  "aud_=
infra_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1518  						  "mtka=
if_26m_clk",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1519  						  "top_=
mux_audio",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1520  						  "top_=
mux_aud_intbus",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1521  						  "top_=
syspll_d2_d4",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1522  						  "top_=
mux_aud_1",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1523  						  "top_=
apll1_ck",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1524  						  "top_=
mux_aud_2",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1525  						  "top_=
apll2_ck",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1526  						  "top_=
mux_aud_eng1",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1527  						  "top_=
apll1_d8",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1528  						  "top_=
mux_aud_eng2",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1529  						  "top_=
apll2_d8",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1530  						  "top_=
i2s0_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1531  						  "top_=
i2s1_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1532  						  "top_=
i2s2_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1533  						  "top_=
i2s3_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1534  						  "top_=
i2s4_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1535  						  "top_=
i2s5_m_sel",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1536  						  "top_=
apll12_div0",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1537  						  "top_=
apll12_div1",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1538  						  "top_=
apll12_div2",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1539  						  "top_=
apll12_div3",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1540  						  "top_=
apll12_div4",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1541  						  "top_=
apll12_divb",
13dd23cfc6e259 Kansho Nishida             2021-07-06  1542  						  /*"to=
p_apll12_div5",*/
13dd23cfc6e259 Kansho Nishida             2021-07-06  1543  						  "top_=
clk26m_clk";
13dd23cfc6e259 Kansho Nishida             2021-07-06  1544  			};
e526c9bc11f858 Ben Ho                     2019-05-27  1545  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1546 =20
5e6cdf0051f824 jjian zhou                 2019-04-10  1547  		mmc0: mmc@1=
1230000 {
5e6cdf0051f824 jjian zhou                 2019-04-10  1548  			compatible=
 =3D "mediatek,mt8183-mmc";
5e6cdf0051f824 jjian zhou                 2019-04-10  1549  			reg =3D <0=
 0x11230000 0 0x1000>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1550  			      <0 0=
x11f50000 0 0x1000>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1551  			interrupts=
 =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1552  			clocks =3D=
 <&topckgen CLK_TOP_MUX_MSDC50_0>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1553  				 <&infrac=
fg CLK_INFRA_MSDC0>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1554  				 <&infrac=
fg CLK_INFRA_MSDC0_SCK>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1555  			clock-name=
s =3D "source", "hclk", "source_cg";
5e6cdf0051f824 jjian zhou                 2019-04-10  1556  			status =3D=
 "disabled";
5e6cdf0051f824 jjian zhou                 2019-04-10  1557  		};
5e6cdf0051f824 jjian zhou                 2019-04-10  1558 =20
5e6cdf0051f824 jjian zhou                 2019-04-10  1559  		mmc1: mmc@1=
1240000 {
5e6cdf0051f824 jjian zhou                 2019-04-10  1560  			compatible=
 =3D "mediatek,mt8183-mmc";
5e6cdf0051f824 jjian zhou                 2019-04-10  1561  			reg =3D <0=
 0x11240000 0 0x1000>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1562  			      <0 0=
x11e10000 0 0x1000>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1563  			interrupts=
 =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_LOW>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1564  			clocks =3D=
 <&topckgen CLK_TOP_MUX_MSDC30_1>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1565  				 <&infrac=
fg CLK_INFRA_MSDC1>,
5e6cdf0051f824 jjian zhou                 2019-04-10  1566  				 <&infrac=
fg CLK_INFRA_MSDC1_SCK>;
5e6cdf0051f824 jjian zhou                 2019-04-10  1567  			clock-name=
s =3D "source", "hclk", "source_cg";
5e6cdf0051f824 jjian zhou                 2019-04-10  1568  			status =3D=
 "disabled";
5e6cdf0051f824 jjian zhou                 2019-04-10  1569  		};
5e6cdf0051f824 jjian zhou                 2019-04-10  1570 =20
d1c9c70a882321 Chunfeng Yun               2021-03-16  1571  		mipi_tx0: d=
si-phy@11e50000 {
88ec840270e62e Jitao Shi                  2020-11-27  1572  			compatible=
 =3D "mediatek,mt8183-mipi-tx";
88ec840270e62e Jitao Shi                  2020-11-27  1573  			reg =3D <0=
 0x11e50000 0 0x1000>;
88ec840270e62e Jitao Shi                  2020-11-27  1574  			clocks =3D=
 <&apmixedsys CLK_APMIXED_MIPID0_26M>;
88ec840270e62e Jitao Shi                  2020-11-27  1575  			#clock-cel=
ls =3D <0>;
88ec840270e62e Jitao Shi                  2020-11-27  1576  			#phy-cells=
 =3D <0>;
88ec840270e62e Jitao Shi                  2020-11-27  1577  			clock-outp=
ut-names =3D "mipi_tx0_pll";
88ec840270e62e Jitao Shi                  2020-11-27  1578  			nvmem-cell=
s =3D <&mipi_tx_calibration>;
88ec840270e62e Jitao Shi                  2020-11-27  1579  			nvmem-cell=
-names =3D "calibration-data";
88ec840270e62e Jitao Shi                  2020-11-27  1580  		};
88ec840270e62e Jitao Shi                  2020-11-27  1581 =20
de1033881e9363 Michael Mei                2019-05-27  1582  		efuse: efus=
e@11f10000 {
de1033881e9363 Michael Mei                2019-05-27  1583  			compatible=
 =3D "mediatek,mt8183-efuse",
de1033881e9363 Michael Mei                2019-05-27  1584  				     "med=
iatek,efuse";
de1033881e9363 Michael Mei                2019-05-27  1585  			reg =3D <0=
 0x11f10000 0 0x1000>;
88ec840270e62e Jitao Shi                  2020-11-27  1586  			#address-c=
ells =3D <1>;
88ec840270e62e Jitao Shi                  2020-11-27  1587  			#size-cell=
s =3D <1>;
94e4dd09581b2b William-tw Lin             2023-12-22  1588 =20
94e4dd09581b2b William-tw Lin             2023-12-22  1589  			socinfo-da=
ta1@4c {
94e4dd09581b2b William-tw Lin             2023-12-22  1590  				reg =3D <=
0x04c 0x4>;
94e4dd09581b2b William-tw Lin             2023-12-22  1591  			};
94e4dd09581b2b William-tw Lin             2023-12-22  1592 =20
94e4dd09581b2b William-tw Lin             2023-12-22  1593  			socinfo-da=
ta2@60 {
94e4dd09581b2b William-tw Lin             2023-12-22  1594  				reg =3D <=
0x060 0x4>;
94e4dd09581b2b William-tw Lin             2023-12-22  1595  			};
94e4dd09581b2b William-tw Lin             2023-12-22  1596 =20
b325ce39785b14 michael.kao                2021-03-16  1597  			thermal_ca=
libration: calib@180 {
b325ce39785b14 michael.kao                2021-03-16  1598  				reg =3D <=
0x180 0xc>;
b325ce39785b14 michael.kao                2021-03-16  1599  			};
b325ce39785b14 michael.kao                2021-03-16  1600 =20
88ec840270e62e Jitao Shi                  2020-11-27  1601  			mipi_tx_ca=
libration: calib@190 {
88ec840270e62e Jitao Shi                  2020-11-27  1602  				reg =3D <=
0x190 0xc>;
88ec840270e62e Jitao Shi                  2020-11-27  1603  			};
41131266c8ce50 Roger Lu                   2022-05-16  1604 =20
41131266c8ce50 Roger Lu                   2022-05-16  1605  			svs_calibr=
ation: calib@580 {
41131266c8ce50 Roger Lu                   2022-05-16  1606  				reg =3D <=
0x580 0x64>;
41131266c8ce50 Roger Lu                   2022-05-16  1607  			};
de1033881e9363 Michael Mei                2019-05-27  1608  		};
de1033881e9363 Michael Mei                2019-05-27  1609 =20
d1c9c70a882321 Chunfeng Yun               2021-03-16  1610  		u3phy: t-ph=
y@11f40000 {
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1611  			compatible=
 =3D "mediatek,mt8183-tphy",
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1612  				     "med=
iatek,generic-tphy-v2";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1613  			#address-c=
ells =3D <1>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1614  			#size-cell=
s =3D <1>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1615  			ranges =3D=
 <0 0 0x11f40000 0x1000>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1616  			status =3D=
 "okay";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1617 =20
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1618  			u2port0: u=
sb-phy@0 {
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1619  				reg =3D <=
0x0 0x700>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1620  				clocks =3D=
 <&clk26m>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1621  				clock-nam=
es =3D "ref";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1622  				#phy-cell=
s =3D <1>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1623  				mediatek,=
discth =3D <15>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1624  				status =3D=
 "okay";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1625  			};
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1626 =20
f538437b315c85 Matthias Brugger           2021-04-16  1627  			u3port0: u=
sb-phy@700 {
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1628  				reg =3D <=
0x0700 0x900>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1629  				clocks =3D=
 <&clk26m>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1630  				clock-nam=
es =3D "ref";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1631  				#phy-cell=
s =3D <1>;
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1632  				status =3D=
 "okay";
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1633  			};
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1634  		};
6b3bfa37a90a37 Enric Balletbo i Serra     2020-06-25  1635 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1636  		mfgcfg: sys=
con@13000000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1637  			compatible=
 =3D "mediatek,mt8183-mfgcfg", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27  1638  			reg =3D <0=
 0x13000000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1639  			#clock-cel=
ls =3D <1>;
1781f2c461804c Ikjoon Jang                2024-02-23  1640  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
e526c9bc11f858 Ben Ho                     2019-05-27  1641  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1642 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1643  		gpu: gpu@13=
040000 {
c78838d8031506 AngeloGioacchino Del Regno 2023-03-01  1644  			compatible=
 =3D "mediatek,mt8183b-mali", "arm,mali-bifrost";
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1645  			reg =3D <0=
 0x13040000 0 0x4000>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1646  			interrupts=
 =3D
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1647  				<GIC_SPI =
280 IRQ_TYPE_LEVEL_LOW>,
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1648  				<GIC_SPI =
279 IRQ_TYPE_LEVEL_LOW>,
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1649  				<GIC_SPI =
278 IRQ_TYPE_LEVEL_LOW>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1650  			interrupt-=
names =3D "job", "mmu", "gpu";
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1651 =20
ad2631b5645a1d Chen-Yu Tsai               2022-09-27  1652  			clocks =3D=
 <&mfgcfg CLK_MFG_BG3D>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1653 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1654  			power-doma=
ins =3D
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1655  				<&spm MT8=
183_POWER_DOMAIN_MFG_CORE0>,
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1656  				<&spm MT8=
183_POWER_DOMAIN_MFG_CORE1>,
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1657  				<&spm MT8=
183_POWER_DOMAIN_MFG_2D>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1658  			power-doma=
in-names =3D "core0", "core1", "core2";
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1659 =20
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1660  			operating-=
points-v2 =3D <&gpu_opp_table>;
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1661  		};
a8168cebf1bca1 Nicolas Boichat            2021-05-21  1662 =20
e526c9bc11f858 Ben Ho                     2019-05-27  1663  		mmsys: sysc=
on@14000000 {
e526c9bc11f858 Ben Ho                     2019-05-27  1664  			compatible=
 =3D "mediatek,mt8183-mmsys", "syscon";
e526c9bc11f858 Ben Ho                     2019-05-27  1665  			reg =3D <0=
 0x14000000 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1666  			#clock-cel=
ls =3D <1>;
4bdb00edbd2ae3 Enric Balletbo i Serra     2021-09-30  1667  			#reset-cel=
ls =3D <1>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1668  			mboxes =3D=
 <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1669  				 <&gce 1 =
CMDQ_THR_PRIO_HIGHEST>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1670  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0 0x1000>;
e526c9bc11f858 Ben Ho                     2019-05-27  1671  		};
e526c9bc11f858 Ben Ho                     2019-05-27  1672 =20
188ffcd7fea79a Moudy Ho                   2023-10-30  1673  		dma-control=
ler0@14001000 {
60a2fb8d202a4d Moudy Ho                   2022-08-23  1674  			compatible=
 =3D "mediatek,mt8183-mdp3-rdma";
60a2fb8d202a4d Moudy Ho                   2022-08-23  1675  			reg =3D <0=
 0x14001000 0 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1676  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1677  			mediatek,g=
ce-events =3D <CMDQ_EVENT_MDP_RDMA0_SOF>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1678  					      <C=
MDQ_EVENT_MDP_RDMA0_EOF>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1679  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1680  			clocks =3D=
 <&mmsys CLK_MM_MDP_RDMA0>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1681  				 <&mmsys =
CLK_MM_MDP_RSZ1>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1682  			iommus =3D=
 <&iommu M4U_PORT_MDP_RDMA0>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1683  			mboxes =3D=
 <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1684  				 <&gce 21=
 CMDQ_THR_PRIO_LOWEST 0>;
188ffcd7fea79a Moudy Ho                   2023-10-30  1685  			#dma-cells=
 =3D <1>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1686  		};
60a2fb8d202a4d Moudy Ho                   2022-08-23  1687 =20
60a2fb8d202a4d Moudy Ho                   2022-08-23  1688  		mdp3-rsz0@1=
4003000 {
60a2fb8d202a4d Moudy Ho                   2022-08-23  1689  			compatible=
 =3D "mediatek,mt8183-mdp3-rsz";
60a2fb8d202a4d Moudy Ho                   2022-08-23  1690  			reg =3D <0=
 0x14003000 0 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1691  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1692  			mediatek,g=
ce-events =3D <CMDQ_EVENT_MDP_RSZ0_SOF>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1693  					      <C=
MDQ_EVENT_MDP_RSZ0_EOF>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1694  			clocks =3D=
 <&mmsys CLK_MM_MDP_RSZ0>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1695  		};
60a2fb8d202a4d Moudy Ho                   2022-08-23  1696 =20
60a2fb8d202a4d Moudy Ho                   2022-08-23  1697  		mdp3-rsz1@1=
4004000 {
60a2fb8d202a4d Moudy Ho                   2022-08-23  1698  			compatible=
 =3D "mediatek,mt8183-mdp3-rsz";
60a2fb8d202a4d Moudy Ho                   2022-08-23  1699  			reg =3D <0=
 0x14004000 0 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1700  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1701  			mediatek,g=
ce-events =3D <CMDQ_EVENT_MDP_RSZ1_SOF>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1702  					      <C=
MDQ_EVENT_MDP_RSZ1_EOF>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1703  			clocks =3D=
 <&mmsys CLK_MM_MDP_RSZ1>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1704  		};
60a2fb8d202a4d Moudy Ho                   2022-08-23  1705 =20
188ffcd7fea79a Moudy Ho                   2023-10-30  1706  		dma-control=
ler@14005000 {
60a2fb8d202a4d Moudy Ho                   2022-08-23  1707  			compatible=
 =3D "mediatek,mt8183-mdp3-wrot";
60a2fb8d202a4d Moudy Ho                   2022-08-23  1708  			reg =3D <0=
 0x14005000 0 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1709  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1710  			mediatek,g=
ce-events =3D <CMDQ_EVENT_MDP_WROT0_SOF>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1711  					      <C=
MDQ_EVENT_MDP_WROT0_EOF>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1712  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1713  			clocks =3D=
 <&mmsys CLK_MM_MDP_WROT0>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1714  			iommus =3D=
 <&iommu M4U_PORT_MDP_WROT0>;
188ffcd7fea79a Moudy Ho                   2023-10-30  1715  			#dma-cells=
 =3D <1>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1716  		};
60a2fb8d202a4d Moudy Ho                   2022-08-23  1717 =20
60a2fb8d202a4d Moudy Ho                   2022-08-23  1718  		mdp3-wdma@1=
4006000 {
60a2fb8d202a4d Moudy Ho                   2022-08-23  1719  			compatible=
 =3D "mediatek,mt8183-mdp3-wdma";
60a2fb8d202a4d Moudy Ho                   2022-08-23  1720  			reg =3D <0=
 0x14006000 0 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1721  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1722  			mediatek,g=
ce-events =3D <CMDQ_EVENT_MDP_WDMA0_SOF>,
60a2fb8d202a4d Moudy Ho                   2022-08-23  1723  					      <C=
MDQ_EVENT_MDP_WDMA0_EOF>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1724  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1725  			clocks =3D=
 <&mmsys CLK_MM_MDP_WDMA0>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1726  			iommus =3D=
 <&iommu M4U_PORT_MDP_WDMA0>;
60a2fb8d202a4d Moudy Ho                   2022-08-23  1727  		};
60a2fb8d202a4d Moudy Ho                   2022-08-23  1728 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1729  		ovl0: ovl@1=
4008000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1730  			compatible=
 =3D "mediatek,mt8183-disp-ovl";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1731  			reg =3D <0=
 0x14008000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1732  			interrupts=
 =3D <GIC_SPI 225 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1733  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1734  			clocks =3D=
 <&mmsys CLK_MM_DISP_OVL0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1735  			iommus =3D=
 <&iommu M4U_PORT_DISP_OVL0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1736  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x8000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1737  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1738 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1739  		ovl_2l0: ov=
l@14009000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1740  			compatible=
 =3D "mediatek,mt8183-disp-ovl-2l";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1741  			reg =3D <0=
 0x14009000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1742  			interrupts=
 =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1743  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1744  			clocks =3D=
 <&mmsys CLK_MM_DISP_OVL0_2L>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1745  			iommus =3D=
 <&iommu M4U_PORT_DISP_2L_OVL0_LARB0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1746  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1747  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1748 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1749  		ovl_2l1: ov=
l@1400a000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1750  			compatible=
 =3D "mediatek,mt8183-disp-ovl-2l";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1751  			reg =3D <0=
 0x1400a000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1752  			interrupts=
 =3D <GIC_SPI 227 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1753  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1754  			clocks =3D=
 <&mmsys CLK_MM_DISP_OVL1_2L>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1755  			iommus =3D=
 <&iommu M4U_PORT_DISP_2L_OVL1_LARB0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1756  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1757  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1758 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1759  		rdma0: rdma=
@1400b000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1760  			compatible=
 =3D "mediatek,mt8183-disp-rdma";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1761  			reg =3D <0=
 0x1400b000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1762  			interrupts=
 =3D <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1763  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1764  			clocks =3D=
 <&mmsys CLK_MM_DISP_RDMA0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1765  			iommus =3D=
 <&iommu M4U_PORT_DISP_RDMA0>;
431368c2648b59 Yongqiang Niu              2021-01-28  1766  			mediatek,r=
dma-fifo-size =3D <5120>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1767  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1768  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1769 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1770  		rdma1: rdma=
@1400c000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1771  			compatible=
 =3D "mediatek,mt8183-disp-rdma";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1772  			reg =3D <0=
 0x1400c000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1773  			interrupts=
 =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1774  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1775  			clocks =3D=
 <&mmsys CLK_MM_DISP_RDMA1>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1776  			iommus =3D=
 <&iommu M4U_PORT_DISP_RDMA1>;
431368c2648b59 Yongqiang Niu              2021-01-28  1777  			mediatek,r=
dma-fifo-size =3D <2048>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1778  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1779  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1780 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1781  		color0: col=
or@1400e000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1782  			compatible=
 =3D "mediatek,mt8183-disp-color",
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1783  				     "med=
iatek,mt8173-disp-color";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1784  			reg =3D <0=
 0x1400e000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1785  			interrupts=
 =3D <GIC_SPI 231 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1786  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1787  			clocks =3D=
 <&mmsys CLK_MM_DISP_COLOR0>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1788  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1789  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1790 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1791  		ccorr0: cco=
rr@1400f000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1792  			compatible=
 =3D "mediatek,mt8183-disp-ccorr";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1793  			reg =3D <0=
 0x1400f000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1794  			interrupts=
 =3D <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1795  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1796  			clocks =3D=
 <&mmsys CLK_MM_DISP_CCORR0>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1797  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1798  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1799 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1800  		aal0: aal@1=
4010000 {
71b946e9505510 Rex-BC Chen                2022-04-11  1801  			compatible=
 =3D "mediatek,mt8183-disp-aal";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1802  			reg =3D <0=
 0x14010000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1803  			interrupts=
 =3D <GIC_SPI 233 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1804  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1805  			clocks =3D=
 <&mmsys CLK_MM_DISP_AAL0>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1806  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1401XXXX 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1807  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1808 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1809  		gamma0: gam=
ma@14011000 {
9a2cb5eba7ad4f Yongqiang Niu              2021-01-28  1810  			compatible=
 =3D "mediatek,mt8183-disp-gamma";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1811  			reg =3D <0=
 0x14011000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1812  			interrupts=
 =3D <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1813  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1814  			clocks =3D=
 <&mmsys CLK_MM_DISP_GAMMA0>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1815  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1816  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1817 =20
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1818  		dither0: di=
ther@14012000 {
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1819  			compatible=
 =3D "mediatek,mt8183-disp-dither";
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1820  			reg =3D <0=
 0x14012000 0 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1821  			interrupts=
 =3D <GIC_SPI 235 IRQ_TYPE_LEVEL_LOW>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1822  			power-doma=
ins =3D <&spm MT8183_POWER_DOMAIN_DISP>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1823  			clocks =3D=
 <&mmsys CLK_MM_DISP_DITHER0>;
b7a8f50a143716 Hsin-Yi Wang               2021-03-24  1824  			mediatek,g=
ce-client-reg =3D <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1825  		};
91f9c963ce79fc Enric Balletbo i Serra     2020-11-27  1826 =20
88ec840270e62e Jitao Shi                  2020-11-27 @1827  		dsi0: dsi@1=
4014000 {

:::::: The code at line 1827 was first introduced by commit
:::::: 88ec840270e62e18dac4bb678fb0823077378b8d arm64: dts: mt8183: Add d=
si node

:::::: TO: Jitao Shi <jitao.shi@mediatek.com>
:::::: CC: Matthias Brugger <matthias.bgg@gmail.com>

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



