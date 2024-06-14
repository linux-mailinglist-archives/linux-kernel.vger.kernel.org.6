Return-Path: <linux-kernel+bounces-215534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E641890943C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C42D1F221B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7C186E20;
	Fri, 14 Jun 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIrC8bpO"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C5148833;
	Fri, 14 Jun 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405315; cv=none; b=fmsAnzGlYGh7NlMWlTMdGchAtumvHfUF9EJs94Xitk/zWhh34n10p8SJy71M9c1Z/1HYjhM2QMys4ElnVxLuYWZGsULN1JBvAeMsbV2xEyv5xLA2HiYwRKU/fqhShedEeZ7udj5FS+ZLwaZPnj+eTpyoYFzNTzBkL5gIWTQ9lRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405315; c=relaxed/simple;
	bh=SHXtMF1agTiwHwUG9oPqeFHuUG5aChlVAFTOFpyBWT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIItHYbViUBh+BXHZQPtU+/Ffnept9mP5+LL/Tzwn5MFoyBQUbkRYyOsfBTmzZZWK3bkRxy8OHoNNNA/qX7PGeCnubu+Ecq04gC38RaG/zVdGX+xNFMfVpgCljT47m4NO9OrSWw9yQsch8x6GfvfWtrG+XcrO9BvVPmg9AQzGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIrC8bpO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so3083088276.3;
        Fri, 14 Jun 2024 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718405313; x=1719010113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHXtMF1agTiwHwUG9oPqeFHuUG5aChlVAFTOFpyBWT8=;
        b=LIrC8bpOLPWzHqX7j7t1w9JKhXBjcgorbOYfACJKR/KQWwiF8cAfPrUV5tW/JYkuGG
         DG6LRhPQm1eFmfvaxtYgG3CBQ6x3YHJgnZWCJ5rzCEzUH1KOdr6vBXqj55KgRHRDpvXg
         RgPBdCLp/jZCf87IaMjEcXckvkoFzeShfFS5y1rwb6AnsWTWyHRHdX65/p3KU3r5tVPB
         3dfPLj0Cp2RluZSWhjRz0jw1TqXJ0Wl7yLpnISZb9DOiZ4dy2f8owT5ndkLzTUJrQg36
         POZHvx4Q/S2TWw7E5ggSCN2DS8RrEcWeeVjIqlVgP/bSWu/lVtbgE0su107eZ3AW/7jF
         4R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718405313; x=1719010113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHXtMF1agTiwHwUG9oPqeFHuUG5aChlVAFTOFpyBWT8=;
        b=PRW7FZcrKET7+M8btiYY2P6PbHqEZ9HlFlm7d1a6fz2eDoMSQX6hcaGaE3L9GYdU6K
         yH9KhRut+rtn4R9oYAB98jiV4IPCZuaa3JV4cL66ryi0pNuguAbcFM1crRCMWEUnagfR
         r9DVN/2ZiVT+ITvZXCFYZ3fWHzFZbndKWtF5IU/bPteaksaJ6ib6OJoTDWs9NMH8AX/w
         Wj7frnjeGZJ8WQldEwQQOHZVUuoUcP3gqEgYRvc4CNqEkwmIPrKlCrbJyHULaABoPDf4
         q+tRiTtD7iqVajej265NcUh/CV0sBJwr6B9BkGrz3DFaOp//Za2x3mIOX5nf4eQXhwb9
         Cx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkVi8GiBNVT5xhXdI5z0MOcOwM102lVAvjiC3+arVPBRl96ylytmqmcK2EcM4EdA+CFFwnVGBN7MbNqw/CO7s1+UQXpX5KNYd6gAxVhx09WiehTf+ViuaPNbZM1ZQLX8GdQC6xlJdE
X-Gm-Message-State: AOJu0YwDOC131lK0nW+xut3fzpX0ChXrzJAlJVJnzVSB27VhTqz1bn3+
	jzHMHmwMnue6/sJNtnknH71q6fxeN3HpCkOftCZOKxK6UyRuipCdcM9mR1xSe1Kb5IXfjas9fvc
	kmpvduHyFvaJkV2GvgEPZeYgF4ig=
X-Google-Smtp-Source: AGHT+IGWlWxi3tGQnFiRjHuRToReH8E/NRFtOQ0NQQ6jRW2qzuRS5EYTxcggkF5vjiY8AQzPyzOUpiEg4eT8KfA8T4M=
X-Received: by 2002:a25:824e:0:b0:dff:73e:fdf1 with SMTP id
 3f1490d57ef6-dff1534de11mr3864205276.4.1718405312930; Fri, 14 Jun 2024
 15:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <CAKEwX=PsmuPQUvrsOO7a+JGd=gDmjP5_XDGD+z-0R6dBea+BOg@mail.gmail.com>
 <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
In-Reply-To: <CAPpoddcgmZs6=s1MrzLgOAJxoVW5_bLa4CGxHq3KhF3GOi8VBw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 14 Jun 2024 15:48:22 -0700
Message-ID: <CAKEwX=MusLXFq49HtZnqKAUuZ72fSnuC-9T2p85S2MuVQV00_Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> My intended workload is low-activity services distributed on small
> system like t2.nano, with 0.5G to 1G of RAM. There are a significant
> number of pool_limit_hits and the zswap pool usage sometimes stays
> near 100% filled by background service processes.
>

BTW, I'm curious. Have you experimented with increasing the pool size?
That 20% number is plenty for our use cases, but maybe yours need a
different cap?

Also, have you experimented with the dynamic zswap shrinker? :) I'm
actually curious how it works out in the small machine regime, with
whatever workload you are running.

But yeah, I'd imagine either way zswap would be better than zram for
this particular scenario, as long as you have a swapfile, some
proportion of your anonymous memory cold, and/or can tolerate a
certain amount of latency.

