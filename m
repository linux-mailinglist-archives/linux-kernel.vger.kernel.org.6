Return-Path: <linux-kernel+bounces-419313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C39D6C56
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 01:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC5A28149F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2663B9;
	Sun, 24 Nov 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BmEZpzDp"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9011362
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732408228; cv=none; b=D/IbM7djU+hK6GFgDCsnIASZ9R9T0GAiXTHV6HGWAOLH8LquLOKd8tEeW3frDgWt4AZNTbj7KJtAyg0x6o/XDllpT5UDzYv/Tyn07+TM0Pd9LX5HeXoQiDWsjeRxe4C5CURUaMvAJ2XAXmI3qtHr9ZkMegzDLk82d7sSpAUfH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732408228; c=relaxed/simple;
	bh=vK+3W2EiAJq0FPOMTc7nweIodObdMfU+Cd9JHDHERJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoyGz0f2oa+wRWA6RMX2qiUMgZHCiV3SW6yN1/iYf9Scn7tzZRMFGtBPqdsTVTCVmrD+Br3cgvxU7ATlupjILOsmKpSwFDsgZZ5yXDiV27Vq8G0npmws5stCNb03aU6GZ1jYQCQ1QXp/KhpV0aJlB0MxyvZa58Wk+h5hgDWLTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BmEZpzDp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382433611d0so2786341f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732408224; x=1733013024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGPRMD9cR7EMqOjcmqjn5vQV8yH237RsfdmXmmlb2Jk=;
        b=BmEZpzDpTjIjIz4mYIRV05zm6UutNqOyL9YK8XndBbwQE+PjjfMnOd8PNnt/BX+Ffj
         UIQK4bHe1Zx5mHsYLSEFiDLa2Q5aO5O3nVXoOfLrNXdWDzWl0ZBKzvyZw9JU0fSLZjp9
         Pjwnk0oFn8jB3bPOxEuNkyE0aagcYkVpm7u38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732408224; x=1733013024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGPRMD9cR7EMqOjcmqjn5vQV8yH237RsfdmXmmlb2Jk=;
        b=l+Li/odSNcI3NHJk/BBjWRfZG6VFiTcvSJWqMYmIGI6S7nJC6KTvkOs3q8Wj3LQIKj
         AAyOveGOtZGm7B6ZbL7N/A+JF7zfYbXBhDTW1AShrcRwcRc5NajQvBg35umG7K77TFoA
         lXwJevtDVEab18S4/nIGvhsZYB64kHutXYKxSXbhll6xnBZka44+QjWrDQhSubz1VaEM
         +NoL5ZWA+7UACvS5fRoeUZPxAyQV+fgC1yujpTGoovjo0ss5i7U1NMHUAwBYB7zI/KoP
         SmtjtK2cDi22FN8u/R53tS4WOvgmdfxpU0yEVpHwD1ve5UQcRZzjCjmJV+ik1JEdQHJn
         pGYw==
X-Forwarded-Encrypted: i=1; AJvYcCV7UFrUGjrEE58Ef50vg0/aicYIFMpoxn82lEKNNc/rcfNxKLK6QDReylesbVhtBG4b3JkRT75+W1PU/lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPD6uqVCEnSAzE2t/J9p7QLBNHbGSMjSmg77HSnS5tyEQNYDE
	AQRg6AMnemxlvm8V+wiUjTgADA5FPgZ8XJSME7uBpTG7N6JGx9Tro/3rKpgFZR8hi9b7vWPvE0I
	Qyio=
X-Gm-Gg: ASbGncsVqVtGmOtd+KyGWMaZ35q1tmc6q7csKMFnFENS1pvqgMQLFOw6YbJA6k3hoNn
	lGuorAlSj2qzgPpU+jsfm/JAP1X4JSK5/BT61tOCWqTaakYio74TfYkAhqY6NQJUJzMQ0/VfFdt
	UQL9mIKPRU/gOvvTj3kDAQrx6qpldMk2sLo2jkh5CNVlh9PyCuXaoawAMUSR1D2j2MO4znUuXdK
	+fSUfpinFschnBu5sHXjZzJoJJts8KyPXi4dPe+0OHDgm5gBtHs+810bG81cpS8gh4Q7m9tb+gh
	hvmVopIKXvoTO7+fjMG+Luwf
X-Google-Smtp-Source: AGHT+IGJo+uBTQGR5+6Vj8cd7udrMeaxdXxskyXc1SgOhVEwlxiKIi3rkv8stFF6LJZOT2hZzJh16A==
X-Received: by 2002:a5d:6d0e:0:b0:382:29aa:565a with SMTP id ffacd0b85a97d-38260b61b1dmr8433657f8f.24.1732408224695;
        Sat, 23 Nov 2024 16:30:24 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f0ebfsm281866566b.52.2024.11.23.16.30.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 16:30:24 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382433611d0so2786326f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:30:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOCRXxWGb/1y6QFba/CRJo5hMpPai3/ZAqSQVgOWs6Uxxeuv7uCDTI/9+/Uqgh0x1IxYkctK8SjuJ3mio=@vger.kernel.org
X-Received: by 2002:a5d:6482:0:b0:382:46a2:3788 with SMTP id
 ffacd0b85a97d-38260b6186cmr8305836f8f.25.1732408222578; Sat, 23 Nov 2024
 16:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com> <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
 <2195976.7Z3S40VBb9@basin>
In-Reply-To: <2195976.7Z3S40VBb9@basin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 16:30:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkMC3afZJBamTuppf4BTJEuHNVpqK7qMKsg5VgX8q2HQ@mail.gmail.com>
Message-ID: <CAHk-=whkMC3afZJBamTuppf4BTJEuHNVpqK7qMKsg5VgX8q2HQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Allow user accesses to the base of the guard page
To: Mikel Rychliski <mikel@mikelr.com>
Cc: David Laight <David.Laight@aculab.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"bp@alien8.de" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 16:24, Mikel Rychliski <mikel@mikelr.com> wrote:
>
> access_ok() for x86_64 checks the validity of the byte one past the end of the
> requested buffer, even if that buffer is non-zero.

Ahh, the non-zero case does indeed look like a valid reason for fixing
this. I was just reacting to the stated zero-sized case that really
doesn't matter.

So if David's patch fixes your use case, I'm happy to apply it with a
fixed commit message.

           Linus

