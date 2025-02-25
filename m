Return-Path: <linux-kernel+bounces-530503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F200EA43458
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38343AA587
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C118524F5A5;
	Tue, 25 Feb 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THuKP8tQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AD4D5AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458583; cv=none; b=XY93O9mI3r16LqK6H/MJX/vuJlAI2/aillKVdK5OYV1360F08rveVL795RhA6qr7uLTE5Wrfd0vUAa9AX9+pUauWsmUbw7l/vwngxy7TZev4RJEya2NhcDrUGFmKQ08/xKHyt8P6nM2XejFWPucw2BLws2Y9IEjeg47yMYAnibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458583; c=relaxed/simple;
	bh=DGZqoc7R40hr25U/Ymra7GCAV4yvZ0OpxJrDNy3WqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtZ+N5DC4yU4v5A7B+JpVauVnoo8OcOwtXNZ9zXsT3qliniM5kCNz13NDcIt5Xy8pE1rX/loiPbfsjsf8bxHnYhhukY+NvHuBNtrtXhCQO63jJguEk+vsf4nMjNbkrjpHEg6AJcuIrIkjjog0vtTk1a8IuZsO2RDzfSv6BLR+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=THuKP8tQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e83d65e5so98006585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740458581; x=1741063381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUCWi4bZErdgQd6eqhjY5DFB+7kfj6KVOsc3f/JicmY=;
        b=THuKP8tQKidffXdi4TIHiiA/r/XCxS3Hg/FKWsYIv6pvdILiMH0noBOcFKlp4vXLTn
         M8FDXSJ00Zibmg/KJ3Gx9+Ag7IPypq/xs/5ka7VhSPhDUF+pjmrqg7l6NqFEZO5e4gyg
         yyvvANptrDHS+ZvKvKIr7jNwLU2umbzkwJaPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740458581; x=1741063381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUCWi4bZErdgQd6eqhjY5DFB+7kfj6KVOsc3f/JicmY=;
        b=B80AWTDgOMRVkqwwTJIY/Ce82EZDmSickZ5Aq6pDmHfVwpxukPkZt5i1sNiw3KdB4A
         pi8ql/Z19smoXmKRl2KrFIUa0o7dS8QE9z+qiZItyUQV7bK+WDISbVgFbF5WksTQV8e7
         YYq7gNWMp2A7P56Td2cC+4PFJhl50bcwgKZy9xI/+OBx7r5A3x4g97nY/6Br5p38183z
         P0q2zAyvrRN5TDaMpVChJ9Y7crofbb0qXDy5tQnDnBAeeMm0M8aRAbWBK0RQRQoTApkY
         jzeX/FeslhtdeeGK504Z20H3VZ7LYHSct9nbbUZeUmY0xqX+V+HnaJCZU6mvGClhxjH0
         5i/g==
X-Forwarded-Encrypted: i=1; AJvYcCXHrMBMgUWCwQSf+DhTn9yag1Vzi9nk/7WvtOI4BwSlF8N+sD5A10fLKaDIjCML7VoNk0Pj8a8xvsy8PxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGIdJB8r5ha+0bnaBgswCevRTvqNBYwzlIQt6s44nq+Hjt2B5
	4YRWwujlBi2cnHAzLQTvpxmnoMv1tU+SNhd9T7zZErqlaFUrJtVvIajC3PnbyA==
X-Gm-Gg: ASbGncuV+5C9Wtn6ugSVvxr3c+hf0Nld/mWXQuohYKo1QaumO2+vxqYdB7I6htUgA+N
	2lNI/Fb/3OBi0BpWohDhy8Jr8Ud53IJ5e9h+CzAIv3AhzCIWNvlyS69oD5oThDxtHwuLyUpXwRF
	TL2asftBkkWMtEFocDlowyqKyU15lQr9Q0FCn+Kx42DZVAurnYxoOGqsx7BGQ8owhiObIWAkYjL
	DPjWDpifmGaSf2sobGHsa10hSFrQ1HqA79z7Iyk87122aCsUwvscexrgHTx4tqr81AaC39lYtnY
	Wfk4ixBtCTFvAcZSx+1IOG9s4+IAKg==
X-Google-Smtp-Source: AGHT+IFr0nitVOoP5X+Q+Wz2949pPDsDe3Yp8CEi9Dc/JwmleByYQKSkdppAuP/1rSKlJXrNVOTYMg==
X-Received: by 2002:a17:902:d507:b0:220:c2bf:e8c6 with SMTP id d9443c01a7336-221a000add9mr277835185ad.53.1740458581179;
        Mon, 24 Feb 2025 20:43:01 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e27d:842a:e0d1:29c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00a970sm4651855ad.69.2025.02.24.20.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 20:43:00 -0800 (PST)
Date: Tue, 25 Feb 2025 13:42:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/17] zram: permit reclaim in zstd custom allocator
Message-ID: <vh3uzody42dfcfduwrhnha3wrjm6wi7awwferzed35zuodn4zu@txo4zpftf2uq>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-15-senozhatsky@chromium.org>
 <20250224091036.Y9fHrKr-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224091036.Y9fHrKr-@linutronix.de>

On (25/02/24 10:10), Sebastian Andrzej Siewior wrote:
> On 2025-02-22 07:25:45 [+0900], Sergey Senozhatsky wrote:
> >  static void *zstd_custom_alloc(void *opaque, size_t size)
> >  {
> > -	if (!preemptible())
> > +	/* Technically this should not happen */
> > +	if (WARN_ON_ONCE(!preemptible()))
> >  		return kvzalloc(size, GFP_ATOMIC);
> 
> This check works only on preemptible kernels.

I'm not sure this is true.

> If you run this on !PREEMPTIBLE kernels, preemptible() reports always 0
> so that WARNING will always trigger there.

I thought that preemptible() depends on PREEMPT_COUNT, not on
PREEMPTIBLE, because even on !PREEMPTIBLE preempt-count still
holds hard/soft irq counts, etc.

I ran CONFIG_PREEMPT_NONE=y zram-zstd tests and didn't see any
warnings.

