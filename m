Return-Path: <linux-kernel+bounces-176850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21508C35F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941C0281724
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF31CA9C;
	Sun, 12 May 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LQwJN3kW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IXCUDfgD"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98471C68C;
	Sun, 12 May 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715509458; cv=fail; b=Rvi/wGpC4Dbi3MvfRp88dAZWyvwY5YazZzLq6VYSJ9JhhFTtXyAxC98+3wxmv1TcM/ZU5l0Hq5EEN0yOr8VGn9PW9z87imilCPOZ9cm3FZ/9mI9uvCjxe1UOTR6uUT5NHho+wUcJSz60f2cdUVG2lOehYM1Cm60C9fO5+oR1IAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715509458; c=relaxed/simple;
	bh=zMglL//60IreLiDVQf2fgk0H7ofFkxw+9+nft71jF10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n9xkgXWjpuswuCSAjJ2+002/P3Qu7XAuj6Y4KF+lZh8pITnUzOEbaM7079gW9DwNvHNWUdCTo0Cc55R09FJecT6PwcpNkFS82hdGoMMhuKZIvcQd8/wSnbiK9yXlaqzgbw892oO1wRoZW9IX5tc0xfcso5F2enMsyGQTtVN0r9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LQwJN3kW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IXCUDfgD; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715509456; x=1747045456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zMglL//60IreLiDVQf2fgk0H7ofFkxw+9+nft71jF10=;
  b=LQwJN3kW3P/GxC5Cde6v0R5I7H3V+odc1D4CuMfj1rD+InhqiiZVXtri
   2viyGJhJC8wxk0s3je7mUh5C8cbNh3HO7HyT9pnHMi0bjM7VO9VhAGmF/
   bEsZ7wUiiQmirxOCytrA361PjiLwXfrO46HDtp9RA/h9UUPnkFQ3KTBW1
   0UF6ou+BJBJv+jpds71rAODf7PF2i12V4KCxEZnbdRHsf1YKsbGQro0m8
   2pzi88b8g/k/6HSibfXNR3XOqEMTpabslp9mcUUmLETe/7oub1RUyqKvw
   +oovC1y2lT4/t9N3QGdwtuuxP20m/GWncipzGRBeasex5kWlvw9tuJsk3
   Q==;
X-CSE-ConnectionGUID: JcevKYEOR5ecHfQxuj9gpA==
X-CSE-MsgGUID: e+OJRtxbTxCGXoUiEZf9rQ==
X-IronPort-AV: E=Sophos;i="6.08,155,1712592000"; 
   d="scan'208";a="16954914"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2024 18:23:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISjEEPa4u7tdUwjCYaj8qfJ60Wr47nTsAVQNOgFI594ajR8bSfUlSZmltkcGLRaz75qFWp2FK0T/UHu3C7/1fy133RqG0IloYn+R0x6dtA3hRIgVaKKcynSH0lxw0oLb0yfjGBdMPcQR11S57+jKTEcfyeEXYnZr4ceu238pSOrdrnoJVI1+h51tK0mu0UES4wKMhAksCjeYLWDJnLG074brCkyTS9c+tsOthu34jAkY0Zh4xsOzFqMerHC8wi+IGd3fWaqDNzo1zchSnqEFBHpV0YmXvmPoGXxPXTOnawf7eatF9A4HOxuNW00i2McUr+W9+36kXGvMJ4TCs/r+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB0FlGhmB8gkoAaMPUa94LIFxXagLV6HyFCQPN7JZco=;
 b=nVK3qJMeOv1L1CamvwtJ59dB7DaK9RJv+1hSEc06b6DKM0IrvsJadTtgpaUshDW9KL7NuqtLBPHArkNeebaQ8tPGptQilPUmMXXdYyUgaZVBQKygGxRlsAW5vJmvr2leFPyI2M6KtGclRwYRQmItZLhjZotslGCeOfq2rrGaIjcpxufLZe9O3feGG7tSqR1M5p7gdL+FXvlzxOaeJuEHHUuSxqMs3Sm5+JzFTKf5Rhl/dC5eSvDbolFaG4bCz4y7DQzxHG2RXXewWQu6QAm2iMZKcIMV2nnhpiu/S6w2g8L2odYOCwo/gaXMNaI3OSD+GuEF8Lz07+Il2O3nPftQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB0FlGhmB8gkoAaMPUa94LIFxXagLV6HyFCQPN7JZco=;
 b=IXCUDfgD5ZcWTIK6nzSGoQR0zla7SDwp2MXfWL67q/3aohYdFnEubgT6NOAxH1rlRWmaKHn2uH6TkTCyWVyQlrBoEvmrtUdVOlKfQfJR2v/mCewGlFTr01ffldmJWoDDFZAwKVvEDMeF9IVtEcXF+o1/ralEl85dmJF88jmcSI4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6316.namprd04.prod.outlook.com (2603:10b6:5:1e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Sun, 12 May 2024 10:23:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 10:23:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Klara Modin <klarasmodin@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, "bcfradella@proton.me" <bcfradella@proton.me>, Danil
 Rybakov <danilrybakov249@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ben Fradella
	<bfradell@netapp.com>, Ranjan Dutta <ranjan.dutta@intel.com>, Yifan2 Li
	<yifan2.li@intel.com>, Jonathan Yong <jonathan.yong@intel.com>
Subject: Re: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Thread-Topic: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Thread-Index: AQHaojL91N1jMhQERUKPwzt4AofoErGQjnsAgABL7YCAAo3rgA==
Date: Sun, 12 May 2024 10:23:02 +0000
Message-ID: <am2n3qjaxgnciwfxhqs4aeosyug2oy2umuul4dzuagfhxdjlod@7ksrhwbjdxuc>
References: <20240509164905.41016-1-bcfradella@proton.me>
 <Zj0CIPR5djf0-hHb@wunner.de> <Zj40RnWnNqpr4Nom@smile.fi.intel.com>
 <b9ce0494-ab30-4647-9b0b-e01cc19dab23@gmail.com>
In-Reply-To: <b9ce0494-ab30-4647-9b0b-e01cc19dab23@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6316:EE_
x-ms-office365-filtering-correlation-id: 43a60500-341e-40f2-f430-08dc726d8144
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?J6TDB3FqYDwKX/ft7R0V30It9FBtWNHW2KQSE14A1iSoloXN+W6Wt77SRr?=
 =?iso-8859-1?Q?n906vMtgKEPUTX6x6SjDwNbznpQrcHwGpmgDhTZq4dqEkX1dpC3EzbIhZ8?=
 =?iso-8859-1?Q?eOUUGPnQyj29ql4K1RuUz/dy7z74SmhjHVXS3FdlXV+EXsMiQCsfGudKQX?=
 =?iso-8859-1?Q?YAi03y9/Ub9JE+nbv+SDg0zCqIsdsZb9Zt3wjxT1Huf1ScpdK4uQMDc8t5?=
 =?iso-8859-1?Q?vbsjGVaqE4d2ChGhQgFjKnUmjAX/FKeLK45y1dRbxXklnzNkwUXLJh92BQ?=
 =?iso-8859-1?Q?oTVUKPL8EtruYErDF4PvKP8fhEh14sRF93+sCnturqneff2FHdaqeVKGft?=
 =?iso-8859-1?Q?GBswjox9ONY2payAd3vhDK0u0csZr9t9fjpFmAexT3SmQsKh2Y7AAI6jvD?=
 =?iso-8859-1?Q?gQWMW+a1dt/44dtCON9IOlLbYIcCrNU/se9rV3VfZvw/SiyehZwtbqX0Sp?=
 =?iso-8859-1?Q?spa46g5kMhKsF1lipGcFPwPOkYIt7EOTioKBqrFI/JRo89WOWwKKMGF0bV?=
 =?iso-8859-1?Q?4MPJlcIH0T7OFH6pLIrMOvdqFV8Q8hDfq4yhuH49SMhOLkR57B4z/ctFbm?=
 =?iso-8859-1?Q?HbatljyYNxLCFGM2Kpneato7v2gwa+5IxLnVaB5QE4CY1iySDsqY/8AXry?=
 =?iso-8859-1?Q?WkPhPsM8O+qC7psjLfZOiz1foUb21e0xoeviHpUJJM67Kq4Q9NKWWa+jlI?=
 =?iso-8859-1?Q?80HiSKuWPTpGMIYltAC3LfTiMommnLFQazYm3Tai1urSwgU6lcn4PXSbzt?=
 =?iso-8859-1?Q?vSSHJiHX5+FIS21oSOpa9c72Bp4lTqgreRk74pl0Sad75CvETIF3TStTim?=
 =?iso-8859-1?Q?MOpEy8L6wcZIbers4xt01IbHYl22S/S+7qNqn6RkXDilLrFQebEkRjL34y?=
 =?iso-8859-1?Q?kXc5hRT+JaRODieSVemIpub3hPy8wtoYeuxI33mzu++YeJYgEsoYuTwahq?=
 =?iso-8859-1?Q?hiFMjtl013bk6XDWEXjByrBo5J/e6kOmatXRYaJE07OiLgyellMyo41ATZ?=
 =?iso-8859-1?Q?4M4k9Ci5OUkPG6IiTPe5Bz+m3rM28D9bKZGSwsRuFuMf65KEb7fhgkjGSz?=
 =?iso-8859-1?Q?UwNA1glrVrpe+6sRTCrU5y7pL6i99Co5Vjse6/vcTyiTUrddLLz0bcvg/S?=
 =?iso-8859-1?Q?8t7c/8Z7mJkJQ6me5ZaboUoC4PriyPjfNUs6ZIfd8u8wk2GhW8IkZ8hTXT?=
 =?iso-8859-1?Q?RO5AfZjKrLK74xbOSo6kXZmHLSATMF6C83OBc7WwaRlD6b8Diii3IA71AL?=
 =?iso-8859-1?Q?fQEyjJIUCcPiOy6XZXOhe80zRLI2itrtGxe80Hogfq9KPrgYCaAN4uIH3J?=
 =?iso-8859-1?Q?1W/r8kRhbm+YFbd7BZCMnUbiN1wL7UUR+cW7Nh3IVE1VIhMPx0E5mSKc5h?=
 =?iso-8859-1?Q?RQSI10vzhdTYCZJGcNPYtwUekP7SQH1g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wt3fjGcpOyWTa1FiMGVr9rpCB3CDZNTmEPHKuPuo7SVgyvkV4lxzY7scWW?=
 =?iso-8859-1?Q?sZpOqK6Lx0b/1dYY6T7tWEwDUWXjowrAshQ2MF6u3sjlMabey2e6kDeZN4?=
 =?iso-8859-1?Q?AQlkt14EKo415RFIkXeqKNeh6+qSJoZcvvs88JsP2FC0idfsBIphpVC4G0?=
 =?iso-8859-1?Q?hGwYLvqiGuVJ4okMUdTDjywd3XRBqWxq3Urm6ns6zqMEcwXduzq/AZDBs6?=
 =?iso-8859-1?Q?W6JQpluOty3uK/j1u7OM6sEurV+0g/9WOvY56BzqxSMkErmxBjMU1yWPYu?=
 =?iso-8859-1?Q?Lq8R0gz8Pdhe+lYaK/CpVddAVgn8qO560ixNnErBqulzkFvYG9T/ZjUA7D?=
 =?iso-8859-1?Q?f+/r33qECiPgeuy6zObXk9lWgw7SBuyYMfWZR4RqodTJxKG8CU/jVPxftT?=
 =?iso-8859-1?Q?LQEY/EGiwfJqWgFsNRXUXs3hx8MV+lbnxNMOiBEFj7VzJLWsSfmUEXxLzd?=
 =?iso-8859-1?Q?1OhkCOaRpBjNn7FneDWSI86aHjWoaig8pqSIU+LzemFAYgQbwIZhzeVs/B?=
 =?iso-8859-1?Q?XTp+PKGq77V02MIDclYYtZGvjXNTpCHsJDh0Iid7ugaqGsonbPTYfTXGx1?=
 =?iso-8859-1?Q?Dthubwlmh80OMULcNS9iUp2zJ0cJZTc28Hd2CX5C5JNcahNQfaO/4BUJcO?=
 =?iso-8859-1?Q?+/bbWMW4jGZOG+Y1h97jonp4i3PEFByPalNjxE/VvFgqnjmmSOJ+5KDWNO?=
 =?iso-8859-1?Q?UY5BVSGivJ0jxFrdTr5XA+XSzpChNIUUxwqtIZvMT/s+LliIXLOHanow0j?=
 =?iso-8859-1?Q?wGozw92beijzIHcfBLYzJ8BxHWIQu3L1cy+FpOZ69JcGwDL4aaVlGzAUuM?=
 =?iso-8859-1?Q?osCcDOPTMPJcNL6kMfVCW2KLuz32IyN93OmXoaXEFgKm6g++bk+6QLt/iP?=
 =?iso-8859-1?Q?7hWf6Q6jAHq49u0bh1NRm7GHO/BSZfrraI+2Pq2jHdQ/p7Mbsc2ecyDCE0?=
 =?iso-8859-1?Q?RsXUikEbVpX+PjKzvY+jphIeEMwi4D3eJqDyzPcjDVUlBpNRjpdFtaD6h8?=
 =?iso-8859-1?Q?o9PBgHMTng9onJYG4yUPuU3yHhrGKa99Rjg/QyzTfRhAocrsoFgD7XMPW9?=
 =?iso-8859-1?Q?DjGkkvJSzeF2QX1IdMw0HXdr1nwuxar7O/Flwh3HGvSUYy315HaLujdkPp?=
 =?iso-8859-1?Q?TdEYJvam0qYM7cSayCPocspdFTFXrA6SmG6yRFoE1pAZzrV0WOd57nxAeb?=
 =?iso-8859-1?Q?HpleFWsDWCg55CI3U+QS5iyVm5r3w2/zhk+kvRMaydhIT8eJYqfYyUwkGM?=
 =?iso-8859-1?Q?ZqlzEuZuGkFWAWnqDw7CHQguscTOMQXqfQ81bULMjIS0H1XUijOk9RsAPO?=
 =?iso-8859-1?Q?0PCg8sa5/75YMYO6diWxWP/6P9tQgNHsBWuOnmYc5YVsHJw1sn2Rzp+Ze1?=
 =?iso-8859-1?Q?mI57LQuFjoybTnheEjqymfd66INirye6ZtaMElkD20qj2InIH9PdGHuhb1?=
 =?iso-8859-1?Q?b3lwSI6Jss3wg+qnp/JCKVmOYhk4qjf8XqHRiOEErFqAFau3gP3Ji2GBbf?=
 =?iso-8859-1?Q?mI4UhSqzVGSzgOMYklUtAmcbdPHuBpMIIBL71Pq9UwfvoV3XnuOQ8FQ/hz?=
 =?iso-8859-1?Q?xMZ8wij8Mafdxi8PZHG9Jn6Ck2GysvytrqkOZyyDJbKmHC3o5NrRsoaIYN?=
 =?iso-8859-1?Q?DUHtxeetxjSNLTDf8934jOIL914VaggDavHz89GLvNKa3r/BDFHEPiT1eh?=
 =?iso-8859-1?Q?Kp69Bg/F9ETyMlnH3i4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5D9FB9FBF043FC4DA951E5AF6FE3AB5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5RrQpZMTaBVghft57Bk1BB7pEb+sxQ3ubmOpoLpbMCidUAd6WLl9aFB7cRuCBepRn+pP69CUdUEEMQsYTJMBSzdk0Xou9EzOoawv4VCrW9WN+q8IW2yr1aCrrzVdr5L4aOisDvAEB7ZBQSq9/xfPxZuGEriDeaP9zf+zIEvJrCX4h7+CJVjCyDPnK8fvVV5MVsRWawKjrXBjOWTibWA7XupOlojNICM/uNOaeasYd6Rn++kcudx+D/GyESTpqrRWxnbYxGr3R/FsNCrrB/X4KTSki3TEMIPU1zlPQcmYmQVRtusq33qxp1cwBXxRpfV7uM/16lxgCNfr6zYBylirh0xPlr1F6GWeJwQVxctiKi8oNXJnQ230Lb9f+0ho1uBnmKPf0ZryTBI41JefPP0e9uuI/xfvpmirfKasqrlimgRPqazjo7rKtYRrg14sT+ljuTxmdY31wLRKXqCJI/UOXaE/l9lvpJAHweAsQQYZ39dNLAQpYeSWPLjW2ATlw36CTW/pbPxUPqp+1HbrWpRMG762q0MqcJYfXC2nkbxfKGMPqHkoWtRExUk5IkwU8j+qT/CBhrkVXab/d51nD74TeigYBfAwN6yWIunHjoAlPZjbFCF2vrywT6caxau/dhFd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a60500-341e-40f2-f430-08dc726d8144
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 10:23:02.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk4zxvfaA9U2ytWWLHAmYV8/eYjQun/CeTDdLbBnoCNPjGabkHCE0hI/oVILFFAHXDu63Vve8k5HX6thsYRYnwZDGBGclbUaUY7sA+VyjBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6316

On May 10, 2024 / 21:22, Klara Modin wrote:
> On 2024-05-10 16:50, Andy Shevchenko wrote:
> > On Thu, May 09, 2024 at 07:04:32PM +0200, Lukas Wunner wrote:
> > > [cc +=3D Shin'ichiro, Klara, Andy, Danil]
> >=20
> > Thank you!
> >=20
> > > On Thu, May 09, 2024 at 04:49:34PM +0000, bcfradella@proton.me wrote:
> > > > From: Ben Fradella <bfradell@netapp.com>
> > > >=20
> > > > The P2SB could get an invalid BAR from the BIOS, and that won't be =
fixed
> > > > up until pcibios_assign_resources(), which is an fs_initcall().
> > > >=20
> > > > - Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
> > > >    enough to avoid a race with any dependent drivers.
> > > >=20
> > > > - Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catc=
h
> > > >    unset BARs going forward.
> > > >=20
> > > > - Return error values from p2sb_fs_init() so that the 'initcall_deb=
ug'
> > > >    cmdline arg provides useful data.
> >=20
> > ...
> >=20
> > > >   /*
> > > > - * pci_rescan_remove_lock to avoid access to unhidden P2SB devices=
 can
> > > > - * not be locked in sysfs pci bus rescan path because of deadlock.=
 To
> > > > - * avoid the deadlock, access to P2SB devices with the lock at an =
early
> > > > - * step in kernel initialization and cache required resources. Thi=
s
> > > > - * should happen after subsys_initcall which initializes PCI subsy=
stem
> > > > - * and before device_initcall which requires P2SB resources.
> > > > + * pci_rescan_remove_lock() can not be locked in sysfs pci bus res=
can path
> >=20
> > PCI bus
> >=20
> > > > + * because of deadlock. To avoid the deadlock, access P2SB devices=
 with the lock
> > > > + * at an early step in kernel initialization and cache required re=
sources.
> > > > + *
> > > > + * We want to run as early as possible. If the P2SB was assigned a=
 bad BAR,
> > > > + * we'll need to wait on pcibios_assign_resources() to fix it. So,=
 our list of
> > > > + * initcall dependencies looks something like this:
> > > > + *
> > > > + * ...
> > > > + * subsys_initcall (pci_subsys_init)
> > > > + * fs_initcall     (pcibios_assign_resources)
> > > >    */
> >=20
> > This makes sense to me
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > I assume others will conduct the proper review and testing.
> >=20
>=20
> This patch did not introduce any new issues on my previously problematic
> system.
>=20
> Tested-by: Klara Modin <klarasmodin@gmail.com>

The changes look reasonable and good to me. I also confirmed that the patch
does not affect on my use case using two my test machines.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

