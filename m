Return-Path: <linux-kernel+bounces-369076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5A9A18AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446A01C2229E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565E4EB50;
	Thu, 17 Oct 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0AOFhFg"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797A53E15
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132730; cv=none; b=V+JA+cPEG00rNGYUA/kJqp7r+U42tRVj6egyuO3PN+ALAeh6mGY8c5TMiClZZ1KuXO3rPtyLh/TwBFWSZDmrefhfpgNOOSoHPI0BaKHN+JPQ/ecc8U9VnsWvkZNgr2H/f3oENwtBDus145amLmk+Qq8GRlC5nA0voEg0fVW50bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132730; c=relaxed/simple;
	bh=MFbE5/HxNE/3MWJa6C+tGfnobv5hU4G4+lDi6051zRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYdOvLn/zwAcBJgz/AuQ2zG7fI/Mpv8wmF2cqdyyak0WaLBY6heICgI3bx5YkYOW830P6wHQYbDEoNMEqNJ+LKt2lXp5zHfYBZU7ORnsimgZg7QUDsI8YlnBpr7b/kA7TLxRqEVLNcr6UsbvMVLrKPTq00x8Busi1FhHjOEikAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0AOFhFg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so13566a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729132726; x=1729737526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyoX/VXB6kRQ5Z5Po0ZyyQ1eAQYC/i5UR7HqsdBY26Y=;
        b=g0AOFhFgE3cM49cGnYbYs9oIC/QY/DnenJiLakXKwgo54jg2B1ajj8ipFwGR40CYj+
         2NHPkoLx3TGNbxyiZTCoZu2pYINAxDsOswxGrF8IOP7MW53hXr7Z6yVkE+DC7LczTWI/
         0LesZYEIDMiEJN+sW9Dp7LCpklFBcxuOSL+IXaHMMkaVKkxqWIoSh51ULULDq0PI74c4
         XMOuwW82b3Lu0mmrZ6sycuDy7x1nwNQ0vvHpkxxxTByVtogkiui5pO6IccjpQtgloThy
         pfX4hn0P+gmRooWH2SuCGYKJVW0hRWF20c7kj1Y0J3DbT44tRwVQXyv9TunxVBHWQeVy
         pTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729132726; x=1729737526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyoX/VXB6kRQ5Z5Po0ZyyQ1eAQYC/i5UR7HqsdBY26Y=;
        b=Xchs4mjLwl8k9d1jBqhIen4eeEYKcf5I/pEhiB/tuAfnytA8/Wc398p6Sen+afyyVv
         OFyjJDGW+PUdo1tHv4vP99hI2B96Uo3bacG1z75POvfWJrk7iw13ZrQcwmp3bLUVhz+j
         x4ef1rhpIEglvNTZ83EpbAkZhtKujh5YO0yS53PBsx7LUHC/u75aIZbXxp6RXADqnmYM
         pQBLrDgoAJ+E2JA7ofmDcvspqz1jgdCUCacwclIwtZZDErdq3ZnUGdqfVDlMDZvKaty7
         kHnFkMxNPFPstmu6+gW5qZ3HfdUYQzqBt+FOw1/26MfKQR/2S2J+nbQCz7WSQmYuNvxK
         f+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0YZXwgX3FKO4kBtiLUKhezHmTZSIntpJyQFeIfUbiK5qzVaHak1RNrWcPA+0B/QgjIEqwoXqeHJdiPwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhw1PESg+lRZaE2sd76mVUBXYnXaIrnhk+oElfNpo20iWFi1ui
	nhiQBtzPlDhrxiOmq/JYX2SSi3HWJDjjeGLyE+f1h9dxgpQlEz0XDNFaLLo38uJuKZEOm4A9w4U
	gAmFnWVmQC5P0p+3nYWeJdrF8qsmBGIgHO/GZ
X-Google-Smtp-Source: AGHT+IGOV3tbbxDMxDfkL5dTKHJ47DuzvRwXqoEqBnSc9W0BsLddUP4XNhaEM2ZgUZfm9d/AKVluzoXHH1/1goEuskU=
X-Received: by 2002:a05:6402:5107:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c9ebb55cf8mr149642a12.1.1729132725983; Wed, 16 Oct 2024
 19:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017022627.3112811-1-jeffxu@chromium.org>
In-Reply-To: <20241017022627.3112811-1-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 16 Oct 2024 19:38:08 -0700
Message-ID: <CALmYWFsnx+QvkqLyYRSBW1ueJonEJeXROq6UM7Bbktn3bu+PMQ@mail.gmail.com>
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, deraadt@openbsd.org, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:26=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> It appears there is a regression on the latest mm,
> when munmap seals memory, it can cause an unexpected VMA split.
> E.g. repro use this test.

It appears that this test has some dependency tests that haven't been
merged, so can't be run as is.
This is the repro step:

- Allocate 12 pages (0-11).
- Seal middle 4 pages (4567)
- munmap (2345) - this will fail

Seeing VMA for page (0123) is split as 2 VMAs (01)-(23), those 2 VMA
have the same attribute, and should be merged as one.

> ---
>  tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index fa74dbe4a684..0af33e13b606 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(b=
ool seal)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_munmap_free_multiple_ranges_with_split(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 12 * page_size;
> +       int ret;
> +       int prot;
> +
> +       setup_single_address(size, &ptr);
> +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> +
> +       /* seal the middle 4 page */
> +       if (seal) {
> +               ret =3D sys_mseal(ptr + 4 * page_size, 4 * page_size);
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +               size =3D get_vma_size(ptr, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       }
> +
> +       /* munmap 4  pages from the third page */
> +       ret =3D sys_munmap(ptr + 2 * page_size, 4 * page_size);
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(ret);
> +               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> +
> +               size =3D get_vma_size(ptr, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       } else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       /* munmap 4 pages from the sealed page */
> +       ret =3D sys_munmap(ptr + 6 * page_size, 4 * page_size);
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(ret);
> +               FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> +
> +               size =3D get_vma_size(ptr + 4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  4 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +
> +               size =3D get_vma_size(ptr +  8 * page_size, &prot);
> +               FAIL_TEST_IF_FALSE(size =3D=3D 4 * page_size);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> +       } else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       REPORT_TEST_PASS();
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>         bool test_seal =3D seal_support();
> @@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
>         test_madvise_filebacked_was_writable(false);
>         test_madvise_filebacked_was_writable(true);
>
> +       test_munmap_free_multiple_ranges_with_split(false);
> +       test_munmap_free_multiple_ranges_with_split(true);
> +
>         ksft_finished();
>  }
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

