Return-Path: <linux-kernel+bounces-243419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0589295FD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A19C1C20B40
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A514D8CE;
	Sat,  6 Jul 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBYuuktR"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890F10953;
	Sat,  6 Jul 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720309996; cv=none; b=SfhCQikFtbEEvw/zvVhMTL2a6HJhiCP3xndw+6VgcgGk7H2zdUI6DEgDFDdQR2vCLNwgAL83GL9oHVQxkwMlWdsJ4iy89ciccn9Q8eVnpbiGYoJOK5L4a8pSyvhk7nRRTINWEehUP6NbNEOB3T2Iss0KYCASc7m62n4dUgqc9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720309996; c=relaxed/simple;
	bh=8MpIh0u2fu1mBQS1tGkkiaL8mpe1cnEquAjL8fJNZmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtFZjN8o5h3R9B01RA7bedXxV0BUcfNY77YiilO9r9SKP7wbBJA3ZcOuNK2FZfov/NhYoN1BEvJlchdnl9baZLXwEHBY2OIzWjLUaDGrbFt7lX8KavyWSNbcFBplRm/AQVbGWg3uKleu0L8mwYI9WM+0krb8QycQwTO3oyzKvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBYuuktR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79efec89c80so94723685a.2;
        Sat, 06 Jul 2024 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720309994; x=1720914794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MpIh0u2fu1mBQS1tGkkiaL8mpe1cnEquAjL8fJNZmI=;
        b=EBYuuktRw32OkRf6EkTC3lU/ef/zgLpa5lZ6Vq/2Ll47AihPZcNDQP8UFSHRFlvYI3
         4AsIdAhZOBQ2UavCm4jNo9bh+7z+OhuTpWoY2Ogsxy2ULe/XCYzk19kWPxTCO2CC7HDs
         6EB3AMW6VfOkCasyFT0zJ7lSvJz46Q8zegz54HMiYKwzJWytvBKCwaajuKf2f6v5AZXK
         1UoHOBkO9D+JoYH9x6bzwgjF7iWul44NHR5KhSAaxOPE58a0RYvHJorstxE4wKDyBW/P
         lcoXhdhaHPT79yaAUUojT57FX/CJzjpAyOLxivAXtY1NGO7DQus+ZMiX6TcbP82KufUK
         nptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720309994; x=1720914794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MpIh0u2fu1mBQS1tGkkiaL8mpe1cnEquAjL8fJNZmI=;
        b=PSTwpXWGdD++vipOHxqMUinN9a5ly9rB/3PVPsRm7p1yk1hoQG7CvKXcgphEvlUExk
         cNy02YyO/NlqbQEMmHW3ufFPAIyeoB+i7l3BE75GnOEGkqJsgGgizLQnYoYgzvo+5Jzi
         QxzDFdVaUsmx22Yz+uYM/By4Wv5emgylMEP+s2skfoD/yf3wsGMChRWngs7VkEU8mh1o
         Lf2cLBE5aRXDKWyf9+vS2ldSplGcaZ4tP+VDQ/yyZc3MsuKnuwlPLcLs9F21AYR+uQ+5
         xzsDCwxsK0k5/k1aKKL/AAsP1tmatKRa5oXtuH56akcST5Kmi2IJilTuTfEKPh8hdsor
         YUFw==
X-Forwarded-Encrypted: i=1; AJvYcCU90inEnOxZ8PnNOx+pC8V+kmHKkuSxXvL/L4syJY/aI9g6gyyNC8jYbx6OD2JOz2g/QjdxCr1KVNeRc01HhDvEfc/ukMAxlZMlSFWKnPqB3QMOG+vjGiHJt1WxRc3WD1KhsfMvlxfM
X-Gm-Message-State: AOJu0Yx/LBa7VZf79kXUy0t6Gz8GH/SCYSYcYJWFk/yfrpJOmr0DQkbP
	SxeXYmg9PjoFUocHpybC4wRt+FPbTbmlD93bgGLqlPru4vXGdrCcxvUfVgYZTEFzmblE/paolO5
	ygtJaT5HfLzw7oqyBH1Jrdaxkvf0=
X-Google-Smtp-Source: AGHT+IHA/MsUFqZtusJR9E/YqELzb9rz0q54Gg1DlK/3baD3u+GVRo8KAVIfXyEiJoZC+pZi8qFPsIWfsfYFlYiMhVc=
X-Received: by 2002:ad4:5cc9:0:b0:6b2:da77:9a42 with SMTP id
 6a1803df08f44-6b5ecfd167amr126673236d6.16.1720309993772; Sat, 06 Jul 2024
 16:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-6-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-6-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 6 Jul 2024 16:53:02 -0700
Message-ID: <CAKEwX=MmwqevpoGnskXrsYQWKOR8yx4t0moasVO=risu0P7-uA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch allows zswap to accept incompressible pages and store them
> into zpool if possible.
>
> This change is required to achieve zero rejection on zswap_store(). With
> proper amount of proactive shrinking, swapout can be buffered by zswap
> without IO latency. Storing incompressible pages may seem costly, but it
> can reduce latency. A rare incompressible page in a large batch of
> compressive pages can delay the entire batch during swapping.
>
> The memory overhead is negligible because the underlying zsmalloc
> already accepts nearly incompressible pages. zsmalloc stores data close
> to PAGE_SIZE to a dedicated page. Thus storing as-is saves decompression
> cycles without allocation overhead. zswap itself has not rejected pages
> in these cases.
>
> To store the page as-is, use the compressed data size field `length` in
> struct `zswap_entry`. The length =3D=3D PAGE_SIZE indicates
> incompressible data.
>
> If a zpool backend does not support allocating PAGE_SIZE (zbud), the
> behavior remains unchanged. The allocation failure reported by the zpool
> blocks accepting the page as before.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

I tried to propose something similar in the past. Please read the
following discussion:

https://lore.kernel.org/all/CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=3DvMGhfF4iN=
2B4VKw@mail.gmail.com/

But, the TLDR is Yosry was (rightly) concerned that with this
approach, memory reclaiming could end up increasing memory usage
rather than reducing (since we do not free up the page that fail to
zswap-out, and we need extra memory for the zswap metadata of that
page).

So my vote on this patch would be NACK, until we get around this issue
somehow :)

