Return-Path: <linux-kernel+bounces-222220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5190FE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248A21C22852
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F0A175544;
	Thu, 20 Jun 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0q1TTYUR"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCA172BCB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871311; cv=none; b=bGmeAYgQXB8uQZ8kMfXNI86dd7vkix2NZ4LS2GJ7lEqIWqLhfGKHTLK6uoHL9wYC3RnkuLFwPmTv2xNxy0pHFvtG220cTpUt/RuIF32N/kiRWKoRdLrrpResd17IEzq1+meVW+zGfBzIeHv/7VYnqtZANwGMfjrVb5WHAHKBdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871311; c=relaxed/simple;
	bh=ZHRuGJFlUYdLamnB6sF47nsjZQIytquVYyRv7K2ZWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXiOJaa0+EPzLXIqr2OXv/V3YWrJStDKQYNt3darBxIz1ahS0AtDhUBnjvazbj6Z0PPQX4gz+sRBp//+3KasB3mN+Rd8plUaAlWFRFH1SK6dDOG2iBsnwhy+mpGjXAS9q5gIwK2a9vaJ9Scz9FSXnil9ur1vWr48BQL3HCMS0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0q1TTYUR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6327e303739so5805817b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871309; x=1719476109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=0q1TTYURnIp+/XFb/EoH4dDbQF63DjNb0U+1GNE+ogoI/17YREMvATQGVlZ+Y6fAfV
         AUyJLwDnn3FP7lwBsoNp10YgVAwp2QdsHCllE7PW+Y5wiCoHKW9McjfSfQmbAGkeFJym
         bKwrSSW54DfizLu/IGad6MaLecomhonc0iXvbQ6NaAmX/1LGC4LlnLAzzP/6QR6xkQZT
         7yUta9lsPaaNfJt2bbaMYrrgLINexvn9ihcRooPYTyFSmrEnZ2DgSD7Ayr7jPfwl1PaD
         hW6+/vbc6A/NQ5p3IHkWvGy7W6rwj8y3qTN4L3rZMG/H49O8GUbelgrAroLH7vhEQgKS
         crhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871309; x=1719476109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkDyjmmo2mJ4eSIsOzioTK+npaxfD4Q0PqQ0hVQZ66Q=;
        b=umimVGYCEfEXJH1dIEmdQh7HkclLWpwyzVIrW6ABZa2LWdWzKmCotSq0zgpJZF31JD
         GwS+RHSrGPlskk/BMG2OOwHpYWQ/wQNhbPRvhb+a/5dyyRcI9g9Nhv294NoBemJON5mh
         UalKI1ScRH1yckf/b9gekDFg9n/JKbhTOGCoiIkUGoPB0QY56tv5L970oAHeJSTIvRlk
         wpxyaqI49q/jEaGTy72IiMqmhI/Oiti2RDmmo+dtYzoOBKQSbJQXQiUAtpkivSbDVjfQ
         qijuTAETo7vNIh7U4SxV/tbDahjM759p0ZbyhVaAszKbhGOIcK7TqYTRO6oACOL6RH8z
         Oz8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Gk/YubwXBg9IQKVw6otmW4o/kqcdVH8xxgkuNOpRNsquMoeQM7adqxnvj/5rhQSYLGlFHUZmDj0YR+P0eqKWxHJWPsAPcb06bHmf
X-Gm-Message-State: AOJu0YxOAJCpFjCWCV8WRYTM7Ez/pRlmhAEjWIHUNrzaf4OrFOnLM0V3
	uxZC+SXEN4lyu5U4zRRRwVKeApT84CoVbFBiMTwucT1WeryM0DMkmE/QHA+3Z+JTCJmT69lrywH
	BnUiycXX2zDbp7jjEmJfw5y5viqOVM4QVNHKz
X-Google-Smtp-Source: AGHT+IEov8tA6WgC+NocZnlJNfskZn/sCcpgNQNbOkch4CKnuKF2F+01qvPEG14FlebgcmBeM68GwMaerknT5zuvZsM=
X-Received: by 2002:a0d:f185:0:b0:61b:3345:a349 with SMTP id
 00721157ae682-63a8d44ac47mr43240177b3.3.1718871308642; Thu, 20 Jun 2024
 01:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-13-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-13-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:14:27 +0200
Message-ID: <CAG_fn=W6L0Yr_GLHEok=LmL0-whk2r+-E7fVHj8pA8GCtgze=Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] kmsan: Introduce memset_no_sanitize_memory()
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

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Add a wrapper for memset() that prevents unpoisoning. This is useful
> for filling memory allocator redzones.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  include/linux/kmsan.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 23de1b3d6aee..5f50885f2023 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -255,6 +255,14 @@ void kmsan_enable_current(void);
>   */
>  void kmsan_disable_current(void);
>
> +/*
> + * memset_no_sanitize_memory(): memset() without KMSAN instrumentation.
> + */
Please make this a doc comment, like in the rest of the file.
(Please also fix kmsan_enable_current/kmsan_disable_current in the
respective patch)

