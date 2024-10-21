Return-Path: <linux-kernel+bounces-374957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3839A7278
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D675281E10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FE1FAC3F;
	Mon, 21 Oct 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwimAlmS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF11F9AB1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535775; cv=none; b=bhjlySCw42yKgn1PjJnc+wlK63usUIWiFIPYkR0mBe5Lq78KLzFj2eqGu3jJ937Q9a0QXDkjvuwAss44gsaqSiFrEjLfJjRV7mRqqeT/XNtAIaXG6oVtoGP3r1XwoBbZggA4ZV6OsXbDoB5uw0OW731gCZFWnK/c0xJAFJRoEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535775; c=relaxed/simple;
	bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HIru1xph9hOK9tJ6A5dLKD+yhw6TgfRKK7+PigxgXXjd0Q53GX0Trya8VvJjwR4d2xSm6oAxg0n+wjWwistrEMvMvBnMJKHSjEs/MeHW4vD8eZw/jyrkc0m22rYEUsSKYoQpp+1q4zLRSmbICHYNN7VRD0Os5rNjK1To3hHSqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwimAlmS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e13375d3so5309375e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729535770; x=1730140570; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
        b=XwimAlmS6W5G+5nBrUQJTnXjmhPwREPe5Geh7cIV/BRgVMBwmSR6gKn6onlD800zVP
         KTr+IGcKu6hYSKvUAvRWY+wnL/6lx4w84QHO1a4TRFLDsyjuFPVvU42AOOd32LLMaLt5
         GN3gbhMBKVJA9xYFLPKgIbUFZnxETX+e0ljxmflJVCWqHyt+IQ/AGCYO/akmGBw/WhK+
         uipwL9J++2grhM/+T4BWzHkm1tInGvZtbRrgjresxUSaaKV4keWmXeYOq1b8josm4MYW
         UcHguVJwcRaN+SZ3ZLTbjZmEmZwsFpX9u176rw2UXUrghf1IJKayuQsC5AbhBnHde4DP
         i0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535770; x=1730140570;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8oj3vfqmlM0xsYADMFgn3dqvUu8ThnYSgPeaSBvCJ4=;
        b=Quv/rryQB4sl9IlT4cLzYf/SUXTQZW222H3gv/7IBndOnWy3lwYzYAoPm4KBWAryGd
         hwdnK/ZFwO4grIpjjbcxxYxB6/OxKL7r7AakwxxlZnDxPoxfMKP2Kua7GuKDJUNiyGsM
         HbTIVLrxK+dClWw9NLmbXkEuh3zWj9DF+tOW3jK5h0QeX8qFJb6eHhXFvImF8y3X3s7m
         wl05whZo1kMZutT0+2fYvAX6d7A7nI2noRuLOIiXakMTxADiXLQupRlEFWr4BI9C3G9o
         4fcK/eUW2vu3hh5//VTVj+tctl+3RHyVKzC/zeQqzC9Ouma7wEpCxF+yEimANYfTRLkf
         NPPg==
X-Forwarded-Encrypted: i=1; AJvYcCXdkTOV94RiORWxqs+ZMynrjv5EJlQLNQR2rrl5BICWYp5LwWsTstRo4MqB6qnVnlZ+L6XjgvWWbn0i/JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTJZ0nZN5MTxtNeR/Jn6KObWNBqx/sVofBCDJ+WaVjKiuujnF
	YBnwU6lr14LZzt7GzPsl1h53jmSURkfA3PDXpnQGq+01b/y1rQcByOsi7cxk+y6kF7jx2vEqfsv
	mvxzieZ3m+6MMSH9c1Bgx5kMsgRSf+blNYXXI
X-Google-Smtp-Source: AGHT+IF+0F+zaNHtxsbg+gonwYc1DvKt2ow49jd6XgmTT1CLmLAHX/pP8qve/Wi1OK1gXjQs8uB/egmJ+SnCNS621MA=
X-Received: by 2002:a05:6512:124e:b0:539:ddf1:ac6f with SMTP id
 2adb3069b0e04-53a154fb010mr5963550e87.46.1729535769525; Mon, 21 Oct 2024
 11:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021182821.1259487-1-dualli@chromium.org> <20241021182821.1259487-2-dualli@chromium.org>
In-Reply-To: <20241021182821.1259487-2-dualli@chromium.org>
From: Li Li <dualli@google.com>
Date: Mon, 21 Oct 2024 11:35:57 -0700
Message-ID: <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
To: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, please ignore this outdated and duplicated patch [1/1]. The
correct one is

https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.org/T=
/#m5f8d7ed4333ab4dc7f08932c01bb413e540e007a

On Mon, Oct 21, 2024 at 11:28=E2=80=AFAM Li Li <dualli@chromium.org> wrote:
>
> From: Li Li <dualli@google.com>
>
> --
> 2.47.0.105.g07ac214952-goog
>

