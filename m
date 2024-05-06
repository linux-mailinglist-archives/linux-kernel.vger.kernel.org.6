Return-Path: <linux-kernel+bounces-169439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181D8BC8AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279F128238C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F80140394;
	Mon,  6 May 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJNj6GAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E852942A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982027; cv=fail; b=O4ya9LsRc1yTjUBsD17AcDGPi5JrPBe+NgRNSj8yr2WQGbFp3HR2QI5lIwDak6EHiYIEgbvAFoq7vQ083Wxa2NNhVa708+C+0uV8L3brIHWwpGb/A1hAlBf+qABv35FEfHOpU4bYAY5fyLsr/KzTHydBTfz/XbwErJi5zy7HUGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982027; c=relaxed/simple;
	bh=NQiByLjmcks4t0AjalKeqNZwc/zPTYxUTOVTSoXHSgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IT5nibblHw1Hd6sQuOXJEsHSv3oUp/ExgN9V5ZT3hV14UU8TbXPiwsgB+C6wLDzRohW/u0vIEEk3aLuRHupYZ8MAFT0y++a4YFfC86qPCwMvmVzbHVA8GCArdv+BJDIPDzFVFaJY7jzgwLEQLVzYtz5a0T9fzZ1WLzt9ppgfouo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJNj6GAp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714982025; x=1746518025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQiByLjmcks4t0AjalKeqNZwc/zPTYxUTOVTSoXHSgs=;
  b=hJNj6GApWES2T6mUbXI9jyCwV5HAt35s5owJbPkxnCg+S7ReMen8EbSW
   4FMwuzh7+9fdcHf+048WiFUSEY716xYFwiOzjx27RedTsAuesxHP7yqyZ
   VODornphT7Eek3K+sQDbCBSMe+NOSzaiFT/ksVkNfF46HwAcE1PTc7mFk
   Zw9dFg4enTY8fqFcts8dxRzVAQS5LMZHXOtZ8WzwU5JBv5X5GiA3ww9TB
   RLSN9oACplbhSmgd5fQrWTpt2Nt1PQnfMi9lP5o2RAYQHgPEdTKNAkAuA
   Aa+tJiTqeKgQOqnSBTTqnCBcRg1tq5xXfKZxBL7S7Pzle0dlqnM3S6wkJ
   g==;
X-CSE-ConnectionGUID: gs2EYBhhQ8SzYUsgkuMyXw==
X-CSE-MsgGUID: TSCu+LV/TaGInEizC+50kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10596887"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10596887"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:53:43 -0700
X-CSE-ConnectionGUID: 6229SamzQKmx0yqdPvlEsw==
X-CSE-MsgGUID: pqhkuptaRayxgKiiT5R+kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32755936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 00:53:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 00:53:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 00:53:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 00:53:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 00:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWRazIfniGa8cHdPEC7qqrQB2uEPsXC5dDYtytQejxAovtnmyamyy/Gt8QSKknS3pK5Fz9G9bSYq1hoGNIBtYc/wbZdRDnvkNF9qQ7FGnT7IPs8QLxU3sHccPHJYTPTNE+HNbpM31hfhAvGUW6I8u9b4W9Jd5QOwYSADIy1AFDFgP/aux/Wo+f13hJL93+frdZIoHVLgGrUFih8DaIG7RjXdrTr9K7fEXmczVBeayHnBGI/YIlskVSgyMXLGsFE00DaOxdfGYcgBn35qiTtsgDF13EOtez8tIe+ld2jDWGh2I70lkupwvwJ84Jmz9XRwVIaPx+akDkkOV11Zw1mmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQiByLjmcks4t0AjalKeqNZwc/zPTYxUTOVTSoXHSgs=;
 b=XkswZ+G4cZoo7i6UiiQlhEVPLOZP0S9qdQgPUv70xvJMwy8WdSjXb4rAq1yKcWLv/wMbZ0MZAzzeA8DjDDoY0+AcC6couv+7qoqh1gIL9wMJbBAkotl+lQiY5CWsk8zmKxnwfeJi8dVLrS032+EPUlOnlcxH8BXpla85LvcEE75qCmN16BBvewLeQEX/3vXTXZu9ymxyjOmRvIZmgK6l9CeAm3NC9nY0cskSiuln7B0noniFAHRU8cirfl46R6kkA9+fvIqd18V9S3R5DpIkHNwVVAAZ1dZEulvfLQmsswWSK/53B7oP1gdbb9eTRLXU0CLH/SMhUHGMTUX9WlsJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 07:53:39 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:53:39 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>, Alexandre Ghiti
	<alex@ghiti.fr>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>
CC: "jerry.shih@sifive.com" <jerry.shih@sifive.com>, "nick.knight@sifive.com"
	<nick.knight@sifive.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	"andy.chiu@sifive.com" <andy.chiu@sifive.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "cleger@rivosinc.com" <cleger@rivosinc.com>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "Li, Haicheng"
	<haicheng.li@intel.com>, "akira.tsukamoto@gmail.com"
	<akira.tsukamoto@gmail.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Thread-Topic: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Thread-Index: AQHadTFZCj1OJ7zmTU2s78nLDHdNIrGFvQQAgAAA+YCAAAwJAIAAGGcAgARGtHA=
Date: Mon, 6 May 2024 07:53:38 +0000
Message-ID: <DM8PR11MB5751E4193D7B73B17DB7D7FFB81C2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
 <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
 <4bc238eb-410b-46b1-98e1-4aaa35e34404@codethink.co.uk>
 <daa955d9-b554-4e0e-a08e-835c4cd5a366@ghiti.fr>
 <4a04a462-3eab-4382-83b2-ce6ed7104883@codethink.co.uk>
In-Reply-To: <4a04a462-3eab-4382-83b2-ce6ed7104883@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: bbd71075-4c21-4fb2-1adc-08dc6da1a41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?THFMekd1UVpmR2t4WWxQamZyQ21DVUlPSElYaVZQUTV2VlBLQ05JbS9BYkF6?=
 =?utf-8?B?aGE5U0czY3p6NEVIdmRaUGNTbnRLQ1k5V3BNdVFoa284aXlyQnFGSDQrd1pk?=
 =?utf-8?B?V0swbi9FVXdBanFxbnlBakM4dCtLaFZTcHdPbXhBL2s0ZlRad1VYMXhBdlVw?=
 =?utf-8?B?c09sMUxQVTljVnQyUG1tVkp3TmtZbEZtcEduODhrS1l3dXJOVStoL2gvM3JX?=
 =?utf-8?B?NnBJRTBZdGRkcWNhandMWkdZT1NKSzFXSkZpNG80ejZGbTVCeHFCV1FENllX?=
 =?utf-8?B?VWxicjRrN2Q2cWdTRlZBQTU1akdKbDBWQ3NJSklOenowLzFoRHNtWWpHazZz?=
 =?utf-8?B?K2dNR09XOWtBako1TGtMVzJrdDFhU0FmRDFNMTg3YzZZTUZWMkRrbXg4K1FU?=
 =?utf-8?B?aU80U1dRUFZoQVNqdEY5Z1pzWThOUTltSGZYL0dlcTl6Wk5uUWRxUUYzaDIv?=
 =?utf-8?B?Zk9KZUNWMHF3M0J2SkF6QllCRHNEWldld21sdUJIT3k4VlVVclNmRldPbFpL?=
 =?utf-8?B?M0FOclF1NGpDcGdEdjAxQ3Mxa2JzWnBPTXhSZms0cUtNNHMxcnBiTVlEU2JC?=
 =?utf-8?B?ZDR0elBhUzBLYi9HYy9CNEVtUDlveG40MG9Cbk9Lc21DeXppTmkzdFBDamJw?=
 =?utf-8?B?ZlQwUXljSTJySG43QXlGWEZRMUFxMDlMcWJHMWJLdldoVGZuUGxqSDhsMGN1?=
 =?utf-8?B?MTJ3QzBKYWVkcERhbVlNUDBoZlArWEwyQjgwckhMQ1FOYVBzdGttalNwSlRW?=
 =?utf-8?B?WjZ1MzYxbmtnYjBYU09sWktMZ1BIOTV2WUN1SUtNa29EK3huUXhoQm9obXl6?=
 =?utf-8?B?K1h1aGtxRE9EWHlLbVpETnB1eDFRTGdMcEdLb1NLczN0S08wS2hRcy9aTzFM?=
 =?utf-8?B?K1c2UWFaLzRsZE4rRXgvaHMzZFd5ZGI0SENTeXJVTHE1WjQ1LzFMbE0zWkZT?=
 =?utf-8?B?NUMwblRsNE9ta1FIYXZJd0NLbWMzUVpjRndkaHdZQTdhTUpDM3NSODVpZlVy?=
 =?utf-8?B?cnZadEZOeGZoSkRjckwxRUU0QWxmRjN4QlZERFVzc2lpS0pJTFh6Z3FrY2xF?=
 =?utf-8?B?OUhxQ1MrUDVuaFZUQ2hZZmlqbjBTOVpFWE1uL0JmYVJ5UHBPZS9RaURFdmZP?=
 =?utf-8?B?ZThVeThTMmRlc2ROVDRDTXNSbUtIUjIzQTM4cGlxYTdQNHlQbWVBbVpOZExR?=
 =?utf-8?B?S0l2cHhOb3ArUDkzdmlnM3E0dUpwdTFpTEVseXM2UEs3Sm12MkNpU0wvbkor?=
 =?utf-8?B?MTJoU2VqVWNIVHMxRlZjbEF6MG4zaUYxMDZVTElMckpQWTFuVjV4NWhTMVM4?=
 =?utf-8?B?SWJDeXF6dExkbkMxdGhmU2dLWUpSTHFRclpvMnQ4WndXb3ZPZk1lRVFjaU9Q?=
 =?utf-8?B?NnlxVDFpckZEbzZ1NXRDZW53eTRDcGErUkpCS2dhay9vVlcrWWN5ZGplWjFk?=
 =?utf-8?B?TGNMTG9vVWxRMUtJa2NJcnd4L2FreGVrNWltQTJtZG8xaldEd2M0dkxLM28x?=
 =?utf-8?B?VHAyZ3FRQWFiYzBpZ3BjaGVJTTVFUDM0TnB6dTNHUGY5RERKaUcvdlZqT1RW?=
 =?utf-8?B?L29wR2VlQzg1SWJFLzBwT3l5cFFPYzIvZElpT1NMalNwSzdwN3NLMGNvUG1k?=
 =?utf-8?B?Qm0ycktWa1g3YXAwLzNBdCsxYlJPK1dlNGU1U0d5OTNxd2lEZ2dVMzg1dnIz?=
 =?utf-8?B?TlFJUmM5Z0xsUitoSjZ5b2ZSQ1Z3QXJLUkhjbmhsdHRROGs3YzZpdUxvY1BS?=
 =?utf-8?Q?2qQqnuUiSk+CcykaUw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkwzdm54Y3RsNlI2RDkxQkVoSXIvNi9IalZCTzkwc1J4c3d1cHRCd2Z4RkEr?=
 =?utf-8?B?WDE0NWdqaGhBNngzZVJYWWZoVjR1WU1Na1puMVhPQlRUMy9wUHJwaHdhUTF0?=
 =?utf-8?B?SHhBRWF5TzJKSzBYWlZkL1p6eU5LeDZ4WWVtOXI1MnBoQUkxWU9scTN3QW9K?=
 =?utf-8?B?SENtckNOdEk4MGxIRnlLdGhSSU4xV1lqL29saWs1RmViZ0JvRngrZnJkYS92?=
 =?utf-8?B?aEhMTWtCWFNhMnh6d1RSZ1ZiU0JmWld1L2tjSkpSbzVhUDJ5ZUVoRnJEeWtl?=
 =?utf-8?B?bFNaejBQTjYybmVzV3UrVFYrcHl2b1pLY0wvQzlrbnJrcTVWL09yVjVaWjhB?=
 =?utf-8?B?ZW9qNmhLd29pUjUrNEZkOGNrVW83d1Rzc3VjekJuRmlYbUlIODhmRFMvbzlw?=
 =?utf-8?B?SXVRMTQyTkpqTjR4QmNLdThXMUpDcVlHMjc4NXYxdCtFRnZZd2hpQTM3Vm1I?=
 =?utf-8?B?amF3ckhERUFvZ0dBRWdmKzBZN0w4MDVRL2NlWWtDd2VYbmRoYktma1VTSlFl?=
 =?utf-8?B?cTRsRVUyRk1nU0ozUlhZWVZ4RmlNbHBCcHBCZEtEMXJMMXdoT2lZMHBrWmVl?=
 =?utf-8?B?N3R0ZmIram4wSlBBQUp3cEdYZHIvaldaWmI4YnBFMFRBM05GL3Q0Y3A2NXhN?=
 =?utf-8?B?Tnh1bE1YR0dWd0xOUkFNcUpkK3YxMysvNmtoOGhzZnl0NzRTd3dXYndnc2kr?=
 =?utf-8?B?OE9Lb0drRno0c1p3LzhacHZUaGszcGgwNEhJTXBTYjA5VHB6L2phcGI1TXhO?=
 =?utf-8?B?Yjc0bHozZTVlY2NVYXY0VWxjWFJGUG8xbVBiMDdxeSsvRkl6aHgzaWhZYzBj?=
 =?utf-8?B?a0NYaXBRa1NRZ3lTU0xrSk1xUnhqS29NbkI2ZXJXR0ZVUlF1dHN0NkhSUkJl?=
 =?utf-8?B?WjZ4UEtaUkYyTE5VKzZqQll6REp6NWRXU3BpVmhiM0MzVHR3b3EyRkZXekpv?=
 =?utf-8?B?dGF5UG1SNFRnaGFWZFpvQ1NQOXBPZkJDOEovK0RHZXkzS05GVmFDeFBiYkpC?=
 =?utf-8?B?Mi82OVVDRmoxcVhPaDZyZGc0NmQvTlRxUmpLRGQ0THpIZkxPNEhKdnhZaXBP?=
 =?utf-8?B?ajVSVzVaVFE3emQ4TUhodmR3UkVQZVVvZEkyb3RSa2s3K3lVQmtodkFlcURD?=
 =?utf-8?B?d0g2d016OXBBOEV0UXNWc0hDKzI4dmFsTzk3NXVpMWs2T2JjcVpiRmdWa2pJ?=
 =?utf-8?B?NWpVRnhUWlpzWVo0UENXeUpTSjdrVENGTytEZmRoUUkvNU9DUFlXcFJkamZK?=
 =?utf-8?B?dHBCblZGYzQ1dVpxVlFxb1E2dDZPM2t1ekxKRFdEdjVKcXZZWDdKa3VUNlNF?=
 =?utf-8?B?M0ZCd200U0hDWjBOcTY1K3gzd2g1dzFZamkrYzdFWVFCNW5iZzdXN2hZRmdi?=
 =?utf-8?B?T252elladzR2cXYwRlNORHJjTWhaNEJMK2E2QW54ZGl1dnhsdk02Z3FMS04r?=
 =?utf-8?B?S05sd1NsNjN5bXQranVhM1BJT2g3V3Y0L00rTlUxRndxekFoUUVpZlJRbTd3?=
 =?utf-8?B?SGdETWpLS280bFZ1Z0hjSUtLNVVrQzk3dm1rblBjZkNucy9GWkhlWUs2cmJE?=
 =?utf-8?B?ZEgxMm9OMFFJb2NrWWR3WGxSM1Y4bWpnU3ZrVXdabEw0QVdXd0pXbGMvYU5s?=
 =?utf-8?B?MEovSnJzb1dZV3V5cHJnSUJETGFKdVhQMXlYSkRUTmRDQVpuK0ZHSFgxK2tn?=
 =?utf-8?B?bndROUV0Z3NwOTZERWhYVDl5ekhLOVZQRnMwaUV4LzEwT2djNG1VdWhuMy84?=
 =?utf-8?B?cWQ3RXBMNVRjU2NxcHBTQlVFR1VvL0gvREh5YXhOdVBhMVladUZURit5MHVy?=
 =?utf-8?B?MUlka01VQlpYVGY0NjcwTThrTUFadXRTZ3J5Wm8ybHQzZmZwaFowN0RmY2V6?=
 =?utf-8?B?ZzRSeThLa0RTdFV1cm14RFhNV0NORHpPMjFLcTVCQTJtWGhFSy83amZsYVM0?=
 =?utf-8?B?R2E2YlpLV3B2V3IyUmIwNWducnRzK0t0dGRGT0hnTDVFc0ZCcXMxcHBVNXMv?=
 =?utf-8?B?N0JmdnRDTzBSYUNxc05SMFpENjZZOGp1dFdPMVZzV0puTUdVWVpVamhBOTh4?=
 =?utf-8?B?d2ZGWUR0SEVDUWlKaEpQek5TM3lNYlQyREFXdk5qQXZTUTNvSHJYWHd1R0pI?=
 =?utf-8?Q?2aC64kBEPzO1VBmk90qMcdwFa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd71075-4c21-4fb2-1adc-08dc6da1a41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 07:53:38.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XE73+EkMGBwfv2GQ/HlJWW8zGMdIhVEqKGTavpNx6YIvinAiPmajnFb1n3mQzdihwsH/6OICV0211iQBZ5CqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

SGkgQWxleCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiZW4uZG9v
a3NAY29kZXRoaW5rLmNvLnVrIDxiZW4uZG9va3NAY29kZXRoaW5rLmNvLnVrPg0KPiBTZW50OiBG
cmlkYXksIE1heSAzLCAyMDI0IDEwOjMwIFBNDQo+IFRvOiBBbGV4YW5kcmUgR2hpdGkgPGFsZXhA
Z2hpdGkuZnI+OyBXYW5nLCBYaWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT47DQo+IHBhdWwu
d2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5iZXJrZWxl
eS5lZHUNCj4gQ2M6IGplcnJ5LnNoaWhAc2lmaXZlLmNvbTsgbmljay5rbmlnaHRAc2lmaXZlLmNv
bTsNCj4gYWpvbmVzQHZlbnRhbmFtaWNyby5jb207IGJqb3JuQHJpdm9zaW5jLmNvbTsgYW5keS5j
aGl1QHNpZml2ZS5jb207DQo+IHZpcm9AemVuaXYubGludXgub3JnLnVrOyBjbGVnZXJAcml2b3Np
bmMuY29tOyBhbGV4Z2hpdGlAcml2b3NpbmMuY29tOyBMaSwNCj4gSGFpY2hlbmcgPGhhaWNoZW5n
LmxpQGludGVsLmNvbT47IGFraXJhLnRzdWthbW90b0BnbWFpbC5jb207IGxpbnV4LQ0KPiByaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIHJpc2N2OiB1YWNjZXNzOiBBbGxvdyB0aGUgbGFzdCBwb3RlbnRp
YWwgdW5yb2xsZWQgY29weQ0KPiANCj4gT24gMDMvMDUvMjAyNCAxNDowMiwgQWxleGFuZHJlIEdo
aXRpIHdyb3RlOg0KPiA+IEhpIEJlbiwNCj4gPg0KPiA+IE9uIDAzLzA1LzIwMjQgMTQ6MTksIEJl
biBEb29rcyB3cm90ZToNCj4gPj4gT24gMDMvMDUvMjAyNCAxMzoxNiwgQWxleGFuZHJlIEdoaXRp
IHdyb3RlOg0KPiA+Pj4gSGkgWGlhbywNCj4gPj4+DQo+ID4+PiBPbiAxMy8wMy8yMDI0IDExOjMz
LCBYaWFvIFdhbmcgd3JvdGU6DQo+ID4+Pj4gV2hlbiB0aGUgZHN0IGJ1ZmZlciBwb2ludGVyIHBv
aW50cyB0byB0aGUgbGFzdCBhY2Nlc3NpYmxlIGFsaWduZWQNCj4gPj4+PiBhZGRyLCB3ZQ0KPiA+
Pj4+IGNvdWxkIHN0aWxsIHJ1biBhbm90aGVyIGl0ZXJhdGlvbiBvZiB1bnJvbGxlZCBjb3B5Lg0K
PiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRl
bC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gwqAgYXJjaC9yaXNjdi9saWIvdWFjY2Vzcy5TIHwg
MiArLQ0KPiA+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbGliL3VhY2Nlc3Mu
UyBiL2FyY2gvcmlzY3YvbGliL3VhY2Nlc3MuUw0KPiA+Pj4+IGluZGV4IDJlNjY1ZjhmOGZjYy4u
MTM5OWQ3OTdkODFiIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2FyY2gvcmlzY3YvbGliL3VhY2Nlc3Mu
Uw0KPiA+Pj4+ICsrKyBiL2FyY2gvcmlzY3YvbGliL3VhY2Nlc3MuUw0KPiA+Pj4+IEBAIC0xMDMs
NyArMTAzLDcgQEAgU1lNX0ZVTkNfU1RBUlQoZmFsbGJhY2tfc2NhbGFyX3VzZXJjb3B5KQ0KPiA+
Pj4+IMKgwqDCoMKgwqAgZml4dXAgUkVHX1PCoMKgIHQ0LMKgIDcqU1pSRUcoYTApLCAxMGYNCj4g
Pj4+PiDCoMKgwqDCoMKgIGFkZGnCoMKgwqAgYTAsIGEwLCA4KlNaUkVHDQo+ID4+Pj4gwqDCoMKg
wqDCoCBhZGRpwqDCoMKgIGExLCBhMSwgOCpTWlJFRw0KPiA+Pj4+IC3CoMKgwqAgYmx0dcKgwqDC
oCBhMCwgdDAsIDJiDQo+ID4+Pj4gK8KgwqDCoCBibGV1wqDCoMKgIGEwLCB0MCwgMmINCj4gPj4+
PiDCoMKgwqDCoMKgIGFkZGnCoMKgwqAgdDAsIHQwLCA4KlNaUkVHIC8qIHJldmVydCB0byBvcmln
aW5hbCB2YWx1ZSAqLw0KPiA+Pj4+IMKgwqDCoMKgwqAgasKgwqDCoCAuTGJ5dGVfY29weV90YWls
DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IEkgYWdyZWUgaXQgaXMgc3RpbGwgc2FmZSB0byBjb250aW51
ZSBmb3IgYW5vdGhlciB3b3JkX2NvcHkgaGVyZS4NCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTog
QWxleGFuZHJlIEdoaXRpIDxhbGV4Z2hpdGlAcml2b3NpbmMuY29tPg0KPiA+Pg0KPiA+PiBPdXQg
b2YgaW50ZXJlc3QsIGhhcyBhbnlvbmUgY2hlY2tlZCBpZiBjYXVzaW5nIGEgc2NoZWR1bGUgZXZl
bnQgZHVyaW5nDQo+ID4+IHRoaXMgY29kZSBicmVha3MgbGlrZSB0aGUgbGFzdCB0aW1lIHdlIGhh
ZCBpc3N1ZXMgd2l0aCB0aGUgdXBzdHJlYW0NCj4gPj4gdGVzdGluZz8NCj4gPg0KPiA+DQo+ID4g
SSB2YWd1ZWx5IHJlbWVtYmVyIHNvbWV0aGluZywgZG8geW91IGhhdmUgYSBsaW5rIHRvIHRoYXQg
ZGlzY3Vzc2lvbiBieQ0KPiA+IGNoYW5jZT8NCj4gPg0KPiA+DQo+ID4+DQo+ID4+IEkgZGlkIHBy
b3Bvc2Ugc2F2aW5nIHRoZSBzdGF0ZSBvZiB0aGUgdXNlci1hY2Nlc3MgZmxhZyBpbiB0aGUgdGFz
aw0KPiA+PiBzdHJ1Y3QNCj4gPg0KPiA+DQo+ID4gTWFrZXMgc2Vuc2UsIEkganVzdCB0b29rIGEg
cXVpY2sgbG9vayBhbmQgU1JfU1VNIGlzIGNsZWFyZWQgYXMgc29vbiBhcw0KPiA+IHdlIGVudGVy
IGhhbmRsZV9leGNlcHRpb24oKSBhbmQgaXQgZG9lcyBub3Qgc2VlbSB0byBiZSByZXN0b3JlZC4g
V2VpcmQNCj4gPiBpdCB3b3JrcywgdW5sZXNzIEkgbWlzc2VkIHNvbWV0aGluZyENCg0KSSB0aGlu
ayBpdCdzIGFscmVhZHkgc2F2ZWQvcmVzdG9yZWQgdmlhIHB0X3JlZ3Muc3RhdHVzLCB1c2luZyB0
aGUgUFRfU1RBVFVTKCkgbWFjcm8gaW4gZW50cnkuUy4NCg0KQlJzLA0KWGlhbw0KDQo+ID4NCj4g
Pg0KPiA+PiBidXQgd2UgbW9zdGx5IHNvbHZlZCBpdCBieSBtYWtpbmcgc2xlZXBpbmcgZnVuY3Rp
b25zIHN0YXkNCj4gPj4gYXdheSBmcm9tIHRoZSBhZGRyZXNzIGNhbGN1bGF0aW9uLiBUaGlzIG9m
IGNvdXJzZSBtYXkgaGF2ZSBiZWVuIGRvbmUNCj4gPj4gYWxyZWFkeSBvciBuZWVkIHRvIGJlIGRv
bmUgaWYgdGhyZWUncyBsb25nIGFyZWFzIHdoZXJlIHRoZSB1c2VyLWFjY2Vzcw0KPiA+PiBmbGFn
cyBjYW4gYmUgZGlzYWJsZWQgKGdlbmVyYWxseSBvbmx5IGEgZmV3IGRyaXZlcnMgZGlkIHRoaXMs
IHNvIHdlDQo+ID4+IG1heSBub3QgaGF2ZSBjb21lIGFjcm9zcyB0aGUgcHJvYmxlbSkNCj4gPj4N
Cj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiBoZXJlLCB3b3VsZCB5b3UgbWlu
ZCBleHBhbmRpbmcgYSBiaXQ/DQo+ID4NCj4gDQo+IEkgdGhpbmsgdGhpcyB3YXMgYWxsIGdvbmUg
dGhyb3VnaCBpbiB0aGUgb3JpZ2luYWwgcG9zdCB3aGVyZQ0KPiB3ZSBpbml0aWFsbHkgc3VnZ2Vz
dGVkIHNhdmluZyBTUl9TVU0gYW5kIHRoZW4gbW92ZWQgYXMgbXVjaCBvdXQNCj4gb2YgdGhlIGNy
aXRpY2FsIFNSX1NVTSBhcmVhIGJ5IGNoYW5naW5nIGhvdyB0aGUgbWFjcm9zIHdvcmtlZA0KPiAN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMTAzMTgxNTEwMTAuMTAw
OTY2LTEtDQo+IGJlbi5kb29rc0Bjb2RldGhpbmsuY28udWsvDQo+IA0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIxMDMyOTA5NTc0OS45OTg5NDAtMS0NCj4gYmVuLmRv
b2tzQGNvZGV0aGluay5jby51ay8NCj4gLS0NCj4gQmVuIERvb2tzCQkJCWh0dHA6Ly93d3cuY29k
ZXRoaW5rLmNvLnVrLw0KPiBTZW5pb3IgRW5naW5lZXIJCQkJQ29kZXRoaW5rIC0gUHJvdmlkaW5n
IEdlbml1cw0KPiANCj4gaHR0cHM6Ly93d3cuY29kZXRoaW5rLmNvLnVrL3ByaXZhY3kuaHRtbA0K
DQo=

