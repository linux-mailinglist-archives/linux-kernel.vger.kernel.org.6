Return-Path: <linux-kernel+bounces-294056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC86958854
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EED0282BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308E19069B;
	Tue, 20 Aug 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hmzjpwBg";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="REzPVFeN"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F018FDD0;
	Tue, 20 Aug 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162093; cv=fail; b=WKGGcyUlP9/KJxjW2OoRd+GANvgTAJddH1bVocjmW74AD4pg3eTN/qOMIK78NMf/LG6RvEoXcKfjhcB7mZV1Wq/MBoBs4aWqRgI4x4d4hpuO1Bxzd0mPViQSLOj61X2mMPx3zKc8e2U08XllwYKEjFKYtVkcjnhy45p1LLDzAlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162093; c=relaxed/simple;
	bh=Rwt349UZx6z2gOt4JgSAYkbwYwz5H5yNWews+gnWkkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VK7ZEo+SongtGIG7PcJaPJraXnk25tvP7LvBRX5dKSGYd0NjXvAAcA9KiAPfzcliyoXn3FwURGgvsJvkdm2cQjTkykV8oQuXWzxG0iw0TXJbFe+4qUv6lB+09W1a2Xc7i4AmQgtfiPpXxBQxO9AKBJcpxY3SFAP8yibfd1M98qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hmzjpwBg; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=REzPVFeN; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KD8g1N007546;
	Tue, 20 Aug 2024 06:54:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Rwt349UZx6z2gOt4JgSAYkbwYwz5H5yNWews+gnWk
	kg=; b=hmzjpwBgx6vHFadxOGsrvwOvd3/TODpGlR10E7imsjeE30+q8uyrFN7ZK
	W+lUOFV8nTgBziGL6G/4Aht6ER2CtmYLEEpsk1Hi60kaXnG9VJUnRl+Eg/73i+ea
	1GeW5dZTGPejRdr3jIK9/2BnODzyF5zO4f6HwYImUoIT4OAiXyZW5mxV5uYLnt2G
	IP4AGDDL5whCWlqi9TnMH+4R3WqfZr9OvRFcCvDFYU5kUp2cbgI2Fe+Yg7hsrBHm
	Mnx/HNMgXRqVU0TFgHOb6qirXDbFrYagfjAz0eAZJV7ibyHygom7qH+ToBSVEWuA
	BwSsZwkXKtIuZ4a5pInsKT9VXVlKw==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 414g9d1by2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfhryY5zs4LfD1LiUT9TYxGtq3EUjQlwxmHic3vItP4ALXKic4elzkK+xFF5FB0h9GrdqnjST6KtjXitBNmJ9GTaYUk4NaTSF3BXxGF8uJmn1vxOb9L84kupChzCAg6Da6oAL55aMCeHwvhpbBCkexD+jrNqJqFHt/93kH4GNJQ0xWWGJHInPKuUzb14h0VrFT61sYOlnoei+/nnjhuvQuOAe1WV9kvEllTrgSQhLaihoCAi44goEFesGzTNh9LQUB7Od0D1+ksJRHWNJbU+7Ga6RxjH5UDLX7DAnG9pkmlFNuQ/V8qyN2xEXe8EuXmzAJIJnq3CbGQfhMzT4HBKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwt349UZx6z2gOt4JgSAYkbwYwz5H5yNWews+gnWkkg=;
 b=Ak9p3ZLHL3JzoSmluLsJjYLBLlUVpTyPfxvLbvKhkIp0GMBHa10qX7GNCwQIu24xnIph1xkt2AT4iEu5wB0kt61aR4gmG3VY2J9E/FB9nygo5+s6AIJ7tMjNBKi0K6kHa5viMI1IJB3uRFU5l3BghBSpcRj/e5n5Wr23AeB6YvD81VcpA24AGajHeA0Hf5ak+0oct8Y1pTjNi+Q0aKFYq1c13Nu9/Mzjr3/YIFEFYo7PMXAR8G71N4avNV5rWu7i8oUEH/I9jqrleerj2MA5CH1rSYmhcnU7Vpjh4595gcEriLOGqXGS/pFOATyPvUCjX23QPh5MWAtQ5QqfEmgwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwt349UZx6z2gOt4JgSAYkbwYwz5H5yNWews+gnWkkg=;
 b=REzPVFeNx1ek1c1MHnDlEiB7NeR/U+qv1tSSMPXSHE+AkJzZo9XkRDwPjwaUpfdijGue6gYZ7jwnOBsGHr/+U0JijYWWrJ7T9FO6xYc/4UzRGvhcw/c0PF2lKQR4aONbCoLnsXnkEeX1g26ZGnbJgCkMg+T+wwI64zrgh0wtPk3Fi8T4smVNnEggFlM2p04PEoUMb4mJ4+9SMujB5ZB8GXMcEmeWvwo36n06nq9U2ggFcU4bx9EcFhvzKNya8GapqHsvLaCt6HK1JvW/s+lA4Voq9BnnIUzEFdToH79Ox7UsIbHLLoHeoY1LCoG5C1BkIgvh00FEu2tSk8wr+/930Q==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SN7PR02MB9301.namprd02.prod.outlook.com
 (2603:10b6:806:344::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:54:41 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:54:41 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ian Rogers <irogers@google.com>
CC: "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
Subject: Re: Perf test failures for 10.2 PMU event map aliases
Thread-Topic: Perf test failures for 10.2 PMU event map aliases
Thread-Index: AQHa8qWCbkPu8VGkCEG8+A4f+5JvBbIvogKAgACJqYA=
Date: Tue, 20 Aug 2024 13:54:41 +0000
Message-ID: <65A24EAA-A348-4E77-AF5B-933B41C9CAB6@nutanix.com>
References: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
 <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com>
In-Reply-To:
 <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SN7PR02MB9301:EE_
x-ms-office365-filtering-correlation-id: d73ddabe-5df0-40d6-8686-08dcc11fa3f9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXVVR3NFcmJ6c1N4NEJReXBDWkxVaXV2OWNUaHRwT2ZEK2FwcXNZWHRhaTBy?=
 =?utf-8?B?QkdPZlhNSkw3c29mWUdKbElmTURvOHRPV3Jld05EVVFlZVByS280akdhRXJv?=
 =?utf-8?B?TDMrTGxlbTZ5NG1vRFRXL1RhbnRtS2JkSTZBOG5QYnhTUEZWOTV5QXI0L0dz?=
 =?utf-8?B?bVlqdm43ZVdPVHZmd2dhcGJzdzN5L0NKaHlhSjMzVEpFL3VnMk5LVWg1Z2tM?=
 =?utf-8?B?S1Z1ZlYrZlRkdkk5cDhmKytJUC9QS3BCd1pYNmY5TnZZR1BzUDU2Rzh2M083?=
 =?utf-8?B?UjhHTW5mdXlzZmJyU3FjRVE2MSszMUZEaDlKcUZKVGFxeFRHbFA2QzhEZXdQ?=
 =?utf-8?B?VHhmdDdXQnlzWHR3MnkrWVdTK3ZmOHZqMW9Id2I0bFRFa3NlWThjVFlKdkNY?=
 =?utf-8?B?eEpBdmtQc2lFbmRSbmlEWWdla0xSNlo1bkRTbGNpSFI3N3dQS3hIdzIyK0Rj?=
 =?utf-8?B?bXNCV2c4RVU2c0ZmVlBPOG9zd1l2aHJYMGx5bTNlNHhOV05CR2lxcnlZQ3ZB?=
 =?utf-8?B?enRHZzFnYUlzMkhlZXgzRU01Mk81bVNMemFLKzdpTEx6RzMyOEwzbFZxQlRj?=
 =?utf-8?B?dzFYdGNQaXArWE83NFdvZExIbEliREZJS3piVXhEaGNqQkFSRmUvdEJhdzVX?=
 =?utf-8?B?OVdqejdVK0VlWmhhZXVDSjVtdlRrdGNBQVNzQ0NYdWZodXZDTDFFYmJmeS9h?=
 =?utf-8?B?UnBRNmMvb1FRTGJTWldmYjE4Qi8zNHB2d25BM1JJa25Qck51NVpwOUx3bWJG?=
 =?utf-8?B?eHQvMkFOU3lVV3N6Rm54U2RRS2tmTE9HTmR0eWhGOTRDRm5rYmdjMW9LelR5?=
 =?utf-8?B?WWUyNW5DSmNyRFNCa2psdkhDWXVYSUlMdjlHOUNWV0lSRndyY0lGOTFINEpi?=
 =?utf-8?B?NUZlZ1d0eUk5bHFhcXBlZDUrRk1CYUxReWxsNEVFVzZNaHZyQzhvN01EdGZ4?=
 =?utf-8?B?ZkRkUFRRRXY1SU1neWVMYTBFSjlHcUdpUWpWWW14Yk5STFBhc0c5djRWZEg2?=
 =?utf-8?B?YmF2blBoNTFyT2k5N3lEV0IyVFJTYm10QnZoejdlMEN3bWFDU3N2VTdiTHdw?=
 =?utf-8?B?L05nby83bDFTWmVEODlRQTRORy9UNnRJMGZwNXc1STZCRm9vaXZ1aHJoVDRn?=
 =?utf-8?B?NEs1Mi8xbGJtUkg2QW5FbEc4d2trYWJTV0JnQ0d2NHo3c3RhL0t6aG1XNGhj?=
 =?utf-8?B?N1RXZmRBekVmaXVOdFNqbDMxYUhIVUZOZ2ljak0xWG9YZWxLK1lCMjNOSUhF?=
 =?utf-8?B?UUxycW1MQ0tjR1QxM3lBSHdXc284bThCa0paNnRZUVZtcjN2RFZPRFpiNjQv?=
 =?utf-8?B?eXVxYkZ3K0h0Q1lSaGFXQmhyKzFaUXplVURUbml3MEtHOS9TcmtZc3BuTitF?=
 =?utf-8?B?azAzMW1icHQ1eHQ0ODhaeTllNjVXb2ZRbmM3aUpCUFV0cVpNdkdqRTBBVVJK?=
 =?utf-8?B?TkpoYXpDeEdqY24rdEMzQ2JaN1R1MDZ4SS9NTkpvc1V2OEh3QlF4Vy9kTjBG?=
 =?utf-8?B?NmVSWG1vekhxUEE4U05EcndLZlhKSkhMSTVhUE1kRU9tMFZXT3lBZjMxYnhX?=
 =?utf-8?B?QnZ4WHBlYTdrS3ZlTDdKMWN4c1JEQ1pkczIyQjR5clpPcTd3V2NaTFV3b3V0?=
 =?utf-8?B?NDZwdHVvd3hjZnl1ZXhROFR1eVd6ZFVCYncvSWVwN0NyWG9KeWxiQ2g3OG5m?=
 =?utf-8?B?TEhCam5OWjdCOFJ6NGk2YTl3K290Qm95d1RRTjFONEdzQ0NwUGhPbUw2Vlp2?=
 =?utf-8?B?ZFVsZ21KV29uTExtQlRzL1hsRmdHdUhiYTdyUjh5czl4djgwUGNmSHNJRTIr?=
 =?utf-8?B?aGFlM2xTbU1RNFdkMkNLY3ZrREpDVHk1LzZRSWVkOE5qdkxlYWlOUEJVeTlG?=
 =?utf-8?B?MitxOTIvOHR1amlBUUZnSE9QQnVJelVpUVJxc3Fud1pGbVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1dyR1hUdlh5UnI1T1h1cGtwV055MWpJT051NTI5UitNUEJhWDFZL0lmdGgz?=
 =?utf-8?B?dHMvZHFuQXlaYWtkVTJLNEN5K2ZyUUJ5VStXTmpsNUxHbFprSEZPdVc1U0dm?=
 =?utf-8?B?TGdDTzlIaWZrMTZ1bWNRdWZuS0MyYktORkswTENJVGN1Q3NIanVBU2dNUlNp?=
 =?utf-8?B?S2N2bjJLMXpSc3RySkNoSGxpTjlQTDBQTkVIdEk1VHYzaG96KzlCelJTM2dz?=
 =?utf-8?B?UGI0SkxWbnRVanh6Y3YveU5EN2pJSE9qNE1FOUtOTVhJTG5RQmUrZ2xjT0Fp?=
 =?utf-8?B?LzR4emFINGxBVHBERjRkaW9oTlY0ZUFKNkJwYkU4TTlScjhhUGF3WXl4NmRp?=
 =?utf-8?B?aFk2VEczZi85bXdvWTBiQ2xZckxnUzArZjJFR0NKSTJnQXFKc0l6MEJBbFpI?=
 =?utf-8?B?bHNjd0hQR1dxQ0pBTElDTkc0bVR0bC81bG9pcUx1bThUVGlOR1lXTk9XMW93?=
 =?utf-8?B?bElPdnJXc08xVW9tR2h5eUxjSXZiVTAxUWlVODFFa1pUMUZDa0wrcXNZaUto?=
 =?utf-8?B?dm4vN2xkNXZMWU5yZFJZdUxRbFNvdHpqN3VNSGxwb1ZpTEg1VHhHZE9YZHBq?=
 =?utf-8?B?N0xQL0J6UzRLclYvMWh0eUl5WWk5SDBQa01jc0VwTjQwK3l5eFZjQWpsZnY5?=
 =?utf-8?B?aUg3NUljZ1B2anJMRWh3cGFIZ3pPTVV3L015Si9GZkUwUTNwREZHZysybTdI?=
 =?utf-8?B?NkxIUVVja0pMTXhvUkZhWFRIRnJkUGxGUHMrY0pibVRtWURSczF3T1RVU28x?=
 =?utf-8?B?VVNYTUdBWDk0aVpyaDlSMWhvckFvd1pwVTBXcFdpazR5VURNbEtQY0REQmk2?=
 =?utf-8?B?Z2IwN0NUQzdBQ3J4a0tUanJ4amNRbzJxS1YwdW1uRyszQkJpRzdnbERjYUlh?=
 =?utf-8?B?QjFUY0RPU0lWbFhjMUxDM3g4Zys0MC9saEdMS1YvTWNMZ0RsclVoNmhMblRP?=
 =?utf-8?B?WC9tR3lKR01RSlFobFdrcVM1TzdqekVVUTJYZlQ3eCtmYWJZUWJWTlpKcWJ5?=
 =?utf-8?B?WjhUU0s3WDZxRjZFZk5XQm1nWWJSc1dBdGZDak51SlVhcjdraGcvbTJUdGRo?=
 =?utf-8?B?THl2SXk1U2tlWVdkUDlaN2xPUUNTZWlPNmRMR296Z3kwaEV0YXFmTCtuQ0Zq?=
 =?utf-8?B?Q3d0SEhrRG15YTA4ZkhrL09oY3BTUlRsM3dHOXRUQkVxcWlWa21KSVB0RjRo?=
 =?utf-8?B?SFpYU1dVU3ROK0lKOEt0amwxc1FsUWZUa1luaGlad2R2VXVGNW13RGRRNkcy?=
 =?utf-8?B?dHZ2aTRwck5QTXJoN0JhaE01TndVdm5RandISDhaL0ZxVGtXUTdSNlVyY3p2?=
 =?utf-8?B?R0QrVFYrZ1FWUzh6TEs5aVlxR2JoMGNhMktiWXoxWFh5T3dGSTZJSXF4TG5H?=
 =?utf-8?B?cnIyNkt0UmZTQlB5eGdhelVSM2t1N2trM2FPbEVMUTJyY01vQm5vRC9iUWp1?=
 =?utf-8?B?U1M3b0t5OTg2QVM5c0FHWXhJYlg5YXRQQ25jcmF2ZjhMd0t1QVdXdkh4WlZL?=
 =?utf-8?B?eUdTcFRUZC9GR2loODBzSnBaVXZMcml2Z28vaThaRDIrZ1hYaVhPMTExa1Iz?=
 =?utf-8?B?dTBoWk10djZCWEpCQ3lwdjJCWWhiQ1cvUDhJdFVDT0dtOUYvRlgrVU5USyta?=
 =?utf-8?B?Y3VkNHh3aXE2RGJQM1cxbFFhcE9sQTBFNWxsVmc4WUxDZERidXpPTEQ2cDNp?=
 =?utf-8?B?aFVTNTRhaktMa1MyN0hIdmNtay84R09hcVpEU0JJM2dlMkY2MUQwMXBtK1Jh?=
 =?utf-8?B?dE55eXowUlRJVlg0azNEL1BzVS9LandMTVpHMVl0QTVwUXdTdHhicDZEVS82?=
 =?utf-8?B?L2dUUjNtTDY0eDdaUTdDeXc5Z1Q3QW1aQ05oOTlRVk5yN0RYZzMrZ3NQVGVt?=
 =?utf-8?B?WXNrdFVMcy9SZ1B3ZlYzeWZpbS9iZWZTT3Q0Ri9HUlJMaVMweVd2WFNhTVYr?=
 =?utf-8?B?NkIwMVQ0WStnV3JOWHhWS0wwVDNzM0pOWHRUeTViaUFwOWV6Y05tWU5MaE9T?=
 =?utf-8?B?SFg5VUdmWDhlY3pWTTV3UGIwek55bGhGeVpZQm9WYmFTNE43NDdxMHRnbFQ5?=
 =?utf-8?B?T0tGb2VCM2Z3emJaM0xmYWxqWWVoTnkzWGZjZEVIdk56c2ROZkZ0bE96M3hH?=
 =?utf-8?B?cVRqMExpVTlmbm13a0pESzh4K1VFQWNVT2VlQVd1WkgvdThkSVEyYTZYRHhn?=
 =?utf-8?B?L21HRGluUHFmSCt3Z1N3TVRqazRUdDB2bXNCTThra3QxU3g5ak9GcTdpMlhl?=
 =?utf-8?B?aDZnT1YrcG9OTkd2T2NDSVRQbVJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0B9822029B3E439F7A47F95E746879@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ddabe-5df0-40d6-8686-08dcc11fa3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 13:54:41.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLT6qIBu6E+3YRgospczGaot7Ywq0cg4aC2ota/0v03fJaCWBbjyojIGvjO2ZarIp9hZ764PCcMSBkabvZmv6Bx9hQhvyeQ+KSRWxryoaCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9301
X-Proofpoint-GUID: -Ou8wIGuU97iL2p5YdAOjB5YCfJ5iI1q
X-Authority-Analysis: v=2.4 cv=UM2PHzfy c=1 sm=1 tr=0 ts=66c4a025 cx=c_pps a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=1XWaLZrsAAAA:8 a=64Cc0HZtAAAA:8
 a=VwQbUJbxAAAA:8 a=iXhRRcRARM8ew6H_4wwA:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22 a=AjGcO6oz07-iQ99wixmX:22
X-Proofpoint-ORIG-GUID: -Ou8wIGuU97iL2p5YdAOjB5YCfJ5iI1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXVnIDIwLCAyMDI0LCBhdCAxOjQx4oCvQU0sIElhbiBSb2dlcnMgPGlyb2dlcnNA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVy
bmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIE1vbiwgQXVnIDE5LCAyMDI0
IGF0IDc6MDbigK9QTSBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+
PiBSZWFjaGluZyBvdXQgdG8gdGhlIHBlcmYgY29tbXVuaXR5IGZvciBmZWVkYmFjayBvbiB0aGUg
Zm9sbG93aW5nDQo+PiBvYnNlcnZlZCB0ZXN0IGZhaWx1cmUuIE9uIDYuNi55LCBJIHNlZSBwZXJz
aXN0ZW50IGZhaWx1cmVzIHdpdGggdGVzdA0KPj4gMTAuMiBQTVUgZXZlbnQgbWFwIGFsaWFzZXMs
IGNvbXBsYWluaW5nIGFib3V0IHRlc3RpbmcgYWxpYXNlcyB1bmNvcmUNCj4+IFBNVSBtaXNtYXRj
aGVzLiBJJ3ZlIGluY2x1ZGVkIHR3byBvdXRwdXRzIGJlbG93LCBvbmUgd2l0aCBhIGJpdCBvZg0K
Pj4gaGFja3kgcHJpbnQgZGVidWdnaW5nLg0KPj4gDQo+PiBVc2luZyBJbnRlbChSKSBYZW9uKFIp
IEdvbGQgNjE1NCBDUFU6DQo+PiAgICAgICAgMTAuMjogUE1VIGV2ZW50IG1hcCBhbGlhc2VzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6DQo+PiAgICAgICAgLS0tIHN0
YXJ0IC0tLQ0KPj4gICAgICAgIHRlc3QgY2hpbGQgZm9ya2VkLCBwaWQgOTYyOTAxDQo+PiAgICAg
ICAgVXNpbmcgQ1BVSUQgR2VudWluZUludGVsLTYtNTUtNA0KPiANCj4gSGkgSm9uLA0KPiANCj4g
U29ycnkgZm9yIHRoZSBicmllZiByZXBseSBidXQgSSB0aG91Z2h0IHNvbWUgcXVpY2sgaGludHMg
bWlnaHQgdW5ibG9jaw0KPiB5b3Ugb24gdGhpcy4gVGhlIENQVUlEIGxpbmVzIHVwIHdpdGggYSBT
a3lsYWtlWDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0
dHBzLTNBX19naXQua2VybmVsLm9yZ19wdWJfc2NtX2xpbnV4X2tlcm5lbF9naXRfcGVyZl9wZXJm
LTJEdG9vbHMtMkRuZXh0LmdpdF90cmVlX3Rvb2xzX3BlcmZfcG11LTJEZXZlbnRzX2FyY2hfeDg2
X21hcGZpbGUuY3N2LTNGaC0zRHBlcmYtMkR0b29scy0yRG5leHQtMjNuMzMmZD1Ed0lGYVEmYz1z
ODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9TkdQUkdHbzM3bVFpU1hnSEttNXJDUSZtPVJKeDY2MXh6
YWtyQjQyaHNVc0ZEMUhoSmN6a2dwYVl1cjlsSFZ0bDdqMzZfX0NCT3FZZktmNERucTB4ZHBCWmwm
cz1GLWVYc21UQVNnUnNwdHQ1R2Focm82ZlJ5TXdFUWRqWjZQdFk3dmh6SUtNJmU9DQo+IA0KPj4g
ICAgICAgIHRlc3RpbmcgY29yZSBQTVUgY3B1IGFsaWFzZXM6IHBhc3MNCj4+ICAgICAgICBKS0RC
RzogcG11IG5yIHRvdGFsIDMgcG11LT5zeXNmc19hbGlhc2VzIDMgcG11LT5zeXNfanNvbl9hbGlh
c2VzIDANCj4+ICAgICAgICBKS0RCRzogcG11IGNwdV9hbGlhc2VzX2FkZGVkIG5yIHRvdGFsIDQg
cG11LT5jcHVfanNvbl9hbGlhc2VzIDENCj4+ICAgICAgICB0ZXN0aW5nIGFsaWFzZXMgdW5jb3Jl
IFBNVSB1bmNvcmVfaW1jXzA6IG1pc21hdGNoIGV4cGVjdGVkIGFsaWFzZXMNCj4+ICAgICAgICAg
ICgxKSB2cyBmb3VuZCAoNCkNCj4+ICAgICAgICB0ZXN0IGNoaWxkIGZpbmlzaGVkIHdpdGggLTEN
Cj4+ICAgICAgICAtLS0tIGVuZCAtLS0tDQo+PiAgICAgICAgUE1VIGV2ZW50cyBzdWJ0ZXN0IDI6
IEZBSUxFRCENCj4+IA0KPj4gVXNpbmcgSW50ZWwoUikgWGVvbihSKSBQbGF0aW51bSA4MzUyWToN
Cj4+ICAgICAgICAxMC4yOiBQTVUgZXZlbnQgbWFwIGFsaWFzZXMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDoNCj4+ICAgICAgICAtLS0gc3RhcnQgLS0tDQo+PiAgICAg
ICAgdGVzdCBjaGlsZCBmb3JrZWQsIHBpZCAxNzY1MDcwDQo+PiAgICAgICAgVXNpbmcgQ1BVSUQg
R2VudWluZUludGVsLTYtNkEtNg0KPiANCj4gVGhpcyBpcyBhbiBJY2VsYWtlWDoNCj4gaHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19naXQua2VybmVs
Lm9yZ19wdWJfc2NtX2xpbnV4X2tlcm5lbF9naXRfcGVyZl9wZXJmLTJEdG9vbHMtMkRuZXh0Lmdp
dF90cmVlX3Rvb2xzX3BlcmZfcG11LTJEZXZlbnRzX2FyY2hfeDg2X21hcGZpbGUuY3N2LTNGaC0z
RHBlcmYtMkR0b29scy0yRG5leHQtMjNuMTgmZD1Ed0lGYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0
R2NnJnI9TkdQUkdHbzM3bVFpU1hnSEttNXJDUSZtPVJKeDY2MXh6YWtyQjQyaHNVc0ZEMUhoSmN6
a2dwYVl1cjlsSFZ0bDdqMzZfX0NCT3FZZktmNERucTB4ZHBCWmwmcz02RHdENFpteXdBdGN3Q25S
ang3d1JmbWRXX0c2NXdISXV5WkpJY19fMnljJmU9DQo+IA0KPj4gICAgICAgIHRlc3RpbmcgY29y
ZSBQTVUgY3B1IGFsaWFzZXM6IHBhc3MNCj4+ICAgICAgICB0ZXN0aW5nIGFsaWFzZXMgdW5jb3Jl
IFBNVSB1bmNvcmVfaW1jX2ZyZWVfcnVubmluZ18wOiBtaXNtYXRjaA0KPj4gICAgICAgICAgZXhw
ZWN0ZWQgYWxpYXNlcyAoMSkgdnMgZm91bmQgKDYpDQo+PiAgICAgICAgdGVzdCBjaGlsZCBmaW5p
c2hlZCB3aXRoIC0xDQo+PiAgICAgICAgLS0tLSBlbmQgLS0tLQ0KPj4gICAgICAgIFBNVSBldmVu
dHMgc3VidGVzdCAyOiBGQUlMRUQhDQo+PiANCj4+IERpZ2dpbmcgaW4gbW9yZSwgbG9va2luZyBh
dCBwbXVfYWxpYXNlc19wYXJzZSwgSSBzZWUgdGhhdCB3ZSdsbCBkaXNjYXJkDQo+PiBzY2FsZSBh
bmQgdW5pdCBmaWxlcyBpbiBwbXVfYWxpYXNfaW5mb19maWxlLCB3aGljaCBsZWF2ZXMgdXMgd2l0
aCAzeA0KPj4gYWxpYXNlcyBpbiB0aGUgdW5jb3JlX2ltY18wIGluIHRoZSBmaXJzdCBjYXNlIGFu
ZCA1eCBhbGlhc2VzIGluIHRoZQ0KPj4gdW5jb3JlX2ltY19mcmVlX3J1bm5pbmdfMCBzZWNvbmQg
Y2FzZS4NCj4+IA0KPj4gIyBGcm9tIDYxNTQtYmFzZWQgc3lzdGVtOg0KPj4gbHMgLWxoYXQgL3N5
cy9kZXZpY2VzL3VuY29yZV9pbWNfMC9ldmVudHMNCj4gDQo+IFRoZSAidW5jb3JlXyIgcHJlZml4
IGFuZCB0aGUgIl8wIiBzdWZmaXggYXJlIG9wdGlvbmFsLCB0aGUgbmFtaW5nDQo+IG1hdGNoaW5n
IGlzIGNhc2UgaW5zZW5zaXRpdmUuIEluIHRoZSBldmVudCBqc29uIHRoZSBldmVudHMgYXJlIGxp
c3RlZA0KPiBoZXJlOg0KPiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJs
P3U9aHR0cHMtM0FfX2dpdC5rZXJuZWwub3JnX3B1Yl9zY21fbGludXhfa2VybmVsX2dpdF9wZXJm
X3BlcmYtMkR0b29scy0yRG5leHQuZ2l0X3RyZWVfdG9vbHNfcGVyZl9wbXUtMkRldmVudHNfYXJj
aF94ODZfc2t5bGFrZXhfdW5jb3JlLTJEbWVtb3J5Lmpzb24tM0ZoLTNEcGVyZi0yRHRvb2xzLTJE
bmV4dCZkPUR3SUZhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1OR1BSR0dvMzdtUWlTWGdI
S201ckNRJm09Ukp4NjYxeHpha3JCNDJoc1VzRkQxSGhKY3prZ3BhWXVyOWxIVnRsN2ozNl9fQ0JP
cVlmS2Y0RG5xMHhkcEJabCZzPUZwQWdWd0xtVHlYVUZRSU1aX2diUGxIOWFYdnJtY0o4Q1phVzN0
S0lhajQmZT0NCj4gDQo+PiB0b3RhbCAwDQo+PiAtci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBL
IEF1ZyAxOSAxODo1MCBjYXNfY291bnRfcmVhZC5zY2FsZQ0KPj4gLXItLXItLXItLS4gMSByb290
IHJvb3QgNC4wSyBBdWcgMTkgMTg6NTAgY2FzX2NvdW50X3JlYWQudW5pdA0KPj4gLXItLXItLXIt
LS4gMSByb290IHJvb3QgNC4wSyBBdWcgMTkgMTg6NTAgY2FzX2NvdW50X3dyaXRlLnNjYWxlDQo+
PiAtci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBLIEF1ZyAxOSAxODo1MCBjYXNfY291bnRfd3Jp
dGUudW5pdA0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgIDkgMTU6MzAgY2Fz
X2NvdW50X3JlYWQNCj4+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDQuMEsgQXVnICA5IDE1OjMw
IGNhc19jb3VudF93cml0ZQ0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgIDkg
MTU6MzAgY2xvY2t0aWNrcw0KPiANCj4gVGhpcyBzaG91bGQgYmUgMyBzeXNmcyBldmVudHMgKEkg
ZG9uJ3QgbGlrZSB0aGUgdGVybSBhbGlhcyksIG5vdGUgdGhhdA0KPiB3ZSBsb2FkIHRoZSBzeXNm
cyBhbmQganNvbiBldmVudHMgbGF6aWx5IHRvIGF2b2lkIG92ZXJoZWFkLg0KPiANCj4+IGRyd3hy
LXhyLXguIDIgcm9vdCByb290ICAgIDAgSnVsIDE3IDAzOjQwIC4NCj4+IGRyd3hyLXhyLXguIDUg
cm9vdCByb290ICAgIDAgSnVsIDE3IDAyOjUyIC4uDQo+PiANCj4+ICMgRnJvbSB0aGUgODM1Mlkt
YmFzZWQgc3lzdGVtOg0KPj4gbHMgLWxoYXQgL3N5cy9idXMvZXZlbnRfc291cmNlL2RldmljZXMv
dW5jb3JlX2ltY19mcmVlX3J1bm5pbmdfMC9ldmVudHMNCj4+IHRvdGFsIDANCj4+IC1yLS1yLS1y
LS0uIDEgcm9vdCByb290IDQuMEsgQXVnIDIwIDAxOjQ0IGRkcnRfcmVhZC5zY2FsZQ0KPj4gLXIt
LXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMjAgMDE6NDQgZGRydF9yZWFkLnVuaXQNCj4+
IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDQuMEsgQXVnIDIwIDAxOjQ0IGRkcnRfd3JpdGUuc2Nh
bGUNCj4+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDQuMEsgQXVnIDIwIDAxOjQ0IGRkcnRfd3Jp
dGUudW5pdA0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMjAgMDE6NDQgcmVh
ZC5zY2FsZQ0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMjAgMDE6NDQgcmVh
ZC51bml0DQo+PiAtci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBLIEF1ZyAyMCAwMTo0NCB3cml0
ZS5zY2FsZQ0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMjAgMDE6NDQgd3Jp
dGUudW5pdA0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMTkgMjE6MzMgZGNs
aw0KPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgNC4wSyBBdWcgMTkgMjE6MzMgZGRydF9yZWFk
DQo+PiAtci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBLIEF1ZyAxOSAyMTozMyBkZHJ0X3dyaXRl
DQo+PiAtci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBLIEF1ZyAxOSAyMTozMyByZWFkDQo+PiAt
ci0tci0tci0tLiAxIHJvb3Qgcm9vdCA0LjBLIEF1ZyAxOSAyMTozMyB3cml0ZQ0KPiANCj4gVGhp
cyBpcyA1IHN5c2ZzIGV2ZW50cywgdGhlIGpzb24gZXZlbnRzIGFyZSBoZXJlOg0KPiBodHRwczov
L3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC5rZXJuZWwu
b3JnX3B1Yl9zY21fbGludXhfa2VybmVsX2dpdF9wZXJmX3BlcmYtMkR0b29scy0yRG5leHQuZ2l0
X3RyZWVfdG9vbHNfcGVyZl9wbXUtMkRldmVudHNfYXJjaF94ODZfaWNlbGFrZXhfdW5jb3JlLTJE
bWVtb3J5Lmpzb24tM0ZoLTNEcGVyZi0yRHRvb2xzLTJEbmV4dC0yM24xMzQmZD1Ed0lGYVEmYz1z
ODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9TkdQUkdHbzM3bVFpU1hnSEttNXJDUSZtPVJKeDY2MXh6
YWtyQjQyaHNVc0ZEMUhoSmN6a2dwYVl1cjlsSFZ0bDdqMzZfX0NCT3FZZktmNERucTB4ZHBCWmwm
cz1Nckh1VUNaRnFyTnJkMDVJUHlxNGZ1WkRINF9vd2tFdzB4SGNjN2J2R3ZVJmU9DQo+IE5vdGUs
IHRoZSAiVW5pdCIsIG1lYW5pbmcgdGhlIFBNVSBzaG91bGQgYmUgaW1jX2ZyZWVfcnVubmluZyB0
byBtYXRjaA0KPiB0aGlzIGRldmljZS4NCj4gDQo+PiBkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCAg
ICAwIEF1ZyAxNSAwMzoxNSAuDQo+PiBkcnd4ci14ci14LiA1IHJvb3Qgcm9vdCAgICAwIEF1ZyAx
NSAwMjo0MiAuLg0KPj4gDQo+PiBMb29raW5nIGF0IHRoZSBzdHJ1Y3R1cmUgb2YgX190ZXN0X3Vu
Y29yZV9wbXVfZXZlbnRfYWxpYXNlcywgaG93ZXZlciwNCj4+IEknbSBub3QgcXVpdGUgc3VyZSBo
b3cgdGhpcyBpcyBzdXBwb3NlZCB0byB3b3JrLiBJJ3ZlIGFubm90YXRlZCBhIHdhbGsNCj4+IHRo
cm91Z2ggYmVsb3cgdG8gaGlnaGxpZ2h0IHdoZXJlIHRoaW5ncyBhcmUgZ29pbmcgb2ZmIHRoZSBy
YWlscy4NCj4+IA0KPj4gc3RhdGljIGludCBfX3Rlc3RfdW5jb3JlX3BtdV9ldmVudF9hbGlhc2Vz
KHN0cnVjdCBwZXJmX3BtdV90ZXN0X3BtdSAqdGVzdF9wbXUpDQo+PiB7DQo+PiAuLi4NCj4+ICAg
ICAgICAvKiBDb3VudCBob3cgbWFueSBhbGlhc2VzIHdlIGdlbmVyYXRlZCAqLw0KPj4gICAgICAg
IGFsaWFzX2NvdW50ID0gcGVyZl9wbXVfX251bV9ldmVudHMocG11KTsNCj4+ICAgICAgICAgICAg
ICAgIC8vIGFsaWFzX2NvdW50ID09IDQgaW4gdGhlIDYxNTQtYmFzZWQgc3lzdGVtDQo+PiAgICAg
ICAgICAgICAgICAvLyBhbGlhc19jb3VudCA9PSA2IGluIHRoZSA4MzUyWS1iYXNlZCBzeXN0ZW0N
Cj4+IA0KPj4gICAgICAgIC8qIENvdW50IGhvdyBtYW55IGFsaWFzZXMgd2UgZXhwZWN0IGZyb20g
dGhlIGtub3duIHRhYmxlICovDQo+PiAgICAgICAgZm9yICh0YWJsZSA9ICZ0ZXN0X3BtdS0+YWxp
YXNlc1swXTsgKnRhYmxlOyB0YWJsZSsrKQ0KPj4gICAgICAgICAgICAgICAgdG9fbWF0Y2hfY291
bnQrKzsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLy8gdGhpcyBpcyBsb29raW5nIGF0IGFs
aWFzZXMgaW4gc3RydWN0IHBlcmZfcG11X3Rlc3RfcG11DQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgIC8vIHRhYmxlLCB3aGljaCBmb3IgdW5jb3JlX2ltY18wIGlzIGEgc2luZ2xlIGVudHJ5IGZv
cg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAvLyAmdW5jb3JlX2ltY19jYWNoZV9oaXRzLg0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAvLw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAv
LyBmb3IgdGhlIDgzNTJZIGNhc2UsIGxpa2V3aXNlLCB3ZSBvbmx5IGhhdmUgYSBzaW5nbGUgYWxp
YXMNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLy8gaW4gdGhlIHRhYmxlIGZvciAmdW5jb3Jl
X2ltY19mcmVlX3J1bm5pbmdfY2FjaGVfbWlzcy4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
Ly8NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLy8gaW4gYm90aCBjYXNlcywgdG9fbWF0Y2hf
Y291bnQgPT0gMQ0KPj4gDQo+PiAgICAgICAgLy8gQ29tcGFyZSA0IHZzIDEgb3IgNiB2cyAxDQo+
PiAgICAgICAgaWYgKGFsaWFzX2NvdW50ICE9IHRvX21hdGNoX2NvdW50KSB7DQo+PiAgICAgICAg
ICAgICAgICBwcl9kZWJ1ZygidGVzdGluZyBhbGlhc2VzIHVuY29yZSBQTVUgJXM6IG1pc21hdGNo
IGV4cGVjdGVkIGFsaWFzZXMgKCVkKSB2cyBmb3VuZCAoJWQpXG4iLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcG11X25hbWUsIHRvX21hdGNoX2NvdW50IC8qIDEgKi8sIGFsaWFzX2NvdW50
IC8qIDQgKi8pOw0KPj4gICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAvLyB3ZSBzZWVtZWQgZG9vbWVkIHRvIGhpdCB0aGlzIGNvbmRpdGlvbmFsIGFs
d2F5cywgbm8/DQo+PiAgICAgICAgfQ0KPj4gLi4uDQo+PiB9DQo+PiANCj4+IEkgZGlkIGEgd2Fs
a3Rocm91Z2ggb2YgdGhlIGxhdGVzdCBtYWlubGluZSBjb2RlLCBhbmQgZG9uJ3Qgc2VlIGEgbWFy
a2VkDQo+PiBkaWZmZXJlbmNlIHRoYXQganVtcCBvZmYgdGhlIHBhZ2UgdG8gbWUgdGhhdCdkIGNv
cnJlY3QgdGhpcyBiZWhhdmlvciwNCj4+IGFuZCB3b3VsZCBsb3ZlIGEgaGVscGluZyBoYW5kIHRv
IHBvaW50IGluIHRoZSByaWdodCBkaXJlY3Rpb24gb24gdGhpcy4NCj4+IA0KPj4gV2hhdCBhbSBJ
IG1pc3NpbmcgaGVyZT8NCj4gDQo+IEknbGwgbmVlZCBzb21lIG1vcmUgdGltZSB0byBkaWcgaW50
byB0aGlzLiBIb3BlZnVsbHkgdGhlIHBvaW50ZXJzIGFib3ZlIGhlbHAuDQoNClRoYW5rcyBmb3Ig
dGhlIHF1aWNrIHJlcGx5IGFuZCBwb2ludGVycywgSSBhcHByZWNpYXRlIGl0LiBUaGUgdHJpY2t5
IGJpdCBzdGlsbA0KcmVtYWlucywgYXMgdGhlIGNvZGUgSSBwb3N0ZWQgdG8gYWJvdmUgc2VlbXMg
dG8gc29sZWx5IGRlcGVuZCBvbiB0aGUNCmluZm8gZmlsbGVkIGludG8gc3RydWN0IHBlcmZfcG11
X3Rlc3RfcG11LCByaWdodD8gSWYgc28sIEkgZG9u4oCZdCBzZWUgaG93IHRoZQ0KZG90cyBjb25u
ZWN0IGZyb20gdGhpcyB0ZXN0IHRvIHRoZSBvdGhlciBldmVudHMgaW4gc3lzZnMvanNvbuKAmXMu
DQoNCj4gDQo+IFRoYW5rcywNCj4gSWFuDQoNCg0K

