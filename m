Return-Path: <linux-kernel+bounces-366239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82799F280
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5567A280EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A51F76A0;
	Tue, 15 Oct 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hh0Yq5Rm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X1PhV17/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A061F4724
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008738; cv=fail; b=BY06q5aSr8MFsQuTEKjMtEsSg9peO7xUqx/WOsbu9IkdtKz6e6ALSXeFnPjJ3eSUZ9JUzVRsqzY+mQ8E3tbYuR1KI9k4xGQWhqxYfHs2ynalZPJwFzbU3I8sL8Gk4oVsm+PwadYDGxJ3NGxUmbxBVJFzs/r82TVA+Sy/34LMGUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008738; c=relaxed/simple;
	bh=Y1oybK3AKrPJ95/Xs3s/KSek8XGy9PQM4749BaPZX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XjoifyUr3l+2D2M2q7JsAnV0g8atYROIesyA/3YFH92z+uTsRSlZAC//KzoVU0dGGEZBJ2GFVAewoInZkRTkYT0dAv8HpvXz7K5tRwBObcVo514LJTxNENXPbBc1NqkNs2XwEU99n7/ORREXxqDsvuHyFGkCM2JPcO+/JoYNs1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hh0Yq5Rm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X1PhV17/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FF0b32003872;
	Tue, 15 Oct 2024 16:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=KYyLF2ENtexUITml
	T8lmmUNbLkPq9ljm2V6KhrAKUcA=; b=hh0Yq5RmIUk+KyFlX2my6MzRWu46SVAv
	LrWolYHp9EbsdlFWtYKjJo56HxFPaztM1Bszbs0Q+4euJuMh2PPyGVT2EafI3YSj
	55BKl0rufcK3qHCsFsatNkV9jBPg0DKnRTdjk2LrQW9Pde95ZpF2cqPcdZzIWLFl
	g34YK0HhicMR/jCJ4kTHmICnTpL549rIIDvhn/HPwXFhfdyLjp5T/noVDV3bWhXr
	oBr/3S6RJJwysAn61SRTeZd7LfOcB6F7rDjdy3T7lYu3jMPKAh6VPs+PJbuXpZjy
	uVCGNou9VjBn+QM5SuWLn/0Qlg8JgyhQ1veLxcGjySM4XzmNQX10sA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt1g53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:12:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FEpCew026287;
	Tue, 15 Oct 2024 16:12:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7nuhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwGk2BhpeYQ/xXLQDrC/SjBLylC3VM2ouET8/KKFrrmX/UU1ahDm3CSRrZGgAQkUoR5PJCpgMJD5Nyl4qt9i0Nvz26b1/UBgsSG6kyZCpNWP3P1c/TxKXyyJXIk//MeG8K1Ba58lDmzT4WbPJfEjTbyDI8qW6Fj+mYu7MDhGBQa52TFwtGvgRVJyoGlJLE5/HKWDDPeI0mV1kI6YQurgvC2Ayg0w25o6kJoa+K4RY7sFVJA6xQxtqRMDDVpuk0+Fnrhy1f3zAvthkT3SgRMsafgdZrgxWGhBsXNYCpW8irIpy+F7707+h27lXmEEYT7SqnFMwCsEZPT2IcPxupkOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYyLF2ENtexUITmlT8lmmUNbLkPq9ljm2V6KhrAKUcA=;
 b=iucsWVR3WEDINgRWSup1EkPF6mElanhfazl5Mf20d6ouH1uY0PbdSMjlKFZ4+1bg+ZruQvvl0E9ulFVbU1JEtv1uFJ8ISZe4KKHroC5JmJQ3y8EUi+2j6YXnz8SbFtXWQ+tBC1UW0DQpIgLqrT6sUZDLUeXDZBzizfAQOub5V4Bzlh9c48tWTg4NAG8FtLal2JjRM0lVFEWwjjDnDr8gzd7quY2R+0aB9GIjkOR6FJGyxwo2sKUduy7F65wSEbZactIsKqZIQAvdi+Z473wYdu8aXAakvIbDi2AEp7huX2D353XcfsiVN9U5oLAdJnkFgr/x/pDCPslXZxhOVFoTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYyLF2ENtexUITmlT8lmmUNbLkPq9ljm2V6KhrAKUcA=;
 b=X1PhV17/cjTlT5DgoAKAEVcWoSZ6UtoPGdOJjXdgB6+Pa3gNaQ4EVs6bpvdZe1A3o8lBj+C/9NpVR81EATLnM0wdvm9xDnrZ9/ldkfSe5RitLRIBUkPG2fY19z4LIbAc66X/SuOUWHUncLVzYpicSE0lynZR98goCWnIXK4FCVU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 16:12:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:12:00 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/mmap: Fix race in mmap_region() with ftrucate()
Date: Tue, 15 Oct 2024 12:11:35 -0400
Message-ID: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 302e019a-1a59-49f2-ff36-08dced34196d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPNNYiMm2vI5gg+KiwGEX/AsIU8pqVuA6QJ1ekUbFBK/n2nYBnhjAWVXSuR2?=
 =?us-ascii?Q?ifTvnKqIUt1DZbCMvDmnyqfvCRsKuBnmBH4OGRUjWWA4+91fcayvrxUR41V9?=
 =?us-ascii?Q?C3tJGS5vRkln718SFTsvIKWKB3Ssb0yO0M2p5WVJc37JEQijcSIr2XLZD6Db?=
 =?us-ascii?Q?9czLVkW4Fd4chojVGSV1sHDvCtnowUsteMI8zk88rTFP+GUsWoYumhHV8MEN?=
 =?us-ascii?Q?c+vMIFTP0CX5+v/ZDmivNQ0VXK/4QPX5oGeSCaC6b3VK2g6RmbNJi2nUF7uQ?=
 =?us-ascii?Q?QomgNNWIgM91Z7pkd16c1xB1yQbIznIh+dEgcHNjJ8G6r6hZohX1JAv9VA7I?=
 =?us-ascii?Q?rpWodwzBkePFTGa0BaOb8JJmkQN+McpjtTQIfwuYZcFYWueiObh5mKuBFpQn?=
 =?us-ascii?Q?B3N4qBLunba5Vfz5kEYqOsEW4LlgTq70zmZw7ShE3FnJeFH1oiW4d93Y+GRh?=
 =?us-ascii?Q?UnIxJeMwOPOZkKFSq4QRGOsk/EVlNHGCpuWbEz5m3Xkjf+SroyKw5K9cLygl?=
 =?us-ascii?Q?nV+hTy8v/4YLV5Bnyup3oR0uNMTL1uMb55ahHsNx3Kd7/+SAZ8aeOtJmwqfv?=
 =?us-ascii?Q?PeNJ1GbsQNfu6JP9PJN0/Dzq3xAkABMgnhJGi7iR3QFknaTOlJzo6RzxGfI0?=
 =?us-ascii?Q?BI+ivApoKUNRz0e790HA/uXy/foIh83PJJV6J7Q0b3ppdL8Bfxg6WdZduZus?=
 =?us-ascii?Q?XpW4tpOUVrSErUmVrCI7g7xaidqRc2EKOZU+Js+89X2zcR1jnConpjRnVwPB?=
 =?us-ascii?Q?EhKkJ/HID0C0Dvu/zzvOr4FQtBeu+MtGMw1sIxS11dZ+uj6Qj78h0LOFx64V?=
 =?us-ascii?Q?r+jm2WBdicXOzYICZaJ6RPbHSpK8ph+fNn1soB+bUePr/49ZUejMl0xMISc/?=
 =?us-ascii?Q?GU/OySFGuVr0S5Lwkd2o50zhKptriJ3pl4P6W6kDpbHu5jv4gW7eqvmBV4Qu?=
 =?us-ascii?Q?NbgPph9uZjMzmt1J7NIxLKa0TZW4OjzEHGITSgmEba0dlou+hGu2ZLh7T3Y+?=
 =?us-ascii?Q?3LlAD3dhc2OXHLyXsOIA5Vn4RPDEHgyqWch0S5DDfGoWB0E9edIPIdv/F2OT?=
 =?us-ascii?Q?4dgOAEo4IDwR/AMG12A4W0K8l3N09K/UzXitDNwd5qB3w3MyQhmajtBV/5ON?=
 =?us-ascii?Q?1cOJDsWEmVoorfMO5C+LZb91GSF9B0AxnZ8FgAo+hvtAZ3pfCeCaeU2+o4Z2?=
 =?us-ascii?Q?Rb9mhvhQWlDpdJiTsE3O9ktfMAnB0Ge7RssFurh0kCpOmhAS6vUYRpCvtGrx?=
 =?us-ascii?Q?OEVsCR683yanPtc11MZPK0ahP4Y/qvZ8thPzt8E3Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4WKIN1pUTsHxLA7iHSwb2nRMw1ACbvE7L6ATWup5uIa3HcwyYV3UVLX8yfz?=
 =?us-ascii?Q?P0l1yuvth4iG1cn55UJtaVU3S91mwQMfU9FOoI/NPlSw77OUFwBMlTICikWf?=
 =?us-ascii?Q?SI4uThRX+ER8/pEcMn5iBSyxPiYHrjilNi4h0MxofLK6MzVnL1kbGbDhhB4Z?=
 =?us-ascii?Q?cEC9ncKY6V32ggj3UUt+sLN7xhArv6QjdfDRFHy65ykNoAVzZIQX+i2BRTmw?=
 =?us-ascii?Q?Lhxo2AfNbecUnPmydVmRD4TiAv41zb30GthEge7fWHuEDHMBM02ERz0N9jn0?=
 =?us-ascii?Q?N+jItIu+VXgZj+Y7EtG7RVCfhrRd7xFplmyeCAoAW1C2lIfirY6ah/cz3tI5?=
 =?us-ascii?Q?X+bzeU3N42PSUf1ngBpmXNYCGUOOpAzqGfU8udJndudBlGd3/8xWdh82z5GR?=
 =?us-ascii?Q?wWbqVjUgSrEf7pebxAKKveWa8cVdaKEwiBByStISjPyzr8YtRht83Z08iQkS?=
 =?us-ascii?Q?yT/qX86z+2alCfm5nUjlIjoehjQHTvHc+EqKTAC9ON/C1qN/bzEXhkfWphWB?=
 =?us-ascii?Q?f5WpltBgAXPRPOg+3F3XNmxVTvlEA+y9T9XOeMTx4JilWMCJgs7hiMCFeXp0?=
 =?us-ascii?Q?ttD7nZmtuaWltHPQ18XlLa1PfzIKfz01hqYk4P5RBI/Pb0xMEFh+JLlM7lez?=
 =?us-ascii?Q?zj1l7Bjlyuk7FhM+3oYh98VeSuz+IizQuh6HllZFNfc79WOgfmBInUlktmyc?=
 =?us-ascii?Q?zc1MSLsZIKnkvtmrKxiB3gMAEnWTiEgpu3nVEZy8jXOSpep4yjE9hSkMhqZ/?=
 =?us-ascii?Q?R+VJ77Zbd9hK7eGXaK+ZsmcWNbhwSdv4iQGEnIk9r+GKyrCj12BdqGHEIhQ4?=
 =?us-ascii?Q?pdZqdWjkqSTs7xRyXzjmxMSBMG8cjSPfFAqUZnrTo81ZHjFiFZBcDFy6DmJN?=
 =?us-ascii?Q?KJHSSHaeKrTXrsx3zb0j37/Iq2t02CKJFT9Hi9MGZ8ZbSNQpYMBsm/EdZa0S?=
 =?us-ascii?Q?QhI4nVBclqtF65BD4jghS+9BDXnKR5o/7J2ZaQ0P3+GMKfeJ8uUBsaaoJBeG?=
 =?us-ascii?Q?bNMksgMFgq4UvLbZlRZvLqkP5oaHqu6Ts7tBaqe+3x9caXo9V9i9i9SGZIHs?=
 =?us-ascii?Q?NxW67GmwAxV7u7EO/LbI+H81qgf0oEglmCGZdgy7JSL2Sp7zCP8GyYumTnV9?=
 =?us-ascii?Q?G7l5v9qIuleUNCeOUseu/5Yej/MUhmIiK5ueB1Nmi83vTSBk19FEwyRtvjwX?=
 =?us-ascii?Q?bNrcCXa0UVOop0+kRyDXebVArhSMyvxTDsmJ/MEgsNXNd2aAl4R5d44lqgle?=
 =?us-ascii?Q?BEZ9MnX+ZzUcdZL1oZwAfhT6hr1u9w5tPJ5+H3DW/whkl1qF/Auq/G0uRLzU?=
 =?us-ascii?Q?lSP76H/9T97U9Jo/uf1ucXaUZINdDyC40qEmJpYtSTfeF8KNE/pgA4wN5GBw?=
 =?us-ascii?Q?iDg2eo8/DWXj85KnwGpfedIGTpkZrSRtFMqfZ6TaxBmpDTC1SoPZ+nSQF07l?=
 =?us-ascii?Q?qqr8ZAGeRfGjoO1KbfANcHY9iNYhGvYwnxjxWzv7R1AB0sm9v3AqRv7ISyn0?=
 =?us-ascii?Q?yYuabF1r46ZBUBIi43IuRk8HqILGXxVr3NJtn/zcR30Ku7y76ePuOK5MIXCG?=
 =?us-ascii?Q?1WbH7obyYDWE7kPM2zoQ3HtPTc7toY6US01AZVWHf3BVuPOZ/D5YI8XedX8R?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SwhAqEjamj7cQyaFtLttPEXqOWTKxwobAL3h3QgkUrXimqDsgeVjrskD5BDIDetN+qLG8l/PX1eudCJcBPV7erw7y/1EoIkV4VAH0/XkcrTCj+NYo7biNkajh3tdcZhHNFoRA4AqvUbE1Ftwnuqzj8csoaJcFXANfuu1EnuNvkrLYi12+yp0PB78gD4Yx+6+Fe+RtWKpRVYeb7fQr3IYl6oOkrAvGO0zToMye6zGaj6LlFG/ckGP+fgjAtD32wvWxc/EMHbugFvxQG5P/fVS7vM9IrwnYgMWBRtijiKxdWxCIBlVAUgZ/n8sLMPodv06EbrNHCP7+lR+wj8I6BBGZvWEz6IZalZIke5YKrPuzcCm/EspzbBtE2CenirHl9zggNb3M0ReiS3vsu0hTdJ95fSWWr1T75wj/2el8JGVoODPTZ5get3NCvoQfU6Fzflg+Uc9J4MJ5/fyxzmuclBRJc7fWmViRm3cGZnQi3CDCV3Qr3+TzKtoAxtiHwu2DKjpF6FTPCtT2C4fwHbiB0gw60J1krk4aoHcrTOjskLN3HIPR7ekZtz81EengA4yqjX4qOOwLKGsR1h9DjmLmrm6vsjzADDSPUnUB/ShUKH2qYU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302e019a-1a59-49f2-ff36-08dced34196d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:12:00.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVWB/2a/h2QpjdHP9EzOIzdY8DHk+kJt0Ha79jY/yVk8ivynhhsLN05P9MCZkSLrve0tSXttjVU7DBSGQR5lIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_11,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=995 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150110
X-Proofpoint-GUID: jWZU5sDgaEsvq9Lv8WbR3gYspB-0ZWe6
X-Proofpoint-ORIG-GUID: jWZU5sDgaEsvq9Lv8WbR3gYspB-0ZWe6

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoiding the zeroing of the vma tree in mmap_region() introduced a race
with truncate in the page table walk.  To avoid any races, create a hole
in the rmap during the operation by clearing the pagetable entries
earlier under the mmap write lock and (critically) before the new vma is
installed into the vma tree.  The result is that the old vma is still in
the vma tree, but the page tables are cleared while holding the
i_mmap_rwsem.

This change extends the fix required for hugetblfs and the call_mmap()
function by moving the cleanup higher in the function and running it
unconditionally.

Cc: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..a20998fb633c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}
 
+	/*
+	 * clear PTEs while the vma is still in the tree so that rmap
+	 * cannot race with the freeing later in the truncate scenario.
+	 * This is also needed for call_mmap(), which is why vm_ops
+	 * close function is called.
+	 */
+	vms_clean_up_area(&vms, &mas_detach);
 	vma = vma_merge_new_range(&vmg);
 	if (vma)
 		goto expanded;
@@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
-		/*
-		 * call_mmap() may map PTE, so ensure there are no existing PTEs
-		 * and call the vm_ops close function if one exists.
-		 */
-		vms_clean_up_area(&vms, &mas_detach);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-- 
2.43.0


