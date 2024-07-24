Return-Path: <linux-kernel+bounces-261043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5F93B21E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B5E1C21227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C01591FC;
	Wed, 24 Jul 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b5Pb6/4e";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b5Pb6/4e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D491591E0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829344; cv=none; b=OrIVzCOfl0CxD8TBAlDcO1K0BWLZ6G8U2J1TB4po/c4Cy8aSg5xN0SN2+2obm9GTJp8GrCZen/fBh0E50PLRdv9FFSVHawE3KYEPIFdft7mCS5Dq43MvG9fISdhZX3rdMOO1l7uQlhOKgSypw1Cm2yg9tpmkBboVfDn5HXO0qOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829344; c=relaxed/simple;
	bh=3UsTrBlaqrMtkCkWg5kiykNCwV0IwEcIm9jCRf1IFTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dDUasLeb5SeGBlJW48BJahl1ck4cpX5c+880w2CVp1ia1dXc2nyYvPknmVLxp5t2XYNyfxR8K8QyROM3PT2su0GouXQMZoVJ0F661Hvtufea2emyfa/B0Gk4tLOXS5WwwZR4HzHtcw3Q9zhtQt7plCb29laF1k4UQxKxHZP2G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b5Pb6/4e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b5Pb6/4e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3A9B1F897;
	Wed, 24 Jul 2024 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721829340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3UsTrBlaqrMtkCkWg5kiykNCwV0IwEcIm9jCRf1IFTU=;
	b=b5Pb6/4e7eX26auyG8+SkJ2f9CpUnMaaF18nRZ/0RUDaQ2j4jRTpqjv7aCMF8txr9t/34W
	8xxrHsyyfPFLwLvc5LiAyaCA1uJScUfFi4IXNMx6YMqsiH+4ha3KnlBxUuBOfe/LDcuem8
	WxLYBFK71/8mCRMMdX9qPgOq81FidQ8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721829340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3UsTrBlaqrMtkCkWg5kiykNCwV0IwEcIm9jCRf1IFTU=;
	b=b5Pb6/4e7eX26auyG8+SkJ2f9CpUnMaaF18nRZ/0RUDaQ2j4jRTpqjv7aCMF8txr9t/34W
	8xxrHsyyfPFLwLvc5LiAyaCA1uJScUfFi4IXNMx6YMqsiH+4ha3KnlBxUuBOfe/LDcuem8
	WxLYBFK71/8mCRMMdX9qPgOq81FidQ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA27313411;
	Wed, 24 Jul 2024 13:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jdb0K9wHoWZ9HQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 24 Jul 2024 13:55:40 +0000
Message-ID: <bf1f5bfa-446c-4aea-a092-8cd9e7a786c3@suse.com>
Date: Wed, 24 Jul 2024 15:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
To: James Dingwall <james@dingwall.me.uk>, linux-kernel@vger.kernel.org
References: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bauopM6jtGEfYvh3FxPySgi2"
X-Spamd-Result: default: False [-4.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.99

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bauopM6jtGEfYvh3FxPySgi2
Content-Type: multipart/mixed; boundary="------------LAwvihxXgrKmNvdl2DPdO3e8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: James Dingwall <james@dingwall.me.uk>, linux-kernel@vger.kernel.org
Message-ID: <bf1f5bfa-446c-4aea-a092-8cd9e7a786c3@suse.com>
Subject: Re: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
References: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>
In-Reply-To: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>

--------------LAwvihxXgrKmNvdl2DPdO3e8
Content-Type: multipart/mixed; boundary="------------rf40hYMKTC00x8fnl1mLWg3u"

--------------rf40hYMKTC00x8fnl1mLWg3u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDcuMjQgMTU6MjUsIEphbWVzIERpbmd3YWxsIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IEkgaGF2ZSBidWlsdCBhIGtlcm5lbCBkZXJpdmVkIGZyb20gVWJ1bnR1J3MgVWJ1bnR1LWh3
ZS02LjgtNi44LjAtNDAuNDBfMjIuMDQuMQ0KPiB0YWcuICBUaGUgbG9ncyBhcmUgcXVpZXQg
dW50aWwgSSBzdGFydCB0aGUgZmlyc3QgZ3Vlc3Qgd2hpY2ggaGFzIHR3byBuZXR3b3JrDQo+
IGNhcmRzIHBhc3NlZCB0aHJvdWdoLiAgQXQgdGhpcyBwb2ludCB0aGUga2VybmVsIGxvZyBn
ZXRzIGZsb29kZWQgd2l0aCB0aGUNCj4gd2FybmluZyBiZWxvdy4gIFRoaXMgYXBwZWFycyB0
byB0aGUgc2FtZSB3YXJuaW5nIHdoaWNoIHRoaXMgY29tbWl0IHdhcw0KPiBzdXBwb3NlZCB0
byBzdXBwcmVzczoNCj4gDQo+IDUxYzIzYmQ2OTFjMGYxZmI5NWIyOTczMWMzNTZjNmZkNjk5
MjVkMTc6IHhlbi9ldnRjaG46IGF2b2lkIFdBUk4oKSB3aGVuIHVuYmluZGluZyBhbiBldmVu
dCBjaGFubmVsDQo+IA0KPiBUaGUgdGFnIGFscmVhZHkgaW5jbHVkZXMgdGhhdCBjb21taXQg
YW5kIGluIG15IGNvbmZpZzoNCj4gDQo+ICQgZ3JlcCBDT05GSUdfREVCVUdfU0hJUlEgL2Jv
b3QvY29uZmlnLTYuOC4wLTQwLWdlbmVyaWMNCj4gIyBDT05GSUdfREVCVUdfU0hJUlEgaXMg
bm90IHNldA0KPiANCj4gQ291bGQgdGhlcmUgYmUgYSByZWxhdGVkIGNoYW5nZSB3aGljaCBh
bHNvIG5lZWRzIHRvIGJlIHBpY2tlZCBvciBpcyB0aGVyZQ0KPiB0aGUgcG9zc2liaWxpdHkg
dGhhdCB0aGVyZSBpcyBhbm90aGVyIHRyaWdnZXI/DQoNCkFzIHRoZSBvcmlnaW5hbCByZXBv
cnRlciBvZiB0aGUgaXNzdWUgdGVzdGVkIHRoZSBwYXRjaCB0byBmaXggaXQsDQp0aGVyZSBz
ZWVtcyB0byBiZSBhbm90aGVyIHRyaWdnZXIuIDotKA0KDQoNCkp1ZXJnZW4NCg==
--------------rf40hYMKTC00x8fnl1mLWg3u
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------rf40hYMKTC00x8fnl1mLWg3u--

--------------LAwvihxXgrKmNvdl2DPdO3e8--

--------------bauopM6jtGEfYvh3FxPySgi2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmahB9wFAwAAAAAACgkQsN6d1ii/Ey/u
1Af7B/gLBwvTWcp6rv2AiIDoae4nHKzLBFMdBACv0qoTIih/mzHm2bGbEKShRoVwZDDAdtODJwH3
1qRAlzrG/3/rUl4Kg7uTMPSqtMB3cts2jQUC6yLHsD1tidq61wxL4LHN1t90Qp4wJeRIFg8CkV+b
duoqwDag7HsAYbWBKop8jx4T7LKFqODHQ4Q0dJvTNiivZw4NV6k8FTENY0JeQjw7yQoyrK+8q3Ml
Lgd9mmxBPnTo009iZrWWrv4ulFsZVwx/1Eb+eGoyX8QMxgHeYWOnlDiAMiEGNu2/MElTGPL9ae7e
y6Lo/6gFq50N5wRk7HSrWIGZccSMQzg8HZf2QE+mtg==
=nwJF
-----END PGP SIGNATURE-----

--------------bauopM6jtGEfYvh3FxPySgi2--

