Return-Path: <linux-kernel+bounces-282342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D728894E280
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64E61F216D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDB14D430;
	Sun, 11 Aug 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Is0i372T"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C41803E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723399672; cv=none; b=nRnRau5f6JkF8ECOwsgh8K0GYBZKWuDjGymbp0TDvF4dBrguLlVAKYIuy5HXzSHiVZtnB9p/4LYPLBT1p9qJ84gkQfsrh3T5eGmpL4GL4mt6CHBrMTdtg3szSfAaTiQwN9i43mGwyut7dze5eS1VrbqduU0YevoAlDvVsS5ny28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723399672; c=relaxed/simple;
	bh=AxTM6wY6axlhsU/KYGHNfN47+u99cUPKgse7q31C1c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soH5zxmkxM1KDp//VcaQSxFKB2p+gHua6GrUUXkCRwyPZo7dK2bdLhfkfEormRlGElVXvCBvdzovKwpbx0AE5hID4sm2A4T8u4BfuJl8ZRe0KWwc3o/Y2SEM9hpsNnhp6Gd6tB+h4meAvbEBX33CayM4WiZ2t4chm+A0g0Zy8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Is0i372T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so3987840a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723399668; x=1724004468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzmjvXg7gffBBVR9BUiPViwqzvMr4O+zZB9/X81Cl0o=;
        b=Is0i372Tib2Q3ps32W+lzcIMvw+q6DIBijB5Nm0uHvboX8y4vNJGteX9yYWNFqiCPN
         tdidAqonr1ahyHTJL8U1H9nkpEkkxTQyvS4Aju6viTcNa5NbK9ScDZaMclN2BlcWwkBk
         Yp66TUiMtxWte5pd0Ck5XRWtLY7864HU/MZi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723399668; x=1724004468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzmjvXg7gffBBVR9BUiPViwqzvMr4O+zZB9/X81Cl0o=;
        b=D+Fbp4ThzJr66pLW3hFDBA1XzNDPUneWLpa/VxujsjUyK2NyodWKmEVqM0tO5AdFo0
         cnqVeJf0UPfWwYJeMez5M2CHnrOvj2t/eEwpP+jXo3oZueAtEgyksS2+519ZNwWVBBkO
         EyotyldogAC1Nd8d/qDDjk+qfQxdGkQdFPMaDA9PO5qEkCQr8nJKG/ufrXAXFnfzgNC1
         anle/mOsWAVpJn9TQtnCa4KmonJpah3BOBG7l6u7zKAKKI0oMB9nmKcFdiqdu4SxcHRC
         I+UmRiquLxNJ2d60jHg2vmiE649xTlpydXull36an6WH2FZ8WXJY9NdJDRQ587HNtw/v
         M8eg==
X-Gm-Message-State: AOJu0YyuBUCAo5uMpk+JLDkpKL6ceLsMyvTjdGGAKudaJMJNJPbdKQu1
	tpebIFQDpNvhB9rJE9BxqO802+d+45o8VY9ymzpj0v0z2uWRzOBmRreumdM+RXCr1QG/5g2z13D
	L14/fKw==
X-Google-Smtp-Source: AGHT+IH9M2kBJqaOvmqT7j+3VNo0+42ip3j32erAzI9Z9RTO2xI2sW9HGuognJa6Lc92Zk4fRvlqBw==
X-Received: by 2002:a17:907:c7d3:b0:a7a:acae:3425 with SMTP id a640c23a62f3a-a80aa55689fmr566681466b.14.1723399667973;
        Sun, 11 Aug 2024 11:07:47 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb243c49sm160966666b.219.2024.08.11.11.07.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 11:07:47 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso3841420a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 11:07:46 -0700 (PDT)
X-Received: by 2002:a17:907:c8a0:b0:a72:8c15:c73e with SMTP id
 a640c23a62f3a-a80aa65b5fdmr551173666b.55.1723399666505; Sun, 11 Aug 2024
 11:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
 <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
In-Reply-To: <172338466744.1168419.7654203284534630611.tglx@xen13.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Aug 2024 11:07:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjasZbABR14SFRgkL8MZxP+X4qBUOUM3c97cL5gXuwrUQ@mail.gmail.com>
Message-ID: <CAHk-=wjasZbABR14SFRgkL8MZxP+X4qBUOUM3c97cL5gXuwrUQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Aug 2024 at 06:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Chen Yu (1):
>       x86/paravirt: Fix incorrect virt spinlock setting on bare metal

Oh, and while looking at this pull some more, and agreeing violently
with this change, I did notice that the code that *uses* the
virt_spin_lock_key is a bit odd:

  static inline bool virt_spin_lock(struct qspinlock *lock)

does this:

        if (!static_branch_likely(&virt_spin_lock_key))
                return false;

and this looks really odd to me.

Our static key code is pretty confusing, but we basically have

 - virt_spin_lock_key is now a "struct static_key_false", which means
that we consider the virt case the unlikely case.

   I agree whole-heartedly, because it's going to be the slow case
anyway, so this is good.

 - that means that 'static_branch_likely()' will generate a branch
(because the key is marked unlikely0

Isn't this wrong? So instead of falling through to the native
qspinlock case, we will branch to it, and we fall through to the
virt-spinlock case?

So i think that static_branch_likely() should have been changed to a
static_branch_unlikely() too, but it's possible that I've just
confused myself.

Anyway, somebody should double-check me.

I doubt it actually matters, since I think this all is fundamentally
just in the slow-path, so the "do a branch or a no-op" is likely
entirely in the noise even if I followed the code right. But it looked
off to me.

               Linus

