Return-Path: <linux-kernel+bounces-336135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48597EF91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A45B21D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456519E98E;
	Mon, 23 Sep 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqT9aKCs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8A81AD7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110271; cv=fail; b=fgYfALVnYC3t83GrIfIc5+RQ5AgNonmXEYXg819PN9JrCtl0shQ0Hc1LYjplHatOqaCXMlB8oQgr06ODSbLr7TxSu8hDNnZXd2e0505kPZ1H6ehQxCFS6kTPqi9yylNtONCymlKnXbdYj2TRczaXS2Mjy72liYB4rMRvqxNfX3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110271; c=relaxed/simple;
	bh=ozCKhe5adwwvwFTCjHFHfKtpRqRY0eL8UvRmwFDQX2Q=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DzDGA3UO+zefeDHE0+OsU+ExiWq9uo2yvigk6C5o0mW75YuBlebRSrxDO14YZKPQh5fdnNQRo0nfP6uH/quXExXwaExTX6zAlUSRY1BnnuqiAjJyPGrRogoVCvJwI1iqlJLPDom9j8gFyAh6SxKap/ZviJBBvVW16kTo1SHt8pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqT9aKCs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727110269; x=1758646269;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ozCKhe5adwwvwFTCjHFHfKtpRqRY0eL8UvRmwFDQX2Q=;
  b=OqT9aKCsZ+xzDujytNmGqPt360b840KAQ+JnkeyTfgR6xM9pip8OvOgT
   TS9s1gydbQG4yG5MLAxLoPoX7vSNX1dkDmRgMmY3wOSUlA8KUpHEVadvY
   T+kzgMKDqncSI9MfFqA8jJFiZMOyg0MvqnWxgDThp484vFHitL23A5iya
   WdwKuwugo2azXu8HLZ8aAgR1Vq2Caomf6faOWIKKsg3yl0NtYOhNVxAnx
   KSgk9547ygOlGZLFjaAZxGntYTBhahCTiafnfJ0JCztjAcrz3nxb9oCLP
   CUhoSbj78lOwWEt8a/+oVsmIZxJL7N4/7jhWRjKq1EA0h8wPkpu6QSWxh
   Q==;
X-CSE-ConnectionGUID: IQrZHaifRDqWM3TkaYtEQw==
X-CSE-MsgGUID: UqByfvWcSpSpaouoPac0eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="51487601"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="51487601"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 09:51:08 -0700
X-CSE-ConnectionGUID: 3qVFMH8jRaOb5P2GX2eJSQ==
X-CSE-MsgGUID: 90D6lqJET3WHClOp/06RQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75663536"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 09:51:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:51:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:51:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 09:50:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 09:50:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 09:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=An35eeN+NGJvKxpIvIR66mQKdoGQaPfJxt53ihn8B/8l8wxmWYjRTFQmKjalXTa/3+FRTnWDJo0Dr/rSvGEwky0IIet4otIX8BEc4Sb3E6aUaRh0wkSwPkqakTSjxanwbjX41rvjguJcyvbR3XCHSBK8DTkPgHFOW8MsCxmpXNfKEQIA++FlulE4NKc6h7srXLEg3m4m7B7clcQHCzP3PmBM7hn4x9OVMS9wNB4ZCH5QD2TpIa25uRonX1mlnG2YJvBKM40MZAtG+kx8YAPbjbiTNIdf+fuwibG5OZvsd6yZNTzQET86xi3cLvnafMI8sQwicWDV9gXudgTLFGx7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZb1BkqE14TpwoA2D+qMShFxTd42VRqeX31jEZ+4f4=;
 b=NSSCvd03gw0QCIZ7r6UIlX6bKiahUsH64xkhooJKk+xkbzxqJ0FsAHssWtmtAGkCQxtWpciay/VsBO/ZSV2W7XF2m3LQQE/mvvOBFzvtUCnWHynJq4lWM5F43sAy+riGEWVqIi8xfahaa09CiwWnUMImgcszPCK69M85NjN9mbqijgBjoAtYbxiXiLmZ7WUuRc/SIhrmoSql8ZW5Xc11JSf2dfHsMFi1kNfWYSuNfOILL1a1EwlVm5aJaU7Y8vQfuNJaRiPWQ9gf4Rjfm1XRDW+XrhUgcIDN40GuETWJ7BYV/qMeh7yc8Zoc8haGveI0v7adlEQw6WjehjrU1jrwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 23 Sep
 2024 16:50:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:50:41 +0000
Message-ID: <dd3731ef-cf47-4103-a310-13536e831bc2@intel.com>
Date: Mon, 23 Sep 2024 09:50:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
From: Reinette Chatre <reinette.chatre@intel.com>
To: Martin Kletzander <nert.pinx@gmail.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
 <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
 <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
 <7467f313-761a-42ed-ae2d-cdadfd93db90@intel.com>
 <ZumkrWn7FtiMxESR@carol.k8r.cz>
 <771f3a74-722e-4966-b319-daa28ce24e86@intel.com>
Content-Language: en-US
In-Reply-To: <771f3a74-722e-4966-b319-daa28ce24e86@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:303:6a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0e5a02-193b-4188-1c53-08dcdbefdc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REE1MHpnRnRzYWlkOUlmdHZISm1peEIxTlp2SHJqaVpxaFBQM2VXOGZaSFlr?=
 =?utf-8?B?VG9PeCtzdXVtMUxYTXRKdU02YmxTeDF6Y0NtMzRtUEJsZkVPQXY4T291b3Vh?=
 =?utf-8?B?VUZPcE80YS9HV3hqN2thQmNPdXI3djZQWDlaY3pIMy96bjZDVzFEL201VmVR?=
 =?utf-8?B?NjBBNlcrMEJDRHNzSnF4cko0RnlLQ0hEc0ltTWlhanFKYkpsYS80T2xkM1Vq?=
 =?utf-8?B?MzN2QXBqbm9xdWxvVThJSUE0TWtsK29NSXJmYmpQcVJZTHl5Uml5Zzg3ak9I?=
 =?utf-8?B?b1JLWnFOZnRURG5BQTZrWFZuTjN6ams1QkxDNWttd253VllyWkZpVjdheWZJ?=
 =?utf-8?B?VG5ZSDViaGgvcCszK3dqbi9BVW1rZU5TbTVrcGlrRkVsOVNUeWc5ZllySEM2?=
 =?utf-8?B?eUpEMVRqNW9yR0lSVnNqZ1ZtVjJrN213MVo3bWEyUHZzVXZORUFoY2tEM0cy?=
 =?utf-8?B?Q09xWnZWMHZVcmNrQjRFK0YvUG0xbldmdHFtZzQraS9XaDRuajFvR1MxdytQ?=
 =?utf-8?B?di9vdGorSVJIbWhwUzhjbEhUVlp3MnFZUmtyT1VXVTlDYnFHa1pBQ1p1cTJh?=
 =?utf-8?B?dGlhR3QyUmZmdFVoRElxS0NyeGtrUVIzYXlodmFySDFuRk1UbjM0OUx3Zndi?=
 =?utf-8?B?VjJVdnMrSkdlVjd1WTFYVHhaWFZyMXRxTFhqVi85VWptYjVIbEpUaEkrSEJ5?=
 =?utf-8?B?WUhPdEtmeXA4Vi9iWmVtM2JYUlV0U2tyRENQWWJNZHk4WWhicS9Fcit4b1Ar?=
 =?utf-8?B?Y2JRQUM3RzNPNEl2N1pFM3lZODQ1QlI2RUxtQmJNU2FCVGkvQnpGbngyZGZz?=
 =?utf-8?B?RWlRTlRjYnVBQXNobTRkSTZZcXJQd3I4Mk1WQllDTE9MeWdyQ1o4cVYyNkFi?=
 =?utf-8?B?bEloM2V6MWJaakpxWHZwLyt4ejE5dmRaN3VyeUNFa2tTdE9PZ1AzQmloYVdD?=
 =?utf-8?B?N3hMUEUyMWd2RFZmakkvTHA0MVVWWGNmSjB6MGFzMUY2b3ZrVmFvL1VvODRD?=
 =?utf-8?B?VFdwMGJIR2JxZnBHOHFCMldqOXA3K1ljeFJSV0pVUVVkSkJaLzVsNUVIWldR?=
 =?utf-8?B?dDd5Q24vYkVranFiNVREYWhxZktTdzQ3RzVFTUdURWJxa2JhZGhtYXhRdTA5?=
 =?utf-8?B?eW9XbDI3cVpJaWpaZ09aSUF3R1lYUGl2ODNqTk9MOE55ckFhcnN2WC9mODdz?=
 =?utf-8?B?eWQ3QitVUzdjZEFwNFFIakNtZDRvWVV0TnNsN2pVbWFDS1pRYnI5ckVXK29t?=
 =?utf-8?B?YmQ3UllPSEZQNDBuV1hSZ1ZnbmY0bzBNaEVMNnJ4QVMwRVVvbE0velVCdFNs?=
 =?utf-8?B?VVgwTXdMNHNtemxRV3ovSnB6WVI4ZDRPaWpiMnhYUndTWFRETk1TNkJGUnlQ?=
 =?utf-8?B?OGd0MnZaMnNwaG9mWkFrZVkydW5hMFpacThDbEVIaS9aeVRoenBKd1E5cTJW?=
 =?utf-8?B?ZGppWWR3SXdDbHp4TVRtelh3VnlOaWhvdENOU3lnY1BoalFTMURkcDRZczRi?=
 =?utf-8?B?cDA2bjB5UVRTWnlQc05YK00yZ2MxNVhkUUhRRm1IWEV5aFpxeFhSd0lSRDlD?=
 =?utf-8?B?RlpFSWxsT3lScGEzeUhWemcwT0RCZXZFZ0tiZE94TEFwd1hGZ2M0SmNyd2JC?=
 =?utf-8?B?bFZkOUhteE0zZ2s1ZmdPQXVUUjlvNFBCTmJvMUYvbU52ajBqeTVrZjVmV3Fq?=
 =?utf-8?B?M2dIKzdIK3JKREJFcVJiWkJ4TmtMVk50eFFFYi9qdDNLMGFVRE1UaWlobjhu?=
 =?utf-8?B?bXg4aTgyYUlkeTJkU3VlVXpkdlN1YmE4U0x3NVc4VjlrbHVvVS9mNmlOY0Rl?=
 =?utf-8?B?ZlJvZ3JTWVpXRlR0MEcrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZFYUxvVnJlUzJxYzcwWnBsWHVYQkh6a3orOFRrak9vTnlldFRnWmxoK0Rv?=
 =?utf-8?B?UlAwRUwycEVSanBpS2xjSDF4dXNPT05nWWV4emdxOEo2UWNHZnVid00ydyta?=
 =?utf-8?B?N2wwcGxwb3VabmVkQmFHTmxIVGdaOVVtRjB4dUpPY1RVSjhPMWcrTVhLR01p?=
 =?utf-8?B?Yk1xYzYvN2x5QWRGU0lKbDE4YlEvMFRFeFVYNnFlV3B4MVdQMGxtenpLYkE4?=
 =?utf-8?B?VFBqYVhMWjgyZTVnOFdpakMvVW1hQnBDaWsxaGpsN3FrUDZQRllyTWVVaU00?=
 =?utf-8?B?OHQ1WVQxbWkrN3QyeFZwbTErWlRaU0VveWpQeHJHQ3FCcWFsQzV0dzFSOVo1?=
 =?utf-8?B?UEhuUmZyc01xUVRPc3Q2UWVmc1QzTkM1UXdZelZuUkVDR1oyTTRQY0d1ejNn?=
 =?utf-8?B?b0hJS3ZVbGQyUng0ajA1K3BjaVIrUjNydXIyWjdBVjVNdDB2UnhEaSsveHA0?=
 =?utf-8?B?SVJWY1NNNXgvbitRWjFuY3ZpNWp1bzBKU3NLMUw1cnRYOWt5K1lkaVpKRWZa?=
 =?utf-8?B?RXA3ZDZwRXBUY0hwbzdGZ3I5VmZYa0hKdkJ6aDh2NUdWRDUzSUNVSWlSQXMz?=
 =?utf-8?B?NmxYbk1keW40NERna2FXRU9ReWZ0WVd3ZC9iYkFlUFc1djVHQWVNclV6dEVX?=
 =?utf-8?B?Q3lUUkhjczVzUGlNZnA1SkVKK3RxR3JkNUFvVENNRVhPQUR0MUN4K1ZseUdP?=
 =?utf-8?B?NnR2NG1LME0zeU4zRWNUd1k0OEErWTQ2dU41SzNMc2paZ2VhRWVid2tzd3lT?=
 =?utf-8?B?NTRCZ0xSR3FFTEFHY0llK24zdUtvajdpbkVma1dNZk56TlA2Q0JhWEpXYWF1?=
 =?utf-8?B?VlhPa1RsQVRwMEJBZ2xpMDU1dUpDR2ptNWd3SGhLbkZmT3o3aXBQdE9VU2NI?=
 =?utf-8?B?OHVsbDlHbmVzVmFoREluc1FBbEFvbWlDdHg5bnZzeWd6QTBreTNrL3pQUzc0?=
 =?utf-8?B?bGNGU0F6OXdrNXpDQ0Q3d2xGYXZjSlVFSHZMN1Q5MkttT3JaMEEyU01RN2Y1?=
 =?utf-8?B?dXNFOGpqbW1ieE1IVFFwTlMwdlJ3eFpuNnhCK3pNZnR0b2ZtdWZBVVJEdk1P?=
 =?utf-8?B?cUFUbCtpNGlZT3NrWThiN2RmM0ovOUdXSXBnWjlld0ltRnIrZENsenhQVzVB?=
 =?utf-8?B?Smp0Tk5nb1RNcTlzd202cjJaNlVqVU9YNk9uWjE3QlZGMUpLK2hNU0VKWVBm?=
 =?utf-8?B?djBlUG13MW41Sm9ZVDN0ZnlJeFhyNmhZUFFxaHJ1VWxWLzlJYk9VNUdXYlEw?=
 =?utf-8?B?ZFd4bkpEUFkvSjJHVVlBdlVENTFHa2YvMW1aLzdVODhZU1NpV0RDcDBaU0VD?=
 =?utf-8?B?ZUZvY1pnZDlLbnJ3Qlc1VDA0WkRTc3lMdU0rdVdyeU9nKzlCOGd5RmF4STlz?=
 =?utf-8?B?Y1AwUnh2S2MwR1JKNkE5WVZZV1djNzJFQTdPdFZmZHl1SjdnenluMnczVGlM?=
 =?utf-8?B?Q3M5c0FrTTlvbzEwa1FoSHlvYkR4bUNzbHFCNGlhTjVBalhMZzFSWWZReEVW?=
 =?utf-8?B?SGJKUk1sWE5aVmRFQlF6RXRFVUJEZTFWbmZYVUhoNUFHOG5kYlhFTWxyWlc2?=
 =?utf-8?B?enVaaFphQlNodit6N000d04zTkJxZEw1Rnp3RkNVbWs0a3k0Q2RpOHZQNFpG?=
 =?utf-8?B?R3NaNlAvdWtiVUdKNStZeGVVZjE1MGtuL0RDc01zTmhEVkFzTWVNbmNHMm9o?=
 =?utf-8?B?cGZjY2RFL0xMUXArWVBwKzZtMXZvMENYQWMyblA4MDZDVUpibm1zMmc4UENu?=
 =?utf-8?B?YVdWdmZKdnFuZlJXL052S01uQ0krMGY0ZnJLaDhRWE03N1FxZHF2N2ZrbHZN?=
 =?utf-8?B?aU9HeFpOa2hzVHNmMGNXYUpKSjdZYkYwUVFSVWVGOC9hRkpNakRPeDVWYnVk?=
 =?utf-8?B?eU15aUUwUVZuUzBxOTZ3eEY3UGxJY3RMUCtiYWtwNUhreVZuZVpYeDJ5Z256?=
 =?utf-8?B?ZlR4ZzQ2MjAwZEoxano4STZMYVRkSDhDU3hIREtVV1dPMC92M09qb1NQNm5v?=
 =?utf-8?B?ODZPRUVMMitOc1FRUnVEUHZKOC8veitCWTdLaE1ldWU2UitvenhhVENVOVpt?=
 =?utf-8?B?eEdXWGl0WDRSdGMxZXRWWmZaOEpxaFowY0ttcG56OVMxdmdBV29CQ0JpTHox?=
 =?utf-8?B?ZXBod2QyWitpQVRXemZTbUVhOExDVEVSQTdFbklSMDAyanNjbEI4TTdNbDFa?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e5a02-193b-4188-1c53-08dcdbefdc24
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:50:41.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvsXmC1Iiiyfr/Q9nedxCwm5145XB1+mCJm3uPfqhk42htGTONiZ/eixKjNCgiMuSEO0RBqVFr2IAIwvfGPiB0MVr/aurV6maZ1NSJmDQ6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com

Hi Martin,

On 9/17/24 10:19 AM, Reinette Chatre wrote:
> On 9/17/24 8:47 AM, Martin Kletzander wrote:
>> I wanted but the diff has some weird line numbering and could not be
>> applied.  I'll write it manually later, test it out, and send a v3.
>> Thanks!
> 
> Apologies. Please try:
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..53defc5a6784 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -29,10 +29,10 @@
>   * hardware. The allocated bandwidth percentage is rounded to the next
>   * control step available on the hardware.
>   */
> -static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> +static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
> -	unsigned long bw;
>  	int ret;
> +	u32 bw;
>  
>  	/*
>  	 * Only linear delay values is supported for current Intel SKUs.
> @@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	ret = kstrtoul(buf, 10, &bw);
> +	ret = kstrtou32(buf, 10, &bw);
>  	if (ret) {
> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> +		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
>  		return false;
>  	}
>  
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> -	    !is_mba_sc(r)) {
> +	/* Nothing else to do if software controller is enabled. */
> +	if (is_mba_sc(r)) {
> +		*data = bw;
> +		return true;
> +	}
> +
> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>  				    r->membw.min_bw, r->default_ctrl);
>  		return false;
> @@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>  	struct resctrl_staged_config *cfg;
>  	u32 closid = data->rdtgrp->closid;
>  	struct rdt_resource *r = s->res;
> -	unsigned long bw_val;
> +	u32 bw_val;
>  
>  	cfg = &d->staged_config[s->conf_type];
>  	if (cfg->have_new_ctrl) {
> 

If you do find this appropriate you are welcome to add:

Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



