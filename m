Return-Path: <linux-kernel+bounces-242104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D4928390
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB81F21CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964D1428E4;
	Fri,  5 Jul 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEL/t+hv"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C941A81;
	Fri,  5 Jul 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167553; cv=none; b=S1D/jvCI1If1sAncGlZumPyb184MahoYRjqplPJfIXrAxn8x8NIrvn2pXYoHqmb+quNv9NLjzTIPg2QyNGBPvJ6qJuafuNZRJkNwzS2PWI3VdaqVoWIS9yqIamQC7rs5bydRlacMyjB8+dAtlQgH7DRAXcyC9Bakpqzt8nYdQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167553; c=relaxed/simple;
	bh=7aOpINCPvg0vvhmXw5cCeNQkCVwgJmM7bESdDQA1b1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfx/P43Uee2iWjaYVZxOP3UlF7DyDhrXPHtRznGczAmkfGsXL3wtQER5QKPQaDmwnPEIx/oSOPEkUZyB+q7H4Sd/fQ4P+mvcBdgOTTs6/T0T8f6ZLSvkEClCF+kJjFNy2OYs/yVq5/EW0N/zR3gQY8I5cv43Bk6d7+7p//4EK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEL/t+hv; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c46b040b53so617172eaf.2;
        Fri, 05 Jul 2024 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720167551; x=1720772351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aOpINCPvg0vvhmXw5cCeNQkCVwgJmM7bESdDQA1b1s=;
        b=OEL/t+hvwbHWLi71XeQ31OrBJGOk+Hb9xrYx6E5I89gGIHAcdpq+hRwLdwQTWjxhAa
         NRo1JFi80ztR8kdTfct+sAhgzlhmRWrmCwRAf9GtGR+/bdxd2BamdZurkY++uHMYHxG1
         Xrcyzg+a81s9lJ7m8rmx40w74FozKYW5P80XtoW7VS5nOYY0FxgIyaRQLeN5bKH/l+wb
         YTtrIhD/zQNUZMd5oXKkicmMPD0IZYLvwt4edBRwUkeKdzAmC8g945tbioLbiiMKhevZ
         Soq6Ip3Sn7+MGnk8x1rbZDxLMPdtXypq4pNACvIgbRLl/CySDsEsEST5OO4MEGWGTZxX
         BzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167551; x=1720772351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aOpINCPvg0vvhmXw5cCeNQkCVwgJmM7bESdDQA1b1s=;
        b=g8M3+6pJs7u1tsA7kY+2wKBoJhcV7P83vC8Xo7ilozMMdI4Qb2rXfhWHtqZeyIwmJD
         9scq23b54XA2UagKuqcXfc2d/hx/qZChSNjKOu1gHDrQrJ5H6nQwqdxriEakFeXfb0N/
         V0GOjEWfLKKZvj7tkDf7QZVVAVy24aS1BwkImEjWmLdW6FCdF716q6c01w9oLoDKyljT
         rICrWdpqfVv/y8kBkaD2CF7J5PGuRD8QZo8N5treilkNWZCwgt19s3OGleDUBs6sVQvr
         R81LcHuBMEbYDx6BiKMEqLSmR4vW4JDvqr5Ri+u9G6vYRzfA+EcmZ5hShZALrLVMOOmx
         MJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCXS8hpyJOpgYDAjjAra14VTYtymz0U6RsVxxrYeDVTb4PkTX3lgDt9KH9s214CpCrkj+GsK5SWoGVH8VfNas3QGUC5wIV1AsX9h+f0BRllGqibSpNJn9+yVk2+ePGcgGCSbtDAvtk3+
X-Gm-Message-State: AOJu0Yynbk5fUEib4SuLHVFbJghVbAJW6X34sBBU8o3VUDWQlU9zldpS
	py4rf2jA8vmfmeZyTS0cpk6IoXU1Fd05SON8n/CV7poU9m99M64lVgmH0ZICE3ZB9S48BBWK5lr
	zegkAeoirWwUNbrJXTkVhtqi/dUtKpYZyfBc=
X-Google-Smtp-Source: AGHT+IF7TQYmBewryyeNp0kMG78rpCTiJk8CpOGAeEyfetzcR10PwWd8fDG9RsTKXb21fuuzCAs8erbEfbxRCO472vQ=
X-Received: by 2002:a4a:af02:0:b0:5c4:2c2a:2358 with SMTP id
 006d021491bc7-5c646f63b94mr4137659eaf.6.1720167550895; Fri, 05 Jul 2024
 01:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705022842.51451-1-wodemia@linux.alibaba.com>
In-Reply-To: <20240705022842.51451-1-wodemia@linux.alibaba.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 5 Jul 2024 16:18:44 +0800
Message-ID: <CAD-N9QUPWrAaT-7UjibcKR7=L_etmGF4qy0voO8u3W+wk6G0nA@mail.gmail.com>
Subject: Re: [PATCH v1] zh_CN/admin-guide: one typo fix
To: Tao Zou <wodemia@linux.alibaba.com>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBKdWwgNSwgMjAyNCBhdCAxMDoyOeKAr0FNIFRhbyBab3UgPHdvZGVtaWFAbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOg0KPg0KPiBGaXggb25lIGNoaW5lc2UgdHlwbyBlcnJvci4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogVGFvIFpvdSA8d29kZW1pYUBsaW51eC5hbGliYWJhLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUuY24+DQoNCj4gLS0tDQo+
IFRoZSBwcmV2aW91cyB0cmFuc2xhdGlvbiBwYXRjaCB2NCBoYXMgYWxyZWFkeSBiZWVuIGFwcGll
ZCwgYW5kIHRoZSBjaGFuZ2VzIGZyb20gdjQgdG8gdjUgd2VyZSBtaXNzZWQuDQo+IFRoaXMgcGF0
Y2ggaXMgb25lIHR5cG9maXgsIGFuZCBpbmNsdWRlcyB0aGUgY2hhbmdlcyBmcm9tIHY0IHRvIHY1
Lg0KPg0KPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4tZ3VpZGUvbnVt
YXN0YXQucnN0IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5yc3QNCj4gaW5kZXggYzBmNTRkOWE2YjA1Li40
ZDk4MTdiOTE4NzAgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2FkbWluLWd1aWRlL251bWFzdGF0LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5yc3QNCj4gQEAgLTEzLDcgKzEzLDcg
QEAgTnVtYeetlueVpeWRveS4rS/mnKrlkb3kuK3nu5/orqENCj4NCj4gIOaJgOacieaVsOaNruea
hOWNleS9jemDveaYr+mhtemdouOAguW3qOmhteacieeLrOeri+eahOiuoeaVsOWZqOOAgg0KPg0K
PiAtbnVtYV9oaXTjgIFudW1hX21pc3PlkoxudW1hX2ZvcmVpZ27orqHmlbDlmajlj43lupTkuobo
v5vnqIvmmK/lkKbog73lpJ/lnKjku5bku6zlgY/lpb3nmoToioLngrnkuIrliIbphY3lhoXlrZjj
gIINCj4gK251bWFfaGl044CBbnVtYV9taXNz5ZKMbnVtYV9mb3JlaWdu6K6h5pWw5Zmo5Y+N5pig
5LqG6L+b56iL5piv5ZCm6IO95aSf5Zyo5LuW5Lus5YGP5aW955qE6IqC54K55LiK5YiG6YWN5YaF
5a2Y44CCDQo+ICDlpoLmnpzov5vnqIvmiJDlip/lnKjlgY/lpb3nmoToioLngrnkuIrliIbphY3l
hoXlrZjliJnlnKjlgY/lpb3nmoToioLngrnkuIrlop7liqBudW1hX2hpdOiuoeaVsO+8jOWQpuWI
meWcqOWBj+WlveeahOiKgueCueS4iuWing0KPiAg5YqgbnVtYV9mb3JlaWdu6K6h5pWw5ZCM5pe2
5Zyo5a6e6ZmF5YaF5a2Y5YiG6YWN55qE6IqC54K55LiK5aKe5YqgbnVtYV9taXNz6K6h5pWw44CC
DQo+DQo+IC0tDQo+IDIuMzkuMyAoQXBwbGUgR2l0LTE0NikNCj4NCj4NCg==

