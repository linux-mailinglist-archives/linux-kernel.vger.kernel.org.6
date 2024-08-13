Return-Path: <linux-kernel+bounces-285436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B7950D79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF081C21A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D81A3BC8;
	Tue, 13 Aug 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SniH4Aby"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6554279
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579332; cv=none; b=UDGrcCGdXERcqMXKIV9ghf8DEK6Ql0C9xmmo9YG9K3MAFjrX5WmFFmNhY6HP26JjC6hqtSFOkSUC+UjXnWxh+8gfebx2O/uWQ+/81KNd8okQAV9AfXROz8X2yhZn1Zw1HOiEE2TLDVB+LtJhiOxiaTx+goAzpGD6saYC6wmuw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579332; c=relaxed/simple;
	bh=PKTqGo+hY1iTdH/E5gkiO28NnWS37lLCc0cy0Hj8ciU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX0pxDT/m+nY6OqSWsYckH1SVhwQ16MSppr8s4bb/s/3d/eyfCKkswIMb2O7Fh9Y9kkAhz0ZsjK8I4ih1NCOhywy4/vj6Jn+r5ug4HzAaaOCUqRVRdSQ8u9E2xdEUfmb56HGFJcbEBIM6onCA9SH+gzNuNp4/7GJe+8cZrLApuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SniH4Aby; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7844489a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723579328; x=1724184128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmAbvdEngFPVAVMDhCM7a1Akua0vJAWV4vuO7e04JNc=;
        b=SniH4Abyr0GeJhJDQNf+XbrcZvtu73AdRDnycxUeQqq4qgAamewzDw1O6tz8D+Y1+z
         EMChY2ZSZo9sZOgeau82tJsa07N37whyBz+xklvJ4lmDvZ69IcofVrDE43M+HPlAWd10
         /Xn5KUdiHCRlEeHEbBshH2DN9iRUrRCW9If8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579328; x=1724184128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmAbvdEngFPVAVMDhCM7a1Akua0vJAWV4vuO7e04JNc=;
        b=dHufhxR5i1HTlupSYIk87KtoK4BDb2qO3lCPlHPDhJouNeGySGk08tUvpnXaPFEKha
         gL7Ldb3W6JoNVjyH21IRyJtlN1BIjVFfrOtSbIVN/C0opSJolQJ51NtKE/nk3j57uTC8
         D+n9OQYRZUL+CPDOTpOTtFiUlzhglMv+wzXTNS/OqgFXZpO2v6qNqg+DXXKkrDM103ui
         uRQHcXsc2FitffYi3swUhk63VwsYRodluitt4pgUcOIn3UmfE9CCptTLjggU6+032ozQ
         4aLtAFJzXdbOafKpwmPFVGMAskC+6Fw1QhVRflegy5DYNhTA44n9muJTp0BRQuqO1ylB
         e1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp8H+SPGcJZOqWpvi/AU2cYfejm8qEHu2e/LuHmp3lgnak0v09lp/GFlOBxTSfS2t9gxvJI/XnVUuntxhtReNrI/G90JPKQlA9CGy0
X-Gm-Message-State: AOJu0YwbmZ5rhpHQfC4vf6nvMM6c9QuEMGznyHVwlwQhkv91N6t/eT+F
	pbt13scyWzlkuhNIJYt/fype4Of31eQVQ5iu/5q6I6tpL69XBkwfwx0C9vwaovTV4A7vyb1/98E
	KB6I=
X-Google-Smtp-Source: AGHT+IFX1ypNDgvus3DTZ9V50FI1u35xLI72x8XHbJq7GTKfkPQys+/iUqUsrsvh4B1EcRfHhioE1Q==
X-Received: by 2002:a05:6402:1d53:b0:5be:9cfe:6d with SMTP id 4fb4d7f45d1cf-5bea1cb3e38mr361926a12.37.1723579327849;
        Tue, 13 Aug 2024 13:02:07 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5dfea0sm3196269a12.75.2024.08.13.13.02.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 13:02:06 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so7718212a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:02:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH/Ii0pkQGaZ7aWlfo2XDWA5vkD5MlveKpF5cBwokau6kv7U2+RygL8DbHNcfQXgrj25+1TrSqyZRQVxrlXn0pgCOU+993Z8AgM+x3
X-Received: by 2002:a05:6402:278e:b0:5a3:5218:5d82 with SMTP id
 4fb4d7f45d1cf-5bea1c7b117mr401494a12.18.1723579326438; Tue, 13 Aug 2024
 13:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
 <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com> <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
 <5d54a189-3c2b-440a-9626-4e00e95a7f77@redhat.com>
In-Reply-To: <5d54a189-3c2b-440a-9626-4e00e95a7f77@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Aug 2024 13:01:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=why9gTVRPHwbyz-24QSmKW1zXrF_pbS-UtDyQddyzEu9A@mail.gmail.com>
Message-ID: <CAHk-=why9gTVRPHwbyz-24QSmKW1zXrF_pbS-UtDyQddyzEu9A@mail.gmail.com>
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load acquire
To: Waiman Long <longman@redhat.com>
Cc: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 12:58, Waiman Long <longman@redhat.com> wrote:
>
> Sorry for the confusion. What you said above is actually the reason that
> I ask this question. In the same way, smp_rmb()/wmb() is available for
> all arches. I am actually asking if it should be a flag that indicates
> the arch's preference to use acquire/release over rmb/wmb.

I think that if an arch says it has native acquire/release, we should
basically assume that it's the better model.

I mean, we could certainly use "PREFERS" instead of "HAS", but is
there any real reason to do that?

Do we suddenly expect that people would make a CPU that has native
acquire/release, and it would somehow then prefer a full read barrier?

             Linus

