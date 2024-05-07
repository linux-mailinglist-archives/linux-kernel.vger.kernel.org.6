Return-Path: <linux-kernel+bounces-171920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0058BEAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9317285E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3216D326;
	Tue,  7 May 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQEQRuG0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cYtHGbnA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34F16D307
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103279; cv=fail; b=LPUrMax4Prr5h/iDv+/25DaBWtUMl9sfHh75hSSe7rQiN552Lb6aundyCIMJfUdd/W5t9IfjCNwtay2dpM3rqbhWsazEfbqet6I4XjQlhB7WYclkHQiPIFoCoXGpjgYKaUG4WB1UyibJp6v4usxecU5Hb+hkzTLplYEH792y+7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103279; c=relaxed/simple;
	bh=mDLNVb7ARrD/feoIWxFqvIKYObcA77mIuqDSB+EfqQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4pBsrkFR9f5Ipmx9JsXa8xhgwtIvKKLWdXVqHwZYYI7MBWbRIu9UhQyajPzIwkEGfz8v440QO/VQioXON4n4OuA8KxtYmVkfizgn/V0GGgTkYl++1SyCoTMfYyTqTLq5k9mTcgizgPdWCz4KlvlGLQgsbk2ow3M+mhL01a4awI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQEQRuG0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cYtHGbnA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GWCth031269;
	Tue, 7 May 2024 17:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mDLNVb7ARrD/feoIWxFqvIKYObcA77mIuqDSB+EfqQU=;
 b=LQEQRuG0QkxaKacbxPx3IBcomVBP8rjtmM/vgbHcO8kvMleRqykspUE9I9xWDZ+ptVGK
 IYzRFNWQiMHzfQaW2/Rh3VNT+cFt2gXO/bX0so5tQGef9CSi+aIqItdEIqufmzKF9+00
 0suyq5refRJ/Udd9TypNjzhxEm/JVHsOTPSLrvdnvBzjEA68CtF5Xjihp1DFMFqywCMo
 9fqsdZ9Jbkh1YGb4rjj7aNt1+z23RKuAX1NOktIJqyPSSiGVdUI9v8qSvWIirdnGgcac
 YguBa/qJgAoVd4HspgZ4ElHAniA0IwvRF9+Folsf5lvciFJLLYojm2QcenJhtRWQ07WU 6w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcwpb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:34:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447GgMwq027545;
	Tue, 7 May 2024 17:34:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfem0yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0adNwUiuqoj78N2Y6sMEqYhEpcDnUK7l7usMXIBjrhsNJHTOTouZ8N+ewxG2xoSHxRlBLSOLtilyg0d/ocSiNlCo6LbDlvis2ELgUen0HxmcblPR+O1D2l1alYRBmQBdO04xbpHY1tRWD3TLiX0gjKl6J2vg2tEWmaE1b7Zk8bYbN+nUHWkdS8KF3+F0whVviPzFK1bbsyLNqnsDXosgHgmQObe5ZSR489joEuIhTFs4hi5BoqKuJOI4d+rJdJZ5wUekhDUZRLruPj3ZQNYbqL4GxSDA64T5w+IZWqBf4ucnyyouOLDldoW5egqwsgibIKwYLZAKcNAHx8kZnl4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDLNVb7ARrD/feoIWxFqvIKYObcA77mIuqDSB+EfqQU=;
 b=MsFtFIT30z/OAo5uVaPH3LXqSoOGvqLCvaMQXJD8Scr9LXWHnd4PQG3iy2fo7DZ1cOgSBjSPgkgsB8/X0FLeIVeZXsH0zbQruidreD33XHoHIUCZF49YV6H1wAMl8/pcJ0G2759BDEmYMI2QnyMA+3ahMwDzZAXll7+mXv+cYD2mnBvkZp3esklXauwk/uvu0Ni3DI8Uzas9CbsUw5+sThhpCedawSjoWcHPKppKqPTJJGq28aUscsGl06AotcI7YkOydiV8oGB62jPVniPuRVK13YV72t5nez+RAKqeLzIu9HMF3uN0cXvPxTXkY+vPi/pNrAiMiwiZovA6ImhnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDLNVb7ARrD/feoIWxFqvIKYObcA77mIuqDSB+EfqQU=;
 b=cYtHGbnAL6lXBP4xGorO/S+aOE/p+XOyjhVb38w8Z5J8+sR9+vceBVsorBwKLAWjCR8370gNtZwOoAEzYjcAkPut8hQ8Q7+qUJ57lo3V3GXGuc7zaczrMdCj1FhEZ/KJdVo4Cft8YVOmx6G1pC8a4Fyg8q9tst0dseLT/HwMd1k=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 17:34:16 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:34:16 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Keith Lucas
	<keith.lucas@oracle.com>
Subject: Re: [PATCH v3 3/4] x86/pkeys: Update PKRU to enable all pkeys before
 XSAVE
Thread-Topic: [PATCH v3 3/4] x86/pkeys: Update PKRU to enable all pkeys before
 XSAVE
Thread-Index: AQHalzs2Ae5wW8HPT0mwORpgykziD7GMDhaAgAAM+AA=
Date: Tue, 7 May 2024 17:34:16 +0000
Message-ID: <FF998E58-D109-45B1-9BD8-FEF873E2FA7A@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-4-aruna.ramakrishna@oracle.com> <87wmo5po0i.ffs@tglx>
In-Reply-To: <87wmo5po0i.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|SN7PR10MB6287:EE_
x-ms-office365-filtering-correlation-id: 8fccd9e8-bc18-40c9-e375-08dc6ebbeb69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R0w3MVlvcXVoWU9UVVlBN1c1U25KdVBMVFVSWTYzQnFVTEF4RmlKQVN1cWpR?=
 =?utf-8?B?bE5FTW1xVFo2ZTk5YzQ3YUp0WFJkUVZUcXdSR3NFVVpmSVEwK1hzQ3VGR3ox?=
 =?utf-8?B?TXlmYXVXTjBzemhlRHpKVi9IK3ErTWFHblQyZThPL1laUitLVjVaZ3RUdit5?=
 =?utf-8?B?cXNFT0IrK3FwM2ZQZ0M5QTBjKzJyUE05d2RGdFZBdEhCRFJMcUhuampJNWV0?=
 =?utf-8?B?NDRRMjhuWGJLSmxweFk4bHF6aUgvc0kzeUphbUwvbWtTamlZQlB3NSs1OFNu?=
 =?utf-8?B?eHM2N0xZTVlkZTRwYm5VTFFTcXZBbE9GbDBJazNCQjNBZURmajhWSmNlc1Jx?=
 =?utf-8?B?dzhaakcwSllmL1p2QXBQcEFvNWRPdW9CR2NaQ3pORzRubXVLQzdmMzNZTjlU?=
 =?utf-8?B?SHpaS0oyb2drTTJiR1RKRllyRnFvMWtMSzFyWENtWVdTUHRxTjkyY21VaTZu?=
 =?utf-8?B?dHFPMzI1SVBJSmpmL2pPdjlKY2lDaEdLS1YvbG5DYW9YSytEUUNuWUE0U2oy?=
 =?utf-8?B?c3BPaS9EVGVKTkJORHBXMWRRMzhwSDliRzU1KzAxTjNpOUF4QjdZaDBIajhC?=
 =?utf-8?B?YkZQSFFOOEhiZnpWYnV2cStCTjFKNUFhOHdiVVZYR2ZyWnMyNno1Vmh0blV2?=
 =?utf-8?B?NFVRWXBlcmt4aHVlaFhFczZFdFA1SWpKZlJOaFhuR1dlRENzQmpocHh2bEJi?=
 =?utf-8?B?c000SEtWci93ZlFlcTBFQVVzT29pV0NTcGdLNE5KTE1vYUJkTlJBSUI1cFFP?=
 =?utf-8?B?WUdIRDgybGd1cFBDYnhCNHVLRUwrbEZiQlRUczkvS3BPRlR3dTJRU084RHA1?=
 =?utf-8?B?OXBwS0ZESG1OWVJlZ3NsVlUxUGxnK3pJZmk1ditRTmticDBRY2x3emw1YUlD?=
 =?utf-8?B?MlgrQXQ2ZERwNUh4d2VpUGdhYTZFS3dUZXpGSjNITUNDSTJVWFpDYmMwaU9x?=
 =?utf-8?B?SlZ2aG1vMUhldmNUZDBWWm4zd0gxM2dYaXZQeDZpNW93cmdYdWRlcUlGbCtL?=
 =?utf-8?B?M0I1NHhsbnlKSERHUXlwMlBudWlsNC9lUkV0YlRqeVVibGJIdTVXRDJNUjJH?=
 =?utf-8?B?NHJXeUdtcVNnZzh4UjArQXlCRERuL0tVQ2grNVJtREkva1FTNkxuMnR5NHpN?=
 =?utf-8?B?VkFWR3VlZ2FoMXB4WXpuSEN2RG94OVFjRFljUFBXdlNCQzB6S3BWZkRCZTd2?=
 =?utf-8?B?RFpPUHBram1FR1JhaDhDZk8vVk4rSW9KR1VQTHhFV1JYOG1UTFdoNFI0VUJ6?=
 =?utf-8?B?QWZPVGdjZWhFOVlMSFRsa0tGOHpnVkNYUzRMQzdEZVY3VG9PeGRJclF5cTc0?=
 =?utf-8?B?dVEzT21VaDhGcTY5K1BTcDZ6cmluNWNRWDlOTzg5eHRVdEUzcWovWkhuelNi?=
 =?utf-8?B?N3FXQk9qblcrRmY2cVpZVTBMMS9JeWYvbnJ2elhYaVE1SVRTTVNDTjhWamRm?=
 =?utf-8?B?OUlCN25KVUcyOGxSRlVXeFh1SGFzSmZzenI3VzE2Y3U4cjlWVFBnLzA2Vm1j?=
 =?utf-8?B?Z3dDY3dyUnJFTUdSelJxWUNjbDUwNzlCMFpnOWF3YUE1SkNqS1hFOGZUUFZn?=
 =?utf-8?B?eUxzNVFxMU56WTZxS2pEK2YyOEFnSmxRYm5jcDF4Wk9aYTVUQzBCd2ZHSG01?=
 =?utf-8?B?dXBCR2NHZVJQdG9lZ3V3MlkvYWkrc3RITXQwcUhvbDQ0SVAxMENhQVJaVkhZ?=
 =?utf-8?B?TG5oRm5Zbmk4M3dtZGIrNWxlQTIxTVFXbXpwZWVQWC9hWTlLY056a2d3KzEy?=
 =?utf-8?B?a01nVTM2aG51eEovdkJRWWl3RnFybFh1ZHpSaGtDMDA1NjNYc1VVMjFlaStZ?=
 =?utf-8?B?S3ZRVXBubDJhZzZQUW54Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ajFUMTJHM1dlNXY5N0dBdlgrazZQVVUrcjBQSVJDZkMyRlFSRlRxb1dNWUxI?=
 =?utf-8?B?amFCWFkrS2Zab01QTHBwVFR0MEJVUGg0T1VxWldZK1pCc2RndkthTjdUeEFw?=
 =?utf-8?B?ZE5Uc1NqYTJlaGRGQy9iRTBnQnNOMUhHMDl4NDNQZjZpNlZ4aGR4c05JdFNI?=
 =?utf-8?B?Y3BEaDZTYk5USDljNEJTajRSQWZNN2p5bm9KZk11QVRSdWFrWUZVRXB2OXNh?=
 =?utf-8?B?bmQvTWh5K0F5QnVXNW8renRlcUlIZlRCMWNOMFVwakhNSW9reFdVTndRNXhH?=
 =?utf-8?B?QitoVGJtQjJxb3BaM2VVb2gyUzM5a2hTNy9McVZhbDAyNktPcEN1VnBmUzFt?=
 =?utf-8?B?cSt6RFJibFV5UlVwcDNFd2hjNXZ6MHJhYVdmZ3ZGc0w3UmlXUHdXbjBtWXla?=
 =?utf-8?B?M2NreVczdU9USFIvYmY5UktwVzRGeFd5dDVVNHpBR3dtMmEyQzFTdmNmamFq?=
 =?utf-8?B?OE1QZ3BVdUd3NWdkcFNLOEwvTE13UG54RDVlLzEvRHFDYlQ4NWlESjcyZE9L?=
 =?utf-8?B?S1FFSHhOVHBITjBqcERvODUrYnRiam55TENVOVVXeDdGMk5IVms0V3FBT0RC?=
 =?utf-8?B?eW1mbi9aSHdlWkhSOEVUdVVhN05mMzE0OHBXZlNaSGV6VkpsV21haTdkWisr?=
 =?utf-8?B?VkJVUzYzR29YZWNYdUJJaFY2czBUcERQZWxXYTZsb3U0K2EyN3pXUkwwbGtP?=
 =?utf-8?B?Vndyd1NFYlR0T0ErTVM3YncweDdnVHdtUStxVFhpekdXNWFEU2tlcERmWlVE?=
 =?utf-8?B?K21IUkJHQ1NKQWpUM3NWWXRQR3ZTaG1IVkpKV3lSRFJsMmRCMEh2bTVBTERO?=
 =?utf-8?B?T0lQOFdJMDhmZk80VGVpK1JBSWlxK1p4b0lHZS94QmtGMW9jRHFmVmNhM1BU?=
 =?utf-8?B?cFVtZTVXWlJ1Ry9GTWl3dTFlV2Q1enc0WVRhVktiVmVZa0dDN0Vmem0xODFG?=
 =?utf-8?B?a0JzMWFCcWRvWFlLQml4dUJWSXZPUVpaR05ERnF5ZVROUUZXdThQK01JWG1w?=
 =?utf-8?B?Y0JBaS9PQjByWTVzQ0pMR1ZnU2hTMWQ5Mm4xT0VTa251bm9VdTRVaHJuSlRP?=
 =?utf-8?B?OE5UdGJqWVVwYmFHNktJSzNLbXVLSHlnWDF3YlBaSHkyakZFejI1bDFkRENJ?=
 =?utf-8?B?dTIrdmtYZW0xRkU5ekZ5Vys5V25RV3pGSE0zak85cDBYQWtjZVlTeUNtWFVZ?=
 =?utf-8?B?NTVFejdKTjRTK29Mc2RtdVJnbmZYMHp4NlpHSUNtOGdETDlqMVFrekZOMFZI?=
 =?utf-8?B?d0JodktyNGdUOTlYL201RktYM1h5VzlzdzAySTI3Vi9Oc1BKRnQxNW1Bb3Vi?=
 =?utf-8?B?K0dZVUVGQ2h6b25TWW4zWHdxQXlMaVQ1dWtKZ05GMjdyaXV4Y2tPZWN1c2hp?=
 =?utf-8?B?ZWZGYmdadXkvdUVGZU1DYjZMQmFHYnZ2MWRNcFVqU0RBVW91TDN0dkF1ekUx?=
 =?utf-8?B?WXphNEREeHJNdWZmWTZKWTI0cTZqL2ZvM1ZwU2o3eENyVFprSWRKMWUvMzU3?=
 =?utf-8?B?K3YwRUFFMk9WK3RVQnU0T0xlWWdudjdvNHhLS242ZzhxM3VFK1BGN3FaSmV5?=
 =?utf-8?B?VDhpWHpnWGpQejd4Q0NMdkt1TnJicitkakt1RThQKzhrQXVmYjJIZkNYVWk5?=
 =?utf-8?B?VzZiMGNHM2E3SDI5VmJrMm02OWZYaGZNbTd2ZkJ5dm02ZzNQYlFoSGF4cUNW?=
 =?utf-8?B?NHB3L0lXc3dVVy9RVUYrYnhDdDFPQlFGSm95bnBCcVRrTlF4d0hHaFFwSUsr?=
 =?utf-8?B?UzhNRStCQWRvN3gyZk9MV2RCWFJ5bUttbHE5UG5zZXJpcS9DSm9vaEpiMm5o?=
 =?utf-8?B?TlBVYkpqMFc3NHgrNzJZeUNUcm13UEhwV3FKalZpRm9mam5ZL3Bxc09sbzQ3?=
 =?utf-8?B?SStoTVRDbHNuUm45aklCNHdCMlFGVW1tb2F2ZVZnT25RQzVDc0ZDN085Z1I2?=
 =?utf-8?B?RVJkcFhkWTArdnRmVU8xaG8xY0V4Uk83NFBjcjFQUXMvTHU2RE1sZDVaOTRx?=
 =?utf-8?B?b3pud1FNT21Tb2RCZXI5YkVqcnFzc2RPSDdkeDliNFlwOHZnQUhlL3BaenI1?=
 =?utf-8?B?amhXNm5zQy81QjloZFJmaXIvai9Ga3NYR1B6bWRSb1Y0aHZFVDlkenJ0SkNm?=
 =?utf-8?B?WHRBSHRYc0pIYzhSb3BZbWR1cFZKbndZaHdZZ3lPc09tNzd4cXV1bWh6WmJL?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD04F84016F6B2458B708CC271AFA334@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nW5GmuYjZaoxCdo3a/cavRvUj6cpshUUCWZZhHjqAxtlsMbMFTIr8lNGzLXAsmHrieEyy/74o/VM6ZNOwnBjsVFxRLUKgZQ0InbXa3elJZAIumZfaOUG9ES/57r4E1MIeOIsaWLubrRAjf4ZdfJK5hbWhSZsRsyly9/vx1PNihBGHsNz0jkAdflUyOIllIePwNY9+hxY/CyRlOeYhC9VNYsZbX6C1uxHvoXihaIdb845wuvDtlvQrrQRTJ8o8Xi5ck5LXJeqKW60KCTZykj+dVABQZuEIhQ0ES3+OvoiYMmGRXKXfsoVJ4cvPxX0fAf4PSjMs6M+4jXLdK4WaqxVfDm9bKuyVGbqbd3kRi6Kpl/3WUlXd9IpZX2YaTsuN55LPARCmvBfkVm9zcePMcrC01Cc6ASy3iPKNczY4SmIo2/wwW/xTQrR1hMDsi+nbSQ9buNITBHxclZRqPdlOAEu0KfncVib0/JwedQ7Po2pITAz2R+wPwp5Lz6KmZRNWoQDz6CrDGDATf7Uk4R6IMgfWAPpyDcAi4rlnWNQ7ts+8G18QzmhhKhmeUhVs6OFkbspq4OVXut3CX7YcpHMGfcYKIp7dW/VMYlL6UW09mFKRNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fccd9e8-bc18-40c9-e375-08dc6ebbeb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 17:34:16.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cV+5q6C+SEbFOFMxfr0XwyLogjOcXktVxcX33C61k2jnbwn4uGcDZP71+sLynqFwKMxQxfoKCwTWOtzWTxlQK4cnzQ+zBpBTtWv7eswSebI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070121
X-Proofpoint-GUID: NLJmjd02B99P-gBuLSpzK-x22nFCHgrA
X-Proofpoint-ORIG-GUID: NLJmjd02B99P-gBuLSpzK-x22nFCHgrA

DQo+IE9uIE1heSA3LCAyMDI0LCBhdCA5OjQ34oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXByIDI1IDIwMjQgYXQgMTg6MDUs
IEFydW5hIFJhbWFrcmlzaG5hIHdyb3RlOg0KPiANCj4+IElmIHRoZSBhbHRlcm5hdGUgc2lnbmFs
IHN0YWNrIGlzIHByb3RlY3RlZCBieSBhIGRpZmZlcmVudCBwa2V5IHRoYW4gdGhlDQo+PiBjdXJy
ZW50IGV4ZWN1dGlvbiBzdGFjaywgY29weWluZyB4c2F2ZSBkYXRhIHRvIHRoZSBhbHRzaWdzdGFj
ayB3aWxsIGZhaWwNCj4+IGlmIGl0cyBwa2V5IGlzIG5vdCBlbmFibGVkLiBUaGlzIGNvbW1pdCBl
bmFibGVzIGFsbCBwa2V5cyBiZWZvcmUNCj4+IHhzYXZlLA0KPiANCj4gVGhpcyBjb21taXQgKHBh
dGNoKSAuLi4uDQo+IA0KPiBBbHNvIHRoaXMgbGFja3MgYW55IGp1c3RpZmljYXRpb24gd2h5IHRo
aXMgZW5hYmxlcyBhbGwgcGtleXMgYW5kIGhvdw0KPiB0aGF0IGlzIHRoZSByaWdodCB0aGluZyB0
byBkbyBpbnN0ZWFkIG9mIHVzaW5nIGluaXRfcGtydV92YWx1ZSB3aGljaA0KPiBpcyB3aGF0IGlz
IHNldCBieSBmcHVfX2NsZWFyX3VzZXJfc3RhdGVzKCkgYmVmb3JlIGdvaW5nIGJhY2sgdG8gdXNl
cg0KPiBzcGFjZS4gRm9yIHNpZ25hbCBoYW5kbGluZyB0aGlzIGNhbiBiZSB0aGUgb25seSB2YWxp
ZCBQS0VZIHN0YXRlIHVubGVzcw0KPiBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZS4NCg0KDQpJ
ZiB0aGUgYWx0IHNpZyBzdGFjayBpcyBwcm90ZWN0ZWQgYnkgYSBkaWZmZXJlbnQgcGtleSAob3Ro
ZXIgdGhhbiBwa2V5IDApLCB0aGVuDQp0aGlzIGZsb3cgd291bGQgbmVlZCB0byBlbmFibGUgdGhh
dCwgYWxvbmcgd2l0aCB0aGUgcGtleSBmb3IgdGhlIHRocmVhZOKAmXMgDQpzdGFjay4gU2luY2Ug
dGhlIGNvZGUgaGFzIG5vIHdheSBvZiBrbm93aW5nIHdoYXQgcGtleSB0aGUgYWx0c3RhY2sgbmVl
ZHMsDQppdCBlbmFibGVzIGFsbCBmb3IgdGhpcyBicmllZiB3aW5kb3cuDQoNCj4gDQo+PiBzdGF0
aWMgaW5saW5lIGludCBjb3B5X2ZwcmVnc190b19zaWdmcmFtZShzdHJ1Y3QgeHJlZ3Nfc3RhdGUg
X191c2VyICpidWYsDQo+PiAgdTMyIHBrcnUpDQo+PiB7DQo+PiAtIGlmICh1c2VfeHNhdmUoKSkN
Cj4+IC0gcmV0dXJuIHhzYXZlX3RvX3VzZXJfc2lnZnJhbWUoYnVmKTsNCj4+ICsgaW50IGVyciA9
IDA7DQo+PiArDQo+PiArIGlmICh1c2VfeHNhdmUoKSkgew0KPj4gKyBlcnIgPSB4c2F2ZV90b191
c2VyX3NpZ2ZyYW1lKGJ1Zik7DQo+PiArIGlmICghZXJyICYmIGNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfT1NQS0UpKQ0KPiANCj4gVGhlIENQVSBmZWF0dXJlIGNoZWNrIHJlYWxseSB3
YW50cyB0byBiZSBpbiB1cGRhdGVfcGtydV9pbl9zaWdmcmFtZSgpDQo+IA0KPj4gQEAgLTI3OCw2
ICsyNzgsNyBAQCBoYW5kbGVfc2lnbmFsKHN0cnVjdCBrc2lnbmFsICprc2lnLCBzdHJ1Y3QgcHRf
cmVncyAqcmVncykNCj4+IGlmIChzdGVwcGluZykNCj4+IHVzZXJfZGlzYWJsZV9zaW5nbGVfc3Rl
cChjdXJyZW50KTsNCj4+IA0KPj4gKyBwa3J1ID0gc2lnX3ByZXBhcmVfcGtydSgpOw0KPiANCj4g
cGtydSBpcyBkZWZpbmVkIGluIHRoZSBmaXJzdCBwYXRjaDoNCj4gDQo+PiArICAgICAgIHUzMiBw
a3J1ID0gcmVhZF9wa3J1KCk7DQo+IA0KPiBXaHkgZG8gd2UgbmVlZCBhIHJlYWQgYW5kIHRoZW4g
YW5vdGhlciByZWFkIGluIHNpZ19wcmVwYXJlX3BrcnUoKT8NCg0Kc2lnX3ByZXBhcmVfcGtydSgp
IGlzIHdoZXJlIHRoZSBwa3J1IHZhbHVlIGlzIHVwZGF0ZWQgdG8gbWFrZSBzdXJlIHRoZSBhbHQg
c3RhY2sgaXMNCmFjY2Vzc2libGUgZm9yIFhTQVZFLCB3aGlsZSBjYXB0dXJpbmcgdGhlIHVzZXIt
ZGVmaW5lZCBvcmlnX3BrcnUgc28gdGhhdCBpdCBjYW4gYmUNCmNvcnJlY3RseSByZXN0b3JlZCBs
YXRlci4gVHdvIHJlYWRzIGFyZSBvYnZpb3VzbHkgcmVkdW5kYW50IC0gSSB3aWxsIHJlbW92ZSB0
aGUgZmlyc3Qgb25lDQooaW50cm9kdWNlZCBpbiBwYXRjaCAxKSBoZXJlLiANCg0KVGhhbmtzLA0K
QXJ1bmENCg0K

