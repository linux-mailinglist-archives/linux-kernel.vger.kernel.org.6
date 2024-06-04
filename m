Return-Path: <linux-kernel+bounces-201067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB468FB8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C91D1F25E61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948114884D;
	Tue,  4 Jun 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="XucFB5UK"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2090.outbound.protection.outlook.com [40.107.15.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B411487DC;
	Tue,  4 Jun 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518516; cv=fail; b=mqybDre83WO+IXgHcvfHQyI5Jfuv6wWOaGyrrY/E+moDSSTwcT8mlGojQUnQQQznjXq8Ywz1oXSx4evwXXnsoC2XGSNPfNCpk2N5ACoKGFeHJkp3fBNW6fx5mYIATKUIxmsA32VrCmxKVii5ZgV40U5tAYlTIakmyOyIhHqBdwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518516; c=relaxed/simple;
	bh=9DhIrz74syCKJzFGEhWyMISDRKB6o8znZvtpECQd16g=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eOxAciUllDXEgMHH3Qfc70oX2diVFKt4UeLIfXmaDbQtqYQkcumDZJ0+XM4o5kBeV1PQJkInZDO063eZ9Q9XHuBrYOcA6j6/yPWT5YT1lGB+/WsgypufYxLG9XYMIr3zno0dB8464kn0Zgvj8aqs6PivLdpNKCiqqrM9d61Bc+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=XucFB5UK; arc=fail smtp.client-ip=40.107.15.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsI3AQu44fS/WazBS8oZGdP1YRmOJzBK6kjOYB01xKj/f5A9kNC8yUpQzgHPJLivrjaVGELpnQgfjzvocSyCiw3MlBKUntU2zJfk4VeSnya6QSw1WMFyea7+UF3Ib5QvPFysimy5x+X7TmbYlY56fjTaNV9XxmQSarMw8/r3kwF1NNGixVR0+aQEQVNqNlE1RJHhkxmLk+HdWnrxqZVrSytwi9OIIIRy5uIE7Rq50cVFqjZYHWwWLJLS9+MR3Dm0dfPbWhFjcB7y+2iR1vspcam3IIG3sl0p3slgZEY0ZPLgdkGO9EdxSEVcgRbcPnnkFsDVi7SW6chynKM/9Xx7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7oYMz6WD6g6S/qqFRn7epX/ImqkPpsOxm/dj5MNM+o=;
 b=KP4GOXBlhIaXyV9lN/3tTpkZ1Q7NUIoLsE9IMFPMy3HBnWYmoigbl5MavUG/5rOONe/XzjRKpAd0O7xuXl949rrQuaKCq1gIuNqCh8KVz0ZsfZSngjgIk0V87iC/5bvDoUTP0fGHYSZzWgfP1fs4xuWWwai0RCGqWyTjOu/f8wPpHDvbjNuyKEql39Q310M6gkWYmD/uH9l5gA3S3PBCKz8nTooHeXH/sd6P7B+cTFBO1uBbYd27xj2aQQKskemDDUT8dtFsBWghxUMy/XHzaB84K9iu9fh3iXNkikzpJWh40qw1C3V6huferH46SS7yceGdpPmWulFdTZOguFCroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7oYMz6WD6g6S/qqFRn7epX/ImqkPpsOxm/dj5MNM+o=;
 b=XucFB5UKpHw7gWNF7lyvJp+8N3ukOZ9rZkf5ii1mSXepO2bbNie4OzqlKVY4DdKiyFM057YwUXyzqnUOyZZnJQrl3dpg/sm5as7nPl336RTzjvud2AFeHzhAS9VbPljToDy8htn8wR8pylUMKv3MMSNzMgVIFzyi8UKUm026N8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:28:26 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:28:26 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Subject: [PATCH 0/4] Add Mule NVRAM/ROM support
Date: Tue, 04 Jun 2024 18:23:50 +0200
Message-Id: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJY/X2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2ND3byy3NRc3bQUI0ugiLFBSqqpElBtQVFqWmYF2Jzo2NpaAKkKcC5
 XAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, quentin.schulz@cherry.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 63eacf43-59d3-45c1-843d-08dc84b35c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEVDSE5pZmJZemVzaEFEQzloYXR4YUR0NE5uNVNGOFRvYXVUb1Ewc0liNllz?=
 =?utf-8?B?ZTA5Y3M5SEt0Ukp3OUtReU9kRkNRczl1TUZOZ1FmbjlsR2xzcmtSRFVwYzFy?=
 =?utf-8?B?ZU1vQTQ4a3UzVHlEcXRtSlpibkxMZnZNL0ZQUXpseldaWHh2T3ZaL28xQnVM?=
 =?utf-8?B?eEhlSXNDcWlDZEVBYXJRNkU2aG4zTm5PV1VIR1FtWFpHd0c0NFNMaThEOHhv?=
 =?utf-8?B?NDkxaHFSVCtTMElkVGp4RGVaSGlramVRdHR3S1RPUTBnbjZFckxOY1dwYUFY?=
 =?utf-8?B?ai9ZY0VnRUdXOGZ2ZURvTVhic09pZlpydjBieU5MWDk0T0ExTE1FNm41Skt6?=
 =?utf-8?B?c1k3VFk2YWNxZ2V5VE9pcEtRMzNxb0toVlZqb2x4SnlKNnByNXJKMndWNURD?=
 =?utf-8?B?ZnVQTEt0aDVKcDdtckQ0a0JUT0svRGJmK0dTckFEeXB2VERISHpaNjhuMUdI?=
 =?utf-8?B?dFNSV3NUMkZxRERXQVdyYjIyVnF0YnJUQTZKNENzb2hCSW52aDdTSm1Nbk1y?=
 =?utf-8?B?dDNsd1U3OUNnZmtRejU5ams4NSt4blQrVGt0dEN1Nk9kWmRzWEtqbkVwWnov?=
 =?utf-8?B?Ni8zcDNNVGlsdUd3cHdLVHRpemJYeFBJeVh2cmhkeU5QOTlQdlVjTG9oUEN0?=
 =?utf-8?B?bDhSWU51ck12Ky8yQUlBQTF0QkJUbTEyOWptaUdlUDRTdkFhS2N5anpRMnJs?=
 =?utf-8?B?L3FyMHhQSm1PYTJEV0ZIelozVzBOUWFUSTRGOG1SQUdjc3VnZ1VQRXpNSHR0?=
 =?utf-8?B?Q1RjWHZVdFdkc1lHVkJWNS9zU1FvMWNuQUM1eGdjbEpaWE5ZenpPbGN5dzFx?=
 =?utf-8?B?Y21wUGxocDBCb0RmbzNFN2xDZXgyNmlzeVlHNUhvTWRSL09ORDBlYSsvQWhz?=
 =?utf-8?B?S2N1ODBtb3NaWWkzY1pLUU1DOGtwK3R5MFJNYy8zbjhxVzFCWS85MFNLNFdX?=
 =?utf-8?B?RlJSWEozRHc4aElPT1hNR3U2amRPS1Flc3h2YXB1OCswNGR4ekc3cHJld1RS?=
 =?utf-8?B?aHh1ZWVHdmhjc1h4MHErWG83dDBOaHBZSmVsUFhLc21aSXRMa2NYcDJmQ0Zh?=
 =?utf-8?B?dUwwbzJoVWVFVW1QOWFXR0NzRU1qZVUzSCtGUEVrb1RGKzBTZzF2bXR4UDE2?=
 =?utf-8?B?U0RySHpoUkpzNVE3MWVOdER1TXNucjBrSU84SWp2Tys3RlZIeVlzTE1xNFUz?=
 =?utf-8?B?aTYxUmhIRFVjUjI4VXNDRlNpc1VxMGQzK053dWRCWGhHU1lBZlh1SzRRd2dj?=
 =?utf-8?B?SmJ5eUlGVGFqQTF0cjdnWTFWWXdCaFhZOW1VMVVMU0ZwK09hQUw2UDZ6M21p?=
 =?utf-8?B?a3doMTgxSXE2MVhmVXc3Wmdla040dzRQUjZqU2FpZkpnZVNiQ0xidEpGSkRG?=
 =?utf-8?B?YjZpWE1ZcWlKRElhMHNQUi9UWWlqUlNqa1AveSs4RUowNTdkeXBLNjc0UFNh?=
 =?utf-8?B?OGFwVTA3Vm05aURwVFliVXVYaGg1Nm14aUhJUnRVY044TjRBK1VaelMxamNw?=
 =?utf-8?B?ZDRNT0t0aGUreEV0ODNqRW5YOEhJSWFwQmt2NXBsdVFOQkcwV056bDBRMVNE?=
 =?utf-8?B?cHN0R2cybEhYY3FWc1ZvTlJpZVN6RGVMYkhLeEs5MytpanU3Rm83Zk13QUY3?=
 =?utf-8?B?L1RTUGkyVWYycGQrRTBEU0RQRDdkLzdLaVJGNTdUUlN2ajZ5ajZHRGk3R3Y3?=
 =?utf-8?B?c2dJSGM1NytJMW03TVVCWTVXb3ltWkJEWVdvVE13ZGFiTjRyZ2xSSkJUMHJC?=
 =?utf-8?B?TmhYMVo1UElib0RlalRCYmRGeHhWK0JUTDd0V2ltOW9qYXhXMHA3M3FDY2xv?=
 =?utf-8?Q?shdaaSi2RGWb2JZyIA4sm0/953dm3idf5qvD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEcrQnR5c2FxaG5HUnd0enA0U1J2ZkE4eFFvNGQ4ckNYSGp0anVPNDJCRm9X?=
 =?utf-8?B?MzY0Z1JSalZlb2xJbDd0M0s0K0h1SnhYVFF1NE12Y0VBbTdDSTgrZzdHS2tV?=
 =?utf-8?B?dWZQRHRJeXRiQUNVNVQzbzc5K1UrRXdsalY4WSt6bzAwcmtUMldDNmNNM2Fz?=
 =?utf-8?B?RUIxUUtHSUlVOEJNZy8vdkRnUkt0UkpnWUZqZjBXZVVoVVp3THRvRm9ITm9q?=
 =?utf-8?B?b0hkQnVTSjlWR2wwcmxvOVNnSGk1SVpxU09xKzBlQmNmMUVCSm1Ld2RLWUoz?=
 =?utf-8?B?WktHSmZNN2xXSG54UTlDSGRnTzcrNnM4aHRXVGNrQmNTbnRDWTd1ZUZxN3J2?=
 =?utf-8?B?OVBDcitCWVRHdzVFRVI0YmpHOW40SW8xamtmaG5LaEJTaHpFS0xHNEY0clZE?=
 =?utf-8?B?T3JGakVYVkhaTE5EWWpxa3pveDdVbHRRNG01T3g2b1ZyOEZwb2J5RHp2Rlg3?=
 =?utf-8?B?QllVSUhHSEZwVDc0VncwVWQ1ZFlHeDNuQzcxeGw3a202Z0kzaXpYMHZEZEVK?=
 =?utf-8?B?QmQ2NFZNNWphQXFQVk41UW5oOHZKZ2dqT1l2N1pOalZaUG5GYjdtSTd2QnBq?=
 =?utf-8?B?QWUxRXUwdDlqTXNLMTdxTmtQS1ZXK3ZFVEtYTXFVdjBLVHFWNXpobWx0U0o4?=
 =?utf-8?B?M1VxcnZsNzJlVTA0dzBBQVMxQS9BMWZXTzQ0dklQVjNlRnJ1cUF6SlI0RSsr?=
 =?utf-8?B?djZBcWp5VVpmRjJJUE0vWURTa012cFRieFNvRFBkYXBJQWtzWVdmb1NWYnJr?=
 =?utf-8?B?ZHIyaTVINkVsSHZiSXY1R2hQREFCc0Y3N0JrYlN1L0pEZGZPL3pCRzdyb2V4?=
 =?utf-8?B?MXVXVlJqM3J6YmVDQkllM3pxUVdKZG9lTVFVcTN0d0RsWkhKTWppZUtpZEE2?=
 =?utf-8?B?dnk1ZlFJN09odmpUWWxDY3l2V25VaHlRK2MzcFpzMnpCRVFmZmRWK1VQcjhr?=
 =?utf-8?B?bFBRNEh6cnNzNmJ5VFB3dEd2aVdPTER6Lzk3clJBdUlONW5uT1YveFEydWRt?=
 =?utf-8?B?K1JuTStMeWEvYit1VDIrRDBPRUV2dzhXays2azZvaWxrNE1nRjA4TElzcHZT?=
 =?utf-8?B?ZEJuY2h4ZEZCTVcrVDdCOFAwbGxtTmZaVFNFZG5PMkRkR2sxTG9BN3dyY0wx?=
 =?utf-8?B?VXJnaHFwYUVEWjRkdkl6NUJUdGhOQUxyTVNGSldBV0ZCczY0bmhQOXNhOTFt?=
 =?utf-8?B?clh0d2ltN2FjSFkzTThVTXhTTm9ybWVLUUhoSVYwUzNqZXpyUnJsRHA3eVk2?=
 =?utf-8?B?b2xRV091ZFV2cjdjK1Z2b3ZPMXJucGdrS05FM3ZXWlNyeCtCNXMyaUZac3Bu?=
 =?utf-8?B?YmI0R096Mjk4TDFLTmRDazI5NURqNld1UXVJOGZ2K0syQW9mOS81V1BMTTlp?=
 =?utf-8?B?QWkxOUVreDRUUDVjenRiUDFOUnJsaWxSUUFpdkVhOVZFYmtBeGtsY096K1V5?=
 =?utf-8?B?ZkNVc1BwRmdQTjh2aGxvancyYTkraXBWYTFzdUp6SlY2Q2lJejBGaW9qQkJX?=
 =?utf-8?B?VVdUbWpZanY4V1h0M2VGc3BzTk5pSGZjUTNKaGZXZ0IxY3o2MVBwb05lWHdk?=
 =?utf-8?B?aTVld3c5ZW0wbmovZzZLT1dCaU1pY3pReVByd2taUTRJNEh2aEpjYzA5RkNS?=
 =?utf-8?B?c29zbXVzd3kxMUt3L0lRb3p0TFhKV1U3S0wzY0RYNmxtYjlkNng4YkhqV3J1?=
 =?utf-8?B?YmwreDBxN3dOT3pDd0ljdmFxcUk2NG41aU9YN1gvczFtLy9Dd0JQZDl2dnps?=
 =?utf-8?B?bVRtbWNsbFlyRWF6UUJ2VVpDZDMrY3ZFcFNjd3pIZm5UZUpSK2pGbkFmc3lG?=
 =?utf-8?B?Vm5zUXhqaWFIRUZCd1oxdEp5d2xvdDdWOTZTaUIwTUFXM0RpNmtVM25kOFdY?=
 =?utf-8?B?U1NCcGRaU0RzMXpOd21TdkI0WUExN1l1VEEvUUJaTldWcnhOTWdwQnE2aWpy?=
 =?utf-8?B?dkxLLzFPTGNCT3BmK1B0VWRLOTJYQXFaVzNKckxET0JBdG96MkhQZWtqSGt4?=
 =?utf-8?B?TGY2U3oweTZTMUFhZjNKd1c1UmhsQkRKVERjUldrZ255NS91Z0VjMnc4VjdG?=
 =?utf-8?B?bEJCekVySjVwOTZjeENyVGRoT2d3U24vUzBGSTdySExOekZzMEo5Zm8waXQv?=
 =?utf-8?B?NUV2Y2xrSDZ2OEtZNjlhcHY3NFBpZGNjOWM5cW9GdFRMN0xwQTk5T2ZEWSto?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eacf43-59d3-45c1-843d-08dc84b35c5f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:28:26.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpD1OVVDxV+N4AjKO0YsaI7SlK1YD4jyO5kdTALmhvExrCof4nu7nXSK1JDlwNkAaPc1Ya2yFmaqVtx9Z0ge/lZToDW7WYvh4ajVekoliXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

Mule is an MCU that emulates a set of I2C devices which are reachable
through an I2C-mux that is implemented in a different patch-series[1].

Device #2 on the mux is an emulation of NVRAM (PCF8570 I2C interface)
with a size of 8 bytes.

Device #3 on the mux is an emulation of a read-only NVRAM (PCF8570 I2C
interface) with a size of 32 bytes. This memory contains information
relevant to the Mule firmware.

      +-----------------------------------------------+
      |  Mule                                         |
      |        +---------------+                      |
    ----+----->|Config register|                      |
      | |      +--------|------+                      |
      | |               |                             |
      | |               V                             |
      | |               __           +--------------+ |
      | |              |   \-------->| amc6821      | |
      | |              |   |         +--------------+ |
      | |              | M |-------->| PWM over I2C | |
      | +------------->| U |         +--------------+ |
      |                | X |-------->| NVRAM        | |
      |                |   |         +--------------+ |
      |                |   /-------->| ROM          | |
      |                |__/          +--------------+ |
      +-----------------------------------------------+

This patch-series adds support for the NVRAM and ROM on rk3399-puma-haikou,
px30-ringneck-haikou, rk3588-tiger-haikou and rk3588-jaguar boards.

This patch-series can only be merged after [1].

[1] https://lore.kernel.org/lkml/20240506-dev-mule-i2c-mux-v2-0-a91c954f65d7@cherry.de/

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
Farouk Bouabid (4):
      arm64: dts: rockchip: add mule nvram/rom to rk3399-puma
      arm64: dts: rockchip: add mule nvram/rom to px30-ringneck
      arm64: dts: rockchip: add mule nvram/rom to rk3588-tiger
      arm64: dts: rockchip: add mule nvram/rom to rk3588-jaguar

 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 45 +++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   | 45 +++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts  | 45 +++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi  | 45 +++++++++++++++++++++++++
 4 files changed, 180 insertions(+)
---
base-commit: 2917aef27decdfc367f37f599a613255c98c2c26
change-id: 20240531-nvmem-fd2902430de5

Best regards,
-- 
Farouk Bouabid <farouk.bouabid@cherry.de>


