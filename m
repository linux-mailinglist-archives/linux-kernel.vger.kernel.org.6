Return-Path: <linux-kernel+bounces-303090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31D960744
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF95B217BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8C19DF97;
	Tue, 27 Aug 2024 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hxCDzJGq"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010028.outbound.protection.outlook.com [52.101.128.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B209450;
	Tue, 27 Aug 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753971; cv=fail; b=W4AKJoBB7/AqEh8Op88dUwjVyPmNnrVUI1sW0hqm1rra7uJyID4mtEnGzpsBVBJrK1OwxvvkORt9wUbmjOF/6NV+0L9owI3wW4BpxRsPp6tGujmSolaF5lHMMMNHN/euGzi2N2QXW6LFkxTo92OvIspIErnixxB+M2ixR5HguXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753971; c=relaxed/simple;
	bh=bLika92/uaYyx02oWNkRYrt1LERbg7DmU7zDnOzjrW8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZDTIKfFCOxAuzfyYylsFYyh4Mfb2ud4LX/5g6thPH+etAaTCI2A1XfP7fZZ40pzLETQui4S+CS+q3cc1MaoR9lSIonZ1rDkC0Dcy/M8s9hKmeiibIRLnpTTLAV+obQ++JnYey1cC2tf3yeV1PQwkNS/g2+6EOHzqjNkqxzOYuns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hxCDzJGq; arc=fail smtp.client-ip=52.101.128.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXUfVWJHiO9KZSXS6pNrUVIFVqvobHrOTS/twqj0HbZj4IfwRC7eS6soiWlTbnUEUKmBXSZvj3VQ1Y/kyYv+PZK781SkzSOG6YW+aQmBXjQ3Q8SiwOb/VYMu1ZL4vDqt9JSt8DFiT4kjgWr+El4LSp/4TJHnQzV9/O3nkIpXvDaEI3DnbHYGqjpTPmRO8AhoNKt8CE2bK7OY9J6UdKMqNOYFioZ2EVCoXviFTjUGdIlsy+jDwRik2B3quxrnQCL5Qu6aCcSySuHOnO3hCl0ZnEmzekjl2Sv7lyvAnghBbHJZNmPy/Ev458f0RJhVbM5xA6pYfdtp/C12GxLB/sMPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLika92/uaYyx02oWNkRYrt1LERbg7DmU7zDnOzjrW8=;
 b=Z5588F7AUw+G6jZKqNotoHPYIqdMZhy1El+NcNA4veuBYkchS/hpIU8PcQPtT0FA4VD7p/AaDsDjUPUNi3UBvS6AJoeRH3cA8I5M4py4QAHn5ke/bt5CTPbkphDIsX4U/B4YWu6Tc72wrN5oH+SE6UhRNk1JtJXQ6RzHfcLy3Da/OSX/rdFhQBIgYNiPUZTMBveuadu3KuTNCGvHGJEFym9q90aW10aMQwVR7I1tKXtayTrwMyExQr+HyhWgmnKg3aKXlhb6su1Zly3ZQ5y3J7qNgr2sKSB0czq9ENXbemFmSyHhALP9a1/O0mJ+qm91HrkxRTysCijSB4X9xleWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLika92/uaYyx02oWNkRYrt1LERbg7DmU7zDnOzjrW8=;
 b=hxCDzJGqBNDvnwzJxXtPJ6AP1GGRHjEI94He+e8u2bPZ8ChVgp1HrLeVYEn58Nwps9HqS7HKVgLc0jffrrSvMadTJChVdDJM939Y6UA0irjBwlWGEb2BQ8zNWraKecDBLhOvgjaYTCgzkcc6vbprhN1MLdjvQU/wjmd0iaF77BZPNAtEqOk5IALcgfMcDnm4JvdzaHhWgHKGLOMk/nCI++r3Uj9awPBD7GAXuQ6FGCBS4x3LqzX8p52cjjF5+ffufozO6zjEy+pNHCuV4dVIm+gXH47ORlTtOR7Zgs/D5/s5mHJDCW9E2dg1iri+qx1FMuqtWGYOLywHSXw8aXn8Aw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by PUZPR06MB6188.apcprd06.prod.outlook.com (2603:1096:301:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 10:19:22 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 10:19:22 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: [PATCH v8] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Topic: [PATCH v8] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr4aNYXeCkosvBxSpO4qbARlQh3sg==
Date: Tue, 27 Aug 2024 10:19:22 +0000
Message-ID:
 <TYUPR06MB6217549161B67D996EB3DCE3D2942@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|PUZPR06MB6188:EE_
x-ms-office365-filtering-correlation-id: 0ba35f7f-cd9b-4782-1ad5-08dcc681b843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm1ENDJPWm5zUFk4UnQ1MVNWb3FoMzA0SDJKRXlxd0JBWlZNQnV6M2xEemQz?=
 =?utf-8?B?bmhDNXRpaFBTZVFWQW9IV2VBaXB6TGphWjI5bDJmQndJY1NCMCs0Z3IzM2RY?=
 =?utf-8?B?SXRXTlZqK3Z5Rm9PNHgzazNLdFJJNmE2N2drRnR1TWVBWHVVY1V3QlY0Szky?=
 =?utf-8?B?ZnVMYXFmR0FGRzRlWWliaHI0TU1UVlRDcmtqTmp2WWx2a3ZlVkZxSWRZRThq?=
 =?utf-8?B?WXI2eHdYdS9DczNTbEUxRjVpamM5ZSt0OTJ5aiswSWlmalY0Mi9tejNuUGtD?=
 =?utf-8?B?bkRDYlB2ZGtNODdueFRUMHltdFU2QnZNQU5DNzZEN2RCR3NoaGRSVUt1VVIz?=
 =?utf-8?B?VStSN2dqZVd6d2o3S3dFOG9WSFYyZloxZEJyZ0FYY2gvendUSVJlOWhvS2tm?=
 =?utf-8?B?UzREYlEveEs3Y0RvVGYwUDhNak8xVmF5aFBNUXhJY0hHY0ZXQzFkck44MDFX?=
 =?utf-8?B?NkpSZGpJWFpFcmdSY3ZDeWpkUytaei9vZkdtTERpZHBFS25IQTltQytqRStD?=
 =?utf-8?B?OFlUTkVBckxLN3dGR2VTd3BLamtOMmRJcEwrOERMc1FyWjFtWU1hVm9iZDYw?=
 =?utf-8?B?SC9DaHorRmZReCswSzFQM3RUc2VaMERoc0xPTjhOY0NxK2EwNjNZUTIwYldp?=
 =?utf-8?B?bHJIWEpiUHNGam9xb09OcWl5TFF1cTQvbVEzSEdFZ0NyNGxXVW4rSzA1MVF2?=
 =?utf-8?B?ZkJVZEdHekhTWllrSW9XZzhDSmtrNFNLNkVKTVNhelV5NksrS0krQVJSdWZl?=
 =?utf-8?B?MGZPaVAva1lLOXEwRm5DdkFpV21mNFBKRDZsSlNtR3FrTFBpMElWUHkxaHVV?=
 =?utf-8?B?L1lCeFUyZ1AyVVc0aGpzYXIvaHI2bTc5ZFRZSXp1TWFIOElKejE2NUE1MG5M?=
 =?utf-8?B?Wng0TmVaNHVVeVExMXdmTW1VeDNpMkkvbk5qRzhjK3pVYUpiaTI4YXNCUkNl?=
 =?utf-8?B?d05xczlGN3llMHMrNjFUeEFhcHRCSGVLSEpOMzU3RWFEUlJZV0tYMVd5SmRw?=
 =?utf-8?B?ZFlFWFA1ZXJ1aHpkOEJ6UWFmTGxXTWhoVGNWZy9wZERIVUtkQ2p2Q1hhMmgw?=
 =?utf-8?B?cGw5Wi80dlFwZHNwV2dpSVpNVDk2Q0U3VFN0RjVLWXdMTWZwTERJNDBVbnpo?=
 =?utf-8?B?cklDSU5TWkgxTk1NVS9PMlpSUFQ2TjNYZ3M4NFRlRXRkSExKRmQyQTJWNER0?=
 =?utf-8?B?c21rc0ZXNUFWSzhwOGo4Mi91Tkcrb2ZMUHBkbk0xV3ZqQ0NNTFNvNGNtckxk?=
 =?utf-8?B?ZHU0OEdnc0ZCdWZYaUdldEZqNXY2azZycG5GY3pqTjQ1dHV1WTNWei95N3A1?=
 =?utf-8?B?RzQvMkxrRTA0UlViWkp0dUtXbldnenJZZVZFSTFoL2NuMmEvV0s4UXBSdm1S?=
 =?utf-8?B?U2xJOGRFOXdIWHFPdE5JWllpdHVsYWtkV1hVZEYwbFBxOXdlM1dxYit4ZjZl?=
 =?utf-8?B?UTQydStydlloTlBLRlFBcDRMb3pCUjVZYS9pSkpZeFNMUEptUmhUVE1nQ3FO?=
 =?utf-8?B?RmV2cmI2WXhJQTE4NFpTWkYvMWQ3S3lXcWJOVGxaYVl0ZnJJd2Uyd1hmWjJ5?=
 =?utf-8?B?djFaazBpbVhuVmN1WWVPMDVzV1JnTlRMeEUxcFJDT00wS3Y3eGNpMk94QWxC?=
 =?utf-8?B?end2bW1wUEtTVXhIRWhxbFloejBZeDczdXlOamU5M2dVS3FTOGN6U3hTdk1t?=
 =?utf-8?B?YlJHeTdJbmpjTUI5SnlxSGhncndLTWF4ZnNta1VyUGpSRkZ3aE13WjZ0VUMv?=
 =?utf-8?B?OXRHNnppcGpOMVQyaTJsUXVpTHBLWHZZdk1tVm01aHY2R1QrZWxMTGx0WEFu?=
 =?utf-8?B?RFlsd01kOW56OHo3cDJxYUtpWkhIWkpOem16by82YnBzMzR2NWpHUjNlZ0Nk?=
 =?utf-8?B?cllOenh2L21iMDVOZm5ad29JREhZVWlXMDhHOTlQaUNJUGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnJvTWk1WTFhS204V2tscm5JRzdSSmdMclJaemxvd2VOelk2eE1vTDdweWk0?=
 =?utf-8?B?bHJ6M2M3RnBjaGJKVno5Z1VVRlBwaDBkT2tTMGR0OHZwUkJheEpxc0tvMUp0?=
 =?utf-8?B?NlRjajJpeDR4MnB3UFhqYlBnNVNrOVE4ay9FcEVFbElDZTFFcFJyRmJ5TjVV?=
 =?utf-8?B?UzVvNTBLaGpCUy9RdW03cWxEVklWc1M0R2FCREttVXhpOHBDQThOeEx5WDFs?=
 =?utf-8?B?Tk5pbDZpUkkrNmRLZ0llZ2liUHhDOGRMMG5YSEQ2WmdVQyszQjFTSGxMQ25a?=
 =?utf-8?B?Y2VMajVtUnp4Nk1HUlkxSEVwWGdVK1djd3Rnbkd5VUVHRGRYSDhUYmhHRWF4?=
 =?utf-8?B?amNNUFN3bmdEYmZhZVJ6Q29hNnhYc1ZKODhvUmJUeUdpbmFPZ3hERHVUTTVI?=
 =?utf-8?B?NTE5d0pyOXYrY3NqWndWTzIyeGJ0ekZ3VXVrekZ3WXdjRDBhSEJCUzNLVTZC?=
 =?utf-8?B?TFUzMDVaeGNXTnVCU1VnQUI0QkkxYnJQODRHM1FhbWlFNVdPNERjOXRDZ21j?=
 =?utf-8?B?SlRWSm45aXd0VzlsbkVqOVNESXlyNGdFWlpaTW5iZHNNcXpDL29Rd0V4RUtM?=
 =?utf-8?B?UWo0M2xtU05LOExSakN0M3RkdHM5Wk5rKzhvL3pIb3lXMjhKWFhpRERJUXNI?=
 =?utf-8?B?cFVDeVRtQ00xR0Q2cmIyWjRjMWNVMnc4aDZCSVRKZ3I4RG1VK3JGLzRMcHNZ?=
 =?utf-8?B?VjNoV1JNSnhVNlZCalNMb0xka3NlSFFHR3Rab3ZKeXZuNmlNdk5oaW9xbkx5?=
 =?utf-8?B?NEl5NENVZFI5UEZqWHRvNGVoZnJYaUdqQ3NSa3RWQjg2T0VtbzVwMGlTT1Mw?=
 =?utf-8?B?cWxTNGxvL0U1MEdUNW8xNDNkS051emJ3ckJHaHdkTm1sZHR1YlNxUUxudlJP?=
 =?utf-8?B?MUFsQlc5dnp5TGhZQUtWcXJlb2ZXcXNGczZDb2NDUVI5eXV2RjkxZWdodzZV?=
 =?utf-8?B?SDFmUC9peHl4akE4UHlwcng5RUJ3WWhsbkdzK2t6aFAydlZVVXBPaVgwR3NI?=
 =?utf-8?B?Nm0yS3JXQXZmVUlqSFh0MG90SEN3MDhJay96bTRQMkJpR0VGWjRzUVFSMTBR?=
 =?utf-8?B?ZmFJb3ZPVm51bEM4cnBFMlp5aGtVVU9FWWxIaW5aTjNJanRVRkp3WHd1NXIy?=
 =?utf-8?B?ejdXMTBEUHNZQk5KTllnbFNKSGh5aDlQcEJreUlIcTlYek9ONG53dWlLZlp3?=
 =?utf-8?B?Q3RZZ0Z5WTRvQTVwSnR0QjZnZExxNlk3c0dwd3pMYkw0b2V2bTQ2WUdtdUNJ?=
 =?utf-8?B?Z1NSeDY4YXhkdllDajFBVCtnaWx5Rzh0MStISFJJVklvOWJ0SWNoa0FUZDBi?=
 =?utf-8?B?ZkgyU1Vlbmx5RlpRN1NYVjladm1pUEFSOEozN1V0aTB5YkJKWlR5bk04a2tH?=
 =?utf-8?B?VGdOUkI0TUlBM1hMcDVWaTVCZXBqditsWVh6K0YveEY0ZkphZE1ENXRCYWtl?=
 =?utf-8?B?eTNaMnBURGVwcVdhdDBkV0JsOXpkTE10K1RkMGpVRzRJZG1lMHhmaDN6OHJv?=
 =?utf-8?B?UmFnamkrbFY3MWxKY25zZnloR0toOWg2dkxhV0N3M1ZLTzlTZUhaRnBZd3Zu?=
 =?utf-8?B?NUFkYXdvT2JkUkk5Y2Z3Wk53WG1DVkowb1RtU3pTRzVqdGhoTXBYYnRGR3RY?=
 =?utf-8?B?TUlKQWsvY2RtZ091TW5qTjR2Mjl4SXhnNjBRWVJ6cXlua3IwUGNWVzZIMEM5?=
 =?utf-8?B?UHpBbFFXcWJWNFB2aWZ3TS83RWE1NWlSMnVkVU9yWStlN2t1YVh4TnBjRGtC?=
 =?utf-8?B?dmJ0MnYzRmJVaUFZd3Zta1FWWDEzMGZRRXRxZWpMYlpPL1pEMmt2RUtUVGV3?=
 =?utf-8?B?YlRpRlk0Zm9zakEzYmhzU3hYdmRUNjE5WXZJZWZvbTd5TkFUY2Z0TXErVnky?=
 =?utf-8?B?NkJ3aExVRUNoOHdpNUhrQWNGb0V2Z0VYcnAzQ0FlQ1ZxMmxQWXFKNS90dE5h?=
 =?utf-8?B?WGV2ekliK1pwSXR2WkpuYUgwRVI2WFlsU25OcXpBSEJaYVp6Z3lTQjN6SkZY?=
 =?utf-8?B?WjF6L1NuOHE5Z2hGK09zZnpPaFBRc1BJeVErKytBU3hmeTYxM0lCeHNPcmJD?=
 =?utf-8?B?OXRMSWpZWFNpdThSbmw2cXJzR2VMOXQzQko3MGNHeUcrNXJDajRLSVp1MWFv?=
 =?utf-8?Q?SkHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba35f7f-cd9b-4782-1ad5-08dcc681b843
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 10:19:22.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tPwuwhIKrqTntt/CMkprb31KuZ/xhJaWAVhBtHLkPGtagfIeA73/AayGvqrZMjZFlteeKY6efu956O2a8WMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6188

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbg0KaXMgYmVp
bmcgZXhlY3V0ZWQsIGdzZXJpYWxfZGlzY29ubmVjdCBoYXMgYWxyZWFkeSBjbGVhcmVkIGdzZXIt
PmlvcG9ydCwNCmFuZCBnc19yZWFkX2NvbXBsZXRlIGdldHMgY2FsbGVkIGFmdGVyd2FyZHMsIHdo
aWNoIHJlc3VsdHMgaW4gYWNjZXNzaW5nDQpudWxsIHBvaW50ZXIsIGFkZCBhIG51bGwgcG9pbnRl
ciBjaGVjayB0byBwcmV2ZW50IHRoaXMgc2l0dWF0aW9uLg0KDQpBZGRlZCBhIHN0YXRpYyBzcGlu
bG9jayB0byBwcmV2ZW50IGdzZXItPmlvcG9ydCBmcm9tIGJlY29taW5nDQpudWxsIGFmdGVyIHRo
ZSBuZXdseSBhZGRlZCBjaGVjay4NCg0KVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlIGF0DQp2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDFhOA0KcGMg
OiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCmxyIDogdXNiX2dhZGdldF9naXZlYmFja19y
ZXF1ZXN0KzB4NDAvMHgxNjANCnNwIDogZmZmZmZmYzAwZjE1MzljMA0KeDI5OiBmZmZmZmZjMDBm
MTUzOWMwIHgyODogZmZmZmZmODAwMmEzMDAwMCB4Mjc6IDAwMDAwMDAwMDAwMDAwMDANCngyNjog
ZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiBmZmZmZmY4MDAyYTMw
MDAwDQp4MjM6IGZmZmZmZjgwMDJmZjlhNzAgeDIyOiBmZmZmZmY4OThlN2E3YjAwIHgyMTogZmZm
ZmZmODAzYzlhZjlkOA0KeDIwOiBmZmZmZmY4OThlN2E3YjAwIHgxOTogMDAwMDAwMDAwMDAwMDFh
OCB4MTg6IGZmZmZmZmMwMDk5ZmQwOTgNCngxNzogMDAwMDAwMDAwMDAwMTAwMCB4MTY6IDAwMDAw
MDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAwDQp4MTQ6IDAwMDAwMDAwMDAwMDAwMDMg
eDEzOiAwMDAwMDAwMDAwMDBkNWU4IHgxMjogMDAwMDAwMDM1NWMzMTRhYw0KeDExOiAwMDAwMDAw
MDAwMDAwMDE1IHgxMDogMDAwMDAwMDAwMDAwMDAxMiB4OSA6IDAwMDAwMDAwMDAwMDAwMDgNCng4
IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdj
ZDEyMDAwDQp4NSA6IDAwMDAwMDAwMDAwMDAwMDIgeDQgOiBmZmZmZmZjMDBmOWIwN2YwIHgzIDog
ZmZmZmZmYzAwZjE1MzhkMA0KeDIgOiAwMDAwMDAwMDAwMDAwMDAxIHgxIDogMDAwMDAwMDAwMDAw
MDAwMCB4MCA6IDAwMDAwMDAwMDAwMDAxYTgNCkNhbGwgdHJhY2U6DQpnc19yZWFkX2NvbXBsZXRl
KzB4NTgvMHgyNDANCnVzYl9nYWRnZXRfZ2l2ZWJhY2tfcmVxdWVzdCsweDQwLzB4MTYwDQpkd2Mz
X3JlbW92ZV9yZXF1ZXN0cysweDE3MC8weDQ4NA0KZHdjM19lcDBfb3V0X3N0YXJ0KzB4YjAvMHgx
ZDQNCl9fZHdjM19nYWRnZXRfc3RhcnQrMHgyNWMvMHg3MjANCmtyZXRwcm9iZV90cmFtcG9saW5l
LmNmaV9qdCsweDAvMHg4DQprcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0KdWRj
X2JpbmRfdG9fZHJpdmVyKzB4MWQ4LzB4MzAwDQp1c2JfZ2FkZ2V0X3Byb2JlX2RyaXZlcisweGE4
LzB4MWRjDQpnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3JlKzB4MTNjLzB4MTg4DQpjb25maWdmc193
cml0ZV9pdGVyKzB4MTYwLzB4MWY0DQp2ZnNfd3JpdGUrMHgyZDAvMHg0MGMNCmtzeXNfd3JpdGUr
MHg3Yy8weGYwDQpfX2FybTY0X3N5c193cml0ZSsweDIwLzB4MzANCmludm9rZV9zeXNjYWxsKzB4
NjAvMHgxNTANCmVsMF9zdmNfY29tbW9uKzB4OGMvMHhmOA0KZG9fZWwwX3N2YysweDI4LzB4YTAN
CmVsMF9zdmMrMHgyNC8weDg0DQplbDB0XzY0X3N5bmNfaGFuZGxlcisweDg4LzB4ZWMNCmVsMHRf
NjRfc3luYysweDFiNC8weDFiOA0KQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAwMjIgMmEw
MTAzZTggKDg4ZTg3ZTYyKQ0KLS0tWyBlbmQgdHJhY2UgOTM4ODQ3MzI3YTczOTE3MiBdLS0tDQpL
ZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwgZXhjZXB0aW9uDQoNCkZpeGVz
OiBjMWRjYTU2MmJlOGEgKCJ1c2IgZ2FkZ2V0OiBzcGxpdCBvdXQgc2VyaWFsIGNvcmUiKQ0KQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClN1Z2dlc3RlZC1ieTogUHJhc2hhbnRoIEsgPHF1aWNf
cHJhc2hrQHF1aWNpbmMuY29tPg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWlu
QHZpdm8uY29tPg0KLS0tDQp2ODogVXBkYXRlZCBwYXRjaCBzdWJtaXNzaW9uIGRlc2NyaXB0aW9u
IGFzIHN1Z2dlc3RlZCBpbiB2NyBkaXNjdXNzaW9uLg0Kdjc6IFJlbW92ZSBjb2RlIGNvbW1lbnRz
Lg0KdjY6IFVwZGF0ZSB0aGUgY29tbWl0IHRleHQuDQp2NTogQWRkIHRoZSBGaXhlcyB0YWcuDQp2
NDogQ0Mgc3RhYmxlIGtlcm5lbC4NCnYzOiBBZGQgc2VyaWFsX3BvcnRfbG9jayBwcm90ZWN0aW9u
IHdoZW4gY2hlY2tpbmcgcG9ydCBwb2ludGVyLg0KdjI6IE9wdGltaXplIGNvZGUgY29tbWVudHMu
DQp2MTogRGVsZXRlIGxvZyBwcmludGluZy4NCg0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi91X3NlcmlhbC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uNjZkOTE4NTIzYjNlIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtNDUyLDIwICs0NTIs
NDEgQEAgc3RhdGljIHZvaWQgZ3NfcnhfcHVzaChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQog
DQogc3RhdGljIHZvaWQgZ3NfcmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0
IHVzYl9yZXF1ZXN0ICpyZXEpDQogew0KLQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2
ZXJfZGF0YTsNCisJc3RydWN0IGdzX3BvcnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdz
Ow0KKw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlw
b3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0KKw0KKwlpZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0K
IA0KLQkvKiBRdWV1ZSBhbGwgcmVjZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJl
YWR5IGZvciBpdC4gKi8NCiAJc3Bpbl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3Vu
bG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQorDQorCS8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRh
IHVudGlsIHRoZSB0dHkgbGF5ZXIgaXMgcmVhZHkgZm9yIGl0LiAqLw0KIAlsaXN0X2FkZF90YWls
KCZyZXEtPmxpc3QsICZwb3J0LT5yZWFkX3F1ZXVlKTsNCiAJc2NoZWR1bGVfZGVsYXllZF93b3Jr
KCZwb3J0LT5wdXNoLCAwKTsNCi0Jc3Bpbl91bmxvY2soJnBvcnQtPnBvcnRfbG9jayk7DQorCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KIH0NCiANCiBz
dGF0aWMgdm9pZCBnc193cml0ZV9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVz
Yl9yZXF1ZXN0ICpyZXEpDQogew0KLQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJf
ZGF0YTsNCisJc3RydWN0IGdzX3BvcnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0K
Kw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlwb3J0
ID0gZXAtPmRyaXZlcl9kYXRhOw0KKw0KKwlpZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0KIA0K
IAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jayk7DQorCXNwaW5fdW5sb2NrKCZzZXJpYWxfcG9y
dF9sb2NrKTsNCiAJbGlzdF9hZGQoJnJlcS0+bGlzdCwgJnBvcnQtPndyaXRlX3Bvb2wpOw0KIAlw
b3J0LT53cml0ZV9zdGFydGVkLS07DQogDQpAQCAtNDg2LDcgKzUwNyw3IEBAIHN0YXRpYyB2b2lk
IGdzX3dyaXRlX2NvbXBsZXRlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3Qg
KnJlcSkNCiAJCWJyZWFrOw0KIAl9DQogDQotCXNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2sp
Ow0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5wb3J0X2xvY2ssIGZsYWdzKTsNCiB9
DQogDQogc3RhdGljIHZvaWQgZ3NfZnJlZV9yZXF1ZXN0cyhzdHJ1Y3QgdXNiX2VwICplcCwgc3Ry
dWN0IGxpc3RfaGVhZCAqaGVhZCwNCi0tIA0KMi4zOS4wDQoNCg==

