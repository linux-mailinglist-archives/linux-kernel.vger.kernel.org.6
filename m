Return-Path: <linux-kernel+bounces-268627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96394271F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A0F283D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF874413;
	Wed, 31 Jul 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lkdypalH"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804A282F0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408546; cv=fail; b=CIPYkm0k8qjb3We2Ljt2iLAcDs/om+hAMnA80hWtnR0L9W1ONJqFYVWTu7fX38j/hf1Z8efDXZKTv/ZZZ+l/K1prUwxeYG5UBlIIX9/RkzdNH+N8ro/Cy4UQ4cZdUNPUYl58iSJlNPFmtg5juuznN+anT07p5iO25V/sFFAk/j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408546; c=relaxed/simple;
	bh=91V3TtSIpB46oy0tVzvPe1Py7gip2SPREWwV5AY9txc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H7kZX7J7pGdsUDw/q5VAQuHu2JhfKmGpzngEVwzA0LbCWyM9QQL6xxgWgH+A+7V5JjZoTnpSl39D0Z5M13StGh5Hp7s/0B8JCPeP64PxjXLieNqN1gU5lQXplzj4zL+L5Xmf7Gx9vx+XwsOHflAtdbs3UHH31dbB3Z+dFn7uU7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lkdypalH; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSx8kuFKzVnJNShajZ5Y18AqK4WzVpZDkD81FJ6JrNuvXvLmShgkMPeJuLe5Wbm3VvLNZCXu/v3adELS73grNNRozc9luOC7169q8d5TbyQhtnILDm5RXGmtMEOlQ9NBNsyBle3aPKbmrhM9pkFQyiwrqsC+C7xp4dey9ADOrvF8TmST2+mIDTijmDTxATRF9F0Rdk/0c+kASF2JxF308ByPusmsFZAy2sTJYUrkHaM9MCF4uetOYNuy5i3CHhXei7loceWWISsYPhxc6/GpDfj4HldrB90eDx9uQ6pNuvCOH1qB0twyYQVM+4VTay+WTOlcvRpK0wOM4E/MyPXjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91V3TtSIpB46oy0tVzvPe1Py7gip2SPREWwV5AY9txc=;
 b=FTJuwnL53iAkdoawhom/HfwhBR54XuLC7GR5d4ZhauhHzMYYbaLpBHrjhI+GpMH0nX+qLO6ZKkZOsJUffl0prwT0Z3Hl44Qds3ZGiUrXub3zPf6WWqbDKu1qzu4N1z+7/wRqQCMcBPIeFYzp1Ua9IKIWhy/dzvMx7P4L3eOIzlQE1EI6Mqt/zu6skdZmKEHr9d2g8J9iurZRyR15AIt/1xW5lJJTQus2+ahYqa67sTi8vlmTNADPH/thehXLVUTLirtKyiKYpD6zhWDQjS1SyBYI/CJ83LZN1SPhqPbjIsnnpQ6PpK+Z7Tz4WP6mnEpHRI9KCENrL50YdglN8vrrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91V3TtSIpB46oy0tVzvPe1Py7gip2SPREWwV5AY9txc=;
 b=lkdypalH8un//xS7V4a/u3XWyY+zqA5I33oTSDu7fSyDbhb4SZei75dk6ZMbcBNpeqS/gV9ORht4SF4QciM1oeOp68hrPKMnQr8y/jXaUXQ+v3NakZUawgXnHnOZEQwW5imrXEEjXHqw1T1NxGsCTKtCohtzqWtAUHvf0GjjoCIJCZ40n6uvzZTIgl/va7FSKomz0gUPZblQTQvK/3DGEsVbTRzpLSnVhEagc1iB+WDUTnHJRh+iroqv1OY21ikQwhpMF0sPJiCOmE5bChaoHtYY9L7kJNWAMWTpDndqz/JRcGRgNqkqltAsBr0XXdlnNphXu0uuktDCaBbDtNOvXw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TY0PR06MB5331.apcprd06.prod.outlook.com (2603:1096:400:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 06:48:57 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 06:48:57 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: opensource.kernel <opensource.kernel@vivo.com>
Subject: [PATCH] usb: gadget: uvc: Fixed the abnormal enumeration problem of
  mobile phone as UVC camera.
Thread-Topic: [PATCH] usb: gadget: uvc: Fixed the abnormal enumeration problem
 of  mobile phone as UVC camera.
Thread-Index: AQHa4xS9u02gHE5J0kmbmjmtyNKMWw==
Date: Wed, 31 Jul 2024 06:48:57 +0000
Message-ID:
 <TYUPR06MB6217E6066E3A74EDE86FED1FD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TY0PR06MB5331:EE_
x-ms-office365-filtering-correlation-id: 53132a8e-1eca-400f-c550-08dcb12cda3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QTJIQ21EeHNyRk1kM1ozaXZaNXlUVFM5SWMrYkZJbUhXNXlYODNmbXJGUDRj?=
 =?gb2312?B?OXNZRWVTYXRJWkd4SUM2Y1VSKzVoK0p1WEIrWHlrSzlDMWc0QW9XUTB4U25P?=
 =?gb2312?B?RlY0TkV0K2owWTZBRHByTEVlYlJKOUNMdXN0R1REZ1VxaStRWlZiWlA3Y25N?=
 =?gb2312?B?WlgyK1FzME1DUFVBREgyQUlTN1RBVlFBckMyY2d4bkx0MmZIUjMvNkNHVWpm?=
 =?gb2312?B?aGY5WWJJdEdtbXBoRDE5N3c2eFlrdVliQXY0UkFVWHkxV1MvVExNbEIvOVRr?=
 =?gb2312?B?MisrdnJ3U3NiQ3VwTnVJMzlZT1NGSlF3cERDRUtDUHl1S1ZlWmdRQ0tsbVc5?=
 =?gb2312?B?aUcwNmU2ampKb1lwUC9UdVlFdExkOWsxamN0U2V6NXd0RldINWhtbjBURmZt?=
 =?gb2312?B?K3NUa1dncEJxeHZ5TzluOFJJbk4wcXg5MjNlL0l6eGZzYkJJTnhwaGhLMmpO?=
 =?gb2312?B?VThSK1J2QlR1T3lGai9PRTFZQXkwYjJ1emdON0UrWXdldjk3L2ltTEZDU0hJ?=
 =?gb2312?B?TVpZNHlDOElQZkoraHdER2lPWjMzaHN0NmVwMlhQTTJtOFBWYW9hcExjQXBP?=
 =?gb2312?B?UWVFV1V0NEhlZGhTQkFMZnBGQTk5MGhDLzNHS3l5T3NKK0pIQTBZeXo5SHVy?=
 =?gb2312?B?MXh6clpaZE9UU0VYZ1VoRVM4MU1haktwZ3h3ekl4d01aMkpDZll0eGJ2ZW1Q?=
 =?gb2312?B?dXFrVGJpK3ZwTG56Skxaa2dLaE5BWGRjaGs3ZmZBcXVnT1lybkZRbW5NaVI0?=
 =?gb2312?B?cmQxTUJIb0ZxaDlCNy9LU1dZRUNyOFFiMWNZcElQN0RzZFFoUWxwNHEyV0pL?=
 =?gb2312?B?T0JjQ1NFbWVLSFZNZXZSTGorSVZ4MEliOVhZRnBaaXJyR0FBK2k5WnlrZXJq?=
 =?gb2312?B?L09NN0N2UHNDUlZOdDVUZFNTd0c1RXZYUFRYM2dmaFFJVEluMXRPUTNwZ2pV?=
 =?gb2312?B?THp3Qkw1MVgwTFpNaE5xUXJwUXg5c1JLbGlyejNWdjNnaThVVmZmbkV5OWdP?=
 =?gb2312?B?aElJMVUvM1JBQWZwMG8yZ2ZFZ1FwbGJHcmVFeVpxTHVxdmg3RS9WdkJkV3F2?=
 =?gb2312?B?UVBrTG9lbmsvWFNDZlZrTURQbWgzT0dtTEVhL21wOE1mUWtpa2NmVWxrSFpZ?=
 =?gb2312?B?RGpmd3NmZlRsZ3YrSmFhdFZBblVYUDcyK1htbDVDZVZpeFRueWw1N0lCTTFV?=
 =?gb2312?B?cXlnVEdMbncxMVlYR2dIOG11YU9FUGgrVjBuYS9mZmJ0WlViSmRCYUpGa3dv?=
 =?gb2312?B?THhOUE5vQU1ISDNodE8yYUxMRVZSellPb3BYc2hKZFNvZ0dPcXdsMXRCcXph?=
 =?gb2312?B?SnJtMDBLVURrMGo3VVZ5YWVWeS9ybk1SdnVnRkwrNkV0RGZkU0dsOWpqNCtW?=
 =?gb2312?B?TnBJQkV3YkhlRzk3Um1mR1UvQmQ3V3N4MzJhMEJuWTZIU2lUQWJMUnMyTGVl?=
 =?gb2312?B?OTRmRlRSeEhrV2svdEtPZXd6UHpaUXFMUHFQeXpKSGNLNmkrV3V5dWpCSFRm?=
 =?gb2312?B?MUJxNlpPYitGbFJ3OWNRWVp0bzZTS1VpTWFDZC9HQnhqTjFsZWZMYzhXVk9m?=
 =?gb2312?B?VGlKeUhqblI0ZnRuK0h0MHRrTXY0S1VsMlFvd3JwOWtxSWRxUjNtOFpWbldP?=
 =?gb2312?B?bUYxWkZhcU9vbkxodWdGckNRL211TmtTUUtVRFA2NTBWdDRac2kvM056cHFI?=
 =?gb2312?B?WStTL3pBNUE3cDRHcFN2NElUMCtpbHhoV1pPS3ZsSjdPeEwzWEhpbTZZd3FW?=
 =?gb2312?B?SURCc3VaRG1adEh1clF3VzB1cG5yMUZjelNLLzl3ZVFsZDJFcDdCclVXUWhm?=
 =?gb2312?B?QllvTUVldGNGRXcybmZPeWFYNG5mQ1VjK0Y1cjJIRDA5bEhnWWE1STduaXRM?=
 =?gb2312?B?ZmRWbzFiZGRyMWhjLzYyZFFqV0JDMWdWYUVwd09STUtCaHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cHorYUgzN1RoSWlVa3BiSTZBRHpERzd3cU94b2RIcE1aWk10MEpUQ29uVSs1?=
 =?gb2312?B?K3NGeENmRGhjRlFxcnFQdFFBSndld2lZOTRuT2YyRHRaNGhxTUVZUXkrVDJK?=
 =?gb2312?B?eXNEbWZMNk9zWWVSWFpERWZnalJDVzNIRzVHZGxDeVpzRml4M0g1R0E4dnlh?=
 =?gb2312?B?UzAybHVlSVI3VzhoZ2dQR2MyaFR4eCtDZE9zajF3QUNSRVQ1YURYcDFnSEtz?=
 =?gb2312?B?ekZrN1ZTMHlHRkxoWklTcFNGdUtQYjZxZjEvZXRkNmlZbTNVY1NWTVpmQWJs?=
 =?gb2312?B?ckg1ek5GOUJKQUFxRXJDRnJTd0Y4RytpaDhWRmp1ZmE0a2FNbWRNdS82V2hs?=
 =?gb2312?B?Z2FsQi8rTDJia01NTjRWSVhheG9yZWljK1ROckN1SVMwWXJNREtNZ3Bod3BR?=
 =?gb2312?B?SUFaWnRsUHRmeHJwclZjOFpwYU1UK3JEcVRUVnZBRWFZVWg2d3IwSFpJSjJa?=
 =?gb2312?B?Sld2TXo4Ry9kekNKTzRSbmc4SHhub0tnQVducDhSOVpNUWFVV2lQL3NNNGdI?=
 =?gb2312?B?clBvdm9FaGF6TTdJL294MHFWRnRzdStsTDVnQ0FlZytoRnJ5VDB0SXprUlND?=
 =?gb2312?B?SURRS28wazk4U25qWHVmckZCT1ZPSDFjTFhKQnBJQlUrTTh0amcwSDR6dGl6?=
 =?gb2312?B?VUJXSWhBbHExelFFaWhXaGhjZFhqZkFPT3VTT3pTK0xMTVJTOTBVckpFRlIx?=
 =?gb2312?B?K2d0L2s1WUpob1Z5b3E5YVFTUnpFSkF6YUJjVXRBSDZXRGtBalhQNjBJSXJJ?=
 =?gb2312?B?V0hEOGlIS3ZnNmpkbkJ5Mk9Hd0lWbWRwc2VrRXNzZTJlUXR4MmwwNS9RM0dI?=
 =?gb2312?B?ZS9yWEMwdk5XYzNHTGppV0ViOE51ZVpFRDRtallNU2d3am5GMjJuakY3VVdw?=
 =?gb2312?B?N0xjK1BuQjJzUlBpVGtLM2ZaR2tjTzhOTUdIbG1FOHVKa0tQbW03ck9BSEFC?=
 =?gb2312?B?T29MM2VGVmdvVHVYbFVrSEl2WWhINEJLWC93L25oVjJTVWVRTFhScDRJL1hR?=
 =?gb2312?B?QzJvVFFkbmpTeWJadlVSZ2NFS3ptRnZmVnRlQ1d5bVZTeXdhVjdJNDRHZ3Yy?=
 =?gb2312?B?TFpQS0FvNi9QVXdhcEQ1RE5GU0dUenJqczQvMHgzWXV5NG9xYXppNVhoc29L?=
 =?gb2312?B?WkhmSEsrdzFFclVGT0lVcGVxV3lOd1puTzZ0ZFFZME5CWmMwZjkzTHlQVDF2?=
 =?gb2312?B?RTdPV3Y1MGczU3kyVDkyUDErbE1LQzlDN0pkaUwwUWRzdnFpUEJlQ0krLy9m?=
 =?gb2312?B?MGJESTVkQ0dqMngrUTl6VG1Od1VrK0lNWVdUTllqZWd2R1MweWxGUEo2TXZs?=
 =?gb2312?B?c0YwZTZhNEs5czBZdC9EeDhmeEhhbXdseTlCblQ5UHp1SU9iK0dkalNEVmlW?=
 =?gb2312?B?YTM2ekpOc2szS3IwOGJrWjQ5cWt1K2VjS253Y3pZZkw0OGV6V1Uwamp6OU5B?=
 =?gb2312?B?Ky94R243TjFhZGgveGVEZkwxT2FEYm1OUzlnZmE4YStjUDBCbEZ2Y1dySkRq?=
 =?gb2312?B?dDVZREhYeGJUQ1RCR2FJYmxaUlFTVEV6UnJZWnNNN1J4Sisxc2tPaUxLSFlC?=
 =?gb2312?B?cURwekFGVW5EUXlFRlA4eHFYNTlQSEx2d0cwQzJnL21VOUJrbG1SVEZ3Qyt6?=
 =?gb2312?B?d2J0dzBZMEFpaUJmMTZheEV4dXhtd2dSU2locnF0cG1IcERYdGVUQTA5NkY5?=
 =?gb2312?B?b0NYQnZuVjJULzYrbHBmS29nYldvd3B5d3RsbE5xK2UrcFBKNzdTOEVjMXRK?=
 =?gb2312?B?VUc4ZFdaajMvK1drNnZOR3VuN00wSTJpS1F4aFhwK0tFYlZPOWF1VGNjZ2Z2?=
 =?gb2312?B?OWJpeHpZMThGcDhxVnlMOFRjUXZ0YWRlbTFScUc0bnlzWFlCWU80RTR2MVlN?=
 =?gb2312?B?TEhoaTFFZEJoQjdlMkRRK0toV1hUTkZVd3N3Y2xnVUdGQzFHdWIwMGo1bmhQ?=
 =?gb2312?B?bEE2YVB2bjZqVFdlL1hyVnJWWE9LZzl3cCt0YW02emM3bmZieFlYTnNMZDFE?=
 =?gb2312?B?MW16bkJwR3drVjdEVXdsN2pySHdKL1B2dmgrcVJBNWg2UzR3TnZrK25PcEg3?=
 =?gb2312?B?cm9iM1ppYkFUdXRPclVCdy92RHJ5R2VaVmdaV0RIQ3NiNmdVYi9aSDJIZ1lw?=
 =?gb2312?Q?bnmQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53132a8e-1eca-400f-c550-08dcb12cda3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 06:48:57.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kjRweXmD53ZT+A78AV8uFvN74YKdYGGCiC4NDxhVE8ARX12LY7JG8m3XKbYM9IOcXuMaE9S7+6F1hkrk+laOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5331

RnJvbSBjNDY0NTU4YTcwZTFjYTM2YzBlNGJkMGExMjFmYjUwNTY1YjQ0NjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+CkRhdGU6
IFdlZCwgMzEgSnVsIDIwMjQgMTQ6MjE6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGdh
ZGdldDogdXZjOiBGaXhlZCB0aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZgogbW9i
aWxlIHBob25lIGFzIFVWQyBjYW1lcmEuCgpXaGVuIHRoZSBwaG9uZSBpcyBjb25uZWN0ZWQgdG8g
dGhlIGNvbXB1dGVyIHRvIHVzZSB0aGUgd2ViY2FtIGZ1bmN0aW9uLAp0aGUgcGhvbmUgbmVlZHMg
dG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2YyBjYW1lcmEgZnVuY3Rpb24uCgpCZWNhdXNlIHV2Yy0+
ZnVuYy5iaW5kX2RlYWN0aXZhdGVkIGlzIGNvbmZpZ3VyZWQgYXMgdHJ1ZSBpbiB0aGUgZl91dmMK
ZHJpdmVyIHV2Y19hbGxvYyBmdW5jdGlvbiwgdGhlIHVzYl9nYWRnZXRfZGVhY3RpdmF0ZSBmdW5j
dGlvbiBpcyBjYWxsZWQKZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBv
c2l0ZV9iaW5kIGZ1bmN0aW9uIHRvCnNldCBnYWRnZXQtPmRlYWN0aXZhdGVkIHRvIHRydWUsIHdo
aWNoIGluIHR1cm4gY2F1c2VzIHRoZQp1c2JfZ2FkZ2V0X2Nvbm5lY3RfbG9ja2VkIGZ1bmN0aW9u
IHRvIGZhaWwgdG8gY2FsbCB0aGUgY29ycmVzcG9uZGluZwpjb250cm9sbGVyIHB1bGx1cCBvcGVy
YXRpb24gKHN1Y2ggYXM6IGR3YzNfZ2FkZ2V0X3B1bGx1cCwKbXR1M19nYWRnZXRfcHVsbHVwKSwg
YW5kIHRoZSBVU0IgY2Fubm90IGJlIGVudW1lcmF0ZWQKbm9ybWFsbHkgdW5kZXIgdGhlIHV2YyBm
dW5jdGlvbiBjb21iaW5hdGlvbi4KCkFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2gsIHdlIG1lYXN1
cmVkIHRoYXQgdW5kZXIgdGhlIHV2YyBmdW5jdGlvbiwKdGhlIGR3YzMgY29udHJvbGxlciBhbmQg
dGhlIG10dTMgY29udHJvbGxlciBjYW4gYmUgZW51bWVyYXRlZCBub3JtYWxseSwKYW5kIHRoZSB3
ZWJjYW0gZnVuY3Rpb24gaXMgbm9ybWFsLgoKVGhlcmVmb3JlLCBtb2RpZnkgdGhlIGZfdXZjIGRy
aXZlciB0byByZW1vdmUgdGhlIG9wZXJhdGlvbiBvZiBzZXR0aW5nCnV2Yy0+ZnVuYy5iaW5kX2Rl
YWN0aXZhdGVkIHRvIHRydWUuCgpTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5A
dml2by5jb20+Ci0tLQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgfCAxIC0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91
dmMuYwppbmRleCA0MDE4N2I3MTEyZTcuLjZkNjNiZWExNDIxMSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMKKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfdXZjLmMKQEAgLTExMDcsNyArMTEwNyw2IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1
bmN0aW9uICp1dmNfYWxsb2Moc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZmkpCiAJdXZj
LT5mdW5jLmRpc2FibGUgPSB1dmNfZnVuY3Rpb25fZGlzYWJsZTsKIAl1dmMtPmZ1bmMuc2V0dXAg
PSB1dmNfZnVuY3Rpb25fc2V0dXA7CiAJdXZjLT5mdW5jLmZyZWVfZnVuYyA9IHV2Y19mcmVlOwot
CXV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsKIAogCXJldHVybiAmdXZjLT5mdW5j
OwogCi0tIAoyLjM5LjAKCg==

