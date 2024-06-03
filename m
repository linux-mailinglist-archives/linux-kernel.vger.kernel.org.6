Return-Path: <linux-kernel+bounces-199483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD88D879C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B0F1C21EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A3136E34;
	Mon,  3 Jun 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8Rp+kk6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A41369A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434356; cv=fail; b=KHZ3/vuixzRUGQLOgk0/qk3nIEj6Uj5gS9aJKALp3AeH8Z6ckluTwWfAoeI6YdnlSHON2D4YRb0c2nwrPVQgr4WZd2LwmDH4WrQHvqzdqDmP+Rv+2priFTl87bP4ljNhGz8n3lE/2l5TJe3J4MFZ/IafNHEXW752lUuhM9k2TTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434356; c=relaxed/simple;
	bh=3bEa3oso+pzYVawVHAmlzDh5yWtO2KfRJdVtNOPy3iY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dc1DQ5Us/zsq8rjOmW4KxmfdRd6l+/a70BFqR3kR9XGuatlNzJfVjW3EbNua3fPwWBsEYdZFZCMpp5pYyn12aBr9wWHHMy87ctWo1VuJcPjezSdJyzAKWgphd8nzb5zPlCNCPlfAEpYKxbNb5YfbV/F5V57OstfAxyn4R6WKq5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8Rp+kk6; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgY5sdTTK7En9dUyJ1se5Gzs6dZ0uwb39rfYHPpXQd+JmY3PB3U/HeL1toN6h8hgKlX3m0px8CyRb96BMyFy8hazGxCQ3U1j4w6sUzDcfrCDqsZ5X5Odl7vfM0LP39XDAvjjQsDnDoTPxRnG8oR/5WzDgnCTwC67+jm5NhWpnssLWobB5vDJ14sA1AA5ml2RFUTgxv/BwzodlMdpLQ2JcyrB/y/tQq0Efn/twcnNRziYHoLKhxrRKNOXORueKE+QMA1fUVKJklN+7QGRYur8qyB5gm4L4VbMRrFjStqXvf5y8alt9E3wbBaIqqJHuc9AnJp0XRT1Hrvvyf+7THbmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+90rgciA3JSzBk2mJ7LZQRDtYXyGCCaFarB538BA+3k=;
 b=PvFiJok7SHqAWhCgAXvXn8YFJKON/Of6VSY7gOuH+M89qWAniSLfyNX0QWh262tQ5xPmWLUJx+a4br33ueCmz5P4bC5ERwLm4VqraduqzCAHwoh/O1kNyWceI/lBwIq8xd1ibpe405JSCo6bsloNDBjX7WziITg6v9QuIGoUEo2xbTzMgW1cLHom3Oqy/iAqX0OC9zIsDojlZ4aMFm91w1eB1NeDjmRAe774WdPCArsuznSB2r/M5hFLvwnXp7h69VbV8U3BsyNortT0MIKO6VTliASRxEvuUa96zPPO4xvsbqL34CxIFC5V25Ex8QZkXQ4KwePkjQz5RUZauKBq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+90rgciA3JSzBk2mJ7LZQRDtYXyGCCaFarB538BA+3k=;
 b=y8Rp+kk6jEnHbU8Q/Yd03xplRx6Zqd0ziBJmGfTe23oz2d6Jra+9SmVjPVv0mXDAyCBVeKDJMeIb29h7EzkNRSt0FPP7nxkJ0NCxNwNsghzp9F+noX4NCVf4D6scRc8QuRNVT0wjDypb9dedvS8X2O/bM6I3yWB1AErsaohj1ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 17:05:51 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:05:51 +0000
Message-ID: <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
Date: Mon, 3 Jun 2024 12:05:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
To: Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dave Young <dyoung@redhat.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
In-Reply-To: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd4209c-0ffc-4a36-df15-08dc83ef6c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEVkTC82NDBpcnU3ZVJtMENORm1wMlhNcXd4YkZuRFVDZnh5ZnhxKzBSUWNJ?=
 =?utf-8?B?cnViaGZySyt1blo3bUZOVXBFNk4rc0JCZ3RkL3RkNUZGRGYyQ3lBa3p4VkZk?=
 =?utf-8?B?bGtqNlVueThKQmhJTTY5dTlVT2RuUXFLaHVTRTVwQkwrdzAwV0JmdmpjK0NW?=
 =?utf-8?B?WlYweVp2d2dSdVhSa3paa285Ykk1ZzIzdXNWbnVrZlIyMVk2ZWVXZTJUZFVX?=
 =?utf-8?B?eWhwWlZ4MVEyenJzaE4vMHdtcERvb3Z6b2U3cWVTbk5ZTzFySnBJbG53UHJD?=
 =?utf-8?B?dDFJb0ZVS3N2NldsanpGT1M0VGw3cllESFJpaUhheDhZUUlqaU9ORlZmMWVn?=
 =?utf-8?B?aE93b25TVzBhNVZyYWlHekVYbE1Uenp4WmZiNTROeUZPMXE1bk5hVGdNSkFi?=
 =?utf-8?B?bWlUVnV0eTBVSEE4Z0FRNVBZVExXWnNGYU5TR1lIWDRFWmJXNmRPMlcwR0lJ?=
 =?utf-8?B?eTNoa0dNdFhkdXJqSFlMcW9lUTQ5ajNvclVkS3pPOXF1cVV5WmpJdkdRczR0?=
 =?utf-8?B?L3lrT1hBTU85OW0yZUFUOFZaMHd5bWQyOGNTRU5Bc3VNUGVYNEFzSmhjc1Av?=
 =?utf-8?B?eUdVNG1FUzVNTnNSL0czQUZQZFEzWEF1TFp5RDB6VHNueDlpWGVua3FLNm11?=
 =?utf-8?B?UTNBbUVIRzBjdk4rSmliWW1HQlIwNEJqbUcwV3doRFF3N0krYml0amNwaTdm?=
 =?utf-8?B?ZTNyU2hjSlB0dDV2Q1hISGFXQzh0bFNUb3JIMnlUUDFKWUt0QUtEU0JyQVJp?=
 =?utf-8?B?aHYzenkvWG5JejZpWHI1UnRhTFhDRFg5V1owbUs0eUp2L0s5dGZUdUlMRTN4?=
 =?utf-8?B?UWhzUS8xR2Jld1RZQVYzK1RKZnlocHVmdjFybjVlbDk0eG1sa2FUSlNJK0Vw?=
 =?utf-8?B?YTZlbkpua2RzZ01aemNPdlNwdE00UHpPZHZlRnFhSDlUTGZ5RktvKzVPVDNX?=
 =?utf-8?B?RW9WNHhueGt5eGR2RnJmNGxZeitsTUl5UlNoUWFmRmFHV3FFKy83TkVDc29V?=
 =?utf-8?B?dko3OGZLdGlsemlGdzROVjZ2cVFwbGtmTlNObENrRGlqa3NaM0RZdk1RYzYx?=
 =?utf-8?B?RklNSzVVYS9YcEJwdDhZSWNlUlFwS1FRRjFUYmw4czlLMVdMeDM0QjRlOUZo?=
 =?utf-8?B?VnRReXJ0TERDWDA1VWM2dkx6Q29BUkx3aEpZTTBWN1ptZi9KZ2k3UmVkNEtD?=
 =?utf-8?B?aWtIVDlBWEtxbEJtK2FlcVlEZHc5cldQR0tBRWFac2huVjc3bjFWRDFCcnp1?=
 =?utf-8?B?WktmQzVZOXpHLzNCMmlscFhyazR0Vmx2ODQ2RDlDN0UwRjRTTExQQTV3d1lJ?=
 =?utf-8?B?dk50QllKME1nYW9YcUtVdEtabU9DR1M4M0RTZkQra1g2aWJZbHZFd0pGNzNR?=
 =?utf-8?B?cG5VejA1dlB0V2s4ZlFRWEk2MTJvSGV1YnAxM044MERBRk1TNEhnNWdpVDhp?=
 =?utf-8?B?M1hqMFh1QUMvTUxjNXNvTjFxaEMwbGdpbnJibUV0ZkZjUzdDbS9jbWlsb1kv?=
 =?utf-8?B?UzBvQTJJNmFpWHFkT2h6VFFqbHFJT2hrSjNNTFAwWWZOOVRMMmtuOHlCVDVJ?=
 =?utf-8?B?NTJDNUIxaHIycm4vcGRqTWk3S2VWUXQ5R0ZaWU1COCtYV2dCQzJFbTZsYXls?=
 =?utf-8?B?TExDT3BmQTNqeW5XYjZReUpEalJpUmNYSEFCMkdSWUVpV1hXUkFWME9JVk1I?=
 =?utf-8?B?VXJabEVZS2wyVzFwTllnTnYydThSSUp6c3dPb0RHdUI5THdyQS9wQzl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUk0RGlQWlNmY0dDUDVwMVZjaW1PbS8yMUZOdSs3dXZNMUp0RFk1eVlOZTFW?=
 =?utf-8?B?ck9RSXFrQjNLWUhOejBqQ1hTdmFYaHM0ZjNpSnJ6ZnhpV1RIRTVyK0dnTi9J?=
 =?utf-8?B?RVpKU1hzaDYxYUJmRU1iYWJuZnp0NWJQbEF6RFNvME5KSEpTK2I3am5JQURn?=
 =?utf-8?B?RERMVE5hV2lseXc1ZUZTdUpia1FDdlBJc2pXV3ljOXVtQmdTT2FDZTY2eXpy?=
 =?utf-8?B?WmdKbklpd0w5RCtsU0h6RjkvK1gxTTFkNk1XUC9LaDFlSDllOWxKNTI2YmRO?=
 =?utf-8?B?RW9YYUcydUE4OTl6OXptQTNQVCszdjBrQzEzNmFHbVY3bG9RL0RWN0hDbkxG?=
 =?utf-8?B?dTNmN3ErN0ZQMlNKUlppelRCZm10VGROaUJiSzE1WERTTmVudjlkSVZ2MGtY?=
 =?utf-8?B?RitmVTVyUTM5R3VuSG5aUlMzTDFKZGltMS9PcTdEaFgvcmI1RmV1SVlpZU9X?=
 =?utf-8?B?eitCK0xyT1hLcXVnaG1Bd1pReEZ5clZVYnQrM2ZxZVl5U0E2S0ZML1pRclJU?=
 =?utf-8?B?akpMa2ZYMDVFVTFRUzRXVnNqMUE4ZHdidzgvYTYwaFRiYkU4L3RpL0t1cDlv?=
 =?utf-8?B?ZzdHdkZBK01BcjZzR3NmYVdWb2JTNGpZY283aG5yL3RjNkFvYjRYTzNDdCtX?=
 =?utf-8?B?WlNyZGdiSGF2YlEzRzlnNmR1UHhJMkVSQjlVVTBwRUhLbTJnVThFbmgwM3Fj?=
 =?utf-8?B?eUNkRFFZZGVzdUtUVHJQcElkYnRKTm94dHQ4eVdqVk5RSlVKR3BvNU96ckN2?=
 =?utf-8?B?eFUrckRsWkxJcTNzVGQwL3dkOThLbmNiN3pWVTg1NnhwNzNXMktidUk3VmFV?=
 =?utf-8?B?VjJQYUdxMW1vcHpsRHlYSVcvWC9PWHAxb2VwcVZqMjlHQ01BQU93ZDBqVmti?=
 =?utf-8?B?RURqY0JZSUdta3hnMDVXM1d0K0Mrbi9BbTBlUmtvMzJVaWQ4Mll5Mi9EUXRw?=
 =?utf-8?B?UHk1bnY0NEVxRUNScmE1NmNjbE1TL3ROY3RPMSt1TFRyS3REQXMrZm43dWhV?=
 =?utf-8?B?SUU4NGI4OElMSy9wVHd3U2dwNTQwQ2dXWHk0YU1ka213cWo3cERoWW02QXRx?=
 =?utf-8?B?cC8zNUxReFBvMURUR3E5S0JCRFgzUk1BeklKQ2pZSzVINWlybWlzMnBJWmZC?=
 =?utf-8?B?TkpHN3VRU1dQY1pmRWVGVk1iS1RJblVrMWpCUWJwUDN3THpneTdjSlc2MWY4?=
 =?utf-8?B?SlQxb1hLMzR6QUtHdVk0Lyt1d2t4cTdXdzMvdlFTRGpINHE4bUlFV2JHSUl0?=
 =?utf-8?B?aVJRVEdJa0FXZWwrS2lmanZON09ESzFjM0NFVHVzSVREQ1M1MHplanBTMTlQ?=
 =?utf-8?B?U1B2TVhxTEZFWkFnL084cGovY1Bta1RQczdtRUQvT0xyZkx0dFUyaTdKNUlW?=
 =?utf-8?B?WkdkaWNITHNwRy9hRzJTbUFNK2s4TmYzVTMyNnorL1liY1ZZOFhZWVZCWUFp?=
 =?utf-8?B?THNZNXllUHFMQmJYb1VFNUplOTBrNnNXUE5INzFCU0xZc0Q1cGNqaUdLU1Qz?=
 =?utf-8?B?MVN4RGNOZzNFTGtuZlhXNGFYNnd0eUVRK2pLa1lhRjRmNDRwMWFXQ3Yzclp4?=
 =?utf-8?B?L3RmeXYxL3JvUWo2MW5iUUZLaFRCM3FmNTVQZG5pSThPckhUd2w4aUZDUE9r?=
 =?utf-8?B?MUlDeml0MFVaeDB0b0ZJSVpGWThWajlUZUpiaXdoVGZhMUgySVpqSk95TG4v?=
 =?utf-8?B?d1VIbEsxb0tOQWxVU0pJc1R1VXFtTnRTcUlUWVQ4MHZqTFhoUUJ1NWhJRUw0?=
 =?utf-8?B?RmhLNHRDQ2xFRUxsRFVYZHdtTm9vKzF3ZzdQa0ZKSHBybENvVkR0RHhaUVJ2?=
 =?utf-8?B?REV5R3FXUDliMkNwVTlFaVhVSEJSK1NYVUgvcXlsSmZhSUdLZFVvTC9rVHg0?=
 =?utf-8?B?M0Jpb1BobWk0bGtZdjVpZHBWajFrcFhRc2t3cjZSRCsyZW9tZ01vc0VvWkxO?=
 =?utf-8?B?b1NsSWg5RzE4M2xEZ3pZWUVDeE1iWmJZcjNvakU0UE5BdU54dnd0UUMzeE5O?=
 =?utf-8?B?dzF3UzFtVjdYOXczOVJiVTVYc2hxZmhKRWVwdTcrZis3TVBIRXhnT0w1aG04?=
 =?utf-8?B?eWlLMGJEdlp5amxNZFhiQnZURzdOYWhibGpUbUhkNWo5dzFNTE9JV0FIZStE?=
 =?utf-8?Q?6pGUsF9gbLgsW5wDdDuLxt8+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd4209c-0ffc-4a36-df15-08dc83ef6c19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:05:51.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw7ydBLh+gTxOlPyipovyGShVDYDzz5g1MQv5HJawJ3OKuYnG72+qC7ALxvxDm2DoAnw+dq3nbOq/LxXVN/7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549

Re-sending this, last response got garbled.

On 6/3/2024 11:48 AM, Kalra, Ashish wrote:
> On 6/3/2024 10:31 AM, Mike Rapoport wrote:
>
>> On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
>>> On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
>>>> If we skip efi_arch_mem_reserve() (which should probably be anyway 
>>>> skipped
>>>> for kexec case), then for kexec boot, EFI memmap is memremapped in 
>>>> the same
>>>> virtual address as the first kernel and not the allocated memblock 
>>>> address.
>>> Are you saying that we should simply do
>>>
>>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>>> index fdf07dd6f459..410cb0743289 100644
>>> --- a/drivers/firmware/efi/efi.c
>>> +++ b/drivers/firmware/efi/efi.c
>>> @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, 
>>> u64 size)
>>>       if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
>>>           return;
>>>   +    if (kexec_in_progress)
>>> +        return;
>>> +
>>>       if (!memblock_is_region_reserved(addr, size))
>>>           memblock_reserve(addr, size);
>>>   and skip that whole call?
>> I think Ashish suggested rather
>>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index fdf07dd6f459..eccc10ab15a4 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -580,6 +580,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 
>> size)
>>       if (!memblock_is_region_reserved(addr, size))
>>           memblock_reserve(addr, size);
>>   +    if (kexec_in_progress)
>> +        return;
>> +
>>       /*
>>        * Some architectures (x86) reserve all boot services ranges
>>        * until efi_free_boot_services() because of buggy firmware
> Yes, something similar as above, as efi_mem_reserve() is used to 
> reserve boot service memory and is not necessary for kexec boot.
>
> So, Dave Young (dyoung@redhat.com) had suggested that we skip 
> efi_arch_mem_reserve() for kexec by checking the set 
> EFI_MEMORY_RUNTIME attribute as below:
>
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..6f398c59278a 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -255,15 +255,39 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, 
u64 size)
         struct efi_memory_map_data data = { 0 };
         struct efi_mem_range mr;
         efi_memory_desc_t md;
-       int num_entries;
+       int num_entries, ret;
         void *new;

-       if (efi_mem_desc_lookup(addr, &md) ||
-           md.type != EFI_BOOT_SERVICES_DATA) {
+       /*
+        * efi_mem_reserve() is used to reserve boot service memory, eg. 
bgrt,
+        * but it is not neccasery for kexec, as there are no boot 
services in
+        * kexec reboot at all after the first kernel's ExitBootServices().
+        *
+        * Therefore, skip efi_mem_reserve for kexec booting by checking the
+        * EFI_MEMORY_RUNTIME attribute which indicates boot service memory
+        * ranges reserved by the first kernel using efi_mem_reserve and 
marked
+        * with EFI_MEMORY_RUNTIME attribute.
+        */
+
+       ret = efi_mem_desc_lookup(addr, &md);

+       if (ret) {

                 pr_err("Failed to lookup EFI memory descriptor for 
%pa\n", &addr);
                 return;
         }

+       if (md.type != EFI_BOOT_SERVICES_DATA) {
+               pr_err("Skip reserving non EFI Boot Service Data memory 
for %pa\n", &addr);
+               return;
+       }
+
+       /* Kexec copied the efi memmap from the first kernel, thus skip 
the case */
+       if (md.attribute & EFI_MEMORY_RUNTIME)
+               return;
+
         if (addr + size > md.phys_addr + (md.num_pages << 
EFI_PAGE_SHIFT)) {
                 pr_err("Region spans EFI memory descriptors, %pa\n", 
&addr);
                 return;

Thanks, Ashish

