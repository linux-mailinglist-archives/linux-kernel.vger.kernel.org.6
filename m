Return-Path: <linux-kernel+bounces-429220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DD9E18FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BC0283097
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D71E1036;
	Tue,  3 Dec 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IAubPj8n"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E5189915;
	Tue,  3 Dec 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220959; cv=fail; b=BJNZTb958UplDlCeMpdoLaocOm7OOIdgK0TeLC7cYoWrjJXEyozfwaGKNrYtz8nGnQAimIn8PYHr6EJBbNWo99RKZVUmtdjWesvBIGe0K0a633qd4xOp4Et973AOyyCiz7LzB3cO3z5hF1SFJXGYnwYb0mWMfzZmYW5cAyd7ibc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220959; c=relaxed/simple;
	bh=1M93cgGQZMsq0fGiokMidzghIp5uKvod1NqpCZ/07Nk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KWU3wUfO/hwlF+MRU4siviA9NCAEbAqYRaAGN3UFC5xRiInTEKBWmmXCfmeJV4AxoNUoid02KuGqRK7ITnTfUNZRGxk1USyStwu2WCzvF/ZVDZy7/3WPiiq52W9duNz8XuYfK0x+2fQTJNEMqW32039WbMIoDwKF5fWFWCRrT1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IAubPj8n; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqQ04t1m5nvimpUgDiceK73PP4LTnpUPca0VVTTOtVV9KaEczGBa/9wzBxdptfi5mZS2KKUbiY1x1Nn+I6OJ08dHZebLGL5xBcyUz7pVfXoXurZTxRmQzhYaJ9J5P5AxV2ehzyUau+bN0HQe3ZsfO9U7sLstCAHo+FxjzeifhQoz7DN0gyPmcJAIkFWLjeQxI8PI1dBeBeVKMriuc3T39auLnTT04ZxyGnGQkQH/gElrWn5CuuwqI1j7Zhy4AuJtXFfXnmpzvzblXhgWrVwwaG4wUbcrA/GDvZNfbKPOjElHcVMNJXLOhwNzlHZMA9S6WbbIttYF63vuskc1I0XjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M93cgGQZMsq0fGiokMidzghIp5uKvod1NqpCZ/07Nk=;
 b=WQ21gHFP1tTEWswkdKYPjxn+6jf1EVhoIsQ4CRPjMRSx+zQmcxWdDY8tF7COFEgWseDg1KWG9KjgiFC8Dh0vr5qWFxl76WSTGcQwVhmfRCpHcxytu/hzPRi76eOeDdiHE6LPsud5yEL9o6PhYivgx0zSIASIHu4MBsk2amowcpSI0GXySffeMJjpUbHbvUFsj8fPswZK6XAbubxHvTX+8xOPKYJLYJ82daUxOWHYK7xODdYh3jXmkbFLL8rz+Q7fnQ4VWQIVarSJ2XqPMsV8ku+Vv3HcOg/567q/fIFDdiiaz1PaIP/muUftIupQTfXifwXI6jTA5L8oBVES0Tybsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M93cgGQZMsq0fGiokMidzghIp5uKvod1NqpCZ/07Nk=;
 b=IAubPj8njd9IlSSrXD5ZI2RK6za67dZSivv+SDDGnsEkYUrpOoFQGFKrLiCrx0cAX9G40kDU+g6+vUilw/7O9Sc0cIh+LnT1gQkmSAOKNb9+DAx8LSsaYdmAw0+L82Fy1Rt7JNF5d5tE/428L1byg68FnhpjK9APbm/JJ+ePjq4tTVfCJsSepLf4/KdtqXsTvxbwoDGPqLUzTLT0IRNtWfqXqEHIUMTXmRzQ36KZeRnfKBEn1KKIu8PzwW+4ee/27y/WVIUCFjzdHgkcuy5cRAF2z/+fHNH/oENF5TLBKxd3sjimCjiIwhGquoht8e4ijkAaiX93u5O5DI/WTPFWLw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB5420.apcprd06.prod.outlook.com (2603:1096:400:200::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.4; Tue, 3 Dec
 2024 10:15:51 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 10:15:51 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYzXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IEZpeCB0?=
 =?gb2312?B?aGUgaXNzdWUgdGhhdCBnc19zdGFydF9pbyBjcmFzaGVkIGR1ZSB0byBhY2Nl?=
 =?gb2312?Q?ssing_null_pointer?=
Thread-Topic: [PATCH v3] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: AdtFbD9AT972nKHiQsKXxwBpOClQXw==
Date: Tue, 3 Dec 2024 10:15:51 +0000
Message-ID:
 <TYUPR06MB62172E7B32CEA62F7FB53A3DD2362@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB5420:EE_
x-ms-office365-filtering-correlation-id: f59175e3-0d7e-4d33-da2d-08dd13837709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SUNiNXRURm9OMTVoS0VTZDNpbVBZNys1SUVsb2p2ODBVb2JkUXdMU2xzVlpl?=
 =?gb2312?B?ZTFNc0R0eXprQWFHRElVV3M2OU1lMFlrRjlMU3U5TnE1b1NERXJtK1BLMDFO?=
 =?gb2312?B?YzFvLzFnenpFcFRuVGc0cU9rYlVIcFJ6RitEeGFMc0pWYlBYNGtPSVBqWWt2?=
 =?gb2312?B?T3JKNzdPUEVDOEpvV3ZlemxqVXVjemNFTWMxUG9LTGJ5OFovWlRZcWVBaXNq?=
 =?gb2312?B?d1AyS0dOSERzME9FTk1ML1JwMnhPdHREVWlxSTlmNk9VdTJISnhuWCtNSUVU?=
 =?gb2312?B?b2l4R1BoRFRDTVB6ZWhsOGl1c2tzaGN0Z3loWEhmUjFzenB3WUREdEMvKzV5?=
 =?gb2312?B?YjNsUmxCSVc3ekdpZG5oRXRsQXRTWlB1VkdoQTVoK0pvb2d5ZTYyc2o1ZEdH?=
 =?gb2312?B?V1BNUWM1RFZ0emZnMm9UaWNBVlV3WWFpaHlvQUZKRlhYbzJqM0dXaGRTNUVy?=
 =?gb2312?B?ZWkreFdZM1p2TVhFZUZ6Z0t0VytWV2hoUmFzcDVCaW03bzBUOE8rMHhlWWhU?=
 =?gb2312?B?STJwcmplRy8rYXBMQWQ5R0xpdzF4SXNJc2RES3M5eTcyekxPWS95ZmpBdFFF?=
 =?gb2312?B?RW10OW5nSUlBNDhUcktsV1d5cHdxUXorL2dQSzNuSHh2NnJsclRNYkk5WUxq?=
 =?gb2312?B?d1JaTFMyS3BRWEphYmt5b2szT2tCNnNNRWM4WTdFbEhldEd2bHV1NXdNbXEw?=
 =?gb2312?B?WXFqc21na2w0cUV5SEtYUktwUnp3ZkJNN1htaHdHc2djbzA2emQrVUNqSjZW?=
 =?gb2312?B?UnJSRXBBSHRqYVR3TXU2cGMxcHpVNk9XSjlIU3Y5eVBhQnJnWUxyS3BGVUdN?=
 =?gb2312?B?OTdnOVdZYnpQdlZ4dTBmMUY2ZWNldFhraG41SzVYaDlIaDNxbWhJbHNVTlgx?=
 =?gb2312?B?SnovcmQ4dGFNZFhvQXdha25xS0dFOTlpRGt2R3RmYVZJakZ4ZEdEaUJuVUxm?=
 =?gb2312?B?VmFaWEc3Z2ViN09nM1U0eUQ2Qy85Ris1UG1zcVJubzlqOEQwU3kwRXVpQzR6?=
 =?gb2312?B?TmlRSTRneTQwSlIzN2lQUFdUcjdKRzQwaU5uZVc4WU1nK2VROFp4c0xHeXFo?=
 =?gb2312?B?STEzeGdmYWNBWUtObzBrb2hmTDl5T3V0QUpOQW8wa2djK0lOclRkcWpOVTNa?=
 =?gb2312?B?ODQrU0lDdHRVV2ROb2VSRXE1SnlvU3g5WlNIa0lKU09NanJqMmRKRG15anc3?=
 =?gb2312?B?MkN1dUhUQi9mR1IzeVJJOVQ5cUpuY3U2THhuU0tURUdSZE1EakZ4SkdBTUVi?=
 =?gb2312?B?RzhlOUxwYUFXSEhtbXU5UEFpa2MzOTNQWUlYVCtWcytCa283YVBOQ25OU2pG?=
 =?gb2312?B?OXRHYzRjWFAyUnVuQWZDUVpvRlhvWENMWDczRWx0SUprcSs5Z0cxcE5KcEtW?=
 =?gb2312?B?TUdUN2NIWkk5cTVLUlZwallGWEJRUUFycG9Jd1ovMHZza0crTW4xbHp2bmlV?=
 =?gb2312?B?TlFUR0RXTVptOTBlYkVXdCtiQmV4T3hxc0F1WDZJbGtXejVJRVU2bGRlRmVm?=
 =?gb2312?B?dTU4b2o2YTZSZzVUeUZYbS9KOEZuMDZqZVBPVldzM1UwYUIzbEE4M2x6dE9F?=
 =?gb2312?B?K1IyNE9oUnpGbWtDTlRycmRISHUwaWRVOGRiOHdiK2NIQ2ZVMTNtNU9BYkVT?=
 =?gb2312?B?YzZJN1FxUENsU2xidzlacUJvTHo2T21ieTB4USs4SkJxczB3a3NNbWVzcFNl?=
 =?gb2312?B?cjJVZ2ZQcDVsZXZlVjZhMkQ4YVlBREk4dW1kTkptYzRNZ1lMaUtReXpONHFL?=
 =?gb2312?B?YzJiVnFYQ01oTzI3eGJEYzU5SlZubzRaNFNud0dLTS9JT3I3UVRFdnU3SUhl?=
 =?gb2312?Q?Rt4vvhD+rY4QWUEjeq91GcFZ3ZIAVHblL/NCU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?LzdsSVhVQU1RSVBuVjFkYXhmZWkvVVJnSmJ6MTVLRlM3UzhSVTlwRnZtN1NE?=
 =?gb2312?B?cFBWaGJ1VHZpbytKVFQxUVlSWUU3b2hiQ0lSazM0eitMSzRTT1BqNlcxR0xL?=
 =?gb2312?B?RkpSb3JSYTlLdEl3SmgxNjJXSGI5SHhuUUY0akMvZDBVRFNmUHNxMXFjdVBR?=
 =?gb2312?B?YnUwZS9sSmlxd0RubG5hMDVobkpUQnhtMzNjVW8wZ0M2ZVVtdEx4RDdxeDdY?=
 =?gb2312?B?TEZwSUFDSVVPRXFXVDR6UHZidk9hamhaOXBQWEs2WUZ4cXZLS0JlRXZKWXYr?=
 =?gb2312?B?Z1FtcUlDM2N3d1gvYnhTNzEzNlVIYkk3L3l1WW1WVW9lWU5DTkRyYTNkYkNY?=
 =?gb2312?B?UlhnVHNzOG0rZWpNYUxUZzlGNk9ETTNITldHdkNhY0ZnWm44UjJpcFNtU2JS?=
 =?gb2312?B?RnYrMjUzRnVwUkdmMFZkY3BlM256UFAzcDBQT2xxS3hzWG1Vc3ZMdWM5RFFp?=
 =?gb2312?B?WG5kR1YvdGhPb1JkdVg4THQ3cWJGaDA4RE45eVBkMUtVOEF2OE0rWTZDYzVG?=
 =?gb2312?B?c0Y2L3ZtTDBuZ1Q2QlVqODNYaEE3NGxIQ0hlRVJXZjRCSk4xamVyMUxHdmpX?=
 =?gb2312?B?bytuT1lKcjNJcS9KTlFuWW12a0ZjekFYU3ZRQjlaYS9Fb2c5TmJXUVYxVWh2?=
 =?gb2312?B?aDhpeGlLSDZaTkV2ZnJ5YkdZQWRRdkE4bnc3VllIU21TQ2N1MXVwOFQ2SzVE?=
 =?gb2312?B?Y0FjQWVYM3BmVmFVSlhuNk9QKzdVWHdXQkVnMHJ0NWQyN3JvOUN1Z0tkRXlk?=
 =?gb2312?B?UTlnYWkraVN0TDZzSHlNaG9yNnZ0S3BoYjRmRy9Hd2RlSWtqdTFtc2ViaUM4?=
 =?gb2312?B?MVdVWXViTDM1L1lSR0VRNDE2SEY3ekVsTENPb3NObG8rQnA3dC9mUEVXVi82?=
 =?gb2312?B?L21CdEk4ZWJlUlRJUkpnR1lELzN6N0E3YW53bXQ2SExxV3Zka1pjRVJsR1I1?=
 =?gb2312?B?bWtNM2UxN2NXOXpRcklybVlXU1RVak5EYkYzVzdzMU5pdVI4ZlJEcHBhRnB2?=
 =?gb2312?B?c0FhaXFNc0F0cmtnUzJ3b041dC9aT1RZYkhZRGdyaGkrYXFBR1lUcVJyNUNp?=
 =?gb2312?B?V09OalZuNGNnOTFMdGZ0VzQvN1RNNTZacFZIUCtwcktzRHJ0VFg5Q3NRbTdO?=
 =?gb2312?B?VTFJWE1hNWJiNndpRjV1ZjZPZU83Tk1FVUdyb3pvdW5NSDZvRFI2SGo4bHNT?=
 =?gb2312?B?ZDkzdWg1U0FQN1hNaVROV3RsaG9iQWhGQ3pZWjU1K0JyajB6NnhIZVh3ajlE?=
 =?gb2312?B?UXc3QnY0Nm12cUZQcHErTGFCSXJiR3dRZG51YW1wNzIzNHRVaVdoQmN4Z2Fv?=
 =?gb2312?B?VVVwd2RUYjNtdHBVOFI0Uy8wZUxhby9rcFkwVS9VVDBnT1VtMVdhcVFDYkFH?=
 =?gb2312?B?WWFKVmV4RzRrZnpkalNHNVlhN2Y5UUVqOFMwM2RwWU1JSVNBbGRyT29Ubnl0?=
 =?gb2312?B?NzFpREgxMjJiVXJjTFpCMTluaDFCTXVaY1hJNEVtNzRPZTdnU0lwM0JxY01S?=
 =?gb2312?B?TERxTGhuVXVXNG1NZE9PNzlpbFV2SDVnY0lNRTBoYVo0cnRNTFVWbjN1WGdm?=
 =?gb2312?B?anJ4RDA3ekJxWEhmeDdMVHcyN1ArVTI1U2oyck0rY0FTZlg3SHhPeDhVRXBl?=
 =?gb2312?B?a0dYM0dLTUY0SzlXRnlPMnA4WVE4eDkyLzJWTW5WL0x4anVBNjlrNWpRclM0?=
 =?gb2312?B?bGcyNlQvTkh2aEFERExqS1hUaWlMQTdEZDdwRlRwamtXRy9Nc2J0WWQvcnRM?=
 =?gb2312?B?TmxWNHhRTStCd1dqVEIzaUs2K215cGlqWU11YmZzTGFMeVJNV0VFb2QvaTlF?=
 =?gb2312?B?MnlWZy80UGJlSWEwVmVSQVNlTjI3TXRwSG5ub2RTNEpaWkdWOWhsRkNmdHpK?=
 =?gb2312?B?dXNHZ0RLdDVVMVlTdHhRZXRQU1gwYzdHUFZDNmFseXU2UjJLK2twRVRGYXk0?=
 =?gb2312?B?QisrU2JocEJqNkxtd2FRWVROSW9KSXg4aDFVTENyT1R4TEF2K2M0VmNVSFdI?=
 =?gb2312?B?OUFOemtHcTNlYS9xamlYd0RXSitPdUxSWUk5ZUlmRGcrbDBHcXZqYWxuQkxB?=
 =?gb2312?B?b09KZU9vMWRKZDJaeExBdHgxaDdBaVJFWjVJUlE2T3ZoaWx4MVp5djRVc3Jt?=
 =?gb2312?Q?pV9o=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f59175e3-0d7e-4d33-da2d-08dd13837709
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 10:15:51.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ip0z+wqxivLhpt5vNYOJe2pS4ZU5LeneZ1fWhROnpvYUVE4zcKaQn9wehopMJCSV0LfQNvQI+5FkjDN/969Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5420

SGVsbG8gIFByYXNoYW50aCBLOg0KDQo+ID4+PiBGcm9tOiBMaWFucWluIEh1IDxodWxpYW5xaW5A
dml2by5jb20+DQo+ID4+Pg0KPg0KPiBbLi4uXQ0KPiA+PiBBbmQgdGhlIHJlc3Qgc2VlbXMgZmlu
ZSB0byBtZS4NCj4gPj4NCj4gPj4gQWNrZWQtYnk6IFByYXNoYW50aCBLIDxxdWljX3ByYXNoa0Bx
dWljaW5jLmNvbT4NCj4gPg0KPiA+IEknbSB2ZXJ5IHNvcnJ5IHRoYXQgSSBkaWRuJ3Qgbm90aWNl
IHNvbWUgb2YgdGhlIHByZXZpb3VzIHJlcXVpcmVtZW50cyBkdWUNCj4gdG8gbmVnbGlnZW5jZSBp
biByZWFkaW5nLg0KPiA+IEkgd2lsbCBtb2RpZnkgYW5kIHJlLXJlbGVhc2UgdGhlIHZlcnNpb24g
YXMgcmVxdWVzdGVkIGJlZm9yZS4NCj4gPg0KPiBodHRwczovL2xvcmUuay8NCj4gZXJuZWwub3Jn
JTJGYWxsJTJGYjBjNzg3YWQtNTVhMS00ZmIxLWI5Y2QtDQo+IDFmNjg4ZWE2NTMxNiU0MHF1aWNp
bmMuY29tJTJGJmRhdGE9MDUlN0MwMiU3Q2h1bGlhbnFpbiU0MHZpdm8uY29tDQo+ICU3QzcxNDlm
NWE2NWM4OTQ3ZGYwNzM0MDhkZDEzODAwMDFmJTdDOTIzZTQyZGM0OGQ1NGNiZWI1ODIxYTc5N2E2
DQo+IDQxMmVkJTdDMCU3QzAlN0M2Mzg2ODgxNjI3MTM4MTIzOTglN0NVbmtub3duJTdDVFdGcGJH
WnNiM2Q4DQo+IGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxB
aU9pSlhhVzR6TWlJc0lrRk9JDQo+IGpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0Ml
N0MlN0Mmc2RhdGE9a0U3ZXJoUDVRbWVKUjYNCj4gUXo5V0diZ2o2NzdJWFF3OGp2VzBjQzh0V2py
VzAlM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+IFllYSwgQWxvbmcgd2l0aCB0aG9zZSwgbWFrZSBzdXJl
IHRvIGFkZCBmaXhlcyB0YWcgYW5kIGNjIHN0YWJsZSBrZXJuZWwuDQo+IEZlZWwgZnJlZSB0byBh
ZGQgdGhlIEFja2VkLWJ5IHRhZyBhZnRlciBtYWtpbmcgdGhlIGFib3ZlIGNoYW5nZXMuDQoNCk9L
LCB0aGFua3MgYSBsb3QgZm9yIHRoZSBhZHZpY2UgZnJvbSB0aGUgY29tbXVuaXR5IHRlY2huaWNh
bCBleHBlcnRzLg0KDQpUaGFua3MNCg==

