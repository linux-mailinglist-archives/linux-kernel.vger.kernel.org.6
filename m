Return-Path: <linux-kernel+bounces-548177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95824A54135
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA816C1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25A19993B;
	Thu,  6 Mar 2025 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Esq5hUZa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB01990AF;
	Thu,  6 Mar 2025 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231382; cv=fail; b=CQs3GmUHqXGpunGSVGTqBqSUFFftyslnGkvzHzK6hdI8sGAY1kfpPwNXSvwz04f8JnkpBkXqXDlLa+3H7yrpBeqPMeb+QGoYqBbt+9T46GGUCaZwH/OrRBa7V6N8l0I10rMXKsuOqNXEIAUSMQW2TXN96VuBHOdRuluyVA/4Dqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231382; c=relaxed/simple;
	bh=G+lYwd3sanZuxF+0n3tVHZEpTzQrxUYqgnHyHlc4PnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAik3J67yRCjIzc+4/wBcJ44luQ8cMyR8oT4pjns4IPIF8fh4rpeT3jDikeMkfYwDL3Yo+lOpgpMhqV4o8Pf+wb5/a3hMtEdmybL4J6/yD9SGWkVG542GXHErp15Hjw/qUFQpRzZ4szYnEbmLDg3Ye7qAhoYPiMZcRpc6q5DdHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Esq5hUZa; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741231381; x=1772767381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G+lYwd3sanZuxF+0n3tVHZEpTzQrxUYqgnHyHlc4PnE=;
  b=Esq5hUZaqpP3WxbCy5xOI9eBxzZxM6sdBwo5yonttlpF3U0d5FOPq1U2
   C/QVEVfDKjA39xV5d8HrlHyzk4bv5G2bXKVW9Rf60CH1rOSdWEhu0BgCL
   gJ+DQw0lQBABsLp43lKUmsYSVAmzLaiLIPp2+TdFPZ1IM/8Y7uVbdtHvO
   6DHmx0qYqRHb0MCJFa7i9cJ6ID1a4CmpYcheD0ctsbz8ny3HipC0+rRED
   XL9+N820+A1UbjxBY81SdCWb3DgrQd0+EwjZk5caiaTQPtL9Qj3sxA1U/
   2MCZNsd6x5GU915W8KuKdK0aANQ3uvmDBCAQetWsm41sW7LkyeDGUxQkM
   g==;
X-CSE-ConnectionGUID: TCNOSFyXTjaLznSX+1JgwQ==
X-CSE-MsgGUID: nOZGJx/ySK6TEpX989Qt0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42251061"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42251061"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:23:00 -0800
X-CSE-ConnectionGUID: VtEHy9r5RG2YtS52Kdl8ow==
X-CSE-MsgGUID: lA+jhZ1/Ry6WJnudGqrEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123976799"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 19:22:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 19:22:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 19:22:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 19:22:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+EDGk3lX9pu5F1t7xpUBGNTsadWmFKBcFiNe2WSejpXOJ1QpDD5100Cahcd9/Z1rO9kuzZ3e0wF/xbJTIL3UNgjJsWG1S0NTgArTK8zemltOSfIupO7F4XIz2aM1hJtSxhv3SrQoUPCq0n+uUVulcOrmcAbuzNeqO4YV/iWJ5IDMJMsmVFiGnfA54pxBUxg7bxxIGa9fwA56xFJUXhfP+2hFUF6+08dwfVJJnsYE/1Rp8ooA+0xhqiuy0qC2HFKkao8JLzcFINB95n8UbIlB4DeayMg5iOI9gbGI90qmnKrcpTpDacbBssnArr07Oua7xn+k5WUyc7puJeJWZxxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnaA6/dsRQEFWn0WwkI4OTlD+5YnzGDH7eiwS0tXjyU=;
 b=SRMX8YAB87C7yryTHr7GrFfOQHJCFChxaJKFzY0OAkBBnHUDnMEfNEjDbXucGo5ybFuTB+JcUsDZ5Eho/OnI2isOpocEkXzRo5AW5+AK7iHu07X1KT7Z4oU/FyEdyMQwVwIr0BWRlJNz9+XrOmjUNDQL2IGjgD9LMBvzEqsNZr55rImYU4KYulfv+mRcS+53FQ7LuMlK72RozdSay3a+DAOAWDDk9dOvObRxZ5YfUOpIRDcuDYT6yXQ+JOlOa88iBeqHPTgGqSwmEVjCIEaozu2uGliYwarnhtfa8M16Dx2O1Wa1uumd8x6Ok+i+eFX1Uk2jqaTic7hAKfXMRrdyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 03:22:54 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:22:53 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NkyIeAgADAZHA=
Date: Thu, 6 Mar 2025 03:22:53 +0000
Message-ID: <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <Z8hetcRinFXXVAdy@hovoldconsulting.com>
In-Reply-To: <Z8hetcRinFXXVAdy@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: 23c1f385-cc12-439a-189c-08dd5c5e2ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PTdUZRRSv1o8Cl0kgWqyJ9HdMc89AINPOVwb50Sm3A7BUxA5BhGlmnkPn2D7?=
 =?us-ascii?Q?rDMFFsXJER3xQucoeeF7MWIIwMitRsX0zDYwOoIVl0JcHapIX7DhM0C1W96s?=
 =?us-ascii?Q?BJ6tDZ4eOsSo9O9E/KW1F1iWBGp815/ZcdF5bTn2r2Q1c/YwAa/FYOdAV+pC?=
 =?us-ascii?Q?rA6XgcZUQyOX0D2L/pffzlQr72Kw02O4MA96MnXknXGBobitXAo/aCKPpOTS?=
 =?us-ascii?Q?amIdaIwc9OzcWEvlzpPULOdZ76nO8ledUw5X467ERezFHGZRIPVaANT9lS35?=
 =?us-ascii?Q?d5RZ6AqR+J8GQObRSYe4wMkyL6ewB4g2gNN2ENzTUQx7Nzzkw9+GRUyTVW59?=
 =?us-ascii?Q?47XnMd7VYJ90c6gwPlylY/xkyuyQfBCpFHm7Ba4H5AgVL/Pf9xwNFkiCHHpZ?=
 =?us-ascii?Q?5jxDK1VvlIdc7FHIHn8t5ANWboGAmNBlAQ6FRzYmv5ZgDiIVBqscjvf/f5c5?=
 =?us-ascii?Q?hicf4Dxgub8bUIIVHhNPdfnH79mYR/JUQjBco/1hpy0400zxMVCYunGhvqZy?=
 =?us-ascii?Q?KcDw1tqgr0br05hvyINt0ZXJ6nz4jogmYni/h7VtkMu8FFf5AZBz/cA4ZeKA?=
 =?us-ascii?Q?yOBcOkjApAmLlhzNL7NMQFMgGVSCsn/CPzQty9MdEFuMtu8Z3xbcak+Yu+l4?=
 =?us-ascii?Q?/9cbpg5/elJzac/2AoRpLtC4ztpDvWsHRD3pr0YH3k9jm+CJ/xU+KgHjhcny?=
 =?us-ascii?Q?BY9WbRqvulw4vVtpABY7oJWOPdpSHwlCiTTSD6DLj2gl52HqJIeGNlDDHZ2E?=
 =?us-ascii?Q?x3F0H6WnpymcrF80ozkqAq7QNcLK5o9N0o+S3/DI696hGOmw1uhUBSlnaFN8?=
 =?us-ascii?Q?/MrWLjd8jNtnBTOTGtpz8VW7kDBcozkdZK8vYGVJwa5BCpGx3vJy4ku/Ialu?=
 =?us-ascii?Q?0tA/RBPWlddAFNUNAhB7JZLajnw9MwRsBtn2TbZOT3PMoRDn9+IGRxTVY830?=
 =?us-ascii?Q?xy30qEcTS7A26epGhB/kJCuSMTjaApE+tXATYKiSg31Ij85tMjAQhuNt+qIv?=
 =?us-ascii?Q?PF9YCZMPFCZuCI7Ybwz+ySiGsSt55/FbyZwi+w/HD4WCen5uwEypvNaNfd/f?=
 =?us-ascii?Q?Ivb/rCdmYM0k7Fr/VuReYftfphgvwLPMzqV8lGq8x53Yhdx0ENzvgNAygYPu?=
 =?us-ascii?Q?mc+o8OkDv5WzD0c3p3x12Yeciy9wOhhwpvNya9BIVKf/M8urq4Rz4K2pI8qv?=
 =?us-ascii?Q?mvJcsp0u22iypQYp8gV4Knv5pmy7H7F/szCn8t0aW/Oljb8GRx7XhoOW88sy?=
 =?us-ascii?Q?CaMb2ITKqnx2zPiOucy/q/+rL95oznSiHrb6kf5Jx6MD/xgO9X8BLXi4cFM7?=
 =?us-ascii?Q?YzcEsluzYjbhKKHSQjRS55adzFXryw0adiw1ZTaToORhZz0kzBoVgJkrXHLT?=
 =?us-ascii?Q?eurpPWaQ3QfkMJDI5umMsm/n6tWo7E4kGexD+Er9lA7kdaH/oJYBHCNls4ko?=
 =?us-ascii?Q?vJI7BjfCjQ9p5OVP1t8XNvZ3ZhA3RLXv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X+fTIHF7wBLZAc+Gh+a3v5iPaSh5Xp8cDCvHBLJchF1od1PI7u3huIR03mY6?=
 =?us-ascii?Q?JT8ab9iGw7zMLBK9PrW1Y3nOZ4Z5ekmlpSp0rCTSJ3zenuW6gRkRO+JiP/Ei?=
 =?us-ascii?Q?SMWMGa7O0BufXfmrkyvEHEmkaOx5/ZwOEGaEdtSMN9PR5oAFeQomVSSF78Pm?=
 =?us-ascii?Q?xcfdLQ235WhrH2Vnxj2UjfZ6XZzQzRXPbf3brLrKfxJioaKMEcYT3TyjQilu?=
 =?us-ascii?Q?Kxj61/CcHVXMEUv0pKf1GsmTBTMjbOjnnyYVsVVmYzsyyt1QcEITW8aGU8zJ?=
 =?us-ascii?Q?vHItCf30ULb0B/UFSAusql84Lrns1x9UGq0muvR7l3g8J3pD770j9o2yW5QG?=
 =?us-ascii?Q?jfH9poELbLLvIZB8AR7U9C1thoQg6zG6DlM8Nwe1aTwkhbLb6LYe7BtDekW6?=
 =?us-ascii?Q?OQnkxvwpLGNzIuBoaujBS8YrUEK+0zAU1GNX3QmRe9XYQ6pzfaiuUvWFW+py?=
 =?us-ascii?Q?Zdi5ZN7k8NrHPjMnLDsbKImg7BdSPJAOFLuMfkpIbQRYInnUv7uxlzl3GFFL?=
 =?us-ascii?Q?MXPyyDAkoSrjmFD+We8/s/VDlUTqV5fvOzL0wrC0klH+wPBVrjnI9wS77IdW?=
 =?us-ascii?Q?FUStwwCdS+Jl9cJgu4lDVRQQ9hpx2bPlt7ssB3ACX56WAsm9KvB1jB71op8N?=
 =?us-ascii?Q?PzxYV6jncHGvzi4sJD/xoXkFSVY4ZloDV2D2nUwNWbSREaJGqbNzcqqGwRG+?=
 =?us-ascii?Q?yCcUXHgdZYIxhXyPgXpQkjQSjprIK8gMHPTTRPUkJ05qe/n9Hjg4XGcpyUva?=
 =?us-ascii?Q?vm2m4ze5EA3g/4lE04RMgHgiL/iFZjB41tgct3rMQQ+/HsvOJwfv3n936YTu?=
 =?us-ascii?Q?SY2U4r6R8fWZ+eZ/Nf9c8IIwJz3yQ4+rQpaJ707wobvPoYZiJNt2DDBgb317?=
 =?us-ascii?Q?ydpfvfChCuiwXzURwlOSITT/uhrbrUbZ7iZ0DIAQAvrerINscSBpNJQ604Hn?=
 =?us-ascii?Q?DtEm0fitCbivlcIIYwEo5IErPdAPb1NiIO20Ui73G6giZf6c7g5cX3shvkFk?=
 =?us-ascii?Q?CX22mpQ5/3C3jYLhIAXJLPmvebrlRqc/BhEW2LI+8frFc5XVpP8fN5vGVVON?=
 =?us-ascii?Q?qp55/HmTVx0LT2vE/NkTx/Z3KsGZdcE2Qcnr3uNz3Uc9+VoTw9G8BlGT3HVl?=
 =?us-ascii?Q?syL9nsiILjtIrwueqjbYDm6JmldfrYynPHYikHVaBeg2gz31FRMZSLaP95Tc?=
 =?us-ascii?Q?Wv5DhL3DD2Ru3KhmcKxmxT/VD/UAW6RBifH+KK/GoOURNngbIesvt5svn3V7?=
 =?us-ascii?Q?h2qmbZNWNaClYdeYEd6xbkDMtWMEGmSosLrAzIQ+YrWJzRHgprNYAyAgB+Ng?=
 =?us-ascii?Q?JJAWEv+heofIRMXhYyEs/4uRl0YXVyvS8gVVR3zE3qQhIHFxGGx5JOM/0X9W?=
 =?us-ascii?Q?FDyGIwnNIroc7Ia56MSGHkZEbOALm892k7NkCajlFHctQ6g90+pgl0fw5Elf?=
 =?us-ascii?Q?EUnbT+p6VXaR3xR1dpB6BPsPBDlXaiMSW/xAVAYuASWq7oK7GWq2QxxaUx1G?=
 =?us-ascii?Q?VGlTfOZD4enMP2uLdt6fGCsbwzw3EKChk1UwoavxSs+a77nSc6ew/dAaXDfT?=
 =?us-ascii?Q?/+bC4aJ2oVBJe7eHJr2vb7WcSjq2fbMelxo5ie6l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c1f385-cc12-439a-189c-08dd5c5e2ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 03:22:53.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsYuA8EgSl8A36ES8iLoBk0TJ9JKIPXrDE89sFznFgjPEiJruiaiQ/9IzO1umbggOeq1di858midR7V9eOqAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

> I assume it's either an FT2243 or an FT4232 and not both?

Hi John, you are right, it is either FT2243 or FT4232. Will re-word that

> Can you say something more about these devices? I guess they are used for
> programming FPGAs? Are they embedded in other products?=20

There are 2 type of designs, USB Blaster 3 cable or On-Board USB Blaster 3.
They are mainly used to connect debug or configuration software. Supported =
host
software includes Quartus programmer, System Console, SignalTap,=20
Nios debugger.

> And can the
> same PID be used for more than one type of device that they are embedded
> in?
> Or are the PIDs tied to different types of "USB Blaster 3"s? If so this, =
should
> also be reflected in the naming of the defines.

The PID is associated with how the ports are connected, and
which FDTI Chip are used for example:

PID: 0x6020
Description: One JTAG Port
FTDI Chip FT2232
Port A: USB Blaster 3
Port B: Not used

PID: 0x6021
Description: Two JTAG Port
FTDI Chip FT2232
Port A: USB Blaster 3
Port B: USB Blaster 3

...

PID: 0x602E
Description: One JTAG Port + UART (Port B, C, D)
FTDI Chip FT2232
Port A: USB Blaster 3
Port B: UART
Port C: UART=20
Port D: UART

=20
> This is a generic Altera VID so should just be name ALTERA_VID.

Will update in the next version.

>=20
> > +#define ALTR_UB3_6022_PID		0x6022
> > +#define ALTR_UB3_6025_PID		0x6025
> > +#define ALTR_UB3_6026_PID		0x6026
> > +#define ALTR_UB3_6029_PID		0x6029
> > +#define ALTR_UB3_602A_PID		0x602A
> > +#define ALTR_UB3_602C_PID		0x602C
> > +#define ALTR_UB3_602D_PID		0x602D
> > +#define ALTR_UB3_602E_PID		0x602E
>=20
> Please use lower case hex notation consistently for the values here.


Will update in the next version.

>=20
> But depending on the answer to my questions above, either these defines
> should be renamed to reflect the Blaster type or product they are part of=
, or
> just be dropped.

The PID are not tied to specific product, however it is tied with how the P=
ort are connected
and how which FDTI chip are used. (FT2243 or FT4232).

>=20
> Johan

