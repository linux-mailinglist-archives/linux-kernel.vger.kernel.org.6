Return-Path: <linux-kernel+bounces-436442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F1E9E85EB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F3F1638FC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B286F305;
	Sun,  8 Dec 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjF3AqtS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D414F9F8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671601; cv=fail; b=J3UPIM+URAVvptJw+uyHOw0xY7ShjzW7NAbCYdjJ7m7lhaXj5rltTN2BuR/UUr3hYCI4+44Rgf+6ePjPhaVyAKgJ6DpKBbctfW+ZvegtwetJ+pzy92HHLQvLZdo3e7Pa452cs7vkRMfDDaKe5PZGs+oqSRHTq5WnvABkP4vUxIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671601; c=relaxed/simple;
	bh=nNifUpcu8fPygbKbjMzZWm1mPsVU5AFcipd4lC/B43o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=B6GOyth1p8qvwupqm3Rtgh0rQPn+x2P3PQeH7YbKGb2sNMKmtpN4TuUBkrX62VTcO1bQiN9MCGbWVoaDO0V0WDJtkDDsfVRSArmQw0/NSZ0q3AfBQMypFm+xeAXXIApAmZBFYAGMcwur43ic1pnRZ+jsLH4zck9O8IoEvn4xu/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjF3AqtS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733671595; x=1765207595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nNifUpcu8fPygbKbjMzZWm1mPsVU5AFcipd4lC/B43o=;
  b=WjF3AqtS+kTWPDMTQ0woBe4NIk0OVCpuWNERoM+fZfOSVODo7pZA8i8c
   dhL98/lcbRDCGDilfmof2Jejo8MDFqwZD0hPhWVfjGIAUWCjbogrNGdvN
   NTbtER9XxBEzv5nuhzLEJEzmjC2QGWx+ZnWi4bUeWziYu7Ibr1n/bDOZc
   /xqRIuhdUOR50BS7B3OGBgHB69eQ/T0zXnyta64a2V7V5Q8diOm8b/fkt
   XB0hMCYX3cvp73c7+T/Cfhu1MymjYIzIncOmlpO/SMxg/m+J5uGIaI2Tm
   yA0KG+W9Rm/wS7T9Cv6XmbAPe8LrMZ7WXiBtLbtwJPPRxr3Ei69dHFFiv
   A==;
X-CSE-ConnectionGUID: j2NruKunQUC4pUzItKBkvQ==
X-CSE-MsgGUID: xm+EY/8UQCq98Arty6SydQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33887438"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="xz'341?scan'341,208,341";a="33887438"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 07:26:32 -0800
X-CSE-ConnectionGUID: SGdU/GJfSl2JgJtd/s7SXA==
X-CSE-MsgGUID: 5GTfG909RQ66JsMLZAD1ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="xz'341?scan'341,208,341";a="94695431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 07:26:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 07:26:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 07:26:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 07:26:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljg+qNZJtVgEeHsQaOhn2qdUfW3FPBHxAqOA3Up8zXYBcHDQql9RDERfeDWUr4uF5XUqBzdrHIgRkWZQvplPMIddFFdNSsfnsEhQE2v4MttfSLkIWJSBpftsJ1JYi+8T4xPaJoh6uEKVmyMXlEcgfR+BVA5kjlD9bS26AbAqAg5znv8EboTsAvYmH6aNNe7FVZBqMtl9/zS+Wi/7R9UXnx9YBg/8EOQHU5hF9Ou/h+jYIdU26758KaeZiW+lmdpFLHiEFg/f2sBujBoHo+VgsCUC2Zk7z8TASmAIwznUQjRN1TzFXb+hiKUmzaMUbmLbvhnmMIvcw3Y8WrAo6DJJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPicbRxFE8JcJPx/2QoM7/EXDTj4cyLdTiqaz19CGtk=;
 b=sMF5ELrGqGH/3kmMyErPTK4a6cxxx6HyNper4lOH4e0/JNryOq3FFTSiIQ4BDFlM2kECjMr/Mdpg+F37iuz2VcfizvMrC7N635m/ODHfejhrxjJdwrjb3yQHZmyWER6GxfT8KTlTbPuocZKVYxM/Ih5l8ZkVCa45Jj8YdJBaYntzz3TZErXztUZhykhAXi6HcJkNDyK8Puq6D1UNbGrK0BpU3tI3Zbp3bws+kw1VHwMRUMoMHU8GXDmrnVRkp42JiAQh3sy+957EISNjQ+hYL7I9PaTqMCIsz8h3QqU46yMJEJ+OwBWhCPSIsw4l+lcO+s/LP/Jl+ngbxGdnd/VbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 15:26:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 15:26:26 +0000
Date: Sun, 8 Dec 2024 23:26:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, David Howells <dhowells@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Hillf Danton <hdanton@sina.com>, "Hugh
 Dickins" <hughd@google.com>, Jann Horn <jannh@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, "Mel
 Gorman" <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>,
	"Minchan Kim" <minchan@google.com>, Oleg Nesterov <oleg@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, "Peter Xu" <peterx@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Sourav Panda
	<souravpanda@google.com>, "Vlastimil Babka" <vbabka@suse.cz>, Wei Yang
	<richard.weiyang@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [akpm-mm:mm-unstable] [mm]  85ad413389:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202412082208.db1fb2c9-lkp@intel.com>
Content-Type: multipart/mixed; boundary="0rQtslgHZOAF6227"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 975bf957-c91e-42bd-3496-08dd179cadbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fm62KrrCvvcTF3JvPlz2ypGn2lIGt3mqVaC6Lxne916+dX4xGZTurBzM6lf?=
 =?us-ascii?Q?+NV8MSJJvrONZ4hPgx1B9ilRrIXb7mqmW6ejtXHiOd+6nSfg68Kvxa435weu?=
 =?us-ascii?Q?OGY7uOFmP2ZpAbwCPj7RIoleiKmx4xZHcwAiU3v8BDhurPmRFi2UHtM5I6wU?=
 =?us-ascii?Q?DE0zQjPYxiSRsNiIGAQ9XKBijsaDTz2Fw1jK1QHPaqRlQZIpKktGpniBUvbO?=
 =?us-ascii?Q?9LG750oatXGl/VdDgwBQu9m7EG2tl31rWzp99Jex9LTrUp0KsLKXayaKZ/I0?=
 =?us-ascii?Q?mD2ACep1UPXMTM4qdpXcxKSS4mPelyM7SzlXlMiBc79Cpysis38UOs5lW1/o?=
 =?us-ascii?Q?FPtbH71DpXV6XZg4mkL3t9m/N2r8DY/ZKAvqQoC9SBTtOx7DUvXZ1YxGAAnJ?=
 =?us-ascii?Q?67rD/7ttaWXljvCAA/xJyJcFfD8LOY73jpe+IU/3UxqcOE/FEnuQfDHvykgf?=
 =?us-ascii?Q?nVtKBDggCW0yeVX5lgo69J9k0NUkN90NVFC8oy+I77xVZYrTiz6RYhAfq6o1?=
 =?us-ascii?Q?/8NS0lxw/9TFsUpnysXs0ZXfWVurKGSlZ3ig2bPQTduwMQTF8wWNB16fi9m1?=
 =?us-ascii?Q?UqW/iBTVHfvz2AdLH/i0FOvJ/sWNYTWtMshO8/TCTIDKzsFFBWSJJPYu+g7d?=
 =?us-ascii?Q?q3C0oVQzjdbkdqsR62QBHZ+gJI/eR6CYleBwXK0H5/1Tu540IGnUTyYv089m?=
 =?us-ascii?Q?ZsWbBa64jxbVG5Y4oV3F1QNYN3lUw3dx73PuCqnxHiTqEIvRLUdaZMuN1Cor?=
 =?us-ascii?Q?6LUclBTk5tWqXvttWePo2odo95k4Gh3U5XQKtE8NQlmkBSFi18DeqFEkfzso?=
 =?us-ascii?Q?yncJGJHmaNllylaRlvRbKsMLm88vvBm9o2Db0lWhUAnpNG9pzotCzfQh+iQf?=
 =?us-ascii?Q?yTMoOmiQVY3Nz+891w8i5sWhQ/P5fz/8RFldv/ygY6YEMnPogHJbpx0kDaTV?=
 =?us-ascii?Q?dQbSaKlmZ/J1oFetFC9S6/g662Li94N62XFJNEfScUNBP4FvnI8HqglCsBxX?=
 =?us-ascii?Q?iPqvI5Uta//1Y0SOI10XrsVwMe07ZgM1Hr0RymSIRWZhSSspJMPWOtvBaN33?=
 =?us-ascii?Q?8hiC0WRTFiN269amPnRnu2EIqE1kyYnqG6sieikhAECW0qcgBOqZ/qUy63+8?=
 =?us-ascii?Q?d/Df4jQhYrWcCncEb0BJNKydIOi9LGGOzY8tfTWirUHi6yJwy2OkdNsfhCYr?=
 =?us-ascii?Q?j/qZ8uiRrLLZK1Ll77wCyNQ0mcUIJPIsQhyAyr5Ulo1a7RDFNIFlowQC/Ror?=
 =?us-ascii?Q?ULjnn/MCcvEd7p4AYsAN1wUcvtMyXV3rOcb/gIucsLVFlxrfruFQ7G8ibCJw?=
 =?us-ascii?Q?pJozYBDzqKcwJLCdztAy/8EEUbohtKaMdsLZrzJMRywx/FkWGGaELYmZ1z+R?=
 =?us-ascii?Q?8JHONfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WDzRvZCyqJNZH5hbjtMKiHrs0FXkIebfJf2XGcyySQ1dYNl1eGT7972JD7Pz?=
 =?us-ascii?Q?NenXa8deHw/ddaFrQm7bgYRxppfT+hTlRQvG1F9ioy5coCWChwGs+oXDdzmD?=
 =?us-ascii?Q?AhTZh6Wo9qoN0BNCizSZuIPFJKheJhXyi+ACMvkLEr5FlXCZ3CA30mgjEASx?=
 =?us-ascii?Q?jYQ+98iN1vi6dz7TDlmcu0P8cBVkOcyj397Daz+64T0zS79F0Q5AwS9CjE+d?=
 =?us-ascii?Q?jQPJbgnd30ZlyaC5MliMkjxv07sp6fFRHBnvfRBCeajeCvhtGiFLyDxurCl+?=
 =?us-ascii?Q?XP5JltU+fT9hk/I7yhGdKXZ+7mpPuFhkTyd8yvlKhbKJAOa2EMT8/XJP9inp?=
 =?us-ascii?Q?5kdl+0nHK02jev4q9E1C3QiYcaJfL0HBZeFELBORtm0zZsPvjhy32JipSZiP?=
 =?us-ascii?Q?xCb7QwcKL6k2Z2POqaCVWsYM/KpyENABoX9e61yWaggwndui+Bqax2yPY+7N?=
 =?us-ascii?Q?g2qzh8z6jWWgMGv7oMJlB+esZzKGBuNwq+Ggqhqie6F4G7P403fJUzhAypUe?=
 =?us-ascii?Q?IRoxeJIgQCnbPjWINYauxVVI2NmQnk5I8NDYanYOTzH6TlrbWE8pMxF24DV5?=
 =?us-ascii?Q?YQh8mcV7EBhMYQen2M4F4b580Xu9gYYB5gqh0Gv7c6Pp6BsnEgZwAHC+IqRb?=
 =?us-ascii?Q?agtliHVXZG25VVEtZAul2XZbpsRVk91crYfrRaELswl476Gy37uk/rZWiTBH?=
 =?us-ascii?Q?IHVaBMFG8NKi1vSkwWgFKQvbs7OMrzdC60lBBqknIFZd/egyurs+lT3S+Ykd?=
 =?us-ascii?Q?TalecpdZmbr3mMiKS0ElB8IA1AMwfKuBDFDlCD2BJhSCAQQNoShIJzYn7wGx?=
 =?us-ascii?Q?pvIEPKaD0P8R+H1bE+wi0DQ+bGF40mSGi0GFvKy3LkcVwJEFEB5n/NHEmJSC?=
 =?us-ascii?Q?cORj+I4pIp4+r+2OAUIR69wQXd4ZN5wS4XDQ3MiAvRnSnUefF7rT/xRU9uHS?=
 =?us-ascii?Q?bu/OHd+sLO09ObKl8mdUMo4E9psUQCdavblTMm73qMkRqEMsvlsBoFWM23jZ?=
 =?us-ascii?Q?qaSs09/J5JmemMujC6hGvqiBlC2DBx/sdTQaucNU3JPRsm8vM4q3j0YvHKAO?=
 =?us-ascii?Q?YGl8I89TQikZu729vD6I6WBwdM2Z773GDAsbF3QyRJnOspiIMW/sLIIfHqAd?=
 =?us-ascii?Q?3xw6oCTrxdChWCUhe6cZ63BzmiNFIooqzLmJkTs5X1cYwB7OD0N/Am4j4KqH?=
 =?us-ascii?Q?BqLchgye1KC8+sgB4Pu5b9cYbrz8yB65tMfKH//RJ3G7GqjAky8bm7+cYpSp?=
 =?us-ascii?Q?eNKO0hBzcUHWNjuOssxvE6OFYYfyTagGR3O+bn8IeGKciLdb9TXsXcNrzbwi?=
 =?us-ascii?Q?Xp9MktZdNSYRYOIP3hCAYPlcDq2H9WR+ljmmq5K2DbNFlE6qV8LNqJ9xCHXp?=
 =?us-ascii?Q?eLobHN0DuO/0pq03MDK1XJqE0WCLHlaAy2XCXGF5M2vkpt4fYZ+SWFjfkNSS?=
 =?us-ascii?Q?YNDr2gDTmDniG5XKeQ73D7j18OX3SGigrNBOdXd86pYVH111J1JZqkNEeKTF?=
 =?us-ascii?Q?Ysine0ghNs2p7XakrBwFTrsd9KU2qu8OGWzm+yulLCQSUK371jeuyhErqtNx?=
 =?us-ascii?Q?k/ODf8LXRQjV+VrDOjlWz4x4g45LEV6S2UMrBwUVgoG3XihT6hgMIPvbl0Jd?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 975bf957-c91e-42bd-3496-08dd179cadbe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 15:26:26.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8HltlOGr94xmUUKEnHkx0qMFn3/Qtp3jtdNdaAcCKcNW6WYM3R3zRrvUu6jq+Dz3iMjAQjloWS8mDU1L0LiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com

--0rQtslgHZOAF6227
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable

in testcase: boot

config: i386-randconfig-141-20241208
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | 98d5eefb97 | 85ad413389 |
+------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address    | 0          | 12         |
| Oops                                           | 0          | 12         |
| EIP:lock_anon_vma_root                         | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 12         |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com


[    6.680723][    T1] BUG: kernel NULL pointer dereference, address: 00000000
[    6.681291][    T1] #PF: supervisor read access in kernel mode
[    6.681706][    T1] #PF: error_code(0x0000) - not-present page
[    6.682122][    T1] *pde = 00000000
[    6.682389][    T1] Oops: Oops: 0000 [#1] PREEMPT
[    6.682741][    T1] CPU: 0 UID: 0 PID: 1 Comm: init Tainted: G                T  6.13.0-rc1-00162-g85ad413389ae #1 b25e7d42bdbf00dd0b477b43b1be4c6af368b663
[    6.683729][    T1] Tainted: [T]=RANDSTRUCT
[ 6.684044][ T1] EIP: lock_anon_vma_root (mm/rmap.c:245)
[ 6.684422][ T1] Code: 31 d2 31 c9 c3 55 89 e5 e8 55 68 15 00 5d 31 c0 31 d2 31 c9 c3 55 8b 00 83 c0 04 89 e5 e8 64 5f f2 ff 5d 31 c0 c3 55 89 e5 53 <8b> 1a 39 c3 74 18 85 c0 74 0a 0f 0b 83 c0 04 e8 48 5f f2 ff 8d 43
All code
========
   0:	31 d2                	xor    %edx,%edx
   2:	31 c9                	xor    %ecx,%ecx
   4:	c3                   	ret
   5:	55                   	push   %rbp
   6:	89 e5                	mov    %esp,%ebp
   8:	e8 55 68 15 00       	call   0x156862
   d:	5d                   	pop    %rbp
   e:	31 c0                	xor    %eax,%eax
  10:	31 d2                	xor    %edx,%edx
  12:	31 c9                	xor    %ecx,%ecx
  14:	c3                   	ret
  15:	55                   	push   %rbp
  16:	8b 00                	mov    (%rax),%eax
  18:	83 c0 04             	add    $0x4,%eax
  1b:	89 e5                	mov    %esp,%ebp
  1d:	e8 64 5f f2 ff       	call   0xfffffffffff25f86
  22:	5d                   	pop    %rbp
  23:	31 c0                	xor    %eax,%eax
  25:	c3                   	ret
  26:	55                   	push   %rbp
  27:	89 e5                	mov    %esp,%ebp
  29:	53                   	push   %rbx
  2a:*	8b 1a                	mov    (%rdx),%ebx		<-- trapping instruction
  2c:	39 c3                	cmp    %eax,%ebx
  2e:	74 18                	je     0x48
  30:	85 c0                	test   %eax,%eax
  32:	74 0a                	je     0x3e
  34:	0f 0b                	ud2
  36:	83 c0 04             	add    $0x4,%eax
  39:	e8 48 5f f2 ff       	call   0xfffffffffff25f86
  3e:	8d                   	.byte 0x8d
  3f:	43                   	rex.XB

Code starting with the faulting instruction
===========================================
   0:	8b 1a                	mov    (%rdx),%ebx
   2:	39 c3                	cmp    %eax,%ebx
   4:	74 18                	je     0x1e
   6:	85 c0                	test   %eax,%eax
   8:	74 0a                	je     0x14
   a:	0f 0b                	ud2
   c:	83 c0 04             	add    $0x4,%eax
   f:	e8 48 5f f2 ff       	call   0xfffffffffff25f5c
  14:	8d                   	.byte 0x8d
  15:	43                   	rex.XB
[    6.685810][    T1] EAX: 00000000 EBX: 4ccbd680 ECX: 00000000 EDX: 00000000
[    6.686314][    T1] ESI: 4ccbd678 EDI: 4ccbd800 EBP: 416e1c60 ESP: 416e1c5c
[    6.686817][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[    6.687338][    T1] CR0: 80050033 CR2: 00000000 CR3: 0ccbc000 CR4: 000406d0
[    6.687821][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    6.688313][    T1] DR6: fffe0ff0 DR7: 00000400
[    6.688632][    T1] Call Trace:
[ 6.688880][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465)
[ 6.689181][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[ 6.689478][ T1] ? __die (arch/x86/kernel/dumpstack.c:435)
[ 6.689745][ T1] ? page_fault_oops (arch/x86/mm/fault.c:712)
[ 6.690080][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
[ 6.690427][ T1] ? kernelmode_fixup_or_oops+0x50/0x5e
[ 6.690891][ T1] ? __bad_area_nosemaphore+0x2c/0x17c
[ 6.691343][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
[ 6.691700][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1280 (discriminator 1))
[ 6.692055][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 6.692391][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 6.692815][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048)
[ 6.693136][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 6.693560][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
[ 6.693913][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494)
[ 6.694352][ T1] ? lock_anon_vma_root (mm/rmap.c:245)
[ 6.694717][ T1] ? anon_vma_clone (mm/rmap.c:298)
[ 6.695053][ T1] ? __split_vma (mm/vma.c:486)
[ 6.695375][ T1] ? vms_gather_munmap_vmas (mm/vma.c:1289)
[ 6.695763][ T1] ? __mmap_prepare (mm/vma.c:2242)
[ 6.696108][ T1] ? __mmap_region (mm/vma.c:2443)
[ 6.696454][ T1] ? mmap_region (mm/mmap.c:1037)
[ 6.696782][ T1] ? do_mmap (mm/mmap.c:499)
[ 6.697091][ T1] ? vm_mmap_pgoff (mm/util.c:580)
[ 6.697433][ T1] ? ksys_mmap_pgoff (mm/mmap.c:545)
[ 6.697782][ T1] ? __ia32_sys_mmap_pgoff (mm/mmap.c:552)
[ 6.698159][ T1] ? ia32_sys_call (kbuild/obj/consumer/i386-randconfig-141-20241208/./arch/x86/include/generated/asm/syscalls_32.h:193)
[ 6.698507][ T1] ? do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339)
[ 6.698869][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    6.699231][    T1] Modules linked in:
[    6.699518][    T1] CR2: 0000000000000000
[    6.699858][    T1] ---[ end trace 0000000000000000 ]---
[ 6.700258][ T1] EIP: lock_anon_vma_root (mm/rmap.c:245)
[ 6.700625][ T1] Code: 31 d2 31 c9 c3 55 89 e5 e8 55 68 15 00 5d 31 c0 31 d2 31 c9 c3 55 8b 00 83 c0 04 89 e5 e8 64 5f f2 ff 5d 31 c0 c3 55 89 e5 53 <8b> 1a 39 c3 74 18 85 c0 74 0a 0f 0b 83 c0 04 e8 48 5f f2 ff 8d 43
All code
========
   0:	31 d2                	xor    %edx,%edx
   2:	31 c9                	xor    %ecx,%ecx
   4:	c3                   	ret
   5:	55                   	push   %rbp
   6:	89 e5                	mov    %esp,%ebp
   8:	e8 55 68 15 00       	call   0x156862
   d:	5d                   	pop    %rbp
   e:	31 c0                	xor    %eax,%eax
  10:	31 d2                	xor    %edx,%edx
  12:	31 c9                	xor    %ecx,%ecx
  14:	c3                   	ret
  15:	55                   	push   %rbp
  16:	8b 00                	mov    (%rax),%eax
  18:	83 c0 04             	add    $0x4,%eax
  1b:	89 e5                	mov    %esp,%ebp
  1d:	e8 64 5f f2 ff       	call   0xfffffffffff25f86
  22:	5d                   	pop    %rbp
  23:	31 c0                	xor    %eax,%eax
  25:	c3                   	ret
  26:	55                   	push   %rbp
  27:	89 e5                	mov    %esp,%ebp
  29:	53                   	push   %rbx
  2a:*	8b 1a                	mov    (%rdx),%ebx		<-- trapping instruction
  2c:	39 c3                	cmp    %eax,%ebx
  2e:	74 18                	je     0x48
  30:	85 c0                	test   %eax,%eax
  32:	74 0a                	je     0x3e
  34:	0f 0b                	ud2
  36:	83 c0 04             	add    $0x4,%eax
  39:	e8 48 5f f2 ff       	call   0xfffffffffff25f86
  3e:	8d                   	.byte 0x8d
  3f:	43                   	rex.XB

Code starting with the faulting instruction
===========================================
   0:	8b 1a                	mov    (%rdx),%ebx
   2:	39 c3                	cmp    %eax,%ebx
   4:	74 18                	je     0x1e
   6:	85 c0                	test   %eax,%eax
   8:	74 0a                	je     0x14
   a:	0f 0b                	ud2
   c:	83 c0 04             	add    $0x4,%eax
   f:	e8 48 5f f2 ff       	call   0xfffffffffff25f5c
  14:	8d                   	.byte 0x8d
  15:	43                   	rex.XB



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--0rQtslgHZOAF6227
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.13.0-rc1-00162-g85ad413389ae"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.13.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_RUSTC_VERSION=0
CONFIG_RUSTC_LLVM_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=127
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
# CONFIG_TIME_KUNIT_TEST is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_NEED_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
CONFIG_RCU_LAZY=y
# CONFIG_RCU_LAZY_DEFAULT_OFF is not set
CONFIG_RCU_DOUBLE_CHECK_CB_TIME=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_SLAB_OBJ_EXT=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_FORCE=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_SMALL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_CACHESTAT_SYSCALL is not set
# CONFIG_PC104 is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_RESERVE=y
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
# end of Kexec and crash features
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_MPPARSE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INITRD32=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_ARCH_PKEY_BITS=4
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_DEFAULT_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# CONFIG_X86_BUS_LOCK_DETECT is not set
# end of Processor type and features

CONFIG_CC_HAS_NAMED_AS=y
CONFIG_USE_X86_SEG_SUPPORT=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CPU_MITIGATIONS=y
# CONFIG_MITIGATION_RETPOLINE is not set
CONFIG_MITIGATION_GDS=y
# CONFIG_MITIGATION_RFDS is not set
# CONFIG_MITIGATION_SPECTRE_BHI is not set
CONFIG_MITIGATION_MDS=y
# CONFIG_MITIGATION_TAA is not set
CONFIG_MITIGATION_MMIO_STALE_DATA=y
CONFIG_MITIGATION_L1TF=y
# CONFIG_MITIGATION_SPECTRE_V1 is not set
# CONFIG_MITIGATION_SPECTRE_V2 is not set
# CONFIG_MITIGATION_SRBDS is not set
# CONFIG_MITIGATION_SSB is not set

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_THERMAL_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NHLT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_EINJ_CXL=y
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_EXTLOG=y
CONFIG_ACPI_CONFIGFS=m
# CONFIG_ACPI_PCC is not set
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_CPUFREQ_DT_PLATDEV is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_AMD_PSTATE=y
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
CONFIG_X86_AMD_PSTATE_UT=m
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_ELAN_CPUFREQ=m
CONFIG_SC520_CPUFREQ=m
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_GX_SUSPMOD=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO1_PM=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_GEODE_COMMON=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_TS5500 is not set
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_VAES=y
CONFIG_AS_VPCLMULQDQ=y
CONFIG_AS_WRUSS=y
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_PMD_MKWRITE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_SUPPORTS_RT=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_ELF_KUNIT_TEST is not set
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# CONFIG_EXEC_KUNIT_TEST is not set
# end of Executable file formats

#
# Memory Management options
#

#
# Slab allocator options
#
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLAB_BUCKETS=y
# CONFIG_SLUB_STATS is not set
CONFIG_RANDOM_KMALLOC_CACHES=y
# end of Slab allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_GUP_FAST=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_PG_ARCH_2=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_DMAPOOL_TEST=m
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_MEMFD_CREATE=y
# CONFIG_SECRETMEM is not set
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_LOCK_MM_AND_FIND_VMA=y
CONFIG_EXECMEM=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_NET_HANDSHAKE_KUNIT_TEST=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=m
CONFIG_NET_TEST=m

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_NPEM is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCIE_TPH=y
CONFIG_PCI_LABEL=y
CONFIG_PCI_DYNAMIC_OF_NODES=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
CONFIG_PCIE_BUS_PERFORMANCE=y
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_IBM=m
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_OCTEONEP=y
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=m
CONFIG_PCI_HOST_GENERIC=m

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers

#
# PLDA-based PCIe controllers
#
# end of PLDA-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=m
CONFIG_PCI_EPF_NTB=y
CONFIG_PCI_EPF_VNTB=y
CONFIG_PCI_EPF_MHI=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
# CONFIG_CXL_PCI is not set
CONFIG_CXL_PORT=m
# CONFIG_CXL_REGION is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
# CONFIG_FW_LOADER_DEBUG is not set
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_DM_KUNIT_TEST is not set
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
# CONFIG_REGMAP_KUNIT is not set
CONFIG_REGMAP_BUILD=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=m
CONFIG_MHI_BUS=m
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=m
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_KUNIT_TEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_OF_OVERLAY_KUNIT_TEST=m
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=y
CONFIG_RPMB=m
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_SMPRO_ERRMON is not set
CONFIG_SMPRO_MISC=m
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=m
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=m
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_OPEN_DICE is not set
CONFIG_VCPU_STALL_DETECTOR=y
# CONFIG_TPS6594_ESM is not set
# CONFIG_TPS6594_PFSM is not set
CONFIG_NSM=y
# CONFIG_MCHP_LAN966X_PCI is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_VSC_HW=y
CONFIG_INTEL_MEI_VSC=m
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
CONFIG_PVPANIC_PCI=y
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_LIB_KUNIT_TEST=m
# end of SCSI device support

CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_KUNIT_UAPI_TEST=m
CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=m
CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST=m
# CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST is not set
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_KUNIT_OHCI_SERDES_TEST=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_PFCP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HISILICON=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_META=y
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_LAN865X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
# CONFIG_OA_TC6 is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_RTASE is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
# CONFIG_TEHUTI_TN40 is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y
# CONFIG_INPUT_KUNIT_TEST is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=m
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_IQS62X=m
CONFIG_KEYBOARD_OMAP4=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_CYPRESS_SF=y
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP5=y
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DA9052=m
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE=m
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=m
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=m
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=y
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_HTCPEN is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
# CONFIG_TOUCHSCREEN_WM9705 is not set
CONFIG_TOUCHSCREEN_WM9712=y
# CONFIG_TOUCHSCREEN_WM9713 is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_PCAP is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=m
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_IQS7211=y
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_SSIF_IPMI_BMC=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_DTLK=m
CONFIG_APPLICOM=m
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
# CONFIG_TCG_TPM2_HMAC is not set
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
# CONFIG_I2C_VIAPRO is not set
CONFIG_I2C_ZHAOXIN=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_CGBC is not set
# CONFIG_I2C_DESIGNWARE_CORE is not set
CONFIG_I2C_EG20T=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PCI1XXXX=m
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_PCA_ISA=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CS42L43 is not set
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_GPIO=m
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=m
CONFIG_SPI_LANTIQ_SSC=m
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PCI1XXXX=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AW9523=y
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_EQUILIBRIUM=y
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_PALMAS=m
CONFIG_PINCTRL_RK805=y
CONFIG_PINCTRL_SINGLE=m
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_TPS6594 is not set
CONFIG_PINCTRL_CS42L43=m
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_METEORPOINT=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
CONFIG_GPIO_AMDPT=m
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRANITERAPIDS=m
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_POLARFIRE_SOC is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=m
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_VX855=m
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_FXL6408=m
CONFIG_GPIO_DS4520=m
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5585=m
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD71815=m
CONFIG_GPIO_BD71828=m
CONFIG_GPIO_CGBC=m
CONFIG_GPIO_CS5535=m
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_MAX77650=m
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=m
CONFIG_GPIO_TPS65219=m
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WHISKEY_COVE=y
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=m
# CONFIG_GPIO_MOXTET is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

#
# GPIO Debugging utilities
#
# CONFIG_GPIO_VIRTUSER is not set
# end of GPIO Debugging utilities

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_AMD_AXI=m
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
CONFIG_W1_MASTER_UART=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_ATC260X=m
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_REGULATOR=y
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SEQUENCING=m
CONFIG_POWER_SEQUENCING_QCOM_WCN=m
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_OLPC=m
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1720X=m
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_RK817=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_RT9467 is not set
CONFIG_CHARGER_RT9471=m
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=m
# CONFIG_FUEL_GAUGE_MM8013 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_SMPRO=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CHIPCAP2 is not set
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=m
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_HS3001 is not set
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_ISL28022=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LENOVO_EC is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2991=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_LTC4282=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=m
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX31760=m
# CONFIG_MAX31827 is not set
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MC34VR500=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7363=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_OCC_P8_I2C=m
CONFIG_SENSORS_OCC=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PT5161L=m
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC2305=m
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA238=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_SPD5118 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_WMI is not set
CONFIG_SENSORS_HP_WMI=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_DEBUGFS=y
CONFIG_THERMAL_CORE_TESTING=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_MAX77620_THERMAL=y
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_BD957XMUF_WATCHDOG=m
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=m
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_MENZ069_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ADVANTECH_EC_WDT=m
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_CGBC_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
# CONFIG_GEODE_WDT is not set
CONFIG_SC520_WDT=m
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=m
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
CONFIG_NI903X_WDT=m
# CONFIG_NIC7018_WDT is not set
# CONFIG_SIEMENS_SIMATIC_IPC_WDT is not set
CONFIG_MEN_A21_WDT=m

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
CONFIG_MIXCOMWD=y
CONFIG_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_ADP5585=m
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CGBC=y
CONFIG_MFD_CS42L43=m
# CONFIG_MFD_CS42L43_I2C is not set
CONFIG_MFD_CS42L43_SDW=m
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_MAX5970=y
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=m
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_BXTWC=y
CONFIG_INTEL_SOC_PMIC_MRFLD=y
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_88PM886_PMIC is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77541=m
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=m
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=m
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6370=m
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_OCELOT=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=m
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK8XX=y
CONFIG_MFD_RK8XX_I2C=y
CONFIG_MFD_RK8XX_SPI=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=m
CONFIG_TPS6105X=y
CONFIG_TPS65010=m
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS6594=m
# CONFIG_MFD_TPS6594_I2C is not set
CONFIG_MFD_TPS6594_SPI=m
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=m
CONFIG_MFD_ROHM_BD957XMUF=y
# CONFIG_MFD_ROHM_BD96801 is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_QCOM_PM8008=y
CONFIG_MFD_CS40L50_CORE=y
CONFIG_MFD_CS40L50_I2C=y
CONFIG_MFD_CS40L50_SPI=y
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
CONFIG_MFD_RSMU_I2C=m
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_NETLINK_EVENTS is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=m
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_AS3711=m
# CONFIG_REGULATOR_AS3722 is not set
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AW37503=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=m
CONFIG_REGULATOR_BD718XX=y
# CONFIG_REGULATOR_BD957XMUF is not set
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=m
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=m
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX5970=m
CONFIG_REGULATOR_MAX77503=m
CONFIG_REGULATOR_MAX77541=m
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX77857=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77686=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=m
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6370=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PF8X00=m
CONFIG_REGULATOR_PFUZE100=m
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_PM8008 is not set
# CONFIG_REGULATOR_RAA215300 is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RC5T583=m
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4803=y
# CONFIG_REGULATOR_RT4831 is not set
# CONFIG_REGULATOR_RT5120 is not set
CONFIG_REGULATOR_RT5190A=m
CONFIG_REGULATOR_RT5739=m
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6190=m
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=m
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_RTQ2208=m
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=m
# CONFIG_REGULATOR_TPS6287X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65219=m
# CONFIG_REGULATOR_TPS6594 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=m
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=y
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
CONFIG_IR_FINTEK=m
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_GPIO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_SCREEN_INFO=y
CONFIG_VIDEO=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
# CONFIG_HD44780 is not set
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_LINEDISP=y
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=m
# CONFIG_MAX6959 is not set
CONFIG_SEG_LED_GPIO=y
CONFIG_PANEL=y
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_AGP_EFFICEON=m
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_KUNIT_TEST_HELPERS=y
# CONFIG_DRM_KUNIT_TEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_FOREGROUND_COLOR=0xffffff
CONFIG_DRM_PANIC_BACKGROUND_COLOR=0x000000
# CONFIG_DRM_PANIC_DEBUG is not set
CONFIG_DRM_PANIC_SCREEN="user"
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_CLIENT=y
CONFIG_DRM_CLIENT_LIB=y
CONFIG_DRM_CLIENT_SELECTION=y
CONFIG_DRM_CLIENT_SETUP=y

#
# Supported DRM clients
#
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# end of Supported DRM clients

# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_BRIDGE_CONNECTOR=y
# CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_DP_TUNNEL=y
CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG=y
CONFIG_DRM_DISPLAY_DSC_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_STATE_HELPER=y
CONFIG_DRM_TTM=y
CONFIG_DRM_EXEC=y
CONFIG_DRM_GPUVM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SUBALLOC_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_DP_TUNNEL=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_REPLAY_GPU_HANGS_API=y
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
CONFIG_DRM_I915_DEBUG_GUC=y
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
CONFIG_DRM_I915_DEBUG_WAKEREF=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_XE=y
CONFIG_DRM_XE_FORCE_PROBE=""

#
# drm/Xe Debugging
#
# CONFIG_DRM_XE_WERROR is not set
CONFIG_DRM_XE_DEBUG=y
# CONFIG_DRM_XE_DEBUG_VM is not set
# CONFIG_DRM_XE_DEBUG_MEMIRQ is not set
# CONFIG_DRM_XE_DEBUG_SRIOV is not set
# CONFIG_DRM_XE_DEBUG_MEM is not set
CONFIG_DRM_XE_KUNIT_TEST=m
CONFIG_DRM_XE_LARGE_GUC_BUFFER=y
# CONFIG_DRM_XE_USERPTR_INVAL_INJECT is not set
# end of drm/Xe Debugging

#
# drm/xe Profile Guided Optimisation
#
CONFIG_DRM_XE_JOB_TIMEOUT_MAX=10000
CONFIG_DRM_XE_JOB_TIMEOUT_MIN=1
CONFIG_DRM_XE_TIMESLICE_MAX=10000000
CONFIG_DRM_XE_TIMESLICE_MIN=1
CONFIG_DRM_XE_PREEMPT_TIMEOUT=640000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MAX=10000000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MIN=1
CONFIG_DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT=y
# end of drm/xe Profile Guided Optimisation

CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_AUO_A030JTN01=y
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
# CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A is not set
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
# CONFIG_DRM_PANEL_BOE_TV101WUM_LL2 is not set
CONFIG_DRM_PANEL_EBBG_FT8719=y
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_DSI_CM=m
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_HIMAX_HX83102=m
CONFIG_DRM_PANEL_HIMAX_HX83112A=m
CONFIG_DRM_PANEL_HIMAX_HX8394=y
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9341=m
CONFIG_DRM_PANEL_ILITEK_ILI9805=y
CONFIG_DRM_PANEL_ILITEK_ILI9806E=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_ILITEK_ILI9882T is not set
CONFIG_DRM_PANEL_INNOLUX_EJ030NA=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JADARD_JD9365DA_H3=y
CONFIG_DRM_PANEL_JDI_LPM102A188A=m
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_LINCOLNTECH_LCD197=m
CONFIG_DRM_PANEL_LG_LB035Q02=m
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_LG_SW43408=y
# CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966 is not set
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
CONFIG_DRM_PANEL_NEWVISION_NV3051D=y
CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
CONFIG_DRM_PANEL_NOVATEK_NT35950=m
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
CONFIG_DRM_PANEL_NOVATEK_NT36672E=y
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
CONFIG_DRM_PANEL_ORISETECH_OTA5601A=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_RAYDIUM_RM692E5=y
CONFIG_DRM_PANEL_RAYDIUM_RM69380=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01=y
# CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24=y
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=y
CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=m
CONFIG_DRM_PANEL_SONY_TD4353_JDI=y
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
CONFIG_DRM_PANEL_EDP=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_SYNAPTICS_R63353=y
CONFIG_DRM_PANEL_TDO_TL070WSH30=m
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
CONFIG_DRM_PANEL_VISIONOX_R66451=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=y
# CONFIG_DRM_PANEL_VISIONOX_VTDR6130 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CHIPONE_ICN6211=m
CONFIG_DRM_CHRONTEL_CH7033=m
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6263 is not set
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=m
CONFIG_DRM_LONTIUM_LT9611=m
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
CONFIG_DRM_ITE_IT66121=y
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SAMSUNG_DSIM=m
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=m
CONFIG_DRM_SIMPLE_BRIDGE=m
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TOSHIBA_TC358768=y
# CONFIG_DRM_TOSHIBA_TC358775 is not set
CONFIG_DRM_TI_DLPC3433=y
CONFIG_DRM_TI_TDP158=m
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI83=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=m
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_ANALOGIX_ANX7625=m
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CDNS_MHDP8546=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_PANEL_MIPI_DBI=y
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=m
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_ILI9486=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_SHARP_MEMORY is not set
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_SSD130X=m
# CONFIG_DRM_SSD130X_I2C is not set
CONFIG_DRM_SSD130X_SPI=m
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PRIVACY_SCREEN=y
# CONFIG_DRM_WERROR is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
CONFIG_FIRMWARE_EDID=y
# CONFIG_FB_DEVICE is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYSMEM_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_DMAMEM_HELPERS=y
CONFIG_FB_DMAMEM_HELPERS_DEFERRED=y
CONFIG_FB_IOMEM_FOPS=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_KTD2801=m
CONFIG_BACKLIGHT_KTZ8866=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MT6370=m
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3509 is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_MP3309C is not set
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_DRM_ACCEL=y
# CONFIG_DRM_ACCEL_QAIC is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_CORE_TEST=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_CTL_DEBUG is not set
CONFIG_SND_JACK_INJECTION_DEBUG=y
# CONFIG_SND_UTIMER is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
# CONFIG_SND_SEQ_UMP is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_OPL4_LIB_SEQ=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_PCMTEST is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_SERIAL_GENERIC=m
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=m
# CONFIG_SND_AD1816A is not set
CONFIG_SND_AD1848=y
# CONFIG_SND_ALS100 is not set
CONFIG_SND_AZT1605=y
CONFIG_SND_AZT2316=y
# CONFIG_SND_AZT2320 is not set
CONFIG_SND_CMI8328=y
CONFIG_SND_CMI8330=y
CONFIG_SND_CS4231=y
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
CONFIG_SND_SC6000=y
CONFIG_SND_GUSCLASSIC=m
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_JAZZ16=y
CONFIG_SND_OPL3SA2=y
CONFIG_SND_OPTI92X_AD1848=y
# CONFIG_SND_OPTI92X_CS4231 is not set
CONFIG_SND_OPTI93X=y
CONFIG_SND_MIRO=y
CONFIG_SND_SB8=y
CONFIG_SND_SB16=y
CONFIG_SND_SBAWE=m
CONFIG_SND_SBAWE_SEQ=m
CONFIG_SND_SB16_CSP=y
CONFIG_SND_SSCAPE=m
# CONFIG_SND_WAVEFRONT is not set
CONFIG_SND_MSND_PINNACLE=m
CONFIG_SND_MSND_CLASSIC=y
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CIRRUS_SCODEC=m
# CONFIG_SND_HDA_CIRRUS_SCODEC_KUNIT_TEST is not set
CONFIG_SND_HDA_CS_DSP_CONTROLS=m
CONFIG_SND_HDA_SCODEC_CS35L56=m
CONFIG_SND_HDA_SCODEC_CS35L56_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L56_SPI=m
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_SENARYTECH is not set
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
# CONFIG_SND_SOC_TOPOLOGY_BUILD is not set
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
CONFIG_SND_SOC_CARD_KUNIT_TEST=m
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
# CONFIG_SND_SOC_AMD_ST_ES8336_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_SOC_AMD_RENOIR=m
CONFIG_SND_SOC_AMD_RENOIR_MACH=m
CONFIG_SND_SOC_AMD_ACP5x=m
# CONFIG_SND_SOC_AMD_VANGOGH_MACH is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
CONFIG_SND_AMD_ACP_CONFIG=m
CONFIG_SND_SOC_AMD_ACP_COMMON=m
CONFIG_SND_SOC_AMD_ACP_PDM=m
CONFIG_SND_SOC_AMD_ACP_LEGACY_COMMON=m
CONFIG_SND_SOC_AMD_ACP_I2S=m
CONFIG_SND_SOC_AMD_ACP_PCM=m
CONFIG_SND_SOC_AMD_ACP_PCI=m
CONFIG_SND_AMD_ASOC_RENOIR=m
CONFIG_SND_AMD_ASOC_REMBRANDT=m
# CONFIG_SND_AMD_ASOC_ACP63 is not set
CONFIG_SND_AMD_ASOC_ACP70=m
CONFIG_SND_SOC_AMD_MACH_COMMON=m
CONFIG_SND_SOC_AMD_LEGACY_MACH=m
# CONFIG_SND_SOC_AMD_SOF_MACH is not set
CONFIG_SND_SOC_AMD_SDW_MACH_COMMON=m
CONFIG_SND_SOC_AMD_SOF_SDW_MACH=m
# CONFIG_SND_SOC_AMD_LEGACY_SDW_MACH is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_SOC_MIKROE_PROTO=m
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_UTILS=m
CONFIG_SND_SOC_FSL_RPMSG=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_SOC_CHV3_I2S is not set
# CONFIG_SND_I2S_HI6210_I2S is not set

#
# SoC Audio for Loongson CPUs
#
# end of SoC Audio for Loongson CPUs

CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI is not set
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_ES8336 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=m
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A=m
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5514=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5663=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SDCA_OPTIONAL=m
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
CONFIG_SND_SOC_ADAU1372_SPI=m
# CONFIG_SND_SOC_ADAU1373 is not set
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4375=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4619 is not set
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_AW8738=m
CONFIG_SND_SOC_AW88395_LIB=m
CONFIG_SND_SOC_AW88395=m
# CONFIG_SND_SOC_AW88261 is not set
CONFIG_SND_SOC_AW88081=m
CONFIG_SND_SOC_AW87390=m
# CONFIG_SND_SOC_AW88399 is not set
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CHV3_CODEC is not set
CONFIG_SND_SOC_CS_AMP_LIB=m
CONFIG_SND_SOC_CS_AMP_LIB_TEST=m
CONFIG_SND_SOC_CS35L32=m
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
# CONFIG_SND_SOC_CS35L41_SPI is not set
CONFIG_SND_SOC_CS35L41_I2C=m
CONFIG_SND_SOC_CS35L45=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
CONFIG_SND_SOC_CS35L56_I2C=m
# CONFIG_SND_SOC_CS35L56_SPI is not set
CONFIG_SND_SOC_CS35L56_SDW=m
CONFIG_SND_SOC_CS40L50=m
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L42_SDW is not set
CONFIG_SND_SOC_CS42L43=m
# CONFIG_SND_SOC_CS42L43_SDW is not set
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS42L83=m
CONFIG_SND_SOC_CS42L84=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
# CONFIG_SND_SOC_CS4271_SPI is not set
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CS530X=m
CONFIG_SND_SOC_CS530X_I2C=m
CONFIG_SND_SOC_CX2072X=m
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8311 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8323=m
CONFIG_SND_SOC_ES8326=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_IDT821034=m
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98520=m
# CONFIG_SND_SOC_MAX98363 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98388=m
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_PCM512x_SPI=m
# CONFIG_SND_SOC_PCM6240 is not set
# CONFIG_SND_SOC_PEB2466 is not set
# CONFIG_SND_SOC_RK817 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT_SDW_COMMON=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT298=m
# CONFIG_SND_SOC_RT1017_SDCA_SDW is not set
CONFIG_SND_SOC_RT1019=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT1318_SDW=m
CONFIG_SND_SOC_RT1320_SDW=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT5682S=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=m
CONFIG_SND_SOC_RT721_SDCA_SDW=m
# CONFIG_SND_SOC_RT722_SDCA_SDW is not set
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_RTQ9128=m
CONFIG_SND_SOC_SDW_MOCKUP=m
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SMA1303=m
# CONFIG_SND_SOC_SMA1307 is not set
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SRC4XXX_I2C=m
CONFIG_SND_SOC_SRC4XXX=m
# CONFIG_SND_SOC_SSM2305 is not set
CONFIG_SND_SOC_SSM2518=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
# CONFIG_SND_SOC_SSM3515 is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS2780 is not set
# CONFIG_SND_SOC_TAS2781_I2C is not set
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_UDA1342 is not set
CONFIG_SND_SOC_WCD_CLASSH=m
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WCD_MBHC=m
CONFIG_SND_SOC_WCD937X=m
CONFIG_SND_SOC_WCD937X_SDW=m
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WCD939X=m
CONFIG_SND_SOC_WCD939X_SDW=m
CONFIG_SND_SOC_WM8510=m
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
CONFIG_SND_SOC_WM8731_SPI=m
CONFIG_SND_SOC_WM8737=m
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8961 is not set
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_WSA881X is not set
CONFIG_SND_SOC_WSA883X=m
CONFIG_SND_SOC_WSA884X=m
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6357=m
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_NTP8918 is not set
# CONFIG_SND_SOC_NTP8835 is not set
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
CONFIG_SND_SOC_LPASS_WSA_MACRO=m
CONFIG_SND_SOC_LPASS_VA_MACRO=m
CONFIG_SND_SOC_LPASS_RX_MACRO=m
CONFIG_SND_SOC_LPASS_TX_MACRO=m
# end of CODEC drivers

CONFIG_SND_SOC_SDW_UTILS=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=m
CONFIG_HID_SUPPORT=y
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EVISION=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_GOODIX_SPI=m
# CONFIG_HID_GOOGLE_STADIA_FF is not set
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_VRC2=m
CONFIG_HID_XIAOMI=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NINTENDO=m
CONFIG_NINTENDO_FF=y
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_PXRC=m
CONFIG_HID_RAZER=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
CONFIG_STEAM_FF=y
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_TOPRE=m
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_UHS2=m
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_ACPI=m
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=m
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_LITEX=m
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_LEDS_EXPRESSWIRE=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AW200XX=m
CONFIG_LEDS_AW2013=m
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CR0014114=y
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP5569=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_PCA995X=m
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MAX5970=y
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_BLINKM_MULTICOLOR is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MAX77693=m
# CONFIG_LEDS_MT6370_FLASH is not set
CONFIG_LEDS_RT4505=m
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=m
CONFIG_LEDS_SY7802=m

#
# RGB LED drivers
#
# CONFIG_LEDS_GROUP_MULTICOLOR is not set
# CONFIG_LEDS_KTD202X is not set
CONFIG_LEDS_NCP5623=m
CONFIG_LEDS_PWM_MULTICOLOR=y
CONFIG_LEDS_MT6370_RGB=m

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_LEDS_SIEMENS_SIMATIC_IPC=m
# CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE is not set
# CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_AMD76X=y
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I82860=y
CONFIG_EDAC_R82600=y
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
# CONFIG_VFIO_DEBUGFS is not set

#
# VFIO support for PCI devices
#
# CONFIG_VFIO_PCI is not set
# CONFIG_QAT_VFIO_PCI is not set
# end of VFIO support for PCI devices

CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=y
# CONFIG_COMEDI_PCL730 is not set
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
# CONFIG_COMEDI_PCM3724 is not set
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=m
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=m
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_VME_BUS is not set
# CONFIG_GPIB is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=y
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CHROMEOS_OF_HW_PROBER is not set
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=m
# CONFIG_CROS_HPS_I2C is not set
CONFIG_CHROMEOS_PRIVACY_SCREEN=m
# CONFIG_CZNIC_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_MXM_WMI is not set
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=y
CONFIG_XIAOMI_WMI=y
CONFIG_GIGABYTE_WMI=m
CONFIG_YOGABOOK=y
CONFIG_YT2_1380=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_AMD_HSMP=y

#
# AMD HSMP Driver
#
CONFIG_AMD_HSMP_ACPI=m
CONFIG_AMD_HSMP_PLAT=y
# end of AMD HSMP Driver

# CONFIG_AMD_WBRF is not set
CONFIG_ADV_SWBUTTON=m
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=y
# CONFIG_ASUS_WMI is not set
CONFIG_ASUS_TF103C_DOCK=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
# CONFIG_ALIENWARE_WMI is not set
CONFIG_DCDBAS=y
CONFIG_DELL_RBU=y
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_UART_BACKLIGHT is not set
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DESCRIPTOR=m
# CONFIG_DELL_WMI_DDV is not set
# CONFIG_DELL_WMI_LED is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=y
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_SENSORS_HDAPS=y
CONFIG_THINKPAD_LMI=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_INTEL_SAR_INT1092=y
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
# CONFIG_INTEL_MRFLD_PWRBTN is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_VSEC=m
# CONFIG_ACPI_QUICKSTART is not set
CONFIG_MEEGOPAD_ANX7428=m
# CONFIG_MSI_WMI is not set
CONFIG_MSI_WMI_PLATFORM=m
CONFIG_XO15_EBOOK=m
CONFIG_PCENGINES_APU2=y
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_LG_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_SERIAL_MULTI_INSTANTIATE=m
# CONFIG_MLX_PLATFORM is not set
CONFIG_INSPUR_PLATFORM_PROFILE=y
CONFIG_LENOVO_WMI_CAMERA=m
CONFIG_FW_ATTR_CLASS=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=m
# CONFIG_SIEMENS_SIMATIC_IPC_BATT is not set
CONFIG_SILICOM_PLATFORM=m
CONFIG_WINMATE_FM07_KEYS=y
CONFIG_SEL3350_PLATFORM=m
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m
CONFIG_LMK04832=m
CONFIG_COMMON_CLK_MAX77686=m
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=y
CONFIG_COMMON_CLK_PALMAS=m
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_RS9_PCIE=y
# CONFIG_COMMON_CLK_SI521XX is not set
CONFIG_COMMON_CLK_VC3=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=y
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_CLK_KUNIT_TEST is not set
CONFIG_CLK_FIXED_RATE_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
# CONFIG_CLK_FD_KUNIT_TEST is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=m
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_AMD is not set
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
CONFIG_SOUNDWIRE_QCOM=m
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=m

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_PMIC_PDCHARGER_ULOG is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

#
# Broadcom PM Domains
#
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains
# end of PM Domains

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_INTEL_MRFLD is not set
# CONFIG_EXTCON_LC824206XA is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_IDT=m
CONFIG_NTB_EPF=m
CONFIG_NTB_SWITCHTEC=m
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=m
CONFIG_PWM=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ADP5585 is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=m
CONFIG_PWM_ATMEL_TCB=y
# CONFIG_PWM_CLK is not set
CONFIG_PWM_DWC_CORE=y
CONFIG_PWM_DWC=y
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_INTEL_LGM=m
CONFIG_PWM_IQS620A=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=y
CONFIG_PWM_XILINX=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_LAN966X_OIC=y
CONFIG_MADERA_IRQ=y
CONFIG_XILINX_INTC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_GPIO is not set
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=m
CONFIG_PHY_NXP_PTN3222=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_DPHY_RX=m
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_DWC_PCIE_PMU=m
CONFIG_CXL_PMU=m
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_AMD_ATL is not set
CONFIG_USB4=m
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DEBUGFS_MARGINING is not set
# CONFIG_USB4_KUNIT_TEST is not set
CONFIG_USB4_DMA_TEST=m

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_LAYOUTS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=m
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
CONFIG_NVMEM_LAYOUT_U_BOOT_ENV=y
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=m
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_CORE=m
CONFIG_FPGA_MGR_XILINX_SELECTMAP=m
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FPGA_MGR_MICROCHIP_SPI=m
CONFIG_FPGA_MGR_LATTICE_SYSCONFIG=m
CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI=m
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_INTEL_QEP is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_MOST is not set
CONFIG_PECI=m
CONFIG_PECI_CPU=m
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_STACK=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_FUSE_PASSTHROUGH=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_NETFS_DEBUG is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_QUOTA is not set
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_CRAMFS=m
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=m
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_COMPRESSION is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_NLS_UCS2_UTILS=m
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_PROC_MEM_ALWAYS_FORCE is not set
CONFIG_PROC_MEM_FORCE_PTRACE=y
# CONFIG_PROC_MEM_NO_FORCE is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,ipe,bpf"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Hardening of kernel data structures

# CONFIG_RANDSTRUCT_NONE is not set
CONFIG_RANDSTRUCT_FULL=y
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ARIA=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TWOFISH_586=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_HIFN_795X=m
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_420XX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_ARM64=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_RISCV is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_FORCE_NR_CPUS=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
CONFIG_REF_TRACKER=y
# CONFIG_LWQ_TEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=m
CONFIG_FIRMWARE_TABLE=y
CONFIG_MIN_HEAP=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_ULEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=0
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
CONFIG_UBSAN_SIGNED_WRAP=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# CONFIG_DEBUG_NET_SMALL_RTNL is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CODE_TAGGING=y
CONFIG_MEM_ALLOC_PROFILING=y
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y
CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
# CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
# CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_WQ_CPU_INTENSIVE_REPORT=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_CPU_STALL_NOTIFIER is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_FAULT_TEST=y
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=y
CONFIG_LKDTM=y
CONFIG_CPUMASK_KUNIT_TEST=m
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_MIN_HEAP=m
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=m
CONFIG_TEST_MULDIV64=y
# CONFIG_TEST_IOV_ITER is not set
CONFIG_KPROBES_SANITY_TEST=m
CONFIG_BACKTRACE_SELF_TEST=m
# CONFIG_TEST_REF_TRACKER is not set
CONFIG_RBTREE_TEST=m
CONFIG_REED_SOLOMON_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=m
CONFIG_STRING_KUNIT_TEST=m
CONFIG_STRING_HELPERS_KUNIT_TEST=m
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_SCANF=m
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
CONFIG_TEST_MAPLE_TREE=m
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_IDA=m
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
CONFIG_FIND_BIT_BENCHMARK=m
CONFIG_TEST_FIRMWARE=m
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_CHECKSUM_KUNIT=m
# CONFIG_UTIL_MACROS_KUNIT is not set
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
# CONFIG_LIST_KUNIT_TEST is not set
CONFIG_HASHTABLE_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
# CONFIG_CMDLINE_KUNIT_TEST is not set
CONFIG_BITS_TEST=m
# CONFIG_SLUB_KUNIT_TEST is not set
# CONFIG_RATIONAL_KUNIT_TEST is not set
# CONFIG_MEMCPY_KUNIT_TEST is not set
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
# CONFIG_OVERFLOW_KUNIT_TEST is not set
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_FORTIFY_KUNIT_TEST=m
# CONFIG_HW_BREAKPOINT_KUNIT_TEST is not set
CONFIG_SIPHASH_KUNIT_TEST=m
CONFIG_USERCOPY_KUNIT_TEST=y
CONFIG_CRC16_KUNIT_TEST=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DYNAMIC_DEBUG=m
CONFIG_TEST_RUNTIME=y
CONFIG_TEST_RUNTIME_MODULE=y
CONFIG_TEST_KALLSYMS=m
CONFIG_TEST_KALLSYMS_A=m
CONFIG_TEST_KALLSYMS_B=m
CONFIG_TEST_KALLSYMS_C=m
CONFIG_TEST_KALLSYMS_D=m
CONFIG_TEST_KALLSYMS_FAST=y
# CONFIG_TEST_KALLSYMS_LARGE is not set
# CONFIG_TEST_KALLSYMS_MAX is not set
CONFIG_TEST_KALLSYMS_NUMSYMS=2
CONFIG_TEST_KALLSYMS_SCALE_FACTOR=8
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_TEST_MEMCAT_P=m
CONFIG_TEST_MEMINIT=m
CONFIG_TEST_FREE_PAGES=m
CONFIG_TEST_FPU=m
CONFIG_TEST_CLOCKSOURCE_WATCHDOG=m
CONFIG_TEST_OBJPOOL=m
# CONFIG_INT_POW_TEST is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--0rQtslgHZOAF6227
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='akpm-mm/mm-unstable'
	export commit='85ad413389aec04cfaaba043caa8128b76c6e491'
	export kconfig='i386-randconfig-141-20241208'
	export nr_vm=300
	export job_file='/lkp/jobs/queued/bisect/vm-snb/boot-1-debian-11.1-i386-20220923.cgz-i386-randconfig-141-20241208-85ad413389ae-20241208-12012-imkkvo-0.yaml'
	export id='76c290dae53671a17e33b9e66b8cf7fd45dea2b4'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export ssh_base_port=23032
	export need_kconfig_hw=\{\"KVM_GUEST\"\=\>\"y\"\}
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on carrier_timeout=60 rcupdate.rcu_self_test=0'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-11'
	export enqueue_time='2024-12-08 15:03:17 +0800'
	export _rt='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/.src-20241208-150027'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491/0
BOOT_IMAGE=/pkg/linux/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491/vmlinuz-6.13.0-rc1-00162-g85ad413389ae
branch=akpm-mm/mm-unstable
job=/lkp/jobs/scheduled/vm-meta-230/boot-1-debian-11.1-i386-20220923.cgz-i386-randconfig-141-20241208-85ad413389ae-20241208-12012-imkkvo-0.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-141-20241208
commit=85ad413389aec04cfaaba043caa8128b76c6e491
mem=4G
intremap=posted_msi
vmalloc=256M initramfs_async=0 page_owner=on carrier_timeout=60 rcupdate.rcu_self_test=0
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-230/boot-1-debian-11.1-i386-20220923.cgz-i386-randconfig-141-20241208-85ad413389ae-20241208-12012-imkkvo-0.cgz'
	export kernel='/pkg/linux/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491/vmlinuz-6.13.0-rc1-00162-g85ad413389ae'
	export result_root='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/i386-randconfig-141-20241208/gcc-11/85ad413389aec04cfaaba043caa8128b76c6e491/0'
	export meta_host='vm-meta-230'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--0rQtslgHZOAF6227
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4LvNMUFdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0cBaGDaudJVpU5nIU3ICatAOyRoDgsgw6LNN2YAnmjHhL4HGZqDNmJcJmwJ051wimsJTUMmiq02H
NFMi6hREC8Am8UY0B6I7q2mr3VUZrmdpJWX/I01CH6rbGteqnTNgJxmwK4vO5OaWfPa8rZIIU3na
ms7GrQh4I8jzUy0ag0R7NRy+q6UA93qDTAzGntVon+zh03XeSiSRg2v/34g1yECVG49Kl72B1HKr
xAQ/seEP+5vqBXLHFyDEd8Sstbxr1ANqFf+Cuzb22/jGY0p4DroVvT9gkE3P06+IjAp7gwGD3Erz
5Kb3CAsgFGOabuzCvhq9yULDee8QE/usXlABJaMow7hKf8oNrZnVENrycsrmx2EBZjfHDNnByeqW
wYzKT7at2VWvLFpciQofLIub35C2Bfg/vcvJCAyWnToK7CCJQML7f162AGYHPsq4ymGO55fJlTJU
EMlpeudsT7u87zMGq5wjJuuMUcw/Blu19VQFjVc+e1mQsVboZxjVDTQplW3OBJDDbjR/ZGfj4sbf
jGEVS7hE60cvpBP5HaAAG16ket0deZf4qAzNQLMJ0rI6BS7wAcRHf7rjuTKvOXCuyGgq/th7AKLx
YRCusLS1FcAynG+xFGqenPIj33gtogqo9jjUp49Af+rPebdP3Pob3qbIi4WQI1T+CP33eQSd1PXB
GnMf2cW7D1vcowhSkT6/d3zUsE00lwjaxakt29WO5u/bSCvqrLxurm9v4TuRmMp9Ddk0nuyL8eZ4
pWl7tmMnKzOrt7mHkk47xoNjKOGImdLrWX0dWSUNaPrmNQQoLU8Z2GR6mQCdT29s3uPKeVycXjQ/
2U+FGXrV6Ddg0EwIwPtM+2dJxi00WDyui3IlJdkYwb24cES/VQzjyCdT28kfBMaCIhvm7ehIRuw+
BEKzzqQCWZUZDroykB1FwnEbPn4HptflIBn0hGFNJwmJ9+FKiAfR6S8rrJgp4Ye4m5ItwpotxsEd
5Y09r6YpvsU6ft/PmEbvty3du7NBuupTpnlBOVdYwuRM9QuurJCe9oYYCcTH2rU2I7o5rrTEA8Mh
NEg8C3FhRTJquZlXaKL2/yeU7zzZ3/aIBoXs+tBhd2xzhvn05s2HOISXF3ETLocRuNMdGmFjsq5E
ANhEPGvcgykFNoE+cwMX2MNAty+91IKe2XCn4HyrnN0RO5MQ9HPsukCS8Bw6GKTM+VGdsx+KRNPu
2QP/wHvM1VyNrzeQl5uvzXisbMWdk1m5OVitDLP7E4aBddo+vDttDi6Nj6tRCacsXPWedPa8zI2R
Bcl07IgkM6yeA9vlBnob+WJgi1aSFHpiaqw7XzKWTpN7i8Pc20y2aVCpqPF6v4J41mDJCOMvPsTs
xlGa9xLzHooVsIBt1Mj2SZOVx6wzyUa41rPWEV7rN0Amn9nH1rPXzrZSJfAQhDAqNMWnQcDFyT12
YSmdISCBjygEXxXKXHNUtamuxE4pJ8GQwdVRq01j3z/atVO+RvS9XuKKz0eFDWsCRmNB8fBYuH2u
x0lAuxmhVjJg4sBrxDkbXr8rE+jUJu+oe/Q5E/tTXTL45bpU8Q5n93Iqc2JvYBlW/s43VYyie9vi
Edzldqbkji9hPA36fxVIXRlBAk4QSz/WCuBfU7UYmBgGiMFnxbVv+jDQTNDuD/XMGDZGscqMY4Ri
zLJNkAo91h384BXGGolbxoZEP1wWirSf5wErtAx4kXG/UuXO4DRYMW8vwhsGqoC+vRIAeK1Xo7Pw
o8942xg0g9b/wfPO0CwcrH45PjSJpRVzaVRgk/ODK58socXwVnT7UI9iuXp2UR3tdbUzeXpdiPpe
Onm2kF91OizwMd/5fnyH762W/MScDE9bjOZaVSSIPkI7xT6UaptzIoWDpnk6RlYIls749eAG2npI
b78okTpHiAxBGA1ALStNkRbrUa1I2lsyf+9CHeQfct1C6zf97b0T9I27Aj59vkueDtA4DSI4dl2N
5XyNhH0QwlU3bWgYFwCDb+q6cmGqsIrmn9JGDnCDiPpS0C4ZWDIW1Pgxdjixjgv7fYSkbCt7lxwL
B6U31SIL+yFJSMpzoIomG7bNe3zyJgzRSzSJE4n5miab2HJByrP8Ia82+uX8eFGVVG5KRcnLHWrA
JI4ji0mvhV/YKO5slkmmcTxMwKCAhncwVyivjNfsrBgV1iEf+FLw5sPcqj2PccKuLrl0/77zC7DP
4ld77r7OjcYJYpymI+uzdXDhSOWbMHTflAAPU1yj8T7YDHz/mpNVpisyZ6RllSQ+EcIdbYqOesWR
apquxHQodcwwb3/tTjenRww1MEoHhWpEYXaXLR7g8Yiijy5r1g6m6YT0UZJT51zq3IIUF08QfFPr
YrDsK/bDxfEOVGVa+abZhFRvJlw7vOOyfdb8a6LkfxEDcJsccmb3PMRN6RJh3WLqiwWVb0YIgfnC
mt7jEz1a5ZYwca93t9SaQlTujhRm64rWhTY1/HrYpnoSUjQhRFH8v3WjCYC+oZgitbVMM9zZOQl7
JUT3jtWgVg0HK96FjYQaKSwKfnhzMO8nN3TCvue/SwvAOMMjkvaEG+Rz0y7CT+n6acZ7uYTO2iWU
HGcDb1jXRzxTJUYHzgiueaLiEHMz/FLwXvb+rztGKNCqSt0v2BB3dK73UUUZEayNmk2pdrBbt0Oe
xD1WqG395PDZh16cbb/GdleW2fIrkH9TyPzTYZPDXqkb9VmL0UfVY3Flk210YBpJZJLbDVc+Ehx/
rb2bCGrkqlZaKTuHBo/cBBeRkvxGLpiIk/fEYCh3PiuTV8paAgij9qr18Hy0aWDZ8Ly+FaCsMNJC
3B1A/5GpapoOuUU4e58VinEu6m+TYBgAnqC7oYgBGLwt6SzmyJ+cb/RCARLvYoOLWzpXJ2RzY7ZU
4SfT9pSVJDKtNa+W8uwXE9Kr00M4j8IFdz9q1uv3hh0pPACgPPlCjTBXHX9X/K156+IuZrMQILHT
nSLqAQY8ik3jcmNLlnNMJP+IftUMSaVeYLJbJ/f3p311wXn5uTpiyk2x3tZKgyjZqjKyQokBIV7d
Ve5OKtiwJ/KcnQ12flJd5ad2WFr6yL91UIGVRXwwgHjFCumMX/vLTxigZb4sABApEugvd20GsMl1
KjLqhoBPAEeimuBjcE6+D0MPHUYCE/C+YW5ZlsfZvk+fGRV8aQLYwm3IoBlOt9gMIqgICYE4Nuec
pjezT27VpDpfNPM+PJpc7Cx/dG5RIMxVaND4tNcTdyvsv1QsWxnp3hRfo7Fb/+lTMTRqmkdNPOhf
6it4yqExYNYzIs5gJd8ygtZDSBVq04KcmjuQpO/KUQTz74BntsvB7fC7E2i3c53ogN8Xc61KYDTC
bx5KbVaVuppljogA4EtHXagRIMb+0JaNTBhkw1DnrTnrAjnvTPb95XsyY5KtZlA7V3oT7KP3gxW+
DfbRrVNTAwSEpSTqmgIYhprgFwRxGlQOBqxci9BQUZFsjS+6zu/RPSjFz5mMeDY6NJMwc5jpyUg6
F0oZ9mHw4rWPp3BQsWnvtFxYSShNYoAgl3xbQrjisNxYbU8ho7v9e6XQRvbbsv0e1Wp9oP/y38Pr
3nhskMEFQaicGfgh6vU6vD9SgVQ9LvADbDpgClz3Stbm99b0Hi5+YolauB+nQeaHXtLLO8vKruuR
AvZCatzgJeEXmbBzMf6LxzEPDCKq5oKUGfLEGl9AQBCDETfgF82TOWXbQgPwIoBlneDKa4s9zDMG
tLrniOZ+E3dW7IhIGP80faSTWXFo6dNPSKhY2AOOss5B1e/k1ZIlD/7GQJk9z59RjZziW7+prfKh
F2EDhcp3Gb8pmprzotL/VCUBH8q/L5CI+aUrJ4YhhyCe6KLc3xF0u0rKveOoVDOiKJhg7CSk2024
1UJlwEidhPtJJM6y+Cov4QCm96wqs1isVurxlWjwKs6g73/UJ8wKmeYU1DgD8HPG5sB34EzSkE83
VUJOojDKqMCa4kX4d1sn0Wm/+VsCQhFZAwOvo4AzR0eQ2dcGeTShe3iyaeRJ2GmedolR4ukfI0Sp
Yup7ncbCpXvXJSH5YAYs7llmqqYLanUAZchgb+huN04x7bz142/1PiO1xZcc5Sp/Yn/zlbGR1Keu
4DSVUlpYTBEWvjcJyNVgcHoGP1y0jFDJ77AOGhkz+DmSwNOmQM+4lq9kP79RS/tAHncDM//z9bZq
8LJfAiNRTcPX81uOm8SZSvYcnYbin916R6Udc7nxL58dEvpJtuMEtTQQkR487I7gbPv1gqpGbwSH
T74fGyOJczt0wTlvYKZC6CUThtJpnhxICTtRAl4zCr86Su8dHQeO2N+j/E4HU3SUUd7kX0AvKF5G
0hWD+Td4WXlH2L7owJrZCEJTdeYtpWKUOr5VPwFXPNOvTFHsEongBh270Tb6c1+FXAUTvlRZa3JR
Vtjph0bL0T8/JX/YiCAITZuwA2k0etomSij4t0e+guLFSClhmv9KSf9bVpNU1/S99vy7aKGq3Qea
xyZzvrTA6bKmO4oZ+gF20FMk56sflahn1qy2LTHE1z3xhT8u3JxRfpn8c/0sY9Cp9d6ISKQF+ypl
9K9UmN24VLJx3ietHIXrurs/IDsFB/8ydmzUvjeaJxqR3M8S91a+/XJAsOuAiMea2hx2ZgElndHn
dvV81NdF1bxhcLbi64b4S83IF+JBU6EsIuDt1iZ6AaIc3V7RdLsWTTBOWCtZbyUyZmLzCPmax21K
5I3TFrR595gmSAaMBp76vvucHhGeCtgU+Skau6QWtPYIxOJeD2Le969PIcHAh/YGNkwYkA8+dyWd
IcAdt2dE7y0y3N/Rqavs1RHP4X/5X3qhyhZjIHVW8F8FSz2yuQnlgaY4TdThZp4mlml0mmk5f7fP
GKJhgz2DuRAiFTkXKUhaX5L3IiMbLlbirwZGSOZfTUkncGBG1b9m5Y/CrZrdCbk5Ez7zAM6YId74
KWzHeeYfOATKiV5mcdvz36es39mh26HVzVvZ7lqi7Jr6m6Qx6qOGcYZjtZzAoUbjWlasbN/o3DMl
xJgeg4Fyadi2Nk7WQaxqFP3J1JAo00avGpzCFa7sYVXSiCpXoYqTgK/aSgKMsnA34oHfgvwijjSc
UWTVg9HZUzU5F13WXo0WvAdNAZ1LLbzWtGvxY4JeTZ+ypyhPKm36W1dURRwiMhDFFS8IGmjOSQLG
i6BlQeGRFdy522ppbyRl3teflKWhTLtmfDkjXHBAtLZCLbHfVtiEuOccSeafuW5ZDLGD9iJOWM9O
UDObH9K6neC3OiYCO4v24BRvOyddw4ONDFSMDLzXWC13DHAIO6DWFrWidEgwB65X1ND4YiDDP8bf
y9vNRc7qNoNjACpJMKbPJ1Ixip0xNMkm+59l6kjjcJOT8uyyOlmD6fQfiI9anAwg/B9IMsOiFFdA
wrEYIpBFF4Cu0A8kzAgUsm8ZP9ugIk+GIyrSgWmzPwaB4rGUl5MSJFzkm7oVtPcapoAmvNPZCa4a
yRksSDvB61MY6Xi4OFkuwWHtfHaSJdZzKB/FVVZ1cQljm92A3n69lO1jqLwJ+iIxfp6GQyX1Yc+o
jgCBWw53+mnnvDNNAPzZz7T8vyGco1aK5HS67ODXxla/+Vsf+rUeMf0qXiWkqg3w81pnQcEFB1Ot
dU/OO67D2k2roEYEnZo6uqowg8NsTTde674PVOw3itKlLGsa+NBozayiKb5aDO4bjKOBpyk2/9Fd
SnJ2pfFkDqqAafm6eDyjT6XrDN5SbarzBJE6g2pcXRZK3saW2daRrnaGGmPIAnbRggWh+OU9JpMK
+3yey77x1b5NqaM50O33FZt+8YUBLTwpinuS6OI6f6qA9pej1c4WQorDBZ6OiSd5qyiubiKe7k30
k45f4K3rrth6Fs8aL8V11wJquwdUg7OjQEtLAP5XBL5ZbUAZeC2DiDHjodHW6R5YFdeJXxPE8W8O
DrDdneG2nLMfPatP4/TMubLZrNqtEbv6OeJHkvGfh69c/o1omVnfmoHuiah6AFm52elihPkRMokI
FMpWlvIVf2rg04PDI2RKMgIivxFa0ieLfupS3eQaKRcZ9iNn7jM2DnjZAMiG7AibnTRr7SZzpzKy
GugNmMSTwpJoU+AorWOtaW2vbDUweFxKtNlLovxSihnSsXQcpAmwGRWB7Hnja7Z5igv8kbCEVTbj
BUFbAubapNgvg9mD58i7wonY87hictt+XhtavvyVA90KH/Ec2enNJ7qxF3f6h3sEkGyt8HTBNgEV
PoQE0dPP7mhVLI+DHSXHCxEqX4FfD9gB+KCiW12ONQoysbVIQu4zB29vik6s6r4UMjUW4iXLCMx9
4+GuRO++Kc7w+P6K1exnck23Z/w7eNzpnEaNRyPATlCzcdhDIliXzzr2qNtiuoOBoUJzYvDYonlL
5QsllejdgLLJZ7cSkmV1uxikLu9ZImVYPeX1goJgn7rZ8KHuQb9lNwTlcJYVkvJEt3aoF2ZcCgZG
TBFt4GfCoV87RzaHM0l1xHVYLHnVcCnU5BtX5S63x8V6Lsj+nsOnrPb1DBFaKeYMOcZFuBdhhuGn
3uQiU5vbd6MiqrX6JjYeAotKwxZSRCcoYwnVRjQ/idqi5xLv78bhOBHqNIsuwgkW4ESm6059nxgv
+KxMQt1JgA/Czo7Nu3SmB9KZudhw9nG5n5kLMOPGpATIhEWKpYDdCM03hmgvULisXN8wsNDz2PQS
CCoUhNf7v3drIOKfAPr/D5oLKDDkvwV/UauwoKU9BQ+TdRQ7QAt2HTh+e1saKw6xgsMhZp/r+54P
Ft5wEC8CiSDdYVTrOddp9tC4hw8vdHi7og8LuOFgUcAb+Nx147q7DL13cDVeh3u2mVSQhJtpGRDO
bBfNUpkzlyU6YAYHGlZdML3lPsqKpLEmNz4qKUTYhNK25IVojSw+cGU+7FV5SPF7CMDmjZ5rkCRX
9Y1bcthO075p/Zo6HJUO62Wj/gCYpiCqX/P/1yT+xoXtypiEm1I91p47jwblZVlUoJO47yvWK167
/TzTNAyGJsWGp0rw8geBer3mFn1+Mofjt/dsYLw0gPawPZhPRVpAEqLwbiODhKJMDZdmtN97HEJN
y0w7uNPVt7gDSJRCpb5+F+G38IYBgUMnR/MnUNyCQFPRAvepbO25Q4ol+J4qKb0HyzMUcBQe8ddw
v2hrVeh9iVdf8FpHwtvPOcj0tjykCckSL16XoYCZlLnYNQKZXO7ut1yBHxqDPeXEZOpuydAXGKd5
eBY/Zz5I9YIXaxliV5swZxjT/zkPgGH2S7cfRDCILv4eZsqV2i/kpsLRREMyJ8yyVmXaad7ytAtD
zTzDmKClAG/1eiFlfr78/1nAcU0V4ItvNZp23qV9Q+xAXwwx+5k1lxCyjXxKgHWHSN0D5j6KV7dk
uVIvJIlasBgdtsQpYBjHe8NM6y95hkL2/nyf1IOat/v8TK+X3EfkX81XaaHjWd8KxE69s/EMPscU
lo2RKTccOarK+T/pBVvxuY1QuOkh6KbuVizxkYZZPIKb6OJHpDe4BPM/kOxRP7FNE1n23J74AbDv
qZspedaHhArrDYAa/cL0hZffPXVXVLFc1kDt8QnW86gPV0lC2ATAyI1973YGOXalzfTKTUREjm5h
W7jG/vlZgd0rzixVMqk9WEARaXUMYnS48uJjxqvNIe7XIIFQ9wmlxXBxqzGnyBLf0kz95PiIwHl1
Or1GFuK2kxM/ZbsdTrlYZZ5E67m0X6LRgDKqqUvW776tO6OF7wCSPZH1IbAt/G2KNwBaV75qYu2f
GvcPcmE2qDiafb02nTbG279rb++JahYkALgqPLfkeV1HS+egBAT05s8F+1CxouQoENMuIHSULC96
UqanGym076vA+jsaXw0rVCylR57MITJTkRB1GCww9YO0piikIY0jpaE1APqhduhQdo80riZ91O8K
L9mv7g26QZOXdAvC2KhKflzi9mWn3t4fz9pl+dmJ999IQoMBnjTA8VitPdLZQ78Y/ClGBX/U43ng
CKabzxC8reryDMpirrHEJm0S7P3J0+gje/3JhGlsUzqgmcEstG860Yr9Erm9dalhu3p8gAO2mH2z
qto+6JeOSuWPAbbCb2LrOoOrWb2z0LFdo/tyjKShYl0kHd/Z/IBo102CQXzTVvEdz6so4fuicihT
pEsHsDXAsuY1o/oRaZiH0qQHjIROujVQtNb95Ol1zqvDWrwwxi3ZfOwpXAPDXdxbFgDgZcV2+ZOP
/A6LHFZ7Wr18SFIp/fWTjI/T4A168qy39F7lFJkpCkBGoP5MRB6v3oKtsyaroZKqEchETx8eseip
yJNIbUDbDmkzZljd2SVzGMY1RfisQpb1SnC9har76xG3c6e66FxfVqBxpVsNLbeJ/nJUSXyvfnZo
EovIzejS1KAq8xz7E9GSES13ZgjPS/fdA7hGOtlGTqbBCMQ7vm881zm4izRGzc8OZvwQLaxnq3KI
NE638zWt2+OydO7OXk4oq2wysboQrUg2JdEATXqbmqk5lXTrONXS4AZqUu8SVrGaFtUlVB357UsQ
7+wzIH4Y6pVQ4H8Pq0fBtgu7qF41T468lmbTHMAVGPr9DwBqpExKlMmQRhiMITMCXCp1SJhgQbTr
yyUIU4ERKEudMuBE2CyAETA3HeArIi3rM1xBjcsJ/qsr5BpycjeQFZU3y8H6CmYjRMIlbGiG2w3F
Z01lCf48PcWvMG1O8eS2SGlDkS0r5H2uU+Uvk0dvf77VCBfyvAuD2QyBiCPsiE/uGiG1Avnx98CI
DV5omp/e9aCyigtOkMwl/JBCBDtWlWGvOkCbY9aKORrv0D8iGSl9nuYJ2Ru2GOKQMtVL5QV9SpXJ
7dHU3xiMJsYU/1BpuyJRVlla27TI3YZP41zvzXd6hZKYyBMpcZ7KYTgJ5iLLdbM1H+QDsKvUUf/j
YyuaErxRB4yoQ30cmwEWmAzwBCaWNmu2DeJxLqvIiQG+CEA/o+Hkg3uVQpdb5N33VAN+xMzwADyA
R4JvS7m/ucHJl8sMb7YB4MtRwK4Hq0OZihzjk/AlrrQkec8qPc8YK9t3NwdXLAez4q4g7dQsAu+Z
hHvJQh6UMGx3JCNH4nkMBvdrXBKkoWIV1i7VYtvxWUvP0TlNJn1eTftKGoRmn7DIcV75FP2gdjt1
M/PIWgbyX8CUo3ifvhLNNK0n+najaptPqDF/e4IgecmrrxdkmgOYj7rTeCuTSPq2tV2H2WU9it2Y
V8DuEiHgXq9bQtyjlx0YGIgQzoZu2ykgOZ368YEX2P4c7UqGc6bIUZqctnq2qV50xNE7nYyrZkqf
ocImeT6r5NFd37Kxx0L7DcIx9fIRYOuvNj0VLCfKCF62x9+QIapTf0q+JQHmTNsTfX0xsL0anXMV
76ouFWk3qcjKpcBdu7zBfEl/I6gOW7iw7+A0em2pUG+kPUUD/hpP61Lx6AC5oy+f+UAKL2fmnlFL
IGygSTtY25W0P3dRXpIs1NUABoIfn4kjEjWZ4n6bjcsratbBV4THl45L5op3BzSWFZJukjNLwA2t
xHxzDLOybr0xG7UdtcPDZT10ctt9vWOdPL7zRsZJaz2cxXOOQqGXCwU6HswveryCXmDehWYdNO3V
AnI6rWof3mnmtS490+NEvXnQl5qN6zKZeEOhk6lLnmJJMlesG+oGNkQvKuAeNGgJPHCvgFuxHr2J
iB+vhMa5uQ5hDnmdvGndGUhz2EArOWDdBTJHYrMuMsJ+92Ae/eH3YYVDw3IOoP42vqAwluI7jyQg
0PCNrl0G8MJgzycO25oNy+oSnhNG8ZnDU/m7Bdm1AfkSnkaJ5nhgyMIZSVk88mOvVQwGXHHatJRR
2x7W8zlY1vVaIN7fkJgfN6I7f5yARoEkvi7zIzqV68XXtKsFWnXPzl3aA3L9CrFuL+LLoHWnepBA
6LIzJo4njLGPYzH+5ituLcyjnR/tw+liTfcRvNsvLSqsh9tqRR2Xal656RCwC6j5Qsj4q+lbF38F
3NYtzW82iJd+j+x84OKMV4NMuIMXMNvsL20pU6aL2GE3eneH5b9n1h8jCYs1q583GOkiZYs8HX2t
JcJOvSEITIpdljzzl9Mh0CxqQ2dJORRSDTDOn3M7sLD1Aoyp8db1gWopQymkU2nEflX0feHoDn2+
BxGyvQhbaRTPua26lDvtsxte1q/NElwVHgoMvi8F2zK1fucE7NUeVjV48HBHgjNW2ZuVXh4d069Z
ohAwubHNpHAJaI5+9X+OkD7TSvn+CNfbyaQoAFEdF+jfBm9S/z3PfhAolG1FbfZlq9q2f+LYUnUF
A8h3aldliWa5SC06aAyzn481Q+OvtxMg4lNB9Yfhs1LbxYM/bx4iNF6d9mJH4mHe+PV7WS2Fz/ZE
q9TC22kSI4i2Bpy3naD+70EHDG99B7PoSJ1MKs03s3lZ8hkfMLnDLhN0wCgjY3HUizDE6fZhTXQh
zWI7VkqEaEkLHfDkKCgfEWSfrzgEBGxIJSs8hSqBhF0z/BbLqi1v/OFRWpq3/R27AARu8V4IMqX4
vlG8jBbnsriG/1/MU3PggwDzYxGrXGObM308LLjuO0hmnpEVVxFY8AvaZm6MSVAAyVtV9qPrz3Ke
wl02M8EVtKSDa/3+Lmo0pGGeiZKWwB/8fdHWJ1lNPl576Pws3D9gk0w43b4YmGW0O1bRbKCzk1TZ
xuUjTRq7FPcSs4oJ14+CtQPc1757t7YTpKNofEbo91nWMnBcZaonCVUOplt2ottabvjX5fN4YLMy
Y5mK7yU7806eF7Smk0vv40ZglfH6nVi1+haG93LHuZSyoCftjXP7K2iYwStHoXuhQJY9/n7CANjH
s9w8OQPzk0qOnB//+yxqnAhUOmL0RtnzxcgADuURu6Aik37yNWnLOvhH9w4OwZ+XWPPBVQSqEoq+
3wz0QRyP2a5OPanTFV7VMK1JaC5zelmSf59bo3vkSot79lkdxnLa/i/lMBYwSqlXc/B0DGdYCU3K
MCOsRPeI8VI2iWTKfU+jjXiKBVIkPE8xeYfcQne0Jb2hIG1ak79D4IrYMzXCUPshuNI8N5+8YipE
m7H+permpLUnKkpjvawJfLv5J1g99qrk9sOaog/G4PBC/mBHKwL8VefxLBha2taAtSvMZ4JCrBjg
lvQehLaD4rTI5ncsOuYoZQ/gY0oMWhoxuEbv4Zg9soDCxe1HwfJTZb6GTg4tVDQnjXVVMS3oDjfA
VaFHAm4WDyMw5HR3E9V+XgOPplKe2benS7rts8zEaWGd0tDx/6dM2qN9lvAOIYqMPW6/WcV3r4jE
fOR+nMCFq0XRd8SPMejX9b9wzqjyFq2gbgvvlj5j1HJMNU0kTEXdcjkgr662t2V1GWaGo1AQmigB
PIBifErKC4x9rX7XneYuRTibGrpE+DpLl/SY3hULOZn05Cak2wxj/PT86p2JrQnzQ4MWfOuFxRny
JijvlVHTjD69Wm/2w7lj7v6zEoqJ3c4PKundPbdhMXiPdigDVJXAqJrPO9z358cCzgEKSFfbibdg
vY0OXqquseK3K6b1xcdB+bdXlhRsTfWlZyKYjroUsdXm/RNTQDLWUGGLGU0uVBpEl04FZlbeJ0wh
Z68nIeT3DkLz4nr/XMyR3UucAAJnZr5fy0yA6WXh3ByZOgOKANMHzIe/OHThAOWFxM6YpeV9TVyo
LwsYYREPPvwXK2HKPIfq5PpvBJJRc9HnxanZZ7CPfP7nrPVDQ0wFwykvrh/t74mzPULW2QjAsK+E
hyQZP1NCkDlG6sRjSujl9qhbnE2Ppc68IdCJ75HlKPtc+ng7dNKzFsh1lhAEEw/V2jR85Xdszcgb
rlGygy3BNmahZmfj/kckdJRKvyXUQWWu/R594/wmlpcdZb3t2kxTUq1hL9X9CRHLflrkCo763uMP
MYzy5oyuqjPU9yiTnFKOFpSZ7IgXY4atipUrtBUSR1PiL4Ur06Ln+IR72Bks81VN/+adxlWWmuNF
6jM0hxyW5CpAochzmHUcZBu4FMy+g900BHvpW1/yr1mwKJI1b6Xb4Hd6T+JeuKlUW9MTIXY+jYqN
jWDzBz4P8i/FTJk2PVR0wBLCU+Hyi4CofISVG6+umFM9aHxz6m9cWfnN+M2AUlDZ15hrB29EFQuI
GZATOfslRgK/J6Dg/aAvgiTUlZop4K9fiAqRrRUgqui2L0EPTTzjqVWMLF55ZqcRDAyz4eMJPZVu
i1xlz2w2xBR6QhT3sxGxL5zXEm9AMno6podS7HHbe074nm9bjDr0LOdEhk3YtwNzTm1usCOoHVZ2
hlwiS0mqyFkjV69B3jhzljvHmf6ofCC5MGM3Hv7NuvQ5nsnOk49NqVCiScR4rzYJzxbF6tkEOlSZ
lUqjqjHSVNWW4YVBv4pqgS0tIdjudAAoQOS9sDEPEQ/LrHtL2r+Twq97NsjY1PKoKLj0fQ8Feqya
Qf9OoEZCjPQJI+FMUL8UGB+yH2j5q3XBywCoVLgW2mF+sXlrwy6inL9PCg1XYm3/PiLJweceh43Q
TD9xRSDSkY3k5eJSK6ctYdjtxlcrMSn3Z0VcmGFrHMAoX++AuwJD1DnpavmIg3wftXRJNokWrLtQ
dUR3rkrgVj+/Waddq74RRBZ4w2sDCaX/JWsgo+VgGVmWAYOZqlnFZGY1p/tvXE4j54k60eqkV61U
YR8pNgKft9swNVb3uV9jWWgOnPKMhTqui2YtgBuguhux+SKN5R/PqKPNTCpehtgRdKHiIMmUGa71
eQs/KmmXsiFH8H2ZMieOfgvz9B1nJl31j/wQ9io04r5/097Lkw3LQb4A8oyTDWv3OHvj5AXKnFh5
bYIHNXx5mHVvESMpwq4ftLShF7WVyq5Ow3E/flIRL5WZ86K+VGvn/J5SDlP4Ha4dICb3eHZt0RZr
sMNFsUyrb9KStbttiXz2TgZzbdf5qWsszkTxsdh4AZdnkDRd7wXQEZtu6plBLVLsZy1rBu8ntHMX
tvsSZIExhQVh56iPRLXp2CTDrGG4LybCGV7mh0vdvMaYD7YO+GXCdVHyhQ9HJ91bY0Jl1hZVOGiI
s0UlWYkx+/OyTBvKRvkdZFqCY5oN7NV4VTaCgbqHPN2c6TdbZXEp3d6YlEgdh0e/JFwWb4F0PI7i
ITlXJU+tNmkdW562Lb3rVLxgs6LbS6efMaSV979TTY/PBLjL6TAsM9e+ZwmjYhZ444vn6jVrndHm
U0j/bkmEVhvnLqJOZcbhJCskGqESirsYMHywgIlGMBaph2gZXv6BFjHBlHxHM45XP4cGr50rTppI
wLd/Cbg+FswdhXh85v72NuLS36eXGko17F9hXCj+0IXeCGUAnCYGmB3WUzzXJtRCEMf+tjjLDp5L
oAz+B47A9WlIGsVxbWNARO6pxgar5vgZ25Fd5FPf8Fi5tROeEawgeJOePa81GLsKutwMlx9N1Lpy
JiyeslfbcHaL4CGXZjs1tIuvr3LndPeVNr/DSbeZ9eRekjmE7vzN+yJIrr+8g06bf5XgFt0Izahm
yyZ+8prMLRh3FMcW/zeNV6wt12/tTEARS5hHpOGLAVkSs1x15Pm3XCxLfzcugnlcOCardyOqD9MK
wVpfeLv/PmfLYl+G70BYziucFTe+aciA+eUCw0Oo1NM7Z3zaOT6daNepVG/4G5wcFSCPZG56pxeF
9COdNLaBdA2SG44GZJlqaI9tFV7OAs/Yrvbl7CIlxdRaxV5KMNaqVNNsax3Azjs+H+CuQz1S6nQg
EOWFdblaYp3523dZH2h1vZrEw3+WjC5RxDxoVQy/ScNXZ0pdYXiT73jrlag0W92VVFIjUKY/LrrY
X1BccseLkBtQeACU4m+fep90bqvxCdO4y2SAwY75YK6H1sireQLpHgv7UIzvVEao6JeVnU6TMYUt
FlNwCSEx5r94HVHGsKtP+uM9/J5SR9JAlBYMF3uUpsNqfroOCS6CA402ZuToIlAEXC1LI4uPbp22
+m1HSFLIof7CQ00neI32Ps3shUYIA+RE2LxoTR2r2Yk1bf/kzeRB9j4DvpM7eW+WWYEQ4Bp/xLhX
DSgOGbIibbN+2AXvkPWTCrBnJ2e8reptnkexBUfD0sNQWCr/OahoqxbgX6YKVPpl6PFc67qJeMD5
6J685EdSPjybqPusxvjfPCAx34310njLopWzW2aWeAe/8bZmY3x9+FH1PFZo0F1rT8c+2ESEuO3N
2A3XZp1N+J7hmRtkfY/I4rn8htalSHM6ghWrdVwXG+YbXvBOKKrgDpzPmrF2XpTWqi5XjvaW+F8e
yzrhZ2kol2g+wjNHI+XYYQDakXaTw8At+rs/wnoGnyLrNe6binLr3bi/cUiH1bFPIWZIjBb/A5la
onKiF/8rjf3EGkOFNL//IMKXuG4sOqV4UE/roLJUIntHFBqzWRaYHgDUgUR4+s0K1HIbh3wUfhF8
vwL+a5hQYTMBVxfGr1mLgR3YbStWI6+mIALWYhjX7+EmHxZZ1C/OlNVUKfxtW8mBY7QOLa5sjhR3
lYpmoJNkFtkfUA2cyD1GLGEF/gd0oui7GVVL4jL3f4CJNRNF28uEMz761WKmCEew4R4JJvR32kVU
f143gnYJWjXeh15cs3e/Znr9CR0cMW6nH1zhYJmLZI2QBm+sxsIjk0CxxWj30hmOcMJKMZZlcgA2
F5Axfl3/QO6zeefQbr+i+NVFm8vcUqLXzsvVZ0E6E0LEE+fpF1+DdT8Uu8cSN447+WTiYTjYeevk
SL+DYYwGyEOBTVAGEgdNhIb/gz61Xb/7ZKkqJdgghWFdBi3XOojDO8JwbSAHXmqA9L53JdnEDrxM
jc8fpJdCd7ft1LsLnfhAPkY8cvxGWqF8+L1yw4avIKjW0iRC2ztWsqkuusBjvGjP4lNyvi3eSk4T
3tACYdswERV+wmvXhWuduuLs50uP8w+1sqQ+MCd4daJftjogKO3S2APBDK3XdTh3B4ld/S0qGuhg
NUDr0Z+amorHRwBs0TlzHneB0brxEpbUhCoEvniQXAqxi1ILQM+aQ06nTvFez6XEG1GcVbcT1eZP
X0U9kGaz826Zea0oUqmVdk4XM0JrzGGSRbxScnC+8fTidzj/605rOIJlOmy/HbaaduYn98yVAXiY
L3LVJWK68He44W6cvGdtEbYVWzeD746Oui2nEUyZDnVeh83SKaT45kaKAPH/TczS08yEQzM1a3rp
SuL/TSV893fCtGcL7BS4/s298gCXvwZbaq4jbgRbJPpkgmzt9wgH9+ywpahpUd7y8JbWMakv4IT2
ubBry9N52RsoQEQ7sEvEOEsS2TSyJ+kgiDKNlHbVNPv8NJqUjlauTo/g4K49M9sBiSb+FTHRkMZ7
e6AfsAZ9Ayickpr6iXAeKZspQ4YBGqCJZrxzqC14c8dAmGMUqCmgtoKg9J9HPDMP8sInIJ5A/i7s
MYypDzmTWSQpVpsK47nZ1WGaBofyvWOk+mq153JlexSPpxaBkR+/QMiJok1JfopEJTVfu0cb6tMx
rcyPJ9AT+Ll8hleKG/fO9LoKEFTNceoaYEKkjOhnOBBxVAlaRPudVdjMdA54SYIMQj7Zf0/kKNQe
Kma1Mqxq4qoHwrdB/cNn42CVFdB8cPZuXfygmN5Hy6tn6bNTDHtniwUML86Sg9bp8AtjRrUDepkK
nyCDQH6tWLEDjVY3jQiXKTR0c5ii9zIlmoKvGjDVVESIVbvj1PGzeHLLDk2edgDIOFKtbcRDRpFu
h9THz+th+JYANceKqzDmJPWaS9DpXWec3gg9hjwp4gEj5+3lPjyD2Cj3STcGsK7UBM+8Ff9YMyoA
dzJACvowLrKxPR730DSPS4qS5PJd5Fsu2qnbrdXVmlpkbj9nsxKCxWn/XTIfJpN75EH5ivw6UDKu
A2KOzF8BushXNeXsohn8z5ktPIDv9Y7yPJ839m7JvsT6Fcbk+JXiGI6ORJvb0M5O/HnpWcr4W62i
DBQhizguL9kCeO9SiZDoeu/qZp8tytx/NWXfca8RLiLIUp02AFWLWw26VvfdF9JePAGh4utU8POO
86j2SqUd9gtCWZOXXourQWj+WZgaYHuhjQECpIqi+tNhUfr+4vdIbrW5pVWK2ClUeRAFW2qnZCvs
HAuQh2VUrQCGf7Qm1EZrZd/Q60RO7TctISVtCMTZu1Q5Ce2G8EcCO/QaAI2WgLbPgqN85lcx7rWJ
6fhI1o4Ihj2GEgnrAAo+Gh4DAwqHNT19XVAiGfxcgjoEdjqL3hxaioMZIaVR0ZJ/ndiRyozYQmVQ
gIhHYLxHst61cY0ZpZWPVk0/4iTzFN9eHQhGgtF2rT7DN4WKuFoPB+rw7GKszmhOIuhi9+snSL/T
JuNQBWpWkRIEvZsKS8bLLrTScXTyDorMGB4enjUqppEre9NAsjFzR6s9Ullbx4FJ8/5OsrJ+nzpz
y4a3+egxZHCHv+uq/F/+SKKtVFRRkRWWntkNj2wYNwCco/H/lq51TDdk3zyAtSte6cYbZJ9vCAe+
t9eh4yV10m0XbGGgyt9wQsCA3DIsC3MFJFFs4PrxYKFinRZ0EPHDqsH+HtlPpngU+nGpXx8B8IfX
TXnlhmgu1mmEM59/eS4YL09irpUZ4FiuXsSj0oCHPlxnwGhmHD41995ebzze0gnsX8Rfu4HQQe9x
uLfOictmUb8aSDVLV32rpQ2vuNQON4D3sb4wftKop0C/bzaWdoVE/LZXcPsq/HWMU68uxYbV+MkR
bfgLlCAOe/2GwJYXova+7Up4Vg/E4+pKzbzA49FYGNIeNjXYVHB+wew1gSm1q+Zd7Lkx3+/8s4N2
FN0Uc0hP1nwhMa0ZtnRe7p7tdwXf83omNFAgosMheC+eBRQb43FIMFkiAAAAAADwsrGtRD6TiwAB
3WLO9wIA42EomrHEZ/sCAAAAAARZWg==

--0rQtslgHZOAF6227--

