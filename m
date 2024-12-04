Return-Path: <linux-kernel+bounces-431902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE39E4280
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D0A169A82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74620DD66;
	Wed,  4 Dec 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7+6u4xV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD620DD5B;
	Wed,  4 Dec 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332779; cv=fail; b=MpczsM4sDoTghiQtcMHLUXTW3DbqJS96XPNk8XS03KtXIyGlx6zAH7TIRLa0GN4lB7KNuEtWBImUIjixKvy6qNzuCDw1eevt2a82VnQZu+DZBCgKnfNOnOh5sxsPgG7fTshF7teINVTNDcznyFQfhDtzwQyM9nvfVTmWQG7baOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332779; c=relaxed/simple;
	bh=0yUiHZwrBe4YmL5jE1pLyBW8rpNVp2ikY57/WKgE4ek=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4zaF7thv/ScdniuOVtO3UYt2FQeXaSSXxtAGTj4OxPAjkKQY17WtoSPEaZoLdtJRmmcYaG2GtmyuDLNed2xChD3qLa2nb4h/QyCFRW004K5jh4POjqLIH8FXxGA4z/0DlQDyJArMtS0QldAyzd3qkn3rcQVlD6eTvHEB37Gu88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7+6u4xV; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsimGyTdCkqljYkbS1q/U25Oo9okhlPioNQrfYu8hVWU9toHfx3dWBLs9UpRJaC3LOpHyUA9ZKxTYZC5CCi+ZQMhVOAsQugGM3c7rqqeAAWiBLUX259v8p8sznHE1c2AWQEBi6hExAdskXwkykQVwB062bnjEUaqJoNqO3K13lkY1Lk6U8dFVfbsPAT0m/RIScVA2F+LWV3/atiw0vwHjFPOiTYddxblmyAGyzqKiQBUg9jfAqZ7LUB4oASEg8gigVY3eeKHxVzHtdbYzhCbsAyoK1UjOL+AXT0OmgA2AP7c0UVufqfpLcgt2teGiwypTa11yY5q5y2WvPjfnku9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAygl81BatHZk/w7EoBDkVyQ6aeapT3CcWJgB2D5dbg=;
 b=j7zKvvV99JU95ocpzsF2icDrzxAuWGY40l3MTa5LATI9Kj9MXZ/zU0tdIL1aHj1XJyf/4krcwwuXp+R12PsNcnNqxZt55o4mYSGHZChYmrXa0KnI1qULl8t5ZFZku1nqsTP8SnYSrzcyWEi92WOqWdZysr+N3SnjbkCNXZAzGTqHLEvLngHCYd33nPvM1flKjtWMN0jqUJr78ol+NOuOZutY9h+hUtKuVmB37CvSMXgBQQ1EIaRms3ZIU+burcEcV2knj4kTgSlCIQN90Pi0VdpZrYOngVnPE4Qo8VKl6jXzNbrwd+sbGUYX2hmF5gxrXOm8mLmvaaE480US6EUNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAygl81BatHZk/w7EoBDkVyQ6aeapT3CcWJgB2D5dbg=;
 b=g7+6u4xVp3FLNIRgaivXyQfxEmV/W3Kn6v90/aY2QOp0ZdSuavHqKqGtKScX0864njueSySenOWVLvi/i556WzgXIXMK4kgz+cjBDIpeDxvUc1X6+kGJv7WNooD05Mr5eD4wzSqkvHw/tZTXcJax6CejZ5GgKiR0tK9kCtroLlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 17:19:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 17:19:30 +0000
Message-ID: <6be962a2-8fb0-40e0-b010-db61f3f476cc@amd.com>
Date: Wed, 4 Dec 2024 11:19:24 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
From: "Moger, Babu" <babu.moger@amd.com>
To: Fenghua Yu <fenghua.yu@intel.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org,
 rostedt@goodmis.org, akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
 <85cc9764-1140-4c08-8ced-c2654f7775ab@amd.com>
Content-Language: en-US
In-Reply-To: <85cc9764-1140-4c08-8ced-c2654f7775ab@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0176.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e55676-08e5-46d2-0b01-08dd1487d014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGlDbm9rOUxpMVJVODJtWUdGdnlrM21pYWpMeUQ4VjZVVTlQVFBwcjdxTnBw?=
 =?utf-8?B?aE1UVksyRm9aK1FuRHlLbmcwV0o1VVZIUFRCSEExU0g5b0kvNTdCZjJ1Rm95?=
 =?utf-8?B?M2dqQ1o1dVU5eVptZnR2K204a0J5czAwK0szSElLc1pKTytSSWZZNXI5RUU0?=
 =?utf-8?B?dUFJNXpWOE83NDhjQkdkUXNDbVhSanJTcUV2cXdWaFl2NHpwUnhValJUQUNW?=
 =?utf-8?B?dE1jYXVyZVk0elZkWXd2eHRpU2lTWjN3N2xRRzZORU9zOGhZNk9sWjlrczNx?=
 =?utf-8?B?Vnp4eW56a2IwV1pTd0lLbVpFRWdhdHRGbDZhcDUrZ1RqdkR5TjFqdm9TU291?=
 =?utf-8?B?d09paGRYWmhzWWh4Wnp3N2RZa2gzL0ZNRzhVVVVrOWludit3QUpEbzNhcmRP?=
 =?utf-8?B?RlRJdFA2QVpLQStNU2lrYXVuTnBMc1F3WUkya1gwN1Z6SncyRmtFb0MrUnAx?=
 =?utf-8?B?d011Ry9IVHFvYlVVN3pyWCtiTTVXcjJDblhLZXFWbzFLNnlsMWhjdUhWazVF?=
 =?utf-8?B?eDJ1ajZzTGVhRXpXMjZ3a2JOWkd2QUJvL2dKazVLMG9UTnd2UUsrTC91ZUht?=
 =?utf-8?B?L0RnU2g0a0dncTFkdFhuU2lvVHNCdjZiU08zSDJwZGpQNkJzc0lyUFU0a29q?=
 =?utf-8?B?NHo4ZlNXSGRSaVdEOWN1VnpWWHQ5a3FYUXJNZjRrYjVVdEV6U01wTVZJOTBy?=
 =?utf-8?B?aE5neW12bU1aOUo1OFhsUzBZU1JZU05YaFVYRTRqVFBTYUlteVBYZFZaNktN?=
 =?utf-8?B?bTZQSmxnQWxLRjVkakQrbFg0MFZOVnNnTE1OeTBudWppRFFWMU0rQWNIUUN5?=
 =?utf-8?B?N1IvdXVDdXlqVXhzYzdxREpOSkN0aVNzcnY4K0RKSHJwVGhaZU9xVVFPS20x?=
 =?utf-8?B?YWVIMUN1N2NEZk5qZGs4QmtxR2syKzNBcG91SFU4SXQ1TGduVnU5VllHRURE?=
 =?utf-8?B?UjR1SkdCMXJRenlaMVIrelFEMDdwZGg1ejdYZWFCbFRNaW9paHpLbzFxRVBW?=
 =?utf-8?B?dytOT2d6S3VabjVCRC95Ui9FbmZ0QkN2OW1ESmM1TXVYOXV1Z1hOT0tPTXFM?=
 =?utf-8?B?RHl2RFErT1h2TTdXVGUxVVErNzNIYVI5eWRNYzM2cHI0c21TMU1USjJWOWRv?=
 =?utf-8?B?RE9tMnFVVmZpR0pqYktDcmZHVUMyUHp6R3EzZUJ6MnNEVThNUW1PTm9WZjk3?=
 =?utf-8?B?UnFreTJkUTdUR09rNnhCTHM1MUc2VmFMWU52eldBMDRrc1p1SWxvQnhIUGNE?=
 =?utf-8?B?UlprTGRBeVk0dFdjNEFla21hNTlONUpSRW00WjFkVitxbk9XOTlrL2VENHZO?=
 =?utf-8?B?Z3ltY2RIWGtOQjhpWnk3akhYK3NWczJ3RjdaOEp2TWZlZE5XVXJlTVJXQ2hY?=
 =?utf-8?B?aDBVeGEwQnB0Z1VkM1BTMEU0cFUvZTY5R2duSElaR0RNZHhlcXZ1U2puU3Vj?=
 =?utf-8?B?bVByMDF1ZThSSkE0L0xLczhUNXd5TlBXSGhQaGNkbmV3VTNkcWtFSittUHRU?=
 =?utf-8?B?c09tbGZCOTdqKzZBZ1dRQjcyZHZpUXc4aW8raGhHYVhQaGF1WmxzZnZXQmJt?=
 =?utf-8?B?U3lRZjYzc0x2Zk1GeVpyOU1GUUZhTlpzTTJEVUhCNEg1NHJnRVVRQi9WTGxW?=
 =?utf-8?B?dmVPZmJXLytOVVdhVENCVUZXVWtQM1RWdHMyNHVBU1NZOEh6YTIzSkh4WnZH?=
 =?utf-8?B?b2RiNzV1SE0zbWE3Z3RTVnp5R240azU5R1VyRURMNFpHdWdteTJ3Q0tzczZL?=
 =?utf-8?Q?wotYqfU2Dd3k8jIotA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVYV1J6SkFrcVFLbThWZCtYWTRvQW5kMGRocWY4aXUvd0V5cmt4WkF3OGJj?=
 =?utf-8?B?Q3l5b0l4WnBtVGdBaUt6dXA0dGlyVWwwUFkwQjlTd09Bakc4M0kvSDVreXF6?=
 =?utf-8?B?cStta2Rpa2I3MjMwTy91a3FXSVJoM2FTYnZOTE94R2QrcXU5MnZwQThRMEVV?=
 =?utf-8?B?TkpHWFdQM1VUMHpiTUp3S2JVMUFzUXYyanMvOUVuY1RDM3VnTmR5Z3JSeFpu?=
 =?utf-8?B?U0wxdlViTlZjM3JYUjg1QVlTTXBwNnR4RjlsQlEzZ1ZLM3BFZlZTN2VtTTIv?=
 =?utf-8?B?MWJ5TnBJSXo0MTh4S0NrVGRoNG84NWhLaEJIZksxaTMvYThvRC9WbzkwdEtC?=
 =?utf-8?B?d3dJbDhnY0FkZFgzT3N2QXk3bGI2T0VPMjNocU9JNFJvangrZWpmZjhaQkE4?=
 =?utf-8?B?QldQZmtsK21Ya2Q5Y0FTSUFwcC9oMlRoVlphVXRUY2l6T2l4MU5NUmRSR3JV?=
 =?utf-8?B?QUtZc043UjBHd0JzeXhsVTlCdUs5aWNsQ0ZFc0dqUi9ITFN4bkxPVllwTExl?=
 =?utf-8?B?Z1FZdXh5THoyUTFnd3FNdDJzZG1Qc1FNOWZhT1VlMEpENE1kQURXR3JLSE1u?=
 =?utf-8?B?WHdzSjJmWUZmL3RBR1AwaFdZMGZESUZKZkJHWHNKTkIyK3RReGRXU25RUFZq?=
 =?utf-8?B?S3BPdzdqOG8zNEliNXVOMUttdXhiem8rOHQrR2pCN1lOL3RMclBhdEIwUXl2?=
 =?utf-8?B?U0lSeFhhc2xNak95WUtpQVdvWWZmWDBYV3VLbHdqUnlmb2J1VDhJNU91NlZJ?=
 =?utf-8?B?NzJrc0t1dUsxc2Y3TUR3L3Z0ak4rbDBkVUtvWnZ5enFETTQydDBZYXM3M3JE?=
 =?utf-8?B?TnZ0UGZIR21MMVBtVUpHMU9XVStCcXBjQ3Ixb2NQRVFPMG01WXNpWGpmYXBI?=
 =?utf-8?B?b3prcWVqSXovcDl6MnFQRG9CUy9QWVNpcEttM2c0cTc1dllhREg4bS95V3lV?=
 =?utf-8?B?UC9Xcnl3Z2p2YkRkVlpRN2VvYi93bXVTNG41V2xoYWo3QjlUWURqOUhRNGxz?=
 =?utf-8?B?VkY0NXEwZWdNNXNsT2orc0twYy9FSEVmbXJ5N0NINWJ6MWNVYmgzT1AwQ1NI?=
 =?utf-8?B?c2F1RmtoaG5NMm9RV0I1ajZBOHYrbExGdnJUUnBSWk5RbGpXWXBvWFBYVnV1?=
 =?utf-8?B?RVN4ZnlldUtoejA4MnY0ZlRNdzFWK016d1BLcUdYVlJKT2RxRCtaUU4yQS84?=
 =?utf-8?B?VUdqOEdMMU5UVzR0ZDZIcGZ1bnRxdDh2dGdpRlJVd2N4bXlNbC9SMUJxRmk1?=
 =?utf-8?B?eS9XK2svVkJoSm9GS1hjQWwzSzRlaTdZZEZHci9KSkR2a1QyRFdQOEZRZDBv?=
 =?utf-8?B?MGVIc1d0N1VSc1NibHh2VnZyREIzVXB1VkNCRlBkd0VIOFEyM0c2ajJkYjQ1?=
 =?utf-8?B?Sk5ad0xtL0R4MVA3TzhzY1lKcnh4MGY4SHlYQnlDaUw5ai9Kc1FPa1pEOXJt?=
 =?utf-8?B?VGNlODFVdU9NOW9CaUdSbFVJZk1DRzlrY014UnR5K1hnRW5kMzlLc3pidWxi?=
 =?utf-8?B?RHkvRDA4aDNzQjB5aFIzTXlPdmU2RUtVMlJtQWdyTGlTSXVOc1hBdVhROHBQ?=
 =?utf-8?B?WFh6SFl4NkR5disxdFlsS3BxTGRIR3FTcENnYS9lVXp0TkR5UDNHZUs5RDhH?=
 =?utf-8?B?MkFsdTdQZmNtYm5CNFFxRElyZXgzd0xkR2tsbjdPY0J6R2FEZmYyT01IOWVp?=
 =?utf-8?B?UkdheXdSdVVBdnk0NGgzVHVPODNod0Vpa0lNUTdxOHhCVTBaV0xZdCtzanJJ?=
 =?utf-8?B?Q3FKdml5VVNGc3pPbHR3dW1KUGtyVTBTSC8wK2pWNDQvZWgzYyswMVlnL2tq?=
 =?utf-8?B?ZTE1a1ZJb3BsUTh4N0dsYm1uaVEyTDNOaVZtNEJaNisyem1Ld09pUkc0aExn?=
 =?utf-8?B?a1pKc2RmRVFRYTA4UXM5R3NFblVXNCtqdnp1U1BKR1licHV3QTFNeFNpK2po?=
 =?utf-8?B?TS9acVBBM0Q1dU9oeEZxMWlJbllEMERkeUxrMGk0d1RMN1hTSHEvTEd5eUVH?=
 =?utf-8?B?M085YkFJUG1CVUxoSytTZG9Ed2V5YU1UUWdKenpXSWFnVHF2VUFXbTVqMG5w?=
 =?utf-8?B?VlVldTZQYzkwRFhZMmRoeUNSSW9tTWthR1hGb0lLMUpPVC9MQ0FocFlqcHdP?=
 =?utf-8?Q?Sc00=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e55676-08e5-46d2-0b01-08dd1487d014
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:19:30.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzGAxGdPSHS5S23ChOunGSCyKAx3aVA25ukOLuWkVKROxt/RQv1uM24F1Bt6xNsv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

Hi Fenghua,

On 12/4/24 11:14, Moger, Babu wrote:
> Hi Fenghua,
> 
> Thanks for the review.
> 
> On 12/3/24 22:16, Fenghua Yu wrote:
>> Hi, Babu,
>>
>> On 10/29/24 16:21, Babu Moger wrote:
>>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>>> are required per group, one for MBM total event and one for MBM local
>>> event.
>>>
>>> There are a limited number of counters available for assignment. If these
>>> counters are exhausted, the kernel will display the error message: "Out of
>>> MBM assignable counters". However, it is not necessary to fail the
>>> creation of a group due to assignment failures. Users have the flexibility
>>> to modify the assignments at a later time.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to
>>> return void.
>>>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>>>      Updated function comments.
>>>
>>> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>>>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>>>      Fixed the problem with unassigning the child MON groups of CTRL_MON
>>> group.
>>>
>>> v7: Reworded the commit message.
>>>      Removed the reference of ABMC with mbm_cntr_assign.
>>>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
>>>
>>> v6: Removed the redundant comments on all the calls of
>>>      rdtgroup_assign_cntrs. Updated the commit message.
>>>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
>>>
>>> v5: Removed the code to enable/disable ABMC during the mount.
>>>      That will be another patch.
>>>      Added arch callers to get the arch specific data.
>>>      Renamed fuctions to match the other abmc function.
>>>      Added code comments for assignment failures.
>>>
>>> v4: Few name changes based on the upstream discussion.
>>>      Commit message update.
>>>
>>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>>      ABMC feature by default if the feature is available.
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index b0cce3dfd062..a8d21b0b2054 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>>>       }
>>>   }
>>>   +/*
>>> + * Called when a new group is created. If "mbm_cntr_assign" mode is
>>> enabled,
>>> + * counters are automatically assigned. Each group can accommodate two
>>> counters:
>>> + * one for the total event and one for the local event. Assignments may
>>> fail
>>> + * due to the limited number of counters. However, it is not necessary
>>> to fail
>>> + * the group creation and thus no failure is returned. Users have the
>>> option
>>> + * to modify the counter assignments after the group has been created.
>>> + */
>>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>>> +{
>>> +    struct rdt_resource *r =
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>> +        return;
>>> +
>>> +    if (is_mbm_total_enabled())
>>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
>>> QOS_L3_MBM_TOTAL_EVENT_ID);
>>
>> In this code path,
>> resctrl_mkdir()->resctrl_mkdir_ctrl_mon()->rdtgroup_assign_cntrs()->rdtgroup_assign_cntr_event()
>>
>> CPUs are not protected by read lock while rdtgroup_assign_cntr_event()
>> walks r->mon_domains and run assing counters code on CPUs in the domains.
>> Without CPU protection, r->mon_domains may race with CPU hotplug.
>>
>> In another patch (i.e. rdt_get_tree()), rdtgroup_assign_cntrs() is
>> protected by cpus_read_lock()/unlock().
>>
>> So maybe define two helpers:
>>
>> // Called when caller takes cpus_read_lock()
>> rdtgroup_assign_cntrs_locked()
>> {
>>     lockdep_assert_cpus_held();
>>
>>     then the current rdtgroup_assign_cntrs() code
>> }
>>
>> // Called when caller doesn't take cpus_read_lock()
>> rdtgroup_assign_cntrs()
>> {
>>     cpus_read_lock();
>>     rdtgroup_assign_cntrs_locked();
>>     cpus_read_unlock();
>> }
>>
> 
> Good observation. Agree. There is a problem.
> Some of this code will change with earlier comments.
> 
> We know couple of paths are affected here. Why not just add the lock
> before calling in affected paths instead of adding new helpers?
> 
> /*
>  * Walking r->domains in rdtgroup_assign_cntrs, ensure it can't race
>  * with cpuhp
>  */
> cpus_read_lock();
> rdtgroup_assign_cntrs()
> cpus_read_unlock();
> 

Oh no. Looks like we are good here.

Looks at Reinette's response. Thanks Reinette.

https://lore.kernel.org/lkml/4032a5a5-dd0a-49ae-94b6-dc4fac4c190d@intel.com/


> 
> 
>>> +
>>> +    if (is_mbm_local_enabled())
>>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
>>> QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +}
>>> +
>>> +/*
>>> + * Called when a group is deleted. Counters are unassigned if it was in
>>> + * assigned state.
>>> + */
>>> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>>> +{
>>> +    struct rdt_resource *r =
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>> +        return;
>>> +
>>> +    if (is_mbm_total_enabled())
>>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL,
>>> QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +
>>> +    if (is_mbm_local_enabled())
>>> +        rdtgroup_unassign_cntr_event(r, rdtgrp, NULL,
>>> QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +}
>>> +
>>
>> Seems rdtgroup_unassign_cntrs() is always protected by
>> cpus_read_lock()/unlock(). So it's good.
> 
> ok
> 
>>
>>>   static int rdt_get_tree(struct fs_context *fc)
>>>   {
>>>       struct rdt_fs_context *ctx = rdt_fc2context(fc);
>>> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>>           if (ret < 0)
>>>               goto out_mongrp;
>>>           rdtgroup_default.mon.mon_data_kn = kn_mondata;
>>> +
>>> +        rdtgroup_assign_cntrs(&rdtgroup_default);
>>
>> In this case, cpus_read_lock() was called earlier. Change to
>> rdtgroup_assign_cntrs_locked().
>>
>>>       }
>>>         ret = rdt_pseudo_lock_init();
>>> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>>   out_psl:
>>>       rdt_pseudo_lock_release();
>>>   out_mondata:
>>> -    if (resctrl_arch_mon_capable())
>>> +    if (resctrl_arch_mon_capable()) {
>>> +        rdtgroup_unassign_cntrs(&rdtgroup_default);
>>>           kernfs_remove(kn_mondata);
>>> +    }
>>>   out_mongrp:
>>>       if (resctrl_arch_mon_capable())
>>>           kernfs_remove(kn_mongrp);
>>> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup
>>> *rdtgrp)
>>>         head = &rdtgrp->mon.crdtgrp_list;
>>>       list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
>>> +        rdtgroup_unassign_cntrs(sentry);
>>>           free_rmid(sentry->closid, sentry->mon.rmid);
>>>           list_del(&sentry->mon.crdtgrp_list);
>>>   @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>>>           cpumask_or(&rdtgroup_default.cpu_mask,
>>>                  &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>>>   +        rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>           free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>             kernfs_remove(rdtgrp->kn);
>>> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>>       for_each_alloc_capable_rdt_resource(r)
>>>           reset_all_ctrls(r);
>>>       rmdir_all_sub();
>>> +    rdtgroup_unassign_cntrs(&rdtgroup_default);
>>>       rdt_pseudo_lock_release();
>>>       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>>>       schemata_list_destroy();
>>> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>>>           resctrl_arch_disable_alloc();
>>>       if (resctrl_arch_mon_capable())
>>>           resctrl_arch_disable_mon();
>>> +
>>
>> Unnecessary change.
> 
> ok.
> 
>>
>>>       resctrl_mounted = false;
>>>       kernfs_kill_sb(sb);
>>>       mutex_unlock(&rdtgroup_mutex);
>>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
>>> *parent_kn,
>>>           goto out_unlock;
>>>       }
>>>   +    rdtgroup_assign_cntrs(rdtgrp);
>>> + >       kernfs_activate(rdtgrp->kn);
>>>         /*
>>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>>> kernfs_node *parent_kn,
>>>       if (ret)
>>>           goto out_closid_free;
>>>   +    rdtgroup_assign_cntrs(rdtgrp);
>>> +
>>>       kernfs_activate(rdtgrp->kn);
>>>         ret = rdtgroup_init_alloc(rdtgrp);
>>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>>> kernfs_node *parent_kn,
>>>   out_del_list:
>>>       list_del(&rdtgrp->rdtgroup_list);
>>>   out_rmid_free:
>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>       mkdir_rdt_prepare_rmid_free(rdtgrp);
>>>   out_closid_free:
>>>       closid_free(closid);
>>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup
>>> *rdtgrp, cpumask_var_t tmpmask)
>>>       update_closid_rmid(tmpmask, NULL);
>>>         rdtgrp->flags = RDT_DELETED;
>>> +
>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>         /*
>>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup
>>> *rdtgrp, cpumask_var_t tmpmask)
>>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>>       update_closid_rmid(tmpmask, NULL);
>>>   +    rdtgroup_unassign_cntrs(rdtgrp);
>>> +
>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>       closid_free(rdtgrp->closid);
>>>   
>>
>> Thanks.
>>
>> -Fenghua
>>
> 

-- 
Thanks
Babu Moger

