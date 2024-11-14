Return-Path: <linux-kernel+bounces-409758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0C9C9102
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BA6283DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EBA18C933;
	Thu, 14 Nov 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YqDbf8RF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5D18BB9F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606157; cv=none; b=ruP/e5gKky1g9Mls1vbfTMz17Wf16vVQ5fDcIUWZqLxjzykwySzIzwZSX/iBoUl3/FV17C3Vshau6HdU/lb0DXM1HGe4pz5PdVdz8zbugjr/xhZvVetTucr0yOu5MNLlZ7v54nql87sAj6Qr+4EU/rBdiG4vxYxx76+7Poud8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606157; c=relaxed/simple;
	bh=mSaU8+k6H5UsTO/zFUXIvfBdXgPPqBH46d5GSShwijo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkLEFsq03PKpwelFU+SaiIP4rF/i5/7dS/xdFMuxE1Zpp6UB7Z2uFPjsoEh9ISWYi5QTTKFxI0k3KHGipZo3tY1EmXNxeav1m5vA7vb5moD4QU1S/Ht9Qg2RYc2gxItS/f+UP1c6XUtL47IeX+eRBOo+x5mmX7fbyuFgs0IxGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YqDbf8RF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e8522445dso170665766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731606153; x=1732210953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnfu4AuFc7Ir4mUZPIm/dFK37daLn9XyJCKqN5KNnKU=;
        b=YqDbf8RFCwGfmwhwm1lAEuO3aFRnM1PNnXX/7VPUNC8Yu/BZcLqj2ja5ONW7xVpdD+
         xyVBl4dbdmLW7c/kMqQ2vPYFT4YWS9vUYooDo/tLnhPn0NivRQQujGc6VPvhtbss/DQC
         HfIBqoafz3ej/40KmTsh5JwjgC446ANBJW3OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606153; x=1732210953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnfu4AuFc7Ir4mUZPIm/dFK37daLn9XyJCKqN5KNnKU=;
        b=UmmsBQAaRV8bUDDeOwxrFtgDAAxoBD8iWpDg3PVOKqiujU4Ch7KmQv8QatVvDmxNI0
         m5HweW6ed3LQZnCFVlhmDiMCVrZLxC+LBuyd5yh8TcuVTh0ZXd8sEu454k5iQM1ezXkj
         HqM19dsujYlwt0NyfVKbfRh9fkDGVkPT51w8bPLKrzXgYjTqi2hLSRv9bwN4jOs2wfIY
         sMY5UHt3nsNPJGDTK2w0PoR2gXvSKeyWOfhMvHGEHz4FfdkAcU0M4MAnulhVzIlYSM/u
         oyC8Ps1OjlKVr91oHpeJOEhB7YkPoGRI5GT7+dPpVB/v1zrDTIZrKlp3iO4Rd67HD2P6
         yWug==
X-Forwarded-Encrypted: i=1; AJvYcCVhJW5tJGEXjXTg/oudpvN+CbmcbrHAqitgLIYtbMBlwnpJUbMKxcuPhliL30OBFttZJaSBkof2RB1CHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA301xN7WvpaXqunSalJaBc8adv4velXKGQVN24lXPIXOdANXa
	6vUxiIYtO2tX9d1fbvSwNW6ZgFGNXpSmaFBACtIAVXB5qvh59qaNz7po65SZp+j/PEdalaLO0pA
	VIsLkXA==
X-Google-Smtp-Source: AGHT+IEv0inTWR56iUq5Cbe8QFFr/VhhWPXxaOqwiMjM+UmVRN3Gvuf3dTW+HIctJpGs9AokJz28Xw==
X-Received: by 2002:a17:907:26ca:b0:a9e:1fa0:d2f0 with SMTP id a640c23a62f3a-aa20cd0594fmr328666266b.19.1731606153110;
        Thu, 14 Nov 2024 09:42:33 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e086063sm87649866b.189.2024.11.14.09.42.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:42:32 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso1234710a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:42:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfUaFqMg9qSrdDWPHD2d6HrQT8NyO4baYqFN7z8E4Fm8bnFvyzKLlQk53hjzEgX7mJBbcYMZWiPfBRnk0=@vger.kernel.org
X-Received: by 2002:a17:907:9307:b0:a9e:b5d0:de6 with SMTP id
 a640c23a62f3a-aa20cded0b0mr291909366b.50.1731606152058; Thu, 14 Nov 2024
 09:42:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com> <20241114101402.156397-2-philipp.reisner@linbit.com>
In-Reply-To: <20241114101402.156397-2-philipp.reisner@linbit.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 09:42:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
Message-ID: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 02:23, Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> compiler.h defines __must_be_array() and __must_be_cstr() and both
> expand to BUILD_BUG_ON_ZERO(). build_bug.h defines BUILD_BUG_ON_ZERO().
> So far compiler.h lacks to include build_bug.h.

The bug is real, but..

> Fix compiler.h by including build_bug.h. With that compiler.h and
> build_bug.h depend on each other.

I hate how compiler.h would include build_bug.h, which - on the very
first line - then in turn includes compiler.h.

Does it *work*? Yes. The standard include guards stop the thing from
recursing, and both headers only do create pre-processor defines, so
the dependencies aren't ordered, but it's really really ugly to have
these kinds of circular includes.

I think a better fix would be to not use BUILD_BUG_ON_ZERO() at all,
but just use _Static_assert() directly here, to make
<linux/compiler.h> be more self-sufficient.

The gcc docs say that __builtin_types_compatible_p() and
__builtin_has_attribute() both return an integer constant expression,
so that should be fine (the advantage of BUILD_BUG_ON_ZERO() is that
it works in some contexts that aren't necessarily technically integer
constant expressions - as long as they just evaluate to a constant).

We historically used to avoid _Static_assert(), but that was for
historical reasons (ie it's one of those things that didn't exist back
in the day..)

Hmm?

              Linus

