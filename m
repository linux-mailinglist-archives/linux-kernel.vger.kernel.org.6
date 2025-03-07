Return-Path: <linux-kernel+bounces-550316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A94A55DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EE21897041
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4811885B4;
	Fri,  7 Mar 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="da0YqHmr"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFD1519B4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315547; cv=fail; b=XtAXFxgfktwnSaYBfsZoSlkOQ3dIia8cRVnWmbGiMQ/kkP0CTGUcxjW5X0qi/kxnuPicgBj/qNrjSUZ/PJER+nNNczWct+91b1cxji7Vze4uirovytSHgdvj1sEfvIvjm1bNJE/ySACL/7NlR0KX9BRX6nUs7SoQRK705qYRnLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315547; c=relaxed/simple;
	bh=BRZOa/ECylh50br6X3X9b6XjkYuZLeGwYlDoayY8Ioc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omVy88IVUUnMvDJQQ8Ev8ius5XW3sdduSe1rHM2HSRE3AGShwlgAq/9mdfgAgQ74ptQZ1DIsHFJykEHPRXJezkKUVlSsT/6NU9kWfDwVpG2qdc1csFH+EtXEMBnuNbZDQnX/LY2PZKFoZWKH2bL+dRcGOEbdhNVJIcIQDNzi+bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=da0YqHmr; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgMCiuk0QW60TbwpTuI1D3M3bxk5/6SMTE7Qoi/X32dOkBE9bVVuGDzS9ugCouX5oZG6Gk6NoKQKRDe3EA5GF9tUTRCCGtfxN9iDFtWLBEEXGt0IqBYqw5kuCGe2BJ9nPFxvQbf+fWW/1nmi+PXmuRYa180vCc0AvW9QbtjeRCQgOE/ZZOqzoc7V5xY81Y9KupRfvQE4UgLXLrb+uwNwuXS8NbxHbjd3alngFRcWzsm5CIgxo1BeKteWhX7itX+0pRT6oFtsvJA56YOuFlWV2kJd7/83L7Yqro9x5u4upXPAPImfI0y8YS7Z2uM7Io4Ux86zvL52WHWeXIU8LQSnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRZOa/ECylh50br6X3X9b6XjkYuZLeGwYlDoayY8Ioc=;
 b=tateeEN3XLw1+KgwdTM9nlkpLXcdBdtLf/n+Jo0OkDV+M657Op9C/kbpbJzOO5HWDK7EPKDQFbNJA4H76e7xiC7xbDnboLm5SdiAH6AdrLlnJ8A4yLK0DEWVvJMk1NGuaMQpYe8bxQp433/SlyZELYioZbJ7ClchrfGaMtLBLD5iT4kZgE9ceWBGSfmf6P065hyGKI2xnLKUCPZzakeH8BxNKvecWErA5RnfH48L+sgrnqOeBVwMeMqwcHdVem5MtBjgRyS90PjydwT9Cy/Mg2IdiYyMZHo+VDlwTrt6qfVbi6+WVhkfXnJiFWjPedl1+k16OW0SJqr+Bc1E+ie47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRZOa/ECylh50br6X3X9b6XjkYuZLeGwYlDoayY8Ioc=;
 b=da0YqHmrLJ/NiFTI1fy2VnR1v8Hc2WQ2iUpTYx+Z1u5Ur5cPu4um1im2BQgLp0WmVolg9GD+GXl4W/BK7fzrPQs/UME+oGjckHsvzROC9NG/WONIlU3dGaCU8gko6LGTnPJGGZ/KNrtLMDOVR6Bc+5v3DLyXkmvIQ7bE1ZBNr9gCElDDOMJ3eqhYZPdNnx4xMni9YXzJClXG3r+oIT1kBMWYYKNn6zk4beFgSfOLdl6GWveOx6E8UFgE+e/MOptmhYheCZdxOUfenMF6fSc/UU9OSG4ki/k2LUeg0gl27221BZRE97WBB8w6Moyp2+7bdwEi64W3CMcSHKlipx6oUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:45:42 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:45:42 +0000
Message-ID: <0d3c2a9b-e845-49ce-8faa-bdef406198a9@nvidia.com>
Date: Thu, 6 Mar 2025 18:45:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 49/49] x86,fs/resctrl: Move resctrl.rst to live under
 Documentation/filesystems
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-50-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-50-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b1e0ca-1ef5-4201-fddb-08dd5d222751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVFCRlVnV2ZTYUdNWk9ta3JkU0dYZVBpYlJSN1NjdmdsNG5RMlM0RFNCTzk1?=
 =?utf-8?B?YUR4MFQzaktzVVpJUTg0aTYxeDR4d01Tb3h3VXBEWk1wZmRxZkdieGtlT01T?=
 =?utf-8?B?d3AwL2g1eE9laEJHQ2Y2d01MREVzRUlhUGlUTGhqVEVyM1hPMmd4S1doSzRF?=
 =?utf-8?B?clQxK29ESitLRzU4TWFuRmo1NFQwMWlRSnFZM0xtbjU1a21jOUhaZU9RbXFL?=
 =?utf-8?B?SGN0eTBKeGRsaFVvYWZkOFU1eGxlbE9QWjRxYnJ2dVQ5Ry9NY09XNnljTVFS?=
 =?utf-8?B?UldzaFIweVgyYWtUOWxZRkpBTE1UVUY2QzQwQ2RySGxNa2Q0b0U3L1hkb01v?=
 =?utf-8?B?NVZLdlV5WWlyaE16YVR1UEdzS2FIKy9Ec29CTm0vOXVjd3hhdm9qTlNad25P?=
 =?utf-8?B?cmt4Y1h1eGZBMmFXL29HSHJXNjJlUXFIdktRWFZHbEpRUUk2b0NlNlo3NVc0?=
 =?utf-8?B?QmxTK0M1L0N3dGdvaEdnRnpLUVI4UndkR3htWHNqdHRxekhHODJGSW1ZSTN5?=
 =?utf-8?B?K2dpMENHOC9aeW5xTkROT0w0WkNxYk5hYlJsaE1ZUUNleVpzdi9ubmlLNnFX?=
 =?utf-8?B?WVdEL2c5SThXa2pZYmNTZzNOWnl1YThabjZWWHNET2FRL1FuQXZsSkQ2MHR3?=
 =?utf-8?B?Rzl0K053VFJ1UVlDekFpb0NrTllCUTlBTmdXaEl0bytYeUZieXJjNEwraFdt?=
 =?utf-8?B?b2tpd3EvT0lxb1VIbCtRUHVQeWxsOEdGdk5zQU93NEplbFZGeC93RWtnemUv?=
 =?utf-8?B?VHA2MTJCMDRXdytDcGorV1VJcGhRaHE0UUZiOGhZU21SVFVOSHBpaThsNjk2?=
 =?utf-8?B?aVI1WDJNNWR5cGc1V2o3cDlGREg3WWhvZDNBTndJVTFpdnhON04zMUEvckth?=
 =?utf-8?B?MUNBdWRXYlExS2ExY25TK0dEaUxiZXI2N1A1QS9CS3BVb3lmeWZYMW12RUFR?=
 =?utf-8?B?LzdLZ3d5eEFCOWg0UEtMU1hKRDBkUjFib1loQndnUXlza29YMDEvMFFjZUQw?=
 =?utf-8?B?SFpyMUNCdFZSSEtEM0hTZmFsRi9PQjBDMEdTRjJNTmFhdXJSR2lERGxVVGNI?=
 =?utf-8?B?SmRBRlpvamlZaVlhbEhpYjFzblM0cE1jQUdhcDVKZW5NeElRNWtHTVB3M3N2?=
 =?utf-8?B?Wmovdk9QeHU3c1NXanRqUGQxL05OaElZMnNKRHRhYjR3N0pFWlNSeEs0TmEz?=
 =?utf-8?B?anJqdUozS1FZWXlJRzhOOW4wWjgrbnMxVjFQOWUvbTBramdQa0g2M2xxMCsr?=
 =?utf-8?B?bkFwQm9MM2ZDSGh4MlZlQ09XOFRqNEx1OWsza2RDRHVkcjVuOEJmNkthNzZk?=
 =?utf-8?B?c1UxdS9lN1hYaWRQWlp6Mi9lRUJQN2NSamlBb1JxdkdUTnN0Zkc5SjV6bGEx?=
 =?utf-8?B?VlBFdzM5WjloT2FhNnVUbzNmcVpJYTErZXVwV3hvNlBtUW5qZFF3YXB3UjdX?=
 =?utf-8?B?Rnc4V3drbkgwMzNZTnd1bkRGMHRDNFNaUjVnLzhLSzMxZVo0SVBzYTZLWjZt?=
 =?utf-8?B?RklLNlJRRkRQWFAzTytHamgxSk5yYmVWMXpFekhBejFMR1NzUHNtLzdZV0pH?=
 =?utf-8?B?RVZGTnRubVBPdHk5ZnY1eG90TE0zbEJ1Tk1DR0E3WFRLR3VZVVJuSlFqWEkv?=
 =?utf-8?B?WXp2NUNpQW02WG1VSFgydW5rNXcxY2lxdHVsUVIzcWJOa1pUejVKT1dZNVE2?=
 =?utf-8?B?VW5DRXYxZlNldXJWTW1YVlRNRHlLdStSa1lvUmQ4NUZtczNMKzNodTdWS25L?=
 =?utf-8?B?aGVCaTROZnUyZXF5a0FoZjdiaEdzbFQydllxdVhZLzFOWnFMTHZRN0RlYzdU?=
 =?utf-8?B?clAwZXJndkQ1cDkrU0pUSlVLNjJ4OURXdythd0h0ck5FNzFIUktUTUJnV2pj?=
 =?utf-8?Q?em6uUstY92lpW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlRwalBxZ0xxeExpSllVUGplR0M2d2RKL2ZSR2hSM05Hemd5UXRYT1hpOVRL?=
 =?utf-8?B?RzNJN29nZnRPT2RETit4YXVTMzk4ckZlRUFDN0JHRklIcHFSZEs2QnBkb2Jv?=
 =?utf-8?B?d08xS2lGalpNaE1DeVFXc1dLODZldTBzOHFQeEI5N0RLSTVsODgweFFwSnd5?=
 =?utf-8?B?WXJJZnFlM08vMFB5Wmx0MU5XaDZYdGt2WGV5NDVmYmxVY1JEVFdMeVBLTlpm?=
 =?utf-8?B?dFJ3M0cxS2Mxa2owcmJYaHlhOURPVzBNWTArNVJ3bzlKbkdHTm9yWWwyTjZB?=
 =?utf-8?B?L0l1SldtMmh4MzJJQW5HV1hXN1ZUaXA4UXJWbHlMdXlURkdoWmZ4dzNuOWFK?=
 =?utf-8?B?c1BVSHBZUFl5YjEvc01mZFhZNXVBVTZEWUIya083ajNSN25BOGpBTnNFaEF5?=
 =?utf-8?B?V3FwR2t0NktzQ3JnZWdEcDRWbDhscStGSDMvbDdiekZmV1F3cmd3aUxQeWNN?=
 =?utf-8?B?R0RNMmJhZXJDNWJuNGFMTXR0OWJqY0g1dXU2djRvODR3REZmYkpTa1BqWm1T?=
 =?utf-8?B?OFF2MFk3QWVFY2R6QXl5STZkY3NlV21sRlhjR0l3K3NPV2NnMkxTZGZ5ZHZ4?=
 =?utf-8?B?YUM5Skx3RlE1VHVJcmk2Y25CZzMwZS9LenlxNzVxT3U2WkhFOHBINVY0cWdZ?=
 =?utf-8?B?WnhwMkY5WFFUb21HeDlmNmV6R01xckZ6WXZocnY1T3BJZVc1cHdQbUs4dHo0?=
 =?utf-8?B?aGtFWmVaaTdGanNFZjRQeG1mMXVqVDRGVDlTK3kyZjJKQm1xMFd0RGZEQUhu?=
 =?utf-8?B?emMyeDdXQXdHb2d0ZWdCOS9VRURObjRocjJPMkxRMTdycjE3azBCcGpSVFBC?=
 =?utf-8?B?UkthMXd6aUVqK3Q0Vm1odnp6MlFsMXUyTVROU2hROGNkVGF4Sy9uQi9VeVkv?=
 =?utf-8?B?U1MvWVpQT0RtcU1hejY1YThXS1kvdGl0L3IxNk4rUk5rZ05FTUNQOHRoclJp?=
 =?utf-8?B?U2pMdVJhQkxkdGZjaVIrNHlrSk1ZUXgwcUlOcnlyaDNjSTJoOFFveWRrZm9C?=
 =?utf-8?B?OW45OXdsM2s1eVNiOHdDb01waGQwWGlWYlhBNzRoaWpoOUw3VVhuYzR0MFpo?=
 =?utf-8?B?M3JLNjRsaVZoWkoxNHkvNThkZFNWNEdmMHl3YXFvTnU1U2dVTk1Wcm81cmpB?=
 =?utf-8?B?QkRJc3haNFN0MjE0YnkwZTJGZGpSOWtLZCs1RytHMW00RmNrQlJwb0VlblJu?=
 =?utf-8?B?WHJ2Q29xcGtISFlqelI5a2NuYXlMN1Q3T2gzWW11UlVOWXZBRGpVLzVRZUdM?=
 =?utf-8?B?c1hqK2o4QWhxMGV6NUhQK0lsV2FaT010QnUreS9ES2JFVHd0WWg4UXNBVTMr?=
 =?utf-8?B?eGZ3RnNuczFTMzM3SkZOKzRWOTIyc1NXV2hXczZCc0VVNjMxSE9KRElIOE03?=
 =?utf-8?B?bEJaOVZkMTJNQnVDck9pY3g5cUJBZnFpZDE3ZVhNZFRhVVI4ejdPMElxZGNE?=
 =?utf-8?B?UlU0ejhtd0ltSTZpVzBnZHVPYm1QZmkwTWxIb2hDU1dmenNYcm9aWmRvandk?=
 =?utf-8?B?ME4zWmFDVnNRRy9RUGlNc0cvR0wyMlJ1cG5xRU9zUlZRaldCWTg2UkhMNi9h?=
 =?utf-8?B?Z2FHcnZyMmRjWDdkYXZNSGNkcHVXWml4YkZYTDhnRFB2SzhhcHVQZTNCTnZs?=
 =?utf-8?B?dFpBa3VwWTN0cjRVcmFxNWRralc3Tlh0TFpwUFMxcVRONmdib0w4S21QeUFX?=
 =?utf-8?B?V2ZhdjJSbEltOTByMGN6SmxYRWlubCtVRFpBSHpXSWQ4QWRHamxSNXNLeHNL?=
 =?utf-8?B?NDZnWW5FWnQ5SzBBOWxXVk9qaXN4ZmpRRFVycUNaZlpCSmpsUWdNWjdVTFlF?=
 =?utf-8?B?ekpMSlVZaUVTUlZxVkVBVjlWUkh4WnhYNUg4UkNKa2h2bzhST3IxV09MZFZR?=
 =?utf-8?B?NERocGxJQW1QbU5neUlGMWJ2QlE5Y0JRYmQxYlRCZGpqdm1vUnVtUG5idlZC?=
 =?utf-8?B?NStUaW9ESUY5NnczVUNZdHpFOStwbVpwYzhQSGpEYVJsM0Y0TnBkR3JpOTRv?=
 =?utf-8?B?UEIydll1d3hQVThKampSV0FrK0xQTDA1R3RFQ0pobHBZd1I1dU83RktRYTZS?=
 =?utf-8?B?d2cvSXZWSW40aXpLdmJlbmJ4KzVQVnRTMXU2SzluT3lueTF5VHhDWElZYlJE?=
 =?utf-8?Q?NkqXUHn9KZsAbRQhVPP9kPEEM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b1e0ca-1ef5-4201-fddb-08dd5d222751
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:45:42.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zaj9VeoceW+rSAropNENIKZFVq+sX8ku/EbHUPNavFV4bU1jgtP+0TKzIx3b3zWv5eooIgHKHHNsoBMHRfxQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448


On 2/28/25 11:59, James Morse wrote:
> The filesystem code has moved from arch/x86 to fs. Move the documentation
> too.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


