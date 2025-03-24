Return-Path: <linux-kernel+bounces-573104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56074A6D314
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6813AAE69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D721E480;
	Mon, 24 Mar 2025 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY0Ff7LS"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6638B667
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783477; cv=none; b=TfdFbhVcnMPSn/WnUjGs9taRFI209Wl1GGWHDFPAhQpybtpimkDD0disr53mEudXWHpiRiQD1B/CKwgYwa9fVUgC0MBF4qRfzJ36FRNKQrCwHQzMsbm/+MSKonhOKY1rklHEWE6qq9BATrLISO4pkzzTMyQpIOaPNMM0VUoH8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783477; c=relaxed/simple;
	bh=Gapv6lVXDgNSi7QhBTU2/tBoocd9tRwG0AXSlmgvm3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rzu/3o18FX29QCXOJdUuYJmqc6bz3vM5fYoG/9X7bGh4y/L9B9nTAr5IjnnxqO4zf1n0eFOJWGC4uuC0dZx3CZNeieAo/Djlu1rGroBMHuWKoUN2XSDKDO+Dohrhi8DsLHzoHKxRk8RkhMsvd5Cu9lWUBQZhkvSSHY9BQnhGnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY0Ff7LS; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso5038721a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742783474; x=1743388274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s/fPqwdxiZ9x9NodRkD/LWCwT9GrwBc/j5SnFSJa+g=;
        b=OY0Ff7LSW3qfY3VmuNqVDxfioZYoTYfuV0Nlev7iNGiMcOnte1T/qE7FKQh4mxZ8oc
         0r3JVS/q5SeaB4TIoerhx5SYelnEgaAivA1fTUBrMnr2wTIIn5pXGzZ7U4GDM3C5OuM7
         8BoY/rndmVlTKFzDMZzkyZ67SmRRmy+jV7GQpIhtDDkT8kwhukZHg5AUlH9j/ZNgpxP3
         kVag/H63Jmmk8wFh7sy0Z9xeBRvNoq2GHuUWxl9EB64/vb5l5pxJc2H08cRC3ekAMZ0L
         GvZS9KsUdtnsXdStqKNsPhpckOd9UurjeAH9UN5B6GqFL4XpPbs19xUOvpr0S+RkejVC
         A2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742783474; x=1743388274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s/fPqwdxiZ9x9NodRkD/LWCwT9GrwBc/j5SnFSJa+g=;
        b=kPr5ItALZu/dF7OQRw+sU3SocdP18/CUXWVG3t9MhF00WopS9/1i289rZubK5vf/wE
         fkEQL5E+onQCs9ZpyJ2PXE7J5lmubSj6K7FyFnH7RRyh2W+UddryGUlgD7QMDbanwNRE
         nulWkmtyX3qQL9RT+x9ydbA6oLYk6Eh9KX7CqZqGgjvIgntbcPsV9AxIi7EqwxKs9Z8Q
         mmrFkD1a9pcx+ggkpLz5NVof/CuDz8twq5heLFfPX9jrB0CdrxsIsJHCSo2jiHlpTdid
         g3ibCW+ecZIVVxdP1krhuh5Oh2rn2Tq0Bugb5kTeIFLEtCAhBM1KpBPyaYBTdFJFxV7e
         vrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgb0f9VO1skGMxFse2Cu7vpiwNF5bzSlXVhddPw8ECWE69chaT57JY6se7vn6LH9Qw4d+B8s4fJ2cVS2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYWGeFhAl6XzQ3Wdord0wwMofiPL8LJOsqRuI/eenGD2BZtqj9
	c9X9EIhIhVVsnKE0tiWKps3D09SUWx9yY3T+cqn6jXuEseMj6q1R0XTB6sZMVSFhNT2Pe8zEU4X
	AX3Mp1a9FkUQ9Ee28TdZh8CisMw4=
X-Gm-Gg: ASbGncvZP6LV7BIacnoD8/+wpEFFGWQ+8Ka93mPxjHBIjw8+3fRGeo40NLwADiyqVH3
	OsOimFesIqs6SKIrpmEATbnYhXrLkB9hVOQ/AYv1MO9BFrPOjvPfDaS33KHJ/ILqOHAJiwxe79Q
	zjcZ5OWu+m3GcLRukU6YWgCGUlIZM=
X-Google-Smtp-Source: AGHT+IG3uRNswoJk7CJzgCqY0GeGtOps6arQPTHusBTyto/w0F/THsl2nBYv08jzJSJwhoDjMQnffP6zrWpuyDtJjak=
X-Received: by 2002:a17:906:6a0d:b0:ac1:791c:1532 with SMTP id
 a640c23a62f3a-ac3f28048camr1213940366b.51.1742783473706; Sun, 23 Mar 2025
 19:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwHWFpVRL3ZTSmKn2CGtixDBdszxofE4DSUx0rAOeK41g@mail.gmail.com>
 <CAN2Y7hyM6pAupptUZx-cQsbTimxYSYKinyrSGBLYq5i3Dbxmgw@mail.gmail.com> <20250323140358.61c1ad10@batman.local.home>
In-Reply-To: <20250323140358.61c1ad10@batman.local.home>
From: ying chen <yc1082463@gmail.com>
Date: Mon, 24 Mar 2025 10:31:02 +0800
X-Gm-Features: AQ5f1JotBi6na_WwfjZgPmcsSfI4HBmi5x_q1F7OvQreB6vwRPDlTXm9nFGZzuA
Message-ID: <CAN2Y7hzCk4FoV_aZzDEXbn0nfqLTeYKbWxfKo7WS6225y1gbcQ@mail.gmail.com>
Subject: Re: [bug report, 6.1.52] /proc/loadavg shows incorrect values
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 2:04=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 23 Mar 2025 20:45:51 +0800
> ying chen <yc1082463@gmail.com> wrote:
>
> > Hello everyone. Have you ever encountered a similar situation?
> >
> > On Tue, Mar 18, 2025 at 9:54=E2=80=AFPM ying chen <yc1082463@gmail.com>=
 wrote:
> > >
> > > Hello all,
> > >
> > > In our production environment, "cat /proc/loadavg" shows incorrect
> > > huge values. The kernel version is 6.1.52. So far, at least four such
> > > cases have been found. It seems to be a kernel bug.
> > >
> > > ~$ cat /proc/loadavg
> > > 4294967392.49 4294967395.80 4294967395.83 87/16100 2341720
> > >
> > > top output is below:
> > >
> > > top - 21:12:13 up 191 days, 20:50,  1 user,  load average:
> > > 4294967397.45, 4294967396.82, 4294967396.15
>
>   4294967397 =3D 0x100000065
>
> Which looks like some calculation overflowed.
>
> 191 day uptime is quite long (I reboot to update my kernel every
> month). Perhaps there's something there that caused an overflow.
>
> Interestingly in 5.14, some values were converted from long to int. Not
> sure if there was anything there that could have caused this.
>
> Just something to look at.
>
> -- Steve
Do you mean the patch "sched: Make multiple runqueue task counters 32-bit"?
I've also noticed this patch, but I'm not sure if this problem was
introduced by this patch.
>
> > > Tasks: 2388 total,   3 running, 1208 sleeping,   0 stopped,   0 zombi=
e
> > > %Cpu(s): 27.9 us,  6.7 sy,  0.0 ni, 57.3 id,  0.5 wa,  1.7 hi,  5.8 s=
i,  0.0 st
> > > KiB Mem : 99966995+total, 56704217+free, 22655678+used, 20607096+buff=
/cache
> > > KiB Swap:        0 total,        0 free,        0 used. 68817177+avai=
l Mem
>

