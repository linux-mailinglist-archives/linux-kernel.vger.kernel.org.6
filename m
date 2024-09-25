Return-Path: <linux-kernel+bounces-339539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2643E98668A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF02F1F2447B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB41130E58;
	Wed, 25 Sep 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KzLeT5bN"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05549624
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290234; cv=none; b=GduwrAj57OOclkw8cwQd+J4k6u3K0xg9MBXXMQsRg3D6q8uR2Tc4yW7qUmH0YJaaQ9MUrQb1LhLFVvGSXQ0x0tOm/cn0MNwSo+5GpZWekfVFaVcVmz8R3y3371Tlj5+du39DBuHjfb5iWYNp+Aw1CpYiGqmNqSCoH7wPHh1dpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290234; c=relaxed/simple;
	bh=Z7kWssl4XZPaLL+5nUhmnGIgZllP/Q/flkFj3v+9mLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT5naJTtU5npItMeXRBJ7VWI4IrIuB6NrIyFX63CX6UZLN+8pLDC/866mtJy7jAKmZHVsRr53c6+nLVgMKyfM9GdTt0kDNvvn9Lmpealh7kKvxlKgdxwbEGalXY/1OmddcDWV8zlEgXtj7Nq6unKIIzA4jC/pmxuFqC3KO9pfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KzLeT5bN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7528f4658so1380931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727290230; x=1727895030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh0JQMZG3vWViuegY3eLz6gtbb6ALA7V+/Vd0bHsYGk=;
        b=KzLeT5bN7fdC2YOzSjo4BFsQjdYHzeU4wVQGdpcOOxWVG2D9YKnHZ6bjGgASZNJBqz
         4iHyi9u1vlTxbJQJC4vNxsncCP95CRFsTuO9HOyo8vHlCwfugRZvayhv3VPVa9YsPWyO
         mLgg2l1misxfwY20JLAtv7cS7pvWqLngBDavw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290230; x=1727895030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uh0JQMZG3vWViuegY3eLz6gtbb6ALA7V+/Vd0bHsYGk=;
        b=s8XWVX+QoihZArRW0ljJUePYpixnNqtgS/PKbbjp+501PAz2RJhgcBwGwKmOZfUM/e
         7Q3EVPgEN5t/mioouKfLGN6T5Oa4XrcIb+vHUCf7GyHKkazcc7k33tRe+e8cc7cGWqAF
         EG5ZxeLo96x+rYTYHM/pQpWm906yB7rDfJ6fTnTPT0qH2r/IsUpiAkLQ+pk6AUaPnhZE
         JSg+Vr+GO7EVZRkghBGmZIMoAd6ADBsG+qKZsfoI1SiRQoOqTX6K17b8Kuv9MyEsbqpf
         7jViVSS/dlYFwTV/KtB1wEadFiGyS6CZEX6leu8Iy+XZdpiI/KmqNMc5OIjhiq6YxU/w
         FjVg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ySuGRSW+mY6gL0AzGCoFshaKztOGngBI5p3x/gft5zCyXJHMfFoiYXXM0kTMXvycU1p93BARrKnN/fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+a1dcImjmwEFSiq0cNeDFspDkXx81mWzegGP244tpYY/gVnYr
	XyQ7z33kBs/JZGwm/zaf+VeAuBvl+DUuriO6KavclJDo9hzIGIZqL99/io+y1/LlSvLBvG9N7Q6
	0SYd71w==
X-Google-Smtp-Source: AGHT+IH0YPZCXCPSP50VLRVHlEvYvZ/vTn190fAdfzDFI/v5ZQcYVDp47VUjTovmJrZHopKQuHCkJA==
X-Received: by 2002:a2e:b8d4:0:b0:2ef:2b05:2ab3 with SMTP id 38308e7fff4ca-2f915fe4333mr27904811fa.10.1727290230379;
        Wed, 25 Sep 2024 11:50:30 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283c655sm5675301fa.55.2024.09.25.11.50.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 11:50:29 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5367ae52a01so200916e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:50:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv3/4Ne3wmDynWMj9S+aNnIgf7hz5aK8gh3cpRky8RKOWZiNMIE7YN3oSg6Nm2Jwa2sodlwPUfCqNueTU=@vger.kernel.org
X-Received: by 2002:a05:6512:e89:b0:535:665f:cfc0 with SMTP id
 2adb3069b0e04-53877533876mr2498473e87.32.1727290227263; Wed, 25 Sep 2024
 11:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923063707.40017-1-rppt@kernel.org>
In-Reply-To: <20240923063707.40017-1-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 11:50:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=8JhAWjaxZPEOQgarTTsqPV0AQO=Q0USYtG009EYhUA@mail.gmail.com>
Message-ID: <CAHk-=wh=8JhAWjaxZPEOQgarTTsqPV0AQO=Q0USYtG009EYhUA@mail.gmail.com>
Subject: Re: memblock: updates for 6.12-rc1
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Sept 2024 at 23:37, Mike Rapoport <rppt@kernel.org> wrote:
>
> memblock: updates for 6.12-rc1

Please make sure that there is a "git pull" somewhere in your pull request.

Now, the "git" part will always be there from a git request-pull (as
part of the "are available in the Git repository at" string), but I do
want to see a "pull" somewhere too. Otherwise my search functions
don't light up the email, and then it takes me longer to notice.

Most people put "[GIT PULL]" in the subject line, since that's also
how you get the attention of the pr-tracker-bot. So that's the
suggested way to do it, even if my search functionality is a lot more
permissive and just wants to see "git" and "pull" _somewhere_ in the
email.

You have done that in the past, I'm not sure why it didn't happen this time.

               Linus

