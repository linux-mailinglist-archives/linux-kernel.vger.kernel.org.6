Return-Path: <linux-kernel+bounces-219637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D090D5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA92E1F23279
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10E14EC62;
	Tue, 18 Jun 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DWNxsjk"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CE14E2DF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721515; cv=none; b=Zl1LESD0FE8+sT6KySd5tHIJSJfy93LYuh1wtmkHtSViL+LULMY7mAibXmIee2X7awsvoqj+bxlbxStvOcVbisisSBYVPfTvjt0+5V6lVhSyN7VGlKXM5vK0Au0jEvoMgk3YrUvj7g8i+1ewE8VeoXNaVOgrwVrk7DEbOUJhXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721515; c=relaxed/simple;
	bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYwbG+ZTfxNeYrFk1wZ5VSmucxkl8kqSojb8Jj7WFuVXOcN5VCBNdXyYjxiN9IqO9sCaBciOLVDWevvkTIZy7AjTI3eLbJrOd7uqf3u6nzdRIzlI2rVYIkZXxHdaDrGUsNSgMrI9TxLWZYJb2niRZuill5VcP4GUEEx4EoH1g2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DWNxsjk; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b081c675e7so28552466d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721512; x=1719326312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
        b=2DWNxsjkfDnqP1LPkjLJazw5K1B9X+xJZnvH3stNIiPS1NuZPErg8WeDny0sVuAxTY
         Ko3M7I7dseGaBL42cI5ZbXrq1MyRgPmOZwl79rtEoPGVX09BFiTzX5ZzYRxbn3H0DnvR
         JLESnoLbRrInBiexOGOhGkYdGW+M5vXv+beHNqRruub0LSk7tT4ncdsJ/HbuNJW8o9IN
         KP/iM1R6XPaC5kuvj83c/Yuh7L0SU5wmsIhs2ssIT4GUdCQIqB9+bYZKr197c2uYpg7c
         Mvr+mkf+nFq0tvukpg7Yu1bwOyoIyCFm6G0sLlLgSNK6DBJtlowgKX0MsAItzXa1hvyw
         7Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721512; x=1719326312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asXpl0JeYor9a6fnYwHucBKXJR1r4vtn+68cuYeq1jQ=;
        b=v49smRc3r0obPOIene1DIhFb4dVa6SN/b3UUyUFTcwa7V6qEV+niOHO/jIkyM7hXCQ
         JHexfZq1DJH9IlfoinWMbKgoH1YaCWGi26Lx2tpSIBzm2Qn7ZbjXJslG8NOOCAwAo90+
         GJw41MNyDU97sEe2/zFVQzIaCw0q60SeB+LV+JhgquLk1RD2COY6NYe0BXb+Iwtvzp9b
         vjuQvxGhYBb6kW9AI0ra8Hhny23BhjJac3kLzBByk1R8fNOwy4jOxK9ALoXGF59dXeXm
         N0vVOsilEPUKGfkTPRjFLkDcZo4085YZRl4G+lnQ0GUmv2W4DwNEk4nYBUfk4jtzUAIp
         IOeA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ivRTVpU8JI8TnUfvbVIzUoMwml5bEmzt+raRL+dlgYd2fBVo3jzQzuTgYa3qwA4FZ42GOUQXbznmQzfTjx/TD/+PGKK7AqXahlKz
X-Gm-Message-State: AOJu0Yxi2/AhU9AEZdk1feESEc38nPc7OWjigBKkFIn1IqHMq7XoTowf
	lu9HHQcWLFR/0G0QYeBBwagYQpuhPWPaTW2CxXgMNkbFHAin6+JA0XU40vkb+JjzsISpYWDekIk
	JLSOacFoGPYqgErEHAB0je7ii4JZ3FPEfV/kI
X-Google-Smtp-Source: AGHT+IG4JaLnVUVMywHgKWR5RLAZx4PZdexzuK6i5qlGKBVjqac751o/32budwVfajonH+PxBsa2bq093K+sijHFr4Y=
X-Received: by 2002:a0c:8e47:0:b0:6b0:7864:90ac with SMTP id
 6a1803df08f44-6b2afc6efb7mr135971756d6.11.1718721512230; Tue, 18 Jun 2024
 07:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-15-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-15-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 16:37:55 +0200
Message-ID: <CAG_fn=UZ+gCgvgYtn7=p0o8P8sj+iDkD5t-PpihMNNN1W33XyQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] kmsan: Do not round up pg_data_t size
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> x86's alloc_node_data() rounds up node data size to PAGE_SIZE. It's not
> explained why it's needed, but it's most likely for performance
> reasons, since the padding bytes are not used anywhere. Some other
> architectures do it as well, e.g., mips rounds it up to the cache line
> size.
>
> kmsan_init_shadow() initializes metadata for each node data and assumes
> the x86 rounding, which does not match other architectures. This may
> cause the range end to overshoot the end of available memory, in turn
> causing virt_to_page_or_null() in kmsan_init_alloc_meta_for_range() to
> return NULL, which leads to kernel panic shortly after.
>
> Since the padding bytes are not used, drop the rounding.

Nice catch, thanks!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

