Return-Path: <linux-kernel+bounces-360766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8D999F45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563AA1C21F31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877F20B1FE;
	Fri, 11 Oct 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="bEZWTI5p"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2110.outbound.protection.outlook.com [40.107.249.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9A282FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636527; cv=fail; b=hmAthgpNN0G5LTgFOi0w9kD/86abew1IQnTGd9FotIqefBXll+Fyq05zTml4PPEKZgsvrMNadUHN2TqldXHkCdQ4O6f6Oz5VIPWnZDM+xyUe84No7sLEhl+us11EaPVjB/uuYGt5qyN7joo9Py2lpJ4tixp/8vsOdnfJvmcw9nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636527; c=relaxed/simple;
	bh=RKhEeqDeH/ACcaDEXWT7RVKsDCl52MXBUSSPT5oxzQY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H07mzWQP/PXsIc9AtixIDopnfapcRlz4HEUnwCGDiJFG6MVsy4kjWmVXPD8wKXXb6hz1vytVKaCzIXsgDgPYPrbeooQNjkTEhUSOBu6ToECXNnDAnJGfgYBNAq6XgkHcCGoAeqEhCpydqAzcViEniuZr4Jyo+oZcaL94AzeYYwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=bEZWTI5p; arc=fail smtp.client-ip=40.107.249.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elpRSElotPRBOeTvZdJRxbar72XpcbrJW+PyteGJbILnQbFQVRZv21bmSkcBO8dcq6Cn64y4ckN8akEjEd1iMiNJDYkYPlWFo+ICSerrn16yHSwx85TwAEl1hnFA1wBdwY6823kpq5aMXenQDgviAQUoWghVl1NK3XA8n1toEP2an6U1QBAhHKwHraWWbj5Ptz2ZDUb0w2LHBWW0UCCJcvRi1DRkRXFMR5+frhtSsOsgxHxyDO0H6VWLOxsrAy63Y3Os+HkBbMJXAX5J0uMbT4AUiwp+U7OlJUoa90bidBbB0WQLb71tz7YksrooZ3EofwRjbPxjKf3fVIl5EdCuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhEeqDeH/ACcaDEXWT7RVKsDCl52MXBUSSPT5oxzQY=;
 b=nrsyaqQgwn0PmRVLJiP9WhZNkRYb8eW+izPw/gSo6gWBrLCzNGmCOH7e0pTKsZUjIftv7yJ4zGvgH588W3IfrvspWYeuo0AdsUONZ52m3bxhOvrWf+CAr3dzhinFwaCWMSqiM/i5y07l2GaXEFKMxvYCSERmW78Rqz9ajyuJFPosnNFN1oQAmjXtZodblr431cD0j0Dfd5np1oe3u08pBGP3l8gA2H6IvkTScIc1O/Y6xbTnS4xQ2LWunq9i8CUFVlYltjltCdRR0sNpvcj3aSUfd05KugSkRgiy8NCudqjKBrTz5NUqgC1sML38yNkduPfgVTxF3kUJ/o7awkTa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKhEeqDeH/ACcaDEXWT7RVKsDCl52MXBUSSPT5oxzQY=;
 b=bEZWTI5pEthdtggvKQ9DPcSwHo3lA5ccYY5kSCGOZIsKcuAASH3rjxqEBE1NmyfuEWZ+wqsbj0WeqhHKIsvz/4crbh5P3WcDLF0iHrg2DE89RRR+o6x4/B/LVKulZ2uB91w1cVCT8S7bi1HtJ7dArqhVbHqQEDcqfkWYaRCF/fIhObet5x4cm6EHL55yj2p2P4sod+AZJxQg1gYuw1bPLxRj41MUu+bJhZdk6k5Q3MxeVeiV0fzpJ3NCU6n7qOY9MXySGWCdcvFIxcrgdOo2D5u8Vz7+FlP6yJ23Hi12cezgoqBNzubeYGHNCCdGE9z4bOSipYB1LjaGZsjoU6Ujgg==
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::14)
 by AM8P192MB0883.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:48:39 +0000
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9]) by AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9%2]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 08:48:39 +0000
From: Joel GUITTET <jguittet.opensource@witekio.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bad commit backported on the v5.15.y branch ?
Thread-Topic: Bad commit backported on the v5.15.y branch ?
Thread-Index: AQHbG7m9FAVCOgG+30u3iPoW66Acag==
Date: Fri, 11 Oct 2024 08:48:39 +0000
Message-ID:
 <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P192MB1316:EE_|AM8P192MB0883:EE_
x-ms-office365-filtering-correlation-id: 50034d1e-8d3c-4b99-2102-08dce9d1807a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Xn7uE41lpnInsWlaVjYkm/kliPdLnCnIJst0RWXfUdqqI5j5AIm+JSQSW1?=
 =?iso-8859-1?Q?Dvij6LhjK8t2Ya8q3pkJ5nRaXjk1FyDGn/UvTHuijwWTUXrKEIob6EqxLK?=
 =?iso-8859-1?Q?MOXYtH9P5twvaRFywNRt6TVPpoZwE7VoIzqM+UW+Pl2acXEXgsv2ko2b0z?=
 =?iso-8859-1?Q?MPbpPWntAcvkQhraggUu0VamKiNQ9LCKq6utl6ScT3/nNpr+evUH1DSFwd?=
 =?iso-8859-1?Q?3XDuw24R44Eri0K3lKV85UQq8PcqeW8vwa0lP2wcQ9mSC7EFm2PTqghiyF?=
 =?iso-8859-1?Q?fbVDRqB0ZjQEslADTyOz0lk0b8Gvys1tOXttuNymoJjDRJxsj5lvrBI87D?=
 =?iso-8859-1?Q?9ofVX42HtICwYz+0QzJ6irC+xnx7uAHMy6voksbeqrvKvBHe28qJoY1WhT?=
 =?iso-8859-1?Q?mi1N2H2m6abKqFoNsKpw593RvC7jxfI6xFhODiaXXmG8gKljVGtUHMtSfu?=
 =?iso-8859-1?Q?sRw0p5eHBqG1dkvd9P3m716S2o1WepFF/5mrFhGOARwUUWBzBUFk6zxA8N?=
 =?iso-8859-1?Q?wLisD7fbhgQNNO0QDQeWoduabUjnveLwIPh6GgoeBbvdX2cwuGvyLeHgxO?=
 =?iso-8859-1?Q?KhVsXcHlUShj1RLXj4qvKtzwL3mgI1iX3rah9Pa22hW3yYkQuQIncEsc3Z?=
 =?iso-8859-1?Q?x+HlpfSFTHadwkJ/0mhic4fAVKJ03wSz4uZ/ba5gg5e6p7GSzbaHujLMO6?=
 =?iso-8859-1?Q?+zgxES2argxK9TEY6wArFF1Wk833WIBeR8k/E8JHs83Qz07DC8l7UErGvM?=
 =?iso-8859-1?Q?uRo9cV0eYpVOTLzb6psN7QOqFjT0MIgUu8Vpy6+UBV7iVQIyJWffb3JVpg?=
 =?iso-8859-1?Q?dUEZYDRr0OiNna3NOsGTfZoUufcqh2t0q1DFL81WvPNY79DeVxmyoBEsm1?=
 =?iso-8859-1?Q?vbllEYE0GjCCbnfpBxgInNVRkCcA19aZdTJ0Ph8N3avAKg/Zkx8qDee0fz?=
 =?iso-8859-1?Q?nPudNTl8qc4Jnhpvj1ehOIeDTvd9nFZsUtWdIvf0ARnznMx3yQuHu0lRdi?=
 =?iso-8859-1?Q?WLLdogHq//xW4iSuD1WtIgUQkxIa+d1mJDej/SLBO95ny3gfhdBlihH/GA?=
 =?iso-8859-1?Q?5+bo7AWGXZ5h5NgouqBXflNcozmk3hK0fWYpnpVZbmStKOQBqQo3SMhkcr?=
 =?iso-8859-1?Q?EpPkrnQhPJaqAX4D93SlGTvUsViC8E2Thdn/PORSEDLMRi7ALfKgl9vGXI?=
 =?iso-8859-1?Q?9PDp1le3xljCjw53rHr3byuiXDyPKSxfl7TrStMf/ZmerSf+/haOhMjd+Z?=
 =?iso-8859-1?Q?qny/9wOM9Frua2KiJ/sNwzwpaX1WYysS+QoQWaMOKwfiWPhIMwf7vV34ol?=
 =?iso-8859-1?Q?MBMu8VrXLHqp840UcWESd11II+apQ+j6d+7jHuQFs0lFpHSB8wWAqHVQuW?=
 =?iso-8859-1?Q?NLgqvnZTbK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1316.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KSFMUiZRL/zhq9AMVzQEP5rwXRaua4IvvLxI9EvfAohLhEJ99kp0kiao9y?=
 =?iso-8859-1?Q?Z6OdetLlHO8aiPNzJTAThLDsN9R5CAvFaOr6z+6fnv28Id1WRhMG1JwyqS?=
 =?iso-8859-1?Q?wRSYY5iXMoeapM3HQtP/yzG6Igtt2iGElprfL3B8ulOZaJWMXrnDBy5hbn?=
 =?iso-8859-1?Q?J9nQpCgTmFoTOgs9HdjvHEnKYO9shvWjEzMpefPCG3J861tc8EgqKhbpdr?=
 =?iso-8859-1?Q?gfAKolj0ryJTUXl7KPUsWrkKZQzmIcdcMfcL1djR95/ChQ4V5/rqOOT22D?=
 =?iso-8859-1?Q?Td/P+GsSJYxkblkNrTjk5m66tzq6kzoTNuVMk8NKQKQNwYKCdsvM9xVcDO?=
 =?iso-8859-1?Q?OF701tljXJYGPThLEaQCQimfxCG+RbIq0S1e86zfzHxzo29+VirgowunhQ?=
 =?iso-8859-1?Q?Catj0qef9Qjxaah672sfQRZTDljNDzwgxfFHZc5W/9Xd0ItvbkASJJpiSm?=
 =?iso-8859-1?Q?ZAMfFJMG7wgwhuIWKZPhLBt+Tcb3F9QJ+2JtiDVoqCj1ldE02CMC5A1kBX?=
 =?iso-8859-1?Q?/HGVnPpPK6LSn+RmewT9s4iCca8XEZlwqr9FcAemqW0nhNpRI2a1YozEe7?=
 =?iso-8859-1?Q?0arGeuhCiwS+j026Ua3o9CQKTjZXUADa9gYHD6L9sp66s/Ohf7BW1ZfBqk?=
 =?iso-8859-1?Q?X/eqL/RXiVqBGc0wFYMICY11JWesXQ1aZCm+x2IyzsSEavmOm7bqB+ca2w?=
 =?iso-8859-1?Q?vPxo6A5xjvwuIbaJN1+EK8XdyNc6x+sg7GsrTjSLnSMN/i9Vv6QK/emva6?=
 =?iso-8859-1?Q?zTauPp4BheKoagYMSItqTaCMxsZe4lk4RF7LZKphUVTiDUB+xKjQo7GpSd?=
 =?iso-8859-1?Q?hh197C3Xly6D4tqaiKGtvXeFE8puXrnA4G8K59jYDAy8po7O7Hjjs5kRtX?=
 =?iso-8859-1?Q?lp83f6cqaPbyNvfVRR7FBwWBmHh7cLj4rw+Q7sBq+t5J9ZnWX3xN9HxiTs?=
 =?iso-8859-1?Q?XIXmNKTgKILvuZ+XByxnAyuNBzdZOTQpNI4F67aIhB4wcPezYSt1hXM+Eh?=
 =?iso-8859-1?Q?fy2/prC1aZbdYYKns6cnwQU49Xy8o2OkoTChMJEKro4dId8v3KWLjdnMXo?=
 =?iso-8859-1?Q?7nOc658jdsj8lZd99x0xwAuo71GhQFuJrJGTOV9fRZedllyQoGMU9Q5YD1?=
 =?iso-8859-1?Q?B9ZoavTsT5OGph3mJc6W3aYVQ+0erga4a+vBvOdDtdHrzDXFBCjxWucucm?=
 =?iso-8859-1?Q?jXJ/Sc8YzScVMszVcPAW9oUug1br0gY9L3TWI45a6UsWYRKatrZT/cuFGv?=
 =?iso-8859-1?Q?5Txw2lKKPQ9VhuyOCeNAds6kfPHCWpK439WRRgt8fU6ohkMcwgt8d7f3wM?=
 =?iso-8859-1?Q?EulzSvD8vILuEmhFzEhNVi3K2GBfNjcaEHuWmDfLHRkHKXS4hDfUxwrpT2?=
 =?iso-8859-1?Q?/f3xprUVJlRC5TcY3tMmp2iWX/bJgBmt3b786G4bhkzyWAazPcLtUN0hY2?=
 =?iso-8859-1?Q?7KZMRj3NDIqB22pssqKqNWFxhmFWCtfEDz4iV60QXkGuUNoXFLkGv84bpy?=
 =?iso-8859-1?Q?JLL7rEcfNu9VIKGoRU9yLCPgECjLguyL38wDLVSAsmoZdyszwL1EEA1Fg4?=
 =?iso-8859-1?Q?swkWAm29pTseVY3NFGG3kxmpRVeXMW1dBjjFI9jlAwNJMqa/bW0L4yFzuv?=
 =?iso-8859-1?Q?+RgSoKEnkQYDlsBnrGVysS0PRAOZcWo0XIu5MWTWJUP1k8dqob74OvZCNK?=
 =?iso-8859-1?Q?HhR1sdpgd4AWdNHMvGCl6zVO+Ow6J/7OVRtrktll?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50034d1e-8d3c-4b99-2102-08dce9d1807a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 08:48:39.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3woMzgbooMI1GTWwSVk4xhmszwdcbK3ezS2jf+tsbaQRLi/zbyZgC3sveko9QHneJIHxBB2YUsh22s0PTCbVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0883

Hello,=0A=
=0A=
I faced some issue related to scaling frequency on ZynqMP device using v5.1=
5.167 kernel.=0A=
As an exemple setting the scaling frequency below show it's not properly se=
t:=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies=
=0A=
299999 399999 599999 1199999=0A=
=0A=
echo 399999 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq=0A=
399999=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq=0A=
299999 =3D=3D=3D=3D> Should be 399999=0A=
=0A=
After analysis of this issue with the help of Xilinx, it appears that a com=
mit was backported on the 5.15.y branch, but probably it should not, or not=
 as is. The commit is 9117fc44fd3a9538261e530ba5a022dfc9519620 modifying dr=
ivers/clk/zynqmp/divider.c.=0A=
=0A=
Is anybody reading this message able to answer why it was backported ? The =
information I have until now is that it is intended recent kernel version. =
Dependencies for this modification is currently under clarification with Xi=
linx (maybe another commit to backport).=0A=
=0A=
By the way, reverting this commit fix the issue shown above.=0A=
=0A=
Thanks for the feedback,=0A=
Joel=

