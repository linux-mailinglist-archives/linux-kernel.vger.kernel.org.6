Return-Path: <linux-kernel+bounces-364690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDA99D7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C56B1F22233
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D41CF7C9;
	Mon, 14 Oct 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZzNP/0m"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80A14A4E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936721; cv=none; b=iB7FEcuqgY3MHUMCHtTdmZHTwp+2offvEDunbdp3Wzz1jfwj3kKeurfVW7lAtbgp7/tbI4RCqvyIsn3sJwDRWFXgecfdFiqn3GGrigpKzSbWGCag9RiwoBiS7+wEfnc/JSzHxqCdUEt8NUjYCallxuHe972fgqNNsZQPIuOiPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936721; c=relaxed/simple;
	bh=iSwR7Mm9dkFPmqhmV2deWN05jXrhP7MJva87LF9WdAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvCmYkiUDSloXWK+VgQR8yLnjWHS1BD/RAOlEciQgOTi/+zlGCuoc24ep5K4piSHl7lb4Rm3ARWdXyfd/o3Y87HoKj0VARcjOQTJGzYP8VZ+pF8LNO/fG3OBfxgpNlcAXwsVZuggpM40+0Acd/EvGqXr6SSRY263OL9QE8J1+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZzNP/0m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43115887867so31597985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936718; x=1729541518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soeb6YbR58TlyNb9WlOFV9xKVMAzyllWqObFU0oSEYI=;
        b=dZzNP/0mPfH7yN4J2BPlqsNp5tzkKjrMatac2vHZhRrPL04nRB6msx+EhFv89jVs2S
         ayvjhzWYXR2gwHMfncV/we7h50JB/6q6h50g8oILJ6HciNcj9HkpVXIERkM+80E7kHHl
         MtqeRaQc2H2/PNdsfdHFJvUuzdbJbsgTH5g4uBur9ra4uBMQ788e1+2eHHwB6kB79LSR
         NokpMUCtUQxbe57U4mYk4xEjO2UcNDTuPiGdIRyLHpB7wC0KdtOcaqOBioSEPVizwS7V
         oVALQ6EGWh0IKLwv/g1wahQLL7Fd5DejWKLbeXhngpe8sgx+LbuETXDqxbESjczIyGAw
         XAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936718; x=1729541518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soeb6YbR58TlyNb9WlOFV9xKVMAzyllWqObFU0oSEYI=;
        b=AUat9+ie/JDPiOd0PqllgSS9ns3BZsRWiYJo4JxRVYhyEXXHMBK+sTHbICN/mpI17+
         JsT0rCgPzFzQfXlcYTPHKjVd1qrMRFUoVVyPc0is7k5SHFoTLgkZizKgOWLw3Ffqlgs2
         QW4Ox9tuY4XCKLLjMbKiMQvc7DUi8J7FwbIFpxcd3lijmIWcdv0YprtCtEZOuEmvdocs
         khvrp3zKMVSI/8U1XUJjCENKY2Pn1Ml1rtGkwOmHsgw4jQEzZ606AmiVltA4Pc4wMri1
         gLcaTHPfSA2bgZIF9nGQOMQI/U1/bxK+K5GJA3qzkWDMWosi0OmogwansTe6zhTzqDpy
         D18A==
X-Forwarded-Encrypted: i=1; AJvYcCWN032tBUMso9UEe+ZxcSrYs+uBgfDYqYkZY4hZDORGCilKRf6OW9wxJn7ErY5VvuUp0ecAx4g/rBuHZ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9pyBl3Ffk0irZj1bJKWiO7Jt1vQH5XKujztS/QMZAhZxODCV
	amJUnk7I1lR3GUc7bl5vmJwF7KtIPllrqq8cWgQRQDhgFTRHGif9i9c+csRyUUhAJKE2VO80jY9
	oUPQjJhoYV2aDkW03ChuA88Kgags=
X-Google-Smtp-Source: AGHT+IHqgjsecLVxyauFCDz/PLim/NJ3WqRomNxV+w5VRl7XCenj3vGf3Yq+/KQGvUMOkiiHiFKul2lPDnP+jjKBROU=
X-Received: by 2002:a05:600c:1c9f:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-4311d8914ecmr100623995e9.6.1728936718148; Mon, 14 Oct 2024
 13:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014190128.442059-1-niharchaithanya@gmail.com>
In-Reply-To: <20241014190128.442059-1-niharchaithanya@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 14 Oct 2024 22:11:46 +0200
Message-ID: <CA+fCnZegGx3hTV5=Tfu1VUih80fcbGN4bxKFi8RzonMdUW-OCA@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add kunit tests for kmalloc_track_caller, kmalloc_node_track_caller
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, dvyukov@google.com, skhan@linuxfoundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:08=E2=80=AFPM Nihar Chaithanya
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
> v1->v2: Simplified the three separate out-of-bounds tests to a single
> test for kmalloc_track_caller.
>
> v2->v3: Used the same size for both the test cases.
>
> Link to v1: https://lore.kernel.org/all/20241013172912.1047136-1-niharcha=
ithanya@gmail.com/
> Link to v2: https://lore.kernel.org/all/20241014041130.1768674-1-niharcha=
ithanya@gmail.com/
>
>  mm/kasan/kasan_test_c.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..7e7076e71de0 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -213,6 +213,36 @@ static void kmalloc_node_oob_right(struct kunit *tes=
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
> +       ptr =3D kmalloc_node_track_caller(size, GFP_KERNEL, 0);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       OPTIMIZER_HIDE_VAR(ptr);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] =3D 'y');
> +
> +       kfree(ptr);
> +}
> +
>  /*
>   * Check that KASAN detects an out-of-bounds access for a big object all=
ocated
>   * via kmalloc(). But not as big as to trigger the page_alloc fallback.
> @@ -1958,6 +1988,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

