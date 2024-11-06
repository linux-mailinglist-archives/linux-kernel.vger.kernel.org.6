Return-Path: <linux-kernel+bounces-398872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8539BF76F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23F41F223DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250820E320;
	Wed,  6 Nov 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="dr0i/mg2"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021141.outbound.protection.outlook.com [52.101.129.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4A209F5F;
	Wed,  6 Nov 2024 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922007; cv=fail; b=WaBB7q2sJRx5qHXB0noVfd+yHcT+iqJ9RJtjCxEoJfiiGGm5/1GRHUtdSlXNYbyYNICmxhCdLt9yZKISUXJ0ayoFqdX/eb/Pi/KXtg/Jw77Q2quttbnC5T5ph8+s/s/7f90RyG3206P6N7vs8R32TnIgBPjcC7Y43CweqxC5chc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922007; c=relaxed/simple;
	bh=i9cgxrgZ5QweTjZVAls0+VnU7DvWiw/WuVZdcBszAL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btZBIAhCiHPSIkozTwEGxdLy5QdqA1xZVc8X+jGk/Cc/XfOkhpT3Z6Nob+jUwRmjuwsDpwiiJEkAhlEDwznnFpr8FA/AQxwSKFNqhMFQCOs3FdForgFb732SBgh1dkKAtY0/RwISwv2X3PxdB2l8K04VU7FdZaNMiN2mkj87AeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=dr0i/mg2; arc=fail smtp.client-ip=52.101.129.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFKwzuulguWUKrS223a/b4lZFs+mHxyf3knUuRGIZp0UQ7ZkMwHscxIhXn56P/w0vMi7FkzZhZEcDPRTnVsAI5sxBWFlKc8rbTQgrAE4LiMy9vz0GFOtwh7o49h8qGbHwDhI9YJ+GMTHK/5qzk5rtm4b/kORzJxE0Jr92LHico/Ow+8dUHzHtNvh7VhFJwCmE0b4WqQiViNjoUepzDVQ2c1nf2cAIsrvBur5uS3qvPWZVQePaSprUzjeHsnyKKuNVLvFW8QYLGqS9l6V1mvUIg7GhTLCjW4IwJ78ZcldTON8KJdRfzsfhxQNpgOhGPJ1E0earV0hIW2jBON0+43RRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9cgxrgZ5QweTjZVAls0+VnU7DvWiw/WuVZdcBszAL4=;
 b=eeLRD0EBqqmoR/ttx4q8LMshdBd2K1Vdvu2d9g2abWVVKdHWYthCoYeHcgAhw5eFFjyImO3Fae4JnsvXJmxGZOn7GVPeAMgQZkRSwr3ceABQd3mSrY26py45q118Nmw3pALnVSX9J/F5yG8GISCrtDBX8hIu/3fQmuqfGSPRN23+G5FdLfPc3qsY/UPxJagSMcKfdeo4GH219/swnrNapJwNtPDE3L/fJOplkGXIoRsu9EnJzJK72r2msraSwQTk9bCAv3Ch5fZfkt2gHadZS9N0BWrfX6dX+9JIopc03K2SODRjGQz6XDcPDG99jZgdsld/5GFwNfYg329NI+8Pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9cgxrgZ5QweTjZVAls0+VnU7DvWiw/WuVZdcBszAL4=;
 b=dr0i/mg2hJNCDYo2K0eqVnX98MaYKcqDQTTmrAOSCG/VoZfvFHsUeuVRb7447zOdIeaeT5I93M/K04znftVhHbH1stfO8MvzsUjFvrAGqGIbPJBR+JrJpp/6jJv9NH0hl26E1N/3IGiodiENkjzTObeMaLBGm/5Hyj23NT9phB0=
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com (2603:1096:101:4a::13)
 by SEZPR02MB5758.apcprd02.prod.outlook.com (2603:1096:101:45::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 19:39:59 +0000
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95]) by SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 19:39:59 +0000
From: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogMDAwMS11c2ItbXR1My1maXgtcGFuaWMtaW4tbXR1M19nYWRnZXRf?=
 =?gb2312?Q?wakeup.patch?=
Thread-Topic: 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Thread-Index: AQHbLuJOhIt9NRu7m0GuzhYM0mppkLKoX0aAgAJKK4Q=
Date: Wed, 6 Nov 2024 19:39:59 +0000
Message-ID:
 <SEZPR02MB5495A8637098B92CDEBBFC6C8E532@SEZPR02MB5495.apcprd02.prod.outlook.com>
References:
 <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110512-popcorn-germless-01be@gregkh>
In-Reply-To: <2024110512-popcorn-germless-01be@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB5495:EE_|SEZPR02MB5758:EE_
x-ms-office365-filtering-correlation-id: e1d35761-17b7-4a87-f34a-08dcfe9accd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YTVOMnk0ZVRJL2lJWFhpNWhCMmNYQ2ZneXZtZHFRS1lPVzBEa3Zibmx5R2Q4?=
 =?gb2312?B?R040Z3VibTk4WG1mQWlzMGFLbUdyeTBjczRXQTQ4YVgzYzNQc2ZsVTRjazk5?=
 =?gb2312?B?MHNCU1Fnd00xY0ZrSUVMR1E5d2hXVnVzR3puZTJkblQxdTJsQXJSQ3BXNjZL?=
 =?gb2312?B?Qm5EQSt1TTFwM3Z1d0RCRUo5UkFXdHV2S0t1cyswQ05yb3RkeTE0b2QyeTdN?=
 =?gb2312?B?SFU5MEJXbUFnb3pZaStQcXlUTklIMXZtTEV0MEpCVCtsRCt2RWF6VGxLZ3NH?=
 =?gb2312?B?cXhsRXM4M1lZWW5UTUIwbjJENi93Z3d1VjhYd2RidUI1SjNXbnpPK0JZY283?=
 =?gb2312?B?YnBtMW96T0trZjZ5QzRTNTcvSWNETjYxUFRTWmFLSEVFdS9SUjdwQVMrWndY?=
 =?gb2312?B?YWViNkg4M1o4S1FuVUpsQjM1RkRzSWUxdWhTQnEzSkRmQlBtaHZqb1BuMjU4?=
 =?gb2312?B?N3FvTWF3WDNoVHFsNWtQaHN3RjNiWkJlb2w4VEJ5dm1BWHZCQkRnbnA3bVJX?=
 =?gb2312?B?ODhpblZMRDRzNUVXazNLRXA2ZlpyTXEvYUdRMElFNVRiaTNCaXJaVmYxcDRr?=
 =?gb2312?B?c0RUUlpHOGhac0xCTmRDY2FVQXlwZlJQQU1xaTRtSk81S2d6RGZvVEdLWEp3?=
 =?gb2312?B?dnRjNG5yblpFdzJKWW0yanMvazVpcXFtM2x4dktsRjM0ZVBBSHlKRTVWeXBo?=
 =?gb2312?B?cXdnT2NvaU00RFpmOUVRS2lLS0Q5M1VqQmpSd0J4SmxuZFBvMldza25YMFpi?=
 =?gb2312?B?bFhjRGczS0w5aStvMEFqVGNxOUs0TFBhWmxITkg2L3J4c25DQXlXZStzN3FH?=
 =?gb2312?B?QmoxUTRuSW1CODdhQlFxUWk1WkdUdzV1UkJoUzQ3WGgzWXRiNFFMVlQ2NGp5?=
 =?gb2312?B?MEpJTWhsT1M3RzB3TmZSMmszVUtwSVFsQ09NaW1IQ282RUovOFI3THhoWHVu?=
 =?gb2312?B?blIzL0JKY1d2YjNwQStUd25qVHF2UE80V0VVWDZ6NlZZcUJPaFA0akxXci9a?=
 =?gb2312?B?Vm9kUDdQUWcvZlFwTnJGOXB4ejgrSlJhZ0k5UktwRmRmZHF3VEowN2FLZzVt?=
 =?gb2312?B?Ly9zVTBNVWpTYUNMK3dOQlFiK2pYaXpGZWc5L3pla080QTdBQTNaTzltWlFE?=
 =?gb2312?B?REpQNm1oZFhwYzF0d1BjSWpUOExUZFluREE5ZXRUcE5ZT0RuMFpNYnRXd2NL?=
 =?gb2312?B?NnF4QlJpTnR3N3JpSXBsbVk4L2dhOURsN2tqTFRWMHJxNllMdUtPOThnT0d0?=
 =?gb2312?B?ejc4YVJrcVJYUENxMWo2NGFRZmYyNkJzczZnRjY4NVZEWTR5Q09qYUZaSVZ2?=
 =?gb2312?B?bVdYY0ZEZHZYbVNhWE5vcnE2a09vdFozOFBVRW5JcHpxQ1J1L1drcFZPcTFK?=
 =?gb2312?B?a3B1cSsxa21lbi91SHFBNzZEemRKOFBDd0FyUENRVDRob0VOdGpqQVdiVGwz?=
 =?gb2312?B?N2xWcXpIYVRWTSt3WUZROWxvT09LV3lxQWFIODI1NXdBN2R6a2llYm1zZUpW?=
 =?gb2312?B?dkhQQ3p4L3dqcERRdVpuWGJqbm5SbTJkTDBmSGJSVktYcVdVU0JIVTFJQy82?=
 =?gb2312?B?bjFZaXJWWXBSQTQzRnBZVFJoSWlPcXVTY3ZuNUR1dnpDcjVxa1c4QUVXbHJS?=
 =?gb2312?B?cm9pT1o4dmFpN1B0VzZ6eWRNK2VjQ3RObmk0UW5obVV5VmRLOWN5UXNtWHlV?=
 =?gb2312?B?cnRXNDF6ek1wdE9nN2tKeUluSFg1eDBCNTdWampmeFQ0WDRRRWRxSnJCQlF3?=
 =?gb2312?B?K2UrOWdvT01MQnJTK1FkZ3hlUWFVeXZ2TzcvNmhlWUYwWFhUbWh5YU54MFNl?=
 =?gb2312?Q?JpCvnJSQgzCF4mPu1AwOTTGmDotIfpAZgkwjA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5495.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MEVNYzRtREptaFhWV3ljZ20xRGRXV0M2TE1DT2dRQXU3WUpYbll2dDVEa2ly?=
 =?gb2312?B?VUlZVTRPNkFmTzZ4cjdiY3E0T0puMXFhbWd4VmgxNHUwbllaamhmeEQ5MFF1?=
 =?gb2312?B?YUEvNFJzVjJXVHVkMjl1QkMrdHExdFY1bXNVQnlkdGhlVFFlOGVvN2lKWGw3?=
 =?gb2312?B?cXRJekdHVUpDTGI2KzRVMTZ3L1NFK3BSVGVnQWRvRS8zcDNRQXZSUmZZT3dL?=
 =?gb2312?B?dTRYT3ZWampQcWduTVdrQnZzK0dnc3VkY1g2UHFuV0xQcU56a0N5NnA5d2tu?=
 =?gb2312?B?YzlablMwNjA1a3AybjJZVlFxZ0lxdm0rU0ZRSmJIL2duNmF6UFR5T01sVWI0?=
 =?gb2312?B?UlpwMGR0LytsRmRFU24za21sdmxSbTBYYzluVUpRd0hjVytPNkdKdXpWYUQ5?=
 =?gb2312?B?ZElPWjd5YldGZFVYeElhaktneW90eVg5ZTRlc1ZVUFBLNzhaNTJSN1ErZ1dL?=
 =?gb2312?B?VWxUYXNYL1RSU2tmVG9HWDdHd2gvZWJiRktyYStON1A2L3ZZSDJ0NVlSbnhS?=
 =?gb2312?B?TE1scGY3ci93ZmlTdnBTOHJUN21vTTZjY2gwQ1BkV1Z2b29pVjZHYzJNSGxa?=
 =?gb2312?B?K0tYSTl4OGFLak5Jc255b3F0UDJIcjJycTRFTjluRVptRnVIS0JMYVRFUFdP?=
 =?gb2312?B?UUtjd0R0dzlUM2NydXBDWVdoSy8ycE5hbUM2dHYvUTVXUEQ0YXVaYlBjNS9t?=
 =?gb2312?B?RmFoMXVSNDIvQndrbXd1a2tkYURhT2xDNFJyalhvMU02ejRyaVdQN2FPSXRu?=
 =?gb2312?B?S2hERGZhQ2NpSjY5Sk9Qb0FDaHYybFdJWlZTWmRGVlJ6bEFZdkpENEhnSEQr?=
 =?gb2312?B?ZGl4RkhVYkIxMlJZS05lOEJGLzRlYU9kWEpmRzBoaWhva3RxSHFleEZxR1JZ?=
 =?gb2312?B?ai82d0lyV0MyZUxLZTZYeGRDeml4YTdNOFRTUUE4UVV4UzFuaXIySi9rOU1y?=
 =?gb2312?B?MjhFRS9EY3ZQOUU1R1JxZEFTTFhKZ0N6SDhoMHdTZHdzWmtsY0tlVkVSOHRv?=
 =?gb2312?B?UHBrTTNhclNMbkR0WjAxc2RPNTFuTndXZkhYWE1vdHV0VUxPcUp0Z0owd251?=
 =?gb2312?B?WExWZnNqbnB5Nkd1US8zaCt6NHdGMytId2k3SGtqcU41M2hiWFc5ZmwvMnRT?=
 =?gb2312?B?VnNPb2IzVjA3MGY2MWVZRCt2b3o4bnZRb0FmY05OeFBJbHVrMkZZcHVyUmZZ?=
 =?gb2312?B?V1J3S25iVUxlTmkxY3pIWTN4REh2OS9tS3VBWFZQUWtPcys0bmx0Z2hRTE5X?=
 =?gb2312?B?aVVuMFVSQkk5YVpjSjhZcnJMMUsvdVg0N0ROVmpLMldxMUljMmlmUW0wdjFr?=
 =?gb2312?B?NXRvZXkrMzVJMUxuUTlMUGQrZjlrN2J3WGpxZEcxSTVOZFVEeXpwRzBqSWdJ?=
 =?gb2312?B?OHRicEppQ2Q2ajZtdDJQS0tPaGpHK3UyMHZ4ZGlmdzVDRGxKT3RlNXRYd3Z0?=
 =?gb2312?B?TThnMUw0MzV4T2JYWGtrbENneHhTRlBJTDBFOVJDMDFLMXl4VkVJb3lMRDR0?=
 =?gb2312?B?ejNFeGZDeWdvS2tHR0U3KzhkNDdMUjN0eGNNRUlqQW1oVTB3QVB6UlE0c05v?=
 =?gb2312?B?dWZNTWM4c1pxZ1FoYXZRWDgwR29XWWlDUnlHb1QwWERScmkzZ3ZEMm9xdk9u?=
 =?gb2312?B?NjNTN2dwZEJGbjRmYVMraGVqSVFKL0ppTndRWkxOT2JIN0pQY290QjZhbVNS?=
 =?gb2312?B?Rk8rRUptbk5nclphbHF1U29FbTNxZzRpZWt3M1hFd20ya05Fcy9vYzVGSG9I?=
 =?gb2312?B?VjlNWlF4VDVtQXRFU24xTkZOV0pBM1daei9VbFhsS0lpYllEaHZ2Q1J4anVk?=
 =?gb2312?B?TnY0SHNPdmxpY1JucVV6S1VqeGt6aWFHb09BQTBRQUtRRUdWS0JrTU0rejE1?=
 =?gb2312?B?RENId242Rzk1aUxBYnVreXZxWGtzaytOclVXZzE5OHRzK0w2R0dqd0ZUbkpL?=
 =?gb2312?B?ZWtwR1lycHgyVC9xL1k2aldNMFg1Z3ZSMmtzTS9ycnVTMTJsUzlwdG9iRnZi?=
 =?gb2312?B?MzBiRmJHbXU0T3A4LzZsUzlwQ2hxeEtZTmZrM2I0S3JLUlV3ckp4TWtPaTBU?=
 =?gb2312?B?OThBMDJZZVJ0RDBjYTFxeHYxcDNyRDEvZzRrUGZmVzgvM21kWThrejRuSlNv?=
 =?gb2312?Q?gvEp0OrltWFjFzOB7UxkRphn7?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5495.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d35761-17b7-4a87-f34a-08dcfe9accd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 19:39:59.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCndrXsx7aTfAzICsXu2xk/gdLTSSkQ86AzPtQwXbwdttoTm23yAU2wlqNaHZVC/17vysGVcb3V6DFBLdp6VGJqkc9yFUrT7k7WbLbk0S14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5758

SGkgZ3JlZyBrLWijrA0KDQpXZSBmb3VuZCBkdXJpbmcgZGV2ZWxvcG1lbnQgdGhhdCB3aGVuIHRo
ZXJlIGFyZSBkYXRhIHBhY2tldHMgdG8gYmUgc2VudCBvbiB0aGUgVVNCIFJORElTIG5ldHdvcmsg
Y2FyZCwNCiB1bnBsdWdnaW5nIHRoZSBVU0IgY2FibGUgd2lsbCB0cmlnZ2VyIGEgY2VydGFpbiBw
cm9iYWJpbGl0eSBvZiBzeXN0ZW0gd2FybmluZyBvciBwYW5pYy4NCldlIG9ic2VydmVkIHRoYXQg
dGhlIG10dTNfZ2FkZ2V0X3dha2V1cCBmdW5jdGlvbiB1c2VzIHRoZSB1c2xlZXBfcmFuZ2Vfc3Rh
dGUgZnVuY3Rpb24sDQp3aGljaCBoYXMgY2VydGFpbiBzY2VuYXJpbyBsaW1pdGF0aW9ucy4gVGhl
cmVmb3JlLCB3ZSBtYWRlIHRoaXMgb3B0aW1pemF0aW9uLg0KDQogVGhlIHNwZWNpZmljIGNhbGwg
dHJhY2UgaW5mb3JtYXRpb24gaXMgYXMgZm9sbG93czoNClsgIDU5NC42Mzg3NDldIENhbGwgdHJh
Y2U6DQpbICA1OTQuNjM5MDU5XSAgZHVtcF9iYWNrdHJhY2UrMHgwLzB4MTc0DQpbICA1OTQuNjM5
NTMxXSAgc2hvd19zdGFjaysweDE4LzB4MjQNClsgIDU5NC42Mzk5NTNdICBkdW1wX3N0YWNrX2x2
bCsweDY0LzB4ODANClsgIDU5NC42NDA0MjBdICBkdW1wX3N0YWNrKzB4MTgvMHgzNA0KWyAgNTk0
LjY0MDg0Ml0gIF9fc2NoZWR1bGVfYnVnKzB4NTAvMHg2Yw0KWyAgNTk0LjY0MTMwOF0gIF9fc2No
ZWR1bGUrMHg5NC8weDQ2OA0KWyAgNTk0LjY0MTc0MV0gIHNjaGVkdWxlKzB4YTAvMHhlOA0KWyAg
NTk0LjY0MjE0MF0gIHNjaGVkdWxlX2hydGltZW91dF9yYW5nZV9jbG9jaysweGE4LzB4ZTANClsg
IDU5NC42NDI3ODBdICBzY2hlZHVsZV9ocnRpbWVvdXRfcmFuZ2UrMHgxNC8weDIwDQpbICA1OTQu
NjQzMzUyXSAgdXNsZWVwX3JhbmdlX3N0YXRlKzB4NWMvMHg5MA0KWyAgNTk0LjY0Mzg1OV0gIG10
dTNfZ2FkZ2V0X3dha2V1cCsweDkwLzB4ZDQNClsgIDU5NC42NDQzNjldICB1c2JfZ2FkZ2V0X3dh
a2V1cCsweDFjLzB4MzANClsgIDU5NC42NDQ4NjhdICAweGZmZmZmZmMwMDE1MGYxMTANClsgIDU5
NC42NDUzMTVdICAweGZmZmZmZmMwMDE1MTAwNmMNClsgIDU5NC42NDU3MjNdICBuZXRkZXZfc3Rh
cnRfeG1pdCsweDQwLzB4NmMNClsgIDU5NC42NDYyMjNdICBkZXZfaGFyZF9zdGFydF94bWl0KzB4
OTAvMHhlNA0KWyAgNTk0LjY0Njc0M10gIHNjaF9kaXJlY3RfeG1pdCsweDEwMC8weDI3MA0KWyAg
NTk0LjY0NzI0Ml0gIF9fZGV2X3F1ZXVlX3htaXQrMHg0MDQvMHg2MDANClsgIDU5NC42NDc3NTBd
ICBkZXZfcXVldWVfeG1pdCsweDE0LzB4MjANClsgIDU5NC42NDgyMTRdICBicl9kZXZfcXVldWVf
cHVzaF94bWl0KzB4MTNjLzB4MWI0DQpbICA1OTQuNjQ4Nzg4XSAgTkZfSE9PSy5jb25zdHByb3Au
MCsweDVjLzB4ZDQNClsgIDU5NC42NDkzMDddICBicl9mb3J3YXJkX2ZpbmlzaCsweDM0LzB4NDAN
ClsgIDU5NC42NDk4MDRdICBORl9IT09LLmNvbnN0cHJvcC4wKzB4NWMvMHhkNA0KWyAgNTk0LjY1
MDMyM10gIF9fYnJfZm9yd2FyZCsweGNjLzB4ZTANClsgIDU5NC42NTA3NjZdICBicl9mb3J3YXJk
KzB4ODAvMHg5OA0KWyAgNTk0LjY1MTE4N10gIGJyX2Rldl94bWl0KzB4MzU0LzB4MzgwDQpbICA1
OTQuNjUxNjM5XSAgbmV0ZGV2X3N0YXJ0X3htaXQrMHg0MC8weDZjDQpbICA1OTQuNjUyMTM3XSAg
ZGV2X2hhcmRfc3RhcnRfeG1pdCsweDkwLzB4ZTQNClsgIDU5NC42NTI2NTZdICBfX2Rldl9xdWV1
ZV94bWl0KzB4NTJjLzB4NjAwDQpbICA1OTQuNjUzMTY0XSAgZGV2X3F1ZXVlX3htaXQrMHgxNC8w
eDIwDQpbICA1OTQuNjUzNjI4XSAgbmVpZ2hfcmVzb2x2ZV9vdXRwdXQrMHhmNC8weDEyYw0KWyAg
NTk0LjY1NDE3MF0gIF9fbmVpZ2hfdXBkYXRlKzB4NTE0LzB4NjUwDQpbICA1OTQuNjU0NjU2XSAg
bmVpZ2hfdXBkYXRlKzB4MTQvMHgyMA0KWyAgNTk0LjY1NTA5OF0gIGFycF9pb2N0bCsweDQxMC8w
eDU4Yw0KWyAgNTk0LjY1NTUzMV0gIGluZXRfaW9jdGwrMHgxMWMvMHgxYjQNClsgIDU5NC42NTU5
NzRdICBzb2NrX2RvX2lvY3RsKzB4NDgvMHhmOA0KWyAgNTk0LjY1NjQyOV0gIHNvY2tfaW9jdGwr
MHgxNTAvMHgzMzgNClsgIDU5NC42NTY4NzFdICB2ZnNfaW9jdGwrMHgyOC8weDQ4DQpbICA1OTQu
NjU3MjgzXSAgX19hcm02NF9zeXNfaW9jdGwrMHg3OC8weGFjDQpbICA1OTQuNjU3NzgxXSAgaW52
b2tlX3N5c2NhbGwrMHg2Yy8weGY4DQpbICA1OTQuNjU4MjQ3XSAgZWwwX3N2Y19jb21tb24uY29u
c3Rwcm9wLjArMHg3OC8weGU0DQpbICA1OTQuNjU4ODQyXSAgZG9fZWwwX3N2YysweDY0LzB4NzAN
ClsgIDU5NC42NTkyNjNdICBlbDBfc3ZjKzB4MTgvMHg0NA0KWyAgNTk0LjY1OTY1Ml0gIGVsMHRf
NjRfc3luY19oYW5kbGVyKzB4YjQvMHgxMzQNClsgIDU5NC42NjAxOTNdICBlbDB0XzY0X3N5bmMr
MHgxODQvMHgxODgNClsgIDU5NC42NjIzMTldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQ0KWyAgNTk0LjY2MjMyMl0gV0FSTklORzogQ1BVOiAyIFBJRDogMTQxNjIgYXQga2Vy
bmVsL3NvZnRpcnEuYzozNjIgX19sb2NhbF9iaF9lbmFibGVfaXArMHgxYy8weDgwDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCreiy83KsbzkOiAyMDI0xOoxMdTC
NcjVIDE2OjQxDQrK1bz+yMs6IEhhb3dlaSBDaGVuZyhIYXJ2ZXkpDQqzrcvNOiBjaHVuZmVuZy55
dW5AbWVkaWF0ZWsuY29tOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiAwMDAxLXVzYi1tdHUz
LWZpeC1wYW5pYy1pbi1tdHUzX2dhZGdldF93YWtldXAucGF0Y2gNCg0KT24gTW9uLCBOb3YgMDQs
IDIwMjQgYXQgMDU6NTQ6NDNQTSArMDAwMCwgSGFvd2VpIENoZW5nKEhhcnZleSkgd3JvdGU6DQo+
DQoNCg0KRm9yIHNvbWUgcmVhc29uIHlvdSBvbmx5IGF0dGFjaGVkIGEgcGF0Y2gsIHBsZWFzZSBz
ZW5kIGl0IHByb3Blcmx5IHNvIHdlDQpjYW4gYWN0dWFsbHkgcmV2aWV3IGFuZCBhcHBseSBpdCBp
ZiBuZWVkZWQuDQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

