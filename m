Return-Path: <linux-kernel+bounces-262736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAF93CBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647661F2215E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA73A34;
	Fri, 26 Jul 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUBLcOqR"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97163C;
	Fri, 26 Jul 2024 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953029; cv=fail; b=bGr8QtRYhf+Wc0hlAIg1AAgiKGF5iuBL2iW9eIZnReISS+L4A2mGoiy6GRQNlFGHD53semKZB2i/x33wXw5IubpZ47w2hViMRX5ClmTnnsi7+y+HELlH2b+VsazBAZSrfR2k7+xExrNzJ40aHivnIvqmaBdz8/d6IVoIS6Da3Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953029; c=relaxed/simple;
	bh=R52pi5tjkcJIF7wa4TBbqPYGel4oDa97NTfAbG28zV8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPh62v0S8PHLiwEXs4pWMXxwS/6TJaENBIe3pf77bt/bSQ/cezjIaAAgoJ4dTPfvsz3BLbhj4C5LcRKbc+Iy1bmeeXdGsLb472cwOCawBytfRs/dPWHWrVD6Mrh4DbG+epXcx9uWggU0NI7FWZfghDAfA75S2nP0+0ENIvBuOwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUBLcOqR; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6C2ejA72up5kZ/9Rsg7I725kjnfhQZwrQf8Z1DLA0NEFFTwr6WGxFD9uDbPSmHp5kP+xqXsnbW6S8Ft8+PrCxXFZWufvH1Q+eKFmXp8PEFB+5hFbnIf7bnZeNtjaFaom9pUjVDmv3WzLWwTAOfBZr/APA87vpUIh5r2vAwRcaFNcuFlT80FXcU3HReCcnfHIi1u55fUlQEyIOb6g/OMsQZGpWZpfCeaI3+KeGeHy+OX8GfEt7ynYAXna2bt6/k75dTBowCZvOEQlxMJutqdatSBXeZf+wr8KBskY9zkppGjL+3syitvVDeE8DIZDAYmLk/SBqFblEH/WmPZ1w85lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxZHEwtqBxMOKn2tzDExjR7PXJba2n+ti6QgQ4LNngA=;
 b=WfYpCbXgN5SERHvXWGIuv65/28ji9tSTKdCL0+NrKxR3Tm2QkLEVCxFyBADUX5l3EfR9EJasGJzX1gLRSJ4rlvkDrb04CJiKuL0kmuq91MohhDjlpj/ayWowGJHYuQO1dEgfpEd6S4ZGXG0J4U8ChCGEiTLL/OSqkV31vgZfbL27s+3ZjLY0TgjfBOxIkbxfHeD+1lkFRQTfITeunq+EuDfajdNdv2ubDCDQuqzvM6oNYL77IuQL1+m4BGuMIVjgV7NHjootOshZGqO1kmWlJTBZzsvwv3CleuO0fbeMqzuZiMtJR7PxEWmMjjG+qNnc9mIbHo8Xpunv8U3EvUodbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxZHEwtqBxMOKn2tzDExjR7PXJba2n+ti6QgQ4LNngA=;
 b=kUBLcOqR3RbCxct6wXh5ecC6eOJN0ntWG/AQcDebpgN5ixRWqaQ+ss1lxbPBM/MGH86fzvQFIbhvNzEBoD1ErAILtNgldfCV8Q1Cs2zEmmCjpq++xnnZZAaeLMFFg0G/UElioILvoXpH4SJ2BizwIp3r7Pognyy2k79ZLAhTbk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 26 Jul
 2024 00:17:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%7]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 00:17:02 +0000
Message-ID: <9f46a7c1-818b-8847-1676-a86a31feedae@amd.com>
Date: Thu, 25 Jul 2024 19:16:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 18/20] x86/resctrl: Enable AMD ABMC feature by default
 when supported
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
 <d9de1a56-8b0c-484e-bf44-69891a2e9894@intel.com>
 <eb7f2b83-8d2a-753e-b7ab-9b004af2592d@amd.com>
In-Reply-To: <eb7f2b83-8d2a-753e-b7ab-9b004af2592d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a7ed4f-7a12-4c89-d18b-08dcad0845af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBVY1VsdkdWWHVkUkJiUDdWVnJBYWZoWXVJRjk1Uys1MERZUXhiZkZpWVpO?=
 =?utf-8?B?VDVSU2lYUnZTR1lnWENKdlVDb1pzR1UvSnFmQmZtNHM0OHNZZmpqVTV3SXNO?=
 =?utf-8?B?OXlObHlNbUx1Y2tnN1YvdlJ4NjRLc0g2QklCOVdWWTJidFhHVjh4clQ2eDRm?=
 =?utf-8?B?R3Z6RHNQa2k1SnNIUFlUL3E3Z3ZDUXF1c1p5d3kxQUNIZmZTcjhqaUdkOFpq?=
 =?utf-8?B?eVE0UXJtK3J6U3F1eW5XbGVuUGZ0NzkvbTJEWVQ4bWRSUHRxTldVbG9wMnFB?=
 =?utf-8?B?OHk2M2txTGl4OUdEVHFESDNaZjNyU3EwQnI1MDBVR3VuTEZwQ0UwdC95Zitw?=
 =?utf-8?B?SGVVaU01Vmg0aytpSmVPR1ZxR2h5U2ZxdjA1THliZXgzUHJtY1VSYzNXNjh2?=
 =?utf-8?B?VytqMUFSUURGeDA2YmVqbzFwZXZCMGRvQS9tcWhEcnhhbXk3b0EwQ09Dd24z?=
 =?utf-8?B?akEwOXpIcDZRU3g1RTFhN0FudmFXdklYdW0rTGJYQUswZjVOdnhNT1kwSkpQ?=
 =?utf-8?B?K0N3QWVOUnBvM3NXUFVUQ2RPRVRaa21JLzR0bkdJTW51WFhCbkZFR1R2K2dh?=
 =?utf-8?B?ZUMrelBaQVhnWXB4SjZBcnI4VTN4a0NSSW9YMXhjeWJhazNpMDVHR3VVN2FH?=
 =?utf-8?B?NFB5K1N6aml6WlZkYWJadWNFanZiR2VzelpkSmtaM3M3S2Z5Smh1Mi91UEx5?=
 =?utf-8?B?UXZteWtqa2x3bWJLMzVUcVJrd3VGU3lMUmpLcFVnQmU1MlZiV1Byd3ZnQTgr?=
 =?utf-8?B?czBMekhaMGJTamZHOGt1UFpPNzBxaTZZWS9nM2ZNME5vdnVzdnZIU1FabU4v?=
 =?utf-8?B?V3hqQUVFNndiZnhIUVpIMWc5S3dnaU53K1BhMVpacGZOT0VUMTZUejg3M3dO?=
 =?utf-8?B?UXdhSXpOOW80OGdaL1R4Z0l0eTFIT1Y3d3ZJSHViY0hyV1RicXMxVWpicDl5?=
 =?utf-8?B?bWQwWDZIODhaOXNBM2N0eUpPWnFoNEJ4MzJPSXhXanZjYTQ2bVhrb3pyZ2hF?=
 =?utf-8?B?OVJFQ0FDeXp0QjFOL3RPOWt0N3NESzhCNjhlbWFkUEt3QmpzV2pvcXNOTWg2?=
 =?utf-8?B?d0t5djdYMHNKVnRNSnREcEJtMU9vOVJLZEtER3JUMUNRUXN2Wml2NGw0Zmx0?=
 =?utf-8?B?bE1URjc4Um14azNnVGxpZDc3ZVlDZ0U3ZStVUUp2cDlqZlBnR0dodlhvQjBB?=
 =?utf-8?B?R2pqdXNFK3FRc1g1MGtSNlFwM3hyZDJvQnFFWDRtVDMrY0Fsd2xORjRuZUk0?=
 =?utf-8?B?eGRSa3kxKzkxQ3VxaEc4R3N3d2ZpRWlseUVVOUFCUVpaY3greDVJRGVQT2c4?=
 =?utf-8?B?OEhzQXFUNWRCQjdiNTE3QXg4Ui8wMFlVejJUUFBLZVpKQ3JVdnIzMlMzb1V6?=
 =?utf-8?B?d2RxcTNHWE9pQlRlOFUzbWtoRHpzUFhjK25raVJLcDJ5clVCVytXbS91M0Zs?=
 =?utf-8?B?V3hQYzVENy9ob1FKa3pIMW1lYUVmazRvMUJNSEs4SXlqQms0NkU2SXBLM1BF?=
 =?utf-8?B?ZldtdUVaV1YwWjZtd3FzWndyUTFTQ3JyR0tvSmJ6Uk5ucnlkZWp2Qjk5Slpv?=
 =?utf-8?B?NzEzWWM5NDBzbGZWSW53dDRYRXBxZ25TV1Yycjc1NjQ3ZXk2anhDaEhSVUJC?=
 =?utf-8?B?MDMxZktCMHo3UCtCUEhMMnVOTHI2M0VTOC9IcXdlWlF1b2VILzNtSTk4UnhT?=
 =?utf-8?B?REJrcXhxc2NobTByZXZMY2RwV0hCSjhIVk9EdDB3azVtejQyc2tpZ0srVy8z?=
 =?utf-8?B?UlRTT21UZnF6TlltdXhRM3lYK0JEemIwR2Y4Qy9NMUdmM1VZVldCUU05aUcv?=
 =?utf-8?B?WXp5Tk5YSFlPVkoxVXBYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStJbmphMFd4SUhFaE5jdHk0TGk1N2RCY1ozMWQ3bUt2N0ROb3hnVytTaUxT?=
 =?utf-8?B?a0VMeWNIc0NqTFVnT3FoR280WGdxblNHL3pTcDB6MVdocldyU2FybjhDaW5n?=
 =?utf-8?B?U2RELy9La3EzVzloU2pxYjhIL1hDcm1uSXNaMnJaWWJnYitZNU1pTHgvZmh1?=
 =?utf-8?B?Y3k4QjZZZVluMlM0K2NnTm00enNIdlEzTERROUdhN2ViRlBwaGVnamVwTGdK?=
 =?utf-8?B?ejBVNXlVNXdaNU00LzlRWjRGd1FXc2ZmR1Rxa0NXVitkR1dmeVJTRWNGVGRm?=
 =?utf-8?B?QXQ0UG9uUXlmZHJQbmNNMEdHQVdzUHdYMTVKSXplWXhsbGttaWhscE5sRGw3?=
 =?utf-8?B?ekwrVUZFcnpCS0ZPQTNiYTlZY3RYSXVXUFMrcXB1TTVyVGJqUGpRSlpQanZB?=
 =?utf-8?B?QU5NMjZjK0dIQXpRL2FoZzVxdVJydVIxaExJc3ZTcCtrZEYrVWNseS9VNVFZ?=
 =?utf-8?B?cUk2R0I3M2l5b2dKQ2xScStYdnhMQ1dSZ3NLVGtiZHRwYlN3VXUzUE5PQ2dV?=
 =?utf-8?B?cWk3aUcxSTFNTkRCYzhVZkg5bEs3amh4RjYzVDVyTG5IYmE2RDJESDZYeEhj?=
 =?utf-8?B?WjhkNFg0TDRkOFNPMnVKM3NvdFZMVEdNOXlZcVVycVBidkYrNmJMSk9iZmxk?=
 =?utf-8?B?NkFQeUwrUkJ3ZjYyYUVGaTI1QUlGRTZDRmh5UGZQNnNZNVJiNVVOTCtwMjNI?=
 =?utf-8?B?ZC9WVUdPbjVWeFdPRVVQTDZyVGNyNWJzMUFBZ2ZCNzFqakREOFcxMHFHcXBJ?=
 =?utf-8?B?MlVoR0tMUjhra3dOYjBzZWZiNjBiekJxQ29JeGN6UmNqVjlLM0FkQmdGeFZq?=
 =?utf-8?B?MUh1LzVWMXdZSkNRUm9OZWFRTUQ2WEdUdnZPWWZsK3FUR3JCamc0bld4blFF?=
 =?utf-8?B?bzlmckc3eXJPZm1pS2FBSXpTYy9aSXJjTXRLeVl1VEU4U3FwY3RCa2tQZUo0?=
 =?utf-8?B?WXlLOUNWd0dLVE04UVV5bHA1Q29NU2prKzBsOGN6cnlKeTBwbWVETWw0VVda?=
 =?utf-8?B?S2J6Nmc0bnF1bXZ3NzM5WGVNMVZhQkhSMzV2bkdsSndmVmJuYzVqVHY0bHNX?=
 =?utf-8?B?dkNDS2FYTEhOSlZSTUpSNjJIL2JzTHkyeWROaUtsd0t1TG42R0ozWkdHTUlP?=
 =?utf-8?B?TG1nNXJYMUEzZllaRllIYXgxN0Q1b2lIWkFqa0NucmtsOTNWRkZKSUxTbmdy?=
 =?utf-8?B?ZGpvY2lEeUlrUUh1THNlWHFZamxCeW01Qnd4emdmQmUyUEg5WTdxeWx5SUh2?=
 =?utf-8?B?cWYxVy9DOUpkdk95TVl0WkpNNjROZGpMSFRaZlZSSUVmVXhNU2dFY1hpZ1o4?=
 =?utf-8?B?UWdTazdKZTl3NFhqZWpJTVpWNFZUYjE5SE9ZK0tnQjk5NjE3VkpZUUduQ1ht?=
 =?utf-8?B?TFE2NE1peE5XWkZvYyszZlI3dis4MUxyQ01FdWQ0OE02SGdLUEE3WXRxcjVu?=
 =?utf-8?B?NFV1a0x3OHV3aWRVNmJrNmMyaEI4b2pBR0sxVUxMUXpScFJidktUY3NIOVh6?=
 =?utf-8?B?Vmc3YUY3TEF4dDhucHN0WFl4Wjhja3N3QXFvelVsMXgrNzRzVm9JUzNRNHFU?=
 =?utf-8?B?eldIZGg3aVltdnZxU2dzSEMya2NWdTJDWHdtMDBmclZVdEFNYkRqbS9ZZWNz?=
 =?utf-8?B?eGc3dVhqbCtZcnFsMFRxQk5wOU9ZS2ZwTVArbzhBYUJObSthNUNrMFRCWW4v?=
 =?utf-8?B?NHNlZHFHMUs2NjVzblNOaEU3VklxZTNqZDlkTTN5YWIwVEF3VHFoZHRTbXpG?=
 =?utf-8?B?VmYzRTR2RWNMZlpBYkJXWDJ6RE1DdzJ1TkVqUVg0c3htSWF6YkdiSEswMUdL?=
 =?utf-8?B?SVhyU3RFbXRCNUNZQkNoRjlYdHUwVkVwQUszY1ZmOEVwZklMY1FrZmJBenVz?=
 =?utf-8?B?ZFNTM2UySDFOMzk1NGJzN2JibEJWUTUrU1BKLzc5YW5LcThJcGd6SjgvbkhW?=
 =?utf-8?B?UTlWVFJzYVIzbjFkMkp1OVE5YVoxTjRDdDA5azhFV1MrQmFGNGZDTmVwckdq?=
 =?utf-8?B?My9yZmZhdVBuY0ltaGV1R0pRdmMwTXoyeWhpWGFpN1pQcDUwdThPSnBsYld5?=
 =?utf-8?B?VlVmaGtobXM5Q2NZeDhSQ1JDME9GUWUxRmROb09iSUxkQmd1SGRsRHhpQ04y?=
 =?utf-8?Q?Ukpg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a7ed4f-7a12-4c89-d18b-08dcad0845af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 00:17:02.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1tNB1CSJPGpxEK+DUZU2zHx3hRQpSarMi9x7w2nMNdlHn4RmY+LQEL/omG4Qccq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Hi Reinette,

On 7/16/2024 6:23 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/12/2024 5:15 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>> Enable ABMC by default when supported during the boot up.
>>>
>>> Users will not see any difference in the behavior when resctrl is
>>> mounted. With automatic assignment everything will work as running
>>> in the legacy monitor mode.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v5: New patch to enable ABMC by default.
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>>>   3 files changed, 20 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c 
>>> b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 6265ef8b610f..b69b2650bde3 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct 
>>> rdt_resource *r)
>>>           d = container_of(hdr, struct rdt_mon_domain, hdr);
>>>           cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>>> +        resctrl_arch_configure_abmc();
>>>           return;
>>>       }
>>> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct 
>>> rdt_resource *r)
>>>       arch_mon_domain_online(r, d);
>>>       resctrl_arch_mbm_evt_config(hw_dom);
>>> +    resctrl_arch_configure_abmc();
>>>       if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>>           mon_domain_free(hw_dom);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index beb005775fe4..0f858cff8ab1 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -707,6 +707,7 @@ void rdt_domain_reconfigure_cdp(struct 
>>> rdt_resource *r);
>>>   void __init resctrl_file_fflags_init(const char *config,
>>>                        unsigned long fflags);
>>>   void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
>>> +void resctrl_arch_configure_abmc(void);
>>>   unsigned int mon_event_config_index_get(u32 evtid);
>>>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, 
>>> u32 rmid,
>>>                    u32 cntr_id, u32 closid, bool enable);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 531233779f8d..d978668c8865 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2733,6 +2733,23 @@ void resctrl_arch_abmc_disable(void)
>>>       }
>>>   }
>>> +void resctrl_arch_configure_abmc(void)
>>> +{
>>> +    struct rdt_resource *r = 
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>> +    bool enable = true;
>>> +
>>> +    mutex_lock(&rdtgroup_mutex);
>>> +
>>> +    if (r->mon.abmc_capable) {
>>> +        if (!hw_res->abmc_enabled)
>>> +            hw_res->abmc_enabled = true;
>>> +        resctrl_abmc_set_one_amd(&enable);
>>> +    }
>>
>> This does not look right. It is not architecture code that needs to
>> decide if this feature is enabled or not, right? The feature is enabled
>> via fs (for example when user writes to mbm_mode). If the default is
>> enabled then it should be set by fs. resctrl_arch_configure_abmc()
>> then checks if feature is capable and enabled before it configures
>> it on the CPU.

Looking at the code again, I think it is fine to do it here. This is 
arch initialization code. I am checking if the feature is available and 
enable it by default. The fs code is not initialized yet at this stage.

Other option is to move everything to rdt_enable_ctx which is during the 
mount time.

I will keep it as is now. We can discuss more on this in v6.

> 
> That is correct. But this is a default setting should be done during the 
> initialization. This is like rdtgroup_setup_default(). I can move this 
> inside rdtgroup_init(void). I will have to change few things make sure 
> arch and fs code separate (like accessing abmc_enabled).
> Thanks
> - Babu Moger
> 

-- 
- Babu Moger

