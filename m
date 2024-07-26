Return-Path: <linux-kernel+bounces-262915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6C93CE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1966728258A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABF176AB7;
	Fri, 26 Jul 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YEMVNZTW"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94647381BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977985; cv=none; b=oQMu29/40W1at11I+T1nG45VJEQ6uvNZSeIVQtDqA/aCipEcvywR8/tWcF0ZaBo4m9vp53FjWYSALBJi3ccSrQDY0oZ4N6o9L+grhy7I//+RPrerLgbHlLFg+dARz5tUL7KMqYJ5/5+Z2G9EMOexSl7ybs7q2FCYgkFl9WHqhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977985; c=relaxed/simple;
	bh=f1A6KhFS6dTNPDRuPRPW4KrxtyD2JrdCBL9g3cxuav8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKS6l1K1dEyLWyh1lPJOgKxyRqQsupLimj9/GIX9t92qNc2cOTCum/F/2Z9O3EIZ5IpipMc+j9va3YAzEiLTZOv3FnQqCm4xgHQWXMK1QK/0E6PckKARMMPibOQsJKiTPRO2/LFqipw3/WsPTwKR4dNmiZE7dViC2F4PIBfhMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YEMVNZTW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so238397166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721977982; x=1722582782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbS6QA/uxRn6Yw6eceppEaXLSgjLvSjiU2Xr+hMmLXY=;
        b=YEMVNZTW8hptzUvmdaqD+BRxXkbKsh8V6iRryQS1BM/ATohK3d1K9UX/NaW+j+ALvk
         E3pDRZ9WRajdlIvNuVsOC76Vs5z+4l7tPLkDgNVr8jPMQDmSfl0UpTuMJWI5Flm0SSMX
         xhVzxk7WD57CnN5+vKVGn+fL2sRUZv/PSC3oHfHTNG0IGTYa8pQkPavCnyaXYfIVzy+i
         bq1pljnv3rsbyuXkeK5PuUaRRBNoVwPV/9sSuIelRLLjnM/3wyO89Xpo9oOJ5zCZwitu
         ILvY5DeULLM48+ufqDKZfHV8PRbKq8671D0ywF2FJ6X/h8n/Ui5DFbXb2W7z8ApLS3Vh
         rfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977982; x=1722582782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbS6QA/uxRn6Yw6eceppEaXLSgjLvSjiU2Xr+hMmLXY=;
        b=IrH8pTZsqMJoHjLC50ewHXZtxBIkAk9UlS0EBCqhQ4fcxNCmMfLRco5YHKgN9+rXdb
         qNTSV9dXzThqyyHJKvG/Av6+U0U7NVacI7/wrmTy/UfhBhkw2mnBDbw0kEDuToIPM/EE
         v1qyR5sITXjsknBsOK0bTRzKGhxrOu6r15W5d1OfbwqjG5ik8/h6TlPFmbkMJTJA5IzS
         8S8I6ZPiq3TirbVmTLkjlkFcZTVDcYaeMzmhtN5h6wBUrrpue42BIT7Trs3THgSJ2bHP
         /GwezHzGrhj6cWL4DbQoB0hX0l3QgVQvr1MH3vhiFS0vLuZh3IlFyVR/AXfZy23+rG4p
         gnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ln94qFmwnn3yIigwVkdC7SCRgeF3a7mpyfzMOsu0EV4IbAgaCsx49ZYD4/OYzgxKDUr5SKGnaVCivTOA4KPH7xkhQISefDVMmX62
X-Gm-Message-State: AOJu0YyHXvZTWxzano0HJiei87Jni/SuQy+VoQ7OH6uPsxOILCEN4glC
	Nm5Hxw6wmfOCGyvjpe65168Og2AWVdJNu88ygjQLH8L1bqx6BI1ycBJHeIyf7u4=
X-Google-Smtp-Source: AGHT+IEh81DwYMTS6KZ5c2AMDO6VOtSFS17jbe6XTkWTEeeu3DUnF1wKJRQ4cB/Ro+dBAraNLLs4YQ==
X-Received: by 2002:a17:907:a80e:b0:a7a:8284:c8d6 with SMTP id a640c23a62f3a-a7ac46914cfmr382950266b.24.1721977981732;
        Fri, 26 Jul 2024 00:13:01 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2365fsm142215666b.21.2024.07.26.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:13:01 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:13:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <ZqNMfL6JmgHCJwBv@tiehlicka>
References: <20240726054357.GD99483@ZenIV>
 <ZqNLEc54NVP40Kpn@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqNLEc54NVP40Kpn@tiehlicka>

On Fri 26-07-24 09:06:59, Michal Hocko wrote:
> On Fri 26-07-24 06:43:57, Al Viro wrote:
> > We are *not* guaranteed that anything past the terminating NUL
> > is mapped (let alone initialized with anything sane).
> >     
> 
> Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
> 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Btw. this should be
Cc: stable

> 
> > ---
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index 2aeea4d8bf8e..417c96f2da28 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -1842,9 +1842,12 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> >  	buf = endp + 1;
> >  
> >  	cfd = simple_strtoul(buf, &endp, 10);
> > -	if ((*endp != ' ') && (*endp != '\0'))
> > +	if (*endp == '\0')
> > +		buf = endp;
> > +	else if (*endp == ' ')
> > +		buf = endp + 1;
> > +	else
> >  		return -EINVAL;
> > -	buf = endp + 1;
> >  
> >  	event = kzalloc(sizeof(*event), GFP_KERNEL);
> >  	if (!event)
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs

