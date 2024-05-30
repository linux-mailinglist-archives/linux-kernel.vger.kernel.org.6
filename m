Return-Path: <linux-kernel+bounces-194919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9758D4444
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1741C22455
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39F142E63;
	Thu, 30 May 2024 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMFks4zl"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288831B947;
	Thu, 30 May 2024 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040777; cv=none; b=r7hv7tGKHGTMS7ESIL23a/wf4pzJopogNNz4GdjbWNZJp7QBsz7gjMHre/0rjJhupC9wKgTkgG7y2zXqCYVRL46HH/fcJkhidUPIJOuuRarXvvS3jlvshrulpMp9Plc0D1o55P0d25ClQ+1sQngDNZF6GK9j2VmDXbIXJKiputQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040777; c=relaxed/simple;
	bh=6L11tRl35HQmv/mFBk8LfSjuDV9F1thr5rxj67BCpPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg4uhxo/MEjjA5uzvVN5H7GWg9RUhRfUvBTYYwxHjt9aO4g0WywUygmpSYyjR9bxK0UN8ryW24CAhDoVwLZpTB8nW9ZC3lOa29VLRlVz90XWPJglw1zf/Rx+r45wt/BwPmhzOx/BewzqAKGtYC2IZQqA4mMbnzy1qseGX7FanGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMFks4zl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80ac7385672so155184241.2;
        Wed, 29 May 2024 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717040775; x=1717645575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L11tRl35HQmv/mFBk8LfSjuDV9F1thr5rxj67BCpPM=;
        b=BMFks4zl9bOe+ACcG4gMzQo0fpQUIstQOldTMawwrA/iJsMVoc1KA87o2rOPD0Q1aE
         w8JT6LCxwcxVZ3Aph7o7yqHx8bGGQptLUI1YfyTDGDlf5G7Kak5sN/yoCBgnwBsp5Gb+
         UubBbMbEauOasGrJE0Nm84quQq8pr7kYQ5SPyG5U+5HHnj/b9GftjnuC55m8AHK+pvMa
         z3DjwpdKc4V4hMal4JnvLpYwKZl+VRusi60PStD9QSvfETi4tEwEkzyHqu5y+rY0IiyL
         tf58oD5+ErnZGrkLVa2xYhIULWQEVdxWeOyQL/gbWQcYZUARUABTN3SFuLcGL+9g0oZ9
         /zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717040775; x=1717645575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L11tRl35HQmv/mFBk8LfSjuDV9F1thr5rxj67BCpPM=;
        b=WV/7OjZSGFPTjThXRyEnCrtM2TgPVLd7qiebKNghmrIu7y0cCqTjuypeLKLOz6Ze6n
         1K/P72edder+eE/ym97v1AaAmgHtiNtUJ2lRXwixL00iGpKBM79rhslc+0NPuPIf+ywv
         U1ha2jYIbj/U06iZeyBz4o85KL9jt78xkxMOZn1DgZ58uRiukg99zJeulGHs7nfOUgeL
         uDrmJGeojJYQJ2+D+X3K3PW8B78Jo2plukCqSvN/8/MYEpqAIunMn81WCPl/IphVnOYo
         aBBIZhn7WbSuWXFE6BxqBqcy4CpNESf4UwQVKV6mdbi1Beo07L6jmEtiNoWbXyJnUBCC
         k9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhGVcL3lD/FcNdXZTcog9OSO8kdjhoV1x8vcJsUvz4pb0orbeALXfrzOgmnA2ZGIgOkVsf0cmJRm4JOhqGpBRDLg3S++xwxyyOJBeWkjsXe3RiQzNrruRC8ZJtxyeZo9OrJtDd3Xw8YTZS/U3ko9mjo8rluAj7zqK5UhZRKhIqQUQV
X-Gm-Message-State: AOJu0YxuRE3svQeeMNGn1YftNYM/H+OMDi5hOinSq2bxigjCXwGllw/Y
	M7uswLFhVoLnMB/pUIzGDIX0UTBqs/vZbo/lVzk1BBMULhp9YnnCwcy7XGjKpxPLNK3ArdwT3F8
	7zu5JV5VrQGS0xWWs6vpxPWx0clE=
X-Google-Smtp-Source: AGHT+IF85Nlu3c7uPVn5bMKIYbYvGkSUcAqsd5Huh0o6ZADdaGmNHXy7hxzw5zvNdX/lonak2rM8KZDHGNaZj1IXUiA=
X-Received: by 2002:a67:b34c:0:b0:48b:a8ef:5942 with SMTP id
 ada2fe7eead31-48baea8f7afmr968789137.35.1717040774677; Wed, 29 May 2024
 20:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527102313.27966-1-yskelg@gmail.com>
In-Reply-To: <20240527102313.27966-1-yskelg@gmail.com>
From: Austin Kim <austindh.kim@gmail.com>
Date: Thu, 30 May 2024 12:46:03 +0900
Message-ID: <CADLLry53yZ6PZ7X8DwdS=GGp6+6L0tbAkb+hiL-Eth4FZ+ZTNw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: cve Korean translation
To: yskelg@gmail.com
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org, 
	Jinwoo Park <pmnxis@gmail.com>, shjy180909@gmail.com, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCjIwMjTrhYQgNeyblCAyN+ydvCAo7JuUKSDsmKTtm4QgNzoyNCwgPHlza2VsZ0Bn
bWFpbC5jb20+64uY7J20IOyekeyEsToNCj4NCj4gRnJvbTogWXVuc2VvbmcgS2ltIDx5c2tlbGdA
Z21haWwuY29tPg0KPg0KPiBUaGlzIGlzIGEgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2N2ZSBrb3Jl
YW4gdmVyc2lvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWXVuc2VvbmcgS2ltIDx5c2tlbGdAZ21h
aWwuY29tPg0KPiAtLS0NCj4gIC4uLi90cmFuc2xhdGlvbnMva29fS1IvcHJvY2Vzcy9jdmUucnN0
ICAgICAgICB8IDEwNyArKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDcg
aW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdHJhbnNs
YXRpb25zL2tvX0tSL3Byb2Nlc3MvY3ZlLnJzdA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMva29fS1IvcHJvY2Vzcy9jdmUucnN0IGIvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMva29fS1IvcHJvY2Vzcy9jdmUucnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTQ2MTBjMTc3ZjE3DQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvcHJvY2Vzcy9jdmUucnN0DQo+
IEBAIC0wLDAgKzEsMTA3IEBADQo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiArDQo+ICs6T3JpZ2luYWw6IERvY3VtZW50YXRpb24vcHJvY2Vzcy9jdmUucnN0DQo+ICs6
VHJhbnNsYXRvcjogWXVuc2VvbmcgS2ltIDx5c2tlbGdAZ21haWwuY29tPg0KPiArDQo+ICs9PT09
PT09PT09DQo+ICtDVkUg7ZWt66qp65OkDQo+ICs9PT09PT09PT09DQo+ICsNClsuLi5dDQo+ICsN
Cj4gK+yemOuqu+uQnCBDVkUg7ZWt66qp65OkDQo+ICs9PT09PT09PT09PT09PT09PQ0KPiArDQo+
ICvtirnsoJUg67Cw7Y+s7YyQ7JeQ7IScIOuzgOqyveuQnCDsgqztla0g7KCB7Jqp7ZWcIOuwsO2P
rO2MkOydgCDrjZQg7J207IOBIGtlcm5lbC5vcmcg7KeA7JuQIOumtOumrOyKpOqwgA0KPiAr7JWE
64uMIOy7pOuEkCDrsoTsoITsnYQg7KeA7JuQ7ZWp64uI64ukLiDrlYzrrLjsl5AgTGludXgg67Cw
7Y+s7YyQ7JeQ7ISc66eMIOyngOybkOuQmOuKlCBMaW51eCDsu6TrhJDsl5DshJwNCj4gK+uztOyV
iCDrrLjsoJzqsIAg67Cc6rKs65CY64qUIOqyveyasCBMaW51eCDsu6TrhJAgQ1ZFIO2MgOyXkOyE
nCBDVkXrpbwg7ZWg64u57ZWgIOyImCDsl4bsirXri4jri6QuDQo+ICvrs4Dqsr3rkJwg7IKs7ZWt
7J2EIOyggeyaqe2VnCDtirnsoJUgTGludXgg67Cw7Y+s7YyQIOyekOyytOyXkCDsmpTssq3tlbTs
lbwg7ZWp64uI64ukLg0KDQpJdCBpcyBhIGxpdHRsZSBiaXQgaGFyZCB0byB1bmRlcnN0YW5kIHRo
ZSBhYm92ZSBzZWN0aW9uIGRlc2NyaWJpbmcNCidJbnZhbGlkIENWRXMnLg0KUGxlYXNlIHJlZmVy
IHRvIHRoZSBmb2xsb3dpbmcgc2VudGVuY2VzIGlmIHlvdSBjb25zaWRlciByZXZpc2lvbiBvZiB0
aGlzIHBhZ2UuDQoNCi0tLQ0K7Jyg7Zqo7ZWY7KeAIOyViuydgCBDVkUg7ZWt66qp65OkDQoNCuuz
tOyViCDsnbTsiojqsIAg7Yq57KCVIOuwsO2PrO2MkOyXkOyEnCDtmZXsnbjrkJjrqbQg7Yq57KCV
IOuwsO2PrO2MkOyXkCDrs4Dqsr0g7IKs7ZWt7J20IOyggeyaqeuQqeuLiOuLpC4NCuydtCDrs4Dq
sr0g7IKs7ZWt7J20IGtlcm5lbC5vcmfsl5Ag7KCB7Jqp65CY7KeAIOyViuycvOuptCwgTGludXgg
7Luk64SQIENWRSDtjIDsl5DshJwgQ1ZF66W8IO2VoOuLue2VoCDsiJgg7JeG7Iq164uI64ukLg0K
64yA7IugIOuzgOqyveuQnCDsgqztla3snbQg7KCB7Jqp65CcIO2KueyglSBMaW51eCDrsLDtj6zt
jJAg7J6Q7LK07JeQIOyalOyyre2VtOyVvCDtlanri4jri6QuDQotLS0NCg0KVGhhbmtzIGZvciBk
ZWRpY2F0aW9uLCBldmVyeWJvZHkga25vd3MgdGhhdCBpdCBpcyBjaGFsbGVuZ2luZw0KdG8gY2Fy
cnkgb3V0IHRyYW5zbGF0aW9uIHdvcmsuDQoNCkJSLA0KQXVzdGluIEtpbQ0KDQo+ICsNClsuLi5d
DQo+ICvslYrsnYAg7J2867aAIOuzgOqyvSDsgqztla3snbQg6rSA66Co7ISx7J20IOyeiOydhCDs
iJgg7J6I64uk6rOgIOqwgOygle2VqeuLiOuLpC4NCj4gLS0NCj4gMi4zNC4xDQo+DQo=

