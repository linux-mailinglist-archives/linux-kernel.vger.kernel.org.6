Return-Path: <linux-kernel+bounces-549650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E9A554FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADD116960D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B625D541;
	Thu,  6 Mar 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="KXypKuu3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE719D07A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285824; cv=none; b=DJ6u5uNVzw2iUNzEGQY5h5cCMHQn5hB9Uz8wBtnG02iONOM1GQKMotOlPPErn04F4tbF18klU3FK7vIMjT7I9wnEyLzPLFFa11oybS+nR8jSE/Sjh+D1uitgi44ihZ/ksNWtP2r7wUouk/79hpUVGNRm5Sc7xO9M0efF6ZFnAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285824; c=relaxed/simple;
	bh=mtkkZRnb3QLswP4ydiPCslDz36MawM+f+fLjr8+Ebd4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YPp1hNQxe1ddUQPRRxZQQ5oPR2JYLMibZ/XJ47CE6DvdDKedTCeZu+ZPAL9fi24llmbWBA4rCgJCen04kc4HkKNlOFB68XaCiZowAovyZ0dW4mGjwoxTr8Ky9sWPAAH3mfBNpSqOvORB02QH8TYUReBepNUztgfOhXrE8VPCeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=KXypKuu3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390eebcc331so681821f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741285821; x=1741890621; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPCEqaMTT2sQzMB8Mq+AK33JFTreikwE+NAyimZeTB8=;
        b=KXypKuu362KrjUGmax0l2m8cRCjiZSFhQozcwjO0HK/KXoEgdL+r5wvHj3jk5xr7r0
         f1jPk3BtR67RqTZ/uWr8o3o3r/6dUvKL0CVHBXXgGT5soCAFVD/6BPfQby0PcFM+IRmf
         HlTYfTZbE/srOg+iPu8xqh9J8A50ix5SJr1b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285821; x=1741890621;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rPCEqaMTT2sQzMB8Mq+AK33JFTreikwE+NAyimZeTB8=;
        b=PaDvWAPOjEUgzJsiBZmSgwbq3Y3DFMiijsQXi3LL6ou6vqXw70dPPV4l9BC3yXco7b
         LJBsO37Oz51BLpRzVLMyWbBDkS/Y9b0oYssvhDcUW20yrvnWDj3s/W8UhpX/DJsybhHs
         C/t7AiQdgJQUGCjiukgjZ7Glfr7wbGB1ZrAJ7/3Tth8xzlPXtjZpSUxGYyN496fH0L/9
         6/eLgDsgB9Kn7L0UTBswqJH5dHjXm1oRsNJ37BEEoYBHA7rlkOG9M6PtoHcpA52LPMff
         KgHrfh1HILnyLG5HU4obtmxPZCVBGPdoO2BCZrwYdyFOAq7t+mtXqTkDTm141Sa3K34q
         cZIw==
X-Forwarded-Encrypted: i=1; AJvYcCUyoMHsqZEvMH/B51q7+GmKz2Dygy1XPZczWC91byqs/I4ELodVcus/KQlqFooJxoEawsaIqhY8fAqbPhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7McOCAGE8STZJ8M4px02MZ3o4CGHzAxPEdY81QOhMC86Gwyb
	yWtsnu1xc/Z8QgGD6UyuZSizYRdbB8Y3miqtm9XQYrhu4SauIT3hR0U0j8922Lw=
X-Gm-Gg: ASbGncs94z7mWUv1kuIDmkgPjJ7m+zzSNVC42f40zBBaDixfbqONVuGX8QRXge27VRl
	myMr3tLucIT2dRfck5mBs6LkEmI23mlV74+cwUZ91ZWh708T7TZiA24AEgr0W1CbPhyGHd8qW77
	HDXvpqXMQc1ZDRJFRFLC5uF0EOou/SKj7hcpEThrorb2HCZwjANWOk/Wur5CTEJYxzwpxoVsgmO
	h56J6J3SiINoGk/8JhyZL0fs1ROf/zDtlRFmOByTtIDNNO/Xdb1g0j5kFLRKNkFYfXmSzkbuogf
	T6t20F6nb+ZPSRvEKCal1S1CeaFJtlukOo9mkgkJ/VmtC0e4ijmQXJbHFaXbc7F8sQ==
X-Google-Smtp-Source: AGHT+IGZ5GAw/yJ9TSmMUvhxwM5ULlBFAfwpvd/941TRQqHjvjrPmUrPLnNR1dnWxJ5kNILZaCkYFw==
X-Received: by 2002:a5d:64a4:0:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3912982ea9amr3437553f8f.18.1741285820618;
        Thu, 06 Mar 2025 10:30:20 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm2749571f8f.82.2025.03.06.10.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 18:30:19 +0000
Message-Id: <D89EB2A6K6H8.SDEMLB4O6NMR@kragniz.eu>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Willy Tarreau" <w@1wt.eu>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
From: "Louis Taylor" <louis@kragniz.eu>
X-Mailer: aerc 0.18.1
References: <20250304075846.66563-1-louis@kragniz.eu>
 <8a1fc6ff-e36c-41b5-b959-2d667bb8279a@t-8ch.de>
In-Reply-To: <8a1fc6ff-e36c-41b5-b959-2d667bb8279a@t-8ch.de>

On Thu Mar 6, 2025 at 5:10 PM GMT, Thomas Wei=C3=9Fschuh wrote:
> On 2025-03-04 07:58:15+0000, Louis Taylor wrote:
> > openat is useful to avoid needing to construct relative paths, so expos=
e
> > a wrapper for using it directly.
> >=20
> > Signed-off-by: Louis Taylor <louis@kragniz.eu>
>
> Looks good. I have some tiny nitpicks inline,
> but if you prefer I can also pick it up as-is.
>
> Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

No problem, I'll send another version.

> > ---
> >  tools/include/nolibc/sys.h                   | 25 ++++++++++++++++++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 21 ++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >=20
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 8f44c33b1213..3cd938f9abda 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -765,6 +765,31 @@ int mount(const char *src, const char *tgt,
> >  	return __sysret(sys_mount(src, tgt, fst, flags, data));
> >  }
> > =20
> > +/*
> > + * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
> > + */
> > +
> > +static __attribute__((unused))
> > +int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
> > +{
> > +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> > +}
> > +
> > +static __attribute__((unused))
> > +int openat(int dirfd, const char *path, int flags, ...)
> > +{
> > +	mode_t mode =3D 0;
> > +
> > +	if (flags & O_CREAT) {
> > +		va_list args;
> > +
> > +		va_start(args, flags);
> > +		mode =3D va_arg(args, mode_t);
> > +		va_end(args);
> > +	}
> > +
> > +	return __sysret(sys_openat(dirfd, path, flags, mode));
> > +}
> > =20
> >  /*
> >   * int open(const char *path, int flags[, mode_t mode]);
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testi=
ng/selftests/nolibc/nolibc-test.c
> > index 79c3e6a845f3..2a1629938dd6 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1028,6 +1028,26 @@ int test_rlimit(void)
> >  	return 0;
> >  }
> > =20
> > +static int test_openat(void)
>
> As mentioned in my other mail, this in fact should not be static.
> Sorry for the back and forth.

Ah that's fine, I'll drop the other patch as well.

> > +{
> > +	int dev;
> > +	int null;
>
> Can be on a single line.
>
> > +
> > +	dev =3D openat(AT_FDCWD, "/dev", O_DIRECTORY);
> > +	if (dev < 0)
> > +		return -1;
> > +
> > +	null =3D openat(dev, "null", 0);
>
> As per the standard:
>
> 	The argument flags must include one of the following access modes:
> 	O_RDONLY, O_WRONLY, or O_RDWR.
>
> The other tests don't do it either and on Linux it doesn't matter
> because O_RDONLY =3D=3D 0. But if we are here anyways.
>
> close(dev) could be moved here for some saved lines.
>
> > +	if (null < 0) {
> > +		close(dev);
> > +		return -1;
> > +	}
> > +
> > +	close(dev);
> > +	close(null);
> > +
> > +	return 0;
> > +}
> > =20
> >  /* Run syscall tests between IDs <min> and <max>.
> >   * Return 0 on success, non-zero on failure.
> > @@ -1116,6 +1136,7 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); b=
reak;
> >  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp =3D open("/dev/nul=
l", 0), -1); if (tmp !=3D -1) close(tmp); break;
> >  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp =3D open("/proc/se=
lf/blah", 0), -1, ENOENT); if (tmp !=3D -1) close(tmp); break;
> > +		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); br=
eak;
>
> EXPECT_SYSZR() should work here.
>
> >  		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
> >  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); bre=
ak;
> >  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds =
=3D { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
> > --=20
> > 2.45.2
> >=20


