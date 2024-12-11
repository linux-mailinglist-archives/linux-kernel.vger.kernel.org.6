Return-Path: <linux-kernel+bounces-442212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACF79ED961
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF0018854BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE41F0E3D;
	Wed, 11 Dec 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ODfY97rD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252F195
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955016; cv=none; b=rb5WaDIsLQ81tU3lf4gcsCzSV6Iz8Li3iy+Kqj7WyTfFt0nVIsHvIAfyCvdxQdgQGJ5qME6FTzqbusjbvdd2tSVRRKCOuenIWhv5cRmPXNxnPmH8jD+BI9k0zkr3b7DWqvji7o2Tq/yNXjJ0z5507iJbRyBtxyVmKQ+oaacIKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955016; c=relaxed/simple;
	bh=AlL2O1EIgUE9bnaKZu5Rn4kyJtZlWnTKc4Qwvhn6E/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKyrqbwSDmCYDPLow+K5tJJhM8hdl5zKV4xUfBCVCMb56XQayjcSooDPiL8DegH77nzOMaSk2vUxhdQwp8KM6dD0OcV7/yhL7Y9WuT8CdvRqfI2KVi0/jiscYf75BzyfXRNamtWG2dwQbdHQZrW9Lynaj4BsdlgKsHHecDZFn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ODfY97rD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso11113957a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733955013; x=1734559813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL9CiMnrGdnrcr1vSHJtSdZm/E/kDweDxeUHMXuh494=;
        b=ODfY97rDSCUYNT9V5dpVVduaw9pTOyO8SxpCWxt3/LhfCsbfyFjjbobTpuT8g+Xksi
         +Sn5ZbrR/0FM5YiFwVscADa96sMiIdJTrC8vTTzcGJpUglpfpyTB4QfaO5rkS5mgxywD
         +pS92aJk32KzBc86aecJCgmAenmni4ST61Ass=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955013; x=1734559813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZL9CiMnrGdnrcr1vSHJtSdZm/E/kDweDxeUHMXuh494=;
        b=rQL6kHm44rnfAURfp/tGzrWz+Ks6cgOhvJ8kgmwLBPBc9sRBbj+9OQLne62h+PiKZM
         qnmPxTwfCWF/OEHmyEg3OTftpJBBpJNpZ+0tBzvr61K1NF69gn11pd3l/49016uU1ZhL
         R6lmaJipw++jCiBnejbDaWGdSAjg5UmeSnHdeLCP6B8ouzFXgnIGLK8f9EfWg2i940St
         H8Pju52N7+uXTr1q81bUrf9RacOvc0UPCSB2gIMat6vxWNYQo+ZlNCliHTX9qzLiaPEw
         IZApcpXsQnar8GH1EDsx9K9jUEwLq2zwkxPMYffUlQn4jUjr2trAipaVWI09u8++wtDE
         lpGg==
X-Forwarded-Encrypted: i=1; AJvYcCWgB5mkGfH568uuXx77wDgBkCLn2XNPijzNBf0V34nh3IRi22GByTwJKO0FboUlllX6rl8WAEWy9g8IulI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtQmDeBO+x+jg5Q7f97bzdl7u/q8WW3jU8XweUh33QrdvRQwm
	YHbEgOj+qPuTiBz+w1N1K21kJ88eQR4qz8VrVZkL1mXeSc/dSm8kzCZBN5twaK2CpAothmgALun
	M8/Q=
X-Gm-Gg: ASbGnct1MtDAGmk1ynsPgJtwptwSJTlxQ+f7i1IpUt8PF61sN5OH/xNp+HE0L+GA+5M
	+uImko41dQWEudv6cIdWw9sJJkScp2Mzy+nJ2M17Kh++/yLJXee4WtiCHX+aeO1AOefRUhhz0zI
	bpITjbpeN9N7MxpgXYEAbt5+A/2TzlCtrHNVMhoudTmaj3FgiMoNQ+xysFzvo4+M3o8CWlWpmUL
	OXhq5vYB1MJbGZbrP3tF3HMqBsIhQ/mtdVBF3FEx2h+ayOMoUDAXm+CkTQYKO4Xdo/fGXw04Fg6
	pls646dT9aCBByLp9c3mM7Mjid4m
X-Google-Smtp-Source: AGHT+IHMl3lOjNCmQL+aQO88WyGpc6vBLWlMA4DMu/PfWBmgKNhlEY9H1aKqSoKRzFgHgpTVthn92A==
X-Received: by 2002:a05:6402:3806:b0:5d0:e826:f10a with SMTP id 4fb4d7f45d1cf-5d433048aa2mr4627725a12.6.1733955012806;
        Wed, 11 Dec 2024 14:10:12 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm9576391a12.52.2024.12.11.14.10.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:10:12 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec267b879so1426395166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFg8fX3ICsv1JdCls7DkYhqTw6GEocBOcIGDUUO/fpm5h6jUL0Qjfr4xrGwJvoBLhE14bM0nTF/d99dmM=@vger.kernel.org
X-Received: by 2002:a17:906:308f:b0:aa6:995d:9ee8 with SMTP id
 a640c23a62f3a-aa6b10f5d50mr453569866b.5.1733955011150; Wed, 11 Dec 2024
 14:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
 <875xnqudr1.fsf@mailhost.krisman.be> <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
 <Z1oJ7PgRvLyctn0X@google.com> <CAHk-=whB_YjwB4sGsRGJx8AbxR8wRAJBfy+x2KhsAQ4QssZpMg@mail.gmail.com>
 <Z1oLq7817UOuCJQa@google.com>
In-Reply-To: <Z1oLq7817UOuCJQa@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 14:09:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2-tEcS=iO+aVdb1QYxPdoPgA8K3sBXGaL5VH6qCvFaA@mail.gmail.com>
Message-ID: <CAHk-=wi2-tEcS=iO+aVdb1QYxPdoPgA8K3sBXGaL5VH6qCvFaA@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 14:01, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Ok, well understood. I'll work on how we can implement the linear search for
> case-folding. Meanwhile, yea, quite late so, may I ask for its revert?

Yes, I'll revert.

Also, given that there are case-folded hashes out there, I guess we're
stuck with them, and might as well use them for lookup.

But think of all the random path-based decisions that applications do,
and that ignorable characters basically invalidate - because people
can insert characters that "don't matter" and bypass all those checks.

It's a security nightmare.

            Linus

