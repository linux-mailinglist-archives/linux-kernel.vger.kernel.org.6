Return-Path: <linux-kernel+bounces-268803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C8942970
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53C61C23879
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720471A8BE8;
	Wed, 31 Jul 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="S8xQiyCi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F101A76C4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415540; cv=fail; b=MMszu7P84qLS3QROp+OrFOLIUvjOIQ5RKQW/yRFLn9N9xlAC3CnzdVfp73/Cpess7LQBlpE7DkyUyLAgvvwlcOU5h3blDPFiVDiFD5ASCMY2A7IkdRZTjE5geMArUhZ5uX62eZLqke1izRW76hx6Aa5oVAZZiruWOsJueA8nhCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415540; c=relaxed/simple;
	bh=YcG3ntWjJtRDamj4y1NV5t1PFGMXu0dljRWYmJHdbBI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=haKTb1Qkb+iM1s/OQQX2o9nste9T2G1B5yxdytSeMTWMSPji+Luncb/h/jGQiLIRy9Po07yHn+vWY+TQMxU92Hffs8H4DlGrJT9AMuJ1E7pl7wbOHNGwgD9nR5OmN5vGeS+JTP3Sm9Dnc3I6a5bIwgB0TFBBpyI+4PUihBatnrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=S8xQiyCi; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scgmnSfu7p8kV83BPQmmk5f0zwWMspkFhE+nMwq2Zh2xm5v6r4byfAVSvA4aa4tXvqF74H0C+goWGOLQ8qRPtu86MbjBI4U5kEX6OGPW6oXZ1Uke+SebOukQegYVKr/okANtlflP8irfS9H6K6HQXKQ8NqLcJSbLHBLOYd1qpex1+4b4ETGyED9+sUVdGO7y26xDjn1Jj1DdMKUMsmj6uwr1EWK8cVILXCjw/SGP8p219ruBSis5ixkV1dEBL28+RAmsgLebQkeBmU4EcIRvb+KwiAl0+IKl/cOkkrv7LBANCUa0xnPJjZIwlRB+66lqE4lrh0hlR+MkQP2Nj87vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcG3ntWjJtRDamj4y1NV5t1PFGMXu0dljRWYmJHdbBI=;
 b=hXUnXMLsddWoobjfxj1/pzvmupqzFo2ng+/43P2+okylhhoz3LqjkQPh3hoe+icb3zg23NOhF5i7eX9eJPxul011YX1CtN+WSZiVa3QmpzZOGEG0gLD/e2Q9ocv/OfAgbmxoceqYx5dR2gjkJUStr/WTA13465ZxLaTFieVJtCEAVy1suozBrBSgzihTVpulDDi6RrgLuK7bJtWW8UcJr8cqCAdPNfL14MlkF9ysHe7b+V55YM1CGkXpPc57DBOLyf5RPudTN9UwDiSFchEYZrTTzXmduSdnDBMIdftfnnskS6P6SxzTuZ0RhRPz//81zt98HmoknsFhnHO/mJFa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcG3ntWjJtRDamj4y1NV5t1PFGMXu0dljRWYmJHdbBI=;
 b=S8xQiyCibpj5Igy2KYc421rG5eQGHi6DOF35VdWMZQR6rIH8/kJCFvx+6l+JDYcOg0p3i9MpzAUdMp90I8i3U61PDBcbK+yDFqws6TWiEHPWLHAuaKTuflRPeHNJ8MIonQZ4BnjqUUQD00gDyQO9DGYHcDUWVXsCUtlQq2hh7qzAjRY3qEIRYzYtIFa/1PRqfxZuAZZ6lBOqti/077lURdostVOisUDnt4H60FZLnJW4zyf0zvnZwidlQG9cb5FLeZoIr4gZ2buLCwmsetSw0mM0iKzncE1AR7bgxmPCqqLJol1qcmw6cdy+4xknNtRu++5Ni0nzA7xeYCc+bN8cSg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by JH0PR06MB6317.apcprd06.prod.outlook.com (2603:1096:990:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 08:45:31 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 08:45:31 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration problem
 of mobile phone as UVC camera.
Thread-Topic: [PATCH v1] usb: gadget: uvc: Fixed the abnormal enumeration
 problem of mobile phone as UVC camera.
Thread-Index: AdrjJNj29VsAs/ObR7ym5N0VtlAoXA==
Date: Wed, 31 Jul 2024 08:45:31 +0000
Message-ID:
 <TYUPR06MB6217A8530C44FD14D0ECA18CD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|JH0PR06MB6317:EE_
x-ms-office365-filtering-correlation-id: 40a76b85-1d36-40c4-b268-08dcb13d22b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UW92Yk5CZVpBdkgxR3FabzVsR3VNanRrc2RmU1Y5Q0ZiRm9icTgxQURuTnM5?=
 =?utf-8?B?cnVyOC9QVlVmZCtEVWZzSW5BaUEyRUJMbGF0VTUybS8xVGpzcWZ1VUZVSlp4?=
 =?utf-8?B?azlwNEVWT1Vrek9LNFZ3REV0ZU1UckV5S2xwUmVseWRJaFM1MVYrU1JQZmlJ?=
 =?utf-8?B?Y3FUOW1qUzZwc09oUksydU5JZG01QW5Va1k2Q3YzZ2lZVlloWnVmT0JUVnBp?=
 =?utf-8?B?ckRBdHJMNDZIK0hyQXlFRkdicnRaUXoyc1BpcWcyNzh1Zi90bVRmZFBPeEc1?=
 =?utf-8?B?MmpOVDMvNmplUmNWOG1la1ZQL2lRK3dzcmFISjYzV0h3OE1hVGREcExIZmVY?=
 =?utf-8?B?NWJyZy85eDJ3NFUzanVEcy9wZ29kbTc1ZTdmZnpadFJGZXlYclQ3dXRZbnVn?=
 =?utf-8?B?dEM0cmtEeGlKNTFpdXBIOUZWbUN0aERLNEVMREhyVms3Sm5lemMzL2xieEZa?=
 =?utf-8?B?RWtiaExLcjF5dVZGNVU3dWhqc0JKRkRXZ2oveVpsSEpqWlNFN3ZZeEh4WGZU?=
 =?utf-8?B?Ry82dnZmSEh6ZVVvcjFYQUVYeWlUWDVsUGRtVHVJOE9tRjdQQ3RBc05FUnEx?=
 =?utf-8?B?cU9Tb3Q0M3FJVFkzTTFYM1k2K3l0QUIxV0djY0l6K3lKWGpYRWpsblJjQWNV?=
 =?utf-8?B?L1R6YW9lTEhsNkJXT3ppb2pTdk0rRFhod0NOdUh6VXpVNHpUdWozbzBodk9a?=
 =?utf-8?B?MTkzd2orbkV1Y3lWVVc1d2VTTGphRWRkRGYzMjBCZnlwUHAzVHBrL0pzNzBO?=
 =?utf-8?B?UzQ4U0FEdDIzOFBoeDM1RlczQmsxOVo0azNCd3UzZWQ3b2x3d0FMY2M3aXEy?=
 =?utf-8?B?UXJPUVIvRm9aaGZ5T1E0QkNpb0o3My9lMW15Ui9sNmhETTZYeEhMUWNkd0tW?=
 =?utf-8?B?QjFOVkNBeEhGcUtZUWxFWFNYNDR2Z1I0YnI5anZRU1gyWHRvVitqWSswdjg5?=
 =?utf-8?B?cTVScENRaThmT1F3REcwSnJYMG5aQ005VjMvY0hGU2tMNVF6VFRXUzduWFlH?=
 =?utf-8?B?Z0QzV3FKbW9XVXkrZmliNDNoR3pRRkUrdE9MWmpVL3locnV1R1M5MklucFlx?=
 =?utf-8?B?RGRFekZaNGZRSWFOMFlESngvN2hOUjB3R0l6dU5PMzFmNVFOTm9oaUdteUR0?=
 =?utf-8?B?VDJZSkRoTWZPNlRmbnQ3YnQvbko3dWRKNGM3cVdIanFQL1N3OHI4bk9zR3M2?=
 =?utf-8?B?dzc3aStzRms0SWdtcGowVEZvSlU2dWhpbGU3VHNGTXhFM3o4bmIySjJ3S2FZ?=
 =?utf-8?B?dzdYSk52UUpqcEkvZzRJSzFVWGZwS2hMVzU2SFB0N21YcWoyTEpRUDZDTXB1?=
 =?utf-8?B?cnJVZXI5VUJTdm1OSGppNi9qVHViZkZVaE0vcnl6OGRkaWNRUThTZVQ3SVpI?=
 =?utf-8?B?V3lLZDd5U2oyZWh0T2ZHMGc2VTR4ZW93YXVqQWJrTE9TaVlxRUVzc2JpbW9R?=
 =?utf-8?B?TW1OTUFwT3pIMGlkaEtDcEpwNEYxVy93V1AyT3NsMFIrUjdtNS9xWVJGa2NG?=
 =?utf-8?B?V05qQmIzdlFhYm9pTU5UL0VWOWpVU0ZnYlNiZWNLMVhGdTc5RUpXdlVPcjVz?=
 =?utf-8?B?K2xSaXRQSlpVMFhOWVl5M1NldmJLZlBtOVV0TDgxVzlmR211bC9jaXlpNURE?=
 =?utf-8?B?WWVwUXhhdUN3YkZqT2JxbnZaWFA4UkRaeFpVZ0lLTGpWUDNDTEpFeUIxTGYy?=
 =?utf-8?B?cHZWVHNHRk9Ra1FSNmgza050VTZUM0UwMmVqbTQ5OTN2VGh4ajZXTE4yNW9D?=
 =?utf-8?B?R0JhNVVFbzRiTmc3L1gxUUl6R0hxRSt3ejBmbFhlZFJ1VWhWaHcxQWM5Mk1u?=
 =?utf-8?B?dTQzS1BodDhwSjhZUk4zcStRWFlGK29RSmxhZmRXa3Y4bEFpSWtLakYydGsr?=
 =?utf-8?B?NmxVK3l0YnpjcllmYktJcjZSRmUxTkxXM2NHR3dzZ0VNM1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkI2Q3hCMU9vK1dQUnlkWmZMMFUyNEJRRXNna3llOWVvOEYzR01HRE0ralYv?=
 =?utf-8?B?ODNOWFg4STQzL1Jac0RUbjQyRTdwemFsaEp5VjdwdEVlRjIvK1ZNMUFDWmsr?=
 =?utf-8?B?MmhkRkN1TGhibFg0WEZHcU9HbVBMRC93VFVVclR4YTd6dW5xRm9sNFBWbnBh?=
 =?utf-8?B?c1FXb28zeVhnNXJkanFPN05PQ3VsYnR0bkpyVGc0NU5jUXNqaHlSalFlQlJk?=
 =?utf-8?B?TGExaGxGZnZ2aFpiZ2xEdU1IOExYTzE1VjlvYzNhMTBlQUpPVHNLMmkzc0RP?=
 =?utf-8?B?eUtQUHhQTVl2TXlONUQrYjRZdEF6QW1xUFlSeWF3WGNDTVJaR0RYTHR0c3Ey?=
 =?utf-8?B?Zksrakt6RDZ5eXFMVWJMTHdGaTBRM1hpZFVBQVQvMGdYdHNTSEdZdE93TVZN?=
 =?utf-8?B?MGluTmFnNjdiQXFYeVNpV0JmY2Racm1oZ1Z0d3oxMXhRWmpJbGRjKzAyanlL?=
 =?utf-8?B?VFhkbWppOVJmMGxidU5KdDNia1I5Nk5za0dmVHlvdkNyMjlGVE5uNzR5UEs3?=
 =?utf-8?B?RnJldmx6TFVYaTh5QkRZdzd3Ym02eG95QjR0VEIzT1R1Sk5pakdSTnUwRmU0?=
 =?utf-8?B?b2g2enB2bGswUEk0amRab2huN1J4TVNtODRFV0ZYdldzd3RhbVo5UGFYdk5a?=
 =?utf-8?B?dkJLYWpzZ3R1ekgyNGJrSVZSM3k4azJOcmZDMVJHYWF2UlBrbEZKT1hoU3BV?=
 =?utf-8?B?a2RZZjZJTE5RcEtadWl5T2dSaGNnUTJIS1NKOVRvMi9xdDN0cHd5NUVXTFFv?=
 =?utf-8?B?UXU0dlYzQm13d24yakxaVHlXZldXUE9XMHAwbUhVUk9NeGxXTEJoaG9zVUZT?=
 =?utf-8?B?WFFxSFNxK0dsV2RaeHFnZ3ZGN0hGZlFqVUVFK1dyZjJDOThwR25nMU1WOW5J?=
 =?utf-8?B?QU5WTlpJc2FPZmxLRzUxSldzdzNVR1JxVGtWK1FXUjFpbVMvNUZrbEJRVkVK?=
 =?utf-8?B?NG5DVXZrWEtCMExhNzBnWldOY3YxemlBaHJzSFBXUUFQVkd0WEVoWC9aaFBD?=
 =?utf-8?B?MDRsaXoyaU1iVDVLME9XVlBTSWhja3RNeHQ1VWIzcXg1SHhRTGpXcWs5Qjla?=
 =?utf-8?B?ZElSNEdQUzRtaGE1ZytzQXNNczhuejZNcnVrbjZmcWR6M2owb3ROWnlKNGc3?=
 =?utf-8?B?SjJ6TEl2UzR1Z2dhVUR0L0hBSllUODJ1Y3R6djltYkozcEl2VWNBT3VnWEk2?=
 =?utf-8?B?bCtsUXZRanYvb0tyWnhoN1hlS0NVVWx5SzNhOGxJWlNTZ2FiSFBVVUl2czUv?=
 =?utf-8?B?bklGRzVUSU5ITWFnYWF1NWdVNFArSXhwNjRhRHdkRXFuUG5KblZkLzRnWXlI?=
 =?utf-8?B?azIreUdHczIrdzZkNmhLdDc2RVBaL242OGtidEhXUEVZYnBGS2twNDZBRGF6?=
 =?utf-8?B?d1Z3OGZ2SVJhU0k5UDVpVjVaYnBuZkE3RkpMRUx3bm8rM1dQWXc2NDRLUis0?=
 =?utf-8?B?TjU3cXFEVGxNempxeS8walA5Y0RNbWlzc0JUdzhsbSt2LzJiWTl6ZVU2K3or?=
 =?utf-8?B?NTdoVFpDdnNpRG1oTFlJSE9nZEpvOGs5RlplQTNTLyt0Z2d1Zy9qWWFUakY5?=
 =?utf-8?B?Q21JZXRKWWJlUDhFZzFJbmR4VmJNb3VJZHBvM1pORU95MFkxVmtNTlp5WnBM?=
 =?utf-8?B?ZHhKWm5QSThmeXZtNzFpS1Yzd0NQWkEvRjYrZzFXdmZ5cjFOdWpDUXlnNDNh?=
 =?utf-8?B?K3BROWRhcnp4d3JSUTFyN3FuNmJHcUpxc3plaXV3OGtZaHREZzJpdjl3M0s2?=
 =?utf-8?B?MGZpazNXdlRVRGpQbnlHWHFjVWczMnhYU0pnYjBkVWtrOXd0c2syNjEzcmRi?=
 =?utf-8?B?WWFtSlJQbHNscEpWOUhUTHRTS29JaVpSQjZKSnJtdUk0Q3JHT3dzRzJ6d0Fh?=
 =?utf-8?B?SWtqd1JlRXpJNEJEaHh3TmRkUCt3eVNFTmlyRmhOalNhdWg0VjdzNklwbDdw?=
 =?utf-8?B?aEgvcklTU09mUXV4N0o0WnArcGd1M0cvUTZIV2lackJOdm1zV3VOY2JHQUNk?=
 =?utf-8?B?Q3J4RDFvaE1kcWpvaW9MS2xDbWVlY3lKMkdLUlBISjlsZlhXSzVKazdxTW1G?=
 =?utf-8?B?aGpZUjZIaUtNMGRMM3J0NFJzOUR5b1IxZWltQ2JKbFkxeVA0Z08yZk51d2l2?=
 =?utf-8?Q?L54s=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a76b85-1d36-40c4-b268-08dcb13d22b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 08:45:31.3412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1jdI1/SYZAY1okJ0iGsIaNuUiqWOxaG+baqacKK/IiGaQu6IkKSvlju0NU0g1foiRdgkBCiMdjilSAhV9n8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6317

V2hlbiB0aGUgcGhvbmUgaXMgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciB0byB1c2UgdGhlIHdl
YmNhbSBmdW5jdGlvbiwNCnRoZSBwaG9uZSBuZWVkcyB0byBiZSBlbnVtZXJhdGVkIGFzIGEgdXZj
IGNhbWVyYSBmdW5jdGlvbi4NCg0KQmVjYXVzZSB1dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCBp
cyBjb25maWd1cmVkIGFzIHRydWUgaW4gdGhlIGZfdXZjDQpkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0
aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlzIGNhbGxlZA0KZHVyaW5n
IHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGZ1bmN0aW9uIHRv
DQpzZXQgZ2FkZ2V0LT5kZWFjdGl2YXRlZCB0byB0cnVlLCB3aGljaCBpbiB0dXJuIGNhdXNlcyB0
aGUNCnVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFpbCB0byBjYWxsIHRo
ZSBjb3JyZXNwb25kaW5nDQpjb250cm9sbGVyIHB1bGx1cCBvcGVyYXRpb24gKHN1Y2ggYXM6IGR3
YzNfZ2FkZ2V0X3B1bGx1cCwNCm10dTNfZ2FkZ2V0X3B1bGx1cCksIGFuZCB0aGUgVVNCIGNhbm5v
dCBiZSBlbnVtZXJhdGVkDQpub3JtYWxseSB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0
aW9uLg0KDQpBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB3ZSBtZWFzdXJlZCB0aGF0IHVuZGVy
IHRoZSB1dmMgZnVuY3Rpb24sDQp0aGUgZHdjMyBjb250cm9sbGVyIGFuZCB0aGUgbXR1MyBjb250
cm9sbGVyIGNhbiBiZSBlbnVtZXJhdGVkIG5vcm1hbGx5LA0KYW5kIHRoZSB3ZWJjYW0gZnVuY3Rp
b24gaXMgbm9ybWFsLg0KDQpUaGVyZWZvcmUsIG1vZGlmeSB0aGUgZl91dmMgZHJpdmVyIHRvIHJl
bW92ZSB0aGUgb3BlcmF0aW9uIG9mIHNldHRpbmcNCnV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVk
IHRvIHRydWUuDQoNClNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNv
bT4NCi0tLQ0KdjE6DQogIC0gTW9kaWZ5IGRlc2NyaXB0aW9uIGluZm9ybWF0aW9uLg0KLS0tDQog
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgfCAxIC0NCiAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL2ZfdXZjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KaW5kZXgg
NDAxODdiNzExMmU3Li42ZDYzYmVhMTQyMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvZnVuY3Rpb24vZl91dmMuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
dXZjLmMNCkBAIC0xMTA3LDcgKzExMDcsNiBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbiAq
dXZjX2FsbG9jKHN0cnVjdCB1c2JfZnVuY3Rpb25faW5zdGFuY2UgKmZpKQ0KIAl1dmMtPmZ1bmMu
ZGlzYWJsZSA9IHV2Y19mdW5jdGlvbl9kaXNhYmxlOw0KIAl1dmMtPmZ1bmMuc2V0dXAgPSB1dmNf
ZnVuY3Rpb25fc2V0dXA7DQogCXV2Yy0+ZnVuYy5mcmVlX2Z1bmMgPSB1dmNfZnJlZTsNCi0JdXZj
LT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQgPSB0cnVlOw0KIA0KIAlyZXR1cm4gJnV2Yy0+ZnVuYzsN
CiANCi0tIA0KMi4zOS4wDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0K
5Y+R6YCB5pe26Ze0OiAyMDI05bm0N+aciDMx5pelIDE1OjI4DQrmlLbku7bkuro6IOiDoei/nuWL
pCA8aHVsaWFucWluQHZpdm8uY29tPg0K5oqE6YCBOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNv
dXJjZS5rZXJuZWxAdml2by5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1
dmM6IEZpeGVkIHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9u
ZSBhcyBVVkMgY2FtZXJhLg0KDQpPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAwNjo0ODo1N0FNICsw
MDAwLCDog6Hov57li6Qgd3JvdGU6DQo+IEZyb20gYzQ2NDU1OGE3MGUxY2EzNmMwZTRiZDBhMTIx
ZmI1MDU2NWI0NDYxMCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogTGlhbnFpbiBI
dSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiBEYXRlOiBXZWQsIDMxIEp1bCAyMDI0IDE0OjIxOjUy
ICswODAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHV2YzogRml4ZWQgdGhlIGFi
bm9ybWFsIGVudW1lcmF0aW9uIA0KPiBwcm9ibGVtIG9mICBtb2JpbGUgcGhvbmUgYXMgVVZDIGNh
bWVyYS4NCg0KV2h5IGlzIHRoaXMgaW4gdGhlIGJvZHkgb2YgdGhlIGVtYWlsPyAgUGxlYXNlIGZp
eCB1cCwgYW5kIGFsc28sIHByb3Blcmx5IGhhbmRsZSB0aGlzIGJlaW5nIGEgbmV3IHZlcnNpb24g
b2YgYW4gb2xkIHN1Ym1pc3Npb24gYXMgdGhlIGRvY3VtZW50YXRpb24gYXNrcyB5b3UgdG8uDQoN
CnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

