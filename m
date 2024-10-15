Return-Path: <linux-kernel+bounces-365583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A6B99E4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED031C24A76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B11EABB9;
	Tue, 15 Oct 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV0MAFmJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236C1E907D;
	Tue, 15 Oct 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989564; cv=none; b=eCzI+UfBFqt4awjhEfTU1j0sIPSbiK+JXy7VGqvXCP+Zcg2fmB42+8lX7yAdsSIqWhq2hYT2Wl6MGV61HLAZxkAOkn+tYk6w7Ks8cav75Ktjtj1Lqe9DylrSDMTrlvBgAqIX2r/cdbAQt+gFZI+TI67sQ6hKjAkfJAGN3KX5JpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989564; c=relaxed/simple;
	bh=yP9CszACK6W66/sJ4yrRaQAUlEJn3RPG/6aWepyCiHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYfRJBqiZSD3CCncU9sACX19E+zAfCYtWvvvdlLg4MejLtY4WKrChZD25gvaTXBkkIEAf/kvIm9tF6WsX5I8m1JJs86TAI6LKfY0SB9zBB+cc3vfhRU3LUWa8QZ+nNiu7T0luQGMtbozf/v83RmdtMUgoadS1M9+p8q9KhX4MqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV0MAFmJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7912279a12.3;
        Tue, 15 Oct 2024 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728989561; x=1729594361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miCofaLTCliOiaggNDs4P5r/0poFiwum/y0l9beo+ZU=;
        b=HV0MAFmJaB59oeGlt5WAZDVBAu/N9kQD9sS0m459QnKiG/v9gczzAW8swrIZdYnUHv
         CNJaywA95ue46RNzkjhtT4yZpFjfR/P+SMqElq6RpDqV8xKxdX767IQfx8KYrmAFiYq6
         tSCsnLSfGsGoxmbb4cPAsNIAkXdRj0OF6fuklOH6Zh3a6nLZR8PF8EN+i5Sy8Rr6++U7
         m8FCNY3T+GsSKl2f6OQiJ7II1MH4gD1UFllV0Yue+DVpGADy9exMAFcC48xZAH0u0b+H
         hRkl6RnrxxOGarYgixAoUmx1425iA223jpew++PrbNgc2Vpa2YwscZEuyHRftpBaaOjy
         OPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989561; x=1729594361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miCofaLTCliOiaggNDs4P5r/0poFiwum/y0l9beo+ZU=;
        b=gtC+/LqGbMNvwHNguTqqSCgudez8M+fkOJrfaVpYuQzNxohBdNMYEw7trJggtS3ZI1
         tWXRdwDJ9vlhUfU0myRaw+7oWIjnpSRUqpu9xlJK91rkOQrGSPdsmsEAJMoB2hI40Xlr
         RVS+MwKWohx/p/x6F4mlgp+PIjCqtsyEX6p1q1d0odq3Ktiiw4IVbr/bx3iQrZ2sRgq0
         v7/wFowuv+/THHEfnEAUm5VF0NVsNhzlSOueJgPwS6ofG2hNE1nhztLLc4blZMMBe9BB
         NS8aH+hvbaPh20DnL1GDFbKbT/yv8CyHou/WmAXRl5FWl5vZW4veLmE/yU3l4/2H2Kyr
         3dkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVjQBfzFhJfvmJ96sLtn1BvfJD1EnDYJ1U2rKgtKw1IHFQKJC7jnNgi9PXKBp0XLVCwJR7EBoaGB7hN/U4@vger.kernel.org, AJvYcCUlc6YjuC2VVsm6dJ1ibqOJeY76VRUa2CSzCsvBjqdOdarF5BEi/O/eNLLDKEGRC6qrVOhwVBazdo0=@vger.kernel.org, AJvYcCVbXPQVfzIVmwSRjdh0z3ynwTRpSxoFTib18FBYcG9BT8j7K3CUG6bLwmTiB3jg1PgXSfbOYe/xZ9Cw@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4NnCH+V28KyeOMn4wkjfCwy1VKQOtcdkuj7Ta0Hn2dDwIltR
	xX07s+8BHlKHX4bkWxME05huQTIPU+nON61KD1gpD7+kHnUKMxgzCnB5A+AUnTyUlYn9NBgWkOQ
	2mwNWm/ILvj6wilv8ORYbD1wtd+I=
X-Google-Smtp-Source: AGHT+IFk7BXffNv4e/2AjFYfCrgZ4ShdR5CLjDEp47QaCgk8TG/YKWt1pCpDQM8SNHkK1aqMaNGsGE8gyTU8KU9g23E=
X-Received: by 2002:a05:6402:5188:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5c959e6f56amr9476072a12.6.1728989560452; Tue, 15 Oct 2024
 03:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
 <20241014025701.3096253-1-snovitoll@gmail.com> <20241014025701.3096253-3-snovitoll@gmail.com>
 <20241014161042.885cf17fca7850b5bbf2f8e5@linux-foundation.org> <CA+fCnZcwoL3qWhKsmgCCPDeAW0zpKGn=H7F8w8Fmsg+7-Y8p3g@mail.gmail.com>
In-Reply-To: <CA+fCnZcwoL3qWhKsmgCCPDeAW0zpKGn=H7F8w8Fmsg+7-Y8p3g@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Tue, 15 Oct 2024 15:53:35 +0500
Message-ID: <CACzwLxgJaOL9RXkhAZEosmFDzp-D4=gGfhSh3d5scBRBaq76pw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] kasan: migrate copy_user_test to kunit
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 2023002089@link.tyut.edu.cn, 
	alexs@kernel.org, corbet@lwn.net, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	siyanteng@loongson.cn, vincenzo.frascino@arm.com, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:18=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Oct 15, 2024 at 1:10=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Mon, 14 Oct 2024 07:57:00 +0500 Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
> >
> > > Migrate the copy_user_test to the KUnit framework to verify out-of-bo=
und
> > > detection via KASAN reports in copy_from_user(), copy_to_user() and
> > > their static functions.
> > >
> > > This is the last migrated test in kasan_test_module.c, therefore dele=
te
> > > the file.
> > >
> >
> > x86_64 allmodconfig produces:
> >
> > vmlinux.o: warning: objtool: strncpy_from_user+0x8a: call to __check_ob=
ject_size() with UACCESS enabled

I've missed this warning during x86_64 build, sorry.

>
> Too bad. I guess we have to duplicate both kasan_check_write and
> check_object_size before both do_strncpy_from_user calls in
> strncpy_from_user.

Shall we do it once in strncpy_from_user() as I did in v1?
Please let me know as I've tested in x86_64 and arm64 -
there is no warning during kernel build with the diff below.

These checks are for kernel pointer *dst only and size:
   kasan_check_write(dst, count);
   check_object_size(dst, count, false);

And there are 2 calls of do_strncpy_from_user,
which are implemented in x86 atm per commit 2865baf54077,
and they are relevant to __user *src address, AFAIU.

long strncpy_from_user()
   if (can_do_masked_user_access()) {
      src =3D masked_user_access_begin(src);
      retval =3D do_strncpy_from_user(dst, src, count, count);
      user_read_access_end();
   }

   if (likely(src_addr < max_addr)) {
      if (user_read_access_begin(src, max)) {
         retval =3D do_strncpy_from_user(dst, src, count, max);
         user_read_access_end();

---
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 989a12a6787..6dc234913dd 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -120,6 +120,9 @@ long strncpy_from_user(char *dst, const char
__user *src, long count)
        if (unlikely(count <=3D 0))
                return 0;

+       kasan_check_write(dst, count);
+       check_object_size(dst, count, false);
+
        if (can_do_masked_user_access()) {
                long retval;

@@ -142,8 +145,6 @@ long strncpy_from_user(char *dst, const char
__user *src, long count)
                if (max > count)
                        max =3D count;

-               kasan_check_write(dst, count);
-               check_object_size(dst, count, false);
                if (user_read_access_begin(src, max)) {
                        retval =3D do_strncpy_from_user(dst, src, count, ma=
x);
                        user_read_access_end();

