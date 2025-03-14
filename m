Return-Path: <linux-kernel+bounces-561614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA940A6140A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6EB7A6A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219A201024;
	Fri, 14 Mar 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lyr9XH2s"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C31990BA;
	Fri, 14 Mar 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963763; cv=fail; b=SVdQpNzv0ZCzxGK5KP1jUvXB+p8wIrHjTrlYxeeDgWWtObTtU0S/x9r9myNv/H9hcBEaczLMct2QkYi9qxL0vQahoBkZBuKYlwn1F0GRYqeWmVV6JuyvCPhkvdKH9gMYpceMj8/h/4r+hFYrv2FuB5jd6Xb5/flIv4OsfyyBrdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963763; c=relaxed/simple;
	bh=n+xyJ7EdUXoG80FOOh9qwNgXq9sdQ/i6tKCkMYI6Q44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VsF/yvSv+0IUfvJyJWJw908QW8r7CoxLbbTvQ8E6cXJz7oMBJIIxw21G1y40iVNGBA4LgWYL8y8+9pRQFwPEf0F3iTKa3SSlXL7ysMjJaMXu9D3eZsKMDvH0bloWfvJ3VXGmANrRLDSsySS9hPUyYzVuI1No5Gfv2mRhc6Owf5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lyr9XH2s; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuXujz9Wre/YKI+9kWefGlx7SPkt3WP85ieAK2uKsH6DOCB+62jIC2pZMB55g1gxFvuy1Vs486OhmBso97eC3ZDdXDCbdGNlcc5EciDXqZDy2K0RiVav+jSQ+BwVj15IzmMTRx/c5WGmIcDcHVBS7rZqFzIKE+HTSasCi2dTx5Xo8RSV4wUFasah5PpCJ9lOSfd3A4s9Db6ltJ5B4D1/6KWS8vDHI+L+hZkjoRb08R2iwJPZdIBVDixGv1QSKrZGOp4Gizd8UwEXD22ZMSvI1ojB8G1ixvZXH4I78QLLdarAsaUUtvagr2EEnBWVk7TZyShYTynL1kO6cWLoEEtjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY1K5ZdIo8Jz7/uQ8hdfHvDcMTvYxjngMf20onq2UfE=;
 b=lHQZIcMBE5bl19wHjgTJweYXo+2n/+srzE/vsAv6/TzNqUfFiYCZ3xXrV8R0urBHGGwtc+OKXLrg7nhmDvG4XHgfSDloaBPnBN9/TtQLtqq1acScKK66ppM0nGvl0xahzU8uc1YYCPYJwol6ZPMommt9EgXc5l5yy3UJgTCmtEECDpECNliQNnN+vvwPY48HzABEDkjTV1U8KZqQiX5nzp0pv1CyIWvmlX8+71uOIlUWMwU1xQC3fo3wIPgEaCgWVluDzvdCUdYBDwslk91hDL7EEbpDRlcTWm2DAOpHQYVfXo8lEfJWOh/jzYyPgUjKC43GoXLt/o0grEUIyqgJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY1K5ZdIo8Jz7/uQ8hdfHvDcMTvYxjngMf20onq2UfE=;
 b=Lyr9XH2sv6srniwzokEb7oWkrMxkdIYuCOw000C1eI7Bx22D1jZqWNMGc5NL2ErOvd9AB30v/uyAtRAGuHjn9NckuPw/6Cde4NBg5S+qTJtAUj8yFGnmOraC2iFdohLv11wTW5KENplsdZMnAZKWb80J+yuNsCT/bz99ZYFcSlg=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:49:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.028; Fri, 14 Mar 2025
 14:49:19 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: Reinette Chatre <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Das1, Sandipan"
	<Sandipan.Das@amd.com>, "kai.huang@intel.com" <kai.huang@intel.com>,
	"xiaoyao.li@intel.com" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "xin3.li@intel.com" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maciej.wieczor-retman@intel.com" <maciej.wieczor-retman@intel.com>,
	"eranian@google.com" <eranian@google.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Topic: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Index:
 AQHbbQsnBoZFKQzDmEeBYgHs3dkXM7NEEeSAgABhEoCAAS7BgIAA1twAgADKhwCAAA0qgIAEIo4AgAIN84CAASfhAIAAbHeAgAFfLYCAAD47gIABOAOAgACfaQCABeyoAIAASJ4AgAEK/gCACD1aAIABZ8UAgABVHQCAANdhAIAAlToAgAgSBACAAAl/gIAAJ6QAgAAjbICAARiKAIABNsCAgAAPjoCAABPDgIAAEPWAgAFvLACAAERXAIAABnGA///OVYA=
Date: Fri, 14 Mar 2025 14:49:19 +0000
Message-ID: <efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com>
References: <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <Z9NB0wd8ZewLjNAd@agluck-desk3>
In-Reply-To: <Z9NB0wd8ZewLjNAd@agluck-desk3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MW3PR12MB4553.namprd12.prod.outlook.com
 (15.20.8534.017)
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T14:49:18.406Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CYXPR12MB9318:EE_
x-ms-office365-filtering-correlation-id: 3b35a0f8-e02a-4bb7-8b1a-08dd6307667f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gW71bEaZUuBlVJQsn2ofMhq6yKzbA7meJIXqut+xz2U5vCIeeO+gqOdy72?=
 =?iso-8859-1?Q?Zf93A4GfMHo+sMJAqRFk9CsLcQ9arX+sm4v5ztv8Zw81oJj58yYicZH6BU?=
 =?iso-8859-1?Q?ZNGHh6PS6gFIKJ3fULlaRPxKuAncgTlqGllbWPMMMzTRE3Fcgi13iLp6P5?=
 =?iso-8859-1?Q?bbK17o+2FD7UXTH17FZs+hYVG/Nb+L8+o0o3uOlrgXRQtYNj/mFUjLvaxj?=
 =?iso-8859-1?Q?pu3Hh9xC+prhjvNQZiz1fvJxvD+Va7RiLvGffFAUnNJLQby5h5Z0i1gYc3?=
 =?iso-8859-1?Q?q/b6N0i7Hyuv7MyEyOkFjuTWkdDFlyWSDRP3nCbEmKLXHPgJFQ8aQDsiZ3?=
 =?iso-8859-1?Q?/t5XfiyuIEoWwhvjfaR3wHEoql1A2FEwVneBNtyZy11E/CXAW65FSz27yo?=
 =?iso-8859-1?Q?CyXv3sCfnNOXeZ3O24/+hfYfRBsYJl/rTZWyBc8VnXjWj4ATr3uHL+j5BL?=
 =?iso-8859-1?Q?D0mt1wW8czakr9aiRjTd7Qyham5UslQ5kkizELmEignxRHVBmyO+yNE1Xn?=
 =?iso-8859-1?Q?8HYQpJWswdfgCctsZAxHXF+BxFxNwk5YgIHogMQNY5Ds9X7KuL66UnPxjm?=
 =?iso-8859-1?Q?0Zu4mnCPnf6kmWA35n30BSvGRcgdJmSwguXkHtEm6bLIgQL3wkLg8tfWuK?=
 =?iso-8859-1?Q?wsWAgGietpfYHuN2fTAmky9JLiIXTCFJIOXIhnffWdEb9DRJpfiNiBLLKK?=
 =?iso-8859-1?Q?8xVXpAZfwZjR1lkcren02CtOOFlIWcLtSqIG1VjQ9kVnedVib4DFjgo0FV?=
 =?iso-8859-1?Q?r45sUiDJRuo39KfzyiEY7hsESNu/JarJcGO7HWdFK2ZywI0efOFVeKuF4F?=
 =?iso-8859-1?Q?zYQI8bND+HptRcYYae5Bqbg5aqqV7r/nKyav15cG5/TlyPAmOy7ItgXi3q?=
 =?iso-8859-1?Q?53Dc2p07Tfb2cnM82Eo52pVFRhrI0zU9kfE68OQgLYknT+W9BVsrRwM5pz?=
 =?iso-8859-1?Q?KEQ0Qq1Y5EWNBCIlytquX75fnh0XGhTcm3dB5kizMP+leCmjC1KmXErJ+o?=
 =?iso-8859-1?Q?1KHnScYffxjCoPXgg25xgzZJ6t7jDSHBJMhUzKkHCK+F5omGO4W+G0kUOX?=
 =?iso-8859-1?Q?KXU5w941+0ekOdB+umkhNQ5VLfFC8dSeb2fq+Oiay9D1QW6S6lHz2+8Mnq?=
 =?iso-8859-1?Q?DAYrq2RNg9QWfT5TIBsGnRR+nD+WhB5mBp1vFDmHXEBzRJD1qQWUzZAxUi?=
 =?iso-8859-1?Q?AW3lyG/bPN0n0Gy3Bhy0lcsQa8EbdkpN9pyA7Ade/GMMZhMnMEUqTRqwLV?=
 =?iso-8859-1?Q?mzfPRfD5OjuT9uM5db865NmzyLERAwhj0hJI4U1xFVtfKtEds+O0O5rxN9?=
 =?iso-8859-1?Q?nrB9vUxZcxHvVax1ktlFuTR/iZ5231qiKvA4tao7sq8WoaGEoaGzL+AZs+?=
 =?iso-8859-1?Q?mO2unvqDzYqfLqu44YvF/hgbZX8eIUG4M3R4cHLyA/rBQxOve8uibYQb+R?=
 =?iso-8859-1?Q?CQirK3qvzApqwIEE+UOdyq4pOn8kos4R+gXTE1OnxFVJexxbe+Z2NFmiKc?=
 =?iso-8859-1?Q?Z9qptirRsJmw6/j1yhIZA/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NX41htXWhe3GeOAxU/DGhDTAXS3WSHatq/a2UCknDE+OteJFGztgKRkiOc?=
 =?iso-8859-1?Q?0OuqxYclrv5CBC/W6PAtjWB73YrrJCZzH/+bU8eatwbuFvh9Fj12ftpUj1?=
 =?iso-8859-1?Q?Tm/MsM3LGhbSEwQMyilGyoMFUAi7C2j7RGlalSHXBD/cnb0yO671EGEYB0?=
 =?iso-8859-1?Q?1jkYgWmCrx40Hf3zsbhAqmnptF2ZIAbM64SansOG7Y02yaEAS+6hDbDZ6K?=
 =?iso-8859-1?Q?zFWKyhZSQnMzwTcJrExWaoGXQXrqr7dK6A1cfA6i5z14tf5blmE+Eis/Ya?=
 =?iso-8859-1?Q?u7bJNUlIeyf1OgZAc4w9Gzm+W6zJ06nr85VaKjVr+RSbklk6uvZbxgB6sl?=
 =?iso-8859-1?Q?n8RfEFI8haSS89EggktvOqFkIVgOrwFyn0BBFvqGnqRuvmJCJo2AwL5pgx?=
 =?iso-8859-1?Q?yfsp9E5RhBjAZcquvm2azDDmj8hVd7k8HD2MR8j3TPPCQ0hAduglP9Amcw?=
 =?iso-8859-1?Q?0SghzmTWjvDjS5VZqk1e1LuQv5Qs9FhmuBhVBF8ebP5ygoZ8xl0mASHefF?=
 =?iso-8859-1?Q?M6jvNUtnNK22Ju9cPxmF8ZSy4ga7m9WAixDe3SGYDtUydIX1mOB9C9CGxU?=
 =?iso-8859-1?Q?j+IUz00oHh23sZCX0Ls69IVsLfed48uP9gbPIy/N2Gl6pc91kFY0GokVgG?=
 =?iso-8859-1?Q?+sve4gdwiKmyS29tIpsfXhLllvg9zdheqIfdR9NubcbZAO0lYbzdrgGMPL?=
 =?iso-8859-1?Q?q7qXVXXE5Fw11LkF2Hl8mqr4oloQvsCwsEnBzYOCNN36OJAmUZUSHZER5d?=
 =?iso-8859-1?Q?JgnThz1dEu5HXbCbxulSkthDBnFdULPW+Gwgxqd4rb4Nc3JzawVpELpsmZ?=
 =?iso-8859-1?Q?Og3gW/rNdqjTJScdTFpM1W1JtZk+mrIfxOCGAkCkCFEu8tFCG1IvfAFsQT?=
 =?iso-8859-1?Q?dxJhA/80VoqvV7h6/OgTVeQlPNSDLdpVz8hftnLCZ6OVGYDIopQxPsXhUL?=
 =?iso-8859-1?Q?e4YbjjPlBYm36KCUGH8zf7b0kc4zLHX0thrsaJD1sOP9W/+o3KeBar+M1V?=
 =?iso-8859-1?Q?PsmTnG/g3etvO6/T9osTAWfVqO8BVGuJ1bzs/uKLxe3x6CEKkS1HXrrSRu?=
 =?iso-8859-1?Q?OeeX3zK2NMi6ju8Q5Aq5AjzOuAcbN2yRMzT5WDHt0UO8rmdZhjGEdpiVyn?=
 =?iso-8859-1?Q?EYA3KbQf9XW25C0X+/gDNw/pbb+ox/sfINix3KQNjdDop4vRspLVqIxjeP?=
 =?iso-8859-1?Q?aH35WGzfZJA3pmLMMer4WuOaIhcLF5WxXsgZizAixrXvo5tab4j8IKKrK3?=
 =?iso-8859-1?Q?a2Ljx4iGgkvyhOhHbLNAKmjZP1xgSEIskMexIfB+CMruZEPhAQ0t7MVjth?=
 =?iso-8859-1?Q?08Rt+5Zpg0uTGiuJYed729IO2FqKStmwUyKSky/oOFzCjRikxA59l3+iOA?=
 =?iso-8859-1?Q?Nm83okyoF1WnUYdjiOXHhnTg9PVg7DbpyxoaUnsLKqcmltUwkEdce4cxlf?=
 =?iso-8859-1?Q?PSFqORZX11Xkkw+D9pLSyj9deb65kaAa9Uh5tYPycG2kMCGGIrZl+aichN?=
 =?iso-8859-1?Q?fV/8KgOEhwBq8XgET699cvBatH7A3IQPKcRXZ1OpwaUdJT7lx7KSDoJpzu?=
 =?iso-8859-1?Q?74e8YoJTyGf5XaK11tQ8ysoIpd55ct1FQx2vEIONkIc7mu97ywwUf5oOl8?=
 =?iso-8859-1?Q?cIklo+5jNza9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F735C8959667C5499422172F4A2DC194@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b35a0f8-e02a-4bb7-8b1a-08dd6307667f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:49:19.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y03DhfpTP3TbdFaxAmoWtBTmHTkltr05ITYf+RYDdnPs5ANVP5Vlm89z22DSi6Yy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Tony,

On 3/13/2025 3:36 PM, Luck, Tony wrote:
> On Thu, Mar 13, 2025 at 03:13:32PM -0500, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 3/13/25 11:08, Reinette Chatre wrote:
>>> Hi Babu,
>>>

>>>> #echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
>>>>
>>>> Which would result in the creation of test/mon_data/mon_L3_*/mbm_read_=
only
>>>>
>>>> So, there is not breakage of backword compatibility.
>>>
>>> The way I understand it I am seeing many incompatibilities. Perhaps I a=
m missing
>>> something. Could you please provide detailed steps of how first phase a=
nd
>>> second phase would look?
>>
>> No. You didn't miss anything. I misspoke on few steps.
>>
>> Here are the steps. Just copying steps from Peters proposal.
>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=3DkVLBzhfNo0SFqt4kQGwG=
SGVUqvr2Dg@mail.gmail.com/
>>
>>
>> 1. Mount the resctrl
>>     mount -t resctrl resctrl /sys/fs/resctrl
>>
>> 2. When ABMC is supported two default configurations will be created.
>>
>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>>    These files will be populated with default total and local events
>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>      VictimBW
>>      RmtSlowFill
>>      RmtNTWr
>>      RmtFill
>>      LclFill
>>      LclNTWr
>>      LclSlowFill
>>
>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>     LclFill,
>>     LclNTWr
>>     LclSlowFill
>>
>> 3. Users will have options to update the event configuration.
>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
>
> Once the "mkdir" support described below is implemented users will not
> need to redefine these legacy event file names. That makes me happy.

Yea. That is correct.

>
>>
>> 4. As usual the events can be read from the mon_data directories.
>>     #mkdir /sys/fs/resctrl/test
>>     #cd   /sys/fs/resctr/test
>>     #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>>     101010
>>     #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>>     32323
>>
>> 5. There will be 3 files created in each group's mon_data directory when
>> ABMC is supported.
>>
>>     a. test/mon_data/mon_L3_00/assign_exclusive
>>     b. test/mon_data/mon_L3_00/assign_shared
>>     c. test/mon_data/mon_L3_00/unassign
>>
>>
>> 6. Events can be assigned/unassigned by these commands
>>
>>   # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
>>
>>
>> Note:
>> I feel 3 files are excessive here. We can probably achieve everything in
>> just one file.
>
> Maybe the one file could look like:
>
> # cat mon_L3_assignments
> mbm_total_bytes: exclusive
> mbm_local_bytes: shared
> mbm_read_only: unassigned
>
> with new lines appearing when mkdir creates new events, and the obvious
> write semantics:
>
> # echo "mbm_total_bytes: unassigned" > mon_L3_assignments
>
> to make updates.

Yes. That would work.  Also we could move the file to group's main director=
y like we have other files already.

#cat /sys/fs/resctrl/test/mon_L3_assignments
 mbm_total_bytes: 0=3Dunassigned; 1=3Dunassigned
 mbm_local_bytes: 0=3Dunassigned; 1=3Dunassigned

To assign mbm_total_bytes config on domain 0.

$echo "mbm_total_bytes: 0=3Dexclusive " > mon_L3_assignments

To assign mbm_total_bytes config on all the domains.

$echo "mbm_total_bytes: *=3Dexclusive " > mon_L3_assignments

#cat /sys/fs/resctrl/test/mon_L3_assignments
 mbm_total_bytes: 0=3Dexclusive; 1=3Dexclusive
 mbm_local_bytes: 0=3Dunassigned; 1=3Dunassigned

>
>> Not sure about mbm_assign_control interface as there are concerns with
>> group listing holding the lock for long.
>>
>> -----------------------------------------------------------------------
>> Second phase, we can add support for "mkdir"
>>
>> 1. mkdir info/L3_MON/counter_configs/mbm_read_only
>>
>> 2. mkdir option will create "event_filter" file.
>>     info/L3_MON/counter_configs/mbm_read_only/event_filter
>>
>> 3. Users can modify event configuration.
>>     echo LclFill > info/L3_MON/counter_configs/mbm_read_only/event_filte=
r
>>
>> 4. Users can assign the events
>>
>>    echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
>>
>> 5. Events can be read in
>>
>>     test/mon_data/mon_data/mon_L3_00/mbm_read_only
>
> Is there a matching "rmdir" to make this go away again?
>

I would think so.

Thanks
Babu


