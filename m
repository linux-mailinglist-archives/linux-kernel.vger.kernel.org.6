Return-Path: <linux-kernel+bounces-568479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C5A69616
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947C23A7ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552D1E5B81;
	Wed, 19 Mar 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HWDjvssx"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F41E22FD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404354; cv=fail; b=ja1qYQ6WnoUxhCFNUc/LVlcz0eb3y7GLaKc6BiUlyPHbASRXVNr+p97Bvmd8J28Od28pjHCOWjNEEsicBxeyhJQ6sOnft32pnnBnDg+WwcSVjhGRJHrzcj+BYUKhFLjiSFXv/QJmrtQzQ47I07ZP0HzYTWpL+ptQ1wf3paLalDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404354; c=relaxed/simple;
	bh=jH0SMEZutCtUHXLkoFYT7ymgJRe1Bzu0n4aDB1iXWOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VWI2MMNPJXmvxgAByngdezG/v9E9udRgjgbu9qviElLSBifL5obH7WYx6m91L2L/+BxU+PTKV2hrYaNb51IL4NmZeMIUUG/j1PN5pNLwQDjM05DCBe4/+nPlZ73Jblst8mZPekt4GqhzjiWxVvmYmcFWO7EoVIYFvMpy9b0KJRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HWDjvssx; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JGCWhS016749
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:12:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=SedNuiWGuekHYEDYWyk19hN50fQ/CGJMUJeClGxzJYU=; b=
	HWDjvssx9MHsQbEPyM4o1W/3R1t8IN15fLGIzl5x4WHTaEGp2IvNyx/XzSQHeD75
	IDP9P5/cMjsx01FhDJpGXlKkmV0dk8ba5/frp4wgNgU7B+Dv5gU+0YKaqJbxZhLH
	JZyVP6JILge2YCgkOKGWIAgLUVHuFMoecpbmF7ChU6lClm7YHKT1kaJ8Kq0TD/wf
	nK8CY3rpM/TNlW8Q3enj8mcz+ZxTsW/vrqaHmPvtIEaou/F3/WUaK4ba8CSwPeNz
	tfKl5XePP9WRtFtYGHuAJCQUy0UxAT8tCl8P7oMP2izgd/Oz+Yb/hlukDIJh73qK
	l4NPoZpWKresdUz3lLxybw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45fxbtsxau-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZMzaNwHvjyZkPzSuI5miDqpRwmJ7kK6+kReVs4cv0tyHDeGLb/mFi6vEFW161DiDNT3Bmg6xulF8L0RXjinZrkO9KIOeakMDYJL/an5jQ0TDhdoxuFPUltTTyZQTH6SSzKTg3ixGix4QOzMtqdJP0/s4l4KnbmNHr5D6fWpc/be4350Uthb/a6geC9VWyOvnpp9EycJrWbrouu1etCGEZQi2v+57/dy9urS8FwUjhysD1fczRAtkJ8QyTahuqAhF3NdQMZfIcMPkVBuaPXSSYYLKXA4s2eQjaM63Kce4Djc1TGEe6U+RXPHVrFyuMHZZwAt9M9WVy+M8Fnq0A8r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt+C20Ja0QfRv4SbzXn3Toz95K6InN1AjclAZtXGSt0=;
 b=LDBWOlZ91Y0HCt4WK1RkNP9yclCVpNcqUuHVhanpANksOX+TknEtX7dVBLFb7E9RGvP+HgQAoJKEWOW9CYWHu82IA6+gGwXJ8dP+lJValj7CVo1Msk8zzH4xciyq60ZHBbQwThjeWMk7k8H2gD32V4cy3nvDWAaoXnzelVNHYJDZp0ysUP44CFpgM2eUC7o8YL4PSkHEsUlSDqqlZby2JM9aXc93o/PB4s94hNj4s+SKIYVF7gEAhCagNikonvHRK6J+alE0x8lS8AA2mRIbNAKxadeRfy7PiRUGq3JlU6QPTaRotKLD64+Q+1wgiHQnZsQasKHHEQRBj3UoY25+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by DM4PR15MB5379.namprd15.prod.outlook.com (2603:10b6:8:62::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 17:12:28 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:12:27 +0000
From: Nick Terrell <terrelln@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Nick Terrell <nickrterrell@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@meta.com>, Kernel Team
	<kernel-team@meta.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/1] zstd: Import upstream v1.5.7
Thread-Topic: [PATCH 0/1] zstd: Import upstream v1.5.7
Thread-Index: AQHblFjp3H9z7ZaM1EeYSMTfdaOSiLN450EAgAHULoA=
Date: Wed, 19 Mar 2025 17:12:27 +0000
Message-ID: <B79BD3D7-80D5-41A8-9402-571EB6205701@meta.com>
References: <20250313205923.4105088-1-nickrterrell@gmail.com>
 <20250318131636.GC32661@suse.cz>
In-Reply-To: <20250318131636.GC32661@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|DM4PR15MB5379:EE_
x-ms-office365-filtering-correlation-id: a267546a-cd4c-49ef-1f9a-08dd670939d3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?em1lbkZsS0JlWm9qRXlqcWx2NmhaVWxESjdQb0NHWWoxVGdnc0RPV0UxK1VH?=
 =?utf-8?B?YXViOWNJeHpZSXdGdW9wWHpUcnBhalNUUWF1cHVRQXFFU3BkMG41d3RraTBV?=
 =?utf-8?B?bXdLS2wyZEwwT3JDbjdCekphdkgweERmRmRyZjRFRC95WUtQL29pOEJPN1Qr?=
 =?utf-8?B?bHQxbjNNc0IrZXI2a0p5QVREaFJJRnM5WW0vZzZpQzJldTlCWTZxcG1xUlJN?=
 =?utf-8?B?SEduZGhNV0syeUV1TTJYMWtwTm1vY2pWSXJ6SlljdFZGQlBJQXgxYkRuMndR?=
 =?utf-8?B?cS9SMjlpNFVLaVpRcE53cC9CbGZnNGh5ellnVFJhcCsrNGs2VUFDZnQ5OHZ1?=
 =?utf-8?B?Vy9SSXl3U3hKdnJLaHpvME9SVXkvQkg4emVLUXU0b2xmWGxvVHlIMWNzVTlP?=
 =?utf-8?B?KzVKMDg0M01Iczh6dVhYNHExMjRtTzlwcDFUTFBTM1ZXTHJkTGFvS2xIKzlM?=
 =?utf-8?B?WEdoM1VGZmFjaTFRT0ZnMXpFQWRYNVZKaHBCdVFBR3RZZlVmaUxoTjI5YXNJ?=
 =?utf-8?B?QzFBK2FoTzcvWHB0Tmx0cjFVZUZ0bzdndVVXRVNHemhaS005TlNSZlpCb0t5?=
 =?utf-8?B?bjdFL1JzeEZEbkFHU05HajMxamxTcVE5Uk9jUmpWS2s5R3JPQ0tva0FRRWlH?=
 =?utf-8?B?SzNJWXdiUTIrWm9McGppWEQvdCtvMkN1RWU1c3RtQklWZ3czcVRiTWMzRE14?=
 =?utf-8?B?MEVYcFloVCtkb05FM2xGS1d0MUdYTTJ0Y2Z2VytZR3ovNjRET2lHZFBWaUZO?=
 =?utf-8?B?bjQyQ3lCVmEyelNKaFhMNUEwRUFLQXo2MmZBOHQ0ZCsyTDlYa2VBb2t1S1BS?=
 =?utf-8?B?dERkY2wxTEtoSnNJMDBTVlYzbVhJZlVFS25POWpvakxrMFFsTkNCU29TZ0V6?=
 =?utf-8?B?YURtTGM3aHBLRHkrdzdJTnMwOHBrNXdjdnZmVE04TitiaGRMbnZtcHREMU5L?=
 =?utf-8?B?STNxMGNWZ1lHTjN2UUJlYmVWN0F3SHlOWVhYSlBsZUVvbHlPVGx0bHlNR3pL?=
 =?utf-8?B?QTV5bXNTR25vcExGOG5rdHNaYnErN0J1T01jUUxqMlNteThiQ2NZQWRHQlFH?=
 =?utf-8?B?Q0p5QkljT21NZ1JHdmdEb1g1a0NvNmN1Y0gyL0hpaWNSME5ldnNEQmphNXA5?=
 =?utf-8?B?Sk9PYnIzaFdFQ21OdTZFT2pLbGJuYmFzRDJveDhTQW1TdXJwdlN3c2FyY3A5?=
 =?utf-8?B?TTU4TWxBUmVUU1JkS0tSa2VXUkRDWk5hZWdXZFRkN1hwUEMrMTRwVGJlVUdi?=
 =?utf-8?B?RVdEWTNwamp5WWZsSXpyOGp6NzZ1MkRvb2pGYVd5NHRWWXRhamxkTSs5eGJh?=
 =?utf-8?B?Y3p2VmdTdzJMZEpuRDV0S3ZjRytLclg3cHJSS2gxNXpBY3EyL0NmejBsTCtP?=
 =?utf-8?B?MGRSRTJ6OVIwNTFYNkZqVDVCRjVlTTRRbFpVTnNrSXVCb2NBUC9rNGszK2Mx?=
 =?utf-8?B?UFcvVVladlZQMElWbjNEU2lhQzNVZUd3R2xXYTBDZDhkN2tNTEpHYWNyQ251?=
 =?utf-8?B?dmptUFFWbTNGbFNSVXZybUZ1T3Jaa1FabExSajZqSFEva3dyV3VFb0hoTFpa?=
 =?utf-8?B?c3ovT2U3R01XM1ZZZ0M1UTVoSk5WVGNDb1htQ2g3dUptT1JjK1N6K3pQU29i?=
 =?utf-8?B?dWVYMXZ1clNEOXRkcG5XaG10eU51UHVwdXZSYm1FRGNlOWpxRERGcmF1bmRU?=
 =?utf-8?B?Z2taSUJSenVXdGhpUWpCaDI1cG43cCs2b09JeUxvb3JIRGlmd0t2cHpUb2dK?=
 =?utf-8?B?MHlYZFRaZXdXa3g0c09hdjJYUzJiU3lWQlc2SHFBcG1wMjV0RGxqWldqOXhM?=
 =?utf-8?B?bDI2cVhWM2duTFZuUHB1bUI3WDZra3VQY0tsTCszVnZNdVR3Tk0vZ3gxSUtJ?=
 =?utf-8?B?ZHFFRW03dmpVdEZ5MWRPWHJVSDFTUnVIMXdLWWlDSEVDdnQ0YnpwQzF6RDdU?=
 =?utf-8?Q?22ecNGLy2sUbmN/42ZBscDoFQzLzEi7S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YndTcTIrd2ZFem5kL0VmUkR4Um5VVTdHMndQZ0E2V2U5a1BxbStpdTdyVzVO?=
 =?utf-8?B?MFRoMCtVR0htU0l5TXhwUkxGSUo4MnFnMVQ5WG9YbFVzNXkrQmZERzAxbWp5?=
 =?utf-8?B?SjBYdkI4QjBYcVpiZk5WV3ZlVitlMmdUQk5MZVRuamx6Y0k4cUhlTG1UUWR5?=
 =?utf-8?B?WXQ4Y3hmdDg3RWZlZnBVdUtBNThrQXV4OWIveHE3U2I5dmRUWDBqUWJDV2N4?=
 =?utf-8?B?dkNZTTg2WUZ5YnpVODcvOUlGV0NTWFNMZFkwQllDV1J5NFBiaXZURFBNRTN6?=
 =?utf-8?B?WlpaYjAwUHYvc3d0MWt0ZzRxdjQ4Nkk2SkVlWExmRDVWblpTcUYybkE1aXN0?=
 =?utf-8?B?REtzOHRtZEFwQm5ZYlFlNnlFaEo0ZlFMZUpUQU5QYkV4SjNMUGxEZTBMS010?=
 =?utf-8?B?ejc1UlNJWVo4WWVpbVhJR1VhVktqYkFmWHFCcWd4amtKbGFiOUMxVVFQNkFL?=
 =?utf-8?B?cjM4OVArRDdDOFRTdm5kaTV4WW5xZEZBKy8xRG1SRTdDUjB4Y1Q3U1RwUVFr?=
 =?utf-8?B?cjYwelBqV2JQVnN4MUJoZEc5ZWtQYXY3VGh4bzZyNzlzQjFlekt1SDJCMXh0?=
 =?utf-8?B?WlVZY3FuejlYZ1R0VUs0TmtMZWhDMGFWUUIwbitpbFBCTHRtbGFtSk01Z0h4?=
 =?utf-8?B?T2pPenlzbUpDZWk0eU5HNVpVR3pWRzdPcXM4cjBpYmVQV0RLRmV3Y29oZkp5?=
 =?utf-8?B?SEVqekNZd01JNzJZRThXYVBMZFh0bkxDdyttak04NnBDV0VmY3F0S3pISFJJ?=
 =?utf-8?B?YzlxZk4rQkNoRkgyblNZUUV0L1ppUmF6cE9QcjhmS1NqdTI1TklpOWh0UXk1?=
 =?utf-8?B?VVAyMmVMWGtOSHVWdG1oTWhqdGZORjVxUXVha1ZBTTlacDdBdllCeXRTSTk4?=
 =?utf-8?B?dmpCbkFPR0tSNnRwRVplVWRHZ28zZHZ2RFcrOTQzeG5aVVVDYnRhVFJnRVM0?=
 =?utf-8?B?QkJOR3VsZk1KWEZ3d2k3eVNmM2pEN0xxbUZzMlBGY1V5anRYVEdlSng0Uk12?=
 =?utf-8?B?aWxWTmxVNzFsall5OGVsRS9EUW1kSDBxMjF0ZDRxYXVNTDE0b3pQRmhpV09P?=
 =?utf-8?B?Um9HREtPb01WL0N3RGdzQTI1TmdGQVM2bWJqaEUvK3NSMjRHK1dKTnJjbzAz?=
 =?utf-8?B?WEZKRVZFM1p6OUcyZTRvTStDZ3c0VHhCSjRBajU1L2Ftb0JBS1ZsaHJXbkI5?=
 =?utf-8?B?N0xoSGhjVCtXTjVLYWsxOHE0dG9ERVJWSG1janRwUnRQVGxxOWtwTHNjL2dB?=
 =?utf-8?B?WDBsRnQybk1qT2lOdllnUkNrcmIvcGVYK3o3cmtDYWJ0clozUmZhZ2dNYWZY?=
 =?utf-8?B?WngrY21nTzY0MlNqYjA4WVA2YUltd0RudVo2K0FYUXhDUUxVNEhWSEdKM2J0?=
 =?utf-8?B?TTUzQUxTblRiYWJYK1ZDK1BKMk42NUQ4M0JDUHJDMFFXcnNBL0ZmZ3NyZHhM?=
 =?utf-8?B?UFBKQ2hJU0lHZW9ncU9Qb2gxcU5QaU1Rd1JMRGUwNXkxcFpYYjRQYnM4TWVH?=
 =?utf-8?B?c3NFRmZRZzY0K1QvQUJRR3hWU2V6M3Njb21LaU1QRm9zeFFQK0ZBbmlQalhS?=
 =?utf-8?B?Tyt1NVkreXhhaFF4NnNxbVJrc1g3eUplcjdpQ0JNcTNESEpYMHpJS3B3V1Vr?=
 =?utf-8?B?NEprR1J3R2xRaGtuTjJqWFV1VE4xMlJRaFFabzFVckhKN0dPZnM1UVJVVURq?=
 =?utf-8?B?cSthZ2ZPSnBaWmc1V0tWWkg1L1VIUDhZQ20xREJnWGgvazRlbVpOcHVvaWFQ?=
 =?utf-8?B?cklRSHpQVjdMN2VRRTFUVnYySG4rQ1BkNGV1cGNvZ3FBdDVoT0JYVTVvQnNH?=
 =?utf-8?B?a0JDQmJmWlkyOUV6VHA5Z2dxM3ZrN2RiMzM0VmFYQ2lFZWF0WHluSnhEWlRr?=
 =?utf-8?B?dXE4dnN0NHdkL2hvd2ZsMHBwandBY1JOV1ZBZ0I3U1B5bFgwSWU3czVBeUpZ?=
 =?utf-8?B?MmtOR01xNGcxeXVPbnR0NzdvTHJKOVoweCtIamp6UXdySkhiY3Ruc2pPaXps?=
 =?utf-8?B?M2FHTENlK0FzcVp1Q2sxMG1oM1R3WlRLNmZCbitrVnBTcU9MLzUyYjFITGh6?=
 =?utf-8?B?OHlrdTgvV1pFZE0yTXdjSGFLNWVKRE5lTUJXS1VwU3pteUVNT2dSRVFQQ1pt?=
 =?utf-8?B?Y3JzaXRjd0VWWUNuNFFEVDlKSFU2MkZnWFRjTitSc083WmJIZzJEZjlxdkZv?=
 =?utf-8?Q?FCP/9M4JjmT86AXyduc5Mx0=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a267546a-cd4c-49ef-1f9a-08dd670939d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 17:12:27.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpDd9+QrAZgq0dlYgtDwEbrDXiM2BbJVaw3AhvqVxNeGL7tqPZXcPB/MnrR3PzlnS8h/DlVY8RYYzAAZivWuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5379
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <E2747F734290F24790DDBA2CA37D0122@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: hVRSMujb07D5y6TvxDQQwd4kNRe9oute
X-Proofpoint-GUID: hVRSMujb07D5y6TvxDQQwd4kNRe9oute
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01



> On Mar 18, 2025, at 6:16=E2=80=AFAM, David Sterba <dsterba@suse.cz> wrote:
>=20
> >=20
> On Thu, Mar 13, 2025 at 01:59:20PM -0700, Nick Terrell wrote:
>> From: Nick Terrell <terrelln@fb.com>
>>=20
>> Since this is a large patch, I have also prepared a pull request as an
>> alternate means of fetching the commit:
>>=20
>> The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01=
da6:
>>=20
>>  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)
>>=20
>> are available in the Git repository at:
>>=20
>>  https://github.com/terrelln/linux.git  tags/2025-03-13-zstd-v1.5.7-v1
>=20
> This tag is not in the branch that is pulled to the linux-next tree, the
> zstd-next branch still points to v6.14-rc5. This means the 1.5.7 update
> hasn't been exposed to linux-next testing. Please update the branch to
> the tag as well, the merge window opens next week leaving little time
> before sending the pull request.
>=20
> I've tested this patch with fstests and btrfs, no problems found, but
> regarding the process the updates need to be in linux-next 1-2 weeks
> before the merge window. We're past that. As this is restarting the zstd
> merging I hope we can get away with that this time, skipping another
> development cycle would be unfortunate but also not helping anything.

Thanks David, I've pushed my linux-next trees yesterday morning,
hopefully it will be early enough. Thank you for testing as well!

Best,
Nick Terrell=

