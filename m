Return-Path: <linux-kernel+bounces-406692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5769C6254
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9384C281BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A8219E4B;
	Tue, 12 Nov 2024 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="I36W98i9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B858219E57;
	Tue, 12 Nov 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442366; cv=none; b=AZ2liNOuBJNkGqdFc3+yw3DjZtlC9rwBx+jMv1Za/4az9QqpBfWbVO7Kpa7of5pbkMTLJx80oubwf2rNkmTuZwrwSbr2LwUqg7dQWcY5BEGEZrh2ZR1yV1vSrSpqS3wDIT0kigRawz6AEjlHR8eQL6QiXq49h8v4gq9xc0gSDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442366; c=relaxed/simple;
	bh=7E+MCjcMxZ9hrldEY1WGxt+s38Bf/hlAZRNYwyxcytw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otl26H43lw0bo61bWyG9hF+wmd77kOmQ9ov29RWXWf+exn7SZrM2E4h6Uot8RQMR2lBV0lQSLQnhDzYAT/X6/BeoYm1/dsNnf5iSruGCOt0FHOujhnZc4gHVrWCneYgMHheygAFJAipqEQQYlbrvR53bAiixL+oMbgFIcM++GR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=I36W98i9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CF2EF403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731442364; bh=7E+MCjcMxZ9hrldEY1WGxt+s38Bf/hlAZRNYwyxcytw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I36W98i9M1HmB6s8VdQcVvfJWzGxqGDQWxKXslivaORSlIOyCZyG7pFT0c/LgBCeA
	 w4qQksF0QXWA3Nwv+QBy8PctQah38iHqllovC1/IGfN488NowKruGjRkvo+Uw4w/zl
	 snKYa2fSSOE3JHCT742mOnhKydb4brnuG5F9o+QRKZa69sSkBcb1ZBntkC9JRjLScj
	 4I+ScA8O13NIQFap/7Vpt5WP20pdsg1bbCy7dRtONMA3Xmxj/kCDocabB5XtxMQpKE
	 Hu7aP/mn7TO0tNrrLkSyM+E75RB/V7BQdfZY10g4NOcFicYvPLO53ptZwGwq3sexe7
	 OfHixR43l8v7g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CF2EF403E4;
	Tue, 12 Nov 2024 20:12:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: fix one sentence in llvm.rst
In-Reply-To: <20241107013615.374757-1-dzm91@hust.edu.cn>
References: <20241107013615.374757-1-dzm91@hust.edu.cn>
Date: Tue, 12 Nov 2024 13:12:43 -0700
Message-ID: <87ed3gqkhw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4gd3JpdGVzOg0KDQo+IEFjY29yZGluZyB0
byBKaW5qaWUgUnVhbiwgdGhlIGRlc2NyaXB0aW9uIGFib3V0IHRoZSBwcmVidWlsdCBsbHZtIGlz
DQo+IGluY29ycmVjdC4gRml4IHRoaXMgc2VudGVuY2Ugd2l0aCBuZXcgdW5kZXJzdGFuZGluZy4N
Cj4NCj4gTGluazogaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL2h1c3Qtb3Mta2VybmVsLXBh
dGNoZXMvYy9HYk41UmtWckJoby9tLzJzQzlyQXc3QlFBSg0KPiBTaWduZWQtb2ZmLWJ5OiBEb25n
bGlhbmcgTXUgPGR6bTkxQGh1c3QuZWR1LmNuPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL2tidWlsZC9sbHZtLnJzdCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04va2J1aWxkL2xsdm0ucnN0IGIvRG9jdW1lbnRhdGlv
bi90cmFuc2xhdGlvbnMvemhfQ04va2J1aWxkL2xsdm0ucnN0DQo+IGluZGV4IGY3MTA5MjE0NGEy
Ni4uZjg3ZTAxODFkOGU3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9rYnVpbGQvbGx2bS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04va2J1aWxkL2xsdm0ucnN0DQo+IEBAIC0xODgsNyArMTg4LDcgQEAgTExWTSDlubbk
uI3mlK/mjIEgTGludXgg5YaF5qC45omA5pyJ5Y+v5pSv5oyB55qE5p625p6E77yM5ZCM5qC377yM
5Y2z5L2/IExMVk0gDQo+ICANCj4gIOaIkeS7rOWcqCBga2VybmVsLm9yZyA8aHR0cHM6Ly9rZXJu
ZWwub3JnL3B1Yi90b29scy9sbHZtLz5gXyDmj5DkvpvpooTnvJbor5HnmoTnqLPlrprniYggTExW
TeOAgg0KPiAg6L+Z5Lqb54mI5pys5bey57uP6ZKI5a+5IExpbnV4IOWGheaguOaehOW7uu+8jOS9
v+eUqOmFjee9ruaWh+S7tuaVsOaNrui/m+ihjOS8mOWMluOAguebuOi+g+S6juWFtuS7luWPkeih
jOeJiOS4reeahCBMTFZN77yM5a6D5Lus5bqU6K+lDQo+IC3og73mj5Dpq5jlhoXmoLjmnoTlu7rm
l7bpl7TjgIINCj4gK+iDveaPkOmrmOWGheaguOaehOW7uuaViOeOh+OAgg0KDQpBcHBsaWVkLCB0
aGFua3MuDQoNCmpvbg0K

