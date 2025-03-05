Return-Path: <linux-kernel+bounces-546299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0BA4F8EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCA7188E398
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62C1FC0F1;
	Wed,  5 Mar 2025 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRucgZbg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1831F5424
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163778; cv=none; b=N3wsWq3+7RmMzwk+NHAMhzxQdlEoMBcH+KbKortnhvVRbMRB5OQmo+vIQOzia5sMpjCQ6bk+nX4yqKbNGKUN3efNiUnYUrLtSAFRbhAcmgJ0RSxmIzPN0m3WaIGxzo0K+ucWUXZW0bBZTqveZsrc7OQU3D4mVlucM8WRqo/aIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163778; c=relaxed/simple;
	bh=tclfnaQ+78uJUqE4m2J8GwrNwDst3SKOWGjXQTac2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW+Idvi8PDfdPIq0h0a630OvO7XRtu4CsIIW2i9OndEc+odnebFOya+zkNi9XmBt+MFYWpvYvqzy8q8dlQi0Kxl5YpBhI9cHrVFT0ZDRjZ90CT91D+AdrPcWT3LnZFEdwPx0dQPJmiYNQUuSKZSjH9V8xOlD07r5+Ef06shw9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRucgZbg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcad638efso11640295e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741163774; x=1741768574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=mRucgZbgodwpnJ/LEwx6AquTZQHVsPy5Wt7PkYj3/3iuVXlzlfYtpsV5C2wYRBmbjw
         3EoNk2BCWG1GAhSntBmEettOHYWTw2qcwjQFFgUL1MBd4YosDoTysLdpXDjaGw4dS5/N
         Afz6ZJnF3JarVvhJSD/cRh7RFuYL7ulENxsauISFdD0pBKnaBVNiVDZ1LdAb5/NKn++B
         5iWGnQFlmfBbr4Dr/jZayWeKdN15hWB7yQvny/iE3hdmhtMSsRKqZKIQU6aD7hHmimWU
         5BgNaV21Aa7Kck9JS9G6E/zL3yh/A8g5Gr1dvG6j87h9dCZniNs542brkWusvVD9JHQo
         W0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163774; x=1741768574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfQXwUL3Ydz7mR+cjRUeO/xqWRGS7uJqxxJMkaNfgT0=;
        b=dV3CQzA1UdVGzalZWYMEMonbb37krS7zk3sK5tL4iVncaVbDzZT8FUCae7+BMCXZ1r
         ktmNg7O29PeN8TA7kWOrpmwDA0JzFZhRejPKsnP+QDrxTwcD/ZkYlNOWZhQTN7GZTIEX
         kD9z5fdNf9tcJQYAgw9dTlccB0S5nvYmwhHwywAoJV2daykTBQmiLpVSiOQIptxISBhY
         t1w8PW7WTJ1GSPgtV2Z28jAW6u3t1COgoOJnzomq0oTll/o+BESnIvPtSlqn87akbz2F
         9D5naq0gw9fZiL3/K6yVR4w3gnLt+Sv3SS5TwOVp9c0RQDM/sNFNOzIcNG2BnL3KXqYm
         zB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUQfFab72BSBKX+GaZaMZNQU8prRSX/4GRrSEXila3FT/KsaQaduUU4dPUBqAXFRlanh2TSc6mhZYkZ700=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWuqi1JuUcesxYfMuIBs7ggWeEVoz1FwCa3bIazn6/irbFgSR
	AIIRGIe6Enag5YU/dAoHAUJzmWREAm6k6uy/cvdzohETZK7Ocx0oPDuNDw5qMys=
X-Gm-Gg: ASbGncvj+I8JA9YBd4nx3eaEdhulOytzqSC87Wa5Pcw2hOic/GQ3KhCjpHdWGPVH/z/
	h7AaZtAJOBhrYBwRswSV6yIV+fxOP0HqD5NDW7c0/xxV9SvLG1tax3FSGqvex+uT/5uIep1tlMg
	qXS7XMcDxAP3Z0jFQWrHW4XqV0TR7139oi7s4wKl2+lmzw2Rs7boKO2jIpYLKfV2Mkgn6UIC/Wp
	YzUkP3wA4pX8vow4kJOGHxqO/iBJAv6u1wbBVIxRBpDizrnfyVB9uus9hAY1uhCw3VRKNJNMnbk
	dcx4J2m9q3az3aQRJ+B7u6MLtE68aqKEFOco896Dt+Evk0YKNg==
X-Google-Smtp-Source: AGHT+IG1TdRy5Kvu8p1cmT5U4TYJbrUoCcVGa1tX1dkQIqW9WiR2lgUQPgvjP/3zB9IzHIHCvQwYww==
X-Received: by 2002:a05:6000:184c:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-39123deb51dmr497486f8f.45.1741163774150;
        Wed, 05 Mar 2025 00:36:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm20564933f8f.14.2025.03.05.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:36:13 -0800 (PST)
Date: Wed, 5 Mar 2025 11:36:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Elver <elver@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 01/34] compiler_types: Move lock checking attributes
 to compiler-capability-analysis.h
Message-ID: <f76a48fe-09da-41e0-be2e-e7f1b939b7e3@stanley.mountain>
References: <20250304092417.2873893-1-elver@google.com>
 <20250304092417.2873893-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304092417.2873893-2-elver@google.com>

On Tue, Mar 04, 2025 at 10:21:00AM +0100, Marco Elver wrote:
> +#ifndef _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +#define _LINUX_COMPILER_CAPABILITY_ANALYSIS_H
> +
> +#ifdef __CHECKER__
> +
> +/* Sparse context/lock checking support. */
> +# define __must_hold(x)		__attribute__((context(x,1,1)))
> +# define __acquires(x)		__attribute__((context(x,0,1)))
> +# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
> +# define __releases(x)		__attribute__((context(x,1,0)))
> +# define __acquire(x)		__context__(x,1)
> +# define __release(x)		__context__(x,-1)
> +# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
> +

The other thing you might want to annotate is ww_mutex_destroy().

I'm happy about the new __guarded_by annotation.

regards,
dan carpenter


