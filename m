Return-Path: <linux-kernel+bounces-406202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FD9C5C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33582281FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9F2022E8;
	Tue, 12 Nov 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bie21zXU"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645742022D6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425903; cv=none; b=hvsjw9uV4OVm1rhS+g/RC2Wd8fh4ZuLq43nholKaBN5hQuacQGTygFFjRT331+sXQJZCHmjAGFvTQnD2sHG1dVN3daQ0b7enBTen6qHgJaA1hsJp0D1Vdy9sAQMcUf/rdbZTueLZ1w5o5nsrrz+hcrEwJAWpjW1ZvheeGPqK6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425903; c=relaxed/simple;
	bh=/JqgBTdvRwSGK8eOVAs/6HIFEqq9Bti4PaqUniteh9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Huo6ue4xqJFLJD/l3+ew9OxwKMP/AEP7s64Ck/ooJUy6w9z9pC5QO4fBdGWZfHahxN0NdXfYJhOyTsDsBxtUV8fFetImwKLW8+/DyO+wsRpNezASBm+I5qiSy01Iiq8wHiELoX39vehZlnK0e79pRZ6i6X27mStAWNmpCb/StpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bie21zXU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so309871cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731425901; x=1732030701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JqgBTdvRwSGK8eOVAs/6HIFEqq9Bti4PaqUniteh9I=;
        b=Bie21zXUNZipTVnQ8mvvGJfxgJcJyggI5Lp16nBNEb7XMyWd0jcphadhiMYCi46DjZ
         BNZtlPEJya1ipa+Jx9hI9GG/mzaAn4MuVcu8N0CEQqZXuuIRI65NaZqapL+7XNFgywOp
         svNakTw6ZPMCkFf7eVPZuUVJfIyOnhuU6p7iOSegFKQ9ASPJPr27p1/hn+AJPXxoT1F3
         rLsht8VYQGocQ8SOvX3Bbi9Mu2Cl0P3HxjuUwG6KoSG5fdEP3+QT+cgakptuniMNgNAw
         IN2bcOtCDHDUziphi2kJ96G0JOA1jFyDFe3gwnaupEBkMrdY9LzF8x8LVU+5HGPw/wWJ
         kH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425901; x=1732030701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JqgBTdvRwSGK8eOVAs/6HIFEqq9Bti4PaqUniteh9I=;
        b=h8WHRkpbZuMiG19RHggVsiehS5uxhojnt+oX4zO7Rlav0SsfTPHdJrQ6WUO+JHmWsH
         JUFEAbHP8Ep79VQrYtKpaAaNrI6l+xv4U2HAcY338oGcMY2njepQt399OXMmPFVphRqr
         PN86uDFmlLAFNvl7aK0VVpSC5MEqCqEY9Lv5D7hEJnL3KNyAaXdGvEMrNx5cq+udxMp9
         Pb/3G3JXvqJdxA3Dt76D+9Xu8FzhGA/pP0Bkl9s9bBBPF4/ONLnGcLk8tAKCS0dRDnpt
         qRMOX9tPu33Rvn28/aHBcILECW40+J1iLp6buR/o+scVngaHK91ZMaIFUFMKI4mFKVjT
         QKLw==
X-Forwarded-Encrypted: i=1; AJvYcCWwFHj5OQzi8pI1T9nw0cf7mrqZ8sIgrHXBp8oSJPDtRJJybhW9Q8PRQYvRYsXhtAsqYkUSjUzMexX7s5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQr/FPgsfc5zlaUkwJ7HalJXaOwEbMn5CvSrkA3oKmpeiO3x0
	1PHg7gtHjOTjoLS3RZkQI2Z1WAM6I+/o0/PGFqFImkSoZ+infrkg0A2L2EYMwvLQseaIPucP5EF
	5Wim50hqJWlm/EgLUMrpzKqo0vDdb9DAAEYkw
X-Gm-Gg: ASbGncuI/uUDQFpD/t2Ey0eYuwVwezqAu6wMp7XW6w7vxYbMHKVwUTT518fGMYGn0QY
	ZMwDXRxBYE78RhMI05lv0ozNokvUmht2LPnC8GDHdD1LKB9nUt6tisdDVKk8q9A==
X-Google-Smtp-Source: AGHT+IHUzTnNuTgHD++1wwv0TlqxOZDUnSUEsiVLrKzmwtbuaHLsHnNii9tgVcNny3YBSiqEcNw+ojp2iDX2vnVLjr4=
X-Received: by 2002:a05:622a:4b0f:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-4634288b366mr2486921cf.9.1731425900989; Tue, 12 Nov 2024
 07:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <561f69f7-147f-4f34-ac2b-aa1c8c3dae7b@lucifer.local>
In-Reply-To: <561f69f7-147f-4f34-ac2b-aa1c8c3dae7b@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 07:38:09 -0800
Message-ID: <CAJuCfpHpkEYG0=8rarDCQ9V=BhxTA2KCvSwKMwp4kdbpgk7sCw@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:39=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Nov 11, 2024 at 12:55:02PM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
>
> Sorry to nag + add workload, but could you also add changes to the
> Documentation/mm/process_addrs.rst file to reflect this as part of the
> series? It'd be really cool to have the change as part of your series, so
> when it lands we update the documentation with it.
>
> This change fundamentally changes internals that are documented there so =
it
> makes sense to :)

Yep, I already prepared the documentation patch to be included in v2.
Sorry for missing it the first time around and thanks for the
reminder.

>
> Thanks!

