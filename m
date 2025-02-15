Return-Path: <linux-kernel+bounces-516395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE0A370BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A1C1892B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E007C1F1537;
	Sat, 15 Feb 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jvAMzgd4"
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54219CC39
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739653469; cv=fail; b=FxBNw8IGEDrmsS6vitABoC8UNqapPkYw7+zQ5RCH8ov7m4OLIPxdNqwAGbEny6ztjjEajqm4THD+9TZQl2q0HGGOxFcoXsO7w9c2VjCUL8BY24w2or56M8FqQ7pnAEJbz9PtZIspGMdsXrm8W5lFXOLJ6Vw29z/9cg+sO5H1Z9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739653469; c=relaxed/simple;
	bh=tt0bVLqB8q9CqxP1EAAydq551pvW9ZoJtjsSoUG6mA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaWor3Mmau0Zku6y4luKTNjLLBLoScFMWAhKgrkjdh98E7Tlo6q2AagKKmaaB9aXTqXS3DWxegaCo1/OeSfGdNatkqsrGV+HzhG24LcuBUpw0U1WlYdlhB4KA+VJRSqLAmb8Lugkd/uB//EIBQU89aBONNLrEBBsBfM8Kb8gZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jvAMzgd4; arc=fail smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2749; q=dns/txt; s=iport;
  t=1739653467; x=1740863067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EXIFFy2L2sjlCP5bwFTU2jcZFD0w7O2D6+GXr6afQSg=;
  b=jvAMzgd4+LfT3DiFPPOrXY7Qdmox59fj6d6JpmD5/XKMo/Onw6JMlmR4
   wmw2lRR0Tv/ehs4MKOo1w137rQ9qoPxKK6yAJrC6HPbF00B7tzJ5b6xFd
   Y1qP8gKwlN0d6LLvWXdrk6Wykmp6+zkg38GtGI5nSOENQ2ppoWvuiKVIA
   o=;
X-CSE-ConnectionGUID: cnrfJokhQASPFSpR7obk2w==
X-CSE-MsgGUID: dN44kKjPRNmPJg1NNDxs6g==
X-IPAS-Result: =?us-ascii?q?A0AMAAAbALFn/4oQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGwQBAQEBCwGBcVIHghJIiCEDhS2GU4IhA5g4hVyBfg8BA?=
 =?us-ascii?q?QENAkQEAQGDc4EUAosKAiY1CA4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4YIhloBAQEBAxIVEz8QAgEIGB4FCzElAgQBDQUIGoVFAwGiU?=
 =?us-ascii?q?gGBQAKKK3iBATOBAeAigUgBiE4BhWuEdycbgg2BV4JoPoRFhBOCLwSCL0qBJ?=
 =?us-ascii?q?IJZZ5cZgzWLCFJ7HANZLAFVExcLBwWBKRA4Ayo2MSOBIwU0Cjc6gg1pSToCD?=
 =?us-ascii?q?QI1gh4kWIIrgiCCOIRDXi8DAwMDgzKCQ1GCRIIScWwDAxYQgjFwehyFD4EgH?=
 =?us-ascii?q?UADC209NwYOGwUEgTUFnnk8hFhUIWyBP2SSQR1JgmuQNJ9PCoQboX0XqlIuh?=
 =?us-ascii?q?2WQaiKjb4Ehg1ICBAIEBQIPAQEGgWkBOYFZcBWDIlIZD44tFhbKDXg8AgcLA?=
 =?us-ascii?q?QEDCZFqAQE?=
IronPort-PHdr: A9a23:S3cQzhOzeQWX5z5d4Kcl6nc2WUAX0o4cdiYc7p4hzrVWfbvmotLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:DcwioK81anR/YWAV7+vhDrUD1H+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 mYaUGvTOqveZGXyc9skbdi+8BgBusXUyNdnGQpuqnpEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qpyyHjEAX9gWMsaDtJs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k9O5cW2OF0AVhnz
 sQ2Eyg3MReJhLiplefTpulE3qzPLeHiOIcZ/3UlxjbDALN+GNbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2bM3WjOX9PYH46tOShnGX+dzRbgFmUvqEwpWPUyWSd1ZC2aIuFIoXUHZw9ckCwq
 kSao2faACkgEtmn6zXc1FSAlvSRknauMG4VPPjinhJwu3WXx2oOGFgVWEG9rP2RlEGzQZRcJ
 lYS9y5oqrI9nHFHVfH0Wxm+5XrBtRkGVp8ISqsx6RqGzezf5APx6nU4cwOtoecO7acebTcrz
 VSO2djuAFRSXHe9EBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:8i/8q669LOxXGKfAggPXwYeCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICPoqTMaftW7dySSVxeBZnMffKlLbalfDH4JmpM
 Ndmu1FeaLN5DtB/IjHCWuDYqsdKbC8mcjC65a9vhJQpENRGt1dBmxCe3+m+zhNNXJ77O0CZe
 KhD6R81l2dUEVSRP6WQlMCWO/OrcDKkpXJXT4qbiRM1CC+yRmTxPrfCRa34jcyOgkj/V4lyw
 f4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKx334zzYJLhJavmnhnQYseuv4FElnJ
 3nuBE7Jfl+7HvXYyWcvQbt4Q/9yzwjgkWSimNwwEGT4/ARdghKT/aptrgpNScxLHBQ+u2U5Z
 g7ml5xcaAnVC8o0h6Nv+QgHCsa5nZc6UBS4tL7yUYvELf3rNRq3NYiFIQ/KuZaIAvqrI8gC+
 VgF8fa+bJfdk6bdWnQui11zMWrRWlbJGbMfqEugL3d79FtpgEw82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TjWle2OADEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiJ8/go
 7IXl9UvXM7P0juFcqN1ptW9Q2lehT2YR39jsVFo5RpsLz1Q7TmdSWFVVA1isOl5+4SB8XKMs
 zDTq6+w8WTWlcGNbw5qzEWAaMiW0X2ePdlz+oGZw==
X-Talos-CUID: 9a23:B8mTXGM1Ak2xKu5DUy99+mwTGcAcW0bl4kzIGRC/A2UzV+jA
X-Talos-MUID: 9a23:tLC1KwnbkSr/Q+dL4EKQdnpuEps04IesMHorlK0ktJCiEwBgIGmS2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Feb 2025 21:03:18 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 44D941800019B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 21:03:18 +0000 (GMT)
X-CSE-ConnectionGUID: RHFAsKUfRBO7ieIJcQE9nA==
X-CSE-MsgGUID: pYBuvUSKT3WfekUFaKbfZA==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,289,1732579200"; 
   d="scan'208";a="22826113"
Received: from mail-dm6nam10lp2047.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.47])
  by alln-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Feb 2025 21:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWJ+Ra0/04a2l+rGcJAkJ6Xh727LP3WkxQRm3lHY86x6SN78pnn1h5mhfksshOHo1BDqkVwkWQxZEMqL9q1WVx7XXzw6hy09A4H+LXPP/Tw8yzIpLHhT2zec9J5sboDLlMTPNsrHyef6dFuzGI1WmbNyCvEGjKIftV0UqQelibytbyvePBcSoj53FrguT5zn8Fpl+19ukStOMUFbdAI9f5ZhVbUvGs+FH6b6qtBnjfHuPgdELu+vn7ajefxbevYyUSMz9m7uZgYJ5CMB84eYiVxiKNHPGlNU1qrBBEOFT2MRmgEdb5Nqw3OCdgbNeeTpDkbgAhnIko3BWECSZT8vDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXIFFy2L2sjlCP5bwFTU2jcZFD0w7O2D6+GXr6afQSg=;
 b=AS4Zj8CAqRGiXxSUzwL7EHj+oS0KSWghYgIvNPP0dJZpUfMJe4sXd/OsGYvI+mEZ9lqLJiuST/9liuUPxKuMDqponFXdhzTt46qugFM5J/aMpvl+17LkcY3lEc4DaC8o0NIggGDZBF9IYOb+U2xXkclGrLGIBqCnDVoVsmiRS6ktuRx98eLSc7LcwYKipuw9plN9s7wQ7iSS0Xcn5FIU3GSNGEKzoOD7Iw6KwsYvGzTDlWnlRvErWAX3OV+baStpn+draUiF0GXFIl/NYrgGgV5p7JbKStwEs8gtANExwnI2JL2uLHUHWU0Ad6haTEIet5pAWa+wG+k1zkxzYJqHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Sat, 15 Feb
 2025 21:03:16 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%5]) with mapi id 15.20.8445.013; Sat, 15 Feb 2025
 21:03:16 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>
CC: "lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "Sesidhar Baddela (sebaddel)"
	<sebaddel@cisco.com>, "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
	"Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>, "Arun Easi (aeasi)"
	<aeasi@cisco.com>
Subject: RE: drivers/scsi/fnic/fdls_disc.c:263
 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
Thread-Topic: drivers/scsi/fnic/fdls_disc.c:263
 fdls_schedule_oxid_free_retry_work() warn: inconsistent indenting
Thread-Index: AQHbfu60Aqs0Y1uoDU+0WvnEcG3OM7NG5RiAgAH2PjA=
Date: Sat, 15 Feb 2025 21:03:16 +0000
Message-ID:
 <SJ0PR11MB58962A4F0B9CFFB9439FF959C3F92@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
 <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
In-Reply-To: <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|IA1PR11MB7822:EE_
x-ms-office365-filtering-correlation-id: ff6782c4-a859-4d6d-f8e1-08dd4e042aeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XAlpwPAk294FupdYUcot2rpOwIb6IMY3d1+81vCeSJEkv4O29cI4jAbGRFxW?=
 =?us-ascii?Q?5Suerebf+JaM74rXBSApbjZy3HcBgwTWxOTmhAVy6yyia4AXCYPCpDNBJp72?=
 =?us-ascii?Q?PgvEyJtf94PlMCc4jNIzh9r8lFMJsANWwdZ4nQAGTu1XgW4A02B0MLzfbufK?=
 =?us-ascii?Q?4Ia5NNM79n+r0ZZfXro9dNboBBtGQfFNvfkoWj3ymvjadjo/kukszv8M318t?=
 =?us-ascii?Q?AOOZytr0v+xgCkZP+yfcfZ5+s7kF7VmD6Kgpm/vORbHwBrgXqqz6YUHcsWtm?=
 =?us-ascii?Q?61cGDPIwNfIHSUTbrxbxoTWRK/qZCKbh5ynpUcE2iuvdbsLw308BdA2WcZzV?=
 =?us-ascii?Q?J2v5+PB+RyRF2mHujXr0GirvpbsmOPqybqyuAU82ofwdygru4aAP86E35CQE?=
 =?us-ascii?Q?4eaWVlOl3bAu3Ray2lGkPdNvLwClocDpxQIbWryhhOs/QcZobmqiYcGnglCT?=
 =?us-ascii?Q?AkJhxiq70cyD4fC/VX7yhWzW/uIDn8Ct1Zc84Alul8mjq3cq2YU+ytXFygn2?=
 =?us-ascii?Q?VxOIiNyob8VPQyyrgYN4Invqv24coST/4eePVMfFBgIr5PLDYpuTQAkeVjNp?=
 =?us-ascii?Q?D90LqnHDPCh5gJkmKUSY/YeMzYVsK/+Yub3ZcGarpvQNmylHrUzfs8mCZ2eg?=
 =?us-ascii?Q?JRmHSJepq3bPiVpzN+PKxesvsldhDG7PRpytJaBO1E13/orcd/uCf7x5UOFQ?=
 =?us-ascii?Q?45f0agyP+B026ajWdJKs0EuqGBuuiKN37m68Em6kjThXUxwFjbmER6NKfo8u?=
 =?us-ascii?Q?xCZJffvRV8uvkjrYBzDw/WHY3s7dgk7tNIdrWV8NG6p/ro/2Air/3KDIekaD?=
 =?us-ascii?Q?etK3dy4oiygD4sWsWJSJFNXiK8zclvNNNMogkSrN/rxCJZVEIZlLLYbT7O/u?=
 =?us-ascii?Q?cDxtRS5Ec+uOruNkUSaeU1shAe4qqulCOqiqnP+UGXSIS4otMTYMDfzjKRRr?=
 =?us-ascii?Q?wu+Qr4W5edjy49STbh2nQ9RfleCFXa65QsKE2EJAGLXTgKFDYYp862hTxjpk?=
 =?us-ascii?Q?fKO0ps8AHslhPhQAiBcjoIDAKd5i6MG4u7U6CYfoMjiJqNKhm0oYuCFz9Fux?=
 =?us-ascii?Q?+6EB9oUfDCxbx8yYhK8KRmZPRL1Omtj2oocw6UQU/ynBeDIds0qHvNXQC2bZ?=
 =?us-ascii?Q?CRLau7ALBioJj+KmDw5zSgdvKiMzIKniopGq0O39JvVFiRpV8S0diwcacf7a?=
 =?us-ascii?Q?jlKO390QvxlUzq2W9/ig4fC9r59YXmyLIhh4lFW3+6sMIwFShAodnelh3vZM?=
 =?us-ascii?Q?j4+dZZd92hyr7xqHm4CjCEd+iPDnME1xWqcUbCIZPEDhMXDcnQLkPAKmipLm?=
 =?us-ascii?Q?b3eb1wW+vl+inrODrdl5nlyAvUavKUq2DVqyUX0q7aLLip1BMHrZGldbYkUU?=
 =?us-ascii?Q?SX/wSYDUs24KfFL3f82TlrmDnC+9CRNdqC+vugBUU2wYaeZjw4aY4+Rf6/fJ?=
 =?us-ascii?Q?IXTyuu44dOdC9XSrgr+ffmL1LAimejUB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9M2czco649vn0iSjC0WIeIuX3geDKedEjwfRAzdBOPkfZXk8K600DMJprkZT?=
 =?us-ascii?Q?e7UuVlqVJpbpdg+klK1avk5GdvmBuG8HUcDNpxiGV6J8LidkctxGp09XJjt1?=
 =?us-ascii?Q?NLmqiTK+6i+nL3fIiLDF2iw3nHnjj+TYx5QLEt9XY6p0Ot0tJFpJFmT/R73Y?=
 =?us-ascii?Q?EhF+UsqllXB6VodmvZh8XRrJVbOFqVMazX/+bHiOxvkSWqn5SQes5X3eK3UL?=
 =?us-ascii?Q?fUKIpd44Bi+LjlcskVxY9WElUA5kik05DgABCKq8mRolehoCAZJZir6YjiRB?=
 =?us-ascii?Q?VPnbTaNNvJIgAGRMMwff+Hl2geEpChQtpEogD/Gn9ucYUYbrICUY2uwB41Rm?=
 =?us-ascii?Q?ZW76IOscH8pvEhyq/G/bze1z4DqhHshb9lbzIOxmEFRHpAeHo6wYMxF/VRtD?=
 =?us-ascii?Q?LjRrTgsZk82gN4pY1EqrWPlV0LU8fIRe9QPHZCXNkizpUH1fBials5Qdyb38?=
 =?us-ascii?Q?u+lBpxWeQDO3cd8Ak7kEJY+vmK7/Fj2lExP0BQHHhJWpLD3o8JhHCbzG4KEh?=
 =?us-ascii?Q?GQ8cxf+4NU0artJZEGBOx5HvKeNZi8vjRe5aJPGVywJ+00K20ktynm8xjOWp?=
 =?us-ascii?Q?HPxJu5sTWxrkTjZYvEp7Qt01Gfo2C4sU2nn9bqFrJnJdvt8V2wxKGNoSns9h?=
 =?us-ascii?Q?DhwSH6/rgRz/XYwkcqjshIQwME/HM9imRrzY7l4Pzp53TNA9vG1EX8MJKbdL?=
 =?us-ascii?Q?6NJr2hDMfLHC492rjtZPlOnF4oK1oIZnfw8UYeIqzTUzucexHWMk0YHGds9g?=
 =?us-ascii?Q?2QOldyfdpMnsp1PlKSp6UWrQh188IF+ayNw896N8FEMZvcOPpaHazB16MXQz?=
 =?us-ascii?Q?PXQ4Ulm1Um82dzB/lc0gMKzJAzjzfma7obG7QatiYGN1biH2tt65yqHeWQRL?=
 =?us-ascii?Q?Ynn6eyiu8iETQzp6h1xon34VQRL0Wdi+ljoMmvTccdJpIvCnD+HBznnd2/Wi?=
 =?us-ascii?Q?ojO5xz4GIvKY/geAqmdMNVi+Jxp+zamwc9DCZ6wljfBmDIl/VbfFUCovNx/e?=
 =?us-ascii?Q?0ZrFP2n/1vjMhxHoqGCpPQepKMnK7Rm2kxcRo8XyZ3sDaS+JLcjJs7tDBqf7?=
 =?us-ascii?Q?OaHdie1PYybkccIzV0SFlnc5Pw5QjaBQAE53Aozr+dA+5RyjcZLYupxIcNBY?=
 =?us-ascii?Q?efCZAgXQpAQeNzNKNV5uJDbFmRCQtIIiR7lYhJMlW0TYCMqpIMiDSYNMH1hV?=
 =?us-ascii?Q?9htVYHpRwedNmP0rFshM3a4NjSKvjQkfo+C4oQ346JMN8WDc8TkZjUICyYFT?=
 =?us-ascii?Q?J/8/y2s0lNOVgSrJSj2ybuUg10Dez6Th9Jp7pA0QlsTLarku0K7/VI7xhLGb?=
 =?us-ascii?Q?fl7vpcW1mjgCtLRDnQGDoDl4xhCckrUuTxBhp2lvQMPhI8tGhJ2anjIZV/j2?=
 =?us-ascii?Q?3EkdIKglS5KRvGs5ILEEhRUPQDmVsWEu0NlPd9baMkCoRUcJDKhIjIxgzau6?=
 =?us-ascii?Q?IC47BehDau1v9GIBEPKN9mbmrDZF3Bimv5ocQCl9FEoASRoLsD+bKdIxmBTS?=
 =?us-ascii?Q?E/gsiFWl1D0UmpBEOIoEB94dfs4LJrwLQ9OgMTllmiR6Z/Z3/AZJMJfWguSB?=
 =?us-ascii?Q?f8ksMOYEP4GIg7r0NDHd12Zgz7rgIQlufZuJWfBNXKO2kAziF4lCFpMnAFLD?=
 =?us-ascii?Q?f6h1YzPbW0EjNC+zs5CKafUjBEFPgB5BcjMvOoEmvI7r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6782c4-a859-4d6d-f8e1-08dd4e042aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 21:03:16.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+w/wPNBRUtFDdXa0RPYzaJcZFsuV9JUl8bR5DXdyAVGu8XfRmALQArum5OmM5ja/a/5mq/2vIR4jN2Hx8av7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

On Friday, February 14, 2025 7:03 AM, Dan Carpenter <dan.carpenter@linaro.o=
rg> wrote:
>
> On Fri, Feb 14, 2025 at 05:42:25PM +0300, Dan Carpenter wrote:
> >
> > I guess we can't call schedule_delayed_work() without holding the
> > spin_lock?  It's a strange thing.
>
> Actually, I see now that we're just dropping the lock to avoid a sleeping
> in atomic warning with the GFP_ATOMIC allocation...  I bet you could make
> the code under the lock much smaller.  Just the test_and_clear_bit() stuf=
f
> basically.
>
> regards,
> dan carpenter
>
> diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.=
c
> index 11211c469583..ed141236a4aa 100644
> --- a/drivers/scsi/fnic/fdls_disc.c
> +++ b/drivers/scsi/fnic/fdls_disc.c
> @@ -308,31 +308,22 @@ void fdls_schedule_oxid_free_retry_work(struct work=
_struct *work)
> struct fnic *fnic =3D iport->fnic;
> struct reclaim_entry_s *reclaim_entry;
> unsigned long delay_j =3D msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
> +     unsigned long flags;
> int idx;
>
> -     spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
> -
> for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ=
) {
>
> FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
> "Schedule oxid free. oxid idx: %d\n", idx);
>
> -             spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
> -     reclaim_entry =3D (struct reclaim_entry_s *)
> -     kzalloc(sizeof(struct reclaim_entry_s), GFP_KERNEL);
> -             spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
> -
> +             reclaim_entry =3D kzalloc(sizeof(*reclaim_entry), GFP_KERNE=
L);
> if (!reclaim_entry) {
> -                     FNIC_FCS_DBG(KERN_WARNING, fnic->host, fnic->fnic_n=
um,
> -                             "Failed to allocate memory for reclaim stru=
ct for oxid idx: 0x%x\n",
> -                             idx);
> -
> schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
> msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
> -                     spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock=
_flags);
> return;
> }
>
> +             spin_lock_irqsave(&fnic->fnic_lock, flags);
> if (test_and_clear_bit(idx, oxid_pool->pending_schedule_free)) {
> reclaim_entry->oxid_idx =3D idx;
> reclaim_entry->expires =3D round_jiffies(jiffies + delay_j);
> @@ -342,9 +333,8 @@ void fdls_schedule_oxid_free_retry_work(struct work_s=
truct *work)
> /* unlikely scenario, free the allocated memory and continue */
> kfree(reclaim_entry);
> }
> -}
> -
> -     spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
> +             spin_unlock_irqrestore(&fnic->fnic_lock, flags);
> +     }
> }
>
> static bool fdls_is_oxid_fabric_req(uint16_t oxid)
>
>

Thanks for the comments and changes Dan. Appreciate your help.
The team will review these changes and get back to you.

Regards,
Karan

