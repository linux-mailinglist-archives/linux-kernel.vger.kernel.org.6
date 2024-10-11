Return-Path: <linux-kernel+bounces-360757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7C999F23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71051B21F47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4B20C469;
	Fri, 11 Oct 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nc9IbjEY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33320B21C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635779; cv=none; b=rjZMcZi6vMmGhJ+s6AQwPEnpoGhmWrKMYeE/I7/GnyIbtN991K5GE2SiCoePGOkk8isYa3HU0ezkT/QhWTYChXZVHov0E1kB/LeEs/Vh6XXD82lT6hSJWTKr3IZNBz77aXN+GqLk0rKD2AtPk0upKl8SSUW/SkXOdieXrJe7lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635779; c=relaxed/simple;
	bh=aBiqM8PVcm5Z7jP1wZPQDoMh/uEmbH4eGzzLry+D1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAxuH0u5JEWYRjPKfh9po423aZsUvIHtK+Ux5ocKEY3AyHs1uUv0LIzMRgUbjL6v1Bau+i6gbMQ+gpXKs2HrEYpLy9pK4waYzn3zQIfBnQrkvdoA/bYSIIsGjPlhiLi3LKu6V8FEVjleYZXU42Gm077aW72uXE6zFfU2AFZE5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nc9IbjEY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9951fba3b4so279385966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728635776; x=1729240576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOgl3CHUa2RGJfMMF6MlgKXjPoHKnNyo6jxvFHKTMkw=;
        b=Nc9IbjEY/VwUuoJTSFKxn5pfj5/+yY0/o8jAPC2t/hpDIRSkibFew4tVgsuH82gZnI
         fOFm6iARwph93eWymY9jpFFia9GAusuYTZgzE8DnMTye+M/hyMnntEfzkdL08NNquIHD
         wmgJwId5jcJSDrOonFPqR9ZgPAqjvQedG43iYYh4+FqnGYvJ5dqVbD4FzxWapoMEC+Yw
         AMCiftceONGfg09oTQgRp+k90vaJ6utX0L2Hx8NPzzg2Wp3b3OPHps/m/6RKoJnxnr69
         Llys8ABqYqoQAyBx7+g6zZ//SZgjIOw6sTCH33EGjiiPoeZPXslSJ+0rhG3oT+Nh+Rfr
         +mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635776; x=1729240576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOgl3CHUa2RGJfMMF6MlgKXjPoHKnNyo6jxvFHKTMkw=;
        b=bPpW06lbR0pjDcyjAAiqk75iFJu9vGp0bhG7scRi3itiVUnMAcclotuIAz/ohmKer+
         Ag47sRpNyy6zgd+av6W94HnmRLJMUOiALGlS09JPeBKEONGZLwhtDTepOWwKUFXkX5x+
         EZ0OBLOFwoUcpTWpeoPibUJ/FGcS4b3Cv/v2Bn4ANfGoAikVyE4F8FLkcpqGYd4/9M00
         unRxjfgKo9mwvO3tQUQH5tx/j9rqNZcK8Zy1Zg/iY/dkyxYKyArzHErgYKyeueN4/pwF
         BVfSTU3QP5bVZHcnXAm+ijrXQT+v6zGASmXBkzBcnJHOq6ktTVILdBBmZMpmKITvIPL8
         DBrw==
X-Forwarded-Encrypted: i=1; AJvYcCVUyD9juXxMgSkth+ShyeuSSLsPXl14tJxUF4Qr68UVAxpudcyaGK9KtKi62xYQ6h2MRtjYPMvnJCI/gi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlpfH6jlfYxlCzXnSvzvRlvoyzxwUIlu71W0kVCyBO8S5+kVR
	gfVR5JUDyaEfctfu8KDCTFlOEgjM868ZIT7jNiZ7+NwJtKQ8BzqrwqUKZ3gNi5Y=
X-Google-Smtp-Source: AGHT+IFvJuP7SdsgtDUHmIDRgUFlExBbIuZjhbpGZ+W7e+tlcgqMvjbNUp15ebPcuj+Ssox222eLnQ==
X-Received: by 2002:a17:907:7286:b0:a86:7ba9:b061 with SMTP id a640c23a62f3a-a99b975e6a0mr148209266b.64.1728635775968;
        Fri, 11 Oct 2024 01:36:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f24574sm185786766b.50.2024.10.11.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:36:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:36:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <Zwjjfpb0hSSE2Ap4@pathway.suse.cz>
References: <20241008075203.36235-1-zhangwarden@gmail.com>
 <20241008075203.36235-2-zhangwarden@gmail.com>
 <0d554ea7bd3f672d80a2566f9cbe15a151372c32.camel@suse.com>
 <A35F0A92-8901-470C-8CDF-85DE89D2597F@gmail.com>
 <20241010155116.cuata6eg3lb7usvd@treble.attlocal.net>
 <CDB9AA87-5034-40BB-891B-CC846D7EEBDA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDB9AA87-5034-40BB-891B-CC846D7EEBDA@gmail.com>

On Fri 2024-10-11 09:51:07, zhang warden wrote:
> 
> 
> > On Oct 10, 2024, at 23:51, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > 
> > Maybe add a replace=[true|false] module parameter.
> > 
> 
> How to do it? 
> Isn't the way we build modules using make?
> How to set this replace value?

You could find inspiration in
tools/testing/selftests/livepatch/test-livepatch.sh, see

load_lp $MOD_REPLACE replace=0

vs.

load_lp $MOD_REPLACE replace=1

You could more or less copy the "multiple livepatches" and
"atomic replace livepatch" self-tests. The new tests
would check the "stack_order" sysfs value instread of checking
whether /proc/cmdline and /proc/meminfo are livepatched.

Best Regards,
Petr

