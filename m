Return-Path: <linux-kernel+bounces-313574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EA96A72A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B06286343
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A91D5CD6;
	Tue,  3 Sep 2024 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bzCvo/11"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC631D5CC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390778; cv=none; b=GGEia6rmoi3Md1TXEgh9PPL74dcaW8xKdwwTUXR7Bm/mqcUNdz3fiN25LtNQ7gePCqv1OrQWk0L+wlaZXVBU3M6oYZFcuCcxl0zy1cCVMREGC3N5zNyuGSo1nqjL6qQVl5F9xNA1fOm3JhT1Iw3A7glh8BrIPJtTE7n1n74/QaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390778; c=relaxed/simple;
	bh=CvaDCnV+QaG24AvL/P+QY+StDOYTi5CE3AZLUYyMlzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv4iDDGAQJu9nMjMmfx6wX68vT8/FeDY75vPkmChnmWCbtpHid/JYLenYdkvDboQxT/Earc4r+1fSd0BsLq5C2/lyLiV5i/aFhX1eJv9Nl5jfgGI52aqliUrEjtbb0b8yRZop4n628g9/ZDN6Agkasmwgqb7csF4OqPvL77neio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bzCvo/11; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso66264071fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725390774; x=1725995574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=bzCvo/11sPhzkNrfDu/Hkg34CqqvhkZJiQER/tGbQ/O/M7e5HijXXXisYpzIBnG5Xv
         B4QhzW5JpDpxuUwhl6Y7P1jfNrqhFbnA4kAz5TO64187M+Hy78C32N7j+5PULohg7iLy
         B9TlqKowEhoSPUHpTr2ogRmEEIJHRat0heMeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390774; x=1725995574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=fi+MAOKA8+Rs165Kz2H2cV76QyYFh6UThqc7hhVerzZnL4tKrYmRIU2LFE/vir4ifp
         AxxznW9k5sqpLWAr5LQl9yJx/6RBM4inI0CqxNdzKvC4o22iKhkyXM/mk61pzl5l2zU+
         1Ex3ilf9IGXBzdbkPhznaTFvTxemB2GgSYKjfBw5VOLPW5XC4djKazSPCnQHxgDnVINL
         Z2lIM0cEhdC6DdfQ7XWfQYjqfjptI4mPr+UDMIqv/MpLVCT+RBqjglo6NRcOGiDr2fQa
         sUkFeiTUaQTEwOYtN0VWvlfNNKOy2j5a6tqniCFTewEux4HvvM5KDJhRBLnZKAEOY767
         B2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+6ou17xE9PF+UeJzZZmfohykKfeqC/tEmrndqJLQgqwgqUworFGVphQ+NSYZp4Hp94Vti9m71dl6hbfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wsJCz77TKvBdONZqYstSuihSKEiDC4ZRL0AV/UCVt6ib2DoX
	fNgEKWsNjsQctDtshnAVRfrSDPC6ANlDsIzV+4MfyXmuJxXjCa2sQtr67o5teckOYimUidrpaKv
	WiRRbLA==
X-Google-Smtp-Source: AGHT+IGDvgsy7pdTlO/P7qJ3xEQoojZIjuVWutuecbNR3EUc6tvCoxYoiH+VdUm4TldY3XMlH6n/vw==
X-Received: by 2002:a2e:a586:0:b0:2f3:f4e2:869c with SMTP id 38308e7fff4ca-2f64d570e98mr14434421fa.44.1725390773637;
        Tue, 03 Sep 2024 12:12:53 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed180csm23593181fa.11.2024.09.03.12.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334c4d6829so7232000e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqZ/xDm3xU/42gdwFh6B+NVg9lJijDWXm8RNGLVL/3iuNkfc1BVqkQwah43OzxVF228AVemMf5DGk/2AM=@vger.kernel.org
X-Received: by 2002:a05:6512:3a8a:b0:530:c1fb:5192 with SMTP id
 2adb3069b0e04-53546b335b3mr10741607e87.16.1725390772215; Tue, 03 Sep 2024
 12:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
In-Reply-To: <20240903090843.GA17936@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:12:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
>
> but with or without this fix __create_xol_area() also needs
>
>         area->xol_mapping.mremap = NULL;

I think the whole thing needs to be zeroed out.

It was always horribly buggy. The close thing just made it more
*obviously* buggy, because closing a vma is a lot more common than
mremap'ing it.

Either use kzalloc(), or do a proper initializer something like this:

-       area->xol_mapping.name = "[uprobes]";
-       area->xol_mapping.fault = NULL;
-       area->xol_mapping.pages = area->pages;
+       area->xol_mapping = (struct vm_special_mapping) {
+               .name = "[uprobes]",
+               .pages = area->pages,
+               .close = uprobe_clear_state,
+       };

which should initialize the struct vm_special_mapping fully.

                     Linus

