Return-Path: <linux-kernel+bounces-246125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0892BDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953E41C21E26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F2B19D097;
	Tue,  9 Jul 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dlNdrblm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F3364AB;
	Tue,  9 Jul 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537708; cv=none; b=bsD/efpMFQ1DRk7HmRT3YgDH6FmxKK9Cd1CCmDJE5kn0syGMkB+BTF7ukA6GcEAR4sh7P3HiyHP9I2/eovrmxQDtPmEOPNnSfr4DS9W7hPc62IRrQZ1I9gM0/d9a/dQ7Yg+WCQK6iBIv/LVB7K6iiRosm9hFxZZWT5WuMnj9AEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537708; c=relaxed/simple;
	bh=Ar9lAiUCjYvL61z7OCjl3X6GHb52GEYA7SN0yPdX5Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4YEDKCxD7vbzip1uj6DpwwT6UVWEpNcQ2ie4eXYP6FpndJli4NvDFQbJYKsecUUKae5GNlVZXYqyIRXfdt+Usdm9nq+PAsuJhWW4qwz+51By/pQimbDBLE8fbjGV11QH3kQOy6JwD/V2c5RF9hlvrwYHHBaalkgP1yRzRx2cCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dlNdrblm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 846ED41A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720537706; bh=Ar9lAiUCjYvL61z7OCjl3X6GHb52GEYA7SN0yPdX5Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dlNdrblmyPxOeknj1lmNfNWjfKpvHr1188AUc2hk4pUYNhz7N1wFS/RPUzx+m8erx
	 tTPeOtLYvYzaiwhYGmvAqlxD/2Y2fTIf9+feENFdFG+6oeweO6eYLI5RuyvLjc3uNW
	 m9ZSY3ZYX2xM4zGD5HAisrVJqDw1aso6ANmn4wjSh5jSADSF+PffIe+rmXtdzSccgE
	 ahK9SlBmVjuh+KpCAbhW8VcT9l4OjGpc0JJVoapT3RL3iGltWwkGvAg+RF+3TWCqq3
	 xDgJMKo6s/QKL2JS8RMeTeUk6uqRjkDIlnqI1a9DSsu+BHir1BbVrp5pXToR6XdPMe
	 3pF63qEGY9isA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 846ED41A36;
	Tue,  9 Jul 2024 15:08:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tao Zou <wodemia@linux.alibaba.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: Tao Zou <wodemia@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
In-Reply-To: <20240705022842.51451-1-wodemia@linux.alibaba.com>
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
Date: Tue, 09 Jul 2024 09:08:25 -0600
Message-ID: <87cynm8uxi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

VGFvIFpvdSA8d29kZW1pYUBsaW51eC5hbGliYWJhLmNvbT4gd3JpdGVzOg0KDQo+IEZpeCBvbmUg
Y2hpbmVzZSB0eXBvIGVycm9yLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWm91IDx3b2RlbWlh
QGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gVGhlIHByZXZpb3VzIHRyYW5zbGF0aW9uIHBh
dGNoIHY0IGhhcyBhbHJlYWR5IGJlZW4gYXBwaWVkLCBhbmQgdGhlIGNoYW5nZXMgZnJvbSB2NCB0
byB2NSB3ZXJlIG1pc3NlZC4NCj4gVGhpcyBwYXRjaCBpcyBvbmUgdHlwb2ZpeCwgYW5kIGluY2x1
ZGVzIHRoZSBjaGFuZ2VzIGZyb20gdjQgdG8gdjUuDQo+ICANCj4gIERvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL2FkbWluLWd1aWRlL251bWFzdGF0LnJzdCB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUvbnVtYXN0YXQu
cnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUvbnVtYXN0
YXQucnN0DQo+IGluZGV4IGMwZjU0ZDlhNmIwNS4uNGQ5ODE3YjkxODcwIDEwMDY0NA0KPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5y
c3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUv
bnVtYXN0YXQucnN0DQo+IEBAIC0xMyw3ICsxMyw3IEBAIE51bWHnrZbnlaXlkb3kuK0v5pyq5ZG9
5Lit57uf6K6hDQo+ICANCj4gIOaJgOacieaVsOaNrueahOWNleS9jemDveaYr+mhtemdouOAguW3
qOmhteacieeLrOeri+eahOiuoeaVsOWZqOOAgg0KPiAgDQo+IC1udW1hX2hpdOOAgW51bWFfbWlz
c+WSjG51bWFfZm9yZWlnbuiuoeaVsOWZqOWPjeW6lOS6hui/m+eoi+aYr+WQpuiDveWkn+WcqOS7
luS7rOWBj+WlveeahOiKgueCueS4iuWIhumFjeWGheWtmOOAgg0KPiArbnVtYV9oaXTjgIFudW1h
X21pc3PlkoxudW1hX2ZvcmVpZ27orqHmlbDlmajlj43mmKDkuobov5vnqIvmmK/lkKbog73lpJ/l
nKjku5bku6zlgY/lpb3nmoToioLngrnkuIrliIbphY3lhoXlrZjjgIINCj4gIOWmguaenOi/m+eo
i+aIkOWKn+WcqOWBj+WlveeahOiKgueCueS4iuWIhumFjeWGheWtmOWImeWcqOWBj+WlveeahOiK
gueCueS4iuWinuWKoG51bWFfaGl06K6h5pWw77yM5ZCm5YiZ5Zyo5YGP5aW955qE6IqC54K55LiK
5aKeDQo+ICDliqBudW1hX2ZvcmVpZ27orqHmlbDlkIzml7blnKjlrp7pmYXlhoXlrZjliIbphY3n
moToioLngrnkuIrlop7liqBudW1hX21pc3PorqHmlbDjgIINCg0KQXBwbGllZCwgdGhhbmtzLg0K
DQpqb24NCg==

