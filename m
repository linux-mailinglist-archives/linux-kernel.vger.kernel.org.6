Return-Path: <linux-kernel+bounces-536288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC2A47DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C567A65A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67792556E;
	Thu, 27 Feb 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai+aQIgS"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0122B5AA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659477; cv=none; b=jpprej4vbrjn7EKlfugn1zhFQ6SGdEo74cmljboMGpOlURsOcavZVVEe6Hj1rF7YWeeyddZArDX6zxyh75HymFA9wtxpXZjAzbsEuNjj7apiOl7+psWTJ4+yjXA0vgWS1oGpbF89ChymGdZ8aDiLPsmX34MEJ9ByMoVHSGLgEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659477; c=relaxed/simple;
	bh=OF9d9Xw2chGq+fI/tUuF9Riz15GL7WzaT8vimaxqB0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWCo51OKUbKzdfDE6YrXxZe2eJJYyjVrhfplHMp+Y/EEc36Anw2o37kDuhUOmY6UzrxSN0HWER1xFFtC5aYDK2QthP/eBbRmBqz4oqGVAIosySEtPqaWv5klhFcE4tj8EHHSYVEa1TxG8/msbl45XHqQzllfFffKMPTdoau5ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai+aQIgS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso9553091fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740659472; x=1741264272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NuDSlH5bWdWCCj3eR6L4bKgFXpdLGlQnszPv5WTwUo=;
        b=ai+aQIgSRIMnnl4zWE6/PS66cnK0HgGRFiRgu1Q0kv9TsOVWDcAFxh3pAxg8DNg7tV
         n11Vdc9s2eV2ud9ZXGVVnfQHq56+FynrZMZSc192wobKjFah2+CsXbCRUYbueh1Wdmob
         g0AqSvEtOeFaHpFCaqvEI2Q7E6245oQHtbFli/kQug4/jn5aCT/MRUKGE9rh4K6dELSV
         0qEQbZiRmiQr3UURGhx53H/Kw3icC8/zy2vqjW9kyQ/Ji6cUXVXtG/sxczTfT3MDSdtw
         GlRrzfYTGWIFF1otX+MTEckrOoNWi6ctw0jcA9ds/YiygMqyfFWXEnCVC+5468sarmo6
         YEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659472; x=1741264272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NuDSlH5bWdWCCj3eR6L4bKgFXpdLGlQnszPv5WTwUo=;
        b=rG5iXlmkF6l53ahjoJlM8I82c2pXIPBjjEliPfYnno6VHmhlcxi9uK4pH1DvZ9MXXI
         U0f079AjWdkvrjdL51gHEId+t1nx+FD5C8ZsXmGkMGeyMRJhyRqJXqhb0ftHRAMNaUrp
         Pe7Ax8tsboqMiF2OV+g25JW9XUVTpLxewrAETzGGSmn5Szzo19rLqKzH+8h6ugkSBt7m
         iCTpINFZm0m3B9TT/6tBRZEnFwVwWbXYTE4yujzXFRenfVVd56PMaS2eRc0IjUUVlTIX
         YPamoB8OugoSykqHszAyA7+toT/PB0lWDf1Qmu84z6LtzeyWitc5ilPvnK0a0BrkTF71
         yA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcTLrrTG1my2EtcdsGpNy9taK7psbey+JaiC55tdCemmu+SEqZYn45A1Snx6NajmOZrDx60WBymRPaIYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YympdAQQ57J8UKx8v3+RVSWn8I4N/L8YbwTPjcZDHC7mDwVKwZa
	geRpKWZZ9MEoVWNthmX+dF6sNS8xwcClaMTxF14BQz1UmzC8tvwqDGTJ7oWZjWDYF2kp13uLUdK
	eW0itmQYVU0Xf4d++G3l0S77TEi4=
X-Gm-Gg: ASbGnctCiClByyEj6/12YK3pLmM4O7phgNezs89JZoLM83aatUTlk55GJGloM4lUI8G
	sgis/DeWxHVIY1bLO82tXpTUHlo/x8Z/SjPn0VBdrWxmcTQ00BM4H+GjF9kRtMqKleRLidOWY0A
	mRYVxqkwE=
X-Google-Smtp-Source: AGHT+IFA+JUu0Nm0k77iFYtcMeuiGL1tnKRpRv0ru6PtXDtgHaQNBRS4Lfit8SzX6SiEOpp7Uvmd8U72sGU2u2Z57fI=
X-Received: by 2002:a2e:8650:0:b0:308:f75f:446 with SMTP id
 38308e7fff4ca-30a5b215226mr95456301fa.31.1740659469954; Thu, 27 Feb 2025
 04:31:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213190119.3449103-1-matt@readmodwrite.com>
 <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
 <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
 <CAFULd4bwLyGiJ87fvT+N06ANchEQ0aGZdLvT-U3C8ROwCADr4Q@mail.gmail.com> <Z8BY_AZPQQm0BJTu@gmail.com>
In-Reply-To: <Z8BY_AZPQQm0BJTu@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 27 Feb 2025 13:30:58 +0100
X-Gm-Features: AQ5f1JpUpyARViJ28cpgRIodHDPE9I6UFB9_26VS-jJG6Vp8VD4Lv3KgVGlbJW8
Message-ID: <CAFULd4aCBMXcco_GdTYu9Zmc5A6+Z=J4XrsjLXWe1dydRD0oDQ@mail.gmail.com>
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
To: Ingo Molnar <mingo@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>, Jakub Jelinek <jakub@redhat.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:22=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Mon, Dec 16, 2024 at 5:20=E2=80=AFPM Matt Fleming <matt@readmodwrite=
.com> wrote:
> > >
> > > On Sat, Dec 14, 2024 at 1:17=E2=80=AFAM Uros Bizjak <ubizjak@gmail.co=
m> wrote:
> > > >
> > > > Does your config include CONFIG_UBSAN_BOOL=3Dy ?
> > >
> > > Yes, it does!
> > >
> > > > There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_B=
OOL
> > > > (aka -fsanitize=3Dbool), reported in [1] and fixed for gcc-14.2 in =
[2].
> > > >
> > > > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736#c42
> > > >
> > > > [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115172
> > > >
> > > > Otherwise, please attach your .config, and I'll look into this issu=
e.
> > >
> > > Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot=
 again.
> > >
> > > Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?
> >
> > No, this is a very rare Oops that triggers only with gcc-14.1 version
> > and only when both KASAN and UBSAN are enabled. This is actually the
> > problem with sanitization of the percpu address when named address
> > spaces are enabled (IOW, sanitization of __seg_gs prefixed address).
> > UBSAN creates a temporary in memory, but forgets to copy memory tags,
> > including named address space qualifier from the original. Later ASAN
> > sanitizes this location as a normal variable (due to missing
> > qualifier), but actually should be disabled for __seg_gs prefixed
> > addresses.
> >
> > Your report is only *the second* since sanitizers were re-enabled with
> > named address spaces. gcc-14.2 that includes the fix is available
> > since August 2024, and since sanitizers are strictly development
> > tools, my proposed solution would be to simply upgrade the compiler to
> > gcc-14.2 release.
>
> So unless this is difficult to test for, it would be nice to have a
> compiler version cutoff for the feature. Especially if it's been
> reported twice already, chances are that a lot more people have
> experienced it already.
>
> The kernel build should avoid this known oops automatically.

The patch could be as simple as:

--cut here--
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 95ea2b4b95db..c94c37889917 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2370,7 +2370,7 @@ config CC_HAS_NAMED_AS
     depends on CC_IS_GCC

 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
-    def_bool CC_IS_GCC && GCC_VERSION >=3D 130300
+    def_bool CC_IS_GCC && GCC_VERSION >=3D 140200

 config USE_X86_SEG_SUPPORT
     def_bool y
--cut here--

but it will disable all sanitizers for a very rare Oops that needs the
combination of CONFIG_KASAN and CONFIG_UBSAN_BOOL. The fix is
available in gcc-14.2, released in August 2024.

Uros.

