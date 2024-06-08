Return-Path: <linux-kernel+bounces-207211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA79013CF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 00:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A5B1C20D76
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB4928DC3;
	Sat,  8 Jun 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QlWAX7OD"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B837ED9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717884067; cv=none; b=TDUq0DL7qjzsX0DzD45nIY/xGYiqQsPWsF6+15Nz6C1LDk0AWYpPbRN8Cn2ikWhZryyBXMCWUynnme2Xzhb3P6SpVbJmWRUB+OUiTAxeSgXH+MG+7vcWUW5KVxXjoWe2fNen/jIZp8dm6dngLT6OUH/mybXSq7h8amsG+ZYFtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717884067; c=relaxed/simple;
	bh=s8WZER8/Q8BC6LwlNEm4+xR2JGW3mpGdN3qprUhBlL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udw8zZhmwgoLx3eUJuTK5AgoQ+yFxkS5wf7mkW0VbPKQaPbB/ALwVwSPoqk+toj/e7cKbwydsLPcTSspsEFTHgoWB8/8YWR/5027Ke2pZJUJRxZgs4Hx7GQY2ZKM/X1BO+L2Dp2ZgEt+XgwyZ4+9CPljwZqpqzHe9GS8BEL1fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QlWAX7OD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626919d19dso776497766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717884063; x=1718488863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/J5RbdRxFAMGv+IwRlqwrIrwV2CPOa3iVCPI+grUnKI=;
        b=QlWAX7ODwpr217wy/Cs3HWMc3q8PZY3IdCD41hvODi8YMzEQetQBH+zayaLYTxaSwi
         Fx1NAJL6CNNr97YppSZ7cSRNgx5uXTa1y+CbFLkE0RRHVcLtNXY5qQLe0wXf2KRHDiTy
         XNtOtxw7+1SxVvTKf/8vzVIWltH3VBZUdQHOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717884063; x=1718488863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/J5RbdRxFAMGv+IwRlqwrIrwV2CPOa3iVCPI+grUnKI=;
        b=gwrRal+bwgGFp05gkNjVTTjQjUg6xCo84iEv+sHNTg6KLpYCbqYxixWq+rklm5v9y9
         UAPG5EkcQVm/4KRqERD399puRyYMUMJpLWUlm6p9ygV7AIgNlQj7LuEGMgBrA6LjDXSF
         kzUNYs5qr2eKqIiTNcoJIaZgxOlYYaK8PL/9NRDsSqc08PtIEwj3ecz0ojEzFE3Jq5Tx
         v3hNpq1KZmATYHacVKlFA61lspoOigygq3ucCm+DPH/KeSycjWOr8CWUYcswH1NK8gIO
         chx4k35K2yYbMUYUt7GQaxws1hpsFj2iDCK80AvGINXXmo+jGY0yI6/rPpoSutH5ooik
         EsSA==
X-Gm-Message-State: AOJu0YzWuT1TrzZtwvqmVkTee3zwdQTSR2v1ddibnl4nqQt1rI+2eCvS
	tderrSl4r7zRCpWZVoDdmvKAgXOStt50zFeTX547DnccMxLAQaw8bGv+BiOXqu2C9nIUioYD/Xx
	kA9A=
X-Google-Smtp-Source: AGHT+IGIXGKoZzZEMABuaVH6VlN6qoVMdUDOz+BVvrWTWztDnRqFE/qgoEtNfnbHvj3s+9Z9vR8DOg==
X-Received: by 2002:a17:906:6bd0:b0:a6e:ff5b:8051 with SMTP id a640c23a62f3a-a6eff5b8527mr167330966b.6.1717884062772;
        Sat, 08 Jun 2024 15:01:02 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6e438d2c23sm258531966b.6.2024.06.08.15.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 15:01:01 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so4012896a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 15:01:01 -0700 (PDT)
X-Received: by 2002:a50:998e:0:b0:57c:6004:4388 with SMTP id
 4fb4d7f45d1cf-57c60044692mr3423648a12.6.1717884060899; Sat, 08 Jun 2024
 15:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com> <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
 <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
In-Reply-To: <adbbd899aabf4e6898bbbb04f90b3ede@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Jun 2024 15:00:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
Message-ID: <CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com>
Subject: Re: Linux 6.10-rc2 - massive performance regression
To: David Laight <David.Laight@aculab.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 14:36, David Laight <David.Laight@aculab.com> wrote:
>
> I'll try to remember how to bisect through the merge :-)

git bisect should just do all the work for you. All you need to do is
give a know good and bad point, and keep testing what git bisect asks
you to do.

> I've done some tests.
> I'm seeing a three-fold slow down on:
> $ i=0; while [ $i -lt 1000000 ]; do i=$((i + 1)); done
> which goes from 1 second to 3.
>
> I can run that with ftrace monitoring scheduler events (and a few
> other things) and can't spot anywhere the process isn't running
> for a significant time.

Sounds like cpu frequency. Almost certainly hw-specific. I went
through that on my Threadripper in the 6.9 timeframe, but I'm not
seeing any issues in this current release.

If you bisect it, we have somebody to blame and point fingers at...

                Linus

