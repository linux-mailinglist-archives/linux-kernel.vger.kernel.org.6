Return-Path: <linux-kernel+bounces-428368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936939E0DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCB8B2FEE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025131DEFE8;
	Mon,  2 Dec 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7NQLyfg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e7xvAtqE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E119BBA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172856; cv=fail; b=t97jgp5WUJuHYg8xM6xb6xv/se+rgp+u2t1u7k9kKhlJK3Ow44XV+9a7xJbOySo1uN+H5nWQuc55L3dpIRAeanbbu32w4pyRQLbzDT4BgKQRLhRj20Dhk62MK700UzBzS4PuWW/VQfhKcsJMc36iqZq1JXWsUn5P8lZw0fQXyg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172856; c=relaxed/simple;
	bh=kmqqBWxLyKgIEw9s3YW2haliFv0RHqaui5Ed76hRyJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4aCHBnr52yZacaTucEOLUkR/nOC88kvMsSVTGnBKIr/w+iemfx/UqudRlJ4kCr+cZHo8ISjwsYqCqwHmRRSmHBS2dcZ8YROVHohexyQf3rR84qfokzEWJbiDU/2osPffzTpwmouPDygd2KLPm85H73A95ZZbVW6X6IhSLrVPVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7NQLyfg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e7xvAtqE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2KlJW9017594;
	Mon, 2 Dec 2024 20:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZHahcgWvt38eFu5VbHW5NAXDo8gkDDAtm+NTyiqVeDA=; b=
	L7NQLyfg+gKkiRvLMdYhoOzzaRsyD8gBOIYWjfhbsWv89R+kfFRrcLV1s1B/Wtaa
	KzvkwWiC+fHMk73vGXt4VeNGDaDT7EEtrT6eARdqlxMDOgCXT+TyQo0Eq2X5Q7dh
	gaBwFtpJKqUo5soBz9MDepxd/TKJjECxmI71kqy/dw5YWJtETffH95flnbTNS4b7
	G1oCGDoCfruk0tF0yLhmu8mlwg/fq9N6eBS6ts2ZP+gUVRtmOSChpWVIgcvyaiTG
	Gd5+2Yyd3zLuvfT0moDRFsDyMaEUxZccXWslGQw4xIZCIgRI+bY8RaKvYyLbbo2l
	EdEOyhJJzAimRONJABks1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas4m81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:54:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JtjUc000917;
	Mon, 2 Dec 2024 20:54:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s574qey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 20:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orpk46+ti7CG3SRieC5Qfa2gLqktRkcRUyxYcdoLY0Qfbu7VlQ+/EtdE8oPlwVMN0QRycZj9+GyNmAN6HLTx6qcplJF3X/mZ8W/DWkNxU3oKtAJtq0+1R0DN+3X+IRaA3PK+L6wXYNK7nS/wqya07L1jFWDpk2btPtcNZDCFQ4PXuWmM85MDMkmbkKuKlaquq+BqddagbOJhHuiiSpQiT7Wa0a8nLdhpPnvgARSMvlQN5rOTt7sKsiRQlif18CsGGZUr7onXCj5GH1uUISX2fKrtbxclP5rQMhRaOHZFPgK8TUrlEVA95Rt7gWmvVEih5OcoPMNlJSVz+0kJWdIhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHahcgWvt38eFu5VbHW5NAXDo8gkDDAtm+NTyiqVeDA=;
 b=ZNTypwPCj4tRTKRCZomPYX4TROHeqb291TMmVzoSkmNbQaJy78w85jzxShOsK+yMGYRLok3DxF5sQZec0OLTJ6tb5bAlMx8Cd8dzfjvaBJdLQH1a8tdwAa5sgUfQKndVX0YpXMvXGMUrGs3dKj57/tJuSZCkzgM7ms+VcsS+xNXOOsMCilKEhnvP9Nv57Omg5j27Gz6t3dzMFqXTwd90f9DLwIpkQbPUePECGlMCozMgtDut4salG47Cj0/nnaP62Uzoihq6IUXGHqByTXIbwuCicqMjOH9MdiEPnM3zeRWqd5UZ6GHlr/J57u6TzEoQQJ1Q4tpS4OJRjxS/o6vVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHahcgWvt38eFu5VbHW5NAXDo8gkDDAtm+NTyiqVeDA=;
 b=e7xvAtqEROTyhR4pSfuv3KyJzsSglP6zMkjRsZaUHREeQD85QN1hhndgIiPMVjkUaeBfxT8vNGYm9mfV3iZgO2GKVTkz7e1vqWefBUAJwxWCQHrPDq6FejekCIy6+5uZNwhk7qg2cGmEI8C7Wio4pJEg/o8mi+UR5GTdTidBchE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 20:54:00 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:54:00 +0000
Message-ID: <a5d8f41d-abe3-4a76-994f-6047148f5554@oracle.com>
Date: Mon, 2 Dec 2024 14:53:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] jfs: UBSAN: shift-out-of-bounds in dbFindBits
To: Matt Jan <zoo868e@gmail.com>, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Shuan Khan <skhan@linuxfoundation.org>
Cc: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
References: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
 <20241101095955.9786-1-zoo868e@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20241101095955.9786-1-zoo868e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0394.namprd03.prod.outlook.com
 (2603:10b6:610:11b::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9465c596-7d3f-411f-508a-08dd13137291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3N2Uit4LysxcjMzaWN2UHp4QUVpbER2REVnTUNQUnFRcGpGdmlaSVZmQ29E?=
 =?utf-8?B?ZnhIeTVnRmR2MjZxaXh0U2RyRFloNEhKSWl5azJucGVTSU9yclJlcTR6MlQ0?=
 =?utf-8?B?VGZtWW5HQUdRb3VwMGtHWWhFOUplYlVtZHlpQXRpblYxaUUyS213RC9BaVpy?=
 =?utf-8?B?a0V1ekhiRUp1UEdJNzVmZDRQeklRdVVrTnJxdUE3QW9FNjlicVppT3pRUEZP?=
 =?utf-8?B?aTZYWUFQTzV3VTZQQ25aS1FvUmkrRU5EOWs4ZUY3MkMzTmpVTEhnVG5XMDVt?=
 =?utf-8?B?emRja3E0OWFwYzF3UDhPQVY5ZmRuTThBZUJNQlZjVWplMDl3elNUOHRzaFFr?=
 =?utf-8?B?YVdObVp0VTNnemZ3aU9xekVxRGVFUndtU2V3SFJUVENmbmtxRTREUzBuVEtU?=
 =?utf-8?B?NU1tOGVSVGgrZkNrSGJTOWNIOHo2WlFtQnJldFU4NDM1dkxHaGpmaG5aY2JX?=
 =?utf-8?B?MmEyU0VDYmxmSHY1VEVNUEdMTHVxWnBzcklNWE05S3M3Z3hUVWtsTVhGL1dU?=
 =?utf-8?B?ajhNOTZyZTZMQWNraU9lMGV2ZVdvTUNZb2xPNEdHZFp0RVVVVlpHRVB2STVs?=
 =?utf-8?B?c3hhdVcvQWxLb2UvSWtMMVV0WDlEWHM3RzFsZnN5Y21lYVpGVHVkVGErYmU2?=
 =?utf-8?B?MjViV3hYVWNzbExlSDFXQ0ZNMEZEM3ZsVUt4WFF1M1dLMVV6bkl0aWVjUGVY?=
 =?utf-8?B?OVhDK2RkUUY0bnE3VVJKWnF3bnhFVDRPVWxTL3BUd1ZidGJZTWNzTkcrREJX?=
 =?utf-8?B?VkxxWldXbm92RWVjOUVWUXdPK2UydVdOUWFNRFU5NkNIaDNDOEZPaGlCOHg2?=
 =?utf-8?B?cWxheEdLTG9mL25STWlPMTBYZWVpZ2pWemhRTWdmWGQ2YTExY1lzdmllNkpF?=
 =?utf-8?B?WnFTN2lKOGJRNnpGdVZldlBxeDd4djQ4L1dOVzZmRUpQbFNpUjlYUlBQQ0Zz?=
 =?utf-8?B?ZnBUYVNPeEtTcVdqL2pGNnJhMlRVd3AyOFVobVl2VEx2eHVLMHRtL0xhWFBG?=
 =?utf-8?B?UHhSMjBPMWdHc1hsaWJCb0lDbFI5WHlaaCsrVi96VWQvR29kWlBEWFZUZEJW?=
 =?utf-8?B?ZzUwaEI5am51bmtjTUIvSUQxbUNTRFRMWXNkdTV0R3VLMEpmWnZWai9NVDQz?=
 =?utf-8?B?YVBUT2JselptTnpTYk15TlJzcjlST1gvWitYUDcvYU1qNlBubWZSUHBGOVhs?=
 =?utf-8?B?eEYrcmwwRmtxMkY2ek05YldRMHk5LzBUZDJjcGY3cVludEhtZDBxWDNFT2Mv?=
 =?utf-8?B?QmJMQklJTk00UFA4Zm5OZW1zL1E0aEN4UktuTFY5Q0xzZFFSVjJJYWNsWEVo?=
 =?utf-8?B?NlUzZUJsaDJpMUxjYnRrK0Y3U0dHL01Wb2VqYXNNTkpnREtldWFEaFliZHRY?=
 =?utf-8?B?UDhVMlFndmJnUi8zc1M3RUkzMDVKRHF3a0c2cHBXb3RsMzJGWVdvb05pRStX?=
 =?utf-8?B?bVB6dllBQmZTVFYyYUhQZFBSczRRZjNNSUdlSk4wSUpzcmVrbHg4cDFMYkxD?=
 =?utf-8?B?ZVVZNWpYb0dETmNoaE9zS0MrRThYVnNwVjA0dU1KWVZnb3BibmFORGNrcnFK?=
 =?utf-8?B?b210TFdMQ3VId3VrdklPR2Y5K0FQbGtNelpabHdySjc0SXVMSE1MWE4wT2RN?=
 =?utf-8?B?RnZhNkxCMFNoR1BSZ2YxSEVjbkw3ZVNHdk1QU09hdzlxM1BrUlpkMXJueDEz?=
 =?utf-8?B?OXNHV1FvQlQ0eHkzTk5pbEpXUDlWQWEyblBZcXRBUFNFZFpoN0ZtS0tHZUpL?=
 =?utf-8?B?cXN2Q1VzZE5wVW1ibTlpaFdIbGRnVDcwR3ViNGUxVlp0SE44Z3NKem1iejRB?=
 =?utf-8?B?UmtjWkdmall5SDNiZ24zQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFQNkZnZ3JyZHAyTldHZWEzdkROZ2JHUTFKV0xkdlVLbnB1ZGpXdFhmSjBN?=
 =?utf-8?B?UW1zeWp5U2NmL0hXTjRzRmExbmR2VEo3aEY5ZjZ5VnhUczNBR2YyZU1vUUYy?=
 =?utf-8?B?N2hZakJ1dFhvYzJjZkxUdU5mK29tZHYzNG90QS9nbm5sNkxXUERIVFFPWDBi?=
 =?utf-8?B?WTBmWEZ5T3UwdlE2Wk0yZmdXRjc1QWdnUGE2d1U1bmxzcDJlblMrUlBsYnp6?=
 =?utf-8?B?bXd3d1RGMEdWMHF1S1d4NXdSeDUwYTV3OFJGSGRhOGtmMlRvY0Uyd2M1cWMy?=
 =?utf-8?B?U29ZcGtoSlZ3eGNQckFZQm12SFpzTWpDaFQrZTJ3Z1hNcW1OTEVDNDUzYkZn?=
 =?utf-8?B?bk1HeFBZTHBOQ2E5ZitLS3Y3WWVLNnJCOEF1TW0ydnovem44RzNZZjVOSjFk?=
 =?utf-8?B?QVpGQ0tES2Q1S3BMSVFlbmdNTURvbFFqMHlsWXliMVlrdnVwZmdQNnE4RjY2?=
 =?utf-8?B?ZnJMclVxMUtmd3ZSK0dNVkthdlBJUjFaUWZlcEsraVNvdFQxSlpnRGE3TWJ1?=
 =?utf-8?B?aE83Tnd0eitkZXNIclZGWkVqUUx6N1pjL0tNOTBkd0VsbVRUU0tTZkNoMVlI?=
 =?utf-8?B?d1NaUXVJYWtiRVo0dDdWVUh6a0VWL283dVEvUlpDVlA2N1kvYVVZS1NrL2hB?=
 =?utf-8?B?S0tEckRqRVVtQThqdGVNOWdBeHpxUEpyM24rcU9oa3gwZHh5VW9OYkhHMUpx?=
 =?utf-8?B?NFA3UUp6c0JsSHdLclhXTUVzN2M5eXdIVlhId1k5QXZSa1FsQTFoSnI3T2RT?=
 =?utf-8?B?SWxpa1hXbzlXTTVTeGsxd1JLZzJkdm1hZHNGMVY1Y1c0dThQMnJMLzRBZ2s4?=
 =?utf-8?B?TGRYeFJvSjVLdWdpQUxnR1ZVWmdlcVpOVW1GTTBuL1BzTW83ODFZYmxPbnBw?=
 =?utf-8?B?eWlncjU0UllxMVJBbEExTXFJWEFPS0FzcE5xTTRxVk9DejRkRWEzQnFDa0JH?=
 =?utf-8?B?RC93Y0g5ckowSzl3dDRjcGRCWXZaYy9rekdRR0VPL2VtWW9WS3N3QjgyQ2dU?=
 =?utf-8?B?U3Fac3JCdjI4SFlwU1JjN2pickF5bm81ZVc3bmpTSkt5ekxwQmlqc3hJQ3Y5?=
 =?utf-8?B?TUswa2xEOEV3S3MzcHhaZkVVMFBrdi9VRXNGVDIzblcrRCtGMU9kckxlS3pQ?=
 =?utf-8?B?WmNuSFB2Sk14WlpjaHhFQ2N5UGNtQTl0LzN1WnRKRzFxVjdxYzV3bytWUlFE?=
 =?utf-8?B?MVFwVFVxaDQvZHIyQ3V3cVlTQTQ2UmRaN3pzcElZanJ3SjU3YXNyU3NRUXRO?=
 =?utf-8?B?RlZWTU5UVHI2TGFTY2hITkk2VTc3c1dvMlVzTk8vTms4N2l1QUJtUW5xV1NR?=
 =?utf-8?B?eisvMXk0VzFmZmw0VSt2NlVWQ2RvcXJxK3c4SUlETjJqS3pKcDd6ZXZrbHlO?=
 =?utf-8?B?dEpnTW9nWTNNK2o2R0hhcWNjZnh4NEFFazRMUEd6c1grVklzQnhveUpjanlO?=
 =?utf-8?B?ZVVYdjRTR3dUeFNCbkx0bXRubkxFZHdCTklEWVI4QjZ6RFVqZWpHUWI0cEJ5?=
 =?utf-8?B?YVdvcW1QOXM0Yi82OVlxT1ZRNUlCNklBY1lRZk0vVnV3QUxqZ2xNY1BEZEo2?=
 =?utf-8?B?Zk9lTXhjVlI0S3lGMUlkT3lHQm5VemRoc2FESkY5QTJVN0pEeWgzeS9yT0Fl?=
 =?utf-8?B?ZUZlc1FVQ05xVkp2SVN1UlBQYm9TSmVFVFg1SW80RFBmZC96SndUVFhHRTd1?=
 =?utf-8?B?V2lZK2ZpVXRKR21ISkYyY1FaRjZGbTI1UWEvb21iR0JHWkJ1NHFNR0JEeGNi?=
 =?utf-8?B?MTluSkVuSXUrT3QwRmgvZmFMbFdQR3M5a01tNkcwMWszUUtKZ3o5azNadVo2?=
 =?utf-8?B?aGNpbWhUaERRQVJwc2laMlVLTEIwNlFLTWpxaWs1UUp3dlZLVWhGaWNuK2dQ?=
 =?utf-8?B?Rjh1bGtJSXZHUUgrSEErVlpRQXA3cHd4VzlRZDZwakdtRWY5Y2E3cXh3VjJS?=
 =?utf-8?B?NXdPY01OSWpLZmhkZ1dUaHZpSkV3SVRUaFVIdWpIU3RKYnlMYkh5cmdmTktx?=
 =?utf-8?B?RFJuemJCVmVsdEozRVdBbUdrNVVQMHczNXZNcG0yWmovZXJuOGlTSjQySHlx?=
 =?utf-8?B?ZUVYS0xMNTNkYmNpUkRVMllKQnV3RXpjUUlZby9HdkZTZnpRV3ZiYndiMkhx?=
 =?utf-8?B?dERWSlMvcGZrQ2pVNmY1VDZOOEs4TktYLzc0MW12Q3F4d0VjaFZ6UDFlNXZQ?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kJx2s67rlvlF3cwExJfPUCxmCdv78mgz5xV4JWftkc8za28TGRr8tBmiLwi0UG1GwNGABS4ab2NvrDT52TNyC//0LCWsorjay/pKcLFTqJT8yDstDE+vYABV+9XeBGf8simAKu6f29ISewsBT1Hsz0WG6SbXnDxiQF/pXZFFY73owKxP3DF3Z+vnZfFTrMt085FCaXe2sIRHrtMl1wyfLXGG37v7Fni0sfnLfBTMkLspdJyaozBjNN0URosRMGahX0A6BDzhWj8aHGb0evO0cPaCk8Pgzq8Et2qQcgnJcmHCVBtcwDYtQ1YJ7uMnbptm02GfKwcRhMuuMrv3KYSTWQfo29VOrciTHxVp+wubcl39Le/7kHwU0Nkwlfqd1BJt1iLVjy5huZBA2ohGc/DooPgoJCnFW4IB01hCS+1iDCBx+NcpZE3/slbMKBxePJIKalPy2P78/e/X67qqoCbfHi8f+SptzqqCPLDeteP0fI9zyaK5ylq+zQt79hlSJmuj83ny2uoB/LSPAPSnB2jrWBO053fI/buqO3OTqAXiCWsBG0fy+WNk6aOfprKM3Bh1+qJWjDs0dgzq3MVjtmWgM2MoqimVDtjjRoexRjbAsHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9465c596-7d3f-411f-508a-08dd13137291
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:54:00.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfmBvBLC246Tcdlgmrfi0bZWs05lDOMZapl32JTEuRgM6qyts9JGINP+PSRqFrbjpc86bCpDAzEMLanjdiewbDfwHjwywOu4ttSl1LIce+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020176
X-Proofpoint-GUID: j-2QLimpRXHAJSH6jvwDNcl6ezgTAj0E
X-Proofpoint-ORIG-GUID: j-2QLimpRXHAJSH6jvwDNcl6ezgTAj0E

On 11/1/24 4:59AM, Matt Jan wrote:
> Ensure l2nb is less than BUDMIN by performing a sanity check in the caller.
> Return -EIO if the check fails.

Sorry for the delay again, but I'm still not okay with this patch.

It's possible for l2nb to be greater than L2DBWORD if and only if the 
entire dmap page represents free space.

In dbAllocNear, there is a test:
	if (leaf[word] < l2nb)
before dbFindbits is called. This will prevent the problem in dbFindbits 
from this path. The problem still remains in dbAllocDmapLev since there 
is no similar check.

> 
> #syz test
> 
> Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> ---
> Changes in v4: Thanks to Shaggy for the review. We now perform a sanity check instead of continuing as if nothing is wrong.
> Changes in v3: Return the result earlier instead of assert it
> Changes in v2: Test if the patch resolve the issue through syzbot and reference the reporter
> 
>   fs/jfs/jfs_dmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 974ecf5e0d95..89c22a18314f 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1217,7 +1217,7 @@ dbAllocNear(struct bmap * bmp,
>   	int word, lword, rc;
>   	s8 *leaf;
>   
> -	if (dp->tree.leafidx != cpu_to_le32(LEAFIND)) {
> +	if (dp->tree.leafidx != cpu_to_le32(LEAFIND) || l2nb >= L2DBWORD) {
>   		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmap page\n");
>   		return -EIO;
>   	}
> @@ -1969,7 +1969,7 @@ dbAllocDmapLev(struct bmap * bmp,
>   	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
>   		return -ENOSPC;
>   
> -	if (leafidx < 0)
> +	if (leafidx < 0 || l2nb >= L2DBWORD)
>   		return -EIO;
>   
>   	/* determine the block number within the file system corresponding

