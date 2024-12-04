Return-Path: <linux-kernel+bounces-430901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221FF9E36FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F809B22EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B821ACDF0;
	Wed,  4 Dec 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgyD+qT9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55861AB52D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306375; cv=none; b=o+jVDbz1oWT3EUHgkzIpnjUhly8DHTKpO10CRTwu08OfAzBoTxtWRn0uWE0SoKRd7QEon8qL/EmmVEZOoYqbTayNaSE0T9NeTIA28WhAhGgbi5THDolTry3k/ieIsACsKjeNqn94itJng84PsMfHkKlstwahopLK/Los+trdu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306375; c=relaxed/simple;
	bh=mmaUQ3oqqPqEDuQDJzHkxRsKiWlOfWHzFPJULSZVpSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS+rntiG+mZ1H78P/abPaC1cR21nDej4KVTWK5ljy4fZ8fl99IkHp3byhHgAkfeXXFGaoUrnsgR1C6oggJcWrIq0PNEQmfMmWmXcfK13UEk8EF2jqPrW0D5wMBnA16DVhpu9xmMutzV+1CwWbltqmPLilqLA7GPbyeAlTOhjtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgyD+qT9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eaecc213so350683f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733306372; x=1733911172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmaUQ3oqqPqEDuQDJzHkxRsKiWlOfWHzFPJULSZVpSc=;
        b=CgyD+qT9MhEtcar9J4DW5H+5b9fFgw6dOWo1zIhfjqbqgn2PB3RnwhiYhHWzUg3itH
         3rCPR4pucCtNhEOmIATXzOQ6krPrl57hniat270s++q2QAFSOtpRxHJucdyW5S7e9fNL
         g4gUxsgPi/mkUN9xvmQYpacKDFhtuj4v49QwHuoIud65b4bZ8W6WRhYVYtlQQKjNvsXE
         tDEltUrteRbeRV0K1gkgZ90hENuXxdNCJf2ErORbZAaQN+9rYHmVSf7K6TT+QSzcRb16
         apwyZsgrszBp84hrnqC8lG6wCsFNESkWjbEd/eQfPARJRivDaqHZ1CMRHHGjJfh+e2dG
         WEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306372; x=1733911172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmaUQ3oqqPqEDuQDJzHkxRsKiWlOfWHzFPJULSZVpSc=;
        b=KN/rgEFYJt7FQko0YDaKDokpO0xG2cKUoJ6jULFbF7YBtpX9hovxjLLudsCGJps+H2
         vmv3TEUoSSg0xUTVNbz6/7I92Lr41aRUaWlPZ/LRb8fDmWCAsjFvDYOPCxu6dQBmnW5A
         KUGuyCjxfM167NhSbAb2e2ySYcn+Djlp6zrfvT+q7oEVj9IRT1fVKo2mOdzLJy4oOYSI
         MOJNkFtXxv8hOnrYNp98ETyNq0//j8pxYlEPm1PD0AnkLJ0z6O6m/dlNruluThzMuHV+
         gEKhn/8RkyBYUx6lniEkXcvbzVNntnjvZDdpxUPX9j1If1WnsVgkS0j1JXUp5Ti0Qgon
         yuMg==
X-Forwarded-Encrypted: i=1; AJvYcCV5dlDAxzrm/SMAMLJ+QIEyT9j890p0VI77Hs22+ZJy8XQqB2OBaIkQjH86keNbXevQf3ptub76iJFIMoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EXJes9QATq5COFv0wlIysFYmakewYBIt/2eUe+oXLlbB6Fbx
	+sY+qEsbERATqlWpKcBaeeVcdGznMg3Wr2ksYfiG72JteA/5kf65tHeWOdrveGsMSkVPsgQ16Qo
	52tqhrUnJy7QamAcVX8hBL/4ZaEenrLxf+7py
X-Gm-Gg: ASbGnctbyGKusDBw5KQGc6mzpGj9UlToIRYvYsDfYvGiur7GNBjaPrTo117WuC7OL6w
	8k9hmAYkMseR3Mkjq3KLfwYmvC64hkEDG7WDHG52XwZzwc5Yg1PNl0I/aYA54AA==
X-Google-Smtp-Source: AGHT+IFy72NtsW2BRcSsglyfgns8RrYCJWzP4wJL84LqSM37uX/LLsMRXI9ZIQr7/ZlOa1v2RxyiV6ImIC4nyIZwiO8=
X-Received: by 2002:a5d:6484:0:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-385fd9abec7mr4058284f8f.21.1733306371936; Wed, 04 Dec 2024
 01:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203215452.2820071-1-cmllamas@google.com> <20241203215452.2820071-3-cmllamas@google.com>
In-Reply-To: <20241203215452.2820071-3-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 4 Dec 2024 10:59:19 +0100
Message-ID: <CAH5fLgjMZw+58Wh58QVX2hD14=r-XkbtduTSchUPO14cJAJAww@mail.gmail.com>
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

On Tue, Dec 3, 2024 at 10:55=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Allow multiple callers to install pages simultaneously by switching the
> mmap_sem from write-mode to read-mode. Races to the same PTE are handled
> using get_user_pages_remote() to retrieve the already installed page.
> This method significantly reduces contention in the mmap semaphore.
>
> To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> operating on an isolated VMA. In addition, zap_page_range_single() is
> called under the alloc->mutex to avoid racing with the shrinker.

How do you avoid racing with the shrinker? You don't hold the mutex
when binder_install_single_page is called.

E.g. consider this execution:

1. binder_alloc_new_buf finishes allocating the struct binder_buffer
and unlocks the mutex.
2. Shrinker starts running, locks the mutex, sets the page pointer to
NULL and unlocks the lru spinlock. The mutex is still held.
3. binder_install_buffer_pages is called and since the page pointer is
NULL, binder_install_single_page is called.
4. binder_install_single_page allocates a page and tries to
vm_insert_page it. It gets an EBUSY error because the shrinker has not
yet called zap_page_range_single.
5. binder_install_single_page looks up the page with
get_user_pages_remote. The page is written back to the pages array.
6. The shrinker calls zap_page_range_single followed by
binder_free_page(page_to_free).
7. The page has now been freed and zapped, but it's in the page array. UAF.

Is there something I'm missing?

Alice

