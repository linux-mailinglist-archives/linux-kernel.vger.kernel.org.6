Return-Path: <linux-kernel+bounces-571573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA55A6BEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707917A8BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C0227E9B;
	Fri, 21 Mar 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPgdE8kr"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06986321
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573033; cv=none; b=HHx+eQWNHu+mluwPloURBbCpiLd77RhZ4KT4h5la1aqJc2/efnxCVwrwg8cmbaGLEatymFhYEy8Du3xxbReSd7wro/LAq9SpTGUsCbTXdwQpWIG3ZyMu/WR//TeIyvuKzHtLHfkiGbW+l4A8zwRHqGKbYjx4XwDrOq+oSFcQINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573033; c=relaxed/simple;
	bh=Cu6cOimHwJqoR7VawNoCeLQ/UDK3IeeGCSIVPpFBjWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8MlNNBEpYgNxNaTdWqT8Zn+gs+1OLt8om+26BsV/bW2USDAqR5zoLOUvQQkfvPxJdkQc3u8kPgo836ydGnxJY/yU5CwcbUwNaWEP+KS5rlWwDGATE1gZ9cf8QcWAbCdJUlXedHp3KfxTQH7BtxpiF9SToSQthFp0jBtiKHzR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPgdE8kr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47681dba807so240801cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742573031; x=1743177831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=QPgdE8krql5p54KhyRmjDHFZQMv1l/NEoJDfj+Kci2gf8eWErH/wmbwqwZb5HvRj2J
         6ILCM0WbQe59W+1GRF49kQKA0FQfK1j296eEii16dy8l3qH1/dSZgmHaX2THz8pcfw3e
         ij6oWsONldlhgRUTBKXNMW9DJWHMCI/7Moz20Tu2nJwc/W4LaYIKiUV+Ygh7n5dTEgl5
         fGsdFmRwNGdo+gcqJmJ/Gd2qKg6XvQF4CauyJe5lhw69vSbR0H0phppMkDe3JH1VKQ9l
         RuU+oFn+ytmZfAyNVhVvtm6VNt6zNEdCCZOoL9AuQmwlhkvq6EE0nQPEYLEdUYxFxjLk
         yLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573031; x=1743177831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeJPwSaX6HIdUR8KTOVsZ8Feg++HqdiUbFfhCHyoTMI=;
        b=ibWBfasVus1qHQaHty7IVWmDCYJOgUJvwczFFWGuzjGDNXpO2MaPDVv/OxtkD+VhIr
         p2KOYsNPQispdA+Jyq0V1G5k9pxzwYVS/sHTGQ2KVcBuesUy8SX1QvXRM6T6kv7nC6Fu
         I2QWE0RAdGqe8A1dQiaELxoqOrj3YYFAs8EDeEwfpM2QtWz95+7Z3hrXiLlcIghDXArq
         sHJNvHG/wZitiHgQJ4RPEbvqXa7aKhT9DrvnPlwUvm8Br4B/VvZYmlCKmUZj1W/2V2ur
         df8EgGQqdZcO4WBzHiCtYWVVXhhzN6GLRkdxTBE/NAnvZjSejSyP5h2JDTRPQscY/2Ec
         pnAg==
X-Forwarded-Encrypted: i=1; AJvYcCUPKXP8IZ3/047LcJ8yzgNselimIJH1MV6St2UpvKx+NFzR9lM3FMsRt0GFAqr/Lh63QEUkIQbdXNynh5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgC//FXaDHIQllvJoKDQ050Zu5EVe/q7s0vmwRyiQhPrioBKJ
	hwGdtSJZFTTig6+1Rl/2CcDV7hZy/Ah6kiIeWBJxD6si+NqOjGXmBun7Lk33jg3WFJiO9HXdXL/
	+B6JuVKoC3sRKOFno+B/XX9bpN6x3fJXlNRMI
X-Gm-Gg: ASbGncvXcTA74j7qePI1rVjhRDOCTnJC87Lk/ZMkV5bi9z+fuprYis9VHLl2V+Tbie4
	5Njy2X1bIgJ07vrub9X8rXr5WIoF9h5wxnXwDNmJ3mUVLU5QfzPj3wbAm9ZqNMdXAa984WtXpIR
	F/NdCpJ/rcWF+lk7FCv8iBtidwzw==
X-Google-Smtp-Source: AGHT+IFkXczES/4I5kcNrRXzjxrEN1n1yI01ly+4cs5jHTsrsjRGc5j6UaG3BY/6xhutMfdEGFSNPo3rGZczVOmOkmw=
X-Received: by 2002:a05:622a:1f17:b0:466:8887:6751 with SMTP id
 d75a77b69052e-4771f55786emr3998701cf.23.1742573030713; Fri, 21 Mar 2025
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com> <20250320173931.1583800-2-surenb@google.com>
 <Z9z1lC9ppphUhDjk@infradead.org>
In-Reply-To: <Z9z1lC9ppphUhDjk@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 21 Mar 2025 09:03:37 -0700
X-Gm-Features: AQ5f1JrBg768vc8VQCwRG29x43voyrYWFfgAzMuHmylUPx3zi7H160snG2PZn8A
Message-ID: <CAJuCfpG9apLCrF0DXjzVtCJoPAa=5BLxArHC6SCKkfPNdpZ1wg@mail.gmail.com>
Subject: Re: [RFC 1/3] mm: implement cleancache
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, 
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, 
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:14=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Mar 20, 2025 at 10:39:29AM -0700, Suren Baghdasaryan wrote:
> > Cleancache can be thought of as a page-granularity victim cache for cle=
an
>
> Please implement your semantics directly instea of with a single user
> abstraction.  If we ever need an abstraction we can add it once we have
> multiple consumers and know what they need.

If after the conference no other users emerge I will fold it into
GCMA. That's quite easy to do.
Thanks,
Suren.

>

