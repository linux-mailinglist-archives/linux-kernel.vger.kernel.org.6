Return-Path: <linux-kernel+bounces-209287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E5D90314D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E8F281DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646917165F;
	Tue, 11 Jun 2024 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpwW606j"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423A17164B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084055; cv=none; b=NcMPGZoKg/+xbzKOdqa0845n+QVqL4xUd2ovvE24JUx+bYqjaX1RXnzt+6UeD9kvk4XEmj7BAKwM1EQvo5zEWF/y2caX14Iep+oBdQusBSAXU85zErPC5FOnFVReBueCm4HtTX0+TCsespqyMYZQgY8sPGNFptlY+4A//+YkLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084055; c=relaxed/simple;
	bh=fR3uqfswqgPixvWJU+uzJF8SnpIWyc4DS1G+kRb9LI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gejZ/ym8jisp9JJxAwBTPuCB4GGLiL3e8U/pDHnYX1kqBViOh34pfc8DpNF7wYiTGcxLIVoR52ZKX05oZin1v7/bL000Fddy3ty3Y4FPA8ubCoJlNtMu1v5Wta8vykQ+iBy7G61dbTPttCc6P9J3+QamBiUiZNMRqt5tIOn4Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpwW606j; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42175bce556so24765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718084052; x=1718688852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR3uqfswqgPixvWJU+uzJF8SnpIWyc4DS1G+kRb9LI0=;
        b=lpwW606jE/ZzmkkXql9HRf/GLNevhz4tFi0qXc88H/g4Jn7zc7Mphuj5NEIcGsoARc
         2I0IUVgbYDqRNudR3JUzZ7L0XpXxlI4i74Zs2CkU8G8+x1ABF7L2en9cx5rL8DeytwLf
         sAGEgwyVuXbp5/WX1YTvyzG1cwW2mFU+kZEJc/Hhh+bN+61zujYl7OcmrPZbBfyUTKAI
         bR3vHP5RCVXnTueWGBogM7s2/FifsCGos0TiELEiOXOr3DoVhqHMC6mukUzWWOxAuuts
         RdG3yAmO27bw2wqJiS8hyr9jOQQCkhtmaIRfdUEQf2YBOADB96ZUfFmTbpj10T9bEfLM
         6HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718084052; x=1718688852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR3uqfswqgPixvWJU+uzJF8SnpIWyc4DS1G+kRb9LI0=;
        b=eZWAXj2/AENH6Ct77cucC9oaiedLUN+JMGC1cfab0lO1UMV0w4ppNq3VVbVH1oX21a
         4S3E1Hk4x+3cZEq+JRKXdHipUPaQ3WwYr8ukHk5MlIR31hzdomjkJLViCzKC4jCQKLju
         TaPmCtnYxKSqa289kOTiWs6Glicrdd2N0gLm1ZP4k8lFDva+FJ/e+YY7bHuISe49djCX
         knp+eGsI4cSkuRGI/DfkZ2VOHVbZuGDeEadRIzrKdpisqzty18sCwWVBESdgqL5t//9P
         v1f005JxeHCXqkuQxsooxamiSk4GD9kqPKZWKObPPk5aJABSNBk9XXFAePlyEhH/u6eV
         HTbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4m6BRQ4JzxbkGIhD4Ijn3bPx2n5jDVapxoxr8UhasVDaXcDxbgJXdg7TcLscn/nxT9PYX/Tf6ram+PIfEGp/zL5/oSe1br9rT4umP
X-Gm-Message-State: AOJu0Yx56jd+P6neOfqlcZl4kXcVQ4GDii48XX8La2TL6IKk3F1h8MtN
	AKdGv2bWcPTSsXq2xCHUGoQNiCySkq36vT5DftWdS0XIp8vppUKlDmB8aHaq6gAJylP1Drsbbdg
	gf2CrY+/HFbPgX2IyfVtdUdHaQuSCyJLdoPnZ
X-Google-Smtp-Source: AGHT+IHhYq94AypC29YgE3hVmYacjlUkNo/Qo9+rQA77kfA5hlq20npia7gDojAiEDcXg8++4JZWIpCmeIjETKxk4OA=
X-Received: by 2002:a05:600c:4e49:b0:41c:ab7:f9af with SMTP id
 5b1f17b1804b1-42251e64c22mr651355e9.3.1718084051642; Mon, 10 Jun 2024
 22:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com> <20240611002145.2078921-5-jthoughton@google.com>
In-Reply-To: <20240611002145.2078921-5-jthoughton@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 10 Jun 2024 23:33:34 -0600
Message-ID: <CAOUHufYGqbd45shZkGCpqeTV9wcBDUoo3iw1SKiDeFLmrP0+=w@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] mm: Add test_clear_young_fast_only MMU notifier
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:22=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> This new notifier is for multi-gen LRU specifically

Let me call it out before others do: we can't be this self-serving.

> as it wants to be
> able to get and clear age information from secondary MMUs only if it can
> be done "fast".
>
> By having this notifier specifically created for MGLRU, what "fast"
> means comes down to what is "fast" enough to improve MGLRU's ability to
> reclaim most of the time.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

If we'd like this to pass other MM reviewers, especially the MMU
notifier maintainers, we'd need to design a generic API that can
benefit all the *existing* users: idle page tracking [1], DAMON [2]
and MGLRU.

Also I personally prefer to extend the existing callbacks by adding
new parameters, and on top of that, I'd try to consolidate the
existing callbacks -- it'd be less of a hard sell if my changes result
in less code, not more.

(v2 did all these, btw.)

[1] https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html
[2] https://www.kernel.org/doc/html/latest/mm/damon/index.html

