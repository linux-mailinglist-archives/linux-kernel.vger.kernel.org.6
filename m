Return-Path: <linux-kernel+bounces-184287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41798CA4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102641C21240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112155C2E;
	Mon, 20 May 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lu/DKLuY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06C3E49D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246575; cv=none; b=ix0TCdJUsqKZh04z26Ey60r4YPvXGmdj/JnsxAR/ODDhL4FPTz4Pvn9fSBsTAqQxa9CZHvb5Tn+EJ74Nw1eL9wiuY33doyufvk5ziQXFEa1FZdeOFVeNR1S4S1UEu09N0wvaLYanta0p3yafeBJAG/j3rkSGSSCVWF6205so0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246575; c=relaxed/simple;
	bh=oURIQ8GCHpqOqM5pA4QbJ6dnCOCQctIKVZEaL9xBDAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDzX+yMMV6/0b7UyLeYBCacgoeV8KfzrAoHSUGJs/s0HsVfYNIEow7pBCtmDlB1sxXcvfYmWKmayeOqUvWJ8B6IOI36texBtToqY+G6WTiNOiMqiYpYPYPQaUifWMbgbEPgz8ChRL7vcZaIm0Afd6UtoqwqTut8iXF+aW+PvpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lu/DKLuY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a609dd3fso1058867666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716246571; x=1716851371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvM0FitcwUpr4p4+bW7JYL4NlfErVMc9GVAB1zbL7e0=;
        b=Lu/DKLuYjOPTR1jQf3YIaSgHxl5YhlQZd4RniEtAH4v/d5R/dChbb8j1f3XtOzlBWl
         LGVlJ/QrlUDrMNqmHvI4ptmj94HW1OjkvDigB47L/j5ZxtOwC5Ntro/eBXcd3HvPK2Jq
         p9jhw3cJE4p0M8im2KSNa+pQl1IxcK9ysMT1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716246571; x=1716851371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvM0FitcwUpr4p4+bW7JYL4NlfErVMc9GVAB1zbL7e0=;
        b=PNkepMJFtF0Gk2XqZpavhZoPwsdIxUtMQft2AZp2oe1GlA3rHvBeKRZXMFm+JfioGn
         5xHgJHPCBnP0+oY0n61KolraZN/6Dnieln6VfGcj219j1I2nhV7DT7xJwm0e0ZJxzNGp
         hAnZ2L7S1uGnlS51a4T5Va/zfNQLzUN0DdJJyacWr9j6qlPFTUgjYep7LK1KDKVL3DkP
         HF4kOlNExFO0SK/UvG/TtpxXd1ly5vVBcFctQrV2hCxVBorsbgJcPq4dcdCd8bUwACr/
         K7jv9ezcP+Lr5qW0qmJ5UvClqINADP+Szwu78+q4jvaZv3b814l0afiY2JWrOQujZ0Gc
         iYog==
X-Forwarded-Encrypted: i=1; AJvYcCVlYxmN+fWKdbOS43Hj+Q2p/2rvqFIsivdW64ci3O2Rat181E4Fa4uXFUvhS/l4jiDA+94k7m/oGXM3sbPNBNSGCjvhsdBps2zhSA8l
X-Gm-Message-State: AOJu0YyGvIoGNx0zbxVRsWNYv79ePQ3OTerEUOu/dUqZbV0V6ZrgO4F7
	+RUMcCMx7GKv8CETfTtRM0sB2zeMM8T8TkintdBXIvcBtZAXFAi48YQc+MopyMJGDhwWV/NCrcJ
	fBaJUUg==
X-Google-Smtp-Source: AGHT+IF3p0GGMd0VlQFm/pEtd8IWsC4Nf4c4DELb+KH0iL1t7UImLkArNaMyaIvnMrNqF300O05KKA==
X-Received: by 2002:a17:907:a4e:b0:a61:a705:56f3 with SMTP id a640c23a62f3a-a61a705582fmr304545966b.35.1716246571315;
        Mon, 20 May 2024 16:09:31 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fcfsm1508076466b.119.2024.05.20.16.09.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 16:09:30 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso11064543a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYJ+XgmoWLYgPak2Zcy8RJyXw7mKxNnMvruCF7y7Zb/J12Qz/kw8NPXGUJgcgTCFBX99BiLQtKK5tTB+4C5zT7cGMlHYR56TLqCBax
X-Received: by 2002:a17:907:110c:b0:a5a:24ab:f5e with SMTP id
 a640c23a62f3a-a5d5c824bedmr702435466b.25.1716246570519; Mon, 20 May 2024
 16:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520121223.5be06e39.alex.williamson@redhat.com>
 <CAHk-=wiecagwwqGQerx35p+1e2jwjjEbXCphKjPO6Q97DrtYPQ@mail.gmail.com> <20240520170309.76b60123.alex.williamson@redhat.com>
In-Reply-To: <20240520170309.76b60123.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 16:09:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGbNWK6aOcprocyO8qLySpzJ5-eZzC3if=gb-Fh8NsiA@mail.gmail.com>
Message-ID: <CAHk-=wjGbNWK6aOcprocyO8qLySpzJ5-eZzC3if=gb-Fh8NsiA@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.10-rc1
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 16:03, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> Sorry.  In my case I've looked through logs and I've seen bare merges in
> the past and I guess I assumed the reasoning here would be more obvious.

Yeah, the bare merges in the past is why I'm so frustrated about this
all. I don't understand why this keeps happening so much.

Who do people keep doing this thing where they just think "I don't
need to explain this thing".

Yes, git made merges easy. It was one of the design goals, since (a) I
do a lot of them and (b) it's what EVERY OTHER SCM historically
absolutely sucked at.

But just because merging used to be hard, and git made it so easy,
doesn't mean that people should then not even explain them.

I complained to Andrew this merge window about one of his pull
requests that had _seven_ pointless and totally unexplained merges.
It's like people do this operation in their sleep or something, and
don't think about how big an operation a merge is.

            Linus

