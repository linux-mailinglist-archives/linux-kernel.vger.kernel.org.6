Return-Path: <linux-kernel+bounces-529662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FACA42994
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763DC3AE7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCC263F4D;
	Mon, 24 Feb 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX5AOCWF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E081537C8;
	Mon, 24 Feb 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417797; cv=fail; b=E8IQwyKNU41zKiSQS0Qhjn+5LQ1doc9m4A4mMpedTjsrVwbyOx03d5F6jDtS/EGqwj7xjS3/GRcWjydjVGXxtViD8sXmU2INDABhHmi42Naor18skS59Md71NkTLuLMNKiwgCvFNaj1aZ20b7HZP2pm4flY34jCdzvTrCBEQVMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417797; c=relaxed/simple;
	bh=rgGXUoixunNWGRLMhr6PdhS/Bq3cNriS/zpFr9AUj1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTfvia3OvOhv4AEr0kgpnXAUHRrNxi810V7ZNZA+zO9A1nW/aMQVFAU1fg5RJy4hQYxH4uguS8nQ2b/NwBWGZrXi2NxGFNUUnMYA8lKjSPQkg8QZ+ZDF3fOclBaIAwxgvGF5XDzpSZ1tL5feAwO4F45TEuLapxvfSFgJof0kadU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX5AOCWF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740417796; x=1771953796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rgGXUoixunNWGRLMhr6PdhS/Bq3cNriS/zpFr9AUj1I=;
  b=lX5AOCWFdVjhaZBUb4o/MsMQ5kzJ8iQ55gYUIp4+t0Lq/+aIIjUlfzyz
   rbTNrmndi26Y6Eb7+bA4NsBT/KRNNw55jwZrogAiOjjiyOUBzMJfeHMJQ
   4LZzsnlZjH+4uDFztN3kH7HX2ZnpDp9BKtVulRBBu0WpxDBy5MmMOD85f
   emYuvCXEvnQY46e5Bn+BJgTpMRv583JJZQO3HA7QixsiFvyI8+iKpqJH8
   etZ0sruEMj2IDp4PxGrk5AK2dN/puzRJdy6jV6C4kpnHaFb799W2mBhk/
   dPbTF+REyuv1qjZp5QhAiwTdt0s9ieBittTEb825soz+CvnpoOXGxWFP5
   g==;
X-CSE-ConnectionGUID: GYa1XwHcQvGjPb4Ujs9mRQ==
X-CSE-MsgGUID: wpfxKJA/SU+kcG7c5eSH1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58731632"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58731632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:23:14 -0800
X-CSE-ConnectionGUID: GREZt6zyR8Wh2SklIegMhg==
X-CSE-MsgGUID: aTq5kwsUQ7CoRs6ok0IZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153334079"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:23:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 09:23:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 09:23:13 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 09:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxW9CoWTzTwkYkw+6pKedgGPZQlhRazawSUhQILSB9B6nSD3fA1Ga0gt83wPVjJq4eAUSu1eW2KdK64S13nYeaRS5sCqEneZhOv/1zOD73PN01mcpC6y2vCjNQcaFOkqY/AnD1w+aX9F5VQuYNts++sdLgCuj4/e7sFq7mNXeb1YjTBs/ug5Zj8n3yWusgXJ2v6ZrA/8+WaOo4V5cyVi0YKgzwksuBryjTscAxDHDjithlCiQn0iuvoGP4JpelpLDz3ZFsdnIY+jogzUrmOtgCm5pcW8B9h0aB+CbTMgsGBF8yj0oC/r5SMzwG2vfPOMs4LHWxGczyAJDYmtXpmxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQtH6qRGNDOlJxFmAuIuQ2EMTxYyYRw9ZrXsj4VBM2c=;
 b=ucRknbSgDSagFXdlyEichxee4/AVD8nIYMWHpxFq+UBVjdBK9+8DKaJDZXHYOTV3usnJSXY6N35XqIwffYnADxS7CwjTveEJQOFugkKHXSBRXkX9KdX+9FA7/+1f3iWvChpOgkVVtHDqBX4aSpwMhMH/0xWofuVXBLYWnuxOr7ZtE86E/jzbJ4cHG/DeDJNyDXRjmbnSWRKGofRLUA2nPQYxNHRBVqGQzeDQPe/C6wWx9lRu8GP7BxgL3kb1goBquHtPC0jW5lbMraWXsp0m5y0CKjUnH77kwHMNHwXhALu0Y18FrhcRN+6ZvXBv6Ef3zbK7u+exuNwbLG8bL46QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:23:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:23:06 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "Moger, Babu" <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Thread-Topic: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Thread-Index: AQHbbQuX8YqJ+kbnJkKujoWHd7glMbNO0R2AgAB6BoCAATdnAIAAYFYAgAE2lYCAAEXTAIAEhrUAgAAAnXA=
Date: Mon, 24 Feb 2025 17:23:06 +0000
Message-ID: <SJ1PR11MB608377BD540169FF3B0FF82DFCC02@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
 <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
 <Z7ydx6vfuw8OdJzL@e133380.arm.com>
In-Reply-To: <Z7ydx6vfuw8OdJzL@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: 5dfb2785-4356-4a42-e0c5-08dd54f7e6c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hFFy/mG0tNWo0YyFhv4yd9zM6Xjy8ayRQoMOFnva/UBhx7kSBxCxQ3kAG7k9?=
 =?us-ascii?Q?KN3SgpMkH4Hu1bLBcg+6KU4QtxQ67j6Zl1P40HpPXNLIDDs7ObXqur+y0Qzv?=
 =?us-ascii?Q?eLfIj9z4nyrUgWhWW/We/qrKd3kmqP5ZeT0EtSJaOA5dIfsfk0MYjRoH8LUc?=
 =?us-ascii?Q?I4c8tOVgGPsdyStPwFvIsL438i+6kEqIdFi7R6xhY27miEjeufi1QQ5dgxsW?=
 =?us-ascii?Q?tDmHQszbmdiWKC80WEduf0G3itLZ3Y2Np0LyWHgbRJslFJ2L7B/wBkSaG8Fl?=
 =?us-ascii?Q?t3foOTb3Ik9Rwopb400NxiXK91MEsZI1nbNA3gJWnYTHAjYLlpjvmcnxtMQS?=
 =?us-ascii?Q?iqdvZR/ly/7MT28HghiRVGx64AbRk8P8YnMxl0aVvvLTzfOKFDD9SMS4bl55?=
 =?us-ascii?Q?ixEVHI6xw9jbYz1EElo/HTWRBe8fvx7JbkYlgC6jOd3LSfH1RpP2fLN+C4D/?=
 =?us-ascii?Q?U4lq/O6XFOdWM7l5I8n1hinwYkVlGc6JPrE02UZaBBj65qkYbTn4GOlrYz69?=
 =?us-ascii?Q?brXP3bRvhO00W3jJMogpRQZOKXAh6rbGEJxyO0stsaqnUe23XL8afBe5wkM/?=
 =?us-ascii?Q?Vw9VTX+16K57YKOqRwtvfEVSYaYU4U1+RCve9CF+5PbkdA05I7BJRwMvEf7h?=
 =?us-ascii?Q?LFXu8SRSl1EkLJtQMfu1MBvMq/64LLZP/TeKn/LXtJb/TrsB9lk9A0r9FUH2?=
 =?us-ascii?Q?2bAOqYorFe9xh5kNNzvB8WoRzSItIgf/23/Kz/tM93UjFvb+QGFEkqup+TOv?=
 =?us-ascii?Q?Fli4fuuAKP0ZdPfOCsJOK8xGJKOg/p4JQr8+mdFQZ4ciHxXkBr3Wt6bVRvLs?=
 =?us-ascii?Q?uPtE1QuoO06mWFdcxf+rww3NHkuVI5JtaYdSzAjG8aq+dxKRz7+kN3inqR/b?=
 =?us-ascii?Q?nFmZ0D3YE4JLLr3yHNC2wY9EGpNI/aZGk+Y0h+PuZdlCJHBcbMD3eTQw+zHM?=
 =?us-ascii?Q?0DEbY1Z+v1vmKaoH86U1D3RMLvKKue4/E2lM8dYTMa+FNH3eNhKZhGRZyJt1?=
 =?us-ascii?Q?In0PO8fP7e25SgnjF/ti7jFpEDxJWmOaLUHs1RCH0RGqVtX5ffhB298rBd2+?=
 =?us-ascii?Q?hUFN6W+xF/DQT8l5z/Ad7IrszxUzMXxFfAJDitfWHvYjidzL86m1Ur1cMz+z?=
 =?us-ascii?Q?I9GQ/ZmZDzpAETY5O441Iq2Ybv05VAucjRgT8Iu4sAJcfNi5pRVqSwU7NlPs?=
 =?us-ascii?Q?2f2F5f3qEjCb55d6esTXHwtcxcZsWgpiO6F0FS+QDP3yg/QD6HSx/GVT9+9x?=
 =?us-ascii?Q?drEDSyPZ5lxp/7X1jkWzJyUgwcSJ7oguGb8Bzc2nyl9LMO1IfzsTcvDTpqTi?=
 =?us-ascii?Q?ZDH2rV3dpYTbssmIkfaDzZCuw5fEp1Lms0g3U0hwLNFqR0NgAYrdp3UDYduj?=
 =?us-ascii?Q?NPTv/s5I1JKyugMdywX4JAnns1Z0A67QXuSOFWsJmQW3h65QPfS0TiuLEYlh?=
 =?us-ascii?Q?1j7pT9CqZxym4aRwImtqtuauC43qXOaJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w1keVdhKyzgMzge8BZfyRlXSa6JQKYLaPctMBS5C1agZv8NkLmt1pmkN8pk4?=
 =?us-ascii?Q?6yaf5+d++YyzjwspiI+z2YCUp6SJfs+wrwBaXuYCXvMBCpMhMZJg7+wYeg9U?=
 =?us-ascii?Q?PDU+WtGd63b5W/K8PBoALEf/SzvAkRNasVRfsLQGvfLk5ru65j+qDCZQ3obM?=
 =?us-ascii?Q?qdEFIrhuMqWCiDK9AGfT1yPluPIwq8jw0G3EEx0a4N/tygnBcOneW6Yzp5JT?=
 =?us-ascii?Q?CXZwxNJ/Yo8SQxbsWAU1d3N95NBeW/c0x0EqjYAiLawhVgUrndl8EqUDfJlr?=
 =?us-ascii?Q?vM0SfudAC6JxRK/vkO19woFD4eMDlqs7pz7v8VElxlCtYC3KACtqZMdjrjOE?=
 =?us-ascii?Q?oVBGSnX5WHEOyH6/A42zBfXe7/nY2ovUQnC8H9u6WjkIqxRtYPZWmgQ/9LSn?=
 =?us-ascii?Q?6aCqSbtUqRrPl/emTAuRe9luM0pvbselsc/AJSDJZbF0St8SJHoG9v6Z44NY?=
 =?us-ascii?Q?FdCmqUC7y8V+0UQFkJ/ngtnxGSL01ZP7jxAIkpikQYjqAJdGwYE8fgKFRvpn?=
 =?us-ascii?Q?Ns9pHVV4bgryal8Iqigs7viGhnK6GkDOZMgQqm8AkhguEXg5YQ3oF9NYv+rQ?=
 =?us-ascii?Q?T7hCnA758RdCHaArTGSHfByt2sJ2+pa03z7jrpAabOQ/J0SIwnqiSj6Lin96?=
 =?us-ascii?Q?hxBA+ieq+xKCEns2yJptcGrOV4kv3l4wIpA/iuNqYuF+HWNlWYruPW5f623N?=
 =?us-ascii?Q?asHM8KJqZ7Fi0SDpz/sVl/znPgtIuzk1CxduASmbOvul5mylU/ZxYBi5VscT?=
 =?us-ascii?Q?ORUWv/Mt8GjX5+o6wDRyiYV/GrUnuLoTbALUAyecAOpR0zXu7xYxgYdkQQ6+?=
 =?us-ascii?Q?kFAOrgXC4zA3KkunNhKXem3Fw9qgDDFPCk735mjWFlH59RA5bVd+AIpAu1Ds?=
 =?us-ascii?Q?9P0bfpnFudJzWIiiECiG45rS22lty9f5TMsUPzHh6gtWxTnh/rmTbIKBN7dP?=
 =?us-ascii?Q?OrrZ84iJffF701IOEgItL5f2p5iEpayoXmfgxLgaCJ7HUUBMqnuUWWi24Lbv?=
 =?us-ascii?Q?FNSa8VPkAZGYyhXhuoNPNcQpXc9vgDEREKW38HuO0cQXYRhPnPV9DZaoi6qg?=
 =?us-ascii?Q?0wj3e8cGYCZgwfp2x916Rwvf+KTDYPsqLunXdXDl+EKPMNEAPzC2Xl6Mt6gv?=
 =?us-ascii?Q?lsdKUirOXixXVNlKLc4gCE1xgx/mnGP+t4XWxD5ZGN4giD5fSkDQeCBeynbB?=
 =?us-ascii?Q?DlLYvqFn7uRKoChuVjrKbdF2XRAHZvxtQLHIquR5lpyI3cvMLUNCNV0FZSDU?=
 =?us-ascii?Q?Zh0Teae2v1q7ZYy8g7VZOpsrXd6nZ2vn8zFpLf+GPbotRtKcBk/PiTqGJq56?=
 =?us-ascii?Q?RJmUtLQ2Lo+d7c0NeACHS18eO8GibgobMkz/9Z1IZJoqyFkZ8iuuekIuCa7d?=
 =?us-ascii?Q?Iya25qbWpbrhik3/ULGO9X7CKiZ9G6gqvWAZjplmlsyLDPnO4SA41l5BStoN?=
 =?us-ascii?Q?NpO8dJztvk6nffRx4baoxLRnJNEe5JUqr+1Mpd6uaFzOSmleX8XBYf7K/xgJ?=
 =?us-ascii?Q?ApL/XMc55lIp6+GgeMewMEHSSD1/GXIPhUhOlL15c4+0to3oFHqB8KtTI+Dj?=
 =?us-ascii?Q?M7ZNVtc5CpcF/JyekRGrF6CcCXOu4TGW5tPtLHF0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfb2785-4356-4a42-e0c5-08dd54f7e6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 17:23:06.1230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMyq7TYs6AxTYTk8YKA621KAB7wxTEXQXLSYeu45l3jHLfwDByb9K6sp4z974YMHv8D51z1Jxe4xBjcK8Z7z7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com

> It has just occurred to be that ftrace has large, multi-line text files
> in sysfs, so I'll try to find out how they handle that there.  Maybe
> there is some infrastructure we can re-use.

Resctrl was built on top of "kernfs" because that was a simple base
that met needs at the time.

Do we need to look at either extending capabilities of kernfs? Or
move to sysfs?

-Tony

