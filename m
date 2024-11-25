Return-Path: <linux-kernel+bounces-421359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB29D8A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DB16A7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F233B1AAE0B;
	Mon, 25 Nov 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJVO4rfN"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E282AD14
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551532; cv=none; b=rv5qo3b8/YYBQics3SG3XldO/7oa3ImuTHxykYo5PtP5lEJy0susBecYeJ35oV44UbWT7j05N7Ei/XaLiCv0Oy33H8NisDPH/7lJD6YHq1WaQjRgWQWUOQDyXEZ0/B6e8PiTaZwEkcNQqmVBisKV+pWT/67cl2fdNoVG93Vh7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551532; c=relaxed/simple;
	bh=Vhho94V1jje0QwAUAqBS8ALGr7o4KnACyWouc22n0aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrmfUtnVSv0nKVbRAt8T3QLGf4pWQGd+Bdh39CuqX+YhCMJCpjG5dQcydHukvqs18hDDxAdlZQZyJjPKB0WH1JwrxG07QADPPITmR4lKajRhbRylfFUIs/oSN6RQfSM0hxk62GfIaWJOyMRfx2vM9xsXyHOWLFUUuTd+AS3QoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJVO4rfN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46687f60b73so385801cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732551530; x=1733156330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXQbE0T1v2fJwmVq6RAvjEXp4Ag7Di7PPppePVUvnw8=;
        b=DJVO4rfNPrKaHTyW4nwEpGve+qv+EVcJ2YeXX67f836NGoQahJ4cWb8bJV8HS1WEAW
         VcvG41VfkDvWH890+62vMlxlL1BGaJuTZlbckWemh5ZgJOfi8Z1Ql9IAuGngzVrSBr83
         fMhKUg7zBJxp4qZoOToQN5ZgofsX1vEhFGaM7DPIba62QqJM4ECpT69nwUK3VJJ63fqH
         pH5/wgJ8smm1cLwo2h4Oq67YqH0oP6KVN49RV0HHXmEZBDxUyy8hHOQgMwkwaNlQ7tRO
         PwpzBQ4HG/bhduogwVioA+ydJP1JNHowDbaF5Y6r3HX1ylQUOl82yp9GkrVIsiqOkISM
         9xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551530; x=1733156330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXQbE0T1v2fJwmVq6RAvjEXp4Ag7Di7PPppePVUvnw8=;
        b=QPZPC8FMulEMauMy5T64og+wPMI5a4AO58Q+9zo+oKod/4cGbIHQfS9VG0uzwvueRs
         stl/Hnxf9Ew0OpYrAA9L5LywnX8zpS3l88UeMM5moTV2TnMBdXrQ/KKCfnDJeL3EQaDZ
         B3z8bBEgjnPKadzfEfG/4cvXUw/EdJHqKUMj16w3xZmowitKcOs0ZyWLauQCrPf0aL9Y
         CS02msVIsA1AFVt560TM3/8/Nnd9WlQhAvHtUWmesT253lfKsCwjkLZRCHS2C2T1Xy6r
         CeIISmyn9mHyf1uesuziiqbDt4O0vvCRc547vg9Ah9md5UtWeDpJ4P93TfWabgVF4iRp
         Ry+w==
X-Forwarded-Encrypted: i=1; AJvYcCW0aczrmPj5yPMqMF0cQn9IlX6dn8SHBpLPtg6mTWPIGyEwQ+oLjE5Q7N4cKcNdJFWHChxUWcu6ZhwIfd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAnFY23j2NZQQH3fTcJnZc+JKyJWdpcd6auremhuuHbp7NTNm
	J5geTmm1aQFrYegrBgsVzwxcUAZ+P6+lDM6Yj0ubrH2KLy40Mcjt99o8DuZWUJDxeEFWiCXSz8d
	VwWAXRCQ4RrJ1zK57xoQH2su8WzsBuQWjOkdC
X-Gm-Gg: ASbGncvRuUKa2jsUTqyx8o4hpqJOEjlXSB8f/YjO87pPjlcyM1WCIrV9qje6oPppm0f
	81N5HmYZQwhQP5zHtbJDQ/e0Asa/dRuA=
X-Google-Smtp-Source: AGHT+IFRGABe8UuCauRXseeLtrBztJhWj7HLj+gZpzacy0cROzVdyaPTjiBLKoRlDAdTCCtEEtMIyWV96nvvfVhbrNk=
X-Received: by 2002:a05:622a:1b26:b0:461:358e:d635 with SMTP id
 d75a77b69052e-46672c47a12mr7096701cf.18.1732551529138; Mon, 25 Nov 2024
 08:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122174416.1367052-1-surenb@google.com> <20241122174416.1367052-3-surenb@google.com>
 <20241125005804.libwzfcz6d5zeyi4@master>
In-Reply-To: <20241125005804.libwzfcz6d5zeyi4@master>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Nov 2024 08:18:38 -0800
Message-ID: <CAJuCfpF+ZdD3-gTSLr1iwpa=fefUyL5dLoy8vGpv=v7LABnjNw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: introduce mmap_lock_speculate_{try_begin|retry}
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org, 
	jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, zhangpeng.00@bytedance.com, linmiaohe@huawei.com, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 4:58=E2=80=AFPM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Fri, Nov 22, 2024 at 09:44:16AM -0800, Suren Baghdasaryan wrote:
> >Add helper functions to speculatively perform operations without
> >read-locking mmap_lock, expecting that mmap_lock will not be
> >write-locked and mm is not modified from under us.
> >
> >Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >---
> >Changes since v2 [1]
> >- Added SOB, per Liam Howlett
> >
> >[1] https://lore.kernel.org/all/20241121162826.987947-3-surenb@google.co=
m/
> >
> > include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
> > 1 file changed, 31 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> >index 9715326f5a85..8ac3041df053 100644
> >--- a/include/linux/mmap_lock.h
> >+++ b/include/linux/mmap_lock.h
> >@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const stru=
ct mm_struct *mm)
> > }
> >
> > #ifdef CONFIG_PER_VMA_LOCK
> >+
> > static inline void mm_lock_seqcount_init(struct mm_struct *mm)
> > {
> >       seqcount_init(&mm->mm_lock_seq);
> >@@ -87,11 +88,39 @@ static inline void mm_lock_seqcount_end(struct mm_st=
ruct *mm)
> >       do_raw_write_seqcount_end(&mm->mm_lock_seq);
> > }
> >
> >-#else
> >+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, =
unsigned int *seq)
> >+{
> >+      /*
> >+       * Since mmap_lock is a sleeping lock, and waiting for it to beco=
me
> >+       * unlocked is more or less equivalent with taking it ourselves, =
don't
> >+       * bother with the speculative path if mmap_lock is already write=
-locked
> >+       * and take the slow path, which takes the lock.
> >+       */
> >+      return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
> >+}
> >+
> >+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsi=
gned int seq)
> >+{
> >+      return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
>
> Just curious why we don't use read_seqcount_retry().
>
> Looks this is the only user outside seqlock.h.

Ah, good eye! read_seqcount_retry() would be better.

Peter, do you want me to post a new patchset or you can patch it when
picking it up?

>
> >+}
> >+
> >+#else /* CONFIG_PER_VMA_LOCK */
> >+
> > static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
> > static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
> >-#endif
> >+
> >+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, =
unsigned int *seq)
> >+{
> >+      return false;
> >+}
> >+
> >+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsi=
gned int seq)
> >+{
> >+      return true;
> >+}
> >+
> >+#endif /* CONFIG_PER_VMA_LOCK */
> >
> > static inline void mmap_init_lock(struct mm_struct *mm)
> > {
> >--
> >2.47.0.371.ga323438b13-goog
>
> --
> Wei Yang
> Help you, Help me

