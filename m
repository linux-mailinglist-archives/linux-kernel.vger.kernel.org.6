Return-Path: <linux-kernel+bounces-266253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBB93FD37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A43283505
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F96181B83;
	Mon, 29 Jul 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PtgIEXHr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E87FBA8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276983; cv=none; b=V/L9JIpHJaZvL171EyGQS0avUGdJSatnuSVJjt7Zqiyth+DQjTFPmroU4tiPoJ3xSytEx7jDZXLukmr/Goa2yQmbtNrADHwAOY1sV+RLnvFjhp4MNLtlNtkXA7onlnHh110my4DX77kdHSqxQ4ONgEhWARKXAA9dEE4r1QNHVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276983; c=relaxed/simple;
	bh=LIl46PKiTuHOChuDuKYcVHWM3SfkOTD1oJCyG3S2s8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWCbEX318KEH4Wbur4lBTUqUm1s9VGAHk5z8GCo6tOdJkIa506qlTBKvFgzRPGbxFLT9o5UT0/7OP4UKOWXFfcv+WW/WdET3zRA1z18KGEz0RskZ0vJN+STd5y7j+ku4htoiUJ6Y25Ox6X89EQ4/mFWBzIieyISK5PUhS5AdI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PtgIEXHr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36868fcb919so1583844f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722276980; x=1722881780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jB5fkTKm2Ww7Qd11d11d2YKMGg7fRbgq/CgiCr/mNrM=;
        b=PtgIEXHrsC/ambMOc4KlVO6WKzcp5n5TPO2WBAi2Yyafb+PNaMSij3d138Q3gU/EBU
         PpXRZZYF52v6dkv0w65M2TLLbVzL6GvruyQusx0oR9Pz3zi8KGEfM75AAvNpK+/y7IKB
         OEVTbfLeIta81i1ADMZ+gN+6ATpbFKGTweoA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276980; x=1722881780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB5fkTKm2Ww7Qd11d11d2YKMGg7fRbgq/CgiCr/mNrM=;
        b=vjc0vd/y5x/9QwwY7w244METzhDy2JR+Z6yfBtlMQMugRs4wyqMOS/bDQdhOMhF/rP
         d3NBzZwgzl60ddVEmE14iPzi7sRjc+Zjp8K1A2hbcbRerCRDomr9Q9sajWA4gIgV63xN
         SuFx/fSQcblBKSccADaWt7UU9Fpn9JQ+bh+guX0mKpeEPXyAGTZzwPRGiwqmJhtpdyIr
         oSik/2RjVIJo1vD7nvugSllioQZOUfQp9G9CSO22A2OEB8/0bvOJ9oeZ5OoQ6ZAAWNru
         7HSHoB+e60W3YP6zK9okL88E7KLYnJ8oh+EaSCEt5xL4mjMZPw2zGsAE1R8OAPvjgEbm
         mhcA==
X-Forwarded-Encrypted: i=1; AJvYcCXmj0630wb1n3qUp9X2S47k3kX0ufHbSPdjJvTO9BD6SVky2V1bvjWv72THr4fKeDWBIgPpJfjkJYGtoQpWkyMECGFb1cTa9777K/o1
X-Gm-Message-State: AOJu0YxQrwoSd1JniIPk8deq4TFvX91EQ7TU9pKHM6Dx0T7kC11N0+g9
	o32a45GzkQbkJ0PqhW/0ZFr+qAbL9FR27wIPPvDe8VGFXv1198YDJW35JBOOO2xHg2kkk0DLgrc
	gM8Dl8A==
X-Google-Smtp-Source: AGHT+IGRiAVDzH4j8Xp/TFvq8Hn+AQXvu+/ovfHzd8KnZH/1oSSgDto65qtgFr1D2zHUptHArgAoTw==
X-Received: by 2002:adf:cf12:0:b0:369:b838:9155 with SMTP id ffacd0b85a97d-36b5d353b7cmr5626126f8f.40.1722276979709;
        Mon, 29 Jul 2024 11:16:19 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c95sm6192407a12.50.2024.07.29.11.16.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:16:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so5678582a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:16:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCDP78aYSnj0AqWH2tgCl398FEffZ02IHWgCYn+ZuxmMlPVoJBx8qX4Sh7LZw3vZ96ZyiubPqczBTzYpV+vBiDxO+Ljn3IKf1lyjMk
X-Received: by 2002:a50:a695:0:b0:58e:4e62:429b with SMTP id
 4fb4d7f45d1cf-5b0224ceb1cmr5305382a12.33.1722276978788; Mon, 29 Jul 2024
 11:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7eb34e0-28cf-4e18-b642-ea8d7959f0c7@I-love.SAKURA.ne.jp>
 <2024072944-appraisal-panning-a0b1@gregkh> <f9b4ff23-ee3e-418f-b65d-c40fe28fbba8@I-love.SAKURA.ne.jp>
 <2024072930-badge-trilogy-c041@gregkh> <Zqe76gATYUcDVLaG@google.com>
 <CAHk-=wgweFg4hOus9rhDEa437kpkdV88cvmOHeZWwhgSa5ia1g@mail.gmail.com> <ZqfYfIp3n7Qfo1-Q@google.com>
In-Reply-To: <ZqfYfIp3n7Qfo1-Q@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 11:16:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT8RzFUVXe=r3S9dfCpV+FhARgtb5SxLDSOKCJKCLOZA@mail.gmail.com>
Message-ID: <CAHk-=wiT8RzFUVXe=r3S9dfCpV+FhARgtb5SxLDSOKCJKCLOZA@mail.gmail.com>
Subject: Re: [PATCH (resend)] Input: MT - limit max slots
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Henrik Rydberg <rydberg@bitmath.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 10:59, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Can I write a gigabyte of data to disk? Terabyte? Is petabyte too much?
> What if I don't have enough physical disk. Do we "fix" write() not to
> take size_t length?

Dmitry, that's *EXACTLY* what we did decades ago.

Your argument is bogus garbage. We do various arbitrary limits exactly
to head off problems early.

            Linus

