Return-Path: <linux-kernel+bounces-439932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D09EB658
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA081887379
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681C91C07DA;
	Tue, 10 Dec 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IClF+35P"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC871AAA1F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848000; cv=none; b=KEdMeFl4hrxKuXBYFycNVyXv4jLQcex4d/4HvbO40+HKveDITNJSre1M0PoJxX04BX5Ox281IqqdH/cBa42ejJuz6VOjpM2GGpfUnDYKKlVgQWL9ZlR87VazcThkQ+/ZqECDE+Xh1Q4zctek3XeOyXlqn/7v5ZppmNc59/Q+9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848000; c=relaxed/simple;
	bh=hLfNDRBixJVwXkZBjvzOyN3fdyshtMbByJWJLFYkJ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPKZufBEl4nF2exZxM5Lgehd9LAhj7PWeMV1QxfS2NnQ88Q17BpELwS3+Q3w2OnXu8M5pLgN9YldJv9vkcvMyR1fnl3a/EpThMB0D1GCWtI5FrH3xo/o6zYeeImb2V+C7A4bYJf7W3CQr3LrK7etortnEf9vKAZ3gspZVDx8eWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IClF+35P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4675936f333so175141cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847998; x=1734452798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLfNDRBixJVwXkZBjvzOyN3fdyshtMbByJWJLFYkJ5g=;
        b=IClF+35PjMb9oiM/8Xwm0U8Kh0zT9VWxK/2rZtMLGBhWZKhcBr5CE3vG2yWSZ5/ich
         x+wllqe8CcYnp1V2yv4TWAv2v7LeC7FWNG4UHi26o9iSXFMr3Yg+Yq6LJZJlPJFom9SL
         aYA0Pgfb+0zwMllvALPZHhbesWUU4n32YnzjwkBhGQBFcWDS3zLX/+pK8G/1zfIW+nF1
         J4mxBOoPJwA2ebKHJbSKqlWG3FdGOXDvNAAcrqmcMJ8s4oujVVtJyyiIcsHCIoIw8Idb
         SITOe9DBwa6y0rIfCvVWktFFykfntbG5pRJWUuDjwwINGqUbUpVLpjtzvrkXc0Iz9la3
         LjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847998; x=1734452798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLfNDRBixJVwXkZBjvzOyN3fdyshtMbByJWJLFYkJ5g=;
        b=GvvyttaexfolUK+wuMSjAUBB1/dNe0qbtTrEugwk8mbhvY6qLJE6/kZFI2n50UnAQN
         72wpxzZyUMcz7qF+t8ENfkD/LmD2xbAnEnlDzptLF5NZhWHmXBoFRYa7kHkCRIVsYDws
         mBChC/cuLYECc46nbUzBdK9hsPUa8w0Nx1Ap9Q8TDH7kLnpND4xUaaMpX7RzOVC1+/c7
         9Dx4KuPHq+OtKzCLz086mnfb0XBBoE0wEoXEIZCchUhOus6ZZjqylgDF708M60kfWCqD
         TDNTGB8zrfaRzhfcDkHyIfSfagal9CxoLD2q3QB2UM3beZ54EUHbRB03DqA/OIM7jJov
         L8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDsFD+0tVP402crNSy0DF8YRBKVezz3MkOshz9h/n+kZ3Zdk1NvoA++EQ+sk+eU1L7xqiz+OTOXBRY1PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8REbqSejbF2SYRmSJZ4p50TcNAtGQO1jth7RzzJA0EONiDjk
	QLSMzqp7T5v38Bi5qPEQX1rsSD25r1KKFR73gKx3jx/1mIavsxkajRVtVWPuvLwtnA385y60bkB
	dBa0mUSaCyQ/2KwjDwKuFxHuOPr+kgjpIJQUC
X-Gm-Gg: ASbGncvCkP9scY0uKyOF0mpxFkoG6YkvNoX1NXuAkKj4C0wsDCwPQ8+3izs/9Xu5MkN
	AqnmtanRBJWLIfUcsBPP8mgObH7VQDOL8B/pX4I1X49PkXYUgjx2wg/OOLiZQVsTXnQ==
X-Google-Smtp-Source: AGHT+IEGNVlwrm/5/0osSlNw9N5wYx2d4i2tGfaxKLisjegd7IRO6yWbSsGrIx+hLJ0crW1/0nDcw1Y+gDywI4ihS5w=
X-Received: by 2002:a05:622a:550a:b0:466:861a:f633 with SMTP id
 d75a77b69052e-4677757cac6mr4012141cf.5.1733847997888; Tue, 10 Dec 2024
 08:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209221028.1644210-1-surenb@google.com> <0448d4c5-1675-402f-9629-d1348019e38a@redhat.com>
In-Reply-To: <0448d4c5-1675-402f-9629-d1348019e38a@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 08:26:26 -0800
Message-ID: <CAJuCfpH0dMvOA55KH=n-o9tT2W7k_m5UDvjNKH_Cs5x1AtP-ng@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix vma_copy for !CONFIG_PER_VMA_LOCK
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, oliver.sang@intel.com, klarasmodin@gmail.com, 
	willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	mgorman@techsingularity.net, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:06=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 09.12.24 23:10, Suren Baghdasaryan wrote:
> > vma_copy() function for !CONFIG_PER_VMA_LOCK configuration copies all
> > fields using memcpy() as opposed to CONFIG_PER_VMA_LOCK version which
> > copies only required fields. anon_vma_chain field should not be copied
> > and new vma should instead initialize it to an empty list. Fix this
> > by initializing anon_vma_chain inside vma_copy() function. The version
> > of vma_copy() for CONFIG_PER_VMA_LOCK is fine since it does not change
> > that field and anon_vma_chain of any new vma is already initialized and
> > empty.
>
> I'm wondering if there is sufficient reason to have two implementations
> to do the copying.
>
> How expensive would it be to simply use the CONFIG_PER_VMA_LOCK variant
> unconditionally? Is it even measurable in fork() micro-benchmarks?

Yeah, the benefit if any would be tiny. I'll try measuring the
difference and if it's not visible will remove the
!CONFIG_PER_VMA_LOCK version.
Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

