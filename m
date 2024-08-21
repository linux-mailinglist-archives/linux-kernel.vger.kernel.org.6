Return-Path: <linux-kernel+bounces-294794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DCF959292
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387B61F2548D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9F56440;
	Wed, 21 Aug 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZJM9/Rk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB12AF1F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205720; cv=fail; b=I2EQLAUKeyz0gHtEbwiW1drbl+YG5XNFnk64Y33B9JW0aldGE0FdOTtiN7D6SxwLFtvqWvwwvRjsgm1m7bdSrRzER4qTeO/gvRnUf0GKEJinuZ/eo8oEIbRqA9gcT12pyLgMt6wwQ+s2+aQXVqWynhVBQUTRkLfMcoBGdOj0n4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205720; c=relaxed/simple;
	bh=Mqmd7sPnHVIZFcqb5eZ/X9E7FY2N7tlfHk3zInvhg7I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C5+i4Yq3bswKc2AlXeRQiyfs/f2+K13hb7blglPs6SESnwCiUBrWk7odcF1hva//ybW6PUClh4ACcd3fhK9k/0csEC+6V3aBIuOBC9nykn/OE6mUwMUhp+wrzn2Yu9Rcvl7boW/fsU3uggbvfOXNXfitywxhEQQCwVNaDuqgIAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZJM9/Rk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205719; x=1755741719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mqmd7sPnHVIZFcqb5eZ/X9E7FY2N7tlfHk3zInvhg7I=;
  b=lZJM9/Rk8Kl5MYqoMqGBA+XfWiZsf2DbifZ15eltiird9AazD2NUxF6c
   tk/Egf5KEtE9qewEsup8wuO6VQozgiPChLj1MxchNLa2LQMkJTquNGl78
   ESndQ2HzIwwULccA1ZKDUhal2PvBpI6SEBy5H9Fy9if0GFYrY3R4PZHWU
   54JNPgPfOq6suF5JPCz1E0otqAg43FJbkH/DVvc/jJoDUlP9ig+tXh1ez
   6bM0PYTgKHzRFsYwspJFQ5CRRNBeSkxQ4T4nqW/s8F8fVY03ktC4G5Ps0
   lyRp0upQfrQ2dnTVGZCDvD9jUTF6OFa/Cm02lLx3r/Mk9VvNwt6viknB7
   w==;
X-CSE-ConnectionGUID: wTRjpl30TrCTVoSMRNZwCg==
X-CSE-MsgGUID: l1TElYUUSwyXFqKkRpiYgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33929700"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33929700"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 19:01:59 -0700
X-CSE-ConnectionGUID: y3SiqWWHRbSyY6BH06QVCQ==
X-CSE-MsgGUID: yj4LKdqTRX2B//DlXpLgYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60577018"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 19:01:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 19:01:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 19:01:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 19:01:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 19:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqbw5oAqrKO0okP8lSaDeuYFlGPRZqDD1+0qayu7O6fA1rjPCtbs2oGTv7r3DQeQLj3KvpES9dgsw+X/kVTXibOk3oryqyG+//J7NLb1/G9G+fKeNh9XBsCndBz6qfIY89nOSfS4H0Bx9v+J8xrGKXnyu5nRPk7T6s9CNuH4/7cqxnalDAPlNSvNK5uXIxCxM/hguXu4XEq9Thd1PuDKGUUhvk1bxaZYl/pufbmv+Fdf6BWZsDq8vjk2n/R8elJk3S1bSplLFuUfvWplxFWOuZ3KBqHAtL1nj8BkxyIy/sjRe7WiHPdoKv751XHKimAi8webJ506y9291so/YEuheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNiTPHibhZSh3bMuBkYihBtUUpCO5+QRO1YqOrUfieo=;
 b=XDqUBhvtz/6t4swCllkqV5SDGoSOwAFMWnI4oCYJx+7KzmgIVQDLdEhwNwpXb+XxTfLZFEuPZmxC0b2Kbn70abd8OLI8EV5mBhfjdC0aK2NDZUo4wMSu4pD46HAPJ8b8MlII5039br+KWrpMolcrrxSdzBSv7Qz18aov6YDJuXU5r0ZZZr1FrnIuuXQv3HG1xsQTDHp/0vii9QbTRTYiR/m1ugLkn5uGR7G+Xm11kdhmZOIqnfUXYcu7iRvAlk6lsbI/+Lnuu+17izFwPoHC7t8Dm/GBP2I5ienUD4/NuT0utvxmKtt/awpt8j4ACaM4W9rxH947H8qA28jkUyRg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 02:01:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 02:01:56 +0000
Message-ID: <adf05a71-49a8-4b4c-ae64-8e3d4eee1e41@intel.com>
Date: Wed, 21 Aug 2024 14:01:48 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5, REBASED 4/4] x86/tdx: Enable CPU topology enumeration
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
 <20240809130923.3893765-5-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240809130923.3893765-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e09cb88-6cbc-4b01-83c2-08dcc1853bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG14V3ZCcWw3TUltbkhFVm50cFErOUhKNkN2cDBZdVlCNElaSTRDakFzTXhv?=
 =?utf-8?B?ekRKekhnT20rVlR2RysxUTc5Kzgzbklxby94ZGtiV2oxTTBwQnJOSzFNN01a?=
 =?utf-8?B?cFVWR3J0TUs5WmUzZEtaTEV6T2c2Z2FUUmNzUndWeG1QYi9teGZweHlib0xI?=
 =?utf-8?B?N2pmUjBGTGdLNjFXOHRHUUJoNkdlcHEzVFFyVjE1U2FNNXo5a1lPZGRhNEJr?=
 =?utf-8?B?eUlaZWMrYmc2TmJEcVpwemdKK2NsYmx5WHhWN1Z3NUt6cHFHdk4vcWVUYXV4?=
 =?utf-8?B?eVdYU2NRVytDZWdveVpvQUI1UmlpWmRXaGJNbWUvZVFzVUZEaWdwNFhyY3Zv?=
 =?utf-8?B?UnhEaVpkVmN4bFNydWZnNDZhYklKeXdKdmp2cjNZcW1LQ3ZWZUhSTmRma01V?=
 =?utf-8?B?NkdzWndRZjhmTC9UMHhVakwvbnJrYklNZ1hqTFFZR045YTQ3aUpsQmtYM3Y5?=
 =?utf-8?B?Y3VoeFlNSW93SDRUcFd0MGNJT1FTcWhramU2WUFOd2RSQmE2UGc0Nm5qaGo0?=
 =?utf-8?B?ZnZGaHdDcmhCQWRNaTY2V05ydis1RlRCeDhoWUIyK09RU1VOVVhCU25BdXNZ?=
 =?utf-8?B?L2x1UkM0ZXhjRjVJUTUvTEFPOHd5V0lJcit4R3RDdTFManVCZkQ0ZFFJbVRo?=
 =?utf-8?B?bHRuZUxPZUJlditsY3F4RTRaV3J3MUc4dmVKUStUS21pNjBBVnpOTG5PODhT?=
 =?utf-8?B?NnQrN09Gb05iWUJzZk9FSlFKdVVpUWFYcTdOTDNaQ255VG8wSnI1cTlhampP?=
 =?utf-8?B?dWhxRlRZMVVzMlJuNU5JYzIyWnFVWVIwWUdhUm5yQ1ozUThmdXB5dGlrMnk5?=
 =?utf-8?B?ZVJPZERCVGhpR3p1S3liTlY1THh5WW1XMnhuV2JxS1Y2Z2s3RVRZTFcyVTRp?=
 =?utf-8?B?Q1RmOGthK0NpTmdLTnhNQUFkc3BIOVZIVzBYaGwxMTUzRUg4d1RwYkpabVNp?=
 =?utf-8?B?dllVVS9oY04zMEZtNmwrSldwVXJhanV0QzYwM1FrOUpWc0tPemFiVG9HY0t3?=
 =?utf-8?B?VmkwR0ZXYzQyMU43aXZMSjdCQzBNRnl3R2JmZm9IVCsySEk4UmMrcTJnYkt2?=
 =?utf-8?B?SEpoT0FyL1VhTHJXQmJ4N3RhWkVSZzBUdkVybDg5Q2VYTy9QbnlCeEMzeXFv?=
 =?utf-8?B?MU14Z1Rock94dUZPR3lIVVRYTWZjdHpWVjhudDFrT05sVjlNR3R4RmRGZGJD?=
 =?utf-8?B?aTB4NjNzSjVZNENCY2NSZ2ZiNWlGdHRBRnRrRzd3YVByc0RWMEY3T1NJNDNQ?=
 =?utf-8?B?Y3RDOXdPTEVCeDlNRWE3bmRDcytqWXM2aVVUaTVFSUZzK3JmUDJ0WGFmZkdE?=
 =?utf-8?B?dDdHRTRhMDNtR09vckQwRTI1dGY4QmNPSFMwY1VrUlplMkpoWDg1MmNyMXZs?=
 =?utf-8?B?TkhEV3lZaWRaalN6Z2JFRTc4SzlkT3hWK0hqQ2pBSWI1Vkl1YzQ2QzBYRyt4?=
 =?utf-8?B?RHNRZEs0SDUrNGFGaUN2MEloVG1kcHVpeWhDVmwvb0hPaDMzYjJPVVBYS2xC?=
 =?utf-8?B?ZHlYcVpZeXhIL3hyOGlsQVFOWVd3QnUyMzQ4aG9RbDN0b0R2eHk5UW51NnlJ?=
 =?utf-8?B?TkZvb3hmYmtBY3ZsOUZqNklvYWJFVlBWUEQrcnlWRVhvc2F1Rk0zNlB5cnhX?=
 =?utf-8?B?VHV4TXlkZXdSZnR0OFhxUzg4WU0vSWYrM2RybFUxdEJCVndVazhhaFE3dzBN?=
 =?utf-8?B?U3ErelZmd3JNVlZ2cWNlWTRYaGdFWnp3Tk5zbXVwVkFtM294dTJFd2FKclhq?=
 =?utf-8?B?RU1nblRxazJ6dHQ5VUVZSy9TRWhrQU5Keld6Sk1XRzhYM0ViMVhSenp1ZDVG?=
 =?utf-8?B?QVJDQ3Bnb2NEM2N3dWxZdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1PblVvRnU5T0IwRG9BUHdQM2MzZDgvRDlPUXcvemdsblpzRjNVVEs4Nlpr?=
 =?utf-8?B?U0RVNnp1aG5LYTMwM2FkMisrUStiWlZXa09CWU5TTVpZZkxGb3dkcm01RWRR?=
 =?utf-8?B?clRCclcvWXdqRDlub1JZd04wcDVFWjQ4cVlZUURRSmJyaFp3ZXRUMi9WTzdk?=
 =?utf-8?B?UW5uWXJwK0xWR3FwWm8ybGZaTmI4QTNCbTdkVXpNdFkwYUZXTjlzYnJOUmo5?=
 =?utf-8?B?Vy9kaUpCUGwwY01zRi9jbS93NzBldzcrOVhiazN6UTREVmNPdElaUndQYWtm?=
 =?utf-8?B?TE14S3hRS0RTay8vZ01LUVhpaExIVTVRd1hSRGlSdk5pM0E1ZER5QmZKTUhW?=
 =?utf-8?B?c1lraU5WOFRhS3NVZUpJUFFVeWMrV2RHZWNxMjBQbXBobkd0TmxZN1dSSG1K?=
 =?utf-8?B?WEpMOWVJV0lKOE5qS2RLdU04QjRUZWF3dHU3aktvekwzbzdudGFhSkE1ejBI?=
 =?utf-8?B?U0VoampXQTZIbU1ldi8zc0VPN1pERWZ2Ym1BR1ZGSnNKaFFvbSs0WkNPT1Fu?=
 =?utf-8?B?QWs3eGFsek9aUWlhTDJFTG41ekw1bUJHQWtjNko2OW81c2tmUXlMM2NsaHZU?=
 =?utf-8?B?OVBHUmNmUzJ2SW1PdWtDWHRpVEZyekMzdXRuL1dVdmtoWlRvWlF4K2N1ZUM1?=
 =?utf-8?B?VkZrb1o3YXhrY0F5M1ZFblpJUXJhNGF5V2RObURSVU9MMHBvcjFSVGtKWlRK?=
 =?utf-8?B?Z2hXdDZ6K0xlQkc5TXBObzB4QW4rcGd5TjVQcVVMbnpiL25LcGcwdnZOdjBx?=
 =?utf-8?B?S0swcjFsMURjSGl3THFxWWxhZWpQU01WdGxJL2lkQjR6cGVna0djWE1vbE1B?=
 =?utf-8?B?UzdUUTJsREZ4NTJzMHhkOUtwVk90amJ0QWZlQVlQWm4xVFV1bHMyOXQ5d1Ra?=
 =?utf-8?B?N0FPWlZmWDhwSXhGL21CWWtMTmR5VGlSb0Q2RzhIMEl4TTJhaGlHSTZsSUhu?=
 =?utf-8?B?TVlqK3E2Wmx6ZmJ0VHc4bG1WVnFURVg0TWQwcEc4RFdNN2VQd3Y4M09URk85?=
 =?utf-8?B?Q2Rsb3MwT2pxQW5wNW1rRTFITXA0bGtzK2hiV3R3YzJEODNNSXFEbzJ2WEtT?=
 =?utf-8?B?WE9NT2luZ0lSVDVQRWNzTnpxZ0U1UVhTcDM5eEFHVWF6OTdFYnJoRGUweE9J?=
 =?utf-8?B?TXJaVGY3enJFYkJmUWljMFNRdWttTXAxbTFvS3JOdmNmem5kWm1Wcno1ODkv?=
 =?utf-8?B?WncwTFZ3bFlJeUxaTEluYWljdURBV3J6dmtRMzdjbXlnQlU1MXZybisySzBp?=
 =?utf-8?B?MTJyRVdJU2xPY21qMk5vRkEwcXI0dllmZHFVQ05rSTE5Uy9VTGw2TlNkYWhY?=
 =?utf-8?B?bzlPRVlmS1lWc3Yva0ZkV2xTOFUzSnVZQnA1VTdVV25YNVdHSU1jOFg5VHVG?=
 =?utf-8?B?STZIczRFM3MwczQ3YnhtbE12eGhVWDFWcG44ejZPVlJ2QWxQWFJVMlV6NnZz?=
 =?utf-8?B?VTRjL0h0QUh4bEhidFdJVEVkS2pUd3JQUE81YWtBK05senNQb1N2a2tEZllU?=
 =?utf-8?B?ZXNKM2pqaGFWb3psZnpGcEhFYUZnTXZTRTZZTWxFY0hLdHFmWlhqYWdkalpr?=
 =?utf-8?B?bnptTEp2V0Z6MjJuUDNVaUYyM0FUREFmTmZhY0RQeVgvdVlySzVoSFpQVHBP?=
 =?utf-8?B?UmY5eThlc3l0Sk9nK0REWXNlZ3J1dDBTY2tuV21PdmovRVIzQ0lxeDB2TEkz?=
 =?utf-8?B?OTRDSEYrN1pKMkNibmNkYUJtL0p1WjBOcm1oQ1pKY3M5bnBNY3RuUlpyTDV5?=
 =?utf-8?B?b1YrMjNUeDJrdjdkUFJJZW5KUm8rdmdZZVRCbWllT1hSd3JhY3dPUXFrTEt5?=
 =?utf-8?B?NXZacTVycDA3NDRPLytrUGEzWDNKMlZVSzdlVlZwMEVrOS9TKzZCa0N6WVBK?=
 =?utf-8?B?Ri9jWTdqeERublRscFAwNHdSQmlIVnZ3T0tvNTZZSmhWak9oVnhwZ01qUjMw?=
 =?utf-8?B?V25DelcyUTBYUzFLK05HRG9GVmZNVWN0OEZESUFSN01FTlJBWTFJOXhTdnBq?=
 =?utf-8?B?aElWVUdiM0JIVnhHVkF5WEU3MGFudFU2dFluUjQxeHNncVBkMnpYb25NblBw?=
 =?utf-8?B?bzJRWlZ5MG1IdlBLUFgrTnMvbklwclZseUVyMWJwVzRxSkRabFNwUzk3N1pT?=
 =?utf-8?Q?nlE+i07/rmVN546m5u3ERn7lp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e09cb88-6cbc-4b01-83c2-08dcc1853bd0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 02:01:55.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd2C7kbVCpMRkZxq4P34gjVXWn8aTIl4gM4aRyzMz6uvIXPXLrpL1bFIdlMPk7tMur2CtCaXm8MWyoyEoZgWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com



On 10/08/2024 1:09 am, Kirill A. Shutemov wrote:
> TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
> generates a #VE when accessing topology-related CPUID leafs (0xB and

"In TDX 1.0 generates" -> "TDX 1.0 generates"

[...]

> + * The ENUM_TOPOLOGY feature allows the VMM to provide topology information.
> + * Enabling the feature  eliminates topology-related #VEs: the TDX module
			  ^
			  double space

[...]

Acked-by: Kai Huang <kai.huang@intel.com>

