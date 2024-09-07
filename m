Return-Path: <linux-kernel+bounces-319567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83896FEBA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A321C220B8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4EA927;
	Sat,  7 Sep 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bhnBuB97"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C04C62
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670113; cv=none; b=mqHJa6XU3ny4cPfXBQOhpwtZkr30GomJmDODoFvgikeYL7tmEE2xrJrcSjBE1ySd4bc1a+cPQvN0p4Kr6xptfbUPrdtuLe8VW2106XsjsPmQFzlug0lInECsAkHSP5UOfElh0qTIYzZSYWnJZ47YslRjRZ/W1/W38xeAHdm0bxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670113; c=relaxed/simple;
	bh=UFUaOWELgtMfFEsfIQ6vW+7mTZedBrO6HDqKObAmwFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faw378equNpvSk9rLIqd1P6OM3v+oog1Oj5TgeVTbjtf44Mgqjs49FOZNJRi4yjYM3TRcr8teENjl1lJ3AhuyzqS9Iiu/ZSeVcLNxuVuka+aDNifmktjMFeFjq8zj20H/Ia03mpF+sj0A3WK2pvxovZy6/ysWUKrQ6QfvZJPudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bhnBuB97; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365c512b00so857444e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725670109; x=1726274909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8jlGegiEN/nXhAMG4ddyYE+bSxApyov+rlpPE1WvsoM=;
        b=bhnBuB97hp+hXafG/uvWiu51WGJSGadQV8V0/3zLWgRM7OlmqlX6WNRGzQdHpBRmz1
         IjhTNG6P+o+mQuxbSqpOzOl+0qRrcWwLnTkbVQFP9JtFaEhxdc7wODeUvYWEiBdH+lAy
         lI0GsDkU2x5vLj/9aRRq3ZaPg9X7oNWZymFdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725670109; x=1726274909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jlGegiEN/nXhAMG4ddyYE+bSxApyov+rlpPE1WvsoM=;
        b=YAVyf1XbL40ZuvxaiEzWuFvX3EuTWyObfQYDdNGVZ4zV3Bq8mEn0WMVuoese1AnnRv
         S8Uk4U7HTzc2OMTMmGXC733vsI2NLxNLWgaSXGWqD3z0lTdiMkTWY+sJoaO4lIn0YFb/
         BPgDbiWlg3w5QcZj5RgTsX5kfN9NVRNTvVXCS8jIWkRGD293y0E1bPJpIS3Mh2ysYuRV
         1FpA9nWwF8YJEvpdbYo1rOgQRT720TtU6Mqv5uln+IwGGOVHRsdJdoqQnIz5JVaDOBLG
         6giUb9qx7WQExaE/CR6GxERGaRUIryWrUtabvVhF4NxMZuEqvMR9LXWzxhsXMLEwAL4h
         rkhA==
X-Forwarded-Encrypted: i=1; AJvYcCUTzX4IkXC7akSeD375f7HGNw5xkM/esXOq/8iOTV+0OIOMXj0pmlv2z3io8SDHsTKTMkwmiupNcE+9m30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKg5mi0KWomNQgPIB/Fjsn4Ifv53GkOgM/Fuct/6OFJq6zV3b
	gnD6nuwe/OZGF1tyNU16dF1WtCJa/u2QuBV4U2GLuHTSf7hLLBXlJ8o2R/+r7c6/W55cub30CTh
	pqKShwA==
X-Google-Smtp-Source: AGHT+IH7w64wzoNte/Wz0hfGhOleClcf+aOH1HrOgCaHp59HrJH6VyBvj0pUgYvBzo9Nq1HGDKnt0Q==
X-Received: by 2002:a05:6512:2347:b0:536:53a9:96d5 with SMTP id 2adb3069b0e04-536587aa8e1mr2486973e87.17.1725670108182;
        Fri, 06 Sep 2024 17:48:28 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903ff9sm9370e87.230.2024.09.06.17.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 17:48:27 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso1117281fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 17:48:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRY+Oz6vgmkClZRjClHqMrIfOQydXEKiOwCLENuZ0UwMhGckKL6sEyiCqABPYdmdOrMS1nti33OHV9vv0=@vger.kernel.org
X-Received: by 2002:a2e:6111:0:b0:2f3:e2fd:7dcd with SMTP id
 38308e7fff4ca-2f751ea7abdmr23935841fa.6.1725670106422; Fri, 06 Sep 2024
 17:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906154517.191976-1-pbonzini@redhat.com> <CAHk-=wjK7HF3dQT8q_6fr3eLGvKS+c46PdYNVAsHRyQRgcgiyw@mail.gmail.com>
 <20240906233958.GA1968981@thelio-3990X>
In-Reply-To: <20240906233958.GA1968981@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 17:48:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0ePNgwLfk8yddABjnZh+gcL9dV2E8mxLKfb=8LHFQ-g@mail.gmail.com>
Message-ID: <CAHk-=wi0ePNgwLfk8yddABjnZh+gcL9dV2E8mxLKfb=8LHFQ-g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 6.11-rc7
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 16:40, Nathan Chancellor <nathan@kernel.org> wrote:
>
> This was brought up to GCC at one point and they considered its current
> behavior as working as intended from my understanding:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432

Their argument seems to be "the missing fallthrough has no effect".

Which is true.

But they seem to be missing that it has no effect *NOW*.

One major problem case is that people tend to add new cases to the end
of a switch() statement, not counting that final "default: break".

So the "it doesn't have any effect NOW" is true, but the next time
somebody edits that and doesn't check warnings, it *will* have very
strange behavior, and it won't be affecting the newly added case, but
some entirely unrelated previous case.

So I really think the lack of warnings is a gcc mis-feature. It leaves
code in a bad situation going forward.

Oh well.  Many times I have had to disable warnings entirely because
they have too many false positives, so I guess the occasional "doesn't
warn enough" is still a better problem to have.

And at least we have (a) clang warning about it and (b) require the
warnings going forward and use -Werror, so at least for the kernel the
"when somebody edits that code, you get surprising behavior" case
_will_ get noticed.

                 Linus

