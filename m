Return-Path: <linux-kernel+bounces-522808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE2A3CEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C37116DD12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC419004A;
	Thu, 20 Feb 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PonCgoil"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F22F3B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014901; cv=none; b=qWRVqRzhzvYw5TWOHeknli+9bQBQ03o3fEVgOal2/9tEG6JszlEu6vCx5j2r0iDIIbPWg94PrVisNwPexaUlCK0xYtTER1EccPY3OSJ79+ICl1Yy0qgGr+al4fGUL6LuS9gWQ3v+uO33T9JIUHdnstJeqf1nZUE3xfbzng2zXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014901; c=relaxed/simple;
	bh=a/O/h/jPiGjc4TGG/pt+Cu2AWbJ1PHxilINnTaEszI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl6UkOxvhxZe3MhbV7SOGq5g2X8SnQqaSFtE/GyVenmR5IfmrdLuSBiIJv5eXaZdytsIAGVrfhj6fQf5drMevuZHVT4bdwr6Jrnku3m5B7XMDUalNOzqPsROtR/RORY+axBAlWXooetIsvK8mMqJ19MYMgRFoKjTiWwGpI1xCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PonCgoil; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso490467a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740014898; x=1740619698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/O/h/jPiGjc4TGG/pt+Cu2AWbJ1PHxilINnTaEszI4=;
        b=PonCgoil0odQQKWliWVIjR7IXbliYeEVsjBhA4lnJ5rdfJ5UzpQiIvLKc2tNQaYHE+
         XxcBUhIFoKYwoNDT8bzqb2vDK+WrTjuwnIlqYtn/bS40kEoA+8stXVprxzuCluUofXhu
         j9d1y2ihsBgx8U1q3Zv3kyJEIIGjJhEgRFimO0uNwTJ6tkSO5JLPvkj4s1NPHwZfkmSJ
         wSyWRQD+eARPC76FXzC0wbOByJKx3e3bLnCVZOzm/D+50yke0B2EimijH2Qp82TWnWno
         iaSlsmH3PSiLVXNR3EnrQmACS9vQ7hba5xDiA8nZXgiVfzqTToiUJdEs7J2LGYxTeNfB
         vtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014898; x=1740619698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/O/h/jPiGjc4TGG/pt+Cu2AWbJ1PHxilINnTaEszI4=;
        b=VTgDaOIT7FUkvntwPm8Y7qXdEldhZZON51MAT8UH9uCABmQqj4dLg7p2SOVNasTg+3
         9wvz99Kbba8+KgCvcV44uMKKysyIk8be2AOum0HsbZ633FdWKjtXRwK1TtpaMY+MwUUY
         AHYXTFpyoALl/GJowOpioYlf8SXpPNKZ+4Icz1Mmg3ywc/GY109oEUsqV8c7DgrpyXOe
         2crU94VUPpOwbaf5WRN0JKCQ2valluLu+1Bkvw18c4g/+YWEJTWQMGEVr8oSTZanDltR
         i230ErGEUCD8khHCYletkneTqF83hvm8zp7UX0XoKLKpHXOE6ze93Yw6fRCcgPK1Mka7
         U7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCU1kHMlyndEIzijjeEEF234MtFtx2Dir8y+rGQbfx6SZwCmUduC4/eJfEtnzWmQwHGWz9zGiHoM5ayLCJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDwdF9Lqdz0Zi7kdojQQqZ0zqMZCVPvAnLvQqJV925cKNnw7S
	0zJU2Shzc/kHrODwblWu9JGpBdLcAGc14Hdzqz/c2yFcvLpE1TZ3AJOyrmKs2jSNOJzaW8y0la2
	E+jb1ZC1ezXeDjBVjWeZgyPTC/oo=
X-Gm-Gg: ASbGncsEWXNh8dSWkdpsRj0Am2XNT4GugUTavXciYdrmL9TduHTTSunuABsDXwvKfL4
	LVMVsPIxmuTu2aOUb4whUHxaqysTxfN3+fw2ExUH1pvz97Um7gt0jTkE8/ewpNjppP69tZiI1Q0
	k=
X-Google-Smtp-Source: AGHT+IFohYzsh69AFMAPOGBjzpqdgJLhpj/draOxVD6z9yyV6DjZ9yTR3e0keblXhrmXJq/A4V6AYCzNz062upvfFIo=
X-Received: by 2002:a05:6402:2084:b0:5e0:8c55:52b with SMTP id
 4fb4d7f45d1cf-5e08c5515cemr4152501a12.15.1740014897427; Wed, 19 Feb 2025
 17:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
 <CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com> <8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
In-Reply-To: <8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 20 Feb 2025 09:27:41 +0800
X-Gm-Features: AWEUYZlzlohia0QNps6pKktO2akrT3P7RyQaOiIubTHsvWFO4MwWmKRtSuxY_2I
Message-ID: <CAK1f24m1PwK7uA+eiHmeVSAuX84VizUKg3ThmeHHgnvKa+dtVg@mail.gmail.com>
Subject: Re: [PATCH 0/2] hung_task: Dump the blocking task stacktrace
To: Waiman Long <llong@redhat.com>
Cc: mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:20=E2=80=AFAM Waiman Long <llong@redhat.com> wrot=
e:
>
>
> On 2/19/25 10:02 AM, Lance Yang wrote:
> > On Wed, Feb 19, 2025 at 9:33=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> >> CC linux-mm
> >>
> >> On Wed, Feb 19, 2025 at 9:00=E2=80=AFPM Masami Hiramatsu (Google)
> >> <mhiramat@kernel.org> wrote:
> >>> Hi,
> >>>
> >>> The hung_task detector is very useful for detecting the lockup.
> >>> However, since it only dumps the blocked (uninterruptible sleep)
> >>> processes, it is not enough to identify the root cause of that
> >>> lockup.
> >>>
> >>> For example, if a process holds a mutex and sleep an event in
> >>> interruptible state long time, the other processes will wait on
> >>> the mutex in uninterruptible state. In this case, the waiter
> >>> processes are dumped, but the blocker process is not shown
> >>> because it is sleep in interruptible state.
> > Cool! I just ran into something similar today, but with rwsem. In that
> > case, the blocked process was locked up, and we could not identify
> > the root cause either ;(
>
> Once this patch series is settled down, we can extend rwsem to provide
> similar feature.

Sounds good! Really looking forward to it ;p

Thanks,
Lance

>
> Cheers,
> Longman
>

