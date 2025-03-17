Return-Path: <linux-kernel+bounces-564798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7AA65AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC611888CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF121AB6DE;
	Mon, 17 Mar 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="d/oq6lKq"
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4111AF0AE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232666; cv=none; b=Yk9UynHhKFD7sBPUI3MIGHLxrpS/4zeHy7uiAMBbYqiGuX64dMukAqkB0RPkxu4ev64iIhRozEY7AtyfXmkrKlrgUv+UOJnLs8UYICh0jIFOEOdQOTqHsR6EKrQYa9p8xFzjMqaXvAR1chsh6GCj2cVmbkyOOcqtpXGStOT4Ma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232666; c=relaxed/simple;
	bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HaOnzKgjqNLM0cHI+n/irp/m1Hr28v84t4gr8w/u6gH7aDN45OUSjI6qmmlX4zeNrRsuI0Jm3luuTIWaFZuAfsYoQqs1jyUElmrPNfShOwgFnp0WV3AC5pTzI1aWjemhG8qLUsHdcBJ9/BwcZt0VRwr5ephlpWGWZrhvoANrfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=d/oq6lKq; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1742232661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
	b=d/oq6lKqXcqP2zDVBQx+VMtGInCWZoi5byqsiO+MYdOePudbR7rcLgg4KjRce+/geXdZkq
	i+5Kn1bnaUwV0dlm9ZQgTu5t067gu33HyjSSMFFbU1gI6Q3W2HzqBhXvndlen+pM7gRJvF
	Y0kFhm26m3DZtSDAnjb0Ble0gOSejqU=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17011027.outbound.protection.outlook.com
 [40.93.85.27]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-7-QSplaGTdOBypMT-sO86g-A-1; Mon, 17 Mar 2025 18:24:14 +0100
X-MC-Unique: QSplaGTdOBypMT-sO86g-A-1
X-Mimecast-MFC-AGG-ID: QSplaGTdOBypMT-sO86g-A_1742232253
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::12)
 by ZR1P278MB1236.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:24:11 +0000
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d337:170d:b47a:e4be]) by ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d337:170d:b47a:e4be%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:24:11 +0000
From: =?iso-8859-1?Q?Jo=E3o_Paulo_Silva_Gon=E7alves?=
	<joao.goncalves@toradex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 
Thread-Index: AQHbl2FK2gX/q1gHfEydeUDrXma5SQ==
Date: Mon, 17 Mar 2025 17:24:11 +0000
Message-ID: <ZR0P278MB046004D44F37DDEC6FBAE1BA89DF2@ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0460:EE_|ZR1P278MB1236:EE_
x-ms-office365-filtering-correlation-id: dc8c3dc9-e6da-45e1-6123-08dd65788870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|4022899009|366016|1800799024|376014|38070700018
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1XO/JxDQsIMByMZl64ckMD9LnmOnzzQFPhVoahWRc3drUtFv7ZjVTjpbKm?=
 =?iso-8859-1?Q?jEvtizgqZdbo1eZoMA+kR7lD/Cgc/xI7e1qj7wz8kQ4knv33DzAdBdgRlH?=
 =?iso-8859-1?Q?FivTcchDBSeUWXAGvj958F6mfJ++1dhMZCS4Gnn78WOJDMrtq3bu5zNCxe?=
 =?iso-8859-1?Q?2IUldV87bWQbvOliLmW8HI19NCVjkTsHPXcxtfmKPkw0OBg07NWfQc1RDt?=
 =?iso-8859-1?Q?CwXZ0B96lmYmg6UmAJwBNE5YrjJTKDaelNye0khbzXzmNO5+AwNCOCUP5D?=
 =?iso-8859-1?Q?JxJ+GYcaig8EVKboJrFWx9cqnnylQs6HubpfBdKivG5TLxYZXvlzlkzDVA?=
 =?iso-8859-1?Q?O7p/4m2z+nRH5TvZRTAmkDG1clQz0FyT7yTxZX55+G1jNj7cWkjrXZZKPW?=
 =?iso-8859-1?Q?Yqb/UrQF9/KKaEVAfX6jC8bdPNnyywwflr+ObP2r1dk0xk7+dgtmkPpyly?=
 =?iso-8859-1?Q?aU/SV+x4cuqHU9jI16pXX0ZVDSg+UIt7fAgGsioirRDaoFgghO9I87jT3R?=
 =?iso-8859-1?Q?HWG0hFE0qV4lBQo6SvymKB0jNyKWduCMD6gtVrRMq8g8p0goS3+3aEwYM0?=
 =?iso-8859-1?Q?MRUS6vz8/k4tLyHpw8ZbG4ud13NTwG9UtE6E36Z4vXmj/8IHPbAce0afGa?=
 =?iso-8859-1?Q?k1aYRGtGRF7zv7EFEU7Ve8TKMyP81Yx06sHf3ROAxbl7CmsbbOxSzidyxz?=
 =?iso-8859-1?Q?pNQY6ySojeXGPN7QIQdSc5K/g6bLylzPyOqwUBQJrZbf10CwrnSA+pt1Xj?=
 =?iso-8859-1?Q?OvCjT8GmefNZHzlEjQsrNyII7wKbBMjc4V23wlFQ4xBNxsNUnlBYsRnjCE?=
 =?iso-8859-1?Q?UV/itOFCO5oTQEE9mDFBLqo/DPqxHi2DmhlmQjxjdxVcTMdJrPrTbshPDG?=
 =?iso-8859-1?Q?E6FBaCgWeEthOTP2IJs85wu2zo/1cH+iM0OoQbSJ76RiDR8GpDdcKI3bqd?=
 =?iso-8859-1?Q?23djMnog48p2rucNFrYpJPmejuJNl200TMpZiYBnSKAGApf0+2NZs2ss7+?=
 =?iso-8859-1?Q?XN3dv7OptjxOA+D8LPZ456wck1PSN9u5NH1vmrmlFiNY+ylZ225YHwMMAz?=
 =?iso-8859-1?Q?GFDNedX8EhTq8E5i7WuTMMI3exqC4mm/NblA084IKm5iu1TQcZ2BztA9xQ?=
 =?iso-8859-1?Q?wUUIu6XxjZs/JY2uGcF/yrbAgC7HmpVwIsLOVyqyWbYT1bEZ1Ooai7QD2Q?=
 =?iso-8859-1?Q?Xkd5xNV2X+elSj/9uR13tVE9B2sxblHP/4DLnhWeGXYKnIl2WkiLaStY8M?=
 =?iso-8859-1?Q?jVIF5W51xRSO3JLgqZT3vLRG4kZAcEdL3Z7M3uIF6wt2V7hI3v3uCMYrrx?=
 =?iso-8859-1?Q?eA7fCxegxlIlNktL4jgLnT59Nun34S1bUtCs0rDHYz4A9AcvSd1SnHtGw8?=
 =?iso-8859-1?Q?P3jJcg3fRHSrQbPwoIWjWCDzzG8UQSvklmbY2WnnET/GUxPB6qT1tNOcGs?=
 =?iso-8859-1?Q?/IeR2nxYuKJSqZGeTd0+So8qhbPVro/cHjVB1JTRmyd0mAwAnuTr9POidX?=
 =?iso-8859-1?Q?undtwh4Gtjw3O25smHy3ci?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:pt;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JhK2dX/H0bCTHDgo0fUAbfHn6mmZlZSFGtl0PhDNvOqEcbintB41q8Rpg/?=
 =?iso-8859-1?Q?1C6xFL3fM0361IbuF1oQIo7gHQ0ZPYu1ZDpEqRfjwjIJP9KH1qnQaF9rRR?=
 =?iso-8859-1?Q?Gq8u4HIn+YH71OHeHgKG0BgHMjkz/VHCO8NcwghYJQdJqJVcgP6lP5jTDZ?=
 =?iso-8859-1?Q?G8Xj1QU7NaD/r0AVFIAJYZ7zkIf4xeNmy7mNm2NB+ue78vPoScul0rMsm1?=
 =?iso-8859-1?Q?/i2l6Ti6sdP6+NtM+bMQsyewjYNlls3uBmJsYhtPSdWFljwd2AXK4sdj6z?=
 =?iso-8859-1?Q?O3k0o+T/a8uVjfl6MdG6lpteBsxWiYV3+gn9SpXN+Kb4ozpxYXA7zQJuHE?=
 =?iso-8859-1?Q?VrrmIZnc3PJYDvGn2tm0vPuyWh3MjIJeQ/qXQdpFPDusrcYHVemwOLcUjH?=
 =?iso-8859-1?Q?AJomzS+PjXMgpR6MmoIsLwk/j9EHHwLpG61rlNC9csJ/0HK6imC9QMLEnq?=
 =?iso-8859-1?Q?PmHVwKtt8/ezr6Lf7dmFnAUVHW4D3Q5Sd/vLs7fvJHPvE1GG5YV9YIgTwJ?=
 =?iso-8859-1?Q?Rp1xe5q06a5/nyQL97YyUAyFtFgs0N07bWu/XhACHRHbPSXOBlqrksGax2?=
 =?iso-8859-1?Q?575rHp3QYw5VR80YDmJ/DaoPd3MEM8/Xc+khNWq4nnXa0RcstmKDbGyZm7?=
 =?iso-8859-1?Q?+/cyHEDvRqZVU0rq6gBgzKJh6/t6m4A0D4u5UaD/GfZlcYAvqKz6+nQbd+?=
 =?iso-8859-1?Q?IEAIZK57kY+B+dsqVGqe5NC8RHv/IiBPJnzVGExO3M9Tmb1c7GhgWuSmXK?=
 =?iso-8859-1?Q?zX3y5dHNBj/YrqevfwDD1yq95+yead72Vt5sG15XiLnBcN2ycwzQ0mT+wx?=
 =?iso-8859-1?Q?rWPzx70z3RAIABDSccHD+buWF2/pcqgLMzdP1G302jNhDTTXcX3+zSGZs+?=
 =?iso-8859-1?Q?NuW/R+pxTCQsTAgMpqD7/IczxsA2FRM6stJfmfpdRQJk0ox2tQaVd7C7HH?=
 =?iso-8859-1?Q?wJIrgQRaGvCz5th90mc4bzB5jHpq1v4ME4HWmc9qgmyh0HshWLdq0uBiCL?=
 =?iso-8859-1?Q?9pk3B1Vp9qCSojZlqWI6r/ED7BnUC0Y9tyYq0P18oQrRKUXQhh0TYAHi0k?=
 =?iso-8859-1?Q?BOX+qYlG59oxlaqxDXBt5gAueC9AorLAzCffMe575ieHGg6FAFj7c2LntH?=
 =?iso-8859-1?Q?zoCon2b+q7Ce9XH5f6x8Chjj2bWlqBTI9l/0bTSGWVK31ir71ltgTxEOk8?=
 =?iso-8859-1?Q?xyh496KHW57m4SHma9S/rBThuoXNpNIMdVq/WA3Xlv8aqK6cvcKw2oN/BC?=
 =?iso-8859-1?Q?JuS8g21Zs/YUMdhg671i4iu4v/MdVD+Bab6R+PMZhvY9ZGx+qypwRjRoDO?=
 =?iso-8859-1?Q?+diNITCUnIqpPXeKGXQGvssRsZkGxfdtiul3ycC6Ha5h61dxJ2B0eMn9Kv?=
 =?iso-8859-1?Q?E17z5oJZhvUeTw9dSlREYGefqBKD9Q+xO/ZnqKyi14TxLybPm3Ca0pOl03?=
 =?iso-8859-1?Q?M+hnp045bibGDKIhsoB+B9HWAMBgDXpBJO11luOxEax0oIosYjfjqrwd6q?=
 =?iso-8859-1?Q?wSU2GJDLEcZg6FUNRlK4C0R2EzGj2ZJfB5bJChDubMA7hJLRu84pdc5LGG?=
 =?iso-8859-1?Q?inAKEiLIoikWLuoX0rj6HhJJhD7PfQ47LnInJjCZ+9Whqok+E0l9HD369o?=
 =?iso-8859-1?Q?ryu4A4MrLZkqoif5ndgaFWZO91BPro+ydp?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8c3dc9-e6da-45e1-6123-08dd65788870
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 17:24:11.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LM9SjH8Xr9USi74P5wJes4JyPvBIswpRhEdl9bqeneiyiVOFCdp0bsZz/g43L8l2RtiWu3YzHABaLLazxCf8ZvulM/jhHu/H9yLIlU9pEqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1236
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _N4BOQ13WtCD5BYhgE-vDcACsOzCEXkf6w6udVEio4U_1742232253
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

unsubscribe


