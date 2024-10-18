Return-Path: <linux-kernel+bounces-370793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02449A3229
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBDB2345F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB97603A;
	Fri, 18 Oct 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0LqtmN9"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493320E33E;
	Fri, 18 Oct 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215734; cv=none; b=BFSVoXnzxUynq0i/AfqwQX6rYC2fyEEI0CkBuUwzNc84Zz7UbTaoMJJcPqIi+h3+OoFqMyJlqX1/5cBpnNxG+TZUVgG8LesDJRlZrKgWFtW1tVPVKFGPUEyHXpUCuLPc1QrtxI5B1xjwb3EamevAzPKsWEo22D1vNPekAjNJZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215734; c=relaxed/simple;
	bh=ALBNAZN1he27pKDTVzWnVA3I0wNwhnq8w84ZxJ/qpsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6AAO5vvIQ6B3L3+b1aSqH8hLZzZspMOblg0Dm8q7TV5EBwZNp8lhFpGP/MHxx5yc/FlSNz4FWSysZ91ZGPSBkNdebzJISOZSp0qtRxe0DLZx4X7ggosUNBp4+w4H8nwNAz4czKQM67Dey6KoeESdNJxABkSWwEVT5fSLYCBkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0LqtmN9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5eb60f6b4a7so874015eaf.0;
        Thu, 17 Oct 2024 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729215731; x=1729820531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALBNAZN1he27pKDTVzWnVA3I0wNwhnq8w84ZxJ/qpsY=;
        b=m0LqtmN9NpC430FTFV8ZYhVNfSyA2v218TwP0H27HaurtjJKLxHhU44B/jPLufBr9K
         j/mCGI8TTTvBd4GNIdQxN9ovJERMtNrHi2bBfKYWw9AdrIIM5B/6pB3BvWWMd8zv/zGq
         oh60y6HJqJglKv8UzNyUPkczvIbCKNPW45pNLRhgezAkfxr3uAjuOWpun/sTiUZS0yw8
         Ia9XPpWNWu5pO/i3MiSLQuzQRyyEPUKG6rdaekjPmM+UP6vtWiSwHIVup5rQIxMPEgJn
         YL601HuztIREjM1f+WKvv5HQtb9+q2D3EgmZpGw7Q0fAXYO9d41ExbY0oKKZedtMJBLp
         p7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215731; x=1729820531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALBNAZN1he27pKDTVzWnVA3I0wNwhnq8w84ZxJ/qpsY=;
        b=Jv7Bp62WFSyv+hxs0N4ak7+pZ7qFOvNuRJOx29hpWg16zz11ORQ+yF9yTtKIABCl3+
         xmpbFZ1zCHK/gYaLQV9qCzdx8Y4f3asP1qHXTWHByxi9kk3ZqvbMsHrhIhlJXty/VYwW
         jLA1CSRe3eecPeIDb2byKA16TitJM0xjMo3d/o+72GAHTNJGmeB35ulcQzAWfQsJjXKu
         VgqbKE8OD7UgmnpmVrnlTD+wPySiJCPt5gQ2VUe1V4B82vcSx1ZYs6PKFscoqXBK8qdB
         E8nZHrW1QNsb70Tbxp11SBVY67iyNAgkJHdc0TEHH9K4Wh/FTpb/cb4Go7k84Y/jPIU6
         q4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7o9stuc41noxIdrSrsSE6jQAqZkstYnuyKp8ZFNEofd201Eqf5Xt+teqWA+OgsRoQ4jK6v1wLZU1qzxns@vger.kernel.org, AJvYcCU8bsVE3M7SF1/JdfgyBBAQG9ZE6QBkVazl2VRuxxpF692CwlWREIRXZsySwHauFS5qhB2CpfmXqy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxae3DG0/cS1FavFP1+VV7XnpJoQ9gXG/2knYAIgstzH093lhIr
	gTADYd9Ip9/HAvKRUjC1ukhvAyiKWFGyx6Mu9S6nYZopo7U6Q4ygmS8TDYcHwPPA06q+R9ydfvP
	bRu4u9YhQ/xpXnwJuu416m/k9bCQ=
X-Google-Smtp-Source: AGHT+IHJjCTRnPMrusLOIaHmBpBSy+NjPS6XJDDYs16C/0iIeMg2T9ywou/03DYS7m7vtEiBM+sbqx0r98cYV3QsA/c=
X-Received: by 2002:a05:6871:3a08:b0:277:eb15:5c60 with SMTP id
 586e51a60fabf-2892c24d6aamr686215fac.10.1729215731580; Thu, 17 Oct 2024
 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017151624.3532430-1-dzm91@hust.edu.cn>
In-Reply-To: <20241017151624.3532430-1-dzm91@hust.edu.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 18 Oct 2024 09:41:45 +0800
Message-ID: <CAD-N9QUU5QC3L=nqJfSjsb75CWT3-Au48jVNuBiczofbr5zukA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: update the translation of process/coding-style.rst
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: si.yanteng@linux.dev, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Thorsten Blum <thorsten.blum@toblux.com>, SeongJae Park <sj@kernel.org>, 
	Federico Vaga <federico.vaga@vaga.pv.it>, hust-os-kernel-patches@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMTE6MTjigK9QTSBEb25nbGlhbmcgTXUgPGR6bTkxQGh1
c3QuZWR1LmNuPiB3cm90ZToNCj4NCj4gVXBkYXRlIHRvIGNvbW1pdCBjNWQ0MzZmMDVhM2YgKCJk
b2NzL3Byb2Nlc3M6IGZpeCB0eXBvcyIpDQo+DQo+IHNjcmlwdHMvY2hlY2t0cmFuc3RhdHVzLnB5
IHJlcG9ydHM6DQo+DQo+IERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3Mv
Y29kaW5nLXN0eWxlLnJzdA0KPiBjb21taXQgYzVkNDM2ZjA1YTNmICgiZG9jcy9wcm9jZXNzOiBm
aXggdHlwb3MiKQ0KPiBjb21taXQgODJiODAwMGMyOGI1ICgibmV0OiBkcm9wIHNwZWNpYWwgY29t
bWVudCBzdHlsZSIpDQo+IDIgY29tbWl0cyBuZWVkcyByZXNvbHZpbmcgaW4gdG90YWwNCg0KU29y
cnksIGd1eXMuIEkgbWlzdHlwZWQgdGhlIHNjcmlwdCBuYW1lIGluIHRoZSB0cmFuc2xhdGlvbiB1
cGRhdGUNCnBhdGNoZXMgYW5kIEkgc2VudCB2MiBwYXRjaGVzIG9mIHRoZW0gc29vbi4NCg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEb25nbGlhbmcgTXUgPGR6bTkxQGh1c3QuZWR1LmNuPg0KPiAtLS0N
Cj4gIC4uLi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0ICAgICAg
IHwgMTEgLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3Mv
Y29kaW5nLXN0eWxlLnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nl
c3MvY29kaW5nLXN0eWxlLnJzdA0KPiBpbmRleCAxMGI5Y2I0ZjZhNjUuLjA0ODRkMGM2NWMyNSAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9j
b2Rpbmctc3R5bGUucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdA0KPiBAQCAtNTYwLDE3ICs1NjAsNiBAQCBEb2N1bWVu
dGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9kb2MtZ3VpZGUvaW5kZXgucnN0IOWSjCBzY3JpcHRz
L2tlcm5lbC1kb2Mg44CCDQo+ICAgICAgICAgICogd2l0aCBiZWdpbm5pbmcgYW5kIGVuZGluZyBh
bG1vc3QtYmxhbmsgbGluZXMuDQo+ICAgICAgICAgICovDQo+DQo+IC3lr7nkuo7lnKggbmV0LyDl
kowgZHJpdmVycy9uZXQvIOeahOaWh+S7tu+8jOmmlumAieeahOmVvyAo5aSa6KGMKSDms6jph4rp
o47moLzmnInkupvkuI3lkIzjgIINCj4gLQ0KPiAtLi4gY29kZS1ibG9jazo6IGMNCj4gLQ0KPiAt
ICAgICAgIC8qIFRoZSBwcmVmZXJyZWQgY29tbWVudCBzdHlsZSBmb3IgZmlsZXMgaW4gbmV0LyBh
bmQgZHJpdmVycy9uZXQNCj4gLSAgICAgICAgKiBsb29rcyBsaWtlIHRoaXMuDQo+IC0gICAgICAg
ICoNCj4gLSAgICAgICAgKiBJdCBpcyBuZWFybHkgdGhlIHNhbWUgYXMgdGhlIGdlbmVyYWxseSBw
cmVmZXJyZWQgY29tbWVudCBzdHlsZSwNCj4gLSAgICAgICAgKiBidXQgdGhlcmUgaXMgbm8gaW5p
dGlhbCBhbG1vc3QtYmxhbmsgbGluZS4NCj4gLSAgICAgICAgKi8NCj4gLQ0KPiAg5rOo6YeK5pWw
5o2u5Lmf5piv5b6I6YeN6KaB55qE77yM5LiN566h5piv5Z+65pys57G75Z6L6L+Y5piv6KGN55Sf
57G75Z6L44CC5Li65LqG5pa55L6/5a6e546w6L+Z5LiA54K577yM5q+P5LiA6KGMDQo+ICDlupTl
j6rlo7DmmI7kuIDkuKrmlbDmja4gKOS4jeimgeS9v+eUqOmAl+WPt+adpeS4gOasoeWjsOaYjuWk
muS4quaVsOaNrinjgILov5nmoLfkvaDlsLHmnInnqbrpl7TmnaXkuLrmr4/kuKrmlbDmja4NCj4g
IOWGmeS4gOauteWwj+azqOmHiuadpeino+mHiuWug+S7rOeahOeUqOmAlOS6huOAgg0KPiAtLQ0K
PiAyLjQzLjANCj4NCj4NCg==

