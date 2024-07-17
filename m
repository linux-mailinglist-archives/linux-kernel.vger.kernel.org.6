Return-Path: <linux-kernel+bounces-254596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A72933539
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665BB2831AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD93C0C;
	Wed, 17 Jul 2024 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PODNTPg8"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B717FF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181693; cv=none; b=qmEKRCaBHKuA8jXzMC6PvfIRn4fU/K3xyLcRIhRHCUyi0Y1cTbfcohWdUXctvMqv6NLli4FCgqRXdCtSBO5tG7d7EsAaiPpA7METLOUCNiV5CR4U4MlTiVQuCs+mdLmw5YNVZusIfidP8KZJ1PUOS2SGg9smFsplNtJJiweMrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181693; c=relaxed/simple;
	bh=H3fBaZeUehbLpe13DqgHBVr/k2QHLhtXPc2fQ747bHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twi12Pjs/SPlJx3855KFO9KxJtdnma2xS4WuBXNWIRDwmDm9Y64+o/sEndLLbRGb+NawOfpunPa0bwdEGp9wmdMX3fLwCRPn0EreRMcJMmdsWee3ovuhcU9g0Te5ubw36zuWsRgAyTP5/lakMRzX7K8XGheH9V5PM57lpvkx6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PODNTPg8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee920b0781so63236821fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721181689; x=1721786489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYrqWZq1EqYPi9XpXV1CPlqkOEZcea5WhRbwHmUhz3Y=;
        b=PODNTPg8j5lmJVBFoEwqYVaPKjeSUAg+tQ43p3CrPH/nrW0Qm58p3r/Jyd1KQg1M57
         rXHVkrARCC1fiVxXsf0GAcOYzrn7xXywVws8mwG8tw5d1lDJnEjsFBlyCzYEGYGBrOJo
         bYhYPP1EvkX9D53/dlNKt30yKMADo4TBm683g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181689; x=1721786489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYrqWZq1EqYPi9XpXV1CPlqkOEZcea5WhRbwHmUhz3Y=;
        b=FAfMZOtHBl4WScHPpjqB+O3cA9gqWsegjJtCucd9SveMxljA56CUNYSpxTKvSeZxa6
         m8kdtoeHXBIpDM8w4NgXQM67TAcmPz5tmQmngfFIU2hekKrYfIVJMsjeXy9+wgTPkk7Q
         iUB8TwKPhwUJDA+/x0NwzNEQQfV4+zfcoELA+euxan97Un9LVdjPBzigyUBqUWhd9IcT
         TLvv1S/ttR+xDq9rbUCmD6W3ZL3j5FxcSJbFNdC0wzvZhWKtRivbfuzx1EFkJuF6yA6M
         tVCSwVdmZFm0EIk+xLkGgMSsYJzLMqohbdl8KzWUVkkNkcBUxVAsHHwCIPCwSmBZp7pJ
         LF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV28wG5S3rpoJNE4aqhKK3v8oRYmC02yLAanAvMH64QaWRB62RvUzMNwUFtnJwM8HPFuxJX3z/NGcril+yCytOdibXlZiBDF1Itpdux
X-Gm-Message-State: AOJu0YxlGRuSHURPU+5ztHF7noHqzZe6ievZzmUf+h0roKmSRD+vmi0i
	PRr16Cwj4VKO5tAC0gxtBMxDgHAE8vSJ/MZG4bmX/qCig130yPjTr1ZoKwppk6PzPB/p/5udZO0
	KvLl7lw==
X-Google-Smtp-Source: AGHT+IEY9YjvZE6RGxx8i2iNvqOw2u2meXF71RRCmzUk4mBzMNKf2z3oJMdQz598t28hGi/F4Edwpw==
X-Received: by 2002:a2e:beaa:0:b0:2ee:98c4:c2fe with SMTP id 38308e7fff4ca-2eefd138ee4mr2263651fa.31.1721181688948;
        Tue, 16 Jul 2024 19:01:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59ff76e9851sm852389a12.46.2024.07.16.19.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 19:01:28 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso7550825a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjD43PJkKW812y6dMGpzFMei+C7gTI1dK4lXu3/WbyeEkP4K6whuQVyx4hTCwnujUgKjLs5jIZLqorntNDcjWgqNnsFNQsogcd812J
X-Received: by 2002:a05:6402:40d5:b0:59e:a222:80f6 with SMTP id
 4fb4d7f45d1cf-5a05d0efa3emr256034a12.27.1721181687614; Tue, 16 Jul 2024
 19:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X> <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
 <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com> <20240717005346.GA516623@thelio-3990X>
In-Reply-To: <20240717005346.GA516623@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 19:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxxhjocp7Q92g4vkN75w+VNCEvAS+qbC8aEpguxudMAA@mail.gmail.com>
Message-ID: <CAHk-=whxxhjocp7Q92g4vkN75w+VNCEvAS+qbC8aEpguxudMAA@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 17:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Can confirm. I tried it initially and it did not seem to work but I
> think I may have been using the wrong object folder or something.

I wonder if our dependency rules might not be confused by a new header
file just showing up earlier in the search path.

So what might have happened for you is that it generated that new

    arch/um/include/generated/runtime-const.h

file thanks to the Kbuild rule, but then it didn't actually re-build
the fs/dcache.o file, because the way our auto-dependency works is
that it generates that list of all the other files it depends on, and
it also depends on the exact build flags - but that would all miss the
case of "there's a new file in the include path".

So that would explain your "it did not seem to work".

There's some handwaving here, but I do think that this is a case that
our otherwise pretty good automatic dependency rules may fail at.

              Linus

