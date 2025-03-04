Return-Path: <linux-kernel+bounces-544739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCAA4E4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00D142336D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F55284B35;
	Tue,  4 Mar 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y81j28FQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E3283C9F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102583; cv=none; b=hUuzu1t6xgXrUuvcJmtVn5IHPKzDG/Qve7rLFdmEkxt+kSys3LYQsl4qGU4n3I6urZ9F1s4RAn6AVskV8MihsZkGmxpElMZAsjgYFEg7H4deMPf+9WIcBvshTqeOxkjn1HOPbfJR+zt7g2gTbLHBYotrxFopZXP+0bp3DudyNB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102583; c=relaxed/simple;
	bh=Wq2v8kM/nnvRK7yWNuWZmKYuwktShtrJSe1RPKHvEF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZl1xYPK1x7hEXPdKeCcwAY/jbCYquPFNkou2sUTbXBXLJmmxgX/SS62ChASXKwND+6mTO9qVeTSqzU7Wzi4KqwZ+KRKlA9kxkJeDTPHu0y5fpGEuVBrF5bSESYeqURu/f6wOG2kkXzAxVl/XfcmHsJurCswI8hKbEJOOxOsIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y81j28FQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438da39bb69so42514795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741102580; x=1741707380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq2v8kM/nnvRK7yWNuWZmKYuwktShtrJSe1RPKHvEF0=;
        b=y81j28FQuzcgseRVhBJ8UQwUsK5HxT753SS5nI+93gR82NNr8euskDiX0uLOPf1BNv
         /YDnrKnUBwYdqubOH6kiXOX+2wss9/RHvIZq3DXrjQJ9rFuYcEqxpnFdab9cuZoy5OEo
         8e77LiL01WQUj+G0j3LDhtVJoNXrwbdFL8G2otkxgyBQlz5xHxm3uORU8hg3XEu1DSgP
         K7k/uRKfxhw2DdKt/0XiQ40zpLG6KjjuYihL266NBTBoRg3y4R3wd3T4uVtb1VccvcQ8
         t2EcgS//AQapDfqlZp2zBic83PONp3PtLKXAF+fLFgKxs9lpcrIjM8zHZP8EUQFttcqK
         z/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102580; x=1741707380;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wq2v8kM/nnvRK7yWNuWZmKYuwktShtrJSe1RPKHvEF0=;
        b=BbNFJMeI261iz7FR6nDltlMPDl3XOCW+UKzpyqA62aqX/SjIRXoV/Vrcjjc023LnVl
         fv29JR2gPkZam0SPqU0urvFJbwNchIhkdxqh8Kq+XjszYmZu2PH0vT0iGjf9SJpxYXbx
         KP+1E8hzn1yue4klm4Oqo0Nb/NqG8bg17fV+4uhGt/iRDORDRQjGsQxkJdEV+6AuWgk8
         dAef4TIJ842whVKWZyhslvhMyRlr8SxDvmMWOttQayGHoRJ5fg13cMeKkvput01eE/Ie
         k/XBJ6WJU6S628Fb5e4U8kgMk5Rljriu7srR2bnAq7KZq8k/QWxpAot9K45LXADiBdMT
         Jo+w==
X-Forwarded-Encrypted: i=1; AJvYcCUjAjg7grbeM/KnlTidDw9zpAFK2TXpCFGo2U7q1h/eNeZtVRre32+ighdT4ih8EG2iQRlbm3g3klHCxjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+D7sQkW6PYXbL2zFSxZRVjz4uAOQGgxgToQdkqdRJpCf6QsA
	NIlJfn0oEc0/UM23VkJsF65rsyXEpNgAaUpoQ82dC8oLz2clSmikLHqeduZ5VaJlieRkz1Vpiot
	WmoVF5UaUPW7Ixg==
X-Google-Smtp-Source: AGHT+IHijklkBWkk19vuFCTOjS1+4MgEGEoY1h9rIdV0rc5botTxFkn35XXkTi0FIqcmV8v8cbJtmyY8fqzdU7w=
X-Received: from wmbfj11.prod.google.com ([2002:a05:600c:c8b:b0:43b:cc8b:e6aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f81:b0:439:608b:c4ad with SMTP id 5b1f17b1804b1-43ba66e5ea6mr140003915e9.3.1741102580207;
 Tue, 04 Mar 2025 07:36:20 -0800 (PST)
Date: Tue, 4 Mar 2025 15:36:18 +0000
In-Reply-To: <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com> <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
Message-ID: <Z8cd8taTQbIJOdsp@google.com>
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, sebastian.reichel@collabora.com, 
	sjoerd.simons@collabora.co.uk, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, benno.lossin@proton.me, tmgross@umich.edu, 
	dakr@kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

T24gV2VkLCBGZWIgMTksIDIwMjUgYXQgMDI6MTA6MjRQTSAtMDMwMCwgRGFuaWVsIEFsbWVpZGEg
d3JvdGU6DQo+IEhpIEFsaWNlLA0KDQo+ID4gT24gMTkgRmViIDIwMjUsIGF0IDEzOjI4LCBBbGlj
ZSBSeWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJIHdvbmRlciBp
ZiBlbmFibGVkIHZzIGRpc2FibGVkIHNob3VsZCBiZSB0d28gZGlmZmVyZW50IHR5cGVzPw0KPiA+
DQo+ID4gQWxpY2UNCg0KPiBJIHRob3VnaHQgYWJvdXQgaGF2aW5nIHR3byB0eXBlcyB0b28sIGJ1
dCBJIHRoaW5rIGl0IGNvbXBsaWNhdGVzIHRoZSAgDQo+IGRlc2lnbi4NCg0KDQo+IGBgYA0KPiBs
ZXQgZm9vOiBSZWd1bGF0b3IgPSBSZWd1bGF0b3I6OmdldCgvKuKApiovKT87DQo+IGxldCBmb29f
ZW5hYmxlZDogRW5hYmxlZFJlZ3VsYXRvciA9IGZvby5lbmFibGUoKT86DQo+IGBgYA0KDQo+IExl
dOKAmXMgZmlyc3QgYWdyZWUgdGhhdCBgUmVndWxhdG9yOjpkcm9wYCBpcyB0aGUgcmlnaHQgcGxh
Y2UgdG8gaGF2ZSAgDQo+IGByZWd1bGF0b3JfcHV0YCwgc2luY2UNCj4gYFJlZ3VsYXRvcjo6Z2V0
KClgIGFjcXVpcmVkIHRoZSByZWZlcmVuY2UgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQo+IFRoaXMg
bWVhbnMgdGhhdCBub3csIGBFbmFibGVkUmVndWxhdG9yYCBoYXMgdG8gZGVwZW5kIG9uIGBSZWd1
bGF0b3JgICANCj4gc29tZWhvdyB0byBlbnN1cmUNCj4gYSBwcm9wZXIgZHJvcCBvcmRlci4gT3Ro
ZXJ3aXNlIHlvdSBtaWdodCBoYXZlIGFuIGVuYWJsZWQgcmVndWxhdG9yIGZvciAgDQo+IHdoaWNo
IHlvdSBkb27igJl0IG93bg0KPiB0aGUgcmVmY291bnQuIEZ1cnRoZXJtb3JlLCBpZiBSZWd1bGF0
b3IgZHJvcHMgd2hpbGUgRW5hYmxlZFJlZ3VsYXRvciBpcyAgDQo+IGFsaXZlLCB5b3UgZ2V0IGEg
c3BsYXQuDQoNCj4gSW4gYSBkcml2ZXIsIHlvdSBub3cgaGF2ZSB0byBzdG9yZSBib3RoIFJlZ3Vs
YXRvciAtIGZvciB0aGUgcmVmY291bnQgLSAgDQo+IGFuZCBFbmFibGVkUmVndWxhdG9yDQo+IC0g
YXMgYSB3YXkgdG8gdGVsbCB0aGUgc3lzdGVtIHlvdSBuZWVkIHRoYXQgcmVndWxhdG9yIHRvIGJl
IGFjdGl2ZS4NCg0KPiBJZiBFbmFibGVkUmVndWxhdG9yIGlzIGEgZ3VhcmQgdHlwZSwgdGhpcyBk
b2VzbuKAmXQgd29yaywgYXMgaXQgY3JlYXRlcyBhICANCj4gc2VsZi1yZWZlcmVuY2UgLSBvbiB0
b3ANCj4gb2YgYmVpbmcgZXh0cmVtZWx5IGNsdW5reS4NCg0KWW91IGRlZmluaXRlbHkgZG8gbm90
IHdhbnQgYSBndWFyZCB0eXBlLg0KDQo+IFlvdSBjYW4gdGhlbiBoYXZlIEVuYWJsZWRSZWd1bGF0
b3IgY29uc3VtZSBSZWd1bGF0b3IsIGJ1dCB0aGlzIGFzc3VtZXMgIA0KPiB0aGF0IHRoZSByZWd1
bGF0b3INCj4gd2lsbCBiZSBvbiBhbGwgdGhlIHRpbWUsIHdoaWNoIGlzIG5vdCB0cnVlLiBBIHNp
bXBsZSBwYXR0ZXJuIG9mDQoNCj4gYGBgDQo+IHJlZ3VsYXRvcl9lbmFibGUoKQ0KPiBkb19mYW5j
eV9zdHVmZigpDQo+IHJlZ3VsYXRvcl9kaXNhYmxlKCkNCj4gYGBgDQoNCj4gQmVjb21lcyBhIHBh
aW4gd2hlbiBvbmUgdHlwZSBjb25zdW1lcyB0aGUgb3RoZXI6DQoNCj4gYGBgDQo+IHNlbGYubXlf
cmVndWxhdG9yLmVuYWJsZSgpIC8vIGVycm9yLCBtb3ZlcyBvdXQgb2YgYCZzZWxmYA0KPiBgYGAN
Cg0KPiBJIGFtIHN1cmUgd2UgY2FuIGZpbmQgd2F5cyBhcm91bmQgdGhhdCwgYnV0IGEgc2ltcGxl
IGBib29sYCBoZXJlIHNlZW1zIHRvICANCj4gZml4IHRoaXMgcHJvYmxlbS4NCg0KV2hhdCBJIG1l
YW50IHRvIHN1Z2dlc3QgaXMgdHdvIHR5cGVzOg0KDQoJcHViIHN0cnVjdCBEaXNhYmxlZFJlZ3Vs
YXRvciB7DQoJICAgIGlubmVyOiBOb25OdWxsPGJpbmRpbmdzOjpyZWd1bGF0b3I+LA0KCX0NCglw
dWIgc3RydWN0IEVuYWJsZWRSZWd1bGF0b3Igew0KCSAgICBpbm5lcjogRGlzYWJsZWRSZWd1bGF0
b3IsDQoJfQ0KDQoJaW1wbCBEcm9wIGZvciBFbmFibGVkUmVndWxhdG9yIHsNCgkgICAgZm4gZHJv
cCgmbXV0IHNlbGYpIHsNCgkgICAgICAgIHVuc2FmZSB7IGJpbmRpbmdzOjpyZWd1bGF0b3JfZGlz
YWJsZShzZWxmLmlubmVyLmFzX3B0cigpKSB9Ow0KCQkvLyBEZXN0cnVjdG9yIG9mIERpc2FibGVk
UmVndWxhdG9yIHJ1bnMgbm93IHNpbmNlIGl0J3MgYQ0KCQkvLyBmaWVsZCBvZiBFbmFibGVkUmVn
dWxhdG9yLg0KCSAgICB9DQoJfQ0KCWltcGwgRHJvcCBmb3IgRGlzYWJsZWRSZWd1bGF0b3Igew0K
CSAgICBmbiBkcm9wKCZtdXQgc2VsZikgew0KCSAgICAgICAgdW5zYWZlIHsgYmluZGluZ3M6OnJl
Z3VsYXRvcl9wdXQoc2VsZi5pbm5lci5hc19wdHIoKSkgfTsNCgkgICAgfQ0KCX0NCg0KVGhpcyBn
aXZlcyB0aGUgcmlnaHQgYmVoYXZpb3IuIEZvciBkZXZpY2VzIHdoZXJlIHRoZSByZWd1bGF0b3Ig
aXMgYWx3YXlzDQpnb2luZyB0byBiZSBlbmFibGVkLCB5b3UganVzdCBzdG9yZSBhbiBFbmFibGVk
UmVndWxhdG9yLiBJZiB5b3UgbmVlZCB0bw0KZHluYW1pY2FsbHkgc3dpdGNoIGJldHdlZW4gdGhl
bSwgeW91IHN0b3JlIGFuIGVudW0gbGlrZSBCb3F1biBzdWdnZXN0ZWQuDQoNCkFsaWNlDQo=

