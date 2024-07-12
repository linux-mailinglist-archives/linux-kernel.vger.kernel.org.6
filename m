Return-Path: <linux-kernel+bounces-251226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9293025A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43069283976
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAD1304BD;
	Fri, 12 Jul 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZcnUWAw"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B01094E;
	Fri, 12 Jul 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720826345; cv=none; b=Z+YNw2NLsTt+aNLsGo3QzyxxXCjZNg3H9y5S5y5x8k3h+ld1XTL215y9MLbtoHmt6us5uDxMrwNEVmn0vYkZhDeHJlp6WFtkBPh1cdV1CHt91UJacYE7dShRI0iviBtGGKHOE0pQJ9oXrZ1SgiAWt11iIWOtJVSBU032IsmEm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720826345; c=relaxed/simple;
	bh=FaWRzkVFlCgb0Nly3/8YbMF104vcT8a8AJ1smFpEqHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xvj0XI00otcPpvvwmzr5CP/2e9SXB6VVD5hvP7xZz8lTe0EGVdFKfoRJGEgy9FXhh7YxmNhp/uC2b4HAdoxPP/C0YyMzDdrr5J2OGoHuma0GQ9dkw6XDQkTDOd+9C99RTaJlHWrwej2qDijtfzUfZ5zYhshYj/N4opoA+DekH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZcnUWAw; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48fde3a2b17so884377137.0;
        Fri, 12 Jul 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720826343; x=1721431143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm3Z+3oSlCnKi1jgSrpl07U/rwEo7hHDUw7mZ5MPzPM=;
        b=JZcnUWAwaGG8C54ZfUUdLT8Q7Xpgi8uGVtPCTTHrUmpizHCWNmbeSHR7WKAsOTd8kn
         N8Fl07KBG1Bwki798Q6svwkkHr9dXPMT7f5jjASvKEOnm5xDe8HEALh0rgky8aLequ1a
         8e86OxkqlF/rVbmvKWYDNEJaJMCHwB8j1/lFQlxlN7lR7adOS9rwZVUFS2aDwa1AwPBb
         w8xDUxKxwKkcK+RXEht3ZRMopQcbhpiqDpsPDylFrr4HiHrJFOeuvqMiycmZW56PDgan
         ZlCzSPmFJ1jDkQbr26WsuReKz/fHu7vbQrlLPa/bwQfpGQEsk7vQx9nTtnb0i98puSbP
         JJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720826343; x=1721431143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm3Z+3oSlCnKi1jgSrpl07U/rwEo7hHDUw7mZ5MPzPM=;
        b=OfpB2cVsC7YwN0dx5EIfXB0LkeJMMYOUpgq9PyxrXBQd8T79rKxf5ObnoddTOHsTMs
         JiUeSVY3eJI8iLdGTMMrQTY0KAJ3zksr8/ZE4ZNuDhI83NgzaHfA3qRNYLWC8P3jCWrT
         RDMpCiE5l50K7cmVvwiA0EfaFjuzL4zOWZePhleUJ5sTg3W8dtmCVed8mK7VloQj+af5
         a8UFLEXliBwwhHCJlvFr7AFb78OpttxrOk3hZFXVszqny9cut/llSthLV62VQrHZKjyJ
         CfogeKtS9HFh7H105lOQ0S+N2eeMiy9rzx/WgyjbFAd+ewQnocOfJ0b4Mc7SdHAqfd9R
         2cRw==
X-Forwarded-Encrypted: i=1; AJvYcCWOASbK0bZOukqutqYvolxa3pZ9SmvolQLnSRa+Bbdlj4gG//SRG2LrkYwLsLCdSZMrzkSQA/RX55Q9oxXHdolQVGPMacChudfDCb4VIPfBQPx0T5w4ouPk1aoB2H001CGyW5ao9JIk
X-Gm-Message-State: AOJu0YzttgDKBMadjQVnxEFNJeMahL+SImem+ENCMenmGYc+EL2PeEKU
	9uKulBUkopc/HvQ6j49zYVngzoiA/KZ6Ehcjvpxa7KDoZTkq3wrScHeWMsECBJm75NJSlzhuTIF
	/jdKt4ivjnH5lFTE/CHTHZpL0yIA=
X-Google-Smtp-Source: AGHT+IG37BJLgtBHkGv7Y3iibJrinYDDdhWJQVnbqgcbL4cpy4bo4GDWF65hOrpSJjiNSYNUi6IVbr9PF4yhXjlIH70=
X-Received: by 2002:a05:6102:f10:b0:48f:db40:99e9 with SMTP id
 ada2fe7eead31-49031dd824amr16516144137.0.1720826343044; Fri, 12 Jul 2024
 16:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-4-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-4-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 12 Jul 2024 16:18:52 -0700
Message-ID: <CAKEwX=M8vTfBsptOF=GdbFKK5V++5Lki+XSHkOmVKWYXPVbkOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mm: zswap: proactive shrinking before pool size
 limit is hit
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
> This patch implements proactive shrinking of zswap pool before the max
> pool size limit is reached. This also changes zswap to accept new pages
> while the shrinker is running.
>
> To prevent zswap from rejecting new pages and incurring latency when
> zswap is full, this patch queues the global shrinker by a pool usage
> threshold between 100% and accept_thr_percent, instead of the max pool
> size.  The pool size will be controlled between 90% to 91% for the
> default accept_thr_percent=3D90.  Since the current global shrinker
> continues to shrink until accept_thr_percent, we do not need to maintain
> the hysteresis variable tracking the pool limit overage in
> zswap_store().
>
> Before this patch, zswap rejected pages while the shrinker is running
> without incrementing zswap_pool_limit_hit counter. It could be a reason
> why zswap writethrough new pages before writeback old pages.  With this
> patch, zswap accepts new pages while shrinking, and zswap increments
> the counter when and only when zswap rejects pages by the max pool size.
>
> Now, reclaims smaller than the proactive shrinking amount finish
> instantly and trigger background shrinking.  Admins can check if new
> pages are buffered by zswap by monitoring the pool_limit_hit counter.
>
> The name of sysfs tunable accept_thr_percent is unchanged as it is still
> the stop condition of the shrinker.
> The respective documentation is updated to describe the new behavior.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

Code-wise and idea-wise, I like this patch :) This is dependent on
other changes (as you have pointed out), but if the series goes
through, please feel free to include:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

