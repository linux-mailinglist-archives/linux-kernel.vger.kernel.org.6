Return-Path: <linux-kernel+bounces-179315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74D8C5EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A71F22036
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E431FB5;
	Wed, 15 May 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Op3q2pUw"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906316FC3
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736046; cv=none; b=lCQv0gBYAlisxGb71iyACb/C5DruoQTJhwA3f4lPalCUuEumuUQz18ll0v2HO6nGIzt5a4GNFwpFT9sSV1CjcH6r79sYsQjdtKVxmDMfO4HJRAsLA0RzgfHxqjt9L4hFY/OOIUEYVihj0pbeaiyvdX/0Q1xNbiV1qMp0dvfMxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736046; c=relaxed/simple;
	bh=RWL2uQhi8Ed+uiGVKCNPstf3I/C9ZgqT5ZURnuftkQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApuHBMgBl3YzRdyVzmhtTogLH4SvbvNOVGMdd9YW2Hcy7ps5GIFm67Un5+o8TdvdA6k/gCyj3Afcq4lXmLM87TgBOe4rvZwsQH/l7TDyy5ymaiqxTYfh6JetwBKo2MMfve90o4BWZlaJhd8UAA+qwao82QCqZ/17UJ368V8TJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Op3q2pUw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52327368e59so3562013e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715736042; x=1716340842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=Op3q2pUw/FveAsXldNsihwe4bWCq/TKqiFu5nvQdpspLc2d/Xp7Q+9vhFiX+Bvlzt6
         iBOV/zqAIuESzU2zAchTrnSuQSrSKWtOzZW31bOfu4o/GRbxE9PWhRsaTtU7GHqj1VXe
         tPIBf6uCh6vgy2E8vL+h7YIdi9ejnWYjsTVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736042; x=1716340842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=Y2lhp869Cmx1qKYtFNgS4EQZZaim8XYZJlj+MxDy/21znWrAtGTQ+j4Tw0YSWUFQ8D
         i5D0+MoK689Glz9fkD5j/ig+SRPntvrwBbKaETqMnr9M/70GvpFyvFd0WoGOVQdipsoG
         hPfCw/jC+Fbg1y9aICSPeCROVU7DHDf0SzvYopStxmvpf+ru+m9tqr3DH767ries0aAs
         g+8ulEChga1evJzF9kWCPschixBVqIk5Tb3ar97XiIQhuqUB2VFW7MZq0LRh0i+RmanS
         j+NmzYfHG7D7PTOSRzbIMa5UScSM1iS1fj1LQp9Qk/kxP5rj3VNOr1EnPM4eVf9RLbi4
         w0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiA1C01iTqBeOT6GHpltRFVGu4zHfogTZWkezNnLbF0wwyslOUc9TDASLb+vGTiOUC7PBHEAcDvofoTZqX2fXiTb+remgJNvZNaEWP
X-Gm-Message-State: AOJu0YxCGlg3yHFxUGHbpXh8RsdmR/1x6OcbsQaI7qzKXbGLrSLl0448
	jXrnypSiZIfk575N72QXbiYoBtl+JneKlMZPV8bUkvDT7ZoIXbDcb+1kZSZMHhGnR4pQQp8MFEL
	SjOO6GA==
X-Google-Smtp-Source: AGHT+IFBPSp68+QAofhmcWE6hMqq/9kpdKJZHmwzC+KWElMp46JuPS0sO+kd1kiceBnGna/8LgNn2g==
X-Received: by 2002:a19:691e:0:b0:518:c057:6ab1 with SMTP id 2adb3069b0e04-52210275f30mr8035057e87.66.1715736042526;
        Tue, 14 May 2024 18:20:42 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01724sm786660166b.162.2024.05.14.18.20.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 18:20:41 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c448b44aso119226866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcttWOFarO5qLFToVK9QixPMbQszuvnyRdJky0dGHJBb5Jn2cTmjiTUdB+MTe5YCJERilC+CZ9kWMufi7mU6aqBXXVUaJlSlmtcJkM
X-Received: by 2002:a17:907:9625:b0:a59:db0f:6bdd with SMTP id
 a640c23a62f3a-a5a2d5d56b7mr1123543366b.44.1715736040490; Tue, 14 May 2024
 18:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org>
In-Reply-To: <16982.1715734632@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 18:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 17:57, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Let's wait and see.

You may not be aware, but the Open Group literally endorses the Linux model:

  "When mprotect() fails for reasons other than [EINVAL], the
protections on some of the pages in the range [addr,addr+len) may have
been changed"

at least according to this:

    https://pubs.opengroup.org/onlinepubs/9699919799/functions/mprotect.html

so I think your atomicity arguments have always been misleading. At
least for mprotect, POSIX is very explicit about this not being
atomic.

I find very similar wording in mmap:

  "If mmap() fails for reasons other than [EBADF], [EINVAL], or
[ENOTSUP], some of the mappings in the address range starting at addr
and continuing for len bytes may have been unmapped"

Maybe some atomicity rules have always been true for BSD, but they've
never been true for Linux, and while I don't know how authoritative
that opengroup thing is, it's what google found.

> (Linus, don't be a jerk)

I'm not the one who makes unsubstantiated statements and uses scare
tactics to try to make said arguments sound more valid than they are.

So keep your arguments real, please.

               Linus

