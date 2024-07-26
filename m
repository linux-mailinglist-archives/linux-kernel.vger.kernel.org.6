Return-Path: <linux-kernel+bounces-263578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663E93D7EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944471C2316A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CB17D34B;
	Fri, 26 Jul 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbfHaXvp"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826117C7AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016881; cv=none; b=VU6K87bkxOi5BoEfG1R19QREoQ33gcPiPN6e9XcuDSkPPrSXZlfziy7Q5Avfxx5XWQ/tw9Q11GDpgohPWUk8yLT5YUE5IdXKq5yK+UTvgYQkmbNLAabDwPcPbcc2hRtQSzHWrA3Uval1rXp3e30qpgXSIPsRW8Sq5W3g02bHR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016881; c=relaxed/simple;
	bh=L+auiNf+E4D1L5wzd1qHZcU7FzCvtKL9Bh94+xJW/r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl+6MI4FdS2GhV2LK4TChMPsy6grzXQbKByEzAJMCFz5qn1QR3qABvSArCJNyO6+nbt1JQ9QO8FA7xSH7ZrDftTk3e6ghARvsoy76mlzwYJlLbEWL5dOcoRk2M4kukmnZSoShbhgijLuG69TfqYXBW+LbOfPWMnLKStXZgVBXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbfHaXvp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5bc93e09dso743661eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016879; x=1722621679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+auiNf+E4D1L5wzd1qHZcU7FzCvtKL9Bh94+xJW/r0=;
        b=XbfHaXvp0DDh/Ph8p7NjQ46oaGlF9NcspUQBQxXUdX9MzLlQqO5rfvcooG6axPaBOK
         U8EzDZNIW0r99ExxtZNFxxrhTHpJfRT53yy8Lta5CkHE56lxlTx1WmHA5gx+qORLbqae
         I/YI1Nfv4U7uYDr7o6sH0j0xIWlWU94WfOS+tSu7O+QqLo6RFNmkL6ow/HL96FoAsFE+
         1YXyiAlhC1VAMai5hJle5NtJN2M06sdNgk60eOngwq/Z6QH2jzfDH3TFKhAEk9tPgQUp
         ZzdJMlwfLS7cvmfP3BVxoToCA3snbswGZHsOexx0X7FRL0RcNDkwC6jpIHOj6t/WGDY+
         QEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016879; x=1722621679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+auiNf+E4D1L5wzd1qHZcU7FzCvtKL9Bh94+xJW/r0=;
        b=qfTSOvWUrwJCfmCkiCA9hVEmjlHzh96SA0ph0aMc6xSNR1zoy8JL8IvO4VZD/FZFEU
         KFE9bYWs1X5y7oM6SOjZdM3VG6OF9mcDGJWzReYAZzg062xzF57uloT2ddnXhCnvoyFN
         5u9l48NxrmSyxfnC56RkyrwbbkhIJ7AUrJ70LQsIs3bhXpTMmVGKnFFFMj2JheWhuhpZ
         ExEFF0J8GjZwtts9h9tN+K5/81k3Cnh1uzLWFBJer2cHYsgKU/bNiNi+Mqu9nme5EyBl
         A+ppwtS+iDUjOKxbQFAe21HRHVA+JppXOvXt79o8S1ZaB25ixO5aN84DylhX52eVxhqp
         p+wA==
X-Forwarded-Encrypted: i=1; AJvYcCXaLCkmgIFXXscw3N25XeimKEgM4pmAti0uNXbrzm7ET+1N3zJJrU5+e7TU8wZFYlWjEsimUgYDVEUS50ANMqrjkFJ2EcKWdcwZkBwH
X-Gm-Message-State: AOJu0YxK6W+/YYAs0f5YUsQgirykHk7N1uGzx7cJkmzCjBy5DwNJCEeN
	QLP5rI0AlHQUMSAJq8n25GuDMSyKyq/rj9KDaBbdkJbSjbT5U+aFvu8UcOsbc7Tc0nR12XkWtyq
	2PrMX/vEBvY211fzhlIPovMCGOkc=
X-Google-Smtp-Source: AGHT+IFJAg9qrZNLPTPgo0th1wrNemU1HEUei5xN+NvA5Ij01oM32yj/xZEJW+sawPDEwEq5xAsgwFxEAd/Pa+vxbJI=
X-Received: by 2002:a05:6358:5e04:b0:1ac:ed54:224d with SMTP id
 e5c5f4694b2df-1adc06b2124mr58860355d.11.1722016879323; Fri, 26 Jul 2024
 11:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-3-flintglass@gmail.com>
 <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
 <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com>
 <9ac88791-54e2-4f7c-9171-5a1d44e01657@linux.dev> <CAPpoddcw7BD13ME8xG5TP=kKV=5t_JCxA0DW3t7C5o1wkC5tfg@mail.gmail.com>
In-Reply-To: <CAPpoddcw7BD13ME8xG5TP=kKV=5t_JCxA0DW3t7C5o1wkC5tfg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jul 2024 11:01:08 -0700
Message-ID: <CAKEwX=OBzr7ozLrvGso9HFtGBdged1XZYxGgV1cVwDaiOeaZtg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
To: Takero Funaki <flintglass@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:54=E2=80=AFAM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> Yes, the `++progress` counts both error and success as an iteration
> progress for valid memcgs (not writeback amount). Incrementing only on
> success will overly increment failures counter if there is only one
> memcg, one from writeback failure and one from tree walk ends, the
> worker aborts on 8 failures instead of 16.
> `++candidates;` would be better? replacing the name and fixing commit
> messages for v4.

How about `attempt` or `attempted`? Naming is hard :)

