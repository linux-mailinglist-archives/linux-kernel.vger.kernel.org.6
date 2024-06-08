Return-Path: <linux-kernel+bounces-206916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30FE900FC1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E672A1C2109D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9213E404;
	Sat,  8 Jun 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr74aM8u"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB5ED9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717829742; cv=none; b=s64OMuzIyJMyel3MzaL7f7E69X51R+q/CF1R6Ob6uoFo6ehRR/p2h1o9vC6l97AJYJX77sLzzLd3EThyz+S/c0uN1odgYOLeBqayLghKHaV3nyoGMVY8wK3wEAcOLk7pd96IJiFkcZFVuYmiSGs893T8TkxN4Y78hfXCTQ2u7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717829742; c=relaxed/simple;
	bh=g9H5yvnh4RR42IuLPBgSRZSBktM4eq+tPZwmYAVsWkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCw+2c50zhQvOGRCElen4Xg0O6Fr5t5k5iTNNW7gYTsgGKSg6SSTScl5QFPKlVDtzDDFfLEikYDM6h52NFSfeqky1gr3WAK3aUjZOMhH1nHbTomBuobjYiJvtuOwRdjfHJM8eapZp6QUWa1/RD13hOgSGjD8nowHQpsN1uCFHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr74aM8u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so13048766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717829739; x=1718434539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MMFE08s+jyVi74FwNawWSoyxnBnTw0VsbbLEzcMZRo=;
        b=Tr74aM8uYosxLhw+v7LNKxX5W4CltNSi1FprTlpXqcVtBw4zRHlDfFoXo0CSxTsl/J
         vh60yuqWrSK7WUg+GY1bxG75gfJYHCTbRX1BB930VnskhOLq0J/gsKUBFJUxcsdEJTJZ
         Su/DoOQoCdssBzRSm5M8eTiPB+6mvYkuN+kuy6b/qeJc8g6A8A+vHzL7K6Rm+ir0H1mv
         dwOM2ZrIkQqEQLyILQaWdw6C5biY41wIrxb0ObgMJU5etPQSUMVZeRUrcv6sis8UvJ+E
         wM+61K0Hri2VxupOP5OhFgdbRD14enLPok2XtQcwGiE+resTq6jagHJ+U2q+vfcU/s2+
         ru/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717829739; x=1718434539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MMFE08s+jyVi74FwNawWSoyxnBnTw0VsbbLEzcMZRo=;
        b=fgKObZrqsrnTU/OWcttQqrpsHlCdT8wS5nhqZM/ruxCxe/lf+iUEc37DhXhOM8fytq
         sY1Gs0CHwEa+kCdiVDNSzr4Sej0HI80voV9Opb+aDEcKp7wncyjIsQYrKJTyoD/aRQqq
         cS5rI/yb7M8orZfmJ5wYfAAFIuDXjKTJKES1zDMtAe/2r/tCgmaEcFXG1uA0Eqpf1343
         j5z0KBchv+0BQP9eYKp8LNl5vH2C1/Gp8jByh1P9BUlblH5qGhicYFI4sEH42ATBqDr+
         RfaYPO2z7tyx5wIenT7SmxKG1eyhPDaSvVFprAE1ejJy3f3pIfdW4MOl7sO9uvIyTkoz
         vrMw==
X-Gm-Message-State: AOJu0YzisrU/YRNrRChPjK4vhzlSIPqvIZzOh+T5j6OZWyjbNInIWJ6/
	/MOCRZJ7eVVGXk3lY0JWV7XZlXViW6aUvFBPrYKBc6kCgKu0Ojxe
X-Google-Smtp-Source: AGHT+IEn8s8mFc5jPsZGbPvk1Xy4xFqLl8czpT8aqXRo+WqZKwg8m7PJsPsSm4qc5AIJM0SVJfspBw==
X-Received: by 2002:a17:906:e285:b0:a69:a66:75fe with SMTP id a640c23a62f3a-a6cd561c475mr263298166b.11.1717829738222;
        Fri, 07 Jun 2024 23:55:38 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072889fsm344244866b.195.2024.06.07.23.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 23:55:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 08:55:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Message-ID: <ZmQAZ-REghlJmax-@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-3-mingo@kernel.org>
 <20240605133805.GB25006@redhat.com>
 <ZmF5IhYp5JiiMHgv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmF5IhYp5JiiMHgv@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 06/05, Ingo Molnar wrote:
> > >
> > > @@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
> > >  	 * This is safe because task_struct size is a multiple of cacheline size.
> > >  	 */
> > >  	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> > > -	struct fpu *src_fpu = current->thread.fpu;
> > > +	struct fpu *src_fpu = x86_task_fpu(current);
> > 
> > I think this patch can also change
> > 
> > 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> > 
> > above to use x86_task_fpu(dst).
> 
> Yeah, so I'd prefer to keep it open coded, because of the comment and the 
> debug check makes a lot more sense if the pointer calculation is visible:

On a second thought I changed it to your suggested variant:

        struct fpu *src_fpu = x86_task_fpu(current);
        struct fpu *dst_fpu = x86_task_fpu(dst);

because you are right, it's in fact easier to read this way.

Thanks,

	Ingo

