Return-Path: <linux-kernel+bounces-554606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EEA59A67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53CA1888B12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7061B3934;
	Mon, 10 Mar 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TgZsDBM/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TgZsDBM/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BC22069E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621962; cv=none; b=VTyitfk8qlHI4om04VWTdjd8aFbndPasVqQXoxf0Q/+uMz7vOAu4IDvnqtTLdt/J9CW3ZMY0imFAYF9HKFrcPZ691FIhwBr8lByTkO9OvcHXFF3v1ZSboLY9DFWWykOKCATurirNRQpv6BOtzmH/JSRJgIepbTs88w/ERfX7XrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621962; c=relaxed/simple;
	bh=nuOzUJHmrayjdRkqI/aeYPgmFhj+PrHLtuY5XOQYU8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1fnW8rsA6IsrOhtMGGNE35ktRyi2rGlA9myivbExsxq36uIEXdWcuyGwOFOxSHRKGIk2jNFBLgLfRGaGaga7Ebp7KjQOSFVGCvRyCHRdcRz9Oo0L6rJHa36lXDR+3hXxLTcGaISr3Wvo7ZYlMETzoRypL4Gr9yJPJG5HT3p8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TgZsDBM/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TgZsDBM/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1BF71F38C;
	Mon, 10 Mar 2025 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741621958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nuOzUJHmrayjdRkqI/aeYPgmFhj+PrHLtuY5XOQYU8E=;
	b=TgZsDBM/ds7wdVLKMMRQM3bWykr8DWmHlOgrUuNDT3KUCpN7zQNqwZOfBJWuL00T2VN6Gb
	TsRUqGxA/vgFkyOqQ2mUL4N5qjyf1CneGLwt4rcbBGGKCLFolAdF8/crl5C/pd3oW0ND9e
	U9kqoKOy4WxJYKaJCOlx8IHXt+n8hPo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="TgZsDBM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741621958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nuOzUJHmrayjdRkqI/aeYPgmFhj+PrHLtuY5XOQYU8E=;
	b=TgZsDBM/ds7wdVLKMMRQM3bWykr8DWmHlOgrUuNDT3KUCpN7zQNqwZOfBJWuL00T2VN6Gb
	TsRUqGxA/vgFkyOqQ2mUL4N5qjyf1CneGLwt4rcbBGGKCLFolAdF8/crl5C/pd3oW0ND9e
	U9kqoKOy4WxJYKaJCOlx8IHXt+n8hPo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 389CA1399F;
	Mon, 10 Mar 2025 15:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FuFEDMYKz2d2UwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Mar 2025 15:52:38 +0000
Message-ID: <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
Date: Mon, 10 Mar 2025 16:52:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Alexey Gladkov <legion@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
References: <Z8l66FFgPu5hWtuI@agladkov-desk> <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
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
In-Reply-To: <Z88Iv0w8_l9i7_8l@example.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9eQRAVqdPx9muAhB03Ll3hD2"
X-Rspamd-Queue-Id: D1BF71F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-6.41 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.41
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9eQRAVqdPx9muAhB03Ll3hD2
Content-Type: multipart/mixed; boundary="------------3Iquj44MbsqI7m83LX4LrI2W";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
 "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 linux-kernel@vger.kernel.org, Larry.Dewey@amd.com
Message-ID: <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
References: <Z8l66FFgPu5hWtuI@agladkov-desk> <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com> <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
In-Reply-To: <Z88Iv0w8_l9i7_8l@example.org>

--------------3Iquj44MbsqI7m83LX4LrI2W
Content-Type: multipart/mixed; boundary="------------50EWag0WLG50hkU7uhnaBvip"

--------------50EWag0WLG50hkU7uhnaBvip
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDMuMjUgMTY6NDMsIEFsZXhleSBHbGFka292IHdyb3RlOg0KPiBPbiBNb24sIE1h
ciAxMCwgMjAyNSBhdCAwNDozMzowOFBNICswMTAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
Pj4gT24gMTAuMDMuMjUgMTY6MTEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+PiBPbiBN
b24sIE1hciAxMCwgMjAyNSBhdCAwMzo1MDowOVBNICswMTAwLCBBbGV4ZXkgR2xhZGtvdiB3
cm90ZToNCj4+Pj4gQW0gSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHlvdSBhbmQgSm9l
cmcgYXJlIHByb3Bvc2luZw0KPj4+Pg0KPj4+PiAvc3lzL2d1ZXN0L3RkeC8uLi4NCj4+Pj4g
L3N5cy9ndWVzdC9zZXYvLi4uDQo+Pj4+DQo+Pj4+ID8NCj4+Pj4NCj4+Pj4gV2hpY2ggcGF0
aCB0byB1c2UgZm9yIHRoZSBob3N0IHNpZGUgPw0KPj4+Pg0KPj4+PiBGb3IgZ3Vlc3Q6IC9z
eXMvY29jby9ndWVzdC97dGR4LHNldn0vLi4uDQo+Pj4+IEZvciBob3N0OiAgL3N5cy9jb2Nv
L2hvc3Qve3RkeCxzZXZ9Ly4uLg0KPj4+Pg0KPj4+PiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gYWRkIHRoZSAiY29jbyIgc3ViZGlyZWN0b3J5IG9yIHNvbWV0aGluZyBsaWtlDQo+
Pj4+IHRoYXQgPw0KPj4+DQo+Pj4gSG1tLCBzbyB3ZSBjYW4gZG8NCj4+Pg0KPj4+IC9zeXMv
Z3Vlc3QNCj4+Pg0KPj4+IGFuZCBleHRlbmQNCj4+Pg0KPj4+IC9zeXMvaHlwZXJ2aXNvcg0K
Pj4+DQo+Pj4gT3Igd2UgY2FuIGRvIHdoYXQgeW91J3JlIHN1Z2dlc3RpbmcuDQo+Pj4NCj4+
PiBJZiB3ZSBkbyAvc3lzL2NvY28vaG9zdCwgdGhlbiB3ZSdsbCBoYXZlIHR3byBkaWZmZXJl
bnQgcGxhY2VzIHRvIHJlYWQgSFYgaW5mby4NCj4+Pg0KPj4+IE9yIHdlIGNhbiBzdGljayAq
ZXZlcnl0aGluZyogY29jbyBuZWVkcyBpbg0KPj4+DQo+Pj4gL3N5cy9jb2NvL3tzZXYsdGR4
fQ0KPj4+DQo+Pj4gYnV0IHRoZW4gaXQgaXMgY29jby1zcGVjaWZpYyBhbmQgaWYgb3RoZXIg
Z3Vlc3QgdHlwZXMgd2FudCB0byBwdXQgc3R1ZmYgaW4NCj4+PiBzeXNmcywgaXQnbGwgZ2V0
IHVnbHkuDQo+Pj4NCj4+PiBTbyBJIGd1ZXNzIGhhdmluZw0KPj4+DQo+Pj4gL3N5cy9ndWVz
dA0KPj4+IGFuZA0KPj4+IC9zeXMvaHlwZXJ2aXNvcg0KPj4+DQo+Pj4ga2luZGEga2VlcHMg
aXQgYWxsIGNsZWFuLCBoaWVyYXJjaHktd2lzZS4uLg0KPj4+DQo+Pj4gUmlnaHQ/DQo+Pg0K
Pj4gS2luZCBvZi4NCj4+DQo+PiAvc3lzL2h5cGVydmlzb3IgaXMgbWVhbnQgdG8gcHJvdmlk
ZSBkYXRhIGZvciBydW5uaW5nIHVuZGVyIGEgaHlwZXJ2aXNvci4NCj4+DQo+PiBJdCBpcyBO
T1QgbWVhbnQgdG8gcHJvdmlkZSBkYXRhIGZvciBydW5uaW5nIGFzIGEgaHlwZXJ2aXNvci4N
Cj4+DQo+PiBTbyBmYXIgd2hlbiBydW5uaW5nIGVpdGhlciB1bmRlciBYZW4gb3IgdW5kZXIg
ei9WTSAvc3lzL2h5cGVydmlzb3IgaXMgYmVpbmcNCj4+IHBvcHVsYXRlZC4NCj4+DQo+PiBJ
J20gbm90IGZlZWxpbmcgcmVhbGx5IHN0cm9uZyBoZXJlLiBJIGp1c3Qgd2FudCB0byBzdGF0
ZSB0aGUgc3RhdHVzIHF1by4NCj4gDQo+IE9LLCBzbyBJIG1pc3VuZGVyc3Rvb2QuDQo+IA0K
PiBJZiBpbiB0aGUgL3N5cy9oeXBlcnZpc29yIHdlIGhhdmUgaW5mb3JtYXRpb24gZm9yIGd1
ZXN0IChmb3IgcnVubmluZyB1bmRlcg0KPiBhIGh5cGVydmlzb3IpLCB3aGVyZSBkbyB5b3Ug
cHJvcG9zZSB0byBwdXQgdGhlIGluZm9ybWF0aW9uIGZvciB0aGUNCj4gaG9zdC1zaWRlIChm
b3IgcnVubmluZyBhcyBhIGh5cGVydmlzb3IpID8NCj4gDQoNCi9zeXMva3ZtLyBtaWdodCBi
ZSBhIGdvb2QgZml0IHdoZW4gdXNpbmcgS1ZNPw0KDQoNCkp1ZXJnZW4NCg==
--------------50EWag0WLG50hkU7uhnaBvip
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------50EWag0WLG50hkU7uhnaBvip--

--------------3Iquj44MbsqI7m83LX4LrI2W--

--------------9eQRAVqdPx9muAhB03Ll3hD2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfPCsUFAwAAAAAACgkQsN6d1ii/Ey/f
3wgAgtL4JU5Z87nhVNRSbw83YvLykLMFGRXtvSVRsdbGW/sVpjsSx2ZOj+V3AnfUxk6n4uqlHQ6H
nUjvwkQWbWBlnv5dHYHzTiA00cW7TcXxA02LJpSS2AAvGcdbeheO6ASn3RtrIQWEYoa3kZ1DsuMB
nqvs1L2OeErJ2r888dZ3fqcZM8Gk2ZsJXwoaVnNAQjD9HJka0t/gI3OF+nTird/4Iw9Aq+DWdjyt
WjLFPs8zYc660HWsLW5f0cW/saPNrK2mj0MIiw3idcy3T58L2jEJ+OJ9BbYTUBd9fb+iE18ZQ8EZ
Degxt1cPCe3UZkVdCVRLFzblx7OhSW1iIiI5xz0ykg==
=3kTr
-----END PGP SIGNATURE-----

--------------9eQRAVqdPx9muAhB03Ll3hD2--

