Return-Path: <linux-kernel+bounces-254170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C479932FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4535A28283B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB01A01B9;
	Tue, 16 Jul 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRAfwk2+"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F521A00E3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153475; cv=none; b=kVMp6PhlVbniYDxXFmzQPZwrkj7GydHVSHUEIlmoICUtztubmy/1mNOzA/B5IC2E+izif8NHUpFCkqfUEIlar68Ta3x0idL9XzXzYRagw8NkDal1tr0xf/MEj10VazDiu8Ka31ujDCbYAX/UWZQ+l6hBbHKr4ZUCqunRWFFkdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153475; c=relaxed/simple;
	bh=YrKAmUZYdWQmNQVBvftmvIIlp6vGE+jUNuUMqazJYvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMYlrOGDpA0Ton/P8RVXuNzuqLr5tSjcmF5Vhcnzf+CWQfQCUiCTrAYmOJE2JVXrngPdm4oeLcES7lzuaCFF2KNP6Y8aNeu5MwImolFNbO9OGMx7i2zoPF+2epOVRsj4EtRGjDcwN9NSz0e0XH54n2ngtUslfogxFUJxboKCMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRAfwk2+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65f8b0df1f0so32919497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721153473; x=1721758273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrKAmUZYdWQmNQVBvftmvIIlp6vGE+jUNuUMqazJYvg=;
        b=aRAfwk2+iO0BFRaOiN54uxE7zc1s03PMz9cR5t0Vj0jdsoUbiBJTkwZeUVVdZuUIGc
         X8i1olqPDdC8t06jbYlioRUyrsJG+d6QtYkhkajL4XKpSjK/Kc6kkd4Bs+s/oV1jflm3
         3xpmEaOYOLv2OsiJDHoGgPe9ytOSfcs+pSlBxUws0chTFTwjILI5OBiK/1VLFmHBlSvc
         w6rYu+FrsDv37s60vPP97xEjiutk/eT14ldy+9qHbH1rimRpby33FAJWk+IDhRggL9jn
         Tof1Sa9acwl1QNjnl6e4r2lvXBpXz+JYHyHlxPXVx9d4Vog8/dHzbInLeWwz/oUTd8Ua
         xxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153473; x=1721758273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrKAmUZYdWQmNQVBvftmvIIlp6vGE+jUNuUMqazJYvg=;
        b=Vy6kv2QTDeM+l5X3LDlv4HcJNslb13ApJFxlqRc9b+SiglhIVRKWr5z/BlT+S+19hh
         dEfNhdmzO65fZnPNmONa7Oreckc8LfRbAxYByAQtss8pPsPHubyPxcP1NYJaFnqoLuoy
         WXmPeQRVQzjhuirs40VDalbvMa7Gj0Z9RIj6L1UIdQdrNGXNPECfqOKRxCSWA3GGp3V4
         x8DzDUYdYHjO18XH4GEYwLeEiZC7HTlllA+weAKitmh+odMFkzbaQdCb/zwQF5OkaSt7
         3/pVJRRNT/bP2C8OmdTdFQkoaXWcCwKn7TYn2cSsbJe6Od3/B7PkGbWW8t43uOMTGUh0
         tcLw==
X-Forwarded-Encrypted: i=1; AJvYcCVLVfhreprVMY2RBWOoXGhibjcnoR8ObndZnZ/jigBAPec7eAIbjpHuwvplTFwP/kguHo1tg6Ig6IToobeHW8DNW9+JB4Yl5T4YRiA1
X-Gm-Message-State: AOJu0YycHNQzWE7016ldb3eGpjhSvJ0ZJPIEqF3Q6IgVvykeSv8kvmJn
	6R1rMVxB21YI/+PVJi00iKh8MmZqF1P70gbsZXF8N4SE/yU1mpij3QF4Mk7uEqKsIR7tAswq/a/
	Rqm2pj1K8AewQ8P6sN1tF19ust1k=
X-Google-Smtp-Source: AGHT+IEAkHRNW1v4pFXUKFOnJ9M1wVc1pbkH0YHvNYsSFN5y5HcX5A2yNHJ59GdjkD1QrDud7J2c9isnIrFSj2/JM1w=
X-Received: by 2002:a81:c248:0:b0:64a:e220:bfbf with SMTP id
 00721157ae682-6637fd656d6mr29418627b3.23.1721153472697; Tue, 16 Jul 2024
 11:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me> <20240715095411.GY27299@noisy.programming.kicks-ass.net>
 <CAOpXEOzisJO2kN+qwVRcT5z+jQdSAtL2mpzyH1Q+PcXYvFQDJQ@mail.gmail.com>
In-Reply-To: <CAOpXEOzisJO2kN+qwVRcT5z+jQdSAtL2mpzyH1Q+PcXYvFQDJQ@mail.gmail.com>
From: =?UTF-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>
Date: Wed, 17 Jul 2024 02:10:59 +0800
Message-ID: <CAOpXEOyC4WyOuCbGpoVoqtEMG4emR+wSXDKODqULYN0EpLEKdw@mail.gmail.com>
Subject: Re: A new spinlock for multicore (>16) platform
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Contributors,
Yesterday, I did not inform you that I added the mailing list of the
Operating Systems Laboratory at National Chung Cheng University,
Taiwan, to this discussion. I apologize for this discourtesy. The
mailing list has since been removed.

Could you please give me more advice? For example, should we implement
RON in the kernel under the current circumstances? Or should we
conduct more research before implementing RON in the kernel?
Additionally, is the current approach (where the superuser sets the
routing table) feasible?


shiwu

