Return-Path: <linux-kernel+bounces-559310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE9DA5F238
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E92917CF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056D266185;
	Thu, 13 Mar 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LVOB1pKp"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825331D7984;
	Thu, 13 Mar 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864834; cv=fail; b=MXqpmPxD5tLmyljT5IF6C8sTtDYUWgdVjkizK09x/VB8rcm1f6eMMxZdoQN0Wrvg3dvkI+GI3tU1z3oqH7JwtFU9slON39rgpS1J0CwrGEU3ZFzgOO7Te0dc+T0Lvh/A2oBBJlWZtLPlqI4Hsx1VqFC/dRRG8km1O6156XC0Vb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864834; c=relaxed/simple;
	bh=FzD4ilIILSrUotbDSNcjfZZbPdA2al85CGsyBL1j2XY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mhTGIdl8/2Ex7I0VQa9RZtWGtJxDU5I2lZwCBF0jDRrkRD5D26lBwsTTFlAKz3UwYGsOo83FJBZLRZTXJqZyTvZMFviPUJLwRvoIF1GWuUgxK+FMdZv5VQlyJt939Yy+dHIl42WAUDhIRx4fMt5N18Dg1+CXRC/Iq4OFq8rZzgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LVOB1pKp; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAFCExGC/L9pUYGqtrYrGw0senoBiT+hCBmpdYXmbWEjmzKy8oXGalDs5qE3EG06DLJqqwtKjUEdDeQjxdBj30sFRr5SaTNnQVPhzk/UZt62q4xh6eXGWQFjQsgsM3gscY5sTlaDY00vSx14XXSrTuU4ocbfECXnEhSRuFBU8qLZXrCdO7a0nVqlxhxHWH67jH9wNioNpfUPpPYZPVlgOQ/L2hnFdJP9gfI5QV6Ze4oXJv6PO23zMuY+nSI01TCMYNI+Li/JkRL74SfFML5P+exrHkYAWWwlWd2vxE/i7n7IP6vdSyE1Sz5xGPQaIeB4e3DJcZ802Tyr59OlKKbGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWytK++w7efVge2S3HCDfNc7xFUv7xIt7O1G0q5iL4I=;
 b=pcwbR2hNILu4dSgSvHIkTd6eDmh2umPLwl3OJpGWIH6wzmUbLOpMisrs7KGEytLwtXEKmG+xoeps4qB+0RYI7AtPNT9W+bUOULhIzMGiGhxNoQTHfjRE6NVUGZy0iP9CejmZIyK+D/tXzEPTYIA7KOv2Iwp5cCw/GCTnaqg8At8IaugKQ2HtyVI3nf2ZDgzNPOleJV9s1yAEyULz1l3blYNo/VL8kR2NBH1Is8gNRLTrmC11yLwn0TYbgeX93EufW9BRBlQb0nTMMRxnQJWEJe40Asa8y2NzkloD3qr3KvNMau6EVPKo+8Ylrze976BbD19zcLnCZP7vNoufJ0edeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWytK++w7efVge2S3HCDfNc7xFUv7xIt7O1G0q5iL4I=;
 b=LVOB1pKpK51+nYgMCPLF/iVQ9ptQ0/3n/710E3scm1+XbX0DUbLdJ8c0oI7rYACg6IY+u/83Uj+RG1RVkYnK0s6OpG6t61nE3Kjwu5n5BQY1pscuNuijMyCGqh0ZjCWMi9ezxwHf7vk7AkGNzuMCXn4sod9kswwWHaJG9MLB8k9zzS3drJi5IEw0RKFlWopyex3XMRfoHNyxqublyFa3dapQohIs+Wxs3JBA5+hjBKpKQ8pMTGSwuGuOxAp0XcvU8Z6uir0Z6h27duwWdNisy+Anke2sA/gRvFzuVwPqnIZAkeIAKkfx98+V4D1BO8Ezqxl4WbU4PYDjcwchhyQjbg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFE52A1FAE5.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::331) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 11:20:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Thu, 13 Mar 2025
 11:20:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Petr Mladek <pmladek@suse.com>, "keescook@chromium.org"
	<keescook@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sven Peter <sven@svenpeter.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
	Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>,
	"airlied@redhat.com" <airlied@redhat.com>, Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: [PATCH v2 2/2] drm/appletbdrm: use %p4cl instead of %p4cc
Thread-Topic: [PATCH v2 2/2] drm/appletbdrm: use %p4cl instead of %p4cc
Thread-Index: AQHblAnqlC9D7gQL3UuCo+FWtohJUg==
Date: Thu, 13 Mar 2025 11:20:24 +0000
Message-ID: <C1C027E5-8B59-4F76-9894-98F385B16F17@live.com>
References: <F61E0F31-980B-4855-9AA8-D594BEEFEC6F@live.com>
In-Reply-To: <F61E0F31-980B-4855-9AA8-D594BEEFEC6F@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PPFE52A1FAE5:EE_
x-ms-office365-filtering-correlation-id: 1aeb4397-93e0-4eeb-e6db-08dd62210c91
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8062599003|8060799006|15080799006|7092599003|440099028|3412199025|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S+kcc90AozqBl2GOKBgtHnY8nYtP5bw3hmgIRz7RgiG2dAPROkolF9n92tK8?=
 =?us-ascii?Q?gu19mcJDsymDvWTyhRnsCLYuH6HoTUrN5QHE14Gud3sADRfqU1jF9TKf990x?=
 =?us-ascii?Q?3AT7dt63TSXyw4RMB9VxcJGHUJOkIpFHSygEGa6bjK10xsvqkXEg6xvE/g3A?=
 =?us-ascii?Q?aHTykuvjEtNxIabz62dNUaK/EZoAMV6G3zmh0upJBUUtyz9WUSJkdJRnye7t?=
 =?us-ascii?Q?2Z6IGTV0gPQZLjwQTXxrwtV8/wCQBUltdQZywcqqqtajFkQY7ruRfvcaqNkK?=
 =?us-ascii?Q?tJXhp9vwXk2FmF3fSa7mQI17z786uPTnxhsX9tW5igqq5aSuc+UF4PhBqVxQ?=
 =?us-ascii?Q?lxAaY0DHtMXNwukadJToljm2j3orl6EYMn796ZkSgfrid/uXc/gd5vEllAYW?=
 =?us-ascii?Q?jlxVNiegjXY58qr7TV3ne6DAuGupHDicJOYWvtoOob7laK4I68jFrNo79g2S?=
 =?us-ascii?Q?+wVowmKZPk5qIYXEINpYdH8nWhMJZYPmBs47VMh/0RFbg1gZfzdxXUcTbQCx?=
 =?us-ascii?Q?V5yd+azcK4xAnF5sMR7mg8MPh+BjIRZcg+1Qn9wOnsuh20WFLJ/XdKTlgGeL?=
 =?us-ascii?Q?eMOz+yBWqXRMXEFj3XLFS66HRt38TCPEKbz0Z90o/O4jT1rZtQRW4yEppJ4u?=
 =?us-ascii?Q?IA+Hgmg4HUtXY5pW85B5+60h8eHnShy9XiSviQpsberSuNRRWFDDTeWOuMhU?=
 =?us-ascii?Q?1Kby1Cr43q/HGoeLZMULYbzJfAHtpVwxUlAEBRp94uRlRmIDZSxh1dKY1qjE?=
 =?us-ascii?Q?nFn50YoLUENXCRGgZBjKCe+ilpqEBhJi83Pi+1TLi5caHZQd3hJ6/pkWtEW3?=
 =?us-ascii?Q?VTzha4ZGB5oSiKNINq89WfrEyodi2z8u9kDtdLMNbF7EBh2UaBOyqMi1JhNw?=
 =?us-ascii?Q?IV2UXQn5LhItex7POmH6pkzjEyGCtLUhn8kn4BBsvdJO9JfHivfJZebFEeKP?=
 =?us-ascii?Q?KnRA0RoI7oQjn6j9Pr6eAXWYuBXmq9cWFw7ENqkR72k/D9nK6eN2xGF7myvH?=
 =?us-ascii?Q?i6VnRVaJixo97IDniTDtSqfI+zdOd97fAPvm75KQyJvR7ci5UrBguQ0fbxrt?=
 =?us-ascii?Q?+vpsbjE/nkPehi/vc/aA680K6vqfb69xevRold9Zq/WKyWBZTRtNVPylBfye?=
 =?us-ascii?Q?syVj/2CvnGqU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zfxSafilkAcBAjJXpsK9yAT/y5PwjRz/EeIs8rhfRyCYMvGJa1H570EHu509?=
 =?us-ascii?Q?WWhR+b/gFL7Rob8U3nE7tEIcYupV5rj3BtQ916ukmJrpJALD+LYPK2+lHu6W?=
 =?us-ascii?Q?6z+Md6UqTQHFdW45fsFUrYxwBk1vqJYRWswvvxx5c35nYcKEGpVAOHWDD0nO?=
 =?us-ascii?Q?DdrsYB6AAtW7GlchnAh0vYSVB+15y5d9VTTZbkfo9gfyx3GKGHtIoMguCKU6?=
 =?us-ascii?Q?p1IenbeX1o/FHDkLxBz2CqdkIeG6y9+sDXMUAePJMqoZBdgowNWD97qDBzbZ?=
 =?us-ascii?Q?wSkPjdpZm1GekZw4OVcqFsSUG0ViqudTBup6EFlvv+ZfQFjHdDqCXHfTow8G?=
 =?us-ascii?Q?ZfMFm361jBZsaIYe5HHAoMvvTWQL/oFtDzEtSAmXxlFWurt15YbTcNeeD8lY?=
 =?us-ascii?Q?2GY6slbkn4AN+4lIWiCEoRSLmNvRKysoCMi50W7bCusB0XvT2e1lNdSaDKkt?=
 =?us-ascii?Q?98+5Npf6ELdpt5lKCh53oc6hn7xhlhbTWGQeXYe7Nlx0+3dZO2q11MbApvmr?=
 =?us-ascii?Q?Hfa2AbfaevoT3MHO3c143GteYIth3sqPx5MQVFElB6Ovc6Gc5Wu4qWVwe96T?=
 =?us-ascii?Q?eEkfqY1NBhraNx+fMm7iE2nwG0NHOZPBtt+jEBlUGPxCmjRafVZsrzGys0zH?=
 =?us-ascii?Q?9Gnib5z5EsqWHqLA4Tyc0OcgVpAVJejdIDr2/QqKw2oxnvTOwnlBjG/Twp5/?=
 =?us-ascii?Q?Z5yW/qbUMKMFQz6D2x7gJDNVZBqXjidEgo6nX2icqpwB2YraQhRAnekL/6PI?=
 =?us-ascii?Q?TY6QZP1ha/HIoVYOkn55VEWXp8OCyHmHSGSCEtwWQqfFzXh7ME4IzL5oqIpe?=
 =?us-ascii?Q?GUa0h0egQvHAjsMIc2GIE4D86bZDGoy0xgBE7udumV2xZsHVbwzf9xecsS5Y?=
 =?us-ascii?Q?h2xEr+nTlVHdP704gQKEn5xpOouz6v+wlFQihDQ5lDb15iS/p4Is8rklrYN2?=
 =?us-ascii?Q?9Az1A2sY9fVCGQfZezHSztic/ZDjoK9UHVtODwBxvVj849y5UTwx/tw8WyFq?=
 =?us-ascii?Q?eyN2hlBi11LZadwhJCn/ehk7wXHfvLweyeDewrRnmJ0ea4KIiaMnn6GNmlg9?=
 =?us-ascii?Q?t6r3FVIfK36LiHA/9iv5Z/hSKJWz/bRmMRPeMGo1fPBm2x97mp71OMn5PxI/?=
 =?us-ascii?Q?1OxOqSUA5dF9n9SagK5d/WAFpX9yk9Yvs9/ToN05S+S+KIbpGg6iRA/G5aVk?=
 =?us-ascii?Q?qLHTUxtLS1i7dvgQH5+QPzbzuKWewuKvaqgrszrkjrsWlkAmrReLbiQSq+DQ?=
 =?us-ascii?Q?go1olEOk2ybCooxtKCxVyiIN5gxh7+3env8B/LOYOhojQUboRjh+m/Esoj3P?=
 =?us-ascii?Q?Ws3bItPrbvjs4lb4MHrCumaV?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68094B59B1007749B5316D61992F3EB1@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aeb4397-93e0-4eeb-e6db-08dd62210c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 11:20:24.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFE52A1FAE5

From: Aditya Garg <gargaditya08@live.com>

Due to lack of a proper printk format, %p4cc was being used instead of
%p4cl for the purpose of printing FourCCs. But the disadvange was that
they were being printed in a reverse order. %p4cl should correct this
issue.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/apple=
tbdrm.c
index 703b9a41a..751b05753 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -212,7 +212,7 @@ static int appletbdrm_read_response(struct appletbdrm_d=
evice *adev,
 	}
=20
 	if (response->msg !=3D expected_response) {
-		drm_err(drm, "Unexpected response from device (expected %p4cc found %p4c=
c)\n",
+		drm_err(drm, "Unexpected response from device (expected %p4cl found %p4c=
l)\n",
 			&expected_response, &response->msg);
 		return -EIO;
 	}
@@ -286,7 +286,7 @@ static int appletbdrm_get_information(struct appletbdrm=
_device *adev)
 	}
=20
 	if (pixel_format !=3D APPLETBDRM_PIXEL_FORMAT) {
-		drm_err(drm, "Encountered unknown pixel format (%p4cc)\n", &pixel_format=
);
+		drm_err(drm, "Encountered unknown pixel format (%p4cl)\n", &pixel_format=
);
 		ret =3D -EINVAL;
 		goto free_info;
 	}
--=20
2.47.1


