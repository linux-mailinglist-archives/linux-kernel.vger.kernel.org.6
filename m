Return-Path: <linux-kernel+bounces-522900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDFA3CFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6143BB681
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DBC1DE4D2;
	Thu, 20 Feb 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="WVC7bO3w"
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D510FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020972; cv=fail; b=ZIS0KsSYi6vj+6YqjZxDBLy7ysVrx7mnT12gka83cgL5ls5QLFjJkTrnM1hWJgf5URhT6HC5AF73Lz/+Z4LTu2SL1vVypDNTJxFv/A+X5gNKgneQyOfc27ooMbPFv96qfDZrv9UxvTT/yeczT1DCdS3URqSx1Ir+7cW7MyD4MX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020972; c=relaxed/simple;
	bh=cU4/Qx4PK3AbxWg4O5tZXlbK2kO8XWIsRfkpkg8RFXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BN0OdpApaZNIl7tvRWS7gwU8AVhWO0mrG4pEKeSP9JRFUfhQU6bP8DWpVWh23gcDXqWra8FOJwWxFAOWRJjLoSMxNbhuHM2Bw0m5lRheLGUMy8Ays+EDU6ZLP4SEXAa60FUNyIJdmBhkjL93Afq2tWGv26+NaZbyGMSaLYEZmMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=WVC7bO3w; arc=fail smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7159; q=dns/txt;
  s=iport01; t=1740020970; x=1741230570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mmzm52nC5N/d0o12y4S8w5R5BxvW9fzIoBooc9lcYs8=;
  b=WVC7bO3wj4v0rnHiGlNMIimd3VKK/kmIF7BYjEM6c3plaSG5dCwHMlnD
   DOM8PqqJi9zORa/evdsVm2+ObNcO4YxQqeE4zsC/7t4Sfod5f7KUUYdVV
   zohD07nVIqPkQQU77fkDBf2MIKfhgAbn7b6tCaw2Vy+whYgLRTtRdvGiL
   xoN2y4X/T9vdWG+65JmD4jSOCyJuutIHnviFltUaqKELvANn8m4Kzt6Aa
   DOkEKYrusPI52eORlhvTVy/iwIrynwQl8nO585S5QGPiiPlhzTcxJ53K+
   labgMbqgaMnt/BR7n4Nt+6+8puNx1ihkPjV5n+A0EsQWZgrbmBD+JtZe6
   w==;
X-CSE-ConnectionGUID: xhktXuIGTkS+umzRs9sSlA==
X-CSE-MsgGUID: LfgslE5LRhy+2DbCAyeoGQ==
X-IPAS-Result: =?us-ascii?q?A0AGAAB1m7Zn/4v/Ja1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEaBAEBAQEBCwGBcSooB3aBHEgEiB0DhE5fhlOCI?=
 =?us-ascii?q?QOYOIVcgX4PAQEBDQI7CQQBAYNzTkYCiw4CJjQJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQUBAQECAQcFgQ4ThXsNhloBAQEBAgESFRM/BQsCAQgYHQEFC?=
 =?us-ascii?q?zElAgQBDQUIGoJhJYIcIwMBEAajCAGBQAKJWho3eIEBM4EB4BwGgUgBiE4Bh?=
 =?us-ascii?q?WuEdycbgg2BV3mBbz6CShcCA4FfhBOCLwSCL0qBJIJZZ5EyaogyjBFSexwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSkQOAMqNDEjgSMFNAo3OoINaUk6Ag0CNYIeJFiCK4IggjiEQ?=
 =?us-ascii?q?14vAwMDA4M0gkVRgkSCEnFsAwMWEIIxcHgchQyCGB1AAwttPTcGDhsFBIE1B?=
 =?us-ascii?q?Z9CATyDQCVMAiwsASEGIQgKBiAQaGUOCAwTCzoDklsKES6Ca5A0nQqCRQqEG?=
 =?us-ascii?q?4wYlWUXn2aKbC6HZZBqIo1jmwECBAIEBQIPAQEGgWc8gVlwFYMiEz8ZD44tF?=
 =?us-ascii?q?haDQoUTwCh4AgE5AgcLAQEDCZF3AQE?=
IronPort-PHdr: A9a23:j9JXSB8Yr8Pub/9uWBDoyV9kXcBvk7zwOghQ7YIolPcVNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:YPbgRa3Mi3aQu3mHsvbD5YRwkn2cJEfYwER7XKvMYLTBsI5bp2YAn
 TFMCmjQO/2DZjSnco8kaNjg8E8BsZHXmoBmSAVk3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 rsen+WFYAX4g2QtYztNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGHEE1Ib0F28lLAloN6
 PkKEitcdSuHrrfjqF67YrEEasULNsLnOsYb/3pn1zycVaxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNU+RC/FMEg9/5JYWn+6ymnj7ej5wo1OOrq1x6G/WpOB0+OS2YYeNJoPbHK25mG68q
 G3d+0mkJisaJZ/F5TCu22OhgcD2yHaTtIU6UefQGuRRqFmSwHEDTR4bT122pdGnhUOkHdFSM
 UoZ/mwpt6dayaCwZsP2Uxv9pDuPuQQRHoIKVeY78wqKjKHT5m51G1Q5c9KIU/R/3OceTj0x3
 VjPlNTsbQGDepXMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:41RL26w6HS5LWArUIfTIKrPxY+gkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ5+xoWJPtfZvdnaQFh7X5To3SLTUO31HYY72KjLGSjwEIdBeOjNK1uZ
 0QF5SWTeeAcmSS7vyKrjVQcexQveVvmZrA7YyxvhUdKD2CKZsQkzuRYTzra3GeMTM2fqbRY6
 DsnvavyQDQHkg/X4CQPFVAde7FoNHAiZLhZjA7JzNP0mOzpALtwoTXVzyD0Dkjcx4n+9ofGG
 7+/DDR1+GGibWW2xXc32jc49B9g9360OZOA8SKl4w8NijsohzAXvUgZ5Sy+BQO5M2/4lcjl9
 fB5z06Od5o1n/Xdmap5TPwxgjb1io04XOK8y7avZKjm726eNsJMbsEuWtrSGqf16PmhqA77E
 t/5RPdi3OQN2KYoM2y3amRa/ggrDvFnZNrq59hs5UYa/peVFeUxrZvpn+81/w7bXnHwZFiH+
 90AM7G4vFKNVuccnDCp2FqhMehR3IpA369MwM/U+GuonFrdUpCvgMl7d1amm1F+IM2SpFC6e
 iBOqN0lKtWRstTaa5mHu8OTca+F2SIGHv3QS+vCEWiELtCN2PGqpbx7rlw7Oa2eIYQxJ93nJ
 jaSltXuWM7ZkqrA8yT259A9AzLXQyGLH7Q49Ab44I8tqz3RbLtPyHGQFcyk9G4q/FaGcHfU+
 bbAuMhPxYiFxqYJW9k5XyLZ3AJEwhtbCQ8gKdPZ26z
X-Talos-CUID: 9a23:xsM7G2Cd120r0er6Ezln91IkB+EKTn7mj2rVMXWjWH1STJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AJZrqXA4F9q17J7e4U0c6Gz2ixoxM7au1DG1Qta8?=
 =?us-ascii?q?GqoreGSZbEiaQixuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Feb 2025 03:08:21 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 5AF1C18000230
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:08:21 +0000 (GMT)
X-CSE-ConnectionGUID: xb1x2BlMQY2fNbXq+zjvRQ==
X-CSE-MsgGUID: ttYRgqK4TFiq1PsrwG8GXw==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,300,1732579200"; 
   d="scan'208";a="22015646"
Received: from mail-bn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by alln-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfBocTLOgiwDrZvTy96SM9C5EG20j0g1qyVw3wSMbikXvw2mD5GRqp9SfVZJdS+KfbNDtKODt5fUJe5nJ4+rbsQ+IDIdGiuatva8atZUfynU20GY7t9+b2B8yee3yrza5K1QRnLOvA3s1PZSNeED0piHvBOBd1Z8fiPp0OAUy5aRPT0wsRSKNP5pqGGSNaswUdFgdlAxRy7JErYnPLulNDMapXWZU4LWrUwihIYcgnZK5gTqiBP3t0WLKk9T9RQuS7M1CFSgQsr+o9rtdLAl8HbXPxcErbzoHBYTpzDsyDDeUqjvjyMH5VfQrxFxSGR9jsEMdKKTOKYuex/pEk3NHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmzm52nC5N/d0o12y4S8w5R5BxvW9fzIoBooc9lcYs8=;
 b=H1JL1oc2f0GFYZQB3Tvm2SlUiORABo/3qkS589mojAE65XSxUd4x/EJ719rl/1IehGDMdq6vjDmhwLpIBPXtEc4zOtEz4D9Cb20xYw7nE4ZHG20BfJx+XHLhgvvmpyELvs99WmEmR2bfDby/8huQQQBYXBlhGJDM+txwAfSGtJ85q1akkNVy34DRcbY8dEo+hW3a7VMXheulxU4LPeiDU5QE8FOJb6HI8UrM2Te6I7SpgYQyKsCNzFvYDrCf++alRs5mxQJuBLVY2Trhl6Eww+eTxno44JIsLwqlkTRHnDgnfjGrnhCZ7iwJ27YS03za6iRrbjqcEQN828m2Cqb0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 03:08:17 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%5]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 03:08:17 +0000
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
Thread-Index: AQHbfu60Aqs0Y1uoDU+0WvnEcG3OM7NPiQeg
Date: Thu, 20 Feb 2025 03:08:17 +0000
Message-ID:
 <SJ0PR11MB5896E5F325ABE2CD6AF3F8CBC3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
In-Reply-To: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH8PR11MB6999:EE_
x-ms-office365-filtering-correlation-id: 0be3983e-079b-4df6-bc00-08dd515bd26d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xC7Z9Eqwe4zjmI+QA4eRSgukv16CkKbc4ECV8/QKU2vJRV7Fx5bfD2XWRXfV?=
 =?us-ascii?Q?dqLpNF0jcaWZYrgGotAZOb2HSYCpm73aAXQxW25e9ske35lqyP8LHI+eKyzd?=
 =?us-ascii?Q?XJctFafvvXP3tHDXArbAJmXKVG3fDsCIdRDTCiAW6K9wea00luCS+YJqAYtT?=
 =?us-ascii?Q?6ZAriCSNPAHcTON8qRLft6ELkJ5wZlDyBHFOGu7ISA7rAWY5o/C8Wn2spgcC?=
 =?us-ascii?Q?k+OYYKrjG0coICLXhhIKUBSe2fiNTb3JUxNtfhY5gu4f5VtRfXlBLkTZ90JX?=
 =?us-ascii?Q?XHwfF6SlJQrGN6cPdiKDvXRqVsu1RUR3zy1QoWmdeR8PHvM+6OHqUu74aSqY?=
 =?us-ascii?Q?N2U3DSIzDQwOjg6U4MLUnjFFEZJuoJi3z4Yh6JDmVeTLcn600HNfOqXaFzsF?=
 =?us-ascii?Q?S33/ybUegbFcAu7rxGKP/DOS8numaN7mIwOx3150K/MKTprAKRrbg8BMYLvm?=
 =?us-ascii?Q?8BQ7kA7cOdz9hPz4gjdT4UlNNQJRziar5E/JXLGhm7PQ5NRd25Rl2HVEIKjL?=
 =?us-ascii?Q?yCDJu8GIOY+DF1cV9BGDnweOAi7mS0FPP2OZtIef3hbkgtBtxA9BakUtksAN?=
 =?us-ascii?Q?CpGAN5FkPJ5xEP98fkzFH9/dmT8j5yi62tS2xPLmAdYf6Xvkmz1LJ0/DGfEi?=
 =?us-ascii?Q?28AzlVh+L7G1P/ruoewqXy5H1AKVMXBi5vlhChf72j/hpAXGcW/f/vDEKPFm?=
 =?us-ascii?Q?PxYBP7iuRt77igp1KDDebVxMFtCR0yxg+GptHV8gfl0hEyWnZKHmytp5ISN4?=
 =?us-ascii?Q?3vxqedjFjmryBV1TvTDIIiQjOkb6OiWG/G2gSR6V1k/IHFrcro5HMu2ghG8u?=
 =?us-ascii?Q?e6YkOJMeRyH8prZLOQYf2TKfdGf/hWNFc2b2BeUZAzckAT0qFObINZ+Tufl2?=
 =?us-ascii?Q?DhyvvY6jz8RBCZCoMF5sZ+MQ8ee/XDeOF9uPFpxzr692vm8JII9SbceFP1L/?=
 =?us-ascii?Q?lPbb5G/VzhnyrVfFo9lVmn/3TPDCC6HEG56omNHiUuW26EYTdR07JSbmSFUm?=
 =?us-ascii?Q?a7jBLh5t+zObJXGj9S/W6SZOYsOe4pkosqXx0y/KG71LvINKJpBCh2/6vOEi?=
 =?us-ascii?Q?GHPmgofCd8WpHx27pbma23mNomPkK+By2iRXtO4TMB2v3FAl5Le+tSh2LkLs?=
 =?us-ascii?Q?evdUI63exCcDLNsOkNzvltFjuylmTvExRDkSvSU2ctFu1Xrad8zRsaFzDRWq?=
 =?us-ascii?Q?yXokQvSzs+U+noJrq05xn8jewh8SxrOO9Fbpg8rsBVFXKQY89fNG0VbgRUXp?=
 =?us-ascii?Q?nNPoLQOwJsvEt7QNNiL8OwBozkImx//Yt3Pr1Clb0Yi4XP1Am/RrzTSuddat?=
 =?us-ascii?Q?EeWR7pRRvRuodJyldO3hcfHdi79bjoEW8D8Zge3/7tIQ/Qo2rFr6GnYXBEmg?=
 =?us-ascii?Q?Vke1gaamxYcNvxHGkOckX8qw+E/ipB9ZG9HmrJgiSPTfEE+g8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mbJGJuIrrP7qj+BZW9bFWS2HD4zW7ToqAUIupF/mRKtng+rNdhNzk3+WnkCr?=
 =?us-ascii?Q?D/Pfwn4lqxSKnE9dkM+jGKjbH370Dr8DgEcC37LMduOg19yeDpHvzobLeibg?=
 =?us-ascii?Q?ibUWG0Lr3vW2fcQsJEyeVTpdQEV/Od3Ln3OwPfdFB37V9mms+yyFJyZZiV/G?=
 =?us-ascii?Q?dJx+pSn66LhVT2NfA4Hyf/LBhp9VeGoX0TJ9J/LqDd5cJHAvM6Dl/dFyq07N?=
 =?us-ascii?Q?N4d0WFXy42WBbG/29k/UTaRTc1eTOqVFt+LKpinOIQW7OB8AQaEd2l6rMbWt?=
 =?us-ascii?Q?FeFrVgI8D31DmyK94ouWzlx8t1KcyR84iQSFyGgjl/U63pcSuYepXpUny972?=
 =?us-ascii?Q?Mt8cBmC4nX/tpC6PPvpdaNXyeiepNE+4I/3rMoc0syB7+YB+Iun4P1KVusLP?=
 =?us-ascii?Q?BWGh5qoOgaW/QZtFqPk2uC40vFKeA3u1U3IGO+XSqDRdk5UiSZVfk+4lCr3m?=
 =?us-ascii?Q?hLNazpFGNLGZ0vmS8YFDz0aVWzsAD6oT5a0d4wMhQWFDXrPT6xRmQQJWZ2FG?=
 =?us-ascii?Q?XYEId7P64H3NAR5sRjxTCdhNaTwftCeKoG28j03jQZXfrtgI3bjLrprkae9s?=
 =?us-ascii?Q?DrmOMpEvoDedp8mI7dIIN5BpvHRcPzIADYnkl9RRrALAsBY47S76dz8vnXgy?=
 =?us-ascii?Q?QwwemhTYBJ/O05bFmdiGesrmDXXYh0QkuHyDRGw7TS3lZDPS/K3lRPq5nOYR?=
 =?us-ascii?Q?VKuVgLYLr74CXeAq1zW6xlGrIA+mco49IE35HsCwn/850UX93TCjXLg09V91?=
 =?us-ascii?Q?+HdOxkQ/BtgiM9TEaIwfZ5+VGxfaGQUsT8a9yTUYFPqWZftOyazf5r7J1hYn?=
 =?us-ascii?Q?O3PfwjQxgWoB1ZjeK6qj3yuvayxuZg8VNrFwyy7fAbaa61GX/3rL3zzqGal3?=
 =?us-ascii?Q?CH+f3BYsCEogW2mPfjXWukmRiu+Vo2x0CFVZm7Zo8dV6yUpcJfV3AYcJeXZf?=
 =?us-ascii?Q?Z8wfsqJ7RcHDK5KJRJoxBEbi3gTVkp2PuwxvZpWKZ053Rg5bhWB5H1lZ1qRK?=
 =?us-ascii?Q?YbNSCjsYQgZS1aXeCIRGFfT7i6sH4jTIpVOg4d7/6MuluCWpR0VlAXo33XNq?=
 =?us-ascii?Q?LGPqos/cVpVAWFvdRncBhiSOJl5Uj/jZF9qvRrc3q+fc384QiE73uom+ChN6?=
 =?us-ascii?Q?GV+2wGyhYyW4YsVvgm2UPgccd5FWRCYU3FsmSNwkm/A11m1AS3lGG10enOTN?=
 =?us-ascii?Q?zE92QB+lo9r2Gw4yXbB1H+BaiFs6ecPaI74OXp1haxU6Iz3vXk93vqLXNKWD?=
 =?us-ascii?Q?GhDVgOfhRymM03/6peJleWIvqMZsuUopXJOBMjc4Bq7Ndt0ezLgVaFUndKVH?=
 =?us-ascii?Q?bKIkMCAb98GJk9pXT3rJSGQ4Kc0ONvtGAjrpIRlGNICWOU+7241ZxCHi9sa5?=
 =?us-ascii?Q?Oh5AS0VHwq++RKsHXK8UJODBA5cdZdqfoB3RQi0BjwsDM9ssXu4X1pkLNc8T?=
 =?us-ascii?Q?BdSzQu2y3/x1q3fB35ghWYB/mhlRe53OuzCVMLlMUTZ0EQ1P//2MsF9vzRG4?=
 =?us-ascii?Q?gjpSr9sh0kaUvowgTT9hQsiiLoVEU/WhIltMNlXx+lqopkfSH90WWk/7nvOp?=
 =?us-ascii?Q?5TN2wMN0wNOeIuIz7GUa+T08ruuXXYIL6I0BP8/plehNYGbHEn9Z+A4McwjE?=
 =?us-ascii?Q?KoStBXF4ZAwmbYa03g09EhE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be3983e-079b-4df6-bc00-08dd515bd26d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 03:08:17.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1q+ulJhFu1Of/T7TOkFkQkwGxkPynAVANHB7YxX+1WX4WTRxOtFMS2i8vZ27Z+nJ8UxEykLH48xkxRgcS8mbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

On Friday, February 14, 2025 6:42 AM, Dan Carpenter <dan.carpenter@linaro.o=
rg> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
> commit: a63e78eb2b0f654b138abfc323f6bd7573e26145 scsi: fnic: Add support =
for fabric based solicited requests and responses
> config: i386-randconfig-141-20250214 (https://download.01.org/0day-ci/arc=
hive/20250214/202502141403.1PcpwyJp-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51=
eccf88f5321e7c60591c5546b254b6afab99)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202502141403.1PcpwyJp-lkp@intel.com/
>
> smatch warnings:
> drivers/scsi/fnic/fdls_disc.c:263 fdls_schedule_oxid_free_retry_work() wa=
rn: inconsistent indenting
> drivers/scsi/fnic/fdls_disc.c:989 fdls_send_fabric_logo() warn: inconsist=
ent indenting
> drivers/scsi/fnic/fdls_disc.c:1953 fnic_fdls_validate_and_get_frame_type(=
) warn: inconsistent indenting
>
> vim +/cur_jiffies +166 drivers/scsi/fnic/fdls_disc.c
>
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  244  void fdls_schedule_oxid=
_free_retry_work(struct work_struct *work)
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  245  {
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  246      struct fnic_oxid_po=
ol_s *oxid_pool =3D container_of(work,
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  247              struct fnic=
_oxid_pool_s, schedule_oxid_free_retry.work);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  248      struct fnic_iport_s=
 *iport =3D container_of(oxid_pool,
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  249              struct fnic=
_iport_s, oxid_pool);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  250      struct fnic *fnic =
=3D iport->fnic;
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  251      struct reclaim_entr=
y_s *reclaim_entry;
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  252      unsigned long delay=
_j =3D msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  253      int idx;
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  254
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  255      spin_lock_irqsave(&=
fnic->fnic_lock, fnic->lock_flags);
>
> Passing fnic->lock_flags is wrong.  spin_lock_irqsave() is not nestable
> in the sense that the "flags" variable can't hold two values at once:
>
> orig_irq =3D save_original irq states and disable()
> orig_irq =3D save_original irq states and disable()
> restore(orig_irq)
> restore(orig_irq)
>
> The second restore(orig_irq) is not going to restore the original states
> it's going to leave them as disabled.
>
> If fnic->lock_flags is holding anything useful when this is called, then =
it
> is a bug or if anything uses it before we exit that will break us.  Just
> declare "unsigned long flags;" locally.
>
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  256
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  257      for_each_set_bit(id=
x, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ) {
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  258
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  259              FNIC_FCS_DB=
G(KERN_INFO, fnic->lport->host, fnic->fnic_num,
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  260                      "Sc=
hedule oxid free. oxid idx: %d\n", idx);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  261
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  262              spin_unlock=
_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11 @263      reclaim_entry =3D (=
struct reclaim_entry_s *)
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  264      kzalloc(sizeof(stru=
ct reclaim_entry_s), GFP_KERNEL);

Thanks for this change, Dan. It looks good.

>
> The indenting is off.  The normal way to write this is:
>
> reclaim_entry =3D kzalloc(sizeof(*reclaim_entry), GFP_KERNEL);
>
> Remove the cast and change the sizeof().

Thanks for this change, Dan. It looks good.

>
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  265              spin_lock_i=
rqsave(&fnic->fnic_lock, fnic->lock_flags);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  266
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  267              if (!reclai=
m_entry) {
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  268                      FNI=
C_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  269                         =
     "Failed to allocate memory for reclaim struct for oxid idx: 0x%x\n",
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  270                         =
     idx);
>
> Remove this DBG.  The truth is that for as long as anyone can remember
> the kmalloc() allocator won't fail for tiny allocations.  We're more
> likely to formalize this rule than we are to change it at this point.
> Still, we check for errors until that day arrives.

Thanks for this change, Dan. It looks good.

> But allocations are not supposed to print an error message on error.
> It's just messy and it doesn't add any information that isn't already
> in the stack traces that kmalloc() prints.
>
> I guess we can't call schedule_delayed_work() without holding the
> spin_lock?  It's a strange thing.
>
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  271
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  272                      sch=
edule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  273                         =
     msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  274                      spi=
n_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  275                      ret=
urn;
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  276              }
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  277
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  278              if (test_an=
d_clear_bit(idx, oxid_pool->pending_schedule_free)) {
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  279                      rec=
laim_entry->oxid_idx =3D idx;
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  280                      rec=
laim_entry->expires =3D round_jiffies(jiffies + delay_j);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  281                      lis=
t_add_tail(&reclaim_entry->links, &oxid_pool->oxid_reclaim_list);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  282                      sch=
edule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  283              } else {
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  284                      /* =
unlikely scenario, free the allocated memory and continue */
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  285                      kfr=
ee(reclaim_entry);
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  286              }
> a63e78eb2b0f65 Karan Tilak Kumar 2024-12-11  287  }
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

Would you like to send out a patch for these changes? If so, we can review =
and sign-off on it.
If you would like us to send out a patch, that's fine too; we will address =
these changes in a future patch.

Regards,
Karan (on behalf of the Cisco team)

