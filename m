Return-Path: <linux-kernel+bounces-173513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9E8C017E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9611C231FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1367128801;
	Wed,  8 May 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yEWf6xlH"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C761A2C05;
	Wed,  8 May 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183610; cv=fail; b=cUfR0//iA3bIl+l/PiiKO6Pg/5Ad+/GJoMnPolS0uW/qzvT/DBlYwCcM83Fl59XJsbMh3jC/7dobZWoo+FxpQaBTcwicBnjEoIkO+UiVQFK4ZPvqlqT2D3BzEj8LK7MTajX3/6c5tHh36/V/X5msZGT4JTd76oPA5waXQap8baM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183610; c=relaxed/simple;
	bh=Tm1+DVLL33tvJTMB0H5RBqfx7uNcdm6xrGXUyBEH9jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlF6tf7N9yDoPS1G7S8qF1sS5m69iVjZKKs9y1o/89PCE9sPL1z2ko1RiknsPnWIaHQWJsES5Z2Gfg2OIIQnZ7o68hUVZ8CE+GqdmtUlvJ+YtipysXwyk6bEMiLwd0atEfOWa+peICsiTI9yzvug8BPJA6KvQE9VoQIOWw7Q6eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yEWf6xlH; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7U7+D8ba85VSvyv1oD5CNJPB/tbJvLQ5hxGrpU03uNYWPunuZNBsOARIeayKL2gSrCSDboMUdtoPMUMhY3teWFvt49SWwBZaO14rwYXz2f0e5MCpciGkfxJycxtde3pq0D2GCXtoA1fm1ybPQGv2ZBWXo0aWIwfbObyiRs528mGWq+0sKWj977mlT7Szl6hs9uIIc9CW2ZJIk2QNwEqFfA2fR+gEYMeVXL4RgxP7w9xF9sVy5OlFMPe1V20hJizINf2AzsdK1B8VgZSohdwsRsx4lSjG8CNJMU0KnS//q6w+AKU2xPElf1RP8ehKGkEAEg+qigX4s8gch7nKrVWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5GYN3pu3bGYumjMyMy2rT2fTt8IsaS7G+2CpxQEkeU=;
 b=IT389LO5FW+Cczu9uhnKav5rWSzlzwYhItVWuqlE3ow1GtHDRsmGLgmrMhJB3DZuOhPgd1MOvhiGtGXqw2mowzkGRiClBfdayM+I077ounTw0W4Sfy8XfuTrQRuyn5kAe0F/ejUbkQd/v2rPdxun74MVyZRTtH3N18313Cv9UfC6kDarS9IvkIf5AlArU+QnI7m2mtjRrcFENmNrPF8Wn+HyKtkTIRDXdKegSq0ph8PU+6eI4PQtkDdh7JT1DO4IJmlrpCGv4GBd87Irtls4IRQtyfzQ+0AqKw0v2F+CtaYYWimImvfaCu4xnmE97Cp2pC+0jI5WhOirbtiK9iDByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5GYN3pu3bGYumjMyMy2rT2fTt8IsaS7G+2CpxQEkeU=;
 b=yEWf6xlHBJAlrBTrnqBZU9R82i/3ieUb27CNOZNEsv/dUJliXD13cmzYHIPRhw+ZuLCO0pdN7z5CAb9zl2haTb6RoJG8x/suKcVAw3fZ1czQNPxioq0ewDdUfsOxER7v4bq7lq9dlyna7ROEF4CM/iK8uRMfpGbVvflBaiuHaXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Wed, 8 May 2024 15:53:26 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f89f:6d2f:47d1:3893]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f89f:6d2f:47d1:3893%5]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 15:53:26 +0000
Message-ID: <63894ef1-c482-4646-8351-4d6cfc6c528f@amd.com>
Date: Wed, 8 May 2024 10:53:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH v5] platform/x86: dell-laptop: Implement
 platform_profile
To: "Shen, Yijun" <Yijun.Shen@dell.com>, Lyndon Sanche <lsanche@lyndeno.ca>
Cc: "pali@kernel.org" <pali@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "lkp@intel.com" <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dell Client Kernel <Dell.Client.Kernel@dell.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501215829.4991-2-lsanche@lyndeno.ca>
 <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BY5PR19MB392256C65661E76FC292C0889AE52@BY5PR19MB3922.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::29) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: a05e7868-44d8-449b-228d-08dc6f76ff56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmFSNWVtZ1JFZDNPV0dLcGtaTnRGVE1oc0t3aU5TQUhlbkg2VUNKYWt1OFFJ?=
 =?utf-8?B?TzlENlVoNENkUFdNeXd3Q3ZGRVNzYnVneE53bU43ZlRSdldsOXhNeXdENXMr?=
 =?utf-8?B?eWI5NHJqTk50OHB5c3p4ZUx5bG44Q1NrK0xzNTZiWWhUbU4yUFZXeGUrQllR?=
 =?utf-8?B?a0pUTW1nandZQ0pLVytvM0ZYcWwxY2d3S1BvSjZpSkZualVIYkxkbFQ3czlj?=
 =?utf-8?B?dU95ZGVqb01Pam1GaHdYdmlvdlJuMnVCM0NyeW1TakxmOXVVSVFuMk01SGhi?=
 =?utf-8?B?c095TS94eVJjaS91TzNZazNrM0R5N0FKajRQdmt5YS9jOS9jRTIxWWVUbXBE?=
 =?utf-8?B?NzZzdUZ4THJvc05XN2JpcGU2TlluOEhmMGJlWmc5T0o2MnVNOWFscTZkbWdU?=
 =?utf-8?B?N24yV25zM2xmNXIvdFo3WEs4cU1uUDBNc0hXZWNpSjJXMk5YbHNiTTVSeXJo?=
 =?utf-8?B?MUUyRVB1OSsydTh4RXROU0Q5U3VtYVVHYlEvKzhUQVJtYWZyQzRweHJybDd5?=
 =?utf-8?B?WGdFVkc1NFU5YmdDZTNVaE9CRUZYdm9pUC9GcHMxcWMxYjVWNXdyaEhqWlNs?=
 =?utf-8?B?RjFFZXFKKzg2eWMzRWJ1YUFHSlBoTVNuSC9Xa25DL1JXTGVuR1ZMK2YzN0dT?=
 =?utf-8?B?d1FlK21DV1lGNEM0RHZPZGxXOHFpOXh6enMvRng0Ly9Xbkh0UHVQVDlLQjZV?=
 =?utf-8?B?TkplWmN5d1VqU2hmT3IyOFhiWXE3dy9MTjlMNm8zNk5qNkVaY2J3UFhIYlFm?=
 =?utf-8?B?UXlHUjBvNDVHUnB3aHlBQ3VyS3BRcmorWlRUYnBDV0JnR2RuZnlPQjhnRlpM?=
 =?utf-8?B?aDh4U1l3aEZIUVVDc3M5T24zeVlFTnFuVVVUejBhclNUN1FFRTRZd0VlQ0dh?=
 =?utf-8?B?YW82NHpoSi9aOFlXQmtnRjF4TTdlY2lnMGRrZ1VJWHlncDBYelBHTE1yaDlX?=
 =?utf-8?B?TG9IUXJjZEh4ZGc2eWJlZDFUajA2VzkraUNCOXlvYnI4VHRyQVMxWjY1U3dF?=
 =?utf-8?B?Qm91dUhEcm9iNnN1QjR2d0ZhTm9nYUtKWE9sU2poUTg5SEVwVFdpUVRleXpX?=
 =?utf-8?B?VGtzbThoSTNYY2VZcFBjYWhpQWhLZlQrZFpJYXdndVV2aGQvd25TZGFmZVJu?=
 =?utf-8?B?RG03Y0xZR0V0bytVVkd2VHZQcUxBRWRzZUwzalJQL3dNZldNY0J0QWoxVUpi?=
 =?utf-8?B?YUJBVS9CcHNBQnMzbUFvYmc1TlhrRHlsckFpNTN5MW1tRkdVMW9GVlI3cVZD?=
 =?utf-8?B?cStFQUs0bERMMExTMUJxUFJrNFhCczdWV1JjR3hFR0xIanBwbTcvUFNLUklh?=
 =?utf-8?B?S3NoYjd3MGtDb3NTRm1XbXVrRlhnZERja3lpczJyUEdpVWFtMmVBZjVUaWVH?=
 =?utf-8?B?V2Z3REdIUlc4dzh6K2g2MUlFa2kxMkpDZFlqOTFEako1b1V2SnB1RTBNOW1K?=
 =?utf-8?B?MkgzdEFwdVREeHM2ZTAxcTdOeXpaend0bHV6RlRnSHh6NStsRkdac1NFL2N0?=
 =?utf-8?B?QmpGMGlHbTVKb1I0RVNibFFrallQZHFkR3ErallOd2U2VUx5TjVpSVVWTDVS?=
 =?utf-8?B?UzI4YkhMeFU0eEpIUlVOZVlMNGU4RW80Z2Y5WXhrb2xZcnRlb2xZYjNmRHhr?=
 =?utf-8?B?eUVwNWdud0E2RmNPYmtkazhFdTlkQlFNRG55aXdpUDl3ZjVSaXVDYnpqK1Ba?=
 =?utf-8?B?NE9pWGFiMGxTZzZZNjErTXBQajhzUzRQSDFza3BPN2s0K2Zsckd2VkxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJqQk5MSTlyeGl0ZkYrbEdTRW1CQ1YwWXdzTi9KWXF2OWtvNTNVZDhXUldK?=
 =?utf-8?B?L0V1aG5RMkpDUVNsNDlCM0lxZHJkZkNOQVQ1T05hUnRWczNUVEdCbHhLWUxy?=
 =?utf-8?B?LzAzcTlDUjlickFxcm8vbkQ0YjFoQVlJUU05QUVJWjRoWjZRR2ZZQUdmbmFL?=
 =?utf-8?B?bXQ3cXpYQnd6RXpnc0VNK2M5b2lESit4TVAxSkJIQWh5ZjhRcHM3YXVWVHRa?=
 =?utf-8?B?K3o5SkM0cmthS0NwWDVibytHQWwyczNsVmpIUDZURVNoTzB0TlIrTEg2eWRM?=
 =?utf-8?B?T2ZadHBvNUZ4QW8velBQZHlXa2VLQUZGT1RpVzlmRVo2TTdtS3pjdk14QllF?=
 =?utf-8?B?b1ZocFZCUEdFeC9Ubk01aGlEL3FuRVhUQnRNNklPd0NJMllBajk5VmlmdjJI?=
 =?utf-8?B?ZHdMeG0ySE9Jd2luNHJDUDhhVEYzZTIrT3JjWHQrWkJtamk0MzlacDY4MFJW?=
 =?utf-8?B?THlOMEpyK21Dd2Q1UVcxb1B4VXdWQ2lKeWhXTEJvUTdrd3Bnb0hObkNab0c5?=
 =?utf-8?B?aFFKWnY0b1pvbHNtQjhINXZQd094Rm9nN09kWGpMZGhZbklQZ1BmWllUbFlB?=
 =?utf-8?B?ZC9kUmZyUEVDdE45L3FZYkhzZk1OeXVDeDg2ZDh1SWtFa3JYUklWVEpRcWx0?=
 =?utf-8?B?M0NBQU9SOFFUS1huT3VjMlVtbzZGMDR2Vjg4U3FXZURVVm5XZlc5V2FJcldJ?=
 =?utf-8?B?ZnRzVTJoNzE4d1JRV3RtelZPWG5lUUhkU3pzVGVveG92S09YL0VYRnBJYS85?=
 =?utf-8?B?emQwSFZzSHN4OHRvREY1LzVrbWZHdEx5eEo3MVAzWHJMM21GS2pieXNlTUFr?=
 =?utf-8?B?ekxFcnlKM2FJdWNtd2Fqb3RNNExidnJLQmxRSTBaUWt1bDM4V3BmczdYM2Zv?=
 =?utf-8?B?ZHhBc2wxVlVjb21xc0wzQ3ozNXo2bjd0L2Z2WElrZ2VkN2VVUlJENm1hWW1s?=
 =?utf-8?B?cnRaMUZqQnpUS1AvUUo1TzZERnhnLy9FcHdxem5GMGpQRnBzNDFYY2xrTlZQ?=
 =?utf-8?B?T0diejhqSlE1L2k0QU1lTmhSa3ZHVG1uaFowUHc5Tk5uVjdmVUI4TDF1eUNV?=
 =?utf-8?B?U0lIMXBWdXVkbTdMVDNPMlZqMUVwbTdtUUhuSERwNlpMUDJmTEJ3NzcydVBR?=
 =?utf-8?B?T2Q1VklLaENvaW1DbUFYRytrVy9hbVJwRmNQSmM4em9QMG9WL1JrT2FkalZW?=
 =?utf-8?B?M0UyQ0lPTEs0K0padmNJc0VsUzlGR2VQZFd5Z2ZCVmx0NXdaRGRqaStJWlh3?=
 =?utf-8?B?Q3V4MGFBbjJQM1dSVkxBYi9nSE5NdVR2NG0yQXZualVIaEFFcStJNW9lTy9I?=
 =?utf-8?B?M1grZ2E0a25meStoak4rZzhXenIrdUtMMm9QbTNPN0JJNkpQTDdxTmYwNWZD?=
 =?utf-8?B?YldVTmVaNDk3QnNIejlDekZHeWhTRk8yV0dSbHczZkpETUJ3ZFE2OVgzT2tR?=
 =?utf-8?B?cHI2YjJicDJkM0M0QnEzN0JzOFdtNzlpcDJlSHB4Zmd1dnkzWjhTYnpZQk0w?=
 =?utf-8?B?cVJOS3NLaG0vTHBqVlVsb011REtJQ2Y3Wlptc1p0akRHdjBZZjdhc0xvTTVt?=
 =?utf-8?B?WUlMQVVROVh6MHBhN0lFL1k0bk0xNG1HeE9ZdzRYOEFGVS9GL29FbVd0Y2FD?=
 =?utf-8?B?Y3BsZ0dwelAyVGtkMnZqN1daVC9zbXlNYkEwZ3VJVzlkWE00TkpHanZiMXEz?=
 =?utf-8?B?dUFUYmJsUTA1dHJvSEljSFU3V3QvejJXQk9HVDRLeW5sK0RyYkdLWFlFdk5T?=
 =?utf-8?B?VGhFTVJUblhlVnFuYkNGNjlkckVUQU16VWdUMnBXSnhDaE5BZlNGdEtLeTFk?=
 =?utf-8?B?cVpBZzBkRmQwbDNSRzN5YllvckZUYUh3bnNEYUljYVBPOXR6ZWtyR1RjTm9N?=
 =?utf-8?B?b3o1TWJ3RFVtanpwb2p1VHhUdlhWdVhGRDRWUFBNbXR0OU1telNrdmdXcVAx?=
 =?utf-8?B?L3dvY251NlJFa1hUTDIvUmQ3elJvUmdLbEFPd1pmL0FPQTZHc3gvUTdJNUZ1?=
 =?utf-8?B?aENBSUpFZTVTZkw3aXNkcXp0OURwM2d0NE96Z3JkQUdSQ2VVcHlFWlVYTnYx?=
 =?utf-8?B?UWRsZ2ZCSytsMlpQNFBnZlQxSFdVWUFkeXFXS2NBblBNZUxwMzRUcVhISlV5?=
 =?utf-8?Q?aIlhZltIDL+77C7n7LAd0UW8U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05e7868-44d8-449b-228d-08dc6f76ff56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:53:26.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvDPcG4uukSy6TACM9MMBn/YCADXZubcPVpIUOuB1gwv5ev1tR0E6CVsEHZcyzblVsEDPIjKEPk/8WDei723cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763

On 5/8/2024 09:24, Shen, Yijun wrote:
> Hi Lyndon,
> 
>   Thanks for working on this patch.
> 
>>
>   Dell side has an initial testing with this patch on some laptops, it looks good. While changing the platform profile:
> 1. The corresponding USTT option in BIOS will be changed.
> 2. thermald will not be impacted. The related PSVT and ITMT will be loaded.
>   Some Dell DTs does not have the USTT, Dell'll have a check if nothing is broken.

Hi Alex!

Have you had a check both on both your AMD laptops and workstations too, 
or just the Intel ones?  I think it would be good to make sure it's 
getting the correct experience in both cases.

> 
>    Additional, with this patch, follow behavior is found:
>   1. For example, the platform profile is quiet.
>   2. Reboot the system and change the USTT to performance.
>   3. Boot to desktop, the platform profile is "quiet", the USTT will be changed back to "quiet".
>   This looks like not a proper user experience. The platform profile should honor the BIOS setting, aka, the platform profile should be switched to "performance".
> 

I agree, this sounds like the initial profile needs to be read from the 
BIOS settings too.

Furthermore I wanted to ask is there also a WMI setting that corresponds 
to this that dell-wmi-sysman offers?  I'm wondering if both should be 
probed in case the SMBIOS one goes away one day.  Or should that one 
just be used as preference?

It seems like maybe ThermalManagement corresponds.  There was some test 
data in fwupd for it:

https://github.com/fwupd/fwupd/tree/main/libfwupdplugin/tests/bios-attrs/dell-xps13-9310/dell-wmi-sysman/attributes/ThermalManagement

