Return-Path: <linux-kernel+bounces-348209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A898E423
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D9E1F21599
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6F216A3D;
	Wed,  2 Oct 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soVPMslU"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696452141B4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900852; cv=none; b=og1/MIS8eXIZSXAlvVZwcKPi2xJYRGuhFpNJDQqTWK26vlzg19LIz7o1OsA+dXzfLAUu26G5z554SEV54ELBrXLW/lbrRBMxvLrVfd+b5tTtsimqDgPbWmVTgw8scwjGRKPn1WZU6BJ0hiXBPP9N7wxaBwSz+WQERp43ucdNEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900852; c=relaxed/simple;
	bh=DMPX1z3h+8v1HRakKOyju2YymTRuKX/WCvBVipKR9ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlkcHfRGiX9U5cNALiIvHy9K9X+oCZMHoAyttYmmxE5PnF8MKJvipRVKHx8J+pgz77ZM1Yh1ajBRRerdHd+AjV38bIh0gyLlJa2pfdstLk5sdS84YCWzv80D8qkl+sE8TNsPOSQ7r+7HvP9qjMSsgIhX1gkxsaa8Vs7HAqXSsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soVPMslU; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e03f8ecef8so190974b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727900848; x=1728505648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT+yukDqAEw3D2UmBemMykZfIxnmsmGd8Rtjs4o+Bi0=;
        b=soVPMslUe9FBmYDNsEfhEzt281LJni5LBUDNpECsUbMv67Y+Ig6jnxjTC6fUFNNxRj
         CDMn8h6gQR+5Ncqaxzt7mGgKhMuZuFyqxRAk6m4RMFMCXaxmXrGUMDvrRMNwEjf85RUU
         wJOAdQuglWuHc5uPo9AS7ZQoRiIEdAKVa2e4UyK78kFQ9e/Qt+lqchhNpNwepUOvFYFV
         Tk1bNytnIysFLAh9nIk7IA4auBBIY4qNUEYoIIqxDPUGzzQirkBXfUMghbBAVyBGK2yA
         SWZwVrL+9xvmAxA1H8JDSMn6mJFIH5C4azb8R8G1dlmosHIe0+JnK6l7r2loKgMcIuyy
         I6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900848; x=1728505648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT+yukDqAEw3D2UmBemMykZfIxnmsmGd8Rtjs4o+Bi0=;
        b=Tdgrrvy41Z2tr3pL/C0NZ2inEd4EaWo89s+oJL7FHMQFypXdYLPLxKSFDPjJQTY4+n
         k8vDHne6gsLuIOpIJ47klyFlfLCjkUSuYZaH9QfmsUAa6C85KsKKOb+HcZJrmiZ+LjoQ
         WTWbiJO9LEKB6Zhbw1uMQuJYuiMz7PBTkZeBCceIAnoteXAf3Ygsx1cIxHpbTkwBmaAT
         GaZrUH1/U6LqMb8L/+CJCwyni365AiOsLFmj9c7Ukb8xIMdHJrjzQ0lZ0UfEK8isapyI
         NWN5X2aNAcT799jQ5grIu2cLgEIBl96PAODxC4xq9E25vbunYI8SsScltU94OBHqyx/7
         mLVg==
X-Forwarded-Encrypted: i=1; AJvYcCVOqCohEqD5mJgOvyh+laYQvdhQsRCXTFOhYpNlPO1RQKAW5XMu/zxZupHZ2hCiXCjGpWrQZmspXQ3fNQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Dx9NaDeE1JolwRqsSBqOYwYkEgHgD+tG/c8VY/7IM3szCi5/
	xCdLMaC1vsmBJQZ19A5ln0HwpwqtFNf2QIU0xQvqiyIoVtZ7mZxxKO7yTJDRMn6UIAywvHEZOi5
	iSFc/oa94oA/Ej/ooezzvt3Q7hsdatRuU1RvA
X-Google-Smtp-Source: AGHT+IH/ZELLAKMbJMwkVUJ4DotJIlJfM+F94qV3fdpjMwzFZCMWTXdxbFqPRebvzgJivRapF1HW2e2P7RUkA7w9G0U=
X-Received: by 2002:a05:6808:14d4:b0:3da:e02f:eb8e with SMTP id
 5614622812f47-3e3b417766dmr3951787b6e.43.1727900848190; Wed, 02 Oct 2024
 13:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917005116.304090-1-arturacb@gmail.com> <20240917005116.304090-2-arturacb@gmail.com>
In-Reply-To: <20240917005116.304090-2-arturacb@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 2 Oct 2024 16:27:15 -0400
Message-ID: <CA+GJov4LOncihi99fyUh8c27df3k27i=oYGmKKa4kHQSgzgfTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] lib/llist_kunit.c: add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com, 
	diego.daniel.professional@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 8:51=E2=80=AFPM Artur Alves <arturacb@gmail.com> wr=
ote:
>
> Add KUnit tests for the llist data structure. They test the vast
> majority of methods and macros defined in include/linux/llist.h.
>
> These are inspired by the existing tests for the 'list' doubly
> linked in lib/list-test.c. Each test case (llist_test_x) tests
> the behaviour of the llist function/macro 'x'.
>
> Signed-off-by: Artur Alves <arturacb@gmail.com>

Hello!

Sorry for the delay in getting back to you. We have been busy with
LPC. This looks good to me!

I just have one comment left: the patch to add the lib/tests directory
hasn't landed in the kselftest/kunit branch so this patch doesn't
apply cleanly. Since we are planning on taking this patch through that
branch, could you switch the files to be lib/Makefile and
lib/llist_kunit.c for now. And we can move them in the great migration
later.

But otherwise,
Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
Rae

> ---
>  lib/Kconfig.debug       |  11 ++
>  lib/tests/Makefile      |   1 +
>  lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 370 insertions(+)
>  create mode 100644 lib/tests/llist_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index b5696659f027..f6bd98f8ce2b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2813,6 +2813,17 @@ config USERCOPY_KUNIT_TEST
>           on the copy_to/from_user infrastructure, making sure basic
>           user/kernel boundary testing is working.
>
> +config LLIST_KUNIT_TEST
> +       tristate "KUnit tests for lib/llist" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option builds the llist (lock-less list) KUnit test suite.
> +         It tests the API and basic functionality of the macros and
> +         functions defined in <linux/llist.h>.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index c6a14cc8663e..8d7c40a73110 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -34,4 +34,5 @@ CFLAGS_stackinit_kunit.o +=3D $(call cc-disable-warning=
, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) +=3D stackinit_kunit.o
>  obj-$(CONFIG_STRING_KUNIT_TEST) +=3D string_kunit.o
>  obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) +=3D string_helpers_kunit.o
> +obj-$(CONFIG_LLIST_KUNIT_TEST) +=3D llist_kunit.o
>
> diff --git a/lib/tests/llist_kunit.c b/lib/tests/llist_kunit.c
> new file mode 100644
> index 000000000000..817bb2948697
> --- /dev/null
> +++ b/lib/tests/llist_kunit.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the Kernel lock-less linked-list structure.
> + *
> + * Author: Artur Alves <arturacb@gmail.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/llist.h>
> +
> +#define ENTRIES_SIZE 3
> +
> +struct llist_test_struct {
> +       int data;
> +       struct llist_node node;
> +};
> +
> +static void llist_test_init_llist(struct kunit *test)
> +{
> +       /* test if the llist is correctly initialized */
> +       struct llist_head llist1 =3D LLIST_HEAD_INIT(llist1);
> +       LLIST_HEAD(llist2);
> +       struct llist_head llist3, *llist4, *llist5;
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist1));
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist2));
> +
> +       init_llist_head(&llist3);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist3));
> +
> +       llist4 =3D kzalloc(sizeof(*llist4), GFP_KERNEL | __GFP_NOFAIL);
> +       init_llist_head(llist4);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist4));
> +       kfree(llist4);
> +
> +       llist5 =3D kmalloc(sizeof(*llist5), GFP_KERNEL | __GFP_NOFAIL);
> +       memset(llist5, 0xFF, sizeof(*llist5));
> +       init_llist_head(llist5);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist5));
> +       kfree(llist5);
> +}
> +
> +static void llist_test_init_llist_node(struct kunit *test)
> +{
> +       struct llist_node a;
> +
> +       init_llist_node(&a);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, a.next, &a);
> +}
> +
> +static void llist_test_llist_entry(struct kunit *test)
> +{
> +       struct llist_test_struct test_struct, *aux;
> +       struct llist_node *llist =3D &test_struct.node;
> +
> +       aux =3D llist_entry(llist, struct llist_test_struct, node);
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct, aux);
> +}
> +
> +static void llist_test_add(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       /* The first assertion must be true, given that llist is empty */
> +       KUNIT_EXPECT_TRUE(test, llist_add(&a, &llist));
> +       KUNIT_EXPECT_FALSE(test, llist_add(&b, &llist));
> +
> +       /* Should be [List] -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void llist_test_add_batch(struct kunit *test)
> +{
> +       struct llist_node a, b, c;
> +       LLIST_HEAD(llist);
> +       LLIST_HEAD(llist2);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +       init_llist_node(&c);
> +
> +       llist_add(&a, &llist2);
> +       llist_add(&b, &llist2);
> +       llist_add(&c, &llist2);
> +
> +       /* This assertion must be true, given that llist is empty */
> +       KUNIT_EXPECT_TRUE(test, llist_add_batch(&c, &a, &llist));
> +
> +       /* should be [List] -> c -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &c);
> +       KUNIT_EXPECT_PTR_EQ(test, c.next, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void llist_test_llist_next(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* should be [List] -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist_next(&b), &a);
> +       KUNIT_EXPECT_NULL(test, llist_next(&a));
> +}
> +
> +static void llist_test_empty_llist(struct kunit *test)
> +{
> +       struct llist_head llist =3D LLIST_HEAD_INIT(llist);
> +       struct llist_node a;
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +
> +       llist_add(&a, &llist);
> +
> +       KUNIT_EXPECT_FALSE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_llist_on_list(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       llist_add(&a, &llist);
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_TRUE(test, llist_on_list(&a));
> +       KUNIT_EXPECT_FALSE(test, llist_on_list(&b));
> +}
> +
> +static void llist_test_del_first(struct kunit *test)
> +{
> +       struct llist_node a, b, *c;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* before: [List] -> b -> a */
> +       c =3D llist_del_first(&llist);
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
> +
> +       /* del must return a pointer to llist_node b
> +        * the returned pointer must be marked on list
> +        */
> +       KUNIT_EXPECT_PTR_EQ(test, c, &b);
> +       KUNIT_EXPECT_TRUE(test, llist_on_list(c));
> +}
> +
> +static void llist_test_del_first_init(struct kunit *test)
> +{
> +       struct llist_node a, *b;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +
> +       b =3D llist_del_first_init(&llist);
> +
> +       /* should be [List] */
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +
> +       /* the returned pointer must be marked out of the list */
> +       KUNIT_EXPECT_FALSE(test, llist_on_list(b));
> +}
> +
> +static void llist_test_del_first_this(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       llist_del_first_this(&llist, &a);
> +
> +       /* before: [List] -> b -> a */
> +
> +       // should remove only if is the first node in the llist
> +       KUNIT_EXPECT_FALSE(test, llist_del_first_this(&llist, &a));
> +
> +       KUNIT_EXPECT_TRUE(test, llist_del_first_this(&llist, &b));
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
> +}
> +
> +static void llist_test_del_all(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +       LLIST_HEAD(empty_llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* deleting from a empty llist should return NULL */
> +       KUNIT_EXPECT_NULL(test, llist_del_all(&empty_llist));
> +
> +       llist_del_all(&llist);
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_for_each(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE] =3D { 0 };
> +       struct llist_node *pos, *deleted_nodes;
> +       LLIST_HEAD(llist);
> +       int i =3D 0, j =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; i--)
> +               llist_add(&entries[i], &llist);
> +
> +       /* before [List] -> entries[0] -> ... -> entries[ENTRIES_SIZE - 1=
] */
> +       llist_for_each(pos, llist.first) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +
> +       /* traversing deleted nodes */
> +       deleted_nodes =3D llist_del_all(&llist);
> +
> +       llist_for_each(pos, deleted_nodes) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[j++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, j);
> +}
> +
> +static void llist_test_safe_for_each(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE];
> +       struct llist_node *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; i--)
> +               llist_add(&entries[i], &llist);
> +
> +       llist_for_each_safe(pos, n, llist.first) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +               llist_del_first(&llist);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_entry_for_each(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; --i) {
> +               entries[i].data =3D i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i =3D 0;
> +
> +       llist_for_each_entry(pos, llist.first, node) {
> +               KUNIT_EXPECT_EQ(test, pos->data, i);
> +               i++;
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static void llist_test_entry_safe_for_each(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; --i) {
> +               entries[i].data =3D i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i =3D 0;
> +
> +       llist_for_each_entry_safe(pos, n, llist.first, node) {
> +               KUNIT_EXPECT_EQ(test, pos->data, i++);
> +               llist_del_first(&llist);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_reverse_order(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE], *pos, *reversed_llist;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D 0; i < ENTRIES_SIZE; i++)
> +               llist_add(&entries[i], &llist);
> +
> +       /* before [List] -> entries[2] -> entries[1] -> entries[0] */
> +       reversed_llist =3D llist_reverse_order(llist_del_first(&llist));
> +
> +       /* should be [List] -> entries[0] -> entries[1] -> entries[2] */
> +       llist_for_each(pos, reversed_llist) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static struct kunit_case llist_test_cases[] =3D {
> +       KUNIT_CASE(llist_test_init_llist),
> +       KUNIT_CASE(llist_test_init_llist_node),
> +       KUNIT_CASE(llist_test_llist_entry),
> +       KUNIT_CASE(llist_test_add),
> +       KUNIT_CASE(llist_test_add_batch),
> +       KUNIT_CASE(llist_test_llist_next),
> +       KUNIT_CASE(llist_test_empty_llist),
> +       KUNIT_CASE(llist_test_llist_on_list),
> +       KUNIT_CASE(llist_test_del_first),
> +       KUNIT_CASE(llist_test_del_first_init),
> +       KUNIT_CASE(llist_test_del_first_this),
> +       KUNIT_CASE(llist_test_del_all),
> +       KUNIT_CASE(llist_test_for_each),
> +       KUNIT_CASE(llist_test_safe_for_each),
> +       KUNIT_CASE(llist_test_entry_for_each),
> +       KUNIT_CASE(llist_test_entry_safe_for_each),
> +       KUNIT_CASE(llist_test_reverse_order),
> +       {}
> +};
> +
> +static struct kunit_suite llist_test_suite =3D {
> +       .name =3D "llist",
> +       .test_cases =3D llist_test_cases,
> +};
> +
> +kunit_test_suite(llist_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for the llist data structure.");
> --
> 2.46.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240917005116.304090-2-arturacb%40gmail.com.

