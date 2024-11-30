Return-Path: <linux-kernel+bounces-426484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4119DF3C7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2D0B21ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221A1ABEA6;
	Sat, 30 Nov 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ApAgDkAH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525E15956C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008298; cv=none; b=tcNtg9tvv2KVbt+Si0gHVQc8YdO7MatZ0EEoMxp97oFtGO5s1SYqdIpwVjsQe8S6wQ2/9i873+vhRrJIDTFrKFOn/FerLsq8tJ/0BXFOihahqqr3MYC7BZ/YPr1ZsVXRkjyF+Bg3Qwd/ysPfq92wN2QnZ+hqmzO0Zkw4d+GHsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008298; c=relaxed/simple;
	bh=igWI8mrhgsOvImsfULhcXfwMtkGJFUnIjBAYjDygDVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ+kLqTXpdp4jpjMeC3YgWo4JZ0VaZvYwJnZoMOr9w1fZUWNOpbYFFnw0Uz9UirdcRt6F/o78o5lTEOR26QzUMy1SyCKvwwpOilfx+7snbZ08arTzjXNrCI3gWYVmKcYkmAUpzGZGGoHy3TzGeSTPTqg2Lzl4T4hycnbriVhia8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ApAgDkAH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so3699127a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733008295; x=1733613095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GSLp2FeQX6v0+DpLPCnxxi3sSbb+vr+koAirOocK+fM=;
        b=ApAgDkAHmF0l90AW21clbWq1Hora23ZCfcd0uA7h2je6FkdpipubI0sqz0JrQhx1+N
         wNqp/Jg2JrmVr8zSDSQqwayRcwPIHLqVIbVF59TVzzn3IanguYNiWnFYDqO5E4XgYx7d
         XcRKLhDaGoQnA23dnpoIwFrv8R57JArwEuGYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733008295; x=1733613095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSLp2FeQX6v0+DpLPCnxxi3sSbb+vr+koAirOocK+fM=;
        b=o0x82EmOX++ztB0jiOqNHQrMiSw0nnlrH/gRWmnKiBJ9+fjrOgsRjEs6NjSBNJsMUf
         wu2k8+CEyhufBI7h8fQfXtExIHSK+9QGRYOzyWwmv7/gIRVqqM5lvrD05S71DZYxhFp7
         MZQAYpC9QOEumUuDa9to5PqS1Pf8XXuiYCTGE3kS0uQyyXHC/RpHzyC0c5eNRDOEYyv+
         MxuodL5L1ud1xEklKzgvq8PNn46sJiLCE5douL3urArucegl3c+6QCknSx/+gndH+GOi
         E53w9ciFJ78H1WzckAaR3Qv10mXV+ht031pKS71jSlQywDoVF75vEeNKrIE9TVe1TaZa
         Bp0w==
X-Gm-Message-State: AOJu0Yx4s1gIrEGXzJTVojxLjpxjb+uF2W+O+MaS5XF7tXnSbToOCP6q
	1TY4RUwjgRACondMh1FGCulc76cn0IlC2CkyqL/esXEtlgA5Ni9RJciRv91jMOCiexPmLrLpkRC
	PeJfEjA==
X-Gm-Gg: ASbGncsG/ShGpBnB7H+fBUZS5mGyRZM1vFSNNz2zCaks7W2vsvcFaLgrSyOlW9x1EGE
	pd9u51BX5UGnpEI6R/n7kc8IhTms/AhnRrzz4F2Jnv25JEHmvRFvw/ZFi30GwkCckczy9IiQG2F
	WlUQLhfBrRpBFBNIPssVa/1i3/EPLjmc5S8fI8GH42r150Gyk4NvXN0pPU7tX24JbrmlLS/JZ5X
	Otji8cAs3SWc7/WMR3RaRsfL7p1prqKrGwXTbtmmi0bXT0qAELfRVkpT5Nv+3Pmy0S836G9fBLl
	38OVqlT/vm9XHC+i0oqMQas1
X-Google-Smtp-Source: AGHT+IFZqpcVmYBKsF96QGwTpuuTo8Z+rKApeMBjkP0OXTAZfqnzkGU3zXTtFMoZB6p3cdbWwJvrlA==
X-Received: by 2002:a17:906:cc12:b0:a9e:c881:80bd with SMTP id a640c23a62f3a-aa581057f88mr1208104866b.37.1733008295277;
        Sat, 30 Nov 2024 15:11:35 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599943614sm325840166b.175.2024.11.30.15.11.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 15:11:34 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e8522445dso406865766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:11:34 -0800 (PST)
X-Received: by 2002:a17:906:3195:b0:aa5:9303:1b96 with SMTP id
 a640c23a62f3a-aa593031ccemr1127506566b.50.1733008293952; Sat, 30 Nov 2024
 15:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129231841.139239-1-pbonzini@redhat.com>
In-Reply-To: <20241129231841.139239-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 15:11:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjP5pBmMLpGtb=G7wUed5+CXSSAa0vfc-ZKgLHPvDpUqg@mail.gmail.com>
Message-ID: <CAHk-=wjP5pBmMLpGtb=G7wUed5+CXSSAa0vfc-ZKgLHPvDpUqg@mail.gmail.com>
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 6.13
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 15:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This was acked on the mailing list by the RISC-V maintainer, see
>   https://patchew.org/linux/20240726084931.28924-1-yongxuan.wang@sifive.com/

Please don't use random links.

Maybe patchew will stay around. Maybe it won't. This is the first I
ever see of it.

It seems to be maintained by Red Hat, and yes, at least it contains
the email message ID as part of the URL.

But when I tried to go to patchew.org and then click on lkml.org, I
get " https://patchew.org/lkml.org/" and a big "Not found" page.

And when I clicked on "Linux", I get a working page, I can't even see
the raw messages without downloading some "patch mbox".

So "maintained" is perhaps too strong a word.

Please use lore.kernel.org links instead. Maybe that won't stay around
forever either, but at least it works.

Lore also deals with a *lot* more lists, and has a lot more history. I
tried to look up old stuff on patchew.org, and it just doesn't exist.

Put another way: patchew is objectively *much* worse than lore. So
don't try to make it a thing.

            Linus

