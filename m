Return-Path: <linux-kernel+bounces-514301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD6A35547
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FE61891268
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB431519AD;
	Fri, 14 Feb 2025 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djx+JOcL"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF214830C;
	Fri, 14 Feb 2025 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503521; cv=none; b=b66JmmRbVta0ntQpayUlQLbN7T3c8Sj5JmZd2jV9OBMadT2175OCmXTJeu5QMAoVfOVk3BVqrcMbuGouUvtKlMRoHB0rtP1AgqBxfaInIw6qxnaASZOXUSH1UHUhbZLLB1chomMJ6A8caq2YlE8rDau2WNQi+i8o4gaCqDl7ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503521; c=relaxed/simple;
	bh=w9HYXJG0rv2xVC9pcmOyCyIStMfgwOJdoPHxNLzKCaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv8KZJPbmO5pQObB2kCpfnsFfduY0ZzYIw0zDH+EatP4ef1Uoj0Y05VJzNbbF/TNzsN2jscEsEY5VMEChjUa1VPYzyk8JI5nZa7cV++n6unpJ9NzA4iAn3oYwnWdnWkLrBY71LYao5gGIibfTOYlfaR2hF6vJMFocuKdBfjGurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djx+JOcL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so2186413a12.2;
        Thu, 13 Feb 2025 19:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739503517; x=1740108317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9HYXJG0rv2xVC9pcmOyCyIStMfgwOJdoPHxNLzKCaE=;
        b=djx+JOcLv51RCvFdaMCspuxq1EWUTO55X+ImVEmR1EyjGet3rNj6RN2GSalPHA4bTz
         sP7kGQCvgAjwb3OrHQ1v6L+KNdAs0RfJozZhY7KGRXeVrWmPhsuGmnB9txIWeaIzfmrA
         65OMlalV3am8FdCs43SMTqZyElsxKgRCsL64HPLepN/NIX+7t9OIrkJreEACkY0oXLAk
         fqz16CQXKmK3XG0gkyAesKlut5mG6H1/Kacrtt0/U2V4iopEtgzQFrzrJKdsAOcfWdBT
         3Iorn79KasKVBkPShZDykn1AEpwcdTKpHXRLvj0eK92d9WZvcN6Tvq63PVbnI66id6A6
         txLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739503517; x=1740108317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9HYXJG0rv2xVC9pcmOyCyIStMfgwOJdoPHxNLzKCaE=;
        b=kqGXQGUx778wFynpRdzlp4lY1eBddzgXssYbZnoRU7N6zlBPu5iDO7B1K+R0v8VM/D
         GMV1WlBF9INg0SaJLk5wK9KxLgDeqEKUYWN7hRNGGC5S3oWJM0l/ZKTCVs0Wk4M3xq4/
         WxRzh26iK4jxcBC9eLE73qbNujq92uQ0o39dIwSI1LD4APTMzjllsqaN4hQkUZ/LAZI7
         1hTo5XIgo2mLDc0zhzDghC1gZWbNxGt88aZukoUyFmUvbZIumwoU05qRX/ysh5BshTbl
         H/cYY8ePnIu1IjUv1M037OkNbGdc9bqVAeRqCR9h2kY8HYdJrwDqfJN0EtAmbLKBTjNW
         j6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUwd0fYQF2hu2C/ySh2GUwRohQIV0dtvKDHk4nA4vfIPuZuLxDq4c4J/C6wVsBG2ktXOBx5wyH7Re8AgzRy@vger.kernel.org, AJvYcCXhbtmJap6jdnwfgtG1wMXXfuqeciB4xbv+vnXbckos4iawKl4FTazMWznlUrMFh/e5yo5xmIVzwSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nKOR3odSJu5Oh2wkw0UyzFLGbIj6s8cj2rn24MHAP/3EubGj
	dUQR4DEFedrC0u7oaSdSQuoGZkjHkMi99qv1lFlFyYOKW+fyxmy9fVUoUY2uj/ags33YVQjEdqf
	x6LQJGjOLlx0MtxvyGFsz3JZ5gB8=
X-Gm-Gg: ASbGncvQptZyLF7dnd3GS2h+ZaFGikKyT6w8O7pD9r2sfpquHlGgpsKw20pnrd7T8YV
	qQtbC9P+7/D0NgkfIOPkYYk4yq8V8fg1BQOPc9aJKkCcgBk5T0hFvoaAWa4csigRRMK3bnxZ3Na
	s=
X-Google-Smtp-Source: AGHT+IEUlE+kfTCvLHdFUzHl6QOkNbTuWG8wz5C8hTImslNHoReZnAPGkdjwD2baT4g0UYKN9apKni4Z95kXG351PKk=
X-Received: by 2002:a17:907:6e8b:b0:ab7:effe:e01d with SMTP id
 a640c23a62f3a-aba4eb9b4ffmr580973866b.4.1739503517342; Thu, 13 Feb 2025
 19:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
In-Reply-To: <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 14 Feb 2025 11:24:51 +0800
X-Gm-Features: AWEUYZmaEz_FoId4bx1Fvw31LCjXYicffxkV6lD_wuko5y6SQT9ElCQvZff3zs0
Message-ID: <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Yanteng Si <si.yanteng@linux.dev>
Cc: alexs@kernel.org, Yanteng Si <siyanteng@loongson.cn>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgNjoyNOKAr1BNIFlhbnRlbmcgU2kgPHNpLnlhbnRlbmdA
bGludXguZGV2PiB3cm90ZToNCj4NCj4NCj4g5ZyoIDIvMTMvMjUgMTo0MiBQTSwgYWxleHNAa2Vy
bmVsLm9yZyDlhpnpgZM6DQo+ID4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+
ID4NCj4gPiBBIGdvb2QgY2hlY2tlZCBzdW1taXQgY291bGQgc2F2ZSBtdWNoIHRpbWUgZm9yIGxp
bnV4LWRvYyBtYWludGFpbmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBTaGkgPGFs
ZXhzQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5j
bj4NCj4gPiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPiBDYzogbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+DQo+IFJldmlld2VkLWJ5OiBZYW50ZW5nIFNpIDxzaS55YW50ZW5nQGxpbnV4LmRldj4N
Cj4NCj4NCj4NCj4gPiAtLS0NCj4gPiAgIERvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L2luZGV4LnJzdCB8IDggKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy96aF9DTi9pbmRleC5yc3QNCj4gPiBpbmRleCA3NTc0ZTE2NzMxODAuLmNjNTEyY2E1NDE3MiAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5y
c3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pbmRleC5yc3QN
Cj4gPiBAQCAtMjYsNyArMjYsMTMgQEANCj4gPiAgIOmhuuS+v+ivtOS4i++8jOS4reaWh+aWh+ah
o+S5n+mcgOimgemBteWuiOWGheaguOe8lueggemjjuagvO+8jOmjjuagvOS4reS4reaWh+WSjOiL
seaWh+eahOS4u+imgeS4jeWQjOWwseaYr+S4reaWhw0KPiA+ICAg55qE5a2X56ym5qCH54K55Y2g
55So5Lik5Liq6Iux5paH5a2X56ym5a695bqm77yM5omA5Lul77yM5b2T6Iux5paH6KaB5rGC5LiN
6KaB6LaF6L+H5q+P6KGMMTAw5Liq5a2X56ym5pe277yMDQo+ID4gICDkuK3mloflsLHkuI3opoHo
toXov4c1MOS4quWtl+espuOAguWPpuWklu+8jOS5n+imgeazqOaEjyctJ++8jCc9J+etieespuWP
t+S4juebuOWFs+agh+mimOeahOWvuem9kOOAguWcqOWwhg0KPiA+IC3ooaXkuIHmj5DkuqTliLDn
pL7ljLrkuYvliY3vvIzkuIDlrpropoHov5vooYzlv4XopoHnmoQgYGBjaGVja3BhdGNoLnBsYGAg
5qOA5p+l5ZKM57yW6K+R5rWL6K+V44CCDQo+ID4gK+ihpeS4geaPkOS6pOWIsOekvuWMuuS5i+WJ
je+8jOS4gOWumuimgei/m+ihjOW/heimgeeahCBgYGNoZWNrcGF0Y2gucGxgYCDmo4Dmn6Xlkozn
vJbor5HmtYvor5XvvIznoa7kv50NCj4gPiAr5ZyoIGBgbWFrZSBodG1sZG9jcy9wZGZkb2NzYGAg
5Lit5LiN5aKe5Yqg5paw55qE5ZGK6K2m77yM5pyA5ZCO77yM5a6J6KOF5qOA5p+l5L2g55Sf5oiQ
55qEDQo+ID4gK2h0bWwvcGRmIOaWh+S7tu+8jOehruiupOWug+S7rOeci+i1t+adpeaYr+ato+W4
uOeahOOAgg0KPiA+ICsNCj4gPiAr5o+Q5Lqk5LmL5YmN6K+356Gu6K6k5L2g55qE6KGl5LiB5Y+v
5Lul5q2j5bi45o+Q5Lqk5Yiw5Lit5paH5paH5qGj57u05oqk5bqTOg0KPiA+ICtodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hbGV4cy9saW51eC5naXQvDQo+
DQo+ID4gK+WmguaenOS9oOeahOihpeS4geS+nei1luS6juWFtuS7luS6uueahOihpeS4gSwg5Y+v
5Lul5LiO5YW25LuW5Lq65ZWG6YeP5ZCO55Sx5p+Q5LiA5Liq5Lq65ZCI5bm25o+Q5Lqk44CCDQo+
DQo+IEkgdGhpbmsgdGhpcyByZXF1aXJlcyBhIGRldGFpbGVkIHR1dG9yaWFsLiBPdGhlcndpc2Us
IGl0DQo+DQo+IHdpbGwgaW5jcmVhc2UgdGhlIGRpZmZpY3VsdHkgZm9yIGJlZ2lubmVycyB0byBn
ZXQgc3RhcnRlZC4NCj4NCj4gSG93IGFib3V0IHJlbW92aW5nIGl0IGZvciBub3c/IEkgaGF2ZSBh
IHBsYW4gdG8gd3JpdGUNCj4NCj4gYSB0cmFuc2xhdGlvbiBndWlkZWJvb2suIFdoYXQncyB5b3Vy
IG9waW5pb24/DQoNCkdvb2QgaWRlYS4gSSBjYW4gaGVscCBjb250cmlidXRlLiBPdXIgVHJhbnNs
YXRpb24gVGVhbSBoYXMgYSBzaW1wbGUNCm9uZSB0byBndWlkZSB0ZWFtIG1lbWJlcnMgaW4ga2Vy
bmVsIGRvY3VtZW50IHRyYW5zbGF0aW9uLg0KDQpPbmUgaXNzdWUgaW4gbXkgbWluZCBpcywgYG1h
a2UgaHRtbGRvY3NgIG5lZWRzIG11Y2ggcmVzb3VjZSBpbiB0aGUgY29tcGlsYXRpb24uDQoNClsx
XSBodHRwczovL2dpdGh1Yi5jb20vaHVzdC1vcGVuLWF0b20tY2x1Yi9UcmFuc2xhdGVQcm9qZWN0
L3dpa2kvMy4xLSVFNSU4NiU4NSVFNiVBMCVCOCVFNiU5NiU4NyVFNiVBMSVBMyVFNyVCRiVCQiVF
OCVBRiU5MSVFNiU4QyU4NyVFNSU4RCU5Nw0KDQo+DQo+DQo+IFRoYW5rcywNCj4NCj4gWWFudGVu
Zw0KPg0KPiA+DQo+ID4gICDkuI5MaW51eCDlhoXmoLjnpL7ljLrkuIDotbflt6XkvZwNCj4gPiAg
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0K

