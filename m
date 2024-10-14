Return-Path: <linux-kernel+bounces-364061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8599CAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB75A1F226AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B881A727D;
	Mon, 14 Oct 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA3wHvL8"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24713CFBD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910201; cv=none; b=WqEmY6gowLplNag9WhXXeKo+YPUggbipkAWEOO7vZDdK+9MKhNKY5f8WM38wYOXap8BSfcjuqW7icbQ6MXu6kZMtqCsKwpcZWQvS91LyReJBpWaVnHyMg4Gqa0Wuso32DevmgyFHZjqvGBDOvBqWVbS2G3QmDhDBhpet4Uqw+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910201; c=relaxed/simple;
	bh=gOlnLK37eJMZEqR4kOlTrArqZ8j80+3y6ssaYcP9gRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEDPrLHKsh2XgJysGQdsVNKqGWeBBVgG4dwiijtQtrgywFtSmZ/MR6OFHs8bBY2lfM3/bwudNRccBtHqU6kp13N11X8AcOAqNow7FVX71h0mCEHST8Q9wyyjhTo825UrTuysTgXQtloMgY0MVbZ9ltiyJUCWW57xCnShDp/pO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA3wHvL8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d3ecad390so3350683f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728910198; x=1729514998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf/5MkNv+WtzfCbJoY+JemC4YRAIn9jKsl/phx7FKjQ=;
        b=IA3wHvL8MpMIu5tsFUfu1xf9CR8HbQafSSPjBHKF1wG0js0QvZq5d9B3sUjpYCW+Qg
         K/E1xiETOZXDDCoUHSYNMUFbUktqz1DrRa/AVIMU8UN6D49cYz67dt+K1iRjtb3IhPct
         DySwZ9QRtnKz9OLgXDcfmMNxSFIr/ASryp/BdOf2FDTFpPAwEDgw9EsOOM8u4sKybpvT
         R4c6ISZJL2VUpc2nFtWaKRPTbAtfdrC5yi+Nt31nUkueduk0Ss4qtAb/KK8vlIsX8DpW
         LOXsCgIfLK8Ok8C3xdsIhIJMZNGRtQb6YB8wqfytf63QQz8YbWgOZf8iAtQJjoAuINsW
         I6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910198; x=1729514998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf/5MkNv+WtzfCbJoY+JemC4YRAIn9jKsl/phx7FKjQ=;
        b=YLAZIOvx37+AMS1bmgflNTUV2eI+mvVFa76uECvGDwI/qebyhrKXBccxX5r1sDs9tu
         WzA5guJEfd2/83EG3FGXVuxWHWdQUjMVjo/C5XqqW37HowlhZwIOWHC/ziV1D3dst3xu
         pe5tC9eG49i0TMceQ6Blx6l9mvjaneoOunguEW1hrr0zikOXVFfRGOVdEy6R8T5jd8kG
         1jHo7fU0aiEALil05OPehP5zKAoD5z3oJUrKEfff6ZOvsDyvzhrqP++qca9AQfvbR3IT
         GEq96Bl2LEM3tWAaX/XAvVTEEnkkn/K7VrH1rvpHecVE8EMQ2fDJpaEg0WHhSK8o8a0e
         j+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmhH7Ybitrbw5OnXEPLYxwmyLk/L1vt+bwL1Z4uJJ0Gvp+HA8AnwrGfnBHF62jBaMt1Y48Z/dWW4Vr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2eavSXa/cTCLbbnRaK9Qdl9/oofMec+iH2oBJQmqyT0CtAk9
	NQI4Owc3ENnxOet5TbqaHQrLjkE73B60px4G5cirDF3tFx2T0bP+NOIH2xkIdckstjq8uY9SAab
	r+QVc7vGUbXIvH+6rVqLriitsSGE=
X-Google-Smtp-Source: AGHT+IF4mSkUt9OHJhL/BkIvVV7nALS8RcvpqsyKG18IuDQSLCJvQ8K4Tl8W47nUw4nfqkZNJYtsJOFzQ13sSlpf1zc=
X-Received: by 2002:adf:f985:0:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-37d5519d62cmr8625616f8f.2.1728910197530; Mon, 14 Oct 2024
 05:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014041130.1768674-1-niharchaithanya@gmail.com>
In-Reply-To: <20241014041130.1768674-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 14 Oct 2024 14:49:46 +0200
Message-ID: <CA+fCnZex_+2JVfUgAepbWm+TRzwMNkje6cXhCE_xEDesTq1Zfw@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, dvyukov@google.com, skhan@linuxfoundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:32=E2=80=AFAM Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> The Kunit tests for kmalloc_track_caller and kmalloc_node_track_caller
> were missing in kasan_test_c.c, which check that these functions poison
> the memory properly.
>
> Add a Kunit test:
> -> kmalloc_tracker_caller_oob_right(): This includes out-of-bounds
>    access test for kmalloc_track_caller and kmalloc_node_track_caller.
>
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216509
> ---
> v1->v2: Simplified the three separate out-of-bounds tests to a single tes=
t for
> kmalloc_track_caller.
>
> Link to v1: https://lore.kernel.org/all/20241013172912.1047136-1-niharcha=
ithanya@gmail.com/
>
>  mm/kasan/kasan_test_c.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..62efc1ee9612 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -213,6 +213,37 @@ static void kmalloc_node_oob_right(struct kunit *tes=
t)
>         kfree(ptr);
>  }
>
> +static void kmalloc_track_caller_oob_right(struct kunit *test)
> +{
> +       char *ptr;
> +       size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +
> +       /*
> +        * Check that KASAN detects out-of-bounds access for object alloc=
ated via
> +        * kmalloc_track_caller().
> +        */
> +       ptr =3D kmalloc_track_caller(size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       OPTIMIZER_HIDE_VAR(ptr);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D 'y');
> +
> +       kfree(ptr);
> +
> +       /*
> +        * Check that KASAN detects out-of-bounds access for object alloc=
ated via
> +        * kmalloc_node_track_caller().
> +        */
> +       size =3D 4096;
> +       ptr =3D kmalloc_node_track_caller(size, GFP_KERNEL, 0);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       OPTIMIZER_HIDE_VAR(ptr);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D 'y');

What you had here before (ptr[0] =3D ptr[size]) was better. ptr[size] =3D
'y' with size =3D=3D 4096 does an out-of-bounds write access, which
corrupts uncontrolled memory for the tag-based KASAN modes, which do
not use redzones. We try to avoid corrupting memory in KASAN tests, as
the kernel might crash otherwise before all tests complete.

So let's either change this back to ptr[0] =3D ptr[size] or just reuse
the same size for both test cases (or does kmalloc_node_track_caller
require size >=3D 4K?).

> +
> +       kfree(ptr);
> +}
> +
>  /*
>   * Check that KASAN detects an out-of-bounds access for a big object all=
ocated
>   * via kmalloc(). But not as big as to trigger the page_alloc fallback.
> @@ -1958,6 +1989,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
>         KUNIT_CASE(kmalloc_node_oob_right),
> +       KUNIT_CASE(kmalloc_track_caller_oob_right),
>         KUNIT_CASE(kmalloc_big_oob_right),
>         KUNIT_CASE(kmalloc_large_oob_right),
>         KUNIT_CASE(kmalloc_large_uaf),
> --
> 2.34.1
>

