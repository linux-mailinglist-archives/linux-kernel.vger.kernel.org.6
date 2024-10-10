Return-Path: <linux-kernel+bounces-359409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C2998B10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D26293372
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555023D3B8;
	Thu, 10 Oct 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5C6+l6X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7031C3F34
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573060; cv=none; b=mRlNxS7Kjw5aIib0ejd8FqWycLQ3h4GnPtEp45CMXD+IjGDBMTHsI4E223xFHaj10TRGfXVDzvVWXnWOVcNXl/IdI4y8R9E2okv+Yx2yftIy+HyT+q7Xaza88lByScBitjhbF3DjMbNe7ymCts4SaiT4fSISR6ZBHtZJcavBVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573060; c=relaxed/simple;
	bh=vv7FoLT/BiNcE50eI8e+RHka34AVKuvU0855Sv669wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAbcMHhhBv+/w6hzE346kyuR9I59wF5/Bxah+cJnoLxyod49w4iPxtzieAZiPAtGaOrUjoDl2sOLemrNenPGZDfi18NUmyRs8Nhw1H2eDp46rCbeUJSVdZedn+q4b/LlYPcI7eQ1kQnuRS+tdNxnXxJj/5VbKbcBr0jlJmxa9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5C6+l6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728573058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjA55q+krBtyKpu1UrvE4kCe5ypwnXLDju+HFDL51q8=;
	b=E5C6+l6X3TjHspEtAv1kzQWHB9AxEj6oPwSqhATqB5XvmfHcbqsxumws+i6HUb5mZ8p3Tl
	528AXmMX4lwYRmh0SB4luuXOudv1ZCaVfarlociawEddGfl57RuAzlrbqXABXewkfbElM8
	RtWGLNcnnLIiHcbOBMkrVqNe/BtEeJw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-wmRMw40eOkyKLCu5tk3nBw-1; Thu, 10 Oct 2024 11:10:56 -0400
X-MC-Unique: wmRMw40eOkyKLCu5tk3nBw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e4d7850aa9so823845b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573056; x=1729177856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjA55q+krBtyKpu1UrvE4kCe5ypwnXLDju+HFDL51q8=;
        b=YRqN02phcVf4NhIkIcXT4E8aGA++hPxzCJNJ+h1lI8J4na3e8B2W/3cBO86ZvcySI8
         NLDOqBe1RBa+60nVSTE9X1AKnodRsyfBF6dEvEG3WKfV58djsnkpCLQdyofyWx+p0+RN
         N1aH+binubmp1jDcu7tvyqBGgmHufWXqQQodt3+i/1nIpZIPqC1GWhxWNG4Zqz+m0pNx
         YgJeCHJl5SQa66G8Qih9AtyKkKLFG0sU33H+JByawCwfy02UwWWcec3NjmuP0ZV+AXW/
         TzPdHTXAEoIXVbhnI1FZslAPE+qtlP2GxfjosR3ldGiA64CcrIRULeiQoEdXmLJ2nMXg
         A2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWPNKTYrFjr7w5FJSHDSaxu4YopgC1FgkPGStrey73aFFcHpUujVkMUqWN3Y8cOThs6adA4KHYO7jW+6jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/E3UJrFWvxPA7ALSDImHCmjJYnOZ1Kr+g4KZ/npGZ93MCAwFa
	8Zc0pgRRfKDGQy0uCqCj7erG60iyqLiGy8v8g8abb6WQcRxhRWe75Ms71U81vX6HoOxGtIUKp8Q
	/yShsq4L2LTPUyLYNRmthw+lEo0pSisthYw60oZ9toefBkBwvvW0pc0euQs4U9SFmIUTYmfMQKL
	GHZamOZhAKZ0NtZewrVGwYMKBQZnbti2mzpQrH
X-Received: by 2002:a05:6870:3327:b0:27c:52a1:f311 with SMTP id 586e51a60fabf-28834526ad2mr5129381fac.42.1728573056180;
        Thu, 10 Oct 2024 08:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIB7HsgwV6fuJpvkUQunBq6VUSoqHhvwFCo7dOAfNi+vwTrro16B+0BF1xEsApsHvhZ3NuLGuCIrJFJ3LYhAo=
X-Received: by 2002:a05:6870:3327:b0:27c:52a1:f311 with SMTP id
 586e51a60fabf-28834526ad2mr5129356fac.42.1728573055919; Thu, 10 Oct 2024
 08:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
 <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
 <CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com> <20241010105539.5b5aa41f@gandalf.local.home>
In-Reply-To: <20241010105539.5b5aa41f@gandalf.local.home>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 10 Oct 2024 17:10:37 +0200
Message-ID: <CAASaF6x2gddQ3UTQD+aXBfV3vXsX24kMMVNDigwC5wk_q4VABg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 5:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 10 Oct 2024 14:25:11 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > > --- a/tools/tracing/rtla/src/utils.c
> > > +++ b/tools/tracing/rtla/src/utils.c
> > > @@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
> > >
> > >  #define SCHED_DEADLINE         6
> > >
> > > -static inline int sched_setattr(pid_t pid, const struct sched_attr *=
attr,
> > > +static inline int rtla_sched_setattr(pid_t pid, const struct sched_a=
ttr *attr,
> >
> > Hmm, rtla_sched_attr sounds to me like the function does something
> > specific to rtla. Maybe syscall_sched_attr would be a better name?
>
> Should I be waiting for a v2 with this addressed?

I don't have strong opinion here, I sent v2 with name Tomas suggested.

Regards,
Jan

>
> -- Steve
>


