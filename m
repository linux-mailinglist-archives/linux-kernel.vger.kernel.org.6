Return-Path: <linux-kernel+bounces-263471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DECD93D68C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF951B24032
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949A17BB35;
	Fri, 26 Jul 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=destevez.net header.i=@destevez.net header.b="FpkXQIZH"
Received: from corg.destevez.net (corg.destevez.net [51.75.17.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C031F95A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.17.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009962; cv=none; b=Qs8i4c0iYWS0CChc7/vBhb6tEhKYH2Pwkw34IyZ+W7cSZ/utiWp7ykkhlAtDar7xIiPLEIJDWzQeWZ34j6ku9tWk6g+7B5eSn37u228mnKNwDMbAHC0HHo40AX5RhC3HrbzhnAreazn9DmmEiVTiBA3Xc+b+lIdPjsRCP1iHSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009962; c=relaxed/simple;
	bh=25ejrGl3AfCMO0zVEDy/PAgllfTt9B8kmkvmKXmWlnQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=YsEU9qS3+ChjAKr14rKxMKRl4wXbPUPHLIL0JIriBiKYUcULdGgLLC/SPDrGAKvat3txfDtbbhnQd3dbUCQFOlZR1DohrcFofojcLJvmFXY/jBXShBtKwb7RuElSX4GmzuG2DOZNNIV372tz4aUZvFsHg8JFYdfj9JE++CNhFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=destevez.net; spf=pass smtp.mailfrom=destevez.net; dkim=pass (4096-bit key) header.d=destevez.net header.i=@destevez.net header.b=FpkXQIZH; arc=none smtp.client-ip=51.75.17.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=destevez.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=destevez.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=destevez.net; s=corg; h=Content-Type:Subject:To:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=25ejrGl3AfCMO0zVEDy/PAgllfTt9B8kmkvmKXmWlnQ=; b=FpkXQIZHoUfsy76EiIW2sfo8ys
	ox4rtlP6rZ7oCpEtQlRng6tPa6SXp71iFLMJMG6465YW7PBxks950ZiziQi/lH4vXAOaHm2pM+tL/
	aAlJYugtQwVlKDwmibHdN4p2do4Ni13GrSYBjDB55kC0KeDwdLbFiirFGkutup8yiXV8ee43tPgsv
	T9Ygje+5mYrfzlscXj6ePp9h5344C7doOtvaKzW+1DIUKzs6utZo+H4vghqGg2YIWrAeS01wBu8G+
	1Y1393novUdhtTCeNh1yhEhi0RFDJEOdr7M8YX/xHFNLh10eMlgLbAhixYU5eiAPQjx5D1yEb72Zp
	4wiAi637aZ58j4HuZOm1P9xgTzPeXi26DjBR2W0sNAUTtGpyqS3l8BeSJP0GiLZcOPlbq5Kqj6RLf
	H80RxWSkH0y44gXF7ykYUFM7GgV5zZgcc4C281XtjzbdVHl74XVmcG4ibf25HKoh1yN89cFJCiwL6
	mkSzgXgT7SK0qDGSdxv7U7zej3j0P1oXxTQrTNJQCbp45gU7hoeB4FTFcFFCmlXztPrrCSQmBiJc4
	47rNK3pJpfua83cDpPDZmfYhv1eNHxt0CsQCkRcepnLarQEXnwSFepBJhdrDglDSI2Y5LD9hBkaHN
	1zdEPE8KtKcUtGba2Z85iDCDc8eV8TBxOA82OY91w=;
Received: from [2001:470:6915:1:5642:49ff:fe98:455a]
	by corg.destevez.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <daniel@destevez.net>)
	id 1sXMsZ-0078kJ-2d
	for linux-kernel@vger.kernel.org;
	Fri, 26 Jul 2024 17:29:12 +0200
Message-ID: <0e54ad1c-5008-480b-844a-a53e64c8ea7d@destevez.net>
Date: Fri, 26 Jul 2024 17:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Daniel_Est=C3=A9vez?= <daniel@destevez.net>
Autocrypt: addr=daniel@destevez.net; keydata=
 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
To: linux-kernel@vger.kernel.org
Subject: Writing to file with O_DIRECT from DMA buffer
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VvzrMxCku2hTwUdJdt1AhWZ1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VvzrMxCku2hTwUdJdt1AhWZ1
Content-Type: multipart/mixed; boundary="------------DOshSi0JvE3ETXvgbyiSeNku";
 protected-headers="v1"
From: =?UTF-8?Q?Daniel_Est=C3=A9vez?= <daniel@destevez.net>
To: linux-kernel@vger.kernel.org
Message-ID: <0e54ad1c-5008-480b-844a-a53e64c8ea7d@destevez.net>
Subject: Writing to file with O_DIRECT from DMA buffer

--------------DOshSi0JvE3ETXvgbyiSeNku
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkknbSB3b3JraW5nIG9uIGEgWnlucSBNUFNvQyAoYWFyY2g2NCkgc3lzdGVt
LiBJJ20gaW1wbGVtZW50aW5nIGEgDQp1c2Vyc3BhY2UgYXBwbGljYXRpb24gdGhhdCB3cml0
ZXMgZGF0YSBmcm9tIGEgRE1BIGJ1ZmZlciAoY29udGlndW91cyBpbiANCnBoeXNpY2FsIG1l
bW9yeSkgaW50byBhIGZpbGUgaW4gYW4gZXh0NCBmaWxlc3lzdGVtIG9uIGEgU1NELiBJIHdh
bnQgdG8gDQp1c2UgT19ESVJFQ1QgZm9yIHRoaXMsIGJlY2F1c2UgdGhlcmUgaXMgYSBsYXJn
ZXIgdGhyb3VnaHB1dCBkaWZmZXJlbmNlIA0Kd2hlbiBiZW5jaG1hcmtpbmcgd3JpdGVzIGZy
b20gYSBidWZmZXIgbG9jYXRlZCBpbiByZWd1bGFyIHVzZXJzcGFjZSANCm1lbW9yeSAoMjUw
IE1CL3Mgd2l0aG91dCBPX0RJUkVDVCB2cyAxMjAwIE1CL3Mgd2l0aCBPX0RJUkVDVCkuDQoN
ClRoZSBETUEgYnVmZmVyIGlzIGRlY2xhcmVkIHdpdGggYSByZXNlcnZlZC1tZW1vcnkgZW50
cnkgaW4gdGhlIGRldmljZSANCnRyZWUgYnkgdXNpbmcgYSBmaXhlZCBwaHlzaWNhbCBhZGRy
ZXNzLiBUaGVyZSBpcyBhIHNpbXBsZSBrZXJuZWwgbW9kdWxlIA0KdGhhdCBsZXRzIHRoZSB1
c2Vyc3BhY2UgYXBwbGljYXRpb24gbW1hcCgpIHRoaXMgYnVmZmVyLiBUaGUga2VybmVsIA0K
bW9kdWxlIHNpbXBseSBkb2VzIHJlbWFwX3Bmbl9yYW5nZSgpIHRvIGNyZWF0ZSB0aGUgdXNl
cnNwYWNlIHBhZ2VzIA0KY29ycmVzcG9uZGluZyB0byB0aGUgcGh5c2ljYWwgYWRkcmVzcyBy
YW5nZSBkZWNsYXJlZCBpbiB0aGUgZGV2aWNlIHRyZWUuIA0KQSBETUEgaW4gdGhlIE1QU29D
IEZQR0EgaGFzIGFscmVhZHkgd3JpdHRlbiBkYXRhIGludG8gdGhlIHBoeXNpY2FsIA0KbWVt
b3J5IGNvcnJlc3BvbmRpbmcgdG8gdGhpcyBETUEgYnVmZmVyIGJlZm9yZSB0aGUgYXBwbGlj
YXRpb24gYXR0ZW1wdHMgDQp0byB3cml0ZSB0aGUgZGF0YSB0byBhIGZpbGUuDQoNCldoZW4g
dGhlIHVzZXJzcGFjZSBhcHBsaWNhdGlvbiBhdHRlbXB0cyB0byB3cml0ZSBkYXRhIGZyb20g
dGhlIGJ1ZmZlciANCmludG8gdGhlIGZpbGUsIHdoaWNoIGhhcyBiZWVuIG9wZW5lZCB3aXRo
IE9fRElSRUNULCB0aGUgd3JpdGVzIGZhaWwgd2l0aCANCkVGQVVMVC4gV3JpdGVzIHN1Y2Nl
ZWQgaWYgdGhlIGZpbGUgaXMgbm90IG9wZW5lZCB3aXRoIE9fRElSRUNULCBvciBpZiANCmlu
c3RlYWQgb2YgdGhlIERNQSBidWZmZXIsIHJlZ3VsYXIgbWVtb3J5IGZyb20gdGhlIGFwcGxp
Y2F0aW9uIChvYnRhaW5lZCANCndpdGggbWFsbG9jKSBpcyB1c2VkIHRvIHdyaXRlIGludG8g
dGhlIGZpbGUgKGluIHRoaXMgY2FzZSBldmVuIHdpdGggDQpPX0RJUkVDVCBlbmFibGVkKS4N
Cg0KQ29uc2lkZXJpbmcgdGhlIGRpZmZlcmVuY2UgaW4gaG93IHRoZSBwYWdlIHRhYmxlcyBh
cmUgc2V0IHVwIGZvciByZWd1bGFyIA0KYXBwbGljYXRpb24gbWVtb3J5ICh3aGljaCBzdXBw
b3J0cyBPX0RJUkVDVCkgdmVyc3VzIG15IERNQSBidWZmZXIgKHdoaWNoIA0KZG9lc24ndCB3
b3JrIHdpdGggT19ESVJFQ1QpLCBpdCBzZWVtcyB0byBtZSB0aGF0IEknbSBtaXNzaW5nIHNv
bWV0aGluZy4gDQpJIGhhdmUgdHJpZWQgYm90aCB3aXRoIHRoZSAibm8tbWFwIiBhdHRyaWJ1
dGUgaW4gdGhlIHJlc2VydmVkLW1lbW9yeSANCmVudHJ5IHRoYXQgZGVmaW5lcyB0aGUgRE1B
IGJ1ZmZlciBhbmQgd2l0aG91dCBpdC4NCg0KQXMgcmVwb3J0ZWQgYnkgb3RoZXIgdXNlcnMs
IGl0IHNlZW1zIHRoYXQgdGhpcyBhbHNvIGZhaWxzIGlmIHRoZSBETUEgDQpidWZmZXIgaXMg
YWxsb2NhdGVkIHdpdGggZG1hbV9hbGxvY19jb2hlcmVudCgpOg0KDQpodHRwczovL3N1cHBv
cnQueGlsaW54LmNvbS9zL3F1ZXN0aW9uLzBENTRVMDAwMDVVOXhVaFNBSi9vZGlyZWN0LWFj
Y2Vzcy10by1tbWFwZWQtZG1hbWFsbG9jY29oZXJlbnQtcHJvYmxlbXM/bGFuZ3VhZ2U9ZW5f
VVMNCg0KaHR0cHM6Ly93d3cubGludXhxdWVzdGlvbnMub3JnL3F1ZXN0aW9ucy9saW51eC1z
b2Z0d2FyZS0yL2RpcmVjdC1pby1mYWlscy13aGVuLXdyaXR0aW5nLWZyb20tY21hLWFsbG9j
YXRlZC1idWZmZXItNDE3NTY5NjE0NS8NCg0KSSBoYXZlIHRyaWVkIHRvIHNlYXJjaCB3aGF0
IHJlcXVpcmVtZW50cyB0aGUgcGFnZSB0YWJsZXMgbmVlZCB0byBoYXZlIA0KZm9yIE9fRElS
RUNUIHRvIHdvcmssIGJ1dCBkaWRuJ3QgZm91bmQgYW55IGluZm9ybWF0aW9uLg0KDQpCZXN0
LA0KRGFuaWVsLg0KDQo=

--------------DOshSi0JvE3ETXvgbyiSeNku--

--------------VvzrMxCku2hTwUdJdt1AhWZ1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOn0gFAd3OQG8ow6EtFwrk3lBwykFAmajwMEACgkQtFwrk3lB
wynUWRAAj5I3tGVUlLNtlLq+FG1WKTtQlLOfB8iN6aSSM8FtukP1eYnzgNUFXRrV
IYCkiFLaqcVjNGfLG9bt9WT6vdvcpjWwbC3p08T+eBdKV2qKK37Cicq0WkVFjTVj
coP/TPe9IIVu/++6hXvSSRJKs6vLk3JJFFjWFlvlBRSeb58dADkO1VaOYcvOEi0y
RNS8IKX3L3cWIYRMuOF56CYZk+xmOsQ/6ooI3mwfMF3Q+L0j18tAKQXVBp0Uaff0
2igGnL7QjoF1B46nGcef0oNx98vBK1/SdSH63q5reQvWfSNSjdrWvvZiYbaNHa43
j9FxZZX9cfb6fqQt7XPo5LNjUiZBkYCO5C50OUY3NQao/RvUmBRvJgcOtJ363dOj
PxaTmUMUmRnrH9b8kD0/o6PUS31Yc7Moh9+jEWX9fLjbmG/iLBaGPW0vhg5tOwn4
6V8ZV9AGLILw40g0kj1zs7lRWJDSJW/DKuEH8hDUoNsAb9GuRms1URq7SjJ5wNdg
zYe1v0JWVs053/sXx50AJZJGXH/j1nfpAucdQkteffeWcip19o42MC9xaKnO4Fde
0Hzrr3mV3x+sqrrabwELqck0Y7alZERN2lT5xFkMH9/YcSu4aU7CYXWXs9dcBRex
6QpqGVPWhVgavwEIPqfZ6mxumIWxcVFvQ+07a1DVXujPZ+avJJQ=
=4mzm
-----END PGP SIGNATURE-----

--------------VvzrMxCku2hTwUdJdt1AhWZ1--

