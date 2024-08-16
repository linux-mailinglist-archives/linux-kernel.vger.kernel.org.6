Return-Path: <linux-kernel+bounces-289742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B0954B42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C55FB238EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9D1BBBF4;
	Fri, 16 Aug 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fJ1OBWOO"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F41BBBC4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815771; cv=none; b=F8bitRBdi9Opx6fkt+zrRp/mNDmq9abjU50sMZQjQ8yzVZgQZLX5PoS6Gd7Fkne/IFGxm4wrdHfK/h/iA1SjYad13UCAN84FsP2Y06KsDrsBZquIu2W7XbcDtO9IGFyjhc3mI5SFDe6J3E6Pe/Ai51lM/as159CSca/S6OKGJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815771; c=relaxed/simple;
	bh=vw2ZCwtyOPdQeIflLimMaEJlMbp8BH5R4xTrwPwX5fA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LK7p6rI8A+2HKwbWzknoHQ3eouVWFI+OfOTEFHsH785Xv6vfugoqDk+vxVl93KuyNl7bgztIGPGaISSG1vcz9KjA+1MgMowwQFy7a1/2aJwKsOirhEsYcz05KWK/OGXBlwD47pcHNHGhWv8dxoNso17iBU/Lpba2lYMc7jSJ5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fJ1OBWOO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37193ef72a4so517526f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723815767; x=1724420567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLCF5LuBRNid1ph8VpWew5JdUYU2SKcQIpoYivOki1Q=;
        b=fJ1OBWOOR2xTePYfUFdrdxIq4Nd1bY6uNt7B1adIWVkELpCDCkgewR7Qq/1Yx24ZhM
         Yw+V9EfGQQOGD6FgeMvo5zAJTQpbDF/UL3B+ky5TE2jUlcfnTaLl+fs4kTyadpdcem7Q
         bPZUOCMSea5L2nltl3hVO4Reqc9UL/f/MYTnenw4ST00oDi4OhubK7LotSi0wLFHgsVx
         Rski/Q22QGWCnpHx34N+PKe8nST1kETdDii2KXNmaG/SA0uldXMUIcP37/IzNZoEYBH5
         s5MhDzkmK/yhLGq/a+KT9w8Nma/6HB4TENFAjH342aplcYZMfZJa+OOtmOUSGqz/zWV6
         yIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815767; x=1724420567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLCF5LuBRNid1ph8VpWew5JdUYU2SKcQIpoYivOki1Q=;
        b=FCo5NaW4NL/Ogxi9o32GfMTETuvMs/htWRseCTtkPMYu3+UKtCsOBh+RE8LlbtN4Iz
         lbPxfcV93nd721D9lypCAAruhIURzP79tsL4ZfnQeSviGGq/RruR4mQyfr0fB+9rb2ef
         3+RulFT4myCFVX0T6RvG+sgeAnxAWya4Z9CKFH0hFOG4W/UNckwjCZJ2B8AzmCybbz+u
         NucmKymqs0P8q1v84PTvyOM2vHLtIkogpVVvO1Z+jnXVYApHjmMd27FdKyweMgVUOYDd
         hXKlJEUiz1rjOgTQw/Hl45EyISH3A8iymgZGXlxrO8DH6qq4osEHiSbqOcEp5D9Ftrn4
         v1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWSTFoytXjLNUzOB9XnG444aDfBBHhPRuL+B3SlAqRtaGmdvn8+CyOl8N2yKLbj6rFPIst7bFj25O+9NJvwUAQi1jmpfofEboRXp5q3
X-Gm-Message-State: AOJu0YwEfR+4h6aVqYEti73reWUq1JYqLXZ5R6Z7cINbl9jEyFp18H+G
	65+VKtcJ6WPCiqihC16ikqt3YqSVULBLHrXavfCnvRwcSwG4a6LjfOJaXE+SykU=
X-Google-Smtp-Source: AGHT+IFNVKnwuIUOPuv3ZrPl1FG+tWKvn6OKTQc52FrxiDlLaNduFSc/ZMM2EMM9M2yXsi6HZ20zpw==
X-Received: by 2002:adf:b347:0:b0:368:3b21:6643 with SMTP id ffacd0b85a97d-371946a1372mr2097767f8f.48.1723815766880;
        Fri, 16 Aug 2024 06:42:46 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm3665507f8f.38.2024.08.16.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:42:46 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:42:44 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric DeVolder <eric_devolder@yahoo.com>,
 kexec@lists.infradead.org (open list:KEXEC), linux-kernel@vger.kernel.org
 (open list), stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240816154244.0c6271a6@mordecai.tesarici.cz>
In-Reply-To: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
	<871q2oy6eb.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 07:54:52 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Petr Tesarik <petr.tesarik@suse.com> writes:
> 
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> >
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.  
> 
> I would rather make CONFIG_CRASH_HOTPLUG depend on broken.
> 
> The hash is supposed to include everything we depend upon so when
> a borken machine corrupts something we can detect that corruption
> and not attempt to take a crash dump.
> 
> The elfcorehdr is definitely something that needs to be part of the
> hash.
> 
> So please go back to the drawing board and find a way to include the
> program header in the hash even with CONFIG_CRASH_HOTPLUG.

I'm not trying to argue with your opinion, but it seems you're
complaining to the wrong person. My present patch merely fixes an
obvious trivial mistake in commit f7cc804a9fd4 ("kexec: exclude
elfcorehdr from the segment digest") to exclude _only_ the elfcorehdr
segment from the hash (which was intended) and not any _other_ segments
(which was not intended but is what currently happens).

If you want to change the direction of kexec hotplug support, feel free
to revert commit f7cc804a9fd4 instead. That would also fix the bug and
make me happy.

Petr T

> Eric
> 
> 
> > Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> > Cc: stable@kernel.org
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  kernel/kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..3eedb8c226ad 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  
> >  #ifdef CONFIG_CRASH_HOTPLUG
> >  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> > -		if (j == image->elfcorehdr_index)
> > +		if (i == image->elfcorehdr_index)
> >  			continue;
> >  #endif  


