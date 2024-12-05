Return-Path: <linux-kernel+bounces-433277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0C9E55E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677C41881DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FEA218AB5;
	Thu,  5 Dec 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="j7RbPjAB"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8825765
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403313; cv=none; b=Iu8GJBIEYnFupIPyXOQRtCbVCO671cfb+QrUwoXEHAyV4QvU7pxqxblzic7oTe2QHsgWkqh/UKpvTHjGJdWwT1NXTWfuZVuTAiK0MmLvRW00xb98AEPctTIp2zNMv3xGsvu2IqYfzn1L8GZaAAmaWHRx+yWTveT/+5V8m7YW1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403313; c=relaxed/simple;
	bh=3uJ8KDZhqZdfDTg890Frjr2lJzrEnnG3PdEArbaqfKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SYKR+BAsTUHzcJVWWNMUCrRAB1A2JP6GIgTSY3eXtg6aoqwpnggYyKgtspcTyCE60FwBbx19sJZktQOQ7/1b2GJeDnGqPq9JKEqmI/X0NQcP6paqg+ZrrSWaze+ajr2TnkDKF//l0YWPfpr3Cl26Y8xOtwG+oM6W+8yvR4lhiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=j7RbPjAB reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=DxzuJ+PBFBTjnuUJMTNyiYZFtvZ7pwkUk2OsNljH+Rw=; b=j
	7RbPjABJaEEtc0yrG1mU6Sn04lAI389ddLLpuWyGuwdIuaCalEyEMiH5SEeBpRRB
	7TegI8igKwhMtSpngF2S+wiYiWD54zZX3j1A+IExXJOJOuEstS2QC2WETW0ovIC9
	JyJgR87YZ+gEYyaQ2GDwBuSD28QIi2KbVhKbiF877E=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Thu, 5 Dec 2024 20:53:25 +0800 (CST)
Date: Thu, 5 Dec 2024 20:53:25 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"Piotr Zalewski" <pZ010001011111@proton.me>, 
	skhan@linuxfoundation.org, "Daniel Stone" <daniel@fooishbar.org>, 
	"Dragan Simic" <dsimic@manjaro.org>, 
	"Diederik de Haas" <didi.debian@cknow.org>
Subject: Re:Re: [PATCH v7] rockchip/drm: vop2: add support for gamma LUT
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <12938960.VsHLxoZxqI@diego>
References: <20241101185545.559090-3-pZ010001011111@proton.me>
 <9Rp0NJW2QG5qDduowVaialZWN6xTe9KJFciu7Q2LERJZQXsUgFvMGXfcFaNznIEJEBpZeOdZPuL4fxOEFduaSJLuQJ3cIvN-fx2lEzYSBKE=@proton.me>
 <12938960.VsHLxoZxqI@diego>
X-NTES-SC: AL_Qu2YAfibvEor4ySfYelS8zNM9K56MKvt5LljqcQFePgqqTHL3g4cZnlBM0vW6uLuhrF9Zm4giOWgVo9pwXcb
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7877dddf.b3b8.19396e1df66.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3nw5HolFn1Sw4AA--.49949W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gOsXmdRnDbFCQACsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBpb3RyLAoKQXQgMjAyNC0xMi0wNSAxNjo1NDowOSwgIkhlaWtvIFN0w7xibmVyIiA8aGVp
a29Ac250ZWNoLmRlPiB3cm90ZToKPkhpIFBpb3RyLAo+Cj5BbSBNaXR0d29jaCwgNC4gRGV6ZW1i
ZXIgMjAyNCwgMTY6NDU6MjEgQ0VUIHNjaHJpZWIgUGlvdHIgWmFsZXdza2k6Cj4+IEkganVzdCBu
b3RpY2VkIHRoYXQgYWZ0ZXIgY29taW5nIG91dCBvZiBzdXNwZW5kIGdhbW1hIExVVCBpcyBsb3N0
IGFuZCBtdXN0Cj4+IGJlIHJld3JpdHRlbiBieSB1c2Vyc3BhY2UuCj4+IAo+PiBTbyBJIGd1ZXNz
IGl0IHdpbGwgYmUgbmVlZGVkIHRvIHNhdmUgTFVUIHRvIGEgYnVmZmVyIGFuZCByZXdyaXRlIGl0
IGFmdGVyCj4+IGdvaW5nIG91dCBvZiBzdXNwZW5kIGR1cmluZyBtb2Rlc2V0Pwo+Cj5Nb3N0IGxp
a2VseSAuLi4gdGhlIG9sZCB2b3AgZG9lcyB0aGlzIGFscmVhZHkgdG9vLCBzbyBJIGd1ZXNzIHlv
dSBjYW4KPmdldCBpbnNwaXJhdGlvbiBmcm9tIHRoZXJlLiAoZ2FtbWFfc2V0IGNhbGwgaW4gdm9w
X2NydGNfYXRvbWljX2VuYWJsZSgpKQoKSSBndWVzcyBpdCByZXR1cm5lZCBiZWNhdXNlIGNydGNf
c3RhdGUtPmNvbG9yX21nbXRfY2hhbmdlZCBpcyBmYWxzZSB3aGVuIGNhbGxlZCBmcm9tIAp2b3Ay
X2NydGNfYXRvbWljX2VuYWJsZSBmcm9tIHMyci4KCgpzdGF0aWMgdm9pZCB2b3AyX2NydGNfYXRv
bWljX3RyeV9zZXRfZ2FtbWEoc3RydWN0IHZvcDIgKnZvcDIsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdm9wMl92aWRlb19wb3J0ICp2cCwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fY3J0YyAqY3J0
YywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1f
Y3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkKewogICAgICAgIGlmICghdm9wMi0+bHV0X3JlZ3MgfHwg
IWNydGNfc3RhdGUtPmNvbG9yX21nbXRfY2hhbmdlZCkKICAgICAgICAgICAgICAgIHJldHVybjsK
CiAgICAgICAgaWYgKCFjcnRjX3N0YXRlLT5nYW1tYV9sdXQpIHsKICAgICAgICAgICAgICAgIHZv
cDJfdnBfZHNwX2x1dF9kaXNhYmxlKHZwKTsKICAgICAgICAgICAgICAgIHJldHVybjsKICAgICAg
ICB9CgogICAgICAgIGlmICh2b3AyX3N1cHBvcnRzX3NlYW1sZXNzX2dhbW1hX2x1dF91cGRhdGUo
dm9wMikpCiAgICAgICAgICAgICAgICB2b3AyX2NydGNfYXRvbWljX3NldF9nYW1tYV9zZWFtbGVz
cyh2b3AyLCB2cCwgY3J0Yyk7CiAgICAgICAgZWxzZQogICAgICAgICAgICAgICAgdm9wMl9jcnRj
X2F0b21pY19zZXRfZ2FtbWFfcmszNTZ4KHZvcDIsIHZwLCBjcnRjKTsKfQo+Cj4+IEkgY2hlY2tl
ZCB0aGUgcGF0Y2ggaXNuJ3QgeWV0IGluIHRoZSAib2ZmaWNpYWwiIGxpbnV4LW5leHQuCj4KPlRo
ZSBwYXRjaCBpcyBpbiBkcm0tbWlzYy1uZXh0Ogo+aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Au
b3JnL2RybS9taXNjL2tlcm5lbC8tL2NvbW1pdC80ZjUzNzc3NjM0MGRhYjJiNjgwYTRkODU1NDU2
N2Y2ODg0MjQwZDBiCj4KPnNvIHNob3VsZCB0dXJuIHVwIGluIGxpbnV4LW5leHQgYXQgc29tZSBw
b2ludC4gVGhpcyBhbHNvIG1lYW5zLCBwbGVhc2UKPnByb3ZpZGUgYSBmb2xsb3ctdXAgcGF0Y2gg
Zm9yIHRoZSBzdXNwZW5kIGhhbmRsaW5nLgo+Cj5UaGFua3MgYSBsb3QKPkhlaWtvCj4K

