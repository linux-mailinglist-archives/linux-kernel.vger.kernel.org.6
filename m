Return-Path: <linux-kernel+bounces-571991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60897A6C515
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5E77A9E28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF2231CB0;
	Fri, 21 Mar 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HDQwgYw8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gJLNABdr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TguatUGY"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687222652E;
	Fri, 21 Mar 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592287; cv=fail; b=F4R3w6Rr48nLzsP4ldun2VwPOnatE5aIH0LV72xny9fPwb3ZUzJtCACQu7b35c4r8dF/9vswHOEnQMWMkzSXv/i6tTszjW4f5dsDITL2uku4gvzi97SALIlBFdNaklm4loFgfznmlb+d9hxdPMRhPmswWJvwR6LceGg/dLUBDM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592287; c=relaxed/simple;
	bh=2JCB7+n4bE4btY5qc18nrfpccr+fxLBzqUN0CIHbS8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFnv60G+uFqwCwOD3i/B7hlbzUrkv4kgKr6lOud/kxFM6SMQ/RmNZAgVv7u2Oqw1xmLd+fEyb/ieI3wc1ZlViRBlHVuS9xRL6/MGLCMgM8RrDLbz/pIAe0mlEeS0CFTKoJJ2bqisEyJggOQm0aD5rBGQvoQflDek9HZc39tat5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HDQwgYw8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gJLNABdr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TguatUGY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJeaPw015625;
	Fri, 21 Mar 2025 14:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=2JCB7+n4bE4btY5qc18nrfpccr+fxLBzqUN0CIHbS8Q=; b=
	HDQwgYw8UuaFmeZO0Dh0UJt1Qt8liQJOvQMfmUU8QafR6xfy9fR4dXpV4CDhQ51N
	6i6D6NrYeF0CHAhmpPaXGi2sgJeadJ/hEVFSkv5eBkdrCLgsuSaTgrSQJTd0WtrI
	XdZouKCj1bos8Zv5t8JvYQNAnbexGNY4aQ4VakcGqJmtYbzPRGaaxpYVD8LWjB9R
	DshfXc+of5YrH3TcmaWqs+6aC7OgVyIkZsJs5h7cRvgJtmTVejclodDEHoV0HgH8
	NNWAhhg5DjHZYa4pPiA7L1lNGrFUjvwYU7ufo+wMyjbHVecw80gGzi/ziHGjPY62
	a3EV00DLrlfY0MyteJRLYg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45d8t7ms83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1742592269; bh=2JCB7+n4bE4btY5qc18nrfpccr+fxLBzqUN0CIHbS8Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gJLNABdr4mnUkIm7wkFGV0WXb2e8X2mEkVdk9QOudB1ZiyyjaEsI3Mb8qE1rh0pnY
	 puT8Wbd+X8ddBN2nNWg36Ydz+Yla2NlAwJKZo02kLUCiZupw0w63H57I2EXIm5p+VT
	 xPhdxCyYNquWmKw7RTgouhYGLzhQlrAVMljFlXmPsYwlafA1jNH/2GCwrKGw/YsVJa
	 TCg2Gc80pNB8Kinvnhj4M8A5cgtRRwzlR7Hl0OiDvfQOazEsW2VAY7no0iEddFT105
	 9SEpvaR9VVo0ThHRFEre6DEnNLhJN6DcHKjaW3/4+TR8M2yHPPMfxiWl22omJiIlAd
	 MD82O4TqXZTXw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 96F97405E0;
	Fri, 21 Mar 2025 21:24:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 73D16A009C;
	Fri, 21 Mar 2025 21:24:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TguatUGY;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 759974041E;
	Fri, 21 Mar 2025 21:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvYiJaOOS/wCa9DdVplR/6NMzKFJ0z0RNR+5KS2EYAWHVTOlReFtLWGRY/ji9jPjZrUDDFQU3xjOKWl6HcsYmYsSuZkb+OCCiWzNH7DPg6LDshWuBJu++dcrSKXREC53R5rsI9+HO6wziv1HXM6n1URg+SWyh85ERMCZEUUoQmoKKhC5/wK83WgbJmxK81d6r08EVm8rtI2hfqOHRp7k0p3VaTeorPYw9Exbsvte1lcNhaxkNX7S3qQM+THBMH59QcNqZJKxbBuwLtEuuF46FstnbTRyZj0w64YNehChve2/aPzx39FJyPtMVBGtKKklVNi6vHIveFvHPAlk9MNd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JCB7+n4bE4btY5qc18nrfpccr+fxLBzqUN0CIHbS8Q=;
 b=a5lB2lMzDgSpXyZ9EtBXF9aUWnWqbLwDwyddaR7F1DzDAC7DAI/01dPx4qio9NCBZYSK5tpLRwF4iT5mZJhAMtX0fxUe2V08TxvlVuAFKbwSBmIpU+S3GgcCrFr2N7YuEK4B9tk9s7jXLk34xaH5sGm99APwdt2FRp5IIZeyvl65/iZUyrx/Y6lA/FAf7+hTW3GLIHlvHMzQ4vzhgBbBpjVDRst91Rd5F/l37ZXTRcVJU2FDtjostR/GxH9W/K0SsImvYHHmTmAroAwxTlKEXbJYs4N80ycmKjx1Sh9vPB0pwpRlkCh1GeX05hWeor0elkdAnOn69Z7dNu+6E5Wcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JCB7+n4bE4btY5qc18nrfpccr+fxLBzqUN0CIHbS8Q=;
 b=TguatUGY/Zn6cWF1hNO8G4JelNEcWsIgE5csqTpQ6rYZBjb/1TX2IiJ6WeZbPY/yF99h2cr2yftJEFh/zsCkaun0qKlBA6DJOC0sPQiL2t4jvxtyk/+Uukwh/l4+Lrnsw3LN7EF+ojLvE3/743jCVEsxudjWtaBnn7mMV8pI/G4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:24:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 21:24:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Topic: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
Thread-Index: AQHblPnP9d0AvXdgXUGJVdEv1Rh2trNzIhyAgAO9ioCAASswgIAAZy0AgAWzP4A=
Date: Fri, 21 Mar 2025 21:24:20 +0000
Message-ID: <20250321212419.fhyj4rcx4emte6qm@synopsys.com>
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
 <20250314211411.l5taj5nysvcalfyz@synopsys.com>
 <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
 <20250318001211.tnjwfckt5j4fbvjf@synopsys.com>
 <a9812897-2c79-4a1c-9431-c6f184233a57@topic.nl>
In-Reply-To: <a9812897-2c79-4a1c-9431-c6f184233a57@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5794:EE_
x-ms-office365-filtering-correlation-id: b2f552dc-b4c8-49a5-186d-08dd68bebe8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3BpZ1hVd29XcStvazNEUlE1VWFqWVBsdExtekxsL3ZFdFMyM0VuQldZRlZR?=
 =?utf-8?B?Rkh1N2tIdWZvRnk0SUNERDJGQ1J5dUpSVC8zbmRuS2FneHNKc20xSjBGNVA5?=
 =?utf-8?B?OGRWdEgzUkNoaEJCeTZ2cm0yMEQ4YkRRRGtyVlN5Y2hwQ2c3UVdMWVE4eGRm?=
 =?utf-8?B?UDVnRmJLcm5KeUdzOXJwdzFrYlJTWjQydVc2bG0vaXFQN0huOFB2S2dqT29k?=
 =?utf-8?B?ZDVvVGFrVHNwL3ovUFpwa21kSU9XY1lualh5NnVINllqWm9UNDBiUzkzWldN?=
 =?utf-8?B?WllHS1NONTdmYVBQMUkyS1hpNnhJa21zV09mRlNHWXRZT21XRFJJQ2xlQ3da?=
 =?utf-8?B?KzB5SFFnVnJHV1FrcHBtTVd2ekJEN2tpQzFoNC8yK0lqQmY0UUVrdkxEa05I?=
 =?utf-8?B?Vyt1ek5xUDUxNTRuOUIweHZxVTRCMi8xV3Eza3NvNlhDN0lLZzlKc2VIQXRC?=
 =?utf-8?B?cXBZT2FJQVo3dFpYQVgxMlhsbmFvMWY0bEpmQURtYjN5SnhqQWJ3dlo1M1hE?=
 =?utf-8?B?dHpNOTd5WnBmUm04K3hMUWZ2K0kvQnFXSkZETnRpLzA3M2YvS0xudTFYajAv?=
 =?utf-8?B?T3dXdy94TnNNZ3pzendBN1VsUk1VSEt3QkVvVlViRjRCL1U5Skp3NzlYaldn?=
 =?utf-8?B?bitncmZrNzRFOG51V3NxNy9ZajVSYVYwMGhFWWRCRklCUGF0c1BHMW1iT2Mv?=
 =?utf-8?B?cjJFVVhkeEo4NlRRVHhna2dXSEYySisvSFZ0V1JLR0h6MFNWZjVSdUMxUG4z?=
 =?utf-8?B?NnlROThLTlFjeFVZVnNjdjB0ZzArcWFYRU8rM3BRdWNvS2h4aDhlQnBQMDZR?=
 =?utf-8?B?WE5ER1RlMWNKSklLYXp3ZTRZKzJ1NGJSZXRnOFBoUzlKRHZiMGZZVzFuR3Vi?=
 =?utf-8?B?OUY1ci9LNklZemdqc1VrVjFIYjMxaDYrN0VOaUpHM2Q1bXZqZGNhWUI0MDda?=
 =?utf-8?B?OFBjMUJPY01FbGEwcDlaSXhEMXNhTWhHQkV0YU1JaHBCTGlkVzRnSW5OVjA2?=
 =?utf-8?B?V2d1bkgxSjlFazNma2xEL01wZFRjRVBMaXg2OEpmZUtrQWIyNUlKZ1VSTTl0?=
 =?utf-8?B?SS9WTVVIOFhOZHArZzJLTHNwdjdvM2pPcW1PV2lQQ0ZNWm1ob2hhVitmdWFG?=
 =?utf-8?B?emI0U2ZDaklxNllFb3BWZUdnb2hsQ3JrSnhoQk05MTBXeHc1SGIyS1U3c21i?=
 =?utf-8?B?dHBvdnFVVUMrSC9qZWRjMjh2anQ0WTU1T0lUT1V4VmFxTlF1RUpuaVM1cjFV?=
 =?utf-8?B?Q2c4QitwMktodjZPZnQxK0dEN1VuZ2Q4dU9NUzJaMldMMnZOcG1TZ1hhbXFG?=
 =?utf-8?B?OTBRSW15Rk15VzI4L01hNWNyYXJLNXNKK1BHSW5tcytNTlNyUU5YelpCQ3JG?=
 =?utf-8?B?ZVZCY0NHZ0kxTmV4UzZ4QW9aVDF6c0pMY2s5VG5oclh6V0RobEZsS2k0MTBm?=
 =?utf-8?B?Nk9KVUFuU01tN3RIYmVLVXhKempwblVtOGp5RXJhRGJPN01oQng5MXIrekxX?=
 =?utf-8?B?VUVBV3A5Z29Dem5TVGx4UVNKaWlzR0lzb2NjczJ2ZHMzVTZ5bTYzaWlxNGpV?=
 =?utf-8?B?dk10U25rTmgzTisvVTIvcjdIUk5WUHRzREdaYUpWRzZMNlJpY0Y0cGtyZXpX?=
 =?utf-8?B?SXBKWGF4SHQvY252NjlIY1E2VmZqVVdEa3A2ZzIzdnMySHh4SEh3WXlTcVR3?=
 =?utf-8?B?eU5OMmE0dGpjWjhlbVNSMFA1Wk5laFkrcnp4Q0YzbG9KeGpyWVFwd3ZSOU9P?=
 =?utf-8?B?S1RFWExjTU1HSE5VM21ndmR5eU56N3F6aGhEb09QY2tJeWR5QW5OM2lKWm5t?=
 =?utf-8?B?cGgzTnFCOXdBLy9iS3ArTTFEQjZWcDFMTC9DYU93Uk1ybCtqRnF0cDVUdjNB?=
 =?utf-8?B?TGc3SmI4T24zUG5mZzZFTXZpMDVYWnNkZlpwY3lXUFFCTVZzdDF2UUVmZkth?=
 =?utf-8?Q?4pzhakx6kS1l57efnAlD+UjIxt0VyeNF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3lDOFlKR2ovdkhWSU5qS3o1MldJK1l3MFFFN1VZRTEzTXA2L0pjVFhXUGVz?=
 =?utf-8?B?dFd0WjVBRlQ3ejVhMzZLTmlmbWhja2lBaU9QVjd2Y3YvZWdydEZ6d1dMZHJp?=
 =?utf-8?B?alBtOVFZN1FyTVo4M3VxLzFRZWkxb0hJSTV2enBvSUM5TWdLTVJma1IrbDA2?=
 =?utf-8?B?bnFRdjljTUtQWHlMbUhTM3pGdWFVTXhPYVpxaUdZdmowdlRYdEE1YW80a3FK?=
 =?utf-8?B?eVZ2c0lEQkFjWGtYaUVqVmpTWE5wNy83cmhFVjFybmxSamRXSjc4UnNGSkFy?=
 =?utf-8?B?ZlRaZGwwTHdiTmlwYytJOVBhVWk5YXByM0dHZGtxcHIwUzRmMllXb0w0ZVZ6?=
 =?utf-8?B?UVhvbXJOY1hhL3ZNTHpTSmkreW9iRHRqVzZTMjNjM1UvOG5kdTJsM0FGQ0RE?=
 =?utf-8?B?czZRWGNPMSs4Sk1wbjlQQzVCTWFQY0prRy9yUWVSSGtLTzNBMEgwU1dQUHo3?=
 =?utf-8?B?Q3RBT0s2cURLcWgzWUZ2bW1zWVl6YThjbFFabjRYWlgxU1dINWlLVmpLQUY5?=
 =?utf-8?B?NXZCanRJTXgzTWN6ZC9xRjBYemIxM1h5M1l1d254b05PTHlDYi84K2cvaG51?=
 =?utf-8?B?NTJXS28yK2dkZ3dNcXI0bWhFTkdTM3FiZlFoNFZRYU1WNUV3Kzg4Y0twcDJN?=
 =?utf-8?B?L2EremMyejFxajBrVDYyelBEdk9ZOWY1dTJKKzVUMGVQYzhoaWxZN0Z5L2p4?=
 =?utf-8?B?cWZqQm10dEFreWFGWThWMEUxdVJMdGpGU2FUK0NBd2tJZkpkc0ZjMldibG01?=
 =?utf-8?B?akgyak1yRXRIM2tpZ1ZKdmFoT25TeTVBdWxIOFcwdG9GU2NMazZmcXpwdEhr?=
 =?utf-8?B?MFB2OTBIT1M4ZHgvK3I0QTNMcGpYUFdpZy9uRUlNMVV0WC8rYmJQZ3ZUWmFV?=
 =?utf-8?B?dUt6RkcvRDRPb0lycXNCWFhMQkc0bVBlNEluc09xRE1tcVpWQWJhWDc0dUM5?=
 =?utf-8?B?dlRVOW1oWTV1OUI3dExaemZyRUVmMTcrdUFYUE9abE5KRll4dXhWdXo2MERI?=
 =?utf-8?B?Yi9na0hIU1p0aXdLRExOWjB6WjRSQUhMc2hmb1pxSC9JTWEwZkZBZHQ3N2dK?=
 =?utf-8?B?RVV6Mk5ZZU9UeG5aOUZjdnZuSUltOXM2d1UraXRHTUdpTk1kQUQ2eVBTQzV2?=
 =?utf-8?B?Ukk5bmk2TnBhWVI5UHFtN2F1eE5oWk0yYU5aMldaNy9OcFkxVUQvTURGbUt2?=
 =?utf-8?B?U1h1ZzBiWklQMTlvZzdtdHJKcDdKcGh6ekNOY3VLWnVhZTVnWDBuQzVFeEtr?=
 =?utf-8?B?M3NOdUMzSTVnUDY0MlNTZ2JXQXpXYkpIVVk2V3hxY3llWTBGOUQzUzBjZ0Z6?=
 =?utf-8?B?ZFNqZ2ZDZm1sK2lKTGJEeWRmd2NTNVR2SGxnbXkrWm01NmZyemgxK2xiQ0Jh?=
 =?utf-8?B?aFpLcEdsV3hLcmdpM3NyV3VJSHY3c25mUnVjQmRieFVpRWRJNjNkclhEb04w?=
 =?utf-8?B?ZDhwamdYenMxWS9zc1ZTQVNPdXdHbkFncnRjZnluTytsdUp1T2lpYldBZkc0?=
 =?utf-8?B?bjZTOE83czNtWlZIVklhOTh4V2hhejk4T0lGVGF6VVBwdVVhUzRNcEp0dTNi?=
 =?utf-8?B?SjN4ZVJ5WFV0RFRxZU5ta0c5MmgvNG4wdWdGKzFCU0kwWVJKQWlKQUJjci91?=
 =?utf-8?B?bmxUTTNGTS9JN1orek1RSDEvQWRwQS9BQmZ6ajFLS0crRnN3bGxmZUo3VEhU?=
 =?utf-8?B?K2tXT2ZIL1Q1WUQxSXRZSjRwTFpiVFAzeXJKeUFCdG9kY1gyMDEyOEdsWUVs?=
 =?utf-8?B?RXRuRnBhelFsNnZzR1ZodXJ2RXg5ajhzTUt4Tno0MnZrT0FJNFJPcDVabEpC?=
 =?utf-8?B?WHgzWU1Rb1VENXZ4VGtNT3YzRlhJK1g0ZnVDNjhOd2ZVN3lYc0cvOUQzY2Yy?=
 =?utf-8?B?QVFKTGY0MUp3aFV3N2h0Z0ZJVmpndnUzelBDczkyYlJzSDdmZjJCQzV6QXZr?=
 =?utf-8?B?ck5YNGs4eFdNbnVQNG9mYitQQmREMHQ3L1dadGRXQlB0K1NoTEtqa3FmS1li?=
 =?utf-8?B?SmlOU05WYmJrUDY4c2k1QnplYmg3d2pBOW1xZjNpaUdkd2RmTDlrTCt1L1N3?=
 =?utf-8?B?UXVpM1pBVm1VdUJzV2tJTzNuQmg1L2NPVkxpcGw3UnZvM25PWGJ6bkZ0WTVa?=
 =?utf-8?Q?YtiuGW0ajRZ11QVHVzRwFFqKQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8A449F77FB09344972F021BD10B90DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	24ElV3jdE5Ql2L9VcdBE3O7aTicartRUHWT+F3OaJJcmuWddSdSxQTQRuquIQtKUOorU6WrIXD463P18GfbOsyEuO9SNPfKFnQsacgTelAnoiEwmUyNMrrzhg3tc4X6OvdhFRkv/BeYUUbx9ek8N7MxNpqd7vb5CT75+LK2uV5NJBcUAh+2gpyY6uImlqafJNIJRVO8yyZXZ6f7nKaknj7VdTv9rQiKIqDIZQH7Eo+j4mFwEErAD6FKTsV6qE9yHWljd1qp37rwSyPN4QVBVq995QUOWLlYV7pZG2YK+ymtnywOSJ7Z/PqmI/kNx8Vi4E5jlR1yvx3th+vskfnoN36WvSkNlvFuhwe6hDHv/W2DsZXlMz8D3srAoQCrY03rr0Kd6g9cCFvpB3Mf4BUvLf4iShfIPe0eSQwRDLafJKUf1ekXsQEDOqZ14KLcNQkfqkKX8hyfhBs08nMjYHsiMdDxZo31HzF0HKN4tH5gNM+FYByyRZrhUhD0vSwVTnLIke7+wrfQndxrkwE+Tlot8lABykQmbUxFW8bnUbzCNmBvdwR0wZBrfhEGGh4s9K1h0+GsssgbfmQjAzQR7iJTbpnlMxoMEUEx0YKJG3wGoc48cKEOk2/Vn5A5lVdYOdKIiJkOJFpE1qmIQWcFO1DHp1w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f552dc-b4c8-49a5-186d-08dd68bebe8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 21:24:20.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/wflWpfg5GVYpavO+qm+7P5S5Xuf5A0o8AZqTKZAjw/1l3vAnn0JIGmHeulfJdbzTS/eivYVtFKUOsiCxn9yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
X-Proofpoint-ORIG-GUID: jvHHKJHnw1Ru1QFwwQl9msskOdNcWWpe
X-Authority-Analysis: v=2.4 cv=IJYCChvG c=1 sm=1 tr=0 ts=67ddd90d cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=Z6EfDJrRAAAA:8 a=Yyg9vjTvt8j2OUXZuPEA:9 a=QEXdDO2ut3YA:10 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-GUID: jvHHKJHnw1Ru1QFwwQl9msskOdNcWWpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210156

T24gVHVlLCBNYXIgMTgsIDIwMjUsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiBPbiAxOC0wMy0y
MDI1IDAxOjEyLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gTW9uLCBNYXIgMTcsIDIwMjUs
IE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiA+ID4gT24gMTQtMDMtMjAyNSAyMjoxNCwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIE1hciAxNCwgMjAyNSwgTWlrZSBMb29pam1h
bnMgd3JvdGU6DQo+ID4gPiA+ID4gU2V0IHRoZSBncGlvIHRvICJoaWdoIiBvbiBhY3F1aXNpdGlv
biwgaW5zdGVhZCBvZiBhY3F1aXJpbmcgaXQgaW4gbG93DQo+ID4gPiA+ID4gc3RhdGUgYW5kIHRo
ZW4gaW1tZWRpYXRlbHkgc2V0dGluZyBpdCBoaWdoIGFnYWluLiBUaGlzIHByZXZlbnRzIGENCj4g
PiA+ID4gPiBzaG9ydCAic3Bpa2UiIG9uIHRoZSByZXNldCBzaWduYWwuDQo+ID4gPiA+IEhvdyBk
b2VzIHRoaXMgYWZmZWN0IHRoZSBjdXJyZW50IHByb2dyYW1taW5nIGZsb3cgYmVzaWRlIHByZXZl
bnRpbmcgYQ0KPiA+ID4gPiBzcGlrZSB0byB0aGUgcmVzZXQgc2lnbmFsPw0KPiA+ID4gSSBkb24n
dCB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24uIFdoYXQgInByb2dyYW1taW5nIGZsb3ciIGFyZSB5
b3UgcmVmZXJyaW5nDQo+ID4gPiB0bz8NCj4gPiBJdCdzIG5vdCBvYnZpb3VzIHRvIG1lIGlmIHRo
aXMgaXMgYW4gZXJyb3IgaW4gWGlsaW54IGRvY3VtZW50YXRpb24sIHRoZQ0KPiA+IGRyaXZlciBp
c3N1ZSwgb3Igd2hldGhlciB0aGlzIGlzIGZvdW5kIHRocm91Z2ggZXhwZXJpbWVudC4gU2luY2Ug
SSBkb24ndA0KPiA+IGhhdmUgdGhlIGluZm8gb2YgdGhpcyBwbGF0Zm9ybSwgaXQgd291bGQgaGVs
cCB0byBrbm93IHdoZXJlIHRoZSBzb3VyY2UNCj4gPiBvZiBlcnJvciBpcyBzbyB3ZSBjYW4gZG9j
dW1lbnQgdGhpcyBpbiB0aGUgY29kZSBvciBjaGFuZ2UtbG9nLg0KPiANCj4gSXQncyBhIGJ1ZyBp
biB0aGUgZHJpdmVyLCBmb3VuZCB0aHJvdWdoIGNvZGUgaW5zcGVjdGlvbi4NCj4gDQo+IFRoZSBy
ZXNldCBHUElPIGhlcmUgaXMgdG8gY29udHJvbCB0aGUgcmVzZXQgc2lnbmFsIHRvIGFuIGV4dGVy
bmFsLCB1c3VhbGx5DQo+IFVMUEkgUEhZLCBjaGlwLiBUaGlzIGV4dGVybmFsIGNoaXAgaXMgbm90
IHBhcnQgb2YgdGhlIFhpbGlueCBoYXJkd2FyZS4NCj4gDQo+ID4gPiBUaGUgcmVzZXQgc2VxdWVu
Y2Ugd2FzIGp1c3QgcGxhaW4gd3JvbmcsIHRoZSBpc3N1ZSBpcyBhbG1vc3QgdGhlIHNhbWUgYXMg
dGhlDQo+ID4gRG8gd2UgbmVlZCBhIGZpeCB0YWcgYW5kIGFkZCB0byBzdGFibGUgdGhlbj8NCj4g
DQo+IFRoYXQgd291bGQgYmUgYXBwcm9wcmlhdGUgSSB0aGluay4NCj4gDQo+IA0KPiA+IA0KPiA+
ID4gb25lIGRlc2NyaWJlZCBpbiB0aGlzIGNvbW1pdDoNCj4gPiA+IGUwMTgzYjk3NGQzMCAibmV0
OiBtZGlvYnVzOiBQcmV2ZW50IHNwaWtlIG9uIE1ESU8gYnVzIHJlc2V0IHNpZ25hbCINCj4gPiA+
IA0KPiA+ID4gTm90ZSB0aGF0IEkgc2VlIHRoaXMgaGlnaC1sb3ctaGlnaC1sb3cgZG91YmxlIHJl
c2V0IHRvZ2dsZSBpbiBtYW55IFhpbGlueA0KPiA+ID4gc29mdHdhcmUgZHJpdmVycywgdGhleSBz
ZWVtIHRvIHRlYWNoIHRoYXQgYXQgdGhlIFhpbGlueCBhY2FkZW15IG9yIHNvLg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIExvb2lqbWFucyA8bWlrZS5sb29p
am1hbnNAdG9waWMubmw+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAg
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMyArLS0NCj4gPiA+ID4gPiAgICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiA+ID4gPiA+IGluZGV4IGEzM2E0MmJhMDI0
OS4uYTE1OWE1MTE0ODNiIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy14aWxpbnguYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxp
bnguYw0KPiA+ID4gPiA+IEBAIC0yMDcsNyArMjA3LDcgQEAgc3RhdGljIGludCBkd2MzX3hsbnhf
aW5pdF96eW5xbXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiA+ID4gPiA+ICAgIHNr
aXBfdXNiM19waHk6DQo+ID4gPiA+ID4gICAgCS8qIHVscGkgcmVzZXQgdmlhIGdwaW8tbW9kZXBp
biBvciBncGlvLWZyYW1ld29yayBkcml2ZXIgKi8NCj4gPiA+ID4gPiAtCXJlc2V0X2dwaW8gPSBk
ZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9MT1cpOw0KPiA+
ID4gPiA+ICsJcmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJlc2V0
IiwgR1BJT0RfT1VUX0hJR0gpOw0KPiA+ID4gPiA+ICAgIAlpZiAoSVNfRVJSKHJlc2V0X2dwaW8p
KSB7DQo+ID4gPiA+ID4gICAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIocmVz
ZXRfZ3BpbyksDQo+ID4gPiA+ID4gICAgCQkJCSAgICAgIkZhaWxlZCB0byByZXF1ZXN0IHJlc2V0
IEdQSU9cbiIpOw0KPiA+ID4gPiA+IEBAIC0yMTUsNyArMjE1LDYgQEAgc3RhdGljIGludCBkd2Mz
X3hsbnhfaW5pdF96eW5xbXAoc3RydWN0IGR3YzNfeGxueCAqcHJpdl9kYXRhKQ0KPiA+ID4gPiA+
ICAgIAlpZiAocmVzZXRfZ3Bpbykgew0KPiA+ID4gPiA+ICAgIAkJLyogVG9nZ2xlIHVscGkgdG8g
cmVzZXQgdGhlIHBoeS4gKi8NCj4gPiA+ID4gRG9lcyB0aGUgY29tbWVudCBhYm92ZSBzdGlsbCBh
cHBseT8NCj4gPiA+IE5vdyB5b3UgbWVudGlvbiBpdCwgdGhlIGNvbW1lbnQgbmV2ZXIgbWFkZSBh
bnkgc2Vuc2UgYW55d2F5Lg0KPiA+ID4gDQo+ID4gVGhlbiBjYW4gd2UgcmVtb3ZlIGl0Pw0KPiAN
Cj4gUmVtb3Zpbmcgd291bGQgYmUgYmV0dGVyLCB5ZXMuIEknbGwgbWFrZSBhIHYyIHBhdGNoLg0K
PiANCj4gDQo+ID4gPiA+ID4gLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW8s
IDEpOw0KPiA+ID4gPiA+ICAgIAkJdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAwKTsNCj4gPiA+ID4g
RG8gd2Ugc3RpbGwgbmVlZCB0aGlzIHVzbGVlcF9yYW5nZSBoZXJlPw0KPiA+ID4gWWVzLCB0aGlz
IGlzIHRoZSAicmVzZXQgYWN0aXZlIiB0aW1lLg0KPiA+ID4gDQo+ID4gQnV0IHdoeSBkbyB3ZSBu
ZWVkIDIgY2FsbHMgdG8gdXNsZWVwX3JhbmdlPyBGcm9tIGp1c3QgbG9va2luZyBhdCB0aGlzDQo+
ID4gaGVyZSwgaXQgYXBwZWFycyB0aGF0IHRoZSBmaXJzdCB3YXMgaW50ZW5kZWQgZm9yIHRoZSBy
ZW1vdmVkDQo+ID4gZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW8sIDEpLiBJZiB0
aGlzICJyZXNldCBhY3RpdmUiIHRpbWUgaXMNCj4gPiBuZWVkZWQgaXJyZXNwZWN0aXZlIG9mIHRo
ZSBleGlzdGVudCByZXNldF9ncGlvLCB0aGVuIHNob3VsZG4ndCBpdCBiZSBzZXQNCj4gPiBvdXRz
aWRlIG9mIHRoaXMgaWYgc3RhdGVtZW50Pw0KPiANCj4gSXQgaGVscHMgdG8gc2VlIHRoZSB3aG9s
ZSB0aGluZyBpbnN0ZWFkIG9mIGp1c3QgdGhlIHBhdGNoLg0KPiANCj4gSWYgSSBvbWl0IGVycm9y
IGhhbmRsaW5nIGFuZCBjb21tZW50cyB0aGVuIHRoZSBvcmlnaW5hbCBjb2RlIHJlYWRzOg0KPiAN
Cj4gwqDCoMKgwqDCoMKgwqAgcmVzZXRfZ3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRl
diwgInJlc2V0IiwgR1BJT0RfT1VUX0xPVyk7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChyZXNldF9n
cGlvKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAocmVzZXRfZ3BpbywgMSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1c2xlZXBfcmFuZ2UoNTAwMCwgMTAwMDApOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJlc2V0X2dwaW8sIDApOw0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNsZWVwX3JhbmdlKDUwMDAsIDEwMDAwKTsNCj4gwqDC
oMKgwqDCoMKgwqAgfQ0KPiANCj4gU28gdGhlIGdwaW8gaXMgYWNxdWlyZWQgaW4gYSBMT1cgc3Rh
dGUgYW5kIHRoZW4sIHdpdGhvdXQgZGVsYXksIGlzIHNldCB0byBhDQo+IGhpZ2ggc3RhdGUgYWdh
aW4uIFRoaXMgY2F1c2VzIHRoZSAic3Bpa2UiIEknbSBtZW50aW9uaW5nIGhlcmUuIFRoZSBjb3Jy
ZWN0DQo+IHByb2NlZHVyZSBpcyB0byBhY3F1aXJlIGl0IGluIHRoZSBISUdIIHN0YXRlIGltbWVk
aWF0ZWx5LCBzbyB0aGUgc2VxdWVuY2UNCj4gYmVjb21lczoNCj4gDQo+IMKgwqDCoMKgwqDCoMKg
IHJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQSU9E
X09VVF9ISUdIKTsNCj4gwqDCoMKgwqDCoMKgwqAgaWYgKHJlc2V0X2dwaW8pIHsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzbGVlcF9yYW5nZSg1MDAwLCAxMDAwMCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmVz
ZXRfZ3BpbywgMCk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2xlZXBfcmFu
Z2UoNTAwMCwgMTAwMDApOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiBUaGlzIHBhdGNoIGRv
ZXMgZXhhY3RseSB0aGF0Lg0KPiANCg0KQWgsIHRoYXQgbWFrZXMgc2Vuc2UuIFRoYW5rcyBmb3Ig
dGhlIGV4cGxhaW5hdGlvbi4NCg0KQlIsDQpUaGluaA==

