Return-Path: <linux-kernel+bounces-543009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CFCA4D077
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD893AC884
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05D41AAC;
	Tue,  4 Mar 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XogE5edF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0E18D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050214; cv=fail; b=uRQdvujlnFEj0ly9QiohYBu/kDJurty7/67hqnoq83iNxKLOLqBXeX9qjqq3+0INt6xDGMKtiDyTW66xXvpLLrlvmYaXq8MhXweFzTdR1qWXWGb1ZdexHIZ1JBm3Pwjzutox43KDMjNZn+nDwmwiv9RZ7u0MjsscEN0RIk4Md04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050214; c=relaxed/simple;
	bh=sf/FnXVQZV7Xome8I8Ns9hSbLZmrp9fscrB7r3b6i5A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LXaA4c5cy6ZlhrcOrLJvjqPJbu/vs+D3bOPI6qCCqRqJpW4S0k0kcYpgA0tt1Z0zLu+ABWjMVFg++7nBnfZlGY27G6Ty31AgCfckwVXVlHwaWDMUx9dFyev+6Hbo3OrKb+/MsxiC4fo/JANEqoyoxCo5vYugydXRzB/GSxe8Bbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XogE5edF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741050209; x=1772586209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sf/FnXVQZV7Xome8I8Ns9hSbLZmrp9fscrB7r3b6i5A=;
  b=XogE5edFRgu25unc6YwGGbWpPgvkqqFPzmZ3t51zQMd9pU934wEDUwXq
   M/CAymhvnuwlk561mqmQF+308S0/Op/6aheht2EU102OvSMMMHHD36cXX
   ctF/qNWd+xwmaMPUhaGtOOxthwGawmU6lvfMo+9mun8oL95ZPmKXlG3TK
   49c2E8ENU5XSRq+BkPLggeYP+3dOw82jCOFenUvnO94Pab9VUOms/LhXB
   ZjfwEKg1TG2kJLlhWCfv2eihrRmf7CQfdq4dnKgNpLcp5eOqfMKZl9Wzw
   QbFvrn6WOlK8SBzPpCZWZsc+G3yqtW3INLoOjXHHxyFS34p32YgV9Mnxq
   A==;
X-CSE-ConnectionGUID: Ix/OvfysSW29c/9Unsbn0Q==
X-CSE-MsgGUID: 4PjgDVBDTeWfjqKAgierOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41842891"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41842891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 17:03:28 -0800
X-CSE-ConnectionGUID: K8e/u0rVTQypyDuG0ABO3w==
X-CSE-MsgGUID: EpuV/86lQAS8FHh0rrSXOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123429654"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 17:03:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Mar 2025 17:03:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 17:03:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 17:03:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQvraol+U4mmGjmR7mCca4Sv2Pj4GP2zAjfMyoZY7t6i2m26banIimKds4uwD81WbKDDvcOnuYCtPPV9Q+hWjArhjvQluOj7CAuEMwNPBKDj2mYGigQNn9hPmkS1c4e1l/TK1Sho3hzVdv9E6l6XTvBQnjBI0SzavDQGPD4hGLxQrn264O7ZNNqcl5wQj8aZxqHb++ESsufO+8j3cqF4CQIsDpRN4dVikd5fBi9GBS34dRFF6YXLrPxKI5hE/z43zUqLFQqYj625WbT+CpB7hHVmVQQ+e8qCtd7otyD+pKQ5gzZCPPHuUdWUVhWbhiwhIN7KutTcJPhjfedmeQ7RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=velFwS5HbFCWddb/cvnkqxlaX3vhjxjZdULng8Tkx7k=;
 b=C2SlwhFKUw0Lszb9nIptEgWHAr/iCkjwkJM1JoL0UHmBQxK5TELuWcsDQFOP3ibm3d2BZypVBzPM1Z0ja4G9hHTG1OguhSmXNelM8XwptE3hlrE7uW8RxOh3d8iiSAma13sBtyFD0Ls93DUjaMs2vfPKM+nqWtwgeoEmB7lVgKSn5W7NGf0VYRURH5nQ9UyG2MvDjniPCzGE5tY/W9tvKiiI9kXD8VLUKhguRZ7CWhckm5caYhw0HV6ha9gxPA7nSb5A7jdp5RaKy/rEbt1y4A7Ah1jpCCPytx4heWC52hBh+inxSHI1QOMhya3aXwyCk+4ToPeuSwRodFLYxXI+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH3PR11MB7273.namprd11.prod.outlook.com (2603:10b6:610:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 01:02:54 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:02:54 +0000
Date: Tue, 4 Mar 2025 09:02:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>
Subject: arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:787.22-795.6: Warning
 (simple_bus_reg): /soc/bus@fe000000/pwm@54000: simple-bus unit address
 format error, expected "d2f0"
Message-ID: <Z8ZRNYX/MybgNA4P@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH3PR11MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 866e02f6-2b7a-4dc8-6fbf-08dd5ab84af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?byTBfsI/7K6k2GL6XsL8p+XrlLYHjgvmxbVUL8Tu8vqtxRkCyq6X+0N2UPBt?=
 =?us-ascii?Q?scJbxghpT+GsZI7golT79wxlXpuJLWg+a5w206V1p+0rgXHVZdWFexO7S+SO?=
 =?us-ascii?Q?6E7qDT09xC9W4XmFJdjzViR7dsBReHzPX7K3xvlQzKWlf9ZJOeiKqbtRQPuk?=
 =?us-ascii?Q?kcioCBzH7ubpQXu2qAKdhDNjJPqvpgml2QnQ/s4oFk1dN0XVU6O5SIRfFTp7?=
 =?us-ascii?Q?v0s0NgoCfs/opDhwaU5vJFf6XgN6e7rhnaOM6QzpGcHizMW3Uo6CxSbtBgQ6?=
 =?us-ascii?Q?xYmkVcW7p0kPs14tWcZ4dOvhCbnvz8dfRHfvGc4i7mB59vi78OmfSiD0EVCR?=
 =?us-ascii?Q?5n4aQAWJ9SvmyoQPMrF1dZtQ1Kc3AwPi5WjA4zBISwDTXC0SlKK2e5tmDD/m?=
 =?us-ascii?Q?mr/6umTnPxLfJlazbesvkYjC4bNVRCF310Ppun/2voeKMI5g796vjyEELINA?=
 =?us-ascii?Q?8GNzHaVw/BxZm511BQXAFe2BzyTcnkaMuDRkjPoyzM1iz73FRIXW7e0jV1Nn?=
 =?us-ascii?Q?3882JWez4EhfufYbqPeHlz7ztBv4dVYEAHbIgUsyHwOz0gVLA6aALG6FTvte?=
 =?us-ascii?Q?UM8/s1kLY9WeG4CeNGNbeCgLo6QYOKVCM6/TLUfM8fIsJEhDudVN/5k6STO5?=
 =?us-ascii?Q?OcKq4SvzVuvTYNUsVXUnKmVUTb5f2UgNe6toNEQ9Dl/ELu0MESF81+eo5R2Q?=
 =?us-ascii?Q?yMEQsCrqZEOtq5Dp3tiaJGqdm0dwvka03vn2WQtFXTV+zgELPeb8ADRUl9jx?=
 =?us-ascii?Q?r8orAezCM4byMUloB8MCxxlOWoVPZ5bvQ+t7eYlpuHbsVwb5t0BTIc+VI25N?=
 =?us-ascii?Q?DXow30bquDTQ0aU+6FwEtZwFruRbrv7RMYPYPUlN5rBlelGVmoWoNIU0+4il?=
 =?us-ascii?Q?kSgVrnackqJyWfTmxGbBxnjJzBVl5djpXOfuglAZ6Zxz7fTCI0o+ahZ3y4n+?=
 =?us-ascii?Q?GLsH/tCxeIPETLDoEOFyyzZvtK04/yYiZzcI0HJxe5VMt97CZGEPGOAGD7Fx?=
 =?us-ascii?Q?toiPJU99iw8j4CRMUxHo0liNzGp8jxaEDtCwb5GLJYX11gHoEepNu0dWW25B?=
 =?us-ascii?Q?X0JYMlkuu2Xr1jKAb6/mMpnkbCZ5tfoeJWrbsoWGQCHOftsZhdG1K5ITiCw1?=
 =?us-ascii?Q?RBYtUlw6D5J+awgOHZ5UVHXOK6aItzHZ7EQ/eMLRL4GdIjCIG1S+2eHzGU/j?=
 =?us-ascii?Q?kPeJ1AvVuOPuz95YcmgmYJS4DTD/CSgOgYX2b79ApidHeAzo6QSCtABaHZLP?=
 =?us-ascii?Q?Q2AbVtp7RniYDWHXunR91vd/NZRK3jqs2aL7hsqR+bDyVRpwwtvWu8z3iYZe?=
 =?us-ascii?Q?DpsR1yX4I7GCRhS20gPoYS35nwugp4TDUoPYNTKdjtw/rOGjXz5/kN0zaUVA?=
 =?us-ascii?Q?BXfmyHIHVTVekYxEPey6g+/Ydqws9yJg8cP+YSN8DY4F0Wmi/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sc6oJyyR4sECifHgmJOLNc1NILfwbsfJU7IptNJT3dKPYpgRp+sa1OObqIez?=
 =?us-ascii?Q?YTagFJ0DTxh8mTS5wlgtG6qF6EK3nGUurrWJUAMohdqf9NgghnzCZy5HXNTp?=
 =?us-ascii?Q?6L8lbnwLE+13M7B/Q+Is6u+6ol/4bnUxNLCqc7qayEcLqL9AxehLe6ERVJJW?=
 =?us-ascii?Q?lEsFzgWgTuHKG/98In8guy3YAcZ1Z1eMycxNDZwQzj2zkVuJcVxTnZl4qDS8?=
 =?us-ascii?Q?oITWfli9al1cMhST18oo3dtlIizs75E+/vhBXCUexw7mEHhujc8Z1nsQWvG+?=
 =?us-ascii?Q?o3mgzewvq2ZFNM3GXE35CoNaehS3r0MbTuKoLsEff8HVSXtJB9Yqxoia7teu?=
 =?us-ascii?Q?IRvA0XBlJDn5OL03WCkGcsqTIi7Llox+VbIIPC4hUQKBaDl6f6U4PdwW+0si?=
 =?us-ascii?Q?UeFjo+R2EBbYnvFeMi7sjqqBTvdhmxqDsTIEvEXD2PTl82S/zlARF9zJ7npu?=
 =?us-ascii?Q?LU1Jok/SnLrl2ewzPsuzImfKupF6EGpdytZb7Mf2xk19WYVNASVQv5SetEeS?=
 =?us-ascii?Q?84BTp4h6FiEUw/NrYHKzPBtkwum/OgG1AigW70D7PoiVc6Jwz/OyJeCIh0oP?=
 =?us-ascii?Q?Mj85cTXkKI6VirlMrbJfNkB/MIPtCLN6Jn5s5q8UcMW2Dr7iB0YRts2/i2fg?=
 =?us-ascii?Q?fC9ej0pPVy7+O2NSb557F12wmJc+Skg1wjCwd/ekKR0O1EudBqT8lv0pvgWy?=
 =?us-ascii?Q?XxulbW5HF8WIaUjDfLfS+Rtqn+hoOcTsod+P1n5pfqCV380WwIAO3mUb0MdC?=
 =?us-ascii?Q?HbfmOjtZH07S0OyvhEKXyv1uzf5xmXz/zzm5dedwrqq3wxbL+V7NQsmQ/Xcl?=
 =?us-ascii?Q?yhNa9z39h6isLTH1NH+b2yOasjhiQNlNkdOYcIsAYxgCL+EeZMhv0hc3cjS/?=
 =?us-ascii?Q?/O8HxpnTEu3IRrf/TpkhYtl9Ej1VSX4oLZdS31pDP5B+gagQcmE4TYoamwXd?=
 =?us-ascii?Q?fEH0xeTb2si2S+QadbT/jZjFG1Wzfp6zb6eu3b98iFXeNKU7cOGj9RwbCdIx?=
 =?us-ascii?Q?tmf8UhyOBvIbo+wRE7zx+rLnPmLt5IbybY/g2lF1kPUPAHPAmBu9Sj32J9P7?=
 =?us-ascii?Q?Xg6GixLZAjBYe7X4rGZ7xz5+rJYqjMLeQu2s4tVK8Vocrm1ibzov6ATa0asw?=
 =?us-ascii?Q?H6Z3P6M/wqKwpb6LRgtF3fK7PbFwmu6jesA/TznoQxN1Y9f6qg+BYyBBg3PZ?=
 =?us-ascii?Q?IKFnQpCaGC1u4K5AackoabSLcTu21kwzJ0ZiKgdqYqfVMV9mmcWXuXYJg2Cw?=
 =?us-ascii?Q?M+ZLNkchdtE3/ZXhTPzJWSNCNX7UhTy+p90nBpD6lOd4LxWNZCbiAUI9qpMj?=
 =?us-ascii?Q?XEQIVOquauKKGQ4fskp1+if7lYF7/Ll+NmtIm47PploKXvyCAv+dxCCZQk5a?=
 =?us-ascii?Q?QDqR0FdAalBtJLn/y/CArU2+5IdfVOsZNa1VrEvda0lcx0SHFPkQU5U3Qkvj?=
 =?us-ascii?Q?nAVZ6gkHy+JWDNNxQQKxNvhwlHzzwqXRnjJTjx97wK73lLbZfYCqGohP685V?=
 =?us-ascii?Q?8OxfoSgML9dnL77pSW8+7+OaU9cnloGsC0yJxVoDT3Wap4tDPe8Ik7xyLdw3?=
 =?us-ascii?Q?BCwiWxE/vcsuYsQlCvyguir8jLwFO9kCKeRppo/yC+ak4dWrdlCUjTfJOV1v?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e02f6-2b7a-4dc8-6fbf-08dd5ab84af3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:02:54.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4avYV6FVd3VeN97DeZGaIgcPCezDz0KEYASgoHCJzmE39ymgN2Y2VKf4a3T+mDuFV84isCmZrDbeCLXUtnvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7273
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eb172143d5508b4da468ed59ee857c6e5e01da6
commit: be90cd4bd422e8ae235f534a2fa46d40dae0816b arm64: dts: amlogic: Add Amlogic C3 PWM
date:   5 months ago
:::::: branch date: 20 hours ago
:::::: commit date: 5 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20250304/202503040046.XSme3I6W-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040046.XSme3I6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202503040046.XSme3I6W-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi:787.22-795.6: Warning (simple_bus_reg): /soc/bus@fe000000/pwm@54000: simple-bus unit address format error, expected "d2f0"

vim +/d2f0 +787 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi

02310be6f08007 Xianwei Zhao   2023-05-15   15  
02310be6f08007 Xianwei Zhao   2023-05-15   16  / {
02310be6f08007 Xianwei Zhao   2023-05-15   17  	cpus {
02310be6f08007 Xianwei Zhao   2023-05-15   18  		#address-cells = <2>;
02310be6f08007 Xianwei Zhao   2023-05-15   19  		#size-cells = <0>;
02310be6f08007 Xianwei Zhao   2023-05-15   20  
02310be6f08007 Xianwei Zhao   2023-05-15   21  		cpu0: cpu@0 {
02310be6f08007 Xianwei Zhao   2023-05-15   22  			device_type = "cpu";
02310be6f08007 Xianwei Zhao   2023-05-15   23  			compatible = "arm,cortex-a35";
02310be6f08007 Xianwei Zhao   2023-05-15   24  			reg = <0x0 0x0>;
02310be6f08007 Xianwei Zhao   2023-05-15   25  			enable-method = "psci";
02310be6f08007 Xianwei Zhao   2023-05-15   26  		};
02310be6f08007 Xianwei Zhao   2023-05-15   27  
02310be6f08007 Xianwei Zhao   2023-05-15   28  		cpu1: cpu@1 {
02310be6f08007 Xianwei Zhao   2023-05-15   29  			device_type = "cpu";
02310be6f08007 Xianwei Zhao   2023-05-15   30  			compatible = "arm,cortex-a35";
02310be6f08007 Xianwei Zhao   2023-05-15   31  			reg = <0x0 0x1>;
02310be6f08007 Xianwei Zhao   2023-05-15   32  			enable-method = "psci";
02310be6f08007 Xianwei Zhao   2023-05-15   33  		};
02310be6f08007 Xianwei Zhao   2023-05-15   34  	};
02310be6f08007 Xianwei Zhao   2023-05-15   35  
02310be6f08007 Xianwei Zhao   2023-05-15   36  	timer {
02310be6f08007 Xianwei Zhao   2023-05-15   37  		compatible = "arm,armv8-timer";
02310be6f08007 Xianwei Zhao   2023-05-15   38  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
02310be6f08007 Xianwei Zhao   2023-05-15   39  			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
02310be6f08007 Xianwei Zhao   2023-05-15   40  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
02310be6f08007 Xianwei Zhao   2023-05-15   41  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
02310be6f08007 Xianwei Zhao   2023-05-15   42  	};
02310be6f08007 Xianwei Zhao   2023-05-15   43  
02310be6f08007 Xianwei Zhao   2023-05-15   44  	psci {
02310be6f08007 Xianwei Zhao   2023-05-15   45  		compatible = "arm,psci-1.0";
02310be6f08007 Xianwei Zhao   2023-05-15   46  		method = "smc";
02310be6f08007 Xianwei Zhao   2023-05-15   47  	};
02310be6f08007 Xianwei Zhao   2023-05-15   48  
02310be6f08007 Xianwei Zhao   2023-05-15   49  	xtal: xtal-clk {
02310be6f08007 Xianwei Zhao   2023-05-15   50  		compatible = "fixed-clock";
02310be6f08007 Xianwei Zhao   2023-05-15   51  		clock-frequency = <24000000>;
02310be6f08007 Xianwei Zhao   2023-05-15   52  		clock-output-names = "xtal";
02310be6f08007 Xianwei Zhao   2023-05-15   53  		#clock-cells = <0>;
02310be6f08007 Xianwei Zhao   2023-05-15   54  	};
02310be6f08007 Xianwei Zhao   2023-05-15   55  
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   56  	sm: secure-monitor {
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   57  		compatible = "amlogic,meson-gxbb-sm";
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   58  
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   59  		pwrc: power-controller {
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   60  			compatible = "amlogic,c3-pwrc";
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   61  			#power-domain-cells = <1>;
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   62  		};
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   63  	};
22a9b2a488c3f0 Xianwei Zhao   2023-07-07   64  
ca55a30d27cb37 Xianwei Zhao   2024-09-02   65  	sram@7f50e00 {
520b792e83171e Xianwei Zhao   2024-08-30   66  		compatible = "mmio-sram";
520b792e83171e Xianwei Zhao   2024-08-30   67  		reg = <0x0 0x07f50e00 0x0 0x100>;
520b792e83171e Xianwei Zhao   2024-08-30   68  		#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30   69  		#size-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30   70  		ranges = <0 0x0 0x07f50e00 0x100>;
520b792e83171e Xianwei Zhao   2024-08-30   71  
520b792e83171e Xianwei Zhao   2024-08-30   72  		scmi_shmem: sram@0 {
520b792e83171e Xianwei Zhao   2024-08-30   73  			compatible = "arm,scmi-shmem";
520b792e83171e Xianwei Zhao   2024-08-30   74  			reg = <0x0 0x100>;
520b792e83171e Xianwei Zhao   2024-08-30   75  		};
520b792e83171e Xianwei Zhao   2024-08-30   76  	};
520b792e83171e Xianwei Zhao   2024-08-30   77  
520b792e83171e Xianwei Zhao   2024-08-30   78  	firmware {
520b792e83171e Xianwei Zhao   2024-08-30   79  		scmi: scmi {
520b792e83171e Xianwei Zhao   2024-08-30   80  			compatible = "arm,scmi-smc";
520b792e83171e Xianwei Zhao   2024-08-30   81  			arm,smc-id = <0x820000C1>;
520b792e83171e Xianwei Zhao   2024-08-30   82  			shmem = <&scmi_shmem>;
520b792e83171e Xianwei Zhao   2024-08-30   83  			#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30   84  			#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30   85  
520b792e83171e Xianwei Zhao   2024-08-30   86  			scmi_clk: protocol@14 {
520b792e83171e Xianwei Zhao   2024-08-30   87  				reg = <0x14>;
520b792e83171e Xianwei Zhao   2024-08-30   88  				#clock-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30   89  			};
520b792e83171e Xianwei Zhao   2024-08-30   90  		};
520b792e83171e Xianwei Zhao   2024-08-30   91  	};
520b792e83171e Xianwei Zhao   2024-08-30   92  
02310be6f08007 Xianwei Zhao   2023-05-15   93  	soc {
02310be6f08007 Xianwei Zhao   2023-05-15   94  		compatible = "simple-bus";
02310be6f08007 Xianwei Zhao   2023-05-15   95  		#address-cells = <2>;
02310be6f08007 Xianwei Zhao   2023-05-15   96  		#size-cells = <2>;
02310be6f08007 Xianwei Zhao   2023-05-15   97  		ranges;
02310be6f08007 Xianwei Zhao   2023-05-15   98  
02310be6f08007 Xianwei Zhao   2023-05-15   99  		gic: interrupt-controller@fff01000 {
02310be6f08007 Xianwei Zhao   2023-05-15  100  			compatible = "arm,gic-400";
02310be6f08007 Xianwei Zhao   2023-05-15  101  			#interrupt-cells = <3>;
02310be6f08007 Xianwei Zhao   2023-05-15  102  			#address-cells = <0>;
02310be6f08007 Xianwei Zhao   2023-05-15  103  			interrupt-controller;
02310be6f08007 Xianwei Zhao   2023-05-15  104  			reg = <0x0 0xfff01000 0 0x1000>,
02310be6f08007 Xianwei Zhao   2023-05-15  105  			      <0x0 0xfff02000 0 0x2000>,
02310be6f08007 Xianwei Zhao   2023-05-15  106  			      <0x0 0xfff04000 0 0x2000>,
02310be6f08007 Xianwei Zhao   2023-05-15  107  			      <0x0 0xfff06000 0 0x2000>;
02310be6f08007 Xianwei Zhao   2023-05-15  108  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
02310be6f08007 Xianwei Zhao   2023-05-15  109  		};
02310be6f08007 Xianwei Zhao   2023-05-15  110  
02310be6f08007 Xianwei Zhao   2023-05-15  111  		apb4: bus@fe000000 {
02310be6f08007 Xianwei Zhao   2023-05-15  112  			compatible = "simple-bus";
02310be6f08007 Xianwei Zhao   2023-05-15  113  			reg = <0x0 0xfe000000 0x0 0x480000>;
02310be6f08007 Xianwei Zhao   2023-05-15  114  			#address-cells = <2>;
02310be6f08007 Xianwei Zhao   2023-05-15  115  			#size-cells = <2>;
02310be6f08007 Xianwei Zhao   2023-05-15  116  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
02310be6f08007 Xianwei Zhao   2023-05-15  117  
520b792e83171e Xianwei Zhao   2024-08-30  118  			clkc_periphs: clock-controller@0 {
520b792e83171e Xianwei Zhao   2024-08-30  119  				compatible = "amlogic,c3-peripherals-clkc";
520b792e83171e Xianwei Zhao   2024-08-30  120  				reg = <0x0 0x0 0x0 0x49c>;
520b792e83171e Xianwei Zhao   2024-08-30  121  				#clock-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  122  				clocks = <&xtal>,
520b792e83171e Xianwei Zhao   2024-08-30  123  					 <&scmi_clk CLKID_OSC>,
520b792e83171e Xianwei Zhao   2024-08-30  124  					 <&scmi_clk CLKID_FIXED_PLL_OSC>,
520b792e83171e Xianwei Zhao   2024-08-30  125  					 <&clkc_pll CLKID_FCLK_DIV2>,
520b792e83171e Xianwei Zhao   2024-08-30  126  					 <&clkc_pll CLKID_FCLK_DIV2P5>,
520b792e83171e Xianwei Zhao   2024-08-30  127  					 <&clkc_pll CLKID_FCLK_DIV3>,
520b792e83171e Xianwei Zhao   2024-08-30  128  					 <&clkc_pll CLKID_FCLK_DIV4>,
520b792e83171e Xianwei Zhao   2024-08-30  129  					 <&clkc_pll CLKID_FCLK_DIV5>,
520b792e83171e Xianwei Zhao   2024-08-30  130  					 <&clkc_pll CLKID_FCLK_DIV7>,
520b792e83171e Xianwei Zhao   2024-08-30  131  					 <&clkc_pll CLKID_GP0_PLL>,
520b792e83171e Xianwei Zhao   2024-08-30  132  					 <&scmi_clk CLKID_GP1_PLL_OSC>,
520b792e83171e Xianwei Zhao   2024-08-30  133  					 <&clkc_pll CLKID_HIFI_PLL>,
520b792e83171e Xianwei Zhao   2024-08-30  134  					 <&scmi_clk CLKID_SYS_CLK>,
520b792e83171e Xianwei Zhao   2024-08-30  135  					 <&scmi_clk CLKID_AXI_CLK>,
520b792e83171e Xianwei Zhao   2024-08-30  136  					 <&scmi_clk CLKID_SYS_PLL_DIV16>,
520b792e83171e Xianwei Zhao   2024-08-30  137  					 <&scmi_clk CLKID_CPU_CLK_DIV16>;
520b792e83171e Xianwei Zhao   2024-08-30  138  				clock-names = "xtal_24m",
520b792e83171e Xianwei Zhao   2024-08-30  139  					      "oscin",
520b792e83171e Xianwei Zhao   2024-08-30  140  					      "fix",
520b792e83171e Xianwei Zhao   2024-08-30  141  					      "fdiv2",
520b792e83171e Xianwei Zhao   2024-08-30  142  					      "fdiv2p5",
520b792e83171e Xianwei Zhao   2024-08-30  143  					      "fdiv3",
520b792e83171e Xianwei Zhao   2024-08-30  144  					      "fdiv4",
520b792e83171e Xianwei Zhao   2024-08-30  145  					      "fdiv5",
520b792e83171e Xianwei Zhao   2024-08-30  146  					      "fdiv7",
520b792e83171e Xianwei Zhao   2024-08-30  147  					      "gp0",
520b792e83171e Xianwei Zhao   2024-08-30  148  					      "gp1",
520b792e83171e Xianwei Zhao   2024-08-30  149  					      "hifi",
520b792e83171e Xianwei Zhao   2024-08-30  150  					      "sysclk",
520b792e83171e Xianwei Zhao   2024-08-30  151  					      "axiclk",
520b792e83171e Xianwei Zhao   2024-08-30  152  					      "sysplldiv16",
520b792e83171e Xianwei Zhao   2024-08-30  153  					      "cpudiv16";
520b792e83171e Xianwei Zhao   2024-08-30  154  			};
520b792e83171e Xianwei Zhao   2024-08-30  155  
1e75c2276a4fa0 Zelong Dong    2023-09-14  156  			reset: reset-controller@2000 {
1e75c2276a4fa0 Zelong Dong    2023-09-14  157  				compatible = "amlogic,c3-reset";
1e75c2276a4fa0 Zelong Dong    2023-09-14  158  				reg = <0x0 0x2000 0x0 0x98>;
1e75c2276a4fa0 Zelong Dong    2023-09-14  159  				#reset-cells = <1>;
1e75c2276a4fa0 Zelong Dong    2023-09-14  160  			};
1e75c2276a4fa0 Zelong Dong    2023-09-14  161  
a30c7a73b0ad50 Huqiang Qin    2023-10-27  162  			watchdog@2100 {
a30c7a73b0ad50 Huqiang Qin    2023-10-27  163  				compatible = "amlogic,c3-wdt", "amlogic,t7-wdt";
a30c7a73b0ad50 Huqiang Qin    2023-10-27  164  				reg = <0x0 0x2100 0x0 0x10>;
a30c7a73b0ad50 Huqiang Qin    2023-10-27  165  				clocks = <&xtal>;
a30c7a73b0ad50 Huqiang Qin    2023-10-27  166  			};
a30c7a73b0ad50 Huqiang Qin    2023-10-27  167  
cac34b2b3f5a9d Huqiang Qin    2023-07-20  168  			periphs_pinctrl: pinctrl@4000 {
cac34b2b3f5a9d Huqiang Qin    2023-07-20  169  				compatible = "amlogic,c3-periphs-pinctrl";
cac34b2b3f5a9d Huqiang Qin    2023-07-20  170  				#address-cells = <2>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  171  				#size-cells = <2>;
ca55a30d27cb37 Xianwei Zhao   2024-09-02  172  				ranges = <0x0 0x0 0x0 0x4000 0x0 0x02de>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  173  
ca55a30d27cb37 Xianwei Zhao   2024-09-02  174  				gpio: bank@0 {
ca55a30d27cb37 Xianwei Zhao   2024-09-02  175  					reg = <0x0 0x0 0x0 0x004c>,
ca55a30d27cb37 Xianwei Zhao   2024-09-02  176  					      <0x0 0x100 0x0 0x01de>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  177  					reg-names = "mux", "gpio";
cac34b2b3f5a9d Huqiang Qin    2023-07-20  178  					gpio-controller;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  179  					#gpio-cells = <2>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  180  					gpio-ranges = <&periphs_pinctrl 0 0 55>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  181  				};
520b792e83171e Xianwei Zhao   2024-08-30  182  
520b792e83171e Xianwei Zhao   2024-08-30  183  				i2c0_pins1: i2c0-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  184  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  185  						groups = "i2c0_sda_e",
520b792e83171e Xianwei Zhao   2024-08-30  186  							 "i2c0_scl_e";
520b792e83171e Xianwei Zhao   2024-08-30  187  						function = "i2c0";
520b792e83171e Xianwei Zhao   2024-08-30  188  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  189  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  190  					};
520b792e83171e Xianwei Zhao   2024-08-30  191  				};
520b792e83171e Xianwei Zhao   2024-08-30  192  
520b792e83171e Xianwei Zhao   2024-08-30  193  				i2c0_pins2: i2c0-pins2 {
520b792e83171e Xianwei Zhao   2024-08-30  194  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  195  						groups = "i2c0_sda_d",
520b792e83171e Xianwei Zhao   2024-08-30  196  							 "i2c0_scl_d";
520b792e83171e Xianwei Zhao   2024-08-30  197  						function = "i2c0";
520b792e83171e Xianwei Zhao   2024-08-30  198  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  199  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  200  					};
520b792e83171e Xianwei Zhao   2024-08-30  201  				};
520b792e83171e Xianwei Zhao   2024-08-30  202  
520b792e83171e Xianwei Zhao   2024-08-30  203  				i2c1_pins1: i2c1-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  204  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  205  						groups = "i2c1_sda_x",
520b792e83171e Xianwei Zhao   2024-08-30  206  							 "i2c1_scl_x";
520b792e83171e Xianwei Zhao   2024-08-30  207  						function = "i2c1";
520b792e83171e Xianwei Zhao   2024-08-30  208  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  209  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  210  					};
520b792e83171e Xianwei Zhao   2024-08-30  211  				};
520b792e83171e Xianwei Zhao   2024-08-30  212  
520b792e83171e Xianwei Zhao   2024-08-30  213  				i2c1_pins2: i2c1-pins2 {
520b792e83171e Xianwei Zhao   2024-08-30  214  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  215  						groups = "i2c1_sda_d",
520b792e83171e Xianwei Zhao   2024-08-30  216  							 "i2c1_scl_d";
520b792e83171e Xianwei Zhao   2024-08-30  217  						function = "i2c1";
520b792e83171e Xianwei Zhao   2024-08-30  218  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  219  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  220  					};
520b792e83171e Xianwei Zhao   2024-08-30  221  				};
520b792e83171e Xianwei Zhao   2024-08-30  222  
520b792e83171e Xianwei Zhao   2024-08-30  223  				i2c1_pins3: i2c1-pins3 {
520b792e83171e Xianwei Zhao   2024-08-30  224  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  225  						groups = "i2c1_sda_a",
520b792e83171e Xianwei Zhao   2024-08-30  226  							 "i2c1_scl_a";
520b792e83171e Xianwei Zhao   2024-08-30  227  						function = "i2c1";
520b792e83171e Xianwei Zhao   2024-08-30  228  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  229  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  230  					};
520b792e83171e Xianwei Zhao   2024-08-30  231  				};
520b792e83171e Xianwei Zhao   2024-08-30  232  
520b792e83171e Xianwei Zhao   2024-08-30  233  				i2c1_pins4: i2c1-pins4 {
520b792e83171e Xianwei Zhao   2024-08-30  234  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  235  						groups = "i2c1_sda_b",
520b792e83171e Xianwei Zhao   2024-08-30  236  							 "i2c1_scl_b";
520b792e83171e Xianwei Zhao   2024-08-30  237  						function = "i2c1";
520b792e83171e Xianwei Zhao   2024-08-30  238  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  239  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  240  					};
520b792e83171e Xianwei Zhao   2024-08-30  241  				};
520b792e83171e Xianwei Zhao   2024-08-30  242  
520b792e83171e Xianwei Zhao   2024-08-30  243  				i2c2_pins1: i2c2-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  244  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  245  						groups = "i2c2_sda",
520b792e83171e Xianwei Zhao   2024-08-30  246  							 "i2c2_scl";
520b792e83171e Xianwei Zhao   2024-08-30  247  						function = "i2c2";
520b792e83171e Xianwei Zhao   2024-08-30  248  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  249  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  250  					};
520b792e83171e Xianwei Zhao   2024-08-30  251  				};
520b792e83171e Xianwei Zhao   2024-08-30  252  
520b792e83171e Xianwei Zhao   2024-08-30  253  				i2c3_pins1: i2c3-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  254  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  255  						groups = "i2c3_sda_c",
520b792e83171e Xianwei Zhao   2024-08-30  256  							 "i2c3_scl_c";
520b792e83171e Xianwei Zhao   2024-08-30  257  						function = "i2c3";
520b792e83171e Xianwei Zhao   2024-08-30  258  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  259  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  260  					};
520b792e83171e Xianwei Zhao   2024-08-30  261  				};
520b792e83171e Xianwei Zhao   2024-08-30  262  
520b792e83171e Xianwei Zhao   2024-08-30  263  				i2c3_pins2: i2c3-pins2 {
520b792e83171e Xianwei Zhao   2024-08-30  264  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  265  						groups = "i2c3_sda_x",
520b792e83171e Xianwei Zhao   2024-08-30  266  							 "i2c3_scl_x";
520b792e83171e Xianwei Zhao   2024-08-30  267  						function = "i2c3";
520b792e83171e Xianwei Zhao   2024-08-30  268  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  269  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  270  					};
520b792e83171e Xianwei Zhao   2024-08-30  271  				};
520b792e83171e Xianwei Zhao   2024-08-30  272  
520b792e83171e Xianwei Zhao   2024-08-30  273  				i2c3_pins3: i2c3-pins3 {
520b792e83171e Xianwei Zhao   2024-08-30  274  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  275  						groups = "i2c3_sda_d",
520b792e83171e Xianwei Zhao   2024-08-30  276  							 "i2c3_scl_d";
520b792e83171e Xianwei Zhao   2024-08-30  277  						function = "i2c3";
520b792e83171e Xianwei Zhao   2024-08-30  278  						bias-disable;
520b792e83171e Xianwei Zhao   2024-08-30  279  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  280  					};
520b792e83171e Xianwei Zhao   2024-08-30  281  				};
520b792e83171e Xianwei Zhao   2024-08-30  282  
520b792e83171e Xianwei Zhao   2024-08-30  283  				nand_pins: nand-pins {
520b792e83171e Xianwei Zhao   2024-08-30  284  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  285  						groups = "emmc_nand_d0",
520b792e83171e Xianwei Zhao   2024-08-30  286  							 "emmc_nand_d1",
520b792e83171e Xianwei Zhao   2024-08-30  287  							 "emmc_nand_d2",
520b792e83171e Xianwei Zhao   2024-08-30  288  							 "emmc_nand_d3",
520b792e83171e Xianwei Zhao   2024-08-30  289  							 "emmc_nand_d4",
520b792e83171e Xianwei Zhao   2024-08-30  290  							 "emmc_nand_d5",
520b792e83171e Xianwei Zhao   2024-08-30  291  							 "emmc_nand_d6",
520b792e83171e Xianwei Zhao   2024-08-30  292  							 "emmc_nand_d7",
520b792e83171e Xianwei Zhao   2024-08-30  293  							 "nand_ce0",
520b792e83171e Xianwei Zhao   2024-08-30  294  							 "nand_ale",
520b792e83171e Xianwei Zhao   2024-08-30  295  							 "nand_cle",
520b792e83171e Xianwei Zhao   2024-08-30  296  							 "nand_wen_clk",
520b792e83171e Xianwei Zhao   2024-08-30  297  							 "nand_ren_wr";
520b792e83171e Xianwei Zhao   2024-08-30  298  						function = "nand";
520b792e83171e Xianwei Zhao   2024-08-30  299  						input-enable;
520b792e83171e Xianwei Zhao   2024-08-30  300  					};
520b792e83171e Xianwei Zhao   2024-08-30  301  				};
520b792e83171e Xianwei Zhao   2024-08-30  302  
520b792e83171e Xianwei Zhao   2024-08-30  303  				sdcard_pins: sdcard-pins {
520b792e83171e Xianwei Zhao   2024-08-30  304  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  305  						groups = "sdcard_d0",
520b792e83171e Xianwei Zhao   2024-08-30  306  							 "sdcard_d1",
520b792e83171e Xianwei Zhao   2024-08-30  307  							 "sdcard_d2",
520b792e83171e Xianwei Zhao   2024-08-30  308  							 "sdcard_d3",
520b792e83171e Xianwei Zhao   2024-08-30  309  							 "sdcard_clk",
520b792e83171e Xianwei Zhao   2024-08-30  310  							 "sdcard_cmd";
520b792e83171e Xianwei Zhao   2024-08-30  311  						function = "sdcard";
520b792e83171e Xianwei Zhao   2024-08-30  312  						bias-pull-up;
520b792e83171e Xianwei Zhao   2024-08-30  313  						drive-strength-microamp = <4000>;
520b792e83171e Xianwei Zhao   2024-08-30  314  					};
520b792e83171e Xianwei Zhao   2024-08-30  315  				};
520b792e83171e Xianwei Zhao   2024-08-30  316  
520b792e83171e Xianwei Zhao   2024-08-30  317  				sdcard_clk_gate_pins: sdcard-clk-cmd-pins {
520b792e83171e Xianwei Zhao   2024-08-30  318  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  319  						groups = "GPIOC_4";
520b792e83171e Xianwei Zhao   2024-08-30  320  						function = "gpio_periphs";
520b792e83171e Xianwei Zhao   2024-08-30  321  						bias-pull-down;
520b792e83171e Xianwei Zhao   2024-08-30  322  						drive-strength-microamp = <4000>;
520b792e83171e Xianwei Zhao   2024-08-30  323  					};
520b792e83171e Xianwei Zhao   2024-08-30  324  				};
520b792e83171e Xianwei Zhao   2024-08-30  325  
520b792e83171e Xianwei Zhao   2024-08-30  326  				sdio_m_clk_gate_pins: sdio-m-clk-cmd-pins {
520b792e83171e Xianwei Zhao   2024-08-30  327  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  328  						groups = "sdio_clk";
520b792e83171e Xianwei Zhao   2024-08-30  329  						function = "sdio";
520b792e83171e Xianwei Zhao   2024-08-30  330  						bias-pull-down;
520b792e83171e Xianwei Zhao   2024-08-30  331  						drive-strength-microamp = <4000>;
520b792e83171e Xianwei Zhao   2024-08-30  332  					};
520b792e83171e Xianwei Zhao   2024-08-30  333  				};
520b792e83171e Xianwei Zhao   2024-08-30  334  
520b792e83171e Xianwei Zhao   2024-08-30  335  				sdio_m_pins: sdio-m-all-pins {
520b792e83171e Xianwei Zhao   2024-08-30  336  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  337  						groups = "sdio_d0",
520b792e83171e Xianwei Zhao   2024-08-30  338  							 "sdio_d1",
520b792e83171e Xianwei Zhao   2024-08-30  339  							 "sdio_d2",
520b792e83171e Xianwei Zhao   2024-08-30  340  							 "sdio_d3",
520b792e83171e Xianwei Zhao   2024-08-30  341  							 "sdio_clk",
520b792e83171e Xianwei Zhao   2024-08-30  342  							 "sdio_cmd";
520b792e83171e Xianwei Zhao   2024-08-30  343  						function = "sdio";
520b792e83171e Xianwei Zhao   2024-08-30  344  						input-enable;
520b792e83171e Xianwei Zhao   2024-08-30  345  						bias-pull-up;
520b792e83171e Xianwei Zhao   2024-08-30  346  						drive-strength-microamp = <4000>;
520b792e83171e Xianwei Zhao   2024-08-30  347  					};
520b792e83171e Xianwei Zhao   2024-08-30  348  				};
520b792e83171e Xianwei Zhao   2024-08-30  349  
520b792e83171e Xianwei Zhao   2024-08-30  350  				spicc0_pins1: spicc0-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  351  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  352  						groups = "spi_a_mosi_b",
520b792e83171e Xianwei Zhao   2024-08-30  353  							 "spi_a_miso_b",
520b792e83171e Xianwei Zhao   2024-08-30  354  							 "spi_a_clk_b";
520b792e83171e Xianwei Zhao   2024-08-30  355  						function = "spi_a";
520b792e83171e Xianwei Zhao   2024-08-30  356  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  357  					};
520b792e83171e Xianwei Zhao   2024-08-30  358  				};
520b792e83171e Xianwei Zhao   2024-08-30  359  
520b792e83171e Xianwei Zhao   2024-08-30  360  				spicc0_pins2: spicc0-pins2 {
520b792e83171e Xianwei Zhao   2024-08-30  361  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  362  						groups = "spi_a_mosi_c",
520b792e83171e Xianwei Zhao   2024-08-30  363  							 "spi_a_miso_c",
520b792e83171e Xianwei Zhao   2024-08-30  364  							 "spi_a_clk_c";
520b792e83171e Xianwei Zhao   2024-08-30  365  						function = "spi_a";
520b792e83171e Xianwei Zhao   2024-08-30  366  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  367  					};
520b792e83171e Xianwei Zhao   2024-08-30  368  				};
520b792e83171e Xianwei Zhao   2024-08-30  369  
520b792e83171e Xianwei Zhao   2024-08-30  370  				spicc0_pins3: spicc0-pins3 {
520b792e83171e Xianwei Zhao   2024-08-30  371  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  372  						groups = "spi_a_mosi_x",
520b792e83171e Xianwei Zhao   2024-08-30  373  							 "spi_a_miso_x",
520b792e83171e Xianwei Zhao   2024-08-30  374  							 "spi_a_clk_x";
520b792e83171e Xianwei Zhao   2024-08-30  375  						function = "spi_a";
520b792e83171e Xianwei Zhao   2024-08-30  376  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  377  					};
520b792e83171e Xianwei Zhao   2024-08-30  378  				};
520b792e83171e Xianwei Zhao   2024-08-30  379  
520b792e83171e Xianwei Zhao   2024-08-30  380  				spicc1_pins1: spicc1-pins1 {
520b792e83171e Xianwei Zhao   2024-08-30  381  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  382  						groups = "spi_b_mosi_d",
520b792e83171e Xianwei Zhao   2024-08-30  383  							 "spi_b_miso_d",
520b792e83171e Xianwei Zhao   2024-08-30  384  							 "spi_b_clk_d";
520b792e83171e Xianwei Zhao   2024-08-30  385  						function = "spi_b";
520b792e83171e Xianwei Zhao   2024-08-30  386  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  387  					};
520b792e83171e Xianwei Zhao   2024-08-30  388  				};
520b792e83171e Xianwei Zhao   2024-08-30  389  
520b792e83171e Xianwei Zhao   2024-08-30  390  				spicc1_pins2: spicc1-pins2 {
520b792e83171e Xianwei Zhao   2024-08-30  391  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  392  						groups = "spi_b_mosi_x",
520b792e83171e Xianwei Zhao   2024-08-30  393  							 "spi_b_miso_x",
520b792e83171e Xianwei Zhao   2024-08-30  394  							 "spi_b_clk_x";
520b792e83171e Xianwei Zhao   2024-08-30  395  						function = "spi_b";
520b792e83171e Xianwei Zhao   2024-08-30  396  						drive-strength-microamp = <3000>;
520b792e83171e Xianwei Zhao   2024-08-30  397  					};
520b792e83171e Xianwei Zhao   2024-08-30  398  				};
520b792e83171e Xianwei Zhao   2024-08-30  399  
520b792e83171e Xianwei Zhao   2024-08-30  400  				spifc_pins: spifc-pins {
520b792e83171e Xianwei Zhao   2024-08-30  401  					mux {
520b792e83171e Xianwei Zhao   2024-08-30  402  						groups = "spif_mo",
520b792e83171e Xianwei Zhao   2024-08-30  403  							 "spif_mi",
520b792e83171e Xianwei Zhao   2024-08-30  404  							 "spif_clk",
520b792e83171e Xianwei Zhao   2024-08-30  405  							 "spif_cs",
520b792e83171e Xianwei Zhao   2024-08-30  406  							 "spif_hold",
520b792e83171e Xianwei Zhao   2024-08-30  407  							 "spif_wp",
520b792e83171e Xianwei Zhao   2024-08-30  408  							 "spif_clk_loop";
520b792e83171e Xianwei Zhao   2024-08-30  409  						function = "spif";
520b792e83171e Xianwei Zhao   2024-08-30  410  						drive-strength-microamp = <4000>;
520b792e83171e Xianwei Zhao   2024-08-30  411  					};
520b792e83171e Xianwei Zhao   2024-08-30  412  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  413  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  414  				pwm_a_pins1: pwm-a-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  415  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  416  						groups = "pwm_a";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  417  						function = "pwm_a";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  418  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  419  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  420  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  421  				pwm_b_pins1: pwm-b-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  422  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  423  						groups = "pwm_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  424  						function = "pwm_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  425  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  426  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  427  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  428  				pwm_c_pins1: pwm-c-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  429  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  430  						groups = "pwm_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  431  						function = "pwm_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  432  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  433  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  434  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  435  				pwm_d_pins1: pwm-d-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  436  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  437  						groups = "pwm_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  438  						function = "pwm_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  439  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  440  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  441  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  442  				pwm_e_pins1: pwm-e-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  443  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  444  						groups = "pwm_e";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  445  						function = "pwm_e";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  446  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  447  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  448  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  449  				pwm_f_pins1: pwm-f-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  450  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  451  						groups = "pwm_f";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  452  						function = "pwm_f";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  453  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  454  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  455  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  456  				pwm_g_pins1: pwm-g-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  457  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  458  						groups = "pwm_g_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  459  						function = "pwm_g";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  460  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  461  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  462  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  463  				pwm_g_pins2: pwm-g-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  464  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  465  						groups = "pwm_g_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  466  						function = "pwm_g";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  467  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  468  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  469  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  470  				pwm_g_pins3: pwm-g-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  471  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  472  						groups = "pwm_g_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  473  						function = "pwm_g";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  474  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  475  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  476  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  477  				pwm_g_pins4: pwm-g-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  478  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  479  						groups = "pwm_g_x0";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  480  						function = "pwm_g";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  481  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  482  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  483  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  484  				pwm_g_pins5: pwm-g-pins5 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  485  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  486  						groups = "pwm_g_x8";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  487  						function = "pwm_g";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  488  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  489  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  490  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  491  				pwm_h_pins1: pwm-h-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  492  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  493  						groups = "pwm_h_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  494  						function = "pwm_h";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  495  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  496  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  497  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  498  				pwm_h_pins2: pwm-h-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  499  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  500  						groups = "pwm_h_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  501  						function = "pwm_h";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  502  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  503  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  504  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  505  				pwm_h_pins3: pwm-h-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  506  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  507  						groups = "pwm_h_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  508  						function = "pwm_h";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  509  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  510  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  511  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  512  				pwm_h_pins4: pwm-h-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  513  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  514  						groups = "pwm_h_x1";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  515  						function = "pwm_h";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  516  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  517  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  518  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  519  				pwm_h_pins5: pwm-h-pins5 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  520  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  521  						groups = "pwm_h_x9";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  522  						function = "pwm_h";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  523  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  524  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  525  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  526  				pwm_i_pins1: pwm-i-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  527  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  528  						groups = "pwm_i_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  529  						function = "pwm_i";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  530  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  531  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  532  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  533  				pwm_i_pins2: pwm-i-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  534  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  535  						groups = "pwm_i_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  536  						function = "pwm_i";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  537  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  538  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  539  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  540  				pwm_i_pins3: pwm-i-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  541  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  542  						groups = "pwm_i_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  543  						function = "pwm_i";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  544  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  545  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  546  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  547  				pwm_i_pins4: pwm-i-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  548  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  549  						groups = "pwm_i_x2";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  550  						function = "pwm_i";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  551  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  552  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  553  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  554  				pwm_i_pins5: pwm-i-pins5 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  555  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  556  						groups = "pwm_i_x10";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  557  						function = "pwm_i";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  558  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  559  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  560  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  561  				pwm_j_pins1: pwm-j-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  562  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  563  						groups = "pwm_j_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  564  						function = "pwm_j";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  565  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  566  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  567  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  568  				pwm_j_pins2: pwm-j-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  569  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  570  						groups = "pwm_j_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  571  						function = "pwm_j";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  572  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  573  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  574  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  575  				pwm_j_pins3: pwm-j-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  576  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  577  						groups = "pwm_j_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  578  						function = "pwm_j";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  579  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  580  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  581  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  582  				pwm_j_pins4: pwm-j-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  583  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  584  						groups = "pwm_j_x3";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  585  						function = "pwm_j";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  586  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  587  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  588  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  589  				pwm_j_pins5: pwm-j-pins5 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  590  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  591  						groups = "pwm_j_x12";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  592  						function = "pwm_j";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  593  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  594  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  595  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  596  				pwm_k_pins1: pwm-k-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  597  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  598  						groups = "pwm_k_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  599  						function = "pwm_k";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  600  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  601  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  602  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  603  				pwm_k_pins2: pwm-k-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  604  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  605  						groups = "pwm_k_d";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  606  						function = "pwm_k";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  607  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  608  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  609  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  610  				pwm_k_pins3: pwm-k-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  611  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  612  						groups = "pwm_k_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  613  						function = "pwm_k";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  614  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  615  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  616  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  617  				pwm_k_pins4: pwm-k-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  618  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  619  						groups = "pwm_k_x4";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  620  						function = "pwm_k";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  621  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  622  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  623  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  624  				pwm_k_pins5: pwm-k-pins5 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  625  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  626  						groups = "pwm_k_x13";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  627  						function = "pwm_k";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  628  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  629  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  630  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  631  				pwm_l_pins1: pwm-l-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  632  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  633  						groups = "pwm_l_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  634  						function = "pwm_l";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  635  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  636  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  637  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  638  				pwm_l_pins2: pwm-l-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  639  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  640  						groups = "pwm_l_x";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  641  						function = "pwm_l";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  642  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  643  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  644  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  645  				pwm_l_pins3: pwm-l-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  646  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  647  						groups = "pwm_l_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  648  						function = "pwm_l";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  649  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  650  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  651  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  652  				pwm_l_pins4: pwm-l-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  653  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  654  						groups = "pwm_l_a";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  655  						function = "pwm_l";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  656  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  657  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  658  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  659  				pwm_m_pins1: pwm-m-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  660  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  661  						groups = "pwm_m_c";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  662  						function = "pwm_m";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  663  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  664  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  665  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  666  				pwm_m_pins2: pwm-m-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  667  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  668  						groups = "pwm_m_x";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  669  						function = "pwm_m";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  670  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  671  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  672  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  673  				pwm_m_pins3: pwm-m-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  674  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  675  						groups = "pwm_m_a";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  676  						function = "pwm_m";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  677  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  678  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  679  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  680  				pwm_m_pins4: pwm-m-pins4 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  681  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  682  						groups = "pwm_m_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  683  						function = "pwm_m";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  684  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  685  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  686  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  687  				pwm_n_pins1: pwm-n-pins1 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  688  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  689  						groups = "pwm_n_x";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  690  						function = "pwm_n";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  691  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  692  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  693  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  694  				pwm_n_pins2: pwm-n-pins2 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  695  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  696  						groups = "pwm_n_a";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  697  						function = "pwm_n";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  698  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  699  				};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  700  
be90cd4bd422e8 Kelvin Zhang   2024-09-14  701  				pwm_n_pins3: pwm-n-pins3 {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  702  					mux {
be90cd4bd422e8 Kelvin Zhang   2024-09-14  703  						groups = "pwm_n_b";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  704  						function = "pwm_n";
be90cd4bd422e8 Kelvin Zhang   2024-09-14  705  					};
be90cd4bd422e8 Kelvin Zhang   2024-09-14  706  				};
cac34b2b3f5a9d Huqiang Qin    2023-07-20  707  			};
cac34b2b3f5a9d Huqiang Qin    2023-07-20  708  
cac34b2b3f5a9d Huqiang Qin    2023-07-20  709  			gpio_intc: interrupt-controller@4080 {
e5d4d006a8c550 Neil Armstrong 2024-06-06  710  				compatible = "amlogic,c3-gpio-intc", "amlogic,meson-gpio-intc";
cac34b2b3f5a9d Huqiang Qin    2023-07-20  711  				reg = <0x0 0x4080 0x0 0x0020>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  712  				interrupt-controller;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  713  				#interrupt-cells = <2>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  714  				amlogic,channel-interrupts =
cac34b2b3f5a9d Huqiang Qin    2023-07-20  715  					<10 11 12 13 14 15 16 17 18 19 20 21>;
cac34b2b3f5a9d Huqiang Qin    2023-07-20  716  			};
cac34b2b3f5a9d Huqiang Qin    2023-07-20  717  
520b792e83171e Xianwei Zhao   2024-08-30  718  			clkc_pll: clock-controller@8000 {
520b792e83171e Xianwei Zhao   2024-08-30  719  				compatible = "amlogic,c3-pll-clkc";
520b792e83171e Xianwei Zhao   2024-08-30  720  				reg = <0x0 0x8000 0x0 0x1a4>;
520b792e83171e Xianwei Zhao   2024-08-30  721  				#clock-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  722  				clocks = <&scmi_clk CLKID_TOP_PLL_OSC>,
520b792e83171e Xianwei Zhao   2024-08-30  723  					 <&scmi_clk CLKID_MCLK_PLL_OSC>,
520b792e83171e Xianwei Zhao   2024-08-30  724  					 <&scmi_clk CLKID_FIXED_PLL_OSC>;
520b792e83171e Xianwei Zhao   2024-08-30  725  				clock-names = "top",
520b792e83171e Xianwei Zhao   2024-08-30  726  					      "mclk",
520b792e83171e Xianwei Zhao   2024-08-30  727  					      "fix";
520b792e83171e Xianwei Zhao   2024-08-30  728  			};
520b792e83171e Xianwei Zhao   2024-08-30  729  
520b792e83171e Xianwei Zhao   2024-08-30  730  			eth_phy: mdio-multiplexer@28000 {
520b792e83171e Xianwei Zhao   2024-08-30  731  				compatible = "amlogic,g12a-mdio-mux";
520b792e83171e Xianwei Zhao   2024-08-30  732  				reg = <0x0 0x28000 0x0 0xa4>;
520b792e83171e Xianwei Zhao   2024-08-30  733  
520b792e83171e Xianwei Zhao   2024-08-30  734  				clocks = <&clkc_periphs CLKID_SYS_ETH_PHY>,
520b792e83171e Xianwei Zhao   2024-08-30  735  					 <&xtal>,
520b792e83171e Xianwei Zhao   2024-08-30  736  					 <&clkc_pll CLKID_FCLK_50M>;
520b792e83171e Xianwei Zhao   2024-08-30  737  				clock-names = "pclk", "clkin0", "clkin1";
520b792e83171e Xianwei Zhao   2024-08-30  738  				mdio-parent-bus = <&mdio0>;
520b792e83171e Xianwei Zhao   2024-08-30  739  				#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  740  				#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  741  
520b792e83171e Xianwei Zhao   2024-08-30  742  				ext_mdio: mdio@0 {
520b792e83171e Xianwei Zhao   2024-08-30  743  					reg = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  744  					#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  745  					#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  746  				};
520b792e83171e Xianwei Zhao   2024-08-30  747  
520b792e83171e Xianwei Zhao   2024-08-30  748  				int_mdio: mdio@1 {
520b792e83171e Xianwei Zhao   2024-08-30  749  					reg = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  750  					#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  751  					#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  752  
520b792e83171e Xianwei Zhao   2024-08-30  753  					internal_ephy: ethernet_phy@8 {
520b792e83171e Xianwei Zhao   2024-08-30  754  						compatible = "ethernet-phy-id0180.3301",
520b792e83171e Xianwei Zhao   2024-08-30  755  							     "ethernet-phy-ieee802.3-c22";
520b792e83171e Xianwei Zhao   2024-08-30  756  						interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
520b792e83171e Xianwei Zhao   2024-08-30  757  						reg = <8>;
520b792e83171e Xianwei Zhao   2024-08-30  758  						max-speed = <100>;
520b792e83171e Xianwei Zhao   2024-08-30  759  					};
520b792e83171e Xianwei Zhao   2024-08-30  760  				};
520b792e83171e Xianwei Zhao   2024-08-30  761  			};
520b792e83171e Xianwei Zhao   2024-08-30  762  
520b792e83171e Xianwei Zhao   2024-08-30  763  			spicc0: spi@50000 {
520b792e83171e Xianwei Zhao   2024-08-30  764  				compatible = "amlogic,meson-g12a-spicc";
520b792e83171e Xianwei Zhao   2024-08-30  765  				reg = <0x0 0x50000 0x0 0x44>;
520b792e83171e Xianwei Zhao   2024-08-30  766  				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
520b792e83171e Xianwei Zhao   2024-08-30  767  				clocks = <&clkc_periphs CLKID_SYS_SPICC_0>,
520b792e83171e Xianwei Zhao   2024-08-30  768  					 <&clkc_periphs CLKID_SPICC_A>;
520b792e83171e Xianwei Zhao   2024-08-30  769  				clock-names = "core", "pclk";
520b792e83171e Xianwei Zhao   2024-08-30  770  				#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  771  				#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  772  				status = "disabled";
520b792e83171e Xianwei Zhao   2024-08-30  773  			};
520b792e83171e Xianwei Zhao   2024-08-30  774  
520b792e83171e Xianwei Zhao   2024-08-30  775  			spicc1: spi@52000 {
520b792e83171e Xianwei Zhao   2024-08-30  776  				compatible = "amlogic,meson-g12a-spicc";
520b792e83171e Xianwei Zhao   2024-08-30  777  				reg = <0x0 0x52000 0x0 0x44>;
520b792e83171e Xianwei Zhao   2024-08-30  778  				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
520b792e83171e Xianwei Zhao   2024-08-30  779  				clocks = <&clkc_periphs CLKID_SYS_SPICC_1>,
520b792e83171e Xianwei Zhao   2024-08-30  780  					 <&clkc_periphs CLKID_SPICC_B>;
520b792e83171e Xianwei Zhao   2024-08-30  781  				clock-names = "core", "pclk";
520b792e83171e Xianwei Zhao   2024-08-30  782  				#address-cells = <1>;
520b792e83171e Xianwei Zhao   2024-08-30  783  				#size-cells = <0>;
520b792e83171e Xianwei Zhao   2024-08-30  784  				status = "disabled";
520b792e83171e Xianwei Zhao   2024-08-30  785  			};
520b792e83171e Xianwei Zhao   2024-08-30  786  
be90cd4bd422e8 Kelvin Zhang   2024-09-14 @787  			pwm_mn: pwm@54000 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


