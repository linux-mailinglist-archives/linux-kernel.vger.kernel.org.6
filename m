Return-Path: <linux-kernel+bounces-183144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342608C9532
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954C9281A74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1CE4CE1F;
	Sun, 19 May 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yI/TXDug"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4581E87F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716133858; cv=none; b=e4yl2o7sHCoEWYJ74pd33MmvT4NLjR5Aa4wVbLRFXwqeQ/xdTR0/5E/iIWZLlKCbQXgax4f1d7CQXSoVymBGwgMOX1IUg+hKu9TSHorAI1pBYvGZyC3CUrzOxWKZ49P9MB5RJvHL1Cybw7V4B1/1HFtYnCEvnGjw/VQbGc/ZNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716133858; c=relaxed/simple;
	bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0H1d4Jnl90+NzzkGPfSuOcCQdyenKamhEYtfgHn/BcsluCEN1V173DB5S8NtOJVg2+QsVufRR0HXz2qLqWXlu/GmMZ6KT2tYBkLKXZ20KpZL+6Q8HZxzb2L4S7pdIM7WJXW0JhqSGNvlJpHIg6ilOoQyQ0l6VaoaeSYrtZVB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yI/TXDug; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36db863679bso169895ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716133856; x=1716738656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
        b=yI/TXDugNhJFgWIoMNEKkw3nfM+Bd6Wjfz1jNuVr8YKBFyiOlZ/epkdvuewwLzWCwu
         eg5ASXtRqggFtmJiq4N1dHZr2wlt7nOicuMlIYes3skIxdScFm0H4LNwv2bliYlHxCMp
         3OzDiJunxU2jhWgYse5UCdaEN3SETCIQpCGxzTD8oAQP5vL4NLa6miGyu2ambm3sqKhq
         1q7tqCXEeNu9ju4XUuyg+6MpAhH34fm3gE7yViob08XxR6rkXYfDiiE7xaIXcmjhtkfv
         QpmdVj4jFJMFfs+tpIW+ySzdjm9EZUCoOYtXONy9CtTZaE6iDyYkJXa/gZYZUifmFueK
         CtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716133856; x=1716738656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
        b=LCEQvm1ClQgYY7ERwGCfMrNjDNKZfA7GLUxUcbSIOrAJ/LeGdrBxpdArs/Uue1wfvu
         YR8d/QSxlwesS/U6HaveoHvkxka3ZZJ7QTYMCOB7bToWiihx+mLkPNr7qZJ7cESxz6II
         UPjizbRSy2SMfRDwzk7IF+sHyh3R1QI6wpcfzOmC8GWXqE660DFZg/MSG9l0/Pn4rwmJ
         sqpyCGAEGU+DiJlno8Jj8yRB+2BXXu/hc1DqAlSBe5O2Bd11Usj3mvAygsYANwYukudg
         cvgUGd8Wd80M9JqUTGlnFo+8VWu569sTfc0QcemqV/fbp4ms8H1rPW95UniZQpRv3SK5
         zRMw==
X-Forwarded-Encrypted: i=1; AJvYcCWgx/ZYRHYxI9iy/AWHHtrrMi5g2ugu3Ulok1IU0tn+ZMifrfVxXx50JuXJXA5KnLV+g7qOLqJMkr7TXfgMHmjxNV2CtO6IKHp7R/E/
X-Gm-Message-State: AOJu0Yx1lVl5jBT8Ftz5iQkLRAzflzVr0cHbuofmELpc/c/WXkyY6Yly
	qMMbqLGtLxOCYi3OdDglCyzBWEl9OpiFzpe42X2iwAOsAHFzAIWRXfiriEcQVHvukrp+ZQNUMHn
	kCQW+jvaEz5HgCgtrClcMFOOSu4yp5o0i7eM5
X-Google-Smtp-Source: AGHT+IFMOSoMQwdTinCh/+XbmUz8jIFDcVUjy2yphBrctrLgnpgFTI5cV5FIAro94k1mFeFxbHdgRR4jDAuc52rqzdk=
X-Received: by 2002:a05:6e02:11af:b0:36c:29fc:a5b8 with SMTP id
 e9e14a558f8ab-36dd04fabf0mr3299535ab.6.1716133856232; Sun, 19 May 2024
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518165315.3963142-1-sesse@google.com> <ZkjdQqN1dPsZDDRA@google.com>
In-Reply-To: <ZkjdQqN1dPsZDDRA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 May 2024 08:50:37 -0700
Message-ID: <CAP-5=fXPFtS-aufdZE1_haEo6EpYYDw9JhG_4EjHi2AAzzf5RA@mail.gmail.com>
Subject: Re: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 9:54=E2=80=AFAM Steinar H. Gunderson <sesse@google.=
com> wrote:
>
> On Sat, May 18, 2024 at 06:53:11PM +0200, Steinar H. Gunderson wrote:
> > When using perf to profile large binaries, _bfd_dwarf2_find_nearest_lin=
e()
> > becomes a hotspot, as perf wants to get line number information
> > (for inline-detection purposes) for each and every sample. In Chromium
> > in particular (the content_shell binary), this entails going through
> > 475k address ranges, which takes a long time when done repeatedly.
>
> I accidentally sent out an ancient patch anew; sorry, please ignore.

Presumably v1 should be reviewed?

Thanks,
Ian

> /* Steinar */

