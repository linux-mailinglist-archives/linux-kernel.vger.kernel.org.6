Return-Path: <linux-kernel+bounces-193282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950BF8D29BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98E51C21EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8915A850;
	Wed, 29 May 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecDfza8a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE214269
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944491; cv=fail; b=TtjG7TudlsI6RjcJQcPjumx3L/uyK4HTGtkOpoWZo6g1lRIVEdoiZVBxY3w0MVcnqy3MEFKNDTD9CJr0nRsRn7mck3Z2MJ/I/RmRSmCBftZotvM3PSts1x/zDtJ9szk8ubBM1qDeNYAZE6tA9SO35a08aCJHHgcL5pvdbtcqoaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944491; c=relaxed/simple;
	bh=cF/L7gaVnTOwJ/KSXaP+4WYU7fJ0xCN7KtEeMdaw8/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bphZcC4B+Iqj3tCSeLnia6VWG3JZ/kf0kfpGbDnOKNY0PR69X7CpLGCpXqjR3buuDl1jBSSxKUuispMRDE72SnZgHZ9EqnMmdVi4eLv3YU3igH6qfmUOy8Z7Mvgs+SL5qgYOMMuQkF4APwU++vrJbBXfQtVagto9V91idyChroI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecDfza8a; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716944489; x=1748480489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cF/L7gaVnTOwJ/KSXaP+4WYU7fJ0xCN7KtEeMdaw8/o=;
  b=ecDfza8aMbrHTGnzuPrTliUJvV1foDFn0UMX4J5R4pbUna+5RT1aieIb
   GXt/ljZVoUYHli51NCkjoqkm6mS0mCGdvOgpcGdsPuydVI+/YpBYe1PW5
   +gviZRViWuKfAFotgMtVv+LEen7ShPmH42Pv5KvEpf6ovjUTeZcul9S07
   hSKTbwnOVhfEbNRUua870pd/MZRMnAJ5a8Fo73cjkGc2MY8joVRvBQUZD
   1bIn8wNLaIPbMzGrYU4KhDtUdiv+bpWVP3ylOEsUFBAU8jLpXPdIceFgA
   zwJrkDYX3Qk47rrrr48oRotmqkKsZ2p+I7eczR09xheK2VyfM5Ld4+AxI
   g==;
X-CSE-ConnectionGUID: Kmsli8sTT5KDwqpZvZu0VQ==
X-CSE-MsgGUID: 8RJ3IfqNSCqAfLv9m4hY8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23930360"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="23930360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:01:28 -0700
X-CSE-ConnectionGUID: RPXp8b9uQp+eS81vVCl8kQ==
X-CSE-MsgGUID: Jw0YzOWZT4uJNG77Alq7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35721882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 18:01:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:01:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:01:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 18:01:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 18:01:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up6iAoNhId2EpRgZtBtDcuaWkgN/LN+OngI2k9H/dnc/iXKaYj85OuGl70JHxXg0ggRhta4GCEj/DSudT1Hu17Nt4UW2wsxOzuM1jaNEDCOvZBLj5fuTSllbTEb/LZsyUmgrzeXG4NZml07EXVnsJrwdzHTCqhj/Leh9nqWtpLMKT1jOXpUvHTvXpEvteQHA36yHBPuAO+EnGswIr7jnRwiz11MHYKEBj8cdkQYRNsnID9nLg0lOhsVQw51FO/j9mwzQ/eEsMgyez+cBituYgvBqHXl6/FRWTOs05+SCyWHrCMxtXCqz14JEQGrucMBLF6dkPoTJ1spaUng7oQx1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkYuO0kNQ41MZBZ8VYDN5+fvi1rWSKxruryNjkiccGo=;
 b=VzSE7o9Gi/gMut32orp5ECEWvNMxP3PUpkbhHU9ldZCfTMhZOHZTJcONU7M+wCahMoHJ5Pvr5/djOgPBoXBpJsYph4STv2PcpqccShnurPPgNfsdD9V+H93I8Gcf0VnMHBIj4rAmMA/QXA/7H2IkD6AGjPQtlmL+ayUzUS6QZUTMRfDvcTtEaWM+Zg5n1AegRo+FyPeESCIZuFozgqN8g6CnzmDHynxSjj1xveyDgJ6fTt+XLZrwtu0EvqRx+HqAJDmTjVFcWo49hat5vBGCyMRzhKk/BXbGQElo+OShe6DkE+guJp45D5Sx4ER3x/esbaRgQ82Sdx2hsrIXe2jsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 01:01:24 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 01:01:24 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Conor Dooley <conor@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Andrew Jones
	<ajones@ventanamicro.com>, "pulehui@huawei.com" <pulehui@huawei.com>,
	"Charlie Jenkins" <charlie@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Pu Lehui <pulehui@huaweicloud.com>,
	=?Windows-1252?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: RE: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and
 not requiring toolchain support
Thread-Topic: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and
 not requiring toolchain support
Thread-Index: AQHasO/Q81BwKHiJLU+eTWZMI9PyE7GtY8Bg
Date: Wed, 29 May 2024 01:01:24 +0000
Message-ID: <DM8PR11MB5751DBB6A068008269E7D399B8F22@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-opossum-flavorful-3411811b87e2@spud>
In-Reply-To: <20240528-opossum-flavorful-3411811b87e2@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|PH7PR11MB6955:EE_
x-ms-office365-filtering-correlation-id: 44809241-5633-43a6-7234-08dc7f7adcaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?vOSHcF3VtOPMoHdYJsy4kBeqGjyxkPal3aWW6u9crWEHTwExzdYr9FGX?=
 =?Windows-1252?Q?SWhRCPqysl+MCmATSlwmoBWgpmeQh7K73Usnai2A/2+EtWwTqR8evjhX?=
 =?Windows-1252?Q?wxi034VRCgZYcFV7OzwghOYvbMbaNcSCiRiT3JzaXqn0FOYGlQzaCyYA?=
 =?Windows-1252?Q?ChAWwfoV70qwTI0Rzhio/vL781JDegD8iUZvVoyJw07HKyrk/AkQfEdf?=
 =?Windows-1252?Q?aHW8RjVx9WsOa4pgHr6Z75TUKecbRecdYf0ZfZMz9t6rZItBfBTqL/68?=
 =?Windows-1252?Q?MWrj9ib2mFv05uy4zPGolQ1FNIa7Its4QKIOusRhC5Es+RBT4yPJqmG9?=
 =?Windows-1252?Q?5nmhsoJc6V5i2abQH8WWArT6I3bHZ5T+hMVvAr9k85dzeO7bYfe+xYQ0?=
 =?Windows-1252?Q?fTJOCstiuv70ULRVT31K/dFcqoHmXy2ATImHedw8BHoc1j5/oSCy7l1V?=
 =?Windows-1252?Q?XkwxmdZlUI83A5bnC+xY3ZZ7NcqCEwbk6xd1hnPmVQ3mIJuvkTbGro6d?=
 =?Windows-1252?Q?gxfDrnGWEYPrhAtqu59kiIvGZGJlyHXysXZUw6XjQC5zTaOfiHQWLKyb?=
 =?Windows-1252?Q?okGd2EYRgiTz/FauygBxargoqOCivz9m7kNYLXtvcz+pzR8nqHo0yIKj?=
 =?Windows-1252?Q?tSQqqi0ec0817QyCvOOqY9AZrd1Nwv47Y3vCd3MJ5Zv4HHkue6pdl8eN?=
 =?Windows-1252?Q?LGw/7XIpCFBUHWpHmvF4xBAufZy7zZt3WE7NbsHcq0ujUN1fBVx7TL3r?=
 =?Windows-1252?Q?BOKUx/NqNHf1+vgoXuCAo5mtDolcogv5MkYtu2Ibopx6DkU4lWYp+oM1?=
 =?Windows-1252?Q?ntMl/42Tiq/TrG9KTg1A9RGx+zJuhdJnHMRmhoMhGhx9POfUZgjKS8AH?=
 =?Windows-1252?Q?31K1eYLrYOuAuFUzicSLDZbAcNIBicykXuvqZvPNMUUi9F1RF7jnQZBo?=
 =?Windows-1252?Q?xkDb8pXr2SWuSrW5wJV6BXi1ixmQp59t7nMYP0uPOGTxqo4r/zr3UCyC?=
 =?Windows-1252?Q?gc+JJVBKpIrdOT67O7jugWWMr49GNuFxzSt1PPuDtPSgqkir2ABzVF8K?=
 =?Windows-1252?Q?23DX4rF74ucYZeslKJLmWgEbm4ZYhPwfaHW5Pmrn/LIOArwxe5Pbl70w?=
 =?Windows-1252?Q?iZOjY6yt+i0VdbQY6aLWNdAJk2v0iKtscXsYs6vypddStB6iA/6msZaD?=
 =?Windows-1252?Q?OdnoAfw6bPKy5nbwnX6ZD2YxdXLGSBYyyrp5wXJ8Pzc2ztatdTpZ3CkT?=
 =?Windows-1252?Q?s2WHMu2nzoNlFiN4eaQyH8ryWzip/DYVzEs+S5rv/BSt7aBJavT2j6cf?=
 =?Windows-1252?Q?rz9N6dGWt5Cl4St/XvdgSrybwbV8LnLpM4mx+A2KAYrq/YfxWp1Pba6a?=
 =?Windows-1252?Q?3OIgvOZPDhlnfz2cvCFrK3DrZ0YOjpgaSOA7M/52eEJ74i/TWc5/L1LZ?=
 =?Windows-1252?Q?ukV+1yZ+TCOLVZ55Qey7Kw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?CDAa7VvhdV0KZhpM+wBjhst5USD+/JyJI6IQB/66BAFLSg7pscNKah+1?=
 =?Windows-1252?Q?B7aB73I9k8zifKANQOAFE4p/HYkU/fnz7lXTTIczXQATtum0hSxo/Xdb?=
 =?Windows-1252?Q?1I+pDY+whg43KNDX9sEo7PP24nzY4TqbxeOMjeYckpUc5VbvAcizoPA/?=
 =?Windows-1252?Q?N6ZjRC7loVyBwQYq2xgaZsaIGaj82IJNcigLlDaXUjgDQdvWqW/XdwUp?=
 =?Windows-1252?Q?X1CyNuHfTVfka+RwKga3+B0UB41Cik+m+Dx0b9n8F2De7oW2lXhF1HQo?=
 =?Windows-1252?Q?xBw00+l08N7WoUdRqrPLS32m4lNiUt5MBH6TcHuv0M7xxKE4zAzINzu5?=
 =?Windows-1252?Q?61CFqJd98em3i0XeJv0m/LxGSZeQBkWZXUNg9DgFL3JKdd1gnmrYXm7+?=
 =?Windows-1252?Q?nYTYUwSDEd3jUrs16EjkLtZ3DwL6aA9yVxg6MicKRh10mpIb5nF95CWE?=
 =?Windows-1252?Q?i2MVZD+CkHl7A0lxWIrfpw7Ofn5PblI0nK8QR9Dmze/fCezoUiB/sJmv?=
 =?Windows-1252?Q?FH9rvPakxcdm5cD5wWpncC9qVPzmPDxswOP37lsvTL8Nnjv83qKcJcLA?=
 =?Windows-1252?Q?ninK5qPJzgUNPmgyzQeLBpiIQCDHXL1mAtYF+DYxR89F/GjZTO8Tu3iq?=
 =?Windows-1252?Q?SrmRJmRb9+GawLCK0k+R61QTDNvXoBPEadgqSla1pbPQsL4/KHFid+GZ?=
 =?Windows-1252?Q?MaJxtjLAa9SGmwLMj45iY8jbWPVs/QEoeDPru96WMLDDQLn3MaSGJzTV?=
 =?Windows-1252?Q?ZYTQEUmypf9CW4JFn8ko03voU03LWIHy6DPl6FtMzp/HbZBbJrq5Xet5?=
 =?Windows-1252?Q?F1gdXrPqLFvjJq45ESmDsaAnCS1BubwicpcoLOPkDXYsEhRMiCZ94WMV?=
 =?Windows-1252?Q?ChWk6rI6p38fybfnU+l3C3jhCFAIzGTw66uT4oGl4PT/eg3P4AAjwVnn?=
 =?Windows-1252?Q?TSSL1WR2ifozzUYiYknwUQenU1PdcxSgkEs946TsWv8MER7gk1gJMOya?=
 =?Windows-1252?Q?nUyTWhdCduzAFT7JdNcLI9kXAYy05+opJjZHS2vf1x9+isLRz7IV4P5Q?=
 =?Windows-1252?Q?TBcO86Vy1DaGZ2pxjv6xkwGIzugVOrskqMGYR0BzPss4deG0tZn5T7yo?=
 =?Windows-1252?Q?BBY34csyyuYhYAA13o71XSz/aIcrSo/NTPhEHFY54lo2Y7Fj/jFV4HZi?=
 =?Windows-1252?Q?urlbr/RotRS5JiB5Qbz7ueun9iFeZuDwKt2kbNcGnMdBCe3LAgxHLqDl?=
 =?Windows-1252?Q?+ax6oyvK2pPjYu7MR6kR9TOuFcNI2kyD1lwYoaeSv9L1Y8yk2EW8XPdh?=
 =?Windows-1252?Q?q5+ARlPmmHg+pN2PxTiOriHG3mCQm2CrGqg6zgCSLCw+Dq6ZyNW3UoXD?=
 =?Windows-1252?Q?BmqZ/mIIYqWWfaRcP7hu5vgmhEaYAzvTQay42PaoEec1OI4c1DEl7hFk?=
 =?Windows-1252?Q?YpJ8QEHWM+PJJO9l/KSHOm3EWoxX9/aimyVNj4gNptA1gMJ1pJvUQvUv?=
 =?Windows-1252?Q?4QA2BOuwxtZFuYzt2KT24UOiULgcWYQzfL0FH9LRT2kt7u/MaHziHZ0K?=
 =?Windows-1252?Q?33nEpX7xHswNYEOvcLseX9LJnrjQAfVwm3sSiH43BO+yZxfyJ+tC99+o?=
 =?Windows-1252?Q?yiZHBCIfTJBZqLr0PiJnYEFKfSPxUWMxGzFjBdV3hGWJlLaqsLU3thrO?=
 =?Windows-1252?Q?nU0C1+tY3yHnQDRqRH0oujGY7IiS5oDX?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44809241-5633-43a6-7234-08dc7f7adcaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 01:01:24.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsrtcvzV5poAcEQ2BMifw5W31k1VBW0Az3nSxVYvWKEMvCwSJ5VBcVYThmTg5GS7kFjYStCkXGa6k3EhVtfXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, May 28, 2024 7:11 PM
> To: linux-riscv@lists.infradead.org
> Cc: conor@kernel.org; Conor Dooley <conor.dooley@microchip.com>; Wang,
> Xiao W <xiao.w.wang@intel.com>; Andrew Jones
> <ajones@ventanamicro.com>; pulehui@huawei.com; Charlie Jenkins
> <charlie@rivosinc.com>; Paul Walmsley <paul.walmsley@sifive.com>; Palmer
> Dabbelt <palmer@dabbelt.com>; linux-kernel@vger.kernel.org; Samuel
> Holland <samuel.holland@sifive.com>; Pu Lehui
> <pulehui@huaweicloud.com>; Bj=F6rn T=F6pel <bjorn@kernel.org>
> Subject: [PATCH v3 2/2] RISC-V: separate Zbb optimisations requiring and =
not
> requiring toolchain support
>=20
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> It seems a bit ridiculous to require toolchain support for BPF to
> assemble Zbb instructions, so move the dependency on toolchain support
> for Zbb optimisations out of the Kconfig option and to the callsites.
>=20
> Zbb support has always depended on alternatives, so while adjusting the
> config options guarding optimisations, remove any checks for
> whether or not alternatives are enabled.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v2/v3:
> - Per Drew's suggestion, drop the stub Kconfig option and instead push
>   out the toolchain dependency to the relevant callsites.
> - Delete a bunch of comments about only attempting Zbb if alternatives
>   are available, since they always are.
> ---
>  arch/riscv/Kconfig                    |  4 ++--
>  arch/riscv/include/asm/arch_hweight.h |  6 +++---
>  arch/riscv/include/asm/bitops.h       |  4 ++--
>  arch/riscv/include/asm/checksum.h     |  3 +--
>  arch/riscv/lib/csum.c                 | 21 +++------------------
>  arch/riscv/lib/strcmp.S               |  5 +++--
>  arch/riscv/lib/strlen.S               |  5 +++--
>  arch/riscv/lib/strncmp.S              |  5 +++--
>  8 files changed, 20 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3b702e6cc051..a91c53b096e8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -613,12 +613,12 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
>=20
>  config RISCV_ISA_ZBB
>  	bool "Zbb extension support for bit manipulation instructions"
> -	depends on TOOLCHAIN_HAS_ZBB
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
>  	   Add support for enabling optimisations in the kernel when the
> -	   Zbb extension is detected at boot.
> +	   Zbb extension is detected at boot. Some optimisations may
> +	   additionally depend on toolchain support for Zbb.
>=20
>  	   The Zbb extension provides instructions to accelerate a number
>  	   of bit-specific operations (count bit population, sign extending,
> diff --git a/arch/riscv/include/asm/arch_hweight.h
> b/arch/riscv/include/asm/arch_hweight.h
> index 85b2c443823e..b94db541901a 100644
> --- a/arch/riscv/include/asm/arch_hweight.h
> +++ b/arch/riscv/include/asm/arch_hweight.h
> @@ -19,7 +19,7 @@
>=20
>  static __always_inline unsigned int __arch_hweight32(unsigned int w)
>  {
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#if defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> @@ -50,7 +50,7 @@ static inline unsigned int __arch_hweight8(unsigned int
> w)
>  #if BITS_PER_LONG =3D=3D 64
>  static __always_inline unsigned long __arch_hweight64(__u64 w)
>  {
> -# ifdef CONFIG_RISCV_ISA_ZBB
> +#if defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>  				      RISCV_ISA_EXT_ZBB, 1)
>  			  : : : : legacy);
> @@ -64,7 +64,7 @@ static __always_inline unsigned long
> __arch_hweight64(__u64 w)
>  	return w;
>=20
>  legacy:
> -# endif
> +#endif
>  	return __sw_hweight64(w);
>  }
>  #else /* BITS_PER_LONG =3D=3D 64 */
> diff --git a/arch/riscv/include/asm/bitops.h
> b/arch/riscv/include/asm/bitops.h
> index 880606b0469a..6966d00c3a8a 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -15,7 +15,7 @@
>  #include <asm/barrier.h>
>  #include <asm/bitsperlong.h>
>=20
> -#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> +#if !(defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE)
>  #include <asm-generic/bitops/__ffs.h>
>  #include <asm-generic/bitops/__fls.h>
>  #include <asm-generic/bitops/ffs.h>
> @@ -175,7 +175,7 @@ static __always_inline int variable_fls(unsigned int =
x)
>  	 variable_fls(x_);					\
>  })
>=20
> -#endif /* !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> */
> +#endif /* !(defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE) */
>=20
>  #include <asm-generic/bitops/ffz.h>
>  #include <asm-generic/bitops/fls64.h>
> diff --git a/arch/riscv/include/asm/checksum.h
> b/arch/riscv/include/asm/checksum.h
> index 88e6f1499e88..da378856f1d5 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -49,8 +49,7 @@ static inline __sum16 ip_fast_csum(const void *iph,
> unsigned int ihl)
>  	 * ZBB only saves three instructions on 32-bit and five on 64-bit so no=
t
>  	 * worth checking if supported without Alternatives.
>  	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
>  		unsigned long fold_temp;
>=20
>  		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 7fb12c59e571..9408f50ca59a 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -40,12 +40,7 @@ __sum16 csum_ipv6_magic(const struct in6_addr
> *saddr,
>  	uproto =3D (__force unsigned int)htonl(proto);
>  	sum +=3D uproto;
>=20
> -	/*
> -	 * Zbb support saves 4 instructions, so not worth checking without
> -	 * alternatives if supported
> -	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
>  		unsigned long fold_temp;
>=20
>  		/*
> @@ -157,12 +152,7 @@ do_csum_with_alignment(const unsigned char
> *buff, int len)
>  	csum =3D do_csum_common(ptr, end, data);
>=20
>  #ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
> -	/*
> -	 * Zbb support saves 6 instructions, so not worth checking without
> -	 * alternatives if supported
> -	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
>  		unsigned long fold_temp;
>=20
>  		/*
> @@ -244,12 +234,7 @@ do_csum_no_alignment(const unsigned char *buff,
> int len)
>  	end =3D (const unsigned long *)(buff + len);
>  	csum =3D do_csum_common(ptr, end, data);
>=20
> -	/*
> -	 * Zbb support saves 6 instructions, so not worth checking without
> -	 * alternatives if supported
> -	 */
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> -	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB)) {
>  		unsigned long fold_temp;
>=20
>  		/*
> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
> index 687b2bea5c43..204fb1c184f3 100644
> --- a/arch/riscv/lib/strcmp.S
> +++ b/arch/riscv/lib/strcmp.S
> @@ -8,7 +8,8 @@
>  /* int strcmp(const char *cs, const char *ct) */
>  SYM_FUNC_START(strcmp)
>=20
> -	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> CONFIG_RISCV_ISA_ZBB)
> +	__ALTERNATIVE_CFG("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> +		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))

s/CONFIG_RISCV_ISA_ZBB_ALT/ CONFIG_RISCV_ISA_ZBB
Same issue for below changes in strn*.S

BRs,
Xiao

>=20
>  	/*
>  	 * Returns
> @@ -43,7 +44,7 @@ SYM_FUNC_START(strcmp)
>   * The code was published as part of the bitmanip manual
>   * in Appendix A.
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#if defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>  strcmp_zbb:
>=20
>  .option push
> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> index 8ae3064e45ff..84909807d988 100644
> --- a/arch/riscv/lib/strlen.S
> +++ b/arch/riscv/lib/strlen.S
> @@ -8,7 +8,8 @@
>  /* int strlen(const char *s) */
>  SYM_FUNC_START(strlen)
>=20
> -	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB,
> CONFIG_RISCV_ISA_ZBB)
> +	__ALTERNATIVE_CFG("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB,
> +		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
>=20
>  	/*
>  	 * Returns
> @@ -33,7 +34,7 @@ SYM_FUNC_START(strlen)
>  /*
>   * Variant of strlen using the ZBB extension if available
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#if defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>  strlen_zbb:
>=20
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
> index aba5b3148621..87e7c83c1672 100644
> --- a/arch/riscv/lib/strncmp.S
> +++ b/arch/riscv/lib/strncmp.S
> @@ -8,7 +8,8 @@
>  /* int strncmp(const char *cs, const char *ct, size_t count) */
>  SYM_FUNC_START(strncmp)
>=20
> -	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> CONFIG_RISCV_ISA_ZBB)
> +	__ALTERNATIVE_CFG("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB,
> +		IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT) &&
> IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZBB))
>=20
>  	/*
>  	 * Returns
> @@ -46,7 +47,7 @@ SYM_FUNC_START(strncmp)
>  /*
>   * Variant of strncmp using the ZBB extension if available
>   */
> -#ifdef CONFIG_RISCV_ISA_ZBB
> +#if defined(CONFIG_RISCV_ISA_ZBB) &&
> defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>  strncmp_zbb:
>=20
>  .option push
> --
> 2.43.0


