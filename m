Return-Path: <linux-kernel+bounces-414471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26419D289C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C004B2C130
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E31D0159;
	Tue, 19 Nov 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="MFCGZJfh"
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72581CF5D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027637; cv=fail; b=Ecv47G/O6BcM8gTdzrWsqIMgKLFTZ7W+Nx0loGtcXoP07pZbR7M5ks+8QLQ2ZTGRx28VgFBcth4oMmWby28lJlYBBN7T39rBZf5Eq3pZ6jo8xl6EaebcSvpZGKgVHTbok5FEMnzBSybb+8LuT1D7xKszkgOQK8mDPZ+HAIFySlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027637; c=relaxed/simple;
	bh=MOkSFGviL4BKVlEs8neMUmODzjTYigkXn56VnyDMGC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RE6Inkc1GuOM+tqFSGc0Roth2HrzZVBvjgtIgAN+2ecuOvHpNhGj7mEAA2cCqR1Ss1bJSuDnE/t4Oc82CwqIxAZzEn9LNqcuW5GhatjoO8byazM1xs+g91H4z5S9nY5VolGwNxBtDZEl1gWxCBQ/2d+nc6RxRqY7vbcuZ6ewO5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=MFCGZJfh; arc=fail smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6376; q=dns/txt; s=iport;
  t=1732027634; x=1733237234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MOkSFGviL4BKVlEs8neMUmODzjTYigkXn56VnyDMGC4=;
  b=MFCGZJfhsDVckDhNFvCiWFRnfGs2z+60vHFTgI4IPy/PiKkYqFUU6dqP
   42qCAz5Fu53kXll5smX7Hh2ZfU4/Xih/eyEPDu9CHDxBqA/bkuwql57oH
   ZcvMlNMFMGIBjsBI8U4F9M9k2o561L/KcdHe4rthDA29HnOPgrUymuMiE
   k=;
X-CSE-ConnectionGUID: Zs8otspHTSyE8pj8zB2UbQ==
X-CSE-MsgGUID: ZZm4tMURR0KSII9nR5CbHg==
X-IPAS-Result: =?us-ascii?q?A0AGBAClpDxn/4r/Ja1aHgEBCxIMQCWBIwuBclIHghKFH?=
 =?us-ascii?q?YNMA4UthlGCIQOFeoxVHIssFIFqDwEBAQ0CRAQBAYUHAhaKOQImNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAQEBAxIRETcOE?=
 =?us-ascii?q?AIBCA4KAgImAgICDiEVEAIEDhkOhUQDAaUeAYFAAooreoEygQHgIBiBAi6IT?=
 =?us-ascii?q?AGBbIN9hHcnG4FJRIEVgiiBAj6EKoN0gmkEgkGCZoIpJYETh2yJdpAnCUl7H?=
 =?us-ascii?q?ANZIREBSwo1DDgrRiEsA4JHgjWBUoJGgRSDLoFeBTcKgwmBNDcCDQKCRXMfh?=
 =?us-ascii?q?2aBC4Nhg0WBGYFtgjYdQAN4PTUUGwY9oyAuPkRMITCBJW2TDINHAUmvLQqEG?=
 =?us-ascii?q?p46g2mDcY0CmUguh1uQbppSiFMzhSUCBAIEBQIPAQEGgWc8gVlwFYMjURkP2?=
 =?us-ascii?q?ECBMwIHCwEBAwmRCAEB?=
IronPort-PHdr: A9a23:2MJl7BLfM1iJdObmF9mcuVQyDhhOgF28FgcR7pxijKpBbeH6uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:Wqkf2a40Rnstvdpo4Ih4/gxRtG/GchMFZxGqfqrLsTDasY5as4F+v
 jcYC27XPvreNGL8eYwnOYvn/EkB65PUm9EyGwRvry43Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QoaztNuvrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eD5ZI/fpsGUFyz
 u01eCgPPgKp3d+8+efuIgVsrpxLwMjDJogTvDRkiDreF/tjGcmFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkYfUrsUIMpWcOOAinD5cjBct1u9rqss6G+Vxwt0uFToGICFJIPVFZQPxC50o
 Er0zWGlHjQnDubH6gGk0yOqvLLklwP0Ddd6+LqQs6QCbEeo7mgSDgAGEFi2u/+0jmagVN9Fb
 U8Z4Cwjqe417kPDczXmdwezrHjBulsXXMBdVrVjrgqM0aHTpQ2eAwDoUwJ8VTDvj+dvLRQC3
 V6SlNSvDjtq2IB5g1rHnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:az/WG6td/jnJTEcJELtdr4Mg7skCCoAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tLxGHdySWVxfJZnPrfKlrbamzDH49mpO
 hdmsdFeafN5DRB/KLHCUyDYqkdKbq8geCVbIXlvgpQpGhRAskKgXYae2Om+w9NNXV77PECZe
 OhD7981kGdkAMsH7yG7xc+Lo/+TvTw5eHbSC9DLSQKrCOJijSl4qP7FR+34jcyOgkk/Z4StU
 L+v0jc/KuMj9GXoyWw64bU1ftrseqk7uEGKN2Hi8ATJDmpoB2vfp5dV7qLuy1wiP2z6X4x+e
 O84SsIDoBW0Tf8b2u1qRzi103LyzA18ULvzleenD/KvdH5fjQnEMBM7LgpNycxqnBQ+O2U4p
 g7mV5xhKAnVC8oWx6Nv+QgYisa0XZcZ0BSytL7wUYvC7f2I4Uh3bD3tHklYqvoWhiKq7zO1I
 JVfZ3hDDE8SyLGU1nJ+mZo29CiRXI1A1OPRVUDoNWc13xMkGl+1FZw/r1Uop4szuN0d3B/3Z
 WODo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E78ef2sR42Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjste+596sLvhQ6eDC1zPdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXZ1E2gXvMqMiYEX2kPdlzOrTd2j+1f4jcLeaw9AzWMyjUIbQLQ==
X-Talos-CUID: 9a23:3bS2Qm3n9IQN4nNvzm/k4rxfKNt1dWHG1FfsGF6VWX5rGK+/E2KawfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AjiitaAyykRUARcjMDzfCxh1qpHeaqJacDRwRtKg?=
 =?us-ascii?q?8gZGnDg1RajGn0R+9YoByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2024 14:47:07 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 0E7D71800029C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:47:07 +0000 (GMT)
X-CSE-ConnectionGUID: p3UsmO50RWWKZ4DIv64wdg==
X-CSE-MsgGUID: k9rUiZjWRMeAxiBQ5R9lYw==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,166,1728950400"; 
   d="scan'208";a="40360928"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2024 14:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axpe/30hMibxXUHUVuH7K7776IKp22QHl/l0c1YyAXqDMRU35PpOLBpdjtLWqLuHAXgeQYtW9ZHY706s8QdUXnNk1qrvOmV7yCAuHC4NC7+D21XzqXG7i6Jgb0iTNp3B2WGyJs3Xm+oYyLz90ywwNHNoOLrLErI9A0TdHiiDu50uf5Itsxu9Cgmri9FSy8fHIrnt/MMdX4wnMImhzCOMXC/053gFGMit50NvILdYCTQ1TdzJvnafdK3GzQnrqtlnrJO9Bnde2EAEF1QbhtYq0JmKdi7K+XJni6p3tcNimKWHyKWVLxNpxrJrjwv07E8ot5SSfmp+AEMtVZtTCa1nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOkSFGviL4BKVlEs8neMUmODzjTYigkXn56VnyDMGC4=;
 b=UNJeFD5P/tQnvAI2NHDr0sD0V/NgtGrW/5wTxdOM4/eVSX6PHIwWFOv+tF0VFFlMuuZdk3QUXr07yL4afw7KnZuppUx2FvQ8PfuxxDWQDwmxfOnaN4dxdW6gC1CBUi1ehxlwpE+HHG5l4fWAE+0lHiGkIHHHiI6+60qhaARotK1Jwcx8Oo/qLfOKbG0OVAjsuBZUb/MXWTBQkOWKTD9/l3F1DdxoSA0Yc0VdP3bWBljvVgsByD7kv/HGUNrs6DQ55PIJ+mWouPE/66MggTeKrVT7ubjl69TLWTLAClBTvubHEBVqwJbgjIKvBECjTX+55iYWbC06lWESQlKZLYpqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 14:47:03 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 14:47:02 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index: AQHbNeKxizzLej0qw02u6pHMIY1jfA==
Date: Tue, 19 Nov 2024 14:47:02 +0000
Message-ID: <Zzyk5r22AS/Feg7z@goliath>
References: <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
 <ZzxdXa-IsfHv2IFc@smile.fi.intel.com>
In-Reply-To: <ZzxdXa-IsfHv2IFc@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: fb1f435b-b403-4ea0-7f35-08dd08a907bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGNPekpTNW1pZmxySFU4dGV5UEtVR09YYTY3WVRjUG9sT1pzZlphaWw3MDdY?=
 =?utf-8?B?YndVNTFoZzBhQ1VvT2JxSkpkTjRLMGlDaWpDSGdKRW9ad3Z2ci9nSnBVdmpJ?=
 =?utf-8?B?aW5WeDVxdlBUUDkvdmorclFBZWp3aE5wMTYrODd2YTR6VmIxQnhKVTVQVkN1?=
 =?utf-8?B?WjIvdHR2RXVjSWJENUtKTUdaSkxubStPaCtid1RsY3FWTVJrS1F1aWdwQkJt?=
 =?utf-8?B?UkgyTHhCRE1OMWR6MzcvVm4xOEJnM0NyaEtLRWQrMUpqdXdwZzJYK2ZBaWl4?=
 =?utf-8?B?cHcwL1dkRW53TkRMbS9jOFFJMkJ4U2gyQk0vVXpPMWtWS01TWGVJM0JxZ1JE?=
 =?utf-8?B?TTNnRk1jYzMxK1V4SHNjWUIwYVNVZk1hMzhGMTBLQWJSbld2Z0FINWtUUGpq?=
 =?utf-8?B?UlkvcUF5Z2t3R2Q1ZThDeGR5c0NOdVhUVkd3RVhYRmxNWGxNY0pvSTRLRWpG?=
 =?utf-8?B?bjYzWWlINGhYMXgwcExXd3Z4MzQ4UHBOemNqamorbWVFR2szVXh6Zm5yWC8r?=
 =?utf-8?B?dnhKd3lhdHBFZ1dvS1JuVXFEUTduU2ZBVDFPWTBzMGwva3p2L2ZOUDdIU0lD?=
 =?utf-8?B?VTR6RzFXNVVDQll1cHhwYlF3NTJnN2k3S2hxekdNWElaRW0xZUtwamNGcVFD?=
 =?utf-8?B?Y3RzbE0zNTh2alVaR2NidkRrNExuaW9WcnllTHl2WU5PM01HVFdweVBKOVg1?=
 =?utf-8?B?eURQNTJQdzNSQ0huekRvWm9WZGd2ZGM1eXUySGNSa0d0VDl6Zlp3T0ZVNEx6?=
 =?utf-8?B?VXhUY0xhTlhwQmNDT1ozbEd3NW9VSklOTlpqZUJGdUtIbGhDWVBaUTdFWHQr?=
 =?utf-8?B?T1FjczVvQVdmWThaNjNFcURDeXJRWjlST1hCbVluUG53NGU4MzJ6NS9lQVNx?=
 =?utf-8?B?Wi9RK2Z0eGMyWjBlSGM1Z1I0RXVaTVVaV0dUelFNaHg4aWxIZ1kyM0FzdVdw?=
 =?utf-8?B?bzdSelRqYmIxcXlObVNuODkxOEdtSXZ5L2FiYmhqdzRBS2hWTmNhU0NKRzFp?=
 =?utf-8?B?eWE1N1pCbEMxa3pZV21RM1F1RVdYSnYyRm1helo4L2JrY1A4cElESTlDdFBN?=
 =?utf-8?B?dVZKejZpRnNPdXQyT2FjQkJaVGdTdThzS1dSTUVuekZuemVuQVY5TUdCbVJI?=
 =?utf-8?B?MTRZRlVuNHMzZzkyeWdFbE1RUUozS1NaL1F0eU1mZDkvM0N5ME5tSytzR08x?=
 =?utf-8?B?VTlWbVdmTDFzNTJFWTQ4YVBHUW5CeWFYOEFyaDVnWTVhR0xhQklpWFhhTmk0?=
 =?utf-8?B?RjlRRG9EUmhkVDBpLzZYZWdxTHpCNUhuYlppWGNoM05zT0U1Vk9PbmNnLzVw?=
 =?utf-8?B?SDR5czM5ZWJiZE1JaEVJRWZBWnc1dXNTc2xQREhtbVR6bGVWRmhiWUhLU0Fa?=
 =?utf-8?B?b29wellkZEwwT09hZ29lQUkzQjdJRlpscHJzMzhQaE9ybExMazZBRTBRanhq?=
 =?utf-8?B?T20xbmVhV2E5L3dDQVYwTVYrOFZ5aCtKVEJWNjRJd3pxMTRlWlVENGZlaG9X?=
 =?utf-8?B?Zlk0T1psZTBFVHVNTEJLMVZxY2N0Qnhpd3Y4ZG9PQlZIMXNRc3BHMEkvMTMx?=
 =?utf-8?B?Y3J2eWhYb2szdm9mQ3E2VGQ2RjZidXQ1c201bkVpZFFUNnYwSEduTm9PR2lI?=
 =?utf-8?B?ZkljNkEvUzF1MnM2RUpKRVZER1l6V3A2QTduaDhBcVM4U01sTVI2Z2Y1R0da?=
 =?utf-8?B?TUNZVE0yald6Z05hNit0R3JhVmFua1A1OE0xd0ZvZTg4MWxDdFlSMm5HTy9m?=
 =?utf-8?B?TWFaK1NxdUR2QkZkMlJ3VTBEWEc0NUQ2NGVJaEI5dzJWb0RWdHgyRm1uYnhG?=
 =?utf-8?Q?+wbd4xDJIXSvYR218XnWzQZqPVQnCBweJNPS4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVdKQ1pINW9nN2tJcjBWcFBNakJ3dG1RVVJBdjVoaHdNOEtTZS9lYjFxeExO?=
 =?utf-8?B?VFNnZFdiR2lENHgrTnVqY0JFNGx6MWJ4ZlZpM0ZVWlNGdUdXTVdKcUhkN09a?=
 =?utf-8?B?clVvbkphM1NEWHozQ3BheWdHY0h5YXNJV3JvLzFnREtuVzhUNlVqdzVHVlkr?=
 =?utf-8?B?Mi9XdG8xblp1RGxmWlp1M2tPOGk0RTlrSkNreXdMMGR4cmZ3dzJqTVFQSmt0?=
 =?utf-8?B?NEFsTC8zQ3ZKL1NsaGVLbWxNTzdpVnRxQ1NHcnlsdlhmMmxxTU9QbjRZbytO?=
 =?utf-8?B?ZWFidG9RSm15d25ERGc3eVN0enY1aWJMTWxZZ2lydkRLZUtwYjNHZVk3RVlX?=
 =?utf-8?B?SkIxVWJ5S1lpYTduL1hkNWlQUTNRUERyNjBadjUrMkR0by81enFBV25CaHp1?=
 =?utf-8?B?NVp5ak50NFFJclA5dXhDZndDcjJiem9yd2pna0JiQTMrdFR4dmd0Qm1JZ1c2?=
 =?utf-8?B?OVk5RmswUFZkeXpBMFdicXlHSjhPcncrYVA0UmlKTisvWVFUaWxsd0xjdElF?=
 =?utf-8?B?NDEvS0lTWlA0N1hnSlkrOGY4MWtpUFFLZWJVdG1DeHBvRHAxRFFWbndkY2Jk?=
 =?utf-8?B?UTQybG11MkpadERyQ3pjKytjeUlJeWRyZG9xSXIvN0xZYTIyc2s4TmZ1ak5j?=
 =?utf-8?B?MXRLZTdXNTJXUDZ3cHl1TW9JVFh0NEUxZ216U0ljVEprSGRZaGh2OGx1UTc5?=
 =?utf-8?B?cXozUWVyaVZ1VGg5dnRJdTdnakw2SjF4T1VmU2VhbHBUQzdJRHRrUnVsak1v?=
 =?utf-8?B?Sy9rZGc4M1o2Y29CN29QUmFLWXBmQXpTcWRjeTJlUUJoem4rT2tyUGNOMkh3?=
 =?utf-8?B?SHMyMTJja3BoNFBmeit6V1NKaFF6ZFZ2ZWVralJiUE4xeDc4KzhxNGhpNEhw?=
 =?utf-8?B?MFdaVVNwWEE4b0hTRkdKN1hOdG9kSzY3MWRSc3JpS1orZklQSU5YMUJlUmRh?=
 =?utf-8?B?aVVvelRBSkxON0F2YWJCRU1ncVVnZXgvWnIyeGdvNnlHeGd0ZnozQVVabThs?=
 =?utf-8?B?Ri9UMnRUZFJQVm5ldVlnZi9XWWVrSHVtcmh6K3VJNkRPZ0o5OERQRURaWFpY?=
 =?utf-8?B?dUhqVmtZZk1XK1ZTcVF0QXdHMmFNa3F6dUFTVmUycFVnZmswUE5Ya3hRNnA2?=
 =?utf-8?B?NGZKMnBDT05XTWVjRHJqZ2Zqd3BXSzAvVnZiLzFLc0YwYUYvY0VQMHBhODUz?=
 =?utf-8?B?MVNsdEZ5OFdtYnF5RGswejM0R2wyQTdaTzhEdGFLV1dpOWs5K0t2RzdrRm1z?=
 =?utf-8?B?MUV1bDBtTjBBWld1eDFUU0JENWxDZUhkTEdCdzQrVnp0UFU2QlY0dVcvV3hQ?=
 =?utf-8?B?TUE3Z2tnYklpTjhzU254RkJrUDVhY29rbkFYNDc3QW5sUkg3OWJrZDFnZmpl?=
 =?utf-8?B?TTBEUGdzM01OdU84cERQMlNRbnk4cmM4eWp4enB5R3BQQUFTN0orbUtpVnIy?=
 =?utf-8?B?TTZ3RWtHb3hveG5jc1BORjNzaS8va0tFbVJuajlTUS9BS2RzMjM4cUlPOGc0?=
 =?utf-8?B?aXhxYktLc3hNUUJMZDduTlNYRDRLT0hvNU5kdHI5dU9Kc2dFLzI5cVphYmNk?=
 =?utf-8?B?aGt3SlZQL0w1TVFaOEpZRGlWMGhORFJOYS9oR2hoZXNYSkJCY1krcWplc0JR?=
 =?utf-8?B?blY5OXRyUUxHK05XZUlZNC92T1pDTHBRSXhZQ3NpMXRmYmJyaW5NWUhlOFVt?=
 =?utf-8?B?UHJuczhWQyt0NnpKNXI5SThkNzl1bGt1aW0xdEZEWnpaK09YY0ZWNHMrVWxz?=
 =?utf-8?B?YitKdm1TNEcxTndIRDJQYkt3MnJjazRqdmVMKzZ1THA4ZXo5K1RncE9vcVlF?=
 =?utf-8?B?QzljOVVTMkRLcHVOSUg3QjZubEUrYmFOMEd1cnhrVDBPWTNMcytpMnpNTlY1?=
 =?utf-8?B?Y0tzbTNXdmh5V0d0SCsyNSthYkYydWVnZlZvUmRidU8yZEhHbW9vb2x4bGZh?=
 =?utf-8?B?aENHc3grOVZabURUb3MweTVUS2pzVndJVW9ZV0I2TzdTcWhpb00zOGlEZzhl?=
 =?utf-8?B?SmxuN1dwdHBOaldhS0gzbXpOVkxSRmRwcE56TFNWTERsWHJGOGpuckI3WFVD?=
 =?utf-8?B?Nm1vZFY0V0VFWGU2aFZCelozSElzb00yUWV0WUdabG1DVkV2U2d5T09Kdm1j?=
 =?utf-8?Q?UdHcbNklse9+vdACxuRvVJQoL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3FCB2ABA3224045BE072FC66C47FF87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1f435b-b403-4ea0-7f35-08dd08a907bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 14:47:02.8525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS//scr08ooCtUsP3lxK1ZaLY8jWPEfiwAjHqkuSRwrCWtOTMGFg3l7KqNN/TtNOd7UuVEOv2mpg2M4FTbYkkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

T24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMTE6NDE6NDlBTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAwNToxNToxN1BNICswMDAwLCBEYW5p
ZWwgV2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQg
MDU6MDA6NTJQTSArMDEwMCwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiA+IE9uIDE4LU5vdi0y
NCA0OjU1IFBNLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgTm92IDE4
LCAyMDI0IGF0IDAyOjM1OjQ0UE0gKzAwMDAsIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90
ZToNCj4gPiA+ID4+IE9uIE1vbiwgTm92IDE4LCAyMDI0IGF0IDAzOjQ5OjMyUE0gKzAyMDAsIEFu
ZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiA+ID4+PiBPbiBNb24sIE5vdiAxOCwgMjAyNCBhdCAw
MTozMjo1NVBNICswMDAwLCBEYW5pZWwgV2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+ID4gPiA+
Pj4+IE9uIE1vbiwgTm92IDE4LCAyMDI0IGF0IDAzOjI0OjIwUE0gKzAyMDAsIEFuZHkgU2hldmNo
ZW5rbyB3cm90ZToNCj4gPiA+ID4+Pj4+IE9uIE1vbiwgTm92IDE4LCAyMDI0IGF0IDEyOjQwOjE2
UE0gKzAwMDAsIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToNCj4gDQo+IC4uLg0KPiAN
Cj4gPiA+ID4+Pj4+IEFyZSB5b3UgcmVmZXJyaW5nIHRvIExQQyBHUElPPw0KPiA+ID4gPj4+PiAg
DQo+ID4gPiA+Pj4+ICBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJlIHdlbGwgZW5vdWdoIHRvIHNh
eSBmb3IgY2VydGFpbi4gSXQncyB3aGF0ZXZlciBkZXZpY2UgODA4NjoxOWRkIGlzLg0KPiA+ID4g
Pj4+DQo+ID4gPiA+Pj4gVGhpcyBpcyBkZXZpY2Ugd2hpY2ggcmVwcmVzZW50cyBwMnNiLiBJdCdz
IG5vdCBhIEdQSU8gZGV2aWNlIHlvdSBhcmUgdGFsa2luZw0KPiA+ID4gPj4+IGFib3V0IGZvciBz
dXJlLiBZb3UgY2FuIHNlbmQgcHJpdmF0ZWx5IG1vcmUgZGV0YWlsZWQgaW5mbyBpbiBjYXNlIHRo
aXMgaXMgc2hvdWxkbid0DQo+ID4gPiA+Pj4gYmUgb24gcHVibGljIHRvIG1lIHRvIHVuZGVyc3Rh
bmQgd2hhdCB3b3VsZCBiZSB0aGUgYmVzdCBhcHByb2FjaCB0byBmaXggeW91ciBpc3N1ZS4NCj4g
PiA+ID4+DQo+ID4gPiA+PiBIZXJlJ3MgYSBjb21tZW50LA0KPiA+ID4gPj4NCj4gPiA+ID4+IC8q
IElOVEVMIERlbnZlcnRvbiBHUElPIHJlZ2lzdGVycyBhcmUgYWNjZXNzaWJsZSB1c2luZyBTQlJF
R19CQVIoYmFyIDApIGFzIGJhc2UgKi8NCj4gPiA+ID4+DQo+ID4gPiA+PiBXZSBoYXZlIGdwaW8g
d2lyZWQgdG8gYW4gRlBHQSBhbmQgSSBiZWxpZXZlIHRoZSBncGlvIGxpbmUgaXMgdXNlZCB0byBy
ZXNldCB0aGUNCj4gPiA+ID4+IGZwZ2EuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gU28gdGhlIHBjaSBy
ZXNvdXJjZXMgYXR0YWNoZWQgdG8gODA4NjoxOWRkIGNhbiBiZSB1c2VkIHRvIGFjY2VzcyBncGlv
IG9mIHNvbWUNCj4gPiA+ID4+IHR5cGUuIA0KPiA+ID4gPj4NCj4gPiA+ID4+IEknbSBub3QgYSBw
Y2kgZXhwZXJ0IGJ1dCBvbiB0aGUgMTliYiBkZXZpY2UgYmFyIDAgd2UgdXNlIHRoZSBiZWxvdyBv
ZmZzZXQgdG8gbWFuaXB1bGF0ZQ0KPiA+ID4gPj4gdGhlIGdwaW8sDQo+ID4gPiA+Pg0KPiA+ID4g
Pj4gI2RlZmluZSBJTlRFTF9HUElPX1JFR19SRVNFVF9PRkZTRVQgICAgICAgICAgMHhDNTA1NzgN
Cj4gPiA+ID4+DQo+ID4gPiA+PiBUaGUgY29tbWVudHMgc3VnZ2VzdCB0aGlzIGlzIGdwaW8gNi4g
SSB3b3VsZCBzZWVtcyB5b3VyIHJlYWN0aW9uIHdvdWxkIGJlIHRoYXQNCj4gPiA+ID4+IHRoZXJl
IGlzIG5vIGdwaW8gb24gdGhlIDE5ZGQgZGV2aWNlLiBNYXliZSBvdXIgZHJpdmVyIGlzIGFjY2Vz
cyBncGlvIHRocnUgcDJzYg0KPiA+ID4gPj4gb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gPiA+
ID4+DQo+ID4gPiA+PiBEb2VzIHRoZSBvZmZzZXQgYWJvdmUgbWFrZSBzZW5zZSB0byB5b3UgaW4g
dGhlIGNvbnRleHQgb2YgdGhlIHAyc2IgPw0KPiA+ID4gPiANCj4gPiA+ID4gWWVzLCBldmVyeXRo
aW5nIG1ha2VzIHNlbnNlLiBQbGVhc2UsIGVuYWJsZSBscGNfaWNoIGRyaXZlciBhbmQgZm9yZ2V0
IGFib3V0DQo+ID4gPiA+IHRhbGtpbmcgdG8gdGhlIHAyc2IgbWVtb3J5IG1hcHBlZCBJTy4NCj4g
PiA+ID4gDQo+ID4gPiA+IC8qIE9mZnNldCBkYXRhIGZvciBEZW52ZXJ0b24gR1BJTyBjb250cm9s
bGVycyAqLw0KPiA+ID4gPiBzdGF0aWMgY29uc3QgcmVzb3VyY2Vfc2l6ZV90IGRudl9ncGlvX29m
ZnNldHNbRE5WX0dQSU9fTlJfUkVTT1VSQ0VTXSA9IHsNCj4gPiA+ID4gCVtETlZfR1BJT19OT1JU
SF0gPSAweGMyMDAwMCwNCj4gPiA+ID4gCVtETlZfR1BJT19TT1VUSF0gPSAweGM1MDAwMCwNCj4g
PiA+ID4gfTsNCj4gPiA+ID4gDQo+ID4gPiA+IFNvLCB5b3UgYXJlIHVzaW5nIGEgcGluIGZyb20g
dGhlIENvbW11bml0eSAiU291dGgiIG9mIHRoZSBvbi1kaWUgRGVudmVydG9uIEdQSU8uDQo+ID4g
PiA+IA0KPiA+ID4gPiBJbiBFRFMgdGhpcyBjYWxsZWQgR1BJT182LCB3aGlsZSBpbiB0aGUgZHJp
dmVyIGl0J3MgcGluIDg4LCBpLmUuIFNNQjNfSUUwX0RBVEEuDQo+ID4gPiA+IA0KPiA+ID4gPiBZ
b3Ugd2lsbCBuZWVkIHRvDQo+ID4gPiA+IC0gZW5hYmxlIGxwY19pY2ggZHJpdmVyIChDT05GSUdf
TFBDX0lDSCkNCj4gPiA+ID4gLSBlbmFibGUgSW50ZWwgRGVudmVydG9uIHBpbiBjb250cm9sIGRy
aXZlciAoQ09ORklHX1BJTkNUUkxfREVOVkVSVE9OKQ0KPiA+ID4gPiAtIHJlcGxhY2UgeW91ciBj
dXN0b20gYXBwcm9hY2ggdG86DQo+ID4gPiA+ICAgLSBHUElPIGxvb2t1cCB0YWJsZQ0KPiA+ID4g
PiAgIC0gcHJvcGVyIEdQSU8gQVBJcywgYXMgZ3Bpb2RfZ2V0KCkgb3IgYWxpa2UNCj4gPiA+ID4g
DQo+ID4gPiA+IFNlZSBob3cgaXQgd2FzIGRvbmUgaW4gdGhlIGN1cnJlbnQga2VybmVsIGNvZGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiA4MjQxYjU1ZjFkZWQgKCJkcm0vaTkxNS9kc2k6IFJlcGxhY2Ug
cG9raW5nIG9mIFZMViBHUElPcyBiZWhpbmQgdGhlIGRyaXZlcidzIGJhY2siKQ0KPiA+ID4gPiBh
NmM4MGJlYzNjOTMgKCJsZWRzOiBzaW1hdGljLWlwYy1sZWRzLWdwaW86IEFkZCBHUElPIHZlcnNp
b24gb2YgU2llbWVucyBkcml2ZXIiKQ0KPiA+ID4gPiANCj4gPiA+ID4gSGFucywgdGhlcmUgd2ls
bCBiZSBubyBuZWVkIHRvIGZpeCBhbnl0aGluZyBpZiB0aGV5IGltcGxlbWVudCBjb3JyZWN0IGFj
Y2Vzcw0KPiA+ID4gPiB0byB0aGUgR1BJTywgaS5lLiB2aWEgZHJpdmVyIGFuZCBib2FyZCBjb2Rl
IHdpdGggR1BJTyBsb29rdXAgdGFibGVzLg0KPiA+ID4gDQo+ID4gPiBBZ3JlZWQsIHN0aWxsIEkn
bSBub3Qgc3VyZSBob3cgSSBmZWVsIGFib3V0IHVzIGhpZGluZyB0aGUgcHJldmlvdXNseSB1bmhp
ZGRlbiBQMlNCLg0KPiA+ID4gDQo+ID4gPiBPVE9IIEkgZ3Vlc3MgaXQgbWF5IGhhdmUgb25seSBi
ZWVuIHVuaGlkZGVuIGluIHRoZSBCSU9TIHRvIG1ha2UgdGhlIGhhY2sgdGhleQ0KPiA+ID4gYXJl
IHVzaW5nIHBvc3NpYmxlIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPiANCj4gPiBGcm9tIGEgZmxl
eGliaWxpdHkgUE9WIEkgd291bGQgc3VnZ2VzdCBpZiB5b3UgY2FuIG5vdCBoaWRlIGl0IGlmIGl0
J3Mgbm90IGFscmVhZHkNCj4gPiBoaWRkZW4gYnkgdGhlIEJJT1MgdGhhdCB3b3VsZCBiZSBiZXR0
ZXIgc2luY2Ugc29tZSBjb21wYW55IG1heSBoYXZlIGEgZ29vZA0KPiA+IHJlYXNvbiB0byBtYWtl
IGEgY3VzdG9tIGRyaXZlciBvciB0byBleHBvcnQgdGhlIHBjaSBkZXZpY2UgdG8gdXNlcnNwYWNl
IHRocnUNCj4gPiBVSU8uDQo+IA0KPiBUaGUgcHJldmlvdXMgZW1haWxzIHVzZWQgd3JvbmcgdGVy
bWlub2xvZ3ksIHRoZSBoaWRkZW4gZGV2aWNlIGlzIGxlZnQgaGlkZGVuLCBhbmQNCj4gYWxsIHRo
ZSBvcHBvc2l0ZTogdW5oaWRkZW4gaXMgbm90IHRvdWNoZWQgaW4gdGhpcyBzZW5zZS4NCj4gDQo+
IFRoZSBwcm9ibGVtIHRoZXJlIHRoYXQgZm9yIHRoZSBpbml0aWFsbHkgdW5oaWRkZW4gZGV2aWNl
cyB3ZSBjYWxsIHBjaV9zdG9wXy4uLg0KPiB3aGljaCBzZWVtcyBpbmNvcnJlY3QgYW5kIG5lZWRz
IHRvIGJlIGZpeGVkLCBpbmRlZWQuDQo+IA0KPiA+IFRoZSBjdXJyZW50IHNpdHVhdGlvbiBpcyB5
b3UgY2FuJ3QgbWFrZSBhIGN1c3RvbSBkcml2ZXIgaWYgcDJzYiBpcyBlbmFibGUNCj4gPiB3aXRo
IHRoaXMgYWRkaXRpb25hbCBwYXRjaCBldmVuIGlmIHlvdSB1bmhpZGUgdGhlIGRldmljZSBpbnNp
ZGUgdGhlIEJJT1MuDQo+IA0KPiBZZWFoLCBidXQgSSBkbyBub3QgY29uc2lkZXIgdGhhdCBpcyBh
bnlob3cgcmVsYXRlZCB0byB1cHN0cmVhbS4NCj4gDQoNCk5vdCB0cnVlLiBIYXZlIHlvdSB1c2Vk
IHRoZSBVSU8gc3lzdGVtID8gWW91IGNhbiBtYWtlIGEgY3VzdG9tIHVzZXJzcGFjZSBkcml2ZXIN
CmZvciBhIHBjaSBkZXZpY2Ugd2l0aCB6ZXJvIGtlcm5lbCBjaGFuZ2VzLiBXZSBoYXZlIGEgY3Vz
dG9tIExLTSAsIGJ1dCB3ZSBjb3VsZA0KZWFzaWx5IGhhdmUgZG9uZSBpdCB3aXRoIFVJTy4gV2l0
aCB0aGUgUENJIGRldmljZSBjb21wbGV0ZWx5IGdvbmUsIHRoZXJlIGlzIG5vDQp3YXkgdG8gdXNl
IFVJTyB0byBtYWtlIGEgdXNlcnNwYWNlIGRyaXZlci4NCg0KRGFuaWVs

