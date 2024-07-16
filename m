Return-Path: <linux-kernel+bounces-254541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C1933483
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07601B230FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC07143733;
	Tue, 16 Jul 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c6x0ZWq6"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53C249F5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171952; cv=none; b=VhKN1w58N/NlKLPjtqOGtgAS9wbTXks44UqKr8T3YjfMJBVFRctGgrYvtFQuE7KYm+cVpY1dgTKuEYzCmPPkuOvMx59DZQ7WIHwmwHeee1NlT6gIYtLl5pdX2tcxCvV8lVE3q9jSbLQAqe1L8W+OgRsG2sRB/bcJ02AxK+7oLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171952; c=relaxed/simple;
	bh=N3hrn7dvWrdYtPxRFX9++dSAnB8DCp5SgyAV/Xv+7Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMz3cc1rnOwURRDFM8X/y+T56qx7/rCJY7ejSYzHiU7eXJUKMMsMp/Lvir2n9t7u+AQDvJNc/dMHWHcO/AHUsmE34PnwTVcdDtQkgN+h6rhMyIT/PFgiMhvHDjRoEUwcC1XU20n3tKpvJ2bfEMNfg9TV2tGewjlbWeNviRvA1uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c6x0ZWq6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea5765e75so7374279e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721171948; x=1721776748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaaUOlTJ2aiy5WeShI5LfyPJ+K68pFBCFfdMRXXg7XQ=;
        b=c6x0ZWq6dBo5FjTJhJ9pPtygG6aRRapBUDjzY+4sm1ScT3kBEkE3WLj9Q4jw4cBQD1
         efKbfCqBPS3wP02mOpqzrCSax4oxMQvKLisBFc4vvxEzpNQtHi1Njn1Kx03Q0oyLZ2om
         wgnSRhNTCjOIXQo566nrplURIRrom8bFJoQ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721171948; x=1721776748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaaUOlTJ2aiy5WeShI5LfyPJ+K68pFBCFfdMRXXg7XQ=;
        b=IyXjJU6USLbPUICVCCN5XwhBJzJXq3HGk7h0q3RbwFWs2kifJdR0SpPlm8GpVVFjsv
         N2g0QvDk5DfYJI3Eo4WkXXfRYIvlyW1G7E/o+qqYIsu0+BVc/x/0M6KEKakHic0qcDUl
         Nm6B/jdYzHMJkMGNKhAl9ALLi+WI43O7TcYR0jS6axj2+A0SSehRDye3NA8wneSUlnvT
         xxD6D+SMKE3mN7rCmyaqIMc09HYQc+Dgg2KhdDS78K2pbu6Tnkq1EjzzJRMyIPiOvL2t
         /rEmKt3/mXRY9fbvxIOHtCiE1NOWMaoO1LT6JzPDHb1R13X7x34nt3R9xJgA8FPDTytv
         Jc6g==
X-Forwarded-Encrypted: i=1; AJvYcCWHOWW2K6xXCmdKi9DsgUTNDN4g+CdJkef23gS2cVZh3N2vNVKEk/pFQGDfHGrWl0OxUj5UpSzXCXxsBAMIqhFdVmfQM2TU/2HWeGgs
X-Gm-Message-State: AOJu0YwooKXVwAQe2ucc79iLDWdrUN+JZrTDO9BSZqDjjy6Kuc1DrWIc
	xHuWKe89yTdghcpeW/COKxm2X6u5YRv0iRyqbcBI5zXeaJ8dvVQ1Aqh+GwIG2yn9i6nme2aAE/d
	Yu/wSvw==
X-Google-Smtp-Source: AGHT+IHI0AGKGD/UMVperGIpuHvhy3TqxBRnayOyn43Tz4mIfFfvuxnBgeHZFuaoI5gAY9vlFZYHXg==
X-Received: by 2002:a05:6512:3a8f:b0:52c:e1e1:ae91 with SMTP id 2adb3069b0e04-52edf018252mr2451906e87.11.1721171948047;
        Tue, 16 Jul 2024 16:19:08 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e2a1bsm1289617e87.24.2024.07.16.16.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 16:19:07 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso66006761fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH6R5LjoRMLepTH0X8ZC7F/IAxqqDnqvW+3kyUIA0faMTXORhkgVhpY0tpI8alYUBUT6avt8QWEFKnR5zbkMGExoesYdva4H6AIyib
X-Received: by 2002:a05:651c:94:b0:2ee:8b92:952f with SMTP id
 38308e7fff4ca-2eefcded54amr102261fa.0.1721171946631; Tue, 16 Jul 2024
 16:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X>
In-Reply-To: <20240716143644.GA1827132@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 16:18:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
Message-ID: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 07:36, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Our continuous integration notices a crash when booting User Mode Linux
> after commit e3c92e81711d ("runtime constants: add x86 architecture
> support")

Ahh.

Yes, UML should *not* be using the x86-specific (or any "native")
runtime constants, and that was never the intent.

But it turns out UML ends up just blindly getting it, because it ends
up using the native architecture header files here when it exists.

How very annoying.

I'm not entirely sure how to tell UML to use the generic header and
not the native one.

Hmm... Does this simple (whitespace-damaged) patch fix it for you?

  --- a/arch/um/include/asm/Kbuild
  +++ b/arch/um/include/asm/Kbuild
  @@ -19,6 +19,7 @@ generic-y += param.h
   generic-y += parport.h
   generic-y += percpu.h
   generic-y += preempt.h
  +generic-y += runtime-const.h
   generic-y += softirq_stack.h
   generic-y += switch_to.h
   generic-y += topology.h

basically telling UML to not use the runtime-const.h file from the
native architecture..

Somebody who knows UML better can probably confirm whether this is the
right way to say "don't use the low-level architecture file".

                 Linus

