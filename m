Return-Path: <linux-kernel+bounces-535251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36028A47096
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93F0188A130
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683542744E;
	Thu, 27 Feb 2025 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N4VXNFQF"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126611CA0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617977; cv=none; b=W0RiVsEMomURiIpXdZ9SA+zAC+VHcKVe4y4BULpr9KGqmLgAjE3Xm9sfAHvmUAwD9CRuqF2LuX+vRKa4PsTdhHW+t8/My4AGcA5SOVqr2bpfr7h9b/qG1Sb2R2tTAcL+MOcF90oEg6ke0/3NSUbFCqE+BovDwNC74p3DQWlGcFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617977; c=relaxed/simple;
	bh=VWd9OgxbVmHO2LgjU8IkRr7q+KjdKSPr5STc5HGGnOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNODyIMp1IdwdAJ0YSFSyLe4yEqGVQ4lkqbpXVb9bS4mrDQIeR3NPWI6j9gbRYhcvmg/0CFIhKp+HWoTpDeC4eACVhEZZTlIHcLo5AN1mc0DxzRbbTNFKVenjwvXoBdMBkzvUV7PWrFWhz7VoW0aBIPM+DVoEcDQQ4Tj6VOyUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N4VXNFQF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1D613F5E4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740617967;
	bh=0LOhFdSVk3SkZYJT02ocnx1UrDgNMytfb4SRqiZfmbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=N4VXNFQF8qjFbt0BEEXBZuc3ZbtZPr4u/x+RVeWyNDwSYzztuTYYz5Zo42WqLaF5s
	 zgQFkLHHXyzsReRwccCYn/ld+BuL6s1zfDeNPQCbdvFcDywl69XNEkGo9XCOOTnYDX
	 q11XF97WEByZtqXJJSkHFUaEUG234Dr6VPZC9TZ+u9u5O4LCJ/WOY+Iqfvkq/gjXi7
	 xNxszblXLe/73+bg4kJl5K+mhZF9YeA5EELdpsPGWh/SMMFdXl6OPB6OCrX1MoeT54
	 pz8qZqiTJaDLJevxELg8ZmQyQxA2vNIjbHbN5nda75uLUgcZP2ZjWfaUIaANo1w1LF
	 0irvxRjpETf3w==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fe98fad333so909535a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617966; x=1741222766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LOhFdSVk3SkZYJT02ocnx1UrDgNMytfb4SRqiZfmbo=;
        b=Y2eJoIEgEDqT2aH6Y98SLLmKaagWzRLNAJzX2n9SVHrsLD8xWuywLwxu2xlhfkK7mV
         v1m8wRPAkSoMdEs1LMVhtPEYsUozgTe4Ljoei0pbM/47Uxl89ll1EripP+y7IkILvHqr
         KKQBxFYqRusPjhNFMfsysHSRuc4fvK5/09bUL3wpO9TYJtJ4j/Z7DS/p3rvHSKfHpvIV
         TdEiYaGi2VFwkT0QnwWmSa6pOmAauQfvXQnLh5j50uGkQ22PDM32YUWhk5mGaTiJzASw
         0FN43FKHOo74WOCThVIIpi1x9qHWcEMlqt91nNWRHpA2TD2TvGQRlaqzmAsnrQdvZ+D6
         UheQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCegGDY9Ex7AJsh5l+NMyzU1tDnZlaUFGMCGvIAHweb84VcAcqq1nnL+vIcos1EuJ1u3qt1UsPVJ2xjEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRG4USOoJx76fzwnOr1s5zXmF4D8YImg0AV50xHIqOUwGErHB
	xyMdaapItmlG6NH3wLTjs19zmL9fDi4OQq01m58TcaNFybmdupT3odzLfVWT+GGxmW6V5psbkdH
	9uOw00CQJOLIQ+0HpjOrz1e/8zZc5FktbEXZRdIB2OgI36n8TKNnT9izIHjiCsxFKTCBUUaP/qf
	airg==
X-Gm-Gg: ASbGncuMg4VhBjOt/0snLY1OytXfJDCs2zrtCXEi830t5RdgXnPwrOI591AAQNcsHob
	izGWF3+mxit64u5mgun+7sNe7LZxMb3s5dKrXX6P26nrLesuAX7UPL5r9n+pL7lY8LPO9FB7z4R
	N87IZHDUaHpvaur6LSZSSMDM++6h733LqF8HyTGydR1gKkSlCQQAH6iBEjb1UT48frsqcjI8Afz
	BoixrhzKCKCibcKYKEJsqtD5Q/aayK5ODZeg9QTe+lY6B2FDBVjtA/3DSAWLm3A1lmZc7bQYkNX
	IEj+niTCRPdwx2Crkw==
X-Received: by 2002:a17:90b:4c04:b0:2fa:20f4:d27f with SMTP id 98e67ed59e1d1-2fce7b23bb5mr32362797a91.32.1740617966292;
        Wed, 26 Feb 2025 16:59:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEuWbCc1wnTNcOGj5Z5zq4WyfUzbGIdrseZjoLa4OTdGu45CMbjCZWGK/P21V7Vl6ks8gNFQ==
X-Received: by 2002:a17:90b:4c04:b0:2fa:20f4:d27f with SMTP id 98e67ed59e1d1-2fce7b23bb5mr32362780a91.32.1740617965940;
        Wed, 26 Feb 2025 16:59:25 -0800 (PST)
Received: from localhost ([240f:74:7be:1:cdfe:cd19:bffa:178c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6dec47a3sm1734477a91.2.2025.02.26.16.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:59:25 -0800 (PST)
Date: Thu, 27 Feb 2025 09:59:23 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Etienne Buira <etienne.buira@free.fr>, Andrew Ballance <andrewjballance@gmail.com>, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] scripts/gdb/symbols: follow up on refactoring for const
 struct bin_attribute
Message-ID: <5vhttz23b4v4fs57fv5o7e74bn2uewrmy6jdgeenwztwufjo5b@o72abjlumepw>
References: <20250112122149.9939-1-koichiro.den@canonical.com>
 <20250213043806.GA2552411-mkhalfella@purestorage.com>
 <20250227001759.GA351718-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227001759.GA351718-mkhalfella@purestorage.com>

On Wed, Feb 26, 2025 at 04:17:59PM GMT, Mohamed Khalfella wrote:
> On 2025-02-12 20:38:06 -0800, Mohamed Khalfella wrote:
> > On 2025-01-12 21:21:49 +0900, Koichiro Den wrote:
> > > The work for 'const struct bin_attribute' [1] was merged into linux-next
> > > but did not include updates to the lx-symbols code. So it now fails with
> > > the following error:
> > > Python Exception <class 'gdb.error'>: There is no member named nsections.
> > > Error occurred in Python: There is no member named nsections.
> > > 
> > > Restore its functionality by aligning it with those changes on
> > > kernel/module/sysfs.c.
> > > 
> > > [1] https://lore.kernel.org/all/20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net/
> > > 
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > ---
> > >  scripts/gdb/linux/symbols.py | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > > index f6c1b063775a..8efefd30df49 100644
> > > --- a/scripts/gdb/linux/symbols.py
> > > +++ b/scripts/gdb/linux/symbols.py
> > > @@ -89,16 +89,26 @@ lx-symbols command."""
> > >                  return name
> > >          return None
> > >  
> > > +    def _iter_bin_attrs(self, bin_attrs):
> > > +        while True:
> > > +            try:
> > > +                bin_attr = bin_attrs.dereference()
> > > +            except gdb.MemoryError:
> > 
> > This should not result in an exception. The array should at least have
> > one element on it, that is the NULL terminator.
> > 
> > > +                break
> > > +            if bin_attr == 0:
> > > +                break
> > > +            yield bin_attr
> > > +            bin_attrs += 1
> > > +
> > >      def _section_arguments(self, module, module_addr):
> > >          try:
> > >              sect_attrs = module['sect_attrs'].dereference()
> > >          except gdb.error:
> > >              return str(module_addr)
> > >  
> > > -        attrs = sect_attrs['attrs']
> > >          section_name_to_address = {
> > > -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> > > -            for n in range(int(sect_attrs['nsections']))}
> > > +            bin_attr['attr']['name'].string(): bin_attr['private']
> > > +            for bin_attr in self._iter_bin_attrs(sect_attrs['grp']['bin_attrs'])}
> > >  
> > >          textaddr = section_name_to_address.get(".text", module_addr)
> > >          args = []
> > > -- 
> > > 2.45.2
> > > 
> > 
> > Hello Koichiro,
> > 
> > I hit the same problem came up with similar fix below. Of course I am
> > biased and I think my change is more concise. Feel free to take from it.
> > Looks like many commits changed this code and any of them would break
> > python code. Can you please add Fixes tag at least to the top commit.
> > 
> > 34f5ec0f8252 ("module: sysfs: Drop 'struct module_sect_attr'")
> > 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
> > d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
> > 
> > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > index f6c1b063775a..e4865ec5aebe 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -95,10 +95,15 @@ lx-symbols command."""
> >          except gdb.error:
> >              return str(module_addr)
> > 
> > -        attrs = sect_attrs['attrs']
> > -        section_name_to_address = {
> > -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> > -            for n in range(int(sect_attrs['nsections']))}
> > +        section_name_to_address = {}
> > +        gattr = sect_attrs['grp']['bin_attrs']
> > +        battr = gattr.dereference()
> > +        while battr:
> > +            sec_name = battr['attr']['name'].string()
> > +            sec_addr = battr['private']
> > +            section_name_to_address[sec_name] = sec_addr
> > +            gattr = gattr + 1
> > +            battr = gattr.dereference()
> > 
> >          textaddr = section_name_to_address.get(".text", module_addr)
> >          args = []
> 
> ping
> 

Sorry for the delayed response.
I have no objections. Please go ahead and submit your patch. There is no
need to mention this original submission, nor CC me.

Thanks!

