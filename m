Return-Path: <linux-kernel+bounces-369661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F109A208F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF41F27696
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0F1DBB1D;
	Thu, 17 Oct 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hTJRjSVK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA31D9A6A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163131; cv=fail; b=DGZDpEh0J8rA0BTwgulGjB3qPqVQ5WuZXK8+CrUagABgzMzq3bBcGcaJN8WzBtER0fY0YvFbIaXJihgliQIpWp8IhDjkOnTv0SPk1I41VUZqLQeY4tVuPxf8VZIxwRGGT6twCYYQUcLWXx/SJZ5QLYeaWM0ZNoM9Typ0OLOUb0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163131; c=relaxed/simple;
	bh=GYBJa8azog9Bs7etPEjGyelp6sJmXu7fA4hn3wX05GA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgsqlq8Qwa+jVEzkDfZfJ/zLs67b4f+Lw1K6v4jJfhtDPYR3WdmHc7CpIKUMMXgJQs6gqJ+R/1R0DpuoawCISmf0DpOrEUxt3Nl8Tf1hG4xbtke5HOVbngFa66Cko3fQOT/jCGxw6yY/9al4MqHLvwXo46yNe513+ozrVf8BM+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hTJRjSVK; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRRyOe8kPFAAXywortv5HOfxLMf7EsMxvkjYkH9ZDmRfo2/wkcRY0gJESIPMuwB1k5dc4zxREl/HG02b97875l1CyOFwIbSC9L/Su63bdFE6XDktFbHpTu/8UGx1ofyzPjlgdYVfV/vuzFnchRPhE3GpBbA6XCpxe54NNnQ70/g2nFHRKUtg9Arze0cjs5qxYbSzzJ7WFJzT4OsCTEOrsru5fQcg7t9CY4xXnqV6Z6w2Okb3RxD57kBJgKEwWvDi4dMh4g/hh/1Rae80Wj230IXQMvAEMUMGQVFyt/bO0AB67xCs7BRvhwEcnpE2j1v+jtA+panMyVA3YDNSl/P4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04psjf9PIDp8LDA/al/pFRVGYXjlg+3qVcoI7kb3T1I=;
 b=k9mFpNB+wHA7uXkt7DDU+pzRE8FedB03f3YxTmVFz9+HC+t7lTmoVsn5Goej5coEUBJ968/bEaC1nYeBHQPcqyIDranBwAzdIA9wcIByAzCQs1ScCsOUmjOchVdJ6G6IUAL+8ERd1tgWpNyGTpEozXR+ncdmNuDJAXmYBfQKAgXO1rh6V3Gy7Qs9XTyjItb8yYgxZiWa+2yQJKG8+lQXunMpJ9Ao1ornmZo3YdZ+kB5+/XvGkpJtgaSC/b9QygCMdbgsCyoYoFviGFhs6eQNiif/LI1MO6LqVU04CQ6GbOBg1vdTsIkljVjOv8LDKPqP8jRixLpBp7nV9XK8pk7/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04psjf9PIDp8LDA/al/pFRVGYXjlg+3qVcoI7kb3T1I=;
 b=hTJRjSVKiL5mOIoHOotOBQ15BQC3FORDkBRFVcALylZEXzlvdTdIQMubtu0scpuzeDdaWiCDsmTnefrhVTs03ziuUPM7JGp508J6oX2XcN4CInfRrj8slDg5E0ODeW+/6zK/8fvxN4fKReoAudbdeR0m0sfIh/LT62H89rj+7sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Thu, 17 Oct 2024 11:05:25 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 11:05:25 +0000
Message-ID: <998ab368-61c3-f904-9d06-2c7fcbfd050e@amd.com>
Date: Thu, 17 Oct 2024 16:35:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067E8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::24) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b0d616-17f5-4031-196a-08dcee9b99c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0ticzBTVlRSRk9vV1lYN3ZhZFMrR29NbFRJRVY3UnNYRXo1YlZjUjlFUTNM?=
 =?utf-8?B?RVRUUDJRYmROMTFVN1QzZldjb0xMakFIQjdDWXdCUXFHM1hYUnlGK2hHcGZx?=
 =?utf-8?B?RkptSUh3eEo1RnZxbTVrUnBWbjRUVnJQR09CVEVyM0wzcnVVNll1RGJjKzdO?=
 =?utf-8?B?TktOWTlBZDhjWkx2VFRocW9GMWk1MG5mU3JvYVI1cmJEQUxKVTVKbmZyQUJj?=
 =?utf-8?B?dmp3MGFBT2htam9ySS9oSmVNTUxYS0syVjlwdUxscElvUXh2blJzZlk2dE5s?=
 =?utf-8?B?TDdPajF2eHRKblJJUmN3SGsyR1k5VW9tNnZlLzVvSTZGTDZwNjU5VHpBRDIr?=
 =?utf-8?B?cUl0b2Z4WHptUEpJbU5JVnNMNGcweGM2NWxtZm9PVkRiVWp6UG9QM3k3aGVK?=
 =?utf-8?B?elZ4ZGdoQlBEZmJBQXpWdGp5Uk5wSEliaWhmVE5MTkJlVXdsOWwxZlNWSGdY?=
 =?utf-8?B?cWpxQmVMWlRXTVNkVmRicEs4Nk1xTVFUbUh5ditVbjA2aWFOOTJsSmpKQ1Fk?=
 =?utf-8?B?aW5PQ1VyRFlmRU5OMmtFZ210RExPVFkyN0FOa0FxNzN5STdzd3Bsd3dITXFF?=
 =?utf-8?B?UlNaZk5PTThsTEFNUno4WkZ3R25haFVaK0RrczU2Y1l2ci9DUEhielZuUjRt?=
 =?utf-8?B?NU94RGkwNFNhMnU3VEcxbGdZTnhnai90M3Z6RjhrcGpyS0lRREFIWlRsN1lC?=
 =?utf-8?B?bTJWcGlINDJSWXJjOG9WdE1vb2dNNVVIdnhGRUZlUDhFNDA0a1ExN2YwR1Fs?=
 =?utf-8?B?NjhHOGkvSytQWU5WVFdQTGVocWZCcDU4eWQvNUxnK2ZRVmNPQncyelJOWVpR?=
 =?utf-8?B?amJ0eUZ5YktvbXRDc294b2lZYzVORFoxNkpodjBQb1cxUFZXZVZLbWFaUCsv?=
 =?utf-8?B?UEsvN3JvWlZVelZ3WWwwTVZyODdicXc4OEhsN3lrUzJQQzZuOWVQbndkRHBK?=
 =?utf-8?B?QUhKT0t2Nitsd2dBQTlMRE5iT3ppSXloVU96WUwzQjdxa0hFTWNSVElkd2hM?=
 =?utf-8?B?aHdVRkNud04rOHNMTG9FUC9jR3lVcGhka0xqRWs4YlhiQ1d3VU1venQ2Uldu?=
 =?utf-8?B?bU9KR2g2K3VUMWF5UzV1U1ZRK3hjcVRCSUF4VE84MUZzeC9Vd0JXVVhISW9M?=
 =?utf-8?B?MjRITTNZNEdORTNBRGovWmZpOGg4Yi9vWDAzemxhaE9KMGFuRWozcDJqRkZo?=
 =?utf-8?B?b1ZwUUZVS2pEMFFSVmVTaXIwZGtUS01EN1RFdkdCMWQ3YXpYaDhrZDdGUWsx?=
 =?utf-8?B?a2lSY2FUZW1MRVRKSFVHWTV2VmVLcjBxSGlMV21idnpUUDNyaTJnRTJBNXpZ?=
 =?utf-8?B?WUFaTlNmUHdRTGlDejA5R3o4Nmp4WjhLak9Pdm1LaTk0TVQrTmNzNXFBQ3J3?=
 =?utf-8?B?aGFHZlBla1B1c0xYNXpyT0NKRHlVY0hWNjZMUDVGaU5USjBkM0NHcHlERnFy?=
 =?utf-8?B?N3A3QmNzQUhBSk9QN1lXc2YrRjBnVlFTWmw3QTdnRmYzSmxvRlRTaEI3U3dU?=
 =?utf-8?B?THA2ZWhVM3RUKzBjd21sTUdXd0RTRjFiR3ZSMU5TYTFMc3hVRVY2RmRCYnAr?=
 =?utf-8?B?MXh2L0U0NzdOS1lSQjhodEtnUXR3VkRSV3psL0dHdi9kV0JnQ2lQVU1FNEpn?=
 =?utf-8?B?NUs4UkZJcGd2eTg4Vy95d3diRGZ0MDBKMktzdWFtMUpjYnJYTW9hQ2hEM1JZ?=
 =?utf-8?B?bU5uM1ZCYjNTQnZ3bjV3YXg1YitISUxEMkFobmNLY3JuOXJBaDlMbXhLRGNZ?=
 =?utf-8?Q?WdrUeR7mN3cY97WmahxQ+Elwh//Y3D7tyYVXv2L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWsxRlBDNWtFcjJvVjROanB6Z2xscDhCUzR4SUE3Vm1XNkxEU0RoSWJOT3NW?=
 =?utf-8?B?WG16MlgrT3pWNVd0WUFOWnR0d3dNRjVzdWJMaWlLa2lFU2lLU1lRdGN2T0RK?=
 =?utf-8?B?TGZjQ2RBVEFqNkIyYTRseG1zb1ZMUDRLRWVHM01YcGRHNTFBcVc0TW5OMU5l?=
 =?utf-8?B?M0ZoQ2UxanFHL1ZvQTJRN2trWlNVWGJwQjRjeU1VbVNMZyt3Tis4SzRzNERN?=
 =?utf-8?B?Q3Q5Z2I4OW82NWJOdE90MHNVQ1hWS2tSTTl2MXRPSzFhSUlNaTEvSldSNVpM?=
 =?utf-8?B?RUlybXVzTlg4V08vZEM4RW9jaWR2WnhUTWk5WTBwdnlDeHBVcWhoOG5mWEl2?=
 =?utf-8?B?TzdlSzlVcW1vS0JjS0MyaEh2RTNCYTAycXdzeVIxWTZ0NnNrQmdaTEp6UVFU?=
 =?utf-8?B?eTlEVFBUUEdRTGsyVlUrZU5vWk9UZVFDaThMay9tckVJS0M5cGlHK1RKNWg3?=
 =?utf-8?B?ZkR0UTB1VUx5NUpYcENEcWtQamg5VEp0YU1xQWJpK2JzRFVoN1dNcWZ1MER0?=
 =?utf-8?B?elJUL0w5UGZ2Q1BWRFNlT3gwSENld1ZzMXpUdm9neVVxUllmQWNzYWVXM1dT?=
 =?utf-8?B?K1MrZ0JQcWlIbVpENEdrMzdlbmd1ZzRtQ1EyRUh2MU11VlBVM2hDTml5c09r?=
 =?utf-8?B?dGRyakRmMTVDWHBldWFqeHhiUEpkSGFYWitRNjBkdWRFMlNVNm51SERwQkFX?=
 =?utf-8?B?M0NnT2kzS2hzSmZjMTU4NURnYjFacTJWZ3RpK0pzamdVN2I5ZWZvSExLd1JM?=
 =?utf-8?B?WTRUdU5JZ3hpalgrTjZCZkR6ZkJJaUFEUlY1ZzJyb091S1pDWjZNV2libUhl?=
 =?utf-8?B?MTNlUDVZZU1OWWZRcUV3RHZ1QVZadU1iMGFtejFBaGZ4MGMreklJSEFWYUVT?=
 =?utf-8?B?MWhnQ3lGWHZ4NGdRLzR0ZDM5cWFMUWtRd2o4UldpWGlpS3gyc2VjTThqQmNJ?=
 =?utf-8?B?a01oSTFiNWpNeWlCeTR1M2xwbTg3TEtZL1BvdGVWU001bGdtVUY3M1BGRGZR?=
 =?utf-8?B?NnVHTzJjdExlQXlMckJqQnk5Y1NsQ2lvS2hFUjVNRVlnMzdaZml6UnFHSktx?=
 =?utf-8?B?c0h3L1RjMkd1akkyY1NqV2U3amozR3lQbkd3K1JRL0VGalZiUXQ5SjZyUndi?=
 =?utf-8?B?RWsvakJVbjFEWSthcFN4M1orTFg4RTRaaTIxc3hKM0srdU1yQzBWelExRkFB?=
 =?utf-8?B?V1M5RVBENjBjRkdYYjlzcDRDeVE4TmpXY09BT0c3ZysrNnpXaTIreEpTMW5P?=
 =?utf-8?B?aldhNUlEM2tlaW15ejlEc3lVWStneGlKOUd2d084dFFPSkV5NTVldjltelFR?=
 =?utf-8?B?bjdWY2paVkpyUEhzOHdrbm5pQ01RMWpib24wYWtGeG1XL0tQNTRkUnh0SDd5?=
 =?utf-8?B?ano3SnUzZkNPREpZeWxJQWhVS2hsSkd3OWNZSmdJdEw1ajdGeU5qZjJPZU8v?=
 =?utf-8?B?Z2Q3NVBvb3gvYUhIbmwxVGQ3cHY2MFUzVDFUUG5hYkNSOFJhYklBd2dVSWNv?=
 =?utf-8?B?L1JJUmNFd3NGWnM2VHlXQ0dQOEx6ZUd2WUxvREh5bmdiL2dQNDluS000Z1o4?=
 =?utf-8?B?VkdOUU5kYnB2OUxsd0IxMENJTUJjOVJYeEMzYytVZExJMEUzamkyZGdMdTRE?=
 =?utf-8?B?dTBNOEpuZGFWTUhkZVdsN0FJM01oNlN6UWk2ejN1TXRaMmxWUUtEbEdUN3Qv?=
 =?utf-8?B?Uy9oNEhYb3FNbUczbmRNQkF1NzNFcUVBclhsK2JxSVgrMGIvczE2ODd6N0Qv?=
 =?utf-8?B?aTJHNHhmeHo5UCswczFWNU5hcVhsVTNjRVJ3OFpyR3A4ZVpJU2lrREQ4aGYy?=
 =?utf-8?B?TDV4YU1reDNzWDY4TzVtQWt0cDFqclJTSm1CdHNLYk9QT2RFN1F2b3BBTEpr?=
 =?utf-8?B?MllGVjg3RSt2T3VwSzFkN0kvc2tPakd6NDhsbDFhMm1Kb0dFUjFxa0FwV3l2?=
 =?utf-8?B?NHN2ODN6aEZHR0NHZFNpRVBKVUlsdWhweTcvSGo1OXRGKzRJQTdPWks1cEV3?=
 =?utf-8?B?LzJLVjZmK2k1OWVSRW9DY1dWWHRqeWM2K01hMG1XN1lrT2FoTFEwVmFlakp5?=
 =?utf-8?B?ZmlnUkpkZnpxZGxBY3dtUlI3c1FGMUxaSkxRTXNFRTBUN2k0QTZDUmRoVWlE?=
 =?utf-8?Q?u7fFVA9BJNxdHUJ25k1DnaqqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b0d616-17f5-4031-196a-08dcee9b99c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:05:25.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q04LtF92chILrkduG3OqZy/9ue/s/l04ZplVbBe2hHZpcVIE5fp19zFy+girXF3/jNMVI1Jb7PYNyy/Kxi3HGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> In preparation for support of a segmented RMP table, treat the contiguous
> RMP table as a segmented RMP table with a single segment covering all
> of memory. By treating a contiguous RMP table as a single segment, much
> of the code that initializes and accesses the RMP can be re-used.
> 
> Segmented RMP tables can have up to 512 segment entries. Each segment
> will have metadata associated with it to identify the segment location,
> the segment size, etc. The segment data and the physical address are used
> to determine the index of the segment within the table and then the RMP
> entry within the segment. For an actual segmented RMP table environment,
> much of the segment information will come from a configuration MSR. For
> the contiguous RMP, though, much of the information will be statically
> defined.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

Regards,
Nikunj

> ---
>  arch/x86/virt/svm/sev.c | 195 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 176 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 81e21d833cf0..ebfb924652f8 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/iommu.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/sev.h>
>  #include <asm/processor.h>
> @@ -74,12 +75,42 @@ struct rmpentry_raw {
>   */
>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>  
> +/*
> + * For a non-segmented RMP table, use the maximum physical addressing as the
> + * segment size in order to always arrive at index 0 in the table.
> + */
> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
> +
> +struct rmp_segment_desc {
> +	struct rmpentry_raw *rmp_entry;
> +	u64 max_index;
> +	u64 size;
> +};
> +
> +/*
> + * Segmented RMP Table support.
> + *   - The segment size is used for two purposes:
> + *     - Identify the amount of memory covered by an RMP segment
> + *     - Quickly locate an RMP segment table entry for a physical address
> + *
> + *   - The RMP segment table contains pointers to an RMP table that covers
> + *     a specific portion of memory. There can be up to 512 8-byte entries,
> + *     one pages worth.
> + */
> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
> +static unsigned int rst_max_index __ro_after_init = 512;
> +
> +static u64 rmp_segment_size_max;
> +static unsigned int rmp_segment_coverage_shift;
> +static unsigned long rmp_segment_coverage_size;
> +static unsigned long rmp_segment_coverage_mask;
> +#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
> +#define RMP_ENTRY_INDEX(x)	PHYS_PFN((x) & rmp_segment_coverage_mask)
> +
>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
>  static u64 probed_rmp_base, probed_rmp_size;
> -static struct rmpentry_raw *rmptable __ro_after_init;
> -static u64 rmptable_max_pfn __ro_after_init;
>  
>  static LIST_HEAD(snp_leaked_pages_list);
>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> @@ -185,6 +216,92 @@ static bool __init init_rmptable_bookkeeping(void)
>  	return true;
>  }
>  
> +static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
> +{
> +	struct rmp_segment_desc *desc;
> +	unsigned long rst_index;
> +	void *rmp_segment;
> +
> +	/* Validate the RMP segment size */
> +	if (segment_size > rmp_segment_size_max) {
> +		pr_err("Invalid RMP size (%#llx) for configured segment size (%#llx)\n",
> +		       segment_size, rmp_segment_size_max);
> +		return false;
> +	}
> +
> +	/* Validate the RMP segment table index */
> +	rst_index = RST_ENTRY_INDEX(pa);
> +	if (rst_index >= rst_max_index) {
> +		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#lx)\n",
> +		       pa, rmp_segment_coverage_size);
> +		return false;
> +	}
> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> +
> +	if (rmp_segment_table[rst_index]) {
> +		pr_err("RMP segment descriptor already exists at index %lu\n", rst_index);
> +		return false;
> +	}
> +
> +	/* Map the RMP entries */
> +	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
> +	if (!rmp_segment) {
> +		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
> +		       segment_pa, segment_size);
> +		return false;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	if (!desc) {
> +		memunmap(rmp_segment);
> +		return false;
> +	}
> +
> +	desc->rmp_entry = rmp_segment;
> +	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
> +	desc->size = segment_size;
> +
> +	/* Add the segment descriptor to the table */
> +	rmp_segment_table[rst_index] = desc;
> +
> +	return true;
> +}
> +
> +static void __init free_rmp_segment_table(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memunmap(desc->rmp_entry);
> +
> +		kfree(desc);
> +	}
> +
> +	free_page((unsigned long)rmp_segment_table);
> +
> +	rmp_segment_table = NULL;
> +}
> +
> +static bool __init alloc_rmp_segment_table(void)
> +{
> +	struct page *page;
> +
> +	/* Allocate the table used to index into the RMP segments */
> +	page = alloc_page(__GFP_ZERO);
> +	if (!page)
> +		return false;
> +
> +	rmp_segment_table = page_address(page);
> +
> +	return true;
> +}
> +
>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -192,8 +309,8 @@ static bool __init init_rmptable_bookkeeping(void)
>   */
>  static int __init snp_rmptable_init(void)
>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
> -	void *rmptable_start;
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
> +	unsigned int i;
>  
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		return 0;
> @@ -222,17 +339,18 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> +	if (!alloc_rmp_segment_table())
> +		goto nosnp;
> +
>  	/* Map only the RMP entries */
> -	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> -				  MEMREMAP_WB);
> -	if (!rmptable_start) {
> -		pr_err("Failed to map RMP table\n");
> +	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +
> +	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
> -	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -243,12 +361,20 @@ static int __init snp_rmptable_init(void)
>  
>  	/* Zero out the RMP bookkeeping area */
>  	if (!init_rmptable_bookkeeping()) {
> -		memunmap(rmptable_start);
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
>  	/* Zero out the RMP entries */
> -	memset(rmptable_start, 0, rmptable_size);
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memset(desc->rmp_entry, 0, desc->size);
> +	}
>  
>  	/* Flush the caches to ensure that data is written before SNP is enabled. */
>  	wbinvd_on_all_cpus();
> @@ -259,9 +385,6 @@ static int __init snp_rmptable_init(void)
>  	on_each_cpu(snp_enable, NULL, 1);
>  
>  skip_enable:
> -	rmptable = (struct rmpentry_raw *)rmptable_start;
> -	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
> -
>  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
>  
>  	/*
> @@ -282,6 +405,17 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> +static void set_rmp_segment_info(unsigned int segment_shift)
> +{
> +	rmp_segment_coverage_shift = segment_shift;
> +	rmp_segment_coverage_size  = 1UL << rmp_segment_coverage_shift;
> +	rmp_segment_coverage_mask  = rmp_segment_coverage_size - 1;
> +
> +	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
> +	rmp_segment_size_max = PHYS_PFN(rmp_segment_coverage_size);
> +	rmp_segment_size_max <<= 4;
> +}
> +
>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>  
>  bool snp_probe_rmptable_info(void)
> @@ -303,6 +437,11 @@ bool snp_probe_rmptable_info(void)
>  
>  	rmp_sz = rmp_end - rmp_base + 1;
>  
> +	/* Treat the contiguous RMP table as a single segment */
> +	rst_max_index = 1;
> +
> +	set_rmp_segment_info(RMPTABLE_NON_SEGMENTED_SHIFT);
> +
>  	probed_rmp_base = rmp_base;
>  	probed_rmp_size = rmp_sz;
>  
> @@ -314,13 +453,31 @@ bool snp_probe_rmptable_info(void)
>  
>  static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
>  {
> -	if (!rmptable)
> +	struct rmp_segment_desc *desc;
> +	unsigned long rst_index;
> +	unsigned long paddr;
> +	u64 segment_index;
> +
> +	if (!rmp_segment_table)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (unlikely(pfn > rmptable_max_pfn))
> +	paddr = pfn << PAGE_SHIFT;
> +
> +	rst_index = RST_ENTRY_INDEX(paddr);
> +	if (unlikely(rst_index >= rst_max_index))
> +		return ERR_PTR(-EFAULT);
> +	rst_index = array_index_nospec(rst_index, rst_max_index);
> +
> +	desc = rmp_segment_table[rst_index];
> +	if (unlikely(!desc))
>  		return ERR_PTR(-EFAULT);
>  
> -	return rmptable + pfn;
> +	segment_index = RMP_ENTRY_INDEX(paddr);
> +	if (unlikely(segment_index >= desc->max_index))
> +		return ERR_PTR(-EFAULT);
> +	segment_index = array_index_nospec(segment_index, desc->max_index);
> +
> +	return desc->rmp_entry + segment_index;
>  }
>  
>  static int get_rmpentry(u64 pfn, struct rmpentry *entry)


