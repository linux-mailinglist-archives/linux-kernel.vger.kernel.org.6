Return-Path: <linux-kernel+bounces-380303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D569AEC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E4B1F23E91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542B1F818A;
	Thu, 24 Oct 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqXhsCtn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CA1F80BB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787299; cv=none; b=n1LQBK0+ywceniUWqNzreM3o5V7F+cRv5w6ZvfFfxgayicgFhdBXe9ziCy4DNWOeabhSOMQgv2fqGHao6OzVlaP1Q9N+uEUSEQDGzULKQmQMrHlXyszZJMVrFG/xsqQSRTZ0kq1zcprDM8hCXEuXXdExKXlBsLClfS8Ckq8D5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787299; c=relaxed/simple;
	bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFOLooCjTtiXe+12hvzzk0GWLy1gpISCejnjOOfKMzc+692LCTHB53Fv8dss0gTEBL5UgWxoLOVQxPIKTT5F2Dk4nN3+KGRgJelugiHY363wi+bHRKbhRn0fXUVH5zpBm/K47KDDoyoQriks6n7+W622U3tRkEeYjV9tOjp5gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqXhsCtn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787296; x=1730392096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
        b=VqXhsCtns+ufLmDPexYhJarMnrxej8oSEXMijBEdGNWB5jJnDjohC3Jb+4GoTg3Uxf
         PsFFFznWc/x/B+FkXDKaCPGu7SZqFve/jC5gRe9vjFDDzSUdq+bXwyDp/9IAZKD5YtjW
         nHR3Gz0/VwKGJK5ZdoeyepW/FPyfli4Epi973EQjURGDu9o7DpD7O99ggmy3LZuSVO8I
         0bVxpRft3EaFw6T5U4CZPuB5qzM3xzhLgMiWM/O5KGV8u+s8In5kvMV2q9YQvnRKCGoX
         musX8hLLTv4U7JgpJz0rcqkLzpywXOs9u6mmTnGXXqwfdiF+KGleUpuqyPgiqxtC4cXp
         oooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787296; x=1730392096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
        b=elyVPm3uGYicbTdP7tXi+gJxpUgPyip4icy6LEGU3Vf8vCMbix6vmoZZafiQQ16RL1
         kViG96+QtJPn90Xi3ilA2LukJQ4m6sZHjw3gBxcOhHvgfaquBoqr+0cy9lOaEFifqvk6
         XIBTS0IWATAkPJT45tjyMnXnUmg4pjDWgKq7gkWkI6cdo0krk/RWsIeIgKB7kynRPp8/
         RRNGE4ooXoSK+Z2UXXFjn6IhLIeJ7S6bsnERg0IOcF4YvrZcM37ESuFugk9nLGmPq+o9
         b7iOBEew0imMx8uKbT+blf0hD30bCvyyFlGUB549iFpZUEmypw07RMdlpC0hLkWsITjN
         /mXA==
X-Forwarded-Encrypted: i=1; AJvYcCWKF37q7GDlxmvrd+pC2cyIkiwWQXjQ2q+/5Obv/ZZ7eQBfPn2JuyM5tGAKZqyRylXZSPHg0xs56NgEBQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJC6IMXSgs+OV7MbA2AyZ6cPGtQoI0Iq+bZYdcIXr+MhlnxzmO
	QagCldgs6ja/Cu1q2mPwn8O7tPW7T8MY1DBa5D9uuVJ+HTzeHiMyksax/TA7K2IeY7lUoBtMDj4
	HgTeCI2tueZW4l91pD4Q9vDHwjQ2x8pjpUPFe
X-Google-Smtp-Source: AGHT+IH6GaCTFse8PHhR99yRvdJU42XjOZhxxrVWX7RUwgX5aK9xyEy94yBYp/VrB+JAVrmpWoM6bBGXa7q1ktnK+/A=
X-Received: by 2002:a05:600c:b8d:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-4318a4ace7bmr5573175e9.0.1729787295526; Thu, 24 Oct 2024
 09:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net>
In-Reply-To: <20241024095659.GD9767@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Oct 2024 09:28:01 -0700
Message-ID: <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:
>
> > > Or better yet, just use seqcount...
> >
> > Yeah, with these changes it does look a lot like seqcount now...
> > I can take another stab at rewriting this using seqcount_t but one
> > issue that Jann was concerned about is the counter being int vs long.
> > seqcount_t uses unsigned, so I'm not sure how to address that if I
> > were to use seqcount_t. Any suggestions how to address that before I
> > move forward with a rewrite?
>
> So if that issue is real, it is not specific to this case. Specifically
> preemptible seqcount will be similarly affected. So we should probably
> address that in the seqcount implementation.

Sounds good. Let me try rewriting this patch using seqcount_t and I'll
work with Jann on a separate patch to change seqcount_t.
Thanks for the feedback!

>

