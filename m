Return-Path: <linux-kernel+bounces-512388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A641A338A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E9188C3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40B207DFE;
	Thu, 13 Feb 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g1AL/YJU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BcOQ1Y49"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF91FAC42
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430997; cv=fail; b=MbsdTxSnWp8bUsZU+TXnPrLK/eHgSkXDKpeWvlK7hiJRrGh7SnavLRuw2JMrm4w5t6fOg4XBxCqkorbNMzWIIDJIw1Kqo7GGEilA+RPrawydN3ExKC4hlgYotSrun/83X+FZtcSZRM+LsK7l8Vqpy0EV5wRDhfHBEhYVCxEba1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430997; c=relaxed/simple;
	bh=WxmyKPAUAn1aoHp423XXXBFHkPE1TlrklH5kWjef2TA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=makDx4XZw6Uw95IpawceZ72sLPuUmaxiZ4WpwxcZsLHoHKbITupOSgD30DcXtd4XpVFDcElwCy7HNfj5jirAsGIz42AmIgCZOY5wemKaJn201sqQiVgiIkHAZ6aWpt6VP+FhjoPfWiBLF6lcX6PoTP7pJdXvQjG2RhSbe0EQSKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g1AL/YJU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BcOQ1Y49; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739430995; x=1770966995;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WxmyKPAUAn1aoHp423XXXBFHkPE1TlrklH5kWjef2TA=;
  b=g1AL/YJUqN8VK4IV7H1NlCBJhV4VzZ1ZISePtyIAeZD2Hd3yy9lFdEw+
   54YxJH+kz4ZgPrXginpWnhZSVIPOuI4ktx8F2bIIb0GG8tHBycxGPEuVV
   dWpxE3/8Av7Zr/SnE246pkPbrGzUStAGohbjXeQx0r1xluSLHCW/PRv7m
   xr/8sDtvqrsb0z8awFwwIYN+lp5d2WxH9Yp7P+zubDGx2Ai4JO+A74Amx
   bVbeWWKoHYix0uDDl20hnBYjTjN/Wh+XNiBdsrYgnVROYKsRY9OOi8gJu
   djOGzZ6g/LK4qpbIBdAt5UkpuGqihEwdmczkoBPdJokUh81FoZjTKRS5T
   w==;
X-CSE-ConnectionGUID: I2l9h1vbTpmLk6u8qtHfhA==
X-CSE-MsgGUID: HEW1yrXWSlSmYOEEAjVOXA==
X-IronPort-AV: E=Sophos;i="6.13,282,1732550400"; 
   d="scan'208";a="39352860"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 15:16:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fen2hg49WL1QuWb4tkqLYmvmp/ZTq6hptLFqJfZCCUo8b2qF6nuARe7quvLMbIco0hE3sX2Qcf06WrKvQSNp3oHeC5frGveHf6dXDHXTh66KYkJWRNjh2ebxG8lrkm993i/S2usr2B2Pd259jsdVaAnA0KAk3a8OGZgl9aY94pyft6ooa9fUkej2VzfZREsdBl+m8K5YP3ywPLklPhYwqj0nvtfvaoA18XzAKZ/NztE219W4u16d7dbwvCJycd6op86GpnCH+R2AcPgtPEZmls3pP+n+J7bZ4LeT2Oam0s5Dki+mFC5G2CQe5VdsaeTz+GMHU9cgoBRO1m1qT03Hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juBvlqdFaQypaTi1zQURANeCTt7fEaVjxyE7ucJcQeA=;
 b=e9YA2Y51yPaFtQCrZFSXkaPMKm53eSXvxvQk1KEgkY2epD3BESh9fbeMt0eTlY6AaAlp/ZBAuLibZBZZOzw77sDAufUjrNt6xy9YBzCwf8lWLwpwAmDkPr+wE1VC6Oh/CZxvrTtaHhTUhjxcUPG0bZ6nll2WvBzoEfacsZ5gT5bSjbKlIX2cKYdMNj5L9vm2idyFyB9U58MTF7Wi5aVvx7tWjdmqCzikAvz4Kp0akv8O8PL9FipF3t+qAd6x+S5eY9ZSd4yhJQRwNbRm+Nna+mQpBuBD/PbORUXXrfpMtVAoNj6vwIoVBITtHPg6r7O4Ri5PPei84nQ7uWV0FtjLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juBvlqdFaQypaTi1zQURANeCTt7fEaVjxyE7ucJcQeA=;
 b=BcOQ1Y49pDdb0ePXYd2syy70hL21sY89HnARpx2qUInurg+QE4HMK5mSHpYEAkrQykSx7uZ88cVm06rwBEP1ugLEXK4hrWM9kXkacLmsMgofsNg99hhUBM5LWfzHJe0091rhnTTF1qKLdBVg0wFJ0kWsnmWPmAeIWiZkI01DtOw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 07:16:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 07:16:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	hch <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
	<hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Topic: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Index: AQHbfec0nbYVZITau0iKmO3vJ10nUA==
Date: Thu, 13 Feb 2025 07:16:31 +0000
Message-ID: <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8201:EE_
x-ms-office365-filtering-correlation-id: f84425f9-6c98-473f-4b67-08dd4bfe578f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G29PpJSSSnFw+iiqo+jBjfb1lheaB3+sXK5+jNcmxR+azpdJfRyyuF8t+yQw?=
 =?us-ascii?Q?3YqhHlPOoe6L+9tUT0BZL6zQs7Ce54RkKXM8vrfP+ogrikXqt8uvbPOV4aMm?=
 =?us-ascii?Q?t+c2V4Jwi7wAn5hcxJmbnLsrVa1MNlR7JpQ17BAj5cy0ySjXl9PEqfvK7zWA?=
 =?us-ascii?Q?1PiINpmqlPJwglC8VIvwkiKbVXIXD4IGNrRbPwFya1CkO2bc4TGTMellRBiM?=
 =?us-ascii?Q?cG4J0DTWEfplJbIwDZ1ZN0GHredfJoTY89t/B0GsuSIKKlJbeLz2Qe2GuEwt?=
 =?us-ascii?Q?SFn71uA4FLan1CSf356IQsodvTtHl0RBbTIZme7lAVg/hywrIChr1zr/5bvy?=
 =?us-ascii?Q?QNi6wqo6MUyrJJHPcIgJfSA/kraSPDZ6ZSBVhMOFWpSVGI6j8iHYGTOKbvem?=
 =?us-ascii?Q?igfQcMFUs7UK7l3AxaDX9KavQ4wANGndXOXES48B7tCQXZx0p9sR5JLADXfC?=
 =?us-ascii?Q?Stk6YHsFkYDuZrOV2WZePIi0aPUbkCYt9G11C2vyJV9eBqsDq8zo1aZpGKk2?=
 =?us-ascii?Q?SEiHykvyeC9D+WM7Y606PwCgysRVRdxywhGXaj0LVNnqKcPjXtOvKi8mCqTV?=
 =?us-ascii?Q?vBIEZCYk6QZyovEGydW+BxiW2OqfDXrVLSviZScULP/wGEM3cenKDQku0I/v?=
 =?us-ascii?Q?Cx2YjSCyZtEmDoLCt6ayRvGN8ywYzWRPiQ/wis3Al51TJN3EWL2s+OjVayVZ?=
 =?us-ascii?Q?gr+xSBW6SBePri08iIKwHqRqeqqu8Q10YKtkHkzAaAwuX9F2MmU0wtFTodbB?=
 =?us-ascii?Q?VIHA9bRbfnPiQFDAWqnRY67LLVAAYF774d3jNCkykcbZMk8dlBFo1TWdKcco?=
 =?us-ascii?Q?S8WP39gcqnapU1vQI31pIiPOlC1EJqy3xk9aAWt0ExfR0BmzbUQYoLYQ+oTH?=
 =?us-ascii?Q?E6BryHpiJ80apiVpozhUvBYTdqi8s73hFlt5UxS0bwxjEcoDmHmm5JrAnNYp?=
 =?us-ascii?Q?uF7SMzLu/RrPvE3jDyK7pdtJydE6KKl4T0af2yStvW1c3ZCWLXWrdPupRzdx?=
 =?us-ascii?Q?iS7c2MSVKCVRgHaCqoAQvxt+ZhB8YY4vDkJeGfj9Odx1bLyZ1UZKOWoETU7a?=
 =?us-ascii?Q?/fwFDOKcTVf1YTNUP2jA0x24pv1Mmt/TgJoqETg6Vsg1okYTGc5PAe0GApRa?=
 =?us-ascii?Q?/BHULodHWZ/C8H//5GPUoW0jaze2UHjaImDAiq1YowchsJe64YDYqoqwI+hg?=
 =?us-ascii?Q?Z+ryEwbojDDxqRUdprioBbjhBfa1gViaVrDP9JZK6JWWt9zQwl/bOhdFx/6B?=
 =?us-ascii?Q?wegSbeJ4JnXWAzoPP3aTZoLnBQsQsWsAKds3rgXdKXUFPLVEc/uowN1kyJ25?=
 =?us-ascii?Q?HPtt7C2sTtOZU2oWAAaFG+1QySiy+pvpQ2+if3vWiid3zX1tKDR0Kz+0JfmX?=
 =?us-ascii?Q?THgazYkQlCBEhUCiTcrppCZs9nvNhWBuiSjT6uRxytW6aGes6SSCzbYXEltB?=
 =?us-ascii?Q?6GCg0xmV6rgc4pHRbTKYOpdMzq5JrBRY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cJh+nzm+D/IK6PGPEZ45ckRjJwgVPJE8gxQXerwnrifVA4K3Cj0ZAviM7RHl?=
 =?us-ascii?Q?3XyYSRawu/cB3TfiVlIdiNQh/8wYXddhAJCm1QK19lxhh4NEavVjfQjEJ/eV?=
 =?us-ascii?Q?GszJ3q8UEwzNHokGc2YPALJPFhFZvH8wFu7GiLh25xWP0gOYOdNSXFFP+fmg?=
 =?us-ascii?Q?LnHnRJR3Za4Zy9j7QlyzKMyNCYyQN+jsHyVxwEmF8SaXEbZBDDgXnED1cyzZ?=
 =?us-ascii?Q?bAPfQPAID8eii6Bim2hxF4EyHuwiGhyWRtTkqW+IC506YsgHWBoAAUwF35xQ?=
 =?us-ascii?Q?SV1Q8qxv36lxGrxjewdbnJvBjtj8+MGYQnVQ2ePHCy/GgDz1zmEZ13sOs9Q6?=
 =?us-ascii?Q?WX67mahPpxWuS3CiQFhtAZ89udoFwsQ1m0+ldlt0RBeHCR27cAzhfFa2t10C?=
 =?us-ascii?Q?9hQD48Jy1rtJKZD8paZjVj7+5PZftbi3EMGnbw7h6OnETaJTYJSbsdJrLApw?=
 =?us-ascii?Q?35ne6mPfozH8jnT8sHjcaPIqIuiCHiUb0MhSVwJBcdKIbM5Nl9CgFWdMFK3W?=
 =?us-ascii?Q?reG+YktGfUMYYR+xm56WfQIJN22X482fszyoTEbmQocVF2JobNK3UzDMcmOw?=
 =?us-ascii?Q?ZThVkxam+TdAijcZZ8rqCeTEkLL1mvNm81xm5yXedhno5tm157Rgqp+Iiny+?=
 =?us-ascii?Q?7zMAyaGw0ZrmGLuXm54uXZ5Vg+K//34el22ry4mmbvxwHs2COSUsm/hQkAXk?=
 =?us-ascii?Q?Jx2woXWa79QH12gJJlC3iZD22adduMWJmMMtOyhevbjuruNNWXBeaRWCg2BR?=
 =?us-ascii?Q?K78hUmUY9ajIbSYJkdtReiDMRviDRiUzi2hn1NJfz5EgC/C4bdnCJyKPB8OB?=
 =?us-ascii?Q?CBaaB0FqCyiWuk4FS4M9/X/1xy0wqpRkUvCZ70O054ptthSnlja93BqfUzMJ?=
 =?us-ascii?Q?h2lIzrvdVS89ydjiPvz+gf8QmSYUNaK5/SqApWgAqmhlYAAsV2KMxjYBig73?=
 =?us-ascii?Q?uKVDWqjof7mDwnfMLxnubnPdBZ27h44GSLwjIDD66K3n12f7NzYZ4XLAfxkI?=
 =?us-ascii?Q?cL4SCmmwhZ9ykI6rOPOhN/0Z+mYSU70gV5Hm8TapK6ESFhSe1doBYuEWeaSg?=
 =?us-ascii?Q?vdaZWV7VYmnHpbjz98nOaDD9i9wH7soCmW9zaZR7PyNteZ5GBmxfKyrt97ga?=
 =?us-ascii?Q?mBGLAsnMG/ZlSMO7HCUfQLEbZJOcDbALI9sxKuQJP1ZRUoFealL9V3dqMZjR?=
 =?us-ascii?Q?m7o353NKvNZC1/ybZA8SzneiJOipEikWPU9cvKoGMyYMGtfOXv3ZpDvFZUN1?=
 =?us-ascii?Q?Lu3F9AifGmP+TlZo0AiJCqRDGi9MrUTKXVQrkGZooPJaz9wLcZpmRn1mBdO1?=
 =?us-ascii?Q?bxSN0HZYCBY1umOkN5y/CKumJ17vnokAruI6oylvojghAQIBwRr5l6ifsfGd?=
 =?us-ascii?Q?erH/xf1pmt6MlwXA+s4ny6/KrsPgZGZrBFNuZpX2JyrlD44eQQoBzxYxw4C9?=
 =?us-ascii?Q?pX9JhYi6go7sZHWIsvI+jnTcFwfG2E18raYrLgf5QD4Pi0VL/a1wsEFMZ4IM?=
 =?us-ascii?Q?YsmGc2XO1Ff4+HaiT93PKKIBPhDSa1tez8VODaZq2bdtXW+J8ft8obuTvN2J?=
 =?us-ascii?Q?/90DnOMvIhcFg/z3+kTtNqxFSu/l58ohDWIqRXRIvtTlSMW6OUzba2pE/Yb/?=
 =?us-ascii?Q?a8NQMXLjl8+RUlx352VEcTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F0F47916F0E6140B906D4262242DCD0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dQJ9+HQLMNyp5SYINB9wjy8kEHtUeW6QmjMrUtsJWYCzs+5r+UwvwUlwQNDuOtUr+A+2OULoP/jBQHDh/O1VnER1rJ8sJP/73Q8iTaQTdGDX/yaTUjUjBmfqFuGBN1/9mI5KcCeOeVCRVGH3COx4kqImfqXNl67JVm0AS5wpeMHtAr+OwwuSC2m6uuiRJ+wunOXpjdtaKD+2U6KsVVscUccOiTnUI4IHvRBLInhUvk9WGy+knwgCveQ2YurVTVykK8xjk6d2+ASQn8z91aFArGVm91BYDvQnUSKlj8cKUfEBq3VNwxGm/epAPfxek0Co4y0Hvo6iakNfrO8RrBNGFRPgVczi0Gy1auUyqDTCfit6JfG311VYqjPzb4oYsNu5cO8PivPVC+r//PMMMDHi2uw+xklvjZXfJh1LJn54bLqE2IPfhrXVw/TU5e6KWStPjUAr17xhVCF2osVh6kdEGM/iErmmwS7dOjiuSomsxwqgSbMCHkj3HrKJb10RWma5eGK8QS40uI9WS/O2gwccWWMmUub0D+zUqMDaQvQLc0i0l5rYgXntuR4b1ISoinBwt0EZyIKgvK3P2WVpGpJGsTq63EzX/P0ttZ+MyCQO9G3jEDwzQeJdgWvm4i+6PQVI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84425f9-6c98-473f-4b67-08dd4bfe578f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:16:31.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6SWBAuXkADvf/pvM0/z+QOyg2xniPiygOYTipEmvVo4bQ13u651kZs+T8/HdgJ8/rLxCQZzm7KdyyAuxEx0gTEkmoBs9CRPJk3MjZKRioA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201

On Jan 09, 2025 / 14:30, Daniel Wagner wrote:
> When a connectivity loss occurs while nvme_fc_create_assocation is
> being executed, it's possible that the ctrl ends up stuck in the LIVE
> state:
>
[...]
>=20
> There is already the ASSOC_FAILED flag to track connectivity loss event
> but this bit is set too late in the recovery code path. Move this into
> the connectivity loss event handler and synchronize it with the state
> change. This ensures that the ASSOC_FAILED flag is seen by
> nvme_fc_create_io_queues and it does not enter the LIVE state after a
> connectivity loss event. If the connectivity loss event happens after we
> entered the LIVE state the normal error recovery path is executed.

I found many test cases in blktests nvme group fail with v6.14-rc2 kernel w=
ith
fc transport. I bisected and found this patch, as the commit ee59e3820ca9, =
is
the trigger. When I revert the commit from v6.14-rc2, the failure disappear=
s.

Here I share the kernel message log observed at the test case nvme/003. The
kernel reported "BUG: sleeping function called from invalid context".


Feb 12 12:03:08 testnode1 unknown: run blktests nvme/003 at 2025-02-12 12:0=
3:08
Feb 12 12:03:08 testnode1 kernel: loop0: detected capacity change from 0 to=
 2097152
Feb 12 12:03:08 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Feb 12 12:03:08 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
Feb 12 12:03:08 testnode1 kernel: BUG: sleeping function called from invali=
d context at kernel/workqueue.c:4355
Feb 12 12:03:08 testnode1 kernel: in_atomic(): 1, irqs_disabled(): 1, non_b=
lock: 0, pid: 68705, name: kworker/u16:14
Feb 12 12:03:08 testnode1 kernel: preempt_count: 1, expected: 0
Feb 12 12:03:08 testnode1 kernel: RCU nest depth: 0, expected: 0
Feb 12 12:03:08 testnode1 kernel: 3 locks held by kworker/u16:14/68705:
Feb 12 12:03:08 testnode1 kernel:  #0: ffff88813a90b148 ((wq_completion)nvm=
e-wq){+.+.}-{0:0}, at: process_one_work+0xf20/0x1460
Feb 12 12:03:08 testnode1 kernel:  #1: ffff88813b397d38 ((work_completion)(=
&(&ctrl->connect_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7de/0x14=
60
Feb 12 12:03:08 testnode1 kernel:  #2: ffff8881ab5bc018 (&ctrl->lock#2){...=
.}-{3:3}, at: nvme_fc_connect_ctrl_work.cold+0x2200/0x2c9d [nvme_fc]
Feb 12 12:03:08 testnode1 kernel: irq event stamp: 140088
Feb 12 12:03:08 testnode1 kernel: hardirqs last  enabled at (140087): [<fff=
fffff90e222ec>] _raw_spin_unlock_irqrestore+0x4c/0x60
Feb 12 12:03:08 testnode1 kernel: hardirqs last disabled at (140088): [<fff=
fffff90e21fef>] _raw_spin_lock_irqsave+0x5f/0x70
Feb 12 12:03:08 testnode1 kernel: softirqs last  enabled at (139874): [<fff=
fffff8e5158b9>] __irq_exit_rcu+0x109/0x210
Feb 12 12:03:08 testnode1 kernel: softirqs last disabled at (139867): [<fff=
fffff8e5158b9>] __irq_exit_rcu+0x109/0x210
Feb 12 12:03:08 testnode1 kernel: Preemption disabled at:
Feb 12 12:03:08 testnode1 kernel: [<0000000000000000>] 0x0
Feb 12 12:03:08 testnode1 kernel: CPU: 0 UID: 0 PID: 68705 Comm: kworker/u1=
6:14 Not tainted 6.14.0-rc2 #256
Feb 12 12:03:08 testnode1 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Feb 12 12:03:08 testnode1 kernel: Workqueue: nvme-wq nvme_fc_connect_ctrl_w=
ork [nvme_fc]
Feb 12 12:03:08 testnode1 kernel: Call Trace:
Feb 12 12:03:08 testnode1 kernel:  <TASK>
Feb 12 12:03:08 testnode1 kernel:  dump_stack_lvl+0x6a/0x90
Feb 12 12:03:08 testnode1 kernel:  __might_resched.cold+0x1f7/0x23d
Feb 12 12:03:08 testnode1 kernel:  ? __pfx___might_resched+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  cancel_delayed_work_sync+0x67/0xb0
Feb 12 12:03:08 testnode1 kernel:  nvme_change_ctrl_state+0x104/0x2f0 [nvme=
_core]
Feb 12 12:03:08 testnode1 kernel:  nvme_fc_connect_ctrl_work.cold+0x2252/0x=
2c9d [nvme_fc]
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_nvme_fc_connect_ctrl_work+0x10/0=
x10 [nvme_fc]
Feb 12 12:03:08 testnode1 kernel:  process_one_work+0x85a/0x1460
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_lock_acquire+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_process_one_work+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? assign_work+0x16c/0x240
Feb 12 12:03:08 testnode1 kernel:  ? lock_is_held_type+0xd5/0x130
Feb 12 12:03:08 testnode1 kernel:  worker_thread+0x5e2/0xfc0
Feb 12 12:03:08 testnode1 kernel:  ? __kthread_parkme+0xb1/0x1d0
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  kthread+0x39d/0x750
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ret_from_fork+0x30/0x70
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ret_from_fork_asm+0x1a/0x30
Feb 12 12:03:08 testnode1 kernel:  </TASK>
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: controller connec=
t complete
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:0f01fb42-9f7f-4856-b0b3-51e60b8de349
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association create=
d
Feb 12 12:03:08 testnode1 kernel: nvmet: Created discovery controller 2 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:f35c1212-8678-4a7f-99e5-05e61788783b.
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: controller connec=
t complete
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:f35c1212-8678-4a7f-99e5-05e61788783b
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association delete=
d
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association freed
Feb 12 12:03:08 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 12 12:03:18 testnode1 kernel: nvme nvme1: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Feb 12 12:03:18 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Feb 12 12:03:18 testnode1 kernel: (NULL device *): {0:0} Association freed
Feb 12 12:03:18 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 12 12:03:18 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found

