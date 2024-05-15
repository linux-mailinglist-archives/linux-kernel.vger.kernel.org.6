Return-Path: <linux-kernel+bounces-179629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8A8C6286
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E18B22D60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AB4AEF7;
	Wed, 15 May 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfFjZgep"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080934A9B0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760459; cv=none; b=KtfvWcDFSapnD9vz8zDaGmQRD26ticeiXX6dXSHLMJrJADFzAd1eEH4ZaPxltkVDPZq1AtdP0VKCI4j5bSOntI9l8Rw+d/s7iKfrUe29Assz7adSHn9URWWed8VwgiR9BldBgA486yVjH0xKvCK2EsBOkvbrhgKA7vG1jkLjEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760459; c=relaxed/simple;
	bh=NP+7qI+yjVoD1wYi/GXnJFAcu7PPxRuSqdPwO8RWnXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfdfcXaZ84FPr8cflZysB48GWPQuTpiqsF+aoDm/RAlIUo85TfawhTcMgrADhb1OCosdvNlbgD92K+jC+D902LdzckrNYRTxJm4/AVWO5DsVfOJvwC4hbuH6zCSXgG4YC2tCHTDU7wxN3vTk6kj8PGlTgezPbNJufouKm8d2B4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfFjZgep; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso1213601a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715760456; x=1716365256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEXbGOflU70Wts3zIk9oHVkh8J2/DOOvMw7ztGmBJBs=;
        b=KfFjZgepybxs0ZzWtqcAbncfcNI4V26zSA3wFBjgTAGM8/vmlHj5vpnZg2DaKJfDNU
         URVmBya6HAbT+2xTP62YtIA64ILbgEsuT0oPHzvG0L5/c539TMTFXFWcsQaK+J4pU+DY
         oWTFbEJ7qx6KmQO6xrLDuKKE/pAK8M3cau66mMYcz0Ih2PejMasMbj2e1ssbeSoxQwtT
         INHg/wcPVbkBx6e1bn63KmkYyos1RabddzQfmJaAsZsLQp9Yg6WQrtzbgRFA34rkOsgr
         Ab/eoVCbmXrRE7Q1aztCH1dPcSKdv06tcYU5YeXWGtJums/KQwlykrB+yRxc67/OUJu8
         wMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715760456; x=1716365256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEXbGOflU70Wts3zIk9oHVkh8J2/DOOvMw7ztGmBJBs=;
        b=ZV/0RiQLGkZQcDLHPYfdIyGpouWFBpWCW3bAg2HGIOebJ1P6V41Z29X8TicO8KXrg2
         /vqOUDu/spePe+/wCttiRerOmcFmXqNBtkLumGT3f3uRC5pNISQ6B2xUaaXgiEqWytKM
         kndWu2xkUDH9Plt6VGZQDuz4kM3fa+3Wj1IqGagpAZAQ3tb6EQPInKe8p/cQVVaOj+Q0
         93Rzuq0H7HTgfZP78glWA5P2IWw3M6y39UltskT7S5ZbY6AUqOV0C5wKqfreONzjy7bC
         TvrVTcZMnj6QHiu0UCYJuqq6w6IjuVMmPJct/+58gS0tUam60ud1j3kG1uptUOHvhmG1
         sqKQ==
X-Gm-Message-State: AOJu0YxDZ3B/fGN+4uwFXvG8PEPFblByvI7B8+6rhjQacnleWFWLoYvJ
	w0wMBEYP+yog+AmaGTNTm3aJsq/RSz+7FuFcKLYjwYPpoI1Cm8PspOmVXosz
X-Google-Smtp-Source: AGHT+IGn2JlYo48+Jdu6qB+I+r2SJsjkzKektsVZa0ccQCifvMUyy+6YefGzkO5UZLBRSqvb3mhm3A==
X-Received: by 2002:a17:906:348a:b0:a59:ced4:25af with SMTP id a640c23a62f3a-a5a2d5ccfacmr939330866b.41.1715760456098;
        Wed, 15 May 2024 01:07:36 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fdasm819849166b.128.2024.05.15.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:07:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 15 May 2024 10:07:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/shstk change for v6.10
Message-ID: <ZkRtRcaqO+4jy3QW@gmail.com>
References: <ZkHLrqO1HdfQb71Z@gmail.com>
 <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAXOLja2AqBzPZE+k9DKX0wjBGKZT+m2DN_hariyA0Pw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 13 May 2024 at 01:13, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Enable shadow stacks for x32.
> >
> > While we normally don't do such feature-enabling on 32-bit
> > kernels anymore, this change is small, straightforward & tested on
> > upstream glibc.
> 
> Color me confused.
> 
>   "feature-enabling on 32-bit kernels"
> 
> This is not for 32-bit kernels, as far as I can tell. This is just the
> x32 user mode for x86-64 kernels.
> 
> Or am I missing something?

Brainfart: feature-enabling for 32-bit user-space ...

> I've pulled this, but does anybody actually use x32? I feel like it
> was a failed experiment. No?

Yeah, so H.J. Lu suggested that shadow-stacks are a natural extension of 
our security facilities on OSs where x32 is already enabled:

   https://lore.kernel.org/all/CAMe9rOo1ZONFgBkuN_Ni3REBRsedNwj3gNnXj1oxB0bQzuNipA@mail.gmail.com/

H.J: *which* are those OSs? I don't think any major Linux distro enables 
x32 anymore - here's Ubuntu and Fedora for example:

  kepler:~/tip> grep X32 /boot/config-6.5.0-35-generic 
  # CONFIG_X86_X32_ABI is not set


  kepler:~/s/fedora> grep X32 lib/modules/6.9.0-64.fc41.x86_64/config
  # CONFIG_X86_X32_ABI is not set

Another feedback was that the observed lack of x32 kernel regressions 
upstream could be because 'it just works':

   https://lore.kernel.org/all/CAMe9rOoEQ3jUUXy+Kai9Hg83b+79azmGfu8DBR=A3HSL05kj0A@mail.gmail.com/

.. so at this point I think we should be permissive towards well-tested 
patches, barring contrary evidence.

'Contrary evidence' would be for example some x32 regression that wasn't 
fixed for a long time while nobody cared, at which point we'd remove x32 
instead of fixing something that wasn't working for a long time. I'm not 
aware of such a regression yet, BYMMV.

Thanks,

	Ingo

