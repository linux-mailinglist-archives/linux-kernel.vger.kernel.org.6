Return-Path: <linux-kernel+bounces-535201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A83A47016
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EA2188163F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CF3D6A;
	Thu, 27 Feb 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LIacGOEi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F310F4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615484; cv=none; b=Bu1Ljr7oi8ctVa71B0bL9xdiGAEUmS3+IaxFY1kmGIvbGfmpI+mIBN/zbNPrsnLOXD/LbDnNe9mAiUiFTsnr7FoPuQBbminwbpJaWCNnvYtdBQBDIp8uwUH66NuMx4GJE2XbwiMGnLsV5SWRl47ahrQG9UA9zW12Xw8zXcuVnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615484; c=relaxed/simple;
	bh=idEuPUYJ3g29VmFrDTMh0Ov6kAkWBEn9nVOp30PY0HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZC/hI+NNmu6vt8F5pDYJ+Xs97sbeXIrgRX60Sqy5a5Jfoo+01kNr+E/d/8Ub6f/FGMncAQYMdBTasAgBG+mNBwiKe/Q4cQXY7xc3lauaaaXrGb9BPhJ3/eypIPXq+LbjJvldrjpKy+Fwpu8wVSevec66gVlva0t50La5MuP438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LIacGOEi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2211acda7f6so6624185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740615481; x=1741220281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNjETOwgQSPSdQks4Omr+Q3YqFENJSEvV3BrU7cYbXk=;
        b=LIacGOEiuNzm/sO7WsjsTNczU7OxeE0KpA37sKIxE9Mx2zbUpCjtJdtA5x0krX4gW6
         vWjMoswGx+pg3u2Bq8bk7Ddyk8IcsRVisTAJhxgTLNjWn6gBCDsN1/K1lvkpK37E0WsR
         Axhj3ECqMbZkMzqw7t9YdnyRq5xPsEbfj4qMU0qOcEMy5O+0UCrwGfCFxuOCuj4VU+Qg
         wL1EAOliR/4qNqva3XhkOl6fijMakEeVcxic9GhXuqnzuFFW2SMoBIMkgM+EfYu+a02f
         wlp5WuyhHdT+OtKst8pb7Xk30Hc1LQv4uQ6fYeBgCODcU8FKml/+mwa+TbzN3muUroLK
         10fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615481; x=1741220281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNjETOwgQSPSdQks4Omr+Q3YqFENJSEvV3BrU7cYbXk=;
        b=LEoQle1hf5NEfbaOVtvnkrRQQmbhRdX21zalvqM15zl2XVOgYTswDe42VrcZ5DuXSy
         hMHmS43QhikuVMoIAqCaDhZwgif5CfulgTJyFeYQ8cTKC5Rn49tPoVPH+jzxDI/bD3HT
         HE8Hh/IKW4eNMfG/8f7iMU0GY1nLvUyxG3W1fYO54J5F60Pr2Lxa5deAgKpXHaChegD1
         JC3QZo9ER4DCfpWsPh1ntyqLUCDg+2xRCK+sVaILGFrFTPKT90xL3jg5Mr+V1x6UbVQb
         1LMTtVViPDJzrV8DiMe6czjFZ2214yDh9o5oCrlKqMzNptXNTKfvvKl+8v7SYZvbcU6Q
         R6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXfLh5d0rtXbh2pNUW+pw7TndK789ILRgOkolE0IZzu9Ytm9fM/93rnrYZP/3PS9isoez4r5GG3sX+Rv5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTcNXkiopll5vTvKqEUvxkpK5n4vM6RbZq3UOz0YtIk3oHcdW
	OORo1pzOUl8KwsLCdBlqxCWuRNF+N3Q+p1R1gdg7op4dlVkvv7Kaf7y8ENxjPaM=
X-Gm-Gg: ASbGncvm+LsNnOc/IKs0MzBIHm7ypNn0TC8OYzeWSYhMUN96E+vTs2yHJvwUMHSok56
	XiyvRxdbK6zjnLHmpVbR+pcHaHSKk9c90FVJyTwAafEUVJjBJO8cFVcLMXg/XxEECiXkg794aTT
	bzHfx1gL7qDXv/g8rnwN8MM092MYXWIKJOzQGQXt0DBrKMclWRBFx6zqfZ0vgEtWkIkhr1zlJtn
	HtnA5t9sA0H3T/D78UUCf4N7uU3waxNP9JoCMkDIXf7ByrhtuCNRdRzQvq/lm5558hRvsC0OF7l
	EmyNJr5fiQW/o932Eo2LuvANg7K17qeAH2gHGNdZ8KK+I8A=
X-Google-Smtp-Source: AGHT+IFjLUm9+WmLLpbEHExb3crhK8dh58TsSoxcL57jz28Pxykl2y59HIGEBAl/mRVJj4ptDcLNVA==
X-Received: by 2002:a05:6a00:a1e:b0:732:22e3:7de6 with SMTP id d2e1a72fcca58-7348be4650cmr7406372b3a.17.1740615481481;
        Wed, 26 Feb 2025 16:18:01 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7349fe2ada7sm197497b3a.36.2025.02.26.16.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:18:00 -0800 (PST)
Date: Wed, 26 Feb 2025 16:17:59 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Koichiro Den <koichiro.den@canonical.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Etienne Buira <etienne.buira@free.fr>,
	Andrew Ballance <andrewjballance@gmail.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] scripts/gdb/symbols: follow up on refactoring for const
 struct bin_attribute
Message-ID: <20250227001759.GA351718-mkhalfella@purestorage.com>
References: <20250112122149.9939-1-koichiro.den@canonical.com>
 <20250213043806.GA2552411-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213043806.GA2552411-mkhalfella@purestorage.com>

On 2025-02-12 20:38:06 -0800, Mohamed Khalfella wrote:
> On 2025-01-12 21:21:49 +0900, Koichiro Den wrote:
> > The work for 'const struct bin_attribute' [1] was merged into linux-next
> > but did not include updates to the lx-symbols code. So it now fails with
> > the following error:
> > Python Exception <class 'gdb.error'>: There is no member named nsections.
> > Error occurred in Python: There is no member named nsections.
> > 
> > Restore its functionality by aligning it with those changes on
> > kernel/module/sysfs.c.
> > 
> > [1] https://lore.kernel.org/all/20241227-sysfs-const-bin_attr-module-v2-0-e267275f0f37@weissschuh.net/
> > 
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  scripts/gdb/linux/symbols.py | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> > index f6c1b063775a..8efefd30df49 100644
> > --- a/scripts/gdb/linux/symbols.py
> > +++ b/scripts/gdb/linux/symbols.py
> > @@ -89,16 +89,26 @@ lx-symbols command."""
> >                  return name
> >          return None
> >  
> > +    def _iter_bin_attrs(self, bin_attrs):
> > +        while True:
> > +            try:
> > +                bin_attr = bin_attrs.dereference()
> > +            except gdb.MemoryError:
> 
> This should not result in an exception. The array should at least have
> one element on it, that is the NULL terminator.
> 
> > +                break
> > +            if bin_attr == 0:
> > +                break
> > +            yield bin_attr
> > +            bin_attrs += 1
> > +
> >      def _section_arguments(self, module, module_addr):
> >          try:
> >              sect_attrs = module['sect_attrs'].dereference()
> >          except gdb.error:
> >              return str(module_addr)
> >  
> > -        attrs = sect_attrs['attrs']
> >          section_name_to_address = {
> > -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> > -            for n in range(int(sect_attrs['nsections']))}
> > +            bin_attr['attr']['name'].string(): bin_attr['private']
> > +            for bin_attr in self._iter_bin_attrs(sect_attrs['grp']['bin_attrs'])}
> >  
> >          textaddr = section_name_to_address.get(".text", module_addr)
> >          args = []
> > -- 
> > 2.45.2
> > 
> 
> Hello Koichiro,
> 
> I hit the same problem came up with similar fix below. Of course I am
> biased and I think my change is more concise. Feel free to take from it.
> Looks like many commits changed this code and any of them would break
> python code. Can you please add Fixes tag at least to the top commit.
> 
> 34f5ec0f8252 ("module: sysfs: Drop 'struct module_sect_attr'")
> 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
> d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f6c1b063775a..e4865ec5aebe 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -95,10 +95,15 @@ lx-symbols command."""
>          except gdb.error:
>              return str(module_addr)
> 
> -        attrs = sect_attrs['attrs']
> -        section_name_to_address = {
> -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> -            for n in range(int(sect_attrs['nsections']))}
> +        section_name_to_address = {}
> +        gattr = sect_attrs['grp']['bin_attrs']
> +        battr = gattr.dereference()
> +        while battr:
> +            sec_name = battr['attr']['name'].string()
> +            sec_addr = battr['private']
> +            section_name_to_address[sec_name] = sec_addr
> +            gattr = gattr + 1
> +            battr = gattr.dereference()
> 
>          textaddr = section_name_to_address.get(".text", module_addr)
>          args = []

ping


