Return-Path: <linux-kernel+bounces-410584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F009CDD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2648B22DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE251B3937;
	Fri, 15 Nov 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iZ+yZkIH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S1Di9cwo"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6818FC84
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670553; cv=fail; b=L/yQ3Svqj7IoJtfBQ3cbqv870UG3FhL5hm3ruww0YdSVjLzHEtmr/CQjrU4gNgQmasSB3Tt59RBJi+n9Upuq8t7LJB/R3e/1ZbzVLM55m0jfz+v2UYTrATo2XNyPIV9Y5EHDJc1ENBwIFkoqJfFkNFalbok39hBR4ZLjjLJyoK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670553; c=relaxed/simple;
	bh=uSkbKAdeSXjxAa068EARdshLNlEF2O0+bJiOSFaibYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8f7vUBnzJA7XfndMtptyXF2gwQP6G32JLryfnQ9ogsJPr6U/M/E92iEJCMtDxeE1uqrK08sQn2U/O34NMh/l2gqQtluOyUMpFDHbAmbvbi+eSYjT6y+oZuluTpyNodltG+SionyFXtSM08v871AzR0MYVT7QWuddOAfvpqiwNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iZ+yZkIH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S1Di9cwo; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731670551; x=1763206551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=uSkbKAdeSXjxAa068EARdshLNlEF2O0+bJiOSFaibYE=;
  b=iZ+yZkIHygetEbDaQI6qHGkEiodJmbI2OCGSFcKNu9mEhWcII6IyCKNy
   EMWE8ZrwRUq/+FuFi6AXFlVzgTtY29f6Em0qn5KFK6lL2yfI93XhKHLhh
   AljA81EtgO/aHmYyTjIhBhgIMXu8Zt3G0x63sNxYP+eTroid/HDtwiPqz
   15zs01F2gaRwDsoY/UJ5uru3i+yXU2YslHOPLrgFqX4PL8Bo4zykL6sSE
   9QwZz5XG5l9z/0by/my8kxbhA6LGj54loRfEixbB1gVyJLHUZyiB2P4cv
   hf0eHRmzCgWMj3a09nwRCe1tv/h+1I3xRztzh4utCsOqH2gdEjU/jYmIP
   Q==;
X-CSE-ConnectionGUID: RpmBwcLBRa2e94nSVyp69A==
X-CSE-MsgGUID: i70byul5StCsevCG8CG+VA==
X-IronPort-AV: E=Sophos;i="6.12,156,1728921600"; 
   d="scan'208";a="31501564"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2024 19:35:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUVXtnG5PK+L8bMSJwE6TElOJW5KSHxrRJDxSEP3tJf/SkPMwpG5VRqbABPpIc7VmdzaSXbKgvBmgeuAZKl5+SB43MhrKSwklIHVFGeAOkXeOkxnahKxA+Evyh4sRNHkNmIkYYSPooEO47o4r3Q+vsfs8GR333oBgG3pTuov30XDXuqUyasSvVnNjgB8xRKaUhBPkwfYiar+cZOMXAuiYqOPDjWM/Z5S8rG5fKiynfjsiAQPNHU6cpxiLC6/sG7ToPKxkPuERVnO/Cair78IG3cfAbaSL8G2zjpGkseNwnp7rzeeqtl16ArR5VSYsgYrvjpOP9sF0eQu5oQnwEU5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHAjAMWFDA0GlTed78CPwQnGopD6J3RP3ybFZaCLg6E=;
 b=YE87DAIBqUZz2esIG62pceC1kl4F0MMpzBgajSLzEIBhXyGcpe1Fe5Wz6sM2qp4HpaJ/dnVf3uPW2eCpBKoFIRLEae/5Mbkk1ry4I0yaCdLhzHJe+6kvMDzKjKA2MAOX5uH2YWqGj0VcrrcGoF+kgQfm93Wxviw4nYF4JhmnSvFqTZI7Qwuncv+IGWH7rcFA697b82328qI5Xn2ZFpvMLP+VqjZS+AO5u60tLgo5T7i1YuXgoW1ePDJ2Tx8ac9Qnn0F+3auzpO5MCgw09spKcAecEsRwLC2TK2rK9y3NegqG0z2yf2XFiqxXJadog0HWh7IlSvOUTvBe0xYCKBfAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHAjAMWFDA0GlTed78CPwQnGopD6J3RP3ybFZaCLg6E=;
 b=S1Di9cwo3pzPxeDDGOtFbORH/jBX5tDPXIaGZeDk1LAMTd1Pd4vS8ZmUvI0212kZYajjO8j/GL2S3yXUMCt2m5QHwDXJGTqRBzvZRZokr+1wme/Yl3VtW/0eTAFgXyfVZbqcfgD0W9tyqleHR9y4+XF5zhXAMRBFsuR7+svqxrg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7353.namprd04.prod.outlook.com (2603:10b6:806:ea::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.20; Fri, 15 Nov 2024 11:35:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 11:35:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: "Daniel Walker (danielwa)" <danielwa@cisco.com>, Andy Shevchenko
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
Thread-Index:
 AQHbNeKxizzLej0qw02u6pHMIY1jfLK1ZTYAgAACnYCAAAitAIAACmiAgAAOz4CAAq+GAA==
Date: Fri, 15 Nov 2024 11:35:46 +0000
Message-ID: <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
In-Reply-To: <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7353:EE_
x-ms-office365-filtering-correlation-id: 0d89b65f-9dcc-4ab5-8535-08dd0569a570
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?enl5eTJlLzZyR20zd3R5S1EzRHh4cEpKQWVsNE8xRmV1YlZnMkk1RCs5WG5H?=
 =?utf-8?B?TlQva2xlRm5HeUFQWEljUzkrYWxsN0dLdy90MHJLcXFnZW1PUGlOdFlnZVJy?=
 =?utf-8?B?Sm1aN0tpQjloN0FYK3hNOTYwZjd0TjI0MWRtR1RidVY0UFU4S2FwMjRyZW5W?=
 =?utf-8?B?ZFJKSUlwQjdPZG42b0JwaDBIYnZIOEhvMGFiNVJDSDFZa01mSGNYQ05tSnpi?=
 =?utf-8?B?T2FlNW1saDkvb3VqMDNEYndOMjlLQmRZNisxU25vRUJsbUNtUkZaVjdqMk1u?=
 =?utf-8?B?TnhBL1NHRy93ZXA5VmhrYUVUWmNWMjJFS3lubG5LYlNPRTVzUFZyTVR1YW1O?=
 =?utf-8?B?b0VsWCtjWitRMVdlYkJuLzBxd2NLVVkySWpQM09LT2FZeXR4cGhZKzNRK1Y5?=
 =?utf-8?B?dEdxWlcxeTY1YjBHRmtoZE9OODBRYVlxMEkveHlVdGFwMzBZd2tlT1lsRnd3?=
 =?utf-8?B?WWUzZXR0ZithOGFPVmdlT0Q1ZDNxTlBiVktHU0dPcUZSbklwL3gxMTZTT2V6?=
 =?utf-8?B?Qk00d0dRTG9JSHdiN0wvSGxETnlyeFVkWTY1c0ZCZEVWN3lnN1NlN1RHLy9X?=
 =?utf-8?B?cGk5VTB0YWJhLy9jVVdVT2szSTlKSnlEdWRZSlNyMzhUMGwyRTF3eTZycEo3?=
 =?utf-8?B?MmQ4Yk1IMXBRWEIwcWhSNUVYWDZsRlJNUzN1ak9WVjFwZU02RTUyWFpxTnNO?=
 =?utf-8?B?SjQ3aGpDckhhR3ZCYVBwYXdsaDd1S2JkNWsrNnFZQXpXNVN1OFlNZDBMK3Fu?=
 =?utf-8?B?UzBzMktwTnVaeFdJTEd6a0RNUUNNeXBPVHdvT2QxUUJqR2F6NG1vZE9wZlV5?=
 =?utf-8?B?a2cxWitmZERORkJCTk5tQ2JqTWdGbWlGdU5DWi9LcTdLVzhTNHkxanB2TlNt?=
 =?utf-8?B?Y0ovZVU5czR1Y3IwL1RVOVZ6bTMxK3kxVWZ0bnhIaEthY05XSVBmNVdrMy9D?=
 =?utf-8?B?emU1aWs1b0VHekxhM0ZOMmxBSmZ4dlVMN0IyMlVJOHpKUjMyNzB1M01YM29k?=
 =?utf-8?B?a1ZCcFJ4UWhCOUlSOGZWL0k3b3diSVdCSW1BZHpxejB3Um4zaEtqQjJHMUVZ?=
 =?utf-8?B?cWNPTE5ncW44aHdXRTN4LzFLMk9Sa3NwT1UrdVR2MjRzZEpYd3I1OERlUDZp?=
 =?utf-8?B?TEZqTXd2WWw0OHZDYkZBZVAyeTdqNEtlMC96MGNuWHhNakg4YjdHTGpSNnRy?=
 =?utf-8?B?YTV1dVRHL0xqUzFHRzV0d3VGSEN5OGh3V3pFM2pqWks4d1h1czNYZUlscHl0?=
 =?utf-8?B?eUZBTWg4ZmRvcnhvSjM1Zkl6bkZVSUVTRXZ5YWplc1ByMjhnRkFHL25FZWx4?=
 =?utf-8?B?S0dMajNLNFpDeEsyYkk4V0hNZzhkUjRUZThCb1haQUZMcVloM00zaUpBU3ZD?=
 =?utf-8?B?T0szS1djMThSbGtPMzhXc3ZLUThCU0tRd1R6dDVJelo4NDBaM3NwNkxvQzBo?=
 =?utf-8?B?Y05aMEJuRkxNZFBrSElYcGp5VkRMOXpDTDE4UlljdVFlb1YrcEJWZlJ5SkRK?=
 =?utf-8?B?Q2hGYUxFVEppN0p1MUJUQ0VkTlhiekd0Wm1sSjR4aGQ5dDE0UkZ5ZXEzWm02?=
 =?utf-8?B?YU83Z2srSjl2U1VZSjdoeHJjNWpjbUN6MHJIMzBPTG1oVG9RU205SHZubHJO?=
 =?utf-8?B?Y3hFQkhQZGJhL09nb2xNOHh5RGQveUhGdGs4Zm40ZkF1VUpCaDh5RVdwRlo4?=
 =?utf-8?B?VGF4aklkeFpKM1Z6RXowOXVPV1NCM0RTbFdRRXUwQklvRm03QUtrSW9TS0hv?=
 =?utf-8?B?eFppUzJsZElVOEFvZ09Pa2QxOFlaWEQzanRFbUYrZE9KZU5taFA1cUpjWVNS?=
 =?utf-8?Q?usScXs9+Eqd/naJMl/T0avSVGiAv7MyfVqcgU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnRpOFVNa3dnUkN1UGZBcDBhQVFReCsrUDZhblB1TmFEc2NvL0cxb1kyOXRP?=
 =?utf-8?B?cXB5bXhjekppZ1AwQ0FWS2pDbDd5YWFVKzlWY1ZncktTb1R3NzZHL0dNQm5Y?=
 =?utf-8?B?dm14eGhMOTJ2eEoxT3Jyd2trTFMvZU44SlpLbVdhbWNjNVlqMkNIenJEaDlT?=
 =?utf-8?B?M3QweGczSmw4bVY4bk9WZHpWeW5waS9jQjZyL3p2UERCcmpjcFpzQzdCbG4x?=
 =?utf-8?B?MUFibEc3TG44Y1kwcXh2UE5MR3ZUS2ZrZ1ZaRGZnb2VRclRpN2dKRnFldmFE?=
 =?utf-8?B?OStCbUpvMEQ4cUdaQWZRL2ZvSmtJcjVJN2ZSaTZRR1UyZkd5R0pPWkpIZ2tV?=
 =?utf-8?B?NXFyeHAxVG1kTFk2VFh2eC8wM1pFTStxQ3hTQTFUQ2d5TzRFWmt0dGpJdnhs?=
 =?utf-8?B?V2pjWENMUXE4VzhjTmkvK1l5eHRYUnk0NXcrc3F5YzRSb216VVRaV0U3UElD?=
 =?utf-8?B?Ni9ZOXNNVTVBMFVZQXM4UUpFeVdrVWF6aFhweGRObTVPVmtIY0svazlxbDNZ?=
 =?utf-8?B?bEU1eWlWaHpVS2VLL3o0enlReWJvbUtZWUZCTm9PdzhsRkNVZnZhc2NzNjNJ?=
 =?utf-8?B?YWI4Z3g5d3hLTjRKM1VIRDdNbnhUMHJWanZFMHZ0TFJLQlRXaHRXeE0yd3Zh?=
 =?utf-8?B?OHN2RFJEVGlYZFVRT0dodnVORU1Va1MwWFQwYk1TTUtOS3FrRFBXRHByNFlu?=
 =?utf-8?B?R2NYSlZOb0FNWFRwNnpMTXVtNnRMUDRKcmtRbXoxTy9ybGJjd2tBMGFTR0Mv?=
 =?utf-8?B?NUVEMUxvVEU1WVVqN05OZW5SZTV6VzJvRzhRRTk2UzRteVBYZ0pYZjBqdWJH?=
 =?utf-8?B?c0NVUHR4d3MwM3oyOG9IVlpMbjZMcXFmc2RsaTNOOFpnamRvOXplZnN1SjQ5?=
 =?utf-8?B?T1pCZndUVk9OZU54VU0yV3d0bXZOVDJ3UmlVb0JVbUhmY09MWi9uUTlDZHRH?=
 =?utf-8?B?NEVKM1VKdmd4RHVPR2FCdm82WDNUdmV2WTA3UVA5S3Axd2dTdWhKYTlmZnVX?=
 =?utf-8?B?dHRGYjl2V1FHZUFVR3RSYWZyNDVrQVpTVkJxR1k3NGN4OEJGUjQ4SmJ1OWVW?=
 =?utf-8?B?TGNGemllYUkvZmxhcmNQWTVTKzRYYitpQ2c4bW9NYkZYQXgvUXovSVhYVDZK?=
 =?utf-8?B?Q0RDSkh1VGNGRDd3QkZmSmhtZ25MQ0N0QVlTc3FiRm4xZ1BxOGhTc1NYZHNF?=
 =?utf-8?B?T3FydzFJZVRCYXpSa2dPMVJoOTdzODBRMm9OSnV4MkJMcVNZcThzZW1rMENm?=
 =?utf-8?B?d2UxUkR1QVhjWmJ4UUZiRElFWFlsbDVtNjVEcUVmSlp4dXFqOTZQMTdhZWJq?=
 =?utf-8?B?Zklua1BUL2MyUEFBemF2MEJDbnpjODJMWHFKYXpGN1UrTzVvSERPRndtWWw5?=
 =?utf-8?B?ekdsWGtXdWpPWklUaGxxUnJxeW9OMFFBcXpqd0ZmTkwvay9JZzQzTE1vSlU2?=
 =?utf-8?B?WGxFNVdlL0krcy9DclBKVGxiVWJyWWJpYnFFWkE3MG5ERGJQaWtnaXBSL0kz?=
 =?utf-8?B?b0NZR0d3RGZST0ZWVFhTZCtYNjFlOE1lSStvMVlxZG10M3RPYTJlOGVFL2Qr?=
 =?utf-8?B?TTVPSDNlY1JxR2FsWDZaN3lxOHU4akl6WXdMU3pQS1N2R205U1RvT1hqQTJl?=
 =?utf-8?B?Vk1HQnRRbGV6ZnpQY2YxZGQ0WlBudVAyZ3A2VUE1QyttdzZ0TEc1MWJMc2N5?=
 =?utf-8?B?Q1pucHE1bGF4eWxtZnNhTis5UGp6SjZDeDBwSzRWaXc1YzZjK2FmNjVNWGZm?=
 =?utf-8?B?S3NwcG9rOG1PMjlzdEtxOFU0cGdESUdpaXQ3N0x3bWJEbEM1bXFXSjhlaWp2?=
 =?utf-8?B?VVc1UHgvSU9GaEtNT3BUa2Y2MGlrYmludTBGMUU0OXprZUYxRE4zNWpqY2NU?=
 =?utf-8?B?clNTSU5WSHdlUi9JMGxvdFZmOVAxM21rTVI4RmhKSllkby9GY3NxMERla2lY?=
 =?utf-8?B?SmhKMnRhVUQyaVB4U0lzYXpFRnA3SWo5YXRBVEtKMUF5enYra1dML1FGd3h4?=
 =?utf-8?B?eHFuZzBOazFERzI0WjhaUHdGWWJZQUFaQkRoYVhtT1NYVnRjUHRFKzJKYnJk?=
 =?utf-8?B?WERBNzNYZjhqcVhtdWpQOUpuV3FjRG0veGVEL3NGc3pQYWdIUTRGY3kzSlU3?=
 =?utf-8?B?OVZJVVE1NkhEcTduUWw5UGxuMEpNaFE1YXdnS1NsMExVb3pDYmg4aDk4RVRs?=
 =?utf-8?Q?t4pcFJR/3tGq8VInkpFccJQ=3D?=
Content-Type: multipart/mixed;
	boundary="_002_wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7lipdvth_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JXJap1G2l6DuyFdq4R4Y5m7wQJi8WCJvXwSQDe7zgOEcrzpDyeTbZk7KFTLS8M598wT6TD0XuRjq6RR+ftPfnX6MeudeVex1bu4bPk4ToaMdLhlubX7gxKsnSV3Je2q0/BaDfjCzl4TObjGw3xj7OUB+l7uk16+wj6h0LgBojtP4l6PJexSWOeXdoYOKBWT8BE19ggBhY/9yiuwLjxNgAuvnxmL3Dqn6Ma2oT0HyLmFdZb9vwcv0i2WQvj2FfIRLl6Yevdndl4IoO/EKYOMwDWdrgYaobEzhpQAvWatIUhsd3kiJxXeu2hNFak8jOFuzsDU38LFfPRq/H0TLjET7RPBGZzMLSf+NfRbFYSGS9x6f3fjgB4FzwZU/0QkAxdjpnHVepJIE8omek4an6xCb57KCwFaPG9OTAxIYOCNK996UzDsSNH32F4tiVSiVy20CsB8znvKjBmWBoxy4Sq8Q4z5OyuC8PCihMageL0hzb98inGKQvHafEYZfWDyjGK9LkDaVsY8nMJ5EMojIAfm0u2pAWkV9Aiyp9j0z/u32W4xCO9mbkuYc87SbwPDwFWbGymg9xKQZIUf10qmYCw0j0/I56XCMAcbMGYcvT0dRJg60bjtKHzqWw3f60reSIkHD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d89b65f-9dcc-4ab5-8535-08dd0569a570
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 11:35:46.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AU39To0vMDXambjzBGRNhDPAiRDnTDGls8KHcu8bz96i2jlGw6n7Ea6bPZQSdbe0m/otDMbfIqzfs9Ct9ATk5GzqmO1FL2dPN5QBI8tqOj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7353

--_002_wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7lipdvth_
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D380697552E8B4EA391F1CEE002A281@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gTm92IDEzLCAyMDI0IC8gMTk6MzQsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gT24gMTMtTm92LTI0IDY6NDEgUE0sIERhbmllbCBXYWxrZXIgKGRhbmllbHdhKSB3cm90ZToN
Cj4gPiBPbiBXZWQsIE5vdiAxMywgMjAyNCBhdCAwNjowNDo0NFBNICswMTAwLCBIYW5zIGRlIEdv
ZWRlIHdyb3RlOg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gT24gMTMtTm92LTI0IDU6MzMgUE0sIEhh
bnMgZGUgR29lZGUgd3JvdGU6DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBPbiAxMy1Ob3YtMjQg
NToyNCBQTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNClsuLi5dDQo+ID4+PiBJdCBwcm9iYWJseSBo
YXMgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlc2UgMiBtZXNzYWdlczoNCj4gPj4+DQo+ID4+PiBw
Y2kgMDAwMDowMDoxZi4xOiBCQVIgMCBbbWVtIDB4ZmQwMDAwMDAtMHhmZGZmZmZmZiA2NGJpdF06
IGNhbid0IGNsYWltOyBubyBjb21wYXRpYmxlIGJyaWRnZSB3aW5kb3cNCj4gPj4+IHBjaSAwMDAw
OjAwOjFmLjE6IEJBUiAwIFttZW0gMHgyODAwMDAwMDAtMHgyODBmZmZmZmYgNjRiaXRdOiBhc3Np
Z25lZA0KPiA+Pj4NCj4gPj4+IEknbSBndWVzc2luZyB0aGF0IHRoaXMgcmUtYXNzaWdubWVudCBp
cyBtZXNzaW5nIHVwDQo+ID4+PiB0aGUgcDJzYiBCQVIgY2FjaGluZywgYWZ0ZXIgd2hpY2ggdGhp
bmdzIGdvIHdyb25nLg0KPiA+Pg0KPiA+PiBIbW0sIGJ1dCB0aGF0IHNob3VsZCBiZSBmaXhlZCBi
eSAyYzYzNzBlNjYwNzYgKCJwbGF0Zm9ybS94ODY6IHAyc2I6IERvbid0IGluaXQgdW50aWwgdW5h
c3NpZ25lZCByZXNvdXJjZXMgaGF2ZSBiZWVuIGFzc2lnbmVkIikNCj4gPj4NCj4gPj4gYW5kIHlv
dSBhcmUgc2VlaW5nIHRoaXMgd2l0aCA2LjEyLCB3aGljaCBoYXMgdGhhdC4NCj4gPj4NCj4gPj4g
Q2FuIHlvdSB0cnkgYWRkaW5nIGEgcHJfaW5mbygpIHRvIHRoZSB0b3Agb2YgcDJzYl9jYWNoZV9y
ZXNvdXJjZXMoKQ0KPiA+PiB3aXRoIDYuMTIgYW5kIHRoZW4gY29sbGVjIGEgbmV3IGRtZXNnID8N
Cj4gPj4NCj4gPj4gSWYgdGhhdCBwcl9pbmZvKCkgaXMgZG9uZSBhZnRlciB0aGU6DQo+ID4+DQo+
ID4+IHBjaSAwMDAwOjAwOjFmLjE6IEJBUiAwIFttZW0gMHgyODAwMDAwMDAtMHgyODBmZmZmZmYg
NjRiaXRdOiBhc3NpZ25lZA0KPiA+Pg0KPiA+PiBtZXNzYWdlIHRoZW4gdGhhdCBkb2VzIG5vdCBl
eHBsYWluIHRoaW5ncy4NCj4gPj4NCj4gPiANCj4gPiBJIGhhdmVuJ3QgdGVzdGluZyBhZGRpbmcg
YSBwcl9pbmZvKCkgYnV0IHRoZSBtZXNzYWdlcyBzZWVtIHRvIGhhcHBlbiBpbiB0aGUgc2FtZQ0K
PiA+IG9yZGVyIGluIGJvdGggd29ya2luZyBhbmQgbm9uLXdvcmtpbmcgY2FzZXMuDQo+ID4gDQo+
ID4gRG9lcyB0aGF0IG1hdHRlcj8NCj4gDQo+IFRoZSB3b3JraW5nIGNhc2UgZG9lcyBub3QgZG8g
dGhlIGJhciBjYWNoaW5nLCB3ZSB3YW50IHRvIGtub3cgaWYgdGhlDQo+IGJhciBjYWNoaW5nIGlu
IHRoZSBub24gd29ya2luZyBjYXNlIGhhcHBlbnMgYmVmb3JlIG9yIGFmdGVyIHRoZSBhc3NpZ25t
ZW50Og0KPiANCj4gcGNpIDAwMDA6MDA6MWYuMTogQkFSIDAgW21lbSAweDI4MDAwMDAwMC0weDI4
MGZmZmZmZiA2NGJpdF06IGFzc2lnbmVkDQo+IA0KPiBJdCBzaG91bGQgaGFwcGVuIGFmdGVyIHRo
ZSBhc3NpZ25tZW50Lg0KDQpIZWxsbyBEYW5pZWwsDQoNCkl0J3MgbXkgc29ycm93IHRoYXQgdGhl
IGNoYW5nZSBjYXVzZSB0aGlzIHRyb3VibGUuIEkgaGF2ZSBjcmVhdGVkIGEgZGVidWcgcGF0Y2gN
CmZvciB0aGUga2VybmVsIGFuZCBhdHRhY2hlZCB0byB0aGlzIGUtbWFpbC4gSXQgYWRkcyBzb21l
IHByX2luZm8oKSB0byBhbnN3ZXINCnRoZSBxdWVzdGlvbiBmcm9tIEhhbnMuIEl0IHdpbGwgYWxz
byBzaG93IHVzIGEgYml0IG1vcmUgdGhpbmdzLiBDb3VsZCB5b3UgdHJ5IGl0DQpvbiB5b3VyIHN5
c3RlbT8gSXQgc2hvdWxkIGFwcGx5IHRvIHY2LjEyLXJjWCBrZXJuZWxzIHdpdGhvdXQgY29uZmxp
Y3RzLg0KDQo=

--_002_wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7lipdvth_
Content-Type: text/plain; name="p2sb_debug.patch"
Content-Description: p2sb_debug.patch
Content-Disposition: attachment; filename="p2sb_debug.patch"; size=1769;
	creation-date="Fri, 15 Nov 2024 11:35:45 GMT";
	modification-date="Fri, 15 Nov 2024 11:35:45 GMT"
Content-ID: <9C1A90F75D99F6448DBF5A022CD93B05@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Ayc2IuYyBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L3Ayc2IuYw0KaW5kZXggMzFmMzgzMDliMzg5Li5lOTAzOGU4ZWJjODcgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wMnNiLmMNCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3Ayc2IuYw0KQEAgLTg5LDYgKzg5LDEyIEBAIHN0YXRpYyB2b2lkIHAyc2Jfc2Nhbl9hbmRf
Y2FjaGVfZGV2Zm4oc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuKQ0KIAkJ
cmV0dXJuOw0KIA0KIAlwMnNiX3JlYWRfYmFyMChwZGV2LCAmY2FjaGUtPnJlcyk7DQorDQorCXBy
X2luZm8oIiVzOiBkZXZmbj0leC4leFxuIiwgX19mdW5jX18sDQorCQlQQ0lfU0xPVChkZXZmbiks
IFBDSV9GVU5DKGRldmZuKSk7DQorCXByX2luZm8oIiVzOiAlbGx4LSVsbHg6ICVseFxuIiwgX19m
dW5jX18sDQorCQljYWNoZS0+cmVzLnN0YXJ0LCBjYWNoZS0+cmVzLmVuZCwgY2FjaGUtPnJlcy5m
bGFncyk7DQorDQogCWNhY2hlLT5idXNfZGV2X2lkID0gYnVzLT5kZXYuaWQ7DQogDQogCXBjaV9z
dG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZShwZGV2KTsNCkBAIC0xMzAsNiArMTM2LDggQEAgc3Rh
dGljIGludCBwMnNiX2NhY2hlX3Jlc291cmNlcyh2b2lkKQ0KIAl1MTYgY2xhc3M7DQogCWludCBy
ZXQ7DQogDQorCXByX2luZm8oIiVzXG4iLCBfX2Z1bmNfXyk7DQorDQogCS8qIEdldCBkZXZmbiBm
b3IgUDJTQiBkZXZpY2UgaXRzZWxmICovDQogCXAyc2JfZ2V0X2RldmZuKCZkZXZmbl9wMnNiKTsN
CiANCkBAIC0xNTcsNiArMTY1LDkgQEAgc3RhdGljIGludCBwMnNiX2NhY2hlX3Jlc291cmNlcyh2
b2lkKQ0KIAkgKiBVbmhpZGUgdGhlIFAyU0IgZGV2aWNlIGhlcmUsIGlmIG5lZWRlZC4NCiAJICov
DQogCXBjaV9idXNfcmVhZF9jb25maWdfZHdvcmQoYnVzLCBkZXZmbl9wMnNiLCBQMlNCQywgJnZh
bHVlKTsNCisNCisJcHJfaW5mbygiJXM6IFAyU0JDX0hJREU9JWx1XG4iLCBfX2Z1bmNfXywgdmFs
dWUgJiBQMlNCQ19ISURFKTsNCisNCiAJaWYgKHZhbHVlICYgUDJTQkNfSElERSkNCiAJCXBjaV9i
dXNfd3JpdGVfY29uZmlnX2R3b3JkKGJ1cywgZGV2Zm5fcDJzYiwgUDJTQkMsIDApOw0KIA0KQEAg
LTE4OSw2ICsyMDAsOCBAQCBpbnQgcDJzYl9iYXIoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWdu
ZWQgaW50IGRldmZuLCBzdHJ1Y3QgcmVzb3VyY2UgKm1lbSkNCiB7DQogCXN0cnVjdCBwMnNiX3Jl
c19jYWNoZSAqY2FjaGU7DQogDQorCXByX2luZm8oIiVzXG4iLCBfX2Z1bmNfXyk7DQorDQogCWJ1
cyA9IHAyc2JfZ2V0X2J1cyhidXMpOw0KIAlpZiAoIWJ1cykNCiAJCXJldHVybiAtRU5PREVWOw0K
QEAgLTIwNCw2ICsyMTcsMTIgQEAgaW50IHAyc2JfYmFyKHN0cnVjdCBwY2lfYnVzICpidXMsIHVu
c2lnbmVkIGludCBkZXZmbiwgc3RydWN0IHJlc291cmNlICptZW0pDQogCQlyZXR1cm4gLUVOT0VO
VDsNCiANCiAJbWVtY3B5KG1lbSwgJmNhY2hlLT5yZXMsIHNpemVvZigqbWVtKSk7DQorDQorCXBy
X2luZm8oIiVzOiBkZXZmbj0leC4leFxuIiwgX19mdW5jX18sDQorCQlQQ0lfU0xPVChkZXZmbiks
IFBDSV9GVU5DKGRldmZuKSk7DQorCXByX2luZm8oIiVzOiAlbGx4LSVsbHg6ICVseFxuIiwgX19m
dW5jX18sDQorCQljYWNoZS0+cmVzLnN0YXJ0LCBjYWNoZS0+cmVzLmVuZCwgY2FjaGUtPnJlcy5m
bGFncyk7DQorDQogCXJldHVybiAwOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChwMnNiX2Jhcik7
DQo=

--_002_wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7lipdvth_--

