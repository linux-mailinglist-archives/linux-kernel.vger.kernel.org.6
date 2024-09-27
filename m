Return-Path: <linux-kernel+bounces-341609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E798825B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE651C2279A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD511BCA07;
	Fri, 27 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLhQ8T8F"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5341BC9ED
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432462; cv=none; b=KTWqRsaqSPlq8j+Z+4YiQQgMxD8VVIDIjBT2bWdNjYBKPDH+NZJ12hSU5G0I13ZSBhFAzp7LldHGyupYeAL3HVdlPwDiIT6ly44D1yO84PXdzF3Gmd/T6EsWNjFK3dOsNDW+x1bBZh9Nw67maqErJw2Kz0mlJ6MFk+ISFeqTFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432462; c=relaxed/simple;
	bh=3JsFW+buO1TNDAkWVuvWqH3Hu5T/i3jeGnsfwh1NJfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMBA7nmPisj5BuojvWvG/AUWKKE6fS4UMz5oX0M3GOBnTc1P0YTOgavBo3TUxZ6z3L7OZZE2TVJjxvz1Ldw3Lu98E4X8vpNbiIpK3BvdaFWmZTDPoJ5vKTECFpgfza99yFXTqu5JlBLh+NJFlw7oyvtU1auahxzN9+Gq7oD5qUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLhQ8T8F; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso1804809a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727432460; x=1728037260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH0pjhh8nI/TD3DSvvV74N9Dvg5uU3ouqm4csnigzQ4=;
        b=fLhQ8T8FSE60fL/nDsaNz0MjIx0G+CjcqJyAco+h+aCo5R8Cr0jrL/rJYPCWuAocns
         sBYdCk1psM3xO0ieF0vNc2HjkL5LjXALFnNwiJDHb3zIt2plwNXzTRcfQIbHhJgCsu0e
         voMsvt9mFKQZM7SkcKxNgYKNMz+/RUftWTx5UaNnY6G0vYNTVcyf48fG83IX5A+G19y6
         /km1tH4usENYqAaYKIctOHX2dRCVvWoNj9DSL+nFdK+ky6OfyS5T0tpisdie+Npa+cZb
         oP8JChpzReqHD9Pq5oNAJCpdYl3lzFaLdLhkf3ed2FFUerUf3/4v/F3Jrzb9dmTlnAwl
         P2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432460; x=1728037260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH0pjhh8nI/TD3DSvvV74N9Dvg5uU3ouqm4csnigzQ4=;
        b=nyrphYfrwYG13dBPCVW3oHlSACsmfe5+EE7QSai1U1DSiQxVOHoCiwQz0WMSZoPBUq
         lj/DcKKHZ2/0x2MmsrZ2jF1fw6Q5Y/fRV/6V3cOYz2BbEkzAwrorpMk+5HF+4GB7Qee5
         i2o8BrMuT5hPmKiJPSQ8d+t6WWnyPAVbg0bQJJYN9MxpItRnp3+5PPO5BkR0ULsFEl+o
         zXmT9bJH4Q7DtJ4Bn0Zh5acFfEDuI/jUsxfiTTStczE70jVF2P1YIiopjp9V36HRu6vO
         8FUOfp3TC60uatcmRIRMAOB+FUy3MLgUGJm9Ad7oxEQYZtQgYBTCpnNkOpI1sHdWO+l6
         vmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVPR6AFBXouzjZXl6YxZCdtZqPskFE5aaeGqETCGGqnKWYO0xPijm6LplHj+R1zjISDzF1BvxL063XJuEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxger/ImGd3sIm9hc1hutxMqYt5/5nee2prJAXFBcsHpJeIud5t
	wX2NlyDGq8YnymKgOWJ1qMMlY4ocz3R44A8T1J4YP0ejHyv9/RNX7W4VrJkuEEUSfih4+ewQd4t
	+5BPWBtYSZdzlH0x8Nxin00+tCbOzo2R/lvvC
X-Google-Smtp-Source: AGHT+IGtd8RfFQOSgV+YA5sxqgRaUKal1sykqKa7bVrfG9DD2ylUUytH7Tr3gXZ7+duKQXCgRY47NWeES9bXHEPjOQg=
X-Received: by 2002:a17:90a:68ca:b0:2d3:c638:ec67 with SMTP id
 98e67ed59e1d1-2e0b7985441mr3282439a91.0.1727432459801; Fri, 27 Sep 2024
 03:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 12:20:45 +0200
Message-ID: <CAH5fLggjvWchAeSRXvw=+qNVEBMKBp-7fAk5z3JLSuc5aUz5=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] binder: several fixes for frozen notification
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>, Todd Kjos <tkjos@google.com>, 
	Martijn Coenen <maco@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Viktor Martensson <vmartensson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:36=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> These are all fixes for the frozen notification patch [1], which as of
> today hasn't landed in mainline yet. As such, this patchset is rebased
> on top of the char-misc-next branch.
>
> [1] https://lore.kernel.org/all/20240709070047.4055369-2-yutingtseng@goog=
le.com/

I looked for other inconsistencies between death and freeze
notifications. I found two:

binder_free_proc has this line:
BUG_ON(!list_empty(&proc->delivered_death));

The top comment has this line:
 * 3) proc->inner_lock : protects the thread and node lists
 *    (proc->threads, proc->waiting_threads, proc->nodes)
 *    and all todo lists associated with the binder_proc
 *    (proc->todo, thread->todo, proc->delivered_death and
 *    node->async_todo), as well as thread->transaction_stack
 *    binder_inner_proc_lock() and binder_inner_proc_unlock()
 *    are used to acq/rel

Both mention delivered_death but not freeze.

Alice

