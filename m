Return-Path: <linux-kernel+bounces-182610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA318C8D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB551C224E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F312FF78;
	Fri, 17 May 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tng.de header.i=@tng.de header.b="HFFhuIjy"
Received: from outgoing87.ennit.net (outgoing87.ennit.net [213.178.66.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757065C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=213.178.66.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977166; cv=fail; b=X+6kfn/HuZ3mUkAKdy1Z6pZv6HW7Pbv+7aQoH3uaZvQzJXTFc/tlAH/stN0O+5HwlY2KPrM64FzvASHJUOoJu4AFJDXQhL5/GXtO20ruozH9GbzEua8k/wT5qy3y7yQ3Symq3KBjFD/vwKM5KeaVq2mmESX1LQUVcGAbwe1UYvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977166; c=relaxed/simple;
	bh=9/sJEIXUWmZZNq2fIryevZlOQPJUhHWvss8iOsCJnww=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=SrEjImVEd8tWqvTXpdtBYnVHJEI6j6dtr0VpN6/S0eASCSTeNyU3YAE+w8vJBjAJM+70krdJXusyuy0BEd7zSgJ45CFqGFdHKjueK03RW9FFWZIEawk6/WACHWPgf1rSO139b7qZcJYy9s1PJphvObssMviV8Tec4G3+hRhAo0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tng.de; spf=pass smtp.mailfrom=tng.de; dkim=pass (1024-bit key) header.d=tng.de header.i=@tng.de header.b=HFFhuIjy; arc=fail smtp.client-ip=213.178.66.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tng.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tng.de
Received: from relay2.ennit.net (relay2.ennit.net [82.97.146.99])
	by smtp1.ennit.net (Postfix) with ESMTPS id 89F2A6201D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:13:41 +0200 (CEST)
Received: from smtp.tng.de (smtp4.tng.de [82.97.146.144])
	by relay2.ennit.net (Postfix) with ESMTP id 5AD171019FD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:13:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tng.de; s=mail;
	t=1715976821; bh=9/sJEIXUWmZZNq2fIryevZlOQPJUhHWvss8iOsCJnww=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HFFhuIjyid0IAvXkDK867B1IZ3Qgvh3E+7f32kF8lSXDDuJQ5NxyVVYe1+ZFEZFzX
	 sp/Op5DC5D6tyqP1c2np6/jQ04Yv/xkJlqX/QDdU+L2gRDjaMHkGei5dFJVvTSgNY0
	 Ctx66BMC54sp+x7Gw/6iHWa9AkiQPBasexoKsXvw=
Received: from mx.mailportal.cloud (localhost [127.0.0.1])
	by smtp.tng.de (Postfix) with ESMTP id 4CFA1803F1
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:13:41 +0200 (CEST)
Received: from [82.97.165.188] (helo=mx.mailportal.cloud)
	by smtp.tng.de with ESMTPS (eXpurgate 4.33.0)
	(envelope-from <ctolkmit@tng.de>)
	id 6647ba75-1b30-526192900019-5261a5bcc26b-3
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:13:41 +0200
Received: from 104.47.11.41 by mx.mailportal.cloud (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 17 May 2024 20:13:41 GMT
Content-Type: multipart/signed; 
 boundary=NoSpamProxy_6d02dd10-a88d-4c1e-a02d-325b1c3806e8; 
 protocol="application/pkcs7-signature"; micalg="sha256"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrL3PKgL4rUsCSYrP/Q1ZSkPCfT77qS+omCFlnlZJccbHXkqJzFjAohSpRpvA7OcVi+FUVbILS01miH4aEef0cVTyd/fhNYikxCWrU6TQLGYJnm3IVmPOONNcMH3PtJtJRrsbf/ZTiUX8ru2jfDveyQW+3kxUYkDze1GZsFhgTDrG6Qa1Ud1EIk5VGQKe68m2Wg6OSaHtRY3iGq5m1aZI9+SpMy9W2UGhn4k1Pw6rBYhKk5UaWVnOjEgJBh+rWHqyYjfbGsCRPXFX2ymsXMlEufgS8hZ5Iusd7M54li8NL+5qXxIv7kdBRRwI74BAnq7uqR98ml8NEiTxZKdPwtAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54dP3AvTvaQpykY9a05i/DzB9aRy9gbdcAduyTuqKTA=;
 b=CUEXDA8PfXmybbfRbOHfHB3gxIEzdN2vchTiQGni2LSyZiLKVilqBLAucY6eeoBS55K8ngcN36EbYsb750ydJODPENc1jI1YCl+r2+/iY1qQZJQPjwuokmtz69n2hM8DqMIoC3R5RXbrfUukrxlOaQZdiFJhFpIzwSI9sdT/8UsADTOhfYv5cac47DSxlK+9qt7Bg9xQ128gCilHrceHozmsKUWsqMtjrWgGTdF//0Y9Iatrih3g6xmI647gSOMvkwSFVAVZ6tL9rCSwKJxcYxDksvTDUeLCOSoZruG+UvlKhClTQKrnfJea8s8zn1+UMGDpwJ5TixJNXsoX+5a2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tng.de; dmarc=pass action=none header.from=tng.de; dkim=pass
 header.d=tng.de; arc=none
Received: from PA4PR02MB6575.eurprd02.prod.outlook.com (2603:10a6:102:fa::11)
 by AS8PR02MB9162.eurprd02.prod.outlook.com (2603:10a6:20b:5b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 20:13:37 +0000
Received: from PA4PR02MB6575.eurprd02.prod.outlook.com
 ([fe80::cb2b:501d:30ca:907f]) by PA4PR02MB6575.eurprd02.prod.outlook.com
 ([fe80::cb2b:501d:30ca:907f%7]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 20:13:37 +0000
From: Carsten Tolkmit <ctolkmit@tng.de>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: AW: x86/topology: Handle bogus ACPI tables correctly
Thread-Topic: x86/topology: Handle bogus ACPI tables correctly
Thread-Index: AQHaqGg1bM+eZ7F2WkajipHbJx7sMrGb3HAa
Date: Fri, 17 May 2024 20:13:37 +0000
Message-ID: 
 <PA4PR02MB65756F99D066C362FBF45524A7EE2@PA4PR02MB6575.eurprd02.prod.outlook.com>
References: <87le48jycb.ffs@tglx>
In-Reply-To: <87le48jycb.ffs@tglx>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tng.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR02MB6575:EE_|AS8PR02MB9162:EE_
x-ms-office365-filtering-correlation-id: bd3e23ab-609d-4cf5-0cf3-08dc76add63b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?J3tPf4AS6E5OS98HqNotV5me6tgDb0wKd6ENFsOO6RyqDGXi78shof+seDkz?=
 =?us-ascii?Q?ppveL7tZh2aZVTBGBxErXdTzqW3jj9gtx22iNpyC+/frmd9fl+PDhB33JSsI?=
 =?us-ascii?Q?NQtzByioGXSTvrY+lp1gAobACLPO9CH/C7m8h+l9lNPQvfPks5KoJcv8tVBu?=
 =?us-ascii?Q?nUplDoqYIqcGAgy4IUKeOYeS5OJ+yDlgf2SalAaLbTdmURiy3MRYIQiJ6HVr?=
 =?us-ascii?Q?WwWkDHKvyCrMrmcodyZ0xaWdxZIub+dqGibAAP0AFNx2oJZED61lsLWB0PK7?=
 =?us-ascii?Q?TPaPurO54nbMWl0G9dQ1tmPZvhPPAKBqrtsWGRX0SURRJwNT4jTm8JqC4UgH?=
 =?us-ascii?Q?dzOJt5wjdYivlkdw+hDJCbB3HJ1OY0Nr3TcJiNuyqp0zzTWkhjmyNqDrrJwO?=
 =?us-ascii?Q?DNUPQOKVrrmdZ/6OvQs8+Pk69jlQ7IgKzsr+l8T6DV0xPPe5C7GGH+n7QsAN?=
 =?us-ascii?Q?RVVvX/scIMqmpKy6CBOtoEohJHzVpiaUstjQS8euNL04OU+BhGqsfVVIoqc3?=
 =?us-ascii?Q?vxSmIzCejLDo4+U0J4hlZQBbU9+IcgTeIZY6DYG2/l7AJhX6ZjHGPX13pa+4?=
 =?us-ascii?Q?57tRqT5CXIVat+fxX7giIULkWwh0okeqO6yHrTepUYAKbxW3rrjLt8Z4mTvx?=
 =?us-ascii?Q?nYyykP2xVoiI+nZhTX9CGWsAqYVXuD31A3VbDkd67WtjZTXdPKwuhsM18ZsX?=
 =?us-ascii?Q?ULjNjg6xTEmZdytwqfFyfnxW6THf46xTVNtLFDTB92gKfVYgg4fKlNc49h5L?=
 =?us-ascii?Q?kOm70JjWRPqr9/o7SZW79W5GO6nTiHyqfu89NIgCw4xYf9xV+aBWuXDUQ1ey?=
 =?us-ascii?Q?a/jXijU8ZWC/DTNIwe6IC33UM8NS2sAxuA8tIrQ8GlFGQ4QaPnqMZ2hswz9R?=
 =?us-ascii?Q?rhDuRFFYYqkArG3Ssmjeei4YNxgJkJuClzDePLzpgn+avLsA3JIRHbUSiFEP?=
 =?us-ascii?Q?RjMkgNTyq9NQDWAXEaRGj4LxpG0zSk0MZATYfVHEDSE0hzgL6DZAl4u/DWXn?=
 =?us-ascii?Q?obxhxVc9iOb4prfndzOHOl970WC7DMPz5z2mogAmigm0jr2tYLTUjzPFjk4N?=
 =?us-ascii?Q?4LuT5RNUbnGMKQ6u+s7T3b10BSEV0IZhso4TUPdTgQSW3+c74jsuGCipvj6J?=
 =?us-ascii?Q?25DdzAxB0GYSeYm0u+BBFGD6prVzX47xWiENRqvA7KKfo6/Z9TNNeM13SzWa?=
 =?us-ascii?Q?c8eO00Dh31m6mlKlOsM5KInkiIkxvbKwhxbf5Jtclvn54D0UJwlJmB5mV+7A?=
 =?us-ascii?Q?vtm7MicCQYwu5nx2qxfb5nbmUdKfEuY8BxHqhsFRmQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR02MB6575.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/YU8+XWbMwKeidaBYD+BCYMBgwoPq4fFAiNSbHX7he8sAbBtFoU5rOyPWAYB?=
 =?us-ascii?Q?UAqNIZKhEdb/XWvTujb/lfVItUyEK9ILk2LIpHAmK2zdLZjBE9DT+R+aBVCG?=
 =?us-ascii?Q?LVjM6gOTxHjkVv9o3RDgLZR8pVknK1JFcY2aU33P9SqXBgawvyh03Eu0SsqU?=
 =?us-ascii?Q?ZkIXhtSzWvk2L3pHK+/qKZmNBRUxc6PFUzJcsZZ8pY7cADwLVIa78ViNMZJc?=
 =?us-ascii?Q?9d2r0juKreQ7D/RkhHCgwoFZ/gX7BeY3M/hEVKfrdyqJyOsESlrrU94ODwas?=
 =?us-ascii?Q?PRcR93FdhS/NztRolZ80mqm6XuzsYNtQ77P67XD5b2IB3Wgw56s3o411HNhH?=
 =?us-ascii?Q?TAuuk+AztaygN8TdQ1LTU+jxEqpRkTrKBLMpQ6rF9kasAWcinMavQXovHXjB?=
 =?us-ascii?Q?fETPd1R7FxTPifoodu3sb5S5jeZX0ku81buWBBCxub05EgU7/PcAuG5qcBuQ?=
 =?us-ascii?Q?i4dziKzH/Va7KbRsLbMT4fST7SOGpA+wtjQ5Glka9pMacCJS/YWJD85Wue2u?=
 =?us-ascii?Q?5jxcs1mRzDV2cFamSdS+gwourQZhFRxHsKL5KMQ+1L93aTWYuj1ywnAhgmt1?=
 =?us-ascii?Q?jfzc+0Nwf13uHZuNjneAzHCK1p7Ete3d0MHtdWffwm3W/KDKwVgXn1Pa4udn?=
 =?us-ascii?Q?4wOkDKskv0BJ9BXAz05dq5V7ZRMvbtGHMLwUET/UWuyTmPtkqj6MKucwlMb+?=
 =?us-ascii?Q?dCZgoYHc9DtaDs5QmY+JxvD1+I68vgNTLI2g4rgXtW9p36HwUeHpz7aJqMMm?=
 =?us-ascii?Q?n40dRlIW3xAurSxWs9NEV5UwVrGaJjPPgDpwhvb4oqvMClpZAdcCkffz9pvp?=
 =?us-ascii?Q?UfhnMemU6Tm3nzCNF0mR68prVf9+QmxrftTwzHiRM5rwC+odqwQ5zVF1KwSn?=
 =?us-ascii?Q?xiU1eixRgIpkzDWWmTD7Np/r0bB9fkS1sZlqT8OpSNcG/NLMjHCY6eb6OCgX?=
 =?us-ascii?Q?RRg4U8rErg0mMSwXPYPV3RkpOcvJUwdD/M+1srL+lW/B27HHmQLaInzNopVM?=
 =?us-ascii?Q?tMv+xTsrSMkTyDLPv8TimnWMTg94Un6OGJHpWlaD88tzwoMHD/bNheHxZDJR?=
 =?us-ascii?Q?Olo7Zdkk/Q7wDqeoPBwdJHAZQmDWQNIew7cC4p4RkqVEfXs9cSoIUem3Qfji?=
 =?us-ascii?Q?u/fyE8BkMTaFucRPxsTT/BF9GW2ySm5pJW5zIX63C5CkYOpthJoLIxf6h0d/?=
 =?us-ascii?Q?FuNijLitrxqGyZgqXtjDDMB1e7fUPo34bKcaiwU/dEygd4RaVZ69ivczm9+w?=
 =?us-ascii?Q?qmqvDYm0Kz/40rn1IjbqhLeVNBeCm4ALVVL8HrWjnXTsJXuUZZDSfP03x8NX?=
 =?us-ascii?Q?s1kUEHvk0lKzmH546GmiZZSaU5MubMTojWshfYZ7f6D/r7Gvo+S9jmr7DJBM?=
 =?us-ascii?Q?l1iNnUSSEmGpXoNUJE0b9kMxOg4Um7DMSvkjwtn+gRVXV1GvVfYUb78CMMMV?=
 =?us-ascii?Q?WVgFabyClw652jqPnvRg0OrtEIdwMfqvuYePDO76O+Kal16iTYBLShSt8qr/?=
 =?us-ascii?Q?OzBpaDM8wQAaCiRO7fgzISP/OkmBMeQKCBAFGsSu/+tIZxwsT7cEGGSD6ve7?=
 =?us-ascii?Q?7qr01io2B4vik00+KU5AldrIhEM/EIw0pQd0e6mhZGC9lvV2+LYi6SMPQJbj?=
 =?us-ascii?Q?vV7iSIGN7+PvUWHInyqB3Is=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X3YP1Kz/XOxZsYoT2WW4SaJrUbl3JscKkUu0d2GbZtJWJH55GoS/IGrSgAyZazLg1tYWrRsTfQvivDprpX5uVGXFImZTT0HXp1gU7cwiqAIhUSsxamo2BYbHrIhc62LVks4gUlwz+MknOn2G+ScrqdwSAO5daJkp1jrOAgDc+ec85jIHX2+whdZ73r1DnzVNdDwhSus8ykBW7Lm8qe9i1EetcZ818TzCHQn9HDRTcR8MyBCqRHao3Od2yz5rO4+SiRkcnPl9ayy5It9B88zYuzP26WvcdEIrfd9E5SQLJPOLBDGLWdkrf7c9DefuVpbt8suT2R/tKJbhcTwrkrZtL4sftaiiuZe7QT3s53bc9FbYw3L8tvOTFwRstmyZIDxB8RYowdLcPC1VHv34zOsDfIZ/e/DENPtwsT4wFF+sx3pwzfGhVPB/bqCSiUliqurgyJZam4yyyDUBq1ONBVUiLfqK7eU3HdMxAd53/FCWWApyO9cf5s0bLRNU6pqGBO8zOOpcGgkxOJc99KS+0aXQRQuPX0lAcjoO0GoXi5fAIzyj2Nyv094so2NM/rvYyFZ2i31XDiLwFUJC5n715joNzOPHwaVgZVv6QM7gE6+KA5g4tAjHKl9/z9YudSw0bHiM
X-OriginatorOrg: tng.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR02MB6575.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3e23ab-609d-4cf5-0cf3-08dc76add63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 20:13:37.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 605c8088-7a31-4547-8879-effe886656e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEiB0FPZPglD5cMrOUqTnoUaYyPagtbAvUdh0vIjXvVyvdRXGzqMQPOViHp1VeI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9162
X-purgate-ID: 154354::1715976821-00001B30-D6FB40B5/0/0
X-purgate-type: clean
X-purgate-size: 37910
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-ennit-suspect: clean

--NoSpamProxy_6d02dd10-a88d-4c1e-a02d-325b1c3806e8
Content-Type: multipart/alternative;
	boundary="_000_PA4PR02MB65756F99D066C362FBF45524A7EE2PA4PR02MB6575eurp_"

--_000_PA4PR02MB65756F99D066C362FBF45524A7EE2PA4PR02MB6575eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi =54homas,

I ca=6E confirm that yo=75r re=76i=73e=64 p=61=74ch =77ork=73 as wel=6C a=73 y=
o=75=72 f=69r=73t =6Fn=65.

=54=68anks!
C=61=72st=65=6E
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F
Von: =54h=6F=6Da=73 Gle=69xne=72 <tglx=40l=69nutronix.de>
G=65se=6Ede=74=3A =46=72e=69t=61g, 17. Mai 20=324 16:40
=41=6E: C=61r=73te=6E Tol=6Bmit <cto=6Ckm=69=74@t=6Eg.de>
=43=63=3A LKM=4C =3Clinu=78-k=65rn=65l=40=76ge=72.ke=72nel=2Eorg>; x=386=40k=
=65r=6Ee=6C.o=72g <=78=386@=6B=65=72=6Ee=6C=2E=6Fr=67>
B=65tr=65ff: =7886/to=70ol=6Fg=79: =48=61ndle bogus =41CP=49 t=61bles corr=65c=
tly

The =41=43P=49 speci=66=69c=61ti=6Fn c=6Ce=61r=6Cy =73tates how =74he proce=73=
sor=73 should =62e
en=75m=65=72ated =69n =74he MAD=54:

 =22=54o =65n=73ur=65 t=68at the boo=74 proc=65=73sor is supp=6F=72=74ed po=73=
=74 =69nitiali=7Aat=69on,
  t=77o g=75=69=64elin=65s =73=68=6Fuld =62e =66o=6Cl=6Fwe=64. The =66irst =69=
s that OSPM sh=6Fuld
  ini=74=69ali=7Ae =70=72=6Fces=73or=73 in =74h=65 orde=72 t=68=61t th=65y app=
e=61=72 in the =4DADT=2E Th=65
  secon=64 =69s =74hat platf=6Frm =66=69=72mware s=68=6Fu=6Cd =6C=69s=74 t=68=
=65 =62oo=74 pro=63e=73=73or =61s t=68e
  f=69rst =70ro=63=65=73so=72 =65ntry in th=65 MADT=2E
  =2E=2E=2E
  F=61=69lu=72=65 o=66 =4FSPM =69mp=6C=65m=65n=74=61tion=73 =61nd =70=6C=61t=
=66o=72=6D fi=72mwa=72=65 =74o a=62=69=64e =62y
  thes=65 =67u=69=64eline=73 c=61=6E r=65sult in both =75=6E=70r=65di=63ta=62=
=6Ce =61=6Ed n=6Fn optimal
  pl=61t=66=6Frm ope=72a=74ion."

Th=65 =6B=65rnel r=65=6Ci=65=73 on =74=68a=74 o=72=64erin=67 =74o =64=65t=65c=
=74 t=68=65 re=61=6C =42SP o=6E c=72a=73h =6Be=72ne=6Cs
=77hic=68 =69s =69mpo=72ta=6E=74 t=6F a=76o=69d =73en=64=69n=67 =61 IN=49=54 I=
=50I =74o i=74 =61s that would =63au=73e a
=66u=6Cl =6Dac=68i=6Ee =72eset=2E

O=6E a =44=65l=6C XPS 16 9640 t=68e BIO=53 ignores th=69=73 r=75le and e=6E=75=
mera=74es t=68e CPUs =69n
=74h=65 =77=72o=6Eg =6F=72d=65r=2E A=73 a =63onseque=6Ec=65 th=65 kerne=6C f=
=61lsel=79 detec=74s a cra=73=68 =6Bernel
a=6Ed disa=62les th=65 c=6F=72res=70o=6Ed=69ng CP=55.

Prevent t=68i=73 by c=68ecking the I=413=32=5F=41=50I=43BA=53=45 MSR for =74he=
 BS=50 =62i=74 on =74h=65 boot
C=50U=2E =49f that bit =69s s=65t, t=68en the MA=44=54 b=61=73=65d BS=50 =64et=
=65=63tio=6E =63an be safe=6Cy
=69=67nore=64. I=66 =74=68=65 kernel de=74=65=63ts a mis=6D=61tc=68 =62etwe=65=
n t=68=65 =42=53P bi=74 and =74he firs=74
enumerated =4DAD=54 ent=72y th=65n em=69t a firmware bug mes=73=61=67=65.

T=68=69=73 o=62vi=6Fusl=79 al=73=6F =68=61s to b=65 =74=61ke=6E =69nt=6F =61=
=63c=6Funt whe=6E t=68=65 b=6Fot =41PIC I=44 a=6Ed
t=68e f=69r=73=74 en=75=6D=65=72at=65=64 AP=49C ID mat=63h. =49f t=68e boot CP=
U =64=6F=65=73 n=6F=74 =68ave =74he =42SP
b=69=74 =73et =69n the APICB=41=53E M=53R =74=68e=6E th=65re is no w=61y =66or=
 th=65 boot C=50=55 to
=64eter=6D=69=6Ee wh=69ch of =74he C=50U=73 is t=68e r=65al =42SP. S=65n=64=69=
=6Eg a=6E IN=49T t=6F th=65 =72eal
B=53=50 wo=75ld =72eset th=65 =6Dac=68in=65 so t=68=65 =6Fn=6C=79 =73ane wa=79=
 =74o d=65=61=6C wi=74h t=68=61t is t=6F
=6Cim=69t th=65 =6Eu=6Db=65=72 =6Ff C=50Us =74o o=6Ee and =65mit a corr=65=73p=
ond=69ng warning m=65ss=61ge=2E

Fix=65=73: =35=63=35682b=39f8=37a (=22x86=2F=63pu=3A =44etect r=65al BSP =6Fn =
cra=73=68 =6Be=72nels")
Re=70orte=64-by=3A C=61rs=74e=6E =54ol=6Bmi=74 <=63=74ol=6Bmit@enni=74.de>
Si=67=6Ee=64-of=66=2Dby=3A Thomas =47l=65ixner =3C=74g=6Cx@li=6Eut=72=6Fnix.de=
>
=43c: s=74a=62le@v=67er.kernel.o=72g
=43l=6F=73es: h=74t=70s:=2F/b=75gzi=6Cla=2Ekernel.org/sho=77=5Fb=75g.c=67=69=
=3Fid=3D=3218837
-=2D-

This =69s =61 =73li=67h=74ly =64iffe=72=65=6Et so=6Cu=74=69=6F=6E =74=68=61n t=
=68e initia=6C =70a=74ch =49 prov=69ded in
=74=68e bugz=69l=6C=61=2E =43=61rs=74e=6E, c=61n y=6F=75 p=6Ce=61=73e =74=65st=
 th=61=74 again=3F
-=2D=2D
 a=72=63=68=2Fx8=36/k=65=72n=65l/=63pu=2Ftopol=6Fgy.c |   43 =2B++++++++++++++=
+++++++=2B+++++=2B=2B++++=2B+=2B=2B---
 1 f=69=6C=65 c=68ang=65=64=2C 40 =69ns=65rt=69=6F=6Es(+=29=2C 3 de=6C=65t=69o=
=6E=73=28-=29

--- a=2Fa=72c=68/x86/k=65rnel/cpu/=74o=70o=6Cogy.c
+++ b/a=72ch/=7886=2Fker=6Ee=6C=2Fcpu/topology.=63
=40@ =2D=3128,6 +128,9 =40@ static vo=69d top=6F=5Fset=5F=63pu=69ds(un=73ig=6E=
ed i=6Et

 =73t=61=74ic =5F=5Fi=6Ei=74 bool ch=65=63=6B=5F=66=6F=72=5Fr=65a=6C=5Fbsp(=75=
3=32 api=63=5Fid)
 {
=2B       bo=6Fl =69=73=5Fb=73p =3D f=61ls=65=2C =68=61=73=5Fapic=5F=62as=65 =
=3D =62=6Fot=5F=63pu=5Fdata.x=38=36 =3E=3D =36;
+       u6=34 msr;
=2B
         =2F*
          =2A T=68=65r=65 is n=6F re=61l good wa=79 t=6F =64=65=74e=63t wheth=
=65=72 thi=73 a kdum=70=28=29
          * =6B=65r=6Eel=2C b=75=74 =65=78ce=70=74 o=6E =74he Vo=79a=67=65r SM=
P m=6F=6Es=74rosi=74y wh=69=63=68 i=73 n=6F=74
@@ -144,17 =2B=3147,51 @@ s=74=61=74=69c =5F=5F=69nit =62=6Fol check=5Ffo=72=
=5Fr=65al=5Fbs=70=28=753
         =69f (=74op=6F=5F=69nfo.re=61=6C=5F=62sp=5Fa=70=69=63=5F=69=64 !=3D B=
AD=5F=41=50=49CI=44)
                 retu=72=6E =66al=73=65=3B

=2B       /*
+        * Che=63=6B wheth=65r the en=75=6Deration order =69=73 =62ro=6Be=6E =
=62=79 evalu=61ting =74he
+        * BSP =62it =69n =74he API=43BASE =4DSR. I=66 =74he CP=55 doe=73 not =
h=61ve t=68e
+        * =41P=49C=42ASE MS=52 t=68=65n the =42S=50 =64et=65ctio=6E is n=6Ft =
p=6Fssib=6Ce =61nd the
=2B        * =6Berne=6C =6D=75st rely on the f=69=72mwa=72e =65=6Eum=65ra=74i=
=6Fn o=72de=72.
=2B        =2A/
+       if (has=5Fa=70ic=5F=62ase=29 {
+               rd=6D=73rl=28=4DSR=5FI=41=33=32=5F=41=50I=43BAS=45, m=73r=29=
=3B
=2B               i=73=5F=62sp =3D !!=28=6Dsr & MS=52=5F=49=41=33=32=5FA=50I=
=43=42AS=45=5FB=53P)=3B
=2B       }
+
         if (a=70ic=5Fid =3D=3D to=70o=5Finfo=2E=62oo=74=5Fcpu=5Fapic=5Fid) {
-               topo=5Finfo.r=65=61l=5Fbsp=5F=61pic=5Fid =3D apic=5Fid;
=2D               return fals=65;
+               =69f (is=5Fbs=70 || !=68a=73=5Fapic=5F=62=61se) {
+                       =74op=6F=5Fi=6Efo.=72=65a=6C=5Fbsp=5Fapic=5Fi=64 =3D =
=61=70ic=5Fid;
+                       return =66al=73e;
+               }
+               =2F=2A
+                =2A If =74h=65 b=6Fot =41PIC is en=75merated fi=72s=74=2C bu=
=74 the API=43B=41S=45
+                * =4DS=52 d=6F=65s =6E=6Ft =68a=76e =74he BSP bit s=65=74, =
=74=68=65n t=68er=65 is n=6F w=61y
+                =2A t=6F dis=63over =74he =72=65a=6C B=53P =68e=72=65=2E As=
=73=75=6D=65 =61 =63rash =6B=65rnel and
+                * lim=69=74 the num=62=65r of C=50U=73 to =31 as an INI=54 to=
 the rea=6C BS=50
+                =2A wou=6Cd =72e=73e=74 th=65 ma=63hi=6Ee=2E
+                *=2F
=2B               =70r=5Fwarn=28"=45n=75mer=61=74e=64 =42S=50 =41PI=43 %x i=73=
 not marked i=6E A=50I=43BASE MSR=5C=6E=22=2C =61=70=69=63=5Fi=64=29;
+               pr=5F=77=61=72=6E(=22A=73su=6D=69=6E=67 cr=61sh ker=6E=65l. Li=
mit=69n=67 to one =43=50U to pr=65v=65=6E=74 =6D=61chine =49N=49T=5Cn");
=2B               =73=65t=5Fnr=5F=63=70u=5Fi=64s(1)=3B
=2B               go=74o =66wbu=67;
         }

-       =70r=5Fw=61rn("Boot CPU =41PIC ID =6Eot th=65 f=69rs=74 =65num=65r=61t=
=65d =41PIC ID: %x > %x\n",
+       pr=5Fwar=6E=28"Boo=74 CP=55 AP=49=43 I=44 =6E=6Ft t=68e first e=6Eu=6D=
=65=72at=65d =41PIC I=44: %x =21=3D %=78=5C=6E"=2C
                 topo=5Finfo.b=6F=6Ft=5Fc=70=75=5F=61=70i=63=5Fid, ap=69c=5Fi=
=64=29;
+
+       =69f (=69=73=5Fbsp && h=61s=5F=61pic=5Fba=73e) {
+               =74opo=5Finfo.re=61l=5Fbsp=5F=61pic=5Fid =3D t=6F=70=6F=5Fi=6E=
f=6F=2Eboot=5Fcpu=5F=61=70=69=63=5Fid;
+               =67=6Fto =66wbu=67;
+       }
=2B
         =70r=5Fwarn("Crash kernel =64=65=74=65cte=64. D=69sabl=69n=67 r=65a=
=6C BSP to p=72ev=65=6E=74 mac=68i=6E=65 IN=49=54=5Cn=22=29=3B

         to=70=6F=5Fi=6E=66=6F.rea=6C=5F=62=73p=5Fap=69c=5Fi=64 =3D apic=5F=69=
d=3B
         return true;
+
+fw=62ug=3A
=2B       pr=5F=77a=72n(F=57=5FBUG =22APIC e=6Eu=6Deratio=6E order n=6Ft =73p=
=65=63=69ficat=69o=6E co=6Dp=6C=69=61n=74\n");
=2B       retu=72n f=61ls=65;
 }

 =73t=61=74ic u=6Esigned =69nt topo=5F=75nit=5Fc=6Funt(u32 l=76=6C=69d, en=75m=
 x8=36=5F=74op=6F=6Co=67=79=5F=64=6Fmai=6E=73 at=5Flev=65=6C,

ht=74ps=3A//w=77=77.tng.de

Execut=69ve board (=47=65=73c=68=3Ff=74=73f=3Fhrer=29=3A
D=72=2E Sven Wille=72=74 (C=45O/=56=6Frs=69tz=29,
Gu=6Ena=72 Peter=2C Sven Sch=61d=65,
=43=61rste=6E T=6Flkmit=2C =42er=6Ed So=6Et=68eime=72

=41m=74=73=67=65=72ich=74 K=69el HRB 6=30=30=32 KI
U=53t-ID: DE22=35=320142=38
=44i=65 =49nfo=72=6Da=74ion =3Fber die Ver=61=72b=65i=74u=6E=67 I=68r=65r D=61=
=74=65n
ge=6D=3F=3F Ar=74ik=65=6C =312 DSGVO k=3Fn=6E=65n Si=65 =75=6Et=65r =68tt=70s:=
//w=77w.=74n=67=2Ede/=64=61te=6E=73chut=7A=2F abr=75fen.
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
--_000_PA4PR02MB65756F99D066C362FBF45524A7EE2PA4PR02MB6575eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<h=74=6Dl>
=3Ch=65ad=3E
<=6D=65ta ht=74=70=2De=71u=69v=3D"Cont=65nt-T=79pe" cont=65=6Et=3D"tex=74/html=
; chars=65t=3Du=73-=61sci=69"=3E
<=73t=79le t=79p=65=3D=22=74ext/=63s=73" sty=6Ce=3D"=64isp=6Cay:=6E=6Fne;"> P =
{m=61=72gin=2Dto=70=3A0=3Bma=72g=69n=2D=62o=74tom:0;=7D </=73t=79l=65>
</=68ea=64=3E
<bod=79 dir=3D"ltr">
<div c=6Ca=73s=3D"=65l=65m=65ntToPr=6F=6Ff=22 styl=65=3D=22f=6F=6Et-=66=61=6D=
=69ly=3A =43=61li=62ri=2C =48elvetica, s=61=6Es-se=72if=3B font=2Dsi=7Ae: 1=31=
p=74; col=6F=72: =72gb(=30=2C =30, 0)=3B">
Hi Thoma=73=2C</div=3E
<di=76 cl=61ss=3D"elementT=6F=50=72o=6Ff" st=79le=3D=22font-family: Calib=72i=
=2C H=65lvetic=61=2C =73ans-serif; f=6F=6Et=2D=73=69=7Ae: 11pt=3B c=6F=6C=6Fr:=
 =72gb=280=2C 0=2C 0=29;">
<br>
=3C/div>
<div =63la=73=73=3D=22eleme=6EtToProo=66=22 =73t=79=6Ce=3D"=66=6Fnt-=66=61mi=
=6Cy=3A =43=61l=69b=72i, H=65lvetica, s=61ns=2Dseri=66=3B =66ont-=73=69ze: =31=
=31pt; color: rgb(0=2C 0, 0);">
I =63an confi=72=6D =74hat =79ou=72 =72evis=65d p=61t=63=68 wor=6Bs as =77el=
=6C as your =66ir=73t =6F=6E=65.=3C=2F=64iv=3E
<di=76 =63la=73=73=3D"=65=6C=65=6D=65=6EtT=6F=50r=6Fo=66" style=3D"fo=6Et-=66a=
=6D=69l=79: C=61l=69bri, Hel=76eti=63a, san=73-ser=69f; =66on=74-s=69z=65=3A =
=311p=74=3B color=3A rgb=280, =30, =30=29;">
=3Cbr>
=3C/d=69v=3E
<=64=69v cl=61=73=73=3D=22e=6Cement=54oP=72oof=22 s=74yle=3D=22=66ont-f=61=6Di=
=6Cy=3A =43ali=62ri=2C Helve=74ic=61, sans-=73erif; =66on=74-size: =311pt=3B c=
o=6Cor: rgb(0, 0, 0);=22>
Th=61nks!</div>
=3C=64iv cl=61ss=3D"e=6Ce=6De=6EtTo=50=72=6Fo=66=22 style=3D"=66ont=2Dfam=69=
=6Cy: C=61=6Cib=72i=2C H=65lvet=69=63=61, s=61=6Es-=73=65=72i=66; =66=6Fnt-=73=
i=7Ae: 1=31=70t=3B color: =72gb=280=2C 0=2C 0=29=3B">
Car=73t=65=6E<=2Fdiv>
<div i=64=3D"appe=6Edonsend=22><=2F=64=69=76=3E
=3C=68r sty=6C=65=3D=22=64isp=6C=61y=3A=69nline-b=6Cock;wi=64th=3A98=25" t=61b=
=69ndex=3D=22-=31=22>
<di=76 =69d=3D=22d=69=76RplyFwdM=73g" d=69r=3D=22ltr"=3E<f=6F=6Et face=3D"Cal=
=69b=72i, san=73=2Dserif=22 =73t=79le=3D=22font=2Ds=69ze:1=31p=74" c=6Flo=72=
=3D"#0=300000=22>=3C=62=3E=56o=6E:</=62> T=68o=6Da=73 G=6Ceixne=72 =26=6Ct;tgl=
x@=6Cinu=74=72o=6Ei=78.de&=67t;=3Cbr>
<=62=3E=47=65s=65n=64et=3A</b=3E =46r=65=69t=61g, =317. Mai 202=34 16:40<br>
=3Cb>A=6E=3A=3C/b> Ca=72=73te=6E Tolkm=69=74 =26lt;c=74=6Flkmit@=74ng=2Ed=65=
=26=67=74=3B<b=72>
<b>C=63=3A=3C=2F=62> LKML &lt;lin=75=78=2Dke=72nel@vger.k=65rn=65l=2Eorg&g=74=
=3B; x8=36@kernel=2E=6Frg =26l=74;=7886=40k=65rn=65l.=6Frg&gt=3B<=62=72=3E
<b>B=65=74reff=3A=3C/=62=3E x8=36/to=70=6Fl=6F=67y: =48an=64le bogu=73 =41=43=
=50=49 =74=61bl=65s corre=63tl=79=3C/=66on=74>
=3Cdiv=3E=26nbsp;=3C=2F=64iv=3E
</div=3E
<d=69v =63lass=3D"BodyFra=67ment"><f=6F=6E=74 =73iz=65=3D"2=22=3E<s=70a=6E =73=
=74yle=3D=22f=6F=6Et=2D=73ize:11=70t=3B"=3E
<di=76 =63=6C=61s=73=3D"PlainT=65x=74=22>=54h=65 ACP=49 s=70ecif=69cat=69on =
=63l=65a=72l=79 s=74=61=74=65s =68ow =74h=65 pr=6Fc=65ss=6F=72s s=68oul=64 be<=
br>
e=6Eume=72at=65d i=6E t=68e =4DAD=54:<br>
<b=72>
&nbsp=3B&qu=6Ft;To ens=75re th=61t the =62o=6Ft processor =69s =73uppo=72t=65d=
 =70=6F=73=74 i=6Ei=74ia=6Ciza=74i=6Fn=2C=3C=62=72>
&n=62sp; t=77=6F guide=6C=69nes sh=6Ful=64 b=65 =66o=6Cl=6Fw=65d. T=68e f=69=
=72s=74 is =74hat OS=50M s=68ould=3Cb=72>
=26nb=73p=3B initi=61=6Ciz=65 p=72ocessor=73 i=6E the order =74h=61t t=68=65=
=79 =61p=70e=61r in the MAD=54. =54=68e<br>
=26nbsp; s=65=63=6F=6Ed is t=68a=74 =70l=61tform =66irmw=61r=65 =73houl=64 =6C=
ist th=65 b=6Fot p=72oces=73or as =74he<=62r>
&nbsp; firs=74 =70r=6F=63es=73o=72 =65nt=72=79 in the =4DA=44=54.<br>
&n=62=73p=3B ..=2E=3C=62r>
=26n=62=73=70; F=61i=6Cur=65 =6Ff =4FSPM =69mp=6C=65m=65=6Et=61=74=69o=6E=73 a=
nd =70latf=6F=72m f=69r=6Dw=61=72e to =61bid=65 =62=79<=62=72>
&nbsp; t=68es=65 =67uid=65=6Ci=6E=65s can =72e=73u=6C=74 in bo=74=68 =75npre=
=64ic=74a=62le a=6Ed =6Eon =6Fptima=6C<b=72>
&nbs=70=3B =70latform =6F=70=65=72ation=2E&=71uot;=3C=62r>
=3Cbr=3E
The k=65rne=6C rel=69e=73 on t=68at o=72de=72=69=6E=67 to d=65tect =74he real =
BSP on c=72as=68 ker=6Eel=73=3C=62=72>
whic=68 i=73 =69=6Dportant =74o =61voi=64 sendi=6Eg a IN=49T IPI t=6F it =61=
=73 t=68a=74 =77o=75=6Cd ca=75s=65 =61<=62r>
f=75l=6C =6D=61=63hin=65 res=65t.<=62=72>
=3Cb=72>
O=6E a Del=6C X=50S =316 9=3640 =74=68e =42=49O=53 ig=6E=6Fres this rule a=6Ed=
 enum=65rat=65=73 th=65 CPU=73 in<br>
=74=68e =77ron=67 =6F=72de=72. =41s a conseq=75enc=65 the k=65r=6Ee=6C f=61ls=
=65ly de=74ect=73 a cr=61sh kernel=3Cbr>
and =64isables t=68=65 co=72respond=69=6Eg C=50U.=3C=62=72=3E
<br>
Prevent =74h=69s by checki=6Eg =74=68e IA3=32=5F=41=50ICBASE MSR for =74=68e =
=42SP bi=74 o=6E =74=68e bo=6F=74<br>
CPU. If =74h=61t b=69t i=73 set, t=68en =74he =4DA=44T ba=73ed BSP detec=74i=
=6F=6E can be =73a=66ely<br>
igno=72e=64. =49f the =6Bernel detects a mismat=63h between =74he B=53P bit =
=61=6Ed =74he first=3Cbr>
=65numerate=64 M=41D=54 e=6Et=72=79 th=65n =65=6D=69=74 a =66i=72mwa=72=65 bug=
 m=65=73=73age.<br>
<br=3E
=54his obv=69=6Fusl=79 als=6F has to be ta=6Ben i=6E=74o ac=63o=75n=74 =77=68e=
n the boo=74 =41P=49C =49=44 a=6Ed=3Cbr>
the =66=69r=73t =65=6Eu=6D=65r=61ted APIC ID ma=74=63h. If th=65 =62oot CPU do=
=65s =6Eo=74 have the BS=50<b=72>
bit s=65t =69n the API=43B=41S=45 MSR =74hen ther=65 is =6Eo w=61=79 f=6Fr =74=
h=65 =62=6F=6F=74 =43P=55 to<=62r=3E
dete=72=6Dine =77h=69=63h o=66 the C=50=55s is =74h=65 =72ea=6C B=53P=2E Sendi=
ng a=6E I=4E=49T to th=65 =72e=61l<=62r>
=42SP w=6Fu=6C=64 reset =74h=65 =6Dachin=65 =73o th=65 onl=79 =73ane wa=79 =74=
=6F d=65a=6C =77ith tha=74 i=73 to=3Cbr=3E
=6C=69mi=74 the nu=6Dber of CP=55=73 to =6Fn=65 and e=6Di=74 a c=6Frresponding=
 w=61r=6Ei=6Eg me=73s=61=67e.<=62=72=3E
=3Cbr>
F=69xes: 5c=35682b9f=387a (&qu=6Ft=3B=788=36/cpu: =44e=74e=63=74 re=61l B=53P =
on cr=61=73=68 ke=72n=65=6Cs&=71uo=74=3B)=3Cbr=3E
Reported=2D=62y: Carst=65=6E =54o=6C=6Bmit &=6Ct=3Bctolk=6D=69t@ennit=2Ed=65=
=26gt;=3C=62r>
Si=67n=65d-off-by: T=68om=61=73 Gl=65=69xn=65=72 &=6Ct;=74glx=40=6Ci=6E=75=74=
=72oni=78.de=26gt;=3C=62=72>
=43c: st=61=62l=65=40vg=65r.=6Berne=6C=2Eor=67<=62r>
=43=6Coses=3A <a =68re=66=3D=22ht=74ps:/=2Fbug=7A=69lla.=6Ber=6Eel=2Eo=72g=2Fs=
=68ow=5F=62ug.cgi=3Fid=3D=3218837"=3Eht=74ps=3A=2F/b=75=67z=69lla=2E=6B=65r=6E=
e=6C.o=72g=2F=73h=6Fw=5Fbug.cgi=3F=69d=3D2=31=388=33=37<=2F=61><=62r>
---<=62r>
=3Cb=72>
Th=69s =69s a =73li=67=68t=6C=79 di=66f=65rent solu=74io=6E =74han =74he ini=
=74ia=6C =70atch =49 p=72ov=69ded i=6E=3C=62r>
the =62=75gzill=61. Ca=72ste=6E, c=61n you =70l=65=61s=65 te=73t t=68at =61g=
=61=69=6E=3F<br=3E
---<br>
=26nbsp=3Ba=72=63=68/x=38=36=2F=6B=65r=6Eel/cp=75/t=6Fpol=6Fgy.=63 |&nbsp;&nbs=
p=3B 4=33 ++=2B=2B+++++=2B=2B=2B=2B=2B+++=2B++=2B+++=2B+=2B+++=2B++++=2B++---<=
b=72=3E
=26nbsp;=31 fi=6C=65 chan=67ed, 4=30 ins=65r=74ion=73=28=2B), =33 del=65=74ion=
=73(-)<br=3E
<b=72=3E
=2D-- a/arch=2Fx86=2Fkern=65l/cp=75=2F=74opo=6C=6Fgy.=63<=62r>
=2B++ b/a=72ch=2Fx86/kern=65l/c=70=75=2Ftopo=6Cogy.c<br=3E
=40@ -=3128=2C6 +128,9 @@ st=61=74=69=63 vo=69=64 to=70=6F=5Fs=65t=5F=63=70=75=
=69ds=28=75nsig=6Eed int<=62r=3E
=26nb=73p;<br>
&nbsp;st=61tic =5F=5Finit boo=6C ch=65c=6B=5Ffor=5Freal=5Fbs=70(u32 =61=70ic=
=5Fi=64)<br=3E
&=6Ebs=70;=7B<=62r=3E
=2B&nbsp;&nb=73=70;&n=62sp=3B&n=62sp;&nbs=70;&nbsp=3B bool is=5Fb=73p =3D f=61=
l=73=65, =68a=73=5Fa=70i=63=5F=62ase =3D bo=6Ft=5Fc=70=75=5Fd=61t=61.=7886 &gt=
;=3D 6;<=62r>
=2B&nb=73p;&n=62=73p;&n=62sp;&n=62s=70=3B=26nb=73=70;=26nbs=70; u6=34 =6D=73r;=
<br>
+<br=3E
&nbs=70;&nbsp=3B&=6Ebsp;=26=6Ebsp;&nbs=70=3B=26nbsp;&nb=73p;&=6Eb=73p=3B /*<br=
>
&=6E=62sp;=26n=62s=70;&nb=73=70;&=6Eb=73p;&n=62sp;=26nbsp;&=6E=62sp=3B&=6Ebsp;=
&nb=73=70; =2A =54he=72e is no =72=65al =67o=6Fd =77=61=79 to =64=65te=63t whe=
=74her th=69s a =6Bdump()=3C=62r>
&n=62=73p;=26n=62s=70;=26nbsp=3B&=6Ebsp=3B=26n=62=73p;&nb=73=70=3B&=6Ebsp;=26=
=6Eb=73=70=3B&nbs=70; * ke=72=6Eel=2C but ex=63ep=74 on =74=68e Voyag=65r =53M=
P monst=72=6F=73ity wh=69c=68 =69=73 =6Eot=3Cbr>
@@ -144=2C17 =2B=314=37=2C5=31 =40=40 s=74at=69=63 =5F=5Fini=74 bool check=5Ff=
or=5Fr=65al=5F=62sp(=75=33<=62r>
&=6E=62s=70;&n=62s=70;=26n=62s=70;&nb=73p;=26=6Ebs=70=3B&=6Ebsp;&nbsp=3B&=6E=
=62=73p; if (topo=5Fin=66o=2E=72=65a=6C=5Fb=73p=5Fapi=63=5Fid !=3D B=41D=5FAPI=
=43=49=44=29<=62r=3E
&n=62s=70;&nbs=70;&=6Ebs=70=3B=26=6E=62sp;=26=6Ebsp;=26nbsp;&nbsp;&nb=73p;&n=
=62sp=3B&n=62s=70;&=6Eb=73=70=3B&nbsp;=26n=62=73=70;&nbsp;=26nbsp;&=6Eb=73=70;=
 r=65turn =66a=6Cse;=3Cb=72>
=26nbsp=3B=3Cb=72>
+&nbsp;&nbsp;=26=6E=62sp;=26n=62=73=70;&=6Ebs=70;=26=6Ebsp=3B /*<=62=72=3E
+&nbsp;&=6Eb=73p=3B&nbsp=3B&=6E=62s=70;=26nbs=70;&n=62=73=70;&n=62=73p; * =43h=
e=63=6B whe=74h=65r t=68=65 enum=65=72ation =6F=72de=72 =69s br=6Fken by eva=
=6Cuat=69=6Eg th=65<b=72>
=2B&nbs=70;&nb=73p=3B&=6Ebs=70;&nbsp=3B&nb=73p;=26n=62=73=70;&nbs=70; * BSP =
=62it in the AP=49C=42A=53E =4DS=52. =49=66 the CP=55 do=65s =6Eot have t=68=
=65=3Cb=72>
+&=6Eb=73p;&nbsp=3B&=6Ebs=70;=26nb=73=70;&=6Ebsp;=26=6Ebs=70;=26nb=73p; =2A =
=41=50I=43=42A=53E M=53R =74hen the B=53P dete=63tio=6E i=73 =6E=6Ft =70ossib=
=6Ce a=6E=64 t=68=65<b=72>
+&n=62=73p;=26=6Ebsp;=26n=62s=70=3B&nbsp=3B=26nbsp=3B&n=62=73p=3B=26=6Ebsp; =
=2A k=65rnel mus=74 rely on =74h=65 =66=69rm=77=61re en=75=6Der=61ti=6F=6E =6F=
rder.<br=3E
=2B&nb=73p;=26=6Ebsp;&=6Ebsp=3B=26nbsp;=26n=62s=70;&=6Eb=73=70=3B&=6Ebsp=3B =
=2A/<=62r=3E
+&nbsp;=26n=62=73=70;&n=62s=70=3B=26nb=73p;=26n=62sp;&n=62=73=70; =69=66 (has=
=5Fap=69=63=5Fbase) {<=62=72=3E
+=26n=62sp;&=6E=62s=70;=26nb=73=70=3B&nbs=70=3B&nbs=70=3B&=6Ebsp;=26n=62sp;&nb=
=73=70=3B=26=6Ebsp=3B&n=62s=70;&nbsp=3B=26nbsp;&nb=73p;&nb=73p=3B r=64m=73rl(M=
SR=5F=49A3=32=5FA=50IC=42ASE, msr)=3B<=62r=3E
+&nbs=70;=26n=62=73=70=3B&nbsp;&nb=73=70;&nbsp;=26nb=73p;=26=6Ebsp=3B&n=62sp;=
=26=6Ebs=70=3B=26nbsp;&nbsp;&nb=73p;&nb=73p=3B&nb=73p=3B is=5Fbs=70 =3D !=21=
=28m=73=72 &a=6Dp; =4DS=52=5F=49A32=5FAPICB=41SE=5FBS=50);<b=72>
+&n=62=73p;=26nb=73=70;&=6E=62sp;&n=62sp;=26nbsp=3B&nbsp; }<br>
+<br>
&n=62sp=3B=26nbsp;=26nbsp;&=6Ebs=70;&nb=73p;=26=6E=62sp;=26=6E=62s=70;=26nbsp=
=3B i=66 (a=70=69c=5F=69=64 =3D=3D t=6Fpo=5F=69=6Ef=6F=2Eb=6Fot=5Fcp=75=5Fapic=
=5Fi=64=29 =7B<br=3E
=2D&nb=73=70;=26=6E=62s=70=3B&=6E=62=73p;&nbsp;=26nb=73p;=26nb=73p;&=6Ebsp;&=
=6E=62sp=3B=26nb=73p;&nbsp=3B&nbsp;&n=62sp;=26nbsp=3B&nb=73=70; t=6Fpo=5F=69n=
=66o.=72eal=5F=62sp=5Fapic=5Fid =3D =61pic=5F=69=64;<br=3E
-=26nbsp=3B&nb=73=70;&nb=73p=3B&nb=73=70;&=6Ebs=70;&nbsp;&=6Ebsp=3B&nb=73p;=26=
nbsp=3B&n=62s=70;=26=6Eb=73p;&=6Ebsp;=26nbs=70;&nbsp=3B =72=65turn fa=6Cse;<=
=62r=3E
+&nb=73=70;=26nbs=70;=26nbsp;&=6Ebs=70;&nbsp;=26nb=73=70;&n=62sp;&nb=73p;=26=
=6E=62sp;&=6Ebsp;=26=6Ebsp;&n=62=73p=3B=26nb=73=70;=26=6E=62sp; if =28=69s=5Fb=
sp || =21=68as=5F=61pi=63=5Fbas=65=29 {<br>
+&nbsp=3B=26=6Eb=73p=3B&=6E=62=73=70=3B&=6Ebsp=3B&n=62=73=70;=26nbs=70;=26=6Eb=
sp;&n=62sp=3B&nb=73p;&nbsp;&nbsp;&nb=73p=3B&=6Ebsp;&=6E=62sp;=26=6Ebsp;&=6Ebsp=
=3B&n=62=73=70;=26nbs=70;&nbs=70=3B&=6Eb=73=70=3B&nb=73p=3B=26=6E=62=73=70; to=
=70o=5Fin=66o.r=65a=6C=5Fb=73p=5Fapic=5Fid =3D =61pic=5Fid=3B<=62=72=3E
+=26n=62sp=3B&nbs=70=3B=26=6E=62sp=3B&n=62s=70=3B=26nbs=70=3B&nbs=70;&n=62s=70=
;&n=62=73p;=26=6Eb=73=70=3B=26nbsp;&=6Ebsp=3B=26=6Ebsp;=26=6Ebsp;=26=6Ebsp=3B&=
nbsp;=26nbsp;=26nbsp;&=6Ebsp;&n=62=73p;&=6E=62=73p=3B=26=6Ebs=70;&nbsp=3B =72=
=65t=75=72=6E fa=6Cs=65=3B<br>
+&nbsp;=26nb=73=70;=26=6E=62=73=70;=26=6Ebs=70;=26nb=73p=3B=26nb=73=70;&=6E=62=
=73=70;&=6E=62sp;&=6E=62sp=3B&n=62s=70;&=6E=62sp;&n=62sp;&n=62sp=3B&n=62=73p; =
}<=62r>
+&=6Ebsp=3B&=6Eb=73p=3B&n=62sp=3B=26n=62=73p;=26nb=73p;&=6E=62s=70=3B&nb=73p;=
=26nb=73=70;=26n=62=73p;&nbs=70=3B&n=62s=70=3B=26n=62sp;&=6E=62=73p=3B&n=62sp;=
 /=2A<=62=72=3E
+=26=6Ebs=70;&n=62sp;&nb=73=70=3B&nbs=70=3B&nbs=70;&=6Eb=73=70=3B&n=62sp;=26nb=
sp=3B&=6E=62=73p;&nb=73p;&=6E=62s=70=3B=26=6Ebsp;=26=6Eb=73=70;&=6Ebs=70;=26nb=
=73p; * If t=68e =62=6Fo=74 AP=49C is e=6Eumer=61=74ed =66ir=73t, =62u=74 =74h=
e A=50=49=43=42=41SE=3Cbr>
+&=6E=62=73p;&n=62s=70=3B&nbsp;=26nb=73p;&=6E=62sp;&=6Ebs=70=3B=26=6Eb=73=70;&=
nbs=70;&nbsp;&n=62=73=70=3B=26nbsp;=26nbsp;&nb=73=70=3B&=6E=62s=70;=26n=62=73p=
=3B * MS=52 does no=74 h=61=76e th=65 BSP b=69=74 s=65t, then =74he=72=65 =69s=
 n=6F way<=62r>
+&nbs=70;&n=62sp;=26nb=73p=3B&=6E=62sp;=26nbsp=3B=26nbs=70=3B=26n=62sp;=26nbsp=
;&n=62sp;&nbsp;&=6Ebsp;&=6E=62=73p=3B&n=62s=70=3B&nb=73=70;&nbsp; =2A =74=6F =
=64iscov=65r the =72eal BSP he=72e=2E =41ssume a c=72as=68 ke=72nel and<=62=72=
=3E
+=26nbsp=3B&nb=73p=3B&nb=73p;&=6Ebsp=3B&nb=73p;&n=62s=70;&nbs=70=3B&=6Eb=73p;&=
=6Ebsp=3B=26=6Ebsp=3B&=6E=62=73p;&nbs=70=3B&=6E=62sp;&=6Ebsp;=26=6E=62s=70; =
=2A =6Cimi=74 t=68e n=75mb=65=72 of C=50Us to 1 as an INIT =74o =74h=65 r=65al=
 B=53=50=3Cbr=3E
+&=6Ebs=70;=26=6E=62sp;&n=62sp=3B&nbs=70=3B=26=6E=62sp;&=6E=62=73p;&=6Ebsp;&=
=6Ebs=70;&nbsp;&n=62s=70;&=6E=62=73=70;=26=6E=62s=70;&nb=73p;&=6Eb=73=70=3B=26=
n=62=73p; * wou=6Cd reset the mac=68=69ne.<br=3E
+&nbsp;=26=6E=62s=70;&nb=73=70;&=6Eb=73p;&n=62sp;&=6E=62sp=3B=26nb=73=70;=26n=
=62=73p;=26nbs=70;&=6Ebsp=3B=26nbsp;&nb=73p;&=6Ebs=70;=26nbs=70;&=6E=62=73p; *=
=2F=3Cbr=3E
+&nbs=70;&nbs=70;=26=6Eb=73p=3B&nbs=70;=26nbsp=3B&nbsp;&nbsp;&=6Eb=73p=3B=26=
=6Ebsp=3B&nbsp;&nb=73p;=26n=62sp=3B=26=6Eb=73p;&nbsp=3B p=72=5Fw=61rn(=26=71=
=75=6F=74;En=75m=65rate=64 BSP AP=49C =25x is no=74 marked =69n API=43BAS=45 M=
SR=5Cn&quot;, apic=5Fid);=3C=62r=3E
+&n=62sp;=26nbsp;&=6Ebs=70;&n=62=73=70=3B=26nbs=70;&=6E=62sp;&nb=73=70=3B&nbsp=
;&nb=73p=3B&=6Ebsp;=26=6E=62s=70=3B=26n=62sp=3B&=6Eb=73=70=3B=26=6E=62=73p=3B =
p=72=5F=77arn(=26qu=6Ft;A=73=73um=69=6Eg crash kern=65=6C. =4Ci=6Diting to one=
 CPU to pre=76=65=6Et m=61c=68=69ne INI=54\n=26=71=75ot=3B=29;=3Cbr>
=2B&n=62s=70;&nb=73=70;&=6E=62sp;&nb=73p=3B=26nbs=70;&nb=73p=3B&n=62s=70;&nbsp=
;&=6Ebsp=3B&nbs=70;&=6Eb=73=70;&=6Ebs=70;=26n=62sp=3B=26nb=73=70=3B set=5Fnr=
=5Fc=70u=5Fi=64s(1)=3B<b=72>
=2B&=6Ebs=70=3B&n=62sp;=26nbsp;=26nb=73p;&=6Eb=73p=3B=26=6Ebsp;&=6Eb=73p;&nb=
=73p;=26n=62sp;=26nbsp;=26nb=73p=3B&nb=73p;&nb=73p;&nbsp; =67ot=6F fw=62ug=3B=
=3C=62r=3E
&=6Ebsp=3B&=6Ebsp;&=6Ebs=70;&=6Ebsp=3B&nbsp;&nb=73=70;&nbs=70=3B=26n=62s=70=3B=
 }=3Cb=72>
&=6E=62s=70;<=62r=3E
-&=6Ebsp;=26nbsp;&n=62=73p;=26=6Ebsp;&=6Ebsp=3B&nbsp=3B pr=5F=77arn=28&q=75ot;=
Boot C=50U A=50=49C =49D not the =66ir=73t en=75me=72=61=74e=64 APIC ID=3A %x =
&gt; %=78\n&=71uot;,<=62r>
=2B&nbsp;=26nbsp;&nb=73p=3B&nb=73p;&nb=73=70=3B&=6E=62=73p=3B =70r=5F=77=61rn=
=28=26quo=74;Bo=6F=74 C=50=55 =41P=49=43 I=44 not t=68=65 first =65nu=6De=72=
=61=74e=64 API=43 ID: =25=78 !=3D %x\n&=71uo=74=3B,<=62r>
=26=6Eb=73p;=26=6Ebsp=3B&nbsp;&n=62=73p=3B=26nbsp;=26=6E=62=73p;&nb=73p;=26nb=
=73p;=26nbs=70=3B=26=6Ebsp;&nbsp;=26=6Ebsp;=26nbsp;&nbsp;&nbsp=3B&nb=73p=3B =
=74=6Fpo=5Fin=66o.boot=5Fcpu=5Fapi=63=5Fi=64=2C ap=69c=5Fid=29;<b=72=3E
=2B<=62=72>
+&=6Ebs=70;=26n=62=73=70=3B&nbsp;&nbs=70;=26=6E=62=73p;&nbsp; =69f =28is=5F=62=
sp &=61mp=3B&amp=3B =68as=5F=61pic=5Fbase) {=3Cbr>
=2B&nbsp;&=6Ebsp;&n=62s=70;&nb=73p;&nbsp;&=6Eb=73p=3B=26nbs=70=3B=26nbsp;&=6E=
=62s=70;&n=62s=70;&nbsp=3B=26n=62=73p=3B=26nb=73=70=3B&=6Ebs=70; t=6Fp=6F=5Fin=
fo.=72eal=5Fbsp=5Fap=69c=5Fid =3D =74=6Fp=6F=5Finfo=2E=62o=6F=74=5Fcpu=5Fa=70=
=69=63=5Fi=64;<=62r>
=2B&nbs=70=3B&nb=73p=3B&=6Ebs=70=3B&nbs=70;&nb=73p;=26=6Ebsp=3B=26=6E=62=73p=
=3B&nb=73p=3B&nb=73p;=26=6Ebsp;&=6E=62=73p;&n=62=73=70;=26nbsp;&nbsp; g=6Fto =
=66=77b=75=67=3B<b=72=3E
+&n=62s=70=3B&n=62=73=70=3B&n=62sp=3B&=6E=62=73=70;&=6E=62s=70=3B=26nb=73=70; =
}=3C=62r>
+<b=72>
&nbs=70;&nb=73=70;=26nbsp;=26nbsp;=26nb=73p=3B&=6E=62=73p=3B&n=62=73p;&=6Eb=73=
p=3B =70=72=5Fw=61rn(=26q=75ot;=43rash =6Bern=65l det=65cte=64. D=69s=61=62l=
=69n=67 r=65al B=53P t=6F pr=65=76e=6E=74 =6Dach=69=6Ee =49NIT\=6E&quot;);=3C=
=62r>
&n=62sp;<br=3E
=26=6Eb=73p;=26nbsp;&nb=73p=3B&nbsp;&nbs=70=3B&nbsp=3B&=6Ebsp;&=6Ebsp; to=70o=
=5Fi=6E=66o.re=61=6C=5Fbsp=5Fapic=5F=69=64 =3D =61pi=63=5Fi=64;=3C=62r>
&=6E=62sp;&n=62sp=3B=26n=62s=70=3B=26nb=73p;=26n=62sp;=26=6Eb=73=70;=26=6Eb=73=
p=3B&nbs=70; re=74urn =74=72=75e;<br=3E
=2B=3Cbr>
=2B=66w=62ug=3A<=62=72=3E
=2B&n=62=73=70;=26n=62s=70;=26n=62sp;&=6Ebsp;&n=62=73p;&n=62sp; p=72=5Fwarn=28=
F=57=5FB=55=47 &qu=6Ft;API=43 =65n=75me=72=61=74io=6E o=72der n=6Ft sp=65=63=
=69ficatio=6E =63=6F=6D=70=6Cia=6E=74=5Cn&q=75ot=3B)=3B=3Cbr>
=2B&=6Ebsp;&nbs=70=3B&nb=73p=3B=26n=62s=70=3B=26nbs=70;&n=62sp; ret=75rn false=
;<br>
&nbsp;}<br>
=26nbsp;<=62r>
&nbsp;sta=74ic uns=69=67ned =69nt =74=6Fpo=5Fu=6Eit=5F=63=6Fun=74=28u32 l=76=
=6C=69=64, =65num x=386=5F=74op=6Flogy=5F=64om=61=69ns =61=74=5F=6C=65ve=6C,=
=3Cb=72=3E
<=62r>
</=64iv>
</spa=6E=3E</fon=74><=2Fdiv>
=3C=66on=74 st=79l=65=3D"=66=6Fn=74-=66am=69ly: Calibr=69, sa=6Es-ser=69f; =66=
=6F=6Et-s=69=7A=65: 1=31=70t;=22=3Eh=74tps:/=2Fwww.t=6Eg.d=65
<=62=72>
<=70>=45x=65c=75ti=76e board =28Gesch&a=75ml=3B=66ts=66&uuml;hr=65=72):<=62=72=
>
Dr=2E S=76en Will=65=72t =28CE=4F=2FVors=69tz), <br=3E
Gunnar =50e=74=65r=2C Sve=6E Schade,=3C=62r=3E
=43=61=72s=74e=6E T=6F=6Ckmi=74, B=65rnd =53on=74=68=65imer<br>
</p>
=3Cp>Amts=67ericht Kiel H=52=42 =36=30=302 =4BI=3Cbr>
US=74-ID: DE22=352014=328=3Cbr=3E
D=69e Info=72m=61t=69o=6E &=75=75ml;be=72 =64=69=65 Ve=72ar=62e=69tung Ihr=65r=
 Dat=65=6E<=62r>
=67em&au=6D=6C=3B=26sz=6Cig; Ar=74ike=6C =312 D=53=47=56O =6B&=6F=75m=6C=3Bn=
=6Een S=69=65 =75nt=65r =68t=74ps:=2F=2Fw=77w=2E=74ng.de=2Fda=74enschu=74=7A/ =
ab=72u=66en=2E=3C=62r>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F </p>
</=66ont>
=3C/bo=64=79>
<=2Fh=74ml=3E
--_000_PA4PR02MB65756F99D066C362FBF45524A7EE2PA4PR02MB6575eurp_--

--NoSpamProxy_6d02dd10-a88d-4c1e-a02d-325b1c3806e8
Content-Transfer-Encoding: BASE64
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExDTALBglghkgBZQMEAgEwCwYJKoZIhvcNAQcBoIIYRjCCB5ow
ggaCoAMCAQICEEAeDHvHFpAx7qaNarUWLBAwDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCREUx
FTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1UUlVTVCBBcHBsaWNhdGlvbiBDZXJ0
aWZpY2F0ZXMgQ0EgMy0xIDIwMTMwHhcNMjMwNzA3MDgxODEyWhcNMjQwNzEwMDgxODEyWjCBqzEL
MAkGA1UEBhMCREUxGzAZBgNVBAoTElRORyBTdGFkdG5ldHogR21iSDEYMBYGA1UEAxMPQ2Fyc3Rl
biBUb2xrbWl0MQ0wCwYDVQQHEwRLaWVsMRAwDgYDVQQqEwdDYXJzdGVuMRAwDgYDVQQEEwdUb2xr
bWl0MRUwEwYDVQQFEwxDU00wMzYwODM1NTIxGzAZBgNVBAgTElNjaGxlc3dpZy1Ib2xzdGVpbjCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOgkSnHtfBNmYB4odwAuWp3NIzwq0jvZAoxZ
WIbc3leIo/NjLcROnu+8ykoKFjFTB3mAaml5fk4KqCr30f5E7O19uyp4gvuYXaQNDshOHlG/oKH2
ldEm8RoDUHgsB9mQaQ+lH7ZYtglo+6+q48EOrM9QHv5vXgyBMgNwyvK9Eg1d6k8D3REOUSLjrex+
7KtaGq7Jm8/7Gb9augFRlogLbtDY4vt0nghd3VB2erI3FWM7LU6zjSESjxgJvAZlFPUq9ORa6ZD4
qwbwO3GScJR6Hi861bCvV9DwOFXi+o/CuGwq9wPc35v4jeBLA5fyP07hV8r156zK8lh8SV6pwkie
2Is0U3PNbYaehl0opt4yk6YuqnbT5jGLLv7N6b2oFRNQO54IP6d+qucmRvvkChlndOTBV47DHUn5
XyQfGSKvlPiHFpFrWXRaqQfsSCi4fUJHrCsJmoupXK4FLKZjo1yXWKE5wd9Gvxfjf9qFAWcLjwKD
L7YY3ftD/xmKlFDYqa8vBPouwtFuHPbKVchGWR8hG2oC8oW/doMFos+jHJxzKLay/OdbcY8aQsP0
sozeEc7TFHtHFp0xQEXYTlQttjkI5pIXYLu0UirUjMwd91X+EuWe6PtyRhoD7HsHcwVHgme9fPS/
IoPij0+uAfdan3coOniHqjIMN5QG9a9sDOclAMQ9AgMBAAGjggMHMIIDAzAdBgNVHSUEFjAUBggr
BgEFBQcDAgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUGQOq2SJFxxpiqedcmbCd3u3UuLUwggFJBggr
BgEFBQcBAQSCATswggE3MEgGCCsGAQUFBzABhjxodHRwOi8vYXBwbGljYXRpb24tY2VydGlmaWNh
dGVzLWNhLTMtMS0yMDEzLm9jc3AuZC10cnVzdC5uZXQwWwYIKwYBBQUHMAKGT2h0dHA6Ly93d3cu
ZC10cnVzdC5uZXQvY2dpLWJpbi9ELVRSVVNUX0FwcGxpY2F0aW9uX0NlcnRpZmljYXRlc19DQV8z
LTFfMjAxMy5jcnQwgY0GCCsGAQUFBzAChoGAbGRhcDovL2RpcmVjdG9yeS5kLXRydXN0Lm5ldC9D
Tj1ELVRSVVNUJTIwQXBwbGljYXRpb24lMjBDZXJ0aWZpY2F0ZXMlMjBDQSUyMDMtMSUyMDIwMTMs
Tz1ELVRydXN0JTIwR21iSCxDPURFP2NBQ2VydGlmaWNhdGU/YmFzZT8wbwYDVR0gBGgwZjBaBgsr
BgEEAaU0AoFIAjBLMEkGCCsGAQUFBwIBFj1odHRwOi8vd3d3LmQtdHJ1c3QubmV0L2ludGVybmV0
L2ZpbGVzL0QtVFJVU1RfQ1NNX1BLSV9DUFMucGRmMAgGBgQAj3oBAzCBtwYDVR0fBIGvMIGsMIGp
oIGmoIGjhktodHRwOi8vY3JsLmQtdHJ1c3QubmV0L2NybC9kLXRydXN0X2FwcGxpY2F0aW9uX2Nl
cnRpZmljYXRlc19jYV8zLTFfMjAxMy5jcmyGVGh0dHA6Ly9jZG4uZC10cnVzdC1jbG91ZGNybC5u
ZXQvY3JsL2QtdHJ1c3RfYXBwbGljYXRpb25fY2VydGlmaWNhdGVzX2NhXzMtMV8yMDEzLmNybDAd
BgNVHQ4EFgQUmt+vjXi3+Cvt5c2c4K5z0sGEhxswDgYDVR0PAQH/BAQDAgSwMBoGA1UdEQQTMBGB
D2N0b2xrbWl0QHRuZy5kZTANBgkqhkiG9w0BAQsFAAOCAQEAehWp//zS4vo3ryQP05smooO/S189
ps5BFa3LPod37Y6ki1k9bmgX56giLfSSL+1G4Un7fJnU32K+IojHr/LtvYsWkFwaoL7w997RG9v6
IPZ7tSQQv/BjCRKDmCeTano/QXyhSovbAyv+iljK6yel+XWNaIjaEV3sfw5s1B+viAfY3eMG2tOJ
kTnw7RbYlyC4KsIF4iDDXkLqFR2irq5kV1DJwYNoDANuqzorfSp5TFge4Btn5H6t5wOH+ZJNqQVL
W6b6ikYbA4AMkl81iMrKRXIEk7ozQv0oUKLuizKrtDGPzK3RNt+undBClyod97puTYSQNRABy9N6
mhUZImUxUjCCB5owggaCoAMCAQICEEAeDHvHFpAx7qaNarUWLBAwDQYJKoZIhvcNAQELBQAwWzEL
MAkGA1UEBhMCREUxFTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1UUlVTVCBBcHBs
aWNhdGlvbiBDZXJ0aWZpY2F0ZXMgQ0EgMy0xIDIwMTMwHhcNMjMwNzA3MDgxODEyWhcNMjQwNzEw
MDgxODEyWjCBqzELMAkGA1UEBhMCREUxGzAZBgNVBAoTElRORyBTdGFkdG5ldHogR21iSDEYMBYG
A1UEAxMPQ2Fyc3RlbiBUb2xrbWl0MQ0wCwYDVQQHEwRLaWVsMRAwDgYDVQQqEwdDYXJzdGVuMRAw
DgYDVQQEEwdUb2xrbWl0MRUwEwYDVQQFEwxDU00wMzYwODM1NTIxGzAZBgNVBAgTElNjaGxlc3dp
Zy1Ib2xzdGVpbjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOgkSnHtfBNmYB4odwAu
Wp3NIzwq0jvZAoxZWIbc3leIo/NjLcROnu+8ykoKFjFTB3mAaml5fk4KqCr30f5E7O19uyp4gvuY
XaQNDshOHlG/oKH2ldEm8RoDUHgsB9mQaQ+lH7ZYtglo+6+q48EOrM9QHv5vXgyBMgNwyvK9Eg1d
6k8D3REOUSLjrex+7KtaGq7Jm8/7Gb9augFRlogLbtDY4vt0nghd3VB2erI3FWM7LU6zjSESjxgJ
vAZlFPUq9ORa6ZD4qwbwO3GScJR6Hi861bCvV9DwOFXi+o/CuGwq9wPc35v4jeBLA5fyP07hV8r1
56zK8lh8SV6pwkie2Is0U3PNbYaehl0opt4yk6YuqnbT5jGLLv7N6b2oFRNQO54IP6d+qucmRvvk
ChlndOTBV47DHUn5XyQfGSKvlPiHFpFrWXRaqQfsSCi4fUJHrCsJmoupXK4FLKZjo1yXWKE5wd9G
vxfjf9qFAWcLjwKDL7YY3ftD/xmKlFDYqa8vBPouwtFuHPbKVchGWR8hG2oC8oW/doMFos+jHJxz
KLay/OdbcY8aQsP0sozeEc7TFHtHFp0xQEXYTlQttjkI5pIXYLu0UirUjMwd91X+EuWe6PtyRhoD
7HsHcwVHgme9fPS/IoPij0+uAfdan3coOniHqjIMN5QG9a9sDOclAMQ9AgMBAAGjggMHMIIDAzAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUGQOq2SJFxxpiqedcmbCd
3u3UuLUwggFJBggrBgEFBQcBAQSCATswggE3MEgGCCsGAQUFBzABhjxodHRwOi8vYXBwbGljYXRp
b24tY2VydGlmaWNhdGVzLWNhLTMtMS0yMDEzLm9jc3AuZC10cnVzdC5uZXQwWwYIKwYBBQUHMAKG
T2h0dHA6Ly93d3cuZC10cnVzdC5uZXQvY2dpLWJpbi9ELVRSVVNUX0FwcGxpY2F0aW9uX0NlcnRp
ZmljYXRlc19DQV8zLTFfMjAxMy5jcnQwgY0GCCsGAQUFBzAChoGAbGRhcDovL2RpcmVjdG9yeS5k
LXRydXN0Lm5ldC9DTj1ELVRSVVNUJTIwQXBwbGljYXRpb24lMjBDZXJ0aWZpY2F0ZXMlMjBDQSUy
MDMtMSUyMDIwMTMsTz1ELVRydXN0JTIwR21iSCxDPURFP2NBQ2VydGlmaWNhdGU/YmFzZT8wbwYD
VR0gBGgwZjBaBgsrBgEEAaU0AoFIAjBLMEkGCCsGAQUFBwIBFj1odHRwOi8vd3d3LmQtdHJ1c3Qu
bmV0L2ludGVybmV0L2ZpbGVzL0QtVFJVU1RfQ1NNX1BLSV9DUFMucGRmMAgGBgQAj3oBAzCBtwYD
VR0fBIGvMIGsMIGpoIGmoIGjhktodHRwOi8vY3JsLmQtdHJ1c3QubmV0L2NybC9kLXRydXN0X2Fw
cGxpY2F0aW9uX2NlcnRpZmljYXRlc19jYV8zLTFfMjAxMy5jcmyGVGh0dHA6Ly9jZG4uZC10cnVz
dC1jbG91ZGNybC5uZXQvY3JsL2QtdHJ1c3RfYXBwbGljYXRpb25fY2VydGlmaWNhdGVzX2NhXzMt
MV8yMDEzLmNybDAdBgNVHQ4EFgQUmt+vjXi3+Cvt5c2c4K5z0sGEhxswDgYDVR0PAQH/BAQDAgSw
MBoGA1UdEQQTMBGBD2N0b2xrbWl0QHRuZy5kZTANBgkqhkiG9w0BAQsFAAOCAQEAehWp//zS4vo3
ryQP05smooO/S189ps5BFa3LPod37Y6ki1k9bmgX56giLfSSL+1G4Un7fJnU32K+IojHr/LtvYsW
kFwaoL7w997RG9v6IPZ7tSQQv/BjCRKDmCeTano/QXyhSovbAyv+iljK6yel+XWNaIjaEV3sfw5s
1B+viAfY3eMG2tOJkTnw7RbYlyC4KsIF4iDDXkLqFR2irq5kV1DJwYNoDANuqzorfSp5TFge4Btn
5H6t5wOH+ZJNqQVLW6b6ikYbA4AMkl81iMrKRXIEk7ozQv0oUKLuizKrtDGPzK3RNt+undBClyod
97puTYSQNRABy9N6mhUZImUxUjCCBPQwggPcoAMCAQICAw/g9jANBgkqhkiG9w0BAQsFADBFMQsw
CQYDVQQGEwJERTEVMBMGA1UECgwMRC1UcnVzdCBHbWJIMR8wHQYDVQQDDBZELVRSVVNUIFJvb3Qg
Q0EgMyAyMDEzMB4XDTEzMDkyNzA3MzA0MFoXDTI4MDkyMDA4MjU1MVowWzELMAkGA1UEBhMCREUx
FTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1UUlVTVCBBcHBsaWNhdGlvbiBDZXJ0
aWZpY2F0ZXMgQ0EgMy0xIDIwMTMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwv9TU
YWjWHdugq1ojOsQw9kcYjgUosouSNYlliHUJJrhRFfyPnZ2I27W2ZxOnAo4yK/TdrBraUQSW+upU
SGkwc7ErjartYbtzh3SWRzt35xOt7F5mUYBnysixdwBK20h/TXTo+TOMdyUpmsnqI3XVOhaSOk8G
wT1Mcon/ZrC1EcNVBOrk517ufVoZrLf+c0h4x/UAt7hD3dfHaCVxdTRmAs9+1FAokXmqXzTQSBZY
9760cCs0FbM+H42GgzMp+CGdH6Q/JSIUd35nNT4VTVcC+urDdQDM+Gni9MpVdL4iCoT1tFlbkLMG
dfJk8UW1u4DdQkc/AqdLRsc2vDoPEiOvAgMBAAGjggHVMIIB0TAfBgNVHSMEGDAWgBQ/kMh9xxVv
8ySPqcMvS6IPIbIv5zBCBggrBgEFBQcBAQQ2MDQwMgYIKwYBBQUHMAGGJmh0dHA6Ly9yb290LWNh
LTMtMjAxMy5vY3NwLmQtdHJ1c3QubmV0MGYGA1UdIARfMF0wWwYLKwYBBAGlNAKBSAEwTDBKBggr
BgEFBQcCARY+aHR0cDovL3d3dy5kLXRydXN0Lm5ldC9pbnRlcm5ldC9maWxlcy9ELVRSVVNUX1Jv
b3RfUEtJX0NQUy5wZGYwgb4GA1UdHwSBtjCBszB0oHKgcIZubGRhcDovL2RpcmVjdG9yeS5kLXRy
dXN0Lm5ldC9DTj1ELVRSVVNUJTIwUm9vdCUyMENBJTIwMyUyMDIwMTMsTz1ELVRydXN0JTIwR21i
SCxDPURFP2NlcnRpZmljYXRlcmV2b2NhdGlvbmxpc3QwO6A5oDeGNWh0dHA6Ly9jcmwuZC10cnVz
dC5uZXQvY3JsL2QtdHJ1c3Rfcm9vdF9jYV8zXzIwMTMuY3JsMB0GA1UdDgQWBBQZA6rZIkXHGmKp
51yZsJ3e7dS4tTAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBADANBgkqhkiG9w0B
AQsFAAOCAQEAEI5Q+KlpA2RO6GWk05CTyUMKd07Rj2e43z5j32b+h191QM3YyY6DQgI9VY3KD1sg
d/HK1GQ2UXMKtzsH0qbM8ACK7tTA5eXd2dGsUmmW4ZwBucMZGvVKyC9vYcOZnCVTYrtOkw63pdrI
WSJ5/HmrhYLrsFtVwg8PUhna17QdF2Z2HvOEjPYfDX5t+7PNI1/z8lFiiMjLB4ar24O57jnKFUOX
zo7cYlo6mGMNWblzuZN1aDXFsnbjg+GalAfeHWz6R8PvquDibAAhBrdCR9fYGowRz0BKJabUv2I0
DRnieD22K5Wbgsko9UDaVmmnHv4q2ZWa/T+W/7x4YrA+/DUeVTCCBA4wggL2oAMCAQICAw/drDAN
BgkqhkiG9w0BAQsFADBFMQswCQYDVQQGEwJERTEVMBMGA1UECgwMRC1UcnVzdCBHbWJIMR8wHQYD
VQQDDBZELVRSVVNUIFJvb3QgQ0EgMyAyMDEzMB4XDTEzMDkyMDA4MjU1MVoXDTI4MDkyMDA4MjU1
MVowRTELMAkGA1UEBhMCREUxFTATBgNVBAoMDEQtVHJ1c3QgR21iSDEfMB0GA1UEAwwWRC1UUlVT
VCBSb290IENBIDMgMjAxMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMR7QpKCH+zt
VJiOEsDKCd+TbjqTXBvkEHeeTmmIbPbhafL2m6Jhsb0HIHSYZfGMJgjNqDXKgDbRY23oRHqCw2xe
3rvoNtLEaDaMnzK9hCLg3MLuEEY5ba+TOa6H5sO8Ccksa2db2Zt2dUwL4LvF17w+efJfvtGQV/mu
9mZfMb/TbY+nukrzI2W7t++jJdcK6li274j6+nmyUljV8KyMoVF0KZWqUTuQMgOfHHJ0kN497WHS
5eP9ZEflubdKqfcfrpaGBKwv46SBd7daFv/YDz/2t3jMpK/6WzwSW6hSiXLviPPVRIGGlSOfe928
2TTvfJQ8qsBBwuOdUBrA5Bki/LMCAwEAAaOCAQUwggEBMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0O
BBYEFD+QyH3HFW/zJI+pwy9Log8hsi/nMA4GA1UdDwEB/wQEAwIBBjCBvgYDVR0fBIG2MIGzMHSg
cqBwhm5sZGFwOi8vZGlyZWN0b3J5LmQtdHJ1c3QubmV0L0NOPUQtVFJVU1QlMjBSb290JTIwQ0El
MjAzJTIwMjAxMyxPPUQtVHJ1c3QlMjBHbWJILEM9REU/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlz
dDA7oDmgN4Y1aHR0cDovL2NybC5kLXRydXN0Lm5ldC9jcmwvZC10cnVzdF9yb290X2NhXzNfMjAx
My5jcmwwDQYJKoZIhvcNAQELBQADggEBAA5ZDljkdEgjRM80IbWcFBqtmku3s4htXKkXcPAqn417
+XuF+sc56BAIsDUrX88C0tOcyAse7gVUrjeTBAl9bI/CdLz4HJS+MQFALfMkILeEVSxcyPV0ShAZ
i6PH7TXWCUjTDsC6OaiwRgKw28aIWcK+/HuxK89+YodVlswBb5tnIZU1i/gQ/HEbt0s3aaY71uyL
7sGw8yXJj5J9oerDykS/JqV0kpzjdOuddNnLTYfY/LRpbIugQwdgeJfp2ZN8wka8mzdSo+2KPBOp
e1NLSZoRBSwLblasHy6CbOBpZ7UObS3Z5MAV8T/6GHLhFW0nWy0wKCufSJpkK5nv8nVJX1wxgDCA
AgEBMG8wWzELMAkGA1UEBhMCREUxFTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1U
UlVTVCBBcHBsaWNhdGlvbiBDZXJ0aWZpY2F0ZXMgQ0EgMy0xIDIwMTMCEEAeDHvHFpAx7qaNarUW
LBAwCwYJYIZIAWUDBAIBoIIB+zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA1MTcyMDEzNDFaMC8GCSqGSIb3DQEJBDEiBCDJkEC+KHaXO53zMNxmGRpeMIg5nNfZ
plztPRiDJ5haWDB+BgkrBgEEAYI3EAQxcTBvMFsxCzAJBgNVBAYTAkRFMRUwEwYDVQQKDAxELVRy
dXN0IEdtYkgxNTAzBgNVBAMMLEQtVFJVU1QgQXBwbGljYXRpb24gQ2VydGlmaWNhdGVzIENBIDMt
MSAyMDEzAhBAHgx7xxaQMe6mjWq1FiwQMIGABgsqhkiG9w0BCRACCzFxoG8wWzELMAkGA1UEBhMC
REUxFTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1UUlVTVCBBcHBsaWNhdGlvbiBD
ZXJ0aWZpY2F0ZXMgQ0EgMy0xIDIwMTMCEEAeDHvHFpAx7qaNarUWLBAwgYwGCSqGSIb3DQEJDzF/
MH0wBwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCgYIKoZI
hvcNAwcwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBjALBglghkgBZQMEARYwCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBLjANBgkqhkiG9w0BAQEFAASCAgBCdBIU9elEI9pHb/0QWR+SS64yVooyR/Pn
4oksApVevoYGLEWCduXu7MOi997Y2EEHa1SSFgK1oR4LAS7/Wx4xICk+WUPZ6X99m6BkKCOL1xcU
+5l6urofW/9TJgOG0Gt4TCiRSbTzlXtsAvZRnEjlCGgZqSh3rqaypW35nZDOJMQjzjOCOpDGJQ3y
ZD6Pf9p2YFoT03ujDciyjm6pZ7HUulhFUAGHd5o/R97T04fXbmFAkC14u+gRy7kHiGYcRmECTPeZ
8rckvGTT2HXTBAiU5XRIAn0AAe+G+MCTfPu11XVOv65LeMm1AL81p4aFO2cPIoR94KezPK4R5FbJ
8QoxIAI9aKxeXKqI5MHUt7EPJJ0oKAeaudi5cwuPHgwp/2mUAnbKKip1TsQl1I6+H4WGFGyDaRkc
MAqSbqhSPhvO/stXzzn3rhVPcRM3TnL5QOze4Hx2OzCZDmFLXAT/YAlHXqpuVWj/6HxKEKiWNHyE
aULFMditdnKJgdRk7PCCmmS5f/VXblL7SuVJWuvT++8PCDXIQm+BU7xQ2qozuoVNgZ3L3X7wsYOB
jAvZePZaBAsl+zffOsAkO1TH7Rc8PFsnM6E9fbg8yZK2skZI27CS1c/pCse0QBHGMAQdsGcldyL5
dxiOzGIwTeYvjj3x90YHRIb+7Slf75H2qXPRW8rI8QAAAAAAAAAAAAA=
--NoSpamProxy_6d02dd10-a88d-4c1e-a02d-325b1c3806e8--


