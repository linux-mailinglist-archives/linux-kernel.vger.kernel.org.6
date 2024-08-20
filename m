Return-Path: <linux-kernel+bounces-294615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015BB95903A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2624B1C21A08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0E1C7B71;
	Tue, 20 Aug 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RMoQUfht";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aeBtxAj1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ooy9we1w"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62921C68AA;
	Tue, 20 Aug 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191566; cv=fail; b=sYiiWdTLmxLqvlY3mOeyYOYu3eWaZATAWW75iMVULa2wJzqa0vFkn84sMXY4ujsjFls71n4zNELna7tFzxq0i7kOv5XPZLFL7Qb+YdevirGUXq1fFWozOHta/rlOXt5uREzHWPcqmtGVmok2fpLhLB1v17MGZYYDbhGCQ2W3CpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191566; c=relaxed/simple;
	bh=OXQqZda2rDh2vMH13pRvM1VX7LhPXbsnnf+F7TbkR7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0OhzfvLONtotCvdzDXRzHbeAlJ0SOvnQGh/RJcovaBwNkhLjWsM51qCDy+E5uDFktVCUEX9rfl11ur3fUl5AqN7Povo5egPkitfLXGNsGGNd3tWmPxBhkPona/jD+yy9AYzOrmApxzWQweung9JtQX7DE9H4jrVkLYAqR1bsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RMoQUfht; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aeBtxAj1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ooy9we1w reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KL0bY0013619;
	Tue, 20 Aug 2024 15:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=OXQqZda2rDh2vMH13pRvM1VX7LhPXbsnnf+F7TbkR7k=; b=
	RMoQUfhtPJ5fDy73NNSj3K8iG97CkwqqBsQtPQKK8KJWyRT+EUtnjTViUAclqMTN
	hTLubjQvbGQQFM58DhkklA5n/8z+2FWfyf1i3wd2m8q0SqJpXtevtMbWjUwn78bT
	3a054rXQ0h/fM9/9c2eOl4V3UEnzULwfN+kw9IRNy2OXqdyg1iQ6vSMvcLKfjrDC
	sIo7SGk4emeHbccahvwvZ7zyqbfAbefSWz/GuLiQ+BCWFCTB33Kw6tYMrRRp6tYV
	Il1YYvW34FJWyZCFAjgxX0G7Yn9aUqWNrAZi4IfLxCrnFQ/NVxwAOR+whtJLdVqP
	ySheIZ8aVNknR0/4/jhdIg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 414g8kw75k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724191550; bh=OXQqZda2rDh2vMH13pRvM1VX7LhPXbsnnf+F7TbkR7k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=aeBtxAj1jeHvkP89MRKtgopvRqwJ3YXarPStbalX2CvPr7ACEOupW4Dow8YnRKLWw
	 5gNsTNamH4A+939ewbfGZUafRku+ZTsK9PtgQSmPRN2Or9wh1si8LrvDFuZEX3Vj03
	 MEF6iWRiiZEjNiyGkkWtVCZ0zcW9LRgThEQonXHFkfEg+9xVRaJMo5DM5lPPhCheq1
	 yV/P7KU0I9Yz4Xi/M7lcRf4BPuWjtCwNFli3FB9+3lGqabOvTktkFryVfhb1JR4a+e
	 RKrd89lGENc4OxGCIentSs8Z0+VJZgijw5Dh5C3o//nzGyxqD2JQzpreg1fIdQf6qp
	 hjdTu2YAl1WPQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 195AC40235;
	Tue, 20 Aug 2024 22:05:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 979BBA00B5;
	Tue, 20 Aug 2024 22:05:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Ooy9we1w;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AD2AB4028D;
	Tue, 20 Aug 2024 22:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFcUWnbENi6rogYrahH9YKYTGphzpOzCZ8MJSdXR/eGr/iJJxUspWJV88IzZQZuvuu4/YZ6RjkUmQFKdRs3qBcT+zk9I2IJYCbWIMzxzXEF8Uyc/a411cG6lAzsmxCnBDaZNq5QYeqBX0lm6wLjvIrZ2YQsS/frxWnIIxSA0HOZd1U/eS0GSKGBxV1fWP1AB4aeCRgTM8VxACLsYSSXwEyrOxjAN2oBVl/mf9npjWZtX5LmpS9bfUP8XssiL/SMWdvQqRihGOKyQikRwzJUhOWB2xLoxtqbXl0F5xW4H/BG8lQLYDtaflu2wz3R4Mwp7hUEzJ5V8/g91uVEwN3qZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXQqZda2rDh2vMH13pRvM1VX7LhPXbsnnf+F7TbkR7k=;
 b=xdnVMC9WYW25K3ceKTlffofH3i8oV+0acnoWHNZHZmZqkMTtR7P4jlfShM1k1oxMHcvw4V4mqfM1xS3YU/+jX70MwG9nnWgCXIWKjnQQXNLSziiE53A3qIMG7mf+bDKlFSB50BncDLzn6mfIpE1t9W6SkEyldoBUkdY0FhkJnc/hccy7kbWnl1qvEYGCVPRW/UN3KEgnCoIVvJBASVVoNm5Gu9HibV2yjFIaJLpEFecaCxNgI8doQC0sfPk+a/QTZ+tHF9XLNj5fyOC/IKbgHY/vmAkXvmzb2JHoQWneqSuESZpBaA/f/4JAP2vk8mFbD8K92FeUA7jTqkrvpOBvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXQqZda2rDh2vMH13pRvM1VX7LhPXbsnnf+F7TbkR7k=;
 b=Ooy9we1whcX5gX7Enjm+wtzzsySXI9wRNLesg3EAJ0cmSDIBbRao6lEUa0+tO7nOwAXR4x741AwXiYDx9DPPfn0CDfYKX6suZvj1NeI5HI9Mho0hYkWdWYOIjQ7OYU8Z20vaMII8CbIxmbwPoRusRaJHIQeWOYosKahT4U4qLBU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:05:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 22:05:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc3: core: Call cpu_relax() in registers
 polling busy loops
Thread-Topic: [PATCH 1/2] usb: dwc3: core: Call cpu_relax() in registers
 polling busy loops
Thread-Index: AQHa8vquRd5MnaF4v0u9WVpe/56vVLIwtDUA
Date: Tue, 20 Aug 2024 22:05:41 +0000
Message-ID: <20240820220536.lgxvvbfboheknyll@synopsys.com>
References: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
 <20240820121501.3593245-2-quic_zhonhan@quicinc.com>
In-Reply-To: <20240820121501.3593245-2-quic_zhonhan@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7577:EE_
x-ms-office365-filtering-correlation-id: 53d92d0e-5b35-408b-b3e2-08dcc1643b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEVxOFI3SkFEYUlobFllTjA4ckg3ajZuc2tpM2pEU1BKTjhHRTlsbTM0WU0w?=
 =?utf-8?B?dUFBSFhSVktMcm9vQzVNNDNkQWlXeGdqMVN5Z0NVU3g5U1BXa3hpKzR2b3Zv?=
 =?utf-8?B?bnQrekZOUU9jU1p5N3N1NythNy9LSUtkOThjLytZbzhUTmY4MXU4VEY2RTVo?=
 =?utf-8?B?UTRMbUQrR0dubkFXYUFmMXdXME92Z1JwaWJvYVY3enZlMnRzNmFSQWlMMDlB?=
 =?utf-8?B?Vy9yYTVtN0YxTENBYTBsVEpoWXNibEJPVDJSRkZCTU04OE5PajI2U2puK0tj?=
 =?utf-8?B?YU84QWNsaWtrL3FmQkdVdUYwM3FZSVEzYzFoTzNOUmtWMjBIeEx0dWxlZ1FQ?=
 =?utf-8?B?aml2ZE5xTEJKenk4dWJndEFMSm5VL1JWd0pNdEl3bTd2bkZwMHJKUi8zZGo3?=
 =?utf-8?B?VVJQdGs2QjZYUDhlRU90dkVUa2ROSGdRRGlIQ0NDS1NiM2UvQ3kzUEFsV09o?=
 =?utf-8?B?ZmpDbDd1M0tqYnVSSUpYcC95WWs4VGxLN1lrYnJSZkp0bEFueHlUaHR0dUZO?=
 =?utf-8?B?QmR6d0ZKUVNDQ2ZjM21YS3hHdDBzbjVmYW1hMFRIRkk1NTBBOGZSNzZ0YWNh?=
 =?utf-8?B?L05BZ3VHT0lWOHoreXhKSWtzY2k1ZzJxOVdDSnFPd2xFYjJFbDBkOHFWT2xG?=
 =?utf-8?B?WmtrYWpjcmZSV2FLamwzVEwraWtrZ2lHYVBoT3JLVzFOdW5VY3RzUlcxREFQ?=
 =?utf-8?B?LzIrRFd6TmxPaHRYSll6ZmNxRDNuZS92U1RxV3JFdjViT2tDUEYrMXlNU0tk?=
 =?utf-8?B?R2Y0UDVCMWlzOGt5SE1JNDFzMU9hUWFyeHBZelltdkl2MHQ1Rkh1dE1Cc0JU?=
 =?utf-8?B?dzJVazIveFppQTcveHp1NnVnV1V5R1NaM05FaHV2OUVOay9Da1BRV1NVZmd0?=
 =?utf-8?B?WmpaZkhtRUhEamoydUdJbUJQRTdoazZwK3AwRjNVQ0lNZnR2UEtuSGpUQ3A5?=
 =?utf-8?B?UENjUDNJNVJSQnc5dFBwQUc4VTNpZFU1VThnUllNRDEyVEFoTlB3T3hqUW5o?=
 =?utf-8?B?L2tiZTFUQmFzUXlHZDU0SjRBWXhRbW9iYXFJaG0wVnpGUE02RWVVRnh5UWZW?=
 =?utf-8?B?TE4wRk9ORVhXRXREU1NUT0w1ZzZ3L3Z4TFlQWFo4Z01PdmYxWnJjOFNyclZ0?=
 =?utf-8?B?bTQxdWtwVnczTVdtZEM3QkdUMC96U0xjLzlqNjc4eEFCY2VmZFVGaEZaWEln?=
 =?utf-8?B?a25sWHFTT0RkYmF3eVdjMkRUNUl3NTZpbThERzFmakVwQXUzcHRhS0FFbXJB?=
 =?utf-8?B?T0dBZnBzbzExQWtDUjVlVi9NbXE3dUlCV3V4MnlPbEU3ZVlnTHcxK2ZmZllr?=
 =?utf-8?B?aVlsYlV6V1pad3Q1SHZkTThQc3RWV0wxb3FDTVM3aTlRcWF6WkdXUVArSUdz?=
 =?utf-8?B?U3VjVyt0YnpBOG1zUVpHeWFURTRBMTlqbDY4YnFHeFhXNDhFRVN5NHQ4Slo3?=
 =?utf-8?B?Rm5WUzN1TUlwaHNVSGU1TUdFR2xTK3A1SE8vWCt1RmRRYW0vcE5tV0wxaFJM?=
 =?utf-8?B?WVc2UDZ1TFZHSkRzb1F0UWdQWm8xSG5lNkNudHA2cWFwOURoUHk0cVZMeC8z?=
 =?utf-8?B?Qm5OT3U1WDRBMURCVUozT2QxN3VyT1NCaHRlOHYxRVZwYlFXcE8xMmF1SnpN?=
 =?utf-8?B?bzl1YWxYaFEyNzZ1SnhQam40K1lDVW5rRnp0NXQrTHc1VHkrb1BpT1NnSEtU?=
 =?utf-8?B?OFFVY3pXRmpxK0ZXbWZHd3dPM0NjdWM0WVJsL2ZocnFVbDRQZEJla2ZnMHpp?=
 =?utf-8?B?UEEvUGZ4SU53aHFGbVBDNW1nZS9GRG1BNGNCVTEvc1BjbWF6ZFhBMVFFVzRx?=
 =?utf-8?B?eXJVNG1tVVNUcWpxb2ZQWnFGUGtwUEhYVmJ5Nmhzb0VyTHpVZGtZc2o1SGVz?=
 =?utf-8?B?TTU0QXc3U1pSbmFJZzBmRzNVWkd2RGVteWFwL1BjZGFsWlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVFWZDVUWWh4dEsyUDdFZStWRkVidzFVd2F2TTNhY00rRzNlTXB4VGw5NHho?=
 =?utf-8?B?dWlZbmVPQThmeEtxcE9FSUNPYWlOOTd4QUZrS2xqRUpyK0RESkIvTmlJVEw1?=
 =?utf-8?B?K2FKTGJXUXBCMmJ2anBodW0vY0pTUGwyRVBORk5xaU1nZzN1eHdRZjBMWFBn?=
 =?utf-8?B?NlVvU1NVeDVyTi9TbFJWdjdJeGs0VzNUbHU1QlFDZ3pNdnVqditScmhVME1Z?=
 =?utf-8?B?aXp4N0dEbGdYdkc5amlhSUMrdCtKUkt4RDhpRTVZcGxuOTl1d2xHbDFCVi9T?=
 =?utf-8?B?bmhUbmRMcjdSTEk3bFIyYkp5eXp6dVhxNm5wOHlHS2JkbzlQdi9aSThBQ3ln?=
 =?utf-8?B?U3hxUDVEWWxYK3gwUGliRU1YenNzbG1ZeGlRTUM5WW40SnpJeHQyMWZrU2J3?=
 =?utf-8?B?a0xBN1lpdnIxVlN3enR4aEc5TXYvM3Y3RFZLcWVUSzFCWmVmWHl0a00rbHhZ?=
 =?utf-8?B?Qjg3M3FZWURTVHpHaTFwZlRXVkk1ZHUxbjkzakdtbFNDR0tEM3NaQ05aazk0?=
 =?utf-8?B?dlllaXZ1eHhLWW5WSU5JbWYzUHNUdk81aGt2eDJBSlA2NVVTVWgydzk0K3RT?=
 =?utf-8?B?MHAzS29FcmR6dFFQVnVaY0NwS2FxZGM3UGpOaWQvNW4yS3NxUitxNG1xN1hP?=
 =?utf-8?B?NHdZOWlCSzQ2aG0reVNUOEtGdlVrM1I5eVNlUm9jWmtxZ1NEWXYzQ0liV2dy?=
 =?utf-8?B?NTFzT3ZRcFVtSTFPRDJQNEh2RitPdEpCM0JBY3ZmU0pjbVFORXh4U3lmbmxK?=
 =?utf-8?B?QTJGOFJpbVVVUjNIblNtaGxtWnZFc0pvNzh6QnhKeFA4bzJMbk9YSk1GbmZw?=
 =?utf-8?B?MURHRGN6Q0VVR1EwRGlzQnlQNjQ5UUhEenBhWUtGOHpjZVNpaXVabXhZemIw?=
 =?utf-8?B?T0UyYkJtTGRtY1VUU3p1M21WT0hQb3VCbllBSEltUFZpL3Z0OW8xYlRlOE42?=
 =?utf-8?B?eEJZRENEL0VSbEplMVJxYUJNeEVxK1NRWHBUNDhOZ1VIWGo4Z1JmUG9Pd1h5?=
 =?utf-8?B?MXVROERId0hJWWhIUXV2Znk2N0lMTU9lbTcrUUNIbUpMN1BPUC9OU0paQ0VL?=
 =?utf-8?B?ZHZtOU9qakFZb2pJZTJyajQ1WkRsSHpGMkQ4YkNZTytPemlyWmVjOVNkS0py?=
 =?utf-8?B?Uk9EQjMyWXVaYUI3dDBydG9VQy9TeElHc3o4MnhuMTh1czBwTU9uR3d0d1dh?=
 =?utf-8?B?Y0NKNGNpakZBOGxiM1JwQ1ROWFBFa3pRTXl2dWlnR0RsVW1QUDJJeXl3aTYr?=
 =?utf-8?B?cW8rWEFMczh3RDk3ZEFrdVZIZG9GRW52YllINHBrUEo4d2VOL3lIYjBBU1Js?=
 =?utf-8?B?YkZqc3VzVXE1ZENCODN2SXhsNkhuSWtIMFhpcHBocFpqZGU5Y2hhcjRERTlN?=
 =?utf-8?B?MTk3dWlBYWtEU0haMVF0UzFwOWI3amNvc3dsSnNUaXJhbGtpK3Vxb3hWZVpZ?=
 =?utf-8?B?SFFqMzR1SnFwYjQzV0JHWFVTTjd6M2hQdlZVbHdLc1JsZzdPeWVmRDN2c2VV?=
 =?utf-8?B?YzI2c2RqZWdVSUpxR3NzQTNmYWRzMlB6ZktjdmdhOVJueUJZNXk5R0l4dHlS?=
 =?utf-8?B?bjRWSmlYU0MreVU0T2dnTXEzd0NpQUVMay85NjU5aG1rK2ZUam5vN3ZYNE9I?=
 =?utf-8?B?WnJxb3VCaVNEYi8ya013R1ptRHk5UGVCN2hxSmxUQ0N0RmZHOG02RmdjRGF3?=
 =?utf-8?B?YVF6cWc4MkRRUUhTS0kwTGQ4SHZKMXltVitqT1hLRmdHNHZ2VHZDVVh5RWxa?=
 =?utf-8?B?WXRqeW1VckRIcTF4TGl1RDFGN2xPdjdMR0xtY1krNGdjTlpLZ2xjQ2ttNHJI?=
 =?utf-8?B?RmdzaThOL29lejFBSEY1VDZIT0hadXlLOXRBTUYzL3ZsUmZDUDFXNzNWMXhW?=
 =?utf-8?B?MVozcmYramorTWlld2xWbmFRNTlWWkcvbG5NWTFjVXE4NFM5d1dXQkp0eXg0?=
 =?utf-8?B?RnpLY29VRy9tdXJLMGRjY2s2ZVUxUTJwOGprR3hvZm1iR2F6eXdDRTFyVHJ0?=
 =?utf-8?B?eUdOUHBPTk9RV3V4SHc4MDQxMHZCVktGMDZzOUJoU3ZndFZnTzVzYzk1Q3NX?=
 =?utf-8?B?M25HOGg0bVlEalFPb3VrVFBxOU1XYWR3L0FSS2d2RktpdGFwVmhObHU2bEJ2?=
 =?utf-8?Q?gT53SddDz8mzmU/nrYHv+28hV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6005DC798B88774AB14AFBD711A46917@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s3vBPWCkmWDdbPPRterUx5lxy6xF8EKwfOIRYdeTqAgn4smLxjYjVB6KndlxAkrI2ES9WGgD6HUIyNRLC/MW3JaL8iFN6vl9QYR+ytAjFEAsju68NXluBX9egXiwsgft+7L1nuFDz9d67/X9QniTHpSIq/tez/6rbxjyRZLa6CMWkwZ8Aqj4ucUNT2EcbyFfULtSP88A0B1FyvKNcADRwS9BE11FZ+eoTRpHTRA0yb8joO/BQHqo0Ng1g6DVp1esNhV0y1GnFDUQyLez+7A1mwxnnc7GLcyXDRKrrwihWCN3B6OQ0/ZU2LuoDwhTjcI736ST5W8cojOsBHj5DuVPUFEJUmZml/3JmdMl53+N3R34AVSa+ezWcBzbBfMlAxpljwLIblbuRacsW4Y4vhDPCBT5ZqaG65lvPQH5Vtdv7fWa1StsKN4jaQwCJRFV50oKkfpjuPfHwP86YZoN2yC6swBJwqQJjFz4OX68IPHvW/oDktv+O/oQoAqwtnJ+ALGVqc3J4Ba4MZTdxui9emzTsFV336iRaKwW+zMDmx42aMM5S0k2K+dbKLLcOv6yyUYzzwpWTysr46VIQyCIC5HvascDxPVGF/u+n9PPBBN2UGNPPcxot/XVxFEXzvMFdiLY0enBCkH9um4pbNgqG2WXuw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d92d0e-5b35-408b-b3e2-08dcc1643b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 22:05:41.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iWaZfB9gyTIc95C+9Lz0lwtUqF/4oyQGs2dNM+n+Ic0H1WLSCcWSmVHMhLGNOmqnDqMLtxrr0I0FdQle0l3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Proofpoint-GUID: 09n4z0Tk5-Ny-TyBnRVa6kyDqHn7ZWce
X-Authority-Analysis: v=2.4 cv=T4TeTOKQ c=1 sm=1 tr=0 ts=66c5133e cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=COk6AnOGAAAA:8 a=5znjJJcOrfHczkz4pwcA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 09n4z0Tk5-Ny-TyBnRVa6kyDqHn7ZWce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=671 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200162

T24gVHVlLCBBdWcgMjAsIDIwMjQsIFpob25ncWl1IEhhbiB3cm90ZToNCj4gQnVzeSBsb29wcyB0
aGF0IHBvbGwgb24gYSByZWdpc3RlciBzaG91bGQgY2FsbCBjcHVfcmVsYXgoKS4gT24gc29tZQ0K
PiBhcmNoaXRlY3R1cmVzLCBpdCBjYW4gbG93ZXIgQ1BVIHBvd2VyIGNvbnN1bXB0aW9uIG9yIHlp
ZWxkIHRvIGENCj4gaHlwZXJ0aHJlYWRlZCB0d2luIHByb2Nlc3Nvci4gSXQgYWxzbyBzZXJ2ZXMg
YXMgYSBjb21waWxlciBiYXJyaWVyLA0KPiBzZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3ZvbGF0
aWxlLWNvbnNpZGVyZWQtaGFybWZ1bC5yc3QuIEluIGFkZGl0aW9uLA0KPiBpZiBzb21ldGhpbmcg
Z29lcyB3cm9uZyBpbiB0aGUgYnVzeSBsb29wIGF0IGxlYXN0IGl0IGNhbiBwcmV2ZW50IHRoaW5n
cw0KPiBmcm9tIGdldHRpbmcgd29yc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaG9uZ3FpdSBI
YW4gPHF1aWNfemhvbmhhbkBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IGluZGV4IDczNGRlMmE4YmQyMS4uNDk4ZjA4ZGJiZGI1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBAQCAtMjA1MCw2ICsyMDUwLDggQEAgc3RhdGljIGludCBkd2MzX2dldF9udW1fcG9ydHMo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAkJaWYgKCFvZmZzZXQpDQo+ICAJCQlicmVhazsNCj4gIA0K
PiArCQljcHVfcmVsYXgoKTsNCj4gKw0KPiAgCQl2YWwgPSByZWFkbChiYXNlICsgb2Zmc2V0KTsN
Cj4gIAkJbWFqb3JfcmV2aXNpb24gPSBYSENJX0VYVF9QT1JUX01BSk9SKHZhbCk7DQo+ICANCj4g
LS0gDQo+IDIuMjUuMQ0KPiANCg0KV2UncmUgbm90IHBvbGxpbmcgb24gYSByZWdpc3RlciBoZXJl
LiBXZSdyZSBqdXN0IHRyYXZlcnNpbmcgYW5kIHJlYWRpbmcNCnRoZSBuZXh0IHBvcnQgY2FwYWJp
bGl0eS4gVGhlIGxvb3AgaW4gZHdjM19nZXRfbnVtX3BvcnRzKCkgc2hvdWxkIG5vdCBiZQ0KbW9y
ZSB0aGFuIERXQzNfVVNCMl9NQVhfUE9SVFMgKyBEV0MzX1VTQjNfTUFYX1BPUlRTLg0KDQpXaGF0
J3MgcmVhbGx5IGNhdXNpbmcgdGhpcyBidXN5IGxvb3AgeW91IGZvdW5kPw0KDQpJZiBwb2xsaW5n
IGZvciBhIHJlZ2lzdGVyIGlzIHJlYWxseSBhIHByb2JsZW0sIHRoZW4gd2Ugd291bGQgaGF2ZSB0
aGF0DQpwcm9ibGVtIGV2ZXJ5d2hlcmUgZWxzZSBpbiBkd2MzLiBCdXQgd2h5IGhlcmU/DQoNClRo
YW5rcywNClRoaW5o

