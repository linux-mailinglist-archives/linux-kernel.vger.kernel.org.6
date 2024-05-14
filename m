Return-Path: <linux-kernel+bounces-178361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFE8C4C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2359B21251
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011D11711;
	Tue, 14 May 2024 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ibzUlLh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EDE545;
	Tue, 14 May 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670296; cv=fail; b=rucYsBokf0P6P6ZnSiA5CkJqghPAUaPrSS9tGTshZn+P+459wrh+1Stj4758RM0fNZdcW3kial1D71Rtmht5qHFTEZYVUkYLkpw9tgylobbC/N3hGX1Xyc/LZieYD7QrPZVmbcKuA7B5OcjyjVmdXUH966Pszw+ABrADSqUyZBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670296; c=relaxed/simple;
	bh=vB4jX5zlbuYafczS01oxnivW2OSzGd8Ex/WLpV7vkdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mVhohYsYemeJLbloB79Y6/Cll9OJA/wb0VlGr47BZTMX7C0XjtOorDM5MnQ74462LmmGVO4R2xdZgZIdJQb4l94ha7EKJeyZe0xGmsYGx8IcpMXWMDDMcie4vhHuV9nwVYj6WLG5/L+tkPRQia0OhjHiOr03FTF8lWUHll5OUQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ibzUlLh; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK6qwe0BFcRddRFo0oUarXO4Tg//caso/BJ9wnd5Ijt9/zmIGZv6hzg6QpUKf15W+U9f6YS6BiexgpJzaiN/8GAZrK1kPyR1Z0klZwJJBcGwuGxSJi5wPfJxTKLM1a+E2uDyuEZqU6QpA4wQfLM+J8H6QQxA388vmENSv0D2cNW3n/bnKUwUNVk0dgz9rEOe0Dd/A/0Pf2HK8F9PCQaBqg/C7C6Rluh8F+c6aZXPASteogcySZT/Jvp1nsPYDXy2aCo7KsmWVKhfsfd1vAoeOTvLoYGu1LkJoSzr3pVzBQNvvklkPPtZVnOY9rTTpB91JJvrbozMVGgrzRXpHBaCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB4jX5zlbuYafczS01oxnivW2OSzGd8Ex/WLpV7vkdY=;
 b=U/AzX+Z/8wOsDzl8IBiPQN/Abl9BJb73FvK41l4Pebu2e8+/KCXdXzxRQrpj/2+k1ABzPUEj9rjfBBUuq+TFTPaONKmQg/kJLkD2n5aX71nUxA5DIghy0rD947wCHVAD3CnxPK0xdwYV/J34s0mR8NLPYXK+WeJ19HE2MMq3FhaLyHa1XziniUNIp/CGn61Y810Z/YYioe5J3jIaQaV07yKnzzBOIUD6gNu2gfBoAGwejJAxHeUkgjqPcBl21ceGzDqN3CPxaFH9JxB4uKUQPfv5guP6U8zGZW9VwThhK/g8v4n+cokhloDOVbEMNES8D9lBc330dVbwxi4RIipWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB4jX5zlbuYafczS01oxnivW2OSzGd8Ex/WLpV7vkdY=;
 b=5ibzUlLhO+DpVsN7fPMq6cLwnbgZJiG3jDH5o4hQjHZlU4M8/kWPVAFxis/FLhOuouXlHP3gv89qt2bpDX+RigFgnJakjd3eMTK13Ui7RlnlQx2GL695RGb+xiy32zddGOAAmJMNm3ybDKP3JmtdZ3/8P0islhIcMi/09iClXsI=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:04:51 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:04:50 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Kuen-Han Tsai
	<khtsai@google.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: Dan Scally <dan.scally@ideasonboard.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "'Mehta, Piyush'" <piyush.mehta@amd.com>, "Paladugu,
 Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>, "Sayyed, Mubin"
	<mubin.sayyed@amd.com>
Subject: RE: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index:
 AQHaDVvg8JAIX7opVUGPeVND2R+OwrBm7bwAgAlqngCADGtuAIABEQoAgAAcxwCAVT1twIANsP0AgBA2vOCApmChIA==
Date: Tue, 14 May 2024 07:04:50 +0000
Message-ID:
 <MN0PR12MB59537CD8D7AD30C20B52619EB7E32@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
 <20231117032832.6k4msq2vlp56asho@synopsys.com>
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240119021520.757vpt3oeig4hws2@synopsys.com>
 <MN0PR12MB5953C70F29987CCDF3EAC67DB77E2@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To:
 <MN0PR12MB5953C70F29987CCDF3EAC67DB77E2@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB5829:EE_
x-ms-office365-filtering-correlation-id: 02d574f1-f85b-48f8-7a0f-08dc73e4261e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mk5Va00yTjlUZEorT0RqRnZzS0ZKWGFSL2xPanYyYmFiVTI2VlpIc1JGRCtX?=
 =?utf-8?B?eTUwVDNhaEx6SDF4WCtxRkdzSG1SdVBIVEQ2bllaLzJ2Q3d2MmJtakVuek1l?=
 =?utf-8?B?OG5OcUVmUVA2MHJJSldFYWtvQ1RYSE9lRm1obDVOemJMYUJ5VHFZMGlrbUlJ?=
 =?utf-8?B?ZXNXMWE4aVVZaTd2NlBLYUpQUS8wMERKSlowYmZLMFRwUlpCSTRsaWRqbDN1?=
 =?utf-8?B?dVdYdWRIa2pKajRZMURvYVRibkNmNXdJOThWUGErQkpYVithZElBa214eCtm?=
 =?utf-8?B?dmd4d0o4WVNrVHdxN09QWUIzM3ZzbkxubnVqTDl6NllBT2QxMzF0ak8zVjd2?=
 =?utf-8?B?OWIwS0pFUTRQTW03Q2Y1SkhJU2Q0bmprMU41RHZGMzBhNzFRMDYwYjhpT0E3?=
 =?utf-8?B?bUdSbTdSS2VCN1liZHVYSkFCUEM3NCtKRWtFMnhXaTJqTkVZaGZSdnk1LzJR?=
 =?utf-8?B?S0h4STFLZDNMK3ZTUEpJeUdGUXlmdTlSMEUvUTVlbEYzYXBtRGhYZExFKzBl?=
 =?utf-8?B?OEhOdEdCUUZyTm5wK2Zua29ud0pDWXdQSElMbUQ0UWpwRDUycEYzbUJ1bXh6?=
 =?utf-8?B?dE1jbWtKS25xMWxrSFltcHFYVnVxSlg2dmVJeWVRMy9mV0xRNmwvSGFxTFF0?=
 =?utf-8?B?c2dRU3lSYmxhRldVdWFWZC9kMW8rdG1POURYSCtITWQ2VitNWmpXMzlQTlFE?=
 =?utf-8?B?RTlWYWhwSTBmVit6Wk9uMmdWaWNMNkhON0ZIS2V1K0R5bVVRSytwY3p2c2ww?=
 =?utf-8?B?RXBkeXRKcW9kWjBoWFhVUkd5VHdsZlh0UHhTQnh3Qjc4QVlSc0ZlNDBhT0F1?=
 =?utf-8?B?dnZwNmtRSHdZbS94RldSemhpTVQwVW5rODBjVXExRlFGOW9mWE5QUE5oVHRj?=
 =?utf-8?B?S1d0cWhyVlVXZ09Lb1VVUVIwQ1Q2dDVuMmFQWExDM2NmbkFicGRRUFhNNVYv?=
 =?utf-8?B?UDViQVMzKzdFQjk5S1hoNzdGNmhIL2s1aW9Ub28wcDN5Zm9vc21oQzIwK090?=
 =?utf-8?B?MjdKdnRUZVVzQ2F2V08wdW9KY1I4R05na0xYL1llQ0dmTDlJejgxdFRGN0sr?=
 =?utf-8?B?RklYeld6RTA0Qjh0RTNzZk1uUzNEbVNML1FpSWFJSCtDck80WDl2QUJPOWtW?=
 =?utf-8?B?bll6U0drdUZFdjMvSzVwbC9ESzJNKy92OHBEMktkYmhMN0kwMmpIamgvc1Ra?=
 =?utf-8?B?S2pJclQzTEo2OVAyOWV2djhySDZhOG9sclN1VUxLMVA0dWh6R2RHNGh0dUdx?=
 =?utf-8?B?WHdlSjZIZjF5cWpyanJDYVhRcTFrOHpjdXZtS0xJNmpyYys4ZjN0bVB5N1lj?=
 =?utf-8?B?WHlabHRwTml5end3SnVRVzRoRFlBMTVXQW1hK09ZT3lST053enBTV1lZaERS?=
 =?utf-8?B?UFh6N1Znb3RZdUZEb0xKWGJWY2NCV1VXaVJwcHVSd2RnN09ZNEVTNko5S3Fa?=
 =?utf-8?B?YWhTVnY1aUxGL1VSR3dtUlU1QTNHcXFLQmRYNnY1cDhWUTQzNVJHQ1k0N3Uw?=
 =?utf-8?B?aThBN3BwY2pkZ2RVa0l2OU5tQ0lDb3gyMno1My82MG9EdWhmM3BvZTdlcWxp?=
 =?utf-8?B?WUo3U1lGazQrV25WSUFZQU9DOHN3WjQ4eUdQcDZncURyUmttTXJTaVVhVkJF?=
 =?utf-8?B?YlVqZFNPT0N6NWdQSkxwbFFFbGF3Q2dPQU0xSlE2MlduQWM1SmI0bGhJQk1Y?=
 =?utf-8?B?MHI5RHNJUmYydHhCU3JqeHNpSE0vTzdxelRoVWV4ZWxSeDcrbkNZVjkvWmJn?=
 =?utf-8?B?dkJvQ2tJeW5lWEh0NTJBdmtzamJmV0ozUUphTG1IRmlrMEZKS3JMUmRmaGZM?=
 =?utf-8?B?aWVzaXZ5aFdyQ3pPNUpPQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHh0d0IrSDVHakZyVHVuUnFxNUhFZmVzU0Exc2FxS2ozME0reXJZb1J4NC9i?=
 =?utf-8?B?aU1OQXF6VmRmQzdmcy9EUStscHpwT3ViY3VxU3hDTFZpbFhHeHA4L25rc2cr?=
 =?utf-8?B?MGJvQjFpNGpqeURhM3RUcjUwcXZMMWt2Wlg5aEFJOVhTdHFxM2pPRUo2bWtL?=
 =?utf-8?B?Ymw4Mm1yUTMxRXNISFREVGt3TUllUmxncEVtM1k2Z1BFZkNTMnJITUdWcEJF?=
 =?utf-8?B?ZHNOQVB4UUtJdGxiL2IvNTJGZTRIeXVDc3dYc3pWVHdSUU0wbG1sRCtqM0tx?=
 =?utf-8?B?ZzU1dFl3UXlZZGQrdTlCd1hNQkxTcVpEYmYrRkJQQnNsMDBkdnhWK2ljZDVJ?=
 =?utf-8?B?Q1NzNDUxUVNYcjdqaXZVLzMrOUN3NGdxb01LYllUS3dTa1VnRGhYWDgyNHFG?=
 =?utf-8?B?dlh5c050bmN1SG1Rbi8xNDNUNjFHZHoxbUUycHNLOFRJcDRKT2k2RVpiTGkw?=
 =?utf-8?B?d2hrVzhLV28zemlUNHkvUCs2Mm1SbjQ0NmdKMXZKN0FVWjU1V29zbk9yY3FQ?=
 =?utf-8?B?VG0xV3RxaUhZMnlwWWFTV090cWJ6Yml6SHpHUStDbXpLZ2tJRzE2T0I5VVJj?=
 =?utf-8?B?WWYrTHErTDlmTFdQQzBPeno2N2FncXZ6bXFzZWlTWVlTZDJVVWVWaWllaTg5?=
 =?utf-8?B?OEQyRTRwU1EvZ1FFWFVJY1M2NFgvempocTVZR1Q4SUF5RkZ6TmhqRzRPRldX?=
 =?utf-8?B?NFVEcUZhRzhXY0dWVW5ia1lXZldzL3Q2dVkvWDRHQWdwWUNzN25mWXVLS2xH?=
 =?utf-8?B?U0NoZkR4bE5QL01VbHR2OTJjVm5lck4zTDRTQW5DY0lzQXp1VXlhNlhCNUdS?=
 =?utf-8?B?VlVtN0xaOEtsODVKTkxmbytmdy9UUzlHOTlpZHNwMFlFanRNK2dvT1EvdWRq?=
 =?utf-8?B?UXhWcUNJaDFVM00vMnNkSnBHTjNDRDF0OTIrcUl4aGlMdEh6ZitxNjIvb2Fr?=
 =?utf-8?B?UVlUc1BTcEVxQ0l4U1VleSthZDJjWjBmdlJ1MW5XR0NzS3hDOC9lcmFMbHFy?=
 =?utf-8?B?ZFF5dHJJTWcyNW1DYXpHRHN5OVdNZkZzb2NtSW5XUFdXNFBVend0QmpESmRL?=
 =?utf-8?B?cnppM2gycnVuYlFMOWg5OVZ1MFpWK1ZPRDRxTFZIbXJjWlV4dnZPOUNoaTlN?=
 =?utf-8?B?OTNmcjBLZVY3OXlKeElRVEpVYU1YZUkwZDJUOVVEemxTTkJXV0R5WlVoams0?=
 =?utf-8?B?VVRsVUFqL25KQkhzMHltT1FhcitGVHcvYThYMHVzVXJCTHBnOHpFSFpBdGZu?=
 =?utf-8?B?dkNkZFZ0Qjk2NDZxbjcwbGpyV1oxT2VCSEFNSjNCL2hyS1BWUEttUjB4TGxw?=
 =?utf-8?B?akJqSjE5K3NwanF2SU5qTGxYN3l0dUJwOThyZkRnRGNpazlHemY2U1JCUEpW?=
 =?utf-8?B?NWdML3BhMDZHY1p3aDRLRU5aNGk0RkxOYjcrblo3TjNmenQwWVh6eDdGVWFZ?=
 =?utf-8?B?MEhVcmxXeWVVSElCdFY5OWtsc3A2SVV0ZUFwaHJqbmJxeUp2TG11ditvUWVG?=
 =?utf-8?B?VFAwUjltSjB0YUsxSStVcmpOYldhM1R0VERDVUIwTDNGZGpLM2hxQ1F5UWs3?=
 =?utf-8?B?cUt0Ynk3MG9qWm1CcnZXRWFwUGhDYjRVMHlrdnYzaHpTY1AwS0RSZ2poWFFw?=
 =?utf-8?B?OEhLVHlTL25SS0hCYlNKdEthV3BQdlRwUXowMjJrY0ptMTVkS2pqVURwVlQ1?=
 =?utf-8?B?TCs4S2lOYzlsNkpuekNpbDF1TVU3aWRJb0VKQVVDU0VRRHI5YkNlOHY4TXNu?=
 =?utf-8?B?OWhEMy8xekZuVXNVY0QySm9OUDV2VHpGNGRjdi9uN0ZLRXphcnBqL2R6NmxR?=
 =?utf-8?B?UjBWYldjUmxCTzl3Q1dKaUh5SEZ1NEkrQ3ZPVnlTckk5Q2FINWJ1RExjZlU1?=
 =?utf-8?B?aUV6KzBDTk1BM25VakhtQTNDUUhPblhULzJoRGxWSjlZcWV2T2c3QmdCU05x?=
 =?utf-8?B?d1NSeEZHWXZUS2dIVnNscjlncFV2ZU9ESVhGV0tOSm00TE80Uy92MnhoUHo5?=
 =?utf-8?B?YXFnanpXZ2p5b2VrcUswYnVVdHloek85elRFR1BtVTFsbHVUWTRGczBPbkxV?=
 =?utf-8?B?T2J4RlFlZ21oM3c5ODRXT2NYanRQN2M4RmdaZUx3QVJuT0FKMk9FNy9od0lM?=
 =?utf-8?Q?5QNo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d574f1-f85b-48f8-7a0f-08dc73e4261e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:04:50.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m75dIX/NPredv/OaqxC8wSG0hhhPJzDtjztaD4VarDYDP71DAlzqGF+ChiNQZgQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5kZXksIFJhZGhleSBTaHlh
bQ0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjksIDIwMjQgMzozOCBQTQ0KPiBUbzogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBDYzogRGFuIFNjYWxseSA8ZGFu
LnNjYWxseUBpZGVhc29uYm9hcmQuY29tPjsgS3Vlbi1IYW4gVHNhaQ0KPiA8a2h0c2FpQGdvb2ds
ZS5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gbGF1cmVudC5waW5jaGFydEBp
ZGVhc29uYm9hcmQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
dXNiQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+
OyBNZWh0YSwNCj4gUGl5dXNoIDxwaXl1c2gubWVodGFAYW1kLmNvbT47IFBhbGFkdWd1LCBTaXZh
IER1cmdhIFByYXNhZA0KPiA8c2l2YS5kdXJnYS5wcmFzYWQucGFsYWR1Z3VAYW1kLmNvbT47IFNh
eXllZCwgTXViaW4NCj4gPG11YmluLnNheXllZEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIXSB1c2I6IGdhZGdldDogdXZjX3ZpZGVvOiB1bmxvY2sgYmVmb3JlIHN1Ym1pdHRpbmcgYQ0K
PiByZXF1ZXN0IHRvIGVwDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
RnJvbTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IFNlbnQ6
IEZyaWRheSwgSmFudWFyeSAxOSwgMjAyNCA3OjQ1IEFNDQo+ID4gVG86IFBhbmRleSwgUmFkaGV5
IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+ID4gQ2M6IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47IERhbiBTY2FsbHkNCj4gPiA8ZGFuLnNjYWxs
eUBpZGVhc29uYm9hcmQuY29tPjsgS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+Ow0K
PiA+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25i
b2FyZC5jb207IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwNCj4gPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+
OyBNZWh0YSwgUGl5dXNoIDxwaXl1c2gubWVodGFAYW1kLmNvbT47DQo+ID4gUGFsYWR1Z3UsIFNp
dmEgRHVyZ2EgUHJhc2FkIDxzaXZhLmR1cmdhLnByYXNhZC5wYWxhZHVndUBhbWQuY29tPg0KPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1dmNfdmlkZW86IHVubG9jayBiZWZv
cmUgc3VibWl0dGluZw0KPiA+IGEgcmVxdWVzdCB0byBlcA0KPiA+DQo+ID4gSGksDQo+ID4NCj4g
PiBPbiBXZWQsIEphbiAxMCwgMjAyNCwgUGFuZGV5LCBSYWRoZXkgU2h5YW0gd3JvdGU6DQo+ID4g
Pg0KPiA+ID4gVGhhbmtzLCBUaGluaC4gSSBjYW1lIGFjcm9zcyB0aGlzIHRocmVhZCBhbmQgd2Fu
dGVkIHRvIGNoZWNrIGlmIHlvdQ0KPiA+ID4gaGF2ZSBzb21lIGZpeCByZWFkeT8NCj4gDQo+IEkg
aGF2ZSBhZGRlZCBNdWJpbiB0byB0aGlzIHRocmVhZCBhcyBoZSBpcyB3b3JraW5nIG9uIHZhbGlk
YXRpbmcgYmVsb3cgZml4Lg0KDQpUaGluaDogIFVuZm9ydHVuYXRlbHksIGkgYW0gbm90IGFibGUg
dG8gcmVwbGljYXRlIGZhaWx1cmUgYmVoYXZpb3VyIGFuZCANCnZhbGlkYXRlIHRoZSBiZWxvdyBm
aXguIFRlc3RlZCB3ZWJjYW0gZ2FkZ2V0IHRha2luZyBzdHJlYW0gZnJvbSB2aXZpZCANCmFuZCB0
aGVuIGZyYW1lIGNhcHR1cmUgb24gaG9zdCB1c2luZyB5YXZ0YS4gDQoNCkBLdWVuLUhhbiBUc2Fp
OiBEbyB5b3UgaGF2ZSBmYWlsdXJlIGVudmlyb25tZW50IHRvIHJlcGxpY2F0ZSB0aGUgaGFuZz8g
DQoNCj4gDQo+ID4NCj4gPiBXb3VsZCB5b3UgbWluZCB0ZXN0IHRoaXMgY2hhbmdlIHRvIHNlZSBp
ZiBpdCBmaXhlcyB0aGUgaXNzdWU6DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiBpbmRleCA4ZDE4
ODFhZGNkODAuLmY0MGM3YjkxMDVjYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0x
ODA4LDYgKzE4MDgsNyBAQCBzdGF0aWMgaW50IGR3YzNfcHJlcGFyZV90cmJzKHN0cnVjdCBkd2Mz
X2VwDQo+ICpkZXApDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGlj
IHZvaWQgZHdjM19nYWRnZXRfZXBfc2tpcF90cmJzKHN0cnVjdCBkd2MzX2VwICpkZXAsIHN0cnVj
dA0KPiA+ICtkd2MzX3JlcXVlc3QgKnJlcSk7DQo+ID4gIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0
X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwDQo+ID4gKmRlcCk7
ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXN0b3JlX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2Vw
ICpkZXApOw0KPiA+DQo+ID4gQEAgLTE4NzQsOSArMTg3NSwyNyBAQCBzdGF0aWMgaW50IF9fZHdj
M19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3QNCj4gPiBkd2MzX2VwICpkZXApDQo+ID4gIAkJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAmZGVwLT5zdGFydGVkX2xpc3QsIGxp
c3QpDQo+ID4gIAkJCWR3YzNfZ2FkZ2V0X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxLA0KPiA+
IERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQpOw0KPiA+DQo+ID4gLQkJLyogSWYgZXAgaXNu
J3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFuc2ZlciBwZW5kaW5nICovDQo+ID4g
LQkJaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPiA+
IC0JCQlkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NhbmNlbGxlZF9yZXF1ZXN0cyhkZXApOw0KPiA+
ICsJCWlmICgoZGVwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RBUlQpIHx8DQo+ID4gKwkJICAg
IChkZXAtPmZsYWdzICYgRFdDM19FUF9XQUlUX1RSQU5TRkVSX0NPTVBMRVRFKSB8fA0KPiA+ICsJ
CSAgICAoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkpIHsNCj4gPiArCQkJ
LyogSWYgZXAgaXNuJ3Qgc3RhcnRlZCwgdGhlbiB0aGVyZSdzIG5vIGVuZCB0cmFuc2Zlcg0KPiA+
IHBlbmRpbmcgKi8NCj4gPiArCQkJaWYgKCEoZGVwLT5mbGFncyAmDQo+ID4gRFdDM19FUF9FTkRf
VFJBTlNGRVJfUEVORElORykpDQo+ID4gKw0KPiA+IAlkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2Nh
bmNlbGxlZF9yZXF1ZXN0cyhkZXApOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCS8qDQo+ID4g
KwkJCSAqIFRvIGJlIGluIHRoaXMgY29uZGl0aW9uIG1lYW5zIHVzYl9lcF9xdWV1ZSgpIGlzbid0
DQo+ID4gKwkJCSAqIGNvbXBsZXRlZCB5ZXQuIFNpbmNlIHRoZSBjb250cm9sbGVyIGhhc24ndCBv
d25lZA0KPiA+IHRoZQ0KPiA+ICsJCQkgKiByZXF1ZXN0cyB5ZXQsIGRvbid0IGdpdmUgYmFjayB0
aGUgcmVxdWVzdHMgb24gZmFpbGVkDQo+ID4gKwkJCSAqIHVzYl9lcF9xdWV1ZS4gU2ltcGx5IHJl
bW92ZSB0aGVtIGZyb20gdGhlDQo+ID4gZW5kcG9pbnQncw0KPiA+ICsJCQkgKiBsaXN0Lg0KPiA+
ICsJCQkgKi8NCj4gPiArCQkJd2hpbGUgKCFsaXN0X2VtcHR5KCZkZXAtPmNhbmNlbGxlZF9saXN0
KSkgew0KPiA+ICsJCQkJcmVxID0gbmV4dF9yZXF1ZXN0KCZkZXAtPmNhbmNlbGxlZF9saXN0KTsN
Cj4gPiArCQkJCWR3YzNfZ2FkZ2V0X2VwX3NraXBfdHJicyhkZXAsIHJlcSk7DQo+ID4gKwkJCQlk
d2MzX2dhZGdldF9kZWxfYW5kX3VubWFwX3JlcXVlc3QoZGVwLA0KPiA+IHJlcSwgLUVJTlBST0dS
RVNTKTsNCj4gPiArCQkJCXJlcS0+c3RhdHVzID0NCj4gPiBEV0MzX1JFUVVFU1RfU1RBVFVTX0NP
TVBMRVRFRDsNCj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4gPg0KPiA+ICAJCXJldHVybiByZXQ7DQo+
ID4gIAl9DQo+ID4NCj4gPiBCVFcsIHdoYXQgd2FzIHRoZSBlcnJvciBjb2RlIHJldHVybmVkIGZy
b20gdXNiX2VwX3F1ZXVlKCk/IElzIGl0IC0NCj4gPiBFVElNRURPVVQ/DQo+ID4NCj4gPiBUaGFu
a3MsDQo+ID4gVGhpbmgNCg==

