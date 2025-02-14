Return-Path: <linux-kernel+bounces-515501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1089A365A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BF47A1C61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8F269889;
	Fri, 14 Feb 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRJsfS8+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hbHscFbm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC326983E;
	Fri, 14 Feb 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557253; cv=fail; b=cVACORG0iAZdtykPpCFdqBoIbpRt+VC75tZlfC3ng0GbyauXSd33ZQgW8XGmI4X97Kkk52md1Pg14vr1yU58wQS9DkFhlsxwCTUfMgQ0iWlWAVUdZ45KTVx661U30HrWNh/+lrm/suqzhFcbQhbJIcK4vPEOM7TOFL0kDFaFStc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557253; c=relaxed/simple;
	bh=lSZL3YXhekcMCrk3fDRJdZp1dgFRcW/3BlZ8aWxh/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUtvQmy61wFpnIERl7eRZD3Ls5QfMNr1ynDgGIEmyu2adA8NsCoLKus9oh/jhXcZMSK+wwTpfDiwdojDWiG6zSY2Wb2AJGrvji2DX4CDZNX3D862CpFyKBig+qGhkQyuCvW86q756i2boO71NWjFYaKYMsXMpHEwQw23QctPLAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRJsfS8+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hbHscFbm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBWK8017949;
	Fri, 14 Feb 2025 18:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0g69wTZIzxL2CYKpy5tGk2uCLPDJBRPpcXKFcA/60Is=; b=
	FRJsfS8+gBhzVxOv/5p7lJ0j8BFKV031vGFHYiky7gSWLdF+51zRD+jWB8uRoec5
	3/CzjHRYsxB0gDmb/Ktb/d0Du/JBRIAG69OA8knOAd75n0kXffc6r+ynFutDDmQo
	Dqj24MT5RGZpPw4+I0SF8P6WloL0PIDBgzq0kq/rUnJZzbojifiyMcBXQi5myxKX
	x8wApRsM1gfFz3fSr3nPU1AAjcZMfJ5bCi0wHI+rQny/GQ7pN/F13XLb1M+WOXI9
	mX8Hl4d+IrWFwu2OXTBmtwGDe8/KHuzilRnbkD+8cUKO0+CoP+0pmBetx8xKxmpw
	BaDGmwyVoOqq1DtSj5GF0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s447cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 18:20:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EHR3Qg009081;
	Fri, 14 Feb 2025 18:20:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdgc1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 18:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uid/k4zOQu5AeMI2irwHydoXY/uDVMatXJJ+1sWeXnx7+mkrXKTtpxM8W8SIEweDGHtm8FDAHPQZezDNfJtB4m5gfIMpt4PFG0WF8C1iqoZDeypsF3ZLIDk/klmkJuF9dVxadh1IMKdFDfVcVQaMBiL+DLw4PXEmb0dKXURy1zIdRqWnepJed7Qg8S4BDnFkwww50GqFMriebrjMj1tu5jYOpz6Rzr60y5kV4e/HRXTDB8RovVPX3k0iLr8X2ARVmgA1IojXsOiLoyshRM4RKf49SwMEv0xlBhwT5zNJK98nKWU4KtCbe5ziTbghi+wEKAkb1c1/TQEPUN+MfL3QSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g69wTZIzxL2CYKpy5tGk2uCLPDJBRPpcXKFcA/60Is=;
 b=EBjZewMDLj0YE/unbzPBlDDDWKClUSw6YGx5dzPx3N2sh5oxkUeVtJAVZz1d1BAECEjl4x+snxljmI7UzsusK7QBHGnQ0isnD+wyy1tEXZQd2Jut845fs46wEuhhrEL6vqB6nXHXpgWY82eKo566dCM+3F5x2um8CIL4Sip1WV4ZrobZhWAslvbjjgCBESfr/FGnB5QJo1kQKDuIEc/HN9lb5Ti6HiMobDAbNTTNwg56kGI+poWl2bbnMQul3EBIcggakIPMJPNn9We87p3V+sR9DI+VQOPh+cbTLURBZuG0Ftgs/0qekYTW7+iFGqw1rgUx9RbhZ7K3bE7ByH3mzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g69wTZIzxL2CYKpy5tGk2uCLPDJBRPpcXKFcA/60Is=;
 b=hbHscFbmbH1zuown1MQzprQr6PJJ2D1sVm+5bwjM/927f2R2a83eQMUdNPrdBImJBcclux3PKOFG3n2kqkV7wPmCehKQw4E31X8MDKmy8/e1n8Qzo3dvxMiVkfugYBxqQdWId3K0PSjCBmQFKXbMvh2fH+aiFypuHj5yWvJtelo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 18:20:01 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 18:20:01 +0000
Date: Fri, 14 Feb 2025 13:19:57 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <qcktrgq7armtvbjepzxvajoky4q2fr3nnfrvk4y67y76m356xb@ayb3bjkv6miu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Balbir Singh <balbirs@nvidia.com>
References: <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
 <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
 <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
 <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
 <2iypqaa3orklplwec4k5n4nuuov3gajtkiv2nt2ce2s2b4e7gd@7y6cmwrwr5te>
 <CANiq72nBDEOSuSNTGKGA5xQrs3ZFH87ii0OAdhJq3rqtOv=dfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANiq72nBDEOSuSNTGKGA5xQrs3ZFH87ii0OAdhJq3rqtOv=dfQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a34c12-42d9-4004-ea6c-08dd4d243256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eitaWG1xcVVsaWJ0THJKZ3QrZkdOOU1GUlQwTXBIMXc1aCtaMm5sUEUxNXI1?=
 =?utf-8?B?d1Q0MVF2VElSRkEyOEZBRXRYK1NVYU83NGlvSzVTekJJZFUzN0N6WGZxQ1l4?=
 =?utf-8?B?eTFyMkVOZUJrRUlocGo1NFZuSE10dmRqQy9UUUdnM0NTczBsTFNxSWtja01I?=
 =?utf-8?B?L2w3RkJ3SmZBd1psWEVHQmVGWWt2bEJTZFJUczE2a1VlZVZjb21MTWF4SUJU?=
 =?utf-8?B?UlVYNk1oQTdLa0ZnQzFqNDM0anhvZDdmQmc5VnVRZ2JLT2VEWGdCbnEyV2pE?=
 =?utf-8?B?V0hEd3lwcXhqSDFuYlNKazRnRzVmMnpJczdKZ3MxRllWalpUUmxuTUdFWU9w?=
 =?utf-8?B?alh2VllmT0QzaHhCTWlEeWU0YU1lbWlQUnU2UWc1SlY0WDQyOCtuUWpCMGJj?=
 =?utf-8?B?N0xBaVEvWXlZSHVTVkRBbHhieEY3Nzc2dGNleEtJbENkbEhLQnA1TDhSTjVP?=
 =?utf-8?B?aEZUd01yWGN0eGc5bGsxWXRLWUF3V0tQb0svdEFhWEZaeFNmQ2YrazA0ZEJm?=
 =?utf-8?B?ZWhtL0N2T1ZTMjZaTXNRWHpqZkgxVU96VEdFM0ovT2N6MkNJa0RkWFF2R1FC?=
 =?utf-8?B?bGVLcU81L3hZZEpkUnFiVTJRcWxsR3p3QUs4ZWVhZFJIL2VVZmdTT0VxMlpK?=
 =?utf-8?B?V3pFNklWRVhqM1J6clR3eHVOYlRVUVArNmZlUktxNXcyOGV3anUvSHRwNEJl?=
 =?utf-8?B?ekJHV1BJck4veUhiQ1pOU3BXMHB0ajVncWwyRnp1aEtOWkY5Q0VuTUFFMFlU?=
 =?utf-8?B?ZVJTMmREZ05lNkVEU2dYUU9nVzc3V3IySUl5UTdyMlQ4bG5qQ3FOUGdLYldC?=
 =?utf-8?B?TzZSdWRVWWlHSHNuQzVzd0Q3OE1KZmdtMVgxTGc4a3N4ZjAyQnMwTk1zdW5m?=
 =?utf-8?B?bDZYbmM5ZE5wTDFmbUtqY3RhTnRCZlJZbitpbFg3NVBrR2MvemVnd1JsUHcv?=
 =?utf-8?B?clNDSG9UcnVWU3JsNC8relF0VDQ0d1lQQ2laVEJydElORFVPb0VrTFZPakFW?=
 =?utf-8?B?NjVOWWtqSmd0SExsa1lUR3pKS1c2MUpaS2NnRVNaQjFIOUVVUktEZTA3Y1V5?=
 =?utf-8?B?MU8vdDVCVWhTa1pLUlhQcXllK0g3RW1kOW5yTHBBdURYa0IyOUJJQ1Q2bFM3?=
 =?utf-8?B?d2o2R0tseCs0QXJmbGJ4V2RhbHF3VUhDaVpBYTJIUW5aemIzZEJzTXBXTHpz?=
 =?utf-8?B?WG1zTXRma1dIQUlxZUVLQ0RtM2FIT2NRVEFUQUFqNDJsQU13MXNKSTdGWEIx?=
 =?utf-8?B?SWgrWm9zdXlpa2VkUkRIMHVzV0IyL2dXTkJZb0tEMS9xYisvTDBTaDZLblhw?=
 =?utf-8?B?TGQ0QnIrTFVyWVpoamZlK0IySFBQZlU4dWR3UHp0akx3QmNVNG9rcXV6dnRL?=
 =?utf-8?B?b3p1K0RBaDBqT3YwQ1lkaTdJbnNWR01wZUp5MjlEZ3QrVjdkRnRlYjVaN1c3?=
 =?utf-8?B?T0pycDNNQllWQXdxdUxjNEdDcHZ5NXdGRWphU2ZjZ1lyaktpb05zVGIrZy8x?=
 =?utf-8?B?UlR1ODhIdFF4VmRiankvNUphTXB5cjRJSWgzQ2dWUWpSaW5xQUhlZ0gzUkJY?=
 =?utf-8?B?RjF3OFhYeFVuby8zT09zS1FJM0RySG9OczAyZDRoSjE0RzVzZ2VDSGZNVjRB?=
 =?utf-8?B?b2ROV1hwcG9SbzFrNk9TWm5Fa2lIZHN3TGVBdkhpOWlPb0lLcFY2TDZTMzBO?=
 =?utf-8?B?cGc4bFJmWUdNaW1YbVZ5aFJLL0dQend4QVZ3QzNmV1lzWTRpdE1FM1pKaHdu?=
 =?utf-8?B?ZXlmbFZyNjUyS09XRXh0SjE3MVZISkRrQXk5bTNidXZrMUttUWViK0J4by9n?=
 =?utf-8?B?VFlXYzRvUzVvZVlZQm1wc0NkeFhLRXE5K0tVbmhzWUlqL3BMM1pVZmJ3QTdQ?=
 =?utf-8?Q?DYrjsvCgKg+Pc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC8zWXZPaFZOcFlWT1dYWVJaU3I4RnJjY1Z6RDVxLzFZbGtIQWt6OGUxalN4?=
 =?utf-8?B?SlJsZWF2eTFXOXRmbGJIRWNaU1h3eXlnRFpWVnl2RmRrNTdubkZLVGdYeXNp?=
 =?utf-8?B?MHVvNjlZRVJqclJIYmpYRnNpTVd6SFBQTkNJQTU4dlBrY25tbk51dmJMdjla?=
 =?utf-8?B?L25Ndmg3TXpiREFZS3dNQ0RQSlQ4bzZuWUdFNnBXSTJSSHJGYXBPNFhsekp1?=
 =?utf-8?B?WmJWYnJZZlRaVytQQ2lxZkJCOUpsOUsvbEpkbVlreUM1bFhzcHo2eEM4Vm8v?=
 =?utf-8?B?dmZtWGFXUGJadWpkMm9lWHErRFloSW5UNE1PTmFnR3FzeWRtZzhyQm1jMUR2?=
 =?utf-8?B?QlVCSkY4S3NGd1ZDZnR4bkRGVlg4REF0OUJkSTRVK0R4VnN1ZFhQM2cwZG1H?=
 =?utf-8?B?V0Y3R3BTb0s0RDRyOHRqRTZGMjgveVMwRTRnZzhmWmxqcnVmT09xUm8yZXJ5?=
 =?utf-8?B?QXFZU3puTmV5U2loZXJVQVJFSkZxeU03cHNqWW5JckZMZHBpQlBVYnRNaGhI?=
 =?utf-8?B?SlNORnN3SlV6ditlME5pOEIvZytzZy9NcHVLeU0xN1ZJdDU5N055dnlWRm1x?=
 =?utf-8?B?WFhYT21reElWVEhmbXdxWVVIdjdWaXd5ZzhmcWREdTIvcUljaFg1MDl4dU85?=
 =?utf-8?B?QXFtNWhsanpOTWVJSTVHYUF3UUtGT0kwa2pQdFV0ZDJyYjczaTJMVEEvZHJv?=
 =?utf-8?B?Szc0K0M4OFhPd1ZWLzU1K1RUMkNwQkRpMVZ4VVlPTlBDZVBJei9xcnFQbVlV?=
 =?utf-8?B?bEZsRkVRQ1RKSUdOY2kzZll2VVhPZGhwQkU5eXM0QmdQOG5HSFRsU3d1d2pl?=
 =?utf-8?B?aXM4ZnVnZ3dBeFRWbllENSt5YmtNNTdHRWQrU3pTYUdUMFhZTXlCSk1oT0dL?=
 =?utf-8?B?dzl0MGNQUnZqeDNRTWs0MlU5V1NuSU9paEJES0loY1h0bmxvL3JTdjRsbXpu?=
 =?utf-8?B?WlgvTFdzYkRXbjFWNjJwOVFncjJEZzFJRjdRajJETzh3K2ZyMDd5emFUQlhw?=
 =?utf-8?B?QWIrYUwwTk5kUk0yTWZOMm0xU0dVZk0xZFlOVGZnMDBLb2RLWEI1aG8vWFJD?=
 =?utf-8?B?R1lxRDhwZ0xjamFEZDNoTHA4RkNPc0hNZUduQnBqY2VHWkxmWXF3aFRsV3lM?=
 =?utf-8?B?bDFET2xiVE5McytLemhtR3NWbWhWREhVWnZFbG9zYXVjSnA3R0NDRCtIanN4?=
 =?utf-8?B?dTZiTDJKR0dMaHduWk1RNks4Rm5IWEZzOUZIV0tMMTI1SU52aXc5a2JCU0ha?=
 =?utf-8?B?U0FZVWxXQkFkcjVVWU1UdFVmSEtMbC9KRThTMGRKWmVOWkpvTDlpampoWGpC?=
 =?utf-8?B?NUY5c1JCZzhjTlNoTFR5Qjd1S2szSmkyN0s5WWI4bDFnbmVBem91UEZTanN0?=
 =?utf-8?B?S1QyLzNGMlhzUm1uTHdHZWtnaWNSTnh5NlpINjVLRkkvZDFvbHBqNWRoYzZE?=
 =?utf-8?B?SWo1VHpxSXZqZzRvTDZEejZjaC93N2ZBcFYwN3dxUHAyQTVtWDZydHN2RVl3?=
 =?utf-8?B?aHNBTXptenJENHdJUVRhTk5jb1EySmZOYmNJRlQ2TXV3MFR1UjZkcGhtOFBK?=
 =?utf-8?B?eHJCeDdnOWhRNVRnbXE4MzA2dnROTkxiaTlxb3RjaDZiV0Noc05OeGVCazNn?=
 =?utf-8?B?R2VlTXg0L2FlWWhnNDVjMHg4OWphanAvVHJDU3BxTHVaR2V2VFBsT2lwY3hB?=
 =?utf-8?B?NjVaS0hwTXpIRHZzWjlWMGlYWEQ4eUFJQ1ZEUXpWVHZ6MzhIRW8xTjZEcUd0?=
 =?utf-8?B?bzJ5bjFTV3RzdnNvMXdCb2R2bGloMFU1WGdUY1A3ZUZZdG5qYUUwbUE3R0tB?=
 =?utf-8?B?MTJCUXg2MEhON0czSXhxdXM5WVJyTVZhdjByRUhxYUhLTTM0QXdBS1ZxcG5w?=
 =?utf-8?B?OEVTWGV2dk51cmtQSEdlbWwzVDcwWmJIVzMxc0RVbzI0NlpjV3lleDlib204?=
 =?utf-8?B?MWZuOGhzT1YwN3pRR1RsQXQ5KzVLMkNNTFFmNktQK0Jnc2VEUkRNazZiSlZn?=
 =?utf-8?B?M0tmNGVjM0p3bytGVDBBKzdOV0UxcVl0QzEyR2VMUk5KdmxJR0d2TXZpektr?=
 =?utf-8?B?VzRCVW9tWDI5aGE2bzBPTXhNZ3hSUzB6WGR2UnEyd3BIYjZwMnNhWUxqdTFT?=
 =?utf-8?Q?TvoUoWznbwp5F3wat/yY1pUya?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHF6K0AOvQOfw4LlSf39+odxChVqq5UIbfJqUEWenfc8UlQ1W6hzNPyRGmHC9TQ13MOwfrq2ebaTITddYIOa6gW96Fi2RFeVtulDmcly+/S97cstobW1cd9zh0wiX3xbTNjQhYdm9CnCmQjhlX2LeQ9kuC8rYdIBxKqgFvZV4iDVKK5c4zcLUYBrOqdxAJwoKm7UEtL+1+4aNM0OBVfFCpr95wvwg3h1ZJ+mMosFjnDgRi5ZwcxGjElSPe41b82V+VWaa6yAynxw+zYb1T5TaqjyqeWX02nNNdBLVjvCCqammmdHS59xXl5SDg2EhAYMDrYcJFg8ezMXsRM8T7hP220pL6cMhBabiH2SfEnnNOfUFjc1WqHA1RZua1NHo1ss3WNMBCY7U8FDtj9iDqCGWItc5Xx6C3G7uIenCfHV0AxC+giOMem9rZ0+0xwpyyoa9J+eaetQSaUcKIo+s7F62gaI/zuX4BYHuSKd/gVOiwYS+Xr+Xnj4PCT2YhNuvngs1wLPM0AUIHeayaq3DMdP4EetO/jbXtgfMAQwk1ACzhqKtFxTZlFEguYclhcM+HzJ8VCDVBAznQDa9RI5QY2LneOzsxNOq/6iPX2pGm94zYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a34c12-42d9-4004-ea6c-08dd4d243256
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:20:01.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDJSLue5OvvQwgTOmNlqcHroq9oYD6l3PIt8dtj1Ra95tA1iAk5mu+06mHA/PZaZwzJ3wZgkfDn5wJRj7arwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140126
X-Proofpoint-GUID: Vtc1qyw44ORR0UNoL3i2a_cNhQXbgvbc
X-Proofpoint-ORIG-GUID: Vtc1qyw44ORR0UNoL3i2a_cNhQXbgvbc

* Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> [250214 13:05]:
> On Fri, Feb 14, 2025 at 5:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > This will become more important once we have more than just wrappers,
> > but I think we should talk about what this will need to look like befor=
e
> > it actually happens.  ie: unstable rust branch tracking unstable c
> > branch with build emails, etc?  Early days yet, though.
>=20
> Like an equivalent to the `mm-unstable` one? Would patches only be
> promoted if they pass the Rust build etc.?
>=20
> (Sorry, I don't mind to interfere -- just trying to understand how it
> would work, since I may be able to use as an example later on for
> other subsystems etc.)

I don't know, but I would think if it means Linus won't take things then
we should do our best to know as soon as possible.

>=20
> > I am unclear how the branching/merging happens.  When do we need to
> > start (at lest) building the rust side?  We've been doing a lot of work
> > in the modularization/interface level to try and integrate more isolate=
d
> > testing, as well as the locking changes.
> >
> > Do you have build bots that will tell us when things are broken?
>=20
> If you mean on the Rust side, I just wrote some context on another thread=
:
>=20
>     https://lore.kernel.org/rust-for-linux/CANiq72=3DYy8e=3DpGA+bUHPZhn+D=
66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com/
>=20
> The important bit is:
>=20
>     I regularly test different combinations (branches, configs, compiler
>     versions, and so on) to catch mainly toolchain issues and so on, and
>     keep things as clean as I can. Others use regularly the Rust support
>     for their different use cases, thus more testing happens on different
>     environments. In other words, things generally work just fine.
>=20
>     However, our testing is not meant to catch every issue everywhere.
>     Like for anything else in the kernel, whoever maintains a branch with
>     a particular Rust feature needs to set up proper testing for that
>     particular feature and relevant configs.
>=20
> I hope that clarifies.
>=20
> Moreover, there are some bots available that support Rust, e.g.
> Intel's 0-day bot. I am happy to put you in contact with them to see
> what they can do for your branches.

Thanks.  I don't know how the majority of the mm people feel about this
stuff or what efforts we should make.

I don't want to hijack this patch set with my questions and I should do
more research on it.  I do think we need more discussions about it.

Thanks,
Liam



