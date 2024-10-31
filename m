Return-Path: <linux-kernel+bounces-391354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C69B8581
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB69B21341
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF321CDFD4;
	Thu, 31 Oct 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oZIScQn/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD81CEACE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410932; cv=fail; b=oxdP/v8qk5+Md0nzJt/h9CkOwUbFGpmr3S4r8rYfQQeIt7JdAMgKpn0QhDmSG2Y4W5GSuB35vu/Mj2ODe9pKNPMBqYw/MXlaqTuAR+MHCoBpBGZwoK1iBrRPXcFagYcTm2UpdueO0RrAiytSVtefHenLoG3cJj/KPx7S6ILt2/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410932; c=relaxed/simple;
	bh=v2Nr7nug1u/14x9sOqwOn3zx+I9C2qMJNV2Fm9G/XJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=in2RLyWw/b68oGhEYt/TK5lVsNXUxT5SUTIBtcP3wqBm+658Q4sQtmM6lef5yPw9+PN2YzLbUkInNBYfH3rH0m7xF6sFnSekzm2HMMfbwmL/61PCReJSxQ9e0DWj1n0eFK7bInQbTVzEHBFqA58brOftWSAG5Seuix+ZRUc7mQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oZIScQn/; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIuexvhj+5C5nlHIwRgvcIjdGHYf7FVUglzMwz5j7kX8Vsg/Fu3djN4Oe+2yG30enAr3pesvV9OlQXavwhQ1WLHmbye5779jMw/18sAX+xQg2zzcOzhg1jsIoQEtrmCtAVvr043u2dPawuI+AtrK5316WimW+/aYMc+VfcSMQn7nlV70VdPWMhNUcPS/bLakuti5PMYGj1XcqEl2L0Z4zyYH0KA3h+U8z0v9YJZSFrH6G2XXxnQS7hIBbf1L9mOFEZmO6C/JBe1qmpsvsn43xfMfioxnaYku60Dim0uTBglpf1gzDiKYyHe5LiKT5Mfz9ZXhhtpNmFvwChNT9dJ5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2Nr7nug1u/14x9sOqwOn3zx+I9C2qMJNV2Fm9G/XJs=;
 b=nrAiT124L41+Gig0IA1aODpzcbAlHO2Asqez8Oc0rK8XnC6HN8OQfboc0HldqATqR/M9lNTNBWLpI311zEs0ieAbQ65swQ/+K2UPOUDPmmQ+7P5Qff9/FGyIBATGehm5GXivchgB1rGqWR69pyOPIJmSml2vilF//LXRBD9FCV6GGGuJ02hzR1Pj1FbSgQe3eP3qWScBUCHeMWlwWjLJeaARO798ln1KMGRp/XKd4kZasc535MMiZ4ZqdSmYcz8bhfBOTVau+aweYX5t6LwPKOQwuKtOCI7Awl2QTM8m4FDn0Veg5UoUaWhFsA3Vj20sN9y2GxtQVRcYEFzJo37vIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Nr7nug1u/14x9sOqwOn3zx+I9C2qMJNV2Fm9G/XJs=;
 b=oZIScQn//2xvie7BqhIRvoubqH4E5hiCE1LNaVMhy932tNCfEkILseWT9OFF8k3vTUrs04pceeg/pbZvD8d3y9FVSmFaf3V7aOdQKfT+9YreZyAAh63XFlOV2R66EF2TGyVClpHqBzfVh8h3tRCtC5WeNsLVXAGQ0AUse1IGLeI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 21:42:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 21:42:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Nam Cao <namcao@linutronix.de>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook
	<kees@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>,
	Will Deacon <will@kernel.org>, Jon Mason <jdmason@kudzu.us>, Jaehoon Chung
	<jh80.chung@samsung.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jassi Brar
	<jassisinghbrar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Andi Shyti
	<andi.shyti@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, Rob Clark <robdclark@gmail.com>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Zack Rusin <zack.rusin@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Takashi Iwai
	<tiwai@suse.com>
Subject: RE: [PATCH 00/44] hrtimers: Switch to new hrtimer interface functions
 (4/5)
Thread-Topic: [PATCH 00/44] hrtimers: Switch to new hrtimer interface
 functions (4/5)
Thread-Index: AQHbKQv9NYYdIEeN2kWvoDdMc95bQrKhaPIQ
Date: Thu, 31 Oct 2024 21:42:02 +0000
Message-ID:
 <BL1PR12MB5144F0126E20F6480F8345FEF7552@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <cover.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cedb0a4b-4086-4d71-ba2a-fac8a1d67fe4;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-31T21:40:43Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: f9526243-dd81-4468-5d32-08dcf9f4db4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm5YOExMV3M2Sm85K2czSFJWTzk2U1N4bjZOZ0QvTWtIY21WYnovMytWWHow?=
 =?utf-8?B?eng5YVB1YnVlaVl1OW5mTmlYRVd2SzJHUWZZcDlSMG0rRmdjYndqTDN6dEY5?=
 =?utf-8?B?SG9KT0ZLNUQrdHRnRnZZMEYrbHpZNTFNc2ZUaHVXdEhxczU4RlUrc0FBOVdt?=
 =?utf-8?B?M1R2Nlg2ZlVHQlBJQWU2aFlnMXFvK1hrVFlBbGNJTTZjSG9uS0JkUE1nU2g5?=
 =?utf-8?B?d2c0L1pYTWFPR05NY1NEQU12UkFzV3NNNWhqY2FGSXlOeWk0TjRFczViYVpN?=
 =?utf-8?B?czVXN2JnMzVNWHpYZ3U5WU52UEpGc2lUWkMzdEVaZUVHQXJrTHpoUjBJaFNn?=
 =?utf-8?B?UWxCSUdrUDFidWlvUkFvUmQyeEdsdmVzS3pBTEFmTHB0WmtlclhOZVhtK3dh?=
 =?utf-8?B?UHhKeXhLU1lDeUVQYk04aEp4QUVuWlJtQ2pMVVZtTnpqSGpqMGF2TGFVM256?=
 =?utf-8?B?dUl6MjlXSk51OFo0RmxzWnhWQ1g1dTFHK3MyVzhmYUNLUlNSZE02Y2pERkNM?=
 =?utf-8?B?bXlLMi9ScWRKVCtTMkxWcjRMc3h0VExDMDFVc0F6L0NVQThlakdOSDEyUCtm?=
 =?utf-8?B?RDg1L1dDYzRBMFNFbTBaMUZFNXlsVCtIbDFaRFMvWjJqWEE1UzgwZy8zYTl3?=
 =?utf-8?B?ME5jdFNLYlFlM21PRFV1SGVBZlN2K3hQU3NGNWE1L3pyYk1NVFl3UFcrQU0r?=
 =?utf-8?B?R1JhTUFTS3lIV3dBR2w2cEE1dm8rYVVhTUVCczRaWWhzRWpFaU80OHNCY0Y2?=
 =?utf-8?B?b1pDR0FuTFdVSGl5WHViWVIxTmFkamUxVmI5N3dBeUJZcEtLWFYwbVh4WUtY?=
 =?utf-8?B?eklSRGpycGZUYXEzVG91RzRkUmhZclkyTFRNVXBuWHJUMmwwM2xkOGhTSE95?=
 =?utf-8?B?TzU1UmJHaVZuWC9QUUdIcmhrK2pjWGFrK250T0ZCY2xDbkIxOFRvcnI3R1J1?=
 =?utf-8?B?YzVPNS80LzJqUzh0QWpZeEx0bmMvRlh5aFdmM2c3RW8zMWVZRkhPcGNjZ0VQ?=
 =?utf-8?B?R1hQS01lMDduRnR1MmhJNHlQUXBYV244UmtLU0w5c3gvRjZWM2g2cSszQmZh?=
 =?utf-8?B?OW5nNkJFVmo4Ynh1TE9iMFR5WVBjL0llWVJQU0s1YmRnUlcvNDU0UHN0cVBn?=
 =?utf-8?B?dzJETmpXdzk3ODZOZSt6YnpUNzd0VVU4RXdtWXNDUHNLeEpSUUNnYWZ4c3FK?=
 =?utf-8?B?eXRqNTJlRXZwL3ArYzdVUmNWK0hzaSt5TkM1bmlqcklGNW9WTU4zZWVNTXM3?=
 =?utf-8?B?WUU5eStCQnlUc0dVRnRXUGE0cml2U3NuSi9NekVsNHpTb1VRYVJ5NUw4VGVt?=
 =?utf-8?B?TWJ1cVBtdmQrenZsSWdUNkhHTjA5YXhpQnlwc1RKY0lOL1M4MG9hZFNvdDg0?=
 =?utf-8?B?cEdVZE9FWWNqU0ROSXp1Z082cUpITkZVRUViQnN4T3hxOWxBKytWVlBqRkky?=
 =?utf-8?B?REpVdURmMEY1aE9jQXRCbCtXRDgrL2plUlV1NW1ZMGhaWWNBOFBTRUdkZGtZ?=
 =?utf-8?B?VFFCeXZHWjJydHhaRWNPK1cvL3NUeHJlL2FUUWlKdlNIUGRyU09OYVBVdUk4?=
 =?utf-8?B?VmFJQUJmTUNQUmFJUzRGR0dhb3Iya3E3elFIa1FPNWlLaXdyM3A0cEhEUkdk?=
 =?utf-8?B?aTZNWkhoRVZKcGpHMkJBK3NkZVFVbjZla2RoMUxrRlRQbkhrWjhZNG1GUHE3?=
 =?utf-8?B?VVBCT2xZeGRBbDBzNC82d3Q4QXBNUlFjY3VVdU5EYzlxNndMUjZpUFgvdit5?=
 =?utf-8?B?Ui9LM05uRTJYUFpXTThaNXRqYjJ2QU9kbUlraEk1YklaQVY4ZGhxRGZlREt0?=
 =?utf-8?Q?K7J/rUgd259MxTKX3PLiPqHRjRcxqiMBEkrB0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlVpRi81a2tQaWV2OTBLS3FmWHVxYmxTSnJueCsvK3FhTVJPZE5aUmdMeE0y?=
 =?utf-8?B?a1ZpQXBtR0VOWmxPdXY1cFdId2hKbEU4UHpxUkVJa2pKLzlxSFFUaTEybC9y?=
 =?utf-8?B?ZytWUDJWVXhadHpieXBTLzFnbDlNNTlJM3lISUJWY25QTkswMVc4c2x1RlV1?=
 =?utf-8?B?cnMxUk9BVW4rMkFlU2lrTzRPN3ZzcC9FbjVQRldGSjFEUll0NE9CTW5ZUTNI?=
 =?utf-8?B?S012VklGLzA4WWMvWkdhNHF3dmZTSW9USllSWkJScldGRWtVUXQvYytwTFRn?=
 =?utf-8?B?VnZVd2h3VVoxYnZFdUpkZ0ZOSXZ3c09qajZXb256MndWbk1nR0IwRTU5ZVdU?=
 =?utf-8?B?Nk5GanUzdnFOTUMzTWtDYmYvanBjRXBROHdQcGs1VG9oeG55eFZXNEJzKzJJ?=
 =?utf-8?B?ZXBlZ3FkUmZkczI4VFhuQnRrbXVIMG90Wnl4blkxaVdMM0NJQzhScEJkNWxZ?=
 =?utf-8?B?UVc4ZllSQ2I3enc0VzFzVjRDdkNYKzZ6SWlVd1ZjOWljMklBb0FGbm02NHNq?=
 =?utf-8?B?eVZzQWdpaHRRWUIwbGt6MEthM2JKL3pnY2toOTA4M1FCMk9MZjRnUG5jekJ2?=
 =?utf-8?B?aU55WWwvYWdWOE5SM2JxVTJTU1BhQjBtcGZpb0RraFkvOTY3em5Eekl1cHJo?=
 =?utf-8?B?YmpLTU9LYnVpd1ZWV3RKYmhmTWtqWnE5OEk0eTFXSUh0dWdMYXA2TExxMWdr?=
 =?utf-8?B?ZlFEVXZpTFpFcVBUUDZGZmRldW9Ib0I0a3lMM28yQThiZnBiZEFZdHRiL1lk?=
 =?utf-8?B?VldaQkttS0t3czl0bTltaS8vQnNNald5Znk2QVU0UVBlNkxjcWsyeVZ4TDU0?=
 =?utf-8?B?bC9xdG8wckppRS9kL09IMTFoWWxSeDdlZUZNZXhOTnhVWUFlMk8zY3ZDTk5j?=
 =?utf-8?B?ZU5UMktNV2FVUFM5b1k3YldPbWRtc0l6dFRFNXpuWVdCamxtSnlYUWVSSUVL?=
 =?utf-8?B?aFg5cStMdU0xT2VyTUVLbHdRQ1RZcHV4aG5MS09ZM1psdnNTVng1SGRpaVVl?=
 =?utf-8?B?bXQ5elpMZE5EcGZsRUhoYVhmemhGTitlUG1GOTdzdjVqTTVnL0d1V1FQbnVP?=
 =?utf-8?B?STdKMmpGc1ZBS0lkWXJQUGV5WVlTM1dxNEhIYkJWRHJwTG44WVVtNFN3cVYr?=
 =?utf-8?B?SGswWGZZaURhWlBadmhhODRVWHZaUktKaFR4YjVaeDlEcUVray9wWm13Qld3?=
 =?utf-8?B?K2Q3NFhrV1F6bWhTYmUvb3VScklKdmRzTlVSdTJBMUtOR2J5UGM3Q3JOQnEr?=
 =?utf-8?B?UnJYQUxTZGpDOWpMTWFCRWpWdDZ1em5URStQWXdRTC95ZHVyRC9POG9KMzRI?=
 =?utf-8?B?YitjcFZ3bnp3V3MvYW9QRksrdE1vZzF6MEEwQUYrK1RaODcvR3ZwakxEV1Jm?=
 =?utf-8?B?RWFGcDFpNklSZVVzZGpmZ2E1ZjRvem5JSC9TblFhQ0ZEaUlMOWNKYUdUWHpz?=
 =?utf-8?B?RlpVYTk1REJpYlNWWDJiNCtsRTl2VkNLdlpHQmxMeVRDMHd1Z1EwajN1UlZo?=
 =?utf-8?B?RW9CMVRiQ0dLQWlhUElyaVhNNWkrZDNJcDZmNUZxVllONHlPWXFLbnRnYmJO?=
 =?utf-8?B?RGM5U01DTHpoeUdDcUV3QTEwM1hENStEQWhLelFzdE5xRFZ1dDI2SlVlQmZi?=
 =?utf-8?B?aWEzTlh4eE9VN2poazRPbVB2MWZ2MjYxditSRkJqWS9WdGlZdXdZZ2RNVHZU?=
 =?utf-8?B?MHdkbjRFZzlRTHAweVJWRUt3Sng3bG5Lei9xVm5VSU9VZnRIdmJyalJtZDRy?=
 =?utf-8?B?K01DUW1MUlFMMWtocWhMRkxjeVZwL3oySnowMjZyRmdJaTdoU2phNU9zalFq?=
 =?utf-8?B?dGpEMXcvcDh3YUREYzNuYTBxOUlvV1EvRFplVzZUSXc0M09jRWtQMWZYYkwz?=
 =?utf-8?B?TktzS09iRHNyR3FWeUhXbHgwOVBSQytQMUxybTJPcWNpM3RYUFhKcnMraHJ0?=
 =?utf-8?B?V2xid1A4Tk9ZeTAzZHlCcU5JTVVFWnBWZ2pVQUZIMGFwNmtDdWtOYWdkK3p3?=
 =?utf-8?B?Y3BqK3ZxWWdDNE85Zjg0M3FYWkZ6RjV4ZDRONkt4VXFac2ZnWGwrMXptWC9o?=
 =?utf-8?B?TjRTR2k0NGQrWHBmT1YxZkxqNlVNYk0zMHpObEVOMkNhVVZLTGtVdHNWNUdB?=
 =?utf-8?Q?bOjA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9526243-dd81-4468-5d32-08dcf9f4db4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 21:42:02.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3XQY3UsFVT2+XXFrs/sWHvni4z6AbAn5kT2NFJHC1I91Odit0tfAQpAVyGotY2jxe4OKevQsb5IxaZr4lWCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW0gQ2Fv
IDxuYW1jYW9AbGludXRyb25peC5kZT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI4LCAyMDI0
IDM6MzUgQU0NCj4gVG86IEFubmEtTWFyaWEgQmVobnNlbiA8YW5uYS1tYXJpYUBsaW51dHJvbml4
LmRlPjsgRnJlZGVyaWMgV2Vpc2JlY2tlcg0KPiA8ZnJlZGVyaWNAa2VybmVsLm9yZz47IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmVhcyBIaW5kYm9yZw0KPiA8YS5o
aW5kYm9yZ0BrZXJuZWwub3JnPjsgQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+OyBN
aWd1ZWwgT2plZGENCj4gPG9qZWRhQGtlcm5lbC5vcmc+OyBLZWVzIENvb2sgPGtlZXNAa2VybmVs
Lm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE5hbSBDYW8gPG5hbWNh
b0BsaW51dHJvbml4LmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz47IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5j
b20+Ow0KPiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+
OyBSYWZhZWwgSi4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMaW51cyBXYWxsZWlq
IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+OyBTZWJhc3RpYW4gUmVpY2hlbA0KPiA8c3JlQGtl
cm5lbC5vcmc+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgSm9uIE1hc29uDQo+IDxq
ZG1hc29uQGt1ZHp1LnVzPjsgSmFlaG9vbiBDaHVuZyA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47
IEhhbnMNCj4gVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPjsgSmFzc2kgQnJhciA8
amFzc2lzaW5naGJyYXJAZ21haWwuY29tPjsgUGF2ZWwNCj4gTWFjaGVrIDxwYXZlbEB1Y3cuY3o+
OyBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+Ow0KPiBKb25hdGhh
biBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgQW5kaSBTaHl0aSA8YW5kaS5zaHl0aUBrZXJu
ZWwub3JnPjsNCj4gQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXgu
aW50ZWwuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4LmludGVsLmNvbT47IFJvYg0KPiBD
bGFyayA8cm9iZGNsYXJrQGdtYWlsLmNvbT47IEx1Y2FzIERlIE1hcmNoaSA8bHVjYXMuZGVtYXJj
aGlAaW50ZWwuY29tPjsNCj4gWmFjayBSdXNpbiA8emFjay5ydXNpbkBicm9hZGNvbS5jb20+OyBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsNCj4gSmFzb24gR3VudGhvcnBlIDxq
Z2dAemllcGUuY2E+OyBVd2UgS2xlaW5lLUvDtm5pZyA8dWtsZWluZWtAa2VybmVsLm9yZz47DQo+
IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwMC80NF0g
aHJ0aW1lcnM6IFN3aXRjaCB0byBuZXcgaHJ0aW1lciBpbnRlcmZhY2UgZnVuY3Rpb25zICg0LzUp
DQo+DQoNCg0KPiAgIGRybS9hbWRncHU6IFN3aXRjaCB0byB1c2UgaHJ0aW1lcl9zZXR1cCgpDQoN
CkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCkZl
ZWwgZnJlZSB0byB0YWtlIGl0IHZpYSB3aGF0ZXZlciB0cmVlIG1ha2VzIHNlbnNlLg0KDQpBbGV4
DQoNCg==

