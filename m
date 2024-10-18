Return-Path: <linux-kernel+bounces-370927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F439A33D7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05511C224F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD6160884;
	Fri, 18 Oct 2024 04:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hqaWZtvh"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011060.outbound.protection.outlook.com [52.101.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C420E32C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225842; cv=fail; b=uNMvNsQdSUiePwnTRhoXktthHAq0YqMfCrRurGolpTUgJv81acusGA4gNGnypZ7FAPIXhUwFVo42jEsQ9EWRH44yhaSzCd3xYuG3cH2nI3xvsMzHxUFt3+U1Eq2BVmDsp1kHF389wjKz/UF1qSB+jUneCg6Y8BCweYyRfXGttV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225842; c=relaxed/simple;
	bh=Wp8JgfCXwINa0Q8W3uf3AcFW2LZdPc+uE6KsAufPMbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRmdMnDFLojaOSkNQEzjD7bGrmDS41acThbky5pwJa7CD6vrLTZARvltnR3hGLHU/5w5Hve+Obyv7S664Ctqso4ItiQsDDXr6pD06YbOOfH420CHYkevr4CnrpwoGkmDzvPeEhgt1PnlspFJuIWi9GTf/OhWItbz4KrjrT8lg6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hqaWZtvh; arc=fail smtp.client-ip=52.101.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Img0n8ZuJ/TSVRTqidL59qzvIgmMQeMIMNmi6ipqgl9+jDTth4JUmdwo6Xabep3TR4+N7uHawlV55mV/sK0PaFxA5GzeLuux72jBAsDlyxrmo45ibcGrBGmrRJvA71aArmPRJW1DbLjZjApx7jCswFHd/wH1SFhw0WL0kOac6RlCxC2Xe3+ygajXGvPCuxdKG4sfrPMaSOr7N1MWCOx4R1f7PlNDS/evAL/tUbny268636LCg2Pa+G3mfF1dISmPAdM45Q2DbXQz4FmAuA0f3YeCj/QeBKQqvKzFhXpV+qnF9CZpxbys/O1JvVTLKP8iGCDEMKaz7zUYbmAradpxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp8JgfCXwINa0Q8W3uf3AcFW2LZdPc+uE6KsAufPMbo=;
 b=bMboUmVyuXFWtbZNT4Yxi4MMKtuB5tN3SbJJIkGfnks4FooPv9ZsCmDUhblHYDZb3aNtLJrfRddbK7XERLMn3OWLRJuSrnWItx5tg/KGMLnXZRTdtnR0C04z5rhjmrUVqU6c8L8stFmkpPNDGWE6J9SXJa2EdweME7T1dxyN0tUJ6PwSUzem/UjHo2MhUf+f5mLedgg15hmgyLSL/gTWelhCTuxGKxvihOKdhKikdkGVfvjrf7HCwDFYp8v+/KRVqVUqttUjWJtTf9NGYeUm6Rr6adHSSqCOnWlgIepV1+Pppc+jJUO9aiQ47mn0/rCGYbAiB5aix2bEJvrOY3fBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp8JgfCXwINa0Q8W3uf3AcFW2LZdPc+uE6KsAufPMbo=;
 b=hqaWZtvhPCo5dyNzmYxgsnVocCMli47GaP2rGFT/zmpLF7/3hoz2ZQb4MWSXsJZpFNQWeKterczQ51a9kYcKRa5DMQvR9LNzS06mIsuDrIbls9n674TWqNAXkuq2emZej+Mo7Y6lP1fIU/iizjf9TuWMkRRys3t6XlpdnQF//xNnsfue7MVs7aNx5/QEQVLTVyLpFFdPQHKJyVtbpWyyYTA3R7e8h/cEvjBgOg868R5bCNrvzg0Z1tQz5hlQPiV1R47M6OztLATPaAm/igDVXUpW7ydFY0H1Ifqhi2uLYxpQ5fJR4EuAyeHWQAiMqcHLL0GpLMKIOdeCeu0eNwp6Iw==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEYPR06MB6359.apcprd06.prod.outlook.com (2603:1096:101:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Fri, 18 Oct
 2024 04:30:35 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%2]) with mapi id 15.20.8093.000; Fri, 18 Oct 2024
 04:30:35 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
Thread-Topic: [PATCH 1/3] erofs: get rid of erofs_{find,insert}_workgroup
Thread-Index: AQHbIIu4Vbh3nYfv0UC2CkvqyrAnErKL69uA
Date: Fri, 18 Oct 2024 04:30:35 +0000
Message-ID: <cd756ca4-e83b-4b10-8792-fc0f1c1ae2fa@vivo.com>
References: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20241017115705.877515-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|SEYPR06MB6359:EE_
x-ms-office365-filtering-correlation-id: d6ce23ea-f72b-4bdf-4c93-08dcef2d9c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUpIMm4zNHR0SHJGcnpVSDJlRGxSTnFaMms2ZVMvRjBaRHRqdStDd1A1L3l6?=
 =?utf-8?B?dytBS2FUbWlxWWZKd3pteHJYci9qdW5ETTAzd2hNZC9aSlcxZjE2NmwwMHNM?=
 =?utf-8?B?SUw3Z1JsdXQ5TDRWZzZpQXZsLzY4VDN1Rk4rWmtZcjdNRlJVN1RHYjRiZk52?=
 =?utf-8?B?eTgzMDZxSzkrVVZBQkEwRDIzeXNVMFlGSWRGa1hoeGpMVG5PY09xeFpBaXF5?=
 =?utf-8?B?amFibjUvMml4SWJRZVJvTHdvaG9yci9wcGIySlluclE4S2c1WkpsQzJCM3hj?=
 =?utf-8?B?SDBjdW92RXZlM0lLSDlQNmtFb3VaTmE0SVFNelpEb2pyejI2eXVrNitNYXRz?=
 =?utf-8?B?S3NkekgxTFV4SkR4a0NXaTk4WmErNjR4NUxEbnlxY3NQL000K3VzaHUzb2Yx?=
 =?utf-8?B?K1NkOUFjYlI0NUFhdlg1M29veUJJa3dQelJRUkJ0eXlBQjhwT0xMdTluTEl6?=
 =?utf-8?B?dDhRcEtKdVZWSERQeVNOc3J2amlpeXdUSEVmWkpSTXdvRnA5NWlVeVJ0TDZC?=
 =?utf-8?B?OXI5L2E1VVUxR2VFQm9wRXVpY0hIVTFhNitIaHliQTJGRU1vSFZ5eE05V2VX?=
 =?utf-8?B?eEpWbWlqMTJjTTZyZTFQOGgvVkl5ZXg3T2gySUdqMGNCUk81Y3RaS2t3NG9q?=
 =?utf-8?B?Ny81eVJEeGYweUIxTi9UcENqcGk5bjhPRCtrQWsvU3grVG5yejVIU0hWWDlz?=
 =?utf-8?B?WkEyak5jaWV5c1FtMTNaSFBDc2w1SkNMbUpzVFBPb2ZYRno4ZEhLRVFZdldR?=
 =?utf-8?B?VHFFMHloWTZUaklXRzNLbkpVTjM3R3Y1KzRJZmFtSnE3OFZkYksyamZ3SXlv?=
 =?utf-8?B?dXNpTHNLbnFKMjFWNHJURWgzYkQ2c0FUT0gzajB2VDRtYTI5UW1YZUNoSlRM?=
 =?utf-8?B?cFdKMVNkeC82aUI5blpncS93RDAyNC9KVlNnaTlGaXhSV2Vmc2lsUmdjWnho?=
 =?utf-8?B?engvNGgrZE56WXVXR041N3RLSFpXekdyUHNaQ0pSV1ZxVFlibFl1dm5FVk10?=
 =?utf-8?B?d0dTVDdMaG9wRWkrTXgrTVlNdnVoYncrQ2F0ZlJyUzVMckdoYWhDZENCUG9n?=
 =?utf-8?B?Q1pYYXE4VXYvMElmSVY4YWxXS2l4bkFkNENoYmliTFRacE9YM05GYTFnVE9L?=
 =?utf-8?B?UzBVN2lpRklaQld1ZXdSL1NTV3V2RW5oM0EzU25zRkFoVmc1SzVKVE5BTnRp?=
 =?utf-8?B?Rm56T3k1eTBDdFQxL1RzZi8zTmJMT0Qrd20yYTdROFN2emFTeUx1QUUxVWlY?=
 =?utf-8?B?TlJhYUovclg3bUpOMmxPVmEwa2NTNzJkQ1A4UHJ1ZUpsUWZwUWE3bHBFd2Fl?=
 =?utf-8?B?REhxSENrQzU2UkVJTFNiOXVPSFQxZFhoZXpvdDdaMEpDSGsremUybjVjRGNh?=
 =?utf-8?B?TUF5ZHpKQndWMTdGVy9vM3p5Y0h0QW40SnlEUE5INHAySkJZTzhIWXMzSFdL?=
 =?utf-8?B?T0thdWtVTnZpZEtaVU1BMGlCak1PaVFzRHhUVDg0TzlBV1dFRGNuaTdPMC9o?=
 =?utf-8?B?RURCZGlzbG95VnNoVHRETklMYXNaVnJOUm5KbHhSMUFjUlY5ZkxlK0pqWEVv?=
 =?utf-8?B?YjN4bnEvWFk1SzF3bkJPVmZ3MGpFdDdGbWtndFpZRTZEWTRGN1Z4WHlzTldx?=
 =?utf-8?B?Wnk0TjJQakZja0sxYzI2KytsT3VrSk4yZ20xcWQxSExyQjduallPdjZDQ3J5?=
 =?utf-8?B?bk9rajZ0OFp4L1pGRjNuRlJpaVZ0cXlDSXhDQlptY2o0cjRlUCt5cURqN1Zr?=
 =?utf-8?B?QVJsZVdBRUNBcDd1ZzZoQ3dySElHcGdTWTNBV0dYYWxWUGs5WnBEVlgvTFdZ?=
 =?utf-8?Q?Q+WB1ZVZLJdMDhM8OrPhcMoiT3Cwgt/l2PQmE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHpVd0dhUTdFVU9YMElmaUdwN21VSTRtUTJWTDY3S2NQbFcyMjRrZW14VXMy?=
 =?utf-8?B?SVgvN1dBcVcySzJpT0pvVDl0dUtPVG1WRHlhS1NCSlh0UkZ2TFRQMko1V2xr?=
 =?utf-8?B?UUUwQ2N3dkllcThDMW03am5aWEtJZTMzbWxUdjRyZTVOUzdaTnRYTEZsVGxU?=
 =?utf-8?B?QS9RY2tLZFU1MCszdno2RzBZT3ZBeS9oSEE5bHYzRlVoVkJ2WU1YVW1ZVHlC?=
 =?utf-8?B?Y2N5aEdwQWg5dTFUbS9IUlJNVUNNeWhVOEpkdzBBNURxMmRMcnlBMVlNc3ZR?=
 =?utf-8?B?cVlxdVN4eTlCa0w0ZWVHV2hPZnZ2WlE0d1lGbExQa29hU056SzdDWFVFeGQw?=
 =?utf-8?B?eU93TFdwd3gzeVpGb21IZVFlSkErZmRobmc2TGVycElYOUxEMmlUZ1lKMDZi?=
 =?utf-8?B?Y2JrTzJUamx3NDQ2dm1Ed3hRVlcrM3J1emRTeVN2YWl2MWduZ1FZS1pKbmhu?=
 =?utf-8?B?NjY1ZWtwRHJrV2RZQ3g4dFh1aWU0TzRENFgraTd4VmowSUN5SGkvK3p6TTMv?=
 =?utf-8?B?eC9iY0oyT21MTENhWitwaWJFRXREY3NwVGZzakFqZ3pVS3V1T3VTM2Z0ejZh?=
 =?utf-8?B?WTVHR3dxQnBXN2tMSFZDeElYRkJ4WlNEQjhHTngrUE1ZeE9IWmdtSW1rOUtG?=
 =?utf-8?B?TUg5UTFmS2Jlem9nM2xTY2hOc01BZDFvWWx5QklZZGI0blNWcHdxMEhIVmhZ?=
 =?utf-8?B?UHpaMmsxdkVYWmxLd0JYV1RiM2RYR211bGVyMTFyYnF5ZUF6Y3NOVlUwY3Jj?=
 =?utf-8?B?SStjYlJCcVFTZk1nRklLdStlUHh2Vy9HMU41SWtrUnZIdkpsTUl0djNFcHFX?=
 =?utf-8?B?YnVXSUxiRDhVN3hZS1FMcXpRdnZoREZxZG9tcDB6R2M5Z3dKZjZPWHVCVUpx?=
 =?utf-8?B?a2dpakFyTFl3dkVTdlNTZm9RVzNwT09xM3htT1gya1gyRmpwNlBhY0JnTENl?=
 =?utf-8?B?VmZCUHNGMUxRZ3lIWis3ZEY1M1NOUDV1RlFzT3lXYkcyVVVqdlppbGNmMmsw?=
 =?utf-8?B?NUU1M2pPWnBBdlFvNlZ0TGp2U0ZOSTExK0RVNUJXd1BrUkVuK0lHRkFITEV4?=
 =?utf-8?B?N3VKYWlzeEFDZXM4RTRPU1R6djNVN0pmVllMR0R3T0RXUFVjbmd4aWx4d3Vn?=
 =?utf-8?B?VnJlWk96N3dHVWErVktkZGJJb2RramMyWSt6V2JLbnZiYW5wK0llV3JLNnFU?=
 =?utf-8?B?MWp0NUdPS0d5dHBGWTNiUVFFYnY1dmlRcU55WThTalZPd3haaUlwd1NhVlR5?=
 =?utf-8?B?Tkphbjd2NlRBK1F3VmpReEc2TGxUOGI4akZ6UmJlV2JFL0Q0My9ONXorRkE2?=
 =?utf-8?B?Y0R1NlN0cU5FZjQ5Q2ZEZk5KK3RlYjNKeWZFV2lRdngwR1NtYUY1RVVLcDli?=
 =?utf-8?B?cDZ6N1luVm8rMDk2UVJtY3ZkOVUxMyt3YnFsRGFsUDN3T0VZTTd2SjNRcmo4?=
 =?utf-8?B?VWJzaGtGUW5COGdNU0tQQmxiTE9DaHo0anNJL1lGYXpDbm1nR2l3TGhjekR0?=
 =?utf-8?B?amxHMDFVbC9vYU9hMnlyK2lSUFNpM3NLc3JBQUwxY0IxbklyQkd0ZmxuZVJV?=
 =?utf-8?B?bXJyUzY3WndKRWFjeWFaQzNOamR1VlN3ZldhVHM5NndCZWVnbEl2SkR3RkVI?=
 =?utf-8?B?WDJOV2JBYlZPWUJOR05HVjZQdlR4czFGNkF0Z2ZIVm9EbmtIay82bVlNSVU5?=
 =?utf-8?B?a3ZKVThvSkV6KytyUVZaZ0FFcmJjTEFlaDdiNzBxOXo0OVBhVDI0bUQ3ajRl?=
 =?utf-8?B?WG1YcEg0ZTdDSFhVejk3NUdpSW0wMUVUY0p5N2lGZ3ZlYnd1UVc1TkgycWNI?=
 =?utf-8?B?S3MvVVFhRXVzRVN0VEI1MlRYWVZJcVkzbXNST3N6Um9Pc1FIQlNvcUF2dHcr?=
 =?utf-8?B?R0pNOFZSb0cwVUw0dDROZHFMTWk5V0pIcGRzU2NhUFpKTnF2RzNPenk4MHBC?=
 =?utf-8?B?VHZ2UVczbUh5VWNBOW5kZURFaDM0MVRVOUVBUkhoV0NWQkNkaUcyUEVTK1VC?=
 =?utf-8?B?Wkd6TW4rbXJZNTV2M2VhLzhKUmluYUJmcE05MTgxQlVGWlJ4UkRmZytKOUR1?=
 =?utf-8?B?YnF0S2FJY3JDaUJQMW5nZTBhd1o3ZWdwZ1ZSZXJicWJLWnN3VnkwSnJSRXlD?=
 =?utf-8?Q?X3Bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71262B388FA3649A6ECB75E62DB9E60@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce23ea-f72b-4bdf-4c93-08dcef2d9c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 04:30:35.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrGiygOONiohL663PoCKK0nV1v3ZVSlGPzhcpUNG9/WnrlFXPmLjKK/UIdLba8/OA6slJ2lYdsOYe2FWErv2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6359

PiBAQCAtNzg5LDcgKzc5OCwxNiBAQCBzdGF0aWMgaW50IHpfZXJvZnNfcGNsdXN0ZXJfYmVnaW4o
c3RydWN0IHpfZXJvZnNfZGVjb21wcmVzc19mcm9udGVuZCAqZmUpDQo+ICAgCURCR19CVUdPTihm
ZS0+b3duZWRfaGVhZCA9PSBaX0VST0ZTX1BDTFVTVEVSX05JTCk7DQo+ICAgDQo+ICAgCWlmICgh
KG1hcC0+bV9mbGFncyAmIEVST0ZTX01BUF9NRVRBKSkgew0KPiAtCQlncnAgPSBlcm9mc19maW5k
X3dvcmtncm91cChzYiwgYmxrbnIpOw0KPiArCQl3aGlsZSAoMSkgew0KPiArCQkJcmN1X3JlYWRf
bG9jaygpOw0KPiArCQkJZ3JwID0geGFfbG9hZCgmRVJPRlNfU0Ioc2IpLT5tYW5hZ2VkX3BzbG90
cywgYmxrbnIpOw0KPiArCQkJaWYgKGVyb2ZzX3dvcmtncm91cF9nZXQoZ3JwKSkgew0KSSBndWVz
cyBoZXJlIHNob3VsZCBiZSBtb2RpZmllZCBhcyBiZWxvdywgcGxlYXNlIHJlZmVyIHRvIA0KZXJv
ZnNfZmluZF93b3JrZ3JvdXAoKS4NCg0KCQkJaWYgKGdycCAmJiBlcm9mc193b3JrZ3JvdXBfZ2V0
KGdycCkpIHsNCg0KPiArCQkJCURCR19CVUdPTihibGtuciAhPSBncnAtPmluZGV4KTsNCj4gKwkJ
CQlyY3VfcmVhZF91bmxvY2soKTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCX0NCj4gKwkJCXJjdV9y
ZWFkX3VubG9jaygpOw0KPiArCQl9DQo+ICAgCX0gZWxzZSBpZiAoKG1hcC0+bV9wYSAmIH5QQUdF
X01BU0spICsgbWFwLT5tX3BsZW4gPiBQQUdFX1NJWkUpIHsNCj4gICAJCURCR19CVUdPTigxKTsN
Cj4gICAJCXJldHVybiAtRUZTQ09SUlVQVEVEOw0KPiBkaWZmIC0tZ2l0IGEvZnMvZXJvZnMvenV0
aWwuYyBiL2ZzL2Vyb2ZzL3p1dGlsLmMNCj4gaW5kZXggMzdhZmUyMDI0ODQwLi4yMThiMDI0OWE0
ODIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2Vyb2ZzL3p1dGlsLmMNCj4gKysrIGIvZnMvZXJvZnMvenV0
aWwuYw0KPiBAQCAtMjE0LDcgKzIxNCw3IEBAIHZvaWQgZXJvZnNfcmVsZWFzZV9wYWdlcyhzdHJ1
Y3QgcGFnZSAqKnBhZ2Vwb29sKQ0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGJvb2wg
ZXJvZnNfd29ya2dyb3VwX2dldChzdHJ1Y3QgZXJvZnNfd29ya2dyb3VwICpncnApDQo+ICtib29s
IGVyb2ZzX3dvcmtncm91cF9nZXQoc3RydWN0IGVyb2ZzX3dvcmtncm91cCAqZ3JwKQ0KPiAgIHsN
Cj4gICAJaWYgKGxvY2tyZWZfZ2V0X25vdF96ZXJvKCZncnAtPmxvY2tyZWYpKQ0KPiAgIAkJcmV0
dXJuIHRydWU7DQo+IEBAIC0yMzEsNTQgKzIzMSw2IEBAIHN0YXRpYyBib29sIGVyb2ZzX3dvcmtn
cm91cF9nZXQoc3RydWN0IGVyb2ZzX3dvcmtncm91cCAqZ3JwKQ0KPiAgIAlyZXR1cm4gdHJ1ZTsN
Cj4gICB9DQo+ICAgDQo+IC1zdHJ1Y3QgZXJvZnNfd29ya2dyb3VwICplcm9mc19maW5kX3dvcmtn
cm91cChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiAtCQkJCQkgICAgIHBnb2ZmX3QgaW5kZXgp
DQo+IC17DQo+IC0Jc3RydWN0IGVyb2ZzX3NiX2luZm8gKnNiaSA9IEVST0ZTX1NCKHNiKTsNCj4g
LQlzdHJ1Y3QgZXJvZnNfd29ya2dyb3VwICpncnA7DQo+IC0NCj4gLXJlcGVhdDoNCj4gLQlyY3Vf
cmVhZF9sb2NrKCk7DQo+IC0JZ3JwID0geGFfbG9hZCgmc2JpLT5tYW5hZ2VkX3BzbG90cywgaW5k
ZXgpOw0KPiAtCWlmIChncnApIHsNClBsZWFzZSByZWZlciB0byB0aGlzIGxvZ2ljLg0KPiAtCQlp
ZiAoIWVyb2ZzX3dvcmtncm91cF9nZXQoZ3JwKSkgew0KPiAtCQkJLyogcHJlZmVyIHRvIHJlbGF4
IHJjdSByZWFkIHNpZGUgKi8NCj4gLQkJCXJjdV9yZWFkX3VubG9jaygpOw0KPiAtCQkJZ290byBy
ZXBlYXQ7DQo+IC0JCX0NCj4gLQ0KPiAtCQlEQkdfQlVHT04oaW5kZXggIT0gZ3JwLT5pbmRleCk7
DQo+IC0JfQ0KPiAtCXJjdV9yZWFkX3VubG9jaygpOw0KPiAtCXJldHVybiBncnA7DQo+IC19DQoN
ClRoYW5rcywNCg0KQ2h1bmhhaQ0KDQo=

