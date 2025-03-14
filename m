Return-Path: <linux-kernel+bounces-560849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74954A60A22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BB518921C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BD170A13;
	Fri, 14 Mar 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DUXfFt9D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DUXfFt9D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6C1624D5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937840; cv=none; b=cL98t7R6IQm956eJ/u+TxzZM6DRGKKGz0kCGH40lWnmvnz8zmpWCoVwRNa9KEjP0wnWgAs7zuhkKb0Xh2rgGkJpOr54odSzlwp6v2maaDyoK7K7RspOFiUvoueGPi+s4bpe5Afq8DksRN5FXxtIwbhplTNoltCAZt514ekIkNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937840; c=relaxed/simple;
	bh=hXkBLhyZ+7S/M+u3K9gNcbt6rvjkuFZDgvEIA7UGOb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUBc3FhnkJDaRISAF3IDyN2e1fglKAUdkR0ku/rhoRoFD+uP1SsK8hjjfvi6+JkozEqXbMo7iH2fNvtHqBiYEKZieCwDUaK2IKQxcr9/hlRtz+g9UD0d/yhIoc3gt/xFsXwYALaClIB+wQTazUgXz2E4ynmB+UMJtzgyo1wDmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DUXfFt9D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DUXfFt9D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8C5A21182;
	Fri, 14 Mar 2025 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741937833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXkBLhyZ+7S/M+u3K9gNcbt6rvjkuFZDgvEIA7UGOb0=;
	b=DUXfFt9DmKkFocpIOSHJ0b9tps3QeyA2InIUo1XoVM4oHe94pLulcT9DP7AunUW2Kvhn20
	h926Hvpwd1q9ywQ57vkkXyp4Hc7WwL9FRT4GLRjHson6/ahMbnlC80BXYNec+Gl6WIz2Oo
	izOziv872BEYH6eTkz+cvqO6ECyq4VE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741937833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hXkBLhyZ+7S/M+u3K9gNcbt6rvjkuFZDgvEIA7UGOb0=;
	b=DUXfFt9DmKkFocpIOSHJ0b9tps3QeyA2InIUo1XoVM4oHe94pLulcT9DP7AunUW2Kvhn20
	h926Hvpwd1q9ywQ57vkkXyp4Hc7WwL9FRT4GLRjHson6/ahMbnlC80BXYNec+Gl6WIz2Oo
	izOziv872BEYH6eTkz+cvqO6ECyq4VE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7038513A31;
	Fri, 14 Mar 2025 07:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DMd9Ganc02eCLAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 14 Mar 2025 07:37:13 +0000
Message-ID: <52e749ea-ce44-4032-a5a2-3f0b6f7909e3@suse.com>
Date: Fri, 14 Mar 2025 08:37:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] x86/xen: Move Xen upcall handler
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-2-brgerst@gmail.com>
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
In-Reply-To: <20250313182236.655724-2-brgerst@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rO30BUJRF5kVJuinXdO6FoAk"
X-Spam-Score: -5.05
X-Spamd-Result: default: False [-5.05 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-0.85)[-0.847];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rO30BUJRF5kVJuinXdO6FoAk
Content-Type: multipart/mixed; boundary="------------geAzy5m2gkt2SbBLMLpbNCHf";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <52e749ea-ce44-4032-a5a2-3f0b6f7909e3@suse.com>
Subject: Re: [PATCH 1/5] x86/xen: Move Xen upcall handler
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-2-brgerst@gmail.com>
In-Reply-To: <20250313182236.655724-2-brgerst@gmail.com>

--------------geAzy5m2gkt2SbBLMLpbNCHf
Content-Type: multipart/mixed; boundary="------------dWaBlnyp0jUflV8kpL4pKLQh"

--------------dWaBlnyp0jUflV8kpL4pKLQh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDMuMjUgMTk6MjIsIEJyaWFuIEdlcnN0IHdyb3RlOg0KPiBNb3ZlIHRoZSB1cGNh
bGwgaGFuZGxlciB0byBYZW4tc3BlY2lmaWMgZmlsZXMuDQo+IA0KPiBObyBmdW5jdGlvbmFs
IGNoYW5nZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcmlhbiBHZXJzdCA8YnJnZXJzdEBn
bWFpbC5jb20+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IENj
OiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0KPiAtLS0N
Cj4gICBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYyAgICAgfCA3MiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5j
IHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS94ZW4veGVuLW9w
cy5oICAgICAgIHwgMTkgKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNjUgaW5z
ZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvZW50cnkvY29tbW9uLmMgYi9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYw0KPiBpbmRleCAz
NTE0YmYyOTc4ZWUuLmNlNGQ4OGVkYTY5MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvZW50
cnkvY29tbW9uLmMNCj4gKysrIGIvYXJjaC94ODYvZW50cnkvY29tbW9uLmMNCj4gQEAgLTIx
LDExICsyMSw2IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvaW5pdC5oPg0KPiAgIA0KPiAtI2lmZGVmIENPTkZJR19YRU5fUFYNCj4g
LSNpbmNsdWRlIDx4ZW4veGVuLW9wcy5oPg0KPiAtI2luY2x1ZGUgPHhlbi9ldmVudHMuaD4N
Cj4gLSNlbmRpZg0KPiAtDQo+ICAgI2luY2x1ZGUgPGFzbS9hcGljLmg+DQo+ICAgI2luY2x1
ZGUgPGFzbS9kZXNjLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS90cmFwcy5oPg0KPiBAQCAtNDU1
LDcwICs0NTAsMyBAQCBTWVNDQUxMX0RFRklORTAobmlfc3lzY2FsbCkNCj4gICB7DQo+ICAg
CXJldHVybiAtRU5PU1lTOw0KPiAgIH0NCj4gLQ0KPiAtI2lmZGVmIENPTkZJR19YRU5fUFYN
Cj4gLSNpZm5kZWYgQ09ORklHX1BSRUVNUFRJT04NCj4gLS8qDQo+IC0gKiBTb21lIGh5cGVy
Y2FsbHMgaXNzdWVkIGJ5IHRoZSB0b29sc3RhY2sgY2FuIHRha2UgbWFueSAxMHMgb2YNCj4g
LSAqIHNlY29uZHMuIEFsbG93IHRhc2tzIHJ1bm5pbmcgaHlwZXJjYWxscyB2aWEgdGhlIHBy
aXZjbWQgZHJpdmVyIHRvDQo+IC0gKiBiZSB2b2x1bnRhcmlseSBwcmVlbXB0ZWQgZXZlbiBp
ZiBmdWxsIGtlcm5lbCBwcmVlbXB0aW9uIGlzDQo+IC0gKiBkaXNhYmxlZC4NCj4gLSAqDQo+
IC0gKiBTdWNoIHByZWVtcHRpYmxlIGh5cGVyY2FsbHMgYXJlIGJyYWNrZXRlZCBieQ0KPiAt
ICogeGVuX3ByZWVtcHRpYmxlX2hjYWxsX2JlZ2luKCkgYW5kIHhlbl9wcmVlbXB0aWJsZV9o
Y2FsbF9lbmQoKQ0KPiAtICogY2FsbHMuDQo+IC0gKi8NCj4gLURFRklORV9QRVJfQ1BVKGJv
b2wsIHhlbl9pbl9wcmVlbXB0aWJsZV9oY2FsbCk7DQo+IC1FWFBPUlRfU1lNQk9MX0dQTCh4
ZW5faW5fcHJlZW1wdGlibGVfaGNhbGwpOw0KPiAtDQo+IC0vKg0KPiAtICogSW4gY2FzZSBv
ZiBzY2hlZHVsaW5nIHRoZSBmbGFnIG11c3QgYmUgY2xlYXJlZCBhbmQgcmVzdG9yZWQgYWZ0
ZXINCj4gLSAqIHJldHVybmluZyBmcm9tIHNjaGVkdWxlIGFzIHRoZSB0YXNrIG1pZ2h0IG1v
dmUgdG8gYSBkaWZmZXJlbnQgQ1BVLg0KPiAtICovDQo+IC1zdGF0aWMgX19hbHdheXNfaW5s
aW5lIGJvb2wgZ2V0X2FuZF9jbGVhcl9pbmhjYWxsKHZvaWQpDQo+IC17DQo+IC0JYm9vbCBp
bmhjYWxsID0gX190aGlzX2NwdV9yZWFkKHhlbl9pbl9wcmVlbXB0aWJsZV9oY2FsbCk7DQo+
IC0NCj4gLQlfX3RoaXNfY3B1X3dyaXRlKHhlbl9pbl9wcmVlbXB0aWJsZV9oY2FsbCwgZmFs
c2UpOw0KPiAtCXJldHVybiBpbmhjYWxsOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgX19hbHdh
eXNfaW5saW5lIHZvaWQgcmVzdG9yZV9pbmhjYWxsKGJvb2wgaW5oY2FsbCkNCj4gLXsNCj4g
LQlfX3RoaXNfY3B1X3dyaXRlKHhlbl9pbl9wcmVlbXB0aWJsZV9oY2FsbCwgaW5oY2FsbCk7
DQo+IC19DQo+IC0jZWxzZQ0KPiAtc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGdldF9h
bmRfY2xlYXJfaW5oY2FsbCh2b2lkKSB7IHJldHVybiBmYWxzZTsgfQ0KPiAtc3RhdGljIF9f
YWx3YXlzX2lubGluZSB2b2lkIHJlc3RvcmVfaW5oY2FsbChib29sIGluaGNhbGwpIHsgfQ0K
PiAtI2VuZGlmDQo+IC0NCj4gLXN0YXRpYyB2b2lkIF9feGVuX3B2X2V2dGNobl9kb191cGNh
bGwoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+IC17DQo+IC0Jc3RydWN0IHB0X3JlZ3MgKm9s
ZF9yZWdzID0gc2V0X2lycV9yZWdzKHJlZ3MpOw0KPiAtDQo+IC0JaW5jX2lycV9zdGF0KGly
cV9odl9jYWxsYmFja19jb3VudCk7DQo+IC0NCj4gLQl4ZW5fZXZ0Y2huX2RvX3VwY2FsbCgp
Ow0KPiAtDQo+IC0Jc2V0X2lycV9yZWdzKG9sZF9yZWdzKTsNCj4gLX0NCj4gLQ0KPiAtX192
aXNpYmxlIG5vaW5zdHIgdm9pZCB4ZW5fcHZfZXZ0Y2huX2RvX3VwY2FsbChzdHJ1Y3QgcHRf
cmVncyAqcmVncykNCj4gLXsNCj4gLQlpcnFlbnRyeV9zdGF0ZV90IHN0YXRlID0gaXJxZW50
cnlfZW50ZXIocmVncyk7DQo+IC0JYm9vbCBpbmhjYWxsOw0KPiAtDQo+IC0JaW5zdHJ1bWVu
dGF0aW9uX2JlZ2luKCk7DQo+IC0JcnVuX3N5c3ZlY19vbl9pcnFzdGFja19jb25kKF9feGVu
X3B2X2V2dGNobl9kb191cGNhbGwsIHJlZ3MpOw0KPiAtDQo+IC0JaW5oY2FsbCA9IGdldF9h
bmRfY2xlYXJfaW5oY2FsbCgpOw0KPiAtCWlmIChpbmhjYWxsICYmICFXQVJOX09OX09OQ0Uo
c3RhdGUuZXhpdF9yY3UpKSB7DQo+IC0JCWlycWVudHJ5X2V4aXRfY29uZF9yZXNjaGVkKCk7
DQo+IC0JCWluc3RydW1lbnRhdGlvbl9lbmQoKTsNCj4gLQkJcmVzdG9yZV9pbmhjYWxsKGlu
aGNhbGwpOw0KPiAtCX0gZWxzZSB7DQo+IC0JCWluc3RydW1lbnRhdGlvbl9lbmQoKTsNCj4g
LQkJaXJxZW50cnlfZXhpdChyZWdzLCBzdGF0ZSk7DQo+IC0JfQ0KPiAtfQ0KPiAtI2VuZGlm
IC8qIENPTkZJR19YRU5fUFYgKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9lbmxp
Z2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYw0KPiBpbmRleCA1ZTU3
ODM1ZTk5OWQuLmFmOWU0M2M0N2IwNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9wdi5jDQo+ICsrKyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYw0KPiBA
QCAtNzMsNiArNzMsNyBAQA0KPiAgICNpbmNsdWRlIDxhc20vbXdhaXQuaD4NCj4gICAjaW5j
bHVkZSA8YXNtL3BjaV94ODYuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2NwdS5oPg0KPiArI2lu
Y2x1ZGUgPGFzbS9pcnFfc3RhY2suaD4NCj4gICAjaWZkZWYgQ09ORklHX1g4Nl9JT1BMX0lP
UEVSTQ0KPiAgICNpbmNsdWRlIDxhc20vaW9fYml0bWFwLmg+DQo+ICAgI2VuZGlmDQo+IEBA
IC05NCw2ICs5NSwyMSBAQCB2b2lkICp4ZW5faW5pdGlhbF9nZHQ7DQo+ICAgc3RhdGljIGlu
dCB4ZW5fY3B1X3VwX3ByZXBhcmVfcHYodW5zaWduZWQgaW50IGNwdSk7DQo+ICAgc3RhdGlj
IGludCB4ZW5fY3B1X2RlYWRfcHYodW5zaWduZWQgaW50IGNwdSk7DQo+ICAgDQo+ICsjaWZu
ZGVmIENPTkZJR19QUkVFTVBUSU9ODQo+ICsvKg0KPiArICogU29tZSBoeXBlcmNhbGxzIGlz
c3VlZCBieSB0aGUgdG9vbHN0YWNrIGNhbiB0YWtlIG1hbnkgMTBzIG9mDQo+ICsgKiBzZWNv
bmRzLiBBbGxvdyB0YXNrcyBydW5uaW5nIGh5cGVyY2FsbHMgdmlhIHRoZSBwcml2Y21kIGRy
aXZlciB0bw0KPiArICogYmUgdm9sdW50YXJpbHkgcHJlZW1wdGVkIGV2ZW4gaWYgZnVsbCBr
ZXJuZWwgcHJlZW1wdGlvbiBpcw0KPiArICogZGlzYWJsZWQuDQo+ICsgKg0KPiArICogU3Vj
aCBwcmVlbXB0aWJsZSBoeXBlcmNhbGxzIGFyZSBicmFja2V0ZWQgYnkNCj4gKyAqIHhlbl9w
cmVlbXB0aWJsZV9oY2FsbF9iZWdpbigpIGFuZCB4ZW5fcHJlZW1wdGlibGVfaGNhbGxfZW5k
KCkNCj4gKyAqIGNhbGxzLg0KPiArICovDQo+ICtERUZJTkVfUEVSX0NQVShib29sLCB4ZW5f
aW5fcHJlZW1wdGlibGVfaGNhbGwpOw0KPiArRVhQT1JUX1NZTUJPTF9HUEwoeGVuX2luX3By
ZWVtcHRpYmxlX2hjYWxsKTsNCj4gKyNlbmRpZg0KPiArDQo+ICAgc3RydWN0IHRsc19kZXNj
cyB7DQo+ICAgCXN0cnVjdCBkZXNjX3N0cnVjdCBkZXNjWzNdOw0KPiAgIH07DQo+IEBAIC02
ODcsNiArNzAzLDM2IEBAIERFRklORV9JRFRFTlRSWV9SQVcoeGVucHZfZXhjX21hY2hpbmVf
Y2hlY2spDQo+ICAgfQ0KPiAgICNlbmRpZg0KPiAgIA0KPiArc3RhdGljIHZvaWQgX194ZW5f
cHZfZXZ0Y2huX2RvX3VwY2FsbChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gK3sNCj4gKwlz
dHJ1Y3QgcHRfcmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3JlZ3MocmVncyk7DQo+ICsNCj4g
KwlpbmNfaXJxX3N0YXQoaXJxX2h2X2NhbGxiYWNrX2NvdW50KTsNCj4gKw0KPiArCXhlbl9l
dnRjaG5fZG9fdXBjYWxsKCk7DQo+ICsNCj4gKwlzZXRfaXJxX3JlZ3Mob2xkX3JlZ3MpOw0K
PiArfQ0KPiArDQo+ICtfX3Zpc2libGUgbm9pbnN0ciB2b2lkIHhlbl9wdl9ldnRjaG5fZG9f
dXBjYWxsKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiArew0KPiArCWlycWVudHJ5X3N0YXRl
X3Qgc3RhdGUgPSBpcnFlbnRyeV9lbnRlcihyZWdzKTsNCj4gKwlib29sIGluaGNhbGw7DQo+
ICsNCj4gKwlpbnN0cnVtZW50YXRpb25fYmVnaW4oKTsNCj4gKwlydW5fc3lzdmVjX29uX2ly
cXN0YWNrX2NvbmQoX194ZW5fcHZfZXZ0Y2huX2RvX3VwY2FsbCwgcmVncyk7DQo+ICsNCj4g
KwlpbmhjYWxsID0gZ2V0X2FuZF9jbGVhcl9pbmhjYWxsKCk7DQo+ICsJaWYgKGluaGNhbGwg
JiYgIVdBUk5fT05fT05DRShzdGF0ZS5leGl0X3JjdSkpIHsNCj4gKwkJaXJxZW50cnlfZXhp
dF9jb25kX3Jlc2NoZWQoKTsNCj4gKwkJaW5zdHJ1bWVudGF0aW9uX2VuZCgpOw0KPiArCQly
ZXN0b3JlX2luaGNhbGwoaW5oY2FsbCk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJaW5zdHJ1bWVu
dGF0aW9uX2VuZCgpOw0KPiArCQlpcnFlbnRyeV9leGl0KHJlZ3MsIHN0YXRlKTsNCj4gKwl9
DQo+ICt9DQo+ICsNCj4gICBzdHJ1Y3QgdHJhcF9hcnJheV9lbnRyeSB7DQo+ICAgCXZvaWQg
KCpvcmlnKSh2b2lkKTsNCj4gICAJdm9pZCAoKnhlbikodm9pZCk7DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3hlbi94ZW4tb3BzLmggYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gaW5k
ZXggNDdmMTFiZWM1ZTkwLi4xNzRlZjhlNDYwMGYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
eGVuL3hlbi1vcHMuaA0KPiArKysgYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gQEAgLTIw
OCwxMCArMjA4LDI5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fcHJlZW1wdGlibGVfaGNh
bGxfZW5kKHZvaWQpDQo+ICAgCV9fdGhpc19jcHVfd3JpdGUoeGVuX2luX3ByZWVtcHRpYmxl
X2hjYWxsLCBmYWxzZSk7DQo+ICAgfQ0KPiAgIA0KPiArLyoNCj4gKyAqIEluIGNhc2Ugb2Yg
c2NoZWR1bGluZyB0aGUgZmxhZyBtdXN0IGJlIGNsZWFyZWQgYW5kIHJlc3RvcmVkIGFmdGVy
DQo+ICsgKiByZXR1cm5pbmcgZnJvbSBzY2hlZHVsZSBhcyB0aGUgdGFzayBtaWdodCBtb3Zl
IHRvIGEgZGlmZmVyZW50IENQVS4NCj4gKyAqLw0KPiArc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSBib29sIGdldF9hbmRfY2xlYXJfaW5oY2FsbCh2b2lkKQ0KPiArew0KPiArCWJvb2wgaW5o
Y2FsbCA9IF9fdGhpc19jcHVfcmVhZCh4ZW5faW5fcHJlZW1wdGlibGVfaGNhbGwpOw0KPiAr
DQo+ICsJX190aGlzX2NwdV93cml0ZSh4ZW5faW5fcHJlZW1wdGlibGVfaGNhbGwsIGZhbHNl
KTsNCj4gKwlyZXR1cm4gaW5oY2FsbDsNCj4gK30NCj4gKw0KPiArc3RhdGljIF9fYWx3YXlz
X2lubGluZSB2b2lkIHJlc3RvcmVfaW5oY2FsbChib29sIGluaGNhbGwpDQo+ICt7DQo+ICsJ
X190aGlzX2NwdV93cml0ZSh4ZW5faW5fcHJlZW1wdGlibGVfaGNhbGwsIGluaGNhbGwpOw0K
PiArfQ0KPiArDQo+ICAgI2Vsc2UNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHZvaWQgeGVu
X3ByZWVtcHRpYmxlX2hjYWxsX2JlZ2luKHZvaWQpIHsgfQ0KPiAgIHN0YXRpYyBpbmxpbmUg
dm9pZCB4ZW5fcHJlZW1wdGlibGVfaGNhbGxfZW5kKHZvaWQpIHsgfQ0KPiArc3RhdGljIF9f
YWx3YXlzX2lubGluZSBib29sIGdldF9hbmRfY2xlYXJfaW5oY2FsbCh2b2lkKSB7IHJldHVy
biBmYWxzZTsgfQ0KPiArc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHJlc3RvcmVfaW5o
Y2FsbChib29sIGluaGNhbGwpIHsgfQ0KPiAgIA0KPiAgICNlbmRpZiAvKiBDT05GSUdfWEVO
X1BWICYmICFDT05GSUdfUFJFRU1QVElPTiAqLw0KPiAgIA0KDQpJIGRvbid0IHNlZSBhIHJl
YXNvbiB0byBwdXQgdGhvc2UgdHdvIGZ1bmN0aW9ucyBpbnRvIHhlbl9vcHMuaCwgYXMNCnRo
ZXkgYXJlIHVzZWQgYnkgeGVuX3B2X2V2dGNobl9kb191cGNhbGwoKSBvbmx5Lg0KDQpQbGVh
c2UgbW92ZSB0aGVtIHRvIGVubGlnaHRlbl9wdi5jLCB0b28uDQoNCg0KSnVlcmdlbg0K
--------------dWaBlnyp0jUflV8kpL4pKLQh
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------dWaBlnyp0jUflV8kpL4pKLQh--

--------------geAzy5m2gkt2SbBLMLpbNCHf--

--------------rO30BUJRF5kVJuinXdO6FoAk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmfT3KgFAwAAAAAACgkQsN6d1ii/Ey/T
dQgAhT2LkOObGEsUltUHsEAho/7mAflPIEJ2/uFbNgh5ZdV1aqPoHPvgex2WhcRQPQ9PkbtR3zEU
aHRK/0wuY3F/TRoYTynWPwmhR70zfS+UEK169CVvyA28pMhbWpCucBEqD8J8MWxwY31xabU7LbhN
GKTocIp7osj/NmYzGBI2kataUUCF9ue2Swa3J2EvU17S31MUWN/5KirsVCX7ovek9nOuAShqjFk9
hv/CWHknQLwaQ2F7Y7JpNfxCMZtsEgOFaEcuQtZuuiF/AbM16I6ScXSehLoFCjlODrCZorhENMvf
h2OF1H900zSEjzvrqE8lACU3yPCHe/VViRrCly61cw==
=EUNy
-----END PGP SIGNATURE-----

--------------rO30BUJRF5kVJuinXdO6FoAk--

