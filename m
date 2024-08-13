Return-Path: <linux-kernel+bounces-285651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF69510D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76805B24A37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E71AD3F3;
	Tue, 13 Aug 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sn4V7nVG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FZ163j7/"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34871A76CC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593572; cv=fail; b=ijUlRsmsSVCscO1iWJo7HvyUp0fSCf5cjPK6i9oFZdTn0a731o2rECPKawARmbHAnWweKmMnkapneBfHS/i397bT2U/RprpM5b/0sFyIk3eHFYijDmo1Mrz9cyh2uKC4D6dFWScuKH8P01SZET1+GjHUscJBfIvbiYjhH7yKgH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593572; c=relaxed/simple;
	bh=yQpOJsvupl4FpFbGdgNcXFgvKedkhniNcvGPFzLWjDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObeCC9p4DgoOILLqtZHFploCBglla48oaH5j4Y2NkfzqnLkTDvppMMfjxf64hxvWKZ3hZrR5kZ+ap/ETWuupt1WuegRm52sDxeUAel0AVXlV3RbltBonln9EcDi2CDggBEdJIZkBJQShL4Gqf1oHSZe4hlOIx/ddeEqvARWzln8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sn4V7nVG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FZ163j7/; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723593570; x=1755129570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yQpOJsvupl4FpFbGdgNcXFgvKedkhniNcvGPFzLWjDM=;
  b=Sn4V7nVGsqTFdSRkoQmTHj0mLJDnmPwlxh3CWlMvjRWOT/0X8Gvh1O8k
   PA5EHQa6V4uzyQFMmghMf7mergvaQwt5gKUc83oXht3APjq2H/A/vIcvO
   kZwusvVXaz5QY0Pwd260Vx9fuwOty4EjXaj/5UMAMyg1YXlTVb5YUmTsQ
   qBqXkQI/28YUt9mP50WaIs5piSpww+TxLi1DPvI2y/JiXhkQxg/zWcmqe
   LaqkEk9YPsvbto2xvuM7iXba/QXhNdRddQktjSR8uJQn0BYtMREawlIu2
   kzaEJzCvvQEoS71+K+dIK1Y9U8PcebgslKaMRPl+b107Vs66NWIHsTiOf
   A==;
X-CSE-ConnectionGUID: GLQjJo8cSlyAUBPIy2G9rQ==
X-CSE-MsgGUID: nw7+L3r1RNC6otRr+QUN8A==
X-IronPort-AV: E=Sophos;i="6.09,287,1716220800"; 
   d="scan'208";a="25202872"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2024 07:59:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfN4rn4PRCZ21EL1u+RWZg6BmhDbo5FLSvpVy9lZ0fRZ1eBLWMffTgyhToVYNRfwCszPvPNgEsO9B4E8kAJhzFh69JzAU+p6NfCiDKcbiRUuEoAmHT3zkb81psQixOsUKrIt+xBk/0gdqJoE/uU/R0mDaUp1YCFfzDY+rteLI9pNqmUQqlt5VfmlEUB0E/PhxL+tEEYmFG2Gs3cJfnzNf17zoBoR0fgg467u3JdfKuoyqYDmmTKwCWo9ugIJvjSHfwzhkyeWm21q2kLbLUG6+D55VJPFiv80ZVsq82g+RFqOsRonZOs+dMcvAC+kMtAUuBv2Mg3ma+JJ087cNtEnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQpOJsvupl4FpFbGdgNcXFgvKedkhniNcvGPFzLWjDM=;
 b=hwwS01kjyAbpnforwfSdbweD2kBUXDVM8q8yb91NYc5rGbUy7DahRf/vmY9HT1nkc5DFAh2BHlSPm9k4Lgtyb0jgljfw3IpDAkiGFCsu9nkFmgbfxbh3drFZynMP+ACRbk4TNIACj1FR5Z4wVSDFy6rxt9AEIjqbMkGVxqnnv5c3RpxD7aVg0ne88th+/egJrITYjbDNNOWBaE8UjpTDgiFQPx735+4qL4jahJ80xoj4CKxD1TgpFCWJLcqkqkFX/a9e7mdTE3/iSsg6Wi+p8Rn/5KpBZfd7KfwaWUDYpmhgWjfpQokNAOHob7snZARcJag08nhAIYM7y37iwIArEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQpOJsvupl4FpFbGdgNcXFgvKedkhniNcvGPFzLWjDM=;
 b=FZ163j7/02MBfTFoGdPjLne33xK6Yv3yW/NpLD2FSY7ZnfotAEaG78kT6w+6XoYE2yPdG5/C+TibQU2smWIdWKgxwJg88w81XjWrfmhfkRGgtE2ltknniv6glMJe7v+jhB9DyaAYFE0ro0KN29IoCY6pHdumFT2IIvBbdnWObA0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6534.namprd04.prod.outlook.com (2603:10b6:a03:1d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:59:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 23:59:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jann Horn <jannh@google.com>
CC: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
	<dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, Pekka
 Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Roman
 Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Marco Elver <elver@google.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	David Sterba <dsterba@suse.cz>,
	"syzbot+263726e59eab6b442723@syzkaller.appspotmail.com"
	<syzbot+263726e59eab6b442723@syzkaller.appspotmail.com>
Subject: Re: [PATCH v8 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Thread-Topic: [PATCH v8 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Thread-Index: AQHa7V+aNJWuNJQxqEGdTCA84xSRzLIlQTyAgACdqoA=
Date: Tue, 13 Aug 2024 23:59:26 +0000
Message-ID: <5qdsfymdkyqhc57ww64mphrshgq4ioelbtg3ojwpicmyzwjydw@kgzio5qsmnng>
References: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
 <20240809-kasan-tsbrcu-v8-2-aef4593f9532@google.com>
 <vltpi3jesch5tgwutyot7xkggkl3pyem7eqbzobx4ptqkiyr47@vpbo2bgdtldm>
 <CAG48ez2DUgxh3f4N=i60TfHBSTbh2HPMbA8DcBo2g7HSepnzzg@mail.gmail.com>
In-Reply-To:
 <CAG48ez2DUgxh3f4N=i60TfHBSTbh2HPMbA8DcBo2g7HSepnzzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6534:EE_
x-ms-office365-filtering-correlation-id: 8116a057-4fa4-4ed0-cb70-08dcbbf3f669
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X84IYnn1a93VnN7ivtwtZE9y98b0K0PycZgowcPuNRWGBHBC5SntMRAM1h/b?=
 =?us-ascii?Q?yy7hbxW2Z7orz8eMm2v+W+oAnXosjG+fWXDeQpYg/HKvPF27ZSz0g4nP9ZvC?=
 =?us-ascii?Q?W9E+1SZ3BG8VUgYqatGzVrMkTr8+4CfZbazQ0PPd/A4A0EtnBOlJqYUjMAnX?=
 =?us-ascii?Q?1cdhZd5++Z93/zirOoD44CvOIyeCKNQP0JFLRQHngNmpS8w9EnkbnMzkbv3Y?=
 =?us-ascii?Q?0AlLp/Z6XUCvc+5Zw8ngJM8/3H6sVBvMZp1OAEyx622nHdRJqXXHLHISLz+K?=
 =?us-ascii?Q?beUs0sWNLf2Lq62jgSV/Tg7nKOclWSc0q9VM8Py9gzcGaECBIrUejvN4RQlo?=
 =?us-ascii?Q?604mpIHNh4kRDRZ2R39bYhotyr64EwYmluSwk0iPGhM9WE4RAiFag8B8s9tq?=
 =?us-ascii?Q?GT1a5awsyXJ4bFxcMzudp5CQfro+FaghRVjNeFkAsQr3llMQycmqLG/lHUFI?=
 =?us-ascii?Q?lo2G9Totv6PgeV0iUApYUhOvkCe+FM6ONTkl7WiKeP/suH6oQJnkE96HKafr?=
 =?us-ascii?Q?CnCCbZd2YQkLLyP9G33KalVB02E5rdE0awC4EbOfQBM3hJnUK8f/kdnQOrEE?=
 =?us-ascii?Q?2cI5NBQmt3lvIjFRUe0yqqBAYlhcSBQFsGi9+mOuHHstOtDMIQXpRy4h/SzJ?=
 =?us-ascii?Q?69hkxyeOBZKpz6+hc2J4l/10h+7D52YBEuChV+OWtWRqpBid0dppFrYHoh/b?=
 =?us-ascii?Q?gt2bxQDRqSKKJUU6K5Y5Zkq4VQFmD0nwz1e25863nCvfDllT/LfX4iGJCZj7?=
 =?us-ascii?Q?6pO5Ax/hk9/ufwpgYO+Xiq1t5DyDiZ8nBeJEBX3H91b6CwWNMR6XjmwM9BZW?=
 =?us-ascii?Q?Zawenng+xvFH+Oh5+f2Lupew72FcV0EZMYcFC4yKtHQ/rAJ78dc9Wj3rmaHE?=
 =?us-ascii?Q?s8RPEeaOZvr4x539Cv6wgaJvyaERcZ8KcUulpC/HW1qtFljp11L7oPY+wUyh?=
 =?us-ascii?Q?bhWCJGH4/FiJza4YZbMSVj9eHvVJD4JF9hdkK9aWVbMstJJVqXGdyxGafOL2?=
 =?us-ascii?Q?eT3JifemJuwhE5ZIRhToIqcoMr5vG9imbOyQ/6vUEelWQUY/ZhXNxmqjkemH?=
 =?us-ascii?Q?zcjtU+/jdUIYWAPq+C98TbIeGnBMuP8AbHIVTDyTCPQsBjVi6PTKSxHQvs6k?=
 =?us-ascii?Q?NFz04stwm8bfvWNHA4ah/WDg/04dC1qfy/ocGguTgDJ8CV7nnziSABe4Nvcx?=
 =?us-ascii?Q?Y9Gwpp+P70uXb2+LAnZpMpMRwtMyNVP88To+jcsLPXyuaTci52E4JcXjo6y1?=
 =?us-ascii?Q?eFi0qMx4g5cjf7/bNrw76DI+R8CJaqVgqy2mIqqw4Tg/d94NaZrHzjtSR6iq?=
 =?us-ascii?Q?ASkbBbtiPsrBuXM9MVQyPWCF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ahnxXEywiQRqmct6W93Ue+r8VSfYpdlvL9J7epMuhzWfPa5wIOZJbsFVvKsu?=
 =?us-ascii?Q?xbsFGD072Ee14HLZh0/Q4c+Fn3Pkc1a2QULm+v5vr4rQw9RmVQ+sNN+F3+pO?=
 =?us-ascii?Q?iDzNsP8OE7C+CA8WzPyQn8EC71kQqMoAqGtBAjNyhAvLqnkytwDdHI0xCvbw?=
 =?us-ascii?Q?LsBBSbQxQs3Oxlmj/yEC1z4yYTkXLvdD6dryP4WFovjjBLqdZU592HGNdn/o?=
 =?us-ascii?Q?9HTc+tjDbzixg2nDze/UWHJPZQoU6Udgi5vgqUoCOd51qb28Kj9CsdHXd7jT?=
 =?us-ascii?Q?+53ZHksEsgLdltd4B6wWREm0mfP0lphXhGW7jz5DTkyaCJ2iB/eXETNknDZj?=
 =?us-ascii?Q?xSz4wucmaoMtJmSDaOtc2x9DJUCEXCO0954nuspy8yihr6v62i7KouthzATa?=
 =?us-ascii?Q?DHh8E4gUSgyFfZhj4W7SA38GRqb8A45+oOcMrJzlxFEfZlfPBjUFcKaMM4ml?=
 =?us-ascii?Q?CyLMWaTFJBurro+eJB/ouCCW0Z5FPF+MqvgJHEw1wrAPTBWoQunmf9fJ7hvu?=
 =?us-ascii?Q?h+aAtHmU9BlPGN15oVUpzLiP6ScVv80z9ZcyLGA5hEaxElEtm5NHeRs12SAp?=
 =?us-ascii?Q?/jeYN19GCQvB/+DH3AiMySJzRZPGshxcIjJR0Q4XY3pvFAgyYpZi4kArWraP?=
 =?us-ascii?Q?+K/pVR5WhXZWs9yFGfUmS0JEg2cIeDwySpxdS1GR3AI4jGu4hRtDAP9JCYVH?=
 =?us-ascii?Q?0HWhjly/ZHhWQnaHixA2d7J4ORWaa8Fzr51bGIK6Daw3ZURkjWJAz38EoFnI?=
 =?us-ascii?Q?tTtv/3zA9wfhuDdfnuWTjmoSEKz4hywEMe8AfovsXG4Kcap37QT15rbFDyg8?=
 =?us-ascii?Q?r72zVu3ouFtRKp+98azcY9/Yx9oav9BuSC+dF/KhCZUGVg8U3LC9Tg9+tXeD?=
 =?us-ascii?Q?3sLCl9Oqzr7/dU0awZ7fLsljDNvzUxgqPtcsfiSN/jIQjuAtRX/8loL4fii7?=
 =?us-ascii?Q?WTI4QU1fNEHkMS+Er1lh9OoMOtsboPAzD5wsUOpYN/qYGu/LB4jgg0qtGmA7?=
 =?us-ascii?Q?wLR1JABKW71NTKW5z4lihOirI2ZCJsDKBbH6kdAZEOovIZCZNZkXdm1qK/K+?=
 =?us-ascii?Q?xzRtXKIo57LLRWS1aeXq1Pchu+h3mLreTzQnL/cNPzXVxnDbe3oAsGPpzbFP?=
 =?us-ascii?Q?ryA/5x8qeY9ovOr7DBNXnRy2UkyJxBqgeKOowzNpYaN1R2RCsJ5KacczZPyx?=
 =?us-ascii?Q?Hn9VVspK1t8JOyP9M5ukTJQps9yWcsTZ4Q9qjVYvD+uaTj3nRAWZvQ0/olR/?=
 =?us-ascii?Q?gl2/1CSR7eCh7borl0C4kp8f6vNjB89yot5CvNEmlG3RGbHeu1SsK15mv0v8?=
 =?us-ascii?Q?826qutUY/pHh+B5uTb2aG99OoswEoRtkuNGqAlDHy9vgoUynoOWnTZf6qqLY?=
 =?us-ascii?Q?PhKqRVRg++KVXILiG/KxDSp8LHiP96A7g2A3/GudMNDEjgCAC09uS0F5Xy8B?=
 =?us-ascii?Q?uuwOdQeILdrFbyTxzf21qqIb8tVhBWRfMZ6OBDg3jLhSyppBpSMk5cKU/bTJ?=
 =?us-ascii?Q?ZgcDJFzTXH93o1SYjweA6L26PmGA4tkz3M9oqnyKvjI3GvPneQGXOyMktw6Q?=
 =?us-ascii?Q?aMvg9vWn0lTiyl6WujU3ouQInDZKQuKMRvXVS07bGaxHfLfakE3G+WxOl8Rr?=
 =?us-ascii?Q?T9nUottsiZYTPgmBvTM3cIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10172981F48E2B4997229FB7B3BE49F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BxCFubE5eSj/EOFTWOiYSnVJDM0Pc1WdpOKWYaj5JlPy0OMG9X3DfKmCSnwAmNMJdcINT+hfT4/8wP4psz/P26PbG3s3MgX3Qnla2FmWodtOJ46dtIYDMngqPo6uip99JT8ATs/fbTdtxrFRjG0Mo1Qo7CSLYM91Qny6laO3vl7+hz0nsxdxAjBZitYV3hySUGFINAcfPHIh3oWUUbq2AsOXrlnxp01wMOyJ+1aXe0ESydoRdgiQRLIcX1iAN6GJTuW11niSXfTrfiKbpNFbMKOx8cqniFmc5d5mMrZrzR97j6TWbndqKke8MXHgaL7Ox68tcq3K4T7Z3p9yWmIC431TJu9iGwH9Ohm8X0NuBNo+OSpIB0mwhDbDS1Dm5FX6J6cabRlc80eUs8jbwKNZ3o+wsoumCCbB7dXHdM+sIadIeZMoEPbsmW7iEqjuK7HnPsh/vVD4hBz7py6odAgLdcc9FLz24sxn3LuLZi5zTBXp4M7AGKavUs+24F/UN4oWO1s3C3+Qlf4H30BJ+YxyUkvdmc/3gm5BZc2E5E7oCMcRJ62NiqLzkzyLiiWYdqwn+KzXxmaRpzuFykMEV9jVao4FwlKEisXhK1+zoFL9mi+naToE3NaNHFL+83RmPwMR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116a057-4fa4-4ed0-cb70-08dcbbf3f669
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:59:26.4781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMq/J//wboYQz9bU4a6wmJ68TTp+nJKKP5DUCitRs0lCEaPlQ3i53ezs+uPr9AU5FvnmRmZcgvmTXuzXtktfzVB3Bqcd+cYUrp37/x2PJtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6534

On Aug 13, 2024 / 16:35, Jann Horn wrote:
[...]
> In the version you tested
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.=
git/tree/mm/slub.c?h=3Dnext-20240808#n4550),
> I made a mistake and wrote "if (WARN_ON(is_kfence_address(rcu_head)))"
> instead of "if (WARN_ON(is_kfence_address(object)))". That issue was
> fixed in v6 of the series after syzbot and the Intel test bot ran into
> the same issue.

Ah, I overlooked that 'rcu_head' has changed to 'object'... I should have
checked the patch change history. Good to know that the WARN is already fix=
ed.
Thank you for the clarification.=

