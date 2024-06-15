Return-Path: <linux-kernel+bounces-215984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922C90999B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0B1281F51
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032F55E49;
	Sat, 15 Jun 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NM7xUVj8"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5943EA72
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476616; cv=none; b=doxGvKi7XM+9F8tqNZ2X5Z2NnEP9ckozAIOneNFbJE2P83Y8jWLvacaSuuVtkZfTvrjmlf7EJEHW+Uzn1FJ2IUZY7Pp00CXDN5OSvf03q7dTItGPD+7tULdTeHbJYPJYfafRNuRJ6++BXtgZbR2096aTPiLdPcPDeYx2HTt6z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476616; c=relaxed/simple;
	bh=HoR7ecXs7xwtQ6cP/t00PPFbPhG2LQLM+ohYCe5CsIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RanWR7RD06DPa1dGNpOaJ+HsnqSLVfykE0zmPrfSNy9KEHeI/LCh+oUndTA7o9FdfSsTZxypZbc6j3MUgW0OFze/7PeXUpsvv7yu6dOsixxukyvE4Xg57C0HQm55HxvAMYwYfUY7jID0iRKq8ZyRtRFR6A2GR7ZZY9f1dZ4f8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NM7xUVj8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so4655271a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718476612; x=1719081412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPRTuxpd7+HApyUR/fzyVrOoitwC5bfZN6GClCdCbzs=;
        b=NM7xUVj8E2QsPDldSs+AlgxIJierkEjDOg384NFDNG73Yl1bqIc8ad/Wjzi/xqyokm
         pfJ2S56jBWh7XrZlBGtK8MlX7ckGSb4ArEVikUGDZrDySKq51NRK7j+ZUs5/4IAvGRKO
         xOiPfLVVV8aaNrvOxxkPjN/SGxvmVSE/21+LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718476612; x=1719081412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPRTuxpd7+HApyUR/fzyVrOoitwC5bfZN6GClCdCbzs=;
        b=SkIhxX9pcGLYHRGB0arJpR/LmUpFNA+8tV4fl0/ZOsgjx+9Tjxzz3waQJBlvii5Vpb
         Q7b8OWeowZtwisj02WZw0YVZ5vyNgQ/MoRoeGHI6oxqCEd3tZ44LmCUNq0RMcP0OEEbH
         fQzsQomnMq0FS8MIi8BfcJBB6MPIqmcRLawvzycSrQXwK3RUDMBQEiD7BEhIayvd+XjZ
         tpxpctT984/ELsuj4xY5KGy+duXsJjYQcMnpCjdlfaB9ov/cqRH2+M0JmoI8+8Qvvs+3
         jk9/5PJmWh8nU7RhCWe9ixNBC4WZ4gcGru7Wwh2QaifO4KKWfKHgeZMAcILIcPPNthR6
         fD9w==
X-Gm-Message-State: AOJu0YynTzNOiWU8bCD5UAgRvbbg8t83q6p8Xn311CP5tBdRNumPpxuv
	U0ViQiiJvwZIhlhgxpS1Dve9QU20dLup07adzS/BjmRWLxQ2SPKG4IS/k5rMf3QtQJaRElWEv+R
	25Zo=
X-Google-Smtp-Source: AGHT+IEf5WIKyHav7cLw9dGoUd7ZaIzq2Ei1jD3df+ro0hvZuZAjU7xjmldqFI7LaV6OAwopg0RPDQ==
X-Received: by 2002:a50:a6d9:0:b0:57c:b82e:884b with SMTP id 4fb4d7f45d1cf-57cbd906112mr4154056a12.19.1718476611707;
        Sat, 15 Jun 2024 11:36:51 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e7a5sm3981513a12.75.2024.06.15.11.36.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 11:36:50 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6269885572so738291266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 11:36:50 -0700 (PDT)
X-Received: by 2002:a17:907:86a6:b0:a6e:4e0:8a56 with SMTP id
 a640c23a62f3a-a6f524740c7mr797787166b.32.1718476610239; Sat, 15 Jun 2024
 11:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zm1NIOnj0NR3U8om@gmail.com>
In-Reply-To: <Zm1NIOnj0NR3U8om@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 15 Jun 2024 11:36:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
Message-ID: <CAHk-=whYb2L_atsRk9pBiFiVLGe5wNZLHhRinA69yu6FiKvDsw@mail.gmail.com>
Subject: Re: [GIT PULL] x86 fixes
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: multipart/mixed; boundary="000000000000e8bd07061af20398"

--000000000000e8bd07061af20398
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Jun 2024 at 01:13, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Fix the 8 bytes get_user() logic on x86-32

This is clearly a fix, but I think it's a bit ugly.

Instead of adding _more_ special cases for size 8, we could just remove them.

Making the 8-bit two-word versions just clear %ecx before doing the
first load means that all the exception handling becomes entirely
unified.

And then you can just use a nice macro for all the user accesses, and
the #ifdefs go away entirely for all exception handling. All that
remains is the "do I do a 'movq' or an xor and two movl's" question.

Something ENTIRELY UNTESTED like this, IOW.

I did check that it seemed to generate sane code on both 32-bit and
64-bit, but no _actual_ testing.

               Linus

--000000000000e8bd07061af20398
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxggjrf80>
X-Attachment-Id: f_lxggjrf80

IGFyY2gveDg2L2xpYi9nZXR1c2VyLlMgfCA2OSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyks
IDQ5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2xpYi9nZXR1c2VyLlMgYi9h
cmNoL3g4Ni9saWIvZ2V0dXNlci5TCmluZGV4IGExY2IzYTRlNjc0Mi4uYTMxNDYyMmFhMDkzIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9saWIvZ2V0dXNlci5TCisrKyBiL2FyY2gveDg2L2xpYi9nZXR1
c2VyLlMKQEAgLTQ0LDIxICs0NCwyMyBAQAogCW9yICVyZHgsICVyYXgKIC5lbHNlCiAJY21wICRU
QVNLX1NJWkVfTUFYLVxzaXplKzEsICVlYXgKLS5pZiBcc2l6ZSAhPSA4CiAJamFlIC5MYmFkX2dl
dF91c2VyCi0uZWxzZQotCWphZSAuTGJhZF9nZXRfdXNlcl84Ci0uZW5kaWYKIAlzYmIgJWVkeCwg
JWVkeAkJLyogYXJyYXlfaW5kZXhfbWFza19ub3NwZWMoKSAqLwogCWFuZCAlZWR4LCAlZWF4CiAu
ZW5kaWYKIC5lbmRtCiAKKy5tYWNybyBVQUNDRVNTIG9wIHNyYyBkc3QKKzE6CVxvcCBcc3JjLFxk
c3QKKwlfQVNNX0VYVEFCTEVfVUEoMWIsIF9fZ2V0X3VzZXJfaGFuZGxlX2V4Y2VwdGlvbikKKy5l
bmRtCisKKwogCS50ZXh0CiBTWU1fRlVOQ19TVEFSVChfX2dldF91c2VyXzEpCiAJY2hlY2tfcmFu
Z2Ugc2l6ZT0xCiAJQVNNX1NUQUMKLTE6CW1vdnpibCAoJV9BU01fQVgpLCVlZHgKKwlVQUNDRVNT
IG1vdnpibCAoJV9BU01fQVgpLCVlZHgKIAl4b3IgJWVheCwlZWF4CiAJQVNNX0NMQUMKIAlSRVQK
QEAgLTY4LDcgKzcwLDcgQEAgRVhQT1JUX1NZTUJPTChfX2dldF91c2VyXzEpCiBTWU1fRlVOQ19T
VEFSVChfX2dldF91c2VyXzIpCiAJY2hlY2tfcmFuZ2Ugc2l6ZT0yCiAJQVNNX1NUQUMKLTI6CW1v
dnp3bCAoJV9BU01fQVgpLCVlZHgKKwlVQUNDRVNTIG1vdnp3bCAoJV9BU01fQVgpLCVlZHgKIAl4
b3IgJWVheCwlZWF4CiAJQVNNX0NMQUMKIAlSRVQKQEAgLTc4LDcgKzgwLDcgQEAgRVhQT1JUX1NZ
TUJPTChfX2dldF91c2VyXzIpCiBTWU1fRlVOQ19TVEFSVChfX2dldF91c2VyXzQpCiAJY2hlY2tf
cmFuZ2Ugc2l6ZT00CiAJQVNNX1NUQUMKLTM6CW1vdmwgKCVfQVNNX0FYKSwlZWR4CisJVUFDQ0VT
UyBtb3ZsICglX0FTTV9BWCksJWVkeAogCXhvciAlZWF4LCVlYXgKIAlBU01fQ0xBQwogCVJFVApA
QCAtODksMTAgKzkxLDExIEBAIFNZTV9GVU5DX1NUQVJUKF9fZ2V0X3VzZXJfOCkKIAljaGVja19y
YW5nZSBzaXplPTgKIAlBU01fU1RBQwogI2lmZGVmIENPTkZJR19YODZfNjQKLTQ6CW1vdnEgKCVf
QVNNX0FYKSwlcmR4CisJVUFDQ0VTUyBtb3ZxICglX0FTTV9BWCksJXJkeAogI2Vsc2UKLTQ6CW1v
dmwgKCVfQVNNX0FYKSwlZWR4Ci01Ogltb3ZsIDQoJV9BU01fQVgpLCVlY3gKKwl4b3IgJWVjeCwl
ZWN4CisJVUFDQ0VTUyBtb3ZsICglX0FTTV9BWCksJWVkeAorCVVBQ0NFU1MgbW92bCA0KCVfQVNN
X0FYKSwlZWN4CiAjZW5kaWYKIAl4b3IgJWVheCwlZWF4CiAJQVNNX0NMQUMKQEAgLTEwNCw3ICsx
MDcsNyBAQCBFWFBPUlRfU1lNQk9MKF9fZ2V0X3VzZXJfOCkKIFNZTV9GVU5DX1NUQVJUKF9fZ2V0
X3VzZXJfbm9jaGVja18xKQogCUFTTV9TVEFDCiAJQVNNX0JBUlJJRVJfTk9TUEVDCi02Ogltb3Z6
YmwgKCVfQVNNX0FYKSwlZWR4CisJVUFDQ0VTUyBtb3Z6YmwgKCVfQVNNX0FYKSwlZWR4CiAJeG9y
ICVlYXgsJWVheAogCUFTTV9DTEFDCiAJUkVUCkBAIC0xMTQsNyArMTE3LDcgQEAgRVhQT1JUX1NZ
TUJPTChfX2dldF91c2VyX25vY2hlY2tfMSkKIFNZTV9GVU5DX1NUQVJUKF9fZ2V0X3VzZXJfbm9j
aGVja18yKQogCUFTTV9TVEFDCiAJQVNNX0JBUlJJRVJfTk9TUEVDCi03Ogltb3Z6d2wgKCVfQVNN
X0FYKSwlZWR4CisJVUFDQ0VTUyBtb3Z6d2wgKCVfQVNNX0FYKSwlZWR4CiAJeG9yICVlYXgsJWVh
eAogCUFTTV9DTEFDCiAJUkVUCkBAIC0xMjQsNyArMTI3LDcgQEAgRVhQT1JUX1NZTUJPTChfX2dl
dF91c2VyX25vY2hlY2tfMikKIFNZTV9GVU5DX1NUQVJUKF9fZ2V0X3VzZXJfbm9jaGVja180KQog
CUFTTV9TVEFDCiAJQVNNX0JBUlJJRVJfTk9TUEVDCi04Ogltb3ZsICglX0FTTV9BWCksJWVkeAor
CVVBQ0NFU1MgbW92bCAoJV9BU01fQVgpLCVlZHgKIAl4b3IgJWVheCwlZWF4CiAJQVNNX0NMQUMK
IAlSRVQKQEAgLTEzNSwxMCArMTM4LDExIEBAIFNZTV9GVU5DX1NUQVJUKF9fZ2V0X3VzZXJfbm9j
aGVja184KQogCUFTTV9TVEFDCiAJQVNNX0JBUlJJRVJfTk9TUEVDCiAjaWZkZWYgQ09ORklHX1g4
Nl82NAotOToJbW92cSAoJV9BU01fQVgpLCVyZHgKKwlVQUNDRVNTIG1vdnEgKCVfQVNNX0FYKSwl
cmR4CiAjZWxzZQotOToJbW92bCAoJV9BU01fQVgpLCVlZHgKLTEwOgltb3ZsIDQoJV9BU01fQVgp
LCVlY3gKKwl4b3IgJWVjeCwlZWN4CisJVUFDQ0VTUyBtb3ZsICglX0FTTV9BWCksJWVkeAorCVVB
Q0NFU1MgbW92bCA0KCVfQVNNX0FYKSwlZWN4CiAjZW5kaWYKIAl4b3IgJWVheCwlZWF4CiAJQVNN
X0NMQUMKQEAgLTE1NCwzNiArMTU4LDMgQEAgU1lNX0NPREVfU1RBUlRfTE9DQUwoX19nZXRfdXNl
cl9oYW5kbGVfZXhjZXB0aW9uKQogCW1vdiAkKC1FRkFVTFQpLCVfQVNNX0FYCiAJUkVUCiBTWU1f
Q09ERV9FTkQoX19nZXRfdXNlcl9oYW5kbGVfZXhjZXB0aW9uKQotCi0jaWZkZWYgQ09ORklHX1g4
Nl8zMgotU1lNX0NPREVfU1RBUlRfTE9DQUwoX19nZXRfdXNlcl84X2hhbmRsZV9leGNlcHRpb24p
Ci0JQVNNX0NMQUMKLS5MYmFkX2dldF91c2VyXzg6Ci0JeG9yICVlZHgsJWVkeAotCXhvciAlZWN4
LCVlY3gKLQltb3YgJCgtRUZBVUxUKSwlX0FTTV9BWAotCVJFVAotU1lNX0NPREVfRU5EKF9fZ2V0
X3VzZXJfOF9oYW5kbGVfZXhjZXB0aW9uKQotI2VuZGlmCi0KLS8qIGdldF91c2VyICovCi0JX0FT
TV9FWFRBQkxFX1VBKDFiLCBfX2dldF91c2VyX2hhbmRsZV9leGNlcHRpb24pCi0JX0FTTV9FWFRB
QkxFX1VBKDJiLCBfX2dldF91c2VyX2hhbmRsZV9leGNlcHRpb24pCi0JX0FTTV9FWFRBQkxFX1VB
KDNiLCBfX2dldF91c2VyX2hhbmRsZV9leGNlcHRpb24pCi0jaWZkZWYgQ09ORklHX1g4Nl82NAot
CV9BU01fRVhUQUJMRV9VQSg0YiwgX19nZXRfdXNlcl9oYW5kbGVfZXhjZXB0aW9uKQotI2Vsc2UK
LQlfQVNNX0VYVEFCTEVfVUEoNGIsIF9fZ2V0X3VzZXJfOF9oYW5kbGVfZXhjZXB0aW9uKQotCV9B
U01fRVhUQUJMRV9VQSg1YiwgX19nZXRfdXNlcl84X2hhbmRsZV9leGNlcHRpb24pCi0jZW5kaWYK
LQotLyogX19nZXRfdXNlciAqLwotCV9BU01fRVhUQUJMRV9VQSg2YiwgX19nZXRfdXNlcl9oYW5k
bGVfZXhjZXB0aW9uKQotCV9BU01fRVhUQUJMRV9VQSg3YiwgX19nZXRfdXNlcl9oYW5kbGVfZXhj
ZXB0aW9uKQotCV9BU01fRVhUQUJMRV9VQSg4YiwgX19nZXRfdXNlcl9oYW5kbGVfZXhjZXB0aW9u
KQotI2lmZGVmIENPTkZJR19YODZfNjQKLQlfQVNNX0VYVEFCTEVfVUEoOWIsIF9fZ2V0X3VzZXJf
aGFuZGxlX2V4Y2VwdGlvbikKLSNlbHNlCi0JX0FTTV9FWFRBQkxFX1VBKDliLCBfX2dldF91c2Vy
XzhfaGFuZGxlX2V4Y2VwdGlvbikKLQlfQVNNX0VYVEFCTEVfVUEoMTBiLCBfX2dldF91c2VyXzhf
aGFuZGxlX2V4Y2VwdGlvbikKLSNlbmRpZgo=
--000000000000e8bd07061af20398--

