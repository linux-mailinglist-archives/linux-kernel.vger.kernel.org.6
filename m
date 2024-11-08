Return-Path: <linux-kernel+bounces-401020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A49C150F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AB8282013
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC512F5A5;
	Fri,  8 Nov 2024 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lix1K94f"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA328F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038534; cv=fail; b=SmgG1NdfeHWutlL63fhj87Q0gLOFVVcZJUsPvQBdWAAuuYVjD9cFOlWB9Q/6evhRi7Ke7MjVCY1yBJkmvJmvBYHia6pF8lAWsRvDOeKjN+UM6791xvLz2n1Wpa4Y7dl/udDqEN2hlfngn6PfeSERCKSadbMIiTlYh4KcNpK4wk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038534; c=relaxed/simple;
	bh=5jG+lTqc52/fXGhn5iaGDPcIaUub4Twl9LJDBXQvYGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TTWyW+C5JK930O5p3s/7/TfZMB0oQ9d4mH9VDv5upxu2vLI02jzHAwEPZLAvVlQvz+HOlPNZN69sOuoPctO+qErmKh6jjyyhLkm233ybHZOpWxi01HIuaKsjS5BURnpyBDey81gAVl72+UqJtpTuy2HO6sKkDOoVpzBilE0KWCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lix1K94f; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbcoU011866;
	Thu, 7 Nov 2024 20:01:56 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gq8kgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:01:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiIbHw6Qk/P9byYndyWOLJjEPbTR6hQ0i1RszbTwIlFCmmAglLl8dH/FPeBr4tI5vHxhJTsBMNciXO3OdRGLorOOPPI/W1x5XToptfU9iG5n0PSt1Kqkxm9zdqfo38yiJVVmZfDRu/0A6xbCa6BTkPIawoBb7l07JoxG9GGNhAii1LZMmaasILXYGrQAkTm001mjNfla1FlZNdhiJjri1zCBrlNUbwMtslBDLaRE/BMjOPAroMu30SK7RfAs1OTqYO8h9UT6XXwV8k121Vno6JImgh2FqaT4B0ZAr0V9r+dPvwh7waBL9xNRfFDB9nvcRAvM/7zNDbrTHfPSSTDLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jG+lTqc52/fXGhn5iaGDPcIaUub4Twl9LJDBXQvYGs=;
 b=oFwbI6UoJtHQUEqtal/IkauYWW8N1AbVjzNzKfFzyPRGUUryceEdQFq1G8VUpFvDZ/ixJhRHtTuWzCbd6ANK+AtCs66xf2tdcomAKNYAIUELrWITVqC7gUxtuP2mAP+74OpZQFVdUYaYvkLnkU/7VTFbt2tuSnX3ATwiLme/OvGulcvCci7fJucMmys9etB9JqxrCGdVo4ZufXBuzxAT84iGMV9JqskHEoeU6QjJUHai8k/M50tcowKjQ88cbl5qLwLlNJ0y8fH01ksQRr5QP/4fBILkAqVLLIxZphiK1WhIcK6A4V8eFrkMKgh2wDtqCWhEdxmw6rU3XluUSJCWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jG+lTqc52/fXGhn5iaGDPcIaUub4Twl9LJDBXQvYGs=;
 b=Lix1K94f2TvsLBVagP3nCGNrFJxJU9hjpMOSyfDjGpTOqRWAIqzP/Lt4kfVi4UGcajcM2qj2TPgUW/mICO0e2sUTtGt6j9LDMFH61cmfd2SZQXz7tLNGctbKyQ1lYx/7IQqJGI+YB0g4YyInF9RyaUafCGpxkkGLcHsTYbaZFJs=
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com (2603:10b6:a03:2ea::22)
 by CH0PR18MB5505.namprd18.prod.outlook.com (2603:10b6:610:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 04:01:53 +0000
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc]) by SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 04:01:53 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Will Deacon <will@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v9 1/5] perf/marvell: Refactor to extract platform data -
 no functional change
Thread-Topic: [PATCH v9 1/5] perf/marvell: Refactor to extract platform data -
 no functional change
Thread-Index: AQHbMZLyoBggA/nZBUyZSWpj/CKNMw==
Date: Fri, 8 Nov 2024 04:01:53 +0000
Message-ID:
 <SJ0PR18MB3865C0CBD980660D828A3693DB5D2@SJ0PR18MB3865.namprd18.prod.outlook.com>
References: <20241016080153.3546353-1-gthiagarajan@marvell.com>
 <20241016080153.3546353-2-gthiagarajan@marvell.com>
 <20241024120925.GB30510@willie-the-truck>
In-Reply-To: <20241024120925.GB30510@willie-the-truck>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB3865:EE_|CH0PR18MB5505:EE_
x-ms-office365-filtering-correlation-id: c2cec7c3-c7fe-4abc-f8f5-08dcffaa14a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVVDQ3cvdXRUMitYMmxWSWNpZ0ZtYkthMzRuOHZiMHdUR3R2V29MOWV0L0U1?=
 =?utf-8?B?a2RINGNHZmoxcHg4VDNWMkJoUmkrcmtweWFLS0dMT29QWnl1NGMvejBIREF3?=
 =?utf-8?B?a1Y0TFYrbTVoNFh6YUg2b2hjd3NERmFpTjN2UnlhcnFHUENyZmFuZWRyV092?=
 =?utf-8?B?cnZZYitjYkg5K1NvRjJIc3F2aUtDV21Fd0hhV3UxL1padkY4NlJsbDFqNmJC?=
 =?utf-8?B?cnh6OGVEcU52eHl1K2YwSzV6Y3hWWk1lTldSOGNtUnJENVhpUTNHNjh1V0hO?=
 =?utf-8?B?UnRBNUZNeFhDbHF3R1dmY050UEtzMVlRQjU1ZzBOWHZoU2NpbmMwcHhVYnJx?=
 =?utf-8?B?NDJZaUZjRDRkWHVHREhoTVJpNGtLakUxNlVXL0J2SkNycG1sY1YzU1ZteC9S?=
 =?utf-8?B?V0dUUlk1WmQvWkp2bVdvd0lDQlloU1FHSWxlQnNheTVyb2RUd2FJaWR3NWY5?=
 =?utf-8?B?ZnVaRWF0eVlYVDdTTytpbWwxaGhjTzFiRUkzczM3b3VzOGUwd1FLL0NIcStz?=
 =?utf-8?B?a2lIRUlRU3ltWG9pb3ZTVWpuMWxGSDM3d1dPK0RMam9HY0lPZzJoWm5vQzAw?=
 =?utf-8?B?QVNpS2NVSzhVamt1cmNkeHNyK0x2ei8zWk15cE1hNDR4cWRVNDZISC9ZUktl?=
 =?utf-8?B?eFM2eXdsc1BURjF4STlPeFlJc0lvT09CNEEzdE9WcGRKcmVRRHh0dVhzZEY4?=
 =?utf-8?B?VTlVWkp4QXQ0NDZBYUJwN1NQQ1VObm9PMEx3eHRIL1loMjdRay9GVG16RWI3?=
 =?utf-8?B?ZVBzRm8zcEQyKzJ6OUxLbzBmT01kR001eVJrREp4cVdJQm5idGxicU1xUDM5?=
 =?utf-8?B?R2lIaVcvRUpZdys3cndmVHJLRitZUjEyTVpmd0R0cXlwSmFzUzBBaVJnUys5?=
 =?utf-8?B?eXZMRHVkdUdlMUlTbWJoall1ZktBelgxWU10OGhjaHBsbzkxdzNPY1ZtM3JT?=
 =?utf-8?B?d1BSdVVraDl6bG5nT0N6N0oyekVUNUpEZlpkaldOL2hqd3dmVHFwSVo0aWxt?=
 =?utf-8?B?MWFaVzBDbVd3eE9EMmRmUFlXRXBCZU50VHBkSHhkUTFZN1AyNmhkU3NDU2N5?=
 =?utf-8?B?eEZ0QlhaZ1k5TUduSys1Szl1SDlLdG1MczJMSmNLaFZJOHN3aTRvSUgvZTJZ?=
 =?utf-8?B?Z2wxRkZveUwvNlNjUzkzNlpaNS9KQXpINmRUeThnVUl3Mk5lMXFQUjM4M2hr?=
 =?utf-8?B?U04zVUJ0K1F3RXB0VUpzZTdPWDM1WFhQOUk2RlZjVVdkMXBjKzdWNzFKcFo3?=
 =?utf-8?B?YWNjTTEvcnptNTU2clBrZi9xQUo3NWVFb1diMWtHZUkxOFBYTzRsTHZQVjZJ?=
 =?utf-8?B?WFFQY2laNmMwcmgvVDRKZXAxekI0S0xrQm1OR2h6UlU4UWtFa1RBcGJLMVF2?=
 =?utf-8?B?b1JvNXNHWWpXRGw2WFhwSDl4eHRKN1lYUldBaGk1OUNGOWp6eFY1R2dlWVJY?=
 =?utf-8?B?WktKUW0rTnNaVXZ3WjZUMXp5QldEQXdoalM2M0ZkVG5xTjgvN1Jad2tjRGcx?=
 =?utf-8?B?ZTF6OW13a1dXM242ZEhTU2RCRGdFYitnQ1ljVWpHdVVYZDdJQU9OalcreWVm?=
 =?utf-8?B?eGhVeXRSUHU2TzQxUTQvaDUwZCtpMjByMnhFRUQ4YnEvbjY3NHUrNHRSckEr?=
 =?utf-8?B?bG5jakpMRCthRnFydEM5MEhtZ3N6STY1akMyeXlka0lMVEEvVHBFZDBCQVJt?=
 =?utf-8?B?Q0l0R2twcGRGTEZkZmY0b2crK01YR2JVcjZsZkxEYmNHUlBYYmpMK1JSODg4?=
 =?utf-8?B?ZnJpTEduRlNiZHFlZGJQcmRKK2NNb2YrWDFQRzdRV0V5NXQxcWVJV1lLSTJC?=
 =?utf-8?Q?jr0r61ZqNy+GhEgckrpvBCT8o7PcfoD9YkPuw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3865.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHhuOTR4OVNKbHNmejBIQkNhNFRKcFk0Nld3dS8zbllXbkgyTHJzQ0FkdDNo?=
 =?utf-8?B?eVptWmUzRENYdnlhOC9wYm5sbHJPSEJ6NG8vcWpFZDVVRUE4aE0weW4zeldD?=
 =?utf-8?B?S2svQ1R1elQySkNDNWV3Y0dPL0tCV3JjbDdxZnNacUVBKzhMY2VxaVpmVmRK?=
 =?utf-8?B?T21KTUcwcUhnVFdIUnNvRGxKejBDeG5JTk94YmlPYUI1a2ROdFRuZjlXaGhS?=
 =?utf-8?B?aHJKOElySTUxUDNOVmlXWnZRTzZtMUtnRUZ4eXlsVWRSbGVRREJOYTF1UTNW?=
 =?utf-8?B?dTRiUlRrMk5odEU4WUNIZmhyeDQxWllEekhpS1NnZ1dqUFpuNVhpU1F4dUdP?=
 =?utf-8?B?V1BlaFRiU01YVW1kVG4xOUpZUUF1Vyt5bzFURlVndjYrT050RmlOSWw4dElP?=
 =?utf-8?B?SFV1ckxwOGl3Y0VUeHNMbXc5NkVDRlNWWTUzUU9VL1hmU2Y0aVJBWnpQZ05x?=
 =?utf-8?B?MVJJNk9nTUd4YlJKcWxvcnRrc2s2QURpSzJIZ2dlRXBCQ0RtU0lqZm9MdzZP?=
 =?utf-8?B?UVd6Z21IbExoYTA4Z0tsWnBvdllTekVRNVFxNzlNdEQxUVpjT1hwTXVaTERn?=
 =?utf-8?B?elROaDhIV3dwZUZFbVE3dUxHeFd0bEtvTUYvS0x6SS9PbmxlU0N4SmtyUG9R?=
 =?utf-8?B?RHpsbzdEOERvSWpnd1YxcFJXWlgrS0pWamlYc2ZHRDFlaWxKdHdRRFlPdk9p?=
 =?utf-8?B?WkFZdGlaUDYxMnp1Vk9XeEwwRGhybThES0RsVlZoeCtwU29wMTU1ak1NWVlt?=
 =?utf-8?B?S3E0SDFFSnh6S1dqT2szS3h6MnJXTGZJbzVsZ0JzMmczQ2lvTGVjQkQ5V3pK?=
 =?utf-8?B?dkF2Tjd3bndLTWVDbmp1cTZYOURwSjhIeU1Hc2JlcUtyL21YVXo2eFY2a3hN?=
 =?utf-8?B?dlBqdHRMUmprZkU3MW1wOGVkbldDTERFRzNZWVVEY3ZOM1dWNTVKOU5pd2cy?=
 =?utf-8?B?S3lRVnl1RFRyN1VCcFQ0VXp3eGhOb1FqU3VzY3NJK2l6L2Nnb0pnZEo4Wlg1?=
 =?utf-8?B?TWJ1NEU5eEdEbVYreHlsM2dYQ3I5M1dibzNrZ1I4T2k3cERwQkVpaDc3USt2?=
 =?utf-8?B?eG1DVnlnRy9QQUxMQ1lGWmg2YUhTOWZZRmYxWS9IOTl5dFkyRFN0T2hBNGNV?=
 =?utf-8?B?ek5GZXRqaUV4QWpjVHM1cHZvMjNpYnlCWFJlZXhEVEJiRkREMVdHbmdseitn?=
 =?utf-8?B?Zzd2UFhzcloybGVvTWlkdkxsaVMwVi9PUGRndXQyOU0zZWJLNUtOcVhYSEJT?=
 =?utf-8?B?ckZ5RDRvV2VKTWtHMEgwRThtRm9lOEM2cWY4emVjTFBIM1FjWnNOZXRQeW10?=
 =?utf-8?B?RjdIdzlyeVBla2hlcnQxeGRWQVNxdHQrYStNQWF1eWxxc3JXM3Vjbkd3bTZn?=
 =?utf-8?B?R0hDRVFsQlduL2o2UVkvaXo3TnBNOHA1RzJKdmpkQ3k2R3d2cEZ2bHhYMzJH?=
 =?utf-8?B?cXZCbk5sWWlnY1poYkUzaW9lbExPaTkvdjRKQ3prNjVmTEgzYktYTFRVMnUw?=
 =?utf-8?B?NjdFY2hsb0xDV1dOTVZObnZaTjRyc0FiVmV0MlhUVFg5Wlp6U0lmR0JEMHJ1?=
 =?utf-8?B?SkdKaHpzUHQvN0ZpTlE2ZXpxbzlqbWFWMS9hWFlZUHpueXBIbDlZQ0V0cU1V?=
 =?utf-8?B?UWZOOStxZnZCYTEzZ1Bxbk5MSE5Fa3I0K05yNGxWMEM5ajFzWVNvSWdpRStD?=
 =?utf-8?B?a2tHdzJkRWl6SisrYXdKM1YyQXpac1o3bUUzWHk2cktJQkJLMmpWTWNkNXkz?=
 =?utf-8?B?QlJZd1V2WHAzbStZL3hTcFhlc3J1d0p2NFdhak5yczNxdGpIaklrOVdaSnM0?=
 =?utf-8?B?Q2ZnMkR1YXd2akwzRW5lOVN6NWEwbHZuTU1sYTZlR1RUS3VhY0FJa290THlt?=
 =?utf-8?B?UzBVaUp4OXJNWnE5QUswNktJU3FFUVBYTmtGUlhLRlVZTjBRdFdLSXBPOGM2?=
 =?utf-8?B?Y0h5TFo0SlM0THBrMFlJTStmdFQ5ZXN0YzlUQVp4cVJEcUI3Y0lUM25EOWty?=
 =?utf-8?B?akdsRmhvWUY0WUxQNWplcmN2eDVhb3pJUEFHQzB1dzVwdUpTRXRpZVJGUGRC?=
 =?utf-8?B?QVp6Mjk2WWlhaE1jRGxOK0ZuVnN3VW5QSHpGOG00RmxVS0NJRmJBQlgzZW1U?=
 =?utf-8?Q?2GydbtZzb+3uZNRYDUg1u0ofK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3865.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cec7c3-c7fe-4abc-f8f5-08dcffaa14a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 04:01:53.5454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4v9X6LQYcyEduMmNM6st+uNZOsTdpbgyGPzWL8mVZMydtD+sqO5AXRfB0FzVs0twAM26hVIMeuCXk9nOch+ao9en8OtSREY8E7hMr3PvePc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5505
X-Proofpoint-GUID: B8B5xd7cygSKxGswjZIcZ1TVlWGIttsm
X-Proofpoint-ORIG-GUID: B8B5xd7cygSKxGswjZIcZ1TVlWGIttsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

SGkgV2lsbCwNCg0KRnJvbTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4gDQpTZW50OiBU
aHVyc2RheSwgT2N0b2JlciAyNCwgMjAyNCA1OjM5IFBNDQpUbzogR293dGhhbWkgVGhpYWdhcmFq
YW4gPGd0aGlhZ2FyYWphbkBtYXJ2ZWxsLmNvbT4NCkNjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBCaGFyYXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsgR2Vvcmdl
IENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwuY29tPjsgU3VuaWwgS292dnVyaSBHb3V0aGFtIDxz
Z291dGhhbUBtYXJ2ZWxsLmNvbT47IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbQ0KU3ViamVj
dDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHY5IDEvNV0gcGVyZi9tYXJ2ZWxsOiBSZWZhY3RvciB0
byBleHRyYWN0IHBsYXRmb3JtIGRhdGEgLSBubyBmdW5jdGlvbmFsIGNoYW5nZU9uIFdlZCwgT2N0
IDE2LCAyMDI0IGF0IDAxOuKAijMxOuKAijQ5UE0gKzA1MzAsIEdvd3RoYW1pIFRoaWFnYXJhamFu
IHdyb3RlOiA+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgYSByZWZhY3RvciB0byB0aGUgTWFydmVs
bCBERFIgcG11IGRyaXZlciwgPiBzcGVjaWZpY2FsbHkgdGFyZ2V0aW5nIHRoZSBleHRyYWN0aW9u
IG9mIHBsYXRmb3JtIGRhdGEgPiAocmVmZXJyZWQgdG8gYXMgInBkYXRhIikgZnJvbSB0aGUgZXhp
c3RpbmcNCg0KT24gV2VkLCBPY3QgMTYsIDIwMjQgYXQgMDE6MzE6NDlQTSArMDUzMCwgR293dGhh
bWkgVGhpYWdhcmFqYW4gd3JvdGU6DQo+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgYSByZWZhY3Rv
ciB0byB0aGUgTWFydmVsbCBERFIgcG11IGRyaXZlciwNCj4gc3BlY2lmaWNhbGx5IHRhcmdldGlu
ZyB0aGUgZXh0cmFjdGlvbiBvZiBwbGF0Zm9ybSBkYXRhDQo+IChyZWZlcnJlZCB0byBhcyAicGRh
dGEiKSBmcm9tIHRoZSBleGlzdGluZyBkcml2ZXIuIFRoZSBwdXJwb3NlIG9mDQo+IHRoaXMgcmVm
YWN0b3IgaXMgdG8gcHJlcGFyZSBmb3IgdGhlIHVwY29taW5nIHN1cHBvcnQgb2YgdGhlIG5leHQN
Cj4gdmVyc2lvbiBvZiB0aGUgUGVyZm9ybWFuY2UgTW9uaXRvcmluZyBVbml0IChQTVUpIGluIHRo
aXMNCj4gZHJpdmVyLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGFyZSBpbnRyb2R1Y2Vk
IGluIHRoaXMgcmVmYWN0b3IuIEl0cyBzb2xlDQo+IHB1cnBvc2UgaXMgdG8gaW1wcm92ZSBjb2Rl
IG9yZ2FuaXphdGlvbiBhbmQgcGF2ZSB0aGUgd2F5IGZvcg0KPiBmdXR1cmUgZW5oYW5jZW1lbnRz
IHRvIHRoZSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHb3d0aGFtaSBUaGlhZ2FyYWph
biA8bWFpbHRvOmd0aGlhZ2FyYWphbkBtYXJ2ZWxsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Bl
cmYvbWFydmVsbF9jbjEwa19kZHJfcG11LmMgfCAxNjAgKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEyIGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygt
KQ0KDQpQbGVhc2UgcmVhZCB0aGUgIkRlc2NyaWJlIHlvdXIgY2hhbmdlcyIgc2VjdGlvbiBvZg0K
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QuIFNwZWNpZmljYWxs
eSwgd2UncmUNCnN1cHBvc2VkIHRvIHVzZSB0aGUgaW1wZXJhdGl2ZSBtb29kIGFuZCBhdm9pZCBz
YXlpbmcgIlRoaXMgcGF0Y2giIChUaGlzDQpjb21taXQpLg0KDQpZb3VyIG90aGVyIGNvbW1pdCBt
ZXNzYWdlcyBoYXZlIHRoZSBzYW1lIHByb2JsZW1zLg0KDQpXaWxsIHVwZGF0ZSB0aGUgY29tbWl0
IG1lc3NhZ2VzLg0KVGhhbmtzLA0KR293dGhhbWkNCg0KV2lsbA0K

