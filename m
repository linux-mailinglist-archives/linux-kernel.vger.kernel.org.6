Return-Path: <linux-kernel+bounces-335450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A794097E5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86F11C20F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026014F70;
	Mon, 23 Sep 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8PzzO/+"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960010A3E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071742; cv=none; b=t5/mBtOWhxXv1c0Il/b5lR7SGPqyrSJgBt7irybK0Ers4zduMp5nG0Tkb0jmk1jmmlLdLS+R6/+TXNdKqoUHSnW6VTnyMFJ2hD0B0/+NJ08yP4ly0J5CDy9o80/08yc8lbYd4S8uN+3EStXln6MbW1B/VgIQtg2Ns9FLEpFV4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071742; c=relaxed/simple;
	bh=unL0WtMsKVtj69g8UmUIv3RMdTmfHFIiMc0FE2FsCoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2mhkLlQH1b6H+Eh2GOGwlPdodPR5mp++01CRfo+crQWCMaE/YhZzA+EXHToaPE/I76jNMnQQv9QFZChWVRtlzie5hK3C2F9J77XkkYGqpfE9EtXmGAjUiaUZRenkDkjAf0GBNwRXIGKXt0Bh6NRh9KdM2Lqz1Ve9mrM6tgeLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8PzzO/+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so37868391fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727071739; x=1727676539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K40eclvjg+5GlWGh4SlN0FjtX41ZWIpAlF1jWels5qA=;
        b=O8PzzO/+5oyP7GysoVJ9dF7WKg3ysz8vIy1k2ETH8UjxbgqlKGKyV8FF5qNtigdsMZ
         I8FTPL6xUhtj4bjgYW54iB794ekIafB1xGArXwKXtZqVtqrg7C9Y6QgcBlFoER4oS3Lw
         7QMpHkRCFnTWSNR64d8ESepD4yz7TXyvXKpMqK+qRYN4GHOMRAtu12P1nJq9xlex1x9u
         kijEfnX9wnyy5m7rXBHok3qPIh+bpOXstDI5/WnFKewxwiCQp9VMUHjiO5fR+cy3K+H0
         LZ+fOj7dpbnHBiGwcE4FTgFDppZl+fKDv8qsbKw9Vedb1qIG7TqYfow4ozyYaPwfbE4g
         7LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727071739; x=1727676539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K40eclvjg+5GlWGh4SlN0FjtX41ZWIpAlF1jWels5qA=;
        b=n82nYUX1L2clVrQS013JP/KO/KVJaB1GnRyOY03I8xFEHM966vd0MBRcHlBs79CW8R
         aj4ywNcOdJrG7ZPxsIXx6UAojHNyJ0QxrnTgyMwEEGSmEhnG/yPm8s3aWIweK6EpVsDY
         7L18YaT5V0+GCcn1yRLWBnlmCaDRzx1MEGEHIynbtBHvK4kP91zPp3snmZOffXNoaVRV
         GvMqjjAuEBWFdiclikL5If5J+OaUlfjbeZGQSbAWq7kJhR7mo1fexiJeS3dOTZhiHChK
         XgZ3DEeicULOTyJAuALQaNhztop/3NkKfPHv+OjzcEtAd2oKxWZoaxUrICm70C70HLkV
         Xoew==
X-Forwarded-Encrypted: i=1; AJvYcCU0/BAd1MRtfTC4CzLPJPI+0lpCv1joIAsuCnmL8+SG6jeWZBNAEMn1KHJF3fpOGsA1RB3MQ+R/YfNYCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqE5Vmm71KfCVttzAhFyR6kv9aTra8ouEFZes/WoEf8+mDVOVw
	0w5LWElrppQvb8iaTe42re9r1FU5535gjqsCg7uwme3NwYavzjDJHLA9qC+PBFehm/EV9etzlVY
	7I+QUZ8WRlGEuIU4FYxeFXEwn5ss=
X-Google-Smtp-Source: AGHT+IHXZ8/KhRf9j+/7bXZhnnPZaQ3XwlgnSVJMxl6mx6N/2HFk7xuLnrJ2w7P0CyX1LdgbhickwQtJDiqfe5YAXHQ=
X-Received: by 2002:a05:6512:a8f:b0:536:a4da:8d86 with SMTP id
 2adb3069b0e04-536ac2e0382mr4432965e87.15.1727071738642; Sun, 22 Sep 2024
 23:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfaZGowWPE8kMeTY60n7BCFT2q4+Z2EJ92YB_+7+OUo7Q@mail.gmail.com>
 <20240922145757.986887-1-snovitoll@gmail.com>
In-Reply-To: <20240922145757.986887-1-snovitoll@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 23 Sep 2024 11:09:33 +0500
Message-ID: <CACzwLxg7_HPxbjLT1v+dHG=V0wAcUJYZvqdcdLBD9xhLgNUmqQ@mail.gmail.com>
Subject: Re: [PATCH v5] mm: x86: instrument __get/__put_kernel_nofault
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 7:57=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>  arch/x86/include/asm/uaccess.h |  3 +++
>  mm/kasan/kasan_test.c          | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a7755c1a441..e8e5185dd65c 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -620,6 +620,7 @@ do {                                                 =
                       \
>
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>  #define __get_kernel_nofault(dst, src, type, err_label)                 =
       \
> +       instrument_memcpy_before(dst, src, sizeof(type));               \
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         sizeof(type), err_label)
>  #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> @@ -627,6 +628,7 @@ do {                                                 =
                       \
>  do {                                                                   \
>         int __kr_err;                                                   \
>                                                                         \
> +       instrument_memcpy_before(dst, src, sizeof(type));               \
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         sizeof(type), __kr_err);                        \
>         if (unlikely(__kr_err))                                         \
> @@ -635,6 +637,7 @@ do {                                                 =
                       \
>  #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>
>  #define __put_kernel_nofault(dst, src, type, err_label)                 =
       \
> +       instrument_write(dst, sizeof(type));                            \
>         __put_user_size(*((type *)(src)), (__force type __user *)(dst), \
>                         sizeof(type), err_label)
>

Instead of adding KASAN, KCSAN checks per arch macro,
here is the alternative, generic way with a wrapper.
I've tested it on x86_64 only, going to test on arm64
with KASAN_SW_TAGS, KASAN_HW_TAGS if I can do it in qemu,
and form a new patch for all arch
and this PATCH v5 for x86 only can be abandoned.

Please let me know if this wrapper is good enough,
I will see in kasan_test.c how I should use SW/HW_TAG, probably,
they should be a separate test with
KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
---
 include/linux/uaccess.h |  8 ++++++++
 mm/kasan/kasan_test.c   | 21 +++++++++++++++++++++
 mm/maccess.c            |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index d8e4105a2f21..1b5c23868f97 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -422,6 +422,14 @@ do { \
 } while (0)
 #endif

+#define __get_kernel_nofault_wrapper(dst, src, type, err_label) \
+ instrument_memcpy_before(dst, src, sizeof(type)); \
+ __get_kernel_nofault(dst, src, type, err_label); \
+
+#define __put_kernel_nofault_wrapper(dst, src, type, err_label) \
+ instrument_write(dst, sizeof(type)); \
+ __put_kernel_nofault(dst, src, type, err_label); \
+
 /**
  * get_kernel_nofault(): safely attempt to read from a location
  * @val: read into this variable
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 567d33b493e2..ae05c8858c07 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1944,6 +1944,26 @@ static void match_all_mem_tag(struct kunit *test)
  kfree(ptr);
 }

+static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+{
+ char *ptr;
+ char buf[128];
+ size_t size =3D sizeof(buf);
+
+ ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
+ KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+ KUNIT_EXPECT_KASAN_FAIL(test,
+ copy_from_kernel_nofault(&buf[0], ptr, size));
+ KUNIT_EXPECT_KASAN_FAIL(test,
+ copy_from_kernel_nofault(ptr, &buf[0], size));
+ KUNIT_EXPECT_KASAN_FAIL(test,
+ copy_to_kernel_nofault(&buf[0], ptr, size));
+ KUNIT_EXPECT_KASAN_FAIL(test,
+ copy_to_kernel_nofault(ptr, &buf[0], size));
+ kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] =3D {
  KUNIT_CASE(kmalloc_oob_right),
  KUNIT_CASE(kmalloc_oob_left),
@@ -2017,6 +2037,7 @@ static struct kunit_case kasan_kunit_test_cases[] =3D=
 {
  KUNIT_CASE(match_all_not_assigned),
  KUNIT_CASE(match_all_ptr_tag),
  KUNIT_CASE(match_all_mem_tag),
+ KUNIT_CASE(copy_from_to_kernel_nofault_oob),
  {}
 };

diff --git a/mm/maccess.c b/mm/maccess.c
index 518a25667323..a3533a0d0677 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const
void *unsafe_src,

 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) \
  while (len >=3D sizeof(type)) { \
- __get_kernel_nofault(dst, src, type, err_label); \
+ __get_kernel_nofault_wrapper(dst, src, type, err_label);\
  dst +=3D sizeof(type); \
  src +=3D sizeof(type); \
  len -=3D sizeof(type); \
@@ -49,7 +49,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);

 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label) \
  while (len >=3D sizeof(type)) { \
- __put_kernel_nofault(dst, src, type, err_label); \
+ __put_kernel_nofault_wrapper(dst, src, type, err_label);\
  dst +=3D sizeof(type); \
  src +=3D sizeof(type); \
  len -=3D sizeof(type); \
--

