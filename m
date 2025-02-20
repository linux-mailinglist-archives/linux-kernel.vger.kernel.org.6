Return-Path: <linux-kernel+bounces-522908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF6A3CFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E506A17D9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC31E0B74;
	Thu, 20 Feb 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="hOF7qNB6"
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1411DF985
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021101; cv=fail; b=uTLQ2N7OCU0KRNyHnv2GePE08BFd9d8OEVuD0j0urA4+JGWWFxY/1XabItdoSmPucfyqdevFc4SWNijCGyb1QZrZ0nFyeRV8ht6+hcVV2wgfVJ4JpsAjcijCv8ayQUGoyEFVuRK+11zGS/sIgfDxphG7ZaPyZlro7Jz1jh39eM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021101; c=relaxed/simple;
	bh=/cRhf9NLwvZDZyOdGyeR4R0S7o/8ie5Tijex6a+3Un0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nfG2ddoZBe+/Lv0vyql8f4BlxgZAw221+Ao6RGnjMBXxtIy/OvY9/MAJxgP/vUcb+m1YB2wLQM9z6Ovi98d9gZIiCbVZLHLoyljuSiFEbBAgKAiSoQUDobHdIFDYdK4kikxucozvNl9EcJe4euyc0VxDSMs9+zYAZMgbghO6dNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=hOF7qNB6; arc=fail smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3265; q=dns/txt;
  s=iport01; t=1740021099; x=1741230699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdPsswxHbIVxactRcItQF3SxcHGQCcm0xP3P/RxuDKY=;
  b=hOF7qNB6u/bNcebw/wG/aLzZAyPCrrl2wy0iLmQ97ZEQpxaUl9jLfD5u
   Y9BfGpXW2JzMtNDFrk2Moj6lmYuBzJXRGCSCQTZ3ZnnvvzMlLXqIsof5U
   1ZfpJuj3xx4MIh/fEJsm5UMjG0tABmzc5Oa1PqbaRFRBPx2VJowVX1YCy
   bdnKV6S21bbpEDpj/Q5wyGDPM6K1DToz5EqJUWwyYd9TDwVe/lFZUpq9X
   yoU5QyazTbTNd1bFsp0bgya2NYhvYxVz3ezdTHf1u7FvNyX6i7xDku/Gk
   BwFZzcqOss9ZpFL1ung6b63xQiIzkoWWUNa7rVXBVWXDM9Fdjz1wdrRUv
   A==;
X-CSE-ConnectionGUID: qd3v6h2FT9ujTJWCPjl6DQ==
X-CSE-MsgGUID: Ve+vVfa4Q1WPgmF/Or50dg==
X-IPAS-Result: =?us-ascii?q?A0AYAABHnLZn/4r/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRoGAQEBCwGBcVIHghKIaQOETl+GU4IhA5g4hVyBfg8BAQENAkQEA?=
 =?us-ascii?q?QGDc4EUAosOAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4YIhloBAQEBAgESFRM/EAIBCBgdAQULMSUCBAENDRqFIiMDAaMiAYFAA?=
 =?us-ascii?q?ooreIEBM4EB4CKBSAGITgGFa4R3JxuCDYFXgmg+hEWEE4IvBIIvSoEkgllnk?=
 =?us-ascii?q?TJqhAV5gzSMEVJ7HANZLAFVExcLBwWBKRA4Ayo0MSOBIwU0Cjc6gg1pSToCD?=
 =?us-ascii?q?QI1gh4kWIIrgiCCOIRDXi8DAwMDgzSCRVGCRIIScWwDAxYQgjFweByFDIIYH?=
 =?us-ascii?q?UADC209NwYOGwUEgTUFpF5UIQhkgT8fQwKSQR1JgmuQNJ4cgTMKhBuhfReEA?=
 =?us-ascii?q?40Gjl2KbC6HZZBqIqNxgSGDUgIEAgQFAg8BAQaBZzyBWXAVgyNRGQ+OLRYWy?=
 =?us-ascii?q?H2BNAIHCwEBAwmRdwEB?=
IronPort-PHdr: A9a23:9NAqsBF5aByx655iDCmO8Z1GfhMY04WdBeZdwoAsh7QLdbys4NG5e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:Fxih161N9lkNvgYGxPbD5YRwkn2cJEfYwER7XKvMYLTBsI5bp2cDn
 2EWDDvXOf2CZTDzft0ibtux8U8EusLQm9E1SARv3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 rsen+WFYAX4g2QtYztNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGFU1tI9MYoMhLUHxMy
 d4nAwgPak6vvrfjqF67YrEEasULNsLnOsYb/3pn1zycVa9gSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNU+QC/FMEg9/5JYWn+6ymnj7ej5wo1OOrq1x6G/WpOB0+OS2bISMKoDTGK25mG6mq
 yHYwWrwXihDC+SQzBTC1Wjx3uPAyHaTtIU6UefQGuRRqFmSwHEDTR4bT122pdGnhUOkHdFSM
 UoZ/mwpt6dayaCwZsP2Uxv9pDuPuQQRHoIJVeY78wqKjKHT5m51G1Q5c9KIU/R/3OceTj0x3
 VjPlNTsbQGDepXMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:BKN/g63QRfZ2wyiu36FXqAqjBf1xeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6K690cm7LU819fZOkO8s1MSZLXjbUQyTXc5fBOrZsnHd8kLFh5RgPM
 tbAsxD4ZjLfCdHZKXBkUeF+rQbsaS6GcmT7I+0oQYOPGRXguNbnntE422gYzRLrXx9dOEE/e
 2nl7J6TlSbCBMqR/X+LEMoG8LEoNrGno/nZxkpOz4LgTPlsRqYrJTBP1y9xBkxbxNjqI1OzY
 HCqWPEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwiy6zDb4RG4GqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg6jAz8HXvoGXowkcL4PaJBg7SOfAxwb6xQSGprHbIe+sMlp
 6j6ljp8qa/yymwxRgVqeK4Dy2C3XDE0UbK2dRj/EC3F7FuKYO4aeckjRlo+FBqJlOg1Kk3VO
 ZpF83S//BQbBeTaG3YpHBmxJi2Um00BQrueDlIhiW56UkeoJlC9TpR+OUP2nMbsJ4tQZhN4O
 rJdqxuibFVV8cTKaZwHv0IT8e7AnHEBUukChPeHX33UKUcf37doZ/+57s4oOmsZZwT1ZM33J
 DMSklRu2I+c1/nTceOwJpI+BbQR3jVZ0Wm9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRtbWXv
 6iUagmdcML7VGebrqh8zeOL6W6c0NuIvH9kuxLLm6zng==
X-Talos-CUID: 9a23:KI56wmzLBcu90ynhMmWXBgUNFps7LH2H4kuBPk2EK1lCcL+RF3OprfY=
X-Talos-MUID: 9a23:m9dHkQimP5AkFh18rh1DBcMpCsor/ZqgARw0yKo+tMyqcgtqZm+Rg2Hi
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Feb 2025 03:10:30 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 97C9B180002AC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:10:30 +0000 (GMT)
X-CSE-ConnectionGUID: kNbT2oJDT0GUlqqZrydJvA==
X-CSE-MsgGUID: Os4tASJ+Qxicx4F2qMB9Ng==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,300,1732579200"; 
   d="scan'208";a="32787123"
Received: from mail-sn1nam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 03:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyNhb7fYrikEjn8GfhH19NdD13iboYn93UuhN0jnQMDQVugImmyMn+81hWGwe3exP/uVCkJ9C2GvZ37vo6I+Wo3JCKf2dKba3foHkYevUIgPQs/yqMdaEflYqD1+frj0YFQe+BaHUeJH0rdcwGXYLqSfR+R/Dv4D3oPr9AwoQWupOLGV51xtiuJc9132fEyRz5WBuTX9b84otUP2huyi7DND86brpNDl4dUue2d48hjhvrBriqE6/P7YWn/eH/GZldQ7KGOAE/oo7mzXT45pZoJdYXIHJqTyGjcHFgCKkWH3V1GKEqW4azRNecmCqcBWPIH2Qr82HfwYjzz7MQjhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdPsswxHbIVxactRcItQF3SxcHGQCcm0xP3P/RxuDKY=;
 b=rIYLWcuSzt6zCuLaCWL0+Alt4Z4sffEJL56ZymsmXBy2IzQ4Gv5DM63rT63fDUwm+tpwGYpBQTptbyNXbDVqfiHe//QAHl6JXkvzitwTK/1bKPVyPIsy9pnNrEfOsvwGJBl1G+H/YsPSiczzLsVSPbu3vLTBBSb5dKmQVTL5q7jgo+6UFZhcHFeGjMOITk4kBsLEJv5CF5qe+TwlsxYGHB0SSfXHHG8xs++uOIzgUUjUvjHVcZ4RaL0iOxEbQtQfrNY2Qmbv6557OWqoNqCY6+jTtoZeMyWxfBaS1I4sOk7zvVMXlUEhJuMtzelZBzNQzjXAuwCOA/S3Ta2fvfnd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 03:10:27 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%5]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 03:10:27 +0000
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
Thread-Index: AQHbfu60Aqs0Y1uoDU+0WvnEcG3OM7NG5RiAgAH2PjCABrBEYA==
Date: Thu, 20 Feb 2025 03:10:26 +0000
Message-ID:
 <SJ0PR11MB5896888C81BFF2EB81E2B533C3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
 <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
 <SJ0PR11MB58962A4F0B9CFFB9439FF959C3F92@SJ0PR11MB5896.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ0PR11MB58962A4F0B9CFFB9439FF959C3F92@SJ0PR11MB5896.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|PH8PR11MB6999:EE_
x-ms-office365-filtering-correlation-id: d233470f-0a14-46d5-02af-08dd515c1fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AZ2NKIPC+33DQvO79Z9yoGOWVHMuu6JjJr2vV3/rqbw5o1c8f7nAcU2Xusmc?=
 =?us-ascii?Q?HOTt9MNukyuguSqN/G/dPFmi2LfychNiQsbNkAv5WEEeNJvfSLtwu3NNWvXH?=
 =?us-ascii?Q?t3079oJITvyvWG70WlWJzh7i0Ep0YafMFjQjbzbxT/aWZi4UNARuFWdtOMFg?=
 =?us-ascii?Q?bFXW4eRX1Rp0lTqhEqNrukoC0fBqqRfLThbkfr9OMfcl4l/AvVCQqASZwzQf?=
 =?us-ascii?Q?4EPF5k5ClYP1N+7xEAht2NjEcjNcGlPPvpXKElHr6fBo6rLKA1PQSM+OTngj?=
 =?us-ascii?Q?9T4I8vFgHNNzPlKFJgQg1qs3HMaqSA0s4Tof5rnQPrf7nKPQY8N02KTUExj+?=
 =?us-ascii?Q?Os+Ug8BrM5zquPHMAFehmQXJOrnp+NL7hjArErAfN2AlktfuIZPsdLRjNRWi?=
 =?us-ascii?Q?pRgsuEwZs2QSJ1rt0Vrbhtc9zPolDjMtl4Tc2C0Crrq0+fOfAoCYpZ9HcMaR?=
 =?us-ascii?Q?6as1YILUTGUq/6C0vY/4nNeJJqO87uiOBTMTvNXgVwUKM+6esmgU9HFKlc1o?=
 =?us-ascii?Q?++kwH8bv2yzB5XU+a0HWbDl0QK62ULKqGBGeQg8K11ol7hmtIEvfUTnoOBKr?=
 =?us-ascii?Q?5ZNln3I/pidr0dUc20Tg39km7SrZ9HqtWO+cQLHxrFCRzUIjjjf+vAYdj34r?=
 =?us-ascii?Q?zFuJgSMYN9qk9BQE4PwtDOqNiM56Vc5e4qNqaKsVv+k9CasEtF5TfpWm33Nf?=
 =?us-ascii?Q?1PstUIMQ75Ck97LOaNeCjn0Ep+dn1hnsF9vJB4a3AyZDbwQDG8HNbRqK8do2?=
 =?us-ascii?Q?Dl0OIZVtqeNSdC0o8U7b1SO/EQxin7St89Wl1Y3iQUH9n9i10FSbpYk+tFcL?=
 =?us-ascii?Q?ufNaqGBHA5gHK2bVAQmiTypOgST7EZdx7/KEqTAJ3V/qiES4ygN3oIZeiRZl?=
 =?us-ascii?Q?mnDE/yrw1FD6xR7AvwQbjMB8JY7BH5HyZIudfAvvgOfG4s/dQDBbcsjGuyy6?=
 =?us-ascii?Q?PXbhIN/OYvuleQShomo9ECfSX+TEOg3BC3B49iIAFwXCCCXOnICt6ZxPCGkl?=
 =?us-ascii?Q?d1Yhl589MVJgODgSKqRNABQzf2kXmiFTr2PBOxwO5jBKS9BVmDbBXOt2C+tZ?=
 =?us-ascii?Q?QNmu9aRATAJ5+y8U61fbbPk65VV+tuczRAbE4TGSntHUazAjJiQAS3zRKTNY?=
 =?us-ascii?Q?vkQLcdegrpcpoJCtliDE7taZMz4r4nadl65edBP43i1Xa1JABNG4UOoSCFAm?=
 =?us-ascii?Q?ovIDn+HEmmYvOcjDyES+F/reqxjL0NmjI+l48rZjP8ObXrKcscGNow9t4F49?=
 =?us-ascii?Q?Cd8s+Wrqruxka/xPb4c+Xu6EPbHGy1Efi9B9tAsf7C6PMhGhFof+U6w+wbHx?=
 =?us-ascii?Q?aq0p/TCXghc38+UVocHZXAOlCgYEik7qh20+W87Gj+NJzsQ4iJlWVsT/vNfy?=
 =?us-ascii?Q?Ed74wbDFTr5SmU59qeOE2ZuhlWFFd+s8grHKTi85g8igSTq0jizE+HWedtXB?=
 =?us-ascii?Q?WtmQo4QGlnQhKmAqiirVBMSPehlCVQrp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sIGRDnG+OSv+d/RfJtlnz0gXiKNd0C8nPu/k4aD1pF08spyYvKKn5OUDpyGI?=
 =?us-ascii?Q?OYew5oRWneUHqP2R4Ve/B6Sii1uCPQW86wClViz4OkHQ79Hig9Nh+J3z9YTP?=
 =?us-ascii?Q?/nYo8Liwu5s3HV9lZCYIdH/5MbmIoW9yA2KXbNr/rZjb23WUwYJT6XhS5ohe?=
 =?us-ascii?Q?ywqrq4OYUa1dvUD/GZeeo32KBzVPrIhuUYdX6ZLaGPz5KAxY/3WW6kQ3j/zv?=
 =?us-ascii?Q?V+lEIHApHO5bdj+c4BUVrJC7IYFE6cnhnCuvA6FRyFl98Nlec5CHXt3/P3jm?=
 =?us-ascii?Q?p5q/9ojlsdIljqRbSGEv5cMXK9deiF/mdXrUBmRGPti7/D2wNQpTeoKkqko5?=
 =?us-ascii?Q?DH300INLMqbkcWqJcE/ZhDhO1ozlISW2VkPsS1ziN5040NphC8VIFD/u3Wdh?=
 =?us-ascii?Q?ervDifZspeupne1ngTJWBDAluT/JuB7I09uL5KZLJuFeVbZkP+YXTuULZHXT?=
 =?us-ascii?Q?D9ovD4tCDEOHNXWTmYTnK9IUXv2rEfXYv4Bu65AmYm8TRMsVZAvv+yevp0wQ?=
 =?us-ascii?Q?LQkHK6f+9g1SAk8PVQg949kVnBB0gJtv9uwwlkklJ9gQ7FK2bBSOBXGVRWgP?=
 =?us-ascii?Q?K/IJo/dxag78MlDJkvXAwcfB0WQ+Rbp3fOI3HbqjvQX673urHOVnBj9HTZk4?=
 =?us-ascii?Q?JKSP7WQLU0ff2uOT01rExsGnojaUqcEtv7v0nhOLLvAjoHkfp8HLidJJHlQc?=
 =?us-ascii?Q?fd8ynV7JXGSZ6th15/pgWQ8Q7t0o39PCHF1HOsDg+6mnZnTnm4tyK1Ibkzrb?=
 =?us-ascii?Q?6j3NcsP+vZ4HFz5U4qGEGcSKsM06WNoatJpl2SGch1yB5yew+eJDvmWvHSSW?=
 =?us-ascii?Q?yaWb78oe97M5rWPbETR8bvKNcbjpIFwo9z2BB5R6VK2G/xJ87lO7Go7GzbyJ?=
 =?us-ascii?Q?goKgmmhYFF4jKxVT3PQZGVC0S0meBIr3nK0dOtaVdrAN9L0b/H6tbHc5vNKM?=
 =?us-ascii?Q?DW6qtlzwoUGCEB9x+dtgADkvelfrnFqjk73LyhctfISsMpX1yupzglmfryAd?=
 =?us-ascii?Q?i1MFZqEhjbCKYb0MqegyYg3W1wo5Ctax4trbl1qq62mYzu4wpfu0Xf3BC2JC?=
 =?us-ascii?Q?EgwzP6LWdiYMbyPr4gdipu87JSZGZjz6lqy5F+HrZ70rDII3zyzMLfxFDF61?=
 =?us-ascii?Q?mVtr8AMLFnwAjZFbkehHOdUn04q8Ww1ySG/iWfrH1sZ8kQtFxzDLN7qSz1do?=
 =?us-ascii?Q?/fmjW7xGkRacWG6RsUR3JovUDyGVNqcWq8O/wVMhKGHLfdj92Gbo8wfszHEu?=
 =?us-ascii?Q?k9otifE8JpvBUZArzGMclUmRtt+nfcgGw6Vxa+q2qIwPqVfuGlxRICn+jZVS?=
 =?us-ascii?Q?wkcvQeBajCbS2MrPRDGLlBW3tp42kj4z8uRcxlScjbT/7gPZ7/wMTFOQOQMS?=
 =?us-ascii?Q?seRqtSKPoBtQeCeKNZXvXSkIp6a85v0Ca7QoJT9ME/QnX6zN/a+i1DGBic+D?=
 =?us-ascii?Q?g9QmzDrR1CZqDZeglOsaNYFjsgiYT0BP/yZBFjNOKmQkcriyl5/wIWOAvzN6?=
 =?us-ascii?Q?Dre9uvT0CCkwX7YiLUsJeoZDXaj7ZH5DsA3OaM/NfagrsNudb83YgNJ42obc?=
 =?us-ascii?Q?cIcr12XTfpAISkUW6m8cEEOTaP58G3mm/EC/DnHmXjZA1Au94ID77GdoPGIh?=
 =?us-ascii?Q?kM1r2QITfWob2X1BjMmQqdM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d233470f-0a14-46d5-02af-08dd515c1fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 03:10:26.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDpF9nJEUivxO7eTPCYpmU7hL1lVvaeSMkGrPrilTwfDqsg59kbvD1VLiZxE2fHPF4qCCkQonSfw/FwT+eD5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

On Saturday, February 15, 2025 1:03 PM, Karan Tilak Kumar (kartilak) wrote:
>
> On Friday, February 14, 2025 7:03 AM, Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 05:42:25PM +0300, Dan Carpenter wrote:
> > >
> > > I guess we can't call schedule_delayed_work() without holding the
> > > spin_lock?  It's a strange thing.
> >
> > Actually, I see now that we're just dropping the lock to avoid a sleepi=
ng
> > in atomic warning with the GFP_ATOMIC allocation...  I bet you could ma=
ke
> > the code under the lock much smaller.  Just the test_and_clear_bit() st=
uff
> > basically.
> >
> > regards,
> > dan carpenter

The window can be further reduced by adding the lock/unlock around the list=
_add_tail. But this looks good too.

> > diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_dis=
c.c
> > index 11211c469583..ed141236a4aa 100644
> > --- a/drivers/scsi/fnic/fdls_disc.c
> > +++ b/drivers/scsi/fnic/fdls_disc.c
> > @@ -308,31 +308,22 @@ void fdls_schedule_oxid_free_retry_work(struct wo=
rk_struct *work)
> > struct fnic *fnic =3D iport->fnic;
> > struct reclaim_entry_s *reclaim_entry;
> > unsigned long delay_j =3D msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
> > +     unsigned long flags;
> > int idx;
> >
> > -     spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
> > -
> > for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_=
SZ) {
> >
> > FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
> > "Schedule oxid free. oxid idx: %d\n", idx);
> >
> > -             spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags=
);
> > -     reclaim_entry =3D (struct reclaim_entry_s *)
> > -     kzalloc(sizeof(struct reclaim_entry_s), GFP_KERNEL);
> > -             spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
> > -
> > +             reclaim_entry =3D kzalloc(sizeof(*reclaim_entry), GFP_KER=
NEL);
> > if (!reclaim_entry) {
> > -                     FNIC_FCS_DBG(KERN_WARNING, fnic->host, fnic->fnic=
_num,
> > -                             "Failed to allocate memory for reclaim st=
ruct for oxid idx: 0x%x\n",
> > -                             idx);
> > -
> > schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
> > msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
> > -                     spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lo=
ck_flags);
> > return;
> > }
> >
> > +             spin_lock_irqsave(&fnic->fnic_lock, flags);
> > if (test_and_clear_bit(idx, oxid_pool->pending_schedule_free)) {
> > reclaim_entry->oxid_idx =3D idx;
> > reclaim_entry->expires =3D round_jiffies(jiffies + delay_j);
> > @@ -342,9 +333,8 @@ void fdls_schedule_oxid_free_retry_work(struct work=
_struct *work)
> > /* unlikely scenario, free the allocated memory and continue */
> > kfree(reclaim_entry);
> > }
> > -}
> > -
> > -     spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
> > +             spin_unlock_irqrestore(&fnic->fnic_lock, flags);
> > +     }
> > }
> >
> > static bool fdls_is_oxid_fabric_req(uint16_t oxid)
> >
> >
>
> Thanks for the comments and changes Dan. Appreciate your help.
> The team will review these changes and get back to you.
>
> Regards,
> Karan
>

Please let us know if you would like to send out a patch for this. We will =
review and sign off on it.
Thanks for your review and changes.

Regards,
Karan

