Return-Path: <linux-kernel+bounces-366253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE54A99F2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4081C21E14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566B43AB3;
	Tue, 15 Oct 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uot/kNtM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF01F6699
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009808; cv=none; b=FEbPaTIAcFz8PUAKmxvZh0St0Eg7GhxEYJ2Gie91r1h+R98lYgAkwtb3c6uHFkjaF+mcAUUp5pQ00+ckcWOJJsoZpIZWt/XdP0W1HN5wj9GOKji11dtNyM8JOqEPl+s8BQq5W9iCF0ElBfkjjkjZ7x13fRYfGKZQIuSThecx/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009808; c=relaxed/simple;
	bh=7Tqnlk1rSMG7x6lwyHjqFpCKI+dVX4BIyQfSkIWIQj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvgmykwWD5xZifN2H8NZIVzlNGaOztSnjAOoR16+RSoe+qxAJXKmc1m5FdUHhT25/dx9TuszbvWGzmzWXAUewG2KmFcOy0Vb90c8Ymh/orOylBdiGKeNKNH+kC78Uc8dzNfTtFOPARxhcD/9vXHqY9adeL2JhOvIWGDcnkc3mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uot/kNtM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729009804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1IGPOtU6eyMyHeTI/BGasSDm8xu61wIWJcpWgG7xawY=;
	b=Uot/kNtMCGR6FcN2DnCryvn08UgDxtz5JfjXiyogtNu/o9Vgm/8lLqlicoJyRp7J9IDOEY
	1t0c0iUuLVJUCxRR4MHuZuVkbu9ctextPCPpyXv88F1gF8/fZPQ50KoMJ+e5ekl/NjBHbp
	dyoJBaY4De4p8RMQm3C9KlFZ8P8eE4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-La4Yl1QiMFuBXKVW8ZYKaw-1; Tue, 15 Oct 2024 12:30:03 -0400
X-MC-Unique: La4Yl1QiMFuBXKVW8ZYKaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43124676f8aso22680165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009801; x=1729614601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IGPOtU6eyMyHeTI/BGasSDm8xu61wIWJcpWgG7xawY=;
        b=gx6KZImrAKf9zhYPYNpsQnYA+OgbdhO01GdxPr9LZeYkofG/8Amx+yEDFGTo4m/cu0
         KPkPijaFi+/8U37wLSZXZZ0dXm2zIaj8Y7ZTfVJFE/8JNBRSU6421rij2+ccnwebSqno
         jcyH+jlqi8xbYTkIOT46hs+2f7YNCJSPlzWwyubI10nnMgENSECQajL+G5IPR04PJ6K+
         P3ALjL8XORWb0l2zTUiUvKgX8omgtRNFKGdnMtbBPg1K29cIW0XUZFCS5cUIw3S61tie
         LI5OXu2C2hxP4Oy5CHZi1043/Z4Dm5/bPQF+eTvfYQ/4rav4oYKkqDa1iz5yCUhGlsDe
         tWng==
X-Forwarded-Encrypted: i=1; AJvYcCWtN45uSDvWvsqbrx/xNlzYDTECAEYU4KhoByFYfl6joVsY2hoKoRdh5tW+KiF2Aa1ZqUWFmwluBNCe4mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVhmiB6jxjc/7zyCTec08U8rkjZMlAmCXlNMLSPn4Z73tEXB6
	pb08ig193WI5qjfQbh2br+gkQL5a+GgaGd4He4VNOwAjFhpFvXwm98UWWhgo4V5iOAlndKumHUI
	aDfiZGbVwSiRNO8LhjZp5YBDry371LTIMBa+qjDClio+KG7A8Lf82FXIuiwi9bfLjD+8pJvSCBf
	pKEpdg1eA6YzU6URHftWso5yKXHo1n12Bp4AqlTzrmdkchtAbsfw==
X-Received: by 2002:a5d:4d87:0:b0:37c:cd38:e7bd with SMTP id ffacd0b85a97d-37d86c03222mr741929f8f.29.1729009801345;
        Tue, 15 Oct 2024 09:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8CmDfZtWOz6lv2Freu/Fa5e4R6/XyKIz482X/CRw61G42qOXehyzKp2Z0v1pih0UdRyHwNWIOiILrVZK4eoU=
X-Received: by 2002:a5d:4d87:0:b0:37c:cd38:e7bd with SMTP id
 ffacd0b85a97d-37d86c03222mr741901f8f.29.1729009800862; Tue, 15 Oct 2024
 09:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728903647.git.kai.huang@intel.com> <f25673ea-08c5-474b-a841-095656820b67@intel.com>
In-Reply-To: <f25673ea-08c5-474b-a841-095656820b67@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Oct 2024 18:29:47 +0200
Message-ID: <CABgObfYXUxqQV_FoxKjC8U3t5DnyM45nz5DpTxYZv2x_uFK_Kw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] TDX host: metadata reading tweaks, bug fix and
 info dump
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, kirill.shutemov@linux.intel.com, 
	tglx@linutronix.de, bp@alien8.de, peterz@infradead.org, mingo@redhat.com, 
	hpa@zytor.com, dan.j.williams@intel.com, seanjc@google.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	isaku.yamahata@intel.com, adrian.hunter@intel.com, nik.borisov@suse.com
Content-Type: multipart/mixed; boundary="000000000000fea4d40624867616"

--000000000000fea4d40624867616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:30=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> I'm having one of those "I hate this all" moments.  Look at what we say
> in the code:
>
> >   * See the "global_metadata.json" in the "TDX 1.5 ABI definitions".
>
> Basically step one in verifying that this is all right is: Hey, humans,
> please go parse a machine-readable format.  That's insanity.  If Intel
> wants to publish JSON as the canonical source of truth, that's fine.
> It's great, actually.  But let's stop playing human JSON parser and make
> the computers do it for us, OK?
>
> Let's just generate the code.  Basically, as long as the generated C is
> marginally readable, I'm OK with it.  The most important things are:
>
>  1. Adding a field is dirt simple
>  2. Using the generated C is simple
>
> In 99% of the cases, nobody ends up having to ever look at the generated
> code.
>
> Take a look at the attached python program and generated C file.  I
> think they qualify.  We can check the script into tools/scripts/ and it
> can get re-run when new json comes out or when a new field is needed.
> You'd could call the generated code like this:

Ok, so let's move this thing forward. Here is a more polished script
and the output. Untested beyond compilation.

Kai, feel free to include it in v6 with my

Signed-off-by: Paolo Bonzini <pbonzini@redhat.om>

I made an attempt at adding array support and using it with the CMR
information; just to see if Intel is actually trying to make
global_metadata.json accurate. The original code has

  for (i =3D 0; i < sysinfo_cmr->num_cmrs; i++) {
    READ_SYS_INFO(CMR_BASE + i, cmr_base[i]);
    READ_SYS_INFO(CMR_SIZE + i, cmr_size[i]);
  }

The generated code instead always tries to read 32 fields and returns
non-zero from get_tdx_sys_info_cmr if they are missing. If it fails to
read the fields above NUM_CMRS, just remove that part of the tdx.py
script and make sure that a comment in the code shames the TDX ABI
documentation adequately. :)

Thanks,

Paolo

--000000000000fea4d40624867616
Content-Type: text/x-csrc; charset="US-ASCII"; name="tdx-generated.c"
Content-Disposition: attachment; filename="tdx-generated.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m2ankbvj0>
X-Attachment-Id: f_m2ankbvj0

LyogQXV0b21hdGljYWxseSBnZW5lcmF0ZWQgYnkgdGR4LnB5ICovCgpzdGF0aWMgaW50IGdldF90
ZHhfc3lzX2luZm9fdmVyc2lvbihzdHJ1Y3QgdGR4X3N5c19pbmZvX3ZlcnNpb24gKm91dCkKewoJ
aW50IHJldCA9IDA7Cgl1NjQgdmFsOwoKCWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0
YWRhdGFfZmllbGQoMHg4ODAwMDAwMjAwMDAwMDAxLCAmdmFsKSkpIG91dC0+YnVpbGRfZGF0ZSA9
IHZhbDsKCWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHg4ODAw
MDAwMTAwMDAwMDAyLCAmdmFsKSkpIG91dC0+YnVpbGRfbnVtID0gdmFsOwoJaWYgKCFyZXQgJiYg
IShyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDA4MDAwMDAxMDAwMDAwMDMsICZ2YWwp
KSkgb3V0LT5taW5vcl92ZXJzaW9uID0gdmFsOwoJaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5
c19tZXRhZGF0YV9maWVsZCgweDA4MDAwMDAxMDAwMDAwMDQsICZ2YWwpKSkgb3V0LT5tYWpvcl92
ZXJzaW9uID0gdmFsOwoJaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVs
ZCgweDA4MDAwMDAxMDAwMDAwMDUsICZ2YWwpKSkgb3V0LT51cGRhdGVfdmVyc2lvbiA9IHZhbDsK
CWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHgwODAwMDAwMTAw
MDAwMDA2LCAmdmFsKSkpIG91dC0+aW50ZXJuYWxfdmVyc2lvbiA9IHZhbDsKCglyZXR1cm4gcmV0
Owp9CgpzdGF0aWMgaW50IGdldF90ZHhfc3lzX2luZm9fZmVhdHVyZXMoc3RydWN0IHRkeF9zeXNf
aW5mb19mZWF0dXJlcyAqb3V0KQp7CglpbnQgcmV0ID0gMDsKCXU2NCB2YWw7CgoJaWYgKCFyZXQg
JiYgIShyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDBBMDAwMDAzMDAwMDAwMDgsICZ2
YWwpKSkgb3V0LT50ZHhfZmVhdHVyZXMwID0gdmFsOwoKCXJldHVybiByZXQ7Cn0KCnN0YXRpYyBp
bnQgZ2V0X3RkeF9zeXNfaW5mb190ZG1yKHN0cnVjdCB0ZHhfc3lzX2luZm9fdGRtciAqb3V0KQp7
CglpbnQgcmV0ID0gMDsKCXU2NCB2YWw7CgoJaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5c19t
ZXRhZGF0YV9maWVsZCgweDkxMDAwMDAxMDAwMDAwMDgsICZ2YWwpKSkgb3V0LT5tYXhfdGRtcnMg
PSB2YWw7CglpZiAoIXJldCAmJiAhKHJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxkKDB4OTEw
MDAwMDEwMDAwMDAwOSwgJnZhbCkpKSBvdXQtPm1heF9yZXNlcnZlZF9wZXJfdGRtciA9IHZhbDsK
CWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHg5MTAwMDAwMTAw
MDAwMDEwLCAmdmFsKSkpIG91dC0+cGFtdF80a19lbnRyeV9zaXplID0gdmFsOwoJaWYgKCFyZXQg
JiYgIShyZXQgPSByZWFkX3N5c19tZXRhZGF0YV9maWVsZCgweDkxMDAwMDAxMDAwMDAwMTEsICZ2
YWwpKSkgb3V0LT5wYW10XzJtX2VudHJ5X3NpemUgPSB2YWw7CglpZiAoIXJldCAmJiAhKHJldCA9
IHJlYWRfc3lzX21ldGFkYXRhX2ZpZWxkKDB4OTEwMDAwMDEwMDAwMDAxMiwgJnZhbCkpKSBvdXQt
PnBhbXRfMWdfZW50cnlfc2l6ZSA9IHZhbDsKCglyZXR1cm4gcmV0Owp9CgpzdGF0aWMgaW50IGdl
dF90ZHhfc3lzX2luZm9fY21yKHN0cnVjdCB0ZHhfc3lzX2luZm9fY21yICpvdXQpCnsKCWludCBy
ZXQgPSAwOwoJdTY0IHZhbDsKCWludCBpOwoKCWlmICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNf
bWV0YWRhdGFfZmllbGQoMHg5MDAwMDAwMTAwMDAwMDAwLCAmdmFsKSkpIG91dC0+bnVtX2NtcnMg
PSB2YWw7Cglmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykKCQlpZiAoIXJldCAmJiAhKHJldCA9IHJl
YWRfc3lzX21ldGFkYXRhX2ZpZWxkKDB4OTAwMDAwMDMwMDAwMDA4MCArIGksICZ2YWwpKSkgb3V0
LT5jbXJfYmFzZVtpXSA9IHZhbDsKCWZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKQoJCWlmICghcmV0
ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoMHg5MDAwMDAwMzAwMDAwMTAwICsg
aSwgJnZhbCkpKSBvdXQtPmNtcl9zaXplW2ldID0gdmFsOwoKCXJldHVybiByZXQ7Cn0K
--000000000000fea4d40624867616
Content-Type: text/x-chdr; charset="US-ASCII"; name="tdx-generated.h"
Content-Disposition: attachment; filename="tdx-generated.h"
Content-Transfer-Encoding: base64
Content-ID: <f_m2ankbyc1>
X-Attachment-Id: f_m2ankbyc1

LyogQXV0b21hdGljYWxseSBnZW5lcmF0ZWQgYnkgdGR4LnB5ICovCiNpZm5kZWYgVERYX0RBVEFf
R0VORVJBVEVEX0gKI2RlZmluZSBURFhfREFUQV9HRU5FUkFURURfSCAxCgpzdHJ1Y3QgdGR4X3N5
c19pbmZvX3ZlcnNpb24gewoJdTMyIGJ1aWxkX2RhdGU7Cgl1MTYgYnVpbGRfbnVtOwoJdTE2IG1p
bm9yX3ZlcnNpb247Cgl1MTYgbWFqb3JfdmVyc2lvbjsKCXUxNiB1cGRhdGVfdmVyc2lvbjsKCXUx
NiBpbnRlcm5hbF92ZXJzaW9uOwp9OwoKc3RydWN0IHRkeF9zeXNfaW5mb19mZWF0dXJlcyB7Cgl1
NjQgdGR4X2ZlYXR1cmVzMDsKfTsKCnN0cnVjdCB0ZHhfc3lzX2luZm9fdGRtciB7Cgl1MTYgbWF4
X3RkbXJzOwoJdTE2IG1heF9yZXNlcnZlZF9wZXJfdGRtcjsKCXUxNiBwYW10XzRrX2VudHJ5X3Np
emU7Cgl1MTYgcGFtdF8ybV9lbnRyeV9zaXplOwoJdTE2IHBhbXRfMWdfZW50cnlfc2l6ZTsKfTsK
CnN0cnVjdCB0ZHhfc3lzX2luZm9fY21yIHsKCXUxNiBudW1fY21yczsKCXU2NCBjbXJfYmFzZVsz
Ml07Cgl1NjQgY21yX3NpemVbMzJdOwp9OwoKI2VuZGlmCg==
--000000000000fea4d40624867616
Content-Type: text/x-python; charset="US-ASCII"; name="tdx.py"
Content-Disposition: attachment; filename="tdx.py"
Content-Transfer-Encoding: base64
Content-ID: <f_m2ankbz82>
X-Attachment-Id: f_m2ankbz82

IyEgL3Vzci9iaW4vZW52IHB5dGhvbjMKaW1wb3J0IGpzb24KaW1wb3J0IHN5cwoKIyBOb3RlOiB0
aGlzIHNjcmlwdCBkb2VzIG5vdCBydW4gYXMgcGFydCBvZiB0aGUgYnVpbGQgcHJvY2Vzcy4KIyBJ
dCBpcyB1c2VkIHRvIGdlbmVyYXRlIHN0cnVjdHMgZnJvbSB0aGUgVERYIGdsb2JhbF9tZXRhZGF0
YS5qc29uCiMgZmlsZSwgYW5kIGZ1bmN0aW9ucyB0byBmaWxsIGluIHNhaWQgc3RydWN0cy4gIFJl
cnVuIGl0IGlmCiMgeW91IG5lZWQgbW9yZSBmaWVsZHMuCgpURFhfU1RSVUNUUyA9IHsKICAgICJ0
ZHhfc3lzX2luZm9fdmVyc2lvbiI6IFsKICAgICAgICAiQlVJTERfREFURSIsCiAgICAgICAgIkJV
SUxEX05VTSIsCiAgICAgICAgIk1JTk9SX1ZFUlNJT04iLAogICAgICAgICJNQUpPUl9WRVJTSU9O
IiwKICAgICAgICAiVVBEQVRFX1ZFUlNJT04iLAogICAgICAgICJJTlRFUk5BTF9WRVJTSU9OIiwK
ICAgIF0sCiAgICAidGR4X3N5c19pbmZvX2ZlYXR1cmVzIjogWwogICAgICAgICJURFhfRkVBVFVS
RVMwIgogICAgXSwKICAgICJ0ZHhfc3lzX2luZm9fdGRtciI6IFsKICAgICAgICAiTUFYX1RETVJT
IiwKICAgICAgICAiTUFYX1JFU0VSVkVEX1BFUl9URE1SIiwKICAgICAgICAiUEFNVF80S19FTlRS
WV9TSVpFIiwKICAgICAgICAiUEFNVF8yTV9FTlRSWV9TSVpFIiwKICAgICAgICAiUEFNVF8xR19F
TlRSWV9TSVpFIiwKICAgIF0sCiAgICAidGR4X3N5c19pbmZvX2NtciI6IFsKICAgICAgICAiTlVN
X0NNUlMiLCAiQ01SX0JBU0UiLCAiQ01SX1NJWkUiCiAgICBdLAp9CgoKZGVmIHByaW50X3N0cnVj
dChuYW1lLCBmaWVsZHMsIGZpbGUpOgogICAgcHJpbnQoInN0cnVjdCAlcyB7IiAlIChuYW1lLCks
IGZpbGU9ZmlsZSkKICAgIGZvciBmIGluIGZpZWxkczoKICAgICAgICBmbmFtZSA9IGZbIkZpZWxk
IE5hbWUiXQogICAgICAgIGVsZW1lbnRfYnl0ZXMgPSBpbnQoZlsiRWxlbWVudCBTaXplIChCeXRl
cykiXSkKICAgICAgICBlbGVtZW50X2JpdHMgPSBlbGVtZW50X2J5dGVzICogOAogICAgICAgIG51
bV9maWVsZHMgPSBpbnQoZlsiTnVtIEZpZWxkcyJdKQogICAgICAgIGlmIG51bV9maWVsZHMgPT0g
MToKICAgICAgICAgICAgcHJpbnQoIlx0dSVkICVzOyIgJSAoZWxlbWVudF9iaXRzLCBmbmFtZS5s
b3dlcigpKSwgZmlsZT1maWxlKQogICAgICAgIGVsc2U6CiAgICAgICAgICAgIHByaW50KAogICAg
ICAgICAgICAgICAgIlx0dSVkICVzWyVkXTsiICUgKGVsZW1lbnRfYml0cywgZm5hbWUubG93ZXIo
KSwgbnVtX2ZpZWxkcyksIGZpbGU9ZmlsZQogICAgICAgICAgICApCiAgICBwcmludCgifTsiLCBm
aWxlPWZpbGUpCgoKZGVmIHByaW50X2ZpZWxkKG51bWJlciwgbWVtYmVyLCBpbmRlbnQsIGZpbGUp
OgogICAgcHJpbnQoCiAgICAgICAgIiVzaWYgKCFyZXQgJiYgIShyZXQgPSByZWFkX3N5c19tZXRh
ZGF0YV9maWVsZCglcywgJnZhbCkpKSBvdXQtPiVzID0gdmFsOyIKICAgICAgICAlIChpbmRlbnQs
IG51bWJlciwgbWVtYmVyKSwKICAgICAgICBmaWxlPWZpbGUsCiAgICApCgoKZGVmIHByaW50X2Z1
bmN0aW9uKG5hbWUsIGZpZWxkcywgZmlsZSk6CiAgICBwcmludCgic3RhdGljIGludCBnZXRfJXMo
c3RydWN0ICVzICpvdXQpIiAlIChuYW1lLCBuYW1lKSwgZmlsZT1maWxlKQogICAgcHJpbnQoInsi
LCBmaWxlPWZpbGUpCgogICAgcHJpbnQoIlx0aW50IHJldCA9IDA7IiwgZmlsZT1maWxlKQogICAg
cHJpbnQoIlx0dTY0IHZhbDsiLCBmaWxlPWZpbGUpCiAgICBmb3IgZiBpbiBmaWVsZHM6CiAgICAg
ICAgbnVtX2ZpZWxkcyA9IGludChmWyJOdW0gRmllbGRzIl0pCiAgICAgICAgaWYgbnVtX2ZpZWxk
cyA+IDE6CiAgICAgICAgICAgIHByaW50KCJcdGludCBpOyIsIGZpbGU9ZmlsZSkKICAgICAgICAg
ICAgYnJlYWsKCiAgICBwcmludChmaWxlPWZpbGUpCiAgICBmb3IgZiBpbiBmaWVsZHM6CiAgICAg
ICAgbnVtX2ZpZWxkcyA9IGludChmWyJOdW0gRmllbGRzIl0pCiAgICAgICAgaWYgbnVtX2ZpZWxk
cyA9PSAxOgogICAgICAgICAgICBwcmludF9maWVsZCgKICAgICAgICAgICAgICAgIGZbIkJhc2Ug
RklFTERfSUQgKEhleCkiXSwKICAgICAgICAgICAgICAgIGZbIkZpZWxkIE5hbWUiXS5sb3dlcigp
LAogICAgICAgICAgICAgICAgaW5kZW50PSJcdCIsCiAgICAgICAgICAgICAgICBmaWxlPWZpbGUs
CiAgICAgICAgICAgICkKICAgICAgICBlbHNlOgogICAgICAgICAgICBwcmludCgiXHRmb3IgKGkg
PSAwOyBpIDwgJWQ7IGkrKykiICUgKG51bV9maWVsZHMsKSwgZmlsZT1maWxlKQogICAgICAgICAg
ICBwcmludF9maWVsZCgKICAgICAgICAgICAgICAgIGZbIkJhc2UgRklFTERfSUQgKEhleCkiXSAr
ICIgKyBpIiwKICAgICAgICAgICAgICAgIGZbIkZpZWxkIE5hbWUiXS5sb3dlcigpICsgIltpXSIs
CiAgICAgICAgICAgICAgICBpbmRlbnQ9Ilx0XHQiLAogICAgICAgICAgICAgICAgZmlsZT1maWxl
LAogICAgICAgICAgICApCgogICAgcHJpbnQoZmlsZT1maWxlKQogICAgcHJpbnQoIlx0cmV0dXJu
IHJldDsiLCBmaWxlPWZpbGUpCiAgICBwcmludCgifSIsIGZpbGU9ZmlsZSkKCgpqc29uZmlsZSA9
IHN5cy5hcmd2WzFdCmhmaWxlID0gc3lzLmFyZ3ZbMl0KY2ZpbGUgPSBzeXMuYXJndlszXQoKd2l0
aCBvcGVuKGpzb25maWxlLCAiciIpIGFzIGY6CiAgICBqc29uX2luID0ganNvbi5sb2FkKGYpCiAg
ICBmaWVsZHMgPSB7eFsiRmllbGQgTmFtZSJdOiB4IGZvciB4IGluIGpzb25faW5bIkZpZWxkcyJd
fQoKd2l0aCBvcGVuKGhmaWxlLCAidyIpIGFzIGY6CiAgICBwcmludCgiLyogQXV0b21hdGljYWxs
eSBnZW5lcmF0ZWQgYnkgdGR4LnB5ICovIiwgZmlsZT1mKQogICAgcHJpbnQoIiNpZm5kZWYgVERY
X0RBVEFfR0VORVJBVEVEX0giLCBmaWxlPWYpCiAgICBwcmludCgiI2RlZmluZSBURFhfREFUQV9H
RU5FUkFURURfSCAxIiwgZmlsZT1mKQogICAgZm9yIG5hbWUsIGZpZWxkX25hbWVzIGluIFREWF9T
VFJVQ1RTLml0ZW1zKCk6CiAgICAgICAgcHJpbnQoZmlsZT1mKQogICAgICAgIHByaW50X3N0cnVj
dChuYW1lLCBbZmllbGRzW3hdIGZvciB4IGluIGZpZWxkX25hbWVzXSwgZmlsZT1mKQogICAgcHJp
bnQoZmlsZT1mKQogICAgcHJpbnQoIiNlbmRpZiIsIGZpbGU9ZikKCndpdGggb3BlbihjZmlsZSwg
InciKSBhcyBmOgogICAgcHJpbnQoIi8qIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGJ5IHRkeC5w
eSAqLyIsIGZpbGU9ZikKICAgIGZvciBuYW1lLCBmaWVsZF9uYW1lcyBpbiBURFhfU1RSVUNUUy5p
dGVtcygpOgogICAgICAgIHByaW50KGZpbGU9ZikKICAgICAgICBwcmludF9mdW5jdGlvbihuYW1l
LCBbZmllbGRzW3hdIGZvciB4IGluIGZpZWxkX25hbWVzXSwgZmlsZT1mKQo=
--000000000000fea4d40624867616--


