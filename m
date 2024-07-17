Return-Path: <linux-kernel+bounces-255057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B181D933B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46481C215AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3B14B07E;
	Wed, 17 Jul 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIhI3pjI"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D76AD59
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211909; cv=none; b=f3hPF+3492BxjSu3SKPGs5FjYEVPiFF2P+WQiLwW7TQ5N7XzQGAbf1geW6IjkuP9ynMFf5ANKucwq9066mI+2geUZqO/wzJmh3pCu+2EBV/98KS4EabJyqvfW7EC7sLYFGKBXMYMkV2XM1hjIRAVcM62gNx72Mh8naWZzTdkWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211909; c=relaxed/simple;
	bh=E/R792D+9Tj4/7Zsl65hzBJhLjFcQCS36vSAk56QCbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0iNUgGRtdCO4USjh+JdR1/2LWn0ydrO4kxIIvBevOyKPF/gT9lUVcFlUOiB3wNo5T4Q3tChZALfXc3u8KdpQPOvQJEukdk0tyLANpYKsuknR6mUL9Zq+G6t9MWUcunEMNMZExkFjvhTXgliNhg98ElJK6ko+YYtTANUmL/F9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIhI3pjI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so9568a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721211907; x=1721816707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0X58dCKUFcabEcp3dJIxILloIfV8wE3Sv4bZ3Bk9Cck=;
        b=RIhI3pjI2wy4gYtWm/Nnps5DEgB187sqVdUqo17xa1+ITVaaeEt6ShZhlsJTlCwSn/
         IBR17S2cYA2tbYthfD+fk6DPHzLdYhtTvAv5WgWYk3jndyOsWu3NIYZ2l04+bCaO/W7L
         DmxnDdEUas8oTORqDX3qH6MFNvrGjhgu2/Fw43IoekBeFlGUrAZ3dLAqe6VqCJHgyku5
         KZKMHl00P+VS8oVMFIXXqQcGD9cvsT3XHtujYNj0FeGQrBIlP6WGF8fDOmPAOiALTJfm
         Du4H063BpG8paJ4wxCRrVy8T+/hvLQELiwt94KxCCQTnBrGzw308ES/Dh3Y2h27CFAIm
         rn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211907; x=1721816707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0X58dCKUFcabEcp3dJIxILloIfV8wE3Sv4bZ3Bk9Cck=;
        b=QIfh8uPywD6R6cwOfjAnjhWHgqDoyeFyFU2FmW85xEKo5Lff99macG/LL7el2d/qSR
         s0rmtCXhQqsk7ZQs6ST4is0OG5Cs0CL1gOWBxZDdznaHgC17vJzMc3AJ0+mwteNRaE64
         zUUVZxzO2M6NsdFu2gljCfpIakvgo0JbdsJEieD7k6LyZWQvi7zNEAi/2SuowoWBlEj4
         JQxDYSxPB7EkXhrFxx947K8pr+XROPb7Ks8Hwt6XeRY5/DusG4VDgd6AyzAAu+PqdU9E
         IvzC3V7qcAWLtP7utE5slvc0/ZigTFZbsb3tU9DoZZZr6ZEACr7zAndMFD7CoyK4Vtwd
         sugA==
X-Forwarded-Encrypted: i=1; AJvYcCWpr7ez8oEs12oghvK/wD5cFMnJ0W/5fvHR9LDOTZNA7KO5riEvNMEwe3vpHXfsuXcOyQPwfXlqZGE7B/FrosMyyzOUYW4EF08sYJbY
X-Gm-Message-State: AOJu0YwT17DVTnucBsXtBAGwIlI3C7MuNXY6zQp8RKzU5ZCQ1Dohen47
	2QnGHyXo3R1MR9qYpzRdm1uxQ3vRaT24NBrHfxIHfLjOaI9RjhsqCWH4USbHZ+YxiO+zsMWUgfh
	YcGV3LQCeAL84+6gWINieubhc3WfI2F8vTdKdKerNQgcGT3sZ2Cz1
X-Google-Smtp-Source: AGHT+IEvysYjCXmrhqGlHDCPmAtAa6Rum1Rpr2/QR4r8ca8vhA6oUTEHS/r/18Z2ytlgDiTjyMASAAzag1PbHOTrDYg=
X-Received: by 2002:a05:6402:348d:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5a03ebfd41amr177573a12.7.1721211906128; Wed, 17 Jul 2024
 03:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419222818.50719-1-namcao@linutronix.de> <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>
 <ZpYD9dDKYYK0BIA7@google.com> <CACT4Y+b0D-RmYznZ_+M98hDWiAZ-FG=eusagoeLGGQN4ZOB22w@mail.gmail.com>
 <Zpb30HMt6jXtonhr@google.com>
In-Reply-To: <Zpb30HMt6jXtonhr@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 17 Jul 2024 12:24:54 +0200
Message-ID: <CACT4Y+a4_QGvhHB+fDvJM8ZFhvUEJagx1Oa5-A0QHCEd7v_zGw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
To: Carlos Llamas <cmllamas@google.com>
Cc: Joe Perches <joe@perches.com>, Nam Cao <namcao@linutronix.de>, apw@canonical.com, 
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 00:44, Carlos Llamas <cmllamas@google.com> wrote:
>
> On Tue, Jul 16, 2024 at 09:11:08AM +0200, Dmitry Vyukov wrote:
> > On Tue, 16 Jul 2024 at 07:24, Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > If combined tags are discouraged then syzbot should perhaps stop
> > > suggesting the `Reported-and-tested-by:` tag? I would imagine this not
> > > only applies to the tip tree and that other maintainers agree with not
> > > using combined tags.
> > >
> > > FWIW, this tag in particular though is quite popular:
> > > $ git log --grep '^Reported-and-tested-by: ' origin/master |wc -l
> > > 82056
>
> The number of patches with this tag is actually 2689. Sorry, I forgot to
> add the --oneline option to my initial query.
>
> >
> > +syzkaller mailing list
> >
> > We can add whatever text you will say. What is the official position?
>
> I don't know if there is an official position but IMO individual tags
> are the safest option. This would even allow tools such as b4 to collect
> the tags automatically. So splitting out 'Reported-and-tested-by:' seems
> trivial enough?
>
>   Reported-by: syzbot+<context>
>   Tested-by: syzbot+<context>

I've sent https://github.com/google/syzkaller/pull/5060/files
to split the tag into 2 in syzbot emails.

