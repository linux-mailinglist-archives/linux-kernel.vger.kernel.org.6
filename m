Return-Path: <linux-kernel+bounces-299817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A279895DA57
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F251F231E5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C28BEC;
	Sat, 24 Aug 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDtEMk6n"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086223D2
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724462602; cv=none; b=rT6SsaHlecqUaKXtR0BBIIpHKw/QLZ0B6nQsU3+bzMldqhQAepYJQbB/0MIR0aQ2IBsji+4fn2jzXg6bi1Yys+XP4DU8A1jBmGilGNtzXclpUbj1A2dvsNQ81tCEX5QEHbWmqbrMPXi58/qVpIIwoAVhZDq9rJq+XaKYk3NzBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724462602; c=relaxed/simple;
	bh=pFBmn1b8HGmxiNAzjHuI1t8iCFvWlQvq1ax4yTVhtWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCmH31xjGkgsFAyqI5gjburJEx3Ifg65wWCGwNHR7qLqi0hLsEPU1r5j8r42b2fPsILgD0B+u147OycniKg30wPd4YXAtoxDo7YOVlVuC28YbYTuUk0t1OqQvdYBu/T7E862wbyTv/HmiiFSQXUXmprFHwNOEEqj0nW9nvXQLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDtEMk6n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86a37208b2so175425466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724462599; x=1725067399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hS0PlIghB31D9UEMBMHujKkEVm4tXs1uqCiHkuDkoqU=;
        b=KDtEMk6nuI2F12uxqL2oxrKKtfpPaoT5FBEU6JIi99X+0H5aisnt2AYeFAgqiU5okV
         ASgMgLDDoRY9gUWzwRru0rCrTmRan0oq10Kj/kl2T9f/5JXlWccyfZwMvc4sLHxEuC1W
         vHnHM0INEQX4y9oLxyGy37u8OC7HRN1pqr7AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724462599; x=1725067399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS0PlIghB31D9UEMBMHujKkEVm4tXs1uqCiHkuDkoqU=;
        b=jwsSobph+TD8cv5lRrOcI0cerS4rzH2O07BLcAusDtUcwk9cY+X9Rgvnz72VhsV6AP
         QxoOPF1oM7171OGX1pkJzxQh6Qrk7Y+F7yO+nBAOIfuZ638gNFKxh/IMH/bSvidufj0d
         gnDRzM31CWCsebrqEPyXY8kfF/WNMXHEHtOd/R59NwIkRdKCspLCKe3K41kIGPTmDGIQ
         f9KiFLdY3W/JVKhhjx8A7p4EgJOPbbaowh8mQk803h4g1zZNSKlpPKJXP3yoSY9yJSVI
         8u3EzNB3mpY1uO63k83JIIjYMzwXzivgMDxAg7wNPwG2TxY0+thbztHEVlmGhZQZsDB3
         2Z5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGIYQVsiPIcJ1rmTldHeTaIDHCWIKT1t6B/Y51G1sHPYbSnxF0g4BEl8A6atze8CAFU4xeDwEO0PGDMAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQedMWb4Ju8RRyhRTnobSpDA2O3P9p+ncSPktlN2b0LdencuWC
	A39m2bbsWPvN2g8roO9+GWqfIBBaJt9K6/h5mN0rCvlzucmEK6y7Uu+yxKeNVR6gZwnv2iEYTUj
	Me0akXA==
X-Google-Smtp-Source: AGHT+IFn6H9qCJCQENji5kyI3mGfryYS1LW0/SGAqRhXGkY8gnMz3xxbiNJEADEFiI0GfUO/e106VQ==
X-Received: by 2002:a17:907:e251:b0:a7a:8378:625c with SMTP id a640c23a62f3a-a86a52de6aemr293871266b.36.1724462598884;
        Fri, 23 Aug 2024 18:23:18 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f222b23sm336881066b.19.2024.08.23.18.23.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 18:23:17 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so3533237a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:23:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf5Bk1cV87l1k5mcANC5AncnQ1MvXdCamm0q/fOL7xxpBVpylqX14sWYM5o1gN+venYVmc/s1Ic+/S/uQ=@vger.kernel.org
X-Received: by 2002:a05:6402:430c:b0:58b:585b:42a2 with SMTP id
 4fb4d7f45d1cf-5c0891a92a6mr2273293a12.38.1724462597330; Fri, 23 Aug 2024
 18:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
In-Reply-To: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 09:23:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
Message-ID: <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, big one this time...

Yeah, no, enough is enough. The last pull was already big.

This is too big, it touches non-bcachefs stuff, and it's not even
remotely some kind of regression.

At some point "fix something" just turns into development, and this is
that point.

Nobody sane uses bcachefs and expects it to be stable, so every single
user is an experimental site.

The bcachefs patches have become these kinds of "lots of development
during the release cycles rather than before it", to the point where
I'm starting to regret merging bcachefs.

If bcachefs can't work sanely within the normal upstream kernel
release schedule, maybe it shouldn't *be* in the normal upstream
kernel.

This is getting beyond ridiculous.

               Linus

