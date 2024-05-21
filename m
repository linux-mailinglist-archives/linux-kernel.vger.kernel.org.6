Return-Path: <linux-kernel+bounces-184612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822858CA995
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0E51F22021
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F354277;
	Tue, 21 May 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMXUX7R6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3B482DA
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278682; cv=none; b=L+m7hkmlcsZu4DVTf17HcCZqlqA7USfgmJDy4Myoux6uewCs3fbFvKh03wj/T2WaIgc2IfIByyP7wgYxb8MViU92GbB5rbJ/viW3nj9m3FZFzZNoiRcInWCD0PFiQW5ujegYXfhMNFoHwd97tN+FP8FGxE9xHuGsvzDBxLQaxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278682; c=relaxed/simple;
	bh=H1pX/l/9zFJBqeC65WLx5xVkJ5/5BEYFzpClMZLFUWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCXE2lzU6LJZIY8lY4n/Q986V/CxJ8K8LDzUZS19yWKqq0MsJYQl5RHJscmbohH/jEkg9XURlMIaNM4R84DI/yvvhk6Te0BLUH+IKgZKr4hoLuQNy3//4y8zxaHgCCeYXFgN8xrgOinykgZu0GjG7V7ANmGTlCuedXLlQjfRhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMXUX7R6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b58fe083so576263466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716278678; x=1716883478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8zfwXAqu2uLm4XXNzPsYjNVm1x+e8a1p9Cw49ZRtk0=;
        b=VMXUX7R6VP485JSuJUXNjJnN2RNrZCkXIUp69JKAmC2CjCIKXba1LS+EEFFGU3dU0p
         on8P1XDa9vRgTHYwtR/4AtzaH7/u04BtpjCtzZPpFFtEKutxwBn1y1M8AmE/wZ5qE5p/
         pQtc09yjbDUA1Nqozmb4VPKeWR3ub8vo2P6ddITeMmsEfZjnyS0tQOWrhCEzXxfmxb9U
         /RYBJNyvrv6UqQmT8rfUJBc9jueMFgmOkZP5ZgOTZVML3HwifRlG8bBRUKiqM/04DirF
         zP5PdZFaHbmFVsO4dPYF2V+T+QtB4C18b7j7av7BPS337sQaDjLotnWdK4A3YXsvhgWz
         oQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716278678; x=1716883478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8zfwXAqu2uLm4XXNzPsYjNVm1x+e8a1p9Cw49ZRtk0=;
        b=m8CjtBS/UF1FQd52SeI7CZNSt5p0GwZ/HtQVPGhXNL6vpzJBOdZ1ox+6PZQFWC1KZ/
         wm67c//0cnxTRPF3BTVhOXtT6/k20WHDAGl76j1AP5a7zMnx+whowMZFVygm2eURyPz5
         0tySj/BAagdPNnWVdihhki53auyxc+c7wWA2KL6VBFtUbRTo+0g6uS6nxTnKv/8qT8Ow
         JksXNoAjZgAApgaTnwiJz3qdNPf/ahE0i4d9tDTWax9MtMtkP8X1JJADg/W7yVOyn88V
         pV1Tehj2SgCuo6PXdVAfNa9t9s9IrB2+JIoSN2tmnSzg5nJzmtWSAWCpYM8j0ltnfi9k
         s2BA==
X-Forwarded-Encrypted: i=1; AJvYcCViZUzA3IOWM0vggVk/t3fdonghAschgTRot98UbNC196VF1buCU3ZF1ygzbIN5Wb5ptWreMmNOpJNRVaEnTkiHVnL7JmCq+yC1A+7Z
X-Gm-Message-State: AOJu0YyYl+CWAW5c+eczZaccsVKfs+EGr73lInIzjakyGKJutKMCZGmt
	YwXU0E3ME64IkDWGUyHn2npQKvVjOZXcNReFutDQlByi0oHgVRETV61w8r3kjaE=
X-Google-Smtp-Source: AGHT+IEwSwaoGXszRy/vlwCN9/gMLqSB6q4698CsQ2KEnbnUuauXnQjOqMjiZnb5tAm0Wcz3tAFUHA==
X-Received: by 2002:a17:906:3184:b0:a5a:1579:9033 with SMTP id a640c23a62f3a-a5a2d53abacmr1834565866b.1.1716278678198;
        Tue, 21 May 2024 01:04:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ce048529asm708154266b.222.2024.05.21.01.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:04:37 -0700 (PDT)
Date: Tue, 21 May 2024 10:04:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: zhang warden <zhangwarden@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: introduce klp_func called interface
Message-ID: <ZkxVlIPj9VZ9NJC4@pathway.suse.cz>
References: <20240520005826.17281-1-zhangwarden@gmail.com>
 <alpine.LSU.2.21.2405200845130.11413@pobox.suse.cz>
 <BBD2A553-6D44-4CD5-94DD-D8B2D5536F94@gmail.com>
 <alpine.LSU.2.21.2405210823590.4805@pobox.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.2405210823590.4805@pobox.suse.cz>

On Tue 2024-05-21 08:34:46, Miroslav Benes wrote:
> Hello,
> 
> On Mon, 20 May 2024, zhang warden wrote:
> 
> > 
> > 
> > > On May 20, 2024, at 14:46, Miroslav Benes <mbenes@suse.cz> wrote:
> > > 
> > > Hi,
> > > 
> > > On Mon, 20 May 2024, Wardenjohn wrote:
> > > 
> > >> Livepatch module usually used to modify kernel functions.
> > >> If the patched function have bug, it may cause serious result
> > >> such as kernel crash.
> > >> 
> > >> This is a kobject attribute of klp_func. Sysfs interface named
> > >> "called" is introduced to livepatch which will be set as true
> > >> if the patched function is called.
> > >> 
> > >> /sys/kernel/livepatch/<patch>/<object>/<function,sympos>/called
> > >> 
> > >> This value "called" is quite necessary for kernel stability
> > >> assurance for livepatching module of a running system.
> > >> Testing process is important before a livepatch module apply to
> > >> a production system. With this interface, testing process can
> > >> easily find out which function is successfully called.
> > >> Any testing process can make sure they have successfully cover
> > >> all the patched function that changed with the help of this interface.
> > > 
> > > Even easier is to use the existing tracing infrastructure in the kernel 
> > > (ftrace for example) to track the new function. You can obtain much more 
> > > information with that than the new attribute provides.
> > > 
> > > Regards,
> > > Miroslav
> > Hi Miroslav
> > 
> > First, in most cases, testing process is should be automated, which make 
> > using existing tracing infrastructure inconvenient.
> 
> could you elaborate, please? We use ftrace exactly for this purpose and 
> our testing process is also more or less automated.
> 
> > Second, livepatch is 
> > already use ftrace for functional replacement, I don’t think it is a 
> > good choice of using kernel tracing tool to trace a patched function.
> 
> Why?
> 
> > At last, this attribute can be thought of as a state of a livepatch 
> > function. It is a state, like the "patched" "transition" state of a 
> > klp_patch.  Adding this state will not break the state consistency of 
> > livepatch.
> 
> Yes, but the information you get is limited compared to what is available 
> now. You would obtain the information that a patched function was called 
> but ftrace could also give you the context and more.

Another motivation to use ftrace for testing is that it does not
affect the performance in production.

We should keep klp_ftrace_handler() as fast as possible so that we
could livepatch also performance sensitive functions.

Best Regards,
Petr

