Return-Path: <linux-kernel+bounces-328955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CA978B70
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE6A1F24014
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A37148308;
	Fri, 13 Sep 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCydffo3"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAE13BC35
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266834; cv=none; b=e5duhtcQnFxr7khPCGMEnGmoGNVsp38CR9E4d9R2bXgNJ6c6xONNt+HAkDY+vSZPXtQGZZ7WMBtDk1WjchAfTqvsOLgup4bO+7vGz1ZqArVJu1xCRFheix6X7nG+5AmsdPfrYX6w/Bob1o2Gaj9vdX1s6ELb53QyVl/JYL8ODxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266834; c=relaxed/simple;
	bh=U1NroKr0HA7CbvYhIRp6QGqZlDY9h8+cRjm0wX0Ld0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb7I7YLReR7ZmT+x1KMoCF8hqYoU3yAmWM/VbaIBefBMuDhB38OSuMzkjqkbZ3Qpf3LPaFjPeFRb15IWsFbEzZ8TVRztXAkHbPpk0VpjcgcuqIQdC2yxq9psrTT/p15LheLt8HW6JauSUTwZ6RsVaPGqWo1XAE38WP5dRBeIpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCydffo3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1d7421d14so109407eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726266832; x=1726871632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR+aFVWTVq8CbCarFENk6QxpMqmR4IKiYC+//JY1HWs=;
        b=LCydffo3Ahdeh+wUDqj9HWcDSBv8dPoRSKM1pN7d8sx0CGMT4dj53oFP8zVT9jv22+
         tP9k9PuECqQ3H34RpXKVEc+36J7i1jbezFYo55ZaLIb3bA5Am5BWEk5A0RvvvsTSN852
         fh0fZKjaNozRhvQLGwZtsGVJq2rhS6lt1R4Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266832; x=1726871632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR+aFVWTVq8CbCarFENk6QxpMqmR4IKiYC+//JY1HWs=;
        b=DFt56VYw4VcUI4n3pwDidnF7PrDTTxICmvSGWZyYbAGCgQH3gJW/asisqXhc7LHy30
         Qluw9OFwmoTxpkwpKlynNpG5gfLiWT+6LkL44al2cUZ0N1cY4b1j7FipYn00C+qlDExW
         oSwSUisALrtyX9rNdqCie0NiODkQC7TYxGJsYhCBX8xiqg4tnMKjYOgebxs3siNUFsoD
         fZXIZqTZARXbzDgnPrtY14XQaWgBaMvYM8cUuNs08S+DjFqrhA5Z4XSR9XSXMHewbKy3
         vYnzv8O9QgWySfsN410iFlff7BjwO87oDye5lbcXD4+Rd6uuW6RAUk2Mh8EudzpgoOUU
         +KAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVMrAFvZLNMLDOl4bXNDAaevtGvPhkM/1WoesfKbbnWryMQaeBzUdGjVZ2sBSR4FBVGQzaAKJ5mkeKKww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dmTn3GivHwQUxCSo+Yq9fMoO7R452UFRrebKirfwVv/KiWCc
	xymkifokzVqTr8KPv2DogmnU0hCKRLBixXjeDM/JtmRmjqSpMWKanLmEDgnnjLDEOL19HCew/Nt
	AExH9Sv/DdNc3u605QDgKCLp6iIJ6B9P/JfBv
X-Google-Smtp-Source: AGHT+IHoRn8wPvaGm0XnG3869dlzoogkjY3U7o40PCg3lnku1IuTJCyxK495TTkFeC7nabla4nDYmkGBplV0McjYN34=
X-Received: by 2002:a05:6870:65a4:b0:27b:9f8b:7e4a with SMTP id
 586e51a60fabf-27c3f694c07mr1516649fac.12.1726266831574; Fri, 13 Sep 2024
 15:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809082511.497266-1-usama.anjum@collabora.com>
 <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com> <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
In-Reply-To: <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Sep 2024 15:33:39 -0700
Message-ID: <CABi2SkWk8igT=HCTcawv72uxrf2rhzj1A23k4EixCxcDKhSNxw@mail.gmail.com>
Subject: Re: [PATCH] selftests: mm: Fix build errors on armhf
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, kernel@collabora.com, 
	stable@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:05=E2=80=AFAM Muhammad Usama Anjum
<Usama.Anjum@collabora.com> wrote:
>
> On 8/14/24 3:29 AM, Jeff Xu wrote:
> > Hi Muhammad
> >
> > On Fri, Aug 9, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> The __NR_mmap isn't found on armhf. The mmap() is commonly available

What is armhf ?
is that arm64 ? I was able to build arm64 correctly.

-Jeff

> >> system call and its wrapper is presnet on all architectures. So it
> >> should be used directly. It solves problem for armhf and doesn't creat=
e
> >> problem for architectures as well. Remove sys_mmap() functions as they
> >> aren't doing anything else other than calling mmap(). There is no need
> >> to set errno =3D 0 manually as glibc always resets it.
> >>
> > The mseal_test should't have dependency on libc, and mmap() is
> > implemented by glibc, right ?
> >
> > I just fixed a bug to switch mremap() to sys_mremap to address an
> > issue that different glibc version's behavior is slightly different
> > for mremap().
> >
> > What is the reason that __NR_mmap not available in armhf ? (maybe it
> > is another name ?)  there must be a way to call syscall directly on
> > armhf, can we use that instead ?
>
> It seems __NR_mmap syscall is deprecated for arm. Found this comment in
> arch/arm/include/asm/unistd.h:
> /*
>  * The following syscalls are obsolete and no longer available for EABI:
>  *  __NR_time
>  *  __NR_umount
>  *  __NR_stime
>  *  __NR_alarm
>  *  __NR_utime
>  *  __NR_getrlimit
>  *  __NR_select
>  *  __NR_readdir
>  *  __NR_mmap
>  *  __NR_socketcall
>  *  __NR_syscall
>  *  __NR_ipc
>  */
>
> The glibc mmap() calls mmap2() these days by adjusting the parameters
> internally. From man mmap:
> C library/kernel differences:
> This  page  describes the interface provided by the glibc mmap() wrapper
> function.  Originally, this function invoked a system call of the same
> name.  Since Linux 2.4, that system call has been superseded  by
> mmap2(2), and nowadays the glibc mmap() wrapper function invokes
> mmap2(2) with a suitably adjusted value for offset.
>
> I'm not sure if behaviour of glibc mmap() and syscall mmap2() would be
> same, but we should use glibc at most places which accounts for
> different architectures correctly. Maybe the differences were only
> present in case of mremap().
>
> --
> BR,
> Muhammad Usama Anjum
>

