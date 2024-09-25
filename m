Return-Path: <linux-kernel+bounces-339463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9E986586
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD71F24679
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D741537F5;
	Wed, 25 Sep 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgB/sXzr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5617C67
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284793; cv=none; b=nS/8IikqqI8QsnzpPAFoEijKrZCT627g9YDK1i41cKXa+BqSOmT6H7oPXcvS5sQ1xiqJOJkIaWh2xdC06cOLFdydCos34pn2MtOomHRGe4n2JmRTX0yC86F/y3C2xjQhg9jJquitCUuswbehT5lxcWkYlFQUl/YRnXiGwUeBzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284793; c=relaxed/simple;
	bh=d4IpwX5nlSO5cDGSa5aXj5jWaVcOOV64wkjcy4P3qPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4xvB+MGcMi/thGwmnRW41FuekJAjMFqW++LuwDUl4E8z5YkFG4Fuc1+AI/X6H0L5MMLgPlvL7OQSlFBBbiY0Xn54mIl/PWjUzXn+vqsIDNugd5ZXGoInwpl+GCGDicfjzsedTlyXUrqxqydJnEmxHtvv5Sh62tiT7edPtXbcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgB/sXzr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d60e23b33so12640266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727284790; x=1727889590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYs3lutzoSncSJnmfL88IPhJU6GFg8JSR7+JveJBSXw=;
        b=AgB/sXzrTEwLK7GjsG8swbFM3Rm+0BDxm98LCE8iZw1Q+6C6zxO4ISePTDj8/EJ26k
         tT8Nk4oFKxFZCYF0XK5CcM6YVlX+Zjvprxz2PbVhFoHXKdzchNfkTo1UMZNE3iFz/KQR
         wz2FVDgyGi/Ma1QYJvndB9PgKeBedGUmOdyMyjAhunVcNYTCt9JdOY3JT8qzsdnFt12C
         cN+RzVlRFoWX434rQUY/yvJEskg4Gpg+ymAA8cEzz5rpE+DTIyKBZ1L65ktpPTdpxXLW
         g7iPB5DHEY4tS8FzCjCOfMiw2YvPNzr0HS5IHZszOmb8JhwV11H/1kaMM0duei5ZFXX7
         dWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284790; x=1727889590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYs3lutzoSncSJnmfL88IPhJU6GFg8JSR7+JveJBSXw=;
        b=EMK7yzejd1SflFe7kCLZbUjTTYDK4hlvqhb+bf15AU4WnIgz0IrX2RA9HSqhKKI00F
         DS1PaPBeov/YVe2hUonrk5/7Ym8YmQdVKeerGGxW/JAfOq77MFIzRlZI9EtmXOnTxj7c
         xPI59wskEVW3ZeLC6/hQ+oVL5aOF/KvpRxwFNu9QEk4DDB2R1ZgwsNoTfL3K4x9+lJ11
         6qqHmGR/QChbYuXukVPDoPPws0vU6PZQMZMzAAVuRwUq6X3vWRTBs17oS34BV5X0/5+L
         GGinSsQSET7p+4frbFf+e54fa4gK+tewrLh3twnctFSXidikeKmWEmpubetzZfgujqXJ
         Vgwg==
X-Forwarded-Encrypted: i=1; AJvYcCUbYpdZDcclkZvVelrnQ2UXDGP+5yrs6P+zPPZJ3uIGIGrIPrvu8RRHSxxd1LpIiJhJ1iAld8vgVqYasRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSR3KFXWrXuZJ6N7Er7GiM+1D5htxTcD7wzuBDmecmo1j7nnFU
	KI93J5d3hlyqud7W1+bQ3FTfCHQ6kYlLHoifXxtOJBV20TB2+dzFnP0uoSvU6+3eQihtgcxj5/V
	SzbgoPEY0bCGVfSMoQtlHv/aMJQkhjDGmOew=
X-Google-Smtp-Source: AGHT+IFyn2mf1UVSsCFu8lWRGIXgqLCKvYnu/Kas1apOkizFMWiUjPIRa49FBbVRGqjAVy1cJ0Y6b9lKinYOCGiAhJI=
X-Received: by 2002:a17:907:960c:b0:a8d:2faf:d333 with SMTP id
 a640c23a62f3a-a93a03c3fc1mr300475966b.35.1727284790060; Wed, 25 Sep 2024
 10:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727191485.git.skhan@linuxfoundation.org> <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
In-Reply-To: <4f3a0acd903aeee52fb71acaec1106d513a2e88b.1727191485.git.skhan@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 25 Sep 2024 10:19:38 -0700
Message-ID: <CANDhNCoC50Mhyo19O2drqXU7g-3j+wkFteTyi1jg1_5pCyzwYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests:timers: posix_timers: Fix
 warn_unused_result in __fatal_error()
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> __fatal_error routine doesn't check strerror_r() return value,
> which results in the following compile time warning:
>
> posix_timers.c: In function =E2=80=98__fatal_error=E2=80=99:
> posix_timers.c:31:9: warning: ignoring return value of =E2=80=98strerror_=
r=E2=80=99 declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-W=
unused-result]
>    31 |         strerror_r(errno, buf, sizeof(buf));
>
> Fix this by adding a check for return value and error handling appropriat=
e
> for the GNU-specific strerror_r() in use in __fatal_error(). Check if
> return string is null and handle accordingly.
>
> From Linux strerror_r() manual page:
>
> "The GNU-specific strerror_r() returns a pointer to a string containing
> the error message. This may be either a pointer to a string that the
> function stores in buf, or a pointer to some (immutable) static string
> (in which case buf is unused). If the function stores a string in buf,
> then at most buflen bytes are stored (the string may be truncated if
> buflen is too small and errnum is unknown). The string always includes
> a terminating null byte."
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/timers/posix_timers.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testin=
g/selftests/timers/posix_timers.c
> index 16bd49492efa..ddb1cebc844e 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -26,13 +26,17 @@
>  static void __fatal_error(const char *test, const char *name, const char=
 *what)
>  {
>         char buf[64];
> +       char *ret_str =3D NULL;
>
> -       strerror_r(errno, buf, sizeof(buf));
> +       ret_str =3D strerror_r(errno, buf, sizeof(buf));
>
> -       if (name && strlen(name))
> -               ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf=
);
> +       if (name && strlen(name) && ret_str)
> +               ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, ret=
_str);
> +       else if (ret_str)
> +               ksft_exit_fail_msg("%s %s %s\n", test, what, ret_str);
>         else
> -               ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
> +               ksft_exit_fail_msg("%s %s\n", test, what);
> +
>  }

Acked-by: John Stultz <jstultz@google.com>

