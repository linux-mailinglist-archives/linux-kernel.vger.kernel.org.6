Return-Path: <linux-kernel+bounces-265610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79FB93F3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040DE1C2082B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B070145A17;
	Mon, 29 Jul 2024 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKGy0aNN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4023CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251550; cv=none; b=g5+qqjWENq0NZdhDITieFSBmaEyRzfu37PMvfyo9KFSpmQ0LokYnkQB6cttfTHWAJJVBZO32l7uD9P43cCtzMs+g5MItoAhYdKNELWjIJ2wt9Y0dx8KlO4rV2F7ewf+a7cYmmKi0fF9gdn/I1prQBiFiabQRFP7/SQF6zHWgO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251550; c=relaxed/simple;
	bh=998IHP0Apss4Il6EUL6cVol+ZhwkZCCx3CDIIvhuSwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfdbBChn930RkpDbgxq+KHVXq4h8Nn4UWe61b6sBwURq6jGcXB+RSKYtAgQ/XK/i84G9qSkw4ZFQlrgjc7MGRRWyp+Ff/ke0mn6lBP6/bZftNyYb84ySzcDCFV8maSmJkHDObjU1pSBdaauEZvyVaghqzVV8gpeUO4bc2xcBtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKGy0aNN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so5846196a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722251547; x=1722856347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdY4mJRd0oeIvInVYbrZM2hv5BYVyhNVq+NkJ96ZB1o=;
        b=lKGy0aNN3saYBv4bTrqQJYzCAYrD5jWBoJpnuMezwxwl3EhvNisAvEYOIGVdZHQz1+
         5XsXaH6qVfLpdDteHljsKknobDKWpIZVfrc1bhd9MtGVvADr/Bbe5nbZL7bPJj/t/wst
         r3P3DLZ2ANRKoGQnvKXjGlR5vzzgfbPQxgkFh705uBoRk6ZsCcSQGJxz+goF+HZw9jNx
         8/sb05o3H7eXzAvmm6sDAjIg89FAoUB2kOPqQc02WIua/jckfdlinfTXvf/Aa6HYecmr
         97fjEO/kSJtxMryy2DDlrAeFuKtVZZgORHqN6ui3Vi7bBbXxKrnUQYbc+tqAFegbwkvO
         uMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251547; x=1722856347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdY4mJRd0oeIvInVYbrZM2hv5BYVyhNVq+NkJ96ZB1o=;
        b=KRiUHzQCJx7DorBlU5ilOiiatEy4O7y7ATJ3QP31ufy3L54SpfZHia6qojMmJrYJ9/
         vmbztkkbkwxQmz/tq6mxcQmprI9PS0Z+QjI4GQwWGZbf7inmTiGqDAUrk6ikAUzEPC42
         yWx6OSPXa5yr2mOZqYKUdfbU4d1LOHTm9LNRjBW9dkZYRjCr6bNEkXovpc9PIJxBli8J
         Bo5ijaf1oyOHxDiraOGmoDp8sY73sPtBMTpp3w0Ak0nQTABM7/65LnB9Mn5ThwBt/Xog
         fG/W9VsYQGNIieCEgWESSIiXfILe9YJ8F2jtOQulciJmj5KIIREt5qGpYAJkPLyntmrJ
         NDoA==
X-Forwarded-Encrypted: i=1; AJvYcCXe/wBNHTTW9Go/l8I58bXMx6b9aLzV+H9KIO30jlkaNsxrD6ipf0oOpkXwqM4uyNcKVw0nT1agrxWoe/X8gU9tTzaeNA4e7qm3AIFV
X-Gm-Message-State: AOJu0Yzx4CRgBFj3XeVtLDT3rYYLob6HRriFGjTUSqZIIs2kazZJx8sY
	IlD8d+MDkLTpoe/yAGC1DeAK69ywus0z5HNuvVuE9R2ThlcGbXwi2J3RAfeOQA8KWd2q3oJf6yK
	KQknmG7C5XBMG/Q4qpmecVHrkhIA=
X-Google-Smtp-Source: AGHT+IFpYaI7E8RYTe30mmeB9PwuJeWdWuINGfRSgZsGWtXgNUwi7s9dWJpFA+BGWsGxl2VUvW1CTs+NwqC6Ux278ps=
X-Received: by 2002:a05:6402:35d6:b0:5a2:3453:aaf2 with SMTP id
 4fb4d7f45d1cf-5b0205d6d60mr5778076a12.10.1722251546666; Mon, 29 Jul 2024
 04:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726165246.31326-1-ahuang12@lenovo.com> <20240728141851.aece5581f6e13fb6d6280bc4@linux-foundation.org>
In-Reply-To: <20240728141851.aece5581f6e13fb6d6280bc4@linux-foundation.org>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 29 Jul 2024 19:12:15 +0800
Message-ID: <CAHKZfL3PjWSEFRa3f6kBqx4YSsCWumK8zi0V1UEX_x+oDZZ1pQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN
 shadow virtual address into one operation
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:18=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 27 Jul 2024 00:52:46 +0800 Adrian Huang <adrianhuang0701@gmail.co=
m> wrote:
>
> > From: Adrian Huang <ahuang12@lenovo.com>
> >
> > When compiling kernel source 'make -j $(nproc)' with the up-and-running
> > KASAN-enabled kernel on a 256-core machine, the following soft lockup
> > is shown:
> >
> > ...
> >
> >         # CPU  DURATION                  FUNCTION CALLS
> >         # |     |   |                     |   |   |   |
> >           76) $ 50412985 us |    } /* __purge_vmap_area_lazy */
> >
> > ...
> >
> >      # CPU  DURATION                  FUNCTION CALLS
> >      # |     |   |                     |   |   |   |
> >        23) $ 1074942 us  |    } /* __purge_vmap_area_lazy */
> >        23) $ 1074950 us  |  } /* drain_vmap_area_work */
> >
> >   The worst execution time of drain_vmap_area_work() is about 1 second.
>
> Cool, thanks.
>
> But that's still pretty dreadful and I bet there are other workloads
> which will trigger the lockup detector in this path?

Yes, this path can be reproduced by other workloads. The stress-ng
command `stress-ng --exec $(nproc) --timeout 5m` can also trigger the
lockup detector in this path. (Confirmed on v6.11-rc1)

-- Adrian

