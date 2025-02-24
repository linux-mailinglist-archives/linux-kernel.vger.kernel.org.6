Return-Path: <linux-kernel+bounces-530081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0498A42E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970BF17899D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5A19259E;
	Mon, 24 Feb 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lG/5AH8x"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4C13C3F6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431212; cv=none; b=Q+qdvV/vbtFxbhjuXy++rKaMtOntppJvR64qhD/HqzkmiiLDAUhSEOW6XDvOBnbnID7eUKuFwFq4MMc8Rzl9ci5Vb3vna3fL+JY2Oeha55QlXa/Whes3IgFK7wzHjoUqJzHG8MwGvauGKwJPOQsxnby/iTy2xC78cR0hx2yf/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431212; c=relaxed/simple;
	bh=+B5pyJ1CO+Mbeuf4lA1Ny1LCGYQD7A/x64IGnU8BklI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n0Mpu/4eJOX4ZGgZ7g/mAsYbtFNzr5cJCpMfdgosfOv1ulnG9H6SGsuWza+HGk0S+1FnDpjldQbJw1wVVW8pl19DlJXenPmwb+/k13bxqmFYmPh/sbQTAu+oeW2l4yqtooO7bt/alqvYd5k4W0d2ZokEtaa4p5vokf2Y/Yua8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lG/5AH8x; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72755fc91d9so434217a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740431210; x=1741036010; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOE07JAo0aeO2qkwqR37ZGgXUL5hffDQBvOrMvHkhEM=;
        b=lG/5AH8xslxb7uBP2k02w44D6awbc3IKT5kMWjH7RwuwjNXiYzbMX7MHY15YkVKo0f
         GD7NrlGgzzOhFjU4EGMu2FPK97vDNvahCq2ECKsfLZHtdjBmhzXTtmpZxRq49goL09gF
         RNkjFt5VaXIXQ9N1bBhF4pVGnMkwGmrdlI2kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431210; x=1741036010;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOE07JAo0aeO2qkwqR37ZGgXUL5hffDQBvOrMvHkhEM=;
        b=A/05IvWCA8xy8f/Gg/SAdf6lMn91V79TLCS2wSvWno3ncvZ7Bvs3IZoMY2lJ+rHDiB
         oTgLsDFpR53/Y+4ZXG3U9rBN4YIrsIpsmiLn2UuRLDqGcOkRFnR4fgzGRG9/3UGrwVmj
         tAEKQ4ONt75VVakJQDgyQtHwcX7GZ+TXZx3DErIdHrMy5fz4ZfF2nKpJRsz8tkmCCO5E
         1nm/zX19fFLdXjIfkWHMz88eI1QV912Twa3JrkE9dp3GMpjlBblGt/B9h/eTwcEd1FRo
         jOR0P+Y6Zrrm9XoLYvzelg8hIJUEhm8+Vbt2faDVWDxs0DvMOSV3ZpSq7Rq7t//Qwy/j
         L63w==
X-Forwarded-Encrypted: i=1; AJvYcCVIDbFlUEvLwzBaxAMdRydvf1tDUexuRRkf6hFvn86YEQIo8PWoY/ceOOcENUaZI0icRmKnOf1CrMX8AKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPw/D27VNH333M68r6JhyYx++SM/IrVqVZbcvElXlNol8thww/
	REp9bjo3v9826a+OMVNQkW+Ob7c51dgmGOVYtUSBCnvfvxuSMVHgBxpJamKjSyXb07aUEP1IYKQ
	W3uZHj3zIBSZ++W+Z7jGfINmgtTlqNWHmW+5l
X-Gm-Gg: ASbGncvQ7r+FpLVmhUBCIp5sGUaitNjKaF0skHklc8DMDZJxrL5LnjV7iI5mW3mwB0/
	L78RhWsNyRqWjShhqOwL8NWs1tOXW1wU7L9L2jy7atP/7qKytT8T6OTBVbOSGPTa+vXKBZKDAcC
	ZpDQWlKR0w5WVnKaCsT2Gf9hl2alZFgXR4Lpdc
X-Google-Smtp-Source: AGHT+IHwxUED7fRonpMySFdHn9FWsxFw+fOcub3O2dyBPDgDK2zdI7zlIRb+ojdTim+vpIhqeKMskqA8xjkLTVVSLO4=
X-Received: by 2002:a05:6808:201a:b0:3f4:19c3:8cc0 with SMTP id
 5614622812f47-3f42469ef19mr4033878b6e.1.1740431209155; Mon, 24 Feb 2025
 13:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp>
In-Reply-To: <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:06:38 -0800
X-Gm-Features: AWEUYZmrz_kKxIc5fJOxGGLkQwCE8hjxnIZdH2BjY5NJFECiClfbmfOlu_08FTY
Message-ID: <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:26=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update memory sealing documentation to include details about system
> > mappings.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..10147281bf2d 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -130,6 +130,13 @@ Use cases
> >
> >  - Chrome browser: protect some security sensitive data structures.
>
> Did you mean to drop this line?
>
Ah, thank you for catching that.

-Jeff


> >
> > +- System mappings:
> > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MA=
PPINGS),
> > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, v=
var,
> > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr =
are
> > +  known to relocate or unmap system mapping, therefore this config can=
't be
> > +  enabled universally.
> > +
> >  When not to use mseal
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Applications can apply sealing to any virtual memory region from users=
pace,
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >

