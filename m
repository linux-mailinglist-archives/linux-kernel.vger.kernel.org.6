Return-Path: <linux-kernel+bounces-420744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F39D82D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53CA4B24FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C21917EB;
	Mon, 25 Nov 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mC//i2jw"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7A19068E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528007; cv=none; b=Z7U0kfZ1dPrfp31MDzSjSzlyDLGkTG8Bn8yKtxIxe7zTVfgR/67ctcx8lwM7gd8YQxGr1xsmQHCLcQywBTEx1z4DkrFfQ3cy0U80bOEObcT1RlfSbVM/Y47ypAT5TS/0kcLKmvh508ujK4Ezic3Na7P4Mw5IubzwcwBAON4Y3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528007; c=relaxed/simple;
	bh=M5fUJVhpmzqSd50ma6zAFTUbqMPF5mxAvt0Q9YqBptc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P37xXWZcaCSSU1QEhZf0eVhX5Q3S8Q9jEqZo7+dVwA112URZ2wYD5HbAtt9rj2SJwfysS8zTBsBBY1PGJHXHr40IhxTTz6LsOl4FkmL3S9JVOxufYYvpuWlsBFtJe8vqpE0MAomSzZno9CAvjBzVNhEZbLwrNoNpn+n42RTH1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mC//i2jw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so29106091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732528004; x=1733132804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+L7QFyWrjCm9IBUnXhJN6fa/EwHyTizrnVzuOJIqiw=;
        b=mC//i2jww2dxyWrWuN3UE624tVEMWxdG2RruyyKZd8n3oyKUl17N4EeFSz/AwbqGKD
         oMn07upVr94xFo40pEwRZ7sPMkp/pLOUqri0/jdxL6WkyJG8zBLoZUz/vAP1HKV/fEzd
         czaoaDMxxgsGzdhMPWbTbnVPREBDbN5InzB5xkllULNk2oKMd28pmfGa6q9p3Mfj/Nxf
         ROIN3Now78tR3PJ8lJYFCuJKnzoBQFgKDCy7dI/JGKZRcT685DuWB49QJs9P84huYCIN
         u+Yheyo2jZolJtBHZiqjePmShsZzriPMXFUvyaywvBIGufhxMp1KqWe2KqCscHFr3S99
         +SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732528004; x=1733132804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+L7QFyWrjCm9IBUnXhJN6fa/EwHyTizrnVzuOJIqiw=;
        b=MtUXKdQECX/oWoshV+BowuR/3wapNMKc+MaotAdhqErxmw+NxT2vabLmL3WSBOpgBq
         e+fLJe9bsSop8L/zCzu/wjrUQ+5w7c5a8SqL+43lD0HXMzOVTJOoZHQUvppaJHictV+J
         Ghn9Xalcnf+PUgll3qKqRQpa5/r0iHcqj74yknWF5bJD+VSHwEYCF8EUSvJqNo3Yimf1
         jjpEOKLtMlpO/2/NPo5ykzQs8IjCcTUgGPtbz7KtzorUVJVSHTO7Ob4G7OVNZOyyYTjm
         OPxA0I/i4nTvf2/c4y5XHFgfrfQqFTZ8LcnLGDzVrklK2akoc4AbLgAc3CrnTef40YAx
         bWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv9uw6ocl+8/mxJ9+n9oBuWRPdbD91vsraz2YJxNdTOShytUwOADWlkcyntV9quzYUrGWk130Uob8ENbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1suh1+6L9r7gVhcTZwmtBsHxXLNdCd502sqlmMxNKjS5prvYH
	e/FQlKfHEmr+opCncgnM4FalyaGD5Z/zjpuAToVQn332KTKhyaAkw3q3zaxn45QYCDdMSb8/z+r
	rt2Oz9FeRlNnWYl/lDk7Spbp9HVbDg3qGEmW80WZG4YRfl4iTwy7T
X-Gm-Gg: ASbGncs0eKXBhLbPmkhoTZJmouFH1jcAUNwVwqWiVHKRJNGKTbpi1gz/GCcfCQbEs+N
	3KwfKXoUVKR+I1UCXa0cv/x3hoSvRPLQq3s1Vk7iYrhs1Ofez3UVnEHTRYr2atNSl
X-Google-Smtp-Source: AGHT+IFEiw0FAkvTY5b45dc/P2X6EwmscxlptPPfYHdIaMxgqcVKwWHAkRLE4+43jGojeSU+6rPCXK1jrVABCdd/Dkk=
X-Received: by 2002:a2e:b88c:0:b0:2fb:3881:35d8 with SMTP id
 38308e7fff4ca-2ffa711e7a3mr56244311fa.14.1732528003975; Mon, 25 Nov 2024
 01:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122234811.60455-1-frederic@kernel.org> <20241123101312.GA12843@redhat.com>
In-Reply-To: <20241123101312.GA12843@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 25 Nov 2024 10:46:32 +0100
Message-ID: <CACT4Y+YQGLtD0673Oxm2=0mHy9cSx1wTPtVCyxjORSv47M+vUw@mail.gmail.com>
Subject: Re: [PATCH] posix-timers: Target group sigqueue to current task only
 if not exiting
To: Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Anthony Mallet <anthony.mallet@laas.fr>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 11:13, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/23, Frederic Weisbecker wrote:
> >
> > - * the same thread group as the target process, which avoids
> > - * unnecessarily waking up a potentially idle task.
> > + * the same thread group as the target process and its sighand is
> > + * stable, which avoids unnecessarily waking up a potentially idle task.
> >   */
> >  static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
> >  {
> >       struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
> >
> > -     if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
> > +     if (t && tmr->it_pid_type != PIDTYPE_PID &&
> > +         same_thread_group(t, current) && !current->exit_state)
> >               t = current;
>
> Thanks!
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Can't the group leader be exiting as well? Though, that's still an
improvements. People usually don't do that (exiting from main w/o
killing the process). So thanks for the fix.

