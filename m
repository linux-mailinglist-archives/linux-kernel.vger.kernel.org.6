Return-Path: <linux-kernel+bounces-370750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE349A319D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311681C22842
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500E3BB21;
	Fri, 18 Oct 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="L82Zdmuj"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381F2A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210506; cv=none; b=hm+tdWbEX/AgZB/TYOonsn5QBVB37LzsAV/wrrGyjt2JlYhgXXxUm/7g5KFscXSgH2plhViSmZLUKyxPF3h6QI+iy9EsKXCH3jEE9MlrjatuOYwkB0h84MmPRH1cMGwaycMpc9kRMv4/VnUDdyn6enyHKJhnsb2/ESJm+/Fye34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210506; c=relaxed/simple;
	bh=lWaE8HTO9nKGearS0vqXXnBqfkWQHN0a9uK12C9EiJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnT5obpWP9605wXoHFc4Jf9UrOLnB4iZhpqmSWNtjetk6dU89M1BQRJ3wIzoE3JTUOREsP72/c9W80prESZyGkBZpUuhTkI3i9tC/3ORn9rSI6RUDSpO1/m5KqJeb2EOAlwJCugMFXjZS+jFEvVsmXxhs486+LNsfih/0w0JB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=L82Zdmuj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0B0322C0707;
	Fri, 18 Oct 2024 13:15:01 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729210501;
	bh=lWaE8HTO9nKGearS0vqXXnBqfkWQHN0a9uK12C9EiJM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=L82ZdmujmuwSQK5eAvWtOEBrIL4IY4tNSxAM8U74dVGZcf7IoivUW7w/pOxVP0dFQ
	 3malGLUFIc1/mdKH1A1bRSzcUfsFR1n+6qrwjKXS+Whk487NbqgKUg53MLT9xh5g01
	 LTC7tLiLxgUYKDuz9pULTurzKw+OfMyZSvviyY2ieF3TUaW1UjXxzfw+m38Ni82uKa
	 60P1Gt+psgLors1d4BHIzHHRmFV8aqqllxk2zH/C+8rnryvbBASeg0+3hEyjH3E3fK
	 ZGYmjiMs2/6nxh4onN3Is35823QvVfgpw1KHs07LKo5cJ8RcBAUeHiV8PgidQ4vxnY
	 SU3Ue6aYLYKOA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6711a8840006>; Fri, 18 Oct 2024 13:15:00 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 13:15:00 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Fri, 18 Oct 2024 13:15:00 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 18 Oct 2024 13:15:00 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next:master 4889/5321] arch/powerpc/boot/dts/turris1x.dtb:
 reboot@d: {'compatible': ['syscon-reboot'], 'reg': [[13, 1]], 'offset': 13,
 'mask': 1, 'value': 1, 'priority': 64, '$nodename': ['reboot@d']} is valid
 under each of {'required': ['re...
Thread-Topic: [linux-next:master 4889/5321]
 arch/powerpc/boot/dts/turris1x.dtb: reboot@d: {'compatible':
 ['syscon-reboot'], 'reg': [[13, 1]], 'offset': 13, 'mask': 1, 'value': 1,
 'priority': 64, '$nodename': ['reboot@d']} is valid under each of
 {'required': ['re...
Thread-Index: AQHbIPLFhVkvcFWAik+XQN0TIWWq2Q==
Date: Fri, 18 Oct 2024 00:15:00 +0000
Message-ID: <a1e2d600-207c-4bc4-9a00-7295e2748daa@alliedtelesis.co.nz>
References: <ZxGZefa4fr4h2PnJ@rli9-mobl>
In-Reply-To: <ZxGZefa4fr4h2PnJ@rli9-mobl>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BEEDF312E06F947A6DAFE7DF574AC5F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6711a885 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=gEfo2CItAAAA:8 a=lIjbESVBPm7NPAriZmkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxOC8xMC8yNCAxMjoxMCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IHRyZWU6ICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51
eC1uZXh0LmdpdCBtYXN0ZXINCj4gaGVhZDogICA3ZGYxZTcxODljZWNiNjk2NWNlNjcyZTgyMGE1
ZWM2Y2Y0OTliNjViDQo+IGNvbW1pdDogZTdhZjdkMTMzMTZkYzVlMjI5M2M0Zjc3N2Y3MWJkODMz
MWY1ZDdhNSBbNDg4OS81MzIxXSBkdC1iaW5kaW5nczogcmVzZXQ6IHN5c2Nvbi1yZWJvb3Q6IEFk
ZCByZWcgcHJvcGVydHkNCj4gOjo6Ojo6IGJyYW5jaCBkYXRlOiAxMSBob3VycyBhZ28NCj4gOjo6
Ojo6IGNvbW1pdCBkYXRlOiAyMyBob3VycyBhZ28NCj4gY29uZmlnOiBwb3dlcnBjLXJhbmRjb25m
aWctMDUyLTIwMjQxMDE3IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUv
MjAyNDEwMTgvMjAyNDEwMTgwMzA1LlpGbEduelZCLWxrcEBpbnRlbC5jb20vY29uZmlnKQ0KPiBj
b21waWxlcjogcG93ZXJwYy1saW51eC1nY2MgKEdDQykgMTQuMS4wDQo+IGR0c2NoZW1hIHZlcnNp
b246IDIwMjQuMTAuZGV2NitnMTJjM2NkNQ0KPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVp
bGQpOiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjQxMDE4LzIw
MjQxMDE4MDMwNS5aRmxHbnpWQi1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4NCj4gSWYgeW91
IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3Qg
YSBuZXcgdmVyc2lvbiBvZg0KPiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZv
bGxvd2luZyB0YWdzDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MTAxODAz
MDUuWkZsR256VkItbGtwQGludGVsLmNvbS8NCj4NCj4gZHRjaGVjayB3YXJuaW5nczogKG5ldyBv
bmVzIHByZWZpeGVkIGJ5ID4+KQ0KPiAgICAgYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL3R1cnJpczF4
LmR0Yjogbm9yQDAsMDogJG5vZGVuYW1lOjA6ICdub3JAMCwwJyBkb2VzIG5vdCBtYXRjaCAnXihm
bGFzaHwuKnNyYW18bmFuZCkoQC4qKT8kJw0KPiAgICAgCWZyb20gc2NoZW1hICRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbXRkL210ZC1waHlzbWFwLnlhbWwjDQo+ICAgICBhcmNo
L3Bvd2VycGMvYm9vdC9kdHMvdHVycmlzMXguZHRiOiAvbG9jYWxidXNAZmZlMDUwMDAvbmFuZEAx
LDA6IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydmc2wscDIw
MjAtZmNtLW5hbmQnLCAnZnNsLGVsYmMtZmNtLW5hbmQnXQ0KPiAgICAgYXJjaC9wb3dlcnBjL2Jv
b3QvZHRzL3R1cnJpczF4LmR0YjogL2xvY2FsYnVzQGZmZTA1MDAwL25hbmRAMSwwOiBmYWlsZWQg
dG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnZnNsLHAyMDIwLWZjbS1uYW5k
JywgJ2ZzbCxlbGJjLWZjbS1uYW5kJ10NCj4gICAgIGFyY2gvcG93ZXJwYy9ib290L2R0cy90dXJy
aXMxeC5kdGI6IGNwbGRAMywwOiAkbm9kZW5hbWU6MDogJ2NwbGRAMywwJyBkb2VzIG5vdCBtYXRj
aCAnXihbYS16XVthLXowLTlcXC1dKy1idXN8YnVzfGxvY2FsYnVzfHNvY3xheGl8YWhifGFwYiko
QC4rKT8kJw0KPiAgICAgCWZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvc2ltcGxlLWJ1cy55YW1sIw0KPiAgICAgYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL3R1cnJp
czF4LmR0YjogL2xvY2FsYnVzQGZmZTA1MDAwL2NwbGRAMywwOiBmYWlsZWQgdG8gbWF0Y2ggYW55
IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnY3puaWMsdHVycmlzMXgtY3BsZCcsICdmc2wscDEw
MjFyZGItcGMtY3BsZCcsICdzaW1wbGUtYnVzJywgJ3N5c2NvbiddDQo+ICAgICBhcmNoL3Bvd2Vy
cGMvYm9vdC9kdHMvdHVycmlzMXguZHRiOiAvbG9jYWxidXNAZmZlMDUwMDAvY3BsZEAzLDA6IGZh
aWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydjem5pYyx0dXJyaXMx
eC1jcGxkJywgJ2ZzbCxwMTAyMXJkYi1wYy1jcGxkJywgJ3NpbXBsZS1idXMnLCAnc3lzY29uJ10N
Cj4gICAgIGFyY2gvcG93ZXJwYy9ib290L2R0cy90dXJyaXMxeC5kdGI6IHdhdGNoZG9nQDI6IFVu
ZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5vdCBhbGxvd2VkICgnZ3Bpb3MnIHdhcyB1bmV4cGVj
dGVkKQ0KPiAgICAgCWZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvd2F0Y2hkb2cvbWF4aW0sbWF4NjN4eC55YW1sIw0KPj4+IGFyY2gvcG93ZXJwYy9ib290L2R0
cy90dXJyaXMxeC5kdGI6IHJlYm9vdEBkOiB7J2NvbXBhdGlibGUnOiBbJ3N5c2Nvbi1yZWJvb3Qn
XSwgJ3JlZyc6IFtbMTMsIDFdXSwgJ29mZnNldCc6IDEzLCAnbWFzayc6IDEsICd2YWx1ZSc6IDEs
ICdwcmlvcml0eSc6IDY0LCAnJG5vZGVuYW1lJzogWydyZWJvb3RAZCddfSBpcyB2YWxpZCB1bmRl
ciBlYWNoIG9mIHsncmVxdWlyZWQnOiBbJ3JlZyddfSwgeydyZXF1aXJlZCc6IFsnb2Zmc2V0J119
DQoNClRoaXMgd2lsbCBiZSBiZWNhdXNlIG9mIG15IGNoYW5nZXMgdG8gYWRkIHJlZyBhbmQgdGhl
IG9uZU9mOiBvZmZzZXQsIHJlZyANCnRvIHN5c2Nvbi1yZWJvb3QueWFtbC4gUHJpb3IgdG8gdGhp
cyBJJ20gZ3Vlc3NpbmcgdGhlcmUgd2FzIGVpdGhlciBhIA0KZGlmZmVyZW50IHdhcm5pbmcgb3Ig
cG9zc2libHkganVzdCBub3RoaW5nIHNpbmNlIHRoZSB1bnVzZWQgcHJvcGVydHkgd2FzIA0KInJl
ZyIuDQoNCkhvdyBkbyB3ZSB3YW50IHRvIGhhbmRsZSB0aGlzPyBJIGNvdWxkIHByb2JhYmx5IGNo
YW5nZSBvbmVPZiB0byBhbnlPZiBpbiANCnRoZSBzY2hlbWEgd2hpY2ggd291bGQgc2lsZW5jZSB0
aGUgd2FybmluZy4gVGVjaG5pY2FsbHkgaXQgc2hvdWxkIGJlIA0KZmluZSB0byByZW1vdmUgdGhl
IHJlZyBwcm9wZXJ0eSBmcm9tIHRoZSB0dXJyaXMxeC5kdHMgYXMgbm90aGluZyB3YXMgDQp1c2lu
ZyB0aGF0IGFuZCBldmVuIGFmdGVyIG15IGNoYW5nZXMgb2Zmc2V0IGlzIHVzZWQgZmlyc3QuIE9y
IHdlIGNvdWxkIA0KanVzdCBkbyBub3RoaW5nIHdoaWNoIEknbSBmaW5lIHdpdGguDQoNCj4gICAg
IAlmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bvd2VyL3Jl
c2V0L3N5c2Nvbi1yZWJvb3QueWFtbCMNCj4gICAgIGFyY2gvcG93ZXJwYy9ib290L2R0cy90dXJy
aXMxeC5kdGI6IC9sb2NhbGJ1c0BmZmUwNTAwMC9jcGxkQDMsMC9sZWQtY29udHJvbGxlckAxMzog
ZmFpbGVkIHRvIG1hdGNoIGFueSBzY2hlbWEgd2l0aCBjb21wYXRpYmxlOiBbJ2N6bmljLHR1cnJp
czF4LWxlZHMnXQ0KPiAgICAgYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL3R1cnJpczF4LmR0YjogcGNp
ZUBmZmUwODAwMDogcGNpZUAwOmludGVycnVwdHM6MDowOiAyNCBpcyBub3Qgb25lIG9mIFsxLCAy
LCAzLCA0XQ0KPiAgICAgCWZyb20gc2NoZW1hICRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvcGNpL3BjaS1idXMtY29tbW9uLnlhbWwjDQo+ICAgICBhcmNoL3Bvd2VycGMvYm9vdC9k
dHMvdHVycmlzMXguZHRiOiBwY2llQGZmZTA4MDAwOiBwY2llQDA6aW50ZXJydXB0czowOiBbMjQs
IDIsIDAsIDBdIGlzIHRvbyBsb25nDQo+ICAgICAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kvcGNpLWJ1cy1jb21tb24ueWFtbCMNCj4gICAgIGFyY2gv
cG93ZXJwYy9ib290L2R0cy90dXJyaXMxeC5kdGI6IC9wY2llQGZmZTA4MDAwOiBmYWlsZWQgdG8g
bWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnZnNsLG1wYzg1NDgtcGNpZSddDQo+
ICAgICBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvdHVycmlzMXguZHRiOiBwY2llQGZmZTA5MDAwOiBw
Y2llQDA6aW50ZXJydXB0czowOjA6IDI1IGlzIG5vdCBvbmUgb2YgWzEsIDIsIDMsIDRdDQo+ICAg
ICAJZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kvcGNp
LWJ1cy1jb21tb24ueWFtbCMNCj4gICAgIGFyY2gvcG93ZXJwYy9ib290L2R0cy90dXJyaXMxeC5k
dGI6IHBjaWVAZmZlMDkwMDA6IHBjaWVAMDppbnRlcnJ1cHRzOjA6IFsyNSwgMiwgMCwgMF0gaXMg
dG9vIGxvbmcNCj4=

