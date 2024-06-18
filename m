Return-Path: <linux-kernel+bounces-219501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C590D37F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47FD1C25345
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB24E158D7B;
	Tue, 18 Jun 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoNaCQ7G"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACA13C673
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718284; cv=none; b=n33qV8wnBOos4lZtymUT+1Vw0fqHBV4z/nHZAiBJuO1BcfJZzsiPs+u0MyiEHcTEqCjt7msYNM045kGcY9ZzP/a0qDcDDK0hlt4EFlsJleWyD4s/BIK3P+RKXu6wFyhup20CdCjwSUCKqG66RYmjM6rOZl+DxUQqAcXKnmAYjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718284; c=relaxed/simple;
	bh=ucoJYhoxF3OeIUrNTD5OVc9wJ2+UwD/QG8mQFRwwwDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QeeeT8PaeY2P3MSDHkn+LuYJ9bw6014fk2Np5M4NvaFMbhbZhOgL9PjCegjS6x2zpMcwDhbtV3kJ/TbStfcmu+DnCqpSB0K1WesJwdU4Qfa1mDgkFp4Uk9o/kQJolghi7Aw6bXXcYpeaC0DA2fHGBYE3IDLZVb9g6EbVOi2ZEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoNaCQ7G; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f9fc2cbf6so115091197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718718281; x=1719323081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIYhMIotUty+XQ9bziyo1SmPKA7CkPdKzruWtPxrXM=;
        b=qoNaCQ7Gi144Jb1RXnltAkOFcjFQnWIn1WHGnFN6ojwZ3HG46jE+3A4S2cyQpTzF2u
         BCa+/XK+G4TvEDU/86UXxZMRqwsg+By7bzDhP72VG4JjUHZ75CCuHcjYKLE6IEy4y5f1
         Alt5qiIr7nbKebxL9rdmNGcUUj4cOG9ATPefNgY6L9ROSOJVmpgDIhwkNnf3y6jiE1GW
         Q8xFrDUWkx1CPwzTTTDLkBqbiQMCpVE6MJR7HHW5veA3x/m+d0PS3+pMBz8p78g0/1nF
         DDY7whZ8YxGoc/lPDFmrQuPx1S7VeYx8GdWm/+/kk1RftiOc7b7rNmP8qKSyFyOo4oYP
         aleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718281; x=1719323081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIYhMIotUty+XQ9bziyo1SmPKA7CkPdKzruWtPxrXM=;
        b=s2MU10pGtKAzMfawZhKWqFg/1qBuOaVu3DM7+7mnbTyfj77aWmZ8M90EV9m9bCHQ+A
         uUtcSjBzamB0wYJc6B7ieGxSLAp9lbzJ9P+852LF7AZv6y364GgsXbHZJ+Q31Q3EO1bh
         fufOyNLM2LLJZn374SvlUXADnH+Z3dDcOBfiK3WJ3Z4613HjioyCwRo/XF1giL+0JKng
         hfHlu0kn4r+YVkcYwA6bgSC5zvsg4ZnlNJKY5q2bahtKGbxOB33jRoleB6n5ulc/swlf
         Ue829+Kbipft+WgR4nHQwEvZE1+63yqgxh2iC6OMLFvetthqUGbzXPwqO5CARyliBAaa
         joUA==
X-Forwarded-Encrypted: i=1; AJvYcCWIglvn5i+xOZRbTvMu+nM3HpNivJCmXo2DV5TABioLfAv85+KaOqYQx+MVeLWwHKQDr+2JfMebCSAQYopdcuZAROHkqfeZ9gp3VehN
X-Gm-Message-State: AOJu0YwNWThQoIOgZMt/a6ODqfDXiiaN74fSm2yDLAIuWDw4tbL4oQxH
	j2oruNAyW48mOnWBHx4bdxRMpyckgSL6ijHS0V/QRkB2tt1xfSlTv9Vz9yCYedFRcd/9IqjDKpq
	dZA==
X-Google-Smtp-Source: AGHT+IEnC2RZHpd6Y9tdhSA2DQFR1PTXG4Zn4Jr9j7XgXE4mUhJjCsEw3I9TdBvA0MYws19u54WEIg0A0M8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b0f:b0:dda:c57c:b69b with SMTP id
 3f1490d57ef6-dff150de181mr4007095276.0.1718718281572; Tue, 18 Jun 2024
 06:44:41 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:44:40 -0700
In-Reply-To: <20240618102434.GDZnFgYsJHTGibyuX1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617210432.1642542-1-seanjc@google.com> <20240617210432.1642542-4-seanjc@google.com>
 <20240618102434.GDZnFgYsJHTGibyuX1@fat_crate.local>
Message-ID: <ZnGPSEB9GOclr9yO@google.com>
Subject: Re: [PATCH 3/3] KVM: SVM: Use compound literal in lieu of
 __maybe_unused rdmsr() param
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 18, 2024, Borislav Petkov wrote:
> > +		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, (u32){0});
> >  
> >  	return 0;
> >  }
> > -- 
> 
> Right, slick, but I'd argue that before it was better because __maybe_unused was
> actually documenting why that var is there.
> 
> (u32){} looks a bit more cryptic but meh, ok, I guess.

Yeah, I'm 50/50 on whether it's too clever.  I'm totally fine keeping msr_hi,
what I really want to do is rewrite the rdmsr() macros to return values :-/

