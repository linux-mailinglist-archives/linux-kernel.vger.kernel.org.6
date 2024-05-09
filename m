Return-Path: <linux-kernel+bounces-173965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEB8C0862
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C6C1F2254B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319053D6C;
	Thu,  9 May 2024 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pg9QJ6NE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i6vyzFQk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dQYVedhN"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598951FB2;
	Thu,  9 May 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214207; cv=fail; b=pFAbGvMBpATENoUp+xydRVfgY4pLvN06QE5Tf26TgIpQ36IjavdltGkMvOizPSRzjIgDOBYMdBmNyxro8RrWwbubyySQ05U7miMCNNs0qsBPq36Fre3LWa07wtcyeNHpfDYI7ASBe66sQf2BRdHW3FGwEZ3Lpyd0bWXn/8n+1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214207; c=relaxed/simple;
	bh=wUgjv66gis+1brY7ASK1cGIPWho+G5bTGe8il5R8HEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QD8UGntDVWWbHgGk0xvJO8tjcO7MceTigUoxQKS/dNixPrmIpFovbOfax3lWi3GBJdh/jTr8bitsecqRwBrTpd1a6KpyI1+I0DE8yYTsMVPyvDqBgr93R8OOsWhHDqF0Usq+wMkxjQxPB/30Ai8ogX+mqmrf4vCRfVw04dbmTKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=pg9QJ6NE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=i6vyzFQk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dQYVedhN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448KYwSU024284;
	Wed, 8 May 2024 17:23:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=wUgjv66gis+1brY7ASK1cGIPWho+G5bTGe8il5R8HEM=; b=
	pg9QJ6NEL/aLq1fbTLw/uZQ/CqZtIbh43LjcR0ddQbJzzwEbWUOyMGrhOaZvrzPu
	M8XoQRconU36QNEp4oh3lw5C6iBHcqD4DDPQNJinektO+poMz4hl6RaVeDB1T/Uf
	KFN3iykxvkKI0dVyRWarTnXp1e9ygDp9nfvN6Xjvd1HRRPllmXeV/cTECzLL01gX
	6z/O+Ys6XjEWTvzC7jRAmhuHYX52tzugAXq+LiN3tJj417UdiJTJdVrmhp/1yx+4
	c22wKJJdWe5mi1MQxj7PN6abNGpR26EHesWsbk47T1DnRa1K+7qDW398V6Ozbfe7
	ceR8JPTr+Dls/lHoy1go5g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xysf3x7uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1715214194; bh=wUgjv66gis+1brY7ASK1cGIPWho+G5bTGe8il5R8HEM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=i6vyzFQk5vKOYrpClpeHJVaYVQjzWScCFs9hPgJASHFxaEf9821dCR5qzLUPz5DDg
	 qxhH2EuS69PEHikL8jR9hbjtbk/ogRZttl8HUM8ZLkTQF7/Rfe7ncGMfMEcOlmfukw
	 CsI59RDfnZH8c/lOZOg/QwMMi1ljQl8YjnXiFfLPRenZJYGD5eRyupl+NbQC8TXV5y
	 miLbpnk49RR8gb0CpxkIXlSsxkgqFDcJ087LCOMbTZteQqGn8C8TO8ZodCZ5blqFkO
	 BSBP7aQR7mi2rPNkFykXD79jjx2xAcQE2bGgqjRm7ovgqFpjLguvy5BH7zYkZRPd1l
	 qBEvMXFAlssTQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55AA240347;
	Thu,  9 May 2024 00:23:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CA60EA0077;
	Thu,  9 May 2024 00:23:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dQYVedhN;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 036AC40360;
	Thu,  9 May 2024 00:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaSz7UHNcFX7Tjhnbzl3RRnHbiOPxkgNQOP6h5Y+edzpwPafd3yfRCCFL6lK9YXwUvm1dAO3jSnbrXgWlsIp/XGOa4p7PFFVaW9qD0BC78+NZdWUZOULbOK4lETB5OsRLQvFKlXpY/Eao4YJwV83MvVa6L9Khx4p4xlt+EfcpItb1oO3NMfjgxEWO3Er7msYlwZZ0t1umHuJlnufi+Wk2bXgMHNpwTVBJe+3KrY/3fAtTVJOGK0sqY8PfKBmIU524rii7+MpIlXPg4gR9XLU3zF4rM/6cV72rp2sbAhQdVUUdPdMsjAVo3iC2jbPX9oH/exvzN1rp1Iek7B4JwVBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUgjv66gis+1brY7ASK1cGIPWho+G5bTGe8il5R8HEM=;
 b=mjhIUsaa4vuLTX4p/COaE32MwIjfFH5iEamqT5y8sg2khqHMrazPe1KuTO/tde0TeikusXWcKzWbRwD0krGmgj5NjqOTa5FWcTkILE5fJNCzNnBM6CpjRCH+7Ht0Zl8YvS4q4zdjLuKc8jCvDkRF/Irdh9CYHm08UycEIL7DSV4UO6/8yCp8f9gLL5HnGT2tS/H0uHpgqfArGFlkP3ry7VaTyQ+16agmgBn116CNs+hcgmnGLYj3EzbxL+sJXoxLP9aTB3cjyOHO5e9WQZvYuEIVPiU5fG6TZb3z8Z8FrB3OjGBLWUiSPohtDhi8FxUM8voTAiLh8Wn3CDQVebiPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUgjv66gis+1brY7ASK1cGIPWho+G5bTGe8il5R8HEM=;
 b=dQYVedhNcwgl+cxuIFdhXppydYmsjH7CPE/DIqMp8CYgtQr8/HFUponxm5coTSPHjSZDvWMcHVKVys93w0Ey2iwNot5ZerozLOY2hMyfuXxNn6Sua+Y/YYQQxmFYAPYr8qopTx4J7NUomRozY+oYp5VDGXm+NwXCYhCGDAqXmLI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 00:23:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:23:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Topic: [PATCH] usb: dwc3: gadget: create per ep interrupts
Thread-Index: AQHaoAoVjxvJC9SNLUaNNv/Fh2AK5bGMIMUAgAG8qICAAB7xAIAABjyAgAALZQA=
Date: Thu, 9 May 2024 00:23:09 +0000
Message-ID: <20240509002256.7grpmpnmlghft4gf@synopsys.com>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
 <ZjvuoVpVTnEcHRIH@pengutronix.de>
 <20240508231950.ifyawl6bfy6bzvk7@synopsys.com>
 <ZjwN0Zp03a1XuQij@pengutronix.de>
In-Reply-To: <ZjwN0Zp03a1XuQij@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7561:EE_
x-ms-office365-filtering-correlation-id: 28e1f097-ee9a-401c-5ed7-08dc6fbe34cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eXlOQ3hTNldaRC8wVXJGdmEyVCtFd3NWKzlpdmJWZGk0M3E3SjNNakxya0JR?=
 =?utf-8?B?SEx3QWRaZjM0Ky9QcWhvZlNoSVZkQVlVeDd4SnNXc28xMDBrTCtQdEVYWk5S?=
 =?utf-8?B?RnV6ZXFhd0E4RXZ2M1RyYWZjZVhNYUZZYnhEaC9tbm5Va3kyeU1ndk9KV2E2?=
 =?utf-8?B?bFZOZ1JybXpyQXdMMWdSSVMrVVJxZ0tOODJmNmtGNXlUOEplcUI5WWdyRzkw?=
 =?utf-8?B?NUNheXM1K0Jkd0Z0bEpUSlk1eUx0NVY0eElwaVROOXl3cVdkdXQ2U3BWdXZG?=
 =?utf-8?B?SHZ1SmY2WGI1eDdLNFptUHdkWVhtQStINXJFRWpOblNRWjNxVEFGSm5RSTlj?=
 =?utf-8?B?d0xPcmVHMVlseU5kZlY4eURHUUNXZXhXNEx6TTRWd1hJY1BKVlpGYXVyYm8w?=
 =?utf-8?B?SjE3Vm1OSERYcU1RRHFKSFJ1alNPc3ZnZ2g4djM2S0xyQkx1WmxMZUJpSXBN?=
 =?utf-8?B?RDFuWTJqNkc5V3ZlUDdCS2FFSFdRb2czNnowejRKc3pXUjUrSmxOZWpDREd5?=
 =?utf-8?B?LzJNY2Z2OUgwSXJyZkpUOG13a25JcFdVbEpHei84ZGtIdTd3dTBYZ2tUeDFu?=
 =?utf-8?B?Qm40ek9pWnRJeWQ2aFFOS1ZLVlIxUGEwS1hlbXo2QWFmMEZsV0ZlVE1zdUN4?=
 =?utf-8?B?emovbmtaYXZ4dGZVNG94dTdoODNDZWsvQ1hPbEpHQmFDdEJ2SE40aEdjaFU4?=
 =?utf-8?B?NWM4VUovc0J4dlYvQXBUNFlJMXp5c3A0LzJpUWhoMUwwUE9sMEFnZnI4VlBl?=
 =?utf-8?B?RE45OUZMRlpRbEdGVGluSHpMRTl2bEp6Q2FwRFlBOTEzdkM5aWZ6alpCc1A3?=
 =?utf-8?B?d3d5MC91Q3UxY2V2L2ZzM0FNZXBESlVZenRZL3d2MlZ4R3hWQkRFSkxCalA2?=
 =?utf-8?B?YzVERDR4T2VoSi85c2RhZXJLSkszamVSVVh0UmlsU2VnUC9YNUtQY1lpcDUx?=
 =?utf-8?B?Q0Rma0lCVFVuV2ZPOGVNMUVuNk5rc2U1ZmpTQjFpaWEycFpJNGNhN044SWVk?=
 =?utf-8?B?NXAxRmRjdGNDME9iMkkxS3g2dUNRNU94d3NYM0pRZU9OM20xc3hqUHo5cmUz?=
 =?utf-8?B?OUp3Q0svU1pwOFZDZEFhZCtTclFHclBMYjkwOTJMRjJyWGt0OHNNYzVoeEtm?=
 =?utf-8?B?U21WeWJEMGlITWFVMGZkaHRDcFkyTjlFbG5KY09Od1Q1Y3U0b0Z1MWIvNkpv?=
 =?utf-8?B?Q3NHaloycTEwL3ZKS2ZqZk5XUy9NaEc0YUQxSDhlcjFNMnM2bUloclRBTm9X?=
 =?utf-8?B?QkxhNEI4dWpEZklXM3ViL2lZSHFPYUJKS2lYNE5WalVpcG1YOTNuNXg0WFk1?=
 =?utf-8?B?Vk5kZThrbzc1SkJVUmZPaS8xVGxZUmZaQnUwWld3VXJYdFFESG5PWWJibWlY?=
 =?utf-8?B?WDdSQUdndGpya0hBTEkzUVYrV0dzTml3Y1JZSFNzUCt0amM3ck1wWkUycEMv?=
 =?utf-8?B?a1RobFZwQ2dsOFlOWG43UWhxdHVEUlp0QTJMVDdnZGdSK3cvRGNyYXloZ3Bz?=
 =?utf-8?B?eWgxSlo4d3Uwd0tYVTI3VXVCNDI5dThCTzd1UEJGWkw3YzErU3FKNnI5OHRP?=
 =?utf-8?B?SnF5WnpoMlFESXpJS1lGV1VsNzBYVTNET2haRmFUV1NzWFM0eVE2OCtxdmVN?=
 =?utf-8?B?RnN2ZzE1WVpPRlh1RVpLdVRTQUZMb0hUSjRJaWNZMlBnT3FHKzVhMWpuaUtL?=
 =?utf-8?B?d0pxd25RSzFXSlF4US8ycUZCelUwNEM0aWc3UXNvWUhzWEtXbDZjOVZRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TXpPUnNNbnRrdm9JNXBTSDQrMURjdTRxRmNRYi9xemp3QXI1eVRKcmsrckVI?=
 =?utf-8?B?MGl4Y0JCL0hEQVhNaVp6eUlnRXZ0L29aMXYrQXBkZWk2WFRNdVFDeE5iWWt6?=
 =?utf-8?B?dWNPeFJZQjZZa1R1eVZ6NlFaU1l1TjFtOS8yeTZxVmhnZHkxaFg4UkxDQjR4?=
 =?utf-8?B?aGdXNWZKSjZPV2lZUUI1SzVXRUdDVWNtYVpDVXNaWkFHdWphUkR1V2FuTmdZ?=
 =?utf-8?B?cjIzK3Z6d0tZWG5xZ21FdGRzbVpENjhaYXp4bnRKc3lvRXpndm5EcXJKQ1Zw?=
 =?utf-8?B?c2JhZDBhU3N2M1ZQRFVXQlNFZUVMcDI0UWM2eXZ1VWkxTjhXNFZOaDJ0U3B0?=
 =?utf-8?B?U3pXblRUcDUzWXV2NkFDSHVQZTgySWpNYk55OWwyUE5nNUN4Ui82aGdzSlhW?=
 =?utf-8?B?VzNwMkNoRG9NOUgvR21DRVRqSmVpNFpBRStXcmNzY2lnaGVvczd6UFpLbFkr?=
 =?utf-8?B?MlZhdWdpTWpPU1ZiNW5XQnd3N21SeERQTTR6bzFSaTdFTkV0dVNqQkwzeUlH?=
 =?utf-8?B?VHQ3THhLMk1BYkZPYTAxNFpVUzdEVEhGZnRpTHl1c3VtUXpac3h3UDMrc2Vw?=
 =?utf-8?B?VEpVK2VwcWh0SW5La3BxcWxWRStkTEZyUmx3MXQzN1VsSE55eUpqbGttOEI1?=
 =?utf-8?B?a1c1SnhuQXJ6cTlwUGtsRHlQcU01bk5ITW5NeDI2eE4rQ0w5Z0lRUmhnV1lp?=
 =?utf-8?B?Y21NT2xxV2xkM2Y2SzJWUENSNmUzTGZnMGptQUR0NDVUd2ZZQnZHSFhacTc2?=
 =?utf-8?B?Y2ZRVVJldUVEb1pQSWxNS1diSjVSeXJNSjk0bHZxUXZxbHZjUENtMnFNN21m?=
 =?utf-8?B?REMweThlTmRYQ0RWWENGMEZ0QTR0K1lQTWc0cW92dDZLOVpycUZyNVRpQkNU?=
 =?utf-8?B?eEZHKzFuanJuR3dYMmQxTlkxc2NQVFVRNFI3Z1pJMzVSVVd3R2FES1dGNHhQ?=
 =?utf-8?B?c1JWNlNpSkNUMmt0SVloQklUN0syeHFPTWcyRVZBQnJwT0l4UG5EUTcwTXlV?=
 =?utf-8?B?TUdxTWkwdkFnSGxtR3Fpbks5cVptc2IrZzNtR0kvamkwaWNTNjlJYWs1U3Fp?=
 =?utf-8?B?VzVWN3hVUmhzTDk3MGxodzd0ak1CRmlFVUFaVlRqci9WUmJrbWY0bUlLZkdT?=
 =?utf-8?B?M0ZSeE1TV0ZpdXZUejRyNzhWV0QzeUt1Zkx3T3cvOTcxZTVVWDQ1QzV0d3lh?=
 =?utf-8?B?UkhtL2hrV3A0eEdoOE1WNHE3RDJkSHJuU3RRN0k3TmpqalZDcEtlTEJ1WjBq?=
 =?utf-8?B?L1NnUHN5QWVudHIzNkNqRFJuaUg3V3hlcVpiREVMRUJBYlBXU0tBN25KdHJs?=
 =?utf-8?B?QzZtY2xNTGJ3ZmlTTGNMRGVra3dvbmw4blkwZU9BT0hZdXROZ3hDRm9rclJG?=
 =?utf-8?B?RmpHRVhZaUJRRjRjdGZqNXZySXFxSTJKNUNManQ4U3hHZVVvdnh2Q2FNTVMr?=
 =?utf-8?B?VWVBWFk2c0tab2wxMUcxYzJlWWF0dkhCQmozOHIxTnJRWWFJaXRjeHQvUkRF?=
 =?utf-8?B?SzFvMDNhRlNER0ltd1VKSjFVMTdocFF4WjNxMkhMOW91UWxqVnoxZlU3VEFv?=
 =?utf-8?B?Z0NNWWl4a2J3YWlXV3ZFOTh4SzdLV1dDR1FNQldoQTBNV3hWOW1FNUFSeGtL?=
 =?utf-8?B?cnFGTlI4MWNGOGFVZFZDSHo3R09hdkhDanBYZGwyc3pGTHFkSGdpamdwUkt3?=
 =?utf-8?B?dkNnZEpRdlhFVEpzOU92bUJHbk5DaTd3RGNYSWtZS3NPVVZMbHBOZ0g5Z1B2?=
 =?utf-8?B?amZycWIvemJRallBaEc3VFNWcUZZb3pWSzEzSHBKNjg1YzcwMXFHNG11YXEz?=
 =?utf-8?B?L2IwTXhQWVg2eWhRait3VlFOeFJScjA1VUs3ZGJmNGRidFdZRDhJZEpqd29w?=
 =?utf-8?B?eVVWQ2tMV3IxdHB6REVCVysydzRKa1FrdzR4NmdOaUE1WkU1emFleUpCT3Vl?=
 =?utf-8?B?dmFycTBURm4veStkQmVnTEJqS1A2RXQxSHJQSlovS3ZnRlQ2dGlmOStZNFBa?=
 =?utf-8?B?QjB5QmtDNlZNbzBTTk9CUHZnaGRjZFJ0RDhTWjlvcTJsc2VhV0Z4Z2lMeUNx?=
 =?utf-8?B?MzVLcC8xN09IVTY1MGNnSFBBaXNNVnE2bS9mYnA2OGhtYW10T0o0MERMR2c2?=
 =?utf-8?B?Yml6bG1makR4M0FvWC9nc0VRN2xlQjBBNzVrTWlyRkNjM1dyQVVOSHdKRTQ2?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B143EB05280F6E4D959F06F06CDD7214@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dfoyRDEvosQ6tCGQ0noLZElThhPM9+PU9jLh01QvTfE6OtAnJDk9WOmZNR9EIBrMuMLEHuE6A3p3QZml1so7J/UinIbw7irTNiEO871bGFlFgZ/H0ni1oyDLv3oDj1hlMecRgjvBUSWP9Re1SMcEiLs+Dhq25sghQ3KJabRRwlB3qD7ClP5FRk86GeCcLUr1XyXWagQN4PD0o0NQhjHNg17OtFwMJA78Qu94OaG60fRJFTkhwvVBbW/gsgOfa0ZOVTYZ8jhZ8G8b0JkhyD7ik2iM87Am7qwipSX3xinCa/egmIZi+3EEUPUANvkUKsHO6C7IGQL6WqwFT8IPOmJ/APuuCrfzm77Lpxhg7G04Q8OYrYMcErVn1+7xMC+oMJ5jw+GAZta1BzyL5DBSbro3dmXbz7jDVeleNXku2R0wAzrAkKLPAIVvdSX80irplOAyjPjp2D7Kv5DL9cCpkJxm52YrjlPqu+vWn5XYLCSlUt+ceoqGgETbVnznI5dkpPQEAlVy5WvbtK/s+yVCqraGFM8g4n52jPY+jKN5zVa1Qo8xhTDQ7WAmakAyQxUwtKyb8kUrcdg0lNlIKTrezRiPsNVePSN0bLXCkYpDb2DwHDhwhDqT3eos4FAk2am2p17cl5ZZ5kUGyhWaJM0lgz2j5g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1f097-ee9a-401c-5ed7-08dc6fbe34cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 00:23:09.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfWTCf00KBfTcwuxzmSBcX4ueH9Cz5sQkVuLNgKH6L9BUvsVXa3D1C+TiaL002394gJxHPjWNUSN7cSFKMUtTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-Proofpoint-GUID: 0VZwiZykuPwwb8DfjxIh7bKp-1bjCHbP
X-Proofpoint-ORIG-GUID: 0VZwiZykuPwwb8DfjxIh7bKp-1bjCHbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405090001

T24gVGh1LCBNYXkgMDksIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBXZWQs
IE1heSAwOCwgMjAyNCBhdCAxMToyMDowM1BNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gV2VkLCBNYXkgMDgsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
T24gVHVlLCBNYXkgMDcsIDIwMjQgYXQgMTE6NTc6MzZBTSAtMDcwMCwgV2VzbGV5IENoZW5nIHdy
b3RlOg0KPiA+ID4gPiBIaSBNaWNoYWVsLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiA1LzYvMjAyNCA0
OjA2IFBNLCBNaWNoYWVsIEdyemVzY2hpayB3cm90ZToNCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGlz
IHNwbGl0dGluZyB1cCB0aGUgaW50ZXJydXB0IGV2ZW50IGhhbmRsaW5nIGZyb20gb25lDQo+ID4g
PiA+ID4gaW50ZXJydXB0IHRocmVhZCB0byBzZXBhcmF0ZSBwZXIgZW5kcG9pbnQgaW50ZXJydXB0
IHRocmVhZHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSSBhc3N1bWUgdGhhdCB0aGUg
aW5jZW50aXZlIGZyb20gZG9pbmcgdGhpcyBpcyB0byBpbXByb3ZlIG92ZXJhbGwNCj4gPiA+ID4g
dGhyb3VnaHB1dCBudW1iZXJzLiAgV291bGQgeW91IGJlIGFibGUgdG8gc2hhcmUgc29tZSBkYXRh
IG9uIHRoZQ0KPiA+ID4gPiBiZW5lZml0cyBvZiBtb3ZpbmcgdG8gcGVyIEVQIGV2ZW50IG1hbmFn
ZW1lbnQ/DQo+ID4gPiANCj4gPiA+IFRoZSBtYWluIGJlbmVmaXQgaXMgdG8gbWFrZSBpdCBwb3Nz
aWJsZSB0byB1c2UgaGlnaCBkZW1hbmRpbmcgdXNiDQo+ID4gPiBlbmRwb2ludHMgc2ltdWx0YW5l
b3VzbHkuIEluIG91ciBzcGVjaWFsIGNhc2Ugd2Ugc2F3IHRoYXQgc3RyZWFtaW5nDQo+ID4gPiB2
aWEgdWFjIGFuZCBzdHJlYW1pbmcgdmlhIHV2YyB3YXMgcHJvZHVjaW5nIG5vaXNlIGluIHRoZSBh
dWRpbw0KPiA+ID4gc3RyZWFtLiBUaGlzIHdhcyBkdWUgdG8gdGhlIGZhY3QsIHRoYXQgdGhlIGlz
b2MgZmVlZGJhY2sgZW5kcG9pbnQNCj4gPiA+IHRoYXQgd291bGQgYWRqdXN0IHRoZSBzYW1wbGVy
YXRlIHdhcyBub3QgYmVpbmcgY2FsbGVkIGZhc3QgZW5vdWdoDQo+ID4gPiB3aGVuIHRoZXJlIHdh
cyBoZWF2eSBhIGxvdCBvZiB0cmFmZmljIGluIHRoZSB1dmMgZW5kcG9pbnQgY29udGV4dC4NCj4g
PiA+IA0KPiA+ID4gQnkgbW92aW5nIHRoZSBlbmRwb2ludHMgaW50byB0aGVpciBvd24gdGhyZWFk
IGhhbmRsZXJzIHRoZSBzaG9ydA0KPiA+ID4gZmVlZGJhY2sgcmVxdWVzdHMgYXJlIGF0IGxlYXN0
IGFibGUgdG8gYmUgc2NoZWR1bGVkIGluIGJldHdlZW4gdGhlIGJ1cnN0cw0KPiA+ID4gb2YgdGhl
IHV2YyBwYWNrYWdlcy4gVGhlIG5leHQgc3RlcCBpcyB0byBoYXZlIGFsbCB0aHJlYWRzIHJ1bm5p
bmcgb24NCj4gPiA+IGRpZmZlcmVudCBjcHUgY29yZXMsIHdpdGhvdXQgaW50ZXJmZXJpbmcgZWFj
aCBvdGhlci4gSG93ZXZlciwgYXMgd2UNCj4gPiA+IHN0aWxsIGhhdmUgbm90IG1hdHJpeCBpcnEg
YWxsb2NhdG9yIGZvciBhcm0sIHRoZXJlIHN0aWxsIGlzIG5vIGRpcmVjdA0KPiA+ID4gYmVuZWZp
dCBmcm9tIHRoYXQgeWV0Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gPiBUbyBhY2hpZXZlIHRo
aXMgd2UgY3JlYXRlIGEgbmV3IGR3YzMgaW50ZXJydXB0IGRvbWFpbiBpbiB3aGljaA0KPiA+ID4g
PiA+IHdlIG1hcCBhbGwgY2xhaW1lZCBpbnRlcnJ1cHRzIHRvIGluZGl2aWR1YWwgaW50ZXJydXB0
IHRocmVhZHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbHRob3VnaCB0aGUgZ2FkZ2V0IGxheWVy
IGlzIHByZXBhcmluZyB0aGUgY2xhaW1lZCBwYXJhbWV0ZXINCj4gPiA+ID4gPiBvZiBlYWNoIHVz
Yl9lcCB3aGljaCBjb3VsZCBiZSBjaGVja2VkIGlmIHRoZSBlbmRwb2ludCBpcw0KPiA+ID4gPiA+
IHRvIHVzZWQgb3Igbm90LCB0aGUgY2xhaW1lZCB2YWx1ZSB3YXMgMCBmb3IgZWFjaCBlcCBpbiBn
YWRnZXRfc3RhcnQuDQo+ID4gPiA+ID4gVGhpcyB3YXMgdGVzdGVkIHdoZW4gZGVzY3JpYmluZyBz
b21lIGNvbXBvc2l0ZSBnYWRnZXQgdXNpbmcgY29uZmlnZnMuDQo+ID4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4geWVhaC4uLiB0aGUgY2xhaW1lZCBmbGFnIGlzIGNsZWFyZWQgYnkgdGhlIFVTQiBn
YWRnZXQsIGllIFVTQiBjb25maWdmcw0KPiA+ID4gPiAobm90IHN1cmUgaWYgeW91J3JlIHVzaW5n
IHRoaXMpIHdoZW5ldmVyIGl0IGFkZHMgYSBVU0IgY29uZmlnLiAgVGhpcyBpcw0KPiA+ID4gPiB0
byBoYW5kbGUgbXVsdGkgY29uZmlnIHNpdHVhdGlvbnMsIHNvIHN1YnNlcXVlbnQgVVNCIGNvbmZp
Z3MgY2FuIGJlDQo+ID4gPiA+IGFzc2lnbmVkIChyZXN1c2UpIGVuZHBvaW50cywgc2luY2Ugb25s
eSBvbmUgY29uZmlnIGlzIGFjdGl2ZSBhdCBhIHRpbWUNCj4gPiA+ID4gZm9yIGEgVVNCIGRldmlj
ZS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyB3YXMgYSBzdHJ1Z2dsZSBmb3IgbWUgYXMgd2VsbCB3
aGVuIGFkZGluZyB0aGUgVFhGSUZPIHJlc2l6aW5nDQo+ID4gPiA+IGxvZ2ljLiAgV2Ugd29uJ3Qg
YWN0dWFsbHkga25vdyB3aGljaCBFUHMgYXJlIGdvaW5nIHRvIGJlIHVzZWQgdW50aWwgdGhlDQo+
ID4gPiA+IGhvc3QgaXNzdWVzIHRoZSBzZXQgY29uZmlndXJhdGlvbiBwYWNrZXQgdG8gc2VsZWN0
IGEgY29uZmlnLCBhbmQgdGhlDQo+ID4gPiA+IHNldF9hbHQoKSBjYWxsYmFjayBpc3N1ZXMgdXNi
X2VwX2VuYWJsZSgpLiAgU28gdGhlIGltcGxlbWVudGF0aW9uDQo+ID4gPiA+IChUWEZJRk8gcmVz
aXppbmcpIGlzIGN1cnJlbnRseSBiYXNlZCBvbiB0aGUgbWF4aW11bSBwb3RlbnRpYWwgZW5kcG9p
bnRzDQo+ID4gPiA+IHVzZWQgYnkgYW55IFVTQiBjb25maWd1cmF0aW9uLg0KPiA+ID4gPg0KPiA+
ID4gPiBOb3Qgc3VyZSBpZiBoYXZpbmcgMzEgKHBvdGVudGlhbGx5KSBkaWZmZXJlbnQgSVJRIGVu
dHJpZXMgd291bGQgYmUgb2ssDQo+ID4gPiA+IGJ1dCBtYXliZSBpdCB3b3VsZCBiZSBzaW1wbGVy
IHRvIGp1c3QgdG8gcmVxdWVzdCBJUlEgZm9yIGR3Yy0+bnVtX2Vwcw0KPiA+ID4gPiBhbHdheXM/
DQo+ID4gPiA+DQo+ID4gPiA+IEhhdmUgeW91IHRyaWVkIHRoaXMgb24gYSBtdWx0aSBjb25maWcg
ZGV2aWNlPw0KPiA+ID4gDQo+ID4gPiBObywgSSBkaWRuJ3QuIEkgZG91YnQgdGhhdCB0aGlzIHdp
bGwgd29yayBhZnRlciB5b3VyIGV4cGxhbmF0aW9uLiBTbw0KPiA+ID4gdGhhbmtzIGZvciB0aGUg
aW5zaWRlcyENCj4gPiA+IA0KPiA+ID4gSSB0cmllZCBwdXR0aW5nIHRoZSByZXF1ZXN0X3RocmVh
ZGVkX2lycSBpbnRvIHRoZSBlcF9lbmFibGUgZnVuY3Rpb24NCj4gPiA+IGJ1dCB0aGlzIGRvZXMg
bm90IHdvcmsgYXMgSSBzZWUgYSBsb3Qgb2Ygc2NoZWR1bGUgd2hpbGUgYXRvbWljDQo+ID4gPiBl
cnJvcnMuIFRoaXMgaXMgcG9zc2libGUgYXMgZXBfZW5hYmxlIGlzIGNhbGxlZCBmcm9tIGFuIHNl
dCBhbHQNCj4gPiA+IGNvbWluZyBmcm9tIGVwMCBpbnRlcnJ1cHQgdGhyZWFkIGNvbnRleHQuDQo+
ID4gPiANCj4gPiA+IFNvIHRoZXJlIGlzIHByb2JhYmx5IG5vdyBubyBvdGhlciBvcHRpb24gbGVm
dCB0byBoYXZlIGV4YWN0IGVuZHBvaW50DQo+ID4gPiBpbnRlcnJ1cHQgdGhyZWFkcy4gSSB3aWxs
IHJld29yayB0aGlzIGJhY2sgdG8gcmVxdWVzdCBhIGt0aHJlYWQgZm9yIGVhY2gNCj4gPiA+IGVu
ZHBvaW50IGV2ZW4gYXMgd2Ugd2lsbCBwcm9iYWJseSB3b3VsZCBub3QgYmUgdXNpbmcgdGhlbS4N
Cj4gPiA+IA0KPiA+IA0KPiA+IERvIHlvdSBoYXZlIGFueSBkYXRhIG9uIGxhdGVuY3kgaGVyZT8N
Cj4gDQo+IEkgZG9uJ3QgaGF2ZSB0aGUgZXhhY3QgbnVtYmVycyBmb3IgdGhlIHVhYyBmZWVkYmFj
ayBpc29jIGVuZHBvaW50DQo+IGF0IHRoZSBtb21lbnQuIEJ1dCB3aXRob3V0IHRoZSBwYXRjaCBh
cHBsaWVkLCBpdCB3YXMgcmVwcm9kdWNhYmx5DQo+IHJldHVybmluZyB3aXRoIEVYREVWIHdoZW4g
d2Ugc3RhcnRlZCB1dmMgc3RyZWFtaW5nIGFuZCB0aGVyZWZvcg0KPiBpbmNyZWFzZWQgdGhlIGFt
b3VudCBvZiBldmVudHMgcGVyIGludGVycnVwdCB0aHJlYWQgY3ljbGUuDQo+IA0KPiBXaXRoIHRo
ZSBwYXRjaCBhcHBsaWVkIGhvd2V2ZXIsIHdlIGFyZSBhYmxlIHRvIG9ubHkgcm91dGUgdGhlIGV2
ZW50cyB0bw0KPiB0aGUgY29ycmVzcG9uZGluZyBzb2Z0IGlycXMgYW5kIGxlYXZlIHRoZSBtb21l
bnQgb2YgdHJ1dGggdG8gdGhlDQo+IHNjaGVkdWxlci4NCg0KQmFzaWNhbGx5IHlvdSdyZSB0cnlp
bmcgaW5jcmVhc2UgdGhlIHByaW9yaXR5IG9mIGR3YzMgYnkgdGhlIGdyZWF0ZXINCm51bWJlciBv
ZiBzb2Z0IGludGVycnVwdHMuDQoNCj4gDQo+ID4gSSBkb24ndCBzZWUgaG93IGludHJvZHVjaW5n
IG1vcmUgc29mdCBpbnRlcnJ1cHRzIHdvdWxkIGltcHJvdmUgb24NCj4gPiBsYXRlbmN5LCBpZiBh
bnl0aGluZywgaXQgc2hvdWxkIGJlIHdvcnNlPw0KPiANCj4gV2h5IHNob3VsZCBleHBsaWNpdCBo
YW5kbGluZyBvZiBjb2hlcmVudCBlcCBldmVudHMgb24gb25lIGNwdSBjb3JlDQo+IGludHJvZHVj
ZSBtb3JlIGxhdGVuY3kgdGhlbiBieSBpbnRlcmxlYXZpbmcgZGlmZmVyZW50IGV2ZW50cyBmb3IN
Cj4gYXJiaXRyYXJ5IGVwIGFsbCBpbiBvbmUgdGhyZWFkPw0KDQpCZWNhdXNlIHdlIGFyZSBvbmx5
IHVzaW5nIGEgc2luZ2xlIGludGVycnVwdCBsaW5lLCB0aGUgc2VxdWVuY2Ugb2YNCmV2ZW50cyBu
ZWVkIHRvIGJlIGhhbmRsZWQgMSBzZXQgYXQgYSB0aW1lLiBUaGUgYW1vdW50IG9mIHRpbWUgc2F2
ZWQgZnJvbQ0KaGFuZGxpbmcgaW50ZXJydXB0cyBvZiBkaWZmZXJlbnQgZW5kcG9pbnQgc2hvdWxk
IGJlIG1pbmlzY3VsZS4gVGhlcmUncw0KbGF0ZW5jeSB0byBzd2l0Y2hpbmcgY29udGV4dCBhbmQg
bG9ja2luZywgd2hpY2ggSSB0aGluayB3b3VsZCBvZmZzZXQgYW5kDQppbnRyb2R1Y2UgbW9yZSBs
YXRlbmN5IHRoYW4gd2hhdCB5b3UgY2FuIHBvdGVudGlhbGx5IHNhdmUuDQoNCkknZCBsaWtlIHRv
IHNlZSBkYXRhIG9uIHRoZSBpbXByb3ZlbWVudCBvbiB0aGUgbmV0IGxhdGVuY3kgaGVyZS4NCg0K
PiANCj4gPiBUaGlzIGlzIG1ha2luZyB0aGUgZHJpdmVyIHdheSBtb3JlIGNvbXBsaWNhdGVkIGFu
ZCBwb3RlbnRpYWxseQ0KPiA+IGludHJvZHVjZSBtYW55IGJ1Z3MuDQo+IA0KPiBQb3NzaWJsZSwg
YnV0IG5vdCB1bnNvbHZhYmxlLg0KPiANCj4gPiBJIG1heSBiZSB3cm9uZyBoZXJlLCBidXQgSSBz
dXNwZWN0IHRoYXQgYnkgbXVsdGlwbHlpbmcgdGhlIGludGVycnVwdA0KPiA+IGhhbmRsaW5ncywg
eW91IF9tYXlfIHNlZSBpbXByb3ZlbWVudCBkdWUgdG8gdGhlIGEgaGlnaGVyIGNoYW5jZSBiZWlu
Zw0KPiA+IHNlbGVjdGVkIGJ5IHRoZSBzY2hlZHVsZXIuIEhvd2V2ZXIsIHRoZSBvdmVyYWxsIGxh
dGVuY3kgd2lsbCBwcm9iYWJseQ0KPiA+IGJlIHdvcnNlLiAoY29ycmVjdCBtZSBpZiBJJ20gd3Jv
bmcpLg0KPiANCj4gSSBkb3VidCB0aGF0IGl0IHdpbGwgYmUgd29yc2UgaWYgZWFjaCBzb2Z0aXJx
IGNhbiBiZSBoYW5kbGVkIG9uDQo+IGRpZmZlcmVudCBjcHVzIGF0IHRoZSBzYW1lIHRpbWUuDQoN
ClNlZSBjb21tZW50IGFib3ZlLg0KDQo+IA0KPiA+IFRoaXMgd2lsbCBhZmZlY3Qgb3RoZXIgYXBw
bGljYXRpb25zLg0KPiANCj4gTGV0J3MgbWFrZSBzdXJlIHdlIHdpbGwgbm90IGJyZWFrIGFueXRo
aW5nIG9uIHRoZSB3YXkuIE9rYXk/IDopDQo+IA0KPiA+IExldCdzIG5vdCBkbyB0aGlzLg0KPiAN
Cj4gSSBhY3R1YWxseSB0aG91Z2h0IHRoYXQgdGhpcyBpcyBldmVuIHJlcXVlc3RlZDoNCj4gDQo+
IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3VzYi9kd2MzLmh0bWwNCj4gDQoNClRoYXQncyBhIHZl
cnkgb2xkIGFuZCBvdXRkYXRlIFRPRE8gbGlzdC4gV2UgZG9uJ3QgdXNlDQp3YWl0X2Zvcl9jb21w
bGV0aW9uX3RpbWVvdXQgaW4gdGhlIGNvbW1hbmRzLiBEdXJpbmcgdHJhbnNmZXJzLCB3ZSdyZQ0K
dXNpbmcgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQsIGFuZCBpdCBjb21wbGV0ZXMgYWxtb3N0IGlt
bWVkaWF0ZWx5LiBUaGUNCm9ubHkgdGltZSB3aGVyZSBhIGNvbW1hbmQgbWF5IHRha2UgYSBsb25n
ZXIgdGltZSBpcyB3aGVuIHdlIG5lZWQgdG8NCmJyaW5nIHRoZSBkZXZpY2UgZG93biBmb3IgcmVz
ZXQvZGlzY29ubmVjdCBhbmQgc3RvcCB0cmFuc2ZlcnMsIGJ1dA0KdGhhdCdzIG5vdCB3aGF0IGNv
bnRyaWJ1dGVzIHRvIHRoZSBwcm9ibGVtIGhlcmUuDQoNCkludGVybmFsIHRlc3RzIHNob3cgdGhh
dCB3ZSBjYW4gYWNoaWV2ZSB2ZXJ5IGNsb3NlIHRoZW9yZXRpY2FsIFVTQg0Kc3BlZWRzIHdpdGgg
dGhlIGN1cnJlbnQgZHdjMyBpbXBsZW1lbnRhdGlvbi4NCg0KQlIsDQpUaGluaA==

