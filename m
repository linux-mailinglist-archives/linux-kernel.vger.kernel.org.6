Return-Path: <linux-kernel+bounces-431338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7009E3C16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E036B16907E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D21F8EF1;
	Wed,  4 Dec 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7y8u6dC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189D1F891D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321127; cv=none; b=gJeREII/DvmA+2a1LCqT/8NuxSASPqZRtmbJrXBrhxZyLSVgVNEuBTa3ubXyKCh9Z/JYjv3Pf3WkqtrwD2r8MK76Z/y5KITkn/wDiNr86ktXJ2B+AqkYPgZ+AXmxWU6KS+3pthrLWeq+sfzv70CqUB3FYdvtKa9lNmOj05AoyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321127; c=relaxed/simple;
	bh=bx68u5XKgT/+jhE3Qp9XsXevOIEBAqKPZA6Emg/Cx2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clvzL8Q/xGsyfZVXvcqRLQMaNPuPHs9BVJsksM7reuqJNaAxb03/LaLZpn54GI3zAOM+s80Cu0HniKMXGLwJtE0XC79FniBzhFCehPTBlxxBp5yQyMoa7CU/M4gvZITfcvyWKmCXot/66Wpx7y+ogkoyJFyIeiHEea1F36HpOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7y8u6dC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434aa472617so56237485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733321124; x=1733925924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx68u5XKgT/+jhE3Qp9XsXevOIEBAqKPZA6Emg/Cx2Q=;
        b=J7y8u6dCdeIg9tUHKMv/k7jfCjPWgN9dPfXPu4uQBv0uamvlE6Yx5t3TqI4rJiJ83l
         fJLArzS7XGpkUlUznvm+SYXyco0et3/384MVtyEHN5YVMX1zDGrZfovLhQGlqQNKGlj2
         Q7Te7L1EJf2JmPbVJcLr7lfl+jnhhtV/I1f5dXguJu2gQVcee78c8J/7saaTnP16GfjK
         L2gMSrfz9YsDs6+RYEreFwjjVcMYzy5TtsG++2o0vhmY898/wxPsNUupqyTCxJyHDg3b
         g2nUXYYoNM3t4BxKzH3tjBsJBdNvE7hYdRfx221qeDSMZXStT8y9Paw+eSGOB929WRpm
         Wg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321124; x=1733925924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx68u5XKgT/+jhE3Qp9XsXevOIEBAqKPZA6Emg/Cx2Q=;
        b=gYqhHvqftEQdoYpQL5XZUPrZ6a0CXMfOyaO2HSYcs7STV6bv+SkLZetMXv8jT/v7FK
         hENgvXbv40pp5Z7AldQmSGEaQEgVy+nxQ7AyR/brsp5kKteoEptxpal3VGu6XDVmQvpc
         JDsjuRUkD9toS7GhdJCZxnepMPR/VcAQtWRrqnBMVBGHqXOQGXJkCmP1bgbm+7MQDqQg
         4B5hGGrSZpUQCHAJSeBQAi6BpcWbIP+v44RBW7EbiLWnjL6ibyJQlK325+OCTaogAW1M
         bHyNcaHOVpRIbDB+arjt+2qNKLW22jcFsyxJVO4thg6ydCG2SNuPCkyW2iQBg6e+2wKx
         7okg==
X-Forwarded-Encrypted: i=1; AJvYcCUy6SVIvqLAkxnwZBfR6Gy3DSEJ4wZFO6w1C4j2lX0mvUbWHaGluV7B5ypksUphj9BdAD9mPRhwaiun84Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidRBRjm9fGuFM+lBBr8wySv/Nonf15D2ppUndzn+QFC3CczB+
	vncIJh3VRs/3OXJh9/FezW8lGo0LDqn9q+htvZvB8rq+vl4dj/oHTAUDwjXJRJ7p0ssfleTl3ea
	R1kQ+RtXPosh7cLrYXXM3jlqzG/X0M3NCTO7K
X-Gm-Gg: ASbGncsijQhdN9ek7abwpydS+wWTTRmEMpnrhtxM9H3ibf6GG0po05pL7I2MZMDNORw
	bdmB4tHqRa10RnlWOUVThE6Md3s6M1sC7o2IR9izrICOSKl3Zn/Ef7U0AAlLzMQ==
X-Google-Smtp-Source: AGHT+IHqp5nN2iOoL3hM8JEZ/0tszs9jMcm3VJPsH9sAgmP+o0N6D8b/XkEpVD11dIyZnjb0lzRSjFgOnTpZLa0RMoY=
X-Received: by 2002:a05:600c:3108:b0:434:9f78:17d2 with SMTP id
 5b1f17b1804b1-434d0a1d675mr54247475e9.29.1733321123753; Wed, 04 Dec 2024
 06:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com> <20241203215452.2820071-3-cmllamas@google.com>
 <CAH5fLgjMZw+58Wh58QVX2hD14=r-XkbtduTSchUPO14cJAJAww@mail.gmail.com> <Z1BblcGDBvcdRTsO@google.com>
In-Reply-To: <Z1BblcGDBvcdRTsO@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 4 Dec 2024 15:05:11 +0100
Message-ID: <CAH5fLgjBEvTzH12gZHpJqK9ebcfwVR+beb0yZ8qKPCY+5mQqEw@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] binder: concurrent page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	David Hildenbrand <david@redhat.com>, Barry Song <v-songbaohua@oppo.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:39=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Wed, Dec 04, 2024 at 10:59:19AM +0100, Alice Ryhl wrote:
> > On Tue, Dec 3, 2024 at 10:55=E2=80=AFPM Carlos Llamas <cmllamas@google.=
com> wrote:
> > >
> > > Allow multiple callers to install pages simultaneously by switching t=
he
> > > mmap_sem from write-mode to read-mode. Races to the same PTE are hand=
led
> > > using get_user_pages_remote() to retrieve the already installed page.
> > > This method significantly reduces contention in the mmap semaphore.
> > >
> > > To ensure safety, vma_lookup() is used (instead of alloc->vma) to avo=
id
> > > operating on an isolated VMA. In addition, zap_page_range_single() is
> > > called under the alloc->mutex to avoid racing with the shrinker.
> >
> > How do you avoid racing with the shrinker? You don't hold the mutex
> > when binder_install_single_page is called.
> >
> > E.g. consider this execution:
> >
> > 1. binder_alloc_new_buf finishes allocating the struct binder_buffer
> > and unlocks the mutex.
>
> By the time the mutex is released in binder_alloc_new_buf() all the
> pages that will be used have been removed from the freelist and the
> shrinker will have no access to them.
>
> > 2. Shrinker starts running, locks the mutex, sets the page pointer to
> > NULL and unlocks the lru spinlock. The mutex is still held.
> > 3. binder_install_buffer_pages is called and since the page pointer is
> > NULL, binder_install_single_page is called.
> > 4. binder_install_single_page allocates a page and tries to
> > vm_insert_page it. It gets an EBUSY error because the shrinker has not
> > yet called zap_page_range_single.
> > 5. binder_install_single_page looks up the page with
> > get_user_pages_remote. The page is written back to the pages array.
> > 6. The shrinker calls zap_page_range_single followed by
> > binder_free_page(page_to_free).
> > 7. The page has now been freed and zapped, but it's in the page array. =
UAF.
> >
> > Is there something I'm missing?
>
> I think that would be the call to binder_lru_freelist_del().

Tricky stuff. But okay, I buy it. This logic works.

Alice

