Return-Path: <linux-kernel+bounces-225463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FA09130D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B568CB21656
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00716F82C;
	Fri, 21 Jun 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EqFocjIx";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FgFyYIdA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CyHwncg9"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AE16DEC5;
	Fri, 21 Jun 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011703; cv=fail; b=r3rczCOp8A6NCYkHhjpFhSSm18p/6BRIvjr0TAOvRGRVoCcFZp3RYD2yCkNWt16vXxfOFvWeXkvSvZf7OdySelclStnfw6eHdWp1xR3jFWfqBDq7LAAGa3nPFtkPDsNClC/8nQVRMpdbfUQKpo5wwyaOXkV1Rv8CJmE99WbL7MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011703; c=relaxed/simple;
	bh=iWHJE42gkxOP3tAoZ2mgM7iZARbgO0X+0NP2RRJ7o8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/0+nDR1ellGSmL3hQesia1aHBHMfIOYxwhUCDYfweFx7aymKDnHrWLwqK3OSlgAKz/bnigAFW5EAdK9TD8RJFrsju/h+eNAk1w4ehLQpP8NlY/oQfLS1C3LASqA4I1dl+kdG2yykYmyFZUbKnBX35F6w3ytzMmJm6hipLbbvMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EqFocjIx; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FgFyYIdA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CyHwncg9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LHjTFL020095;
	Fri, 21 Jun 2024 16:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=iWHJE42gkxOP3tAoZ2mgM7iZARbgO0X+0NP2RRJ7o8M=; b=
	EqFocjIxfFnAxL1XRg6DLseDSNRkDOXRDSHsc98amzCr4Kh7ILB7osDVv7hDS58k
	sMEALOnCUcmtbbDHIUVdxnIRgvrFFFK6jQQ4ArGjX1+Q6SqbSaQJ8quY/l4aFhVN
	QslEicdKSnzKej7Mol6QLRBIDSVmT06PMrAHZWUHIzyQE9VBR0WvOiDFkUp2xNh0
	LLuHev6yafJ/gQyIBqJ/LyB9EEfo7O9xlrVk+/GTk9i6arVi/r2DspGof5WVB3OY
	DrepZsQju0fmSHFcDCgPaeREaYIhNdMnovo9LUSNMByRsOclnooGPf6ma0fLiETb
	ilLLcTnjYZ2pPiJWVFm0aw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3yvrjxxbg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719011688; bh=iWHJE42gkxOP3tAoZ2mgM7iZARbgO0X+0NP2RRJ7o8M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=FgFyYIdAzh1VONunTvcDsQMsFlMN69FBQPkLm6KsSk/qwHlmoaDOWGOIq2IxsmUgC
	 lTF6/ol7yOa0x5adhnUaUtIkI/B/4NZjJOEua2fStMC1a6OKG15RKuIJ+evDvzrpUZ
	 ciZd/RL4CvvhL83ZC1AAkLcyRAj3NlFYY9p4zNIG9j/jui4VxFRIV6USw0Sn+PJKuR
	 QKCApS0rTfx7LzoK7UmpMLrLkfvL2CyJeLnTFSivi47IMPm1/t/neaHMH6xo48U5B3
	 5kHia3VFlREeFhSzuzNJrzXGJbqtbIcZtdTfmz0LOAgei90435mivCMzVAPdW+GKND
	 3WTVYXCw1+4+A==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4F77540141;
	Fri, 21 Jun 2024 23:14:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8A6AEA0263;
	Fri, 21 Jun 2024 23:14:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CyHwncg9;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2854940362;
	Fri, 21 Jun 2024 23:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYiEGGqJrC1lJNz3DvDalPV2wrvPA74qBV1KnvIdu+Z8HyD7oj1W1tdMrcv/Zjf1ypCrBdHtTh9tOxjifnUjQI39wCCsmGQfA2TLMtAZuSmth7++P5Q/ZZ4UfSsFQDXMutbo9yaiu9vplY4cGUKPnGcJpyFrQc1QjJfh/pBsTrNj+3w6oRRwpVIv4EBa0y92Y66oOtfsEf3jQOfaKsurXvvq15pJY7b8i9OYbNx4fx1LQkO13b3Ors+Lq6aiwKDfaZIhtKEg2zhBFhSG0+ymHKrzbgXw7o7DpmjPPj9KvY5lfl0Rgp6AZh09Xhyc/CGk9wnFbfIelUbXzc6p2ysXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWHJE42gkxOP3tAoZ2mgM7iZARbgO0X+0NP2RRJ7o8M=;
 b=gH/Gu3WWf8q1zPATLEzWiZUMVk9bmFaMfHJIu8EyGU2yO7oV4KSbtNFSMmSUL7Q4SFhUliNj6vc5qZHPZopcAHRQmiY/Pzr0U2PDlqqMfKdIyO3pqGXbWaKqDIT6EHdPrIYbqHjICHjPBzqWO7XyNukm/FmPLZ73GK80Q5mDUA1Xp5Z2VUhOW72fbd4VvMzD3VUXb0gN6x85bfmQqXe4GO+gfh+BX+XpNGQ8RBtcHLlKRJ/cA5ves0wIInNR88ee+crYDhzPj6NBZmJthlADzy1qacgbbxBv6KXvchoi4CHs0BUHanim0wkzZfQYxqxziHkCwIa0vcuX4F2p2U7QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWHJE42gkxOP3tAoZ2mgM7iZARbgO0X+0NP2RRJ7o8M=;
 b=CyHwncg9I6lSk8+Dl7bHzwFYDr5N9GgWEVEU/diqZ8LojFsur/A0xkqoZuQ+BPeACDwIXevUVsHtH/hGL5LRSifxjPW2AnfTUktm3bT9dQvAYGHb9x8/mj03NRK+9iQP9IBRqfON35K29nUMYr/DA/40IIcUM0TKVvQC8kQParU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 23:14:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 23:14:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Li, Meng" <Meng.Li@windriver.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Subject: Re: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Thread-Index: AQHawS5mXgmtPyyguEiEAyP9uNoV27HOEasAgABBqICAAAO+gIAEiCaA
Date: Fri, 21 Jun 2024 23:14:42 +0000
Message-ID: <20240621231439.ii4j4bkuanbpgxgb@synopsys.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
 <CO1PR11MB5188DA129618E46A1257F059F1CF2@CO1PR11MB5188.namprd11.prod.outlook.com>
 <PH0PR11MB519190ED0D42D88805122372F1CF2@PH0PR11MB5191.namprd11.prod.outlook.com>
In-Reply-To: 
 <PH0PR11MB519190ED0D42D88805122372F1CF2@PH0PR11MB5191.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7148:EE_
x-ms-office365-filtering-correlation-id: 2679b36e-d3bc-4f99-e622-08dc9247eee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UFd1QTBOdm9kcnhhaGowdWhiRkFEaFFnMG9qcEZBS0YyYWdwMTRkeHJHMWZ4?=
 =?utf-8?B?M2ViRG1kVEYyVDdNS3o1TmZCMW1rRGpONUZYRzhOK2pvcEJXWWt4WnZ3SzYr?=
 =?utf-8?B?NEVEVG1XajVFU1cwUU5JTFFzRVNZNFhEc0MxZU53ZUp3cHM4bExHRzcvblQ4?=
 =?utf-8?B?U0c1QzR6Q2VaYy8waGFLQ3JLVVdkL1hqN1NINWQ0UGVpZlNOVnJiMU0rMTk4?=
 =?utf-8?B?R01TTXNRN095R08wc0p6diszLzhGcSs1azBGYWltOUZuTTdzQWVyb1FOYnNY?=
 =?utf-8?B?VGxnZ1Z4QnpXcFlLWnRIaGN1US9xRXZkbms1UDNuSC9ZSERGY1kzYXl1cnpM?=
 =?utf-8?B?V1FJUUNtbmFpcFNZNmFCYUhQbnN1OUxIT005Qkl3Mi9Fek1LWEtzVDdCbWlU?=
 =?utf-8?B?a3BFQ202Q1A0RW9Na0FKeVhMaDUwR1hvNU9nc29ua3NNdW5nVlNMQktlaVVo?=
 =?utf-8?B?SnJDbE5CNnZLaTFDMDBQUFlmMjVobEpMc3FtTW5sM2lleGdGVUNvNEpmVnU2?=
 =?utf-8?B?SHZkeXQwNDM0d2Q2Q21JSHltMVlnenBtZ1pWM0pINk1PRlptQUVDNlViNEpG?=
 =?utf-8?B?cDlZUXRJUC9jN21mR1RSanUyWERSMThkOFNWc3dFT2VvS2pMdlF6WG9MWlBB?=
 =?utf-8?B?Z2hLTXRkTXdJdlV4djFJOFViVlRWNXpCUy80RHRyQXBwN2pPNXdpczNKZlZN?=
 =?utf-8?B?M3czMGZoYVRZN2dhZTVQQ2FrdDJCbU5YMTU3aGRVb1hQdWlmWnlJRVk4VVRC?=
 =?utf-8?B?L0YyMGgxQXIvbnBoS2ZzRi9jbTU0cS9kZGJvblRKeFFMUEtqY2ZrSGNnMlE5?=
 =?utf-8?B?QzJqSVNGVkIvVWxhaEN1eGt5ejhuLy9FUnhTcUVWb1h5U1BVdFhFeXIrZTh3?=
 =?utf-8?B?aFZKaVNpYTZ0TmZkYUhTN00xVzFsSDV5VC9Cbm1rQ05wOVZIYjNrZ1pUdFB1?=
 =?utf-8?B?YUxiTndBZklUM3VPMkE2bFNRN0F1RWJUK1lRRHRROHNOOHIwTnJCb3NaQXp5?=
 =?utf-8?B?YVBQamF3S3QrelhPMk9GVTRZRmxFRDFjaWdHVldHZytiU082SVh1c1NFZks2?=
 =?utf-8?B?NURtUXp4REJ3SlFybSt5QVpmbkkxV05UVkdzbE9ET25JNmpoWWRKM0VRYmw1?=
 =?utf-8?B?N29JQTkvZTRYcHo0bzd3V0NlRUxJT2xRekRzSXYrdTBJUUh4WDdXSGVwZ1Yy?=
 =?utf-8?B?SXB0L0JMZUVsV09PaGdCTWpmS3FRU2dPbFFZdkw3QnRWcDhzVllhTXVIQWNE?=
 =?utf-8?B?R3ZXQzJCb0g0T3ZQbGlyWUhRd09rYmFQSGY0SVB4R01SN0gwTlVCTzRUcmxt?=
 =?utf-8?B?WHVoVlhES2JnRSt2VTZYdldXNkgvY09XT1h6MVVGY2RYbWNWNyttTjllWE9F?=
 =?utf-8?B?b3hlcVdpMmR2VU9JUEtKbjlnVWo0ZHM5L1d1ajRiMEpHZy9jdWJOdHpDYk9D?=
 =?utf-8?B?a29jUUhqVDhPVk9ZdFJyWFdRY2pFQlhSamtlbDlTRlVuc2czZmZXSC94T2dD?=
 =?utf-8?B?WHhJenp0Qk9IaDhVb0JwTEZEdERzbThNSDdTc25YTmgrRG9YM1NYVnV3aXBT?=
 =?utf-8?B?L2w3d1FNWEtqM3J3TFZCTSszMGtQOGN6VDhXQ0UwYSszZkV2cTRGRFlhaVk5?=
 =?utf-8?B?MGxPdmg3dFA5L1owWFNRYnFjR1p1SERxOG5Kd2src1phdDZQOFRwOTE2T0NM?=
 =?utf-8?B?NFlXMHA4Sm1zcitEQlVqaFF1NnpodzNjVURNdTV0akNjSHZLNE9xUnZmcmdZ?=
 =?utf-8?B?MEtGTDdabFJNaVdlMTFwV0xNbU1pWk1aZVAxY0wzejk0MVlnVHRPZlZKYUh0?=
 =?utf-8?Q?DiiICgE3S85LvC9iidmbzmKfiEqTeyUZ5gOZ8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cXdkMGlhMUpMZ25pZmxQdUpDaTcwaTJJK2hiTzhLd0RuWnp4V2hxNTBDcjdE?=
 =?utf-8?B?ZWk2aWw2UHJ3dFQ4dzE3K3poMkoyaFUvUWovMDZjQWVTUlMxMnVFdTN4bEhX?=
 =?utf-8?B?SjlQZ2YwdndJZ0hZbFZGei8vVTZDaTJmN21LQlVXT2lhWTJpQ1VmMXZtTkRa?=
 =?utf-8?B?aER3eStraWV0QXc0N3hTR053RXNaVlRYcjBoK1NUN2QrZGxkcG85S1dHaFRH?=
 =?utf-8?B?a0tXSEVlN3Z4Sks3Z28zT25ycXhpM3JxNVVmTlFyZXQrQ25wcEdyQlhJaEpo?=
 =?utf-8?B?UTBFdi8xWGhZaVhsWGZLRTRCN1Y5WlpublgwSHNBdkdTNzNManRIZjRWSktn?=
 =?utf-8?B?Z3R3V3FtaFg4REVTUVJHdExKc3JGZldmRXZxVXIxSmpjckV2TFIyNm5sY01S?=
 =?utf-8?B?L2FqcGg5YXlzZVVzQWZBVy82YUJWMmhuS0hEcVlpY3F3ZVBocWdoY0dVSUNL?=
 =?utf-8?B?aHRTVGpaMlQyTTk0YkxuRTkxeVVmTGFYRmhoQkYzUC95VUdhTlFQTzU2VXFo?=
 =?utf-8?B?UFR5eE9hdUp3SG91MldFL0FvV2w5QTN2UlF5R2YzMis0dlVuT3NFOVQzTWZ1?=
 =?utf-8?B?SlhJRHZGNVY0cThlc0l6dk5tZVdXeDNmMWRrSFVoSmgzZFdBUHM4c1A0M0ZD?=
 =?utf-8?B?TnlxNTBxYnZXMEUzdkVaY2Y2RUxRZlI0TjZ3dUR6Zk9PM0w0UTNuYnFlSUdx?=
 =?utf-8?B?SWJzRmZBWXVDTFJ0dExjSGV5OStHK3M3dmFNaytyMUliYm9mU0FQamxJODUy?=
 =?utf-8?B?NTVFMGZBS1M1UjdoLzhMaFZKaXRLbjFNd0o5VUtLcWFST1VSS0xhdGI1RnJt?=
 =?utf-8?B?TmQycldtelRNS2FVM2V6OURhbmRhcmxOanRTaE1MeVJ4UkRKcXFSb1NFYzMy?=
 =?utf-8?B?OHNjTnVLY01ybzFvN3BIV0JSNm9WZzI5Ly9ocXBMM09YanNYM2dncVN0WVFI?=
 =?utf-8?B?S3ZiNXNnbkhjeGxUYlhITitoVDN0MVkwOERSR1dEcUJRaVY3bGNuWEdSZVFv?=
 =?utf-8?B?ZHZ4cFZBWUNlR0I1UEZ6TUw1cWhNYzNkdnFrTTEyeXF2d2I0dDBoL25KSG54?=
 =?utf-8?B?NGEwelB0bTk5VXI3NEQ5U2N2QWF6MlNzZXZoZ1JPdUY3WEVJRFdZZUtHTEt0?=
 =?utf-8?B?ZVNvbk1yMmdFbFREN2IzZ1ljYlVZNnBmM1YxQlAvcURKNHg5dWtvZXEwNjdu?=
 =?utf-8?B?SklxYjdKMVlCd2I3aThBcEFkWnpmc25nVUhVdzFWWkcyRVVaSXBNRmNGQW1s?=
 =?utf-8?B?RjhobzFWNkZPdDd2WU53TEVOZDNFanQ1NjYxQTk5YmdUNGhaejNTYVhNVDdv?=
 =?utf-8?B?NzhZZFZjOG1KRXpYVTVLdCtWQWZFSEZueUpDSGdhRUFzV3Yyd0txUlRINWZm?=
 =?utf-8?B?RkZuazFObk5KUVpmRzFrU015ODg1OTExNDFvMW5kTTJyQWVQWGdFZ1NaZkNy?=
 =?utf-8?B?cmZIb3VVdXJtSTF1Wkl5SGxSM1V6dWkxNEFEd216V3hDNlRRbUY1QjhWT0Rs?=
 =?utf-8?B?d2JYYlREdERaVk56Smw4SHI3T3BVeUd5VW9FQjFvMTFZd2JSLzVIajBiVGNR?=
 =?utf-8?B?ZktuTE9ucWdTMHh4UjM3RGtQeTJqQmZpV1NWWjk4TzJvMHpBdFQzZmpuYnZB?=
 =?utf-8?B?L0JKN0lVNmJ3Y1BlN2JIM2tRWVFSbWtwbExFbGxDcHo4bm1MbGM5YmdHbUsy?=
 =?utf-8?B?RmozdnhHajdNSGxJVlNrdE95aUo5QmhFNlR4ZzdIUXcvRDJ4RlkydnRqcDRo?=
 =?utf-8?B?djY1b0p4U2RReEZIdWx1dEVyVVZnM01yTk9aK2N1OUc0WmVoR0RENGphdkRE?=
 =?utf-8?B?Q0FNcE9ET1E1U2xNaDhBaEtlWVBaNGdUNTYwNytMR2tCdlZlNGxQZE9vTXA3?=
 =?utf-8?B?VlZQTW8yZVFVbGVFa2krSFA2Rngvd05QS09hakJDSHNjRDBtSWtZZDNxYndW?=
 =?utf-8?B?dFV1UnFObTdKM2Y3WnJ4VXdLckpGdEpuNHoybTJ0YTdYTmo0dk56dmJCMGlH?=
 =?utf-8?B?OGdkOTV2T3g5QnB0RlcwaEZXTXJZNGQ4T295ejNWSk1ldVAxNDVVYnN6M3Ir?=
 =?utf-8?B?czk3V1VyRkFVVVQ1T1h4VWlnY0VobmNvQ2lteXMvdDI2YlFIMXR0MHJnZlQz?=
 =?utf-8?B?eGZ0dzJqWmNpRDNIbDNYTnc4WDBxaFNQZStCNUNYbCtwcHpCNG5hcVF6aFk5?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D8FDB66A4BBD4BA4E3148ACC7BCD29@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RKZ14Hp67Jl3R2ZffZ9CWFnSsXZV7+ZOYJJr6W6AlQfHNX5/cAh5LYOAbXrnjyEgTCGiekqUS3Ih55UGcYuR6G8Q1xEHVV7/QCUsPFYSTJtEXtXOHMKgZU1OiJEuu7OBOfMNdjv4TyKvoYgZ6nQiCf/gfWeiknhklX4g5dDsscgT3LexyFwUJKdKszJ/1+NZZj2CQCBvebeuwvBx/KzAVUg0piM8Jz+aC26essTn3ZfCGmgsFgQAKMW28FACnu6CqMxJhQsd2SzbXfddxm4R8skAGgsZeacjWWST6il+t6FJu3zloVhLiyr73zKhBp/5jacyzqB0TIpdr9/+jVh4afy++luxyb6SenVsZfZ6QnzcVTlVhPf7KlKSsXJoVOcYKzNrO3eNI4HpgGPKTfCNTjxGJmAJyAGhqT9dVrX22fpGpGlDfSeHdiUicI6FAndlXjCTnRQS9sL5UZPGp+UH0k3bujaCBCSzCA0yOjUSMw6Ru/RzYF5U3bUj/GeA9hHA+E5LupZ7ydgLVnW8LtXyKimOPV46pJ+YpBgVsuwpIi+38tAZZn4aEvcJF1YW62AIfs0H7LXq4K0WV8d65UiivhZK96Nx04ikoQOUTmtq7PTk3s+3sZ+n597QmxpKihTSofwbyfxV+bEzzexLbrE0RQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2679b36e-d3bc-4f99-e622-08dc9247eee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 23:14:42.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8qA7vQxDFusSLcjWmijFYv3iWI2LVKoFnSx7k+juK8GW5yYbAvbELldjjOoOUUAzCmjxogZvSt5TRXFjlhfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
X-Proofpoint-ORIG-GUID: 4LAwFjLpk5WXzahYKhG5uCC-g1CjVUCd
X-Proofpoint-GUID: 4LAwFjLpk5WXzahYKhG5uCC-g1CjVUCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 adultscore=0 mlxlogscore=715 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210169

T24gV2VkLCBKdW4gMTksIDIwMjQsIExpLCBNZW5nIHdyb3RlOg0KPiANCj4gRG8gSSBuZWVkIHRv
IHNlbmQgYW5vdGhlciB2MyBwdWxsIHJlcXVlc3Q/DQo+IA0KDQpOby4gR3JlZyBhbHJlYWR5IHBp
Y2tlZCB0aGlzIHVwLg0KDQpUaGFua3MsDQpUaGluaA==

