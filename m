Return-Path: <linux-kernel+bounces-280596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC594CCA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3731C21397
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E218F2E3;
	Fri,  9 Aug 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ws4j+CzZ"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AED4431
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193255; cv=fail; b=WOmw05i8LLzgj6v5vPmKE2X/eACpXObBrl3ZYV5Kbw5ikRdzllYnA60dULkJ4gOkDYbr50IGYRAJ5xsEMw4jLmR0Ttslm5teqvaRHuihLsll+6Kp1BWyancfldC1OpVI1TRaX/9Sk4sobDLqreBMDZCI5NmWOCF6waf9vt1tm+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193255; c=relaxed/simple;
	bh=PQloP40gllGBSC2t8/WGLKGCaT7VURO2nbs2HaQaHSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6E7k7dBTCwQMbtfMt5YrLIZs0jQ5LyEdWcFo3Q+SGa2PapKiOq3Lw9lsbVDFEek5yo7XYZM6pg8pvSuIxwYO33A6yD8YLbIjI0JjgHN8Fe9aWSuf6KW5MFnIVV3GgJFETjpRgTg9C9qr2NFGyu2LgtxAtVvKed4r9elzXhvDOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ws4j+CzZ; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/r3nlgsQrwXy16Fy+L5A6Y3rs7wMSqP6isEH1wRFVtlfn/F16vkLeTFcZWAg+WS0PKRlFdvkVFfv81vKyiuSQwHlER126rXk/q9PVTxjqtNrol57wP3Ouej4kX65883uM6H00pS7mnyuVT5+KGJpfQnjheGCxmXi58uln4/kB+ALKwjFAlRvRjMbOLTag/3Tdtdvd1XRwUxDRHT7OZV4jiKLlQ1X8FeOubrgB+9w9ZAB/XFAIoJ4+CkAmubH46H6X9BtxXroTrxhYsL0Veqe6x1t7qG27HMArIzKJBIl2MJFgSh3pL+alvXU7hgeRVeF6NfoQNEI0O/maOr1MyvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQloP40gllGBSC2t8/WGLKGCaT7VURO2nbs2HaQaHSc=;
 b=RG63gwxyb6N+hwL6mstNBgKr2PEG9ZvZaBDELRqdwFcg6mAmFV29AITn11dXNQ6eBYe9GtTe9FLnrTNMEMiJSUSgKNMCZnMVVFn5sbdyoRjKmW14szF1QRaG3X3WROGzdsfX75WnFoNKylWDRx/FuQXWhO7nY0R5V0Q9LugT4QPWEmSas5XCyZ3GodZhEXKX41SZiUhSa409N/cEv0Q9xn44fUsOyxMMGdcBkLCFFBbMcJtEwFDhuRBwULTe+5F8sQBeoptdVtK5NOyWUwSONKTi0wSeJ+3h4B8VCcXa74rHKWARPpTGDIUkn8Y3DRzbXpgLpiYpoxJVzQQq5mfbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQloP40gllGBSC2t8/WGLKGCaT7VURO2nbs2HaQaHSc=;
 b=Ws4j+CzZFmYow3PQrU6QzvfRb4dSdnlzMt5HubcOaUtWLUnBlGghardMDUUJr/jRWaQCGBt/Y8y4xCgGuYLROmqHClPjjPFVi1u/kX8pmGC8DD5W+epfBpWhmteHE6WafD/YRadPM6HXBHRTTjk0y3GDmS36MfnxbV8BHkco6ruGAZ78UO2H6i/7H3BUR4pNG7IE/HF2FEqO9RCKghswJMp8Rp6LIjLONtOekxIHUsDPEFUW80gXfygRklYIDKTWDbdqSyNPCYhOJtSZD5uolRVKUgRXhsYxzaSEYxYkdBxZcmQJKfcbUU9rAavJco0sDQvXlV+kHCyNPN3aAjwJpw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB4PR10MB7013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 08:47:29 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 08:47:29 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "qyousef@layalina.io" <qyousef@layalina.io>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "frederic@kernel.org"
	<frederic@kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>
Subject: Re: [PATCH v2 0/1] hrtimer: More fixes for handling of timer slack of
 rt tasks
Thread-Topic: [PATCH v2 0/1] hrtimer: More fixes for handling of timer slack
 of rt tasks
Thread-Index: AQHa50EedjfX22aAqE+yISJGL8LPXLIeKhCAgAB49AA=
Date: Fri, 9 Aug 2024 08:47:29 +0000
Message-ID: <46ad86f8b1fc4fb5dbb3da8f6ab664f48955849f.camel@siemens.com>
References: <20240805140930.29462-1-felix.moessbauer@siemens.com>
	 <20240809013433.pazaymcdx37lhpau@airbuntu>
In-Reply-To: <20240809013433.pazaymcdx37lhpau@airbuntu>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB4PR10MB7013:EE_
x-ms-office365-filtering-correlation-id: cc6e7177-368f-4e30-1ad7-08dcb84fe697
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnFoMUxnSklleFhIcUpMd3ZpdENNQTFMMVdoN1A3MFE5Y2FvNGUzWTFCVzU2?=
 =?utf-8?B?cmtxQ2F6dkdkTEhIcDFHVENSdG9XWFZJTkw5VFc5SDBLdWE3ZEY5ME5sYzd2?=
 =?utf-8?B?aVpaNm54Ym1HendJc3JuRWVGRHJ0SG1wZ2ZnLzVFZEJGYW5zRmVuWm5LYS82?=
 =?utf-8?B?VFI5Snh1dldrWmlPbEdsN2gwSmxVQmkwQ2NOVG9hMkhidFZVUWhPY1o2MkNT?=
 =?utf-8?B?U2F3Y1lPVmJnc1ZWUDZqejU0ZWtXYWErTHV0bDJpSGdCWHlkNHFqd0pJeExM?=
 =?utf-8?B?U0JCQ0VES09rWlJVUVZDaXVhL3BOM1BFcEFONlN1bmgzbkVlaDN4Z3p3cCtK?=
 =?utf-8?B?eFhFUzBaZE0xaEV2OURwQ1QwVW0wdGRSemVOMnV3TDlKemdGeWlYMWZsZUNH?=
 =?utf-8?B?U1BWSFg2cWsvTEMwU3hXblZpRFpLcmFVOW1OcTl6T0Ixa1JhQko4ZFdXTGlj?=
 =?utf-8?B?RzhNMks4NFZCL01mM0JMcDB0VWZKdWhFdlRyRXMxVEU0eGhJd3RZVmVONTlP?=
 =?utf-8?B?TG1aR3E3OVp0WUExQWlHK3lxKzBZanIzNXNUaU5EWEkyQWhjQkk3QVgxOElr?=
 =?utf-8?B?TW9DdjJTSFA1c3c4L05CQTFQcEtaSzBwS2YyWkVpZ1YrQlBwalRGMlNjTW9s?=
 =?utf-8?B?ODUxV2F2dGE2RlNOU0JydnhUZzNFWVNqNEp3M3ZvK2srTE9NY1oxTHFzbGpm?=
 =?utf-8?B?bmpscWZ5Sk9oQ1Q3WVRQZTg2SHoxMU9HTnhqMEhNVmx0dm42enlIZ3FJOGVt?=
 =?utf-8?B?VUJ5SXprZGlwQjJtc2lUdVdrdmRZR2g4WjU1cGt0QlFqbUk1QlhtOVRJVisz?=
 =?utf-8?B?NlZDRWVFbzAwNWhiVnJUWFdNN0NzVEdIY1h0dS85YjJoMDYzRTlqVkJJcXN4?=
 =?utf-8?B?Y2hyUFBTbWtVYmE2Y1JISmNrcEtYSmQyUVpabCt6c09Bb3A2Ym5ndW1iZng5?=
 =?utf-8?B?VTZ4VWlHSnc2cmk0UnNSL2xjQWdZLzcvcE5TcE45MmErWFdTajVKKzUrb0Iy?=
 =?utf-8?B?MmVJQjZBcDM2cFk5OWpPOXdZMjRZeTVDUkZGNSs5Y1ZMai9UMjB1QW4wektE?=
 =?utf-8?B?OW9pbEhjTEorSGJtcVF1amkvaFR2N1JrcExSSDR4N0toaUZTSGhxNzg3SjYr?=
 =?utf-8?B?MVVsOXczSjJiMDZXRGZLcEcvdmlKQUF3a3R4VUVSR3VZNGxNREEvQVdUYkZn?=
 =?utf-8?B?UkQ5SXJ6M2MxeldFZGxnd1ZmRDd4bEE5eGZsQkU2eGtzWjE3MExaWGFUZ2lN?=
 =?utf-8?B?bUNHY3MvWm1vYjBPVWpPbk9zU0U5Ym5RSWhYeFpCRDdDMDFHTHhNSHNTSWMx?=
 =?utf-8?B?VG5NZkxlTWJxUG4wdnZHSFdWbGY2QTVLaWdnc1pUZURxZlR6dUVDenVnRXVM?=
 =?utf-8?B?TDFlRWJLbC9UU1hrUEhMYWRyVmE3V1htUE9XZVlkTGdyL0RTcGZvZzN4dlVl?=
 =?utf-8?B?SWgvWkxCSFRlS1E5dE1FcC9TaWZSYXh0dTBSSG9vRyttWDhnT0w0TFZ5QUtn?=
 =?utf-8?B?d0dvb2xtN0tsNEF2cDB1N1JOMGJaRWxzcGVQN2NlM0JFS29IZDRNZEJoSS9v?=
 =?utf-8?B?alMvQm84UUh4OTlkOWphNnA4Q0FGVnRuaTh5ZDhxSmU1NzUxSEU4WVpMcTNy?=
 =?utf-8?B?SithUGZRRjRDeW9ob3F3VGE0MHlnZ0tPWEhkdE5ZS1o3bGtOQ3ZoZXZOYm9Z?=
 =?utf-8?B?RHBHZlBHNXV3cGxHdUw5ZHZaVXFOd3pORDNjdHlvYkFMUXNKVGJiWmwyWjNC?=
 =?utf-8?B?dk9TeUwyVFhTOVk0cDdOWEdJclYwYWpGUHNZVlE4UkVONlJ1MUVCdnBIbWx2?=
 =?utf-8?Q?UIAdW9qDVIc2OKyVO0Zu80blzMZEHRizd+CgQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1RkcW4xTi9RbUhRQ1E3L1RNTGR3eG50QzYzK3M5c1cwbjdJdHNjZXVEeVJq?=
 =?utf-8?B?TWlURGdSWE5NdTNrVFcyaURFZFlPUWtLRnNLOXgrdFRYZ1BsdFNsOGxUZmE4?=
 =?utf-8?B?RU5PQnNHaUQ5ZklGK3FtS2FYSktuM25XUnNqR2VzSC8vZFBwWjZDcXRGUmxB?=
 =?utf-8?B?Ymg5Zmw5OFNOenIxUjhXTU5mR0kzOVJ3T2kxRDg3Wk0yV0xndW0zWFdpSlg1?=
 =?utf-8?B?ZitEREsrczlGaUFTM2dPd1B0emx6RkRmT0Y3TkFvb1g1MGJRMVQrK2t5MkJ2?=
 =?utf-8?B?T3Q4bDRIaEpkYUVndTdyUlRTcTdMTnVEVzN2L2hJeWM4cC9MNjlmLzdpNHNC?=
 =?utf-8?B?bUZ4NHNjQklVdUl4aVRKYVdlcm9lU0JyVmFJN3JsS1hLOFVvRThJVGxSVmFF?=
 =?utf-8?B?Nkx6eWhuNXFjME5IY0M0enVJdUpuWFYzNDF5MWR4MzdOckhBZUtTY0hVUEhD?=
 =?utf-8?B?d3BZQUtEVExJbkdOM0pmQzZ4K0NkY2pKTEk4VE52eUJJZTVoRUJjZ2c0YXVn?=
 =?utf-8?B?VlVBbVZ5bXVrVDR1dDJYVDhyM1JvWnVJWk9UdWtLSzhYYzJxSWRITis0clFx?=
 =?utf-8?B?ZHNxdTNZOG5BdHNUQjMwb1JVS2pmRGxSWExqdnEzQ2ZKbCttU0swMnROY2g5?=
 =?utf-8?B?c1J0czUxNmJ2eS9JOStQQWRleS8xMDV1dVVVRW5obGdsM0J1enlDakZSb0NY?=
 =?utf-8?B?SlVacGE2aW51bkVTeVJwVW1rVkhLcmU4Smwvdzh4VlhibjJRWXlrVjZIdDJC?=
 =?utf-8?B?NFlnTDFEL2pyU25jTnI2N0VJcXlOQnIzTzFHQnd1VGJXcUh2Nm1IZit0aWZh?=
 =?utf-8?B?YzVTeDdndko2QUZqOXRyVHFXUDFVZnNUR2FZZ0ZIUTVhUHhwZUx0dVJHOS9W?=
 =?utf-8?B?dDZLY3JJcm0xL0xISDFNM05MZ2ZQRUg2amV4R3FpZGVIOGFkbk4xVHZnWDNT?=
 =?utf-8?B?U3hhc3oxTGJqZWg2TkR6U3U3ZjI0TjZQTC96b1VSc0FRL3BZd1BmSUQvQlVj?=
 =?utf-8?B?cnNpUmtOeHRRVjRVMVMxMk1lYjNFWGF1cjkzU0VjQlNnUmNjcmpsUFl1WHpw?=
 =?utf-8?B?bFh0UHRGZzRibDdxUjNtOG0zYkQrV2pYLzdZWk01cjV6OCtNcFdZRGt5MDJT?=
 =?utf-8?B?dXErQWorY3U0R3VaWEUvNDRaZUFra0hOMXFaZ0tLdkc3NDJaaFh4QmxzVEdQ?=
 =?utf-8?B?M1dDNWt0cU1haUpTQzAxMDRiTnk2QldEa2tuSkI0UUhEb3Q0UDVla0ZNVjJC?=
 =?utf-8?B?WVZkRnBLcnQ2RjN0Nk9XOVBVT2tmL1pRNExTRWxibkNnSUJkeDJQVkhFQzhw?=
 =?utf-8?B?Y1ZXZkR3ZW9FdDB6bGcvOHJlUEJMZ1hVWjRWWThia25aVzV2Qk9wZmZKOXEw?=
 =?utf-8?B?Tm1xTGs5R0pwdmpsR1hBdDEySlVoSWM0b0lhMzN2K1FuQWM0RGtFYTI0VUlG?=
 =?utf-8?B?b1Z6MFFxbkFaeWJjNm8zbDFPR3RSNWNGMDhaS0hPMjR4RHlkUnVVMEJoeXd3?=
 =?utf-8?B?eUpyWGF0K1dnQUtDRm05K1NkMGEzTkFnQXFVTWR6c1JPc2ZPS2hLeDlycGwv?=
 =?utf-8?B?T2pScy8wcWxXWDlhSFoxUllFUHJsZEwwUmF0VXIxSkNPdlNTVVRqSFIzUy91?=
 =?utf-8?B?ZDJlc1N3RXNlSVNxeEdkSFdydUhUdUZjeUtiUjZadlhwQ2oyQ05aNm9MQ05w?=
 =?utf-8?B?ZGVIZWROanFWVmw5eUpydk1NdnJFRkZYa0pnYmJhcG1xTXFsaDZVZU9FYU9S?=
 =?utf-8?B?NDRLbSswUkh3Wk1RZFdMekNEMnJkTGNJblQyLzViUGljMXR6cndWMWlMTldF?=
 =?utf-8?B?Ly9meThqWGRPcERYSnAyR3ZrZHk2d2YwbDhVVUtqeGdDVjRJc1hTNUNLbVpy?=
 =?utf-8?B?NjFwbSs1VTRCUFFjL2lFUVYzN1NYT1FMYndkcks5S2UxUTVrRXM2S1NYUC92?=
 =?utf-8?B?U0gxVGlJQndZejhqWUZmT0JXdFVPUEJPRENOSVRSSGhyQUZHN2VXUGJINXFp?=
 =?utf-8?B?eDlISDE3UndlT1Z0L1RveXNVSldDR1FyaWFSQXpLSTV3SmlCVytlcFpCME5J?=
 =?utf-8?B?dVNrcW1XZkV0V2x3YjJ4K1dUcnlQektBb0tRMmY5dGM2TFZHZVB1ZkExU082?=
 =?utf-8?B?bkJWWUUweVVYMkdnZ3hRRzE2WXV0NHIyNnlEZUxKOHREMUlnK2pFcjJUN2ln?=
 =?utf-8?B?WUt0QlJOWi8zZEpDY3pBcnNCVHp6YVVtT0tnVUEzVTk1anNBaEI0RnlqRlNt?=
 =?utf-8?Q?+Ng7CoiL8H/RCYFEucUwEYZc2RS3EK4PXqlGLv1Uwo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E0DCC7AD0ACF84BA2C253D4367AAA62@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6e7177-368f-4e30-1ad7-08dcb84fe697
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:47:29.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaOj3ueZXvvSihkYUIlDVLSf/9/3aDJTZqZkjtnAoXrYiUWN3ftpl7snjSOYQzLoF9BdCfTZ7EM+ap+/3XAeCFFFI2lLXty+/hR/vAupgMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7013

T24gRnJpLCAyMDI0LTA4LTA5IGF0IDAyOjM0ICswMTAwLCBRYWlzIFlvdXNlZiB3cm90ZToNCj4g
T24gMDgvMDUvMjQgMTY6MDksIEZlbGl4IE1vZXNzYmF1ZXIgd3JvdGU6DQo+ID4gVGhpcyBzZXJp
ZXMgZml4ZXMgdGhlIChob3BlZnVsbHkpIGxhc3QgbG9jYXRpb24gb2YgYW4gaW5jb3JyZWN0bHkN
Cj4gPiBoYW5kbGVkIHRpbWVyIHNsYWNrIG9uIHJ0IHRhc2tzIGluIGhydGltZXJfc3RhcnRfcmFu
Z2VfbnMoKSwgd2hpY2gNCj4gPiB3YXMNCj4gPiB1bmNvdmVyZWQgYnkgYSB1c2VybGFuZCBjaGFu
Z2UgaW4gZ2xpYmMgMi4zMy4NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IA0KPiA+
IC0gZHJvcCBwYXRjaCAiaHJ0aW1lcjogRG9jdW1lbnQsIHRoYXQgUEkgYm9vc3RlZCB0YXNrcyBo
YXZlIG5vDQo+ID4gdGltZXIgc2xhY2siLCBhcw0KPiA+IMKgIHRoaXMgYmVoYXZpb3IgaXMgaW5j
b3JyZWN0IGFuZCBpcyBhbHJlYWR5IGFkcmVzc2VkIGluDQo+ID4gMjAyNDA2MTAxOTIwMTguMTU2
NzA3NS0xLXF5b3VzZWZAbGF5YWxpbmEuaW8NCj4gDQo+IFRoZXJlIHdhcyBkaXNjdXNzaW9uIGFi
b3V0IHRoaXMgaHJ0aW1lciB1c2FnZSBpbiBlYXJsaWVyIHZlcnNpb24gaWYNCj4gaXQgaGVscHMg
dG8NCj4gY29tZSB1cCB3aXRoIGEgcG90ZW50aWFsbHkgYmV0dGVyIHBhdGNoDQoNCkhpLCBTZWJh
c3RpYW4gYWxyZWFkeSBwb2ludGVkIG1lIHRvIHRoaXMgdGhyZWFkLg0KDQpXaGVuIGRlYnVnZ2lu
ZyBteSBpc3N1ZSwgSSBkaWQgbm90IGtub3cgYWJvdXQgaXQgYnV0IHdhcyBzY3JhdGNoaW5nIG15
DQpoZWFkIGlmIHRoZSBiZWhhdmlvciAvIHVzYWdlIG9mIHJ0X3Rhc2sgaXMgYWN0dWFsbHkgY29y
cmVjdC4NClRoZSB3aG9sZSBuYW1pbmcgd2FzIHF1aXRlIGNvbmZ1c2luZy4gTWFueSB0aGFua3Mg
Zm9yIGNsZWFuaW5nIHRoYXQgdXAuDQoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDUyMTExMDAzNS5LUkl3bGxHZUBsaW51dHJvbml4
LmRlLw0KPiANCj4gTXkgcGF0Y2hlcyBnb3QgcGlja2VkIHVwIGJ5IHRoZSB3YXksIHlvdSdkIHBy
b2JhYmx5IHdhbnQgdG8gcmViYXNlDQo+IGFuZCByZXNlbmQNCj4gYXMgbm93IHRoZSBmdW5jdGlv
biBpcyBuYW1lZCBydF9vcl9kbF90YXNrX3BvbGljeSgpDQoNCkFzIHdlIHVzZSBydF9vcl9kbF90
YXNrKCkgaW4gbmFub3NsZWVwLCBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZCB1c2UNCnRoZSBz
YW1lIGluIGhydGltZXJfc3RhcnRfcmFuZ2VfbnMoKS4gSXMgdGhhdCBiZWNhdXNlIFBJIGJvb3N0
ZWQgdGFza3MNCm5lZWQgdG8gYWNxdWlyZSBhIGxvY2sgd2hpY2ggY2FuIG9ubHkgYmUgYSBtdXRl
eF90IG9yIGVxdWl2YWxlbnQNCnNsZWVwaW5nIGxvY2sgb24gUFJFRU1QVF9SVD8NCg0KQW55d2F5
cywgSSdtIHRoaW5raW5nIGFib3V0IGdldHRpbmcgcmlkIG9mIHRoZSBwb2xpY3kgYmFzZWQgZGVs
dGE9MCBhbmQNCmp1c3Qgc2V0IHRoZSB0YXNrLT50aW1lcl9zbGFja19ucyB0byAwIHdoZW4gY2hh
bmdpbmcgdGhlIHNjaGVkdWxpbmcNCnBvbGljeSAoYW5kIGNoYW5naW5nIGl0IGJhY2sgdG8gdGhl
IGRlZmF1bHQgd2hlbiByZXZlcnRpbmcgdG8NClNDSEVEX09USEVSKS4gQnkgdGhhdCwgd2UgY2Fu
IGdldCByaWQgb2YgdGhlIHNwZWNpYWwgaGFuZGxpbmcgYW5kIHVzZXJzDQpvZiB0aGUgcHJvY2Zz
IHdvdWxkIGFsc28gc2VlIGNvcnJlY3QgZGF0YSBpbiAvdGltZXJzbGFja19ucy4NCg0KRmVsaXgN
Cg0KPiANCj4gDQo+IENoZWVycw0KPiANCj4gLS0NCj4gUWFpcyBZb3VzZWYNCj4gDQo+ID4gLSB1
c2UgdGFza19pc19yZWFsdGltZSgpIGluc3RlYWQgb2YgcnRfdGFzaygpDQo+ID4gLSBmaXggc3R5
bGUgb2YgY29tbWl0IG1lc3NhZ2UNCj4gPiANCj4gPiB2MSBkaXNjdXNzaW9uOg0KPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDA4MDUxMjQxMTYuMjEzOTQtMS1mZWxpeC5tb2Vz
c2JhdWVyQHNpZW1lbnMuY29tDQo+ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEZlbGl4IE1v
ZXNzYmF1ZXINCj4gPiBTaWVtZW5zIEFHDQo+ID4gDQo+ID4gRmVsaXggTW9lc3NiYXVlciAoMSk6
DQo+ID4gwqAgaHJ0aW1lcjogSWdub3JlIHNsYWNrIHRpbWUgZm9yIFJUIHRhc2tzIGluDQo+ID4g
aHJ0aW1lcl9zdGFydF9yYW5nZV9ucygpDQo+ID4gDQo+ID4gwqBrZXJuZWwvdGltZS9ocnRpbWVy
LmMgfCA2ICsrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuMzkuMg0KPiA+IA0KDQotLSANClNpZW1l
bnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

