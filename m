Return-Path: <linux-kernel+bounces-239859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329C926627
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DDE1C220A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D421822DF;
	Wed,  3 Jul 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fwUeb0Za"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB0181D0B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024248; cv=fail; b=Z4aArWGmMIFw3kTu0ere4d2GynCXLFMWyQRrh1AbP75OoaOdYjQaxxGIXBkR6FphnsroA/Qiwgmb+FNCOmP5EXp9ZPEQ0dtVy589vnOy6HK5WqztwTQMuHQxtJjlO9Bs6cgRAw8mhJjydLGRQ/VC9a8LkOckjjo3kmHFYn0RdWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024248; c=relaxed/simple;
	bh=AKVO5DLg59XrLj+aUN/fEWyYFQaS8NYJrqTH42mTA+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=I1H5RpBwLE/PeAgHQCmvHGh/CGSDVyB5w5CFRQITLPBdJ6JU8Zlr7eIYXvVhrkarsFiatF+sDsLCpRYcnGiGDlqGVIaIimAEOuRA8ir451UZNQIG88b7adXxEX1UNKO2nm9CewLX4Hh/MjeXkk6GvqFwPKtQ2j5hZWDSQ27mOhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fwUeb0Za reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638jdkN004433;
	Wed, 3 Jul 2024 09:30:37 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4053du9v01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag+tXfLfh3nroUIoh0hsrwx6BBFBUKK7iOTN++EP0chXcPbajMg9HkVO/rK536/63+DuRTGlJHXt4VxHQaW/dzQwYXJi4HLlQD5dyrnpGTvNgGWSiH59igwHSJAljtz60IsXwbULnpy2/pjn2NUHI4+f45yo7nkYBQ7TKvePoF4aaOr6JqCaVjcSlnFVDKuUl01Y+RX92MeOMmwsRFaImlBOIjUZ5cHoz4sYSotrSgalrX4TDnTtj0xRjcdNsaFhLea1/21ItyNHxJ7K+cZ0nGcn0H7oD5GUGhMD6waefEOq8kN0/0Hn3aIyq6r6iL3OWdp5S6vSeBhHWX6w1x76VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7JUMBjIVIxV47QJblAF6E3W/iQHaktd0VCJFdDIvcA=;
 b=WlcZ4w98SjGK92//t1cPrBIL7Dh2h2dKowChylz+Q0JTRi0WX6WgvqjEtuZh0zTabUX6nV+QhBWFK2YxdGVKSqXb36uvLj+BmbVIble3b3Yt63Fr50QQERyQ9Tg2e6gUhKO1rjqt1EF7xWp8hHTPgxt6pr5ppPB1/2en7l66bXgTA+hR/B3h33oGRmtGefvYcjzFl10oRQvnB3lCCPER0zWrQxD3NuIm87RmP7KBur4piAggmQtWVO/vjYt0jRgjykLVWw+f2UMX0BNDa7mFOEDWWy7V8k/ecW2hg/KYxnMJmi970jlVS3kSyPz2zJ9v0CfG4tWvSm4aXhxUHib3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7JUMBjIVIxV47QJblAF6E3W/iQHaktd0VCJFdDIvcA=;
 b=fwUeb0ZaPzhsHbNDKvUzZ4T5GxrBbppdKR2MDhAkDkNwTC+fhjN1MGmL9RxTpFwPxBnPuELc9IXk67aMKM8Y3zE8XOHwWWg/EE18KmYX2/2m7B3bVcY7lG3Zg7aW4Ca/M9vxu5WmRIlKvacX0vGhs4xzF0sJOnptl1B4UzzKYlc=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SA3PR18MB5675.namprd18.prod.outlook.com (2603:10b6:806:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 16:30:32 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%7]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 16:30:32 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v9 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v9 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHawkuRAt24PQewNEyxUDLzLda70rHlJ1eAgAAbioA=
Date: Wed, 3 Jul 2024 16:30:32 +0000
Message-ID: 
 <MW4PR18MB5244717F7C793D18B402BBA0A6DD2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <c43e2c24-cd5b-44c2-a997-5f324f58746c@app.fastmail.com>
 <20240619132109.3168940-1-vattunuru@marvell.com>
 <2024070333-matchless-batch-57ec@gregkh>
In-Reply-To: <2024070333-matchless-batch-57ec@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SA3PR18MB5675:EE_
x-ms-office365-filtering-correlation-id: cd11eca2-fdde-4d47-0b77-08dc9b7d755c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cXpLTEhPSkVSMXQrNlBEMEF5b210eGZadHc4SDdGMXhkTUJ0Zm9XSy9BbVRF?=
 =?utf-8?B?eW5uamI4aDFsU1ozR0U3ZTNXT2hHUHA4V0JmOURJdDkzeTBLdDRoWE5vUzBB?=
 =?utf-8?B?Smh2Mk9Ybk80NWhLUmZyR0JhMW1FTXFpL3AzMFlrUGxrelowa0ZNQ0J4aG1V?=
 =?utf-8?B?bHg1MkFCQnFWdzVZY2hTWWxzTW9rS0Nmb3YwRHlzNUcvUFYwRktsTW5GdHpD?=
 =?utf-8?B?OGhNZlcrU01VdGx2MFZoT0prRUVVaFAxUHE2ZzIxbGJ3Ykhtcjl6UTVmdTJI?=
 =?utf-8?B?NUpMTFR2Vlk2aTJqNGxOUzJ2T2NRODhHWG9nUWtnUG4vcFFhb0cyclhZNUNi?=
 =?utf-8?B?UEF5S293VXRvVS9EaDJlM24xcURBcXZrS2NTQ0dMZDk2MkRNQW55aVpOQlZl?=
 =?utf-8?B?bmFYRytFdkVnV2dOYTdEc3JPdEs5TGMwUEg5YnZyQXRMQkhMM0ljV3NvbVZ1?=
 =?utf-8?B?NVUyOTZWd2VYUzFuT016dG82RkhJL1dFMVd1UGVXdkxNeUxMQTc2K24yRmRF?=
 =?utf-8?B?c3B1TWJxUCtzOXRBZWVLRi9udnFGZU90c05BdWZnWGZKQkZBbnFtc3d5amht?=
 =?utf-8?B?V2ZaeU5jdVhKRk1LMTZOVnVxUzBXWTNmUWd3NHVLOUlFeEd4dU1QSndRSHd0?=
 =?utf-8?B?eTVrT25WUmYzbVF3R1BMRTN0N3FqaUxheTdTeWpPc1NteTJsSW8vVUNMNVQ0?=
 =?utf-8?B?NlZJaTZ4aDRQTGIzVWN5RmxlMy9MZmJqcFZhK2h0ajIrREJ0ZEZOUmx0UTZN?=
 =?utf-8?B?NnpFVDNNb0lwdmNBSDN3aWF4QTBDN2sySW94djZRdkhOSkptT0VpVi9QOEpK?=
 =?utf-8?B?UmdRTmRvQ1JkMy9rOWVvcUdXcm9maFl2dTZsVlo4eTNhTUhwcTgwSnBUMFhS?=
 =?utf-8?B?RW9kbGJGdnlVMWpMSzYwcGpSZlBFVXpaeC9LUXEwbHJDZVNLcytZZHdCV05R?=
 =?utf-8?B?UXBETVJUWWRhUzNLM0NxOXVobU04MnROWnhyQlM2T0s4LzJnMGI5WUxWMUxG?=
 =?utf-8?B?aUhzcWozVDFmeDQ4cWRJS0Jub3k3SFFhb3dhaVlQOHZpZ0xiRzRhRUMzOWh2?=
 =?utf-8?B?M2U4ZzdURHhZYk9ieEMwL2huOTdiTjk0b20wTm1MTmtTQ0xYWm5sRmhRWmRC?=
 =?utf-8?B?RGEwcURUbGcySndmRVJ6WFllM2NETUNDS1lTdDR5cTcxODJFTTZhcVhrNTZ4?=
 =?utf-8?B?eVRYMmpLTlh1ck1WRjBpTXdJMnZXSVVlWUNvWUJqbUFBZHVuazRqeE9FZE55?=
 =?utf-8?B?ZklTaU9FZHFXbUtLeHo1d1JoSzBJRGpYZDVObTEzU0JnTTVCS1V2RTlnb0RO?=
 =?utf-8?B?R3BFSktOUWN5RS91MWpGNHFqYjdBVWdHUGtoWC9aNGh0TVlsN21WdU1EeDZ0?=
 =?utf-8?B?YTNoWVo4TlUrRExlZWhKSmt5RlBiL3MwWTdsZWJWMnBuaEdmQUhGRVQ4M3BY?=
 =?utf-8?B?bnV3Qm9Ld0dXdThIdXowSnJLMy96MCtJb2pHMjlmMWgxNE9JbHB2VndRREpM?=
 =?utf-8?B?b2N4Y1BFTDRLUzJ5OXdUeC9hNGxseUk3WGlkY3BuQmY0cjdVbm03a001QXhF?=
 =?utf-8?B?WXhIMkw2a0ZoMEQ5NERVMlJqaWJDSWdPWEtmR1N5STIxaHkxTVFFZHVrNnYr?=
 =?utf-8?B?T0FQZmI0cE51QmtpRTRmYTZEdEltK205NlJ6Y1RSTDgvRnloNEJROVBEVDIy?=
 =?utf-8?B?cm1idCt2S1NIUEMreVlETzJnTVp4ejVyL1YxU0wzRHJMT2dBWENRMU9aWm1w?=
 =?utf-8?B?cE1JTU45V2wvZG1US2dZcnptdEd1ZVVKRGpqNGFtVUh4bGZNMjdSeHoyMU11?=
 =?utf-8?B?RGhPclgrbHQ2ODBVc0FNUjNWVkNvLzA5R0t4TGVOSlVHR2FVUW9TZVhVVHg3?=
 =?utf-8?B?bmVvQkVHM3ZwUGRxOEVXOXVBUjcxbitRN0pVYlBQUHd6SFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWsrVkNmYXJwY29oQXRrZkFsTXVDMCtNS1lIS05IM1dJdlY1YzFtT0hsQWdK?=
 =?utf-8?B?SGJGZjc3MDJDVnNxTVlPeHI0WWliZjExY0xSdjNmaUV3cWlNTE1NR1o3MDNj?=
 =?utf-8?B?bEhsTlhPa1gyQTh1R21meHVXWTB3UTIvdVN5bWRWTEZFaHhWMlZUQzRMQWNR?=
 =?utf-8?B?Y1puQjQvQ2Y3ZFJxY0F2T1J2b25xZHIyaHpnUjR4L3hPaWs1RDNwZERFQ2Rp?=
 =?utf-8?B?eG1KRFZCY041SHVVd1BMWlBPVzUwQ1Y5ckdxbytXcHRlRmY5SC9MTm9qQS9h?=
 =?utf-8?B?NTVIelpwdVZtU0VZeWR6cHMvaE52VzlHWEZBdER6bHdpODJNWng1bnIwTS9p?=
 =?utf-8?B?cHBMaFpkbnFmcUd2T2ZVdFNnYXd0eGF3WFIrejh6U2xrZGxrUUl5dXJlTDBx?=
 =?utf-8?B?eVF2cEprNmkwRkdsa0FRc2RmWmpLSFhTN21JOXpLMVR4QlhONUVmaDlNKzFC?=
 =?utf-8?B?REE3NktJMS80OTNzSlVObjJuWThPK0FCZzludG9lcmlPUUJsQzZmZGZQaUMy?=
 =?utf-8?B?N2ZlT2tyV3VSQ3QrbnpPRDkrNnVtalNWNEtSS1pSajdSR0RHdzNpZ2RyaEMx?=
 =?utf-8?B?bU5Fam9TeEg1OEp4aHRpa0Y2Zm9SQ3Z6TmY3R1FUeFNVWEl1alNCUFNzWHdB?=
 =?utf-8?B?b2kxa2UyaVpQajcrN3FCV0dGeFJLc3AzMXBBUkhGS21KWFU5bDhnbVdqUlp1?=
 =?utf-8?B?Ly9ITUJ1OWdiRDB3NDNTai83S0RFSVhwV2Z3RWVKSWNkTDFRL1BxVUk3UFJw?=
 =?utf-8?B?K2hMYkQraFpZWkQzMjA0RVkvbmZnMTN5QzB2cDkxVmpvY1ZQMXJtbEtVelkz?=
 =?utf-8?B?KzlNYnhXR1NjOHpxRDZGbnl6Qy9iS2NJd0JlWEhvZzRaZHV5N0F6dy9zUi9V?=
 =?utf-8?B?NWFTQTNIZUxnTUFuN0RFRVdHWWlhaXFHR3d3emt4NkJweFl6dHVCNjBsY1o5?=
 =?utf-8?B?UkJBNGRxT2ZBc3lhUGI5TTlHUXI3MStoZlRTQXMxazJobjZHY1EySlRhay9u?=
 =?utf-8?B?S1hmbklONCs3S0s4Y1hPbE5wWWdVYjV6bE1LbHNySzFyc054b0pwRm1Fait4?=
 =?utf-8?B?ODlmTzJmNDRVUDV6UHRia2hWRVdJK3F1alpXL1NDY3NFSTlEV2I0akZUejU2?=
 =?utf-8?B?cWpOZzRFU3NqS28zaUdNbHFxTHJrNHBDUlJBMTBvMWpMZFhTSjRPV3Ftbkc2?=
 =?utf-8?B?SmxqU0hNQ0F4TkUyemJGeEVQRHVDVzdtbWxnQmdreThtdFlNQWRUYXZpZy8w?=
 =?utf-8?B?UEhmRG9KcFFKdDlpMnRSQkVPRlluWDVNV2ZSVmp5ZWpPOFE0ekx5TWJnaStw?=
 =?utf-8?B?MkxlTHdvVGtwUzNPYXozaklicTBlaDdFRU5iYXZEMXkra3E5MWR4VDhDWEkx?=
 =?utf-8?B?Unk5d1lSRlE0TCtsN05GNTZXdGhyK25IbHJrY2VZL2tNNTc0ejZKZjI2bTBV?=
 =?utf-8?B?QlhJTnlzWFJ2amhrOGVRTU82dkN5U3Roem5RUDdzNm1nMGFMdTFoTVhuR1hZ?=
 =?utf-8?B?QWFMN2NvODF1TllXRUdBU1dlcTYvSUo1M0pscytjTE5pYWF3WkhGWDF1ZEV3?=
 =?utf-8?B?aUI0dEdjMk5ZZDRZVm04OG5yY3oyVUhnMUFNMU9ITWNvaVcvQ0RPTWl3S0d2?=
 =?utf-8?B?NVpkZVc3c1VPSFJPMjI2QWF4TFlpTjZ4SysvQWNZTk10VUNscm9lSjRkUi9o?=
 =?utf-8?B?OGJ5NE1idzZsVHNFaHlLTEo4RjlPUEJ2eUVKb3RuR1paMGJFdVc3eHA1QmpN?=
 =?utf-8?B?RGRDd1lmUzY5QVZhQnV6WDZvc1BnM3dycnBPamFXQVF3N0daU0RiSVhrYTRU?=
 =?utf-8?B?dEZzVGg0dEJZQVcwdlI2S2FBYUVoZUNtYmo1UjBZN1Z0SHlDMUk5YXFwQUxq?=
 =?utf-8?B?T09adGt3ZUxSZGhRK1Z5Qmo2Y3BZNkJYdVowUmdTLzV2Vk96YzBOc284V1pJ?=
 =?utf-8?B?L0ppL1lNanFOTUVhR3RlNHNIaU5WZ1RpVERZTk9ZKzZaczZxRlNIWFNBaEFD?=
 =?utf-8?B?OVpjdXJFcDBXV0ZjN0RKR0Q3Z1ZQcGtyNHFhV3pZc2hqd29tNzlOYTVHR2dw?=
 =?utf-8?B?YnpQaG5keXlVVzBXR3NiU3lDanQ0Q1pDa1YzYlJuc2xNQU1GQm5DL3JtZDAw?=
 =?utf-8?Q?vmIyMofLuec6Xp/5tWyRM/KW+?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd11eca2-fdde-4d47-0b77-08dc9b7d755c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 16:30:32.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMfcjRaBTDfmkXKhGO6bVLKgzGmfAJYeulpmd+jni5p+FjofB37gySJWWLD+/l+D71aJ/egy5Ce36OC6qW0prg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5675
X-Proofpoint-ORIG-GUID: JTvTojVtyaNnnoNOdKcrGO3TU-xkpAmo
X-Proofpoint-GUID: JTvTojVtyaNnnoNOdKcrGO3TU-xkpAmo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_11,2024-07-03_01,2024-05-17_01



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Wednesday, July 3, 2024 8:03 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
><schalla@marvell.com>; linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH v9 1/1] misc: mrvl-cn10k-dpi: add Octeon
>CN10K DPI administrative driver
>
>On Wed, Jun 19, 2024 at 06:=E2=80=8A21:=E2=80=8A09AM -0700, Vamsi Attunuru=
 wrote: > +struct
>dpi_mps_mrrs_cfg { > + __u16 max_read_req_sz; /* Max read request size */
>> + __u16 max_payload_sz; /* Max payload size */ > + __u16 port; /* Ebus
>port */=20
>On Wed, Jun 19, 2024 at 06:21:09AM -0700, Vamsi Attunuru wrote:
>> +struct dpi_mps_mrrs_cfg {
>> +	__u16 max_read_req_sz; /* Max read request size */
>> +	__u16 max_payload_sz;  /* Max payload size */
>> +	__u16 port; /* Ebus port */
>> +	__u16 rsvd; /* Reserved */
>
>Please spell out "reserved" you have plenty of characters to use.
>
>Anyway, you NEVER check this, so you just made it so it can never be used.
>Please read the documentation in the kernel for how to add new ioctls, it =
goes
>through the reasoning why you must check this for 0 now.

Thanks for the comment, I presumed the reasoning is mainly for the copy to =
use space direction.
I will rename it & add the required checks to avoid any info leak.

Regards
Vamsi

>
>thanks,
>
>greg k-h

