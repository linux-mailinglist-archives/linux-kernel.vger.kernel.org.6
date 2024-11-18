Return-Path: <linux-kernel+bounces-413285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992E49D16E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564DC281177
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478651C174E;
	Mon, 18 Nov 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="RSxKzVVW"
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3407198E99
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950208; cv=fail; b=sRodysDOvID49EaW1iXEuy1njrIQ2mPm+wajc9kDwmbSZgzNFz93g+RD03kzyyGTN8QnQzJobD55SiozYxvNDmok9BDCqBDcJtQsjKhwQhRg6QtzkeRmG5e/R3C9c4umkbkk7hX1MyZfM3VAAOYOXG5KAIsWqpnHkMkfqU13d7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950208; c=relaxed/simple;
	bh=YEj4d0CDy9WKc2yWVHFDBi+vGAaSCjkDQaqe5KEgGcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AjBBLU0r9Nldr37R6PlCooNTAujv8l8blxA1Vjq10jp6UyNuSrOlpQQd5EvA06wtQQfD5OE+mtPUs68GrqyCnGoVbEniL/Nc3M3tndUdh46FvOXvN5CaNIvo64O9ShEgqboPRHjH/UY1jJRQ7SQ5IqABCM0FIta0JDMrB1lvGwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=RSxKzVVW; arc=fail smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5124; q=dns/txt; s=iport;
  t=1731950205; x=1733159805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YEj4d0CDy9WKc2yWVHFDBi+vGAaSCjkDQaqe5KEgGcg=;
  b=RSxKzVVWkLVA5qfRqlvAIjPiLCN9tnVcuEEnffHbCjvJK+S0VmL90PUv
   zYd3jZ3+niH/kE1cBT6vRZJ4qMIPGeFZzSn/aoXJs7DJ8CBKWM806CbgL
   z95+Q+mGJICL+9IdqVufyeV6Qc0zzSAcpqrW6HgQ6QCDnF2M1lypu7hPK
   g=;
X-CSE-ConnectionGUID: CNOHc+n3TU6lvvCN95lk5A==
X-CSE-MsgGUID: hifvvy+kRyuO7uUj3+LIGg==
X-IPAS-Result: =?us-ascii?q?A0BCAAC/dTtn/4//Ja1aHQEBAQEJARIBBQUBQCWBGggBC?=
 =?us-ascii?q?wGBcVIHghKFHYNMA4ROX4ZRggQdA4V6jHGLLBSBag8BAQENAkQEAQGFBwIWi?=
 =?us-ascii?q?jcCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGW?=
 =?us-ascii?q?wEBAQMSERE3DhACAQgYAgImAgICDiEVEAIEDhkHB4VEAwGkfgGBQAKKK3qBM?=
 =?us-ascii?q?oEB4CAYgQIuAYhLAYFsg32EdycbgUlEgRWCKIECPoQqGYNbgmkEgkGCZoIpJ?=
 =?us-ascii?q?YETh2yJdpAXCUl7HANZIREBSwo1DDgrRiEsA4JHgjWBUoJGgRSDLoFeBTcKg?=
 =?us-ascii?q?wmBNDcCDQKCRXMfh2aBC4Nhg0WBGYFtgh4dQAN4PTUUGwY9oxAuPkRMITCBR?=
 =?us-ascii?q?U2TDINHAUmvLQqEGp46g2mDcY0CmUguh1uQbppSiFOFWAIEAgQFAg8BAQaBZ?=
 =?us-ascii?q?zyBWXAVgyNRGQ/YQIEzAgcLAQEDCZMBAQE?=
IronPort-PHdr: A9a23:UUJ5HxIUFO8afIAF2NmcuVQyDhhOgF28FhQe5pxijKpBbeH4uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:0KjDiq9eDYWV3gXbKZduDrUD1n+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 TZLWG6APv/YNGr2L4x0bIW29kpS75LXzdZnTARkqSlEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWItaztEs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kdG6o48aVxWl1zq
 /gGNhsrP02HhL+flefTpulE3qzPLeHxN48Z/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Yn1lQ/UPrSmM+kj3/+fjlHoXqepLE85C7YywkZPL3FaoWPIYPaHZkE9qqej
 mLH8XrnE1IZDs2C7mWYz3D3xcvusiyuDer+E5X9rJaGmma7wm0VFQ1TVlahp/S9olCxVsgZK
 EEO/Ccq668o+ySWosLVRRa0pjuA+xUbQdcVS7N84wCWwa2S6AGcboQZcgN8hBUdnJZebRQh1
 0SCmJXiAjkHjVFfYSLHnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:FR+2pKCtAbgmhWrlHejQsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskduZJhBo7y90KnpewK7yXbsibNhc4tKLzOWyVdAS7sSrLcKogeQVBEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIU+rIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfhTL0N1LNTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDs1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN+NyMBv/McTvLq0TtngDhO6t
 MT44tfjesOMfr0plW72zEPbWAwqqP7mwt5rQdZtQ0ubWJXUs4ikWVYxjIXLH/FdxiKtLzO14
 JVfZzhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: 9a23:N+Y9QG2ADVJZ1k07kddyTrxfMeYCUnaeyizsHhG8F3hCbuzITVzN0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AOuNL8w+rcE2+eG12Ce2anOeQf8dp7bqwGQMOq4Q?=
 =?us-ascii?q?bnJaZCC4reBO8ozviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 17:15:24 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id AE47418000251
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:15:24 +0000 (GMT)
X-CSE-ConnectionGUID: GCNO6TczTvWc808n2Hl8eg==
X-CSE-MsgGUID: SsPjXbdzS6279ZvqPPRmEQ==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="29642270"
Received: from mail-mw2nam10lp2047.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.47])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 17:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH09o6KUJvDa09lb7D4oey8VE8lD/WitDLlWj+9Md74eQRc6Jrd4Sbun2gnligBdG0AIVQZiMH6qlbxEN49359D1qhiObsRJN+uvHednUwTro230IZKf+P3v3/RRyirpM296/DfqEquElmP2OJG1q2GwmFGeag1+G7fdXzi6XJPpeWbR0yU7lI+kw7YNKA205Dn3qrBp68GGm/kHxRxRuvcwMUPEpqVZ1405ocd5AQ+XGUAEzG0ZSyM22HOGPZ0jK9xpHoT7sSCO3KQvGIi9PSUZ/LopBpjpOjtRY+XD9j3W1FEKMy8On8/Wy5NN3jtEHVOF/Z0pMXS8prSbcUjd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEj4d0CDy9WKc2yWVHFDBi+vGAaSCjkDQaqe5KEgGcg=;
 b=BrC3ip1SLXViCJHNm2n8guedv2wJLuw+uxNCXLmRG3Smqop+0ENqN3xxWCfWOQq0gSNvDTQAinRtThpnfDa7TjV9iIdQhjQavPkZ+AJ3XLGxtoyGca3bGXvVMvmFcxjTOdsyC6Qqxm5MmHQk98aptfMdvbUHxM+43THk4hEsd1LXYnoc/otoPwl8fOzNkF0ho7Bo1bIobaYHNAkGevcLQED4GgEv0YMTDJq4bWEaJfAndooM6xXNkrC5o87LACbfr/6zp/K0Tj+WEi3H4u5QqpWV1qEtAexmCrl3jH9Td3y3O/d9xIaaWwgWyqMnl+vyHSjadfkgfZFOpRz0sCT0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 17:15:17 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 17:15:17 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Mon, 18 Nov 2024 17:15:17 +0000
Message-ID: <Zzt2JNchK9A0pSlZ@goliath>
References: <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
In-Reply-To: <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|CH3PR11MB8342:EE_
x-ms-office365-filtering-correlation-id: 3f7b9476-2640-43fe-cc91-08dd07f492fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0Z1ZXJKMW5OTHJOYVhsNWRWaEdsekxPR2E2Ni9MYU93RzFUcTh6ZnFhZ1pZ?=
 =?utf-8?B?ZitBVXBocXRpWDBFa1JEYVJSMnRTLzVQdEQxeUxTTFFUMU92TlhGSzdibkFh?=
 =?utf-8?B?a1NneFRMMW5naGRIS3NJL002WUN4OEczN1BralhMK21GS2xlTFZCWjZFL1Vj?=
 =?utf-8?B?VGNLc1NNNEovMTUvdnlkdHdkaHZqRzRwVzdZMGJXZ3hxcExnQUVGby82SUI5?=
 =?utf-8?B?by9qSXJDOERTNlE2c1dVWGQxaXk0VEg0TUJ5ZSs5TWsybUdwMFYza0YreU0r?=
 =?utf-8?B?d2tONElhTmZzT09YWUphTTlmdzNMa0laYm0renJldkQ0YWl5dkJ0cFFMVzJj?=
 =?utf-8?B?bDBvUEJmeFl4NHNaSTZ3bzlmK1ZKVWhOdmUvOURUMTVVTTBTRHFRNzVGbmxL?=
 =?utf-8?B?RUlOU2FrYjRxd2pkdk8rbVByNDd2SDh1Nk1CT2pwVTR2OFEyYjlveUt3NEZQ?=
 =?utf-8?B?UHhXUzhqeVBOK0ZrMTZNa3VJYjdHZ2FpRTZQYk9xZ2NsZDlJQmlkNDltRDAy?=
 =?utf-8?B?eEVuSEVZY1RJeUNITlcwVm1vZ0ZEWVRaNVZBeUlZWmlMUGU4REVpRmQ1S3kr?=
 =?utf-8?B?S0lEMllnb1hVZmxUbzlaeUtZNmxBeDNLZUVhSS9sOTlsb2RnMVlWcm5INGp3?=
 =?utf-8?B?TlBZN0hnWVVEK0g4V2VuMDEvR2hqRWlLek9EdXFpZmJnNlNPUFBXbGNoc3dk?=
 =?utf-8?B?c0NmOXBQdmw0MFQxN3NnNlRBNmJBUDAxMlB3Y1Ntc3IrdytCbUNMMy94V0dF?=
 =?utf-8?B?YTltVEhwK1lGcXFwTVhnRlVvTGtpS0lFSUhld1lvWlJ6L2ljYTFqRDhYNDl1?=
 =?utf-8?B?ZERjSmdEb1U5WGYwZTV4WkZrckNNVjRtQ04zZGhDc2k1dFRwT1pJY01FeTI2?=
 =?utf-8?B?VnhJMjlpenVxZXB0MUxkNThyMVZYMDc1dHJmZGN6aFV2SWZvRzU1OE1SdzA1?=
 =?utf-8?B?QkJkK1ZuRjA5cUNYY0FlUEZUNDJINHJKT2VuSk5SMUw1MytIOXBiZFhETklt?=
 =?utf-8?B?THV2YUdBcTl2L2lIUjdVSTJEM3ovUU0zWUdxRXZwQ1Jxa1lFclpWaFU5bTlr?=
 =?utf-8?B?eXNCYStMTVJ5TmhzWS8zRExBMDd4Q3g5ZDcrNUcyRTNzY09KOEUvNk81QjhD?=
 =?utf-8?B?TEtBM2VvREhxV0FGUkhoRlJZZDY1b2ora0orTGtLZnpsVjNYYUcwUlpkOTJX?=
 =?utf-8?B?SnlLRnd5UkxMbGErQ3k3emlFZFowdWtCRVN3ZFNYY1IyYmJ2aGp4MlUyWFBt?=
 =?utf-8?B?QWxOQVJndTdsZkRjT0kwOWFQYlVUdm5ZVkVnU1JSQmI2Z1cxV1pHVEFBUWVH?=
 =?utf-8?B?emtFd2tWV214cHVLWXhnTDlHckh5N1VFTUMxcU8wRXo4bit5RXNlRVJiM2Ns?=
 =?utf-8?B?SUFLMW1ML3FzRU9Yc2ExYXk2cGdvT1JoVHpxODh3TU9iL1N0eXlzSmZMNDg5?=
 =?utf-8?B?UkNSVzdObkU2MEtIbWEvNEJnVnBaZlZtc3c3SEIvVVQzbm52WHpTZUVTbXBO?=
 =?utf-8?B?ZkFYWGJ1b2U5THY0dndZZENEVXZDUzdYb2tSdU9xdHJ1ek5hTUlKVnpZRVhk?=
 =?utf-8?B?eDJNYWlaUytTRUtxbzhFQkxGVHJkQ2pLdDkwNDI3VmFDeUcvdUxJMklxRlNT?=
 =?utf-8?B?UitzU0dVSnBna2k0ZFFpMHJwOUcwQzlLN1B3MVFUaXFGSnJVQ2NNNkZac3BJ?=
 =?utf-8?B?dTlpTVlmMDkxRk5uUjBkWmpTUXhUMno5ZnNlR05HRHF0ay8zcVFVcmJSQWNs?=
 =?utf-8?B?QlRMaEprOFZ4bmwzZWtmVEUxVWdOeS9halcwSmU2TUFqWit4b0VHMm9BM1BT?=
 =?utf-8?Q?rHSfbkbXMnMW1Ji7L3NCSuSMDiFB3OUuBfcA8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MngwWEY3ZENkNWZ3VHU3VEp1NkkyUi9rdmNoTFMvUURBeEJ0V2xobHJLbE1i?=
 =?utf-8?B?Vm1uTURydHlUUFFYc3BkUUhXMDFjUjhGK0tQSklGWm9YNC9RdWZJNHkvWTJV?=
 =?utf-8?B?MmtCRkdjRE9xcmFjOXh6VWNnUXpSdGYrOVZBMUNXdDVRYzl2SGJKVkxtNUdZ?=
 =?utf-8?B?TUt5VjFOR2Rjc2huMzBVVnBmdXRHSTRaS1BWMWVleUp3RGFCRzU3RVVnZnY2?=
 =?utf-8?B?cERCeEp4L28vcHFIOUp2SSthcEpRTGdHUFNhWW45WnhyZjJSVFF4YmNIRFpR?=
 =?utf-8?B?MlJRU24vSTROanVLdEp2RkNBT1VmUmF0bVpuLzlQYmZVcHQ0cFo0SklTN3lS?=
 =?utf-8?B?b0JtS25iVENpVlYvb2s4NEtCN28zalJ2Z0F6UjlXOCtycXF4U0tmU2dNa2xn?=
 =?utf-8?B?OW5uRXpJTU5UcmZsdFB5QWt2cXF2bGRwQkFLYXk2SmtQMTYvc3crVU5mdEtq?=
 =?utf-8?B?Q2tuZmo4bitKYlNpVnMzcHFzcllnbEtTQ1pPVERUQnZxSmx1bWx0NVpQWE9B?=
 =?utf-8?B?cklBWXRDVzNydS9hbHhrMGxuNDRrZjcweUJEajE2OUhWQlc5dnlHWE90WDVi?=
 =?utf-8?B?NExGTk96K0ZmcGpHUXZtbTVvcW1FeFBsaTV5cDVlN0RGWnNPVWxaN0MvbjdR?=
 =?utf-8?B?TXdhOWpjYTQwVEZZTDNzQUk2V3VDNzZJU0FTWGZ5cXBoSnRIUEY2OXo1UkpG?=
 =?utf-8?B?NXZWMFRZdFNIV2hENi9uOTA3bmxIbWlLclJCVVZIM3pxcXBIb2gwUjNIUGR3?=
 =?utf-8?B?RTlaMUtSSGxqR3BKTlBTcG9GNU1hRE5ZdHBFNmtaS1NqMDdtYTNnTWdyOWtv?=
 =?utf-8?B?RmFwcUxmdmd1SjhPamU2bGZCcU5GeHdRMFduUVNuQjY1QlI4OHZPWWcxdHFv?=
 =?utf-8?B?bDByTlFjYTdUWHVPN3ZNaExMQ2M3aGEwZWdFalNpczVoaDVnTWFLOTlrRm9D?=
 =?utf-8?B?QXlVWUhlSXlzVHQ1bkFQdHJLSGlVZ25hRXUxSTFpakhNSmkwRWxYeDltSlZ2?=
 =?utf-8?B?djRmaUpzQjNQWjEwVFlDZzVCeXZ2SVpQMHRUaGNDUHo5QitXbFppVTRZaGhS?=
 =?utf-8?B?bE5zU3JJMlFhbGltYW1uNnphQk5SOWZtakR3akZvOXQ0QUord1JEK3B5QTRE?=
 =?utf-8?B?YlZDK2pjUWMzUGszZVZ2bFNtM1hXSmd1MWlqbjRmL01kcG85ZkhHdWw1dUUw?=
 =?utf-8?B?emdQZytiVWVwNnlDNnFVQ2djZlRmWFpHay82MzVqM1YyQkhIT3M1aExMcDZ3?=
 =?utf-8?B?aUtjek1iV2U5OHRLRWJnQ05IeUMydEEvSmFNOUVWaWhVcEx5VSsvVExod25X?=
 =?utf-8?B?cFB1K1VPaWt2SFRDUGdVM0dsZjFLUGU2cm1DNzBjMEJFUTJBVGlJa1I2Ky9i?=
 =?utf-8?B?U2dGb1l0OU5SNnVzc0Z1VnVoWlQ2SDVwSG51SUNoZ0t3ZVg1T2tsZzhWbi9q?=
 =?utf-8?B?cndpdXlpa0lqeUgyY28rRTJJT01hU3doOE5GU0VxNGNEK2llM0tGUWFjd1hV?=
 =?utf-8?B?OEwvZXlXN1ErZWJ1NVRHWW5MQWVnTVpIRGlHTDhOWnA0OVpiTFhlQ0ZaMkJu?=
 =?utf-8?B?SFZaZUNrUVJKSFdjWWkyeGxvSUxzRTRqUjArcnpmbWFudEtSc2VXK21UeXFB?=
 =?utf-8?B?bSszRG9IRWE2UXVyQUhWRVhPd3BnempnOWtMdmNiYjh3WmIvZTNnVDJSZnZR?=
 =?utf-8?B?TUxCMXdYS3o3U2pLajdEdzFiSVdtVmxnbzlXNTljdDdWZThpdSt6MlFiSWQ2?=
 =?utf-8?B?dzBtbjFGaWhEVlZCTHU5M2dlT0ZWV2FZVmlReW9jc0ZDZjVXb1VsMkd0bkVq?=
 =?utf-8?B?SnBtL2JXK0dZK01EaDk0WTV5eG0wZ0RoaE5yYURiWmVCT2pwaDNtcGk5a3Vr?=
 =?utf-8?B?T0xaOHJlMHdVTkxzUzAxVGJJWjJiRlFsMThaSDEwWkNrM3l5c2N0TXZ0c0lH?=
 =?utf-8?B?RGlOblFYdEpsZlI4Z3JoNm0va05nWWlLWlNrMjAzNkJqMnJvWHZiRTNsM2Jr?=
 =?utf-8?B?VnJEV25NbTNtMW9vTjBmcDNxOXk2a1NjbFA2OVVpZWFpMkpPb0dnZURqZmtH?=
 =?utf-8?B?V0tWVzk5MEV2WDVEZktkWG45R00vNlplcW1HeGNsY0ZxUndlUi9pOXNWQWU0?=
 =?utf-8?Q?EkSe9pznKOF+VEPlLy8ZMWuOZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6BE70419036D4F96D96E4B0264D57E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b9476-2640-43fe-cc91-08dd07f492fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 17:15:17.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdxQxVKOVCn0BiSwGwvG06TBpnyukegzHbzP5TyDwGCF2ce0cg6GYqclb+s7qeSrKlzb+99g9GfmKch+FiHqPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

T24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDU6MDA6NTJQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3
cm90ZToNCj4gSGksDQo+IA0KPiBPbiAxOC1Ob3YtMjQgNDo1NSBQTSwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiA+IE9uIE1vbiwgTm92IDE4LCAyMDI0IGF0IDAyOjM1OjQ0UE0gKzAwMDAsIERh
bmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToNCj4gPj4gT24gTW9uLCBOb3YgMTgsIDIwMjQg
YXQgMDM6NDk6MzJQTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+Pj4gT24gTW9u
LCBOb3YgMTgsIDIwMjQgYXQgMDE6MzI6NTVQTSArMDAwMCwgRGFuaWVsIFdhbGtlciAoZGFuaWVs
d2EpIHdyb3RlOg0KPiA+Pj4+IE9uIE1vbiwgTm92IDE4LCAyMDI0IGF0IDAzOjI0OjIwUE0gKzAy
MDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPj4+Pj4gT24gTW9uLCBOb3YgMTgsIDIwMjQg
YXQgMTI6NDA6MTZQTSArMDAwMCwgRGFuaWVsIFdhbGtlciAoZGFuaWVsd2EpIHdyb3RlOg0KPiA+
IA0KPiA+IC4uLg0KPiA+IA0KPiA+Pj4+PiBBcmUgeW91IHJlZmVycmluZyB0byBMUEMgR1BJTz8N
Cj4gPj4+PiAgDQo+ID4+Pj4gIEkgZG9uJ3Qga25vdyB0aGUgaGFyZHdhcmUgd2VsbCBlbm91Z2gg
dG8gc2F5IGZvciBjZXJ0YWluLiBJdCdzIHdoYXRldmVyIGRldmljZSA4MDg2OjE5ZGQgaXMuDQo+
ID4+Pg0KPiA+Pj4gVGhpcyBpcyBkZXZpY2Ugd2hpY2ggcmVwcmVzZW50cyBwMnNiLiBJdCdzIG5v
dCBhIEdQSU8gZGV2aWNlIHlvdSBhcmUgdGFsa2luZw0KPiA+Pj4gYWJvdXQgZm9yIHN1cmUuIFlv
dSBjYW4gc2VuZCBwcml2YXRlbHkgbW9yZSBkZXRhaWxlZCBpbmZvIGluIGNhc2UgdGhpcyBpcyBz
aG91bGRuJ3QNCj4gPj4+IGJlIG9uIHB1YmxpYyB0byBtZSB0byB1bmRlcnN0YW5kIHdoYXQgd291
bGQgYmUgdGhlIGJlc3QgYXBwcm9hY2ggdG8gZml4IHlvdXIgaXNzdWUuDQo+ID4+DQo+ID4+IEhl
cmUncyBhIGNvbW1lbnQsDQo+ID4+DQo+ID4+IC8qIElOVEVMIERlbnZlcnRvbiBHUElPIHJlZ2lz
dGVycyBhcmUgYWNjZXNzaWJsZSB1c2luZyBTQlJFR19CQVIoYmFyIDApIGFzIGJhc2UgKi8NCj4g
Pj4NCj4gPj4gV2UgaGF2ZSBncGlvIHdpcmVkIHRvIGFuIEZQR0EgYW5kIEkgYmVsaWV2ZSB0aGUg
Z3BpbyBsaW5lIGlzIHVzZWQgdG8gcmVzZXQgdGhlDQo+ID4+IGZwZ2EuDQo+ID4+DQo+ID4+IFNv
IHRoZSBwY2kgcmVzb3VyY2VzIGF0dGFjaGVkIHRvIDgwODY6MTlkZCBjYW4gYmUgdXNlZCB0byBh
Y2Nlc3MgZ3BpbyBvZiBzb21lDQo+ID4+IHR5cGUuIA0KPiA+Pg0KPiA+PiBJJ20gbm90IGEgcGNp
IGV4cGVydCBidXQgb24gdGhlIDE5YmIgZGV2aWNlIGJhciAwIHdlIHVzZSB0aGUgYmVsb3cgb2Zm
c2V0IHRvIG1hbmlwdWxhdGUNCj4gPj4gdGhlIGdwaW8sDQo+ID4+DQo+ID4+ICNkZWZpbmUgSU5U
RUxfR1BJT19SRUdfUkVTRVRfT0ZGU0VUICAgICAgICAgIDB4QzUwNTc4DQo+ID4+DQo+ID4+IFRo
ZSBjb21tZW50cyBzdWdnZXN0IHRoaXMgaXMgZ3BpbyA2LiBJIHdvdWxkIHNlZW1zIHlvdXIgcmVh
Y3Rpb24gd291bGQgYmUgdGhhdA0KPiA+PiB0aGVyZSBpcyBubyBncGlvIG9uIHRoZSAxOWRkIGRl
dmljZS4gTWF5YmUgb3VyIGRyaXZlciBpcyBhY2Nlc3MgZ3BpbyB0aHJ1IHAyc2INCj4gPj4gb3Ig
c29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gPj4NCj4gPj4gRG9lcyB0aGUgb2Zmc2V0IGFib3ZlIG1h
a2Ugc2Vuc2UgdG8geW91IGluIHRoZSBjb250ZXh0IG9mIHRoZSBwMnNiID8NCj4gPiANCj4gPiBZ
ZXMsIGV2ZXJ5dGhpbmcgbWFrZXMgc2Vuc2UuIFBsZWFzZSwgZW5hYmxlIGxwY19pY2ggZHJpdmVy
IGFuZCBmb3JnZXQgYWJvdXQNCj4gPiB0YWxraW5nIHRvIHRoZSBwMnNiIG1lbW9yeSBtYXBwZWQg
SU8uDQo+ID4gDQo+ID4gLyogT2Zmc2V0IGRhdGEgZm9yIERlbnZlcnRvbiBHUElPIGNvbnRyb2xs
ZXJzICovDQo+ID4gc3RhdGljIGNvbnN0IHJlc291cmNlX3NpemVfdCBkbnZfZ3Bpb19vZmZzZXRz
W0ROVl9HUElPX05SX1JFU09VUkNFU10gPSB7DQo+ID4gCVtETlZfR1BJT19OT1JUSF0gPSAweGMy
MDAwMCwNCj4gPiAJW0ROVl9HUElPX1NPVVRIXSA9IDB4YzUwMDAwLA0KPiA+IH07DQo+ID4gDQo+
ID4gU28sIHlvdSBhcmUgdXNpbmcgYSBwaW4gZnJvbSB0aGUgQ29tbXVuaXR5ICJTb3V0aCIgb2Yg
dGhlIG9uLWRpZSBEZW52ZXJ0b24gR1BJTy4NCj4gPiANCj4gPiBJbiBFRFMgdGhpcyBjYWxsZWQg
R1BJT182LCB3aGlsZSBpbiB0aGUgZHJpdmVyIGl0J3MgcGluIDg4LCBpLmUuIFNNQjNfSUUwX0RB
VEEuDQo+ID4gDQo+ID4gWW91IHdpbGwgbmVlZCB0bw0KPiA+IC0gZW5hYmxlIGxwY19pY2ggZHJp
dmVyIChDT05GSUdfTFBDX0lDSCkNCj4gPiAtIGVuYWJsZSBJbnRlbCBEZW52ZXJ0b24gcGluIGNv
bnRyb2wgZHJpdmVyIChDT05GSUdfUElOQ1RSTF9ERU5WRVJUT04pDQo+ID4gLSByZXBsYWNlIHlv
dXIgY3VzdG9tIGFwcHJvYWNoIHRvOg0KPiA+ICAgLSBHUElPIGxvb2t1cCB0YWJsZQ0KPiA+ICAg
LSBwcm9wZXIgR1BJTyBBUElzLCBhcyBncGlvZF9nZXQoKSBvciBhbGlrZQ0KPiA+IA0KPiA+IFNl
ZSBob3cgaXQgd2FzIGRvbmUgaW4gdGhlIGN1cnJlbnQga2VybmVsIGNvZGU6DQo+ID4gDQo+ID4g
ODI0MWI1NWYxZGVkICgiZHJtL2k5MTUvZHNpOiBSZXBsYWNlIHBva2luZyBvZiBWTFYgR1BJT3Mg
YmVoaW5kIHRoZSBkcml2ZXIncyBiYWNrIikNCj4gPiBhNmM4MGJlYzNjOTMgKCJsZWRzOiBzaW1h
dGljLWlwYy1sZWRzLWdwaW86IEFkZCBHUElPIHZlcnNpb24gb2YgU2llbWVucyBkcml2ZXIiKQ0K
PiA+IA0KPiA+IEhhbnMsIHRoZXJlIHdpbGwgYmUgbm8gbmVlZCB0byBmaXggYW55dGhpbmcgaWYg
dGhleSBpbXBsZW1lbnQgY29ycmVjdCBhY2Nlc3MNCj4gPiB0byB0aGUgR1BJTywgaS5lLiB2aWEg
ZHJpdmVyIGFuZCBib2FyZCBjb2RlIHdpdGggR1BJTyBsb29rdXAgdGFibGVzLg0KPiANCj4gQWdy
ZWVkLCBzdGlsbCBJJ20gbm90IHN1cmUgaG93IEkgZmVlbCBhYm91dCB1cyBoaWRpbmcgdGhlIHBy
ZXZpb3VzbHkgdW5oaWRkZW4gUDJTQi4NCj4gDQo+IE9UT0ggSSBndWVzcyBpdCBtYXkgaGF2ZSBv
bmx5IGJlZW4gdW5oaWRkZW4gaW4gdGhlIEJJT1MgdG8gbWFrZSB0aGUgaGFjayB0aGV5DQo+IGFy
ZSB1c2luZyBwb3NzaWJsZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCkZyb20gYSBmbGV4aWJpbGl0
eSBQT1YgSSB3b3VsZCBzdWdnZXN0IGlmIHlvdSBjYW4gbm90IGhpZGUgaXQgaWYgaXQncyBub3Qg
YWxyZWFkeQ0KaGlkZGVuIGJ5IHRoZSBCSU9TIHRoYXQgd291bGQgYmUgYmV0dGVyIHNpbmNlIHNv
bWUgY29tcGFueSBtYXkgaGF2ZSBhIGdvb2QNCnJlYXNvbiB0byBtYWtlIGEgY3VzdG9tIGRyaXZl
ciBvciB0byBleHBvcnQgdGhlIHBjaSBkZXZpY2UgdG8gdXNlcnNwYWNlIHRocnUNClVJTy4gVGhl
IGN1cnJlbnQgc2l0dWF0aW9uIGlzIHlvdSBjYW4ndCBtYWtlIGEgY3VzdG9tIGRyaXZlciBpZiBw
MnNiIGlzIGVuYWJsZQ0Kd2l0aCB0aGlzIGFkZGl0aW9uYWwgcGF0Y2ggZXZlbiBpZiB5b3UgdW5o
aWRlIHRoZSBkZXZpY2UgaW5zaWRlIHRoZSBCSU9TLg0KDQpJbiBvdXIgY2FzZSBpdCBzZWVtcyBs
aWtlIHdlIGNvdWxkIHVzZSB0aGUgYWxyZWFkeSBleGlzdGluZyBzb2x1dGlvbiB3aXRoDQpwaW5j
dHJsLCBidXQgb3RoZXJzIG1heSBub3QgYmUgYWJsZSB0byBkbyB0aGF0IG9yIG1heSBub3Qgd2Fu
dCB0byBmb3IgZGlmZmVyZW50DQpyZWFzb25zLg0KDQpEYW5pZWw=

