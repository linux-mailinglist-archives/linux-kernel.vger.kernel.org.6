Return-Path: <linux-kernel+bounces-350787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3169909B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E207FB2475A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F61CACE0;
	Fri,  4 Oct 2024 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOKkGL3t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4DD1C7292;
	Fri,  4 Oct 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060752; cv=fail; b=lmQsrZA+J/RhhOlxdTa0QCrqm33EXo03ZnX2hLqiU1q9dFucdjf6mQk3vh61gYVnItXMJg+xH6huA73nfGm2QZ4dF6HYD3XubW59eOxTq1pnJdef6JbqUeQlKJRSCU9OOx7tjs+4yU7zKzZ7U87PV6euM5Zal+rVJEfvQA1VpXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060752; c=relaxed/simple;
	bh=ZQT59fUULUI8BStaW66UOceK5w2z7QWx5i/1OwJMQSQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ln7Zr32YVtprMnv+FMGI3vdXXAhC3k+IwQ/SyS6EAr5Eqk/EUuR5vMI+6vPzN2mdLlcC9X42Y5B3UoT6W/GqLUQlJP7MscdztEGFz7X5RpTGWZ0jZMQc/kImspTm/03+vQRdiPIs6/y8SeWPyaZ7iuKw8nKXQjzDvVQGANyjJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOKkGL3t; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728060750; x=1759596750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZQT59fUULUI8BStaW66UOceK5w2z7QWx5i/1OwJMQSQ=;
  b=OOKkGL3t0J5zLBmE6E2XYqZ7wnmtKnnAdF6TK9dQzE7vkvpYUbyaSZYB
   I62S4e7hHTSF4Xbj2MD6ZD4+fEf2vTNu7RDWFMGbC5IJF+q4ghRoInHHd
   MQkxKG7gE9ejemtnmj+VUFNuEPZ7blkOLocdfCmQOzm4yXRzTCwWm6c38
   q1yvgNpvpGuF7n0a/MH+emQnV9NhUg26vwDHewL0ZN40cdaFfD8szVHQK
   t/Bc3Ws3l2ziv6szYGVOnreiFFaHzODQfLaj8UyLBramcnT8X4i3amCYB
   zBAcylTEuhXWkorlF2Cw1IOY6MCB/G08ltEkd9A+aVdMOYXn63lPUGQS3
   g==;
X-CSE-ConnectionGUID: Fz9u3JjXSOyxnwBUXEFx/A==
X-CSE-MsgGUID: kFKNlyKxS82bVdgycNqe7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37858495"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37858495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:52:29 -0700
X-CSE-ConnectionGUID: k595nYMcQI6ie5jjcdcU/w==
X-CSE-MsgGUID: TYTe1wvsQNSBLrNo7XRl5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74349948"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 09:52:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 09:52:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 09:52:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 09:52:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 09:52:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 09:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmlz0vI84qyp1iQzdbYmdd5a1BZpmjOI8Yn8XdF7DQ/EifwPViXx3+zszcWZGmeDv/i7OL19h4/4pnpFFR+LRQcnyVkaJcJXhxsWapP12eLbTMletU4AO0exrYSeSEm7rJUAZmUsXju/RNoXhXXVyoagkpS05mlGUoF8t+2fXm7EmqiMMZvVP/Ve+dXdHBb3tgBmH7rH4h7IrvEIHRayxwFS8VWPNj79VFhUVWMmYeUzMHgX2zdn3xGIoeh+c/T9l0zwV0fTeMHws4lqQwYG/iDZFXpTzQqzHFbiPUD+aSBL756sJN0fl9yuK0x7Y/oXwldcSb25bZx1Rot1ns0H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fBvQxcjZiDXHu8JjRe0lxh8K5XwZdmObh/kdiTWFck=;
 b=DeSnG+AgnJkvrQYA+LpWcVWOdJnxVbvoyyw1ZOa0afiquGSXIRNew8KqtX9C0CWSXjyHwBGuTQ1Nl12Q0lMSo/r75taV2/m8IKKmwJeEWR2Q7mcD1+A6rAekbOi8cA/Fc6tD0atDe7YpvguoTA87HcA+2uu5Y5PHwujJHBbR+/XMymnT4hqrIzbqhKpiRv8jbr5UcG3x3pJWUpfYAY9Kq/jTjzsbwd5eUM7MAPdm1zrWerUtRf/sFE/gHH8n8Ro60QrjZk/dv43U1tFUtyHvhzkUq/UilgA+2NaTbAFfZLO8VPEap19//RdVIJJdCw0rC62Mvdt34xloeMX5nPOwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 16:52:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 16:52:24 +0000
Message-ID: <4c212746-6d61-44aa-abc6-2d2155ee538f@intel.com>
Date: Fri, 4 Oct 2024 09:52:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
 <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
 <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: 11087002-7d22-4657-9825-08dce494ebef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXBGTFZjTURSd1pIcDNTRG5XYldOUFpjb3RvTHhVWG9sWG1ueVJuTU8vY0dn?=
 =?utf-8?B?bjM3RUZaVUNsZGYxbWlwVFFjalREeVkzQW1zVTNDQXE3VEpsU0IvRkl6T3JM?=
 =?utf-8?B?WS9YTHgxMGMvMnlKNDJYMXY3YmpPT0hkUG1aTVNucG5STFVXMUtVWVVvMnpU?=
 =?utf-8?B?NUg0UUZhM0N5M05Gc1A1UUxqNEVNZGdFbzRoazdBc0o0bi9ocU0xVzZrNEZJ?=
 =?utf-8?B?SEpDNXJSVUNpbElZNVdScnZUdDZXRzZZODNmbVc3QUE3U2pMUTlJSUoxTnk3?=
 =?utf-8?B?dHJjbytSYStlZllXekZRUHZqM1pJMlA0NFJLWHhJM1Ewemw1L05zVGpGQU5F?=
 =?utf-8?B?dkk2QitueU1OSHZXSit4L3BIdXgvWnVDY1phaVNLVlFmcENrTk1odWYzSHcr?=
 =?utf-8?B?YXpjeExDVk9mOWtaM0dhdFhNOTRwK0lpazZwalJqUCt6RkJuVzFWOFJnaklP?=
 =?utf-8?B?alBaa0Z5V3YrM3doOURUYWNQNHZlajJEMlk1WnhhU0x3K1F3cUxOYWhmaFJr?=
 =?utf-8?B?YVdRQm9JWTlodVhlQkZ3WmdFeG16L1FWU3YxOUE5cjI2SHFLMVJwS0x5SnI1?=
 =?utf-8?B?SFJrUTFKY2dpNXlBUGlObXFJQzdKQjJsY2pFM2NEOW45NE5HRGpWdTF6WndH?=
 =?utf-8?B?VFJDeEFPaktMTE16RHB6bitKeGg2UlRSMmY2T1UvUlFVa0dUQkhueU5Menht?=
 =?utf-8?B?d1NZMmVsRmRFWFllckdSa29wUVVoY3lqT29taVl1Skc4NmlSKzJnK1Y3SVFt?=
 =?utf-8?B?OFRYSHN5bDZSdUMyRlV0K25raTJjNGMvcVVnbHRnQlVKTkpuZXFoRnBuSEpi?=
 =?utf-8?B?K2xEVUova0dRdFNObmJZeTFUMlQyUjJZdE5GQkhJUUIrSkFnYmQ0SGFQa29a?=
 =?utf-8?B?aExHcWdsK2dlNStuK21nSFZlMWlOMUhBeUcvVCt5NnRvWW9uaUxWaTdKN0FI?=
 =?utf-8?B?Z0lzditPbWYra2hKSnprVlhBYTIxL3NsVXB2aG40K1YvRmRyMk1iR2tYYSth?=
 =?utf-8?B?Q0JZZjZtUGhQeWZTcGNqQ3JsVUlqcGF3WEZOWlkraGxqeDhYRjBHYkFkbXVz?=
 =?utf-8?B?NDl5ZzdFVlphS2J5SlBTTW5iYUtHaktJOXRldm1JSXY5bG81NVdEWjVUMnha?=
 =?utf-8?B?aUxBcVpUSGdXUXFtR2REVzRKaHZIYTlrWHRBekgweitMTys1N2UrSnVvUHRS?=
 =?utf-8?B?eWg0Zy9kTTgvVGcyeVlzTHFNbUFiclhqSkRiZVl5Q2FkT1ZtQW15M3Vva053?=
 =?utf-8?B?eEc2aVVsbWVpazNhSjZKaDE4R0RlcThyNDJ1Q1FwQ09ZSWJvT2pxeWUvU2RZ?=
 =?utf-8?B?TmtjWmZvckNuajRFSndwSGNwbDd0eG4vTlZCRnhiZjd0RzJGTVkycENjNjJH?=
 =?utf-8?B?T09PZGg3czYwNEZyZEFjL29Udkw1SmZQaUUrYmhGbWtNK3p6cEhOdWNSWlFB?=
 =?utf-8?B?Y1JCbVFQdVdJTXJWY3N4dDcyTnRMejlERXFwSmxnUnpqdDBKMFN5eFp2VEtW?=
 =?utf-8?B?R2swTUZSUDIrNWhpeGlVSE9lK1NVZnVZUnY0bWNDVE1HaG51emRhaGJuWFVV?=
 =?utf-8?B?Z0dZa0l3RTJrb0RrRVdrUzlaYkZuRk9vM3JWQlh4NXlaZUtHQTVzQU9hcFZy?=
 =?utf-8?B?bFZtY1RxZ0Y2cmo2TjlYMVZiazlaUzJGeE00MFBjb3kzV1NrZ0JiYkVpRHRB?=
 =?utf-8?B?TmpTSldVMnQwckFVUmlPSE8xdEdMV04rZkd6TkhhcXQ0TTAwVlFXUWp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDNGU0FMcHIybG5iRmRscE9LMHB0MUg0SDRXVzRLTHNMekpzQU5PTElFbGxX?=
 =?utf-8?B?dS9mUldkWDJ5Tk5QRFg3VTFrcTJVWmtPQll2RVVjanU1RG5oMFI1OFdTWUFj?=
 =?utf-8?B?N0JQTm0rUWIrNzlqMFFqWEduZWRFQUQra3NVRzFPeVNxbTZCWkJ3SGRzMEFi?=
 =?utf-8?B?Rk0rUmhoWittKy9BZFZxajltTDR2eFQ1eSs5MHJ2UUU4TmF4bnphQVU2TWtW?=
 =?utf-8?B?eGIyUTg1emNodFRta0ZWLzNLYzRXbkptNld0ZEV0bXkrT2xzL0hla1hZSTln?=
 =?utf-8?B?eHhnK1Fhb3Exd2FITDFVVHVYWG1zVnlaUHFJc1VTTkN0NENNNHVjVW9ZazNw?=
 =?utf-8?B?djhzeG05TXhQTXhTQ0gxcHFsditXZ1ZiVmhVY09iNEU1WUtuWjFHTTc1N2Fn?=
 =?utf-8?B?bC9TSExCVThjeDdEeG4vL0l6UllFUFR6R25IRDFxTEVzekFJNm1DWGsyRGo3?=
 =?utf-8?B?MTl1MkZRM1VJVURweWhMZ01qTnBKbmlDTXFmbTI0R2lISXZ3ZkhmeU9ZYzFh?=
 =?utf-8?B?RDlSSS92ZnduS3BycVNRWWVmc2RKRHgvREdJYlRsMXZVZDh3UE93bkZ4cmZP?=
 =?utf-8?B?TlpKUmxiQlh4MG1zbmt0WE9QZ3B0UmlCc1dNUW03OUp3ODBtbkpYcVNjckF3?=
 =?utf-8?B?cXNjRVVpU3pkT3NYTVdMWFJaWlJPK3ZSZVF6QytrZi85SnoxRHBUUEJXejJM?=
 =?utf-8?B?U29TSHdlLzI3Mm4ra1NZU2FRREVXOG9yTEF2U0NpWFpEUVZ4SmZJcmpud0dI?=
 =?utf-8?B?SWZUU2hXMm9ObVE4M2tQY1BTbGVadTI2a3o1S1p6c00xVTdNNHVCcXZ6NDJ5?=
 =?utf-8?B?WjdZRUdET3l1MEdVcUo0VGIybndObXpyVXdlZXlPU0FVVkRoMnY0STgyeko1?=
 =?utf-8?B?TWtMTDQrbGhrQXliRGNoNWNNaEFXS1UzZjJ6TFJzbVVJK0hvY3plU0I3WVFF?=
 =?utf-8?B?d0FqaTJhb1F2RENFTFhlaTIxZFNRQjhBSVdxcVNTSkoycGxtZFJWZXhxdHJl?=
 =?utf-8?B?Rllad0ZrdFhydXdDQTg1d21FUlFxdTZuSThLUUJqYTdyYTc2TWNxMVBNRTFj?=
 =?utf-8?B?SWhjdmFhbXJkQWZNbW1UbklIZWxoNnp1SnNUNDVxOU5uemlsMXpSY0FzQXBi?=
 =?utf-8?B?eGhnSDRlTnFLSWRFcHdVZDExWGtGMldoZkp4UG43ejVvdVRIUHpud01OL0M3?=
 =?utf-8?B?VFVoWTkrejdsYWNqa1FNVWJnMDVNNkV3aG9lSjlGNHh2aUtGL0xyT0l2Y3k5?=
 =?utf-8?B?VjgrSkQ3V3NpeC92QkgzUWpxSUhKYW16N2lkUEpmU21qUVpQZFVNYUhSRU5I?=
 =?utf-8?B?aHVLSVlBbm00MGJRa0J2VDBuOFhHcUZyY3JBdng2Q2dENzVIWmtiLzVITHBO?=
 =?utf-8?B?bGhEejZ6bUZiWXZ1U1FvV0Z4SzQvQjNVKzJJZCs2WTNheXRBK3YxQmhvVGg5?=
 =?utf-8?B?TWFuTTcxWThwWTNUTXkrbzRFVTRWUWZKcHpibm5QSUVZejNPdzhFNHVOVmVy?=
 =?utf-8?B?OHU2c0ZIRVZpQ0FVWDdwb1VZYkxOQlVCOWlFbkhqZ3h2U25lQld6ZHl5Ykw4?=
 =?utf-8?B?a0VnSmdpS3Byb1ArdXVzeTlvMTZwcml1MS9KZFM4WXlIbThlNWJaR2lLNkxn?=
 =?utf-8?B?dFVqSmZ0ZzV4cjVDVE95S1l6QW1FT2d6VE9GQ3V0eHdsMU96SXg3TXl6Q0M2?=
 =?utf-8?B?NHBKUHJ1R2JoRVdod3Z4MWdLT0JRdXFreWlYUkNlK2ZmdlM4b0FuYlNLeVFn?=
 =?utf-8?B?L3ZlU0ZBTzRpN2F4eXRjWkw1VDNpeDdHelpwdlQ5U0k4QXVjSW5QMmVuN1M1?=
 =?utf-8?B?UjN0T0Q4QS94cmZRdUFjeHUrV09tTTBLZ2c4bHF3MUphdWQ5UGdmN1AxNU5V?=
 =?utf-8?B?b1BRakhRRkE0SmtDMGF3blhLRWdkdEh2UlB5R3MyKzRyUjFIN1lOL1MwRE0v?=
 =?utf-8?B?ZzY1R3BrSTJCRzJQV2NBaXRzOXpQeU9GZHNLbGZvWDZES0Mxd2JkeFlNNWpN?=
 =?utf-8?B?WVU2L01IT1VxNnFMWHJPWWVVNkROcTVsNFhEU2I2WUhqa04xMkQwSXdhRHB4?=
 =?utf-8?B?aVNGZG8xcTFkVUpsbWlZOHZPZmVVaUtsTDBGbGtnK2QxOTNrNmdUeEt3K1R3?=
 =?utf-8?B?eDByWHBEbTR4ampXWExZNnVBNVl0bDRFVXhleGxEdTNvQldLYm1uMFVYc3Rl?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11087002-7d22-4657-9825-08dce494ebef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:52:24.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxQIDn6UCbQyEjpJf30mlBk+UMMIPe1a0YaG9Whm+lR6pdcNR/12MLcBHXjOoTQQAzwV2byN2Uvg72VuI91SVUGcNZNU2JEE5ZQ1DlVDN4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com

Hi Babu,

On 10/4/24 9:38 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/3/2024 9:17 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/3/24 6:11 PM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>
>>>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>>>        Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>>>        Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>>>        Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>>>        Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>>>        Removed ABMC reference in FS code.
>>>>>>>        Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>>>        Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>>>        Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>>>
>>>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>>>
>>>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>>>
>>>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>>>
>>>> The last sentence is not clear to me. Could you please elaborate what
>>>> you mean with "are assigned earlier this action"?
>>>>
>>>
>>> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.
>>
>> hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
>> "domain=lt" or perhaps an expectation that counters should be assigned to the two events
>> and then immediately unassigned?
> 
> Yes. "domain=lt_" should be "domain=lt".
> 
>>
>> Giving user such flexibility may be interpreted as the assignment seen as acting
>> sequentially through the flags provided. Ideally the interface should behave in
>> a predictable way if the goal is to provide flexibility to the user.
>>
> 
> My only concern is adding the check now and reverting it back later.
> Basically process the flags sequentially and don't differentiate between the flags. I feel it fits the predictable behavior. No?

This is the point I was trying to make. If flags are processed sequentially then it would be
predictable behavior and if that is documented expectation then that should be ok. The problem
that I want to highlight is that if predictable sequential processing is the goal then
"domain=_lt" cannot be interpreted the same as "domain="lt_". When flags in "domain=lt_"
are processed sequentially then final state should be "domain=_", no?

If sequential processing is done then "domain=_lt" means "unassign all counters followed
by assign of counter to local MBM monitoring, followed by assign of counter to total MBM
monitoring". Similarly, "domain=lt_" means "assign a counter to local MBM monitoring, then
assign a counter to total MBM monitoring, then unassign all counters".

If this sequential processing is the goal then the implementation would still need to be
adapted. Consider, for example, "domain=lt" ... with sequential processing the user
indicates/expects that "local MBM monitoring" has priority if there is only one counter
available, but the current implementation does not process it sequentially and would end up
assigning counter to "total MBM monitoring" first.

Reinette
 


