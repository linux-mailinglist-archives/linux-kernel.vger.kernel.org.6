Return-Path: <linux-kernel+bounces-428463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BDB9E0ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C19165710
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F181DF964;
	Mon,  2 Dec 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eStUgekU"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF81DE3B2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178009; cv=none; b=Qo+1yaOTnHISDYDxeTNkOHeQtRHsaO2qlhvwiTOeZbVBVxXaLa4U9hwLUgvgQ1ffNnzhvYqCkzTMV0dwfeAfsu0Yd3PFQNt9kokOlRjUg0tyOFacZdEnhkE4d0eI1Lo0l3FkDMnskUlQXAUHizFsX/y23+CqRcsuLM+Xu1GFiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178009; c=relaxed/simple;
	bh=KxDp5MnGW60aqBFJqD4JyRMmY5bR01t13DbUTGA+aMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEQJz1VuasWqDxJZNg5A/uu2EzzyXCnJkdKC6k+jsoo3wYinU1NCaaMUJGmgqyde83WPd8yJdEYgRT2ENgA0ZROaQRjJSAvQKeuX61opwc4yp6/jPgc5PLKouF3qsSGxgEwZ/8EVcISvqU8D7MWZuNd/gbOXUoWlV3DhUIbvfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eStUgekU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71d4ff749baso2273591a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733178006; x=1733782806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxDp5MnGW60aqBFJqD4JyRMmY5bR01t13DbUTGA+aMI=;
        b=eStUgekUv2BvStnkJPPE9KgHfwoqkzoGjYEqu3dvpTPjQ3maeIhVy+UImO61pcIv4l
         gUmlyy6bTogiVmXMY6cd3nEBhjM50AvoBLfw1RDyZ1YFk2UeilHWKkQV4PgoqQE1bE8f
         rPlSS5DIM+1YC4gozdbgyreUGQC2CwiAgvjtWZuCl3i5zrX6F00UtaI4GCaVWuaMqe2A
         ST1hKrBydt3g2+7hIWq/VZ8BVGtAp8DgTHk1Oxr65g6n3Aei7wpFZRHubVPr6o/jKDCN
         9B6lxcEdvQNa4tDY8bxRk156S4IjhSQ/wn/O5XxYym5QBbduGwXgJytZeTOOhCUOGM/M
         tbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178006; x=1733782806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxDp5MnGW60aqBFJqD4JyRMmY5bR01t13DbUTGA+aMI=;
        b=iCKas5Z9og5WZYvubW9UmleCtV64oIUFZbkmL0/KKHWlHAVY2vpeDm3noj3B0eWkAU
         hxRyCy44UJD/NrqgRfwy/eEHXpLDm9aQKIbZU/xsG2W8cU+9YYiLgAJPuCMacSIz3bva
         6gGHGuD8f++H62httfIo3mUT+xBMsR1NwvhNkbZwiUDjUTwzRAQ3SZ54Y8ntlroSB8H0
         d8awyiFuYkxdG7HyiZV7f2cEkzw0jnDUd8VI0niO5J2Y/Xa7mMp9rIenWV/cHyMFbhzr
         k7PtIaK4i4qiG/wCGsgU1NaXAAmQQXW9eo2HZ6M1vHBEAIK1d24NroSHP+gelzA3QBIs
         nIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWsrVu4kJjSYyXEbFMamETLJ+VeZ+tSzuqToeZcJWLWcC2ja3GnHNfUj17Ox8yGxlrToyt5ivLbPwLZL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9G3OyQtu/DROGfjD00p9dzEllnUIhZXeTh9BxSzlS8hEdzWf
	JxZf6luXUYbriPCqHUcMH9vblTidBwL5+BqjeEUSJe85MZa5F/32chVgxcTAeMpArF1vwVQoFaO
	UdJw79hK3uWVvyQ2ZprWyMGm94PLyrbGjoFGF
X-Gm-Gg: ASbGncvI7I0fGBzpvrIVDL8xOASOGjCc5FFVQ0Ocm+jGk1jy2kVDz9SM9WDJx9Nt6J1
	/jbZR8hyNbvaiwSbg4FX5eHWnzvqaipDQjJFV3QhICdOeXRxgZg6rbJ/Tb84d5Hw=
X-Google-Smtp-Source: AGHT+IGatTpJwiKxbnO6DaUR3NzXa4m4OZ5gudCk71K5HQZbi0bxzC9mddfkQtkd9cEzkEL7rxYDSUpeQaMn7OuLA04=
X-Received: by 2002:a05:6358:d383:b0:1c3:84de:4d5c with SMTP id
 e5c5f4694b2df-1caeac4ea20mr45668655d.23.1733178006499; Mon, 02 Dec 2024
 14:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128102619.707071-1-00107082@163.com> <20241129025213.34836-1-00107082@163.com>
In-Reply-To: <20241129025213.34836-1-00107082@163.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 2 Dec 2024 15:19:29 -0700
Message-ID: <CAOUHufZpr9GR2KLpgYNMkzBptp3OGDZuHs8URtnKHyU0eap6xg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/codetag: swap tags when migrate pages
To: David Wang <00107082@163.com>
Cc: surenb@google.com, kent.overstreet@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 7:52=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
> Current solution to adjust codetag references during page migration is
> done in 3 steps:
> 1. sets the codetag reference of the old page as empty (not pointing
> to any codetag);
> 2. subtracts counters of the new page to compensate for its own allocatio=
n;
> 3. sets codetag reference of the new page to point to the codetag of
> the old page.
> This does not work if CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dn because
> set_codetag_empty() becomes NOOP. Instead, let's simply swap codetag
> references so that the new page is referencing the old codetag and the
> old page is referencing the new codetag. This way accounting stays
> valid and the logic makes more sense.
>
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Signed-off-by: David Wang <00107082@163.com>
> Closes: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163=
.com/
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>

