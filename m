Return-Path: <linux-kernel+bounces-336069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17ED97EEC1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D422A1C20A24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F15E77107;
	Mon, 23 Sep 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eW6Cxc+L"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F146B5;
	Mon, 23 Sep 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107283; cv=fail; b=aVcL4EQstgY2QSNkgFIavBkhK1LAUDIrGWdKOtQatjKvu/ef+davKBv/o0SdBOt0uvKOc0ZetXFi9LbXSbTShiprksGYDfXOJAz+l9XABLj7p/UwZzu2gWI6uwrdUf++orK1Y6KzJ66gU4JX/GqGFHcfn+A3rPaau5eNMmhSvrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107283; c=relaxed/simple;
	bh=M6chUrbJ0I80XXk81R8H2hfzGmLKuMnIDo4qXprLs0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovIPFVdjuFgVHJRUyU1dBHEv5ItC9/obqFjLgXRU+J6vFd0MqyulJd4eRet4m+wGlagHRcTStvUVRQAm7p19PvMnGXU0WG7Sd4xnftWUy0RxyXB7Rre7aEVxOScagQ2nTG0ROpMQmHRxKqdJxCn3jDCefOE64jhywBJomV27v70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eW6Cxc+L; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqA4ktGq+hmc9MEQns4BhPKRpHUvqaphwKXN4BZMGOkafuwvC/U8mI/KwN3D4MOct0N+ucSOvmn7UWusIZj8iwjtXeMRfmTtOLOv4pgX8JiBhQ7uRryRMIgpoLkVdNvqvulKv/iQjIfZcs7KKpATbc/5EtxeHM8MD8JaCl8SpMXgzYMozZpZZs0eXF9JtN+LJ4qCyw1tUsbBdZJQtTLm14ZIyQJMkSvPogayGbCa4IdQYOX3hSn9O5xkEDX0z4K7UHpoYwr4wZGznC3Y92RLmN7X79CK0dgTMOR3CHZ6IecaYoFRuiFV6+iIfFJr7QpPvko2NfiH2Xvf8d8gt0JdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkC34kir9IqmnBouDkLYy6hPG4R2NUzHyMH4KJ54pKk=;
 b=kvhbYHy8JsO7dDjs4/IxckoioYkz8C/0OT8uZzBhAe3OToAptdpU/3W+uJnnQzuPME86IEQ/AEwTQ9/DgafBTpSASH+9Z/JQXKE0ViuBu18b9SiGDabtyk/ttMB6+BIxkAfQFAFCZ/TLUgUDNbHrEa1OmaBt7LufYNLf75b8a3OSL7YjbfnliA2X7z8v+xsk5O7Xmsbz3GDH3mZPg1MkacTM0ToFeBHkpWXOc9Mr6n53aKbEeyU3HKdfj+5DG5q981cwO1NS7xZhsNX8OIZXYlauovmrs7hehmtjI8/RLRGuA9SgKiJPP5Eb4X4PUDrB05h1jhJfwRjO1fZd9rchOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkC34kir9IqmnBouDkLYy6hPG4R2NUzHyMH4KJ54pKk=;
 b=eW6Cxc+LagyJiJ9xpKUzl44vtZqbJrmtz7v5xgquSm1hB6kIRA57JVVZusAEDAtWDA+q1ocFo8n/WyoKrbw4+dMPPfLvBSTvG+O3uL5woJfEimgkEaMzbsXp+CUYmf2HeW/SjjT1gjS2XiliQFYie55yMkNbL0xkmDGWFn58cRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:01:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:01:17 +0000
Message-ID: <efdc414d-cfe1-4e95-a5ad-179fcce1bd25@amd.com>
Date: Mon, 23 Sep 2024 11:01:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 07/24] x86/resctrl: Introduce the interface to display
 monitor mode
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <e3ff30d647ab9bc452c882ce1dfb366eabb0cc25.1725488488.git.babu.moger@amd.com>
 <e848662b-23ee-4c3c-a848-976f944e8927@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e848662b-23ee-4c3c-a848-976f944e8927@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfbf091-6009-40d5-bfe6-08dcdbe8f565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHJOK0hCRklvb2luMG1FMFkvZksyNUFNUG5NRXI1NEZ2S0FxUW1zRHFIQ1lZ?=
 =?utf-8?B?Wk1IOXNpdkRGa2NnRGkwTXlCUmxsZUdsbXgrT2lGR1hLNUxzR2VOcFBzM2Q0?=
 =?utf-8?B?WGc4aTEwT0xGcEFaczd6ZjVLSTd4YkV3NzBVbVgyRlI1dTVPM3daYmI0Vjdw?=
 =?utf-8?B?ZExyZUFaQXRvTzN6eGhXYXBTQ1l2bzdGTTFJYjU1bThuY2R5dFN3cjNobTBn?=
 =?utf-8?B?enJBZU9HZWo1WDlrVUU5V25nbEdoalBpdm1Eei8wa3NtK1BhaFJqdzJZNEFI?=
 =?utf-8?B?RkNpbnplN2Q3Ulc0ZlNRa012MHRjRGtIWEt0a1NReHFodUtPeGJ2VnIzdGN4?=
 =?utf-8?B?N2VWS2VJMG81Sk5wTzAvUEFDZVFBTzhJeTQzS1NQNld0MmVVZWx1T2JQOGhR?=
 =?utf-8?B?NDdYRFVLWjJIVjdTZE9yd2x5VDVKUEN5UUszNC9Zc0pHN0FEWXR1T00zbGpP?=
 =?utf-8?B?TDdmRDI3NUxPMTl6M0E5VUNkZGdiSDJOOGNVTnRNbHg3bGxkMEhyUVMvRlR0?=
 =?utf-8?B?R0MybEc5L0FhSVp5TzJWQ2NmdkJLcEVZcndhTnU0R1VaNVAySEhZNGdLVWRo?=
 =?utf-8?B?a014K0R2ZHlqMTZ1YWNxUW5hdXp6Q2JLbSsvNER2TGNtR3VTK3VtYlU0QWJ4?=
 =?utf-8?B?SDdSMDU2TWxLZ3o2ckI4Z1FBaGZKYUd1cFlLa0Uxd2VjSWEwNERvZmNSUEpQ?=
 =?utf-8?B?bDFaYm5KUkY1ZmhwelA4aDBwYlFsRkp1MllybENVVWZobGVSOE5XaGJoWDNR?=
 =?utf-8?B?LzlNTitvUUdVUkVUR2tTWXQ5dWkzSDZ0Q2cvWWxxYkJHNWlhKzlZK1VBMTNP?=
 =?utf-8?B?TFZXSW9MN1VNY1JsSXpwMDJJLzZpaDBmbjFwODk0RFFHeFZBQmtwZ1craUZD?=
 =?utf-8?B?dEp2ZWlHK0JUbkdObDhGUzZVeHo0VUNqUnlqV0pTQXY3NkY1dktCRnRCUUo2?=
 =?utf-8?B?VmlKNEk5MlFZeTUzQ2VCVzJTS3haS21EQnN3N2pLMVZMRStCS2xlSDdETUM4?=
 =?utf-8?B?TmFadVZkcVp1c1hza1VIaHFQZ0c0ZHN5OGxWWThibGNhd3pyOUdMTzdSRTdx?=
 =?utf-8?B?UkluUDFJaGR6c3Qwak9aaG1yWTZjalVTKzJwVWhWdTBRQnZKbXlGVGxmZXgz?=
 =?utf-8?B?Z1hZQlJKVmxza29WSVpBaks1cFBVK04yNjFtS1NIOE5Ba2JlTnpSQVF1KzVi?=
 =?utf-8?B?aXNxV1VRVFZCUStJOXhBZVhNMHhPUFZYNHRRM043c3FHYjVNZ2cxcFNuRHpG?=
 =?utf-8?B?NS83T3pvUWpyRTFjQUNWNWdvZUs2dGdBSE1DeFpNRGRSeWs2SElPRitXaHht?=
 =?utf-8?B?KzFPT2txKzF0a0ZQNDlZN25SYzltd0Qyb3ZYOWxZQ1dDOGd5NS8vdDVpYTFH?=
 =?utf-8?B?VENKZFdYSVJEeTd5WFAwRzY4R2JENXRNUUNUcjdMM010SHdRUTZlSXBTRU1m?=
 =?utf-8?B?S1kyRUticTBYc3VuZCtGbHk0byszcEx5Y1ZIOWJxdXNHTWtEdWp4Q1c1bklB?=
 =?utf-8?B?bEc0LzF3R2hndzhheDdLbGwvRUJHYmdPQllXaVNrUnhqdFdJdUQwbUd1SmE1?=
 =?utf-8?B?a0pZUWJ4dWg0NU9BbkhybTk2a3h3Y1J3NHdvUjl1S0gybVcyTmdwekdTSHVK?=
 =?utf-8?B?K0h2OUtnMlpqTnk5M3dlLzV1TDZJV3Z1TFBvb0Y4Q3cxZVpuY0pXY3ZpcGZX?=
 =?utf-8?B?YWl5RTRGcXZJZWJQUHZVanA5S0pyUklmRitTMGhma3JxYTdQTFFKVFN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGhndFBOc0dsbnZmVHVES2EvdzFibmhXTlg2K1BUa21FaHJ2ckdKdy95V28w?=
 =?utf-8?B?QWpqNncrSTh1TitUZHZzNkZHd0VGUUZkNkpOdE9ZbmVxY0w5WnpqNWhIU2FK?=
 =?utf-8?B?N3VYenlwOHFoUEZ2Wk9za3YvZUhNUXlBR01kTUR4YUNMekhUNjA5dEN3UnRY?=
 =?utf-8?B?TXc2aExpY2pjMFFZNzZMcE1KUDAzVTdXUXlEQXVrWHYxN28ram4yNVlSTExB?=
 =?utf-8?B?RGNxanRZZkRMQjlTelNmUlN3RVZnZDFWMFZDZUlyWlRsNThCVEVmTGpSZ2RV?=
 =?utf-8?B?MEZER2gyWEh4RG40OWsyRTVHR3ZZd29zL2FTUHMxZ2paQUhyOUpwT1NJNndr?=
 =?utf-8?B?d2lldmZUcytVTXNJWktqWEYvWU0wNkJQSXNaandFOUlGc1V6cGxpWU9uRTB2?=
 =?utf-8?B?WjRrMHdqYktWNTQrUDdPMHIvblB0K0Y0WFYrSld0dGVHbVBwaEhWbGo3Ky9Q?=
 =?utf-8?B?Z1B5L0RYUW0zWWU0d1o3bjhZdnBiOXl5TkdCek80SHZZZzJvbGNJYVhFeFVG?=
 =?utf-8?B?RndCVjM5ckkxaHFmU1ZuRlZ4TFQyeW8wakxDZHd3bUhmM1NRVVZUc0craG54?=
 =?utf-8?B?REQzYTllcnIzSHh2WHdkTUI2Visra0dxY1dhcXBJMmp5S3NLS2gwRlc1YzJJ?=
 =?utf-8?B?YTFIMXpETjM1ajVyRnpDbkFWaHRGM2FnYzFLVzlPc2FkaDI4b2JMb3cvTC9t?=
 =?utf-8?B?TWFsbHpGSHI2ZXR1R2F6OFIzclRpa1oyblVRbHVwWUphVVVLK3V6NXVjV21U?=
 =?utf-8?B?cFA5OFYzQk5mZzFEM21TRWRjL1djOUtVbXMrRmZXVmhrNkdqakFkclRQY1ZP?=
 =?utf-8?B?WmZCbTlwcU9GRTZRUitiUGlxbW9pQWRIR3BKL2pWWXJZRzZEbHNncHZ6WEM0?=
 =?utf-8?B?TXZ0N1NaT1RkdzMyYnYwQ2FwUjJ5T2U2b3VXWXJrell2QVVkQXl6bmF4V1ht?=
 =?utf-8?B?bWtSK0IzdlBnUUJtclpMNm9Yemk4VWFuMHJ0aTkreFZaeHA4eDRjMjBBcnZi?=
 =?utf-8?B?NW5GZjR6WWc5T093c2dNQU52dlh4UEpNWFd2ZGxOdXcwL0hHbW9kRHhCNzB0?=
 =?utf-8?B?aWZRNm1kSFdhcitRYWQ2YXRvMlcxOW9KOVppWVpYRWhOR0ZQekJVZGJSdjFT?=
 =?utf-8?B?ZVg1WWxndXd1RXdhRzMyVmRXYXlnblh0THYrN3pJQVdTanR3azQrNHpRVnlQ?=
 =?utf-8?B?M3NZR1VzS2tOcmd0bGM2UVhONzJmZHdnK0VyZjFEWFRMMzk4d1JoN1hpV2Zw?=
 =?utf-8?B?UlU3Q01ra3ZvUE9CYzJITU1VRkYwTlRxbGltOGVQbGJ6ZWlGOFJQZFYzZ3Av?=
 =?utf-8?B?MUt3QTNkQUdGaUUyWjhMZ0tzQTBPRVZORnJIUklrN1NYSjVFdlpyT0sySXI1?=
 =?utf-8?B?Q3hyTS9rWVhOSzJla1kxQW9TampWdTh1dlc4eTgxWTNUb0NnN2tCVWRHK1hQ?=
 =?utf-8?B?b1lUbzI2cjZ3YXA3SVhDVFhJL0N5cHhxK0lYbHhpdVF2eDZKZGJhYmx3UnRO?=
 =?utf-8?B?Vm12bDl3VDRYL1NSQVYvTWFuSytaU2JtSGp5UlJ1ODY1QXp5cVRVM3lnTW52?=
 =?utf-8?B?RS8yQ0N5WjcwQ1JKbjFKOXhMaEFFK1l6NERJUDZTVzJIN2NUcXA1YTJCWnky?=
 =?utf-8?B?VkNnWVJMdk9EK2dwczZRSDIwdUJxNkVEWGVGQWliditUVkRmdnJUaGQwbUVj?=
 =?utf-8?B?SHZjS0ZnZWFzSmhKbTNxb3VhRW5IY09oMmM3MFREM3A5YnhSd21seGJ2cGVR?=
 =?utf-8?B?bHJDbUdzN2l0VGw1RC84YTlHMVp1U1RQWjNXOHFhNy8vZFVabmlXQURPSkt6?=
 =?utf-8?B?TkFnNnRhUWlJZlFJNi9pUWFFTkc0dk9HR3lDbHg4aXdNdHJTblRKRmV3RzlZ?=
 =?utf-8?B?c01NYTZvOUxNSEZMMGo0UXMxT29kazNDU2ZVbm9XRWxJMUI2M1Fob2RoNTdu?=
 =?utf-8?B?SHo4aW9PTWw5ZTRsQm5neUF2V0hleVNCVlFCQnF2YU5UZWFQb0psWTdNUERl?=
 =?utf-8?B?V1JMWk53WTdnempLamw2c0hIUGNzMDA4VkRFNW1BNlE3cjBsd3RiblBPUTY0?=
 =?utf-8?B?cnJPSFlpeXZhS0tlM3BaVGpHZlN5UEF3K3hzZGhqVngxZXh0dnBXZHh6amU5?=
 =?utf-8?Q?+2hI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfbf091-6009-40d5-bfe6-08dcdbe8f565
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:01:17.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 204//917vB8vbC+Hg2hTiYeARv5Xl4D0hnraDpTLo/YLa76J0GMO8CO/dZKoYwFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

Hi Reinette,

On 9/19/24 11:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>> supported.
>>
>> The "mbm_cntr_assign" mode provides the option to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>>
>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>> Bandwidth Monitoring Counters) hardware feature. "mbm_cntr_assign" mode
>> is enabled by default when supported.
> 
> As I understand this series changed this behavior to let the architecture
> dictate whether "mbm_cntr_assign" is enabled by default.

Yes. Correct. Will change the test to mention that.

> 
>>
>> The "default" mode is the existing monitoring mode that works without the
>> explicit counter assignment, instead relying on dynamic counter assignment
>> by hardware that may result in hardware not dedicating a counter resulting
>> in monitoring data reads returning "Unavailable".
>>
>> Provide an interface to display the monitor mode on the system.
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_cntr_assign]
>> default
>>
>> Switching the mbm_assign_mode will reset all the MBM counters of all
>> resctrl groups.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Updated the descriptions/commit log in resctrl.rst to generic text.
>>     Thanks to James and Reinette.
>>     Rename mbm_mode to mbm_assign_mode.
>>     Introduced mutex lock in rdtgroup_mbm_mode_show().
>>
>> v6: Added documentation for mbm_cntr_assign and legacy mode.
>>     Moved mbm_mode fflags initialization to static initialization.
>>
>> v5: Changed interface name to mbm_mode.
>>     It will be always available even if ABMC feature is not supported.
>>     Added description in resctrl.rst about ABMC mode.
>>     Fixed display abmc and legacy consistantly.
>>
>> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
>>
>> v3: New patch to display ABMC capability.
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 30586728a4cd..a7b17ad8acb9 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,39 @@ with the following files:
>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>  
>> +"mbm_assign_mode":
>> +	Reports the list of monitoring modes supported. The enclosed brackets
>> +	indicate which feature is enabled.
> 
> "which feature is enabled" -> "which mode is enabled"?

Sure.

> 
>> +	::
>> +
>> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +	  [mbm_cntr_assign]
>> +	  default
>> +
>> +	"mbm_cntr_assign":
>> +
>> +	In mbm_cntr_assign mode user-space is able to specify which control
>> +	or monitor groups in resctrl should have a hardware counter assigned
> 
> This documentation should ideally also be appropriate for when the "soft-ABMC"
> support lands. Considering that, should all the "hardware counter" instances perhaps be
> changed to just be "counter"?

Sure.

> 
>> +	using the 'mbm_control' file. The number of hardware counters available
>> +	is described in the 'num_mbm_cntrs' file. Changing to this mode will
>> +	cause all counters on a resource to reset.
> 
> Should resctrl commit to this? Resetting of the counters as implemented here
> does seem to be an architecture specific action so this text could be
> made more generic by stating "may cause all counters on a resource to reset".

Ok. Sure.

> 
>> +
>> +	The feature is needed on platforms which support more control and monitor
> 
> "The feature" -> "The mode"?

Sure.
> 
>> +	groups than hardware counters, meaning 'unassigned' control or monitor
>> +	groups will report 'Unavailable' or not count all the traffic in an
>> +	unpredictable way.
> 
> "or not count all the traffic in an unpredictable way" is a bit hard to parse ... how
> about "or count traffic in an unpredictable way"?

ok. Sure.

> 
> 
>> +
>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>> +	enable this mode by default so that counters remain assigned even when the
>> +	corresponding RMID is not in use by any processor.
>> +
>> +	"default":
>> +
>> +	By default resctrl assumes each control and monitor group has a hardware counter.
>> +	Hardware without this property will still allow more control or monitor groups
>> +	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
> Please be specific what is meant with "the mbm files"

Sure. Will change it to mbm_total_bytes and mbm_local_bytes.

> 
>> +	if there is no hardware resource assigned.
> 
> "no hardware resource" -> "no counter"?

Sure.

> 
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0178555bf3f6..dbc8c5e63213 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -845,6 +845,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

