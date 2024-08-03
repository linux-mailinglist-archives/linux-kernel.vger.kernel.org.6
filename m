Return-Path: <linux-kernel+bounces-273598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6E946B2E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBED1C21415
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451774D8CE;
	Sat,  3 Aug 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz5tkeNo"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F1B653
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722720968; cv=none; b=AIDzxOGL+DyX2u2JKgG2XgVWSOsP8lcwtR6IUJ5QD06COkuv7MCX5wXA6thKiweQ/sEVIrWvUPDSynOUPv4ovoavtk/k1iAeKUUO8FJfUy8YsMzDC6mmlooeXkxfn2yvYA624/g1K+6muTv9TDxUQesc155k8cm4JhlibfXTYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722720968; c=relaxed/simple;
	bh=GGA4x0cRfdtZr8rM4e8YaQaSSi/rroQkTyA63QWZunA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIc2ZaYpx4Trg95aR/jPWqOL2J4pMNlkrE87um+KYxMGRSIcVlHp7ENUkMsOZUA3ygwcj0Hj1n3RiB/ePdNKnKSXM50mm9QioYMXjLxyH0lzyKAXlmZnk0wKsE5FwmsAqzEcWqHusR8cDubxog2TsM3YbTEBhpwVgWTv8sUdlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz5tkeNo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b79c27dd01so51517706d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722720966; x=1723325766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGA4x0cRfdtZr8rM4e8YaQaSSi/rroQkTyA63QWZunA=;
        b=Jz5tkeNo20MtE8iI052pjn81DHKLwZsPZjrYa//WOwjaj1pdzYqaThdj6y7FlSXd+k
         Zf/U574orXxdohtBjI6eCDKVuyil6XFuRM1xg/HtpUVokC6iBn1xE+fG7Fg0Juh5/UyR
         rOQ1aNBR9IW33mek5Xi66JLTYwL/aoVVysjk+2c+ltrYoPaOQmDxFeKTIO0LMO8DmqeO
         bvMzewZ3PlRhfmgV50IDK2+tnqBMPXNS0uWMGyHdAzKBZcjNfrbCFGU/te8+HmAnnwXX
         BixXrOiySb0tU4eu5lNWJsHo8M8wbFSNI2YkDNxsS2XV68QxxKag5IZed73QIwA7hb9S
         AoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722720966; x=1723325766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGA4x0cRfdtZr8rM4e8YaQaSSi/rroQkTyA63QWZunA=;
        b=r5l36oXHw2YHdX4Ig9lzI6wbrhBNqCEPYoURIOa/zMbVGiaUZb+FesZFwqXpXjaAtT
         TONzzRPq6I6L8eANJkZCV+OQyg84C3JkgljFFtJu2jS20PtO52q2opxp3UsLU7+ZzBPI
         0siE0xiik4QGt9y4jVlE63w3p/3o4Bh2mqoZuaixDqO64jhCoqPlYDnKQF5OxTQ5d99P
         U7lWZarktfo8ILM01tLnV3i+Mu6jZ/NyRY+CyAh5ssp/nfZmUBhdvrRwcxpUfIF7BmvH
         PEU3/okLR7GEM561k2NylAdD4AnMVkiansDpl0P8YCMtCY4H+cENHST4+8iVJOljgSRw
         yOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUrvLen3IUW+k7nwnzsapdtl2oD5ZHiKBWArPYJSd643mr7qoRKb/ZiPk9ijnEiaeeY9f+itMJOcNgNKlJwo7LbxvtR4ARso00QyZcr
X-Gm-Message-State: AOJu0YxmQ4le8j/Gohu8+YiTJ4tTCAYuiIv5oOLjnA9hqAbdes/7oTuC
	wUgsJuSG8JowkpEc9SbPdjMO1KSSfTrOB9D5Q4Q62s1uKdPFjRwx9zpuF8zvxj1xA0gx81IDlMs
	SaouJ/PR0/1z7dF4gqFhnDZ1UDg0=
X-Google-Smtp-Source: AGHT+IGszZGZLYotIbtw6Fioo5KC/jrwn+A1TjHwocUeTx2+7j0c+FPLoJQjNwwuAAGJRz2PEorN5HY09hHG4R00qhE=
X-Received: by 2002:a05:6214:4906:b0:6b7:a2c2:610c with SMTP id
 6a1803df08f44-6bb9836ece4mr99660916d6.17.1722720965938; Sat, 03 Aug 2024
 14:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803053306.2685541-1-yosryahmed@google.com>
In-Reply-To: <20240803053306.2685541-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 3 Aug 2024 14:35:55 -0700
Message-ID: <CAKEwX=N1GZEGnuXo_iW1N9Sx+Jon8=rqe7vznKwL4RQ7t349fA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: make the lock critical section obvious in shrink_worker()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Takero Funaki <flintglass@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Move the comments and spin_{lock/unlock}() calls around in
> shrink_worker() to make it obvious the lock is protecting the loop
> updating zswap_next_shrink.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Thanks, it looks cleaner to me too.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

