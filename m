Return-Path: <linux-kernel+bounces-357819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9699767D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33541F23C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B71E1C16;
	Wed,  9 Oct 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bc2YwtV/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C813E3EF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506123; cv=none; b=duo6j0MJ3egS5vq9PCdfky/BbnvXTg8ERBGbpi/xNY0QXUFxXKtcZ99wPrT5sTMWH+8PP11FsVoO+jbEDR8WLY7q2WMDUDiwE9Aun2MXP8xSlmR3LMzaPXNtR5y7T/Uy5hN+WBOuy5ecDfEa94vrMBOk/7WH3Iv/n8ULxC9kaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506123; c=relaxed/simple;
	bh=GXLCkw65d2S++VNyv8Zo9MSqFS1XqxeG9ZueQafHMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyQd/DNrSHlI4PELwEWgQ5jDh9PUnN+MOyRpje+v45GI30Or7gZc3nvs7BS4REXu+XBopii2BK6iBwP5+vC3J8JwGw1++xtZPC/HNnwfzWMcxtc97Ko05uuBTE2HIg1gD/xjDM4krWRRlr25uM4D4pJ+6ABqjWeIvLImVJDWsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bc2YwtV/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c593d6b1cso1784745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728506122; x=1729110922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GXLCkw65d2S++VNyv8Zo9MSqFS1XqxeG9ZueQafHMXY=;
        b=Bc2YwtV/ZFM6/uBG6FHyF5qlNRXfpnulWIHIO2FEZVrrrRrvtmeMCqoCAFAQAGX6ee
         vooCyJdHLRCMCPP8febR3bFOa7FnJzIxherjM8rNd2IoHO8Sd/Gzf6NlSkJTKN9C/JDJ
         y480Rf7YW3wO6YhDj9jESPYcRBPvlvN6w8Gl5v0AfNQT9jmhj988nDxs6DKK7Sb//cuj
         TSlaVT7CYU8ssmGMAcQY0/4ycylJo27ENI7c0LP9ytyQvg2n7/Z0QBt3alQXI3kj2hiZ
         qfUekZK0Ah6NZwpUXl4nWdliHWiL8YB7lPh6MZde34DnLw0Iy4HiKpMJOaXVNS2mVVaZ
         zsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506122; x=1729110922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXLCkw65d2S++VNyv8Zo9MSqFS1XqxeG9ZueQafHMXY=;
        b=aJ4myL9r1jKqTkkyHlyLY/ad7euuoGQOSsNHgnzEZtF8RE2hryjAjnkiOtmbpkasiL
         1CaAz/Qe4luzu8/vQMFN4Eyf0IPxKJ5XVsIaK4/Cg2imUhg6rGegX+cRFbc8OdZTTIjy
         4Dudq4mU0X5dtQQR/uaXQXRr6aHSSedh/kZP+k8IupElimKncuH5PsHqgRFA99G8+FnP
         m3YexmzO5eWCsjBPwisdQIJ9E0ZE5iO193BQpDKzJ0OIc5DbsQD6DDmGzi7c5VyNf6gv
         YJnoRxlT5EhqVhriSw2t+wNUFWCfEHsBayvdTQFjbeXY4YVq2oytWA0ikND0rDKo5x3w
         7oXg==
X-Forwarded-Encrypted: i=1; AJvYcCXLJAvP9e89Oq+RookX3lxChDoJ6d3GgJOXYTX2jMHlhhciBclSpbWJPT31WJn2/Rohx98rDQwQXSDv+B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzbjJgBzG67KIjRV/kVD1VHYxkOLvKp4g3okhHeEmkruBjnuu
	oGjEkJOWoR75Ni6d+oy9KDRnGErlgnYOtW410FOWuqnhkpF5bAoE/E2fNONMvBha+WcpYVFJqyG
	yqu4rMCz2HOJe3NHZEV810acW/a7csb4+8U1h
X-Google-Smtp-Source: AGHT+IH6w0gjsL4Vx8BKOWRoSzBUrC6zu/uKFze01J9tNx7obSdLJkDVbD4YEXLF85AjPB+FzOvy9/ia+//jA3hLRrQ=
X-Received: by 2002:a17:902:d490:b0:20b:b48d:698 with SMTP id
 d9443c01a7336-20c6370bcf0mr51380195ad.17.1728506121152; Wed, 09 Oct 2024
 13:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNN3OYXXamVb3FcSLxfnN5og-cS31-4jJiB3jrbN_Rsuag@mail.gmail.com>
 <20241008192910.2823726-1-snovitoll@gmail.com> <CA+fCnZeMRZZe4A0QW4SSnEgXFEnb287PgHd5hVq8AA4itBFxEQ@mail.gmail.com>
In-Reply-To: <CA+fCnZeMRZZe4A0QW4SSnEgXFEnb287PgHd5hVq8AA4itBFxEQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 9 Oct 2024 22:34:43 +0200
Message-ID: <CANpmjNNPnEMBxF1-Lr_BACmPYxOTRa=k6Vwi=EFR=BED=G8akg@mail.gmail.com>
Subject: Re: [PATCH v4] mm, kasan, kmsan: copy_from/to_kernel_nofault
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, akpm@linux-foundation.org, bpf@vger.kernel.org, 
	dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com, 
	vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 22:19, Andrey Konovalov <andreyknvl@gmail.com> wrote:
[...]
> Please add a comment here explaining why we only check
> copy_to_kernel_nofault and not copy_from_kernel_nofault (is this
> because we cannot add KASAN instrumentation to
> copy_from_kernel_nofault?).

Just to clarify: Unless we can prove that there won't be any false
positives, I proposed to err on the side of being conservative here.
The new way of doing it after we already checked that the accessed
location is on a faulted-in page may be amenable to also KASAN
instrumentation, but you can also come up with cases that would be a
false positive: e.g. some copy_from_kernel_nofault() for a large
range, knowing that if it accesses bad memory at least one page is not
faulted in, but some initial pages may be faulted in; in that case
there'd be some error handling that then deals with the failure.
Again, this might be something that an eBPF program could legally do.
On the other hand, we may want to know if we are leaking random
uninitialized kernel memory with KMSAN to avoid infoleaks.

Only copy_to_kernel_nofault should really have valid memory, otherwise
we risk corrupting the kernel. But these checks should only happen
after we know we're accessing faulted-in memory, again to avoid false
positives.

