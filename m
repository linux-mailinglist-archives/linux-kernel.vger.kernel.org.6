Return-Path: <linux-kernel+bounces-380693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061B9AF4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938811C22089
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0489A217911;
	Thu, 24 Oct 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhCDP/kB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544121732B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804852; cv=none; b=iwbzTj66IS62HB+8rKQ1uJVzgQJYVO/65nzv09pbxwoIGqTOYTO3k6sVF9ZlVp4y9ZV+HFM5NCqudU40FCJmemVR1QlZhxTBRfuYz71VW9kjH++ivI0QTEWfX9ZlCAcq5IqwA39TZTqfLvwBJRH13n6jdYr1zbLTGbyFkjmjA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804852; c=relaxed/simple;
	bh=OiKlShSbqdbMke+lpbNtykbmT+/jRycetEjYQuBMk8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZsSKhJTEkhDs3lH0Fla7rV7RsL6FKIQCri2mu24qSbFab7X+NHdqCVxoMREcm0m4oHDEokQE/sy+5jlMW1/AlMr4iqdjLCcYSxFvIxmGBnB0uksF/RMYMySNOAeCQGa0ptnl0NGCrx9x02aRIDGxuSEUZLpBd54vxa7+B5+HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhCDP/kB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso175663966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804849; x=1730409649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtb3tMMZLygMRIANpRpf+GLUOgtpm8O9lUJe8RW2I6A=;
        b=LhCDP/kBNjZDaQq+XitIxfLv2AzveX0C1lXSCqY0I8GaQgUTi6OZNni8Hyk+EEAwUc
         yi16ZpPAjhSmXSu9H3naSZjwH4UBTORgx83Z4lh+KYTisprXR2bESeqGu4hcSMtYK/J4
         C6otPJ8Bx+15yBYoZSJPARLZMX6n0FFbCAF1BzYHBO31M8V6BXPUsf4WCBxGnTLDqYLt
         FA0UvdHyv+53d6ZUhpSBZRlTJQD4htNWiOmtyUBo2caiNsUOyGS0eyAunsP7rni7Ldi0
         +Yjs2kRLu2+yNC8hj/fjKTBfrDXQaBwJcM7Fvv0tPhrVAGcj3mm4gLVVREWTdwZuBRZf
         duWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804849; x=1730409649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtb3tMMZLygMRIANpRpf+GLUOgtpm8O9lUJe8RW2I6A=;
        b=H/E1znZDuhXiGXYqQcPBWoE2wQyRJ3SUqV50Fwrmlv2ycc83KqZqmrMEgGLgIofWdE
         SK+hrlUJmrjshUQ79rmQ1cgWF8PTTD09YP7Cbe8FeyRlSmdtooZRZgZah6j1loPkI/wh
         A00j406EpdP61m2VJ8r88MeIibcXWt2e4tvVH+MPsn9O3KLJND5shIAeEQZRm4mh3s1O
         hujdbfpZA6OYxvPNP++/7JrxxaQ3MGHXd6ORU/i1ssc4LXxxFvsPRsn/pUeeDnp7uRBX
         EqU3QU4SpsGPe/XB1VSMTffMe8/CQc+W4MZk1WyduLEzKGe9nmRz0Zh3g4jFgyBoo2yF
         qrYw==
X-Forwarded-Encrypted: i=1; AJvYcCVKdD1UmFuzQsrg/7WJinRv4pbm3ziteR/bYdRNHO1tlRcmJUgCZ70t8Nrw75ratoIeFLcOssh8TIsjczs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbpkKP/j6tKNIsFP43V+IiTgdlz9Pv4/WxF4UJQCmcf6Gddlm
	damsRNSxKbLvRaD3NSotzX9uMqI5ZFIW1rwAddeVklLsM1EtB5g3qoOeqrsgR/ZnDxcrEYon6WF
	3e8+MFUWG2x8u+UifhcLfj3d43j0xuqovgROkdVODBsGKz0w2CRo=
X-Google-Smtp-Source: AGHT+IEvVfZ2y4WRNkmEZUcsLnFk79iev35c4Dnd6vZ7b2XPXoc2ae/MXF8IHmU5H+/DeBNNALNkDKerJ6fJHAs4CR8=
X-Received: by 2002:a17:907:3f94:b0:a99:ff43:ca8f with SMTP id
 a640c23a62f3a-a9ad270b607mr273081066b.10.1729804848469; Thu, 24 Oct 2024
 14:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-9-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-9-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:20:37 -0700
Message-ID: <CANDhNCpz2Gqd=xA_fT0jCTqjE9yU2TGvMotx36AhRQ9jFv77QA@mail.gmail.com>
Subject: Re: [PATCH v2 09/25] timekeeping: Move timekeeper_lock into tk_core
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> timekeeper_lock protects updates to struct tk_core but is not part of
> struct tk_core. As long as there is only a single timekeeper, this is not=
 a
> problem. But when the timekeeper infrastructure will be reused for per pt=
p
> clock timekeepers, timekeeper_lock needs to be part of tk_core.
>
> Move the lock into tk_core, move initialisation of the lock and sequence
> counter into timekeeping_init() and update all users of timekeeper_lock.
>
> As this is touching all lock sites, convert them to use:
>
>   guard(raw_spinlock_irqsave)(&tk_core.lock);
>
> instead of lock/unlock functions whenever possible.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

