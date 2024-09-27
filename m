Return-Path: <linux-kernel+bounces-342048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A42988A07
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0E81C22B26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652271C1740;
	Fri, 27 Sep 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M7XzGxx/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E9175D20
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461196; cv=none; b=uKy2CLSAZLiBQihfs4WCA25ydYje1lOHWmq90vvpJbNCWmbA0U+LH8J8SdNtPOPgfdID+i1FabpAOEuIxSX7Uc+g/pB1WeJNFfrOjwgAA/ZATo0g66EcUwem02BEUGISW7YziGZeEhNOzL7ghVhUe8LQhhjKBV03BPEc0ATAafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461196; c=relaxed/simple;
	bh=07wSPeAgU67g80HqM54Nnsi81+Gz526YFvVEU0VUWqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH3hzieA8s1/ZTwLUTGoeqbrdOqm24zJenCfeM3SnlEmL+aC3umcpLioh8wmmwvQtXjtw3IxEUbQu4kGD+qsOkVlnlWava0eDzUvcRw9luAuH7AeQWHk4i9Mb9OU4wcku+ijyhqiJkXfscQBp9RqzAH+Yz0A+Zf0XEu007qMRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M7XzGxx/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so33364171fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727461192; x=1728065992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUX1kCLvq6+bfGUvOV4xSkP3/ox8tqlvT0bJqmyP1AA=;
        b=M7XzGxx/2ker8vZJ5KqQkgIG3Eu+KaHu/2hFBG39+bnoVpsxRyNOC2RHWIUMSfXk0Z
         rZhiNlZeTSDszibKs43WMys+ZhMB/RXsNPJMUCwuXu5b47cxNYvAa654yyWAAJNobF0j
         VDH2eWVS7IRZQIO/hyzXO+ng5LgziqEqDhJ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727461192; x=1728065992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUX1kCLvq6+bfGUvOV4xSkP3/ox8tqlvT0bJqmyP1AA=;
        b=p5uRToCUt257qTR2HBwl+SVaYKttRij6WCIBhNXqtS9bAOf4ADwcssnhLPjhbVjuxV
         7yaSzDHqSACP79JG00N185nmNjfhUnqzA/dBnK/wrkk8EWURjqQxmGPMw8C5wTzBMoeq
         OJrGXFGURJeVEvHyi2YhNeF7gaWifyJ8dodhXnM5Ny05ll5shVHuSDasCpI2ko8iOGGM
         d4TVI21IESCumLo0VObhOyPPaZpYhFHXYQa+xEXRDJl/KktG218NBf6ZINjxeN86BjY6
         X+ORsPEEkGyBMP+pblORobpc/dLIB9iXjD6Ki6KtrDzxngwKDVHNmjhgf0Qa+sOb7rr0
         svWw==
X-Forwarded-Encrypted: i=1; AJvYcCXkIGTQMvzRAKgUCphI2y2EkB9CkjOTbS5aIFj4J979Cl/USEHo0E5+OepFrR+QxwzhbpsFsgt65BnW6hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4YUAoRrWeWaek2lRh5eKR0WvXl7frv2iUsGgsvBlQ/pfLADW
	LNXlGP2tl6fhcuZkRUU+KVS3I5xD7t5UP1gxRO/nBSqIXHLYWJF02JuJIZDAiIGQhHINahI9lsx
	9b9Q8Rw==
X-Google-Smtp-Source: AGHT+IGk5mG2UP7ylhPxQksOBaVPlAoD5CfSM+NgWscaXxJ0X2b2yX27WyXVEDbZ4bNdQK9nDG6I8w==
X-Received: by 2002:a05:6512:230e:b0:535:6baa:8c5d with SMTP id 2adb3069b0e04-5389fc3f111mr3205211e87.20.1727461192424;
        Fri, 27 Sep 2024 11:19:52 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27756fasm162423166b.18.2024.09.27.11.19.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:19:52 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so1173158a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:19:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXSLZOzaqNsJ8QyvcJ2MmCJi5tqd7ZkHPW4KGibC5NpvflO0SsrDE1AYstMaGNhEYcLMLhnRkL358aZwU=@vger.kernel.org
X-Received: by 2002:a2e:b8c8:0:b0:2f7:562d:cb5b with SMTP id
 38308e7fff4ca-2f9d3e3d465mr41944381fa.7.1727460802851; Fri, 27 Sep 2024
 11:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux> <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com> <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com> <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com> <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux> <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com> <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com> <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
In-Reply-To: <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 11:13:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
Message-ID: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 10:53, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> >   (b) the value barrier needs to be on *both* values so that the order
> > of the equality testing doesn't matter.
>
> If we use OPTIMIZER_HIDE_VAR() on both parameters, it indeed minimizes
> the odds that someone get the order wrong, but it disallows using
> ADDRESS_EQ() with a constant parameter

No it doesn't.

This is trivial - just hide the source of the *comparison*, so that
the compiler doesn't know what you are comparing, and can't use it to
then replace one with the other:

   static __always_inline bool compare_ptr(const volatile void *a,
const volatile void *b)
   {
        OPTIMIZER_HIDE_VAR(a);
        OPTIMIZER_HIDE_VAR(b);
        return a == b;
   }

compares two arbitrary pointer values without allowing the compiler to
then use the comparison result to use either of the original values as
a replacement for the other.

And yes, that "hide both" model will cause a bit more register
pressure, because the compiler will now compare two values that it
really thinks are potentially different from the originals. So you'll
have two "useless" temporaries that contain the same values as the
source pointers, but if that's the cost of having a comparison that
the compiler can't see, that's fine.

Making it a bit less obvious, you can hide just one of the variables -
you don't actually need to hide both m(but for clarity, maybe you want
to).

Because even hiding the value one from the compiler will mean that it
can't use the comparison to decide that the originals are equal, even
if one of them is unhidden.

No?

              Linus

