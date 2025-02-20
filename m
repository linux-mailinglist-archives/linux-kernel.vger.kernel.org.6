Return-Path: <linux-kernel+bounces-524805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFFA3E74D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CDA17F904
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3920D504;
	Thu, 20 Feb 2025 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Eg90gHYX"
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E8192B86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089699; cv=fail; b=ADr4/aC3az+i48k9SKvj/f7O/CvIX6rDHFQE5+8+h2ficNJbq0yvpxshfPLK2eKMZivN6GEtCUc2wvaWcdP1kETLqg8Joni/W34E0pk7kcWNXPyTCplCN/Kg+4SowS+iS5MJvo1GDWmJ+dVWXuDAW2qsUzgUM9daOD3H4EmoSyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089699; c=relaxed/simple;
	bh=4iAt3FgiQGwmp1kFPvCH+HIxTIoSge4S//4hj6pVWww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nlw1MUS35BSi0jV0PKdnR+nS2dwp4IonlQApdH31xO0K7AAIGo2uDGiJd2j4WBLecef0PZoKiQTFhRWaObCvIuQIrV+Qe8QU9QE+VP+IWLCpJ1/FO/kk23HARHi+EoT+up7lcCRwWT1/sgt3wtzhIYf6LiKPX2OfNxio6GeZHeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Eg90gHYX; arc=fail smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1255; q=dns/txt;
  s=iport01; t=1740089696; x=1741299296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DH66QqtxPWTtLGJpZ2eWQf3XCsaybqFHvLVpMziFEGk=;
  b=Eg90gHYXths6A4SaDOaNQtC+1azh2DN1wcyLfhVj5w6gsXuzUwU1iHSB
   OxGxAITdXZWVez/hpcpvSkc46x7kKfUsjgc/aVDsMPkCJgVocJxiFClKs
   RegbiQCwYUaHi7PTsUYwgi5ey8kEUV8W6QUWM1g65HusJH70NxbGoYBi2
   xUKpXbM8STk/26Wuvn4vO1Z8izea5ljpXkcmI/vrEvvQCLXBhBpdqBUf9
   WPPcyxoEEAZxbwKD8/1Nl8vmCkR+rtyXB5I1ZyOdzsdY/xyk5fBYqUzbx
   WaCXGCsMpta3JowxzUeqJ117LZh9Vt9wLJi6o+ULYG/NpH8XFRWbs1xYB
   A==;
X-CSE-ConnectionGUID: 60ncDm9oRFithpEflc1QrA==
X-CSE-MsgGUID: 14VpsaomRNSK2ntCF8kT8Q==
X-IPAS-Result: =?us-ascii?q?A0BJAAABqLdn/5X/Ja1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBcVIHghJIiCEDhE5fhlOCJJg4hVyBfg8BAQENAkQEAQGDc4EUA?=
 =?us-ascii?q?osOAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4YIh?=
 =?us-ascii?q?loBAQEBAxIoPxACAQgYHgULMSUCBA4FCBqFRQMBo3MBgUACiit4gTSBAeAig?=
 =?us-ascii?q?UgBiE4BhWuEdycbgg2BV4JoPoRFhBOCLwSCL4FugldnlnaDGowuUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEpSAOBDyOBIwU0Cjc6ggtpSToCDQI1gh58giuCHYI5hENcLwMDA?=
 =?us-ascii?q?wODMIVSghGBXQMDFhCCMG93HIR7gkQdQAMLbT03FBsFBIE1BZ9JPIVcZIFeQ?=
 =?us-ascii?q?5JDg1GwAwqEG6F9F6pSLodlkGqkE4RzAgQCBAUCDwEBBoFnPIFZcBWDIlIZD?=
 =?us-ascii?q?45ZyhZ4PAIHCwEBAwmRdwEB?=
IronPort-PHdr: A9a23:XQNawxdx8gDukoJMKJ7+nSGSlGM/gIqcDmcuAtIPgrZKdOGk55v9e
 RGZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:pkC0D6/4/VXhMZ6ELWqhDrUD13+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2EYWTuGa/yPY2Lxed0iadu0oRkEsMPdz9c3GlZupStEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qpyyHjEAX9gWMsaDhMs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2loZYsT1uMmBltg9
 OAYMB0DahvavviflefTpulE3qzPLeHxN48Z/3UlxjbDALN/G9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0wn1lQ/UPrSmM+rj2PjcjlRq3qepLE85C7YywkZPL3Fa4CPI4bRH5wN9qqej
 juawXziCxYfDvqk6mCD7lmC1uzzzRquDer+E5X9rJaGmma7wm0VFQ1TVlahp/S9olCxVsgZK
 EEO/Ccq668o+ySWosLVRRa0pjuA+xUbQdcVSrd84wCWwa2S6AGcboQZcgN8hBUdnJZebRQh1
 0SCmJXiAjkHjVFfYSv1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:VXlf6KrjVj+8CFCzOxmM1jIaV5tkLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV7QZniWhILOFvAs0WKC+UytJ8SQzJ8m6U
 4NSdkbNDS0NykEsS+Y2nj3Lz9D+qj7zEnAv463pBkdL3AOV0gj1XYENu/xKDwOeOAyP+tDKH
 Pq3Ls+m9PPQwVxUu2LQlM+c6zoodrNmJj6YRgAKSIGxWC15w+A2frRKTTd+g0RfQ9u7N4ZnF
 QtlTaX2oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweBfu1aKv2/lQFwhNvqxEchkd
 HKrRtlFd908Wntcma8pgao8xX80Qwp92TpxTaj8DjeSI3CNXAH4vh69MZkmyjimg0dVRZHoe
 R2Nleixt9q5NX77X3ADpbzJklXfwGP0AofeKYo/g9iuM0lGf5sRUh1xjIOLH/GdxiKs7wPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy8fB9/gIm1UyR9XFojPA3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibGjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dgP129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttconexKvVaPF0NiHFKu1vwCMlIb8oU/4AKieznv4=
X-Talos-CUID: =?us-ascii?q?9a23=3AEpig9GpWbbGwLVMRV9JYtsjmUZ59dHbxySbXGWG?=
 =?us-ascii?q?5FWZxZbORQgap4ooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Apna97g/78Jok4CGwLNM2T3uQf5403by1AUcIq7M?=
 =?us-ascii?q?9mJOCKQdeazSh3A3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Feb 2025 22:13:48 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 6B544180001E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:13:48 +0000 (GMT)
X-CSE-ConnectionGUID: HJycO53xQCWJYoXCScC/7w==
X-CSE-MsgGUID: QhXwi75pQYiqW3x80ix1Ew==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,302,1732579200"; 
   d="scan'208";a="23027750"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by alln-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Feb 2025 22:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/Jf1dVGSknTWhCuLQn1h0ET/Asya7GorBZ1xM6qrZGoLdWFGAnwA80MmXm9bWWLMeZKMsD94EpkokQ2SZr6PARE8tKgMGzUgjYBzXyciazTT4/2xc8a/8MPBBPl/Hs9IHy9OcrQUNvoNAQrAx1QlXTB5LsSYfE7uRaym37yFw/pohVLGj5CNIHTHLVYeJL7QfEOLL95p32G7CZgxZRL2U4PZ8vYP0TlQTpe2tP54ZZkHDsjTl+ZP2RvRgUz4aja/E5KirDrwnbaTQZahs3ELMOszDEkF/6wTw7l1UaC33bVvgck+RurR6X84+z0l0qZlnOVTbIEXOPvD/rlP6Lnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH66QqtxPWTtLGJpZ2eWQf3XCsaybqFHvLVpMziFEGk=;
 b=DaWm5v65RoxrTgc+OEsTkbJJ/X2hAbtdDiiRgWUHknxDcBH19bDoxPQae8yRmDqOYrABbF6kBxQ7/c0wvQ4fAVhnjf7QLHyVoLXbN7TpV4+MAHhsJSUkeqg/aprynD7OvPkxozBMFLAiD2WGoidQhkd9vXfTAg8f4K2Dt1OYBjC1PZyZ+bAZNpCaZtIhCcZMXXeaJBLCzR4iA9zPgE/rvQWnK9/eRa6hszk64qgmqydFmMo3KsKDTiewv/gycwZk7f2MaKxg9BZQv27u8RxcfUT9KDH57NDX2RHQf5Yc3hEKOc/efeDiX2HemJTF18ka40byNcYUnqr+I+JvLGsbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:13:45 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%5]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 22:13:45 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>, "lkp@intel.com"
	<lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
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
Thread-Index: AQHbfu60Aqs0Y1uoDU+0WvnEcG3OM7NG5RiAgAH2PjCABrBEYIAALR+AgAESZfA=
Date: Thu, 20 Feb 2025 22:13:45 +0000
Message-ID:
 <SJ0PR11MB589636FC2FF34B7DE8A14B2DC3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <f1c717cf-63eb-402a-82cc-91c445055b97@stanley.mountain>
 <fd4d8516-5eaa-43b0-9100-2984312930f8@stanley.mountain>
 <SJ0PR11MB58962A4F0B9CFFB9439FF959C3F92@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <SJ0PR11MB5896888C81BFF2EB81E2B533C3C42@SJ0PR11MB5896.namprd11.prod.outlook.com>
 <5886f4ff-d6be-4804-8c76-c431946128a5@stanley.mountain>
In-Reply-To: <5886f4ff-d6be-4804-8c76-c431946128a5@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|CO1PR11MB5060:EE_
x-ms-office365-filtering-correlation-id: febaf611-40f5-45c6-d40d-08dd51fbd7ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GBaI2HwOI9GjHsCK75nXopt6YSnBNeFJVvwKJwH7ggD1uypEL6ZFe04vPUIj?=
 =?us-ascii?Q?Q006BV2XkL0bGrHXqcHoCPXZbJ1HjEpA1XqncW944O13748IhKPJRZnnQsmB?=
 =?us-ascii?Q?d9Z2xwLjOFOlUrVonx4mrXMIYTW5kq7XKyQWuhcSr54z/HZC8s8Cdv76Qmhz?=
 =?us-ascii?Q?isa38WtpIMNqFqWBGU8T3TK7S35ttUdC/3ezSpoLK4XOBwgZe9yJMeXpOjFs?=
 =?us-ascii?Q?omm2u4mSBSi9uWV00FARNZTiY0nchCAb90bUoA03MfgKSkg61zs2tHQ6BQgP?=
 =?us-ascii?Q?Ws8cm43BkR7vrMIqcfQg/PXwe8OGgkoTsiMLcgDohpZXTDMbHNCMbf7K+edY?=
 =?us-ascii?Q?feMUhDOCgsgUumOck6TbCrleTEo5s2wGM4dfyld6zhM7bRl1BCXep0/jSgxJ?=
 =?us-ascii?Q?F9VVLk3KG86xwoIkjWndUohll4hxvJMXYxMcnI/b/Qac0UZWbKilr/Nha0IZ?=
 =?us-ascii?Q?pPMeWjbx/ALuvH1nAb1zuWLsaHCc9j5Ps6VBSON666Ck8gw5FZQTUhybo0BA?=
 =?us-ascii?Q?+5+j6g61bR4tzhhK4F8UUL4VWvMF5nP3YLR5cHwLYm3eW14y7Bg+xLctCNEO?=
 =?us-ascii?Q?WWWUbvrJiTQWIS8rZWicuGeQfmDIyAhwyBf3YaiHU36ocJu1wazkE6Kbj2Gc?=
 =?us-ascii?Q?VMfX0kKvf5ynkheuofJ8NUTDa60n4CpIacWSbUxvZoTWMzPYgtQUMEDfTuWP?=
 =?us-ascii?Q?gbsQqi2uKzJxDsNP0LBtg57SmWRPfyacyxGSevKkBcS9FhJXZBXKmKftGUIQ?=
 =?us-ascii?Q?aBwJ5llfayKX6xdPE0xEJYas27kxjczNjKkjg+NbX6P3OAgzyeVlKZ0jygnL?=
 =?us-ascii?Q?h2EsiJRDh3obAIsn9dde00+8NuZggNt2Fbhiz5iFmKB8owfjlmoOOW65+wU0?=
 =?us-ascii?Q?/3I27Ssi8dZmoxZaT/Zp8sUfCu6tHyf24Z1e7HRvAHCW1rxKGqXR6lWhsZIH?=
 =?us-ascii?Q?cc/Z/KWbQP9TYbL3CRaGwQFa8iAI/uwiLF19T0i3pCLb1a5PYBySHmZdFyka?=
 =?us-ascii?Q?t1ucXO/i5SXRJpUJxPELVeejmoJbc4+Wp4rPNvkPMPYHEpCsKLOI7JY4c/y1?=
 =?us-ascii?Q?4orOm8gzcp6/UdliUh5HhWqJETKV99YGPdrLntEPEoiBF0/3mvaCGQ/xkFIh?=
 =?us-ascii?Q?a8RfDI8LlLztTAAm5I4wwYQwx4iFimXVMd9Y46dqk2y5S4VhPz1rvVkRJSGz?=
 =?us-ascii?Q?uK9FR/piG0n+iH0tBWTHAsrLSdzaUH2ZfHoLfVdzSv7UTEE8G6R/i984Us4x?=
 =?us-ascii?Q?BpsLkh68mzbTrADRgELMYLK4IhtolzXRQ2tdY+7yakoFpInVAhc1oiP8JZIP?=
 =?us-ascii?Q?y2AQ1bsU4T2WUDSq6wT4tSjp4gbVZaLnNFK9EpvOuIkmMy63wwpRI9ZhoOmc?=
 =?us-ascii?Q?UKErNPg66kiq7xmIacX6iOdhvOmsntG/Ub6f7rJT94/RwbQ7NZfU5egbpJlQ?=
 =?us-ascii?Q?dnCU2SJY7R9LSufOTbAYEJ2M2td9Pxl6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l+zhCaD1HuANIwwJ+m1eFcTpb49uiTZxc8awK4pUFnM7UshboYpsUpW59fNF?=
 =?us-ascii?Q?0CzlmObIBE7EzSjDuYrix1p2IuNzTOImdhJu+S4IwW33QZfX1bZLh0Y9gex/?=
 =?us-ascii?Q?omC7EPXY7xGpRX/+zX4BjVUrNan/2ZAXwQVshNGquYZ/4+VZ4hU3UZRzW9dr?=
 =?us-ascii?Q?oNxSRvIvi5sDRzRX4rd5cfqQuwj4RMXP7N4aZ4GuDbxVKGtypeMz0qrQkxu0?=
 =?us-ascii?Q?47GNuTGmQzO4p4jtq7pWlxTFjwvVL158zv/IYD6nFXVf0DrKSeLcWg+/mozF?=
 =?us-ascii?Q?M944Pyn6hG8GQSkmkaMGG0SwZVSBRh0ggnQ9jMmE9axAf+cP5Z366YkuEbcV?=
 =?us-ascii?Q?I+54UMxclSfBCfRkwCs06ZKfZcoA6o6D0ACxZMuor8KZK8cPCDnQLINLhd/0?=
 =?us-ascii?Q?eG5YL7Yy7RnNZCq9tpXBRCRwlE4ahmu+4zLplPX8J4urS2GtBJNg9MOYzM1S?=
 =?us-ascii?Q?VioK9YNyHDEo9BPUep+NH/d7jdNvFkzcsjBTzpAHUyCWuW1DhuIo+W1Fp8eh?=
 =?us-ascii?Q?mnI1oBO5cJhmLvjg3wXNNzNd8lZe6N9XJNZr/pPnM4eQflv6Fh4aqLh2fVV+?=
 =?us-ascii?Q?e5fBFZ9SlohSjsOEGzSK3QErYhspTbgo1xl8DEA6BEd3BMrPTKzzb1KuPcU+?=
 =?us-ascii?Q?R3eV8eXf1s1oIjsuZ7UTP6C/EwSJq9pI9paZbsJ5UClKn/3ox5U0fHwfT6uR?=
 =?us-ascii?Q?hCnrTN7YYUVwlAjBE3daiXO1rle4cJ3nK6j0aUbbWS90ah+RZASnXthrkVb2?=
 =?us-ascii?Q?Ilv//XP7lY4wa8dY/TwlVe9/tmtgkOYJG+Xcvh6bQ+HsX+EKhOluadJeZxPV?=
 =?us-ascii?Q?ENyt0Ot8I/DrQ6PZx0Zj1+s35G7neE1k2ZNKvQeXJgqDoSTs8JAFg402wCi+?=
 =?us-ascii?Q?pn4Xhanbv1ZWyBZ3Y2eVGI0QXvnvTONfpVGLYQSt0IOxwSXig8sR15skJEYD?=
 =?us-ascii?Q?U7fMF+/EzxEsTTlf7CU6Nh3WjGjv5TohQ5ft276KO2/Ytwbr75OHSxqeEjR3?=
 =?us-ascii?Q?vaHxhGxx1mrgGDXcrbI4ai85b8ndx3C9ozIaaPPLGylaoEc5GF0rCxRoJ5SM?=
 =?us-ascii?Q?zgUvOTZwv59GVC+7ibfKWhVKrb9fICioBIq5ttDjc1QefiIchzCbca1gXUdj?=
 =?us-ascii?Q?MJvE7Ff6PrcDLObjIAUsdMcYxSES0UBniKS3Ey4hYx+HLiWg2MUXEJa3eqix?=
 =?us-ascii?Q?QYKzLlplB3xRndHAVVGbS1iEYOKl4LH5q9GBEUJZ2S/aIXixI9Bdpf/CDJ1g?=
 =?us-ascii?Q?dfsZSiC5nLSg05IUTPlsrR6zFgvT4hJnuJcO9ooFDhni+yowrWX65UItvDtN?=
 =?us-ascii?Q?CeEli/3WUU7PcVdPGxEgqW5NOlZa92iW1LPrnCTGWfrF6es5+NczPPQnR73K?=
 =?us-ascii?Q?Bv2LLvKDvcOi37rnBOsUmcm+wJ+/WLrrR2DMjTtLefoxQ9LovOrV/rXCcZki?=
 =?us-ascii?Q?M03E/i2/ip6L35QSMC6fVjrIFI5VXBIDm7zxV58L1/HhRK3OcVu8Eb947QD3?=
 =?us-ascii?Q?mJqD4CLzEim0YqjuW0h+uzFb/V2F1oO4hmVTkF6tU6ocpxhBcxQ/54qgQvgq?=
 =?us-ascii?Q?ACkZMfDMWAaGrZ6bOJFGzF7L4HDkrNCkPkYffCWyoNg6prNdKcVmPvlL43ei?=
 =?us-ascii?Q?pYTYcoFFRLGcIPke5caWy7c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: febaf611-40f5-45c6-d40d-08dd51fbd7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 22:13:45.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBsCJfPJl+t4sEiXUCmyaQY+tqmb0JnLmXzoSjenZ9wASZZjQSLS/hMraZEqGUuajwPxb7aFoMKxmcZiESOrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-12.cisco.com

On Wednesday, February 19, 2025 9:50 PM, Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Thu, Feb 20, 2025 at 03:10:26AM +0000, Karan Tilak Kumar (kartilak) wr=
ote:
> > On Saturday, February 15, 2025 1:03 PM, Karan Tilak Kumar (kartilak) wr=
ote:
> > >
> > > On Friday, February 14, 2025 7:03 AM, Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 05:42:25PM +0300, Dan Carpenter wrote:
> > > > >
> > > > > I guess we can't call schedule_delayed_work() without holding the
> > > > > spin_lock?  It's a strange thing.
> > > >
> > > > Actually, I see now that we're just dropping the lock to avoid a sl=
eeping
> > > > in atomic warning with the GFP_ATOMIC allocation...  I bet you coul=
d make
> > > > the code under the lock much smaller.  Just the test_and_clear_bit(=
) stuff
> > > > basically.
> > > >
> > > > regards,
> > > > dan carpenter
> >
> > The window can be further reduced by adding the lock/unlock around the =
list_add_tail. But this looks good too.
> >
>
> Could you send the patch for this.  I don't know the code that well and
> can't test it.
>
> regards,
> dan carpenter
>
>

Sure Dan. I'll test the code and send out the patches.

Regards,
Karan

