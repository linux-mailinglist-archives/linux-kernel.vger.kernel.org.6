Return-Path: <linux-kernel+bounces-257814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB8937F53
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4951F2170F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620714A90;
	Sat, 20 Jul 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzW3HL4Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA412913
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721457058; cv=fail; b=d+Ge0n5QjAdm+nlWcnI3510VuSATJSFtmo2TlchQtyxe4sgoUzipOKI2wTLQyDw8faromhqemAicra4rDLdJxUmpEreGLq/zrHiO7mUevQ+CDBZ63pXCZz0Rnjp/NyHLG7dfXjMk9AuDUQkhOTh7sFJYqnCDiR7h8sbquJsK0ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721457058; c=relaxed/simple;
	bh=Cs9lRdI9aud4NiWCaitRi3R4FfzPV4OK/rKabdN3va0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qh8Wb3T4JJWazFNJDvmXnywDiuSoTHzbDbvjAzJ2kUN+sG0oNqH29fQ+LISEfYG8Qk6+wWxuFE2EoWTn68dQ3XgkqGYYb/mYSw9iieIOqgHcz9Pk9HLinuQ1etvN7SznajMpjL+edzSuyHxRVk1Z3SVND2yd1QVktlXPo5a0jXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzW3HL4Q; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721457056; x=1752993056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cs9lRdI9aud4NiWCaitRi3R4FfzPV4OK/rKabdN3va0=;
  b=RzW3HL4QZV7Itt+2RREeL2RH31cpxKHpF474QOXa0DRijV3aoSQLvqPN
   WrsWPUbfP+5tHRbUAfbSjcPbu9ouiNzWY95VTbxqgNuuw5uD3fcl7jhM9
   zvSGsXmHrAiO+yvkL5+rMiUPrs1ekGgP2pBk/+GcCNnJZLdNcyYmInVDC
   Q27Jw9pPZzPccjGmmowxpubs2FaYyOxPrDCRDUHbPzR3hP73GAk3j/3zp
   cPeXLDzQfTte+Q4mZnOaZwt7/+gxPaAOMCJTacedSTEy9KaM6gTp35aux
   o8UxkCrhpGP7Oej+URlxEkERu8jLkbwG2aaoeVMUDoGTEGlJCpXjOdWhP
   g==;
X-CSE-ConnectionGUID: 7IbQ8ymERQOFM7qgZ0ko4A==
X-CSE-MsgGUID: FEPvVqm3SEGWm4mcJVmChg==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18707092"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="18707092"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:30:56 -0700
X-CSE-ConnectionGUID: cBlxA7i/TcWJ6bRgMBur2w==
X-CSE-MsgGUID: iSWNPVq0QXuS3ATPx/f9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51352568"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 23:30:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 23:30:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 23:30:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 23:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+DNfEVJfDXyp3/W0uuOkbQ1SbRI9zrXer/c0gtdiAfjnI+HFWfglTG/0XWTtZts94+75hEP0cYZmpE+lvFgEqWIv5jx/R83kCohncY2G90tG2swNRpONFGImG5djCEZcogOsxOjGGVLxrFVMyFPuSmylVKS41VZiY9Qd8f2FD0iCj+6b8QePkLqthLKehI2Ml8dIjGlxja0ajmKpc0l/X20uLhsC2F8BROsYO7rXgdGw69QGdYfMreAYPIi9fAdoa+JurADAGd7BOekcJegDSIXyxNf0QK8MMq8M50GebSLgVrwSIDbUGwwda4OIeMnVFgibnGK293WbuFOFraKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcCNKGO6k73koSoYaiydlHyhIzjYSZetoC4/dHP5Jco=;
 b=dFRUQVIz/6PzcBwzKUGwaUfFtl6SlorVrL8SDG/YX5mVpqYQPe6UT/slSbDipcjoV1jDgTbQVq/eRmEsjlEx3KfdQeu6gudlpx48/hqnfy5B6jJsqY1o4GpBYtPD/Fw7dGmQcMC+J/6wMsNv/reYe8hiqsg/mqpqW9p2OVMVbBt/jExnzUoYRoySV6i5Y73kjuo/Jp8V8qYS8VhTRilPdvuc2Sj/RYVbObWcuw/SujWlvOsSzamWXEhHLf5CjAou2lHj/O/qQ6moXlGM4ny+PpBJFctqTnEhonilnmcC+hY6z95vdDAe8ZZRpNHfxdF5UdHswz7Ksg9SRKnjD7wyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Sat, 20 Jul
 2024 06:30:53 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.7784.017; Sat, 20 Jul 2024
 06:30:53 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Hillf Danton <hdanton@sina.com>, David Hildenbrand <david@redhat.com>
CC: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>,
	"hughd@google.com" <hughd@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "Matthew
 Wilcox" <willy@infradead.org>
Subject: RE: [syzbot] [mm?] BUG: Bad page map (8)
Thread-Topic: [syzbot] [mm?] BUG: Bad page map (8)
Thread-Index: AQHa2WURQ8c44Q+/N0KJTnMnC3rOFLH96NAAgAEoZICAABG+QA==
Date: Sat, 20 Jul 2024 06:30:52 +0000
Message-ID: <IA0PR11MB718599AAE80C72AE0F19EF0FF8AE2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <9e26dd3a-f983-4d54-b162-52a9938d0dcd@redhat.com>
 <20240720050219.1813-1-hdanton@sina.com>
In-Reply-To: <20240720050219.1813-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB8489:EE_
x-ms-office365-filtering-correlation-id: 41401527-4033-47d7-5658-08dca8858117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+gqXq8vd4q0V51w9gPh+4GN+yNd+kbSt7/qjZ88uOXU7rYemJ3gccwJ0eqm7?=
 =?us-ascii?Q?etPDCOLWplUDujsrtpkk3uFo3eTYtAVy5pp3iYP2dyWN7qgQNb+8dqGNj8mi?=
 =?us-ascii?Q?J22WlkJM34ubtQCa8aGzoViG+vBe4b+8jH623obsX91HYO6HuZ7YLQONC03v?=
 =?us-ascii?Q?zxmBpgv/G03C1X9DC8d2ERn9SeHHdLZ63xmxcl4UXd/t8x7wtuguYbor9xmD?=
 =?us-ascii?Q?3TOejtcqPvo8/NvfEnK3th96xldBZCUd0d4DoDvV4yH8JA94zPMkXqh0ag8M?=
 =?us-ascii?Q?dUPHrJoajgi/vY/0VSgde2kTY5WOrlzmWgFOrSwMxUqrOWf6FqnyoMZ7R6fT?=
 =?us-ascii?Q?8irAdWhXSKg18JpOE2mlcdfeHCwN5vuyae8qY3VXTpnDEfjmDLbKemWX227k?=
 =?us-ascii?Q?rChH3CaiJVMQPjgW/quEX6PHZZ7vQLzH0z80VUgy1uQsmKZFbBVHRoHdl6HD?=
 =?us-ascii?Q?Vn61lV53GbNIhgtVPAoUnK9G4QZ6V40uHH2G8esPG4+wrX51lG3CVdBC8gG0?=
 =?us-ascii?Q?8bIwSqa/ezcTpgmZHmzxH6gsetsp7kpPNMV2nFxOsDxyIf+Ummv18AmpR9WZ?=
 =?us-ascii?Q?XiUeZsYfC+/3XOLF/JgEjAc03ACXQWTBhLqUbfOdaSn5xWR4YYcCFe0NxM8p?=
 =?us-ascii?Q?/Ciuor5s19yLnxjiJrUeVz1rwpbYMkoWCEFQiE+wSwh1E5/Vf8W8eECCRHvw?=
 =?us-ascii?Q?CnwOrgl9wF26TIwS5+ujs+y5jyUUwQscCgBtatIgNr/eakWV+Pak5QG3PTyc?=
 =?us-ascii?Q?ACiTIUEK3eOYsI+sCtH3j4tRwJqMCr5R8sfwLQj1+/n1r/ZyVO5LefKVBz7i?=
 =?us-ascii?Q?09MzhN6jZLLXbwXgr+VVCOA9LKVqu5yAN1zw7YRj//Mgse5X71t0fmMs5IAL?=
 =?us-ascii?Q?AGlJHU46eQ5hQHI+SSM4SJXYrMV4IRe2PDvCJOWSvbx7R8DIOpHr8XDGAPWA?=
 =?us-ascii?Q?8Hk58oK7FiHj0BfnNVycrwQItdwCRyogladC3wXAkG5KAUcxNa2ABSvLzhcy?=
 =?us-ascii?Q?WZTdQrESrsXpPwKer+W5TeWT8ukEKmIeb0al/FMzZ36dh+xu8nY+uxjodLi/?=
 =?us-ascii?Q?ccAIlqCRuLwoRRSUz+rvy14OVQO3rP/F4Wf7a9yuXkLfkF0raH1FqfoISKSP?=
 =?us-ascii?Q?YkSBqQCSg2OS0c5FL2rySoTRLBK44gEUDx+4Dk9GNXxE5ly8YqMsCk/sHCwU?=
 =?us-ascii?Q?EjwmtsqPlzUqS5WfNkyun/3PCBxhJTvExN09r5jf8rMVHljqUrTAIPe0iusM?=
 =?us-ascii?Q?XUZqrkWdC4fp8qemixCrAtDIo6qwSglJMLJFiig7Flltqk401W+pUk/INNiE?=
 =?us-ascii?Q?SdXJqrjftOyHr6gOQa1Bf0HCSnp6JRAr0mWiwUgdCagbTMFGOUVl3ex1VkVg?=
 =?us-ascii?Q?ovEwTaA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e7C9nKW36/ONakvrgtqJdyWdytx5L52hv5hP2laLdQZrDpAQdcI+i0MyuUSH?=
 =?us-ascii?Q?z9EmPj7v1HoSS7zslynNnG32yc7aq7sGQ65ND8ehcaHucuZbKsT/yPEXtujk?=
 =?us-ascii?Q?RWJWXfSmDxEMBSVOUTy0ADWUFCK/HSaCkeMeMJmP/1UiMK57TT8xSRNFrjES?=
 =?us-ascii?Q?JQ7apun5akeQBrNGDxpVXeFEMv6js9zzLwAtZT9tIj7E1Khm3KpEX/j06DPZ?=
 =?us-ascii?Q?Ze8JMhptjrG8K4NMHDuLaz9zPy0Kxylf6M3NG+sa1ofGa/JzeBZDeR3/dvmf?=
 =?us-ascii?Q?ZoH/MayGUvP78OcJqrmqg5DXb+ILIBLSKETohLpREphSboO+Rv1oPfj+vNav?=
 =?us-ascii?Q?pFtbnryUAkiD48CF5nQLllSRrcSFcDTXzfdaQXd4qK/tlq1lisTOFd45qmUW?=
 =?us-ascii?Q?4Q/mtbfUpRSKNH+UY9/GUwdYY/7GCgoXn8LsEY1G8e87fpLOCY5FB19EJDdn?=
 =?us-ascii?Q?n2fSLuV3qZT7giMLRjlJlC/z4WXNqhkif8T1NVABPn9RgGpl+Y7vk11W2DuY?=
 =?us-ascii?Q?ISgdEIUWCP01S5NbEzcLj9V982/6yJoNyhePQUaIhKUBu56agXNkFTPLa4T7?=
 =?us-ascii?Q?rZpQRiZDwEbTQv0Y34hYgKZ18bzcgSTY8tNptmMgzyTzDU8Zlsm+LtV1PUhG?=
 =?us-ascii?Q?1Ke7N3VxL5yX5uoyKapR7aasPe314QAGpO1jRO70te3hhWigrMIGIBqbqjqT?=
 =?us-ascii?Q?cPVxBmdfW+VNw/cW+UjsGGnvCga5dOnfx7qD7lkYkfac+68K7AClHfyZfaP4?=
 =?us-ascii?Q?egcNDjN4q/4OZbY6tsrZtNxiBv30uVDV8vdi9dfj742CbXVaToZblBwGWg2K?=
 =?us-ascii?Q?/OCF/QplnCPDwbR7YYOj5GeakW2dkL0orhc3TEYM88o71yYye8/vqnaH10le?=
 =?us-ascii?Q?+C9jrxOs+xKmDFFgrPfMKSSE1I4BDmwo2A9F2F5rvFcKgTpzjjy0aZTXdWPg?=
 =?us-ascii?Q?lV83d431tKxV0/R084xdKmiROUr4fHGqJd0n9bsSt92Q0UCTV8RtmWoKDHQR?=
 =?us-ascii?Q?sVBsEX9CtRv7SmBTZF0H9QMY2kcLLskrsK9DvewXXD1oS+VsgQcNqNnKIkrD?=
 =?us-ascii?Q?5cdCR3FCwLc6soVmzTTx/sT/RCcaJmtsh1D5iazmEqFsBSlZkOQ9G4vS8UkB?=
 =?us-ascii?Q?UjGc7Oh0m7A8XmKi7+xXqYqEi79Dnhypn6bOAndaEQOYCRzaLx4DMB7yqFxu?=
 =?us-ascii?Q?CLc8JusIhGRurlNp4KOLWh6SlIMZO7zJWLCILgj7oBIB5KN0xWwco83GhAKA?=
 =?us-ascii?Q?fgXJY0Bhabzd5J18o4v8XKPBQYhIvQDMDb9yzUumyI/HBBN4zxeGE0nnBFU5?=
 =?us-ascii?Q?5HMsu4OLzxX+Tpc+FsFZ0+74IV6MbKk8sBThwJPk1chTQkBjGjBuOX5/iSAs?=
 =?us-ascii?Q?mThWZRTpEWgigkwC2o4CTuo4hH6+q9hXGP1P3Bg+Uci8aRB3AbjNz/9BXzhu?=
 =?us-ascii?Q?RFLTToyefY3Y0+GP5+pSXkefg1VTrpCD/U/NfnDCkZIH4ON0YskGuMBHvjwU?=
 =?us-ascii?Q?zdwhZ9NyUGP0jqGuWU/PZetHNmFAXi7hHTGnsK2GaGlVBVofRtmkNgO1/4Zt?=
 =?us-ascii?Q?qjKqyDvO12R2Cs/MqjFlofL+UMjwA5hsngJMcAMp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41401527-4033-47d7-5658-08dca8858117
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 06:30:52.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siqJHCCHcEo3V8RzscJykvzRcBAPImL/YQl4HpZ/OM2bNDJF4sdi73JZo9kzmq9S12/BtLnEdnh9BNEFfIkYaH8NGyb/RjB+hCfQV1bPEuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-OriginatorOrg: intel.com

Hi Hillf, David,

>=20
> On Fri, 19 Jul 2024 13:21:30 +0200 David Hildenbrand <david@redhat.com>
> > On 19.07.24 00:51, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://gi=
t.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D113214959=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6b5a15443=
200e31
> > > dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dec4b7d82bb051330f15a
> > > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU =
ld (GNU
> Binutils for Debian) 2.40
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113e054=
e980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1366ab859=
80000
> > >
> >
> > The reproducer involves udmabuf. I suspect it has to do with it.
> >
> > But I'm curius, does the reproducer not trigger before 4d145e3f830b on
> > mainliny?
> >
> > Viveks changes are not upstream yet, but I can only speculate that we
> > have some issue similar to the one we had with hugetlb: udmabuf doing
> > things with memfd/shmem pages that it shouldn't do, because it doesn't
> > "own" these pages.
> >
> > "udmabuf: Use vmf_insert_pfn and VM_PFNMAP for handling mmap" might
> help.
Thank you for taking a look. The above patch or other associated patches ma=
y be
fixing this bug as I cannot reproduce this issue with a few weeks old mm-un=
stable.

>=20
> 	cpu1				cpu2
> 	---				---
> 	evict()				find folio2 in page cache
> 	truncate_inode_folio()
> 	truncate_cleanup_folio();
> 	  // unmap folio2 from mmA
> 	  unmap_mapping_folio(folio2);
> 					mmap folio2 to mmB
> 	filemap_remove_folio(folio2);
>=20
>=20
> If the window exists for mapping folio to userspace while indoe is evicte=
d,
> is this report false positive?
Yeah, this situation is possible as udmabuf currently does not handle trunc=
ation
or hole punch of the memfd after a dmabuf is created. I have tried addressi=
ng this
issue some time ago but the solution was not elegant. Need to revisit this =
when
time permits.

Thanks,
Vivek





