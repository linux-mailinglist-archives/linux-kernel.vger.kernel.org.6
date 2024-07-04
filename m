Return-Path: <linux-kernel+bounces-241101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0C492770F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5241C21824
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C41AEFC0;
	Thu,  4 Jul 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XFQedrG6"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7271AED2E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099290; cv=fail; b=WxUgKXd+dIhHY/EnWui7BW/tjFFNb1rRtJfeckg4vRnJ1tSFxrYmzC8dbkVl7c62bbf6bjWmJkENitr7fpnbOH2/rCOBAZ/YRka4VOQnQtmxsEROXifjwRq4eq2SCgj68B9SQ+AA2O0o479vw7jSlmJBmWGbQbtCSMfZuaj6wLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099290; c=relaxed/simple;
	bh=4/UivPtlR60qrSoh3s+mf7nWjTTkNYETFIIUAGpASAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHOIZKsqJKKc1nkx4VwJ64NrqE9xF2sm3Ra5VU2wH/BdlhcBQzv3weu74eNzYSSKy4Tm5qAuNhNYhFjlOEC5IVQlFuNj+Fr9f8DjOc/dBjmbsmGpES8njEi+obVQ1C+SKKYmHVPlbmefnaM++A3DcQtDRDMnYK34/cMTo3hECsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XFQedrG6; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRoxbc+KFGS6ibBvEl5UUiExNoj2oAC7hDCxzlpdtee5aNb3zf60QfGwYw4tJhQW66omIsFSWina1TgeaOciV3pQa6xvBnmGeWwHkhW/golAyDHJPk5ICU6bHqNTiLsGFAAjddtUcNLY/BA1M2kAXNKEnkquz5Z29IPOkttRWolwc5yKm78IfPtIjls64CaV0lU+SeDb7lAUwIy2qrHJkd6heN3mXmJ3mwAnsgve73RHKYgobZhfD/wUmjADRaQgY3TWKSMMfGgFwZp2ha+L7SoN+MljWdXBFfWfV0YDxnBK14d3KyoxtSoUryc6V0jRSogt0//TbEEJrD9uaKXKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=l0Q+3aQ7QyaZqebWNvxH8ItA9ZIvjbU6xGVkKbQr0KOGuDMIg4NtATfv4WsDwgsvCE5Z0YPJBlmuwa0HO6XiwMYD0mGJDgr3737X8K5dW5j+BpnIHiCOHPbTWsAQIcvyRpWhiORX7WGitgVsj61iWDrXwrU9UMYLPAOE71CYRkLn2MkOyHrT+unC+h6qOElL16uniVzR3FJ1+BTQnaQy25RD8D7TOZe6NQyr4gCmH9TG39Ps9OAG3XudgSFABpUn4PEBU9kLIadmFHV2o3eAll3zIw9NIXE9t3SVC6uflDKq1FnkH+YfzekpF4eSHkttdKsP7GY8pby49Tm1Bo5TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf7OPVuzFCVUbxqXMXgjlFlzFPQmuxktVkyKjUGXAQg=;
 b=XFQedrG6zTZzhgJ6bFNX5Ws6B+XyTrN5lZe/nstjWkt0moFtER2kjUM+D3fhwc2/ES9TlyMGEkL4v4r1xJ1+2IIbe0ydoIqeAK+lbK1ixVTgfgFvr6Kf+OWIpNART+eYoVYQbzK67dM4pZSsgGs3rvItS7hJy9vlSk/DAX+rGc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 13:21:24 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:21:24 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
Date: Thu,  4 Jul 2024 16:21:14 +0300
Message-ID: <20240704132116.2865864-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
References: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b408c50-c8d1-4b45-ec7f-08dc9c2c33e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmRDR1RNR1lqSVlhS1VKTlM1TGpVdDhseWhYT3FnVVlFa1Urd0paYXhjaDIr?=
 =?utf-8?B?V0hQOGF2bGJRdmxDemM4NUVlOGo2MHZHMCtvcnVsVnBjb1ZEcjVieXJBdG05?=
 =?utf-8?B?R0NZTmNCYnRDUzFOUVZWOCt5NHRFeEFPamZRSWFmRHU5RHA2TUlaWG1mMFRK?=
 =?utf-8?B?VlRyWHVnT2V6aktSUGNTT3Y0RDd5OU1zUnhqUkpwYUhNSTV5Sk0xWFQ5bktz?=
 =?utf-8?B?SUlFSDZXN2tPcmhxV1FRcFhwNXNONmV1K0NBQkd0Tm85Vk9NZ1l6ZDNINENX?=
 =?utf-8?B?QlpMbjdZL3pQRDQvVmRab3RZckNuQmEybTZoRmxuNldxM0hBcGo5Rno0aHJX?=
 =?utf-8?B?T04wRHE1UnA0cWkrVlFEMStmbXRTTzcrUE9WRG5MWmg2OVduZGVMMGVNdGZJ?=
 =?utf-8?B?dE5IclorRnBvMmNRQlJ3Y3dDK3RDcm9EVnlaaHFBbWVRb3BoTnlvWkI2azFT?=
 =?utf-8?B?ZkxzTjBXK2ZERHpPVG1IK3RhOW5vcE5tTk8rZmtSMmxYQzZUcW5WOFJWRDdo?=
 =?utf-8?B?VGJzODd3Z01KdmxnTHRvVDdYRFRray9wd3MvWGNucExTZk50MUlWMWlWSjVZ?=
 =?utf-8?B?TjAyREhSN1NuZzE3eEQxNWNUaU9FSDNoaGNFQkZhcGFqd21VQkswdHpKQ0h0?=
 =?utf-8?B?YmRTMkRtZ2o1UGJUa205TDlOdzdjbHUxNm1HU1FjTnRTc3lEUXRJWWgwNUsx?=
 =?utf-8?B?UEZvcy9iVWhhTS9ldUF1UkhWNXZZZmx1YXQ2UVdpamI5V2YramtQaW9oejVK?=
 =?utf-8?B?a28wQkNFQ3RIdzZSNXIrT2xvSkdjMkkrMkE1NDN2bkhTTFpsMVFsZ1MwY1Q1?=
 =?utf-8?B?aDhNRHNHWUlzRkZ2Yit3Qy9GQ0xuSzNwN3pJTWRUZDFiWi9xWmRvb1NETUVl?=
 =?utf-8?B?Wld1aFlLYW1DNVVUTUNXbU5senpJeXdyTHU2eDNhS1pGbldjbCsrbEtiSU1M?=
 =?utf-8?B?dm81MEdSKzIrcDVUYWF3R0pRTXdmN3F2OWkvTVJKNE1seTdXVXdUNzc2OW5M?=
 =?utf-8?B?S1ppdklYYStZVGNXODduNnZpY0pzZ3oxSU1iU3VYV0NMK3BpY1VuVHk2c0FT?=
 =?utf-8?B?VGtpbEtEWnc1M0NIa0Z1bWJ0bHFmcmkySFpiK1pOMHpqVkM1MkNwMFJDL2N3?=
 =?utf-8?B?OVFjTDhuVFRrTThQYlJVMHk1TFl0YTNpM2trY0FNU21hc1NOeFRSM2hqaGtR?=
 =?utf-8?B?TVFrNXJCQTE0MDNxM1BxZ2pIQVNILzBLN1dqSDhkdURGWmR2QTg3RDBBY1hM?=
 =?utf-8?B?bU9SKzlvRUpUalhiOWJNOXdGWDNYdmdabjJPdTJrUWFKeG1TVS90M2JYRmRv?=
 =?utf-8?B?dEJReXlia2YrbHpuREZiZkh5L2J1RUxsS2tlVjJEL09sYXJmZEJnWFhoWDly?=
 =?utf-8?B?dHF1WmhxMnByejI4THRnU091VzlJRm4vTlZTM0hoNE9lRk5JS1Nhb2N1d0tM?=
 =?utf-8?B?U0FuRzdwQlZaN1NzSlZHYjg0VjFJVFF6c3NlZ2drM1BaWUpKR0IyT2tJVzdm?=
 =?utf-8?B?SzdneVA2TFppRHhjaytWVUV1UmwreE5yK2hjUHBDbTJFK3pIbFdWdjdRZ0lv?=
 =?utf-8?B?OFE3eG1PRlVTYXJwZmRXd3A4ODRzeEw4YklxVk1aWnI0Q1VWQ3dkdUk0UkU3?=
 =?utf-8?B?U2g0YmsrdnV0OFZQbDUwNEZPekVvODVOTkMvZlBrN0pvOFhmL3FxWTZwSnFs?=
 =?utf-8?B?czYwK0VpdVZjOWY3R3pUaUFQaTM0Y2lBRHo1NUUxeGRpMU1LTnNlR0U5SEkv?=
 =?utf-8?B?REI3b0d1QXBMbVBvVTRHWkg3dFRGbkZWN3JGaFZkQ1hmSTdkeHUwOXZjRG53?=
 =?utf-8?B?cVFpbDhaYTJmVmUxaEFYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVdJeldtbTNUUHRsRmZvZWJpYWFTNGkxZjM4cU9Nb2gvMkpEaUp5UUJBS3Rt?=
 =?utf-8?B?K2UycER0WC9tb1dBS0k4SzZtUHF2eUlNNzg4cCs3ejFiM2IrWjJodnphZ1Nn?=
 =?utf-8?B?TGtYcDZsUkJuWmZhZFcrRTRaVmVGS2tqWERNWktTaHR5WFFkVDVBbXdaN3Nu?=
 =?utf-8?B?NEpUQmhjVGh4TnpiWjNTZC9qUXVKKzR6c1B1akNnNHRPbVgvL0NEUE9MY0sw?=
 =?utf-8?B?Ri82ekd6YWhlcDA0dW43NTJiQ0ZvVlJncDZsS0tIbUtvUkkxNk5DdVg3NGM5?=
 =?utf-8?B?TzdhaTlIVHcvMm5UUFBWcVVZMXVocGwwMWo3WGVNQUdTK09rY0lzdTk5TTMw?=
 =?utf-8?B?RGVqeXdyeDdsM2djREtwR1QwenFkZWRXWmVpSjZVOWxsR0VsYUdPTnBUMXh1?=
 =?utf-8?B?SHdjNGlJcnBrVXR2NXpUWFgySXJwOVZBOFN5SU1ZZlM3aFJwVGZlbTE2ZzR0?=
 =?utf-8?B?citoV243dm9RR3RObVlzakxuMTVsWWdmWG1LQXREYnkwb0hsa3dZeUNmdWc0?=
 =?utf-8?B?b3pqb1pLR0xZdVpvbUV2dEVidFU0ZkJEZU1Oa0ErUDFLYVhZOG56ZGNYMXpO?=
 =?utf-8?B?R1JCWDBjbDZvSUlnOWxmU1JNUzhZSm5OajBxSHhVZzRIeUZUdmpwRVVWK3FZ?=
 =?utf-8?B?MmFzUFJyZTZ3ZnhmUUh3QzVNOERtbWxSSjh2Y0FSWStXa2xKS3RjdlhudW5O?=
 =?utf-8?B?V1ZZaG9WYnA0V3kwZHFwOVVLRTdoM0p1RXo1NTZnKythRjJoSnkwTVRaeUpT?=
 =?utf-8?B?dWpDLzEwYnZha1FFQlFObE9mZjg0NHIvd3Jxd1lqcXl0YWtQRy94L3k3Qndi?=
 =?utf-8?B?RFRXN2tWV01JMFB2d0hacE9kVkdhL1hRc2g1TGp6Wkc3OVAzLzEwYk5DeXdZ?=
 =?utf-8?B?MWlrMTVhZHdvUnVJbmtoUjJsdDlwRFY1T1pUeHNFOWhRTWlpNThyNW1UaGEz?=
 =?utf-8?B?VldSOWIzNkhoUmlNS2FVaFVOc2lZZkU5SjYwbXUvNnByVlhGL0t6aGhqTG9u?=
 =?utf-8?B?Uks4V3lYU3B0bkFGKzcyNGE1dGNjUW03YVJ3c1FpUmFEYkhVdkdJeGFkRmZ4?=
 =?utf-8?B?N3lUTGhwNUpXQnZQRWdVWll2UkdCVDJCenRVUjZuNk5PZFR6cm1nNHFlWU91?=
 =?utf-8?B?SzV2bGVGTG5KREptNko4eDhMQkVFUFpIY3BMSDlaTExiUW13cmhrYVFMYytC?=
 =?utf-8?B?ZVd4MEZ0N1NNL3hScTgxK21mTjhKdmNiMVkvK3lER2RFUnVOODRuU2Fpb0Qv?=
 =?utf-8?B?TjR6N1Y2QXpkOUlPQ0tiTHd5TmVLUm41L3piTC8wWWNHTVpyMDFVYlFMN25k?=
 =?utf-8?B?Qlp3OWxJTTd6dFc4N0tlUFlSM1VDTS93NWkrSGp4amFzS2dqQlJMR01ZSnNM?=
 =?utf-8?B?UjkrYkZDOVUxNWQ1ZHQyT2pBZ1gxOG5PN2N3TUtEa1RaZzhVd1Q3cHlUNXg0?=
 =?utf-8?B?VFIrTUJySy9HSVJEbTNqK0UrYmVlM1pFd0hHWnFvcDJPOWhIR01pZ3VqYmo3?=
 =?utf-8?B?aUVxUU4rTnNKL0crRnlGbkhYRFlWT1NPSXo5Tzc3N3FvWHZLTWlrYkhmZVFT?=
 =?utf-8?B?UWJ6U2lMOWFCcVY1R3NLTUk1aERmbVJVNkFJVmh2RlNtK2lXZ0kxb3R6MkVs?=
 =?utf-8?B?MHVSSmhEeU1BK0h0ektlbEpZVFNRSjRjTVJxcEtJOVQ3V245NVdOdEFMbjlq?=
 =?utf-8?B?UCt4RzE5TTF1WTRrM0g2NXdSYWRURkN5U2F3MkNMcWlNSjdsVXlMT0ZINEhz?=
 =?utf-8?B?MENpVWhYZzhFNWkxSWh5dU92U1dWUnd4RldEMmw5dHRSWXJzWThMdnRMTjhU?=
 =?utf-8?B?b0EvZHJhNDNZTXdhcjhKZ1ZQN0FWRHU0WDB3Q1ZadTNrMzEvRUtPU2VXN2lP?=
 =?utf-8?B?U3V5SlVuZUJEa3RwdFJDdGdLZGtpNzZ1SlBQYXdycUF3b21pRmIzeGgvRmNV?=
 =?utf-8?B?MEFYejgvcitkNWs0VmtnaDdWMXpmL3YvZlZ5STFzbGplVXRDMUNMMndTajFp?=
 =?utf-8?B?NWp6dTlIaDdXQWtaWFoxcDV1YXY1MmZhMFVWajlaanFHS0RsMW53MnRseHVj?=
 =?utf-8?B?NkppdGRaVUw4OThicHE0TDlVcnZtZFFvNytnaHFSNkdrdmlHQ0tMa0R6b2Z3?=
 =?utf-8?B?TXFPdmRyNjdyL0hMRlpFc1dReVJYQy9lbzNPd2ozRWNuaWdNYXI3K0VIQWNC?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b408c50-c8d1-4b45-ec7f-08dc9c2c33e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:21:24.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmPHeCLJCfr1kQ3KK9pSfbpGF8QFHkB7JvFO5v9dV5sKLnLAq+m4J56w8dV+txHNlUQHrYZksYFzdP7GvH73ERvYaUuVXYP2tA7PFmfi3fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

The I.MX SDHCI driver assumes that the frequency of the 'per' clock
can be obtained even on disabled clocks, which is not always the case.

According to 'clk_get_rate' documentation, it is only valid
once the clock source has been enabled.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 21d984a77be8..8f0bc6dca2b0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	}
 
 	pltfm_host->clk = imx_data->clk_per;
-	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
 	err = clk_prepare_enable(imx_data->clk_per);
 	if (err)
 		goto free_sdhci;
@@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ipg_clk;
 
+	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
+	if (!pltfm_host->clock) {
+		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
+		err = -EINVAL;
+		goto disable_ahb_clk;
+	}
+
 	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(imx_data->pinctrl))
 		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
-- 
2.45.2


