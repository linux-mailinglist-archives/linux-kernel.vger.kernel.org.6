Return-Path: <linux-kernel+bounces-311755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9B968D17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F8282609
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE61F1C62B9;
	Mon,  2 Sep 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vv+5ZrNu"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467241A3058
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300635; cv=none; b=bIFbMLUphUCk6oQqITLXVCd51lFY24bcaK+564YMbCwqeEQzImFyaWDhrTouyr0Cx8DAzbg5PHybxA411YPh/lDdxoQAOA6LlpJ+hc71xtGWBRYDmyWkUrJfe3seQAucV/Q81N9gbdJtMoH+ab98Yo2YX9zWenmK5pDFm0dV1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300635; c=relaxed/simple;
	bh=HgOn/3IiUVhbrjJvM1lNiNzrymo/kFrhHrJKVu/yhaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkxGrkIy2ggcrivJ2FLiZY0ezraPPxuYsbW4Zv7lG/HiStdaGnStmv4kC5VigHyHAmUVEMeFamEp3vO7WwR/u82hSEkHmXHlV0uQ7ocipHeVgjw3EG4uWEv1Kl4AcpCe3ARbXP7ZRu7cK3iKYTNkFB9+ob+uAEoeW261y76YHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vv+5ZrNu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86a37208b2so518754766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725300631; x=1725905431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=Vv+5ZrNuSqe6+OZ3IkTaUjHYIIa2QFrkcOy21ZW3mrK5MEC03QmVGLMEs4/Cx9AYhm
         WjET1WT09cz/qSS0j7IXl/JzzsYdRnlvuaz9L2OSyK9p1yXwarSta2I9w1BsWMosPozR
         ClzL9MCpGOjdw1bZr6n7kOkk4y/4iE2jYws0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300631; x=1725905431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tKnOa4A90IoF/EoF6/zH6Ks3lMs+xeYBCb2/giypxQ=;
        b=LW3+VUIXz55p3iLXJ4g52+jiWJTTcTJyoSoadNvrtIKf4Mo4M89Xt8RSQfdm/elEII
         6zplQius4YG2Y3mp5SVuYcBrRulgLsweYxS/jiw/FKWLKr0MgcZRMIgnK2Ahyukapofx
         wriGcylyduuMpXFUORnVjfjjPQPDTIYGhHQtS8BMfMyAzXbNmH4K48Jym2bUxb5VCDGO
         cKuseA8239EWYraaTS2ePTBHJmk88beeQqyHPlrzzCxog3+AYHtNmo21lmaIH+2tmsGK
         9WYuxynrSRAuAfTb1ZGRbF/y0qn9tWqB25OBstuY++pT1TA0SdWUde3a2atXcz+/+hou
         4v3A==
X-Forwarded-Encrypted: i=1; AJvYcCVlXAwLKgHAtn+mfdImhXfTBXeZerO8gaRmClHFviJklX/LpfZ2BZAdZl1hyrjdeVg49dfP5msRGT+9FUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxHieUoLthkO8m88TegrPXtjhVDbql6CCC8Mww+TGbwtQ2bqd
	F2RLkcGAwo9vp0eiJZ6DOValRhko9bKaeAqOU4lOVmpuWD+hiy0WOAf6n9ponVUx9oU3SBcwSX+
	XmZs=
X-Google-Smtp-Source: AGHT+IFYgDqe01Drg0VR3eC6ruJJ8RcSmpcgGCTcMLSQx6CMgHQrS3FTEyPQi40KLrGvrMdOAXRDVA==
X-Received: by 2002:a17:907:9702:b0:a7a:9144:e23b with SMTP id a640c23a62f3a-a897f8364demr1111551266b.19.1725300630928;
        Mon, 02 Sep 2024 11:10:30 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fea68dsm583534666b.26.2024.09.02.11.10.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:10:29 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5658885a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOXhKglW4/Ea0Ki11f9cX6iqSjFClEox9hSCOOa2u+rHI6KvPdFATyO0eur2gf0is+uGpEqgE/E2H0TYw=@vger.kernel.org
X-Received: by 2002:a05:6402:3595:b0:5c2:50a2:98a2 with SMTP id
 4fb4d7f45d1cf-5c250a38f97mr4049161a12.6.1725300629265; Mon, 02 Sep 2024
 11:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240902154334.GH4723@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:10:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Message-ID: <CAHk-=whef03dn8OWJ01L08hShVHCieVz7Rrzr1HJQOriVBvaDg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 08:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> and Linus took objection to similar patterns. But perhaps my naming
> wasn't right.

Well, more of a "this stuff is new, let's start very limited and very clear".

I'm not loving the inactive guard, but I did try to think of a better
model for it, and I can't.  I absolutely hate the *example*, though:

  void func(bool a)
  {
        DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);

        [...]
        if (a) {
                might_sleep();
                activate_guard(preempt_notrace, myguard)();
        }
        [ protected code ]
  }

because that "protected code" obviously is *NOT* protected code. It's
conditionally protected only in one situation.

Honestly, I still think the guard macros are new enough that we should
strive to avoid them in complicated cases like this. And this *is*
complicated. It *looks* simple, but when even the example that was
given was pure and utter garbage, it's clearly not *actually* simple.

Once some code is sometimes protected, and sometimes isn't, and you
have magic compiler stuff that *hides* it, I'm not sure we should use
the magic compiler stuff.

                Linus

