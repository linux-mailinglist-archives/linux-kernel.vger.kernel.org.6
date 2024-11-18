Return-Path: <linux-kernel+bounces-412890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029AE9D10B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C28282CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDE19ADBA;
	Mon, 18 Nov 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PtSFA3dY"
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEB19AD90
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933629; cv=fail; b=Oe6XJndbi7sccpBHi5HzTVfOn1rOG8Ql00vKI8FCZE2iSMgAJJYkUSA4K+mmLULf1ZiNXw7CatFwIEyANvNRNa5jgPRH24BIbc3HzlMGqmT+sJSwlv/xxnh0li4q6Zo/Wi1QtO8GkSTKYaN4aFaS6Wl7qXdU37N4zkn7Q7OLrTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933629; c=relaxed/simple;
	bh=WZcFJsnta72/PzScWwg8LOniDAhrAiqjVDII9xGFBhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=stZ7apNB6nU/aKX3au7LRut75PsTDQ+9bvfxfgFvyqqe1WybakHc/+i87OoXvfK8svjyoXBAQFZkwM8mjhhgAiFsQ/DIv6bbzRH/vqT1VzOkRvYdOqJQR7yzpwA1W50dysqBjS61X62/oLltw0x2Ft0iS1QdbeqT9fVWqXnDQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PtSFA3dY; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4360; q=dns/txt; s=iport;
  t=1731933625; x=1733143225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WZcFJsnta72/PzScWwg8LOniDAhrAiqjVDII9xGFBhg=;
  b=PtSFA3dYwiEgoEWfHCA/nYL96YpPWslZ+uowfBA9wCa6ZTUiHbNpG3j6
   AA4E18nvriHGg2vmCKphXIPhVB2sNWEyYDoUuikt0qZkiGrFTnEp7gw1c
   2xKu4bJxraNr5QIXbEGiZkgeIXJG4mqMaFEiMtSgdwB2UusSyVMrrK1Eh
   o=;
X-CSE-ConnectionGUID: aMia5m7uRk+JKn4Oqnumtw==
X-CSE-MsgGUID: s+BuHytfSky6ob3a4hCzWg==
X-IPAS-Result: =?us-ascii?q?A0ABAAB9NDtnj4sQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGgUBAQEBCwGBcVKCGYUdg0wDhE5fhlGCIQOFeoxVHIssg?=
 =?us-ascii?q?X4PAQEBDQJEBAEBghOCdAIWijQCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFFAEBAQEBATkFDjuGCIZaAQEBAQIBEhERRQULAgEIGAICJ?=
 =?us-ascii?q?gICAg4hFRACBA4ngl+CQiMDAaQnAYFAAooreoEygQHgIBiBAi4BiEsBgWyDf?=
 =?us-ascii?q?YR3JxuBSUSBFYMqPoRDF4NEgmkEgkGFDyWIf4lrC5AVCUl7HANZIREBSwo1D?=
 =?us-ascii?q?DgrRiEsA4JHgjWBUoJGgRSDLoFeBTcKgwmBNDcCDQKCRXMfh2aBC4Nhg0WBG?=
 =?us-ascii?q?YFtghcdQAN4PTUUGwY9pAMGGDSBZ0UIE4EVklUJET2CZAFJj2GfTAqEGqIjq?=
 =?us-ascii?q?jsuh1uQbqNLhTICBAIEBQIPAQEGgWc6gVtwFTuCaFEZD1aNVBAJyX2BMwIHC?=
 =?us-ascii?q?wEBAwmQYgEB?=
IronPort-PHdr: A9a23:yAOrDxI/kXc2cfW6Z9mcuVQyDhhOgF28FhQe5pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:hNETUa512+XReKI3496eXQxRtDbHchMFZxGqfqrLsTDasY5as4F+v
 mJLCGDQPKnfZzehLdwkadu09k8H7ZTUm9FmSgVpqy01Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoaztNu/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eNKgZ87tyXnx09
 r86CzZRSQmFmueq3+fuIgVsrpxLwMjDNYcbvDRkiDreF/tjGcqFSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZOEwn1lQ/UPrSmM+kj3/+fjlHoXqepLE85C7YywkZPL3Fa4qOIILSFZwO9qqej
 nmF1XnZEw0UD9+Olz2PqXvwhsTdoiyuDer+E5Xjq6Y12wfMroAJMzUSVF2msby6h1S4VtZ3N
 UMZ4GwtoLI0+UjtScPyNyBUu1aNuhoaHt4VGOog5UTVkOzf4h2SAS4PSTsphMEaWNEeTBkr3
 wKMwM7TBn9Nk7vJbmub67KIsmbnUcQKFlMqaSgBRAoDxtDspoAvkx7CJuqP9obr1LUZ/hmun
 li3QDgCulkFsSIcO0yGEbH7b9CE+8Ghou0dv1m/soeZAuVRP9TNi2uAsgSz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWKH2A4xT8Nwp270qhZPmLy8BhkjeS+F1e5ZKFfUj
 LP741o5CGJ7ZSHzNPQmOepd9ex2lfW6SLwJqcw4nvIVP8AuL1XYlM2fTUWRxGvq2FM9ir0yP
 IzTcMCnSx4n5VdPklKLqxMm+eZznEgWnDqLLbiilkjP+eTFPha9F+xaWGZim8hlt8toVi2Jq
 I4Hb6NnCnx3DIXDX8Ug2dVMcQtTfSljXsGeRg4+XrfrHzeK0VoJUpf56bggYIdi2a9Sk4/1E
 ruVAye0FHKXaaX7FDi3
IronPort-HdrOrdr: A9a23:TSIF66OT2QKIKcBcT73255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHQYc2/heAV7QZniWhILOFvAi0WKC+UyuJ8SQzJ8m6U
 4NSdkbNDS0NykEsS+Y2nj5Lz9D+qj7zEnAv463pBkdL3AOV0gj1XYENu/xKDwOeOAyP+tDKH
 Pq3Ls+m9PPQwVxUi2TPAh3Y8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aOSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXcH4ot69MZkmynimgwdVeJHof
 t2NqWixsJq5Cb77WPADh7zJkpXfwSP0CAfeKUo/gxiuMMlGc1sRMokjQBo+FNqJlOn1Gjhe9
 MeUf309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: 9a23:aX4AjWGDfQI/NYK1qmJu0U8dR8V6b0fej1XzJROfEGB0TaGKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A2XK7pg6UmZlhTtEDnkx5eIohxoxzoI6zKFERn64?=
 =?us-ascii?q?FqpeDP3d5Zze2ngu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 12:40:18 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-02.cisco.com (Postfix) with ESMTPS id 8ABA918000151
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:40:19 +0000 (GMT)
X-CSE-ConnectionGUID: xshsjhvQT0WXYLxM/7o4EQ==
X-CSE-MsgGUID: Okynw5ooTW28My5mHD4XJg==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="44355380"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 12:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6SjHs/DPW1pXELuefMzMqEVZwpRLXPLEgjYP7W6vlqYnqLc3Rdi14INWVMfqt8aeS4b2tPxpmQwVLsBpNNZtxvNKWnaFJYV00/TZKRqY02z+U7F4DJMlgzO0cp1WGEoLUeJ/P5RvYmQgbsVsBgZ9wFsLLwolTpcLNb+RmEjr+M5Yls36+0ykOQj+5Si0hzg5RMCDuzt9/YX3qRjlf4pw4kRjpr+kW1ALraEev8cClMEj1k23TD6WoX6Tp2XYoP22j2oA0VEGO/Q4vO1Mb1LmBzr1gUuDiU+/LuGYT/s/TCA2Hor13FHPhjpCNXR0mNYLR83dZyiym9kJXWan2O7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZcFJsnta72/PzScWwg8LOniDAhrAiqjVDII9xGFBhg=;
 b=Rj8nVUDmw3NprC9qHO/W42J/1uBtLmHk1471OsBvzykse3y+lYEZsM02TVXwSCwwfyi9NjgINxnbC6JRdSy39Z/wto6OqStE6Ed8ZFJO02/x+Z/zMSBoPi4S/acjP7nebVsrEkLeQmADkY2isgJ0RUCodFJVyd/diNqtqEn93xJGPVGopXPicXyyI6kcUU2EUKbz+dG7YsVrVxCj/+XePg+AH9LQTdrqrOHH0HxVLZ+irEgKUY1gmCPeD0fN0SsT60z1g3OoUdGVSdwpVcaBtuSN3nLQ33pEpYW3j60vveHJDB0VMZ6Nv+5jNTlHhlJgu+sz7Ll+VY2qFvEQJmSd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by CY5PR11MB6281.namprd11.prod.outlook.com (2603:10b6:930:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 12:40:16 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 12:40:16 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
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
Date: Mon, 18 Nov 2024 12:40:16 +0000
Message-ID: <Zzs1rw1YcoEEeW7+@goliath>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
In-Reply-To: <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|CY5PR11MB6281:EE_
x-ms-office365-filtering-correlation-id: 13c97c17-4538-4ed4-a937-08dd07ce2782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVZ2WlRtaVRxUzlidzRaOWRtbENrczdhTzc4S3RMeVQzMEZKMkZST0NackZu?=
 =?utf-8?B?L1FQQ2orVWZtOFRnL0dSYm53RFdRcnA4Nit2OWVVTmM1VEhGSjRRNjNzTkJU?=
 =?utf-8?B?QjRiWjJ0Z3NsWHoxMWN0YWIwVVBWQThYNEk1OXg2VHRvU0ZWcTFNNjhXOHp1?=
 =?utf-8?B?SXFabVBQNnM1OEFrRGU2eWJTQjd0bVF3QVprSk5LblZNdWdsMkkrZm5rY0lD?=
 =?utf-8?B?S3UzeTFKOUNYRDRYZm5rRUFnRHM0bTBOMEdXWnpKQW02OUZyREZwNGk2ZXRY?=
 =?utf-8?B?R1h1cUtUSlFrUFBiRzJiKy9NZFBrUnBuamdpNngwZDFmcFF3bXY1THY5aUZG?=
 =?utf-8?B?QUV3OVR6cnRnWkdwbVhyb21XN3BBY3BsZmdQUG5rSTJqZjU3THAwQWR1a0Z6?=
 =?utf-8?B?NmdRWUFGZTliMVRPVWJqWXA0VmZNWVFTSGs3dHpRRGVHV2NmRUtIOHVTN2wv?=
 =?utf-8?B?RWRXOWhOOTBScjBFdnlrUnYwQTg3TU0zNVhDSVVaVG9ScHNoT0d1RVFxanpQ?=
 =?utf-8?B?MTJmcUg4MmVqRTdMRFRqNk43N0lPN2N1OXlSbXpCc3R4NGdwTDU3SW14SGdI?=
 =?utf-8?B?MGk3akpZYWVZbWhnTHhteXhvVUxkVFE2V04rSXA0V0FqcE8rZU1TMWJhUzV0?=
 =?utf-8?B?VWJjWE83UE5ILzZZVnZOWGgzL3ZLdkFOUmVTcUV0eWZRcUVtWTNrVG9ydEt1?=
 =?utf-8?B?SGMwaWw1bVJXdjdKS2psSnFnN0hRdEdRNDBucDhNZGZpK2dlaU90ZFJ4TkRO?=
 =?utf-8?B?UHZINnE1RllZci9jK0toUWp4bllRQTFvZjhya2ZjTFltVjh5Q29NdHhwN1g3?=
 =?utf-8?B?Y0lSOG9DTngvQ09NNHp6UmtLWUFLdmcvQUczcVNPWGxyV2cwQmpPQ2ZiTFg5?=
 =?utf-8?B?N015aW1LVFpncEVrMlBCVzdXVTB3aFQveFBMT2VHQVA3QXNXZ1NjUEVWQjNi?=
 =?utf-8?B?T0hwdDBJVW5BU1MxbG9QSFZNenNQVXlGbGgvM2JuZVU3QlcxOEx0QnNnOHJP?=
 =?utf-8?B?L3loamtoK01IR3cvanVMMU1aWFpkTm8yUFFLdHNrWFROUG1WR05rZll3TmN6?=
 =?utf-8?B?YU5xM0szTm9vNmo3YzAvWTVUczA3Yjc4ZXUxUkFkbVBNcVpBa0IzalhOUWlS?=
 =?utf-8?B?YlRkUEU2SXpkNnNxd1Y5MTBqbVlCNEhJMEZaeWRkRWJFOFhDZzIvNE9uaUEz?=
 =?utf-8?B?VVQrSGdLU1hTS3A1VklnQy9NdndBa3ZOL1BkdkQxamFHUi93MlhpZ1FsYWhi?=
 =?utf-8?B?bTJ3eE9vZk14RWR2dzl1WVFTUjNsK3RsMy9JMjdHZnJMTitkWE5rQzNrNFJm?=
 =?utf-8?B?cy9qS2p5T2JMRGRxUUNiWW9Ra01BYUk0L2ZyRnlsTzNVbjVQUGRGYnVrc0hl?=
 =?utf-8?B?S0tyWGdlKzlQczFsNDZ5TnVaLzdEY3UweTlSSEd1Skx4Yk5mSVN5OGFJaXBt?=
 =?utf-8?B?LzFBUldGNVAvMkJ3aGdNUlRNTFhnZXFRUi9udGZITERhdHF6S0FWc2JUVjg5?=
 =?utf-8?B?VDBRQ0N4STJOeHB6WnZrc2owbTZoV0M0TllqRXRoUWR4dWJrTGlBYnc2Z3hh?=
 =?utf-8?B?MHBnNTl2ajZPNW1iSzB5ODRyWm9lcHhrZVkzZmdFcGpWaXZEdkYxUVpRR0lO?=
 =?utf-8?B?Ulg5bmtGTkZNVXJHbkU1bytBNi9aWmtXSjgwWDVzUE9DcE5zN3NqUS96SFR5?=
 =?utf-8?B?L1FoazV0WkVTMWg3dVgxYWdJdTRBNktjN1pIQjd1RGo5TEJ4N1JoQWQ1dG1o?=
 =?utf-8?B?L0RRTUJkQWFCd0doVk1pR2l4TG1HYmt6cWJXcmxUWEphWnJKUGl1ZUg5OHFk?=
 =?utf-8?Q?P00uhXJNY6vz6UfqZlfdjf9MpkfSv3782lbFc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk54QlBMYU5MaXJGQ3ZMbTF2WDJUdnFCZTNNck1abzQ1T3QrNTVEcm5oZlM5?=
 =?utf-8?B?YXI3ZTZpZVk3Tm1zNzNxN3FVbEEvNzJVbk5JYW5oN1ZvZHJ2QURkMmF0Nm1F?=
 =?utf-8?B?SE1JckVwajNDL2xsa1FOSVBQN3Y3OFUvcndiNThacEZ3OGVNeU5sZm9oWG5O?=
 =?utf-8?B?NncvZG1vK3RmT0g5cUwxdmJ4L1pzdUNoU05Uc01TVC9haENHNzdHeFM0UFVR?=
 =?utf-8?B?eCtwaENLMldob3ovZVN5a0VyNzA1V2ptVEVPalIyWldlSWlmNTJ5NXRlZDdK?=
 =?utf-8?B?Wmh3c2xuZ28xVFcvU1hXcElkdWdDVnYxZTlKcHBPbFR6Mk9WSWtXU3J2eVNt?=
 =?utf-8?B?S3pzWXB2VDZ3VVFmNWp6QXkySU5iUDFuTVloaEhhS0k3OVpIelNGeGlyOXFh?=
 =?utf-8?B?Qnd2SysrTVRLRklRYlpmVlIvN3JrRitGZ0lhN00wVHJya2x6YlM1dnF3VTdo?=
 =?utf-8?B?RUxwVEtpY3R6bmp3SUN2UDY1RGNreVRBd3BJMElWajhhZGVXcEo5MlExRlds?=
 =?utf-8?B?WTdJYUg1cmxYUzYyMHR5aHIzOFB2TUhxejVIanJMUjBxR01vcXMreWU3cmhJ?=
 =?utf-8?B?dk9MWlJRK3IxNlRlY3dSY1NaYTVjY0JORmxXRHRFWE9EeTE1eVAxR085am4x?=
 =?utf-8?B?ckRsNXlnNXovVkZ1TkVoejdkODUyWXJoMWQvanZLTkZpay9ZSEcrL3NsWHVR?=
 =?utf-8?B?YnQ2SnBjaDBDV3lrTVNNL2ZoNDd5L2l4VlRaTTh4RWMvZzZldnhlZ1YwN29Z?=
 =?utf-8?B?aVV1MWIxSy95MXN6ZkQ0aGYxcVZTT281bmNUaWQwaGtuQm9rUGlkbjB6eXdD?=
 =?utf-8?B?ZG9OTHptLzlFSzgxUUZ4Q1MzN3NWdVZVL1VuQkdFQStSYTV6Ung1SUM3S2Zr?=
 =?utf-8?B?djlkUlJ1TVl2T1FTTHZ4Tmx0dDBlTDN3NFMxTXE5a1hxb0Fud0ZCUkdFekIx?=
 =?utf-8?B?M29WdTFET2lBekwvbEp0V0FDVE1zbEh5UEphRjlHbGJOZmM5OTVXQTB2eWpP?=
 =?utf-8?B?OXhYdFZqc3BpSXZKZk1CWFJLNXNncDE1ZVdlU1FDcmxmNEc0Z0ZWZHIyZUVE?=
 =?utf-8?B?cFFvU0FKc0pXbXpETzB1Y00yMkd0WjFwVldjVTY0OGg3Qy8wTi8rKzBCVjlv?=
 =?utf-8?B?bHJVQkttYzRNNmJ6ck5aUHhORFdQTGtYT0tiYzNSeWRWRTZGZ1ZZalA0b3Ux?=
 =?utf-8?B?MmJXeWNIMGFSVFM2SjhIaVBtaG1admxCaFl1cnovUFI1OVo3Q0hrYW9JaFI3?=
 =?utf-8?B?L2h0c0pKcFZBRjNMSEpyM1pISFdyMXdTWk16bWNwdytuU1F0NlB4N1k4QjNC?=
 =?utf-8?B?WmZWVG9hczVETHlFN1VQS3JNU1RZNlhnckFYTGhmUnRjWG9MTXFibjJ6LzNB?=
 =?utf-8?B?ZDhrUHZlMWpKWEdRYVhmUzdNbE5HdGRFWEZpWGtpZzVsdjQ3TGk1S3JnNlg3?=
 =?utf-8?B?NHlzWlY3ZmhLdU9LSmRFamhFcnAvaUhMSkM3c1hzQXZMSUp5RkwzcEIxT3dD?=
 =?utf-8?B?VnVTcjFGbm9VKzBmaFpYb2xYQ0o1NU1SR3VBSEJyRE5qK0FUaDRXSllIVS9p?=
 =?utf-8?B?Z1RUQ2FCYTdLUjNxMk5ML1NHR0RNQ2NWYm1HbWpPTXQ4Tkl6T1dmRTkzVHJa?=
 =?utf-8?B?endnNlN0M1RrSmdoeDFDVjVHbzFNV1k2a2JWUzhSQVUzcDkxQUFPZ0ZCVGJt?=
 =?utf-8?B?ZHRIcWlkcW9EVU1oSzBtWVFsRFFsQlV0eG5XZUZ3YjFhL1R3QUFZVnptOWFu?=
 =?utf-8?B?UlJwaXpFRStlV3ZUNHpieFNlbmRrN29zRHkvK0xKQlF2eFBJUk9oNEsvLzVH?=
 =?utf-8?B?R1RGS3g3c0JCVkJOenI0UHRObWJJTGh6N2tGVmlMZXpzUUVWMnhlYTlabzJp?=
 =?utf-8?B?amV3NVFST1dLN09DZmVxUThQNmlpemc4YmhNTGFRUjBWYm16WW1DaE1FMS9W?=
 =?utf-8?B?QjNObVN2RWVZbHIwZHJxMkVWNmRjZFZHejJXNWRuWmJRRUFsL2xDY2o1Ymxj?=
 =?utf-8?B?a1d4dFBwM1I4Q011NHA0eTFVcndZdDUwQWl1QzhHb29TczQwUDBFblpYMGNt?=
 =?utf-8?B?SW94K3lVYXZOMisxTFZHN0xWajZ2dURaank1SS8yK0RGbGlyMmxDQXdTbUtl?=
 =?utf-8?Q?dd5wyUOaphFiE5oWtIa7QV2Bv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D09A841B04AF00458D6932DE2570B257@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c97c17-4538-4ed4-a937-08dd07ce2782
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 12:40:16.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJn84ZSSJ8sTuZZjrXLiP0JSk2hydwWBS86IBfQPY94k/Ds9kwBxovKCkpC4cOU7yNx/xY9PdLubkFg5ACU9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6281
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-02.cisco.com

T24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMTE6MzA6NTlBTSArMDAwMCwgU2hpbmljaGlybyBLYXdh
c2FraSB3cm90ZToNCj4gDQo+IFRoYW5rIHlvdS4gSGVyZSBJIHF1b3RlIHRoZSByZWxldmFudCBw
YXJ0IG9mIHRoZSBkZWJ1ZyBsb2cuDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAu
Li4NCj4gcGNpIDAwMDA6MDA6MWYuMDogWzgwODY6MTlkY10gdHlwZSAwMCBjbGFzcyAweDA2MDEw
MCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50DQo+IHBjaSAwMDAwOjAwOjFmLjE6IFs4MDg2OjE5
ZGRdIHR5cGUgMDAgY2xhc3MgMHgwNTgwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludCAuLi4g
W0FdDQo+IHBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0gMHhmZDAwMDAwMC0weGZkZmZmZmZm
IDY0Yml0XQ0KPiBwY2kgMDAwMDowMDoxZi4yOiBbODA4NjoxOWRlXSB0eXBlIDAwIGNsYXNzIDB4
MDU4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQNCj4gcGNpIDAwMDA6MDA6MWYuMjogQkFS
IDAgW21lbSAweDg4YzAwMDAwLTB4ODhjMDNmZmZdDQo+IC4uLg0KPiBQQ0k6IFVzaW5nIEFDUEkg
Zm9yIElSUSByb3V0aW5nDQo+IHBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0gMHhmZDAwMDAw
MC0weGZkZmZmZmZmIDY0Yml0XTogY2FuJ3QgY2xhaW07IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdp
bmRvdyAuLi4gW0JdDQo+IGhwZXQwOiBhdCBNTUlPIDB4ZmVkMDAwMDAsIElSUXMgMiwgOCwgMCwg
MCwgMCwgMCwgMCwgMA0KPiAuLi4NCj4gTkVUOiBSZWdpc3RlcmVkIFBGX1hEUCBwcm90b2NvbCBm
YW1pbHkNCj4gcGNpIDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweDI4MDAwMDAwMC0weDI4MGZm
ZmZmZiA2NGJpdF06IGFzc2lnbmVkIC4uLiBbQ10NCj4gcGNpIDAwMDA6MDA6MDkuMDogUENJIGJy
aWRnZSB0byBbYnVzIDAxLTA2XQ0KPiAuLi4NCj4gUENJOiBDTFMgNjQgYnl0ZXMsIGRlZmF1bHQg
NjQNCj4gcDJzYl9jYWNoZV9yZXNvdXJjZXMNCj4gcDJzYl9jYWNoZV9yZXNvdXJjZXM6IFAyU0JD
X0hJREU9MCAgLi4uIFtEXQ0KPiBwMnNiX3NjYW5fYW5kX2NhY2hlX2RldmZuOiBkZXZmbj0xZi4x
DQo+IHAyc2Jfc2Nhbl9hbmRfY2FjaGVfZGV2Zm46IDI4MDAwMDAwMC0yODBmZmZmZmY6IDE0MDIw
NCAuLi4gW0VdDQo+IFBDSS1ETUE6IFVzaW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9y
IElPIChTV0lPVExCKQ0KPiAuLi4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEFs
c28sIGhlcmUgSSBsaXN0IG15IG9ic2VydmF0aW9ucy4NCj4gDQo+IFtBXSBUaGUgUDJTQiBkZXZp
Y2Ugd2FzIGRldGVjdGVkIHdpdGggREVWRk4gMWYuMSwgYW5kIGRldmljZSBpZCA4MDg2OjE5ZGQN
Cj4gW0JdIEZhaWxlZCB0byBjbGFpbSBpdHMgcmVzb3VyY2UNCj4gW0NdIEFzc2lnbmVkIG5ldyBy
ZXNvdXJjZQ0KPiBbRF0gcDJzYl9jYWNoZV9yZXNvdXJjZSgpIHdhcyBjYWxsZWQgYWZ0ZXIgdGhl
IG5ldyByZXNvdXJjZSBhc3NpZ25tZW50Lg0KPiAgICAgUDJTQkNfSElERSBiaXQgaXMgbm90IHNl
dC4NCj4gW0VdIFRoZSBuZXcgcmVzb3VyY2Ugd2FzIGNhY2hlZC4gSU9SRVNPVVJDRSBmbGFnczog
TUVNXzY0LFNJWkVfQUxJR04sTUVNLg0KPiANCj4gU28gaXQgd2FzIGNvbmZpcm1lZCB0aGF0IHRo
ZSBwMnNiX2NhY2hlX3Jlc291cmNlKCkgd2FzIGNhbGxlZCBhZnRlciB0aGUgbmV3DQo+IHJlc291
cmNlIGFzc2lnbm1lbnQsIGJ1dCBIYW5zIGFuZCBBbmR5IGRpc2N1c3MgdGhhdCB0aGlzIG9yZGVy
IGlzIG5vdCB0aGUNCj4gcHJvYmxlbSBjYXVzZSwgcHJvYmFibHkuDQo+IA0KPiBPbmUgdGhpbmcg
SSBub3RpY2VkIGlzIHRoYXQgcDJzYl9iYXIoKSBjYWxsIGlzIG5vdCByZWNvcmRlZCBpbiB0aGUg
bG9nLiBNeQ0KPiB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgYWxsIGRldmljZSBkcml2ZXJzIHdoaWNo
IHVzZSBQMlNCIHJlc291cmNlIHNob3VsZWQgY2FsbA0KPiBwMnNiX2JhcigpLiBEYW5pZWwsIHlv
dSBub3RlZCB0aGF0ICJhIGN1c3RvbSBncGlvIGRldmljZSIgZGlzYXBwZWFyZWQuIERvZXMgaXRz
DQo+IGRldmljZSBkcml2ZXIgY2FsbCBwMnNiX2JhcigpPw0KDQpObyBjYWxscyB0byBwMnNiX2Jh
cigpLiBJdCBtYXliZSBhbiBJbnRlbCBHUElPIGRldmljZSBhY3R1YWxseS4gMHg4MDg2IGlzIElu
dGVsJ3MgdmVuZG9yIGNvZGUuDQpJIHN1c3BlY3QgaXQncyBzb21ldGhpbmcgc3RhbmRhcmQgb24g
RGVudmVydG9uLg0KDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBEYW5pZWwgbm90ZWQgdGhhdCwNCj4g
DQo+ICAgIlRoZSB2ZW5kb3IgYW5kIGRldmljZSBkZXRhaWxzIGZvciB0aGUgcGNpIGRldmljZSBh
cmUgODA4NjoxOWRkLiINCj4gDQo+IEkgdGhpbmsgODA4NjoxOWRkIGlzIHRoZSBQMlNCIGRldmlj
ZSBpdHNlbGYuIFdoZW4gcDJzYl9jYWNoZV9yZXNvdXJjZSgpIGlzDQo+IGNhbGxlZCwgcGNpX3N0
b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlKCkgaXMgY2FsbGVkIGZvciBpdCwgc28gSSBndWVzcyBp
dCBpcw0KPiBleHBlY3RlZCB0aGUgZGV2aWNlIDgwODY6MTlkZCBkaXNhcHBlYXJzLiBCZWZvcmUg
YXBwbHlpbmcgdGhlIGNvbW1pdA0KPiA1OTEzMzIwZWIwYjMsIHRoaXMgcGNpX3N0b3BfYW5kX3Jl
bW92ZV9idXNfZGV2aWNlKCkgY2FsbCBoYXBwZW5lZCB3aGVuDQo+IHAyc2JfYmFyKCkgd2FzIGNh
bGxlZC4gU28sIG15IG1lcmUgZ3Vlc3MgaXMgdGhhdCBEYW5pZWwncyBzeXN0ZW0ncyBkcml2ZXJz
IGRvDQo+IG5vdCBjYWxsIHAyc2JfYmFyKCkgZHVyaW5nIHRoZSBib290IHByb2Nlc3MsIHRoZW4g
dGhlIDgwODY6MTlkZCBQMlNCIGRldmljZSB3YXMNCj4gc3RpbGwgdmlzaWJsZSBhZnRlciBib290
Lg0KDQpUaGUgbWV0aG9kIEkgdXNlZCBmb3IgdGhlIGJpc2VjdCB3YXMgdG8gY2hlY2sgbHNwY2kg
Zm9yIDE5ZGQuIEkgZmluZCBpdCBvZGQgdGhhdA0KdGhlIGRldmljZSB3aGljaCBkb2VzIGV4aXN0
IHdhcyBub3QgaW4gbHNwY2kuIEFsc28gcGNpX2dldF9kZXZpY2UoKSBmYWlscyBmb3INCnRoaXMg
ZGV2aWNlIGFuZCBncGlvIG9wZXJhdGlvbnMgY2FuJ3QgaGFwcGVuLg0KDQpEYW5pZWw=

