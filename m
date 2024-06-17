Return-Path: <linux-kernel+bounces-217947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908F90B6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07211C22C43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55F15F411;
	Mon, 17 Jun 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otSsd8OA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kCehTILu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFE1D9526
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642656; cv=fail; b=VH5ChuEfrK9lRMwJLZsd6t5GMJOKhfxHfGvMxXBehX21kiJaKEFQWaFHgJu3byitHzAWJBFzSSet13TJtVqyEcwX0mKI4VZqgVoiL8OO2pu/1R0PRunq7i+0kSnufaEkKY0K5W7oDAcTDN/bHmbxKyJ5txhMzLE8hoTNqYWNQfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642656; c=relaxed/simple;
	bh=r587MtF0MJECt4G8xLFgrT1xVIH+DIYb6khTQsEdQos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ca4KIm4o+r3ESyUvnKq+pPYyUMNAe7002DoVg2tKOeXWAKHNZis+mbq+6UzfK0UgH8UHxQZqLXWyBT8DqfSgTtndyUhIMz67xdW10Ft6WZkHapwNK5H/sMR4qVu7n9SPl+jpcjvicrhlGo3ERNhIYPEiERDL9UlgO2eQqA11sm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otSsd8OA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kCehTILu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBOKZ023402;
	Mon, 17 Jun 2024 16:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=r587MtF0MJECt4G8xLFgrT1xVIH+DIYb6khTQsEdQ
	os=; b=otSsd8OAPjoBDUHSMhbe6qA/VwndgMfBrExPnzwgAgi1zL//VnubYnYIC
	fjTpqMfW4ydsZtDC7XLMX5JxIKKHb58egTbDlOOmFBa4k24pewVL5JGDlo5T6XiQ
	ERS1XpZsO0gr8NAMelLU9s7ZmZBHA2+YrLRRDUmOJH4SdooVy0hH4Kx9cmWZ8fyF
	2NWZ4GkEjnyTNay12OGAwWJxZdTKw7qL2c6ne3CJSrbSg1EBuMm89Bdi340O62Fc
	UOEQ1fi1wRtuOwjS5HjJZ5CBpl14O739sXVBMdYVx53BcBl6XawSwOcteO7dhm4G
	4ofCYE9o7Q0u55rhT3Njbr96QCA/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1r1u5qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 16:43:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HFOvrL032810;
	Mon, 17 Jun 2024 16:43:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6q6p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 16:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+YnxZcXpGYN5ybRe3RvAQ9GRrpjgQ6/VZYRsQ3p2XxCuBnpLT+cPGOnBymTon9xbgYbGeea3MqoCYM3fQZA8ocP4B//qXL+8r3UxuswjrN/ZiiBQZ4VvPYNxw0Sgp7yIHH6IdDOt7sm2jDNDpg5qoSKrBkvo3bUK+rwzKihuZLOCPPLWAITHAAuh6II+NhudkV/OcLRD21KwbK2epipRz68rikplLq+a3n0WwIAfd7SkTJRM9wIfmeD7pGhMzL/DSBLT7gK3msEkvGiYQulnF7YMJWGTltvJvA+Y/GgBnGQUbzhnwPHE7AJWJhDeEaGmEH1vhiKLZ+9C/zi2prN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r587MtF0MJECt4G8xLFgrT1xVIH+DIYb6khTQsEdQos=;
 b=oUQuT9Y2IAajUfQ2x7/Vh41u/Sac3I2cVVY3TdL43hksS+t5pCldDrkxG4p5lhqLiqadNtXWamodYlok6m3KVMGJeDvTEdRD0/pIQi8qjbGnwe5zt2BL+4x9e5offTAG6oUJ7A6hm2VEuSUWijpPbBF9Ss2Sy5LsSGLKfiGd72RLp4FNvenSYRjZZNyo4kDXYTXuLbTDyIQQEt0OCySDBEdnsQAyxA+LOIUNEmy+ou0qDV/xnpRcs45LYbD1WwMpO4svT63tZYwz2nqEYZg5nkoV04w++fGfxyufJLHQZrYQkCHDA3BkOo+qj/Xv9z7OoGiyoKKiZrFDh/ZYp38J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r587MtF0MJECt4G8xLFgrT1xVIH+DIYb6khTQsEdQos=;
 b=kCehTILukMaNjTt/2pnXKE+nF4qx/G7Cbh15sqZlIaUIWbjbgbzlsiDGG0tqlxcuauIY7PI6qRqoVzP3IhbSXBVk3FpJBcT/uKX4vve/O9MHSolqmKpsIwdKybnMJYAfeRhGcM7+dtLKuXPnnZrrfJbtBSDoUPhVSlcbhgI1yhs=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:43:51 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:43:50 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Keith Lucas
	<keith.lucas@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>,
        Matthias Neugschwandtner
	<matthias.neugschwandtner@oracle.com>,
        "jeffxu@google.com"
	<jeffxu@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "sroettger@google.com"
	<sroettger@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
Thread-Topic: Re [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU
 on sigframe
Thread-Index: AQHauGKQF0B3HhgkNUGVwycOSCk5jrHBjJkAgAETbgCAAIhLgIAJEeuA
Date: Mon, 17 Jun 2024 16:43:50 +0000
Message-ID: <90B0A18A-DB23-45DC-8491-0CC293FB6264@oracle.com>
References: <20240606224035.3238985-3-aruna.ramakrishna@oracle.com>
 <20240610213934.3378947-1-jeffxu@chromium.org>
 <2DB720B0-0921-4912-8C5F-F0EDDF77845D@oracle.com>
 <CABi2SkVZA0-7_PPbvycaojr0qBPVn7DPW1F1CpNTZwT_Hi0xiQ@mail.gmail.com>
In-Reply-To: 
 <CABi2SkVZA0-7_PPbvycaojr0qBPVn7DPW1F1CpNTZwT_Hi0xiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|CH2PR10MB4150:EE_
x-ms-office365-filtering-correlation-id: fe149eb9-5c62-4687-ba5d-08dc8eecaad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|1800799021|376011|7416011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eVA5UG93VHI0TEdINUErR2VmOGlMWWZ4N3drNDduVU4yaHovTjhUU1c3cGY0?=
 =?utf-8?B?L0FqUjNvREV0VWIvQmNhNUpUYzdkeDUwS0pFeTFNSFFCVSsxT1pEcGkvMTBy?=
 =?utf-8?B?VEJERWVVNHlpU0ZjSGkrRjBIdGl1V21mbmpVTnoweDRmbmV1ako2TVB3dTNa?=
 =?utf-8?B?RFFpY1FScEZrc1pza0xGditLUHVPazBMZVJWRDFzdmw2VEw0dGI0dzJCa0Qy?=
 =?utf-8?B?TFA0YjR1SUpPYkUzbzdqRkJKK2VOMTlEVFdOZm9QZjByQUxicGhVWnhqY2tQ?=
 =?utf-8?B?WjZaMjlxbEZHYVdpT0NmY1BFcElld1pGVkFpaWhtQnZRUmU2UWdsNkEvanNK?=
 =?utf-8?B?Q0swUElUNm5aRE91U2c3emwzSVExd2J2MHZ6c1lmYkhOY0N3RTlQY1Nlak50?=
 =?utf-8?B?UWxEL0E2ZmUya2FhVjRyNTRhL3dUR2dROEE2QjZmU3NqOW9LQzh3b2ZKSnR2?=
 =?utf-8?B?NjFNVnowODhsbjZjWFcxZUJ1NUZEQUhreHpJWjRaMHN4ejRmcStrMzFNYUt4?=
 =?utf-8?B?TytTNGt2VENjc01vbDJJMmQ2b0VWMEd5NFhPSFZVMXYxMng5T21PcHZBWnJi?=
 =?utf-8?B?b2xzWGlqUWFzV3NTUG0vcWYxRkMvUzhwTW1LY0IxSU1kNFhIS3BTcXk3ejgy?=
 =?utf-8?B?Q2FVUnR2TVFZZHkyRGgwTFlSZzhpeWpXVFVLMGJPa2puL1JFa3lUeEdGVFk0?=
 =?utf-8?B?ZzM2NGo4U0pOQUJoTWx1Z3M0MDFzQlhVLzF5aktPOTNOemtVRVZIV2hneEtq?=
 =?utf-8?B?Mm9Qc3FOVW9ab1hwRTdFdXFBaFBYNVF4QXRlc2xxd284Z3R0RVR0TXJsVGE5?=
 =?utf-8?B?dzI0TGJQclIwcDVGU2JmWi9ibGF5aXdlWEppeWhtOEYwQ2luM3NEK0xBaGJw?=
 =?utf-8?B?OGRualNsTTViMWFGQlFZVnRnOXR2VE12L2tCQ0lGeCtlVzNWRFBXTUdRRnNV?=
 =?utf-8?B?WWNjOWlYR3VKY0NQQkZLckd5ZkhaWmFqQlY1NjdZR3U1aFk2a0JuejFSd2VR?=
 =?utf-8?B?WnZvbzI2MUVlL0tzQnJJekJHbHBTMStDTWxnQ3hVYWZ4TUFpZThGUWloL0po?=
 =?utf-8?B?MElVWUt5eU13Q3ZBZWpRR1VzNENmYjFubnhPWmZ1Q3RrMkNCSzRLd056Rk1t?=
 =?utf-8?B?bzJWQitwTTZTSytsSmVkUEJSQjk2L2YyNkhtZG5aYUtKd3NLVjJ1S1Z5TFc2?=
 =?utf-8?B?WTRRUHNEZWJ0ZlRjOXpESzZVaUVnYnYxTllqek9EdFFFRmxrTnhQSUI2RUpk?=
 =?utf-8?B?YTdiOU5iQlRJSGhTSTRnUWxLdGl5aktCV1A5ODk1Zk9wM2tPM1Z0cnIrYmpV?=
 =?utf-8?B?aHFucWZwdnZlaDFqSGx6c0NRbVZWNURWME4rVVRubkNGYkJUTGVXcWtyeU9Q?=
 =?utf-8?B?bTZJVXFnMVhqTTVQTlgyYnB1dUJGN2JLQ212eThLMTVSUmpYdjhodG4weTZ2?=
 =?utf-8?B?Yk1rS2tmekdwNWhnT1lweVE1MmlXYzEwbVdqNE1aaWJOVWNFbVpXYUZEQUtY?=
 =?utf-8?B?b3JsMGNnclFBN2ZYWjZXV0p6YkFtYWJhNnNRdHhQL1p0eHJrQ1hpdVQyRytJ?=
 =?utf-8?B?K0Z0dmdUM0hEZDZUVzhVR1FxSkJiL25mdFVxRldrSGVaMXRWa0p6d21zMVNn?=
 =?utf-8?B?dVFsNUZnbFZYTGdiMEkzTFZIbFlzUmlKRmdjcUtMbWJOK1BkY20yejZjTEF4?=
 =?utf-8?B?NUhzaENIb1pqWkRFd1Y2M1V4c0krY0xRTGVoTmpxZHdTMHdobGcxbEx6VlVB?=
 =?utf-8?B?T0tWdUVSZ3ltem9UOS80YW9LNXpwTXNxTGgxRFduM1ZEdzFXOFc2cjZYOVNv?=
 =?utf-8?Q?kkbFRhh9+2JY884qzyF5mN9uXc5UMA88eLYxI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZStaQ1k3QWZHNW9CcVNUTFhQYW5HdHNmWDdmdENFRmZ2QUJwMDZHNEZUWGYy?=
 =?utf-8?B?KzgrcnUvRVc2UEVwbE9Kdm1seEFYbmJqZUdkbEc0YWxKRDkrWkN0WVdMSTVD?=
 =?utf-8?B?TENKbUdkWnFKU3VSRmQ0OUhUZkpJN2pVNm9DSjdCdUFnZWNuUDhmb0JBQVY1?=
 =?utf-8?B?MndWQ00zcVpLS3BzNTh6eFFHS2ZNUVovcjltNkdPYnVSTXVkWDUxODZtM09B?=
 =?utf-8?B?OXhOQmxoZGRmNE9PYmIrcmwxNHFRMjcxNXA0aE0vaXh3NmZGbEc1cmk4RU8w?=
 =?utf-8?B?V3U3dW1VbHZuVUJJOXhjWmlhV240UzVweFZ4K3VUdmI3MTBncEY3RzN3MEVY?=
 =?utf-8?B?VVFmYU42RVZCT05oMzNKbUVZaG5LRXR2R1I5R1hhTlFBNFFMOGpxSE15OTJN?=
 =?utf-8?B?TFpvQ3Q4U1VPRXlNMGZUQjhaQU9kRkRSUWVicm9aM0E5OGdwaTFYZStxV09V?=
 =?utf-8?B?TFQ2NUtHSTB0Uk5DK2duSkdNU2NXLzNPK0svZ2tNRTI0NU9VY0dpRnJCRHZZ?=
 =?utf-8?B?REZtbWZRc3BhNmVweVovdzM4dkJCdWJNdXQ0TnNEVlpGQy9WMzFocVBtdWRG?=
 =?utf-8?B?NDhIUmhSbmIxOXFkNDhRNVBLanhTNzQ0c1FtM0ViUldBdWp6QmVvZW1PSzhr?=
 =?utf-8?B?LzBPTHcvRS83SGZyT0tOQjJjeE5hU3RUQ3dGWExzZ2dMU3JRZUEwczZvRXc2?=
 =?utf-8?B?VWt0M1ZWMCtydFpJRitnU1JPUlN5aHhuQjNZNEEzV0xnNDR5TlBvaElDbW5Q?=
 =?utf-8?B?K2NXZUhQUnBweUNPSlBJcFd4WVZBNDBnUjlOc2dMemxBeVdaaWpxZ1lyUjRX?=
 =?utf-8?B?TnpFYmJIcTJmQWxTOEhUMW5lRlFXRlJtY1FkSXNDblFLNnlUcDMwUG84OTRy?=
 =?utf-8?B?cmNqV09XQlIvNTNuc1c2NHdLZU5KM2lGSkRKdFdnQmN6bmxjWFNzd0ltOG9S?=
 =?utf-8?B?a3ZGbjNSa0RsbUdhMlBFZ0diSXZheVh2NE5ndG05TXE5MVhIU0didFBIMm0x?=
 =?utf-8?B?aFcvaCsyL1Y0ZnI5YU4zcTdJemlHa2hBYk1IK041S1l6WXhKSnN4bm9qdFM5?=
 =?utf-8?B?WTVyNDNzRHd5K3JXYjcvckpDbXVDcytPaDE5TjBST3djQUI1UDdrbkRMbUlt?=
 =?utf-8?B?Uld0cTZsOGpZTFRXOWdGL3hlSzdmTTl2Y2NxTkxLbTlaUGhZVmtxZkF2YlVk?=
 =?utf-8?B?SmNVY1BoRTFhQWtmekVlZnNjbUdTbFRLSGtDYVhuRUlralFqNjJXNE50MDhy?=
 =?utf-8?B?aHA1S041MVZicE42Nm92QXd4bG9Wc3RtYjNzYTkxSURaWWl2bm1aY2lCc1hU?=
 =?utf-8?B?bUR1WEl1WVRCcmt1Q0YrdWFuSEN3R2dRdC9vOVM3L2p3Zjc2MU4xMmR3ZzhH?=
 =?utf-8?B?VVNDS2dON2F3YzlML2szT0NWSk9QQlRJdGJSd2xsVUJTc3JRU01EcUlYTEVk?=
 =?utf-8?B?S3R4N3c3OGF3RUJpdFlEVEZpRlRteGk5cFJ6YlFFNUJvbk50b280VmdXdmhW?=
 =?utf-8?B?NUNmWUFGZVk2N0F2ejdoYkY5ODBKajIxV3VYTHUvbUxkZ1Fsd25NS0YwM3FD?=
 =?utf-8?B?MFRLejJ6WHp5R3dyaUFDNG5OQW1YOGZDS0ViWlY5MXpRT0FVdVBONEVzaUgw?=
 =?utf-8?B?QkRzZTQ0OXAza0ZtQXEzeEtJRlcvb1RVSVRQYjArWTVKNkx5MXlMRHF4TVhO?=
 =?utf-8?B?QXFqV3Y1QzJFZitPS2xYMkkxaGhLSTB2N1p0eWhIWWN4bnpDOW5hZzNJQlRN?=
 =?utf-8?B?THFXT2NUamhvWmZQZVphS1RNL3dTaFRBMFRSOWFXdzNmRS9sekZTKzFXVnpu?=
 =?utf-8?B?T2ZBcmhDWFVWeWJ4bnluTXBleXZRYTNjTmZHS3h4ckxQemVreWtLeXNzSlRB?=
 =?utf-8?B?Tm10R2d1UXEyUUxiT1Z2MVliSHNJeXdnM1E1UjNMZ1IwK0c3NTlFYzZhM3VV?=
 =?utf-8?B?cm9EQ201V3pXeExjUVdxS0IzUlhpWTN0T1dMTS8vS0IzdHBhWW0vaDF5MlNW?=
 =?utf-8?B?MUNYTjR3YW55dEpSdnpHYXFLY0Z4YzlIZTVzM0E4ZWhHUngwaElpOTQvSmZX?=
 =?utf-8?B?d3JjSkk1R1NleDdUeDRNN0R1djBkbEcrNzR1N1laZXNEMlRKWXR3bUZscExX?=
 =?utf-8?B?Mmdsa1BLUGF6OHRvL05Ia0xPN1hXS1AvclZ3MjFwaEpsMnN0cDZtMURGNVhY?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F8509E090FA5840BF6D5E917A83840C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MXRf5pUO8e0MTNhhTW+6wYU2eDSNyQS9AXRuJ7t3zrKjDzZZcwbunax0x/MWGcvc2vQcvIfjHoyhVsUFO8dq/Q1SFAIU51L6ZasJg3QIec+O1EBtWmJe6XcN1CXLzS9b5Au3nhTBq5jF7Oodu7dABKalv3MwBH/4Yf38yDZZQGaaV4LT5jfnWsjHGLYfWKz19tkskAUUGcpBbNxqAk2TGUL4cA1leYJvniV066eWyT7A227pUSg7CK+u8bb3WOrUOHkOGvzXDJMCfVNSEWxj16XxrAwOTs1gDOAHpLvIXtmJhYuYkrlqA3hAwVs+3udMceSvd/h+ISH6vSyBEiOLVBpJR0QaVIc0afIDF6zXmbNVGXU1nAp63I0dLP1jzTHXNpGgrXSdirTrXOr806JbJ5fYipMTgoyPgfhQJ1yt4d0op1KjT338LuWJSJTSwe6+wPRY+PSRHBjFiD+hEBjxq4CeJ5aS9L9gmmwnxl0zzWM27quLQO022U+IB6s5fT9SIIlnvuLZS/QbiBR88IRXgMJzkF4FL1bhBVLQC9jY2vXwxqh9CfTlfR4wE8zyUWYxi9dnTGO8/HtHWlBWVE4RE3yX4jphinSFJxv0j5ewpH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe149eb9-5c62-4687-ba5d-08dc8eecaad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 16:43:50.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4uJPgEUCmgX+oUwtMY/SCNx1cLfRcLdm2xzH8k6zEWG3z1jDlRz0serZIvRzgMyJ8zlalDJR+nDJPB1/7tbmFcaKN9zEHRVIVM1bcvQxNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170129
X-Proofpoint-ORIG-GUID: tx09oMPzUd8r7v3nIUGxNKLtCxq3igNB
X-Proofpoint-GUID: tx09oMPzUd8r7v3nIUGxNKLtCxq3igNB

DQoNCj4gT24gSnVuIDExLCAyMDI0LCBhdCAzOjEz4oCvUE0sIEplZmYgWHUgPGplZmZ4dUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgNzowNeKAr0FN
IEFydW5hIFJhbWFrcmlzaG5hDQo+IDxhcnVuYS5yYW1ha3Jpc2huYUBvcmFjbGUuY29tPiB3cm90
ZToNCj4+IA0KPj4gDQo+PiANCj4+PiBPbiBKdW4gMTAsIDIwMjQsIGF0IDI6MznigK9QTSwgamVm
Znh1QGNocm9taXVtLm9yZyB3cm90ZToNCj4+PiANCj4+PiBUaGUgb3JpZ19wa3J1ICYgaW5pdF9w
a3J1X3ZhbHVlIGlzIHF1aXRlIGRpZmZpY3VsdCB0byB1bmRlcnN0YW5kLg0KPj4+IA0KPj4+IGNh
c2UgMT4gaW5pdF9wa3J1OiAwMCAoYWxsb3cgYWxsKQ0KPj4+IG9yaWdfcGtydSBhbGwgY2FzZXMg
ID0+IGFsbG93IGFsbA0KPj4+IA0KPj4+IGNhc2UgMj4gaW5pdF9wa3J1OiAwMSAoZGlzYWJsZSBh
bGwpDQo+Pj4gT3JpZ19wa3J1Og0KPj4+IGFsbG93IGFsbCAwMCA9PiAwMCBhbGxvdyBhbGwuDQo+
Pj4gZGlzYWJsZSBhbGwgMDEgPT4gMDEgZGlzYWJsZSBhbGwuDQo+Pj4gZGlzYWJsZSB3cml0ZSAx
MCA9PiAwMCBhbGxvdyBhbGwgPC0tLSAqKiogb2RkICoqKg0KPj4+IGRpc2FibGUgYWxsIDExID0+
IDAxIGRpc2FibGUgYWxsDQo+Pj4gDQo+Pj4gY2FzZSAzPiBpbml0IHBrcnU6IDEwIChkaXNhYmxl
IHdyaXRlKQ0KPj4+IGFsbG93IGFsbCAwMCA9PiAwMCBhbGxvdyBhbGwuDQo+Pj4gZGlzYWJsZSBh
bGwgMDEgPT4gMDAgKGFsbG93IGFsbCkgPC0tLS0qKiogb2RkICoqKg0KPj4+IGRpc2FibGUgd3Jp
dGUgMTAgPT4gMTAgYWxsb3cgYWxsDQo+Pj4gZGlzYWJsZSBhbGwgMTEgPT4gMTAgZGlzYWJsZSB3
cml0ZSA8LS0tICoqKiBvZGQgKioqDQo+Pj4gDQo+Pj4gY2FzZSA0PiBpbml0IHBrcnU6IDExIChk
aXNhYmxlIGFsbCkNCj4+PiBvcmlnX3BrcnUgYWxsIGNhc2VzID0+IHVuY2hhbmdlZC4NCj4+PiAN
Cj4+PiBzZXQgUEtSVSgwKSBzZWVtcyB0byBiZSBiZXR0ZXIsIGVhc3kgdG8gdW5kZXJzdGFuZC4N
Cj4+PiANCj4+IA0KPj4gSeKAmW0gbm90IHN1cmUgSSBmb2xsb3cuDQo+PiANCj4+IFRoZSBkZWZh
dWx0IGluaXRfcGtydSBpcyAweDU1NTU1NTU0IChlbmFibGUgb25seSBwa2V5IDApLiBMZXTigJlz
IGFzc3VtZSB0aGUgYXBwbGljYXRpb24NCj4+IHNldHMgdXAgUEtSVSA9IDB4NTU1NTU1NDUgKGku
ZS4gZW5hYmxlIG9ubHkgcGtleSAyKS4gV2Ugd2FudCB0byBzZXQgdXAgdGhlIFBLUlUNCj4+IHRv
IGVuYWJsZSBib3RoIHBrZXkgMCBhbmQgcGtleSAyLCBiZWZvcmUgdGhlIFhTQVZFLCBzbyB0aGF0
IGJvdGggdGhlIGN1cnJlbnQgc3RhY2sgYXMNCj4+IHdlbGwgYXMgdGhlIGFsdGVybmF0ZSBzaWdu
YWwgc3RhY2sgYXJlIHdyaXRhYmxlLg0KPj4gDQo+PiBTbyB3aXRoDQo+PiB3cml0ZV9wa3J1KG9y
aWdfcGtydSAmIHBrcnVfZ2V0X2luaXRfdmFsdWUoKSk7DQo+PiANCj4+IEl0IGNoYW5nZXMgUEtS
VSB0byAweDU1NTU1NTQ0IC0gZW5hYmxpbmcgYm90aCBwa2V5IDAgYW5kIHBrZXkgMi4NCj4+IA0K
PiBDb25zaWRlciBiZWxvdyBleGFtcGxlczoNCj4gDQo+IDE+DQo+IFRoZSBkZWZhdWx0IGluaXRf
cGtydSBpcyAweDU1NTU1NTU0IChwa2V5IDAgaGFzIGFsbCBhY2Nlc3MsIDEtMTUgZGlzYWJsZSBh
bGwpDQo+IGFuZCB0aHJlYWQgaGFzIFBLUlUgb2YgMHhhYWFhYWFhOCAocGtleSAwIGhhcyBhbGwg
YWNjZXNzLCAxLTE1IGRpc2FibGUgd3JpdGUpDQo+IGluaXRfcGtydSAmIGN1cnJfcGtydSB3aWxs
IGhhdmUgMHgwDQo+IElmIGFsdHN0YWNrIGlzIHByb3RlY3RlZCBieSBwa2V5IDEsIHlvdXIgY29k
ZSB3aWxsIGNoYW5nZSBQS1JVIHRvIDAsDQo+IHNvIHRoZSBrZXJuZWwgaXMgYWJsZSB0byByZWFk
L3dyaXRlIHRvIGFsdHN0YWNrLg0KPiANCj4gMj4NCj4gSG93ZXZlciAgd2hlbiB0aGUgdGhyZWFk
J3MgUEtSVSBkaXNhYmxlIGFsbCBhY2Nlc3MgdG8gMS0xNToNCj4gVGhlIGRlZmF1bHQgaW5pdF9w
a3J1IGlzIDB4NTU1NTU1NTQgKHBrZXkgMCBoYXMgYWxsIGFjY2VzcywgMS0xNSBkaXNhYmxlIGFs
bCkNCj4gYW5kIHRocmVhZCBoYXMgUEtSVSBvZiAweDU1NTU1NTQgKHBrZXkgMCBoYXMgYWxsIGFj
Y2VzcywgMS0xNSBkaXNhYmxlIGFsbCkNCj4gaW5pdF9wa3J1ICYgY3Vycl9wa3J1IHdpbGwgaGF2
ZSAweDU1NTU1NTU0DQo+IElmIGFsdHN0YWNrIGlzIHByb3RlY3RlZCBieSBwa2V5IDEsIGtlcm5l
bCBkb2Vzbid0IGNoYW5nZSBQS1JVLCBzbw0KPiBzdGlsbCBub3QgYWJsZQ0KPiB0byBhY2Nlc3Mg
YWx0c3RhY2suDQo+IA0KPiAzPiBUaGlzIGFsZ29yaXRobSBpcyBzdHJhbmdlciBpZiBpbnRpX3Br
cnUgaXMgY29uZmlndXJlZCBkaWZmZXJlbnRseToNCj4gVGhlIGluaXRfcGtydSBpcyAweGFhYWFh
YWE4IChwa2V5IDAgaGFzIGFsbCBhY2Nlc3MsIGFuZCAxLTE1IGRpc2FibGVzIHdyaXRlLikNCj4g
YW5kIHRocmVhZCBoYXMgUEtSVSBvZiAweDU1NTU1NTU0IChwa2V5IDAgaGFzIGFsbCBhY2Nlc3Ms
IDEtMTUgZGlzYWJsZSBhbGwpDQo+IGluaXRfcGtydSAmIGN1cnJfcGtydSB3aWxsIGhhdmUgMHgw
ICgwLTE1IGhhcyBhbGwgYWNjZXNzKS4NCj4gDQo+IE92ZXJhbGwgSSB0aGluayB0aGlzIGlzIGEg
Y29uZnVzaW5nIGFsZ29yaXRobSB0byBkZWNpZGUgdGhlIG5ldyBQS1JVIHRvIHVzZS4NCg0KSSB1
bmRlcnN0YW5kIHlvdXIgcG9pbnQuIEJ1dCB0aGUgcGF0Y2ggbWFrZXMgdGhlIGFzc3VtcHRpb24g
dGhhdCB0aGUgc2lnYWx0c3RhY2sgaXMNCmFjY2Vzc2libGUgd2l0aCBpbml0X3BrcnUsIHdoaWNo
IGlzIG5vdCB0aGUgY2FzZSBpbiB0aGVzZSAzIGV4YW1wbGVzLiBJ4oCZbSBub3Qgc2F5aW5nDQp0
aGF0IGFzc3VtcHRpb24gaXMgcmlnaHQgLSBqdXN0IHRoYXQsIHRoYXTigJlzIHRoZSB1c2UgY2Fz
ZSB3aGljaCB3ZeKAmXJlIHRyeWluZyB0byBmaXggaGVyZS4NCg0KQnV0IHlvdeKAmXJlIHNheWlu
ZyB0aGF0IHRoZSBhbHRzdGFjayBjb3VsZCBiZSB1c2luZyBhbnkgcGtleSwgYW5kIGhhbmRsZV9z
aWduYWwoKQ0KZG9lcyBub3Qga25vdyB3aGljaCBvbmUgaXQgaXMsIHNvIGl0IHNob3VsZCBqdXN0
IGVuYWJsZSBhbGwgcGtleXMgLSBpcyB0aGF0IHJpZ2h0Pw0KDQpUaG9tYXMsDQpDYW4geW91IHBs
ZWFzZSByZXZpZXcvY29tbWVudD8gDQogDQo+IA0KPj4gQWZ0ZXIgdGhlIFhTQVZFLCBpdCBjYWxs
cyB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpLCB3aGljaCBvdmVyd3JpdGVzIHRoaXMgKG5ldykN
Cj4+IFBLUlUgc2F2ZWQgb24gdGhlIHNpZ2ZyYW1lIHdpdGggb3JpZ19wa3J1LCB3aGljaCBpcyAw
eDU1NTU1NTQ1IGluIHRoaXMgZXhhbXBsZS4NCj4+IA0KPj4gU2V0dGluZyBQS1JVIHRvIDAgd291
bGQgYmUgc2ltcGxlciwgaXQgd291bGQgZW5hYmxlIGFsbCBwa2V5cyAtIDAgdGhyb3VnaCAxNSAt
IHdoaWNoLA0KPj4gYXMgVGhvbWFzIHBvaW50ZWQgb3V0LCBzZWVtcyB1bm5lY2Vzc2FyeS4gVGhl
IGFwcGxpY2F0aW9uIG5lZWRzIHRoZSBwa2V5IGl0DQo+PiBlbmFibGVkIGZvciBhY2Nlc3MgdG8g
aXRzIG93biBzdGFjaywgYW5kIHdlIG5lZWQgdG8gZW5hYmxlIHBrZXkgMCB1bmRlciB0aGUgaG9v
ZA0KPj4gdG8gZW5hYmxlIGFjY2VzcyB0byB0aGUgYWx0ZXJuYXRlIHNpZ25hbCBzdGFjay4NCj4+
IA0KPiANCj4gSSB0aGluayB5b3UgYXJlIHJlZmVycmluZyB0byBUaG9tYXMncyBjb21tZW50cyBp
biBWMywgY29weSBoZXJlIGZvcg0KPiBlYXNlIG9mIHJlc3BvbnNlOg0KPiANCj4+IFVzZXIgc3Bh
Y2UgcmVzdW1lcyB3aXRoIHRoZSBkZWZhdWx0IFBLUlUgdmFsdWUgYW5kIHRoZSBmaXJzdCB0aGlu
ZyB1c2VyDQo+PiBzcGFjZSBkb2VzIHdoZW4gZW50ZXJpbmcgdGhlIHNpZ25hbCBoYW5kbGVyIGlz
IHRvIHB1c2ggc3R1ZmYgb24gdGhlDQo+PiBzaWduYWwgc3RhY2suDQo+IC4uLg0KPj4gSWYgdXNl
ciBzcGFjZSBwcm90ZWN0cyB0aGUgdGFzayBzdGFjayBvciB0aGUgc2lnYWx0IHN0YWNrIHdpdGgg
YSBrZXkNCj4+IHdoaWNoIGlzIG5vdCBpbiBpbml0X3BrcnVfdmFsdWUgdGhlbiBpdCBkb2VzIG5v
dCBtYXR0ZXIgYXQgYWxsIHdoZXRoZXINCj4+IGl0IGRpZXMgaW4gaGFuZGxlX3NpZ25hbCgpIG9y
IGxhdGVyIHdoZW4gcmV0dXJuaW5nIHRvIHVzZXIgc3BhY2UsIG5vPw0KPiANCj4gVGhlIHVzZXJz
cGFjZSBjb3VsZCByZWdpc3RlciBhIGN1c3RvbSBoYW5kbGVyICh3cml0dGVuIGluIGFzc2VtYmx5
KSB0bw0KPiBjaGFuZ2UgUEtSVSBhbmQgYWxsb3cgYWNjZXNzIHRvIHRoZSBzdGFjaywgdGhpcyBj
b3VsZCBiZSB3cml0dGVuIGluIHN1Y2gNCj4gdGhhdCBpdCBpcyBiZWZvcmUgcHVzaGluZyBzdHVm
ZiB0byB0aGUgc3RhY2suIFNvIGFsbCBpdCByZXF1aXJlcyBpcw0KPiB0aGF0IHRoZSBrZXJuZWwN
Cj4gZG9lc24ndCBTSUdTRUdWIHdoZW4gcHJlcGFyaW5nIHRoZSBzaWduYWwgZnJhbWUgaW4gc2ln
YWx0c3RhY2ssIHRoaXMgaXMNCj4gd2hlcmUgUEtSVT0wIGluc2lkZSB0aGUga2VybmVsICBwYXRo
IGhlbHBzLg0KPiANCj4gRXZlbiB0b2RheSwgd2l0aG91dCBwYXRjaCwgb25lIGNhbiBhbHJlYWR5
IGRvIGZvbGxvd2luZzoNCj4gMT4gdXNlIFBLRVkgMSB0byBwcm90ZWN0IHNpZ2FsdHN0YWNrDQo+
IDM+IGxldCB0aGUgdGhyZWFkIGhhdmUgYWxsIGFjY2VzcyB0byBQS0VZIDENCj4gMz4gc2VuZCBh
IHNpZ25hbCB0byB0aGUgdGhyZWFkLCBrZXJuZWwgd2lsbCBzYXZlIFBLUlUgdG8gdGhlIGFsdHN0
YWNrIGNvcnJlY3RseS4NCj4gND4ga2VybmVsIHNldCBpbml0X3BrdXIgYmVmb3JlIGhhbmRzIG92
ZXIgY29udHJvbCB0byB1c2Vyc3BhY2UNCj4gNT4gdXNlcnNwYWNlIHNldCBQS1JVIHRvIGFsbG93
IGFjY2VzcyB0byBQS0VZIDEgYXMgdGhlIGZpcnN0IHRoaW5nIHRvIGRvLg0KPiA2PiBvbiBzaWdf
cmV0dXJuLCB0aHJlYWRzIGhhdmUgUEtSVSByZXN0b3JlZCBjb3JyZWN0bHkgZnJvbSB0aGUgdmFs
dWUNCj4gaW4gc2lnZnJhbWUuDQo+IA0KDQpJbiB0aGlzIGV4YW1wbGUgYWJvdmUsIHBrZXkgMSBn
cmFudHMgYWNjZXNzIHRvIHRoZSBhbHRzdGFjaywgd2hpY2ggaXMgZW5hYmxlZA0KdGhyb3VnaCBv
dXQgdGhpcyBmbG93LiBJIHRoaW5rIHBlcmhhcHMgdGhpcyB1c2UgY2FzZSBpcyBtb3JlIGludGVy
ZXN0aW5nOg0KDQoxLiBVc2UgcGtleSAxIHRvIHByb3RlY3Qgc2lnYWx0c3RhY2suDQoyLiBVc2Ug
cGtleSAyIHRvIHByb3RlY3QgdGhyZWFk4oCZcyBzdGFjay4NCjMuIERpc2FibGUgYWxsIGJ1dCBw
a2V5IDIgKD0gb3JpZ19wa3J1KS4NCjQuIFNlbmQgYSBzaWduYWwgdG8gdGhlIHRocmVhZCAoa2Vy
bmVsIHBhdGNoIG5lZWRlZDsgd2UnZCBoYXZlIHRvIGVuYWJsZSBhbGwNCnBrZXlzIGluIGhhbmRs
ZV9zaWduYWwoKSAtIGkuZS4gcGtydSA9IDApLg0KNS4gS2VybmVsIHNldHMgcGtydT1pbml0X3Br
cnUgYmVmb3JlIGhhbmRpbmcgb3ZlciBjb250cm9sIHRvIHVzZXJzcGFjZSAoaS5lLg0Kb25seSBw
a2V5IDAgaXMgZW5hYmxlZCkuDQo2LiBTaWduYWwgaGFuZGxlciBzaG91bGQgZW5hYmxlIHBrZXkg
MSBhcyB0aGUgZmlyc3QgdGhpbmcuDQo3LiBPbiBzaWdyZXR1cm4sIG9yaWdfcGtydSBpcyByZXN0
b3JlZCBjb3JyZWN0bHkuDQoNCknigJltIG5vdCBzdXJlIGlmICg2KSB3aWxsIHdvcmsgb3IgaWYg
aXTigJlsbCBjcmFzaCB3aXRoIGEgU0lHU0VHViAtIEkgaGF2ZW7igJl0IHRlc3RlZA0KdGhpcyBm
bG93Lg0KDQpUaGFua3MsDQpBcnVuYQ0KDQo=

