Return-Path: <linux-kernel+bounces-246169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F262E92BE76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78541F26416
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C819D898;
	Tue,  9 Jul 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJwghMV7"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F230433BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539110; cv=none; b=ByDy+eznfGV7bbsdho4qkfeH82Yd0PR0YP6pXggQtg7EjO+9FvSAvY/au6dT++vMiH/xb6YicCgpJyXbm3cULbrDxVvjRXfxyPnijetmNonIr0lBRucb5vZ5xdfewm4vD+ki2ybLyr8SH3ZAipEBkZDqpnlRnB2Mj3k97j3JgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539110; c=relaxed/simple;
	bh=voZI5s8NJ7G6cqBvxozBaN0IUoJi+5Na3Tpon9hVe7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ougdxK4p3zIVX/9+U6jzH2scr622CElUCPY+6MExrGHBnYmTyNmTnVQfOIzFqHfHz8oRGkQBPiT7uh9x57EjUINMzgl4Dq3BUU6T7MJdLhAjGYXegQ67ZBhQvZlyCxqypiaoRNafn3PpmtYjSpb2USSnd/83qLJXcTHHRg1sQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJwghMV7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfef5980a69so5496625276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539108; x=1721143908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQoKhA+ICd3MJpIZmDmZs/xX1LjfxyqH2Gz0ml2Sepk=;
        b=OJwghMV7yN0k9UHa0lk7VpVtaqxiR88169IcFVg+WZKL283wZmhN50dP74AK6bhtwg
         YcJ9Md4gfmOMWI/X5Qjm+E2Lkb+IqKVez21rsM5Tl9dH6xfGjcrGaSafe1VyBeklnwZR
         ISOCw0kZzkBR4Izwavd4OeRzsK4PD2Uk4gx/1f3fV4Jy2+KeCVaqTOFu+o6y+W0FvKIG
         eUIhWOxhPo/FJTSw9ZMDCkXBFVCcupxRy4tcwx/laFXLx5vfQXmencSmieAPWk+wTFZZ
         UEiSW+LpntVFNjdmxGp8pxEu+lR35QMxUFTdBviMrJdGBjR+G7FGn9cQ8hmqCkVEzNek
         Nn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539108; x=1721143908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQoKhA+ICd3MJpIZmDmZs/xX1LjfxyqH2Gz0ml2Sepk=;
        b=c4mTrZJRD0wiuGNooqNNFI1CGOcI3Jt0oD4wcx6c5e/yDPeSKQXwqUZ4FkLJY4hKVX
         hexhRH5WbxLKfjLRdEos1nOUFul2IP0ryFHUXJ3Tu3fCaADXAdPxQKDbb7xPLP0eNErJ
         0HScBJd9viEP2tYjKToxCPwcccL86J7G3W7IxG4366SBh+NKKbqLji/PTHQUE9PTLVRf
         jRkzssTDUkEx3ufEl6S5FhsdJ1eUEdULS3mUDvAKgZ46EP0UGfLZK4vhZ7GSp5HYSm2I
         mrT8OZ644zIaBxAoh7Krg8X3A9s7TwNiwOAhg25w6NaMlNyejjMLTjJuzdzEW4dRFB4h
         QMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZipjnjnWQnzRiOiKqn2HlmQmyYpdMv3830wRjsf7eMXa0DnxlEWibKwfjmRpB8KeF5f//71efpBG/gNCKQYhRR87Z9XQOsNAB8qli
X-Gm-Message-State: AOJu0YwU2WbKYdDiEPBFw5W1s6w3sFCKMeVy4iB3fgJFGgpM8IuawaGG
	ATngNYf3mn3H1KZKxHpOnG/sLbnICxhJ2YAWsgmu0YqjMRKfwqrlB8Z486M2ctAz1AozLHH+l8y
	bAGdz8BdA/BbMJXYUXO+yBXCYu+I2KSjEhPijZw==
X-Google-Smtp-Source: AGHT+IGAIeptn+tE7RkQYiH+yO0nFWuIoGL2cBnHEGQOA05tCKNOiKuaJATENwPLzVHZt9hSxTz4NtjwLh9UJcOo5kk=
X-Received: by 2002:a25:d30b:0:b0:e03:6241:b8f9 with SMTP id
 3f1490d57ef6-e041b070896mr3436258276.1.1720539108320; Tue, 09 Jul 2024
 08:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org> <20240708135310.3VRFnmk1@linutronix.de>
In-Reply-To: <20240708135310.3VRFnmk1@linutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 17:31:12 +0200
Message-ID: <CAPDyKFo6hE9BPgS7Bhe259Mxki-KBZDYyMkaBPFuznETbZhGkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 15:53, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-05-27 16:25:50 [+0200], Ulf Hansson wrote:
> > Updates in v2:
> >       - Rebased and fixed a small issue in genpd, see patch3.
> >       - Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
> >       - Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
> >
> > The hierarchical PM domain topology and the corresponding domain-idle-states
> > are currently disabled on a PREEMPT_RT based configuration. The main reason is
> > because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> > genpd and runtime PM can't be use in the atomic idle-path when
> > selecting/entering an idle-state.
> >
> > For s2idle/s2ram this is an unnecessary limitation that this series intends to
> > address. Note that, the support for cpuhotplug is left to future improvements.
> > More information about this are available in the commit messages.
>
> I looked at it and it seems limited to pmdomain/core.c, also I don't
> know if there is a ->set_performance_state callback set since the one I
> checked have mutex_t locking ;)
> So if this is needed, then be it. s2ram wouldn't be used in "production"
> but in "safe state" so I wouldn't worry too much about latency spikes.
> Not sure what it means for the other modes.
> I am not to worried for now, please don't let spread more than needed ;)

Thanks for taking a look and for providing your thoughts. Can I
consider that as an "ack" for the whole series?

Before I decide to apply this I am awaiting some additional
confirmation from Qcom guys. It's getting late for v6.11, so I may
need to make another re-spin, but let's see.

Kind regards
Uffe

