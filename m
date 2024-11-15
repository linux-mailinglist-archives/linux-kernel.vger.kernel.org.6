Return-Path: <linux-kernel+bounces-410845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D79CE572
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF251F21B83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6901D432F;
	Fri, 15 Nov 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eGUYYkmD"
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E81D4615
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682652; cv=fail; b=PSW2+fPxpNYQ6uzcUNpsi11CnjY08fW1XmGn86RDN59BrI2MPR0nPAEgA7OLorR5ClZ3kWW4icYsBlUzmNpFftmGj5PCUW7vAclVKfkPnyfHFK4vWXhM6lOEv06lnE7I/QGOBNaS+EMq0U9cfYgiEF1m7hLcIilaCdGXc0XsO4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682652; c=relaxed/simple;
	bh=ZXjFB2ynyqkg1K/X+HGrl1gsgy88d3o6vsZUKU1typY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDLAVqrb2EUS5BxU577dkm/B6FGEgWorsh+mUK3X0SiDoryf2mHq0sBsYD2UtWqrOThlVU6o2AHjrTNVvEk1Y02p0DH5DZXH6VOCWAym47MFxExhugjTMUmaABLIAWJfcRgvNzB+lUaCoGr1TJr1ICjqoNoTU8kBD1b6j+6bcdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=eGUYYkmD; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16151; q=dns/txt;
  s=iport; t=1731682650; x=1732892250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=HgBjvwtAuTNkkKIaOShkJPaBXzU/NkBSIzzqrJzI+70=;
  b=eGUYYkmD7Q4Bm3u6ReniwPXPigd/0jxDHH8NFDn/KPU8/aGd2quYk8NG
   CERHrYzpcSAGjwg6onDeF73wZXrM/FJZ6OQwgJQfNuK16i2WmdAqXI6SD
   70Beiog3NX72ixwXOpdeeTqK05LR5NRaejvWet0OmkCxNrzxY27d4+Xru
   M=;
X-CSE-ConnectionGUID: VNotJ1rzTb227FkUoXG4+w==
X-CSE-MsgGUID: oPPIxqveQYOgnINaDaHeaQ==
X-Files: dmesg-debug.txt.gz : 9079
X-IPAS-Result: =?us-ascii?q?A0AHAAAgYDdnj4z/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAWWBGwUBAQELAYFxUnswboUdg0wDhS2GUYIEHQOFeoxwiyyBfggHAQEBC?=
 =?us-ascii?q?gECAkQEAQGFBwIWijICJjUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFFAEBAQEBATkFDjuGCIZbAQEBAxIRVhACAQgYKgICAg4hJQIEDhMUg?=
 =?us-ascii?q?l8BglMRAwGlXAGBQAKKK3qBMoEB4BAQGIEwAYFXgWWEdRoBcmgSg32Edycbg?=
 =?us-ascii?q?UlEhD8+hFqDRIJpBIJBgTWBQYEndiWCGoZmiWwLj1BSgRcDWSERAUsKNQw4c?=
 =?us-ascii?q?SEsA4JJgjWBUoJGgRSDMYFeBTcKdoITgTQ6Ag0CgkVzH4dngQuDYYNIgRmBb?=
 =?us-ascii?q?YFTHTYKA3g9NRQbBptICEqBHIYoPgYIgguBBoEXlhABSYtGgguhXAqEGoZbg?=
 =?us-ascii?q?zCYGKo7LodbkG6jUYUsAgQCBAUCDwEBBoFpAjaBW3AVgyNRGQ+OOsksgTMCB?=
 =?us-ascii?q?wsBAQMJkFkBAQ?=
IronPort-PHdr: A9a23:yKeHYRzO8qVzkkHXCzPsngc9DxPP853uNQITr50/hK0LL+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:HBeIWarTBUFzi1ExmBjaAONOG1FeBmIaYhIvgKrLsJaIsI4StFGz/
 9cvaN20SqvXNyGiZo0jOsjh6w5O/YiChObXe3I/pC8xEHsUopTLCIjFc06tbi3Pc5aeFU5uv
 8hANNLKJ8s6Ei7X/0ikbrbt/CMk2PzXGbf2UrPKYiwhGgJqFnx74f4Ps+chmoppitGlAgSL/
 sO3rN/eIDdJ/hYsWo5Dw/Pb90IHUI3OhQ4kUjXSoxwhlFPbmmIaSZ4SL7y+aWfoXuG4dcbjF
 u/JlLvpozuDr0cmUdn1yrqqLhwGSe+CNlXf1XAOV6X6iEhO+3Q4iq9jb6oSNhoJ1mTRxI0sk
 oVE68PgGV8iVkGgdJzxdjEAe80pFfYfpe6YSZTGjfGu8qHmT5fN66oxXBFoZ4ZD8OwvD2xDq
 6dDczoDP0+O173rkLzmELA2r8lyd8OD0KHzFZ1DIZA1Kd58HPgvlo2TvYcwMA8Y354IRbCGI
 ZJEMVKDVTyYCzVXIFAbFZkiq+mhg3j7YlVwpUmczUYNyzC7IDdZjv60arI5RvTQHZ8Jxx/B+
 zqcl4jEKkhy2OK3mGLtHk2E3ocjrQujMKoOGbux8OJdgVH77gQ7FB0MWFKnluKyg0i4Vsg3A
 xR8Fv0G9PVaGOSDF7ERbjXgyJK2lkd0t+l4T4XW3DqwJp/8uG51MISroglpM7TKvOduLdAjO
 8Tgc9nBXVSDu5XNIZ6RGyv9QT6aYUAowWE+iSAscy0C//u6upMPhEiVEfhgLamFoYG2BmSlq
 9yKhHBWa7Q7l8UH0eC/uFvAmT/p/sOPRQ8u7QKRVWWghu97TNf6PMrzth6BsKsGddrBJrWCl
 CBsd8y24OkIDJyJiyWlS+QWF7bv7PGAWNHZqQUwTsRwqm/yqhZPe6hX2AlfNF53P/81XjDvQ
 WnalQpx6ZZqaS7CgahfON/pVJ9wksAMD+/NUvHSc8oLYZVrcgKD1D9haFTW3G33lkUo16YlN
 v+mnd2EF30WD+FjiTGxXepYieRtzSElzmSVTpf+p/i67VaATECzTqsnaUGcUupjtvyqozjSw
 /kDdNTfnn2zT9bCSiXQ9IcSK3UDIn46GY36pqRrmgirfFYO9IYJVaK5/F8xR7GJiZi5gQshw
 51cZqO64Aen7ZEkAVzWApyGVF8Jdc0lxZ7cFXdyVWtEI1B5Pe6SAF43LvPbh4UP+u151uJTR
 PIYYciGCfknYm2YoG1DNcil/NA5KUzDaeey08yNPWdXk3lIGl2hxzMYVlG3nMXzJnPt7JJl8
 ufIOv3zGspaHFoK4DnqhAKHlA7p4iNHx4qermPDI8JYfw334ZN2Jinqxv4xKIdkFPkw7mXy6
 upiOj9B/bOli9ZsqLHh3PnYx6/3SLEWNhQBQAHmAUOeaXKyEpyLndQYCL7gkPG0fD+cxZhOk
 s0PlquibqFdzQ4U22e+ep4ypZ8DCxLUj+Yy5ixvHW7AaBKgDbYIH5VM9ZInWnFlrlOBhTaLZ
 w==
IronPort-HdrOrdr: A9a23:u/LfQ6/95HeFeGGmIaJuk+GXdr1zdoMgy1knxilNoENuA6+lfp
 GV/MjziyWUtN9IYgBfpTnhAsW9qXO1z+8S3WBjB8bSYOCGghrmEGgM1/qZ/9SNIVybygcZ79
 YeT0EcMqy/MbEZt7eG3ODQKb9Jq7f3ktHMuQ6d9QYQcegAUdAY0+4NMHfhLqQAfng/OXNWLu
 v62iNvnUvSRV0nKu6AKj0uWe/Fq9fXlJTgTyInKnccgjWmvHeD0pK/NwKX8Cs/flp0rIvK91
 KrryXJooGY992rwB7V0GHeq75MnsH699dFDMuQzuAINzTFkG+TFcRccozHmApwjPCk6V4snt
 WJiQwnJd5P53TYeXzwiQfx2jPnzC0l5xbZuBylaDrY0I7ErQABeo58bLFiA1zkAo0bzZdBOZ
 dwriekXlxsfEr9dWrGloD1vlpR5zqJSDIZ4JwuZjpkIMojgHs7l/1EwKuTe61wRx7S+cQpFv
 JjA9rb4+sTeVSGb2rBtm0q29C0WG8vdy32CHTql/blmwS+pkoJhHcw1YgahDMN5Zg9Q55L66
 DNNblpjqhHSosTYbhmDOkMTMOrAiiVKCi8fF66MBDiDuUKKnjNo5n47PE84/yrYoUByN83lI
 7aWF1VuGYucwblCNGI3pdM7hfRKV/NEAjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EFDsjSS5
 +ISdtr6j/YXB3T8KpyrnrDssNpWAwjueUuy6IGZ24=
X-Talos-CUID: =?us-ascii?q?9a23=3AmL5OEWstijlRLj05YiBv+vLB6IsbVHrB7i7KMXO?=
 =?us-ascii?q?yUzw2Zr6oTm+/pOB7xp8=3D?=
X-Talos-MUID: 9a23:Py/s+AY7ACxEf+BTsAfUpSF7KspR0oOhDmErmLkPm8SNDHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Nov 2024 14:57:23 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id D7756180001EC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:57:22 +0000 (GMT)
X-CSE-ConnectionGUID: V61l7H9dQgeBCQbt+IGrEw==
X-CSE-MsgGUID: Nh9HqFiTTKOlww1160xudQ==
Authentication-Results: rcdn-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,157,1728950400"; 
   d="txt'?gz'50?scan'50,208,50";a="19455586"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Nov 2024 14:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP3B26ckhNEkhZFvjQBJMnuX7qP8S1r/6Lr3/wO6OXfOP+CzXUouB4xVWqist66qBLgkIiv0izwAMdfeimdZPAx0tIVQufI27VFq6QKS9DsTWsogkTtCCaA4X2zfdi5/JLfPTh6CFxzp6yhP2d7bzhGrYUjYx6L/Ea96h2jZmmVCnUa/cTJR2fCuM+7g430Mc+r68qqNkLf4hD50bYio2H6qz5x7u4CRZP9mqhTAafZ6Zk7DC1ocyNCIxBaPygALtt8jmFDcOx4G/PiKT35IDPSxdHbdf4iQwdc7RowI5zdyB6SgcnSZOjCqjzVyFqGi9NYJLVdMwxqA2rCYYQEzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgBjvwtAuTNkkKIaOShkJPaBXzU/NkBSIzzqrJzI+70=;
 b=OVJEfwSz+xCtnONyaqgdjgIQ+rWHO3PUVKIXDytmpnvgcH3qWGIOrA6QonNXDB0HrE3UPq2tfkHF5R61HrRKbFAeflCS61lfZ7BzxRGDQ6IAq/WuUhbCrcd4dqWvXjU9wf5PbL68sGm2OyfZnSY0O1+0aKrNTNDcuQNzaFwyJ41/lmcojwdiDf/imeiO/QTxQnt7Y0mrH/hJI1P7gJt7Hu+d6bkRtO96phZUcFKFes/3YGZxgi6KTf7ecE5nkVHmP432QA2oN1ipCN6C3us35LMCk5c+rljIwKAXMB6znpnLO8RfKKxifrtTcA+tBgwRznqNtiwBr6A4GmN5Sm7RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 14:57:19 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:57:19 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
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
Date: Fri, 15 Nov 2024 14:57:19 +0000
Message-ID: <ZzdhTsuRNk1YWg8p@goliath>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
In-Reply-To: <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|CO1PR11MB4948:EE_
x-ms-office365-filtering-correlation-id: aa7b7abd-a8fb-4b06-627b-08dd0585cd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmRpU0NQL1VmUEF5TWZOWjIzcGN0blRMNjNHNTdKR1Rkejd5bmE2QzN4a2tI?=
 =?utf-8?B?b2VSUFhkWXVWRnNvSWVwaURiS3hhS0FiQ3BlR3RzS3E4MU8vR3pLTTIvYjBL?=
 =?utf-8?B?VjAwTCsvVUU1NkFqTmFSeTZQUk11WTlpV0VaeFJWR2c0c09KbUdaQjROcFlp?=
 =?utf-8?B?VVpGL1lCZ09sNUk0bHNhQXFxYmpIbGxWemxkRDVhUjJ5dVhjSUFUODNtbGlX?=
 =?utf-8?B?TzUrSXJLL2h5UFJqSGw5UEE3N3Q1UG0rY3B2dHRkd20zMXNsbFd2VkNtSW01?=
 =?utf-8?B?Z0dnaHNXTUt2UDFqVEc1SGN1dXRxSVo0Tk83dlJMNVVPd1l1MEU2V1llUytD?=
 =?utf-8?B?NEx6RDFFQlN2NzZMY1lYUCtTWlRLWFJXL2RwRDZPRzcwWkk0ZWNuVkFDaW1R?=
 =?utf-8?B?QlBSUFJoUWIySlRYVXROdXpOZXZwNFM3WjdVT2V2VDUxQU1QRHViek1mWjRm?=
 =?utf-8?B?VWp2ejF3NStjSk1YOEIrb0J2MlFRR0lqaithNUh1V1JGNGp4eXJyNFc1Vklh?=
 =?utf-8?B?SEFPZzNEYngrVUR5cURnR2xPcWpkS3RGU3lnVTNtSWgvamhWMUtJRlptOXN2?=
 =?utf-8?B?aWJ5c3VyNmxvdTRXVnlEY3hqdGcrbS82aEVYcVFyNGZBY1dHcmJLZ0ZYdDFh?=
 =?utf-8?B?a3oweWVSTXFsVXVacWdmSWJJR2tKSGkxSmdrSHdLWjdGWFFiMlFjU0pha0lY?=
 =?utf-8?B?cmpIZVdrWWJzNmJnbnJuT01TTUJxTGFHRitmNTBUSHkrbzZiVENFUVdwN3Bo?=
 =?utf-8?B?MUt2Vzg0NWVCcHRPcTY0RDJocU1iT3hsSUJMUTRVOUVWWFBESEhaNGF0SzBo?=
 =?utf-8?B?M0FqYU11a3luMUVUaGVCL2ROVlNMWWNZb055amo2Q1Q0TWlveTlyYkQycUov?=
 =?utf-8?B?RGVQT09TZEJXZTB0NFFqOEw4VndSMDFpaEZkT1JnNDhZa2g1NjlrSFUyQXhv?=
 =?utf-8?B?OHpjUU1BbVdRalVVdnRFeDlwL05QOUZpcXFYcjkxNVVTMFJOQUpGZ1BUTHpE?=
 =?utf-8?B?UGhQMXV1OUVxRkFCdG91amlxRyt3bUVscTEyanlVenhrNEJXTGJmdUNPNmVm?=
 =?utf-8?B?Q0M4aGRqRzNaUWxBYnNnZVdzaEtSOUZIVTBSUVlhQ2xXVGpucjdpbXlnemtw?=
 =?utf-8?B?dU80djJ0bXJTWVFFbi9IT1UvM1FNb2RjMFlQR1pJcGtrQWJoSnZuMTJFRWQ2?=
 =?utf-8?B?UzFoWlhVQ2M4N3dvMFhnUkVuM3hlblVXd09Dck9tV2s5bmJvb2dOZFd4c0xX?=
 =?utf-8?B?WlVtRExLSWwyMVFLY0RQYWRob3R4K1owRWl3a3lhUHBWUmthcVBJOGNrazdT?=
 =?utf-8?B?SERvcVNIRHRsQTRhYmxlaWxLd0RtUWh1dGM4OXBjWmk2MVBnVGNocWgyQ3ZR?=
 =?utf-8?B?RDEyZ3hCNHhYUzVYenB1Qno4YllwdnpvYWo4OEhkOG0wOEJsWXYvYXlJY1pv?=
 =?utf-8?B?VXV6Q0lDQ1lqMFdFd1B2bFljTHRVVlE5bkNBcHIwUVM0a0srMHF4cS9XK1JL?=
 =?utf-8?B?dHBWZFZCOUhRMllXOUMzd3VVaDJQNU9wYU12eFErZkl6MHY2VXJsK1UyQVlR?=
 =?utf-8?B?aUJBc3pFeFRIWndZb2pJWSs0K0llOTU1WjdlNlZqYjA5dFUxS2tveWdzVzlz?=
 =?utf-8?B?aHFocXdGSmpVNXlkVi8zT2c2SzYxVUZNR3QwR3p2bWJ2eVhXb2hGN0twUUUy?=
 =?utf-8?B?LzJaUWFBeU1nSEdjQWRBYWdnbk4wSG90dEIvVWJtN1gwMFF4R21NaXZxSDB1?=
 =?utf-8?Q?g5mtPWUhjJlHOa38DekU2tpq5P0ffkLYzQC4MCi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW80cjZMUCt6TWFWNkttZHh2aFNzVS9xNWhObFpmc1I5Uk9lK3BaYjVQb2hm?=
 =?utf-8?B?WVpYQmx3d2JXdGYyRU1peW0rZ1N3WldNZHFvNlNuNlI2bDF5bFE4c1ZPTFB2?=
 =?utf-8?B?RjZlR0JPajQwUGRCdWxCczd5UytsUGlKMW1FUEdwNlFaeURqa2gwaHRDUHNl?=
 =?utf-8?B?dzIzQU84aEFKYkJkZjZTajN3d04zdHZVUUIwZmk5VUVqcjdqaDhjalZRTWsz?=
 =?utf-8?B?a004bVpRY2I3L3lUVjJibDFiREN6RjQvT1lqSW8rdzdxbkVxZzdHMnNldkJl?=
 =?utf-8?B?TDlyV01aNWdnbmo2VGVyeU8ydUNkVGdSdkZqQTUrUzlNb3JzajBPL09hQ3Nw?=
 =?utf-8?B?aFRPbTdHZXlNOTRORFFhQlNVYXJSbmFha2xzRUdQcUdaOTB3VThvZ1BUYzQz?=
 =?utf-8?B?S01reVFtYnhQWW1HRTdhY25Rc3JPOEFXQXFsWFhFcjA1c0pkK05sc3NoODdW?=
 =?utf-8?B?T3phbWpSU0xBUFpURlVIOWhraXFyM21Bc0ptMGlIajhsd29Bcm5EcU53OStB?=
 =?utf-8?B?VnNHSWhYZUI4clpUeVc4OEhMcHd6WEpyWVBMMUJ5UWI1cTl5M2lVUlZUaUlm?=
 =?utf-8?B?WTZMU01CWHZZOEJudjVYV3hUdVNPdE5jaExxR2xGbVZvRUx6aW9EVW52elNF?=
 =?utf-8?B?Q0VqSDdEb00wNUdIcGxucjY0VmJ4WlA4UmprWk9pcE5nVndVQlN4MUFzNlkr?=
 =?utf-8?B?OHg4MGxYcnE5dlB0azVTRjNzRnRmLys4Tmt1RDAwZ2cwVU5zUHdWSUZObUI1?=
 =?utf-8?B?eCttbXkrRXd3WGpIUEVRa1l0NXBOa0NRbUtER1d3L0xOY0M3TTV3dHFLMHR1?=
 =?utf-8?B?V0piUlg2aVZ6Z3pRSDkxVzFnbHFneWtVM2orMm9WZnJvaEdyVHlYQys1YmVJ?=
 =?utf-8?B?MGl2RTRpa2xHRXkwdDVaMUhmNHFWTlo5NDN6Tlh3dmR4MUpyblRORGJQQkJr?=
 =?utf-8?B?WmtlYTR4QkJLQjhncnpsVE1VdHlQbzJzZElvMHBhbU1Ja2lKUm9LK3ZIMms4?=
 =?utf-8?B?ZW1TWGZUSUhnQlRDTkRvb3NpeGVDemhJeEdxWXBINlhEMEFxV0U3ZXZxWVhW?=
 =?utf-8?B?K1BkaHg0YzZ1NUdpcnNKMlBwSUphVFZCNStvb1dwMmk5VmpmZWdOMHhVUjNX?=
 =?utf-8?B?QWdrRXVmaWw5c1FHZHRGUmZiQ2N3cDVBbHRhaWUvN054SEVWM0hCTE00emUz?=
 =?utf-8?B?QVFQMjhOSWp1ZmQrNFcwd00wYWg4cWlzOGJweFJYaElrakpoN3Y1cldJSG1Y?=
 =?utf-8?B?TU43QVNGc3phUkNidDFlWUJWTGV1QSt5Q3k3aVNSTnd5OFUzOVNYL0xINEd0?=
 =?utf-8?B?TTdkdXN4Y0xZYldEU0FzZTFBbkZ5NWtKdWEvN1VPdC9zbkdTbWhKYnNRTzAz?=
 =?utf-8?B?ekZMbjh6Q2xINGVBSlJXbHJCM09sMjdjYTlVSCtUb256SHlyQWF5NTZzYzVQ?=
 =?utf-8?B?QUVZckRWcGk0NjhHaCsxdzNyTGRFZjFWMm9lZTNyNHkycm1QaW5aYkhETGZs?=
 =?utf-8?B?QVJRRWtwNEFQbkxMVFNQYVhVbTZoVFIvUWlQY2dBOGdJMVVISnB6cGpycHpK?=
 =?utf-8?B?M2lyYjBqSjBBZ2pqcEhLY3FrZkg2aG9HMVh1UnVFcUl4bElHZXdjTUh0Z0o2?=
 =?utf-8?B?UW5mdmJrVVQwSGNyT2dnMWcxYzIzOXVFdXZVMEJuYWJ1SlMwZm9MVE9KYWMx?=
 =?utf-8?B?Rk91eWM3emNNZGtWZzRUcC9IdTFoUTRsVWRYcUt4a0JFWENRd3dGZitMNmxK?=
 =?utf-8?B?NUIzM1ErUFVtZDhvWmJ3MWMyY29idVNLVit2bHpGc3FwWGRUOFhQV000K1FU?=
 =?utf-8?B?K2pUeHlXaVNsMktaaWZoQmlmL3JlOEhzVzZqdk5XV1RMWFBERWFIVmVBUTJR?=
 =?utf-8?B?c1luZUNmMkRUSklEYlJPVWwzK0lneCtnT05PdzJlVEJFMVBueHdXVnRrQUhy?=
 =?utf-8?B?TmFjOEZrbVQ3QU5kMWFrUnFnZUpZY0RBM1R6T0VNK1Z4R3liV0xBb24rOENB?=
 =?utf-8?B?V3hOcng1Tnc5d0JEa0lvZkIzSm5xTm50ZWlGNk41WlRLVk4zMWplU2l6bllV?=
 =?utf-8?B?WjJsTUZxcE5tenE1bWFHbE16ZWU4d1Y0ajFMR3hkYjNLaTBwbUtEckRER0g0?=
 =?utf-8?Q?4olmZDPg0JQI7uKOIvzWLNB/3?=
Content-Type: multipart/mixed; boundary="_002_ZzdhTsuRNk1YWg8pgoliath_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7b7abd-a8fb-4b06-627b-08dd0585cd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 14:57:19.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/f2nko9Oyh2y1mhkQ8/EsQ1+vj0v/7kIVENYSNWCMzOxK0LWVHopAmIHk3pMU1CEQvN+8TgX7bBLPbFlU9NUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

--_002_ZzdhTsuRNk1YWg8pgoliath_
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE6031F74A3D144691E6BB57B0FC12D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgMTE6MzU6NDZBTSArMDAwMCwgU2hpbmljaGlybyBLYXdh
c2FraSB3cm90ZToNCj4gT24gTm92IDEzLCAyMDI0IC8gMTk6MzQsIEhhbnMgZGUgR29lZGUgd3Jv
dGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gT24gMTMtTm92LTI0IDY6NDEgUE0sIERhbmllbCBXYWxr
ZXIgKGRhbmllbHdhKSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0IDA2OjA0
OjQ0UE0gKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gPj4gSGksDQo+ID4gPj4NCj4g
PiA+PiBPbiAxMy1Ob3YtMjQgNTozMyBQTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiA+Pj4g
SGksDQo+ID4gPj4+DQo+ID4gPj4+IE9uIDEzLU5vdi0yNCA1OjI0IFBNLCBIYW5zIGRlIEdvZWRl
IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4+PiBJdCBwcm9iYWJseSBoYXMgc29tZXRoaW5nIHRvIGRv
IHdpdGggdGhlc2UgMiBtZXNzYWdlczoNCj4gPiA+Pj4NCj4gPiA+Pj4gcGNpIDAwMDA6MDA6MWYu
MTogQkFSIDAgW21lbSAweGZkMDAwMDAwLTB4ZmRmZmZmZmYgNjRiaXRdOiBjYW4ndCBjbGFpbTsg
bm8gY29tcGF0aWJsZSBicmlkZ2Ugd2luZG93DQo+ID4gPj4+IHBjaSAwMDAwOjAwOjFmLjE6IEJB
UiAwIFttZW0gMHgyODAwMDAwMDAtMHgyODBmZmZmZmYgNjRiaXRdOiBhc3NpZ25lZA0KPiA+ID4+
Pg0KPiA+ID4+PiBJJ20gZ3Vlc3NpbmcgdGhhdCB0aGlzIHJlLWFzc2lnbm1lbnQgaXMgbWVzc2lu
ZyB1cA0KPiA+ID4+PiB0aGUgcDJzYiBCQVIgY2FjaGluZywgYWZ0ZXIgd2hpY2ggdGhpbmdzIGdv
IHdyb25nLg0KPiA+ID4+DQo+ID4gPj4gSG1tLCBidXQgdGhhdCBzaG91bGQgYmUgZml4ZWQgYnkg
MmM2MzcwZTY2MDc2ICgicGxhdGZvcm0veDg2OiBwMnNiOiBEb24ndCBpbml0IHVudGlsIHVuYXNz
aWduZWQgcmVzb3VyY2VzIGhhdmUgYmVlbiBhc3NpZ25lZCIpDQo+ID4gPj4NCj4gPiA+PiBhbmQg
eW91IGFyZSBzZWVpbmcgdGhpcyB3aXRoIDYuMTIsIHdoaWNoIGhhcyB0aGF0Lg0KPiA+ID4+DQo+
ID4gPj4gQ2FuIHlvdSB0cnkgYWRkaW5nIGEgcHJfaW5mbygpIHRvIHRoZSB0b3Agb2YgcDJzYl9j
YWNoZV9yZXNvdXJjZXMoKQ0KPiA+ID4+IHdpdGggNi4xMiBhbmQgdGhlbiBjb2xsZWMgYSBuZXcg
ZG1lc2cgPw0KPiA+ID4+DQo+ID4gPj4gSWYgdGhhdCBwcl9pbmZvKCkgaXMgZG9uZSBhZnRlciB0
aGU6DQo+ID4gPj4NCj4gPiA+PiBwY2kgMDAwMDowMDoxZi4xOiBCQVIgMCBbbWVtIDB4MjgwMDAw
MDAwLTB4MjgwZmZmZmZmIDY0Yml0XTogYXNzaWduZWQNCj4gPiA+Pg0KPiA+ID4+IG1lc3NhZ2Ug
dGhlbiB0aGF0IGRvZXMgbm90IGV4cGxhaW4gdGhpbmdzLg0KPiA+ID4+DQo+ID4gPiANCj4gPiA+
IEkgaGF2ZW4ndCB0ZXN0aW5nIGFkZGluZyBhIHByX2luZm8oKSBidXQgdGhlIG1lc3NhZ2VzIHNl
ZW0gdG8gaGFwcGVuIGluIHRoZSBzYW1lDQo+ID4gPiBvcmRlciBpbiBib3RoIHdvcmtpbmcgYW5k
IG5vbi13b3JraW5nIGNhc2VzLg0KPiA+ID4gDQo+ID4gPiBEb2VzIHRoYXQgbWF0dGVyPw0KPiA+
IA0KPiA+IFRoZSB3b3JraW5nIGNhc2UgZG9lcyBub3QgZG8gdGhlIGJhciBjYWNoaW5nLCB3ZSB3
YW50IHRvIGtub3cgaWYgdGhlDQo+ID4gYmFyIGNhY2hpbmcgaW4gdGhlIG5vbiB3b3JraW5nIGNh
c2UgaGFwcGVucyBiZWZvcmUgb3IgYWZ0ZXIgdGhlIGFzc2lnbm1lbnQ6DQo+ID4gDQo+ID4gcGNp
IDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweDI4MDAwMDAwMC0weDI4MGZmZmZmZiA2NGJpdF06
IGFzc2lnbmVkDQo+ID4gDQo+ID4gSXQgc2hvdWxkIGhhcHBlbiBhZnRlciB0aGUgYXNzaWdubWVu
dC4NCj4gDQo+IEhlbGxvIERhbmllbCwNCj4gDQo+IEl0J3MgbXkgc29ycm93IHRoYXQgdGhlIGNo
YW5nZSBjYXVzZSB0aGlzIHRyb3VibGUuIEkgaGF2ZSBjcmVhdGVkIGEgZGVidWcgcGF0Y2gNCj4g
Zm9yIHRoZSBrZXJuZWwgYW5kIGF0dGFjaGVkIHRvIHRoaXMgZS1tYWlsLiBJdCBhZGRzIHNvbWUg
cHJfaW5mbygpIHRvIGFuc3dlcg0KPiB0aGUgcXVlc3Rpb24gZnJvbSBIYW5zLiBJdCB3aWxsIGFs
c28gc2hvdyB1cyBhIGJpdCBtb3JlIHRoaW5ncy4gQ291bGQgeW91IHRyeSBpdA0KPiBvbiB5b3Vy
IHN5c3RlbT8gSXQgc2hvdWxkIGFwcGx5IHRvIHY2LjEyLXJjWCBrZXJuZWxzIHdpdGhvdXQgY29u
ZmxpY3RzLg0KPiANCg0KT2suLiBUaGUgZG1lc2cgd2l0aCB0aGUgcGF0Y2ggYXBwbGllZCBpcyBh
dHRhY2hlZC4NCg0KRGFuaWVsDQoNCg0K

--_002_ZzdhTsuRNk1YWg8pgoliath_
Content-Type: application/gzip; name="dmesg-debug.txt.gz"
Content-Description: dmesg-debug.txt.gz
Content-Disposition: attachment; filename="dmesg-debug.txt.gz"; size=9079;
	creation-date="Fri, 15 Nov 2024 14:57:18 GMT";
	modification-date="Fri, 15 Nov 2024 14:57:18 GMT"
Content-ID: <0ED6A52812635241A28F4F6AEB97983B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

H4sICMxgN2cAA2RtZXNnLWRlYnVnLnR4dADcWmtz2kyy/q5f0bXvh+BawLqC4BRVay522BibAzhv
9qRSlJBGWIlury62ya8/3TMS4mZiZ/d8OVQllkbdz8z09PRt5tYL8xd4YknqRSG0moralBuJ3W6E
7CVrqLKqK4qiNRwvyTZQc54t/wdL/rGOfM/KHi+gtrZtqD2s8jDLQdGaxK3n/FW7KBrqcHP3AL4D
Nfrbxw4zz0/BjRIQjBegNnXlAv7QYT6ZwnXiwV30BIoBcqurt7qaAdP5Amgw0iAKAit0wPdC1gU7
CtPIZ70s28zleqcly2DZsbeMUq93y2c2HPUfbpaD+7vr3qXrW+njpcNW+bqJnC7MRle3y8nNZDFa
Dkefe5A4XuhlvcuVF14iKfTvr2bD8bCnmm1Thvls2b+/X/QyN4u7l5eqirMzDPyn4z/t8tLKs+iS
PjbS73YjT1Gm6qVjhR7zn63L1c9xYK1ZQ3SPPUj98f28ESfRk+cwB+LHTerZlg+zqwkEVtwV35mp
yl34GrAA5Bf54NfYazKY67rfIE+tlc/OcxvuMbfLuROG435iznn+1nHvZvvNvZvmEXfnHb0rh3Nv
y632G+dOpO4R96rz1t6J2DrgV1xNeWPvSKoecGtywf2W3pH4kN9UdfmNvSOpcsDNViv25t6R+FB2
zC34rwbTMdx9np/ld0/wuzv8jpVZ5wHcEwDu26bPir873AXz26bvOkf8Lmu/g5/Zx/zY9A5+84jf
eQ+/oxzzK+138Jv6Eb+pv5nf5Ttvj1+s/pv4lZKp4lfb7sHq332B2uiF2XnGYOjxtgtAE5sxO0P/
1kXvkHlPTLqajgddmGdW5tmARhfdEVl+z/K9nzgI5npdGF2P4QkdE6w2ML6b/2s4gkGUxE3xdT6h
kfbkl7apWxoOBkbz2aJ4lx3FFBqN7o/aSM1lRResMxZETwxwdkanC5PJ+B4SK1yz3lf5ZUdJK+Ws
qUZr0r8AN4kCINmQfzjEasmHWDsKWylqTdVfgbqLMlwGhPPCNQdUjgArDa40t6Z/+uXQ1BNI5hap
1OGa/NaRacd4W92udLqmqa8M7QhQPwFYKnul5G+ZqnGEVKl9pe4183iqQqNQY0zUWNwOYdaUhpNx
F8ZhunEYfLSSxEuj8MnzfXa52MRMhQb0IytxYJpETm5ncGcFTKkDB5KNpiLzeE5WWyC3L1XjUpUV
U4BOcMjJBlI/ylKIozj3rYw5XVAudSlL7S4MGW0aDExU9DhNUvDJx5+0l2yWplEiYSyVLWM3hB7u
UZWvJk7jZWkl9uO2XS83rTRZzGY8rAFFBpxb4rEUaga43gv28Xcw4MlKPNqw/0UwoBoXdVjlnp8J
MSFXSQCElUovZutyerXoAv4HaR7HUZKBIza9AytmWxiCAUV+45vlF7O1JDovrUi8ELJHBhjPhsxv
VngDDA29dZ5YZDLgq9xof+vCn32APxcAD4MG/oOD931p8AU/JwyWJhlpDdk8UkEyHZDGls3EZHd9
dmFNsuio1ZCb0kNK/Dd9iDG2FDE1huq4cCTrGL9Jc7SGCYNVhDpvRzmG4SE+rRg4uMBJgGG0I5Gp
QoNnJf4GMi5i+5HZP9I8oMzAczEu5bIoRVcwzObD6e6oRtfXI7RywG2zDrUnWS0s50XB8WU+XBxy
KKj/9HI1IA6ltLXDu8/Af6X9L974Ple0EvEa/xwgdkj63GNwRON1RG6i8YmvTIk4PB6jLBB187q/
O6sjRPk0Io5xvo/YHxZjRMKC6IH8zX63JZGqtX4hmpPdnkAcbLtVzyK+MpH+8OpQNP0SUZN/CxET
qgPEqxJRNX9n1h+no0NEczvG30KkYOEAsV0iDrkctXciTgbXNweIre0Yf7UNTiL+ebwyRoGoDPTf
QZwfbYNRoY9KB3le3Qbaq2s9nFzNDhC3+tg+rz2vbdX+jXqAuNXHFh+j/E59/DiaH856q49Xv6U9
o9kRYmmg1F/smVcQ+6PZIWKl4b+FOBrf/fMAsdRwxfi9Md4cjbHS8N+SY+UtuckXbioQUYyVlckC
Rdok3kbxqMirb0cA3MKfAZArAN10rWMAbtBfB1g5WwB81NxjAG6az4ygAnAdVTPeD2BXALasK8cA
3JSfAVhVACtZPTEFbrnPAFgVgIWZ2jEAN9RnAMwKwJS1EwDcLp8BaFcAbYyhjgG4GT4D0KoAWrJ2
QpH+/IUQjQrAUGztGGB+XhNZpQeMoVqfUGWyqWcAKj3Ax9aJZeQm9AxApQf42DoxAm4xzwBUeoCP
1oll5AbyDEC1nVlHPamJZA/PAFSKhI+nALj5OwNQKRJrK/qpEdycH0GlSPhIqvw/UchEiph2JaBV
FCbwRJ33oGLHc2XKIQWbpp5iK2ol+5WWLdtdlASWf8R2tsAiTaInPr+fNPI0szDXomSDWfYjJhQO
k0T2UEyfWor5YYf8De37yTr20fyKOvYv+F6tQJ/ne712fI7vXNX3LN+Zeu1ZvjOFzjN851dwHHoZ
kacsy2OBIf96QXYA7sOCqy60ANUPs/ki88RkOg+tJ8vzuZoUa/8fY8Ec8Z1MmtoFo/M7XLpmqL/D
p5pyR38Xo9iJ2KPcaZ1lFAZnOmksvIAlML6HaUQlBPlFMWVTGkwfIIviqAvjdRglZJIeo6wR+/l6
zWG4qxwPwST8orqEHdo/sM9mgX5LRMu7yRhq/AzNc3j16hs8eutHYM6a0aFbho3KtwtpfE/kX+Vv
XbBiz0ZqUOvbc0QNny3HwY5SqOqGdbiZY2DXUJRO0ef4brGczwbL+88zqK1yJAb8f+klf+HT2o9W
ls9fVHBcn/5d/Jqxs8vYEaP32RPb8oqaCQ8ya5Or4eKCWzI6ebT3Kj9e6NL60PNubuk5JHcUe8ui
YHVlpawLRR0Tf9JiPgCHWQ6dUELG12u7njsrNbFemuBHa37mVyxF2sVtrbxG5HiCAE4R0UeIsa8C
6iRS9pjgwASdHSVHRHd50OQfjqAA9EO6XbAdyl26K9+PnknY+lbp8COy+HzFUEdJRXnbDteMfReV
R06rqFLpSd2tdcNgpKhnV1uFFnE6GKPsnzwb94ztR/aPNMoTG8eVMJcqXY3vnutyMQZW+oMvW/Hj
5Tp7Y/v0sWqu83bP8dkyxA8KJhSdVqejy1pH0ZUOhKnE7ekSpWDHOYpmtsRhz7tKC8JkiU3U0XLl
ZWlXL1oQrnghY8DfFKnkHwUr5tB5sFGYkktshlQxtU5LhsRUOrgX1A76FcgNVVdNU/rEC5i4bv9v
TsYfwh9h9BwWpdm9maFQEiug0mUKf3vXFP5Ph/y3Ojx7vk911dhKU1y/LALiEmXdpoSG3IkCXJcE
twPJEhz0AFKMxjpDRcQ9jgbMdZGBDkHh7xhJ4R96Rq3TFLmtYptumG30TT0wzA7GEbDaZKjoQyqn
b8DGUIzBI62OCEWLKjtV3HXTaLegFiUOS/BdqYOpmWZLNgVEnYvWStCsk0o2XocSKlchoU3HbaBr
sn6I1Oe1e4U7Ot9LM/wURCvP97INrJMop+I0RGETYBFl3ARy+6diZKerHYm2PK1Bg2TVpYjT/tG1
fL/2kyXRRR0emRUDvkd2N6Jtyt/dhDF6ldLIzZ6thJGnXNz20UehrYIwD0BvSvPbB2z5+Kfle+uw
19LrcE+z6ckNrQ4TL7xfkf1Jezg3skA9JLhDqaQ9RfqBw/KZhQtWbLoi3qU2XlC3M16BL8rkbpZY
ZH34ONGRkCVUW7qxPQBBb6y02mLuh9SoQ9tvqFzZIxhCcKmU2GgpPnosofMFcWlk8ABeEPssQGju
spqCCn/0Df0fGl/qgAbhpTgCPsR9KrTROC6bD5QbX34aUZi0Hpo0VOrKhvVQloU7glmOYQ0/oMFu
IhcWaPVS0XPZUUm6KAZxnpoPi1pwdrY4nEIOP2dEn6J6OrnPkgYLSbdo0ih+39rQ1DCAhcLOFzhX
zvc85bNaswg3Fq4YeQv8tnStMMqzJS6gixOs701Pov6LseH8ujBnGUdJHz03I2GoIOxSQC8KB8zI
3turpcX77O02VmKrgBdizf9jyLhY49l/z0UUy6eDYRC3ASrqMXrhSruKDy0ho5TQxGbbDoaaUCPo
ZDH1fqIaUrDj4K4l95Kh0LmeDYSrIZ/jo7sFJw+CTeGGwZRfVKMyc2xt2ZvSOcFX7p2+lateRFkD
DEBQFZ88HkrSrS/ZVNv7/vwxZtnvOvF2p6UZpoGmzCD/XdwFwB2GqSwKO90EpCKeDePLe7RZqNjc
xUtUa8FtF6XZNrZ99hzcl1qn+DacfRxuA0IRrGBYSAUMGdA/rfmolILYCaxEpshkvSSWJWHClhwj
aVC6Mqp/jP4ek1tbl1toGlsqMGpzZUN2rAJqNpnNDvptWytePkXZOnut/J4X52uMkVXE8UDhOyYe
aAarSYCIasV4xveTyQPIFWMRC2MYd8hWcVXUI7HCgLpJJ+/ibJLM3wtlD1zKUrO5GE9GSPzEzWhP
ftFknlwoPcz+vFDpqfxV7TUUeqe/+1qRpXaDUR3iWDVeURHFXbU0DcVr6Qdaoutyu2OoHZWq9Kgm
A3QXq0QYcWFq/CiKoZb+8OKYOeiShHnasVc5TzRECoCu6a+chfam2SRoOlGHfrSOJuPpHGp+/L1H
5+wy1bvR2KJeLB4ZL9MEEe5JkdMV2wRqi4lyId1aqIg8sQEPfVzlo/VPfdDNOqiTPmWaOv3ZpXaO
qOV94jooN8RTHPZ3i4kEzxaGLbhmJKMy/JfmMa4WbtjPCmCW4WXe2hJXbSj6saN4c5k+W/GabEeC
PWLYRoZtueTBURyhXaAgyaLbNz9FrrVFVA8QZyyLI4ov0n2a8uVJhcvyZTbvQ7DDe43RGU2C2kv7
9YJmjW/7t8EdgXyejL6MF/vMXNE5TeFLcb2IgFSCzBn5HddLAh6d8JtH+/y7Y95i4Wgdj9pQH8Zh
ccDfx5ASLdY0YY7HbzdBX0hY2vb3xGCekTXtbygq3Zfma1TVBYknz0KPYWe+NGNrdLO4UCgBBkOK
UOcWhhs4uC58zv0QQ5EVuYC7CGdgo97QhqYbFS4lNXNxO4Om8mV+9XmEZs7K6FYC2SWlCx9ezDYa
yEjsLq4UZBd5l+mHN+KoiDOfj97PaCLjZPoFVhFasvTd/Ipc8A/msx2WFwxZM7bEaBS9x1ftGwZZ
GIPXy3buT0UztPTX2HT63tLlAzb9iK20r4KsHB4VX5RVvdJ25KYIqV2F62Jrf8AUC/MUVNYPIIoe
Tekag2l+RjGZYkiKAgm5rqRFzEtVq09S7DlLNJvozZhr5T76ZE1tt0xUgtALcsx3NFmRbueTbnW/
jjD9NOihF7NEPlDfWIFVTzFNwLy07gWW9C9s6NIdnijglscLHTf3MXQf8dwVZz/egWtKE1y67Eza
orQ0U99mLUa9TKkOchYOw9Xv38dKg5ju3HRBmPMxroBfm13AVRYFaMAvqB0GmmGY8A9Qm6p88/En
1Fwr8Mh9yS+tOveKPj0bGMKgSnKnyb3WhTRlCV+oEGOsEQX3OLLpqD8HN8i0v9fhJvIddB2ZiPxx
XJqK2SqL4bY/qwMK02+I4MWmOaO218UQYYpu3klwoZMmeuRmWdIrC0/bn86/rtAjcJyD77rJP68Z
Wgb079s91d1lFg5TeOrdH4+bdn6cmC6FxQgWOcfE7UNifqusEedJHGFAwgr5AGj8q0iGTvfLq/1F
6CalmCBSfZb6xmeXKg98E1GeqqnSCJOKgLt6XjKk1MRCeWHGxlm2Pp+ukPLQqGqpUViQ8rD8QkTn
J7K6+bm0bkICeSTUMGoUyU+I2x81IqVNTkEGaWEXPQXqDe2jPMZQlpyJhRkQT/BQHJWmojVBYnws
t/1ePbRLsmsWhw9/FMlxIcA/FPhDhT+0sr8oXz9m1J3C6TGuEEW+bVci50d56dWVwlTczuXyrCnt
1n6QhLuzsDvtjtnuqOanS7rP3lZan3aKgDVF1zRs2VaOqHNcK2xKnqmaUgcD4yx8i8SbbpjmJ26c
cItoLf0TrFLcC5gbdDrqp+295Dogjx1YjbLhQsIEJwtiN+3uXR3ei0f//WqjomLMj0F/m9/mwTDU
zdGSv1LlUSuzhNFsyzC01qFVuhstKI4SuxHlPL1eYtPt+O7TJT7O7h8WI35fGh24D8IYSVbuUFa4
Z8BDliHkD0jzVbpJoVbGDBcldbaJWY8iWuANuJ6a0jIVuaU3FXT5ygWv6WSstyM8QboswlwM+hNe
dMlEJLzEjvbGXrTDOsI9F2Jc9YFs5PLZS9mHdzBRILrkVboPEibSJP0y4t0S+ZicUWDF9yLfInCN
+Rwd88ovuk4JorihqfAcFq6vhgt0ibZvkROmW6Y4jowF4EQsDT9k2/uq08GYwdV8OkEDH5WRF3iZ
RMXa+BE3E8f7iB1OqVROBW7Mt7Mk8n1Kurihrmy03DQkJMF4YHA1KQ/3Tt8pL1K18qM4BHGiwMIA
n2d8X/mxitygoz+OKc5N9s9IaJlxkxMvB7Rs2svSD9ShFSmleIDveRA3ohhtXhHk75ag6JigIEyp
UAcFIZUoXIwG09RDuqb0MV8zXsxLquVUyETceOL+KzfNvMjRqKocxcFhxU3+W4ZPyPOE8sFUFMPw
kAq3VD10+FSsfdyTPdO9aoyn39Ozav6q2z1QyU42ceZ0hbGI8+VfPgtLVaNT2vJ+Ij8vWN7Px7VJ
RGUxGPLay8Xx92lpa18n0ZoyLOeDKYxeMhaSWqVnga7Wa5SKlZ3D5EFb2a4Klb6a3AoLluJm4FpD
QckGNeiv3CMB8/pXZDnbutDX6zJv6udrjID5LfcdfEDXin7tMcIdW2QvdsCP4crrgpsQLZoN/1ve
sTa3jRu/61eg1w+xp6ZC8C1dc1NZthM3tqNayl3m0lRDUpTNRq8TJTvur+/uAnxJoETpru10LuPY
EoldgNjFPoDd5YfLWzaghXYD+NvlgMcr+Ne67HQ9/ZJ7VzJk7dwUAY+96X00Zqy7WOtd8KfTgEeM
ZRvcgJ7hYO5y9/TI/jokL+G/pejvutCf/hv1p8v+HPO81F9nQb391v15GO8pAh/5Rn/dOv2hgbqE
NYaOaHnLsAcOxomUqQnr66xvl0975TYXrjLacViuF+Biztdo6hSl2yPu7gXLGE+7n8HrmD/LTXBE
9j3Ko1mEvAoGFPpOEftuEcZvZvNwmXxHHLuMSK77LFiXEF9imocwHkgAilh9RXdpSKZ06Cz2tndJ
BwUBWhYwQ7j63SvZ7O/Dwc/D5tWdDi7GXfQM0vIZJgf6IQsknR1QGveos85FT5/hgg4qoELan5Ly
Yb27nt4B5xhRwyrrthkst2yOP5N4gMUpsiVYP3pAGzVht31QV71PGiaomF+qUM0oAwcWrNiWB8yh
0Grf42e8E6Pm3OwFNSXr4kTAX+hJgZ9UL0wl5iwABoIAZbOeyaGjLSe0O8mPkjpDgpVoAlMt5gUw
g7wFWg8L30Ef4KzilXTG2WdwA+R2KwbRhGNXEvbLIdCjNF9ofBB0Fszj51FAwZFYvNxqGKVW6+FY
jAKa3Es7AhHmz2WH//DxUCwFYwaaZ03RxwDNgtEcbd7yYFWQRQMLAmw3Cl4RkWbIJ0/iwAOMR2QT
YEvaKSijs4rofF6Jjuw+WpPdOdqU30i4PSzJcLhUorZLqA0Fag9dVwVq2h+Ab2Ay4sa6Am3v9vKP
LFsgQuJd6OzCfAQ0FyY4A6MyVKs0GCsdDC8+p1UaDAYsKXCcY05AHivp60bGLviFE7s4VhCvviig
kRD5UhVE5pruqNqysqBN15qM0bXHW6yhhpKro5WxteenAXK1od3U6k6fk4/z50QrUonsYCIFJSI5
RxEpUBPJKBLJrCRSUEUkV9NDVdsKIslUTGt7mtVQkkhuTiSPq4i0EzqPopXAOwgUHEWgqEQg7ygC
RWoCWUUC2ZUEiqoINNK4oWpbQSBT9GZuT7EaSk6xnU+xo1xFu6DTeDCpXPavougYIvGShvD9Y4gk
cGwTySkSya0ikoBWEImbGvdUbSuIJEORja1proCSRDJzIlm6gki7oY0c2tiziuSDHkogo0SgUKUY
veN0rkC9TbdWkW4t3aygW0ljj1S2RaibZl3bQqDbHoxXHIxXyUTVer5yYp3S+PlRnO9U8W5L4/4X
RdsqPpLCnGR5oOLC3dBGDu3s4ULnKC70SpNlKojtEhfWJLZXwXm8yHm8itjeTmKX24algQdKu9JG
otcbeFgxcKM4cKNq4Bm0UYY2i9BmFfS49CgqSeCgF1H3UcZNXkA3UqCzDyEpoSvNTLFCx6goHLee
yygMJPr1AzE2BuJ5WWUP/LitxgHGKgxhrJRl9iFDsJRcYhXpjNqmYj4ktJWqNplhBeTdHridDzxS
CuHD5s7eJOK2Z1ocAk99TM5Ntw3uTauSfCRHFYooRbExX0XXOmqNdyrXIorS0iqg2GNAFVFYFZ6M
u3sUh7htbmneTM9Weby7581VzZvnZTlgKqegCMNzmNyI8bZNoBRml85QNDeoqsrb4HVSOMCkZwn8
2YhO1fHgbhojsuAF2tvs7QBaU5tvnNEJHB5BpZMLXgg7obiKCcXJenkPFEC8gcEiDKdHumyjX8/Y
IyVjj0t7RnsYe6Rk7HGRsfd5BiMlY5edi/2MXdeT4mZ508k2VfNG5krVvGUoyoxt5UxqiSdWdSsn
quwRlMVmqa1ZwG/k+A2zAv9x/lUN74a3NiYutA6euJZaIlj56rZ3kLkEbuXgZAVL25JiUfaA33+4
LZi1Xta3YLJKsINmNoP68Wrzaf38aX1daUvVBC4aLJRxtPLjWSIh8HjDsQBDUo035y0vyPEG9QZV
AbxjUOaOQfFfz1eb1l3J6TD38hVX8FUG7hTmpBK8zFc5sOtW8xU/iq+4ijW8vEdvFwn3Ah/JV1zF
Gq0cb6veoCqAD+arGt5vdjwnzzbpVJK0+s3d+052NiXDAzB2Xt8Hs1Giq6Ld+RG4z2vi7h6Bu1sT
98URuC9q4r48AvdlTdxXR+C+qon77RG439bE/e4I3O9y3PF8Ol1jKUGKDU6ji1C2tjHxaZZQnkTW
7LaTNsEMhXj25E/ikQgXwrj/8KXNJv6/XkS2SL/bv5bhZxhYVYzBE8PDdUZi/GP/vBC401gngch9
LgTzzKJnERcwxhp8IvyVQcNxUr/54zqobCyToXLEjcUiGYqmFLzS6/UxSR8juZqY7pUPN2/YT5Ma
qZHdNJsO01h3vnhZxhhuCdrG1uCXy+7no/lkPGdvY8x2W8Xszw/y018oxroZr35o9AY9RtGKWTBa
odfLi06X3XZBKGI0odkExYulLp/8ZTmcTl5j80UkjtCTYtADBfqkbJNGWxy9J9LGiKlXK9TJ8fR7
NpszilpfYXRYeduvgelhIHnBN6JinHl2/hkOJcFSBd4ZJrqUflIwTyBeYlBTcga9a6h1DaspRkaF
MGXYdDneUySRieTfwo08L6mxmC1g4cx6YmqQaRuSgcWE7IzZe/QTFkTRLK+Wq4RNHajCkfuXcunH
3fAwV+nBBH3c3zcaT8Kh4B7BcbBla8PgvhHGKtjjqD6M4xGM06rTT/Zcev5cOloDtWEBLJSw8HtU
gx4l2CiHrUuPwrhVFWR39u1s0wPndm+fTmmuzHyuzIo+S+zchqW+no2Yqy7BQOUHFtPNYGhlKPRG
ILShe7arU4AzCBhFDPM1XNuKW77usXhEMUnKcGmRtZEGTIM4SNPkN0KmV+FiiEnG0WyIUhLTNIeE
UIWVKrnsC8KmWDkNJOZqvQyUaARYisc5Y4ZjcGsrx37Q7bEoQdg4QbGzH5V7lqbwK1AFIDxr4Ghh
RH3L5fZWzgsgabN3GYKkaD2cFAcqpwX7o4+njY8Xvf0TWplsA9DaTbxSJ+zUQ6Hgqo93158wLP7m
Q7dzs8Ve971uCWDmT+E3wrAE2D6idPtZQpp1SnG5zS2Y9WhRoxVwYL1WGu7yaatJUhPp3VX/yWpi
DZvwa/jozzBlYhtSMTOfgFqb87FHrxcjwQy5iZprdvCy4wcsRfz7jfH53cTK/J5iTn4/sRv/Nwf9
G6GiaYSodVjobgpmHxazm4I5xwXrpuDucVG6Kbh3dHhuiqF1eFwuL4DrVZK5oj3fJ5Mr4IwDpXEB
jasa7qZsrWjP90nVCjjjAHlaQDFSDXVTOla05/vkYgWccaBEzNFwUzXcTflW0Z7vk2wVcMYBMq2A
oqXsukJCVcAZdWUTbZx0b/q4kyyNU5lVj6n+CyMJhpSVPkxRJ8qLIIWN/nl3+O764vKNLpokoT8b
+rORbAv+2XiGOfvw5w3aarta5TIiM9vAe8LDQAuHrFGBTrHfk5XdwlIK8OiiohneoU2gD+yk/9P1
h8HN+el2hS6sCQPG5UZBUifIyJVdkgz3hZ04+C6bxn2nd4Np61Spn62xtlqcMOMfmmmwv4LLixNp
yheN5Nnu5HfobJqw+dN4Iqq0FFA9PgtM83G6J7lY6BpuxCFmbknMuyFEVcT6AKOlPy233ixv8x8o
bFN3B6uRllxIsmzW1XKd4JHR1+gFqZw0nufLr/gBizNRgvvKny6o+uEby6FhkBv2xgCfY40+kvyu
N95HL2K31s/rLxX2Izv5VegMiwBi+ZhXoD9ar4rtzmlDc+K/wF3aIU4rEJwEycNpugGblinVm5ZM
MWQnU/+fwKOG5Z02QCJlFcbY9Bctq+ZZ6KjU5utLQFlX2d00y/jm7tPg3eX9rVSemQvlJ2ki8hDr
46U76vJaXvyH6kR/Hvysc3xzk8u6p40+PA428Qxbf82Bi3X5VOCVM8rNoj1Oljz6tPKyzXiU4CAS
qeQW7oxidSvUDx47wUqpbxiWP6NKVIG/HuF3jqnyp7iYfEY9dQiJJZDwHIlRQOLuRxIsMalVpKrK
DE+spbR5bbUG6fNxhs+WwFwMPt69HnR65b108OabTuPbI0jfx3CU24gU7frtXfda1OvKU6ar2uIu
PR4UiKyhlFBnmWNKN2brKRKaVyF5DENRnzKRGs11Qw5X45zjvmH8IWa3fU0KYk7nXG+B0v9vP4lR
hYT6ypL9EB3mBffXi2jZX0RAnMd1wMALb3NsjffxAu3/lW9ZgidlcUQJaFQDGpWA9c9t/ANObaCh
lqzmWLOjsVyFw3A6T2gv1Giz+0GXkrSf/a/yxUx9a6tReVXDXX2rSZLW0xNSUxy6YI0/3bA0zjVu
D7jVNnnbdNlH6DMrltByT7eQ+RN/Cfy1XiAGFA9Y5eURK1bILS02ewIObMRGiBq8zeADew2fsqKT
4skbYh1ppHeXbVkPWL4u6/q2M7y47nfOby6H7wb4p/jmrCa7WC8mlGDJoCWbRn6yXkYi/5PKoGZ7
zCHK9+xVW9h4Mn9obvYdz8MVlsFuWl5T1+gbiDvdMDUdfvhpdrqX4CvKRlOQyE/R5C9UVrQpTrTg
SgOJOxkuqK4E1d0RFXRoNFl8QyNexCBqrntPFiXs3vbA4sI6D+ISCB2sV4qCU0wTXZX3kyhUNCjW
xfh0dX+bF8egbcCGgKM7JdlVtZHtbG2tyeRadi+O0EQwHwzMgc61JF6t2YfOLTu5ht+nhZsK/L1O
971iq1wmBo/jZfTsixpnBW3m6Qb/BTSObjT539iPN527tCAWe+JNL9fdo1lCdujkqawOs5JgQJX1
chlReS9R3zGvTWgaMFPXoLcA7yNSJliCHgj9BGyJNNubVO6QFhCWtCZjgyUrWfrFc9GJ4Y7LQS1w
i1um7jiwhrQfTkyzZXqcu7ZhnDHNdE3P01vctk4bmLIu6lpMFzH0oQGvfmqCXcHCaLkS7z4DQ+xG
mAn5HfYKK9yOyMyhSrVkafjCHKLiM2CotNnYDrww8sEMG+uRZzue3XIca2yaXhTodjgaB3xsG4H3
qhFjyau7ORv0bln4GC+EUDxLi+LgGOGWFlCRtj8oxy315/9u+J2s+AVtxPuTh/kS2HHaRnOEZ49I
BY5QrGMJNTraj+nldagE0rJj69k6yQcTY7llsDHEOwxO8xpkWL6n8dMS9/7T93xizcXsvX4MqxRq
89nkRRZTBrfF07/u7kYUB3pNlZgf/EXeXcuy3lPRtSk8UhffkQewP/3pU/q2PTCvRfnnMzyexhvp
e/ng0ZqNfwPBzsbUbXsAAA==

--_002_ZzdhTsuRNk1YWg8pgoliath_--

