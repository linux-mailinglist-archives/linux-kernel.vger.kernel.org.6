Return-Path: <linux-kernel+bounces-293872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6D958604
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B1728577B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E118E768;
	Tue, 20 Aug 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVdSHmV+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7F18E048;
	Tue, 20 Aug 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154187; cv=fail; b=ktwV66kE39viY3iya93spdOg9veTKHCGCBIdgWcn9Pv5fu5VbcngCtvbfpa2Nm1B8xbrRo8s9/LAeQJUBC66QWDEtA09DePyk68LjXk23NZ8FJ08/MB79oq26Fv30PcZIWtjxEk6jODwJ3PT1rDmDhPH6u+CLFOLEqrIl3PXCkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154187; c=relaxed/simple;
	bh=7cGzdOmHjQqRxlSj8CZNyXgwtme1GlL3azp+zTwfSNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BUhlJ4wQwc/R0dl8xKh2xxEqlu78OhtDdUiPkkr7MIjSqIsGyfOJwWOf/tLkHQcqXiUTcrRE7Tb72irA1JDiswRRLs0UNZk5fVwPmqLhrgTMUfZy2jOMJREd7HEKBhht1pmFhEbU3wxj9vC1KBl83GJ5EYERUWaf4Ksflh1jfrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVdSHmV+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724154185; x=1755690185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7cGzdOmHjQqRxlSj8CZNyXgwtme1GlL3azp+zTwfSNo=;
  b=ZVdSHmV+0C/eJ+QDrAxHv5dRPBHn7XMVBQNxSz4ESwQmfn494RUcXkhZ
   hLBEeZXmPDFQvih+6mtFy2XnL3+ymczJcxGFGPZs8+DJoJoLkcKT6AgK1
   x0SFYSD9lJ2p3G4BiZR6LuKvQ0wHKn/grj5GkyJ4s2mzPO6Ienk+Hr5Pz
   BtHJPCo46+P0tH01AAwB816gOWjqZVYDdD8GSxFW1YwroZUOcGcYO66X/
   iJduUSEDBsqAQDaDqcjb8/SmGIpdwB6JeN+Mh4xkBbaTrT5vWL3tjPEko
   uQMPmJgbHtshGVgAHQsCju/bC0w3cI74djgKb6BvB+NYnihjLlznlm/0W
   Q==;
X-CSE-ConnectionGUID: uT2OKjGZRSOpt4ckXjYIRg==
X-CSE-MsgGUID: IQ0iVxgxRD6MgT3AnDGsnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22414810"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22414810"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:43:04 -0700
X-CSE-ConnectionGUID: d4RKrq5RRvavbI6qsyEByA==
X-CSE-MsgGUID: pQlR6HwOT2ujdIwY7gRKbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="98174195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:43:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:43:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:43:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:43:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNz+L+Lmjh7ZBR5DqGdXW49FrvYJMz3c97FisfjkJvKW1Es3JRkYy4EQCn+b2W66nNsBil13l6zOGM5ZfpRwrGlgIPDv3fBNJZNcPccVB6rOUWU/U8TWaHPZCmi1Y9NmD+lWm4oeoD6SiLreaIgb75llsB9S9aZjLZbRkP/Jc6BJ9b5M3KmsqMPqpfg8l3pFziYxvQENZ4rGVP/Q1zqw7wnQSwNhw3F6KhlwCcYQnldIm+zRdNWN8ad+08zP4Z47CIskMhiblJzhavAQGOecXh7Aa4+FCE4yxlOaVIQQJBscaVM7HbNuSNbIhZHZlqWjZFPlL5nfdmhbO+Hks3sRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STQUrBdMvOVzLqZsTAKo5nZPVO1ZQoW3cdbszknUaD0=;
 b=Ra0MD2A7Ca2oK2l+R45d7DPSdYRuEz3yaZnqOxCX8K9kul888jF8qrAjAAp/20cWjLsJmNIUOorUuJP3peRWx90fmOf99LUOcLwgZVkWrJ/TFfPpJbeWJ5rwsENM5zNIxGnzAofk1wS9dt/r2OA2eyQ7eDV3J80/xInzBqVL05JXi1y4/jGNToZj3ttGmXJPIUZRg0ihrmXJBiZvAZ5c7aXxWC6aiH1XgQwk50Bk8Lc81EGnjFgLrGgP+TUB2HcTBVLyBf4Gn1byjO4hcjKpHT+ZFkWb+v9Uk3gbzVPFngZBENEPE5xERZkP2Xi17LeZxdrJzkQs0lvk3EvnfrfTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:43:00 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:43:00 +0000
From: "Mohan, Subramanian" <subramanian.mohan@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "giometti@enneenne.com"
	<giometti@enneenne.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "N, Pandith" <pandith.n@intel.com>, "T R,
 Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v11 0/3] Add support for Intel PPS Generator
Thread-Topic: [PATCH v11 0/3] Add support for Intel PPS Generator
Thread-Index: AQHa8uDaTiNlAyWyY0ugM+v+TqfJtLIwA8sggAABUVA=
Date: Tue, 20 Aug 2024 11:43:00 +0000
Message-ID: <PH7PR11MB586263A4C69967C8B374C543F78D2@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20240820091035.71288-1-subramanian.mohan@intel.com>
 <DS0PR11MB763251A3C730BEFAC4B58FD1E18D2@DS0PR11MB7632.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB763251A3C730BEFAC4B58FD1E18D2@DS0PR11MB7632.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_|MN2PR11MB4695:EE_
x-ms-office365-filtering-correlation-id: ffd99679-83b4-42bf-cb6b-08dcc10d3e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?W9+aJTX3Q/XrUzHx2+HofQtZ8Q4oPOYPNx1aqzxs1qgugk93cNWE0iHEScGY?=
 =?us-ascii?Q?QWouzmqAk/I+tlIdjWPE2niGWR9SpXth7VxKc5RKxAH/9Byp6qUZgTANm0On?=
 =?us-ascii?Q?0PpMXSiLSZoTZvm77cLFYnFq1vBbKqkvjHXwA6YXjf12kecBf32Ioh9Ea9l5?=
 =?us-ascii?Q?N4Zuw81uTZh6/6c0+phCnwKEgSaqWfM5JZzEXqMly7GHWj5t+vczy6gTNzr2?=
 =?us-ascii?Q?0pkTkfUuCvJcgSiGIl8E8b15J2LcGqzDKcs6WU7NSE4AxqgETGDrnq+6ua8l?=
 =?us-ascii?Q?9g6WTRiL8xuX9+mrAt7Jkxv93VP5JsfaJpK4hFQw78zbgqMnA8MC3Iqw6a2C?=
 =?us-ascii?Q?QSqoWdC9ZQwFwhuoRzbS7BvekmW86OFE4BN3xTcQAIAwW8AiiNgV9D5Kz3lm?=
 =?us-ascii?Q?2hyW0sUPIvQD+1my8+KHdsDv2jds5GmEour9lTi04aJq31HWdQVbsj3F37TL?=
 =?us-ascii?Q?PTN/GsLeedW7amAd3OGuAzVwRTcaWq87CgMV50l1oWuCbolIgNDrUmhEqQcl?=
 =?us-ascii?Q?5ryFD1ajZZQNjD8rPh7awgvlX5e2sZh+7hikxudKvNIJ6pSlzKxsmqxxzKSl?=
 =?us-ascii?Q?JG9VB/FHCcbJSHQkOWUsw/wWcT328DbwT0FkUVaGSJ41m4VSjsHjc0LKg9Bc?=
 =?us-ascii?Q?irI2vPgkbKzCg4/xR9K1YJwEUN/dIydsPWYSOH4l4KBgIihB7EapIpCFtzal?=
 =?us-ascii?Q?pIY0SDjzNT2+g4wWGxRvm1LNHTXHa1maW3TGe1/Ht8tjQjM0S+5piVfxRqGI?=
 =?us-ascii?Q?eOQlOpTEuWulD4dRUmNiclYXcI5/dpDtJIfZ65PYgB5vvVkWveJcs4cNTfQY?=
 =?us-ascii?Q?2FM5rRIsQLG6TmYyVy5ZefnAB9sen0fefmgRWydqbjIjTZwZU1Bsn5hrhjSL?=
 =?us-ascii?Q?JMDS6ToyhyQJNcdT8qnSF1Drdnloh91TOx4jnN7JZo/QhnU3/xKJ5+iYbVCQ?=
 =?us-ascii?Q?pWjR1OAbTdwN5FhqfjRW0gmj7fkB117A2np/A1fWBN/XJDX3KkRch2VyjQzX?=
 =?us-ascii?Q?dWkMfw68zLehnMXVCeRjHD6qXV/d9/6DeKVW7DCPUvAKWOvHwAibsGOk20Kp?=
 =?us-ascii?Q?A6QUyl2cH4W3ZVlpcF37t7bJZrrz1dbaeoq21V31xupcSZiJJ9I2VCT7bgxx?=
 =?us-ascii?Q?xvnj9MfFQy+gPav+pM+Bk0/90Gq1TrmwJ6eyIrXeMt7vtsrFzVTpGmmxkqU6?=
 =?us-ascii?Q?2ZHuSqKAY4xJFicgDPjApeCrc9AzjlF03l+weMaBxWVB3hL4R4xcrNHVSVK8?=
 =?us-ascii?Q?NVdowJYO4hi+A5zzsjNe6Hl63ft1fKyeIEL58r7DmosN5IHGIAefe7H++xWh?=
 =?us-ascii?Q?4tcSkqRzf5BnCb/GNeQA+d3PaL8p2BeMCQNljwunXDYJoGGNRsueZC49MTN/?=
 =?us-ascii?Q?rkzCmPg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BtRfySr7YhvsqDxMcVLLDbCxLO8QXySqxFkfb7Wozk51Ra2iSMGMmK1J9xA3?=
 =?us-ascii?Q?nXoia1SqOaI2d30Sx0SLUAi9r19DObbm71RT9tThBJGJ4apBAXnNbOxZyczd?=
 =?us-ascii?Q?FMGRvFcL7mNDbQj8HJMl2oGRm/D8I8WkjiWknLYrV5qcLSDPa+1a1xgeu54+?=
 =?us-ascii?Q?UCJZQh6jV+qJMC8hoAckGQ/OljTFXvo1N3vS6rMuc9xp48Iv55oa2mh27wTv?=
 =?us-ascii?Q?xN/YGXIBDqMQcdpa5GbntVk2PzYomePO/XubxZ704KZtcaNPIj7xRZ2f5Hf+?=
 =?us-ascii?Q?39qrLGGAmF1PtqO7xb1ezGDbIzq5gN4uf+LljdWu2qxRmFT92zR4q4taEUpj?=
 =?us-ascii?Q?ZCrP6GH7i6Ns4RCqGiQ3++1003VgWYZys8oh37Fwj2HeCWVCQY14akF2kjqe?=
 =?us-ascii?Q?hmXmUXoEJB2TGQ1GhLrWJSdC1jW+A+Djw1AW750vcuhIcz6OawUTKDbCN+Lt?=
 =?us-ascii?Q?qU7rhClaRPuPrqe77eclhMkIgjIui9psr6IwSsaKvrvzhqluCGhnSP1o13Ic?=
 =?us-ascii?Q?IopLCrQ3CL/uXZTEbvedEe0/7l7RtqBXQ0OMFAlE2Z35MNwQzoNz7W0zJ5x3?=
 =?us-ascii?Q?JWqhyu85UWEZ/JwcVnZl9to8V8XCLPLrlCj5EUztXq0FVSl72SQAGSN3/N8/?=
 =?us-ascii?Q?YOhAeX8NMMNsK1LtSXZ+RkPpAfiNsJe+vRJrFPd/pM3kr17ts3x8T8HQYxTn?=
 =?us-ascii?Q?otkGyjmtIsh5HnD890vlJtARIqPNSf4eUFjF62JMwUWk/GdOwXAwNZOfPLs1?=
 =?us-ascii?Q?0pX9ykAzeujfpG+u7YvORlM0ZYLpmNpYvNf3oNDm5hTSlizs4abZ5QSozYJZ?=
 =?us-ascii?Q?9fXJM39ONjsuuuGW2JwZ5x9Z1gV6bEYf6+jVvbaJFPj/pPRKLdDjksVMzO7P?=
 =?us-ascii?Q?qA8Zdywyjzu2WKKs89UJ2R0bALbkSWjOYNOIeflzDMjyWEgikBAM1CiBtLi0?=
 =?us-ascii?Q?Ecl06PWNGHSBaLGv+da7hrlGRBTBQpS+3qBZkwhRaA0sy+awJaLf9FCQCNQh?=
 =?us-ascii?Q?RirJyZ/mOgwF99D1aNzov3QICs8UG8Z4gcjQ3hhgDF7pukKOC2goeaT+oZgS?=
 =?us-ascii?Q?y7P96DB6qj3IA6/pRIfXLWHX9+a9m1ykq6bTPSZzHNEkSXDXGdhiSjTPt93d?=
 =?us-ascii?Q?aHN0/qh7sbhoS3f39XtXN6XdKpx6ryExuBD1wbxyEXJg2C/eeHs5WMO2K6J9?=
 =?us-ascii?Q?+CQ/kE/1/RaNrwfHkQAb+ZYNQwC6grTbpSG7m40v0WnIu42KBvnWfPr1avXI?=
 =?us-ascii?Q?/RRBR/MTbUyidUT74+YHw5qsSPNlkJK+YP55HeNtMPILfJEc+BaHqKWooAXi?=
 =?us-ascii?Q?ba075/3PxTAirmcpzk4Z05Isbx7xQd0ekkCL1G+PZMOiKuTkFv6MyY0h9L6u?=
 =?us-ascii?Q?fm923fi1GW31q5QHoA1tGntZQRf4Cxdmz6ylJuGFI+3iYM2ol66165K8F9ll?=
 =?us-ascii?Q?FBF8ybhrNX6uhbqS/vBysTOECULsiMct8KzyNPnWFDtXQgswFhzo0EboJMaM?=
 =?us-ascii?Q?cuYAqCQAlTSIF/GJtOZax5dUNaC1pYheQcJQymYsSVDv5EntMer0WZLp03m9?=
 =?us-ascii?Q?fgOx30elX/E72skw92QJFP7DbhZ5w/7CcWjJ6IDa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd99679-83b4-42bf-cb6b-08dcc10d3e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 11:43:00.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VgMRRsXzjVKLE17qLrJvFHRltXHyhdEO1fQ7/O9Cii1RXC+gglnMU786knlrxumViJ5xZnDUrMHAbC1ih8Hm3LefRsdxan/QRJnLaJJiPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com

Hi All,=20

Kindly ignore the v11 patch series, new v12 version will be sent accordingl=
y.
Sorry for inconvenience.

Thanks,
Subramanian Mohan

> -----Original Message-----
> From: Mohan, Subramanian <subramanian.mohan@intel.com>
> Sent: Tuesday, August 20, 2024 2:41 PM
> To: tglx@linutronix.de; giometti@enneenne.com; corbet@lwn.net; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; andriy.shevchenko@linux.intel.com; Dong,
> Eddie <eddie.dong@intel.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; N, Pandith <pandith.n@intel.com>; T R,
> Thejesh Reddy <thejesh.reddy.t.r@intel.com>
> Subject: [PATCH v11 0/3] Add support for Intel PPS Generator
>=20
> From: Subramanian Mohan <subramanian.mohan@intel.com>
>=20
> The goal of the PPS (Pulse Per Second) hardware/software is to generate a
> signal from the system on a wire so that some third-party hardware can
> observe that signal and judge how close the system's time is to another
> system or piece of hardware.
>=20
> Existing methods (like parallel ports) require software to flip a bit at =
just the
> right time to create a PPS signal. Many things can prevent software from =
doing
> this precisely. This (Timed I/O) method is better because software only "=
arms"
> the hardware in advance and then depends on the hardware to "fire" and fl=
ip
> the signal at just the right time.
>=20
> To generate a PPS signal with this new hardware, the kernel wakes up twic=
e a
> second, once for 1->0 edge and other for the 0->1 edge. It does this shor=
tly
> (~10ms) before the actual change in the signal needs to be made. It compu=
tes
> the TSC value at which edge will happen, convert to a value hardware
> understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the ke=
rnel.
>=20
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily
> loaded, the difference in accuracy is larger in old methods.
>=20
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by wr=
iting a
> '1' or '0' value to the sysfs enable attribute associated with the Timed =
I/O PPS
> device. Each Timed I/O pin is represented by a PPS device. When enabled, =
a
> pulse-per-second (PPS) synchronized with the system clock is continuously
> produced on the Timed I/O pin, otherwise it is pulled low.
>=20
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.
> Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>
>=20
> References:
> https://en.wikipedia.org/wiki/Pulse-per-second_signal
> https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-
> DxLW6t_V/view
> https://youtu.be/JLUTT-lrDqw
>=20
> Patch 1 adds the pps(pulse per second) generator tio driver to the pps
> subsystem.
> Patch 2 documentation and usage of the pps tio generator module.
> Patch 3 includes documentation for sysfs interface.
>=20
> These patches are based on the timers/core branch:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dtime=
rs/core
> These changes are dependent on patches that are merged in [1].
>=20
> Please help to review the changes.
>=20
> Thanks in advance,
> Subramanian Mohan
>=20
> Changes from v2:
>  - Split patch 1 to remove the functions in later stages.
>  - Include required headers in pps_gen_tio.
>=20
> Changes from v3:
>  - Corrections in Documentation.
>  - Introducing non-RFC version of the patch series.
>=20
> Changes from v4:
>  - Setting id in ice_ptp
>  - Modified conversion logic in convert_base_to_cs.
>  - Included the usage of the APIs in the commit message of 2nd patch.
>=20
> Changes from v5:
>  - Change nsecs variable to use_nsecs.
>  - Change order of 1&2 patches and modify the commit message.
>  - Add sysfs abi file entry in MAINTAINERS file.
>  - Add check to find if any event is missed and disable hardware
>    accordingly.
>=20
> Changes from v6:
>  - Split patch 1 into 1&2 patches.
>  - Add check for overflow in convert_ns_to_cs().
>  - Refine commit messages.
>=20
> Changes from v7:
>  - Split the if condition and return error if current time exceeds
>    expire time.
>  - Update kernel version and month in ABI file.
>=20
> Changes from v8:
>  - Add function to enable Timed I/O.
>  - Changed the updating of tio->enabled to a centralized place in
>    disable and enable functions.
>=20
> Changes from v9:
>  - use tio->enabled instead of reading ctrl register.
>  - change error code in enable_store to -ENODEV.
>=20
> Changes from v10:
>  - Rebased to latest codebase.
>=20
> Subramanian Mohan (3):
>   pps: generators: Add PPS Generator TIO Driver
>   Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
>   ABI: pps: Add ABI documentation for Intel TIO
>=20
>  .../ABI/testing/sysfs-platform-pps-tio        |   8 +
>  Documentation/driver-api/pps.rst              |  24 ++
>  MAINTAINERS                                   |   1 +
>  drivers/pps/generators/Kconfig                |  16 ++
>  drivers/pps/generators/Makefile               |   1 +
>  drivers/pps/generators/pps_gen_tio.c          | 262 ++++++++++++++++++
>  6 files changed, 312 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
>  create mode 100644 drivers/pps/generators/pps_gen_tio.c
>=20
> --
> 2.35.3


