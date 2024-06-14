Return-Path: <linux-kernel+bounces-215064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A47908E06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A220528B8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4715F3E5;
	Fri, 14 Jun 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqiA2VIr"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5F15EFB2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377051; cv=none; b=BuUBncCFCx78CpTmmA0xChAB5iqlXWJ/i13MkD97mCO5C59ph6XS47I523rDMNRK6bVCIpk1MXfooFsaRBaRYEZZMzOWRC/HZbHcm84l6vb3RfkfUGS79f56XWrZDBhT31UymNB2U3XlDJiZuwKcKwECngxkJdY9jL/Eto3K/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377051; c=relaxed/simple;
	bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHwOAxlT3099cjqY7VmegoGuEkOCFAuFu/kU6zuYn6CytRsUE6KGp/rn4zFTwfUtPbGvCB9/XyX+A0Rr8cP26QCtGN6LzMdKDRkkxTq8ymbsYu2lALbEz8+jzG/TU92IkQN2az+B24rw6YnBUxzT1KhY0llyky8CimJv0d6Epa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqiA2VIr; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-254e42df409so1288732fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718377029; x=1718981829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
        b=RqiA2VIrxAOZYTsqAo8GuIbdlsUvpOHlVWfUE5OZ2lOHx3TehibFiFxCa4fso0dFQw
         ZdMZAgNLfrA9TEpk10rYcsqx2RmMkBADquXriPe8v0k5UoIjKTl/Lv4jDdQ2BX7K0nUz
         aE0bhrbcm7wLkCANOH5rpITri/4e+Bd+96WVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377029; x=1718981829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDBN7CfZoySclWGICiQXNm0dLSN3WzDrHOHH5KLuTBY=;
        b=hTjq9RSFKzm9tMXu+bEfXCy6Le63Yynj9QVY36AneZos6g/TQ08DKQxXuOlPmpkbNr
         MmumNOVJiRx3CLTTGbSFHDfPbmNYXP6TkZfTJlX1VUY++xuWeRggJ7MkELMP5dykkmvp
         ey2wEzxmJDaRhEDDlujkhBByjVwMn1GyGzp22HbuN54R7Edo9k/3AID24UyswnhJBP5o
         j6dcthz5UF5W78l/CYtvcG7DcP9AbF5vlC62a2pt5HwL/sNqxwQs4yBriYoPg7xsHyMJ
         Qwqay0/9MVHtbgBRGVwtwMTYFO0DjyQsekgGI0ZTMZU53PGMo6QjtNsib3EmB6GrWwA9
         YTUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3fV5ETPjfWG+Fq3mrOYS5aSAsuK7TEkhSdDVumQExOMshZbUUMstJO5gbN9liMu2PtzmNIap0VYQ6RzlhCvkIPshS555DhSIQB39S
X-Gm-Message-State: AOJu0YzlxLghUK8GTbvbRBMEhUPwvkyxgGZkbS0vmEhTE/8bBV5hJmOY
	lRXEXGglzlsMTW6LGGvf5zoZC4nOp8TZ6wYVyU/xMn3cK4ebrg0ctYJ48Yo4ah+U6sfol/hn3qj
	w4/rrK9jBJ4DPe46X6V3jweeAnbj8Cp15BLPK2OnSwBG8NSbgTg==
X-Google-Smtp-Source: AGHT+IEUcAWOw1CVNlN0YcNfMetLlCT81YqYJzny/v8B5VIR1b7mnqvJKLKUWEnEomwJ3Vd4mFsoMMwH5EJv6fYqHso=
X-Received: by 2002:a05:6871:72c:b0:24f:c241:4d16 with SMTP id
 586e51a60fabf-25842be40f2mr3448708fac.50.1718377029521; Fri, 14 Jun 2024
 07:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614023009.221547-1-jhubbard@nvidia.com> <20240614023009.221547-3-jhubbard@nvidia.com>
 <4c6ffb1e-0381-4d5e-afa2-f8809f0b445f@redhat.com>
In-Reply-To: <4c6ffb1e-0381-4d5e-afa2-f8809f0b445f@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Jun 2024 07:56:57 -0700
Message-ID: <CABi2SkXcb_GaSomWrj+n8tEg-VmR3e5bLpqw0-h9K=6gkiBxow@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] selftests/mm: mseal, self_elf: factor out test
 macros and other duplicated items
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:28=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.06.24 04:30, John Hubbard wrote:
> > Clean up and move some copy-pasted items into a new mseal_helpers.h.
> >
> > 1. The test macros can be made safer and simpler, by observing that the=
y
> > are invariably called when about to return. This means that the macros
> > do not need an intrusive label to goto; they can simply return.
> >
> > 2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best w=
e
> > can do is to factor out these few items into mseal_helpers.h.
> >
> > 3. These tests still need their own definition of u64, so also move tha=
t
> > to the header file.
> >
> > Cc: Jeff Xu <jeffxu@chromium.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
>
> Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jeff Xu <jeffxu@google.com>

>
> --
> Cheers,
>
> David / dhildenb
>

