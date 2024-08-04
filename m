Return-Path: <linux-kernel+bounces-273958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203D947026
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD435B20EB6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F48137C35;
	Sun,  4 Aug 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a20N6OPA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB879C2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793665; cv=none; b=hF7yfBLHYYDcA7VsVdy13HLPCA82mb5msR1g6mXE4UiI+DulwPsVXQ6Razm48KVZkQ+y96NnCOc+zxKifSyFzSKA3DB24U0QTZtALPkpovbdoUbg1IpbVhTFZbJG4USbu25eRGLEpotB/6v2GJbXnhC2QnJEktHHQ2Lsmd7I0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793665; c=relaxed/simple;
	bh=bOgLAWiryn7xEv3dr/gbDtDBKa2ZiHm5hldnXh/vfMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir2DEaTgOM/OPyiv1KndDeBsjEO7Oe8IcfGhJzBdMBymdCsU/yE/LT9BEYGHzOGj9nhg/TgpetZFmFOHS3cIm4sSfXHcYs4m0Jjtl6nNoF6iNjj3eOFF2swavTeP3YuQfjhaN90yB7L2BnZe9bSbGZzDlwtNkCmn5DjL5cYEYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a20N6OPA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aada2358fso803625066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722793661; x=1723398461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFhZkSjf7SjBgrgKTzxQPt8eoEIiy87wk6mCd461L7Y=;
        b=a20N6OPACT4t7hJSur6lcM6D4ohi4Alagq07VgYjymdFB7MkWhWnww++mSPfM7UQqq
         9O3azp1TmEXLYLvsa6kXS9PZAVO0skTAoPrLcILWThoF8bo8JxVg6hZGm7vKi+ZAG/lA
         yAfDzQYzgCs4wGTPwNlToLWD8Jh4r8EbqZG0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793661; x=1723398461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFhZkSjf7SjBgrgKTzxQPt8eoEIiy87wk6mCd461L7Y=;
        b=IQX0FItG1eW1O9XMw0HlTS2ejpj/3tbOR2zmfwZC+UnuQacfbJ8kbbONVC/z1MU5kW
         xFennyQgf+i5S5pJmxXs/8ZoSnsDLspI/c3lBAmfCo7rK/frWIKl/+eW3KaApVcvWSf5
         mwN+nZNE+xoIYxpUSh82yLokAKOo6mOHiJOeNdKzCWSKXQI3hf/d+1ZFDkPCmnaBguxF
         Q2unBMD6TOUqLrBFhBT3yUxGWLl4gY6P4QAWcXu9EIOCbCG3MhAF7QA7jSk3g9UtdZQW
         uBSVe+6Qt83RUGrnVGzHpBX435KmyyM4hY3Vr9JKdb22saNMKGB6NFVn6+SMMb0rYXPe
         fIuA==
X-Forwarded-Encrypted: i=1; AJvYcCXvEOifDMo5841RQ1YqXvq3cu0uTBidohzVwSfvLLjpXfXvmoYZtrQFq4EiVb8WGcZqq/Wx6R+XIhzthWE7DhyL7f3Izb/msJtZeS8m
X-Gm-Message-State: AOJu0YyVix8aX+7bzm23zQT0UbMvkUTeCENDSQDBn236d34NQCWWxxGM
	1QmXV4lmRacuEXASRMjfnM6TuCuImInrHLSC1gY1wAEWyPqcOEm2V5O+VxukMwyOO4XR19lloG4
	GhoMehg==
X-Google-Smtp-Source: AGHT+IEJURgz+g+bBk7SGK182Y2VRRDuqNNFH0KKQbYktAT/qFU6vcxkD4gVXHhF4q4O2pwILRXF0A==
X-Received: by 2002:a17:907:6e87:b0:a7a:b26d:fb5 with SMTP id a640c23a62f3a-a7dbcc28512mr904850466b.19.1722793661631;
        Sun, 04 Aug 2024 10:47:41 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9eca4f4sm349215066b.218.2024.08.04.10.47.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 10:47:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94478a4eso828597966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 10:47:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF47rBntOjuM/hBSXGu6ybWlYKbc1A2p/jmrmqpPY2U1PGLerGxIKt59BYHE/7pGgpm+BtmYoJ9he44cZQgOdUR92p6scU6VL8hZv1
X-Received: by 2002:a17:907:804:b0:a7a:130e:fb6e with SMTP id
 a640c23a62f3a-a7dbcc21307mr914595866b.15.1722793659883; Sun, 04 Aug 2024
 10:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net> <20240804152327.GA27866@redhat.com>
In-Reply-To: <20240804152327.GA27866@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 10:47:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Message-ID: <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Brian Mak <makb@juniper.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 08:23, Oleg Nesterov <oleg@redhat.com> wrote:
>
> What do you think?

Eww. I really don't like giving the dumper ptrace rights.

I think the real limitations of the "dump to pipe" is that it's just
being very stupid. Which is fine in the sense that core dumps aren't
likely to be a huge priority. But if or when they _are_ a priority,
it's not a great model.

So I prefer the original patch because it's also small, but it's
conceptually much smaller.

That said, even that simplified v2 looks a bit excessive to me.

Does it really help so much to create a new array of core_vma_metadata
pointers - could we not just sort those things in place?

Also, honestly, if the issue is core dump truncation, at some point we
should just support truncating individual mappings rather than the
whole core file anyway. No?

Depending on what the major issue is, we might also tweak the
heuristics for which vmas get written out.

For example, I wouldn't be surprised if there's a fair number of "this
read-only private file mapping gets written out because it has been
written to" due to runtime linking. And I kind of suspect that in many
cases that's not all that interesting.

Anyway, I assume that Brian had some specific problem case that
triggered this all, and I'd like to know a bit more.

           Linus

