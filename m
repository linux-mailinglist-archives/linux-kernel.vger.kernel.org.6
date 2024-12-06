Return-Path: <linux-kernel+bounces-435511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20459E78D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD6916C4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE9203D4D;
	Fri,  6 Dec 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XaHcbzz8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a5y2+vCY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oPZUOcU1"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C471FFC78;
	Fri,  6 Dec 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512844; cv=fail; b=p2x2UCov00P+Ku5A/BvIQMktgRkQF7VwN6d/ID/Il97Nu8jlwhEhVA5/n9sgTzPfEjfB+PckMwi1FGofReGgHR0OCu8KasgPLTcjhvxn3E7syKpHkaIjVP25o+F6PA/TkMDxiFEYWTPPYoj9bPiLJP4I9nXUM8iGLr1qJfV1eo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512844; c=relaxed/simple;
	bh=1opmzeGqgB3S6diVb1dtSt4FiHEyOOy2KiiwjzzQ7mQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XEGYsRl9IOgHFC5AAec22ERz5FUAtGgJVUijTjJnfw2YSCB3vHK2IJG7/WoZtfKeaOMHf0evFvjYGxK0EbYq6kY+0Wkpa+1QTqm5Bcx+XNn3OSQiOjw79esmbZHDFqrznEjvpmhV9KDEfkkR6IJT3BqtMxOUkudfCtAREHW2nL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XaHcbzz8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=a5y2+vCY; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oPZUOcU1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6GEOkw024389;
	Fri, 6 Dec 2024 11:20:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=1opmzeGqgB3S6diVb1dtSt4FiHEyOOy2KiiwjzzQ7mQ=; b=
	XaHcbzz8V5FAGb1dhRn85bsoPJ0zL7kZIJz0X/MbO6wtyCEModEXqAV0Lse/c/Fj
	a/o0/3cOUiDyhAOcN0iYro+VZotYLgdtF9k1KAsiH1kqodAd4Yuwwxm/XVqAS+5d
	leKbsVGKV9JMW8LbjVQgyQY2AgjwdKMxkH+8zHPkg/HXsYAp7UWSXlDrtn8jwtZr
	F3fgsPBL9OvBlXFeeXx2DxSd7lQX98ndpWQQoc+kESmKlbxdhF/prgkKaq+JWG2z
	qXRmm/A8P/D8RqAPhYqd1tF2Doj8rdZu8ZiLKKLoW2Gdt5YMrQ/FnrkCVybrUqaz
	pKn5r4Y3rc2ADWSEjkYHBw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 439g1yvusd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733512832; bh=1opmzeGqgB3S6diVb1dtSt4FiHEyOOy2KiiwjzzQ7mQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=a5y2+vCY2Kerzp2P5Ds3sC6wvLQljzKNVRylNjq4cvWCvHeWZhfjfzCWmOQwTcW2e
	 0pIgqYFBoXKqEu6KV7aIEUA5qtr3g3oVAg1g9CEk6qohG4da98Tk4jR/blVUQO+Fo9
	 NlbIVVIkqCOp4i2NBYLA2DLeHyD9JMFjIBCNnnhkgAH8i8jADWfF08Y/DomyMnwnd7
	 f4IRYr7tYSON2LS2BKdKWbRIQK1L6VY+hebjQlbuBnpBnkxezAaVgoaoWtiOBCksCK
	 w7TPfjjIlqIWONOw2zCc8LE6ppiqyrAy2nPegjBXDw+NJdcbUvaPq+jvSgpUWrfIvr
	 XjUC6g9n5otGQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F313740572;
	Fri,  6 Dec 2024 19:20:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3C63DA008F;
	Fri,  6 Dec 2024 19:20:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oPZUOcU1;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 657C7401D3;
	Fri,  6 Dec 2024 19:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4PakUVfPT+eAyw+3icLDiAA9lQkXufAOOWWaS8PyPEm2ooPhJQNbeeio55IV0t2BPh9BE+jxxOi/geLBV2r1XJYD2JdVId4wOTE0AGeXsLAfFmDYPjKXLm2uH0yThg+FKsgzYoI3flDqD0E7tlzJmBi8+3Ke+wXg0zRThbShJfoVChgXbfyFHKsTM4EnXcgFvggIhVQmo6Wizu/TQsG/e3vI5aL4B6VXrR9fxxgGFVhtIxRuyqgahgvqJV86XnV6Edw/EZ+A4l93IXmiDQ03Nb/QK/nQGaY1QMyKK3yRpw0MZCQ3J+oW9AkXvsqbaY946NvMFhe2ZOXlNT5pbRmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1opmzeGqgB3S6diVb1dtSt4FiHEyOOy2KiiwjzzQ7mQ=;
 b=cM1kCkxwLWbDEG+W8OFLY7G02HdlErnTArI1IKvnHsV+rZPb8d9HbRMKdxjj9q1j1+BVrwj2F9oHu+0cfuvXC0gcLqXJfckW/u3IYG5KC4FDtJtwsDF2kxn5iogAOOcWMSIO9hTL6UDx57FMKYpFQFErKsxwW1x3gu+eTC9a0q45fgTgVbfJsFtiWVrTKk0+TxUQn8u+WRiOz7163SZMoR+nvCxv62l5gDUoi4A8Tzqxxg6E79T1c99yFXmfl/9NWynXSfOtg1dxnMawzkh5wpiVUrVoqM16dpKsBrwudbgoJEmv4WprfmVHy5/u9rdb6hh2w5A2zangQgn5+Q0hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1opmzeGqgB3S6diVb1dtSt4FiHEyOOy2KiiwjzzQ7mQ=;
 b=oPZUOcU1kUvsVSODe7Am7J2mH/dg6qy51AOSdH6wNA/Dt+bXtIvLm7UFFLP4BQZc2y33DQIo92+8HjNHahQ6auBicxAat2ULJdSfo0+Hrf1ZFHekttiOY8FqRF1ZHjz0hBHv6KiacIuAYByGJnKiT6SS68xxmzDdqVoi0Cxv3C0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 19:20:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8207.020; Fri, 6 Dec 2024
 19:20:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: fix writing NYET threshold
Thread-Topic: [PATCH] usb: dwc3: gadget: fix writing NYET threshold
Thread-Index: AQHbR9kqaEVQ7uUyHEyBiXD3eZ7glLLZmA+A
Date: Fri, 6 Dec 2024 19:20:23 +0000
Message-ID: <20241206192015.pwecvtssndjfi7qg@synopsys.com>
References: <20241206-dwc3-nyet-fix-v1-1-293bc74f644f@linaro.org>
In-Reply-To: <20241206-dwc3-nyet-fix-v1-1-293bc74f644f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5931:EE_
x-ms-office365-filtering-correlation-id: 7aae616e-1865-4328-92e0-08dd162b086e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ty80VjRHekswNmtHQXhDKzBmRXVaS2FEQm9TcmJ0dk9rQkRoc2MrOGl3N3FT?=
 =?utf-8?B?T0xzRUI0MDNTYzdzc3BrZWR0dzRjRUZMMlZTMnlzRDJsMWE0SDJnRDU3VHhQ?=
 =?utf-8?B?L1Z1L2lVd3RKTG5iNElBWWowQzg3c1hPY1djaDMyOU0wRHRHRXp4QnBRdm03?=
 =?utf-8?B?a09PUDRpb04vVXNWODlnREF2VDlKTm5wS0JIM21xNnBqbS9zeld0UnVWMFBV?=
 =?utf-8?B?a3NIZ3JLSCtkajEzTGdOeW84bVZqNTJycFdid3Bpa3AyWDhRZHNZRm4vSnM0?=
 =?utf-8?B?WFc4V0dkUThIZlliUGxyb04xTzRYS0lEaEZPVWhHWGZ1c1RPYkJMRVR4UkJR?=
 =?utf-8?B?MmVvZmE2ZkZsZDkyMG4vS2lKQ2ovKzRqU2F6RlFHRFlsbnBiVjREN2RnUTVE?=
 =?utf-8?B?ZWRkMXlVVllpOWZ0UGQwK0tjWmN5bnMvd3lKU3pMRUZxQStEUHNJdHQrODBh?=
 =?utf-8?B?cUZBcHpMczJGUDhEczQ2cnE1cG9Vdk9KNi9mSmpzREpnN0xYRmVZQm9uNDdq?=
 =?utf-8?B?akRRS0EwQ2hWN0U5ZHlrRUJEQmxnajEwVHNmMXY5dHora0c0emJOSFgwMFlI?=
 =?utf-8?B?cmY1UFdBUUJBMDJYb1hXYVZCbEszVjROZmp2L1dvVU1BVFpxNEpUN3FSZUhm?=
 =?utf-8?B?dG4rZXJmMTFZN2VzOE1YSDRDd1ExdHZBS01ZaVRMSnJBbmQzMXhMRDhjUVRl?=
 =?utf-8?B?Y01SU0RNMEJjZmM0TE5Wb3YyeEppbFhQa3hlRW1vQm5kYzN2MHdNVk10RTdH?=
 =?utf-8?B?YjkxTGtZRFBWcmhlT0Q3dng0b0JuSlorckJQZEoxTWt5Y3ZWY08zZUtqNkdx?=
 =?utf-8?B?cVRjeWVWcjROTCtCdDg3NnVOYmhIN2EvRGM2UEJoZ0JnWlNqeGNZREM4Sk1r?=
 =?utf-8?B?VllwRVV5elpNQUxJaGxTMWhHaGxOd2ZXNnZLOEpzWmJVVEVpZzZRRkFwWDJa?=
 =?utf-8?B?SFMxYUYveEVZWjlQZmRpSVpINEJGcUxvclVYZ0dZQjVSWjFSOFRwbldNeW9Y?=
 =?utf-8?B?bk0wd0MrMjgwc3hIRDlGSi9JSHZ6ajd1Y1NjSkJxVTFSSWZTNmVQUGw3ci9p?=
 =?utf-8?B?MGhzRGc5NndxRE53RjQ2bDEyeGE3aGNFeFV5d240UzJHMnVYb3dVczRNc2M2?=
 =?utf-8?B?SWtSaXRkUkRjUnVWbkZBSkswZVNnWktvbWlsemFUYndPMHlmc3FJbkh6Z05B?=
 =?utf-8?B?WlA3eE5sdTM3RmNPdUZLbHFvdVBzQ3JKcmFHN1JNQ0pOVUIvaDRSb2dpb3FE?=
 =?utf-8?B?RDNOcDd2WGF1QmlsQytzVG1tL2piZEFJZXlDNHlURlRwWjZkdGRHcEhoY2JX?=
 =?utf-8?B?ZEIwV3VvTGVUeFJuS3ZENm4xOGdwcFErWXdVY2oyZExmeUR5cUJuWURiNFlk?=
 =?utf-8?B?RnFPZTNDbzF0ZUNXMXRCMitpTk00RTZTWlRnUVdCbXN6VjJoUWY1Ri9uNzZy?=
 =?utf-8?B?dkhzWjZUOGt2QXNBUnl2M2xQLzQrZnQ4bVBHOCs0cEhvL3ZzdkVKdHNtVFhn?=
 =?utf-8?B?RW5oYjZMNzNteS9aVTVERlhhQ2REaENXSVFPUnEvOG15c3JycUlFN3JTSGVB?=
 =?utf-8?B?NGdTS3M3OHNMcmVYdXVSSm5VdlBTb2tmWlFPU3NjT0xLbndGZ3F0LzgzNnNv?=
 =?utf-8?B?TUUrV3d1Vm85MHgzZkU4NGtKNDMzWnUxVENWLzVINzNTSWVudUVDcjBpZnBa?=
 =?utf-8?B?RDQ5QnMxNW1tb1FJNmt1alo1eUwzVEV2aHNlNmEwUSswdWVZWnZ2aXgzemdD?=
 =?utf-8?B?MzJjOVFLTGpYZGJYd0IzM1I1Yy9vc1puL0t6TmFwOS9mMDhTK1JBYWFrTUJC?=
 =?utf-8?B?K2pWYU5HVFRBZkIvSGxjMlVoUEtSd1hJeDQxYmtNZFlGajh0R0VWb0s3d0Vq?=
 =?utf-8?B?SkgzQXorandXVjJmYi9EWG5DL2pRbVBhUTV5dENkQmx5c3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkx5bnZhK0ZyOW55bjBuZktFV21pQ1QyRmZ4amtIQkhFc0RCSUdEaCt2Qm9x?=
 =?utf-8?B?K2cvczJxUjY3VVJrbGJTNGVaUVVYeDRHWXowOFh1TGJOblJoV2NDbG0wRzZD?=
 =?utf-8?B?WnQzRWRpWGV4c0Y5Ky8xSDV1RndWSXROK1V1VHJadXBDTk1qVENibmIrVlg3?=
 =?utf-8?B?TVVvakluZXV1RXNWa3IxZ3k3M2Vxa1k1UFp3eVBTVE5hVzYydHViaGs5UFA0?=
 =?utf-8?B?V3ZsU0hqSEVRNGRGZElITHNUM0ExSkFzbGF4L3pZaU42R2YrSytSa0IycW9W?=
 =?utf-8?B?bXlrUzd0QXpjbDN2TVdhNVVFQ1dWdlFYRVVRL0NVREpqTXFtVXdzT21WeVlk?=
 =?utf-8?B?OTN6ZGtEb3FNM0tWbW5YaXZOK1FsU2JtZzVOMmxyTjNRTFhQMytMV29FNnlj?=
 =?utf-8?B?L21NQ21HUStjUjZibzVSL0J1UlNjanBWeGREMkY2bFgzMlV3ejNodFptSk1x?=
 =?utf-8?B?bkJTVU5MSFBzRkwwK0IyV1lYcEZTMlJiVFZzSXJNQjMzNGFnbXJqczd2ZUc3?=
 =?utf-8?B?SGgvZXhiZjI5QmdWRnFsZVkrS2JyVktMN1dpTDg5ZGpvZmdvUkhWRGNRbGZ5?=
 =?utf-8?B?L2ttanFjL0pYN1QyUUgzN2E4bXpFd2hvL2I1WStrRllOVzZCc0NPQ3VXRTFz?=
 =?utf-8?B?UEhSaTJ3ZzdSUDN5UFdCblFIUWJGMzRoOXN0eVV0U3BBWUl0QW1ZN045MDJr?=
 =?utf-8?B?ZWdQKzduc1hRUGY4dGtJUzJqWklTeWRyeFpSWGczMjNHRDQrWWlQUlhJUU8y?=
 =?utf-8?B?R0VuNGtaWHF0clQ3NStnRFpqMGJKU1QvQnBXMEFtVEovcnZWL1dZcllKZGxu?=
 =?utf-8?B?K0VTQTliekZwL0tHb1l5aHZZVTFVTGRZSmtNM2lHNHNQOFM0M3RDQ1N3eG1p?=
 =?utf-8?B?UnVFbTVYeG9Mb1Ryalk0OGVOeVBPMWhscTFhbTNmOWZhNklCRkpzREZGL2dz?=
 =?utf-8?B?R0srUXdYMldYSk81dEFLMEhzQVFkd2UrUmV5YlRsdDN1bjBUWFZLbG1Fd0JD?=
 =?utf-8?B?clM5OUNOMDJWS2FYL0RHM1A0WjJDR3lOQWlNRGMrMGxUQS9pSEUzSHFwK2gz?=
 =?utf-8?B?RWlkbWU5bkJ0STNDRFI4Rm42ZHl5K2djWmlPM2pNa1BOdyt5VndVbEhIWXdP?=
 =?utf-8?B?MndXd1JFK0FsNE1tS29IWlJPU0h3L0Nlb2RLRVpSd2Vkb0RQOTN2L21MUXB5?=
 =?utf-8?B?MlJ0L0R0K0kxSWJRZFFuTnd6cHVzMFdZS2VjemZOMHpsb2YyeWZVdGszYlJt?=
 =?utf-8?B?MXJXUnRnTk9qM3VySGtjbEhyc2RORVpmcjQ0RnNHSTRmOWpUYlY5c2RXcm5U?=
 =?utf-8?B?Ynpsb294UTQvemRYSkFicVk0SlovNTVCV2gxcFdENitBYU0zMFZ0OFFsWkJw?=
 =?utf-8?B?RUI1TGl3blJsS0c5QjNKNTllWmV2TjhOMkEwSEZ1L0F5Mk4rOTkySklucm9N?=
 =?utf-8?B?cW52RkRpYS9Fc1U3UzVwamVqNTNkUnBVaDZsWmh2MEFFWXdNelF2TmdaaTA0?=
 =?utf-8?B?QVpULzI3ZlNndTZIT3VBakFiVVRvcUNybUFEMm1BWTBtSFBhL3Q2TkpPNUE3?=
 =?utf-8?B?Y3l1MURveEpKL1h5aGZuVy82bFBMT1ZwQ0k4em1tSGgyZFRMS0ZXQmlZb2ky?=
 =?utf-8?B?TVJCbGhpRS8zOS8yNFZWVjFXdWVzQ3ZaMmlnWHh0dXZhTXRvcng4aHgwTHA4?=
 =?utf-8?B?SW5LS0NEcmRGcE5mcU5NUks0TWVpWjcraXpvNS81MDhXUHUzZHBzYmIvbXRL?=
 =?utf-8?B?R3ZNVXZwZ3Y2dGJ1dFBzUjByTVZmM2ZLcGkwM3h1azdvaUlTRGZzYy95MTBV?=
 =?utf-8?B?LzU0a3c2UU9XUGo5QnJrck00MWRNZnFOdFU2UUNxQTVUS3lmSTVPSXNEY29X?=
 =?utf-8?B?RVdNT09SdmFjOGY4SHJiY2U4YU5YTWpYSDN4WnIwUUlZdmhpbXM4NWNRNnJu?=
 =?utf-8?B?M2o3RERVTno5OUltY2JHYlBHZWdjb01BaSsxTDE5L3BNQUJRZzFSOFJvNndo?=
 =?utf-8?B?cDUzNHh2cmU1c25RMWlpYURWanRjdE1rOC9yNlA1bzJIS0ZiS080TFczNzBh?=
 =?utf-8?B?S29NZzI5NThicUc3QXpwVDd5NTMyRmd3c21SVWliM0pjbS91c1lxQ0pyNTlo?=
 =?utf-8?B?ckIvaUZvYURoREtSR3Q3MzRQdDQrUmozazlwSm5udy9iWjhxb2U2L1V0VmR1?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0710051DB164E428C8D23FCBE1718E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eD5EvspLsawFw+bqaVXJIfrZe0pa/CoIpCiDobXAX45FAtfnxs90+3vUOxCSA8Rej+yLwpetJSeCwkv0PQfNUYfDeU2YUGzVu6xfHcuhqFsONjerxAKwdhZ+gdDiTJK0e+Fi12tkcAQTEqCqY41ZbEzHalLYQW2lGZhQ/f08VKc2JlN3Hen2A52naXtBaKoKoMqIvulpAGzdDWP8sKZ+UjBuX233vFe/s7lgXCQw/TjFI7m9zV2m24/CwG3jMQsFTIhRmfrgFdDrRQy25l6Ia13K1AZPxZmZx7TScIjt9sp+boRAwi3jz6h+O7rxR2ycAa7ueFzRm7F0b4VR3EqqHxHd7c2REaVXRg7ngR37CShd4A8pgqtxuO8XTXQGVabISAToy3OJti15rzqoa+0WnV8SPXN66Pj+QFhc0avBIWXAWOoZnv/1AEvTsqV27KvvQIvUcD7pMvB1ineYtTfx5NOAYUtiou9K992DseGHOXDS4xFJM68EI1YIFCLi/m/g5+T3iP84fjuvsQeMs6JiZVZ9ynREfCcDN3X8nA2qa+w2vH0mbXMfvbGVfyeqsvvHOe1bKgCRnZjUL2B0svgteJi3lWX1bzUVddiVvnDe3pSqQUmOyDk+wZiULz9ugRYq5VE/6oQFRVxXjQavHWBTjA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aae616e-1865-4328-92e0-08dd162b086e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 19:20:23.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDf3VXMgGtTkaPvmK4Jf26Lo11MfkYw4pUE7hCIpRaOutx3onFZJ9lyeEg59nrBDtNMKGdplPkvqYLmX0vi7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Authority-Analysis: v=2.4 cv=TP2/S0la c=1 sm=1 tr=0 ts=67534e81 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=KKAkSRfTAAAA:8 a=BrFl6TuqtGTMEFRHkBYA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dL1mhtG4IP1_tSmgMqAxtagyptDAeneE
X-Proofpoint-ORIG-GUID: dL1mhtG4IP1_tSmgMqAxtagyptDAeneE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060144

T24gRnJpLCBEZWMgMDYsIDIwMjQsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBCZWZvcmUgd3Jp
dGluZyBhIG5ldyB2YWx1ZSB0byB0aGUgcmVnaXN0ZXIsIHRoZSBvbGQgdmFsdWUgbmVlZHMgdG8g
YmUNCj4gbWFza2VkIG91dCBmb3IgdGhlIG5ldyB2YWx1ZSB0byBiZSBwcm9ncmFtbWVkIGFzIGlu
dGVuZGVkLg0KPiANCj4gQXQgdGhlIG1vbWVudCwgdGhlIGR3YzMgY29yZSBpbml0aWFsaXNlcyB0
aGUgdGhyZXNob2xkIHRvIHRoZSBtYXhpbXVtDQo+IHZhbHVlICgweGYpLCB3aXRoIHRoZSBvcHRp
b24gdG8gb3ZlcnJpZGUgaXQgdmlhIGEgRFQuIE5vIHVwc3RyZWFtIERUcw0KPiBzZWVtIHRvIG92
ZXJyaWRlIGl0LCB0aGVyZWZvcmUgdGhpcyBjb21taXQgZG9lc24ndCBjaGFuZ2UgYmVoYXZpb3Vy
IGZvcg0KPiBhbnkgdXBzdHJlYW0gcGxhdGZvcm0uIE5ldmVydGhlbGVzcywgdGhlIGNvZGUgc2hv
dWxkIGJlIGZpeGVkIHRvIGhhdmUNCj4gdGhlIGRlc2lyZWQgb3V0Y29tZS4NCj4gDQo+IERvIHNv
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcsOpIERyYXN6aWsgPGFuZHJlLmRyYXN6aWtAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgMSArDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNCArKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZWU3Mzc4
OTMyNmJjLi45MzM1ZmQwOTU5NjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC00NjUsNiArNDY1LDcg
QEANCj4gIA0KPiAgLyogVGhlc2UgYXBwbHkgZm9yIGNvcmUgdmVyc2lvbnMgMS45NGEgYW5kIGxh
dGVyICovDQo+ICAjZGVmaW5lIERXQzNfRENUTF9OWUVUX1RIUkVTKG4pCQkoKChuKSAmIDB4Zikg
PDwgMjApDQo+ICsjZGVmaW5lIERXQzNfRENUTF9OWUVUX1RIUkVTX01BU0sJRFdDM19EQ1RMX05Z
RVRfVEhSRVMoMHhmKQ0KDQpJZiB5b3UncmUgZ29pbmcgdG8gZGVmaW5lIGEgbWFzayBtYWNybyB0
aGlzIHdheSwgZG8gdGhpczoNCkRXQzNfRENUTF9OWUVUX1RIUkVTKH4wKQ0KDQo+ICANCj4gICNk
ZWZpbmUgRFdDM19EQ1RMX0tFRVBfQ09OTkVDVAkJQklUKDE5KQ0KPiAgI2RlZmluZSBEV0MzX0RD
VExfTDFfSElCRVJfRU4JCUJJVCgxOCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDgzZGM3MzA0ZDcw
MS4uMzFhNjU0YzZmMTViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQxOTUsOCArNDE5NSwx
MCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9jb25uZG9uZV9pbnRlcnJ1cHQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIAkJV0FSTl9PTkNFKERXQzNfVkVSX0lTX1BSSU9SKERXQzMsIDI0MEEpICYm
IGR3Yy0+aGFzX2xwbV9lcnJhdHVtLA0KPiAgCQkJCSJMUE0gRXJyYXR1bSBub3QgYXZhaWxhYmxl
IG9uIGR3YzMgcmV2aXNpb25zIDwgMi40MGFcbiIpOw0KPiAgDQo+IC0JCWlmIChkd2MtPmhhc19s
cG1fZXJyYXR1bSAmJiAhRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjQwQSkpDQo+ICsJCWlmIChk
d2MtPmhhc19scG1fZXJyYXR1bSAmJiAhRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjQwQSkpIHsN
Cj4gKwkJCXJlZyAmPSB+RFdDM19EQ1RMX05ZRVRfVEhSRVNfTUFTSzsNCj4gIAkJCXJlZyB8PSBE
V0MzX0RDVExfTllFVF9USFJFUyhkd2MtPmxwbV9ueWV0X3RocmVzaG9sZCk7DQo+ICsJCX0NCj4g
IA0KPiAgCQlkd2MzX2dhZGdldF9kY3RsX3dyaXRlX3NhZmUoZHdjLCByZWcpOw0KPiAgCX0gZWxz
ZSB7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGMyNDVhN2E3OTYwMmNjYmVlNzgwYzAwNGMx
ZTRhYmNkYTY2YWVjMzINCj4gY2hhbmdlLWlkOiAyMDI0MTIwNi1kd2MzLW55ZXQtZml4LTcwODVm
NmQ3MWQwNA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLSANCj4gQW5kcsOpIERyYXN6aWsgPGFu
ZHJlLmRyYXN6aWtAbGluYXJvLm9yZz4NCj4gDQoNCkNhbiB5b3UgYWxzbyBpbmNsdWRlIGEgZml4
ZXMgdGFnIGFuZCBDYyBzdGFibGU/DQoNClRoYW5rcywNClRoaW5o

