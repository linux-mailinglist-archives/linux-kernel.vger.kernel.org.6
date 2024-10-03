Return-Path: <linux-kernel+bounces-349342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 103AD98F48F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01FFB23304
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037D1A727F;
	Thu,  3 Oct 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjTX/QnL"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4341A7266
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974217; cv=none; b=GU5YOAId/K+3iSTpcKImTQikEfkupfpP+WkFdwq0YC0SBPBXIa54ByX6sJc9qSbGC2zDPjsIuHSgsa0A1WcsnbvuenJzdT+Bk2HO4VM+d5qowQS/WlsWHUdUfHwQvlVMJr7+tpa91Bu7wRbrkFkjGoUmOUHoO2t9RPZv2d66B4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974217; c=relaxed/simple;
	bh=v0ardiIYku0UfoAzMRc1X8Dkuw4P6ge+fZ/CwI30sE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOq3apcEl3jCGZEBzPgiraZKxZFl22uaLYCfadMOk/jCGFFAy4/lw4pr7Kic4RfFEs+CTxxarFVak1Tddb7dJJVBBz2srGK/S1EYYJzJ4N2BYJ/d/m+KsNeXKzTMAs3V4l//mTJ1TWu6ZT5TdARZ7pfO0Nw7Zb5BeJHJEfBno38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjTX/QnL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso14215601fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974214; x=1728579014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ME6Qt+72oI+Kjz4HVFbzblqp5zPtNCBbn6mVConAKz8=;
        b=bjTX/QnLag6hBxbk2Tdu34BwLXLAhKnDZhPJUjxF2p8iVGlKbY99Q9P3w+T18yRRvJ
         rUpe2BtFqMCvwPyhT3MoOXPbZRnCUklk2K9cZjNM3zQ4yWCr8qglQfaCho4nxg7apibX
         E90uLvGF3RAIXZ2THOG+51fJaQJk04bjzb+Fg2XHOOMovC7GMf8RGWixmLM8hg6IA77R
         2Hx4w5nqDcxUtViOwA64q5/omYoG00kbqlKE9kr/xqEvYxXE2Vecxni1qPVlYfj3+El6
         X401aQHWSA2B9rrFeK5si98vZXTi9csRbGDbntTx0xYF+ZaYog8T96n00quFvHrU+JqW
         3H8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974214; x=1728579014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ME6Qt+72oI+Kjz4HVFbzblqp5zPtNCBbn6mVConAKz8=;
        b=KY3OiMgTln7n258fxGR+sjc5/zeVAfcanqrgdRNfDqnpZLPmMLGjS2bpaxwvRIE7ad
         sbAcWom13MPF8RNF0/8QCAafjlrNwGD5xnzhMFMJgAWYWDsklnyZlKAiUaTTCdS1YZD5
         5wlv+nDlIRqQQQ7CVAluTMgggl+h/Uj/pbvgRe+FSap2abWtX9C4PHE3Mvk9hvMSSV2J
         +DczJyJwXcU7zAoQKuCozUqA3cAgSAHLrrrOUIyAUIwBZBsjqoW04SKH67OW978iJ4GF
         sVu2aINwibYbHJQ47PLftkPJ8iUcPNm3jm2bUKyfP4e7NBhuSK2t+YAJU9JwOWU8x/PQ
         vfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb2X0CHklH+I5Mly3E0u/r4Xz9HS/0fjLyuaNdk/Eb8iefjzYFGC9ZXFGh9xwzaaQH8RDaJ0AnfAjA2F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwXIUR4iLc12JBe3SelzIBg+J3r4avkECM3AIGDpqesKURT2Q
	sPxJ0O6XvYO3/peXihfWce1OGpwm3u1AqgVcsyK+Hvzr/Hs26LtFsVhvR2XaWkR8OrTcDptLOv5
	ErTfoUCwrZY0QtBcOBpVqLVDPMIc=
X-Google-Smtp-Source: AGHT+IHUYoTJu5y+PPsr5C2rqd4dPXv8VjYhEnoqPexKUNHFbnVPpqRHkRzqbinNMuFlR/AqjSb+wzD44AxFHQ3JlxA=
X-Received: by 2002:a2e:515a:0:b0:2fa:dc24:a346 with SMTP id
 38308e7fff4ca-2fae102679amr37578811fa.21.1727974214057; Thu, 03 Oct 2024
 09:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930135119.21164-1-quic_pintu@quicinc.com> <a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com>
In-Reply-To: <a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 3 Oct 2024 22:20:02 +0530
Message-ID: <CAOuPNLhhAA31Ze23B=vQ8L30wYpRKXjYejUb5g8_wbz33eXzgg@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: fix unnecessary KERN_ERR and memory barrier comment
To: Joe Perches <joe@perches.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, surenb@google.com, 
	peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Joe,

On Wed, 2 Oct 2024 at 05:57, Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2024-09-30 at 19:21 +0530, Pintu Kumar wrote:
> > These warnings were reported by checkpatch.
> > Fix them with minor changes.
> >
> > WARNING: Possible unnecessary KERN_ERR
> > +                       printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
>
> printk_deferred does not have pr_<level>_deferred variants
> so a KERN_<LEVEL> use here is appropriate.
>
Thank you so much for your review.
Okay I will drop this one and only include the other one related to
"memory barrier missing comments".
Will send a v2 patch if you are okay with it.

Thanks,

