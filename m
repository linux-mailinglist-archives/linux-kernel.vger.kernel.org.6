Return-Path: <linux-kernel+bounces-391978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD39B8E20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5F41C20F98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B4158870;
	Fri,  1 Nov 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="kGglw/09"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011020.outbound.protection.outlook.com [52.101.125.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392442C0B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454500; cv=fail; b=gfFvc3XQfmgqpHtHZzZQlxGAQBQSNFOvrcaXzKA6EcBGWk8JxoCClhYjyRCq2hK1nud5m55yGYe63crD3qedEXyipkW8Dyvv3mt4AW3Loe6wdLupp4xNhrwKCmax73wA0JpSyUbUifEBG1mD68Zid/JrM2wMEmwbcD9+djKOJe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454500; c=relaxed/simple;
	bh=BLbMXaetK9udBApF+ia6KZLxS3baFNrtInwnJvEDNuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvBq2BY93sL9pKbcWV5PBaBnaiZfqrDCoUC6RvF4anHM3K6BfFJ9vLhfKiKHoKb+CJl1pXSFdBNgS7Vk59VkyKyasAxFrfRqcEi+1OHHcQG4hBwtQUmFvOL8V0BhpY8iuwDt1xK/BZHOkdnP23VRUGDgeB4P4BfXhmOISaqm9rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=kGglw/09; arc=fail smtp.client-ip=52.101.125.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKVXBlCc2tiuZ5j9BLosr2r4qdUyuq9cMREoXirhuH/DHHftzkCIyPryx+LPaeCbRpAxBEGe/GRTcTBzOma0XuALw5uAl4WAWA2Bg4I7zq3M/bRU+cMsb9vkmXlVaJSZ2oh+fDm/RsnDlHe4/QGe60Kd2uYA0LjZDK/EyaBsFPWbY7FdEp8Zki8pMWNP+wQFx8KEjUv+5vv9b3lLvoQnp5bLgA5s8AhQymcIAJkAykbWA4G9gxVNqkyW8dzjXXqDNZKQukD7bL0EwfABK+y66y+lvBOGpRgYsTTcWhHbKSDeP25i3kZuLTxWSM9OWSi4t6IYWssAr33jJ60mrFO88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLbMXaetK9udBApF+ia6KZLxS3baFNrtInwnJvEDNuY=;
 b=UjUtRMDsc2Gj9kzUCvknCm8sBsSHsNwx026oFYhMaJaHMBGtFbR5CkCrCekwrTVEVPUnkbGqfmfEk41nKh4/rPL/33fBNadAss9rQ/4ZDCWbfokJDcWn082hld6tFuGSrFZ9ju3BhaeqYBmX7Mzs5ozpBlFvWVl/PIa1ibqM1X7I8SJ6K88xe5Zg9l5uni6T1nVGZNBRRfujHDbNXQLiKdFTSwKcZKpEQOW6ENOBQYnWnkqxV+GHip4KByy6zB1jHaVc2GNbzi4xVDsosK6p2JB15XH0cDe/fpQH+81tifAiyKYTk+f6d+MJ/w5b/HKBDJ0cOwI9b5Zo0NO9KboBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLbMXaetK9udBApF+ia6KZLxS3baFNrtInwnJvEDNuY=;
 b=kGglw/09A0YtVIcPJ4wdIJxkubwGROqswu7SjZmgywXLFpKORxkDHnk9KJi1Kx4Ompl3zQuUaSRuSaQgw/bsSP+8/hEu9QexbnCi5J6qSfKUEPpS7GfeaEKtSYq8wV2wvkUVhsHeMFnVtXmyXlVnWYkb6YEZhAu9JssacLxFBzg=
Received: from TY3PR01MB12089.jpnprd01.prod.outlook.com (2603:1096:400:3cf::5)
 by TYCPR01MB10477.jpnprd01.prod.outlook.com (2603:1096:400:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 09:48:11 +0000
Received: from TY3PR01MB12089.jpnprd01.prod.outlook.com
 ([fe80::2ac2:8829:306b:5772]) by TY3PR01MB12089.jpnprd01.prod.outlook.com
 ([fe80::2ac2:8829:306b:5772%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 09:48:04 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"anupnewsmail@gmail.com" <anupnewsmail@gmail.com>
Subject: RE: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched
 datatype
Thread-Topic: [PATCH-next] irqchip/renesas-rzv2h: Fix potentially mismatched
 datatype
Thread-Index: AQHbK8wpiz3qiGhsfEi/WjWXA/uxibKhXv4AgACchwCAADDbQA==
Date: Fri, 1 Nov 2024 09:48:04 +0000
Message-ID:
 <TY3PR01MB120896A09E7CF11D55164527BC2562@TY3PR01MB12089.jpnprd01.prod.outlook.com>
References: <20241031193606.87970-1-advaitdhamorikar@gmail.com>
 <87r07wufs7.ffs@tglx>
 <CAJ7bepLOJZLwgm6f+RU=-xb0qPim-7VBi+062EJC5yT5_BmmpA@mail.gmail.com>
In-Reply-To:
 <CAJ7bepLOJZLwgm6f+RU=-xb0qPim-7VBi+062EJC5yT5_BmmpA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12089:EE_|TYCPR01MB10477:EE_
x-ms-office365-filtering-correlation-id: 6e96511a-645a-4186-dab7-08dcfa5a4847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWZ6SERQUEtOSytESHBGTG13L29uV1NZRnoxb29OT0w2WENOS3pKamhpVlU0?=
 =?utf-8?B?ZFIwUmRDcitkOUdaODB6K2oreFlFN1dlTXIwNndRSmY2bHZaUDdINFFvaFIy?=
 =?utf-8?B?bXBlcHlmWDl3c3MydFkyVUsxNXpSY2I2K0FVaC83RC9YWUhPZ3crR2NVSGp2?=
 =?utf-8?B?SUIzZEpZalp0dWppTnYzaklrTjZOMmYwRWpHK0thaTZ5OG5hUFdYMjJtRUcy?=
 =?utf-8?B?dy9FdEFVZzdKcVFzZlM3dTZWN2pCczlJblV6aUdaVWVzNG1OcERZdWpiTjRD?=
 =?utf-8?B?R2dHbWJJSjR6b3IxWmVhTlNScTlzNG4zcWhGa1VXY1BqQzJSMzVITTJLaksw?=
 =?utf-8?B?RURwR2FMZnBSZGJpdFBkWUw3OXhPSlNxakF0WFhrUFd0TkhUR0FCdTNvTXM0?=
 =?utf-8?B?SjlEYkFTMmEvUm5DMnlRRlcwSEJVL1ZDTG5CTit3SGNlS2JvbTQwZjJoTGFS?=
 =?utf-8?B?QzJsTi9aWVZOU2FtVGNwYVlZZ0dzT1R1ZDZxN1Z3aExVakNsYXBJMWJqdWZH?=
 =?utf-8?B?N3BvUGFxRzVxUE53ajlKc0hBMGl4Z0xydWR2Ukk0dXN2VzlCYUV6TUZvTE5w?=
 =?utf-8?B?bDM1dWY5OUwwaEVQaXBSZ1FVamQvRTF1WFJqMUlXSU9DQVBLdXhueEUzKzNw?=
 =?utf-8?B?dEQvU0ZDRk92UC9WTWV0VTMwRHVBS3A2Zi92d1I0d081OWp0WGVzY1hOeGRt?=
 =?utf-8?B?UVBYYXZTaUErMDJENFBPK3lwZG4zcjB6eTY2RFFhQkpYTTFkaXVHb1BxbUFr?=
 =?utf-8?B?ZzJCM0xoTlhQcVlFTEdLK01jVzdZV1JkRTVRckVFOFNpQWl5dmRIcWUxY1ZZ?=
 =?utf-8?B?Y0JsVUFDOEl0OHJaeHQ4Nk9KVVF3T1V5NGNhc0xtcVRLUVkyVmZ5eW1xeEYx?=
 =?utf-8?B?OWpnRjFLNlg5NHhnSEJJQXhvTjVycnMrZnF4VGc1VGxzUEVhVlplcS92MWIv?=
 =?utf-8?B?dDJQNGtBL21ZdDU4OUQwdTZNZjRweEx3NmJTdDBOZDdsb3NXWVZMWEk2bllh?=
 =?utf-8?B?SjNMaXdpbDVQeEZrOWlvUGJoMFlqNVdOdmVzSjgzeVN6Y1Fpdlp1RDY2cklo?=
 =?utf-8?B?UHRnSFV2TmorUkR2MFU3cE5KelJMWUV6MDFLRm9zVkRVVjNnVmVBeW9FOXFN?=
 =?utf-8?B?Q2htbVdlbU1MSlAxN2xXWTZqcG1JOU1yYXRxTStaWThvVFJqQ0NnRmdKTk5T?=
 =?utf-8?B?Sm91eHJTTEZEc3hvNGJTTjVMRmw0Wk5mRUFNbjZrYVJwRnN3TFZmQVBZdFo2?=
 =?utf-8?B?MzJiTHZML3VXZGQ4Z2JlZnhRQnFMYXhoTWRNemo0QTQ2ajg2Y0pycWppMW1v?=
 =?utf-8?B?bGJWT1lZWjZhbG5XWEZsTm55UFIxUjN2Y3R3enRZKzlhV0JQTGNiMFhzTlJ3?=
 =?utf-8?B?STd1elQzREJiSW1HekxjZHUzN0x4RFE4c2gxYWlrOVY4NXpyQ2pxZjlHbHpq?=
 =?utf-8?B?VVVPdzkxWHdwWCtvb3paMFkydjFadG1YMWl5bGJObk1PSG1PSEppTFF4ckJz?=
 =?utf-8?B?ZEI4T2NRY28wYVUwVXRzNndaUTNsbmlxUmI4RDNPUlhWbU5sNTN6WVAvT09h?=
 =?utf-8?B?WW1Ub3hKZTdiL0daM3NPbVJTTFl3TnFVWU11dHVrMDlnUkVYU2p0V01WZEVH?=
 =?utf-8?B?RXNBU3Y4QVk1em9zbXlFcThObXFyUVJhalhHbHdpa3ZPRHdySEsrQUJ6UC9W?=
 =?utf-8?B?Ym50WHh5ZWFVVnBlZWtiN0U3dFBFOTdYbkk5Yk8zbW44TzgrZFNHQXFxMUxK?=
 =?utf-8?B?clRtRFNyWkZyeVN1dnlxdk9NQWpQS3Q5d0NHQ05FT2RrSXNYMjRZcFNyanhl?=
 =?utf-8?Q?HKGKVGG4+S2Qya7NpiBWXedyL7FckoacjN49k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB12089.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWo4d1AxZzRYZzZjTXczTkRZV3RNckVBRm1wTGRybEozb01NSDliYjYwQ01r?=
 =?utf-8?B?WE5KL3kva0J3enFpejRNRzNMb2xLTmEwYWdlRXIrQWlrdTg0YkRRUUZrS3Bl?=
 =?utf-8?B?NE9KczF2dEpDd2ZJdTFHUW1mdG1JWk1vN0dldUNuZnZpK3lyRm4yZG5kZ1Y3?=
 =?utf-8?B?VEU3RjRweUZPSDFjVzI4d1l6OTg0OXhBYUdIU1pKMTJJbWEvSC9EQnc1dlZl?=
 =?utf-8?B?R1FjanA0UDFTWUZRYTdCUW9hWDdzM2lHL2JzTHArVEtWNlp2L0hCUFA2Z3Zn?=
 =?utf-8?B?bHA4ODlxaC9VL2FXRTNzb0VlUmwyeVBJWmhISk14MnZjcklVa2FCT1I4aVZT?=
 =?utf-8?B?Sk82akQ3ZkQwcmtRcm1HTWpFaW5hOXF4LzZ0b0xia0ZzbXRQRVRoYUJ2djVM?=
 =?utf-8?B?bWg5K3kwbmpLOVlFNFpmRldUN0FEZ0JPWGE4NkMyOHJMSTk3cG1WRmh2cUYw?=
 =?utf-8?B?Zmo3d1RpRGVxZFBPNUZJMEdGNVhvL2xybUl4d0JWbXVYajNZVThVNEVyMXhQ?=
 =?utf-8?B?dFIvSGFhVHlOenkzdmhqa04wMXJJaXlJRDdpaFRaYVpqWDQ3R1ZXYUNhNXBI?=
 =?utf-8?B?M1R5K0RyZFNhb1pERkhuZ2duYjhSSXlLSmJ5d0d3RE4vOWFyMTh2dXY2QVdF?=
 =?utf-8?B?TytxS3BZQ2hmdWNzTWNicGVJNnN2b2RRVTY1SzE0QS9JNzJOTUpNZ0RuVWFU?=
 =?utf-8?B?ekdtU0JtNnVtTGFSU3VkNTlXZCtNcjJucHl3TENmQjgvOWZZNUdhOXdjNDFJ?=
 =?utf-8?B?c2cvNmRWOW1OaWhhZE43TUVSN3dDYXUycU1jUUJ5SjZmcUFDcm1GSkVlTlgx?=
 =?utf-8?B?cXcrQzAydkJTMkF5cWl5MGtxL0Y4SDRlZEhZRmRHT3pjd0IvVzVPZzZYNFdk?=
 =?utf-8?B?VnhUN2dCVCtucTZ6Qk5tTlR5bTRWd1M0cHdGbWRjLzJtMGZXN1NzRVk2S2kv?=
 =?utf-8?B?YlRyYk52N3A0VFo3R3YvN0FxUi9KdjRsNEpPUlUrQXdvcmVvdVhpVWlzeGNG?=
 =?utf-8?B?M0NWZXpjT0N2N3NaRFk4RDhuL3E3Ync4UyszS1MxbExNdUVUWVFTTVYwaXdW?=
 =?utf-8?B?NkYrdUoyOFpUQzU2Z1dLK2lXOWNKSGFjUGplUy9XQit1aURXMzRrSDZoQjJF?=
 =?utf-8?B?SzdqSVdNOWdUWlZDR1o0WEIxTWNxNnZKUUhuNlBmMFFWZ2c4bkhHeTNyUndp?=
 =?utf-8?B?Y3ZseC9mTVNVRWU0S09sbXlhYUtFc1dzMFRETkV5L21qSVJCazFlMHhqNWNp?=
 =?utf-8?B?UjBKTjBOQWY4RlROVm9maUtUclA1bHJpMVNhaEpNeWpXaFZteS84SmZpTHRR?=
 =?utf-8?B?eWpsSng1ODQ1SDdwVnNSK0JxcGJ6OEExa3lHRFFzK0MzUmRPRHl5SXJtaGp3?=
 =?utf-8?B?ZEsyWGN0RTlWZGVpR09UQmpNMkhUT1B0SjR2ZFYxZnZOcmk4TVA3MzBNRDd4?=
 =?utf-8?B?NkphSXYwcTJPT0s3a2NMWHhnUkZvU0w1Qmd4OVF6NVE4TmJ6SmxXcEMxMGdD?=
 =?utf-8?B?SkxrRVU2dHhUbWVZak1VK1Q3UlpiZUR2MUpYY20ycmVWTkp3aGVBbW41Q3pT?=
 =?utf-8?B?VWQ2K1ZRRzZrNUZFOEJzclhOSTdDY3N5bERGeGcrOWxhQ3djOEplWmtzMW12?=
 =?utf-8?B?dUw0RjFoZGxsa2g5dk1jOXMyYW5jMFErREJkd3hDR2s4cjdGNzZSMjYwWlJs?=
 =?utf-8?B?UGtGS25jdnlqWG1tV3VCUGcxZ2J3QzhWNTQ1N2ZQSElUOWh4Z2ZmVWFVVytr?=
 =?utf-8?B?dnVkeFpCN3pkQU5MU1ltMGpONXZLbkZDL20ydTdOUldoR2RGdnBuNlViOWsx?=
 =?utf-8?B?MXZ4K1oybUtFSHdBSit0OVMyMzRTWmZjK1RmTXJJYlNrdFlQU2l3V2lYVVVC?=
 =?utf-8?B?eVdWOEw1cjhreVZzeTlPQzMzY0F5bnRRSXVINmtsK0pXR1UzNDJJaWNMeVdN?=
 =?utf-8?B?aHNiZTRkemdhMFRscDFtMnZ4aWwvUmZ3TlhtTHoxNXA2UEdWSHNhVmpoUGE0?=
 =?utf-8?B?V3kvdmhLVXcwVlNUdlRRalBCVzI5SlU5UkN1bjgyNzl2aTJ0SEtiQWcxdnhl?=
 =?utf-8?B?Vk00SVJKbXQxaEFpcHpXRVk3SXZQRXJtWUJ2cERBUExZc1VIc3NrYiszZkFs?=
 =?utf-8?B?S3Z2NFZhMGVNNXlYNVNaYVFuZjRhazJPWHBHYm91Zmswa0tLMnV1SlNQbkJF?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12089.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e96511a-645a-4186-dab7-08dcfa5a4847
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 09:48:04.5836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/jAbKlu5OTT57kUrk+7u+21c4X1y0mVeQsPSVyLPKMsBB6j4SwVv5oIubzg5uOfGiDIv3AZ4XjA5Ixli/EX61xRzd2IyAOZz74ZlS+Kmi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10477

SGVsbG8gQWR2YWl0LA0KDQpUaGFua3MgZm9yIHlvdXIgZW1haWwuDQoNCj4gRnJvbTogQWR2YWl0
IERoYW1vcmlrYXIgPGFkdmFpdGRoYW1vcmlrYXJAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENILW5leHRdIGlycWNoaXAvcmVuZXNhcy1yenYyaDogRml4IHBvdGVudGlhbGx5IG1pc21h
dGNoZWQgZGF0YXR5cGUNCj4gDQo+IEhlbGxvIFRob21hcywNCj4gDQo+ID4gYW5kIHJlYWQgdGhy
b3VnaCB0aGUgbWF0Y2hpbmcgZG9jdW1lbnRhdGlvbi4NCj4gTXkgYmFkLCBJIHdpbGwgYmUgbW9y
ZSBpbXBlcmF0aXZlIG5leHQgdGltZSA6KQ0KPiANCj4gPiBJbiBmYWN0IHRoZXJlIGlzIG5vIHBy
b2JsZW0gd2l0aCB0aGUgZXhpc3RpbmcgY29kZSBiZWNhdXNlIHRoZSBoYXJkd2FyZQ0KPiA+IGlu
dGVycnVwdCBudW1iZXIgcmFuZ2UgZm9yIHRoaXMgaW50ZXJydXB0IGNoaXAgaXMgZ3VhcmFudGVl
ZCB0byBiZQ0KPiA+IHNtYWxsZXIgdGhhbiBVSU5UX01BWC4gSU9XLCBhIHRydW5jYXRpb24gZnJv
bSB1bnNpZ25lZCBsb25nIHRvIHVuc2lnbmVkDQo+ID4gaW50IChvbiBhIDY0LWJpdCBzeXN0ZW0p
IGRvZXMgbm90IG1hdHRlciBhdCBhbGwuDQo+IEkgZGlkIG5vdCBrbm93IGFib3V0IHRoZSBpbnRl
cnJ1cHQgcmFuZ2Ugb2YgdGhlIGNoaXAsIHNvIEkNCj4gYXNzdW1lZCB0aGUgdHJ1bmNhdGlvbiBm
cm9tIDggYnl0ZXMgdG8gNCBtaWdodCBwb3NlIGEgcHJvYmxlbS4NCj4gDQo+ID5JZiBhdCBhbGws
IHRoZW4gdGhlIHByb3BlciBjaGFuZ2UgaXMgZWl0aGVyDQo+ID4xKSB0byBtYWtlIHRoZSByZWxh
dGVkIHZhcmlhYmxlcyB0eXBlIGlycV9od19udW1iZXJfdA0KPiBUaGlzIHNlZW1zIGxpa2UgdGhl
IGJldHRlciBvcHRpb24gdG8gbWUuIElmIGl0IGlzIG5lZWRlZCwNCj4gSSB3aWxsIHN1Ym1pdCBh
IHBhdGNoIHYyIGFmdGVyIHdhaXRpbmcgZm9yIHNvbWUgbW9yZSBmZWVkYmFjaywgaWYgdGhlcmUn
cyBhbnkuDQo+IA0KPiBJIGhhdmUgb25lIHF1ZXN0aW9uLCBzdGF0aWMgYW5hbHl6ZXJzIHJlcG9y
dCBhbiBpc3N1ZSBvZiBhIGJhZCBiaXQNCj4gc2hpZnQgb3BlcmF0aW9uDQo+IG9uIGxpbmUgMzA3
OiB0aWVuID0gSUNVX1RTU1JfVElFTih0aXRzZWxfbik7DQo+ICNkZWZpbmUgSUNVX1RTU1JfVElF
TihuKSAoQklUKDcpIDw8ICgobikgKiA4KSkNCg0KV2hpY2ggc3RhdGljIGFuYWx5emVycyBkaWQg
eW91IHVzZT8NCg0KPiANCj4gRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCBod2lycSBjYW4gcG9zc2li
bHkgaGF2ZSB2YWx1ZXMgZnJvbSAwIHRvIDMxDQo+IElmIHRpdHNlbF9uIGVuZHMgdXAgYmVpbmcg
YSBsYXJnZSByZW1haW5kZXIgc2F5IDUsIHdlIGNhbiBoYXZlIGEgYmFkDQo+IGJpdHNoaWZ0IG9w
ZXJhdGlvbg0KPiBleGNlZWRpbmcgNjQgYml0cy4NCg0KSW4gdGhpcyBjYXNlIGl0J3Mgbm90IGEg
YmFkIGJpdCBzaGlmdCBvcGVyYXRpb24uIFRoZSBjb2RlIG5ldmVyIHBhc3NlcyBhIHBhcmFtZXRl
ciB0aGF0IG1ha2VzIGl0IGV4Y2VlZCB0aGUgNjQgYml0IGJvdW5kYXJ5Lg0KDQpUaGVyZSBpcyBu
b3RoaW5nIHRvIGZpeCBpbiB0aGlzIGNhc2UuDQoNClJlbWVtYmVyIHRoYXQgYW5hbHlzZXJzIGFy
ZSBub3QgYWx3YXlzIHJpZ2h0LCB5b3Ugc3RpbGwgbmVlZCB0byByZWFkIGFuZCB1bmRlcnN0YW5k
IHRoZSBjb2RlLg0KDQpLaW5kIHJlZ2FyZHMsDQpGYWINCg0KPiBNeSBodW1ibGUgYXBvbG9naWVz
IGlmIG15IG9ic2VydmF0aW9ucyBhcmUgY29tcGxldGVseSBvZmYsIEknbSBhDQo+IGJlZ2lubmVy
IHRyeWluZyB0byBsZWFybg0KPiBMaW51eCBkcml2ZXIgZGV2IGJ5IGxvb2tpbmcgYXQgaG93IG90
aGVyIGRyaXZlcnMgd29yay4NCj4gSWYgdGhpcyBpcyBhbiBpc3N1ZSB3aGF0IGNvdWxkIGJlIGEg
cG9zc2libGUgbWV0aG9kIHRvIGZpeCB0aGlzPw0KPiBJIHdvdWxkIGJlIGdyYXRlZnVsIGlmIHlv
dSBvciBzb21lb25lIGNvdWxkIHBvaW50IG1lIHRvIHNvbWUgcmVsZXZhbnQgZG9jcy4NCj4gDQo+
IFRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBmZWVkYmFjaywNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gQWR2YWl0DQo+IA0KPiBPbiBGcmksIDEgTm92IDIwMjQgYXQgMDI6NTQsIFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgTm92
IDAxIDIwMjQgYXQgMDE6MDYsIEFkdmFpdCBEaGFtb3Jpa2FyIHdyb3RlOg0KPiA+ID4gVGhpcyBw
YXRjaCB1cGRhdGVzIHRoZSB0eXBlIG9mIGh3X2lycSB0byB1bnNpZ25lZCBsb25nIHRvDQo+ID4N
Cj4gPiBQbGVhc2UgZG86DQo+ID4NCj4gPiBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRh
dGlvbi9wcm9jZXNzLw0KPiA+DQo+ID4gYW5kIHJlYWQgdGhyb3VnaCB0aGUgbWF0Y2hpbmcgZG9j
dW1lbnRhdGlvbi4NCj4gPg0KPiA+ID4gbWF0Y2ggaXJxX2h3X251bWJlcl90Lg0KPiA+ID4NCj4g
PiA+IFRoZSB2YXJpYWJsZSBod19pcnEgaXMgZGVmaW5lZCBhcyB1bnNpZ25lZCBpbnQgYXQgcGxh
Y2VzLA0KPiA+ID4gSG93ZXZlciB3aGVuIGl0IGlzIGluaXRpYWxpemVkIHVzaW5nIGlycWRfdG9f
aHdpcnEoKSwgaXQgcmV0dXJucw0KPiA+ID4gYW4gaXJxX2h3X251bWJlcl90LCB3aGljaCBpbnR1
cm4gaXMgYSB0eXBlZGVmIGZvciB1bnNpZ25lZCBsb25nLg0KPiA+DQo+ID4gV2Uga25vdyB0aGF0
LCBidXQgd2hhdCBpcyB0aGUgcHJvYmxlbSB0aGlzIHBhdGNoIGlzIGFjdHVhbGx5IHNvbHZpbmc/
DQo+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCByenYyaF9pY3VfZW9pKHN0cnVjdCBpcnFfZGF0YSAq
ZCkNCj4gPiA+ICB7DQo+ID4gPiAgICAgICBzdHJ1Y3Qgcnp2MmhfaWN1X3ByaXYgKnByaXYgPSBp
cnFfZGF0YV90b19wcml2KGQpOw0KPiA+ID4gLSAgICAgdW5zaWduZWQgaW50IGh3X2lycSA9IGly
cWRfdG9faHdpcnEoZCk7DQo+ID4gPiArICAgICB1bnNpZ25lZCBsb25nIGh3X2lycSA9IGlycWRf
dG9faHdpcnEoZCk7DQo+ID4gPiAgICAgICB1bnNpZ25lZCBpbnQgdGludGlycV9ucjsNCj4gPg0K
PiA+IEl0IG1vdmVzIHRoZSB0eXBlIG1pc21hdGNoIGFuZCBwb3RlbnRpYWwgdHJ1bmNhdGlvbiBh
IGZldyBsaW5lcyBmdXJ0aGVyDQo+ID4gZG93bjoNCj4gPg0KPiA+ICAgICAgICAgdGludGlycV9u
ciA9IGh3X2lycSAtIElDVV9USU5UX1NUQVJUOw0KPiA+DQo+ID4gSW4gZmFjdCB0aGVyZSBpcyBu
byBwcm9ibGVtIHdpdGggdGhlIGV4aXN0aW5nIGNvZGUgYmVjYXVzZSB0aGUgaGFyZHdhcmUNCj4g
PiBpbnRlcnJ1cHQgbnVtYmVyIHJhbmdlIGZvciB0aGlzIGludGVycnVwdCBjaGlwIGlzIGd1YXJh
bnRlZWQgdG8gYmUNCj4gPiBzbWFsbGVyIHRoYW4gVUlOVF9NQVguIElPVywgYSB0cnVuY2F0aW9u
IGZyb20gdW5zaWduZWQgbG9uZyB0byB1bnNpZ25lZA0KPiA+IGludCAob24gYSA2NC1iaXQgc3lz
dGVtKSBkb2VzIG5vdCBtYXR0ZXIgYXQgYWxsLg0KPiA+DQo+ID4gSSdtIGFsbCBmb3IgYmVpbmcg
dHlwZSBzYWZlLCBidXQgd2hhdCB5b3UgYXJlIGRvaW5nIGlzIHB1cmVseSBjb3NtZXRpYy4NCj4g
Pg0KPiA+IElmIGF0IGFsbCwgdGhlbiB0aGUgcHJvcGVyIGNoYW5nZSBpcyBlaXRoZXINCj4gPg0K
PiA+ICAxKSB0byBtYWtlIHRoZSByZWxhdGVkIHZhcmlhYmxlcyB0eXBlIGlycV9od19udW1iZXJf
dA0KPiA+DQo+ID4gICAgIFlvdSBjYW5ub3QgbWFrZSBhc3N1bXB0aW9ucyBhYm91dCB0aGUgdHlw
ZSB3aGljaCBpcyBiZWhpbmQNCj4gPiAgICAgaXJxX2h3X251bWJlcl90IHRvZGF5LiBUaGUgdHlw
ZSBjYW4gY2hhbmdlIHRvbW9ycm93LCBubz8NCj4gPg0KPiA+IG9yDQo+ID4NCj4gPiAgMikgVXNl
IGEgcHJvcGVyIHR5cGUgY2FzdCB3aGljaCBkb2N1bWVudHMgdGhhdCB0aGUgdHlwZSBjb252ZXJz
aW9uDQo+ID4gICAgIGluY2x1ZGluZyB0aGUgcG90ZW50aWFsIHRydW5jYXRpb24gaXMgaW50ZW50
aW9uYWwgYW5kIGNvcnJlY3QuDQo+ID4NCj4gPiAgICAgVGhpcyBzaG91bGQgbm90IGJlIGFuIGFj
dHVhbCB0eXBlIGNhc3QsIGJ1dCBhIGhlbHBlciBpbmxpbmUgd2hpY2gNCj4gPiAgICAgaGFzIHRo
ZSBjYXN0IGFuZCBleHBsaWNpdGVseSByZXR1cm5zIGFuIHVuc2lnbmVkIGludC4NCj4gPg0KPiA+
IEkgbGVhdmUgaXQgdG8geW91IHRvIGRlY2lkZSB3aGljaCB2YXJpYW50IGlzIHRoZSBjb3JyZWN0
IG9uZSwgYnV0IEknbQ0KPiA+IGhhcHB5IHRvIGFuc3dlciB5b3VyIHF1ZXN0aW9ucy4NCj4gPg0K
PiA+IFRoYW5rcywNCj4gPg0KPiA+ICAgICAgICAgdGdseA0K

