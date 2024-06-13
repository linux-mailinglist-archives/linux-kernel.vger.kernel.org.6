Return-Path: <linux-kernel+bounces-212537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B928F9062CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D89287F06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062B6130AFF;
	Thu, 13 Jun 2024 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="WUM/po79"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A952F34
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250001; cv=none; b=AyeQqm9FmrGwcoMQy+lPJARooggANOAsvi/5JfIJjyRCV6EwD8rF8lus+zEfioz/BNz2AYShkRBJYt/LMTXjMADJepHFc+ggMMr0VSW7In34oNlh/DoqEANnnnX0X0Xutqz+fVtV/yS7W68SgBG2vjslbzRBryWnr9giJjm3uK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250001; c=relaxed/simple;
	bh=LJ5kXAtYL8gEItPISbn48ORF+1W3QeRjbyPGLJisFm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttTvqBOS0NWV33ROrT/1kpYywt6Xour6dwkLb5/kqhB9AFN+cS2M9uT/YtTRYVUgDFi6FB/5/EIi+K7XderJmdJc/wGQqUBp3ty4mLyC11BIiVswJsQkp7u3hgzUtGbrRqEyj+Zm4N6c1IEZofXgy3EXsxcC+4V4qyjgvjJh5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=WUM/po79; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 80E212C04C9;
	Thu, 13 Jun 2024 15:39:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718249996;
	bh=LJ5kXAtYL8gEItPISbn48ORF+1W3QeRjbyPGLJisFm4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WUM/po796Jg9SzaMxI6QEMDqv9VvHHqwlEICN1jKrdKgop3LK3YePBZdb2leuc/D8
	 LcwVvqhuTLRPQN0OxAYBv36h8OpOHx9ZMKG92FvW6/dqa8CGzIRcdmpnd+KRVVw+92
	 mdEUlAm0sg6HJeJ87edG5YAATQJNxKeLHmyyUM2/waA5Lo833JP0EIozgqilS6g1Fs
	 Tcx6pKdQ/LD7w4SgDYFvc2j5sXnEtv7KfSaXkXcyugl17147BfJIhkB1gCq5f3bOKw
	 0M5lIBAEB9afhrG7PjkRMhqj1DPOkpRAe3IL635yES51MN5T4MJfnTYkP7CirVoyq9
	 VkmCf2mwTIfGg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666a6a0c0001>; Thu, 13 Jun 2024 15:39:56 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Jun 2024 15:39:56 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 13 Jun 2024 15:39:56 +1200
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "kees@kernel.org" <kees@kernel.org>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "mw@semihalf.com" <mw@semihalf.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Thread-Topic: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Thread-Index: AQHavTxCpfA370i+oU29gaqwaSvBMbHEOXoAgAACO4CAAAXggIAAAX6A
Date: Thu, 13 Jun 2024 03:39:55 +0000
Message-ID: <f0ec06fe746c612a5c7c72159e89e51ed0af1953.camel@alliedtelesis.co.nz>
References: <20240611193318.5ed8003a@kernel.org>
	 <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
	 <202406122003.E02C37ADD1@keescook>
	 <6c2592c517878a69d37e1957d9624d83dbc982ab.camel@alliedtelesis.co.nz>
	 <202406122033.69D9ABFC24@keescook>
In-Reply-To: <202406122033.69D9ABFC24@keescook>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACC666166DC08C4AB49BCB249DE070C3@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666a6a0c a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=VwQbUJbxAAAA:8 a=Ens2HzU3bXgJHz7i4kkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI0LTA2LTEyIGF0IDIwOjM0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgSnVuIDEzLCAyMDI0IGF0IDAzOjEzOjM0QU0gKzAwMDAsIEFyeWFuIFNyaXZhc3RhdmEg
d3JvdGU6DQo+ID4gT24gV2VkLCAyMDI0LTA2LTEyIGF0IDIwOjA1IC0wNzAwLCBLZWVzIENvb2sg
d3JvdGU6DQo+ID4gPiBPbiBUaHUsIEp1biAxMywgMjAyNCBhdCAwMjo0OTowMFBNICsxMjAwLCBB
cnlhbiBTcml2YXN0YXZhIHdyb3RlOg0KPiA+ID4gPiBTZXR0aW5nIGZyYWdfc2l6ZSB0byAwIHRv
IGluZGljYXRlIGttYWxsb2MgaGFzIGJlZW4gZGVwcmVjYXRlZCwNCj4gPiA+ID4gdXNlIHNsYWJf
YnVpbGRfc2tiIGRpcmVjdGx5Lg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IGNlMDk4ZGExNDk3
YyAoInNrYnVmZjogSW50cm9kdWNlIHNsYWJfYnVpbGRfc2tiKCkiKQ0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBcnlhbiBTcml2YXN0YXZhDQo+ID4gPiA+IDxhcnlhbi5zcml2YXN0YXZhQGFsbGll
ZHRlbGVzaXMuY28ubno+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGluIHYxOg0KPiA+
ID4gPiAtIEFkZGVkIEZpeGVzIHRhZw0KPiA+ID4gDQo+ID4gPiBUaGlzIGxvb2tzIGxpa2Ugc2lt
aWxhciB1cGRhdGVzIGxpa2UgY29tbWl0IDk5YjQxNWZlODk4NiAoInRnMzoNCj4gPiA+IFVzZQ0K
PiA+ID4gc2xhYl9idWlsZF9za2IoKSB3aGVuIG5lZWRlZCIpDQo+ID4gWWVhaCwgSSBub3RpY2Vk
IHRoYXQgd2hlbiBJIHdhcyBsb29raW5nIGZvciBleGFtcGxlcyBvZiBvdGhlcg0KPiA+ICJGaXhl
cyINCj4gPiB0YWdzIGZvciB0aGUgInNrYnVmZjogSW50cm9kdWNlIHNsYWJfYnVpbGRfc2tiKCki
IGNvbW1pdC4gSSBzdXNwZWN0DQo+ID4gdGhlcmUgYXJlIG1hbnkgZHJpdmVycyB0aGF0IHdpbGwg
bmVlZCB0aGlzICJmaXgiLg0KPiANCj4gWWVhaCwgYXQgdGhlIHRpbWUgdGhlIEFQSSBjaGFuZ2Vz
IHdhcyBtYWRlIGl0IHdhcyBjbGVhciBpdCB3YXNuJ3QNCj4gZWFzeQ0KPiB0byBpZGVudGlmeSB3
aGljaCBuZWVkZWQgaXQsIHNvIHRoZSBXQVJOIHdhcyBhZGRlZCBhbG9uZyB3aXRoDQo+IHN1cHBv
cnRpbmcNCj4gdGhlIG9sZCBzdHlsZSB2aWEgaW50ZXJuYWwgZmFsbC1iYWNrLg0KPiANCj4gLUtl
ZXMNCkkgbG92ZSB0aGF0IGFib3V0IHRoZSBrZXJuZWwuIEp1c3QgbnVkZ2VzIHlvdSBpbiB0aGUg
cmlnaHQgZGlyZWN0aW9uLg0KDQotQXJ5YW4NCj4gDQo+ID4gPiANCj4gPiA+IFJldmlld2VkLWJ5
OiBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4NCj4gPiA+IA0KPiA+IA0KPiANCg0K

