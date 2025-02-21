Return-Path: <linux-kernel+bounces-525208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B16A3EC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF303188B23A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E61EEA59;
	Fri, 21 Feb 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP2QvTkz"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD11F758F;
	Fri, 21 Feb 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117564; cv=none; b=qnvGJBooNAjoPKbqRAw+lxmUF3jHp8GiKEqyWkpDcZPNuHB7I7f7F/TdbxMqRowrHVwygAyBsn2k/i+qRfgW1tqYUOJzirTTOayfnYRKsy6Rahzj6a/iS9sLuQdB+j1j9urbKkbYSfiFe7q8XZfGMvAe7G6Mwco0UUb5x4zvlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117564; c=relaxed/simple;
	bh=ibHzWRvBjhxfOa5MDrD8eYfboMb902KHcCF3VtsllUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjp9OY6t9MYQy8RSgFB1G7h+P6AAGr+xb3Xe/NWU+wufbxXWQLBE82k4HUMg02crvrCvSJ1J4qmtdmrxbUnZQjTc3uouZtF4P/DjR1c/raIf/ks1Ppg81KI3lq3hfvYcI8LdAePDtTCFsxiFwI979zTxjefqW5GnDfSHhFiFhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP2QvTkz; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-520847ad493so1052870e0c.1;
        Thu, 20 Feb 2025 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117562; x=1740722362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwyvrx/Jezq/07hjLkAb8nbo563bqDJpeescdjeTq+k=;
        b=JP2QvTkzx4+HyfkJmdgLCPUMovyM5bqAFrlhCGDtrLRWS7YfZiTpEMFi6yQ3yZTmSq
         +cYTC4JVI2I1oCLymzP6jyWWnlWowXXhu38eDSWfTsAzSquTk1SXa3JxDEopqZbpH5TB
         gArdiSY0waVv7rqd55G0z4wx9dprsZ8vzPit/BWHXIjsoYmW0HBE/bw8453QcXIbAqU/
         vgBpevfbZL8du4rFw7QW8z7HMy+V6WTD/es2itM1RsBP8MHGD9eUooEcDUT4bQy/xOUF
         WBCbekmjTHvnla/n0V/8TiHYzLhIDplMU0NppNem3/B5vjZIhjR9WycqghdrfNRsfno3
         JKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117562; x=1740722362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gwyvrx/Jezq/07hjLkAb8nbo563bqDJpeescdjeTq+k=;
        b=D02IBSMMeTGsaz3MieObNSAB/hm0FIuaiKCKEeEQ02tM8THKCBRVMZOnjSFaVlm5b0
         vxae1Fxw8dW5XojGhi/XsSa/RHjE1UhkgyS54r123zwU6QPAUaqux1ZxZwZkfWhhIgm4
         bbrnMXKcN2t2tJ3iUJ5tEjcTwml5HiXAf8Ay0jOsdzCxYR0M1QyFnJVgs7H5FcHm/2+p
         M9yr3WUp/iF55XlJyXhS/uu+0s9/x4ZNVFvqXCK99wSrYeRWbaLHGJriDoXx7J9+jqn5
         J37Y74f3LUzr0DaE1FVm6Yrb80cLx/EUtGF7hS8qX8I401d5n9NLjIDZHe/cbkZokd+f
         qw5w==
X-Forwarded-Encrypted: i=1; AJvYcCVGF9WIlT3xa6X1WLRZ/m7hB4OdmmlCXes/lsj3jIUMwjDmSyW66V/as4etZecvt7L+M6UMkManT8wdAjXhcO4=@vger.kernel.org, AJvYcCXNxVGRgES+wrXcPojGFdRLSyHXVQ8thnVq7sRMdIuR3FcqgmyJqw2LwxOvxR2+Q2doGk2ujS35p9kkhgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTnkMkprCSDPNoYx934i9cLncxmEvpfHC3cuxAz2pcaI15wAT
	xHtBM4a6enRfJys6Gsgi6LFgLR6DNcYXnQJCs+Y9X6sJv5q2R+cwP4ZzvahviUYenniDt7VTtCL
	wrJjGlkDFFwHSIHGPsChfHl2vGOw=
X-Gm-Gg: ASbGnctcWa3+KLouFbua9r7zVIzeHKkn6SmBMwqCYuGthsAhaQv3dBCXkSChVMk4pv7
	X/or3xo4qG/qVGUhxJ1E2mdyqr8m3RZcgZUaWg062x3I/6TbRjUoN3PAC2+1K6zL/1uwBsTbSoh
	kyuwNGpGcg2pKjFdqQAJlFADTfjdB/lcq75VUspTFW
X-Google-Smtp-Source: AGHT+IFK0Te2gAAu9/ippDJ8IfNRI2f4AiOjMhPMlVJgO17ZMIkw5wXZbxAhshYN4Tkjwgte5xFD1iXsknqV9tsPGRY=
X-Received: by 2002:a05:6122:3d03:b0:51f:3fa3:d9af with SMTP id
 71dfb90a1353d-521efb1aa44mr620312e0c.1.1740117561686; Thu, 20 Feb 2025
 21:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021954-flaccid-pucker-f7d9@gregkh> <20250221051909.37478-1-felipe.contreras@gmail.com>
 <Z7gQ3kSeCf7gY1i9@Mac.home>
In-Reply-To: <Z7gQ3kSeCf7gY1i9@Mac.home>
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Thu, 20 Feb 2025 23:59:10 -0600
X-Gm-Features: AWEUYZm-dCCYDK7IVFbcHBzJ3z4WArMhXwpI8ggrnPh3sijx9AIfdIEQ8lnlDjM
Message-ID: <CAMP44s1Ai5qMU4yV+Rwz4cY869ZA=cxBcTf2wuaUY1oyLKUNCg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, airlied@gmail.com, hch@infradead.org, 
	hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

Boqun Feng wrote:
>
> On Thu, Feb 20, 2025 at 11:19:09PM -0600, Felipe Contreras wrote:
> > Greg KH wrote:
> > > But for new code / drivers, writing them in rust where these types of
> > > bugs just can't happen (or happen much much less) is a win for all of
> > > us, why wouldn't we do this?
> >
> > *If* they can be written in Rust in the first place. You are skipping that
> > very important precondition.
>
> Hmm.. there are multiple old/new drivers (not a complete list) already
> in Rust:

That is a black swan fallacy. Just because you've seen 4 white swans
that doesn't mean all swans are white.

> , so is there still a question that drivers can be written in Rust?

I didn't say no driver can be written Rust, I questioned whether *all*
drivers can be written in Rust.

People are operating under that assumption, but it isn't necessarily true.

-- 
Felipe Contreras

