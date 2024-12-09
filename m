Return-Path: <linux-kernel+bounces-437531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE769E9470
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0EE283C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74E227566;
	Mon,  9 Dec 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="bdPYyJnV"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA3224B01;
	Mon,  9 Dec 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747923; cv=none; b=jtp8oI4eoa+x4vHoiyBB3Dp2t4ZUP0c8X/XO3uTvKe5Xed+/Z6ukkyBAljK6jDL6XErmbB8jUvEubsclkmr4fwYAsgtKta8KzVPIk4PT+uP2Aq+6iFqn46nWE80o+vVzj4NlVIDSBMZpbjCPLdWsfghxu0zcr9DzLKa90+CTr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747923; c=relaxed/simple;
	bh=iiVdNzquENfzqRN+PAL0uNkI7bw6oNB8jDXAupyMIZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kBiYi6p+Kcp/fc+sv1qq3eBZz/PPu6ZppXSHUFtV8Nzh2by0HN9zlmQUOuRDfTMDzqAlsTR4SdJLzcna2cAfFB6QwyQFpRUNweEu1KppEwEAKtDOqrVNLKaucpRai8IVxbI3clP91S396ni6/Zdz0Y2dCFITVWLZgpd5rMF+SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=bdPYyJnV reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=6+g6a9zgOHScfh8pfuzFaT8yOgJ0aWJt0L14J82G1Ls=; b=b
	dPYyJnV3upeFShwT7RraFAkx/tTKOpnfz4CNYRVFrb3Xx2vYoOoHzqTM1EzxcHPk
	ifF1GyBRSxmF0YsENDqL1TRqI2BlJRXosYfYhpTUy1PEfCl9RlcEo3QdiqU8DhsU
	ZBIhczvV0uYDsBmJnxASZHzQglfodIiaJzgnFBld98=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Mon, 9 Dec 2024 20:37:59 +0800 (CST)
Date: Mon, 9 Dec 2024 20:37:59 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, derek.foreman@collabora.com, 
	detlev.casanova@collabora.com, "Andy Yan" <andy.yan@rock-chips.com>
Subject: Re:[PATCH] drm/rockchip: vop2: Setup delay cycle for Esmart2/3
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241209122943.2781431-5-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
 <20241209122943.2781431-5-andyshrk@163.com>
X-NTES-SC: AL_Qu2YAfufuEAs7ySfbOkZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY46IPszNAqsSk9+1LSBw9TfE
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d6e7dee.ba96.193ab6d2e3f.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3n76n5FZnEdI6AA--.44307W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxSwXmdW3sf+LAABsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClNvcnJ5LCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guCgpBdCAyMDI0LTEyLTA5IDIwOjI5OjE0
LCAiQW5keSBZYW4iIDxhbmR5c2hya0AxNjMuY29tPiB3cm90ZToKPkZyb206IEFuZHkgWWFuIDxh
bmR5LnlhbkByb2NrLWNoaXBzLmNvbT4KPgo+RWFjaCBsYXllciBuZWVkcyB0byBzZXQgdGhlIGNv
cnJlY3QgZGVsYXkgY3ljbGUgdG8gZGlzcGxheSBwcm9wZXJseQo+d2l0aG91dCB1bmV4cGVjdGVk
IG9mZnNldCBvbiBzY3JlZW4uCj4KPkZpeGVzOiA1YTAyOGU4ZjA2MmYgKCJkcm0vcm9ja2NoaXA6
IHZvcDI6IEFkZCBzdXBwb3J0IGZvciByazM1ODgiKQo+U2lnbmVkLW9mZi1ieTogQW5keSBZYW4g
PGFuZHkueWFuQHJvY2stY2hpcHMuY29tPgo+LS0tCj4gZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlw
L3JvY2tjaGlwX2RybV92b3AyLmMgfCAyICsrCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2Ry
bV92b3AyLmMgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+
aW5kZXggYzNhNTcyYjFjODcwNC4uN2RjOGJlN2Q2MTE4NCAxMDA2NDQKPi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fdm9wMi5jCj4rKysgYi9kcml2ZXJzL2dwdS9k
cm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX3ZvcDIuYwo+QEAgLTI1MjYsOSArMjUyNiwxMSBAQCBz
dGF0aWMgdm9pZCB2b3AyX3NldHVwX2RseV9mb3Jfd2luZG93cyhzdHJ1Y3Qgdm9wMiAqdm9wMikK
PiAJCQlzZGx5IHw9IEZJRUxEX1BSRVAoUkszNTY4X1NNQVJUX0RMWV9OVU1fX0VTTUFSVDEsIGRs
eSk7Cj4gCQkJYnJlYWs7Cj4gCQljYXNlIFJPQ0tDSElQX1ZPUDJfU01BUlQwOgo+KwkJY2FzZSBS
T0NLQ0hJUF9WT1AyX0VTTUFSVDI6Cj4gCQkJc2RseSB8PSBGSUVMRF9QUkVQKFJLMzU2OF9TTUFS
VF9ETFlfTlVNX19TTUFSVDAsIGRseSk7Cj4gCQkJYnJlYWs7Cj4gCQljYXNlIFJPQ0tDSElQX1ZP
UDJfU01BUlQxOgo+KwkJY2FzZSBST0NLQ0hJUF9WT1AyX0VTTUFSVDM6Cj4gCQkJc2RseSB8PSBG
SUVMRF9QUkVQKFJLMzU2OF9TTUFSVF9ETFlfTlVNX19TTUFSVDEsIGRseSk7Cj4gCQkJYnJlYWs7
Cj4gCQl9Cj4tLSAKPjIuMzQuMQo=

