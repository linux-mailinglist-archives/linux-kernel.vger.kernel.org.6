Return-Path: <linux-kernel+bounces-572732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAAA6CDDF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35640189BBD4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85301FFC4C;
	Sun, 23 Mar 2025 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c2Z6nfFC"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE34172BD5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742705908; cv=fail; b=Xo2/Zt0ihTYHJ+fNLsTEPQGgWU7c3ROCefspsA57xbkEM2AbK6xAsi1VbNYi+23pyrD1SW7FcjkpG2IUMbB7Hqg2FlG/Y9UKp8VuPYAE9seVn+Xi6dde+ofZTFWpxEHnyA39bWehtv6w25jxLeeYmxZuzclH/nxxu8Lcrs4EYpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742705908; c=relaxed/simple;
	bh=pboLMaqhYRt4l7C2lQOAF/50JHB3y8CL0H1DMiCti4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=a4fqWHxI47rgHpM/P/bVz8yjzdbOR6ad9zNqVPyjztJGz42B6+o2Z74toJXgWaUYJipRULPYcefoN5SQusopZIBgk8GAK109a/nOE7GuW2bOu4g7gbGq7CNEkR44Gmpqv+PMuTqApyCEVrGDAmCuMCuXtSrYyTvcAo6qJQ6qw3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=c2Z6nfFC; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N4uBBa018744
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=QCpZOXSQRwTEfGUqvC8rarIVOza9cYv6lRzZ/o57fAI=; b=
	c2Z6nfFCbNdBe/c2SW09OGq+/QISCA26USM6gepCHJZbmx2bksvYWIJEis9ta0A5
	VAJUxWGehEcQxVjamALh9T15BjLjL7mZZ2AAHzwjgvDV3ypvA3t+96FMf6qPMtzZ
	bZqZEbbDxZITBv6B/c6AVAA/OYT1g+VJrQeQggKlKXInELLRRA9wXiqiGjGPHu87
	KR1Lcpbqgy208RO2GFtIrPoP5X4nkbudaD1nXWiFrJtir2HMIs977VAdhfmS3CR/
	zFU/adjSQa1e2cH6XmS4YAOkrKD/xs2MPziDDITh+gL055+OdPLkXtF/hnNZOtN0
	YFl//I2Ia5pCyCrHWcGvRQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45hrhc3fd3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaxmLAKia+bhS/lb6t5N3B466KkeDjEB8ffY5w0dYUEFI3595x2yccg1pLCzDI75EkdlVKkPz8oigXwD9hlr1ZLN1whHaRB8BOkw0IAJ4VK+gBO5TdO5kbkvOj9dSL+iuEQ/ZyLMu11rMbQ4gIAmZ6mJkGxhRuLjiG/X93o/L/Czt6H4uCy2Z0W0B10mNvQBAMNwb2SI4qOWvhx2KSO1PG5m6Mn4XJzpkI21Y12aeVlvFnD2+FZsqVy5MzPpj47de0aaMKK4E9U+O8Peuse2R5R7GoCt326TnGzrT3XeenkRbuDQqy8W6zLVrmbYaW+uFv6EEps8Lh80fKmYA+PX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/bNgYuKzh+9mvhxGTaqtnHf6XmUleMmFydZEZHzmvI=;
 b=s1R9LlXlfw6Z/BvKiErebbHhA/NgClXvJqLNgeJfq/gnrjpYPHU3K2GO30xa0MPF0TtNLahLcA7OYho+vML7Dl5p8FxLNjFYOB+InYTC7TrkLdnm9BGmBOu5gq69WBaLOt1y6/qJlflG7hRc4aLylU6wrIDu29lHvPcd5JF8qoUvKkWO3NlB9pI1wO+injoCxBpKo2692rN/KCcY+J6+D5eCoWPIomfeXOiDy+nGtkLxleuiiv3gCjvjokdeOlG2oVDXqdrYK5PWHFNrO09yt0sdjq0LWqxmJ6kG0GmYt665Es3CPJAqPh+TMyzlrko+eATfsUgkGdjffNrJVLYIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by DM6PR15MB3927.namprd15.prod.outlook.com (2603:10b6:5:2b9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 04:58:22 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 04:58:21 +0000
From: Nick Terrell <terrelln@meta.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Michael Kelley <mhklinux@outlook.com>, Ard Biesheuvel <ardb@kernel.org>,
        Nick Terrell <terrelln@meta.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index:
 AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gAAArDlMAAUVscAAA/WCVAAImbcAAAswVuA
Date: Sun, 23 Mar 2025 04:58:21 +0000
Message-ID: <346FD6B5-CB59-4A40-81B0-1C5B5A0A6C42@meta.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z95oip1UjPofpHUq@gmail.com>
In-Reply-To: <Z95oip1UjPofpHUq@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|DM6PR15MB3927:EE_
x-ms-office365-filtering-correlation-id: deaa19f0-c9b0-4de4-d94e-08dd69c755eb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zm56ZjVrNCthbWZSMUVzTGhMajYvYyt5d052T1pwVjZxMFNGdEZtelpPVlY2?=
 =?utf-8?B?RjgvNFVVM2ZFV1N4SU1ZWVd6cEMrb2d5M3QyNGNSSlFOUXUzK3dzSnBYc3dT?=
 =?utf-8?B?SlB0YjU5UDk0TkQ2dlcvUWxQVm9QejhBb1pUSDVsUGRoOTZxSXR1VXVKODVL?=
 =?utf-8?B?YTlETngvTWtFMWcwQm50Q0lzVWgxOTloZkNrRllwZ2xOL1E1RllTOWNOUHB2?=
 =?utf-8?B?WVdVLzMrdlJDYTlkbzVYbWoxSHQ0My9ZZ2ZiT2ZmZXhwc1dNdFc0cWg4ZUdp?=
 =?utf-8?B?RHk0bGhnOFBaYkl5eENucU9hT2dINGlDcS9JOVVRRWE0NldNd25xbkw0YUIr?=
 =?utf-8?B?dmM3WTZBcmRRaGJVQm1mNHRXN2grRWUrQmZXZ2RRQ3h3SWhyWFZwUzdPNlNk?=
 =?utf-8?B?VFY5UlNjWUNWUGRwWVhLclZUcGYzT2hhUTBNVWlTN3ZtOEUySDBIUjdzemRX?=
 =?utf-8?B?dXJ6dXUrTTY4RkQydTJGMFQwT2ZuTmg3eVNLUEI2NUp3Vit4NzJKZndxcUxJ?=
 =?utf-8?B?TzBDaVA3LzBla2hGZzJjTG16RFRTTGV6dFFJRnFQZVcyc0FUZ2xab3lUUWlM?=
 =?utf-8?B?ZlFSUFVQazJuRTRsRGF3TzF5RlpwUmNlWEJTcStBMjVYTXVwcklwYVpWR2tM?=
 =?utf-8?B?ODkzaWNuV3RiK0VsMG9oeHZaOUlBeXNNNjhDWGFRbkxQenRIclBNNHdlYzB0?=
 =?utf-8?B?djB5TDZQRXU4K0R2WjE3UmdUMGhHZE9qZk5LMEtNTXhwWVJCQzRKMCtDS0J1?=
 =?utf-8?B?cnVtRThJRktEd0dQOW5maHB5b3pSVHpDSE1DK2svV25qT3F4em9tbklLT2dW?=
 =?utf-8?B?WmVSQTRRR0d1QklHdXo5WEpiTktEQ0pzYUxYUXF0L3pEZHkxWG1JcHREcVBM?=
 =?utf-8?B?MmtxdVpHbmlSck9KNTRYZXVSVHJGS3FIeWZTby9yNCtSbm5RbVRSMVF3RUlt?=
 =?utf-8?B?RkpnNVdqL3dBTVl0ZUVMZTFmcExCcTRkTUtPY2crZkNuN1lHSEdCL05mNXRH?=
 =?utf-8?B?cGExTlFEQ01XbGNGMWRQYlFTNGlISHpWWjM3NEthUFc0bXZ1a1NwVkFLOXQ2?=
 =?utf-8?B?c1dHcmMrNDljODQwcUtKZEswclNOaVk2WXJHSkdxbGtFRmtCeFV2SXc1ZFBo?=
 =?utf-8?B?QmgzS3pOcWMwNEdkZWZFNFhXZGhzZTVENFQ5dFRuZjE1RVNUUWtSak1HL0lw?=
 =?utf-8?B?VEhIYnh6ZFY3RFNhWDBZWGk5bnBqYjFzbi9yU21nemMzQmJoaE5oanVRdUk1?=
 =?utf-8?B?WktpOVlyYVFJZzJNdEE0SmxXMTRFL1BLRXZaYzJLWTdnWXRhTFByS011WmNi?=
 =?utf-8?B?MlFFeCtTUWtqVUdqTWtHdTZBcmlsL0FBNE5GNU1ySWtCQk1aM0pOaHZGOHI5?=
 =?utf-8?B?cUc2WENUMGFzYXBkTHhoUS94TzVhamwzc0dUdlNxRG5WMG9iNy9GdDlPWGlB?=
 =?utf-8?B?Nzh5ZVRvWjh5MXdRK0NWVVc4YmdXbjdOT1dwQkdUejlJU2lBVEFuQTRHdTMz?=
 =?utf-8?B?SGg4amZ2bHBNY0JPNmoyUm9aak96cTlDcFE4S2FmWHBtRk1ZT2tLTlJPQmQv?=
 =?utf-8?B?RmVnWDBNb2VDa2FkbGlDWjN6cldHN2p2aW9VOU1PKy9sQlhMSFF3eEFYNU9W?=
 =?utf-8?B?TlpON3V1YzZqVkNmMEFZQWgxZ3JLZEN5U25GL2x2eDZtc0FVKzU5bE8ydXlu?=
 =?utf-8?B?YSt2dXNzNWw4Qk1ZSkNyYkZiNS9MQnplTittUE5NWGUvUUp6UXNleGxqaHhw?=
 =?utf-8?B?dVRyelBFZEdNT1ZXTG0yOVNJWnFRNGwrVVF0RUlYRXQ2MG5PUkxpcW5Wc08z?=
 =?utf-8?B?dVdaK2FvcWw1RjZHTENVQk5Sa0pXa0JML1BnemlOajJITWpIbndrWHU4a3p3?=
 =?utf-8?B?bHM4THR2R3lmTDBjOTBDRU14dnVTZUxmZ2ZHRnZnV0hTdkNpalJuWlE1U2Qz?=
 =?utf-8?Q?1KA8TiDC24Jzwc1iYaol+eSq7e1k75dU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkJxNXJIOWw4TDJ0azBSSnVITFFxZVQ1Q3lwdUNzV2VwaGlhQS8vSmhzU3FO?=
 =?utf-8?B?dWMvb2F3ZVFaQUZSMnduVmtBdU93R3pBR1ZaSVkybFhjTnl3bDZUNHJNVFdG?=
 =?utf-8?B?QmVycCtMcHhmbStXb0dKV3ZNaUhiUnpvblYxUGVrcllkUU9sbVdTcTdGNDhG?=
 =?utf-8?B?TmZFcVBDNUoxNWc0dFpOQmFndktzL1hxUGYrR3MvUUlRSThFdDRpZzNpMTk5?=
 =?utf-8?B?NGxvaG41TkRyVE1oY1VPM2RpWEJURE01Y3BDVk1FbHY4SGQzTld2TFpSb1Fw?=
 =?utf-8?B?b2pQOVEwRWZFbUxuenliZi9tYVJZV0hLZnExdGVJNkdaZFJXamJWb2dRRUdW?=
 =?utf-8?B?MGUrdkRNZFdwL1BsM2JmT0JFWERFZG13NkdkZHA1ZVV0cmxvak8ybEdKckdV?=
 =?utf-8?B?ejNRNlpGUy9PeUs1MkxWZ2VEQjRFT2dUOG81N0VBSnFQZzdJeDhNU0VGMFNh?=
 =?utf-8?B?blU3d3hTVk42bHVUQ0tKQTF6QXhldjl0NDVXT0hjeW1SMGdWUUhvWTduUmRu?=
 =?utf-8?B?endsazgzd2ZrbFgvVmdlY3IyU2JITFAxZVJWSlFsbTl0OTBodDVZQTBSTldW?=
 =?utf-8?B?dkZBQWwvSStPbk11RHNyVXhhTTRBOFBmM2xFSWFNcjdiS1RROXA4c0ZQUnBr?=
 =?utf-8?B?bFJXeXJSOUt5Skc3anprTWx3eWxCTEFsYm5LMU9DWUthRm5ZWmdOeXJnSEVv?=
 =?utf-8?B?RDRTVE1GUFhiSGZQZHJJMEVjVHo3NXpmSXlrNlU4Vy9PTm1hVjlMWDhwRCti?=
 =?utf-8?B?TjZpSWhlZ2RvZ2krMUhkTlRCUVZWQk9hSTVpN2RWZjNSY3Z1ekc2STZueVZ3?=
 =?utf-8?B?YzJBV1RucDZmemk4d2Uvd2JGMCsvN3dxRmRaMzBsVGJTWW5aL3J2YlFRbFZ3?=
 =?utf-8?B?dVMrMEtKbm4wanNRTE5pQXVMRFk2b0J4TUE3Y0JCdG9EVUo2UURYQ2YvdVEy?=
 =?utf-8?B?Tjd3SEgvaEhwMjB6b0JiWjZUV0p5SmM2Vi9VY0hnYmhMUDhNNW9XQkxOZllD?=
 =?utf-8?B?RzNCalhLcVVJSFZ2R2N6cnRwYVdHY25IVjZOSll4LzZoVHZyRy9walZxM3l2?=
 =?utf-8?B?eUhTM0laZUFhdDNCUXkweEtiTzBtZ3pRb3JUUno2a0N2RlVBZkI2UFJOVG02?=
 =?utf-8?B?MjNpVWtVcGdDWWErdUVhMkQxN2xVcVFEcDBVRi9wdkdUNTVnc0lzV0pUT0U4?=
 =?utf-8?B?RFFsTTJPUTV6MzlrdlFwcTlJL0cyUFRyYTVSeE5ZTE5GaGJnNTdkbDIxZmI0?=
 =?utf-8?B?eXQzS3VTUmtLTUQ3VHV3czhpSStXcEIxMStQek5ETi9sOTZ1bTMxRlpIRzZS?=
 =?utf-8?B?OHArbGFXZTZoRHI1dlJXWG1zR0Q1S0RuaWVSZk85aEpzRDNxVXNiRGo1MDZx?=
 =?utf-8?B?cmVGWTFCVTIzUDRMNEk5dHF3dVJVKzlaSlZMaFR4bHlLR2FRd2ZiWUFURHNV?=
 =?utf-8?B?VEZ2QjkxcXFaV0dTTzVqL2VtMVhTVDh0ZkgrYjlEWkUxSXhDUVdvSjhMVXVy?=
 =?utf-8?B?Q3lpMXg0bDVxMi9qbWpIZTVZa1NiWjZzQXU0RGtUdTF1bTdrYlZYS2dNaXB0?=
 =?utf-8?B?TUxLaW5jQk10bjB1a2RDTGtwZ0tTM01zbTBFNzk0MjJCRm1wWERSZkJmRnlt?=
 =?utf-8?B?QkxtOW43N1FWbjMwbDRES2liZjc4aXdCNE5VVytQTWU5RHl2TUk4ZmNQV2F0?=
 =?utf-8?B?bXdzTU1McVk1ZDBqVkxRUEJtRWZycWdjSjJNL2MxRm9HVi8zQWF0MG80dm5v?=
 =?utf-8?B?M01JVHVUYUlqdXVPV0U5cllQYi8rTUE3QzZnY0VFMk53YXF2bFRBN29kNVR3?=
 =?utf-8?B?U0cvWTFIVTFQMmdKNzdzQ2o2MTlZVlZ1cU42M0kxcUlKS3lLeUp3TDlLZS9G?=
 =?utf-8?B?NUNNMy9lYzhKR0crcG03TTc5SEhjQmhEd0g2L1RaNTc4cHpMam5KclliUjF6?=
 =?utf-8?B?Ti9VZXp4Tjd3S0Z6Y3d1SEdyKzRReHBwSGpYc2hYUlg3WWl4V2R3M2xaUnVa?=
 =?utf-8?B?ckFteEwrQ2E0RkFqZFZPMFZQeDZ1Yzl1ZTJuTkIvTkpCR0JSdjFicnZ6WW9E?=
 =?utf-8?B?Q1BkV3R6Z3huZkJ2QmdDZ0hXb1JSaXBQOTBKeXJpbVBpN0pJbGRIeUNFMU5I?=
 =?utf-8?Q?VRL6WhW/Y16NhRAt4u/dn1kOR?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deaa19f0-c9b0-4de4-d94e-08dd69c755eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 04:58:21.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvRqqafl4Zx3vXu/IK6l1ve23A2wYR6ZGFSYGJrV/vzs15T0Ni+2m1Idj69iYA93kX8hEKShSqR4gZXNeIGVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3927
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <2B227C56AF4ABF4FA206DA641747D6C2@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: erR8_Q0jfjWs4kTAiQBmdNru1oR8PUJi
X-Proofpoint-GUID: erR8_Q0jfjWs4kTAiQBmdNru1oR8PUJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_02,2025-03-21_01,2024-11-22_01



> On Mar 22, 2025, at 12:36=E2=80=AFAM, Ingo Molnar <mingo@kernel.org> wrot=
e:
>=20
> >=20
>=20
> * Michael Kelley <mhklinux@outlook.com> wrote:
>=20
>> From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 =
AM
>>>=20
>>> * Michael Kelley <mhklinux@outlook.com> wrote:
>>>=20
>>>>> What are your thoughts as maintainers of lib/zstd?
>>>>=20
>>>> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
>>>> in gcc 11.4.
>>>=20
>>> So the patch below would work this around on GCC9 and GCC10?
>>=20
>> I've confirmed that the patch gives a clean compile with gcc 9.4.
>>=20
>> Note that I confirmed yesterday that the gcc problem is fixed with
>> 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
>> if I can get the original gcc 11 release and try that to confirm that
>> your patch has the right version cutoff.
>=20
> Thank you for the testing!

I've submitted that patch here:

https://lore.kernel.org/lkml/20250323050749.165863-1-nickrterrell@gmail.com/

I've merged it into my linux-next branch as well.

Best,
Nick Terrell

>>> +++ b/lib/zstd/common/portability_macros.h
>>> @@ -55,7 +55,7 @@
>>> #ifndef DYNAMIC_BMI2
>>>   #if ((defined(__clang__) && __has_attribute(__target__)) \
>>>       || (defined(__GNUC__) \
>>> -          && (__GNUC__ >=3D 5 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ =
>=3D 8)))) \
>>> +          && (__GNUC__ >=3D 11))) \
>>>       && (defined(__x86_64__) || defined(_M_X64)) \
>>>       && !defined(__BMI2__)
>>>   #  define DYNAMIC_BMI2 1
>=20
> Worst case, if it isn't, I suppose we'll get followup bug reports.
>=20
> Thanks,
>=20
> Ingo



