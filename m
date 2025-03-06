Return-Path: <linux-kernel+bounces-549711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27298A55653
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276173B3297
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066726FA5A;
	Thu,  6 Mar 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="gB1++xkc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD626FA78
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288382; cv=fail; b=EoQrRhm+dvtIg3FUV/xnGLsrATvmVscBbL+SSZ3SeZiurixkMtkun3o1gWdszoT1mw9ncBYiusRChUdZiB/4ddtaKKBOgeRkghorAETMV/FUGz8ber2VWMa1O6OTJFGVbejX2FL9mN75DRwVc6xXbkTTlLJ+S/Wrx4qO9BUo1s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288382; c=relaxed/simple;
	bh=EEEgx/d2YWEOf44SxCpK9gosr4e6FT6K0W3fsVtzTNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1tOydtAF6YbtNRvqApmHVsO0aYQCcE7LfE8KmzZvpawhsQ+UVTgqneQXnTpd1BtpxtgPnmM6FBH5ywuyllMUYtvzbnd1MgvsKFusuyKAkfK0a9UzCz8Yb55MZZ4faKRq6lKsfG2MhR+BVH7ZKmvF6KymAi7CCvAZIS7QS7RwpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=gB1++xkc; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqNbaet849jIzsoFnJdNX2d17KP5CZQgqVOHGxpuVaEpQIUHj5d74YXCMDupP4by3QsiEAwXhYhSoYJuOj7zVc1Q8IfvcV2IYU78SxRlsYdYKIeleYEgOH9Agt5AQW+/RduXuxRicN8NeJpbWbEvjwhdipFHYb2GAzMcD+Uwm76bbV9tz8D0VhfXyTzanZ725p68vaTjfpUySMW3BgtiyzisaHCIt3GZSQF2e3pJFpsueocdxs2xPlIng6Cq//LQryE9uCOTTt0KhSVARgkS0Gzd6uWAzBj8whD+Erwtxeu5Eo4rcxrSh5bofahEVbMk+HQRSoSRqqca4XH5hyPvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UNFexHNT2dHuBA5OuQ9xq5OJqftc8JBVKQ5cVqe+j8=;
 b=tJJss7sxBe7nK/I3OSqkOc7+cp0h3q7eHsebsQivFUCQzFqb7izYdj8+fHf9yh+gri7BkvliNLKO44nPKXRcTCiM8ZfQ61CM8ozKZkthEkSHstyc3PcbXynVauY37jZqEKB7r0nPqnZSvqc6QuJQYtKSFO2lIRqUYcJ4aFsa/jseu9M1s4xHfDznLR7L/qz9+vMPZe0Wa8h+IPL4x74mucmAbCVButHkQ0zQHwUxJAheGoxEVMCVlTu1j6xL9PvGPvA9r7Muj1h8v0N87fgzozYDWR4Jsi3vlvAnYvGMTE4L6JL0mMw/CrICT8eCX91UJwgWBcPlQnwbx98oYFQ7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UNFexHNT2dHuBA5OuQ9xq5OJqftc8JBVKQ5cVqe+j8=;
 b=gB1++xkc1xR9YAmuIw1prvxwZ9c2XhoT/Fpd9DAe9hfoCewKyL+T/ks4DM+lCxCHGnnA2ElSGru6O5APzTzUPzWjGEmWxLUCupD0sNwljZiE+yMnI3ckQHUyAFZf3NpB2p9M9PEgwtnm229NM1cKEAy3t3UIFNboLri+l/rDfbk=
Received: from MW6PR19MB8110.namprd19.prod.outlook.com (2603:10b6:303:23d::14)
 by CH2PR19MB8945.namprd19.prod.outlook.com (2603:10b6:610:282::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:12:57 +0000
Received: from MW6PR19MB8110.namprd19.prod.outlook.com
 ([fe80::a7f8:f7b9:f04b:f537]) by MW6PR19MB8110.namprd19.prod.outlook.com
 ([fe80::a7f8:f7b9:f04b:f537%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:12:55 +0000
From: Kit Chow <kchow@maxlinear.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Thread-Topic: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Thread-Index: AQHbjghVdFcw5+9Z1U6qqHaQNfy9r7NlPimAgAACxXWAAAKXAIABNKmH
Date: Thu, 6 Mar 2025 19:12:55 +0000
Message-ID:
 <MW6PR19MB81100BBC506D295C5FB2BD5BA4CA2@MW6PR19MB8110.namprd19.prod.outlook.com>
References:
 <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8jpi5nf63APb8aN@infradead.org>
 <SJ2PR19MB80942BB17ED2D5B34AF2C230A4CA2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8juCusc7oA2VG9v@infradead.org>
In-Reply-To: <Z8juCusc7oA2VG9v@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR19MB8110:EE_|CH2PR19MB8945:EE_
x-ms-office365-filtering-correlation-id: 3c97c464-fa56-4963-4c37-08dd5ce2e64e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8uD4pBw9ClGv3yoqiz7IZhwC3+f7OcNJFlwYE+kfPiUDvxKhEH12Dlusbk?=
 =?iso-8859-1?Q?q8CCudUcDWuna5idGG6UymAwyfPDm5IjMjGVvFJyOzjJAcox28QEPvZ8WR?=
 =?iso-8859-1?Q?7IiTB++xAuMTVHFeHKRUbqZclfIdZCzUtKay4D9E4Ok1nXpkMctXRMvS7K?=
 =?iso-8859-1?Q?t15/5+6521kbX84GuPYdu8LMs9ETIgiWfLj/SukvoODFkNk/zhxE+pEjd/?=
 =?iso-8859-1?Q?DlAjFDa7zyZBjwCAtCi/zVvDKlECBYM2qjbx4hikLN8AosbLYNs45uVuRt?=
 =?iso-8859-1?Q?Z+ccGqGw76MAfygT79+ne2EFGrPLFbIxH4LDD4xK9BorY3eMfEezLGzhg/?=
 =?iso-8859-1?Q?+zTVvK3d+4SRRlFAzKXAHHugJsZiLcO13T8/tbDP2ZDiZKfRyAAVxGBppB?=
 =?iso-8859-1?Q?1ykKpsNtCcUrtV2e2eAMvQfOpunJ6JmxCxijmr9ZuVakz1mxF3UJc8Jilf?=
 =?iso-8859-1?Q?Po6kfgRmH5h4GDhNsln05h0lPUOfElYvB1RinRNchW7+sELnn2F+2XA75t?=
 =?iso-8859-1?Q?TAe+xdvwScKvEUJfREUdvZez07Dr4erdRbHe8FYAU9AWMp5J5Adw/+65Ri?=
 =?iso-8859-1?Q?+zjem5q8M0ZZWPASCaRDMgWkqDoXAPFSraclhDFgirO4th5WZpN8GnNpRZ?=
 =?iso-8859-1?Q?MyUcRVICgmtVR7lHPoJXThVE183Lseaj0ILoP4KTAMPNLX54tp+rVNJTD6?=
 =?iso-8859-1?Q?wg3GHy1OjfF0Cl5Q485+hL/sm004eYt0eTniOdZwyLqTJ9+snMHGQWVV0Z?=
 =?iso-8859-1?Q?6ZoEtwk1Fp2fR2XlKIIdx3dd4+QzeYKTIa+aXSfWvrv4nwnRU/VwkdQx5W?=
 =?iso-8859-1?Q?D4NOvYX5FfkGbSuQbbq9+tu0CLYYVsckjDePePpFzgVrjpCxk9KI/uGZne?=
 =?iso-8859-1?Q?6qpKeV+ONPByUWEPD1qFi4yt4JFSyxltzwpWw4K1izm72CZ4FjjGY12XBw?=
 =?iso-8859-1?Q?YvH/EU88cmZMe8w+zbxH26d/j5evalDy9YP/j1+3pCR152qo1pGYtaPEYv?=
 =?iso-8859-1?Q?Qt0GKHZ3QqI/Sg39S3JJRU3XZNsw0XtCPFXpWACeVU0vmLcNn5dGAgdcRK?=
 =?iso-8859-1?Q?1J1SvGANWNmbKpVepPaxeAk3qVncQXKYORAzwoihQ6McEbwNSa3C2Drekq?=
 =?iso-8859-1?Q?QDMlN2Bw28XYIhClD2iXaJQQ2FGcJoxmpFR4Mkm3/UlvYz/2I+S/AwO2m8?=
 =?iso-8859-1?Q?8QHMVSY4LlB2d7zA+Y+UyZrymnFDJsRc1IHmRmDIf+VyQgRJG5OFoL7rEd?=
 =?iso-8859-1?Q?mCjd4SeW9TNAbk8cZuge3bcinIdEqXn74AxJQprw6N+VCtvMDmRy5gPavg?=
 =?iso-8859-1?Q?hi2MGqkFaKqObcvSFEjBldHV6F4t2p7SiJ40r0jMfQpWkne1M2pV5I9HeR?=
 =?iso-8859-1?Q?/oOa4TTlhRGD10lvUD4qEy/qg4Z8bdZ9qxj/ph5Oq85dvZ4bKkKLplNvP1?=
 =?iso-8859-1?Q?ReJVrWtDnsu/50ztoNd1U10jIGpcptVdsB3t7xx0xtMVi7ni0JTHRGKLWU?=
 =?iso-8859-1?Q?jUbgIT1nG4zSXStP/XNloO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR19MB8110.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z5p69ANQqpc0RLeBQjQLY/NyH1FzxT7o5PN4D+bhx2ngtU2jaEeFjdiu3a?=
 =?iso-8859-1?Q?waJ9IJx+WCu1rWr2a/iRbjqGj1SZspMd9Lz1R/Yipgky3SmFFjYUfrx7w9?=
 =?iso-8859-1?Q?pa1uGnU66y3uADSid32BBZAbCHqft8j9kMCMj3qN+sLZ3L80WFTNsVHXXC?=
 =?iso-8859-1?Q?ylzpIE4qCTmjtuq2sYm3Vla0xrx7wCQ5ob/BgQpUS8uDVlSRMIcaiShiPu?=
 =?iso-8859-1?Q?DOEayJYTzv9DGhSObT8W8XXsjYHwppJ6NofUBkEuonAQUBMAHvnimQLhtu?=
 =?iso-8859-1?Q?ImjAEtkXp3r9iwQkboFG0+m6uh6Wr8IgsjujMBaSY5y4+R7PxX7txmAnVB?=
 =?iso-8859-1?Q?usxKYn6COPHZzkCqyo1d6lmQHfpe+KouJ9FyO7Em4qhzRhwFZNlP8rHACl?=
 =?iso-8859-1?Q?1x9IAdhIt0Bc3/AI0eoZY2K2XA5vH2cuJWVezVPSuN1ri8mBFkTyKRX6se?=
 =?iso-8859-1?Q?cZOPZlYvjUF+XQ06JFoTRvFabUjcSKkvVPVhuBNCE48/1fcqdNxICGKBot?=
 =?iso-8859-1?Q?VZPOnsUZ4j7jOtGmZ9IZocUkH4xHebaa6ON6tH0kUmirrcL08lAEmNQOYu?=
 =?iso-8859-1?Q?AG9Ejihktsu4IuXQCjCnnHg4DBZCQ6JHsFU4F24ps37vpb2I0Sj1f1jEgy?=
 =?iso-8859-1?Q?vi3iqb3yzfUjCd+mGxSIeJlHlpzkUVtJPaM1YHFZNeBeEbXTaEPU4kGhXF?=
 =?iso-8859-1?Q?BflceIjgPkjlHis8jz3AujaW6d6FoYEe4SuSUYy0EE+xj+Y7zHcL1PzIU7?=
 =?iso-8859-1?Q?9T98PlMwngMkEqufo32cUf4i/oLDxiJt9xk7VDxghj9yZnASFYMaEEgfNG?=
 =?iso-8859-1?Q?LSXcSrXwaJw1R8P3bMWBjSYzMb04egpq4Vn0fE5QklJMgY4Qzy/9N9DRrA?=
 =?iso-8859-1?Q?/sEgDwcADRAKvsUDQDTs1fGJ23C0e5mPRrJEPHP0Tqk3dKtLnP5yDmWdBn?=
 =?iso-8859-1?Q?CDP/HG4alTzlpOd8f8UKytuW619AOCxlUXy0JnJIo1F//2EKyaGG947sz/?=
 =?iso-8859-1?Q?eI5G0r4jhy7snPMczSPGsEIvuNHoL/KDm78+Pu8vDhXPdimiD8KZ9oIfWu?=
 =?iso-8859-1?Q?bbG/8a7wc+JGPYhcwKgV437YctvH0LMwu9THgLihbf0C/UIAy6yHlKZBQK?=
 =?iso-8859-1?Q?rvQ8WHnMM5hHLbVlCFgXRe2u8Fa075wXA7OFr32PG3C2lz+5JRovEL1bsM?=
 =?iso-8859-1?Q?qcUtYVbbj52MgVgJkfa7CRKPMSASZrtCZASbvHubvP584w1mYgUuBYOBWe?=
 =?iso-8859-1?Q?BN9sJgtfNs0TLlCiqzISyUgWYWDfsOutCsbTgYJVFUGIvjCVb/HhOWL67W?=
 =?iso-8859-1?Q?8/DKVFxhgNdQxx77mysu5X+RnNRAcd+65pdhk0IkXSwfic5lcI7QkSTR7B?=
 =?iso-8859-1?Q?VDIzqzw4AOhxvbs5Pvy9pBnk+NKcIiG7B1EoA9grFcwgAmQ3AN0l2ew4LT?=
 =?iso-8859-1?Q?PxwHEhTHnnwFx7IB3A//54Q8K2jGwEBHpqqhPZsYkfPUEM9wXCkV9f7qLi?=
 =?iso-8859-1?Q?+njVTajMO1hNfkJy5Q6Bier0xhFRLlnEXaM7Wt1V7AgwCf5nAp6aFpSrIX?=
 =?iso-8859-1?Q?5l4kcQeEdL/FwB9T6g1iro8LMd7ROH+OoQb3BxM1nUINRENZqVMqIZ0+Lz?=
 =?iso-8859-1?Q?jWurC2VYzMx9QD6cXcSpzSWfDCjAni6hKU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR19MB8110.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c97c464-fa56-4963-4c37-08dd5ce2e64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:12:55.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uD/abX5/8MkDLzi5KTxdF7tfSeS1zF5C/e9xSlJVg3HuU5HNFEGisvBgFNAh9HjXtZjRf9ol5b+WrqtPg7CGIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8945

Hi Christoph,=0A=
=0A=
I will humbly tuck tail and go away but first... Can you (or anyone else in=
 the know) please provide some details about how you determined we are in v=
iolation and which of our "slimey" products is violating the kernel GPL lic=
ensing?  Terse statements about violations aren't very helpful.  =0A=
=0A=
I've spoken to management here and they are perplexed how we are in violati=
on of kernel GPL licensing. Please, please shed some light for us and provi=
de details about these rather serious charges.=0A=
=0A=
Regards=0A=
Kit

________________________________________
From: Christoph Hellwig <hch@infradead.org>
Sent: Wednesday, March 5, 2025 4:36 PM
To: Kit Chow
Cc: Christoph Hellwig; linux-kernel@vger.kernel.org
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotpl=
ug as out of range

This email was sent from outside of MaxLinear.


On Thu, Mar 06, 2025 at 12:30:48AM +0000, Kit Chow wrote:
> Hi Christoph,
>
> Is the kernel licensing issue causing the shrinkage in hotplug memory ran=
ge? Can you please provide some more info on how MaxLinear is violating ker=
nel licensing and I can take it up with management?

Your comany sells slimey solutions violating the kernels GPL licensing.
You shoul be ashamed in a corner and not ask kernel developers whos
license you violate for help.  Go away!


