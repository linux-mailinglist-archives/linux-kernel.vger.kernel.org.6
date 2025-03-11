Return-Path: <linux-kernel+bounces-556094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05CA5C0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A67A663D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51151254AE7;
	Tue, 11 Mar 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b72iuzjL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82BF9CB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695773; cv=none; b=O/aw2oYremjF7cBs6n9QBg93v5s+pDlspd1JMnWCrv2LIFATJb0uEoT7exYoH/M95CVEZC8iUXGwAftafiBdJW3C9ZwlNHnzZjviAgySiFWAwL8WKwlrRZATVdowzdnsv4gGb1Hj++Gbj1YOR0pegVi0aOszVVOsqtyGXC5nUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695773; c=relaxed/simple;
	bh=Jir35b0HgpV0FY6FTSTtKnirvFZaxaNLyjhlogfMqV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=oGRTxx/oZnlBYW5byUblONnG2Yx/cAXbC74gHN5m5f/M9NC3kJ8Xi6za+6YJIPnenzANvRwaGUvP24sDZWAZZM7+NcdXh8hj2GTjgr6j5WiDRhMg1xbnsjwi5US0u3z6sQXhk0T7InzxTemljuR5aVff89EaWosX2ECD5P+WOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b72iuzjL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Jir35b0HgpV0FY6FTSTtKnirvFZaxaNLyjhlogfMqV4=; b=b
	72iuzjLPM9Hpdt1LvzCk0VUtgFtaH+PnzDNS29xW4zkZSribKzLwWSRMqWch/9PG
	AA36bzTdLuMmC7/JYiCJ+VlGE8L73KlPhOjuZ+QLxwgM1Jg3b7Wl7Bie4YBoEWl5
	D/F8zS8MeQ66Rt+EmWMEXDMITg2CUfBylMVTCWI6ZM=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Tue, 11 Mar 2025 20:22:10 +0800
 (CST)
Date: Tue, 11 Mar 2025 20:22:10 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Vinod Koul" <vkoul@kernel.org>
Cc: heiko@sntech.de, kishon@kernel.org, sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com, dmitry.baryshkov@linaro.org,
	frank.wang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	"Andy Yan" <andy.yan@rock-chips.com>
Subject: Re:Re: Re: [PATCH] phy: rockchip: usbdp: Check these parameters
 only when the corresponding set flags are set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <Z9Aa6v1/1KRdZDKE@vaman>
References: <20250306065952.485809-1-andyshrk@163.com>
 <Z86UOmPg/UDSBajZ@vaman>
 <1379400c.90c.19582b05f74.Coremail.andyshrk@163.com>
 <Z9Aa6v1/1KRdZDKE@vaman>
X-NTES-SC: AL_Qu2fA/qSuk8o5imYYOlSyjNW+7xfHKv6+qRChMQvQtsqqTHr9T0KcVtuP1XR3/++sAgV6BesM+3kGdDrWG6d
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5382b861.a48b.1958527c4dd.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgCXPn_yKtBnExV8AA--.18497W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hwNXmfQINjbaQACsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBWaW5vZCwKQXQgMjAyNS0wMy0xMSAxOToxMzo0NiwgIlZpbm9kIEtvdWwiIDx2a291bEBr
ZXJuZWwub3JnPiB3cm90ZToKPk9uIDExLTAzLTI1LCAwODo1MiwgQW5keSBZYW4gd3JvdGU6Cj4K
Pj4gRG8geW91IG1lYW4gd2Ugc2hvdWxkIGRvIGl0IGxpa2UgdGhpczoKPj4gCj4+IHN0YXRpYyBp
bnQgcmtfdWRwaHlfZHBfcGh5X2NvbmZpZ3VyZShzdHJ1Y3QgcGh5ICpwaHksCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmlvbiBwaHlfY29uZmlndXJlX29wdHMgKm9w
dHMpCj4+IHsKPj4gICAgICAgICBzdHJ1Y3QgcmtfdWRwaHkgKnVkcGh5ID0gcGh5X2dldF9kcnZk
YXRhKHBoeSk7Cj4+ICAgICAgICAgc3RydWN0IHBoeV9jb25maWd1cmVfb3B0c19kcCAqZHAgPSAm
b3B0cy0+ZHA7Cj4+ICAgICAgICAgdTMyIGksIHZhbCwgbGFuZTsKPj4gICAgICAgICBpbnQgcmV0
Owo+PiAKPj4gICAgICAgIC4uLi4uLi4uLi4uLi4KPj4gICAgICAgaWYgKGRwLT5zZXRfcmF0ZSkK
Pj4gICAgICAgICAgICAJcmV0ID0gcmtfdWRwaHlfZHBfcGh5X3ZlcmlmeV9saW5rX3JhdGUoZHAt
PmxpbmtfcmF0ZSk7Cj4+ICAgICAgaWYgKGRwLT5zZXRfbGFuZXMpCj4+ICAgICAgICAgICAgICAg
ICByZXQgPSBya191ZHBoeV9kcF9waHlfdmVyaWZ5X2xpbmtfbGFuZXMoZHAtPmxhbmVzKTsKPj4g
ICAgICBpZiAoZHAtPnNldF92b2x0YXRlcykKPj4gICAgICAgICAgICAgICAgcmV0ID0gcmtfdWRw
aHlfZHBfcGh5X3ZlcmlmeV9saW5rX3ZvbHRhdGUoZHAtPnZvbHRhdGUpOwo+PiAKPj4gCj4+IEFk
ZCBoZWxwZXIgZm9yIGVhY2ggb2YgdGhlbSA/Cj4KPlRoYXQgd291bGQgbG9vayBiZXR0ZXIgZm9y
IHN1cmUKCkkgd2lsbCBkbyBhcyB0aGF0IGluIFYyLgoKVGhhbmtzCgo+Cj4tLSAKPn5WaW5vZAo=


