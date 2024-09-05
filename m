Return-Path: <linux-kernel+bounces-316903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CF96D6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338F81F26638
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A219923F;
	Thu,  5 Sep 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxFQI31w"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925C1991D7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534502; cv=none; b=NwTJMrZ8wPMvyy6jgNg18UofJ/FAPlZKKiwy1+Stim/CQIb/ka1blbEREtEYoAaVYrUzPGxasFc01ac4Et0or622B4hZBBTxN9InmFq7tZW8W0DWf7Psn+NM0VestM9K+3aOjylEv7h5rXclR+aGjBkoKSNeewOnuBqWkGTwpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534502; c=relaxed/simple;
	bh=LqwjAMWIXfLAiDh3IzhpRtZkBQ4I8ll+8WXMQlVGHJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fyh7Wl0oegXhn3qSs0JgL4KOU4FIJOKInWw2ErtsiGqvcfwfHHCjkHO40QldE0CnqtQll01AhDPz+dzYguQE4D1EZzpjfAEJdlJKDt8WOKhQxKp2bdF9RgVldbhzBz88xL4VjhRuQ5G5MdWO8YnFDBf2OJ69DB0db/zinyvE5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxFQI31w; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso693092a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725534499; x=1726139299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqwjAMWIXfLAiDh3IzhpRtZkBQ4I8ll+8WXMQlVGHJc=;
        b=JxFQI31whJSZUzkWMvjtTdT53GIDOTUKUF4EnUjz35s9SJUfwuMb0YrJzYg8pTC4Wj
         /mLSjuvyfsUCTBHZH/ZSwL+KfQ2JEsxxjMEFQIR+wOBEo+ac/m2+zJhU+p1ydSeU1JY2
         H/0r5xG53eMAVWo7AL/Msh5rfsNncY/ZxVei3lkuBJG52szhdWRzFWL7nCJNg58X0b/2
         UfEDop+8nCbak8MitOgjpBDOIhlqFDMh+foVGAmpZpbC3bkh9TnjpMQ1s6ioCSq2ZcJ/
         Fv9I8JmYayGIkzbepEhbYLtn2RT/xbdD6vPnouaj2Evml94+Mdqmln+WIHMhytQ28QT+
         EWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725534499; x=1726139299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqwjAMWIXfLAiDh3IzhpRtZkBQ4I8ll+8WXMQlVGHJc=;
        b=JkJ6y5ZnkeNtn1aKbKx8KxjtA/0NYkbYOBjYS90x5WYY58QTETmPSZ/84jNkQDqEK1
         x5EZg6s0hOMCT4B9CEsArIm38BYrRbWv4uG6RjqoOapj6pzRM822ceAETVpE0CaHr1KH
         9JsIT3IBhwQh7qlAe1eb6Y0nwoUQh6VrGh8WaewUc38v2pPAhh3AvimxtdxTfPXcqNiq
         4vO1E4xFyAYGPvccLU9UtyZbsB3vDLClxg6Ft+QkNgh0876buskbCghFIzNP/w5X+ofx
         qIEPZnOHzulm+Dz4pQcGMJ1tma+g1xvWArZDYEhxMVxXvL2YqLShr9kDaXktl6WcnvOq
         /8mg==
X-Forwarded-Encrypted: i=1; AJvYcCV6NUqc5rnGzMRMQmOZof9sEM0eC5GfZJYRV9NfjRQ7PlOTZb0RUBFq/GSYlyKHYEFAWNZs5Acu4YQmkMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURLR8oXuoCj/GWFJEMln1M/NTUru/czFJEgwP5kvoX0p0xJ8D
	bLOhoFkWGGVjeUxmppi/XNkbNVmZ9Jvjk2CTv1IziiBLGJ93QvwtXmnnmAiGXnMLiE/H9Iip+Xg
	2JD/tUeFnPEUCJlZupU+drJ3L3u1GpSN2px1T
X-Google-Smtp-Source: AGHT+IFFX3kl9UZMNdkzkdtZItwLqtVU50rbw+IBqYKGDGFu+Kv+f8YYap3rC0kXwlqF5GAgbv/+LYO15fn+hBspXo0=
X-Received: by 2002:a05:6402:2742:b0:5c2:70a2:5e41 with SMTP id
 4fb4d7f45d1cf-5c270a25e94mr5743031a12.28.1725534497559; Thu, 05 Sep 2024
 04:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904153431.307932-1-jdamato@fastly.com>
In-Reply-To: <20240904153431.307932-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 13:08:05 +0200
Message-ID: <CANn89i+=HiffVo9iv2NKMC2LFT15xFLG16h7wN3MCrTiKT3zQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: napi: Prevent overflow of napi_defer_hard_irqs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:34=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> added to napi_struct, both as type int.
>
> This value never goes below zero, so there is not reason for it to be a
> signed int. Change the type for both from int to u32, and add an
> overflow check to sysfs to limit the value to S32_MAX.
>
> The limit of S32_MAX was chosen because the practical limit before this
> patch was S32_MAX (anything larger was an overflow) and thus there are
> no behavioral changes introduced. If the extra bit is needed in the
> future, the limit can be raised.

Reviewed-by: Eric Dumazet <edumazet@google.com>

