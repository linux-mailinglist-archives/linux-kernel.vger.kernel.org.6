Return-Path: <linux-kernel+bounces-292677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272D9572B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF832831E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD2188CDA;
	Mon, 19 Aug 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2D/CK7+u"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB041CAAF;
	Mon, 19 Aug 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090872; cv=fail; b=HVhmNSedtOPhZlKx8uESLy6JOc5BILBoQ9ZSw3PZWVB1Vm09VgUd8Asen6WPialMzGQlWB8HCY4IibxWR7OJpOtEAEElYX1B+3AWGfHfQ6I8lV9vEfzPu38TO2fuWeX7Ag9SZNM4bA3wMjTC1izdMUSwwCaRaRqY8R62ZTLf+tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090872; c=relaxed/simple;
	bh=jNS9ETYqFNLeiWQqPDyYNZzrwIV2+zsHOVFha+siin4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDwcsd9hk+1r3o/SZwGEJr9pmJAx66LdEp/FE3+uRxGeK/CaT0d+Mr16yq5LVl0yUwYX2fHti6jiJDjrz+8N/F97Q2OvDwOXWZ4JzPV4HEuRhIj9xvyr0f5N45xCxkEf4e5+TIdJ+U3gyroYtMx33RzRNYvvg9ciHiTmnRjKoC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2D/CK7+u; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDubsb76rvbM3JACo2fbLJB08dNXRtESEJ3CcTn7ZtuzQoNmnCwyhmAu9vu/TZv/6n75ZIY5gHqEiGGDy+lOu5fwerlXBeKG8Sq6geWtN5AlyZLaIJwKHxTGwIbO/s/EZ3hMMDQw/pj2/wEWygESBjpa2BvK792L9QPmoUkTcKD1IvUFBhE4l+nXtqkbq1wkHTQqhetpGd4evrWyCIpMofKFZ5oRSkk0/LsP2XIshinpNmWFdptG4uEY3Q69ICsqJG9xaZseLwNFhkvx1YfVfhgf83LuAFyxh9TXCjzGsnHxK5MZbD5hsZ6SezvipU3VTFWZGAeV7vVNooui0/J2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq1Vmz89YVpezyDNXztrNoQy2ey1rBuphHVXVIfBws0=;
 b=jNXrG0saSTMrcZ3f3HippRw+PQ05b5ZEWVQzq1XxxvdWBn+MsaLFi12CHCrTRbmltsItOG4juWxhaT/gL6xD7fuXkhvNv8Lq5ZkYPIR75v2HRSpvmqn/cE7px4a7Fb3EM08xJIG9ZYBpT3zX8zYR2lB1iGPk/1pzPWY49WK5XtbhBNi8aQ9pA5BlpAjlKrjaZTn6yFH+lEU8/thDcOCZ0jvsEgR5FpAeaXbGitNivCDJjzQFRQb4m0MhqbHB1OJHw6v2svT0/SSGGWRmC28Uh7aWbFUs1zNIW1+l07bN9kF+XUwv/03kSCBIJIiOMLSpcdEvkQcWzttWZtX66QgSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq1Vmz89YVpezyDNXztrNoQy2ey1rBuphHVXVIfBws0=;
 b=2D/CK7+usnuo63xnHV9KpxXMYQSZvvSjYU78vmsjvWzxc44XDWCkwbPaRNZIh3CLbYCk+KlZNJRGK9AG2aVG+Oj4DjzIKxKerMap+KOQF/p0Gr+GpRz9m5COfSIujk79h23yHSYFH1MnQ9IDed5ewLGv7kLrZy5FlPQUv1QK9kE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 18:07:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:07:47 +0000
Message-ID: <0256b457-175d-4923-aa49-00e8e52b865b@amd.com>
Date: Mon, 19 Aug 2024 13:07:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
 <272538ff-0608-4bec-be22-3cb32d3a5ae3@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <272538ff-0608-4bec-be22-3cb32d3a5ae3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: f8da3920-68de-4646-bc2d-08dcc079d4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVUwamtVUng0QWVlcGdxcDRxZUM3ekEzZDlsampmbDFNZm1mZW5DQ01SNTcv?=
 =?utf-8?B?ek9iRVhZaU96eEdvYzFSYi9nT2NkOVFGS09CMXNkbW8vNUI5dFNRS1ZwU2lC?=
 =?utf-8?B?UEQvaTd0SDRianRFMGlqektnNk5Oa2hvMkdRVkVlUUNYK3NQdEkrc2lncWhV?=
 =?utf-8?B?ZGVsNkViNzFmSlgyaFRiOWE2cmU5OXFyTkVIbHVQZ2JNZUh6NGpLZXpkdEFF?=
 =?utf-8?B?SjJwb29pK082ZG9rRFlhOFMwRGVWZTdYZ3k1VEg0ZFpmSHEvYm14eGRJd0xL?=
 =?utf-8?B?Zlg4VlVhaHhtSHRKbDhkZ2trVm9wL0ZGUmVUY2FEMHFWUGxaMmNncmlZdG5U?=
 =?utf-8?B?UmlyeDYvS1hlRDYvY3EwV2hSUDNzY0hUaTRtY2kwSWhXejZmQUVReHkrZEd6?=
 =?utf-8?B?U0tnM281TWNmYTlhUVB5NWVaV1ZBUlppT0h2T2p4cEJJSTZQWk9oOVlJQmly?=
 =?utf-8?B?Sm94bGl5S1orUlBxMURZYlNEVCtYZVJqMDRmMFd6VGxkQlZWajhtbm9PdU9S?=
 =?utf-8?B?b2hTZjU5Q2w4YlNOQ3E1RHg1SXRkdTZ2L2ZrdWQ0bUhLTXEvZCt5RFBCSEho?=
 =?utf-8?B?OENScTZYRXBTcUJNM1ZoRStRMHk3WTJNVFloVGtEeU1xOWJHU3R4YkZuQk1z?=
 =?utf-8?B?WU1Wem5TY2x6SlUydXYrbmZZN3FyMlF2emhyb3dXZk0xeFVqYU1oaGVaNlFw?=
 =?utf-8?B?SlhqeForVG04RVNaOThQQXZNdGVOcVdYSHRzT2s1Y24wRVhUQ2s2QkVYMTNS?=
 =?utf-8?B?MFlZdVJuVTg3b1F1cDVxNVY4dEx1TmNLZU5DdHQ5a3Zxak0wSEMyWTBQY3RO?=
 =?utf-8?B?d0lMNHZvc2ZteWZCZ3VzK3ZCMjAwdlhTSW5jMlVhOTd2bm1tejNOZVMxWkdi?=
 =?utf-8?B?TldkNllFN3hTREhtNW9MWGQ1WG9pL3FVT0l2U1AzUERXYzA5OEZHT0Fuelpl?=
 =?utf-8?B?MzNLUy9icklXcVBQUmtKRGJ2bG12NDV4QW5UVEFWVTB1TlNHSXpGeC8wbUxN?=
 =?utf-8?B?Vk52eVN6WWZ6M1lyN085OW5oc1I2V0xpNVQ1Y0ZTMytLWDQraGp5WDVCZ1VZ?=
 =?utf-8?B?dWhmU1A5bEJYSWIzY3c5d3VvOXlPdm5qK1JrOERzckxPdjdHSEVQcXpOL2oy?=
 =?utf-8?B?dEZwMWdEQkxxeGpjb2E2aTl0Sys3LzkyamdUUXVqdmozS2MvWUdsU2FWUWFL?=
 =?utf-8?B?aXdJRGdwTTZlQWR5SWFZSms4NEoxM0pSS1B0Ky9aKytDeW5ENStDK2YwVFVO?=
 =?utf-8?B?aG9meFI1dklJVTR0YWZFcUN4WmROYUkrTXpiTng5ZHhuUUdkTFFQYzB3UzZF?=
 =?utf-8?B?RHNCUXMwYWpUTFhjNC9ZUE9BZmw0cnFxejU1aXdnRXplbFRBQmppYlVJdVNz?=
 =?utf-8?B?UEwyOEtFdXhqUTc5cERDNlY3UGxCWlg3L3JTUVk5SjlGRUthNlpSVnJYdXQ4?=
 =?utf-8?B?aVM1WFRzYzd5eHZMSjcwajA4alR3VHA0bTRFTmlpa0lKZUV6OGtCVUdXRFcz?=
 =?utf-8?B?RmJEY3VRbDVYZngvSHFEa0Yzdnh6bjRXQktwYlZQcGFJNXNsamdZNE54eURL?=
 =?utf-8?B?UFBKWGJHZ1pucENIWk5wRGEwT2RuTmQxUCt4VWpYbGNJQldLcHlkME1hOXVH?=
 =?utf-8?B?ZzVhR2RTRDNjYUdxcWdYMXZKWENjV1JJS1JFcW9Rc25TN2ZtYkhKVGRRREdN?=
 =?utf-8?B?TG5UaXE4Wlg0TXJrSE43dDhYaVVtYlNuaDl3U3VtcFoweVJKeDgxNjB6MUdN?=
 =?utf-8?B?U0J3TS9DTkJjZU12Z2EvVXBINGRNWGJ2NkV2RVNGVjFlRHZaUjY4dGVXUkM0?=
 =?utf-8?B?TFpWb2FaNmg3QzM2N0YxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi9YWDFlTnpsMyt3YnVZc3p1SU1ZRndpSStDRGV6TW1JU3ZZTE1Na2hHRFhy?=
 =?utf-8?B?VnhGTG1mUlh0d0tHNURLd3I2U3B1Wm9GNVRrbDZXYXpFOU5xSEtvNXRwdXQv?=
 =?utf-8?B?aUNnZWY5dmpZcldXM0szU2JhRHNiYmF0Zkc4Vi9jNkZZWTFwZEhINkVUbjFl?=
 =?utf-8?B?Znp2U1p1MVp4OUpTbGxXajVuVFJUUlI2UDIreVo2ZTlQY01CeUVjSG1JTURu?=
 =?utf-8?B?cW9ORy9rWVBwdGVyTXQyOXNJSzA0Uk1JOG4zRTBLWGdyUzh5aGNveHMxNVAy?=
 =?utf-8?B?UytWc0xhMnJFcnBLMkV6Mzg5eWg1dXVGajgxZDdRdkNjRmIzcVZNT0NEYitI?=
 =?utf-8?B?cXBtV3IvemovSW1kdTJZOGhib3hkQlVWS2ZYdVdtdWZ5cFpJanVBZ2J4b00x?=
 =?utf-8?B?Y3UwSklqSVRId0VZVExsSHoxaCtVMXc3RFNic1Frc1JvSnZqNmRIUlY5N2Er?=
 =?utf-8?B?R0p4RUc0cVFyelV1V2hsVS9HdHNoU1pyTnYwVlBWYXdzWXhXQUNRNHF6bmpD?=
 =?utf-8?B?YlVyU0VCd05tUkN4OXdUalVybTZqTnpQK1lCbWlBcTJGQ0RhT2ZWamxtUkl3?=
 =?utf-8?B?Y1RYWUFPWVdpa01jbW4rTDVvY0VFUjBIVnh6VGFkNTV1RS9ockVuSjFZVjNy?=
 =?utf-8?B?Y2IwWmdrWXdzM2h1SURqLzR4TDlqRVJuTSs2SzNXeTRJdS8xTkMwR09FODJB?=
 =?utf-8?B?by9ibkxuNEJjQWFLWGNKTHRXanNsRFBpN1NtOVNkZWxCanpZSkFVOCsrM0Ja?=
 =?utf-8?B?OGlRdXpBTFBvWHdNSjNkcEkzT0hGdExxTWk1WHVnY3hRSndsOG54bzRsQmtK?=
 =?utf-8?B?T05iYjl3b3JkcngvTUMydjArc2xBOVQ1bzNHN1hwelBZN3JmZlpjR3ZtNkND?=
 =?utf-8?B?TU83NlRibVpIYzNjdVFwZGxkUC91QkxONWo3U3ExVWJtcmNrVnhFUGUwZXJL?=
 =?utf-8?B?SWdXVDR4U3Q3ZU5laTBXdnJQOG1WdUovWGxnQ3BYRjJUWnZIaEJQTnZXTGJk?=
 =?utf-8?B?N3RQaXJUd3I1YW9DK1g4VlR0amdncXMrNzRveElleFlZMGRsQW9SV2Y2YVBS?=
 =?utf-8?B?UFUxVnV2bDNjL2hjZk9vQ3VDR2pzQ09GU05aaXlxK01zMGs3d2N2S0s1eWFu?=
 =?utf-8?B?RDdWOVBzUS9CQmREVjA0N04zelFxNllvMGhrbEVVUHRZYTRRTmpVdW14anJo?=
 =?utf-8?B?Zk9GL3JvdU1QUkdBbEw4ck50YVcxaHZDM3hzWjZDeTR1MHRnMHZQdldQdjhI?=
 =?utf-8?B?WkwrdXdHMVBYRWE5R2ltVyt1azBXUyt3WWMrZkVOSWEyL0U2Y1VvZFdRdm5J?=
 =?utf-8?B?NUt5b2JpZ1AzdExWdmdQRVE3LzFOajZ6MS9RZnE1Y01nSjdpRjBwbmgvb0hM?=
 =?utf-8?B?OE1TRGxmRmplWHZoekxwZlRUZTZsK2xHNE9MMVg0a3FmbkFHMDhTMUtEbTly?=
 =?utf-8?B?RHhBNDlYR3JteG00RjRNNDJmY1BuenN6dCtjWDJydDZIYmsxME1haGtOaUdN?=
 =?utf-8?B?dHVETEpaaS9WTFhFUllsSWpxN1FsWWdoWXhUbDdjYWJHWVJUKzdUVVJ4UFhG?=
 =?utf-8?B?WjlPcEowOFRNWU1NalY5R1J1bTRRL1hQb2EwNXpZckNHNXA5cEo4aklLQXc4?=
 =?utf-8?B?RElEalpqZGp5Y29EeTBXOGd4V3FoTnJMd2U1ZVVWY1czaVhUUmx0RkV5Y1BQ?=
 =?utf-8?B?c1NDbnEwd1d3RkpwcVpMREplRG5pS1RxOEliOXlQangxRFhMeE0xSkVnczNP?=
 =?utf-8?B?Y1pGVnU2WDlpYWtaV0UzQmdvTW10dndCU2FOUTVZM3hkOG4wclRHYWFpK0d5?=
 =?utf-8?B?Q3ZDbjZJMWhSemNZcm9OazV3Ukhja3AraWNuN2k1aXM5WDlEQlh4emlubkVu?=
 =?utf-8?B?dlVDOWloK0dITEFWZGdCZzZtekZuNFZlay9sWjNRbnNmY3FOeHBxMXpxZUl3?=
 =?utf-8?B?dGtqVjRCS2d2NU5vWiszV05UenFsTnVuNDNoOE9uWjNMOW5JeFFmellzKzA2?=
 =?utf-8?B?Y0JLR2lGcXBDakpUdWUxR2tZNkR3ZjVMLy9VZzFjOXpUTVJxUXFVQzc4YlJB?=
 =?utf-8?B?K3FTVVU4b3JFVFpCdXNoek1QN1licU5UdkdnWlVZeXBVL2gzWmJkakNKcHlp?=
 =?utf-8?Q?Vtw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8da3920-68de-4646-bc2d-08dcc079d4cc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:07:47.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGxxXtPTyzIZtONG1uT9umJgNJ7DN/EwZn0KZppSM6kr9kbnEdVQqEscGXko7J9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

Hi Reinette,

On 8/16/24 16:31, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>> to be updated on all the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed. Reset the
> 
> Could you please clarify how this works when ABMC state is changed on
> one CPU in a domain vs all (as done in this patch) CPUs of a domain? In this
> patch it is clear that all hardware counters are reset and consequently
> the architectural state maintained by resctrl is reset also. Later, when
> the code is added to handle CPU online I see that ABMC state is changed
> on a new online CPU but I do not see matching reset of architectural state.
> (more in that patch later)

Yes. I missed testing this scenario.
When new cpu comes online, it should inherit the abmc state which is set
already. it should not force it either way. In that case, it is not
required to reset the architectural state.

I need to make few changes to make it work properly.

We need to set abmc state to "enabled" during the init when abmc is
detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config

This only happens once during the init.

Then during the hotplug, just update the abmc state which is already set
duing the init. This should work fine.

> 
>> architectural state so that reading of hardware counter is not considered
> 
> "architectural state" -> "architectural state maintained by resctrl"

Sure.
> 
>> as an overflow in next update.
> 
> "so that reading of hardware counter" -> "so that reading of the/a(?)
> hardware counter"

Sure.

>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Renamed abmc_enabled to mbm_cntr_assign_enabled.
>>      Used msr_set_bit and msr_clear_bit for msr updates.
>>      Renamed resctrl_arch_abmc_enable() to
>> resctrl_arch_mbm_cntr_assign_enable().
>>      Renamed resctrl_arch_abmc_disable() to
>> resctrl_arch_mbm_cntr_assign_disable().
>>      Made _resctrl_abmc_enable to return void.
>>
>> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>>      Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>>      Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>>      non-arch code.
>>      Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>>      Modified commit log to make it clear about AMD ABMC feature.
>>
>> v3: No changes.
>>
>> v2: Few text changes in commit message.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h | 13 ++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 57 ++++++++++++++++++++++++++
>>   3 files changed, 71 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index 82c6a4d350e0..d86469bf5d41 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1182,6 +1182,7 @@
>>   #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2bd207624eec..154983a67646 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -56,6 +56,9 @@
>>   /* Max event bits supported */
>>   #define MAX_EVT_CONFIG_BITS        GENMASK(6, 0)
>>   +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>> +#define ABMC_ENABLE_BIT            0
>> +
>>   /**
>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring
>> those that
>>    *                    aren't marked nohz_full
>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>    * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>    *            Monitoring Event Configuration (BMEC) is supported.
>>    * @cdp_enabled:    CDP state of this resource
>> + * @mbm_cntr_assign_enabled:    ABMC feature is enabled
>>    *
>>    * Members of this structure are either private to the architecture
>>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>       unsigned int        mbm_width;
>>       unsigned int        mbm_cfg_mask;
>>       bool            cdp_enabled;
>> +    bool            mbm_cntr_assign_enabled;
>>   };
>>     static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>> rdt_resource *r)
>> @@ -536,6 +541,14 @@ int resctrl_arch_set_cdp_enabled(enum
>> resctrl_res_level l, bool enable);
>>     void arch_mon_domain_online(struct rdt_resource *r, struct
>> rdt_mon_domain *d);
>>   +static inline bool resctrl_arch_get_abmc_enabled(void)
> 
> This function will be called by resctrl fs code. Please contain the "abmc"
> naming to the
> x86 architecture code and let resctrl fs just refer to it as
> "mbm_assign"/"mbm_cntr_assign".

Sure.

> 
>> +{
>> +    return rdt_resources_all[RDT_RESOURCE_L3].mbm_cntr_assign_enabled;
>> +}
>> +
>> +int resctrl_arch_mbm_cntr_assign_enable(void);
>> +void resctrl_arch_mbm_cntr_assign_disable(void);
>> +
>>   /*
>>    * To return the common struct rdt_resource, which is contained in struct
>>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

