Return-Path: <linux-kernel+bounces-333143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6C97C479
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4516FB224E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53418EFF1;
	Thu, 19 Sep 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qa4P9XkC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C718EFDE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728788; cv=none; b=RMPjSlIDtnhBOOX7xdSh7w5M+hVY/ES4ulio+7Y2ra6pN/u+LN46pXcHDzWAmGWdEdqEDnb0cWEhYb3fon3b0VZT0Us5xmhGN24uR6Wk/gjyzl/OKhloGgiVLsjpQLag2k1PpUjxEKefx+uXOFz1wBfDYR9jVINU8fQ0g+Y44UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728788; c=relaxed/simple;
	bh=SNG+xyeSaoEynPuXvkVIGLs3uhESwYMX8HsRsEX/v9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPl+HC9old/G69Mldn4AwRf+TwWkwygOOIVhWDoO0h4tgUF7F3UeMttHxcPn7kyNMWxGnWRp2tPGFC4xKKFtqlnIvAI/d67CUjrZ18bte7FOPwHi4j3r4CjmowlY7DSNYYbgRGyBZU+6ceGk4BhEWg8Dhm6r2Yif5uCg3o3owmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qa4P9XkC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso4229111fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726728784; x=1727333584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsgXsH5u0tVyG6FNrWEuco/5eRBOsE17pT8NJW0A2ts=;
        b=Qa4P9XkCNHhbbWs9E5wLzflzVhFMdhwn4pvrXZCjfL7jK8ISa0cqv224eUjQl4Vnbc
         kPJBgoRQ7n5yHnEO/ufw1yijFec7ny9XM/G1aHT5E5gor7IDu8V6ozLUwSWr1DWG8/g/
         H9XR5Q0hbPeK8E96cMhILIb+qviGHZgZs6krc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726728784; x=1727333584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsgXsH5u0tVyG6FNrWEuco/5eRBOsE17pT8NJW0A2ts=;
        b=F7OaSQlGxA9q6aMfW7OytWoKf9YHR6BkRd/+dk6bxKPJZahkQpTTlTIbfVjY2Ocb2Q
         /mhOId0ir6zKOkm6VxWGE5jgHCslY9nlbTVMdCLuIlKIRrguec/BhW3mURADclxHJmRQ
         8TtcK07zZ6HK+6Kry4/DzqWMzAWcKFubJoqfu3SpSkKEN05K9dXX8X0RxuiOYurmGnTR
         LuIKJqP+0k2b7QVkVwKpz4Z3vSgM4Vk8y+zjbKIy7D9iIaeYRnt8811+zcYOYYH2aJDu
         vAwgosomCeqNoVC/4BQRijr4vRXo9M2Epab4yJe+33FkpA/N0DTPSNQThRfRucVOjuHK
         7j2w==
X-Forwarded-Encrypted: i=1; AJvYcCWAP+hXbRS58j5mugoiAVUCyXFH2yxbIJF4DmfiRPi3vxWeDlKfd1KNbpz2YPZ1KwZbabxCNjWK9PrnqhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsn9stwFTgvc9YByyvY2tERftCjl4SyPi8QADBSh4yGW7GeMD
	N/CH0ZRZJ2T90rb5JkCJ/MPW1M+nr3IZ4VhSsH+5D0Hm2gS5R665qySiX9h3uzPyxWqO8KXGRrk
	lR8MyKw==
X-Google-Smtp-Source: AGHT+IEhDii+Q/IT5WVgcgzUPkXYUnkIOX26d0S6hFi4H8S21Ed6B8NgC6BSv0Of4KLCtCEZ9eko4w==
X-Received: by 2002:a2e:be24:0:b0:2f1:a30c:cd15 with SMTP id 38308e7fff4ca-2f791a57fa4mr106266541fa.36.1726728784453;
        Wed, 18 Sep 2024 23:53:04 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5e82fsm5904994a12.44.2024.09.18.23.53.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 23:53:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d43657255so65508066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj2zZk+zFB+9HR0dYWU+h/aQhzyXpJz5VmjKghTL9un13PZI8E7C41EcwJ6f+e9NbpDBGZ+Ghh+g1VHtU=@vger.kernel.org
X-Received: by 2002:a17:907:9484:b0:a86:9d3d:edef with SMTP id
 a640c23a62f3a-a9047b50447mr2106944466b.12.1726728403730; Wed, 18 Sep 2024
 23:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com> <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
In-Reply-To: <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 08:46:26 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
Message-ID: <CAHk-=wjzj+WL6uE0J7d4fuiWAygMzTpvZqZxR+yQJm84TTbBCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, John Johansen <john.johansen@canonical.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-mm@kvack.org, lkmm@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 00:44, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com> wrote:
>
> While we were working on this problem, this refcount scalability issue got
> resolved  recently with conditional ref acquisition [3] (however, there are new
> developments in apparmor code which might bring back the refcount problem [4]).

Honestly, the various security layers should be a whole lot more
careful about their horrid performance issues, and I think that [4]
you point at needs to just be headed off at the pass.

No  more "the security layer is so bad at performance that we have to
introduce new ref mechanisms", please. Let's push back on bad security
layer code instead.

                Linus

