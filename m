Return-Path: <linux-kernel+bounces-568976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE8A69D03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DFB7A9D39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B029A1;
	Thu, 20 Mar 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2PCyjST"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01510E5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429012; cv=fail; b=UBatUSUbtgI4wFsImcga4q3caO5Dho8AxS1+bgTB33YrvXiZ5s3HQklhpJcJbnH5JFxd/OhJs7ZUilXVyfDi104auqaVLp95bX5bUzBnlkaPsXxrvGDqo5Afqs1lO6FLoyN9xXWq77OIIBTD54lecXkSktdNjsOgMod+W0AWnfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429012; c=relaxed/simple;
	bh=fapF6Y8nHFl14u49wBtW5np3Xo6gGsypafxm/V/pMj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4+9RDL1cKl/VDvXq3s2WqK5r8TgiwiK5vo8aaqTprEOrCUL8bikyZV97hlMQ+e49cqiZrcbTJuHQJHjNCqgUi5++DsQyYzW6/K55QVBDeESgwv9/1ooSl65vTGOG5aBHSvmRWAuXXA9fNcvUEYKto6+xtoWp2W9/1ZRIrKrM0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2PCyjST; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742429010; x=1773965010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fapF6Y8nHFl14u49wBtW5np3Xo6gGsypafxm/V/pMj4=;
  b=i2PCyjSTwCk6BpJrvvZ5N3dgbra1g8MWBdlp1FXhPHxbI8ZacjplnwUL
   6mn+kC3doOuTfAGSiTGvGf8wt9TdO8PTWFXTcS4NLfMM14tHxHKZ6PVAE
   5lXYDAaNUFo2XIqmjxqPItDCBaRIQi7SLpYK0ZPZGSAKAybhghuE1J3w0
   bCK0XmaIf4Se2vspsocIdVCXaxwlJSLv24Rjmym+c0doV6BOfNAfzV3zU
   ipcd3+5CnEGCjsCujywGZfq2KNAbcsxu6tzrOwUAPgWsCa+jh30wW2zyE
   P/FidpoIYx+TYgrLgAeDDsfXriFeTTAjEUD0ibKwPbIf2ta7JruzJ5mDP
   g==;
X-CSE-ConnectionGUID: 6px0LvrTSea0t0+POs3kow==
X-CSE-MsgGUID: X0eEI9WoQIK8rDZC8OE+Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43814372"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="43814372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:03:29 -0700
X-CSE-ConnectionGUID: EnB+86I4SvGV9CVKam7cNQ==
X-CSE-MsgGUID: e6EA9WsnQluVyULNtXALzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122850228"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:03:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 17:03:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 17:03:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 17:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3gP3J+F5d2MjJOnzEMyyO2Ks/EbxEux6jiy6Q1ySMtobw4L1c6mMIzNwJObQzkSFB6bWSB1xHYgRajfAb1VyIkdwSN2RZ4O15kTACagKU+FSwInqV5ovkDM8im248Fj/4CZ19eRyT41EitTMD6bYN7cHs1ANdOFvFzRQR2h6AF2haHwCuJ+G0UpXb/PeeLsGydcXyszVbB7eYApJQ8lLUZAUwLV1sf4zYdPlRKzGKZcMPyRqHsph3VIdwgWwFFE5BHRVFYJ1jG/bxzpGGdPLEFsHFxh4CnKFrvtyOKqgfFy27vVAHMxlU7Z1wOAnM71iNCt/j8/2cS6spmh2U5igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fapF6Y8nHFl14u49wBtW5np3Xo6gGsypafxm/V/pMj4=;
 b=P3U2kKgfNsU8g0ylJu5eQ5IUMmLkZU02Ji7MdPO2Mw1rrdQpG319d6nNjdhuqNrIKVQWx+SwfLfY+yP1WYNGrw3qZcEuV3imYV234t5CKcpZBKouv/zXczwdjrkuNk9nngb5UleWI2dtIT13bXFpgSAMOfhyFhEKse88STfislFmGwBPWHMzYfBKA4lTMWGau0Xdbv+g9Q5CW4UiGUtjoj2rket/7Avwj1wnjXmNu2V+PXghqY45spDmLlrHImgOTi3jHwKGqvnFfsj6hYaFetTK4btv7Vtglx/jtS1fTIrtd5QTUYObrkKS7b3FG1RIaHnZsz08LVpP74R9QjMbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 00:03:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 00:03:24 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "Yamahata, Isaku" <isaku.yamahata@intel.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
	"bhe@redhat.com" <bhe@redhat.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0Lbd/o5JJJNyk6v5kYhZVWKCrNxaCuAgAW7Q4CAASVwAIAC55YA
Date: Thu, 20 Mar 2025 00:03:24 +0000
Message-ID: <27ffc289747106b1a45dbe2f69a1940823049c4e.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
		 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
		 <324a342417a1455633d4646b4be199aa6d85509d.camel@intel.com>
	 <23c990b979a5b46a5436279126565198ea985889.camel@intel.com>
In-Reply-To: <23c990b979a5b46a5436279126565198ea985889.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ5PPF44E8B88DF:EE_
x-ms-office365-filtering-correlation-id: 845e7552-ae2d-400d-5d1d-08dd6742a281
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFczMmI5QTNkWjZMeGlrSXQ3bVM0bFpaREtCTUppdW0zUGNTSGRnQkI5RU5h?=
 =?utf-8?B?VG9yYUc0ejRCdlNWNDcwWFB0UzJXNndnV256SXV3ZUJOTE5kM3lJcmtRVVgw?=
 =?utf-8?B?ZFJVZk5WMnJsbkMya2NPcFdrRktoZVRGNVYwTEZ3ZzhONVRFUjJqSHFreFZZ?=
 =?utf-8?B?bnhhTUtiQ0h5V0JxSWdONGF1YlVIYkROMzZhRmF2eVpnUzF3aGZiZDBTVnVq?=
 =?utf-8?B?MGMwbjlOMVhBWG9wSHo1TFdQWkxWVDJLK1RVaWxTbGQ3bmJtZXdiMWlwTkpu?=
 =?utf-8?B?amJRUTB3bGkwYUFyNkxEUDdaa2JJdEFNd1NtQ0UxVGhsSGpWSFFLOCtkcFE1?=
 =?utf-8?B?VW5VN0pyUXZ1THowU0F6dlN0QWFDUG81UUhnaDRQSjFidVdxQWVjN3RrbXU5?=
 =?utf-8?B?T3puRUxncmtFUE5kRHZoYVMxRUkrMURVMWExbDNpdXBIcU9QblA1dHM5UVdz?=
 =?utf-8?B?SEpoNVIrbVdRMU9lK1pJSy9FUWFDQmlEMXNmajcvNDQyc3ZNUGJmNEJNRi9p?=
 =?utf-8?B?dkNVNldEQWxnNE1TNkl6NU9WRHA4SStwMmNzTmF6dm4wbytZZVN1TlBiemhu?=
 =?utf-8?B?eHNyNTlnYkNZUFlEcnNiaVR5T3Y0ZlBLK2kzUEFLM2twSmVxVWRtWTBqUlAx?=
 =?utf-8?B?eEdKbXptTHFkZEdld1h5ZkIxMmwwUDdZTFpCMjgxRUk0b1N1cDFWTHhuRHFO?=
 =?utf-8?B?NERGay8vSWxkNTRyUHZMWFVxQ3VIZjZDbmtXY0VjTXBWNWczQVpteXBFRGFU?=
 =?utf-8?B?WU50M0VtN01ZTWZZNzlZWTJyLzNVcFlYRGp6YTZ5MklVM2NkeGUzdDg3VmdT?=
 =?utf-8?B?MXhubHpWSTk0SktVTTdQazlLUU5zNC9nb2F4RzArTTg1a3dxbEdwSytnMW9v?=
 =?utf-8?B?RHR4eGxBY1ovV0pKa2FYS3E0c0ZDQjNMYnlCM3BtLy80SEp1S0VxMVg3TUE5?=
 =?utf-8?B?UFhoSDNhWS9wTEd0YzFoN2V3TEd1dkl4K0pMcjdhVDM1c3BGTTF1NzZFcEZS?=
 =?utf-8?B?d1dsa0YvNDBJSXZmSStrYXNZY2ZVdC9xSlA3NmFIZVpqTHFXVkpCeS9HZHkz?=
 =?utf-8?B?c3J6UmdGSUJUMVZ0ZWp2R3VWSXRZekUxbHpobzQva2M0bno4MnZtWWErU0gv?=
 =?utf-8?B?V0diaUpITmwwQy9PVm0xNDZtTXVvQ2d1SjhIa2xONExKK2U3OFpqaFUyYTds?=
 =?utf-8?B?YmVxVGl5aXorWWxPQ0pLbFlOaytVTGxMbzRpVytsc3gxMi9zZXp2YlB6MnFk?=
 =?utf-8?B?dDlzZ3RMaG5BSEtzZVM3Q0J6bFRHSnREeUFZUXVJZFdJd2hVeDZYM2pRQnFs?=
 =?utf-8?B?M2MwSjF4aDhXMC9XemhicU5tcE9UVUFock5jblVLbUhaL2tZVW4xQXlrSE4x?=
 =?utf-8?B?UW01cXZFZUtERFJGMmFQYkpVM3hTaTRIUVBYWmpXOTVIVGp1Rm4zemRoMEJm?=
 =?utf-8?B?cmt1ZXFFUGZIQzZXWkNYbVZuTkR1UE5Ra2ZmdC9Pa1liNmpFUHo1SVNlL2ZD?=
 =?utf-8?B?a3hpVHRWMk1vbXFsTUlDMHl1dFhqR2Vvanp0QU9CNkxvYjZyellRcURVb2tp?=
 =?utf-8?B?SHZpdWl1YTdjQjdWa3BWOTlXSHFOYUVYZ3FqNEU2cWVEYnJqZUlnQ0h1WjRD?=
 =?utf-8?B?amtvYTVDdUFBaEpPUGxhODVsb3c0Nk5BWWVwYzRhREZ0OFhaekhkdTBWeSs4?=
 =?utf-8?B?Y2V3b3U0MDVSWS9UditCOGdsS2pPTmZtRWdlbitpL2N0SG53VkN2ZC81OW5j?=
 =?utf-8?B?a1pJcUFlWW9HSVYxZlFLajUrazIzTHFPUis3SVZOWGYxUFcyV1BCZ2NRVlVG?=
 =?utf-8?B?cXdmdGgwTGxxb3R2UTcyWTk1Mm9iVm9rL2VGV2ZUaDFYZVhrZmQ1Z1BUcHVn?=
 =?utf-8?B?TFVwRmZPRzdNcGw4MzEyWDUvbk5penpMelhQS3VhUVZGVE5LRmJ0UHRQV1dy?=
 =?utf-8?B?YTF6L2RLdkVxWkdMbjRDZHJ0QStPT1EzaDRnblNQOWxTcVRTT0plbXdWSU90?=
 =?utf-8?B?R296L2dMMU5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zll0MUdKTksyWDRDaXlad1BRVHFDZndRV3JCaDlsdnBmS1R1WDVwS1RHTE9n?=
 =?utf-8?B?MlVFZFYveW40K21icFpVWHo1VmJrS2V0NU5SV3V6SjJmT3pIdThOZFJROGd3?=
 =?utf-8?B?YnY0Wnc4NG1JcjRmNG91cFF5ZXhuRVJiZFI4VXc5dGd2ajZjcFdkaDN2UGox?=
 =?utf-8?B?UzVtb0hIMW5nWG00K1Y5NlJVZTdJRWpsL21xbzhCTk1EOEZDQ1pQaFV3dlA5?=
 =?utf-8?B?bitZVzJqNVZrNFdGQjRWSmJtWW41aG9BNVB4a3pxUHZtT1dneTBVTFFNZzdl?=
 =?utf-8?B?NytpdVhPdkl1OTk1Rm9xdkFJOWw4Y1FxY1hUMWNkN0RtSWhSUEVUMnhRSGZh?=
 =?utf-8?B?ME9mY2VVeW1CVUJQemlOMERWOE5LZEVBVXZ6REtsZi9qcXlid0tkU01uMUdn?=
 =?utf-8?B?K2FHMENNdzlvTWRDWHZTZEt1SXZuTHdBODVqUVJSS2llYTZMa3RkenhvMFR0?=
 =?utf-8?B?L29OdjhFZEUwQ2d2TlRyamtmdFZZaE80WFB3aGxPd0Z2eTNucjNOK2RVUThF?=
 =?utf-8?B?Y0J1ZzF3cWVHRG9oMWlybUVxS2IvN3R0cVVNQmVxbSt0MjM2VDRqajRZTTJm?=
 =?utf-8?B?VjhBdm0xa2ZzdFphZ0Z3ekRwUmxVYTVoUWpSczUreU9HLzFJQnk0cmNQZFdu?=
 =?utf-8?B?bTFwWktRcFp3NzhGYUQwV2hnNC8vdnlOTVdUb1BvNnhEamMvdGxtRlNpZGc1?=
 =?utf-8?B?UFNrSFlVd000RGpNOEhqNGcvbFIreUcyaFdPbG1KK2YvSWpFM2RqVTNNODJ5?=
 =?utf-8?B?TXNtcHQ1T0xobFdaRlpQOTc0RW11Unp3b0hzWmJvOG1qVFFOUU1jY1JnYVJp?=
 =?utf-8?B?VWhEMGNHcHd4RWVnUkhLSklrSTJycCtXMVlGMUdLckpRY1Z4SlhETUp1cGt3?=
 =?utf-8?B?RHd2Z1VkUDdPbGdDL2dQSXd1NDlBdVV3NlY3amJralV2eEJSby9ydG1LRlB0?=
 =?utf-8?B?K2kvYWlVaWw5eElmMC9BeU9Db1Y5ak5mbjF6U1l3ZW11anZDckwzeW1sZDQ1?=
 =?utf-8?B?S1JsRW1ieCtZZSt5ZDVicno3NjIvNzVPZFg1bGpkWnVUL2ZlZ1ErNHVtSmpR?=
 =?utf-8?B?WjdNc2o4NEhpTHdjUndKbC9sZktYTDU2UHpCYnpSb1N6U0RJV2hKVVM1dWxB?=
 =?utf-8?B?c0hNdXNlcGFZRjJOcU1zU2w4eWxGMlJ6aDg0YmtReHNDdk95TDdEOHY0SGRh?=
 =?utf-8?B?eHlsSzhNaEg0TzBzNi9pYkJlM04yTHc5aHNoZlFBZ2REVkNJRStJSGRTVk5G?=
 =?utf-8?B?WksvZHk5RTVLRmFoRUZJSFB2RDQxbWhlU3BNSjNJa0dwbFFYRzZaamJTWVNt?=
 =?utf-8?B?Q1UrUm1BS29lT0ZKeGtoU3ZBSFcremUyaDdUU2xDRW1JTC9KU1pJQjNaZGFG?=
 =?utf-8?B?VzJxbDVJL1NMMGIxQ2hSK09sT25DeTdvSFVDc0RWSERGRFlYZk02S1Z2eVUx?=
 =?utf-8?B?dE1idkMzeXVqTmM2WjJuci9XbHlNVE5vRlNydlpDYnVJMzNaaGIrandXeVBK?=
 =?utf-8?B?MndwZExpTWRVdkV4cWZJQzJycUZDQ1R2OStyeUVYYm5CZUlLYzZmb1BIRUVz?=
 =?utf-8?B?T3hzY0xMNkFJZ1dLaDNNNnB4aVhtSmNUTGkwM0QwZ1RnNmxsM2VTd0hDUjkz?=
 =?utf-8?B?RXJJcGpNRzU3Y3FOdDdQeTdXdjhNdXlkaUZkWURTclQ4bEg1dEtrRDN2em0r?=
 =?utf-8?B?RlJkdlZsZ3FYM3dlZnZ5bklhU0U5MGtsUzArR1drdFJHQkdDUzZQMnAwTWxp?=
 =?utf-8?B?c1lOZHNzMmJzTjhnZEZEc0JtYzJ4N01UQ1lNZWorQzVrdjNiODJ0MUx0di96?=
 =?utf-8?B?K0tXZXU4TkJHNjhRVy8rOUVSdUxjMTdwN3hheVFUWEdWblZTRk13SHFDcTFL?=
 =?utf-8?B?cEhaQmxqOXE3YmhEMTd5SkJWYWhPMEZRSVdKdStEWVZiRURmYmpTNnBOMHdx?=
 =?utf-8?B?ekNFNWdZTmRUQ0JPZ3RsTHllREVTa0ptL0RDaDBEMFpQa3ltcDBIUVpseGhP?=
 =?utf-8?B?OFZvWUhiZVFsYVgrejJUWlJJY0xRVTlVaGlBek14bWVtQUxRWDJVNGdEdHhH?=
 =?utf-8?B?OEV1NDNCNDdXaXlYODNxamEzNnovaGhjZTdyRU44ckp0V2k2WGZ2K2FDSVpE?=
 =?utf-8?B?b3Z5Y3RNQ2FwRGtGaXRzbnhpdW9mK2lJdTdSR2JkVkxNSG1GUmJzM0ZMYXB0?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42132E0E57F0E94E8C0C7C20670B1A3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e7552-ae2d-400d-5d1d-08dd6742a281
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 00:03:24.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFUruukgseL2VmQawBPOjduDKPDuQrGZgbjWjcl8gXOyoU+qrTKViGnB9DXQZTMmW8WBkrVo+j64zu7lAnRwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDAzOjQxICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gTW9uLCAyMDI1LTAzLTE3IGF0IDEwOjExICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+IE9uIFRodSwgMjAyNS0wMy0xMyBhdCAxODo0MCArMDAwMCwgRWRnZWNvbWJlLCBSaWNr
IFAgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjUtMDMtMTMgYXQgMDA6MzQgKzEzMDAsIEthaSBI
dWFuZyB3cm90ZToNCj4gPiA+ID4gVEw7RFI6DQo+ID4gPiA+IA0KPiA+ID4gPiBDaGFuZ2UgdG8g
ZG8gdW5jb25kaXRpb25hbCBXQklOVkQgaW4gc3RvcF90aGlzX2NwdSgpIGZvciBiYXJlIG1ldGFs
IHRvDQo+ID4gPiA+IGNvdmVyIGtleGVjIHN1cHBvcnQgZm9yIGJvdGggQU1EIFNNRSBhbmQgSW50
ZWwgVERYLsKgIFByZXZpb3VzbHkgdGhlcmUNCj4gPiA+ID4gX3dhc18gc29tZSBpc3N1ZSBwcmV2
ZW50aW5nIGZyb20gZG9pbmcgc28gYnV0IG5vdyBpdCBoYXMgYmVlbiBmaXhlZC4NCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XiBBZGRpbmcgInRoZSBrZXJuZWwiIGhlcmUgd291bGQgcmVhZCBhIGxpdHRsZQ0KPiA+ID4gY2xl
YW5lciB0byBtZS4NCj4gPiANCj4gPiBPSy4NCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBX
aGVuIEkgcmVhZCAic29tZSBpc3N1ZSIgSSBzdGFydCBhc3N1bWluZyBpdCB3YXNuJ3QgZnVsbHkg
ZGVidWdnZWQgYW5kIGl0IGlzDQo+ID4gPiAic29tZSBpc3N1ZSIgdGhhdCBubyBvbmUga25vd3Mu
IEJ1dCBiZWxvdyBpdCBzb3VuZHMgbGlrZSBpdCB3YXMgcm9vdCBjYXVzZWQuDQo+ID4gDQo+ID4g
SSBhbSBub3Qgc3VyZSB3aGF0J3Mgd3Jvbmcgd2l0aCAic29tZSBpc3N1ZSIuwqAgSSB1c2VkICJf
d2FzXyIgdG8gY29udmV5IHRoaXMNCj4gPiBpc3N1ZSB3YXMgZml4ZWQgKHRodXMgcm9vdCBjYXVz
ZWQpLsKgIFBlcmhhcHMgdGhlICJyb290IGNhdXNlZCIgcGFydCBpc24ndCBjbGVhcj8NCj4gPiBJ
IGNhbiBleHBsaWNpdGx5IGNhbGwgaXQgb3V0Lg0KPiA+IA0KPiA+IMKgIFByZXZpb3VzbHkgdGhl
cmUgX3dhc18gc29tZSBpc3N1ZSBwcmV2ZW50aW5nIHRoZSBrZXJuZWwgZnJvbSBkb2luZyBzbyBi
dXTCoA0KPiA+IMKgIG5vd8KgaXQgaGFzIGJlZW4gcm9vdCBjYXVzZWQgYW5kIGZpeGVkLiANCj4g
DQo+IFRoZSBwcm9ibGVtIGlzIHRoZSBwaHJhc2UgInNvbWUgaXNzdWUiIHNvdW5kcyBsaWtlIHRo
ZSBpc3N1ZSBpcyBub3QgdW5kZXJzdG9vZC4NCj4gWW91IGNvdWxkIGp1c3QgY2hhbmdlIGl0IHRv
ICJhbiBpc3N1ZSIuIEkgZG9uJ3QgZXZlbiB0aGluayB5b3UgbmVlZCB0aGUgIl8iDQo+IGFyb3Vu
ZCAiX3dhc18iLiBKdXN0ICJQcmV2aW91c2x5IHRoZXJlIHdhcyBhbiBpc3N1ZSBwcmV2ZW50aW5n
IHRoZSBrZXJuZWwuLi4iIGlzDQo+IG1vcmUgcmVhc3N1cmluZy4NCg0KKHNvcnJ5IGZvciBnZXR0
aW5nIGJhY2sgbGF0ZSkuDQoNClN1cmUuDQoNCj4gDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gPiAN
Cj4gPiA+IEluc3RlYWQgb2YgYSBwbGF5LWJ5LXBsYXksIGl0IG1pZ2h0IGJlIG1vcmUgaW5mb3Jt
YXRpdmUgdG8gc3VtbWFyaXplIHRoZSBlZGdlcw0KPiA+ID4gY292ZXJlZCBpbiB0aGlzIGhpc3Rv
cnk6DQo+ID4gDQo+ID4gSSB0aGluayB0aGUgYWJvdmUgaXMgYWxzbyBpbmZvcm1hdGl2ZS7CoCBC
b3JpcyBzdWdnZXN0ZWQgdG8ga2VlcCB0aGUgZGlzY3Vzc2lvbg0KPiA+IGFyb3VuZCB0aG9zZSBy
ZWxldmFudCBjb21taXRzIGluIHRoZSBjaGFuZ2Vsb2c6DQo+ID4gDQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgta2VybmVsLzIwMjQwMjI4MTEwMjA3LkdDWmQ4U3I4bVhIQTJLVGlM
ekBmYXRfY3JhdGUubG9jYWwvDQo+IA0KPiBTdW1tYXJ5OiBLaXJpbGwgc2F5cyBpdCdzIHRvbyB2
ZXJib3NlLCBjYW4gYmUgZHJvcHBlZC4NCj4gDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgta2VybmVsLzIwMjQwNDE1MTc1OTEyLkdBWmgxcThHZ3BZM3RwSmo1YUBmYXRfY3JhdGUu
bG9jYWwvDQo+IA0KPiBTdW1tYXJ5OiBCb3JpcyBzYXlzIG5vdCB0byBkcm9wIGl0IGFuZCBpdCdz
IG9rIHRvIGJlIHZlcmJvc2UuDQo+IA0KPiBCdXQgd2hhdCBJJ20gc2F5aW5nIGlzIHRoYXQgdGhl
IHNlY3Rpb24gZG9lc24ndCBzdW1tYXJpemUgdGhlIGlzc3VlIHdlbGwuIEl0DQo+IGp1c3QgbGlu
a3MgdG8gYSBidW5jaCBvZiBjb21taXRzIGZvciB0aGUgcmV2aWV3ZXIgdG8gZ28gZmlndXJlIGl0
IG91dA0KPiB0aGVtc2VsdmVzLiBTbyBJIHRoaW5rIGV4cGxhaW5pbmcgdGhlIHRha2Vhd2F5cyBp
bnN0ZWFkIG9mIG9ubHkgbGlua2luZyB0bw0KPiB0aHJlYWRzIHdvdWxkbid0IGJlIG9iamVjdGlv
bmFibGUuIFlvdSBkb24ndCBuZWVkIHRvIGRyb3AgdGhlIGNvbW1pdCByZWZlcmVuY2VzLA0KPiBq
dXN0IGRvbid0IGxlYXZlIHNvIG11Y2ggaG9tZXdvcmsgZm9yIHRoZSByZWFkZXIuDQoNCkknbGwg
cmVmaW5lIHBlciBkaXNjdXNzaW9uIHdpdGggeW91Lg0KDQo+IA0KPiA+IA0KPiA+ID4gwqAgLSBE
b24ndCBkbyBhbnl0aGluZyB0aGF0IHdyaXRlcyBtZW1vcnkgYmV0d2VlbiB3YmludmQgYW5kIG5h
dGl2ZV9oYWx0KCkuIFRoaXMNCj4gPiA+IGluY2x1ZGVzIGZ1bmN0aW9uIGNhbGxzIHRoYXQgdG91
Y2ggdGhlIHN0YWNrLg0KPiA+IA0KPiA+IFRoaXMgaXMgYSByZXF1aXJlbWVudCB0byBTTUUsIGJ1
dCBjaGFuZ2luZyB0byB1bmNvbmRpdGlvbmFsIFdCSU5WRCBvbiBiYXJlLW1ldGFsDQo+ID4gZG9l
c24ndCBjaGFuZ2UgdGhpcyBiZWhhdmlvdXIuwqAgV2hhdCdzIHRoZSBwdXJwb3NlIG9mIG1lbnRp
b25pbmcgaGVyZT8NCj4gDQo+IFRoZSBwdXJwb3NlIGlzIHRvIGhlbHAgdGhlIHJldmlld2VyIHVu
ZGVyc3RhbmQgdGhlIGRlbGljYXRlIGRlc2lnbiBvZiB0aGlzDQo+IGZ1bmN0aW9uIHNvIHRoYXQg
dGhleSBjYW4gZXZhbHVhdGUgd2hldGhlciB0aGUgY2hhbmdlcyB1cHNldCBpdC4NCg0KQXMgZGlz
Y3Vzc2VkLCBJIHdpbGwgbWVudGlvbiB0aGUgU01FIHByb2JsZW0gdGhhdCB5b3UgZGlzY292ZXJl
ZCBhbmQgdGhlIGNvZGUNCmNoYW5nZSB3aWxsIG5vdCBtYWtlIGFueSB3b3JzZSBmb3IgU01FLg0K
DQo+IA0KPiA+IA0KPiA+ID4gwqAgLSBBdm9pZCBpc3N1aW5nIHdiaW52ZCBvbiBtdWx0aXBsZSBD
UFVzIGF0IHRoZSBzYW1lIHRpbWUuIEFzIHRnbHggaW1wbGllcyBpdCBpcw0KPiA+ID4gdG9vIGV4
cGVuc2l2ZS4NCj4gPiANCj4gPiBCb3JpcyBzdWdnZXN0ZWQgdG8gZG8gdW5jb25kaXRpb25hbCBX
QklOVkQuwqAgVGhlIHRlc3QgYnkgRGF2ZSBZb3VuZyBhbHNvDQo+ID4gY29uZmlybXMgdGhlcmUg
d2FzIG5vIGlzc3VlIG9uIHRoZSBvbmNlLXByb2JsZW1hdGljIHBsYXRmb3JtczoNCj4gPiANCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBTHUrQW9TWmtxMWt6LXhqdkhra3VKM0M3
MWQwU001aWJFSnVyZGdta1pxWnZOcDJkUUBtYWlsLmdtYWlsLmNvbS8NCj4gDQo+IEknbSBub3Qg
c3VyZSB3aGF0IHlvdXIgcG9pbnQgaXMgaGVyZS4gVGhhdCB0aGVyZSBpcyBubyBpc3N1ZT/CoA0K
PiANCg0KSSBtZWFudCAidG9vIGV4cGVuc2l2ZSIgZG9lc24ndCBtZWFuIHRoZXJlIHdpbGwgYmUg
aXNzdWUsIGFuZCBpbmRlZWQgbm8gaXNzdWUNCndhcyBkaXNjb3ZlcmVkIGF0IGxlYXN0IG9uIHRo
ZSBvbmNlLXByb2JsZW1hdGljIHBsYXRmb3JtcyBhcyB0ZXN0ZWQgYnkgRGF2ZQ0KWW91bmcuDQoN
Cj4gVGhpcyBsb2cgcG9pbnRzIHRvDQo+IGEgY29tbWl0IHRoYXQgY29udHJhZGljdHMgdGhlIGFz
c2VydGlvbnMgaXQgaXMgbWFraW5nLiBFc3BlY2lhbGx5IHNpbmNlIHRvDQo+IHVuZGVyc3RhbmQg
dGhpcyBwYXJ0IG9mIHRoZSBsb2csIHRoZSByZXZpZXdlciBpcyBnb2luZyB0byBoYXZlIHRvIHJl
YWQgdGhvc2UNCj4gcmVmZXJlbmNlZCBjb21taXRzLCBkb24ndCB5b3UgdGhpbmsgaXQncyBhIHBy
b2JsZW0/IEl0IGlzIG9wZW5pbmcgbmV3IGRvdWJ0cy4NCg0KU29ycnkgSSBhbSBub3QgYWJsZSB0
byBmb2xsb3cgd2hlcmUncyB0aGUgImNvbnRyYWRpY3Rpb24iLg0KDQpBbnl3YXkgSSBoYXZlIHNw
ZW50IHNvbWUgdGltZSB0byByZWFkIHRoZSBjb2RlIGFyb3VuZCBzdG9wX290aGVyX2NwdXMoKSBh
bmQNCnN0b3BfdGhpc19jcHUoKSBhbmQgaXQgaXMgbm93IGNsZWFyIChhdCBsZWFzdCB0byBtZSkg
ZG9pbmcgd2JpbnZkIGZvciBhbGwgYmFyZS0NCm1ldGFsIGlzIHNhZmUuICBQbGVhc2Ugc2VlIGJl
bG93Lg0KDQo+IA0KPiA+IA0KPiA+ID4gwqAgLSBEb24ndCByYWNlIHJlYm9vdCBieSB3YXRjaGlu
ZyBjcHVtYXNrIGluc3RlYWQgb2YgbnVtX29ubGluZV9jcHVzKCkuIEJ1dCB0aGVyZQ0KPiA+ID4g
aXMgYSByYWNlIHN0aWxsLg0KPiA+ID4gDQo+ID4gPiBIbW0sIG9uIHRoZSBsYXN0IG9uZSB0Z2x4
IHNheXM6DQo+ID4gPiDCoMKgwqDCoCBUaGUgY3B1bWFzayBjYW5ub3QgcGx1ZyBhbGwgaG9sZXMg
ZWl0aGVyLCBidXQgaXQncyBiZXR0ZXIgdGhhbiBhIHJhdw0KPiA+ID4gwqDCoMKgwqAgY291bnRl
ciBhbmQgYWxsb3dzIHRvIHJlc3RyaWN0IHRoZSBOTUkgZmFsbGJhY2sgSVBJIHRvIGJlIHNlbnQg
b25seSB0aGUNCj4gPiA+IMKgwqDCoMKgIENQVXMgd2hpY2ggaGF2ZSBub3QgcmVwb3J0ZWQgd2l0
aGluIHRoZSB0aW1lb3V0IHdpbmRvdw0KPiA+ID4gDQo+ID4gPiBBcmUgd2Ugb3BlbmluZyB1cCBt
b3JlIHBsYXRmb3JtcyB0byBhIHJhY2UgYnkgdW5jb25kaXRpb25hbGx5IGRvaW5nIHRoZSB3Ymlu
dmQ/DQo+ID4gPiBDYW4gd2UgYmUgY2xhcmlmeSB0aGF0IG5vdGhpbmcgYmFkIGhhcHBlbnMgaWYg
d2UgbG9zZSB0aGUgcmFjZT8gKGFuZCBpcyBpdA0KPiA+ID4gdHJ1ZT8pDQo+ID4gDQo+ID4gSUlV
QyBpbiBtb3N0IGNhc2VzIHRoZSBSRUJPT1QgdmVjdG9yIHdpbGwganVzdCBkbyB0aGUgam9iLCBz
dG9wX290aGVyX2NwdXMoKQ0KPiA+IHdvbid0IG5lZWQgdG8gc2VuZCBOTUlzIHRodXMgSSBiZWxp
ZXZlIGluIG1vc3QgY2FzZXMgdGhpcyBzaG91bGRuJ3QgaW5jcmVhc2UNCj4gPiByYWNlLiDCoA0K
PiA+IA0KPiA+IEkgZG9uJ3Qga25vdyB3aGF0IGtpbmRhIHBsYXRmb3JtIHdpbGwgbmVlZCBOTUkg
dG8gc3RvcCByZW1vdGUgQ1BVcy7CoCBGb3INCj4gPiBpbnN0YW5jZSwgQUZBSUNUIG15IFNQUiBt
YWNoaW5lIHdpdGggMTkyIENQVXMgbmV2ZXIgbmVlZGVkIHRvIHNlbmQgTk1JIGluIG15DQo+ID4g
dGVzdGluZ3MuDQo+ID4gDQo+ID4gRGF2ZSBZb25nIHRlc3RlZCBvbiB0aG9zZSBvbmNlLXByb2Js
ZW1hdGljIHBsYXRmb3JtcyBhbmQgZG9pbmcgdW5jb25kaXRpb25hbA0KPiA+IHdiaW52ZCB3YXMg
ZmluZS7CoCBUaGlzIHBhdGNoc2V0IChhbGJlaXQgbm90IHVwc3RyZWFtZWQpIGhhcyBhbHNvIGJl
ZW4gdGVzdGVkIGJ5DQo+ID4gY3VzdG9tZXJzIGluIHRoZWlyIGVudmlyb25tZW50LsKgIEkgYmVs
aWV2ZSBkb2luZyB1bmNvbmRpdGlvbmFsIFdCSU5WRCBpcyBmaW5lLg0KPiANCj4gU291bmRzIHRv
byBtdWNoIGxpa2U6ICJTb21lb25lIHRlc3RlZCBpdCBvbiBhIHBsYXRmb3JtIHRoYXQgdXNlZCB0
byBoYXZlIGENCj4gcHJvYmxlbSBhbmQgYXQgbGVhc3QgdGhhdCBvbmUgaXMgZml4ZWQsIGJ1dCB3
ZSByZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHRoZQ0KPiBpc3N1ZSBpcyIuDQoNCk5vdCBl
eGFjdGx5LiAgSSB0aGluayBjb21taXQgMWY1ZTdlYjc4NjhlICgieDg2L3NtcDogTWFrZSBzdG9w
X290aGVyX2NwdXMoKSBtb3JlDQpyb2J1c3QiKSBoYXMgYWN0dWFsbHkgZml4ZWQgdGhpcyBpc3N1
ZS4NCg0KQUZBSUNUIHRoZSByb290IGNhdXNlIGlzIGR1ZSB0byBiZWxvdyByYWNlIG1lbnRpb25l
ZCBpbiB0aGUgY2hhbmdlbG9nOg0KDQogICAgQ1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIENQVTENCiAgICANCiAgICAgc3RvcF9vdGhlcl9jcHVzKCkNCiAgICAgICBzZW5k
X0lQSXMoUkVCT09UKTsgICAgICAgICAgICAgICAgICAgc3RvcF90aGlzX2NwdSgpDQogICAgICAg
d2hpbGUgKG51bV9vbmxpbmVfY3B1cygpID4gMSk7ICAgICAgICAgc2V0X29ubGluZShmYWxzZSk7
DQogICAgICAgcHJvY2VlZC4uLiAtPiBoYW5nDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgd2JpbnZkKCkNCiAgICANClNvIHRoZSBrZXkgaXMgdG8gbWFrZSBz
dXJlIHRoZSAicHJvY2VlZC4uLiIgcGFydCBjYW4gb25seSBoYXBwZW4gYWZ0ZXIgYWxsDQp3Ymlu
dmQoKXMgYXJlIGRvbmUgaW4gdGhlIHJlbW90ZSBDUFVzLg0KDQpUbyBhY2hpZXZlIHRoaXMsIHRo
ZSBhYm92ZSBjb21taXQgaW50cm9kdWNlZCB0d28gcm91bmRzIG9mIHNlbmRpbmctcmVxdWVzdHMt
YW5kLQ0Kd2FpdGluZzoNCg0KIDEpIFRoZSBmaXJzdCByb3VuZCBzZW5kcyBSRUJPT1QgSVBJIHRv
IHJlbW90ZSBDUFVzIGFuZCB3YWl0cyAxIHNlY29uZHMgZm9ywqANCiAgICBhbGwgcmVtb3RlIENQ
VXMgdG8gc3RvcDsNCg0KIDIpIElmIHRoZSBmaXJzdCByb3VuZCB0aW1lcyBvdXQsIHRoZSBzZWNv
bmQgcm91bmQgc2VuZHMgTk1JIHRvIHJlbW90ZSBDUFVzwqANCiAgICBhbmQgd2FpdCBmb3IgMTBt
cywgb3IgZm9yZXZlciAod2hpY2ggaXMgcmVxdWVzdGVkIGJ5IHRoZSBAd2FpdCBwYXJhbWV0ZXIg
dG8NCiAgICB0byB0aGUgc21wX29wcy5zdG9wX290aGVyX2NwdXMoKSkuDQoNCkZvciB0aGUga2V4
ZWMgY2FzZSwgdGhlIGtlcm5lbCB3aWxsIGp1c3Qgd2FpdCB1bnRpbCBhbGwgcmVtb3RlIENQVXMg
YXJlIHN0b3BwZWQsDQpzZWU6DQoNCglrZXJuZWxfa2V4ZWMoKSAtPg0KCQltYWNoaW5lX3NodXRk
b3duKCkgLT4NCgkJCW5hdGl2ZV9tYWNoaW5lX3NodXRkb3duKCkgLT7CoA0KCQkJCXN0b3Bfb3Ro
ZXJfY3B1cygpIC0+DQoJCQkJCXNtcF9vcHMtPnN0b3Bfb3RoZXJfY3B1cygxKQ0KPiANCj4gSSBo
YXZlbid0IHRyaWVkIHRvIHVuZGVyc3RhbmQgd2hhdCByYWNlIHRnbHggd2FzIHNlZWluZywgb3Ig
d2hhdCB0aGUgY29uc2VxdWVuY2UNCj4gaXMuIEkgdGhpbmsgd2Ugc2hvdWxkIHVuZGVyc3RhbmQg
YW5kIGV4cGxhaW4gd2h5IGl0J3MgaGFybWxlc3MsIGVzcGVjaWFsbHkgc2luY2UNCj4gdGhpcyBi
cmluZyBpdCB1cCBieSBsaW5raW5nIHRoZSBsb2cgdGhhdCByZWZlcmVuY2VzIGl0Lg0KPiANCg0K
QXMgdGFsa2VkIHRvIHlvdSBvZmZsaW5lLCBjaGFuZ2luZyB0byBkb2luZyB3YmludmQgZm9yIGJh
cmUtbWV0YWwgb25seSBpbmNyZWFzZXMNCnRoZSB0aW1lIHRvIHN0b3AgcmVtb3RlIENQVXMgdGh1
cyB0aGUgcG90ZW50aWFsIGltcGFjdCBpcyB0aGUgZmlyc3Qgcm91bmQgb2YNCndhaXRpbmcgbWF5
IHRpbWUgb3V0IG9uIHNvbWUgbGFyZ2Ugc3lzdGVtcyAoYWxiZWl0IGl0IGRpZG4ndCBoYXBwZW4g
YXQgbGVhc3Qgb24NCm15IDE5MiBDUFVzIG1hY2hpbmUpLCBidXQgdGhpcyBpcyBmaW5lIHNpbmNl
IHRoZSBzZWNvbmQgcm91bmQgb2Ygd2FpdGluZyB3aWxsDQphY3R1YWxseSB3YWl0IHVudGlsIGFs
bCB3YmludmQgaGF2ZSBiZWVuIGRvbmUgYW5kIGFsbCByZW1vdGUgQ1BVcyBoYXZlIGFjdHVhbGx5
DQpiZWVuIHN0b3BwZWQuDQoNCkluIG90aGVyIHdvcmRzLCBBRkFJQ1QgdGhlICJyYWNlIiB5b3Ug
bWVudGlvbmVkIChwcmVzdW1hYmx5IGl0IGlzIHRoZSBvbmUgSQ0KbWVudGlvbmVkIGFib3ZlKSBj
YW5ub3QgaGFwcGVuIGluIGtleGVjKCkgYWZ0ZXIgY2hhbmdpbmcgdG8gZG8gd2JpbnZkIGZvciBi
YXJlLQ0KbWV0YWwuDQo=

