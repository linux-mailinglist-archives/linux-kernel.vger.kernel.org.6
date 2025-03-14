Return-Path: <linux-kernel+bounces-562160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3899A61DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D81421648
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F31D8E1A;
	Fri, 14 Mar 2025 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GLhT9pBz";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YH82C4tJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZdV9jMch"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E18846F;
	Fri, 14 Mar 2025 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986892; cv=fail; b=C+2vymMIiIyDrbfK2UPcxh0HSTfsNYpi9HycvuZmOwyQX6+sF19ylUfShjzrTyKkuWrtfh71Zr5YyqOoOuBnAF5sz4LWc0bgMEaf3DqM0DaODqKjaDWmbmggf5qhOAGPvdw+pXLPFuCDNAO3LAVLVku+/J5zh5eFM7xtgAnyPzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986892; c=relaxed/simple;
	bh=lJYGXBoAxH0Or7NQk1Y9P/7QVeMv5Nsi4OkzchS4WxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D4gfYB7+RrgPke2dalbPegxv0bIZ7d1SNZosRjBwTKpUK1QglaRTu1HaZhSCdmyKoMKtcaUvasQAehxtsPmIUJ29w2GJVOnfcCWpVB2EO3RYNzwtQvGlXfqYEC3XATcFKBIhYqzoDMbVhE/z6bvMMC39eZnlerzEt8LBHDwzun4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GLhT9pBz; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YH82C4tJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZdV9jMch reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EJvmMV008939;
	Fri, 14 Mar 2025 14:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=lJYGXBoAxH0Or7NQk1Y9P/7QVeMv5Nsi4OkzchS4WxE=; b=
	GLhT9pBzZBJ21hUfA4PNQVZ+26f7JeelLkKL3CT+MV3wGaszkB0devSMIenxbTCG
	67VgGOSlHn0/O8ldesfwH275L3NqS4VLQPuEnVn0K7ISUdDdZxvuTZmuCT13Z1Av
	+6IOiDgZq9jxB/ouc/HFoWU53gFKPPOWOevfE1Bv3KvRSYqRQtNynyIt7ie9DTRg
	7gh89kM8vYI7eRQGIkXtrDXeHp9hH6jCgLIu8qATnPmQ64SPoZr+WjSf5zkU7q1F
	+y+n6g4wMbRFyq7OJW1HwbwakekemyMSKunuV+EfQfbiTwFa7x4ZWYYSggLuflJM
	6MkkduZImDawusn0ovGGHQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45cu2qg8e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741986873; bh=lJYGXBoAxH0Or7NQk1Y9P/7QVeMv5Nsi4OkzchS4WxE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YH82C4tJKyzHw9mbnLNL4/oYbyf04Ub38etJnzpvIoQ3TArmrTfCbF/gVOBCKftJ+
	 mBsr8QmDPLtD2Q9ct9K6VbrGs7tezEndKLGy4YpLhTH9WpGYcapO38dKFyXIE6sGcK
	 kYs1PAszhrAMfj0j+215GakJOx021zH+795QRjD7pWOW2PRUFK2lvzTJJSQsFtQLwi
	 f6GJHrNFo9WusovUTjpMARtodDFTL1F8YVMzKOToiVTw3TYokH05yYjGRLwVWWvP9P
	 sNGccL+GzI6E1VP0VqH7iyJYxx42Oy7KR0zh+p9htFOoJVL97LRC2QgNtkkUNASLOj
	 QwgeQOQ3Vf1zw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7237A40354;
	Fri, 14 Mar 2025 21:14:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5DF4AA029D;
	Fri, 14 Mar 2025 21:14:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZdV9jMch;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B06740218;
	Fri, 14 Mar 2025 21:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1AwD7w3D8Fl2ndF8EEfA2vWJdqMEoisqUQ0zZHJaiVUOkHC1HOuzfjGyLmGEnLaH6bwlblaCBVlGzEeOrrW+hnbgZWAgpWo3+GpL9pMQrltVCeIBO61+sVwGrph8pCd6m0UgtD/BTlv27ECrU5qzYzHjN3+ATQyyWcJ/ZTawNS6aEgNZGlGMyDUvogEBuN/JpnHnf8V1nd6ncBnLPLOAdMiiV4/7T42UfN8QwVQL9M7ySMvey5gx7Jt5GfdTdxeNL72BW7XPSCdPxBQpVi8q2/SxpBkQm9ARnKejU/Obf0OmW9Zm9lRP2nZ+ZCb0xXLjglUGM8T84xnFSNvgR8bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJYGXBoAxH0Or7NQk1Y9P/7QVeMv5Nsi4OkzchS4WxE=;
 b=dVxUUhS9ftr22i1EdtDvxSL1mkSPIomtwJ3Fu6HYxz6bOqge9DBkEFBa0mbLae5wrRAdFntOF1Uokc9expxmtPx+7KCkRAVNXzm9A+5SBAvfHt7381DMfy/qJ+/A6/T+FLEeumFCL1CAtjvaldUkOzJ1SVBMg+v724qPkKyOPpyFtLdlfK5AfPJCvyG8SwrQfoNSYTuy2KKp8xZjgAjp7XUQUWHrRB+OXKzKTxUCI/PuUEBoWZzim0ligQUI3OJmcbMF+Q8s1G0TAP0Pja4zZ/hea4JxPANLsojh3X54vF8C+4ho6F5bb3vt3PKu5a6sE3z8BVgyGqdvom1zt/EC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJYGXBoAxH0Or7NQk1Y9P/7QVeMv5Nsi4OkzchS4WxE=;
 b=ZdV9jMchkDuIvL6EoyN25T9SbmBgY1KTyn+G2QJzLr9SZxOgLV2GC4lH4uF+JRol5zWEx/FDqJiGhmP7IpHhRg5kZRjzeX41eZv8OxYnCXiWZVWMLixdy8tZNyjiNLnkLno93jQcWs3ZXeZLf0RGboQ11YSmzVmvVCUohIqpVlE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 21:14:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 21:14:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Topic: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Index: AQHblPnP9d0AvXdgXUGJVdEv1Rh2trNzIhyA
Date: Fri, 14 Mar 2025 21:14:25 +0000
Message-ID: <20250314211411.l5taj5nysvcalfyz@synopsys.com>
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
In-Reply-To: <20250314155706.31058-1-mike.looijmans@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7359:EE_
x-ms-office365-filtering-correlation-id: f69d6ee5-e292-4e6f-711e-08dd633d32ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWwwNHpFV1l2Yzl5S3BqYVFaRVpyV2gwTnlGNlV6MnRNNUU2cVRzLzA1UGZJ?=
 =?utf-8?B?MVYxRW5UVDc0SFMxMXZtVDlySGNvOU9PbnprWERHaGg4MFkxdDd6dGZORXpU?=
 =?utf-8?B?QWF5NUJ0R3hhK25MdU81RlVpanZ6Y1EzSm1pZ0h2VHhqaDU3YStDMy9qdHEz?=
 =?utf-8?B?c0NIL0JVaVlRenB6Zk5wK3A3TmdTeXJ2WDdPVi9aR3pKMjVNYk5Db1FvU0Vt?=
 =?utf-8?B?UXpnK2Iwa0dCaU9IRDAzMHJEUkk1cmdWTDhMZXRuYWdubHZ6ZXp1Q1NLU0Fy?=
 =?utf-8?B?SENNd1huT2lJUmFrTUJYKzZuOW03alQwK3JXRElYNlB4SFZEY2JrbVFCcGJB?=
 =?utf-8?B?VmNVSE80VTUyRzNwc1BxbGpndnI2U2lEa1pxUHpMbGlQb1YvZDBSMldYcXQ0?=
 =?utf-8?B?S3hXQTV1ZHZCV0J0R01sVHVpMnNKMldQOWk0QU01WUplckk4WStXeHphdEtj?=
 =?utf-8?B?VEpnU2xFVFRqZjZBQ3VVa1orLy85Qk9wa2ZCMm4vZFdVR3ZZU3lvb29GaElH?=
 =?utf-8?B?NzhpQnlaZjg3a2svUTVKUVMzMmYwNXd2UkVSdEk4TlNWMVdIcXFHOEVIby9X?=
 =?utf-8?B?MHZLNmt2aFQvcGZHYitKVldxcTh4TS82cVVqTGhNMHdGeFhkdlhTR2FLMVdz?=
 =?utf-8?B?Y2Y0eEtXbThIaDNZaEpiNU40NHJmZDdnYkNhSkhDViswbHhwQ0tsa29idkVw?=
 =?utf-8?B?YkE2d0NwbGNZb0xiUit3UnZQWFNFaitDWTQzQ3RCR3JURlhwaG1nZjVuN0Ir?=
 =?utf-8?B?b0R4MDg4Y3g3N05BYTJud0RMNEhRdlRXbmI2SW44N2dRdG93SWtaNnp1cG9l?=
 =?utf-8?B?c2FTdzljWjNMbisyVDE5TzdXbGk0K0xqTkNHSFRqRk83U2w0R3FTMUlsT3ZF?=
 =?utf-8?B?b0tzRVpqaC9TNXFTK3YyTWdpVEZUTVB6L3ptbnphT3NFdzZmSzBtMkJWZ1RY?=
 =?utf-8?B?dU9ISWllR0lJak9DSndockZvS2R2RTFBY1dUSVFnNG13aWRJSllJT1VHT3Ux?=
 =?utf-8?B?U2hielpVSzdyaDZqcnRrYnovQ1dqZ0JaTktoTnU1YUV0bGNGMjhNc0dnTFVU?=
 =?utf-8?B?T0I4akJzTExEN3luN2l2NUtyRnNmczl1aVJ1bnF0Z1hqQTZUU1BkT2pmNGJu?=
 =?utf-8?B?ZXNuK0YwU3hkV3BkWURtU2s2RHF1K2xBYlR0TXZqRlFtMlQ2aytmS1JqSGww?=
 =?utf-8?B?dGR3ZmdtanJ6QUwvRFpGMGJFVVFSRS9tVlgxRVltcm45R1JoMTJtMVY0Y3hS?=
 =?utf-8?B?NjgwL0F0ODNzSnhDMU5nZ2JwVGJRVGR5Ym1nVVI5d0gzd0FxNW9xd3QxcTh3?=
 =?utf-8?B?aFU5R0FPSEM3eStEU0ZROWlEc3BkbTJldVRFeUZ6WmxQdDZJenBpOXdueGxk?=
 =?utf-8?B?RUt1M21VSkwzWmdRb1V6RVNSQzBlY2tDTS9nMVBsdy85K1VJZis0WHdmeHdo?=
 =?utf-8?B?VS9QVFVORU5TSE01a2lBcTd0NHB5aTVTQlJIRFRjUlU5WTZNQUN5WmJWM1Nw?=
 =?utf-8?B?YkhhK1ZYREp6Z1FkSHhXQyt2MGpkUFlyeHk3UEJQQVh1RFA0VkNFMWlIczd0?=
 =?utf-8?B?QW5RYjhyR3o4ZXVLcVp6L2VlZFRONngrUUxFU0ZVYXlvV3pDVXl5cUMyNUdS?=
 =?utf-8?B?KzBidjZiY3daOVlMeWxXWjhUdm9aYklNZVNTUjdaWjAvRitPUDh3OFJST2Fj?=
 =?utf-8?B?NGNvZWhzeDZpdC9Qc3BoR1pSWjlDRmRYc2xScmE5YW9CUUhNbHJLZGpXTnFT?=
 =?utf-8?B?NC91U3FrYmNYSnY4Zk03ODBFZW5hSU9ndXJ3ejJFSjYvK1dJQk5KTmczeWlB?=
 =?utf-8?B?NUR6ZWc1cUdpT1VoMnFWL2FOelFIc1NnUG9wcW9tenFES2dRWHZLdC9LODl2?=
 =?utf-8?Q?sDVS9RBNb5wWP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akMyTWlTODI2V0I3c2tjK01wbzVPOFdqTVFKeXMvQ3NzSGxWR1dXY2FTSTh6?=
 =?utf-8?B?dlN3akthUlp6QnBkOThKR0lLc0xLejdFV2M0eE5XWUI1T0FQdThNVktVa3A2?=
 =?utf-8?B?c0dIbk9lRDBVcTBuMm4rdktCTmloRHRaL2p6K1dncXdWRVh2VXI4UmhWUENZ?=
 =?utf-8?B?bjlFa3pPU0h3NTAxV1ozeVM1aUM1VTZVekw2akJ1SDZLZGtzZFJTd1dIbTRL?=
 =?utf-8?B?cTBXZ20ySzh4MXhKek9MaHdjZStqMks2ODRqSEVvS3AreXp2WjQxcGQ0WTlw?=
 =?utf-8?B?dzQwTzc1Z2ZqWXZQY1QzdHFmUWxrTEEySVg5cmdoM2FxMzBnUEZ3cXBVZjVF?=
 =?utf-8?B?UkhDMDdzYlo0aGczSFhjWHAxZHV6NElCdGdGMTFRZ09FNVoweWdHak82cFB0?=
 =?utf-8?B?Wm91R0szdEVRZkg1RndDWkkrT0lRWUtiR1VJT2dUMWFpdmJDdk1nUEIwTlU0?=
 =?utf-8?B?WlMrWFJ3d3VNcTRjK1pROXBhSGJ1Z1FlbnBNK0VZajB6ZDU3bGY3OHlZRWZE?=
 =?utf-8?B?RG9OazcvRUU4MHltUjhzVXd0VDNIVWdmTWJsOUF0OWwvOWJUc2hLZXFFY1J1?=
 =?utf-8?B?TndGUHZKNWd4eldlYTNBQUlzbjVob3A4V3RvMkNDSml5d093eUU3RDZqM21J?=
 =?utf-8?B?WUVBd0pibDFmenhZUDZLTWN6WWFFeVdRNms0c1c3aEFLOXE2TUFhVmt2U05r?=
 =?utf-8?B?b0hNRjVDTVpaTWJmTlk2QmhUNXNPbWhnWUNRUmQyaEJKM2hsaG9VQVp1Wnh1?=
 =?utf-8?B?cWhxQU9HV0kvV2tmM2pmUzhUd255TkI5dWQzRXk2YlorTWFkckVRVitzU1lN?=
 =?utf-8?B?UGlkZUh3bXFudWlHdklET2lQWkNDMUVqTEhOOFFhM0JNTVN1eTFKbzRFMUF3?=
 =?utf-8?B?UGdXYTFQWFkrcmhmcHdiVVVFbTMrTmNwVkNjZ2pSMHRsWmJoTTdzejczTGpG?=
 =?utf-8?B?SGFrMHNneVR4UGM2VHNMTlF3UCtwK21sQWx6ZkJzcFNKdnJ0VDQzR2ZYQVgv?=
 =?utf-8?B?Zk8rTjZQbmRSUXRUQzdqQWplclk2ZUlsTUM1WUc1My8rN2dybTVHOEJRekxD?=
 =?utf-8?B?Vjc3dFl4WVUwMkFXWTY3WkZFN3FFUzVDbE5WZTlPUHNSc0Y2eVp0cFZSS2cx?=
 =?utf-8?B?WVJIeTFMMllyYUZBUVZkZ0o3YWNRMFlQYUFVVEdqblgrZitRMnVVMHRMNTBX?=
 =?utf-8?B?R0tVNWZPQUpqOUJyYlNZTVp3NVhSMjZvajl3K0FsWXAxL2E4M3hJUXc5YjFk?=
 =?utf-8?B?dityQlYvTGRoZ3lrVjkzbnZuZ1NpUTJTVEgvemhlUlFhaFF6SE1BV0p2NlVz?=
 =?utf-8?B?dUhVcmxIOWxoWXJlMTdNcTdCWXdUTGxwbFFQK0RNZjRnTFg3WVp2TlhxRGRH?=
 =?utf-8?B?WktWcmhLcGI1UUFlTExXQnpkQU9UUHl6aUdmNWdkT2R0Sm1HcGUwMjd3ZFRq?=
 =?utf-8?B?a0RlVk80TmNSRWRYQ295WG54TnVlbVg5RHppQjdxRGtYZU1lTUdIYW15VnZC?=
 =?utf-8?B?em4yVkFxSk9uQjJrVkp6NW5aY1h4NWZwblJNczkvc0YxOVU4anNJTDNPZkl1?=
 =?utf-8?B?ZXlzaDNQajZtTDVESU9GSUE1WUp2bEZ4SXUrbjhrRk14N0RZOWY5cWxPanN6?=
 =?utf-8?B?RzNLR1hWQ2l1Q1N2bmoxMjVKN3MrTDJRajVsMzYyekNRdHRvZ2RuTHVLNG9N?=
 =?utf-8?B?SnRKcGRZMmZlUnYzREVyaGdEbkhIQkVqNXBqVmFScTJUNllWM3J0UG5MMlh5?=
 =?utf-8?B?dlNnaTVXQkxiYnNZc1VhVnN1K3dPRDZHRC9rZnUvQlNaMTl3Zi9aUTJFNW1O?=
 =?utf-8?B?QjROc2dIbHIyQVF4elhPSFVFK25mZUMxcERWU0pSK0xpN2N2eXVubWhVUVVX?=
 =?utf-8?B?U0hyV0Y5UVl5cndmUUhnMjQ1Z1d6cGV3NFRtTGl6MkxkVlFidjMvenMzdnVy?=
 =?utf-8?B?ektaM21OTFlHQzluZDhPMjNvbDZMN2dmRlNFcG9xbGJocGVFK1lFRHlHUFRw?=
 =?utf-8?B?ZDZqSDRIb0dlb3pzOEJNTWc1eWpGRU5MVGFGL0NpVzlacnNoUVJxYkFlS2VG?=
 =?utf-8?B?Mk4vNmdGOHptTmRtb0lZVDFYRGdDd1Y3SFdMSm1ZNld0TzhWMWJMQ3VRWWt6?=
 =?utf-8?Q?Scy0lS/hURXXBZOD2FyGCEK5s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53ED31657242B94795548D5E38A3B326@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F2tcqFIn9BPq+i/4qNSx5A53IBvgwM8Lu7pGMYZ+M0FcD4GPSaQ1LNZPOL9Pg1/vnTExlVroWOEzolIulX2zzAdJtXRIYecapCV4xAhBhHKv5NlY1FeT5nk/lddOtjfrQGbHckr4xV0d3X5NtkNwTM6iYhcG65eYm/gJ3GGVvf35gxduzwo3X8dJvsY4d84/+926ZMU+2lMl560kb862UMWfirlWNbPzywzsk9PImEi8Xfz8Lua9E351yjUV6eoFBA/+ZkyVDQisDjr9VKCx231PXvHlKKVaUHwSWFLEndGQEreAwI4gA8Li1LdVqaU+8mvRLcc22cIlUJcnIywksjFYUQDFay1gr/wqPqJd6QAZfDzjwv4fWqBRYmnjEhX98s4fjRPB0vKA/B/D1mdDmkdL0OEVvg6vpunBdiJ0pp/CGJ53JFlsIL43rPgoSHxJRldVRwT9Jpu0uRXq+RFecPYJhVG6nnmPBv8WCs0TwrrsBTWrPRtwEykxWRFhPlMP6eJnp8ymR+y1tyXpUtfw6lw/H0p5yeyStr9dJSAbnEkAoY+R5VR7NBfVSdc4nqKb+QoOYlmGeJ3OrLUrCdsPzKJ5tPP7beN2t1n0Q4h9Bd5qMk0ZUxJOSxvzLcnLLhjD0RB+NfyqAncFjTNVATdMjA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69d6ee5-e292-4e6f-711e-08dd633d32ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 21:14:25.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOR6nj8jLlCQwsmjFJo4MfpIEx+OUO8fRp+PjhB/EOHI7p8walYU1q5b2k9Wkh7qcyT0tEGRmuwndkM8vXpJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
X-Proofpoint-GUID: pNUaODk8MXobxP81JczsnNh6aiTbm7BB
X-Proofpoint-ORIG-GUID: pNUaODk8MXobxP81JczsnNh6aiTbm7BB
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=67d49c39 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=Z6EfDJrRAAAA:8 a=sVRP_cUpjjfYkJOGKwQA:9 a=QEXdDO2ut3YA:10 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140163

T24gRnJpLCBNYXIgMTQsIDIwMjUsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiBTZXQgdGhlIGdw
aW8gdG8gImhpZ2giIG9uIGFjcXVpc2l0aW9uLCBpbnN0ZWFkIG9mIGFjcXVpcmluZyBpdCBpbiBs
b3cNCj4gc3RhdGUgYW5kIHRoZW4gaW1tZWRpYXRlbHkgc2V0dGluZyBpdCBoaWdoIGFnYWluLiBU
aGlzIHByZXZlbnRzIGENCj4gc2hvcnQgInNwaWtlIiBvbiB0aGUgcmVzZXQgc2lnbmFsLg0KDQpI
b3cgZG9lcyB0aGlzIGFmZmVjdCB0aGUgY3VycmVudCBwcm9ncmFtbWluZyBmbG93IGJlc2lkZSBw
cmV2ZW50aW5nIGENCnNwaWtlIHRvIHRoZSByZXNldCBzaWduYWw/DQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1pa2UgTG9vaWptYW5zIDxtaWtlLmxvb2lqbWFuc0B0b3BpYy5ubD4NCj4gLS0tDQo+
IA0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMyArLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMt
eGlsaW54LmMNCj4gaW5kZXggYTMzYTQyYmEwMjQ5Li5hMTU5YTUxMTQ4M2IgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMteGlsaW54LmMNCj4gQEAgLTIwNyw3ICsyMDcsNyBAQCBzdGF0aWMgaW50IGR3YzNf
eGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICANCj4gIHNr
aXBfdXNiM19waHk6DQo+ICAJLyogdWxwaSByZXNldCB2aWEgZ3Bpby1tb2RlcGluIG9yIGdwaW8t
ZnJhbWV3b3JrIGRyaXZlciAqLw0KPiAtCXJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRp
b25hbChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9MT1cpOw0KPiArCXJlc2V0X2dwaW8gPSBkZXZt
X2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9ISUdIKTsNCj4gIAlp
ZiAoSVNfRVJSKHJlc2V0X2dwaW8pKSB7DQo+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwg
UFRSX0VSUihyZXNldF9ncGlvKSwNCj4gIAkJCQkgICAgICJGYWlsZWQgdG8gcmVxdWVzdCByZXNl
dCBHUElPXG4iKTsNCj4gQEAgLTIxNSw3ICsyMTUsNiBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9p
bml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICANCj4gIAlpZiAocmVz
ZXRfZ3Bpbykgew0KPiAgCQkvKiBUb2dnbGUgdWxwaSB0byByZXNldCB0aGUgcGh5LiAqLw0KDQpE
b2VzIHRoZSBjb21tZW50IGFib3ZlIHN0aWxsIGFwcGx5Pw0KDQo+IC0JCWdwaW9kX3NldF92YWx1
ZV9jYW5zbGVlcChyZXNldF9ncGlvLCAxKTsNCj4gIAkJdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAw
KTsNCg0KRG8gd2Ugc3RpbGwgbmVlZCB0aGlzIHVzbGVlcF9yYW5nZSBoZXJlPw0KDQpCUiwNClRo
aW5oDQoNCj4gIAkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW8sIDApOw0KPiAg
CQl1c2xlZXBfcmFuZ2UoNTAwMCwgMTAwMDApOw0KPiAtLSANCj4gMi40My4wDQo+IA0KPiANCj4g
TWV0IHZyaWVuZGVsaWprZSBncm9ldCAvIGtpbmQgcmVnYXJkcywNCj4gDQo+IE1pa2UgTG9vaWpt
YW5zDQo+IFN5c3RlbSBFeHBlcnQNCj4gDQo+IA0KPiBUT1BJQyBFbWJlZGRlZCBQcm9kdWN0cyBC
LlYuDQo+IE1hdGVyaWFhbHdlZyA0LCA1NjgxIFJKIEJlc3QNCj4gVGhlIE5ldGhlcmxhbmRzDQo+
IA0KPiBUOiArMzEgKDApIDQ5OSAzMyA2OSA2OQ0KPiBFOiBtaWtlLmxvb2lqbWFuc0B0b3BpYy5u
bA0KPiBXOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL3d3dy50b3BpYy5ubF9f
OyEhQTRGMlI5R19wZyFkdDJTeEhQV3NrZTJnWTJQTlE5R3JKRXI1bFhYa1VDTWI1Q01CZDJ5bVBF
WXBVMVRFZW1NX195OV82UXdpTVR5Q0lYOXdYS0tBT3poWDVFeDV4NUZXYTFRVjVJOTh1MCQgDQo+
IA0KPiBQbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlz
IGUtbWFpbA==

