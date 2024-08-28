Return-Path: <linux-kernel+bounces-304204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5FC961BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F80281C02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D545BE3;
	Wed, 28 Aug 2024 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bcjpQYwM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="buOHaksh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ehPt9cHC"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F281B969;
	Wed, 28 Aug 2024 02:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810809; cv=fail; b=ZYH5cZCtWWfkjel6B7Hxuxt9gY2NemBCHNqibSNoIuS46M2WXmLCxnyQOqDxRhAyItkgV+T76GRNkNLNjnh4p6WMAIEjZV1pCeBEGJGesAEvtBalHmdvaq57PeoY20OqkU5K4OwRekv4e89KTNFnkKRIysNcRK1lsWAC61J0uRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810809; c=relaxed/simple;
	bh=GHjfmc7soNLIOLKmLBXb7NRNCSsprkmouQ9f/ud7QhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i15CWVSo5PEgwkJ5jIkH0m4gFbMTLTBHfFtx/Lbn6ThgrLVcK0tFyWPUifgn2H0Z82OUxcO6bUe0phFwcxdhPeq7I6sBCYdmzgvWczjl69LqveqELZ45YcQ8FIdecypeXpRowAXxdmTZhyN4SH7tYK4O2E3AECFWgSdBAwfl4Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bcjpQYwM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=buOHaksh; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ehPt9cHC reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLgSoO014482;
	Tue, 27 Aug 2024 19:06:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=GHjfmc7soNLIOLKmLBXb7NRNCSsprkmouQ9f/ud7QhM=; b=
	bcjpQYwMUirgOD1bibkjXnJ8Vm1qB/TYsObYKM/852Ett6VS9J8C/wFPMia5M3ZI
	/Iy+smrT3/g+9tB68nSWzSXnotZ6BoZFDE7OVePrN+qUuek4HNjmtrewtFSu9CMh
	mL+0jI8x8dfMnoXoal996mD8MNTKa+8LC+Iie1cb+acN0gW6c2hhBBjF4BPzTkrL
	5ncSu0daQLE+4KTmuL+bPjdapVlEUEPVfNYRiUc03GNJ6HapeycEX1rlED/K0e4Z
	ENxd7sBmn9bY7hiiS7jdfAzy2/W2XXwR2yXrEiev7RQ3+cXL+zlwHxJIHxLOD5r3
	zSfE8qLGjAwNH+2EC09Y3g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419pxyrx03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724810786; bh=GHjfmc7soNLIOLKmLBXb7NRNCSsprkmouQ9f/ud7QhM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=buOHakshstCICbgN3q0u7qELRw/yYnYQ14GS9ZtLYf3WDaOZpqmWaFwLhuVZLOXQx
	 jCi5pLhqs1iOsU0m/oeJVWNiyg3uDW2yqBwRYcHUTndC33zmHk0RaOOe5hLNHxgc40
	 rnhcFgjnkFM2cV3ivQA3BBmi30HW12neUKhPHhxselvTS5qnbcM8Gfsd1nDYvc9qHv
	 bKUi8l9DFPHf/SPwxw34LOcWgPTPAjCO8mYi+FZoYhqZu0aRmlH4rX0ozyOa+B0GOT
	 z5/lGxBQ4vYAxMeYD10cejTV/fnQsvmyZY/XszDzc4P4DGMTtT1ZGJw8OqfppcFzmn
	 Obuw7euE4e3bw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D4A6C40407;
	Wed, 28 Aug 2024 02:06:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 859EDA005C;
	Wed, 28 Aug 2024 02:06:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ehPt9cHC;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0092640236;
	Wed, 28 Aug 2024 02:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXl/ELpWF83lTEXsZT3GCxFd/+s1+CXbU6ZR1rYNhAAB8T0YQT1S+rksxXG6K9hpDFL3CJjT6IH0Tp73vv8f25K5XiZe0GlyInpqrRNRS41E/dzc1kAUA1mbuTjHjaqV29w0KqluTecELvaKkKOMTl+lkaWW4rlt10wsbIqVzo/Rd1q1dVeWMLYNOnL9N5EP0egGQC/miFY+1qGtkQySoL6ureN5RPNaC6gsWV3abM4ffQ+zvOTysJHveOBWqsd+9PfwjqQdAw/qGnbdN7BAmRcSsXxuxrYrz6hGsmgyIOwMUeEWNNg76P3Br326dMj4y54TbKXS3XmBjV6ve6wVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHjfmc7soNLIOLKmLBXb7NRNCSsprkmouQ9f/ud7QhM=;
 b=MNWN5IzwjM5Bs9HQtoVGsuOI20oI2ZvmMzgxoHjlXvWZljoMCgdDy0b2V35FiXy3whpWbieiJcNkPN4pAbVdfHlxIwY1pYaha8xAxiOQmELGn60RKTJBCBxW2GAVhPKFAPQw3yDBFHwCBoXjRPtKRHIdwiT/xndhwbPJ8AXuIr8po5b5WovQkelwXSXzTqxTRdNlWU/KztnohTe8bup4xR1XR6LJjsgqY3zq+8pCEpxpFwLCjjT9rElJyo7k6NKDb71Jn0nEcMs47f33cjzfdFUR+I6vnB9PLyjRCB2byz2MT4Uc5sV9MtDXL4pLn4suw0lDrkKQCL/Deu3rPOzPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHjfmc7soNLIOLKmLBXb7NRNCSsprkmouQ9f/ud7QhM=;
 b=ehPt9cHCgcWlMxyzXoeoEtdsfCAbammoB5aywsiaM6YrW8N1m2jSlXktnvNUEACXvnwrMd+VoFP+76mqol0aZ/Mtw3yRJy4OCkDxcKuXwT0yx8anU7MXcUr+61SLVe7VVsIA472QSPLFs6hDjUL1nT58dFYkuP8432Kj87fIlmE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 02:06:22 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:06:22 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng
	<jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham
	<quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley
 Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Thread-Topic: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC
 endpoints
Thread-Index: AQHa+EULTkB2OCYKX0iBD1wqItnyWbI7vZQAgAAvoIA=
Date: Wed, 28 Aug 2024 02:06:22 +0000
Message-ID: <20240828020619.y72uf4vm7cuvsnm5@synopsys.com>
References: <20240827054956.28241-1-quic_akakum@quicinc.com>
 <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
In-Reply-To: <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB8167:EE_
x-ms-office365-filtering-correlation-id: d8a76a0b-0351-4e26-0302-08dcc706038c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUlCanJ5Tms3NjhjRmUwYk9MdEpLd3JSMzQzN2d0dDNBNXdlWWJ6TmRTT0Zt?=
 =?utf-8?B?em1ZcGQvKzFTRWJZOGFFcHpQT09MTUk3T3U1OFRxMEVxbTV3OVVyeDdrTWxr?=
 =?utf-8?B?K1h1eUhmbTVnamdWeXNMb1JSaEJtL2prajA3UndSR0V4cEVGazUzL2RGUWdh?=
 =?utf-8?B?ajg3RkJCRXhBbXp4NDdZN3BNcHBBaWZnZnRzSENvS2V0SlhITDZoTzQ3WEQ3?=
 =?utf-8?B?RnU1S1pJY0k2VmJ3OEZZQWFGNlI3SUpGK08xR2VUZFhEejV5SmtjeUJjSlhl?=
 =?utf-8?B?T0hjQmRkMjlFUmw4TUh2bkx1VUpDT3lIdG52cHlFN1UvWXdHbEpPb1E4dWcx?=
 =?utf-8?B?b2VTbjEyN3JMcFp1MUhvUU5RRDN3Nk15ODlWT3BUaDcyRG1VeUVFenkwcTNn?=
 =?utf-8?B?bVluREdOK09BRHpXTGdmQWZiY1Nqek5udDVNZVlVQzJUaFdLOVVENFpXS0Nl?=
 =?utf-8?B?UG9vaHVxM1Bwb1V2SEFjTXNvSEZ3SXROUFFlU1dITFNwQ1ZrZk9UdXVXVlh5?=
 =?utf-8?B?NFEwRDNGa1R1amRaOXJ5Q2JNZEduTWhBNlpoNG1XbnFGUG1HdVdSbE92czNu?=
 =?utf-8?B?ZHNGUVloQ1hUbFMvNmVDNytjMFVnY1VIYWowYWFOL3ZxaTVwano1SGNPOTBz?=
 =?utf-8?B?bVB6ekNLYXZRNzMrZm5xSWRybC9YZ2hSVE4xK3JRRUJIUXRtMzMwYlU4NTR2?=
 =?utf-8?B?eTJtSDdzdVczUFdld2xNT2NmTDR5TE01a1hsalJqeEVobkxURnZNczB5TU01?=
 =?utf-8?B?amhqcHU3NHlvRjdBWEo2Z05wRFBwRVRneG45OUpmeUE2ZzF5YjlmYTh1eFRG?=
 =?utf-8?B?djh6elpQY0RpZE1PWktjd0xhbGpxK2pCV25wdU1IZGUxZ0hxYWtlL2p1ejVS?=
 =?utf-8?B?SVZpWXVOWlcza2VPZnQ5RnRGRTFQWU1XZG9EWVMzek1GRlZ0bTJSRCtIVkZ1?=
 =?utf-8?B?WFNFUFdkUnBubVpEVm8xK1lpYnZxN21QOGlLMGd2Y1N0ZFh4aVRUZHVRSHBF?=
 =?utf-8?B?TzF4eTlnSEw3T0R1VlhXK0E4eVV1MUJwcjZOSG15b3gxb1ZKUElxcWZ1UktL?=
 =?utf-8?B?TDhTUlV5aGo4eFRlWlg0WG1XNC94QkovbGhMbDRXN20rdU5ZM2VtMTdiVmph?=
 =?utf-8?B?Z2hCZU1mcEFyMHVyeFRISkc3aFhQcythazBsNTQyekN0R1Y1cU83dHdnWllX?=
 =?utf-8?B?T2NaM2wwOVcvZ1JadFFwY2VhVU0rWmMrVm9LT2FJRFk1b25IK0d5ZGFhVkpX?=
 =?utf-8?B?ampIaHlXZmVRSlJqWmRMRVFXUmR0cW1OTG5zaEMrNXdhNkx6VXJPUmMwUlNJ?=
 =?utf-8?B?bVl5akMreXZTSERsQ01nN3dKWGc3QTUrL3FMNnJzZmNYL3RPTC92MXluWWtt?=
 =?utf-8?B?YmFrbEpPTXFXQ2t2N0J4WGYvb2VxWjNuSncvQmdYSklRREVUc2IwWUFQYjZV?=
 =?utf-8?B?bXNTcmVNUnR1VFdGYUVjbk5HcVFzWWU4czhCTDQyR1E0NWx1L2hQZ1hFbVpC?=
 =?utf-8?B?b2ZlMWNVYmZVUEhBWnJoWi9hcWFJNllNamFwbTZ0YW5qTHFEUHppRXdLdktz?=
 =?utf-8?B?aGhySFozV21yU1piTWVNY09OYk5JMkRyZ1JjdlppTFVXcFY0dnRRSkVaNEhF?=
 =?utf-8?B?OHBHc0dKWERmUEVOektaQ2hJMkJiL2NHOWxZcWdQYkpVTjllYUFneXNZN3NQ?=
 =?utf-8?B?YkVzNVNScXI3N0xTTFR1SVNFYmExY1JkdHM1V1BXQy9kdzdoUWt3MVJEcWdG?=
 =?utf-8?B?U1BVaGdORGQ5aVp3aGQwNk5jVjBLRWhQZi9COStQRlprYWNBQUVWVENEVHRH?=
 =?utf-8?B?WjZqQUNQRUw1QUJYdGxPNUtTREVIeG5hVjc4Z1VmYmUwc0NYSXZ0L0dOYnQv?=
 =?utf-8?B?aWNtN2ZIc2ZRcm9maHhwTnlKRXBzemcrbCtkZEE5ZnVFRnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGRXOUg2bC9ESjBVdVU1K3hTRmx1b2twbnlFQmdUNnBaa2svdU9wSklSeCto?=
 =?utf-8?B?d1BTQ3UySEkwdEJ3RFJYRm9SR2lTaUxObEE0eUx4SDkvS2VlLzk1K2Y0YjZJ?=
 =?utf-8?B?Mjh5c1l3cXdBRlNMOVg0RDREb0JpOHBXUnJxRnRNdmtmQlR1alB1WkptamZE?=
 =?utf-8?B?ZXlCcXpnZ3lWRkdKdGNaYy9RRm5najN5dU55ZnVwNzlJQUxaTTZVZ251QjI5?=
 =?utf-8?B?R2dPKzh1MHYwMDg3T1Eza3NWVTgzQUV6Mk5RREx2RS9pcVVSWWtvL3BIMTN3?=
 =?utf-8?B?L2pRK3diOWx1dk1BRGh3cWtZSUw5QzFrUVNXOVRvTDJweWxlNWswY1BERk85?=
 =?utf-8?B?SmN2R1VNblM3UGt0eG9mTEF3VGM3YVEvd0ZDQ0ZjelJqQThyQnJDL0MyMFVK?=
 =?utf-8?B?bm5YWURBSzdYTG11Z0ltZ1Frd0QzZzNEYllJam9qeHlSaXM5NXRxK0prNTJj?=
 =?utf-8?B?RkhWd2NNWGFDU1VGVjFXUXFJekVFRUloL2dNQytXdWVFb2tyc1BrbG51VExm?=
 =?utf-8?B?MytYLysycjBrNlA2SDZzcCtrcW9lMS9FNWNjQlFPUGJIVUJNVzI2U0xyRXZP?=
 =?utf-8?B?NDNGVHE4VE1rUVBCNStQS2VXVWNnQmdtRVhzUXF0alhtZW1aMlBzMzdWWmor?=
 =?utf-8?B?b3dPWnd2SE1FM1VXeXU1M2lSdG5sSmtFdTFhNlpZT0JLZ1NwOWxqbXdaeGtU?=
 =?utf-8?B?Mk5VMVdyT3pHR1d2aE5jRjVHaHFuRGRRT0l0YktadkNkYXluSmZETWRVMXFw?=
 =?utf-8?B?bDdSQi91c2paRG5kRVlSeS9JMEt2VUY3Z1FtcWdhdTFkeXZ2azBTVWk5MGdE?=
 =?utf-8?B?a3RTUUxJVVYwTUs1RlB0WkpNb2FaN0VHOEJRSUx1TU4vRElWTzdDd2k1eThL?=
 =?utf-8?B?YXdKRjR3Y0pLL1NZZnFRYlJHcFlEelh0Y2FDaHIrelhUZkw0dnFrQm1iN0xP?=
 =?utf-8?B?YzV4MllOU2lRbUcwMkFzS29VSlIxWENOTzYwZXdmRHlZVGJ1R0tidnBMUnNq?=
 =?utf-8?B?SEViY1o3eW1GTnc3KzF0TU4zRlZjd0xRM1c4aGE1REI5RmpSRHhLVk5mSGJj?=
 =?utf-8?B?VkltWGwvK2cvSURvQkZZL3kwR0VwQzVCK3lhQXBtUFpUQmRDU2hiNDlFckVu?=
 =?utf-8?B?Q2o2OXJmYjQrYUlLTFJlTTM4NXQvK3pFM2JTeWZyQXRNbUk5K01JV2UxZnVV?=
 =?utf-8?B?UjRtNmtnL3F2aFJJK2VmaXRlNDZhbGc0NFQ0ZU1TajhhR2w0MjJOV0o5MDVv?=
 =?utf-8?B?ZmJkZkp0Vlc3eU02YmlhNC9TUytsU2tQVWlLWEJFd0ZvN21EclJZV0U5U2RZ?=
 =?utf-8?B?YUl1Mngxd3VqL0ZnTU5SN3R3T2hnSGdxZ1JyY213VWFPSzdONUR1b3BjeXFt?=
 =?utf-8?B?UTF6Q0M0RzNFZldYN0FKU3ZmWldiQUlnWUZvVGJaNjhBN0pVUTZZc3k5cDBQ?=
 =?utf-8?B?MzhqRGNIQlJueDRqSlROQUNwK01kUStET1lwZUhDVkJXVzMxQ1llM1VoY0d2?=
 =?utf-8?B?aWZLY2tDeFJKUVp6cFRobFR0ZVgrSDV3cUFqTGZxNXN4dkIzMTBjdW5NS1M1?=
 =?utf-8?B?VHlaWEFJTlRJQTA1aDNBT1F1bk9mSy9IMUFKQmQ0R3JCZFFJZ2pNYVlxbE95?=
 =?utf-8?B?SHErUHBhRE1rQ0dCcFNZUU9TcHR3TTlXdk8vNTZWQ3ZkU29DaTc3YTJ5RGhn?=
 =?utf-8?B?dVZCamJoM1FSOEFVOHVVVFRoOEpRQ3czT0dtcmpNTldIeUphM25kVDlFQXZh?=
 =?utf-8?B?TVRVNjFYYWlPdktrTStrSmkxUUUram5iWkphWDY2T0tWOE0xRUJsbWZMOUVC?=
 =?utf-8?B?ckFrOTlCeFJVN2FiaU4rL0xQdnhkMVJQc1IrMzdHNzlqcVowaTFITHZJa0ZQ?=
 =?utf-8?B?SnlDQVRmOFFHTGpMV3MzUmJTeHNkL1k1ZjB0d0Rtb0xhb2RycWU4elRHVTdX?=
 =?utf-8?B?U2Y2eUZhamFmR3pESk41MnZVR0NvTTRoS20zdzJnclZtTFZmeXlGOFR3VjJu?=
 =?utf-8?B?RmlXc0hqazBtSFNhMVp6bGZVNy9LNEhJQ24weEx1aFNEYzNHRmlXQ2ZRY1Z5?=
 =?utf-8?B?UU5qVkw4WG13NVlZc1J0a2J2ZmFTTlcxTnEzUzFQZk9EN3lDalg0NmlKUTQ3?=
 =?utf-8?B?TVh3M2Y1Z3IrdEJsK3djSnlkUEhkSWR6dDVJU29MNTluZkRxeHpvN1IyeFdv?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2E15A2E8ED53C49ACA8E0CD85D9DE50@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HbwPQMTnHBep92SBk0L2SIEWq7olhZr3z1i8j0nRxxplJHvDdF0wtR7kl28VF2gTf8mLatb8qPOcBx4ILZT4S4yhcQei/iqkBirI/EAF5Gn1zQt6AafX0kk17R82XP1vMmNFaHvYquTpiRutdl436jEuJt+pNZqGptdXgZmmO6dNjrEWo7Y3Pu+t5bbRAmjfywMYe0BvMv3rjRvaTPEepvwCrlU05CzEhB1aFmINucJWWCUVv/mRZ22GQ9otYF6aBa2A2EdeQzWHTJ5sdQHxvT0SqUkJpRAhnqyfPZTN7OI+RbdU/Sxzhq0YnIK5O/Mt09OL1l8vzSiBI6zC9MfjttFgpwb8eQ5jIHME5BJ2QOrvZzhibSbrL0Owfwt2oDKXBtT3ceUUluV7q/ffchR0GGraeqrIiNoP5D8yAr8mTGjg72aKlRunweZ89qGXxpjcn7gJOj3e8/wV7UPMg0jv60IsjxMbpj3E/9h5Go3C3Ro1TrOK9R89i5lZKYuQ05PbwI/+JugBFofQ7VqdV0PeyRlqCgBPnS97O1sQXfTIpo0YIbUsNtGx0s2raoBjCOrA4Hqylm68Wfipd8tC2vo0idm6Tkf7sxoGrlMVMnzc0Vww2VF42gp2lkGdGe3UpegveEX5H4wHo5Bvx+c7Jbd92A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a76a0b-0351-4e26-0302-08dcc706038c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:06:22.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz9ZOKr9dpKUVilil//pTdk63elGMjtDNNqR+o4/JGpGvF+QM8Wp9jpxOsyFeLnYLEfvoFDXDzdXyCG3cTZDzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Authority-Analysis: v=2.4 cv=PdethThd c=1 sm=1 tr=0 ts=66ce8622 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=EvVHQhRg-q-w8lUuymwA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZJZZyjDy0GiqrRVLXPZ4xkJqfDlP29DV
X-Proofpoint-ORIG-GUID: ZJZZyjDy0GiqrRVLXPZ4xkJqfDlP29DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_01,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280013

T24gVHVlLCBBdWcgMjcsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVHVlLCBBdWcg
MjcsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiA+IFVzZSAySyBUWCBGSUZPIHNpemUgZm9y
IGxvdy1yZXNvbHV0aW9uIFVWQyBjYW1lcmFzIHRvIHN1cHBvcnQgdGhlDQo+ID4gbWF4aW11bSBw
b3NzaWJsZSBVVkMgaW5zdGFuY2VzLiBSZXN0cmljdCAySyBUWCBGSUZPIHNpemUgYmFzZWQgb24N
Cj4gPiB0aGUgbWluaW11bSBtYXhidXJzdCByZXF1aXJlZCB0byBydW4gbG93LXJlc29sdXRpb24g
VVZDIGNhbWVyYXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWthc2ggS3VtYXIgPHF1aWNf
YWtha3VtQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiBpbmRleCA4OWZjNjkwZmRmMzQuLmYzNDJjY2RhNjcwNSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC03ODgsNiArNzg4LDEwIEBAIHN0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfcmVzaXplX3R4X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ID4gIAkg
ICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgJiYgRFdDM19J
UF9JUyhEV0MzMSkpDQo+ID4gIAkJbnVtX2ZpZm9zID0gZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhf
bnVtOw0KPiA+ICANCj4gPiArCWlmIChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0IDw9IDEgJiYNCj4g
PiArCSAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+ID4g
KwkJbnVtX2ZpZm9zID0gMjsNCj4gPiArDQo+ID4gIAkvKiBGSUZPIHNpemUgZm9yIGEgc2luZ2xl
IGJ1ZmZlciAqLw0KPiA+ICAJZmlmbyA9IGR3YzNfZ2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplKGR3
YywgMSk7DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0KPiANCj4gVGhlc2Ugc2V0
dGluZ3MgYXJlIHN0YXJ0aW5nIHRvIGdldCB0b28gc3BlY2lmaWMgZm9yIGVhY2ggYXBwbGljYXRp
b24uDQo+IENhbiB3ZSBmaW5kIGEgYmV0dGVyIGNhbGN1bGF0aW9uPw0KPiANCj4gUGVyaGFwcyBz
b21ldGhpbmcgbGlrZSB0aGlzPyAoY29kZSBub3QgdGVzdGVkKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
IGluZGV4IDlhMTg5NzNlYmMwNS4uZDU0YjA4ZjkyYWVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
QEAgLTkwOCwxNSArOTA4LDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcmVzaXplX3R4X2Zp
Zm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICANCj4gIAlyYW0xX2RlcHRoID0gRFdDM19SQU0x
X0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM3KTsNCj4gIA0KPiAtCWlmICgoZGVwLT5lbmRw
b2ludC5tYXhidXJzdCA+IDEgJiYNCj4gLQkgICAgIHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVw
LT5lbmRwb2ludC5kZXNjKSkgfHwNCj4gKwlpZiAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAt
PmVuZHBvaW50LmRlc2MpIHx8DQo+ICAJICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5l
bmRwb2ludC5kZXNjKSkNCj4gLQkJbnVtX2ZpZm9zID0gMzsNCj4gLQ0KPiAtCWlmIChkZXAtPmVu
ZHBvaW50Lm1heGJ1cnN0ID4gNiAmJg0KPiAtCSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhk
ZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRl
cC0+ZW5kcG9pbnQuZGVzYykpICYmIERXQzNfSVBfSVMoRFdDMzEpKQ0KPiAtCQludW1fZmlmb3Mg
PSBkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW07DQo+ICsJCW51bV9maWZvcyA9IG1pbl90KHVu
c2lnbmVkIGludCwgZGVwLT5lbmRwb2ludC5tYXhidXJzdCArIDEsDQo+ICsJCQkJICBkd2MtPnR4
X2ZpZm9fcmVzaXplX21heF9udW0pOw0KPiAgDQo+ICAJLyogRklGTyBzaXplIGZvciBhIHNpbmds
ZSBidWZmZXIgKi8NCj4gIAlmaWZvID0gZHdjM19nYWRnZXRfY2FsY190eF9maWZvX3NpemUoZHdj
LCAxKTsNCj4gDQo+IA0KDQpBbHNvLCBmb3IgaGlnaHNwZWVkLCB3ZSBkb24ndCBjaGVjayBtYXhi
dXJzdC4gQ2hlY2sgZm9yIGFkZGl0aW9uYWwNCnBhY2tldHMgcHJvcGVybHkuDQoNClRoYW5rcywN
ClRoaW5o

