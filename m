Return-Path: <linux-kernel+bounces-576682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E20A71302
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4FE172911
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E01DFDE;
	Wed, 26 Mar 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+bV07uZ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D92628C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978791; cv=none; b=oIEg2BuwaIrrE0qOtM5H8qARnL+fLME/wUkmOUMYmxfpdxl3trOSdqxQWc6V34UTw7Rb8S+1L83QdNzWqMZn3u4I8Fph9EeX1eCPAFGSG7Ydv8IjmexRlKHgOSOPKKmqFRV7O15sMnFtg9PdTx/+FVn3D39suChbx/Eaz8Mx9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978791; c=relaxed/simple;
	bh=K/dtw6Zy7JkO/qW/mn8P9kjeYNUEvGBSWGjYZWAiAkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXoKGPaJg6TQbX5NbC3i31tZxRQ6/MZfwJZhlQVMkmOS5VKj0B7T7akziXhRToIBsVYWOk2cEoVSPdSosB+//utjzNrD8pEDVJE5/ACF4vVaTg1MkYxVtKJe61XXDQyLdR32kEAHsWTEEABWIeAwCONvgNazHSvbW80tM3AcnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+bV07uZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so66604741fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742978787; x=1743583587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1AhgH9UIweYAk5QdmzyUWPpgLDiJpug8oPX2Zm0hwCE=;
        b=L+bV07uZXBODBctneo/I7dWob+nSGIgQ3wWsqLoY1kK8QYIePhdLrqbQkFTLiJmeyt
         OJjeoKPVnr8wvuP3FEQgqsUtOpqrSzYdkAMYs9tJY55PZIg4+xGrZ5Pv8zdFIn4k+CsY
         3AS4b6B+gg7MGQdZKUXdS2uqnhLAeO/GUg3Scdas7eFb5pie1DUPhLFvao74/yHtjMKz
         d01bs+8vzVFZdhoFntIje6o+08LCHH9keeoihA3fH707nAyQIX2kglk2inkGhS/sDEcn
         iK26hN7rWDiEDKPAqMYm0H3cQvjbxA+FlfyhVWm4IXLzqPeQX6onIGPSrfKribVjdhl9
         bxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742978788; x=1743583588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AhgH9UIweYAk5QdmzyUWPpgLDiJpug8oPX2Zm0hwCE=;
        b=uUi8sxlBb+SzhRPkpUo9XhBQosyGWg5C6UZXN64HjBs68w6/kazlFdj49xrfW8t5s5
         RKIHMZ9HG83/YtrgJEAjt+xTR0wFYE9LQmjgLbkDLRyryRxFVwVVZMJTLY80hwirUMWn
         Otp4BPDyn9HeGLL1TpZd2Yrim+c1fs5cazqu9hmXc9uIgeJL3+wfCWefNk3QJA2h2VCd
         KFDGfNV3NXJkptP9pzbEV/2DaGrr3XZ0GhjmheYhYnT5cTc62xQUjh62O7TL+HIVI56Z
         NaEBgbOR+zOxL5HwKtMgcS0w+RjDI1cKPhIS4doHeQ+Wnnqr1bRK9CQ+W76KW/PZ4yup
         znCA==
X-Forwarded-Encrypted: i=1; AJvYcCWDlC+vxNRA37GJS1i/77GSvsBKBMVpNG4t1RDwcRelT7VXs5C4mi+p0oQPXvtwzHU4YCp74fHKQi+4fr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcvGn3dU1jgFG9e150jk48lIbJO8RS9wmp6Fif2Qc31npbTxu
	ZRINYX5BmFmo4Q9Q6y8Iw1ODO7BMKAcrfctzcAt9/bR729GqZvz/dRzgbjV0b+7WRzBsyrpDUsz
	PpgEASYhmYkdQExNge71+xlYyabY=
X-Gm-Gg: ASbGncumDwbly+22FyZ1w572ez4hWgY3R3xEwjGgZRXWiY9J8KGC0MUhKiBA0dBcFlb
	mYGuBkz4JL5bMtapghsaCU3bErymgerRbayFNLWb8piyXVM42K6Pc74lJDvhrouNhgynMV06l++
	jOhePCvr1qfcqa0wgBQrW4cTAu/w==
X-Google-Smtp-Source: AGHT+IG7g9IsMKWIX3zdEoCpgKg06FS6rhOt/4tehElEjIFgWetLBkAHQT+YNTwVtU6x0HA3Lzb+HE4Tc/IwVWm9yvA=
X-Received: by 2002:a2e:91ce:0:b0:30d:886b:1fff with SMTP id
 38308e7fff4ca-30d886b204fmr63125391fa.37.1742978787269; Wed, 26 Mar 2025
 01:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325175215.330659-1-ubizjak@gmail.com> <20250325175215.330659-2-ubizjak@gmail.com>
 <Z-MjgKSzJKIVooFI@gmail.com>
In-Reply-To: <Z-MjgKSzJKIVooFI@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Mar 2025 09:46:15 +0100
X-Gm-Features: AQ5f1JodvbFUEHOT27u4WA367MR6cTVH8DIzGeDW4NhheCu_Q2xwIyKAwCYewyY
Message-ID: <CAFULd4agDYNCJrQQ8bji09eGVJp1D46LH=fOpcfciza2qhKJfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/bitops: Fix false output register dependency of
 TZCNT insn
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="000000000000777bad06313adf37"

--000000000000777bad06313adf37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:43=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Haswell and later Intel processors, the TZCNT instruction appears
> > to have a false dependency on the destination register. Even though
> > the instruction only writes to it, the instruction will wait until
> > destination is ready before executing. This false dependency
> > was fixed for Skylake (and later) processors.
> >
> > Fix false dependency by clearing the destination register first.
> >
> > The x86_64 defconfig object size increases by 4215 bytes:
> >
> >           text           data     bss      dec            hex filename
> >       27342396        4642999  814852 32800247        1f47df7 vmlinux-o=
ld.o
> >       27346611        4643015  814852 32804478        1f48e7e vmlinux-n=
ew.o
>
> Yeah, so Skylake was released in 2015, about a decade ago.
>
> So we'd be making the kernel larger for an unquantified
> micro-optimization for CPUs that almost nobody uses anymore.
> That's a bad trade-off.

Yes, 4.2k seems a bit excessive. OTOH, I'd not say that the issue is a
micro-optimization, it is bordering on the hardware bug.

An alternative (also answering Peter's question) would be to make
instruction dependent only on the input (so, matching input and output
operand, making insn destructive), requiring MOV if the input operand
is to be reused. A quick test (x86_64 defconfig) with the attached
patch shows much less impact:

  text    data     bss     dec     hex filename
27564120        4642423  814852 33021395        1f7ddd3 vmlinux-old.o
27564679        4642423  814852 33021954        1f7e002 vmlinux-new.o

The increase is now 559 bytes, which IMHO is an acceptable trade-off.
Please also note that:

       asm("tzcnt %1,%0"
               : "=3Dr" (word)
               : "r" (~word));
       return word;

emits NOT insn that is also destructive and already requires copying
of the input operand if the operand is to be reused.

Thanks,
Uros.

--000000000000777bad06313adf37
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m8pnzupc0>
X-Attachment-Id: f_m8pnzupc0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vYml0b3BzLmgKaW5kZXggYmJhZjc1ZWE2NzAzLi4zNzgxOTQ2ODdiZWMgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JpdG9wcy5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2JpdG9wcy5oCkBAIC0yNTAsNyArMjUwLDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSB1bnNpZ25lZCBsb25nIHZhcmlhYmxlX19mZnModW5zaWduZWQgbG9uZyB3b3JkKQogewogCWFz
bSgidHpjbnQgJTEsJTAiCiAJCTogIj1yIiAod29yZCkKLQkJOiBBU01fSU5QVVRfUk0gKHdvcmQp
KTsKKwkJOiAiMCIgKHdvcmQpKTsgLyogYXZvaWQgZmFsc2Ugb3V0cHV0IGRlcGVuZGVuY3kgKi8K
IAlyZXR1cm4gd29yZDsKIH0KIApAQCAtMjY3LDEwICsyNjcsNyBAQCBzdGF0aWMgX19hbHdheXNf
aW5saW5lIHVuc2lnbmVkIGxvbmcgdmFyaWFibGVfX2Zmcyh1bnNpZ25lZCBsb25nIHdvcmQpCiAK
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdW5zaWduZWQgbG9uZyB2YXJpYWJsZV9mZnoodW5zaWdu
ZWQgbG9uZyB3b3JkKQogewotCWFzbSgidHpjbnQgJTEsJTAiCi0JCTogIj1yIiAod29yZCkKLQkJ
OiAiciIgKH53b3JkKSk7Ci0JcmV0dXJuIHdvcmQ7CisJcmV0dXJuIHZhcmlhYmxlX19mZnMofndv
cmQpOwogfQogCiAvKioK
--000000000000777bad06313adf37--

