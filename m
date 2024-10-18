Return-Path: <linux-kernel+bounces-372448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6649A48A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060741C23034
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB818DF73;
	Fri, 18 Oct 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Zt1fObZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43513541B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285257; cv=none; b=UG3jf4a1bgWkyI8ZStT798twmReHRU379mff5S93S6d4Fi1u7A9JpBCpGbJskhg/UPdtAyxSKU/kiTvDVVSjUDlVko5ts5RQsGkzZkuGVhilWdcfUGQcHnu3s/kjXCtHABukMU57u+n3m+lIN+MuBmc28QD4QcSlT+vUwWyfIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285257; c=relaxed/simple;
	bh=wWbV/oCkuKkvYLys3irnAwP5NKAV3l1fQdcm5sywAUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0dDvCdRtvUfOnCXxkXuWZYZSZRVm+HMh/JfxcbV39GgPBXFPSiYSoSOaHFW9UU3YOFfzg25g0dnKeGE8aoKknCuUWnSppJ/CM6Aoz04z3MWiglYcw9s2+kqqwQN9w5GzJMD8D1GB+I/8Y0Rhn0vZZ0vrWyn6bhaMnUTBFXS6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Zt1fObZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a628b68a7so257203266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729285254; x=1729890054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Or/pZEs/vL/jRXAp07LK6CZ7eBWrXwqLOdmnXi+80=;
        b=4Zt1fObZyE0w3HCkssaJgjF5sshWJS2ibb0kihXHwG0+aVAr/YItLW/NEoQQ2NR/0s
         BmztEQmEERvtDRozX8KFswexkwD7pmaZClY0pHMXdmVO3UWC9Mkh16P9oHVg2Cwk5RUK
         hsQ25wpS9AR4QT2SY5JoXSSw+UDzMNoQ4Yjh37kfZ/1mz8DBid4pFYI1YSpfKNnxFXvf
         W0yMOi+/9WzjAhoLsizchDZ2v42G/oUo+QzMtsOfvaBE/h+zptCteYZw9XWK8hEdz0kj
         PPcEdkctPswS5MgAYGiLIsi0RN67P1QPzlKw/7AdhNnh5iRhkOKiOi2gbRwDilnn+6x7
         0DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285254; x=1729890054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7Or/pZEs/vL/jRXAp07LK6CZ7eBWrXwqLOdmnXi+80=;
        b=KnNGk8iYZj7qZKlVqtJ37xwuUlBQ6UhnEw13AYU0qaxthXOl6x968MiAtKyOSMNXW0
         7Afl7Yun3FSvqjoe5xjeHTUItxVt4Os23U1XUIpQUuvxZs/5xgtBPSH5v82w3r34P9mV
         NTr9AnvbzcrbJMuo323ivRvg4+F13hLMPKUNK8ZSnne40G+Ob9jEK0RJIJMWbCB0DvXU
         ovc/OZImTKPwQOcyZrs+TFJE3/Zqzf62aF06zeLDXbqEzCjmiRBAkGRI9K0FTXWc39Vu
         RzvA/1kpe2LT0gENuZOjXR2gmXYGgvlRXmHKJH2RM9L6L3s+4xBQ2i79FLePtfHKUHKb
         oOgw==
X-Forwarded-Encrypted: i=1; AJvYcCVUSWcRjMscjhNblGrNQh+IG3tg2w2f5x4YzajVgSok/lRlxdjAByOQ8uuNqJD2tTCgRrWimv26oQ32oNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOth0hCEumVR4YSIMPiF5ZM1oIrE0GL4XQnwXWgC0M9S9dIl8b
	l+dsKVf7q4eB6H1T6Jmo9pNyeWYM0lVr8h1DQiuFjy33Bhf9KX7oDKXPJ2bEQjclVgSsk/miOgz
	smZDyTrZi7/yx9CpFD3Rt1VRpG0rw0DzKGkI4
X-Google-Smtp-Source: AGHT+IF4inkPL/SJ30v3SbeY+JGZUjMhFuq8i617wBTVyk6lj63eDWWcBGgSSt4FuO5YRr0sRkemoRQbhu0WaQlhF1k=
X-Received: by 2002:a17:907:72cf:b0:a9a:55db:85de with SMTP id
 a640c23a62f3a-a9a69772b23mr324735166b.9.1729285253987; Fri, 18 Oct 2024
 14:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018192525.95862-1-ryncsn@gmail.com> <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
 <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com> <ZxLLNfbLifp-b3W7@casper.infradead.org>
In-Reply-To: <ZxLLNfbLifp-b3W7@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 18 Oct 2024 14:00:16 -0700
Message-ID: <CAJD7tkaycBYvtTCoGsuNUekSDNnE5SZb-XyS5a8j83JsKQw4FQ@mail.gmail.com>
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 1:55=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Oct 18, 2024 at 01:40:18PM -0700, Yosry Ahmed wrote:
> > Oh I thought xas_reload() is enough here to check that the entry is
> > still there after the lock is acquired. Do we have to start the walk
> > over after holding the lock?
>
> Yes.  The entry is guaranteed to still be valid, but the node you're
> looking in might have been freed, so you can't modify the node without
> making sure the node is still in the tree.  We could make that cheaper
> than a rewalk, but you're going to need to write that code since you're
> the first to want to do something like this.

I see, thanks for elaborating.

Could you confirm if the current patch with the xas_reset() added
would be equivalent to just checking xa_load() before using
xa_erase()?

