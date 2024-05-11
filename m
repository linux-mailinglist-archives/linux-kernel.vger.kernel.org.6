Return-Path: <linux-kernel+bounces-176612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B478C322A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC141F218AE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB95647E;
	Sat, 11 May 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="cAbkSRKt"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2103.outbound.protection.outlook.com [40.107.92.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE365336F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441787; cv=fail; b=WZyRq9umUqkXJxiKhg7b2a/rGVYKOHW/iytdsZQhTaUKKeabwMFLUHmwwCOgy37et/10qy8Awqj7QCiqn2GYVt6oABJ3Zl+9JtVeOhBhN2JV7Bw15X8thICDB24kgg30TGA7dbrUB3IVrIZw6fBSihOSPimm0zB2O2EN22s9q2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441787; c=relaxed/simple;
	bh=dh6DyhOWhlaV03Fm4GmJ5ntX8raqcAAJW+vSPjf6IYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bgRmppMmgwRh7hjnXYj7GrE9IDOZ5vnPzd9wMeAf/4fZbC5HoXtSNxyC3+PNZoPvLzEP5Ur1CSKmf0goNlw6KO4C+TK2m0PTnfo6jqq3usqCFVEm0MEgSswLYleYYUzKvlmG4PW7VLzEY5ZA+Tc0YnIQGD83DmtkJgZLPM68gcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=cAbkSRKt; arc=fail smtp.client-ip=40.107.92.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB/7n+x8V9+KWcTp6JyarEwMfx2HppxBjC8WQxDISKgp59Cn7B/VhL4K9lGnxaw3r4A/Y47x8div4NI5EsYAu2BoUbn/Ac2g6MgcsRYtwaujnnhxfZcaBJGMxFZCUDk8uNtiXD5TptxnMvFvbcgP849TYsfPxYTsiJMUR//8HFuvTGbVrFNqPG8ywM0Yt0ELzfedrCETJ9xudwPD16+4BOe0MFsltwjuXIjVE2W3GYOdglVOrG/ikeezvivwDqQKlW5UjjPMO5mBSGqPRxVQ5Beto9yIOfIF0kDAzHoCpHKo4N2tSBlHvCG/Kmlp/3bySiTVOyj2Hl7GMcum1aLW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6AqEL8h/LaWaHA/3hsstGIAvKJ9mNr0YVDDdeKwZRU=;
 b=PPLsm1c0xCAJZbk4LtY60VrqKHSP3VLIQjr7GyMGHz+aEMDBmZeU9LOXgC3pWkgPzdRun5aYv4dy2xFRa8vDXPq9xIM5hXU+tL+SwLb+coW6CMZG9a2XykaqkFeOCB2q97oBwiqSl0UR9247PqH/lCprNJbW6/T8SxlYzD5Etx/Bqsw2L/5GnBfLWHyQLbuqj44tf5y5KqwFji/rXFfQk+29Ab7/ZglEBIzweK+JH3et4ybx5NWWfLIAdFod5VybooFwxjFepbE9LkzkDGZdLagV5vc2QjbmNPXCdQh/OKihwojvhtBL3DJHWNR5edewVjkbKbEIOVIzBLo7gOTQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6AqEL8h/LaWaHA/3hsstGIAvKJ9mNr0YVDDdeKwZRU=;
 b=cAbkSRKtldCaazC8XkGDoO8XHXA8GyG+PjjIHQau9TppX5CM776K8SSmh5wY62ZvrWDpxJGjNMIk/VCsNfoHm5jasGbEp4dG97HqleYDVhEYb0SxhNevrZBSqll7nNuNTCZzJjLEesEB11mFqxYqFjnAJlWNH542L7jsG++cTYA=
Received: from SA1PR22MB5493.namprd22.prod.outlook.com (2603:10b6:806:3dc::14)
 by SN7PR22MB3979.namprd22.prod.outlook.com (2603:10b6:806:358::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Sat, 11 May
 2024 15:36:22 +0000
Received: from SA1PR22MB5493.namprd22.prod.outlook.com
 ([fe80::a308:2ed6:d751:9a0c]) by SA1PR22MB5493.namprd22.prod.outlook.com
 ([fe80::a308:2ed6:d751:9a0c%3]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 15:36:22 +0000
From: Jiasheng Jiang <jian1000@purdue.edu>
To: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "chris@chris-wilson.co.uk"
	<chris@chris-wilson.co.uk>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Correct error handler
Thread-Topic: [PATCH] drm/i915: Correct error handler
Thread-Index: AQHaoxG6TBQoAhaMu0CLAXku3n0QM7GSK3tm
Date: Sat, 11 May 2024 15:36:22 +0000
Message-ID:
 <SA1PR22MB5493FEAD09C01811F539A9D6AEE02@SA1PR22MB5493.namprd22.prod.outlook.com>
References:
 <SA1PR22MB5493ED5E56E154E77AE9C788AEE72@SA1PR22MB5493.namprd22.prod.outlook.com>
In-Reply-To:
 <SA1PR22MB5493ED5E56E154E77AE9C788AEE72@SA1PR22MB5493.namprd22.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB5493:EE_|SN7PR22MB3979:EE_
x-ms-office365-filtering-correlation-id: b4d26522-3ced-4b88-8301-08dc71d01c9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cA9TtHnMoKvPkpatkpGfH1mvkDoBF/dHK4tDZSqENCVZFzo9AkS6A3RG/S?=
 =?iso-8859-1?Q?f2hq7U7NTlAS3/niwTC4q2Bf2iIPIOw584iyMaG6x31latSLTcM/6zKsPa?=
 =?iso-8859-1?Q?qDuZxgXoQDvaHfqrfQ3digz/vQRLtRQcM0oif48G2eQtjdKLAsUlW9hAvd?=
 =?iso-8859-1?Q?CExLE3lgyDIIYd+af/gJnQn41/jsNfGG+WKzh4OsiwOWgUPP4HKGnK+q34?=
 =?iso-8859-1?Q?0nOnmw7FiF3tRfhfWvv/bcgdg5muqjqlfd6Yl5M0++05zOQG4v91dUaaZV?=
 =?iso-8859-1?Q?PGD+NGzaj9nZo6aEbBvmUsKQFABWzEuiNQsoi4Yej2BKcpqC9Ig99lRqL+?=
 =?iso-8859-1?Q?9TrgXTwUK1Vc7VkcKj36rS3OyyvYDZXJpJi42GoXD6IXUV1KI/viExpszS?=
 =?iso-8859-1?Q?ULkce6DpTyyelDdNmZeP/1hDh4TprQu6/UAvQk+NjFzSoOLlqbaPbhBKvj?=
 =?iso-8859-1?Q?o10AeABZ3gLrZ3ap0LBipt+s+sU9WtXzHXrgCxWOz2ssKaUKVzhG5FirW0?=
 =?iso-8859-1?Q?Md8LlLhs8JJAc58s3r8D2QztRubJDygHnoc4HouKIibRDccE7vzc3CD07N?=
 =?iso-8859-1?Q?HnDguCktKpR1e1GcBho0nMF1MUGy3iHtBUKbce2WwLFMuhhQR0ApCp2Qk7?=
 =?iso-8859-1?Q?4OctI6wPaG59lKqnR6tPDH2701mJYTP1zQlSXCQBE38c8y5GKqvUFGS795?=
 =?iso-8859-1?Q?0PUG9ZitaIw0oXt9Hq7b27dEFlsWU3TDXoKTOjcNYXIt0EaLwDqO0tc8wa?=
 =?iso-8859-1?Q?tBHRRTIW7A0f0Za/FKyt3YcjZnlX2iSM92xn+SJfF2PxSm67QeTGKlHwoa?=
 =?iso-8859-1?Q?Hul6zYxoZ244rRflfQm6F/FA/Yb5jGngN4cty7Kt5XNL1tBPRDNlr1qOV8?=
 =?iso-8859-1?Q?Fy7HC+EFQzQk+Gc5WvICC68YvmY4I2TA3kBjqOS8OpVhiSiPWvvtl6lv7E?=
 =?iso-8859-1?Q?YKrMxKN95mtMBpnVYiTtcO8U3N8/6493V9wpGG7biGTXwE41VjUeDDoYcV?=
 =?iso-8859-1?Q?bD5yn/UFtAd047BsPgQz/yJ6mEukMeBJI1M8mch7z0+5AzDTfKoTO3u/5N?=
 =?iso-8859-1?Q?Q+cbj6yNjMfwt0SRNj6DR2/8IzNTmEvQ5IGQTV/iJc+dZHW2ayTgD/BjCb?=
 =?iso-8859-1?Q?k2oKIW190YFj7mXFOKFME9U01DARC8sVkon+zEXNQdOI5FByoce/LFjdPQ?=
 =?iso-8859-1?Q?XrcrIwt0Lo5b0DF7j0dfZt9lgr6y9MHpGtTnvbLmwPWJb8iGyxp1ROhzx/?=
 =?iso-8859-1?Q?RFoW49hyWvdhp+YXT+o3WLeEm39YKbQWK+Wc9/0h3vxQP5BBTOGtw21g//?=
 =?iso-8859-1?Q?XRZxhpQj35o+BuYJnCctuxq/Y4bMkMBoA4gOCNCObJyzB25g3c05oeXCno?=
 =?iso-8859-1?Q?JNNfQqV/vUfqXGyGeizaQbysW0tv0ojw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5493.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BghCcSpTe+vk3rlWe0E/fm0RTaPHCKBTymUYizwzrCKjqJUBQ+S9n7Nd0q?=
 =?iso-8859-1?Q?wMqWUkEMj5mmT9aeEVamIJPklgCmbY7peaq1rO44HJ+QwesxIF+b6bNxhf?=
 =?iso-8859-1?Q?Yca5EZI7wKqFjywuZ99sLgp86gYxqo7TIuQ6A1SbzoBuEggEuxdfD8abNa?=
 =?iso-8859-1?Q?X5rzUwG/wZIEKFrSKMuenkthoi0j9AhwMykdRqgx823pMRlOOELqxOBeAh?=
 =?iso-8859-1?Q?H9Tk+WPNriUNvnKSN3a4YPHnNtaGNsXeEbxMxqG4XxbdWJzEqhaOJrusCY?=
 =?iso-8859-1?Q?4IOG9A6rPbVfV7BmWi2cjRd0+cEzF5pwOviSIx4g7ArWy4qz0btr5fWvg2?=
 =?iso-8859-1?Q?kmfbZUZSew2pSPcQcVfvCqLx35w/Xfaqrz6Kjc8H5E8QMsqwJ13eJ9rEei?=
 =?iso-8859-1?Q?TFiYQ/W7trEvRBYVjZe5eAFmLW9Fcg3m9DJQJSxWNWj4zGkamO44LvthAZ?=
 =?iso-8859-1?Q?dQWpEDRfc1Vyu+/g4fjUfqHcd3FWiQtUOONYIhCCDF2qddQxzcAgIj2fS9?=
 =?iso-8859-1?Q?SrGOnblV05xG5WYuJZloqDYKsaImZ91Up96uZCcfo3k8llsi8Wflzx/7ww?=
 =?iso-8859-1?Q?f5qZ+vQn/3oV17+GjOugZ2bakuQRuS5dthd5B+bHC3u5fR5VoD+QaOXL+c?=
 =?iso-8859-1?Q?xCEQ5feDLZ2Cz/gfQmnhmZZtGYm+BjixKKU4fWBL13fcJ7CFsZbjem51os?=
 =?iso-8859-1?Q?E58FV2qyWGvvz3hgBsE7HRB67FrKeG8EmLoOX3O0hR0ziY0sBDVAx4bmlZ?=
 =?iso-8859-1?Q?3dg0V+Mr8+8G7GPurd0Gm7r0hSbAUcp3mOns4H/BYHmmym7bRo+Ce2wLnJ?=
 =?iso-8859-1?Q?tVe3ODxsqoLcPbh38BG5p9Xz4LsAheeAfgLE+sai+LfL8cYXltAKttpYO/?=
 =?iso-8859-1?Q?eA4cLWz5bFz3Q8mr3rkg2K3hk08bXKbwc5L0pZNmC9L+vaAyCQcYgBJhH7?=
 =?iso-8859-1?Q?9WKvhtQ042w4aC0CzfE0LAHdenSm5PUFV+eqN8HQBata/hmncLaxUFC/J+?=
 =?iso-8859-1?Q?QopA6D+yh/oRl6ADcTkdJVvu19XO86yhA94Qgoys0Akpj5tXX8KI1QjaDQ?=
 =?iso-8859-1?Q?zau6jyiQAaa8XqxBkYcMBDBIQHesnrW7w3seqU8S6n6MpFnHvcZ2rmoVR4?=
 =?iso-8859-1?Q?gF01Cj3zbgXqLqVWa2gy8vR5up0+DA0hX63VtR1uvkU7oxUTEl7Hv6q5C+?=
 =?iso-8859-1?Q?U7ujT/PDIVUYlTEZ1XNI8mY9sDupiYmcWM46OLHmlV3x7yOh9FfnYpRKPe?=
 =?iso-8859-1?Q?OZYbzLl8kIcDG8Wt/+4wR+NVv4gK9YZmUj7lIuk9r7RlIzYt/5Rs7omtGb?=
 =?iso-8859-1?Q?xJEq4PUOQ9xARKQSid2ok92N6kfRW1Ssa6TrOgVh1Zm7+rKD+VFXkndb7Q?=
 =?iso-8859-1?Q?BwTPF7iXVL8MrytjkJtsPTI+I2Ryr33GtMCUSSzs+waDhS7v5Ewlx2pDtM?=
 =?iso-8859-1?Q?UG9UZnAbM1enQKl2LQp8HOQnyBgT7UhbRHVpEFqF3X1xnUD+FbNFSqKXsF?=
 =?iso-8859-1?Q?t661Jsh2FmIyvvlNNGUWqwnmxea9ZgBUjXJD1dsSaiJyXx47/LJ9w8rUAz?=
 =?iso-8859-1?Q?nhfb08Xy01ELeq5PxFMlFbANj1qW8JvUfpZZHgXl6CG0pSCswVSaEed+11?=
 =?iso-8859-1?Q?R38PuPCnGCTzCzd+lh0uIxx3oeLZzYP4yc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5493.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d26522-3ced-4b88-8301-08dc71d01c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 15:36:22.6292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGSt1XeUigbJVv69s21PHFPGzZAXKvmtmO8v96q85w482SONnWHL+6nA7y37xQKPQy4LnJhnOPTaapgPahYAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB3979

Maybe the format is incorrect. I would like to use "jiashengjiangcool@outlo=
ok.com" to resend my patch.=0A=
=0A=
-Jiasheng=0A=
=0A=
________________________________________=0A=
From: Jiasheng Jiang=0A=
Sent: Saturday, May 11, 2024 3:40=0A=
To: jani.nikula@linux.intel.com; joonas.lahtinen@linux.intel.com; rodrigo.v=
ivi@intel.com; tursulin@ursulin.net; airlied@gmail.com; daniel@ffwll.ch; ch=
ris@chris-wilson.co.uk=0A=
Cc: intel-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux=
-kernel@vger.kernel.org=0A=
Subject: [PATCH] drm/i915: Correct error handler=0A=
=0A=
Replace "slab_priorities" with "slab_dependencies" in the error handler=0A=
to avoid memory leak.=0A=
=0A=
Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")=0A=
Signed-off-by: Jiasheng Jiang <jiasheng@purdue.edu>=0A=
---=0A=
 drivers/gpu/drm/i915/i915_scheduler.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/i915/i915_scheduler.c b/drivers/gpu/drm/i915/i=
915_scheduler.c=0A=
index 762127dd56c5..70a854557e6e 100644=0A=
--- a/drivers/gpu/drm/i915/i915_scheduler.c=0A=
+++ b/drivers/gpu/drm/i915/i915_scheduler.c=0A=
@@ -506,6 +506,6 @@ int __init i915_scheduler_module_init(void)=0A=
        return 0;=0A=
=0A=
 err_priorities:=0A=
-       kmem_cache_destroy(slab_priorities);=0A=
+       kmem_cache_destroy(slab_dependencies);=0A=
        return -ENOMEM;=0A=
 }=0A=
--=0A=
2.25.1=0A=
=0A=

