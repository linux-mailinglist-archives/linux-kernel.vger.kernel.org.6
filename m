Return-Path: <linux-kernel+bounces-218447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4847290BFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96B8B220B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85019A29A;
	Mon, 17 Jun 2024 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="APk63HQD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HLSZFXpB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mHDknYy6"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF9288BD;
	Mon, 17 Jun 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668798; cv=fail; b=P8ztWoo/s88FtICrIjFhumGzFhYHvhh6j8ameHc2Y5C2hWMPUO4o8a43Zwe7SwsxwP7/lUdjaAn35TjIsftFRa9RbIpW/02q/H0KP/wTWJcIWWhYzpLgj50wbgZcs3cIq6v1x10oalSrEgqJIgKM1U9PgiM8nFLHwA1D0XvsB7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668798; c=relaxed/simple;
	bh=oeAQP2w1lko6RNbm5QrAMk/f9WmSp/w2UK/c4yAaQ/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecfeLVIZQegm31E0tvFpHx/ipJKJ7JD/zEbAjyv83zjfk4YigCZzZtdutKobyT06O0uYJojWLvTfQaf6tX7aDtdbKYGJEBOQpdZeZumAQxpYph7jfJyh2ZINxwRf3PgXy24i4WNSFTqPvE9hUjjJv+Mr1ciZqiW7wu6PD4kWzaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=APk63HQD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HLSZFXpB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mHDknYy6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHEHeh017822;
	Mon, 17 Jun 2024 16:59:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=oeAQP2w1lko6RNbm5QrAMk/f9WmSp/w2UK/c4yAaQ/Y=; b=
	APk63HQDzbOqfBDFAZKwpfWDo/HBhS2hBUEb+2zXxpqXXEIsdkK3YJHu+nlEx1J8
	D6LdrlPCEF8cGJ/+pJDzl3PL/N2dVmGGkkTR55CYIS8WIjMBcO57Ub9gWugWaJCl
	ze+zUU4Zy5covgkFfydoVDSR1UGEsJbBjuwDn8n+2oM38cWrai/ahqF7HZXa3gSf
	Y/PPdxCHUK7ry7i5l7Rz/UT1cQ9iOIuxUBt89fzJqj2RvawbpM/eYwRr+fTrhPRQ
	64tW+iJ6DyNYjCE5iM+eU1GhVLXimKWkZf0IfCI7pBji2rm769kqRpDBkqdR/mMF
	CbCxTHeSGRVEEQVkEF2l1g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ys9ykfsnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718668783; bh=oeAQP2w1lko6RNbm5QrAMk/f9WmSp/w2UK/c4yAaQ/Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HLSZFXpBCarjWEPFKvAI3oVKUczwP5VMFpVyUtvWNF4CQA8sFdaniA3W4T6kOa9x3
	 SbEur6QQIkgIdDPWHzTH4E6dLtFkEmfOwY/1UchIeOFVBbSRnqDlHh2+zhbG5gINMi
	 dclFb5D98mhqjXoSNMOwhCIsfXW+Eubhodz8xAbryg1fPMHMzYG9JzxUqbY0PmSTYy
	 8E/1q47kjvuwFvdmBWLMv3tMsUxvG2jGE7S2HRChXsrQzH4UH9/oUfdR9d/jxdXQQA
	 5xN3mNRfOBpRGawQggI3lnpx9PhJ7xfEQtK40T0t+osiJStalBswIK4C3u1k1k+FTs
	 XH2QWILnpuhow==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6770640141;
	Mon, 17 Jun 2024 23:59:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C20A5A0077;
	Mon, 17 Jun 2024 23:59:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mHDknYy6;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CC6440355;
	Mon, 17 Jun 2024 23:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwDYmzLQNvX9uqKiOKi/wNrxZYzRij20cjM02knBUJ/vi3joYLAco582ZZuIpkeWt6SWBo3KJDmIkhyO0lAavtXQ4oPBJ9q+Kj/iP7+Ogk7oB38aef77QfdUnSGUlZaj/yYO6sTPolOYV6n546lUy95pzYdrV6+9kHCgfX1WN1HTN//TQevntOyLQBrEP0O321FWT+/VC+tjmL4B4EWwz8CpvYiaiJ79g8mtO5ILbttzJGYLiLi4Z/z9NwX5zP1MEz1xzXi/b0GLVJTj4Pb8oU+P8bHE2o1q7VIhfwcQemPO/7iNcWEI/iLTT7LUK4QoF50gidq8sxKIq8ScFm5UVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeAQP2w1lko6RNbm5QrAMk/f9WmSp/w2UK/c4yAaQ/Y=;
 b=HvApwxUp3TQtu3L0d2FvtuvIw1A6jzOgs5q06ZRGmYCRza4nlabRIgDSBpkCAkkc5BpoqmPfdxkc2OStMOHCvlSlJCwjb/bLt5VZXRUzsG2PbQUhOhjJ6/UZfb+oGMH4ENEkdAg6OyFGpm8MGraLL5s+fdxEC9JKCETlPQ7rre+9jcXAzyG4jMdhYG2t4FQpJ7MTFCjd0uL+EwrUMDp1PDOXuJpZ3Sol934wAu+gm8+++9gqfuKIQTyWmnRTt7g07lkOvwx0X7f2aGM+VdeE8D3fh0O9rriUhXSzWwbUO08i0R/QFFeMQj+0w6/JPkgcCl0dv9DTQgXKmiVTEuLRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeAQP2w1lko6RNbm5QrAMk/f9WmSp/w2UK/c4yAaQ/Y=;
 b=mHDknYy6NBMHE06Z7Tgbl9xJ2q9xHw1MGbtZEmRXSeMkhdERdgsvRPVG9t6gcu+GZxafsW0Qs6FgQduSj8/L1sb5ugD+jnG5a+tnDMYkYzXLm0NweK/0q8Yb9t8LqHrkweSQ09AxMd0pNk5HjsDFT18DxP+fjJmWRMmQmc2X1Bo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 23:59:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 23:59:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Li, Meng" <Meng.Li@windriver.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        Xu Yang <xu.yang_2@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Index: AQHavWVUPhM/ru+zjUCO4n4fhUYG0bHFVmIAgABBD4CABxKAgA==
Date: Mon, 17 Jun 2024 23:59:34 +0000
Message-ID: <20240617235919.e67v6jlofzyrvr5x@synopsys.com>
References: <20240613073959.1939608-1-Meng.Li@windriver.com>
 <2024061313-october-sniff-5b0c@gregkh>
 <PH0PR11MB519103593845FFAA819A92F8F1C12@PH0PR11MB5191.namprd11.prod.outlook.com>
In-Reply-To: 
 <PH0PR11MB519103593845FFAA819A92F8F1C12@PH0PR11MB5191.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY5PR12MB6204:EE_
x-ms-office365-filtering-correlation-id: 9aba94b8-0662-4efe-aa9d-08dc8f298972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Si9BbXpUbVY2NUkvNWRKMjB0SjMrOTF2bEFzc2JtRUN0WXkyM0ZOMlYrUEpI?=
 =?utf-8?B?NktBaktpOGxQNDdNRCtDZ2M0dVYrVEdGMGJkLzlOU05XbFY0bGRnaHFCWWsz?=
 =?utf-8?B?bU5OVnpVVEhtZlMyUW54UU5ReVpiMXJpWnkrOW1tMU9LbnEzUkFORWV1b0xS?=
 =?utf-8?B?ZEo2L2tUa2FEOGc2ZU1jRFFwakozcHdlbHA0UmNBY0tYbU9DcDNlYU1DekZG?=
 =?utf-8?B?WWloRWxhSTNjSFFFNFh3cjB4am85UkNPZTNpWjFSZk9hc1dDSGpEajg5aThD?=
 =?utf-8?B?Tzk0QW9VZXVYM0lodTBVYUtWOURkdnNPMCtWT1l1ZDFDMkpKYlZKUzIyTys4?=
 =?utf-8?B?YlhZNXhqMFBlTUNSdUIvZ3ZCK3hubTNjSldxZHNtZmdnZS9LZU1remd2R2pT?=
 =?utf-8?B?b3MxRGVWN292SGN1VzBVMHFxT1JzVjFHK01zR0szZUVsK2dHbzVxVEU5OXpQ?=
 =?utf-8?B?d1VRbmVuSnhPcWIzbTBROUY2bWxsd2xVU0VPbDI4eXBkZ1VLK3RzNEFRTnV5?=
 =?utf-8?B?eFY0N1N5dXp6MTNKMkhjV2pSakdMcHkraGZyVVF0YjBkUk1oWHllZDBjZmZi?=
 =?utf-8?B?WlBvS0M0QnVITHdtSjNWZWtHbzdGUkd2VVUwcTQzQUw4bnJZWGxSTnpQSUpI?=
 =?utf-8?B?UGoyT2NNU0JOSUJIa09DY25WMWJ1VythbVUvdjIxUlo2MmUwU0lLcTJYTVZn?=
 =?utf-8?B?RndUWUt3N0RjbklGTjlWUitVaFhtVDRtYVZpY20yQjZFR0VjMmd1VXN5dVNG?=
 =?utf-8?B?Q0o2Ry9aT1BZc24wL1F0eS8vdXZ1NjR4NzRJZ3VmQ1dRZzJLNzZWVVVRTjls?=
 =?utf-8?B?bXhNK0ZFZ1ltWWFoWnZzdFJzNmJnbUFDSExGRWtJWUFFdWdYVlhDL0drYjNp?=
 =?utf-8?B?RmlNSTdlQ1Y4Z2hUMzk0ZEVkeXgvVkRKZnJxcS9CTUVOWHBCNUwrRGdYS0Ev?=
 =?utf-8?B?SStXUmxiNGhSNGtyb0xpK1hVd0NWOExJVUFOUk01eW9HRXZkSzBuWlBLSkUx?=
 =?utf-8?B?ZUR3YWNMb1NsR2N6Qm5wSlptRm95ZGJ0RkxVTm43d05ib1c2VnVITG0xVXoz?=
 =?utf-8?B?dFQ2Q1d5WlJsRGZ1SVNtUnR2c2hNVytsLzdZOTZKd210bHU4WjNlZlAxcDlH?=
 =?utf-8?B?ckh2OExRcjYycENmZUJxd0VFMFV1eG1LVzNuU213QW1jRVRKUmhsemFNRGRj?=
 =?utf-8?B?dkY2RlN3TXpRRjhGcTdMOSs1LzVVNVpUYS8zK0ZYRFVscmpZZkpZcDZLTVg5?=
 =?utf-8?B?cmNhRFM3aGlzRURWQ0RQZDU2bmwvM3k4N3BmbmEvWm9sdWpKYlFHOG50b1dy?=
 =?utf-8?B?b3g3UDFTby92dFVHVXhLMWJvSkJGZW5GRmdFQndMNDM1VXBXaDVHMmJzeXpQ?=
 =?utf-8?B?TENHdU5QSVc3cVNZUjhxMEl5VkJOanZIcWtOUkp1R2tBVWRNMnBBakNBZWFW?=
 =?utf-8?B?OWkzVzJjUkhXR0tPMkFzRlJhcE5UWkJWVi9jSTFTbUhpdGw4ck9FcjQxWHFp?=
 =?utf-8?B?dnNIRnJDL0tMc21sQXB1cTg3ZjVXSE8yaDVkc0tMdDdwNnlVSjBXR1ZkakJL?=
 =?utf-8?B?MkRQSmJxSmpBU0FBNlVySWRBQmJKeHVQTHN3SDV0SkRsb2JaMWFrRjV2ZDJV?=
 =?utf-8?B?N1orTU93MkxCazFwaHhEZ1NjMTE5K3daVUJoNTc3Vytna05pczl1TzkwV2lS?=
 =?utf-8?B?N1cwSTRxZ1Y3RFdmMUxMd0xaclJ6WkVaWmgrcXczUmFRVzNaV1pSbUw0Z1Bz?=
 =?utf-8?Q?PydsXRuNN13h9ph/sQA5YAxKSY1xDg9XUPYSLwq?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dm0xRHZCd2ZIcFBHQWd4N1k4d3ExRVVUVUxhV3VrN1Vod2x2S3RzTWVyNTVT?=
 =?utf-8?B?TCtPNDNqSzh6VlZnUDl2c0cvSlgxWHZNL1IvUlQ5RE9QT2RDSWltbnZKWkZo?=
 =?utf-8?B?V3lqVTFEUDBYeWRqQWU3alM4bytMb1ZYamR3ZTI3ZDlEYXVSc3p1SFRLS01E?=
 =?utf-8?B?Vk1hMzNRM3Zna1gxcm1QWmFyeFhBWkw4WDd4Q1gzY0EyZktpcGJVdWYvMUh3?=
 =?utf-8?B?R2xqTWtoYlBFekhYN21pbm9IZzJaSFFtT1FmanlWV3c3T3hUZzRFR3dKNm1R?=
 =?utf-8?B?cVB3QUdxZzVjNGhtT0dYSDlHc21IUFhnY3lEa08ra0wzZTJ0QTJKR0lueVQv?=
 =?utf-8?B?TXdxVHg3WUM4bzY0M2didXgzMkFPN2xERW1RcXk4Z1F6Q3pqQmFqUGtjOHlr?=
 =?utf-8?B?WS9rS3Zud08xUXBZY05HZFY4T2F3cmdEYkRxNnNGYVczMFNUY0MrZjFCOGRy?=
 =?utf-8?B?Q1ZvNkRQMlJHbTZhUzFYaDhvb3ZoK0RGNFp6Tlp4Y2xsb2toRGRqN2swVjgv?=
 =?utf-8?B?RlkvWlVDVkdOLytEQ3NtTW41emdMd3RIZERLaWg4Ujd4T1lpRGRKcDFmc3Fi?=
 =?utf-8?B?L2RrUWRTcUlTR1pqbWM4SEZtb0RmOW44VmUxV1NWU3pIT0JGUHFjd3Npb053?=
 =?utf-8?B?QmlCQnlvRVdmb3BiQlBDZThQMWVzS2tQNHBVTDFvb1ExK2kzTWM2VitmTlhS?=
 =?utf-8?B?OTRVc2pXaG84RkUrdmNtems2Yk5yOEdwcEhBVE90ek8xWXVmUnpSalJFWS81?=
 =?utf-8?B?Vkt3S1hITG1tZ2ZOQWYwZU9nT3M4ckhJbVF0U05WZnNUQ3Bvay9kTytYQkpk?=
 =?utf-8?B?OXZyQmYwWTU1UTVzSk1BYnBRZGMzNTNKdTBNSXdRNGl6Zk56UDJVMWNWK0Qw?=
 =?utf-8?B?QTU3eXRoMi83UG1BbmxqUE9vL0hlUjdXeEtHbGFOYURUQTdPTnh1ZWNYQWp0?=
 =?utf-8?B?ZU5DdlhLa0NkbExQRWpJNzFHVDFnM2phT2lpQTMrM2craHpaMVAwSG9KUlcz?=
 =?utf-8?B?Q0VLVXNySlV4YzhNTjVtV0lxQy9BbU9iSm9mSHVjejQ2WmoyNjc1ZktwYWNJ?=
 =?utf-8?B?NXdxNi91bnhmZndBYktpeE1MTkEyVG54aVhPTzdIZlhPaGt0R1BxZExNanNp?=
 =?utf-8?B?ZTc2OE1ZaFZzT0RRaGpZK2lHWkt1MFNHZlQ5aVNkMHVab1Nsbk5zU2ZOWUNH?=
 =?utf-8?B?STF5Tkd3SGdueHNaSG5JVHVhcGJsbjB2ai8yTGFuTjNMK2lib294RmdjQy9p?=
 =?utf-8?B?cVRqMlpZK1BMaTFGM0cyaDgwZUFPTTgxcTMrcFU3R1NtVE1tYzhVcldLclNs?=
 =?utf-8?B?WkxRdGVGc0hUNnE2eEVkQURXUzlZT0FUbGxpdUNaRmgzM2JsR0I5SjYvMmNw?=
 =?utf-8?B?R1l3OVg1SlRnNm44V2UvcFQzYXhkUkNJODJ4NHVDQWx6TFozelpNZzB3S0l5?=
 =?utf-8?B?ek9XeXNWeHR3U0IvaWpPeXlEQmp6eG1Na0RLai90blhTS3NaNTZnSHpkSlN0?=
 =?utf-8?B?eldBby83bitlWHBKYkN4S2xFUFZtRzBWNEQ3TlliZEN2cDRZUjlLNDc0QTRi?=
 =?utf-8?B?SHc5NGdVMDVNc1JkMHpzaGRULytMTExYWXRRMUFqNC9aWW9LNHZSWFE5TDcx?=
 =?utf-8?B?SUkzejQxRmZndlRZZFFUenhVQkhiT0s5V1gzRUI0Sy9jcUFPNXdFSkYydGpK?=
 =?utf-8?B?TEU5Z0toNDhXRWRpbkd3eldsWGFTcUJqemk5RXRSNEpXakIzMXZrc2VJdDhB?=
 =?utf-8?B?TUpFcWhRNEFQd1IvbTF4cWdjOTFOdTJxNEQ3bmYybDdzN0hST3FHakNzSDIw?=
 =?utf-8?B?elg5MnFVdFE5WnpZdXJocjYvYkpvSkJOckdQTXd2ekxvTzZOd3p4TVExL0R1?=
 =?utf-8?B?TkFNdEFyUGpBSldKZjdldzB0ckp5VG0rQ1pNdStIQ2xXb05od2haR2s0L1I1?=
 =?utf-8?B?Y0wvVkc0ZFZ0WDEvc0NKaDFFM3I3Z1JSODBScE1RYkVaL1k2aUttUGE2SzZ5?=
 =?utf-8?B?eEVYb3JYR01WbWNJKzNDZjFjRDNMSkgxNkNtOXk2ZSs4TEd3bXNGbEZ5VmV5?=
 =?utf-8?B?UXZIUlZsaXBQdFRTQ1QzRWRxdU1GSVlJSjNlakRVeWFxa2puOU1tNUhnMU11?=
 =?utf-8?Q?4td86YL/1dsiT5PUy/YQU+H3y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <169705B40F05C345951E0AD4EB10340B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	efEhwT5GLFWA3t9EIJm/WIJ0Wesj89I+TPMDsZqrvr97FaGh/yiv0H1rE2GZDkCJD45oangSEwWHQId9CKaHSdzXH/cG5TVL84fBzHt+CvtCOflTxxD7kylfK2319HqJ0xLKH6O5nDhnW63pQHGVK2qxfjATgmSdmqlJD7YRMfDGtaWXRhLKKYR9l0LreHzJKzaK5cSw8I6yeS6Za4EHVm/THfSuzGdtVinjtIo1a78lhSqVEFndQ3LomsEx2pQtCd5E9mz3f97qfno8Bsb1g4B4ThVE1hRvIa155Mz6U347qhitq0mV+sTsANeBtCL9MI1DMl/WJJA17hxpcbP77URNJGzuW4VNKXWV2B+h92QRbtpUVdi41MTr/PnqX1rxRZNsRg3jxNBWoOON6n76ZKzkkUzzF0Y17igD6VLQe7uNMsCpKlCkuU4SU8gYV3wTpAOsMeg9c+vUBwLvMSVsJJTV+TipLrPky06vWmiRNEPty1PLpZ1nFaxLK1Yi176Ygxg6TRKCy+sr3MpYE7p4pJa6lFZvSPKc/A7QjfpUV6+g6ZF77CSGTvh90kuTAijEoapTlwsw0Hag1RRj2m0mCu5woCX1ILZhsWnJPSeJyrzo4CZRIJs8fhZZyzZF1NJu8xYBJ+GhvMyO1b8/LeHOKQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aba94b8-0662-4efe-aa9d-08dc8f298972
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 23:59:34.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWQgVvQDHqFS5xPj+T/G2KaqKsOkmgo1MSEPIJzxRopJ6rPFVVWTqxN2Hw6sUNiu6vzNeb7J9vvsAuj6ci143Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Proofpoint-ORIG-GUID: GAnW6pL9nrSMRELY4nA-oM3vvKH8Q6Y6
X-Proofpoint-GUID: GAnW6pL9nrSMRELY4nA-oM3vvKH8Q6Y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170185

K1h1IFlhbmcsDQoNCk9uIFRodSwgSnVuIDEzLCAyMDI0LCBMaSwgTWVuZyB3cm90ZToNCj4gDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogR3JlZyBLSCA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gU2VudDogVGh1cnNkYXksIEp1bmUgMTMsIDIw
MjQgNDowNiBQTQ0KPiA+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiA+
IENjOiBUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tOyBxdWljX3VhZ2dhcndhQHF1aWNpbmMuY29t
OyBsaW51eC0NCj4gPiB1c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBjb3JlOiByZW1vdmUg
bG9jayBvZiBvdGcgbW9kZSBkdXJpbmcgZ2FkZ2V0DQo+ID4gc3VzcGVuZC9yZXN1bWUgdG8gYXZv
aWQgZGVhZGxvY2sNCj4gPiANCj4gPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBu
b24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiA+IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+ID4g
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA+IA0KPiA+IE9uIFRodSwgSnVuIDEzLCAyMDI0
IGF0IDAzOjM5OjU5UE0gKzA4MDAsIE1lbmcgTGkgd3JvdGU6DQo+ID4gPiBXaGVuIGNvbmZpZyBD
T05GSUdfVVNCX0RXQzNfRFVBTF9ST0xFIGlzIHNlbGVjdGVkLCBhbmQgdHJpZ2dlcg0KPiA+IHN5
c3RlbQ0KPiA+ID4gdG8gZW50ZXIgc3VzcGVuZCBzdGF0dXMgd2l0aCBiZWxvdyBjb21tYW5kOg0K
PiA+ID4gZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlDQo+ID4gPiBUaGVyZSB3aWxsIGJlIGEg
ZGVhZGxvY2sgaXNzdWUgb2NjdXJyaW5nLiBCZWNhdXNlDQo+ID4gPiBkd2MzX2dhZGdldF9zdXNw
ZW5kKCkgYWxzbyB0cnkgdG8gZ2V0IHRoZSBsb2NrIGFnYWluIHdoZW4gcHJldmlvdXMNCj4gPiA+
IGludm9rZWQgZHdjM19zdXNwZW5kX2NvbW1vbigpIGhhcyBnb3QgdGhlIGxvY2sgLiBUaGlzIGlz
c3VlIGlzIGludHJvZHVjZWQNCj4gPiBieSBjb21taXQgYzdlYmQ4MTQ5ZWU1ICgidXNiOiBkd2Mz
Og0KPiA+ID4gZ2FkZ2V0OiBGaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQiKSB0aGF0DQo+ID4gPiByZW1vdmVzIHRoZSBjb2RlIG9mIGNoZWNraW5nIHdo
ZXRoZXIgZHdjLT5nYWRnZXRfZHJpdmVyIGlzIE5VTEwgb3INCj4gPiA+IG5vdC4gSXQgY2F1c2Vz
IHRoZSBmb2xsb3dpbmcgY29kZSBpcyBleGVjdXRlZCBhbmQgZGVhZGxvY2sgb2NjdXJzIHdoZW4N
Cj4gPiB0cnlpbmcgdG8gZ2V0IHRoZSBzcGlubG9jay4NCj4gPiA+IFRvIGZpeCB0aGUgZGVhZGxv
Y2sgaXNzdWUsIHJlZmVyIHRvIGNvbW1pdCA1MjY1Mzk3Zjk0NDIoInVzYjogZHdjMzoNCj4gPiA+
IFJlbW92ZQ0KPiA+ID4gRFdDMyBsb2NraW5nIGR1cmluZyBnYWRnZXQgc3VzcGVuZC9yZXN1bWUi
KSwgcmVtb3ZlIGxvY2sgb2Ygb3RnIG1vZGUNCj4gPiA+IGR1cmluZyBnYWRnZXQgc3VzcGVuZC9y
ZXN1bWUuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDYxYTM0ODg1N2U4NiAoIkZpeCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgaW4NCj4gPiA+IGR3YzNfZ2FkZ2V0X3N1c3BlbmQiKQ0KPiA+ID4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1lbmcgTGkgPE1l
bmcuTGlAd2luZHJpdmVyLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIHwgNiAtLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYyBpbmRleA0KPiA+ID4gN2VlNjFhODk1MjBiLi45ZDQ3YzNhYTU3
NzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IEBAIC0yMjUwLDcgKzIyNTAsNiBAQCBz
dGF0aWMgaW50IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoc3RydWN0DQo+ID4gZHdjMw0KPiA+
ID4gKmR3YykNCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0
cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4gew0KPiA+ID4gLSAgICAgdW5z
aWduZWQgbG9uZyAgIGZsYWdzOw0KPiA+ID4gICAgICAgdTMyIHJlZzsNCj4gPiA+ICAgICAgIGlu
dCBpOw0KPiA+ID4NCj4gPiA+IEBAIC0yMjkzLDkgKzIyOTIsNyBAQCBzdGF0aWMgaW50IGR3YzNf
c3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMNCj4gPiAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4NCj4gPiA+ICAgICAgICAg
ICAgICAgaWYgKGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0RFVklDRSkg
ew0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBkd2MzX2dhZGdldF9zdXNw
ZW5kKGR3Yyk7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgc3lu
Y2hyb25pemVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ID4gPiAgICAgICAgICAgICAgIH0NCj4g
PiA+DQo+ID4gPiBAQCAtMjMxMiw3ICsyMzA5LDYgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRf
Y29tbW9uKHN0cnVjdCBkd2MzDQo+ID4gKmR3YywNCj4gPiA+IHBtX21lc3NhZ2VfdCBtc2cpDQo+
ID4gPg0KPiA+ID4gIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpk
d2MsIHBtX21lc3NhZ2VfdCBtc2cpICB7DQo+ID4gPiAtICAgICB1bnNpZ25lZCBsb25nICAgZmxh
Z3M7DQo+ID4gPiAgICAgICBpbnQgICAgICAgICAgICAgcmV0Ow0KPiA+ID4gICAgICAgdTMyICAg
ICAgICAgICAgIHJlZzsNCj4gPiA+ICAgICAgIGludCAgICAgICAgICAgICBpOw0KPiA+ID4gQEAg
LTIzNjYsOSArMjM2Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBk
d2MzDQo+ID4gKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+ICAgICAgICAgICAgICAgaWYg
KGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0hPU1QpIHsNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBkd2MzX290Z19ob3N0X2luaXQoZHdjKTsNCj4gPiA+ICAgICAg
ICAgICAgICAgfSBlbHNlIGlmIChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0gRFdDM19PVEdfUk9M
RV9ERVZJQ0UpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgZHdjM19n
YWRnZXRfcmVzdW1lKGR3Yyk7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgICAgICAgICAgICAgIH0N
Cj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gLS0NCj4gPiA+IDIuMzQu
MQ0KPiA+ID4NCj4gPiA+DQo+ID4gDQo+ID4gSGksDQo+ID4gDQo+ID4gVGhpcyBpcyB0aGUgZnJp
ZW5kbHkgcGF0Y2gtYm90IG9mIEdyZWcgS3JvYWgtSGFydG1hbi4gIFlvdSBoYXZlIHNlbnQgaGlt
IGENCj4gPiBwYXRjaCB0aGF0IGhhcyB0cmlnZ2VyZWQgdGhpcyByZXNwb25zZS4gIEhlIHVzZWQg
dG8gbWFudWFsbHkgcmVzcG9uZCB0byB0aGVzZQ0KPiA+IGNvbW1vbiBwcm9ibGVtcywgYnV0IGlu
IG9yZGVyIHRvIHNhdmUgaGlzIHNhbml0eSAoaGUga2VwdCB3cml0aW5nIHRoZSBzYW1lDQo+ID4g
dGhpbmcgb3ZlciBhbmQgb3ZlciwgeWV0IHRvIGRpZmZlcmVudCBwZW9wbGUpLCBJIHdhcyBjcmVh
dGVkLiAgSG9wZWZ1bGx5IHlvdSB3aWxsDQo+ID4gbm90IHRha2Ugb2ZmZW5jZSBhbmQgd2lsbCBm
aXggdGhlIHByb2JsZW0gaW4geW91ciBwYXRjaCBhbmQgcmVzdWJtaXQgaXQgc28gdGhhdA0KPiA+
IGl0IGNhbiBiZSBhY2NlcHRlZCBpbnRvIHRoZSBMaW51eCBrZXJuZWwgdHJlZS4NCj4gPiANCj4g
PiBZb3UgYXJlIHJlY2VpdmluZyB0aGlzIG1lc3NhZ2UgYmVjYXVzZSBvZiB0aGUgZm9sbG93aW5n
IGNvbW1vbiBlcnJvcihzKSBhcw0KPiA+IGluZGljYXRlZCBiZWxvdzoNCj4gPiANCj4gPiAtIFRo
aXMgbG9va3MgbGlrZSBhIG5ldyB2ZXJzaW9uIG9mIGEgcHJldmlvdXNseSBzdWJtaXR0ZWQgcGF0
Y2gsIGJ1dCB5b3UNCj4gPiAgIGRpZCBub3QgbGlzdCBiZWxvdyB0aGUgLS0tIGxpbmUgYW55IGNo
YW5nZXMgZnJvbSB0aGUgcHJldmlvdXMgdmVyc2lvbi4NCj4gPiAgIFBsZWFzZSByZWFkIHRoZSBz
ZWN0aW9uIGVudGl0bGVkICJUaGUgY2Fub25pY2FsIHBhdGNoIGZvcm1hdCIgaW4gdGhlDQo+ID4g
ICBrZXJuZWwgZmlsZSwgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5y
c3QgZm9yIHdoYXQNCj4gPiAgIG5lZWRzIHRvIGJlIGRvbmUgaGVyZSB0byBwcm9wZXJseSBkZXNj
cmliZSB0aGlzLg0KPiA+IA0KPiA+IElmIHlvdSB3aXNoIHRvIGRpc2N1c3MgdGhpcyBwcm9ibGVt
IGZ1cnRoZXIsIG9yIHlvdSBoYXZlIHF1ZXN0aW9ucyBhYm91dCBob3cNCj4gPiB0byByZXNvbHZl
IHRoaXMgaXNzdWUsIHBsZWFzZSBmZWVsIGZyZWUgdG8gcmVzcG9uZCB0byB0aGlzIGVtYWlsIGFu
ZCBHcmVnIHdpbGwNCj4gPiByZXBseSBvbmNlIGhlIGhhcyBkdWcgb3V0IGZyb20gdGhlIHBlbmRp
bmcgcGF0Y2hlcyByZWNlaXZlZCBmcm9tIG90aGVyDQo+ID4gZGV2ZWxvcGVycy4NCj4gPiANCj4g
DQo+IFNvcnJ5ISBJIHNlbnQgdGhlIHBhdGNoIG9mIGxpbnV4LXN0YWJsZSB2ZXJzaW9uIGZpcnN0
bHksIGFuZCB0aGVuIEkgcmVhbGl6ZSBteSBmYXVsdCwgc28gc2VuZCBhIGNvcnJlY3QgdmVyc2lv
biBmb3IgbWFpbmxpbmUgdXBzdHJlYW0uDQo+IFNvLCBJIHRoaW5rIEkgcmVjZWl2ZWQgdGhpcyBl
bWFpbCBmcm9tIHBhdGNoLWJvdCB0byByZW1pbmQgbWUgdG8gYWRkIHRoZSAtLS0gZm9yIGNoYW5n
ZSBsb2cuDQo+IExldCBtZSBjbGFyaWZ5IHRoYXQgdGhpcyBwYXRjaCBpcyB0aGUgZmlyc3QgdmVy
c2lvbiBmb3IgbWFpbmxpbmUgdXBzdHJlYW0uIEFuZCBwbGVhc2UgaWdub3JlIHRoZSBwcmV2aW91
cyB3cm9uZyBvbmUgZm9yIGxpbnV4LXN0YWJsZS4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gTWVu
Zw0KPiANCg0KWHUgWWFuZyByZXBvcnRlZCBhbmQgc2VudCBhIHBhdGNoWypdIGFuZCBJIHJldmll
d2VkIGFuZCBBY2tlZCBhIHdoaWxlDQphZ28uIEhvd2V2ZXIsIGhlIGFuZCBJIGRpZCBtaXNzZWQg
YWJvdXQgcmVtb3ZpbmcgdGhlIGxvY2sgZHVyaW5nDQpkd2MzX3Jlc3VtZV9jb21tb24oKS4NCg0K
UGxlYXNlIHJlc2VuZCB0aGUgcGF0Y2ggc28gd2UgY2FuIGFwcGx5IHRoZSBmaXguDQoNClRoYW5r
cywNClRoaW5oDQoNClsqXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyNDA1
MjgyMzA5NTEuMjNhYzV5cXdrcGFseGR6ekBzeW5vcHN5cy5jb20v

