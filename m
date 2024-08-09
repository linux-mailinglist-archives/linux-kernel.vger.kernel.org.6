Return-Path: <linux-kernel+bounces-281409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11294D6B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C121F22279
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4401474C3;
	Fri,  9 Aug 2024 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLWEQzSS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05517557
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229548; cv=none; b=ZiOCM3mlDkA4efHqgo7EdpWz91UMi0QwnjVJfuTL12VdK5JFJ1Qq0Lt4q05Q9QCaRL5fRi4dxavLeSm715ubJwUqty+MocyDaTtzZdlQfavCwTWrx1sICIDyoRvsbLQrcDNIHG6FG40iOLI/mf13dUqXeEZOQ+4/Qc3K2gEwW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229548; c=relaxed/simple;
	bh=t3Cj7VDLa1bnw9WsksFqHlQw2fueh0FzL7HEx6ntwFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgtDIV5czrGCXvoI0ZnKOnClP0DEbidSjxb37242AYXCA19v4gdB8Xi7DtN7lxvv3uRLe+Cp7itZM4zpcQuuOIVqumWT0dVpsK4xv5+igKEwcdvEGewKlSso91utVBkSQv/W9/ka0L6UCakiLxNtx6zyXXJ22mRpEpG6lPuEhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLWEQzSS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd9e70b592so19363115ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723229546; x=1723834346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2kxD8+wCHh7kPrw1r+ewjBkSyFLdoVzJbIrH0Dtpss=;
        b=gLWEQzSS4nQwp2iiDtvu+BKZkZnVMYPb62VPLZRyERWEK6aHxqnDrkXxYhWS+EYTMJ
         pM/ni8y2NWORWzqY5oYxQ9qA1ZNLlx7sBqQnj4O4tT1uzWGXesp0jF3DdxswVBLlZmLJ
         rvqiS0fjRYYsWiJBQRf4qk67Jvl1nxEFkS/Do1dBAc6UmP46Eyabd2UVGAeO8n7X4oay
         1zmUttpDEAH7/xZIDcxO0oq4sTX0fx70aqYi7eF8nYzSj3dSgp0NWEytfnhK3WpZlCaq
         Lx7tfnDLMkkd4v0IYDuEjPDhHxf4Ul22A1RN+HV7C6ppRLzDO11zaDKtgFOLUU2M6OC8
         HxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229546; x=1723834346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2kxD8+wCHh7kPrw1r+ewjBkSyFLdoVzJbIrH0Dtpss=;
        b=EDW6ce2VwanJd94F7tC82rvyDocGTL2j7kJ+r5OHU1hvmrrC7aR+VK/r+DTW/22zRp
         FTYmqexPq3xSPJIw2nl5abE/lTzS1Oc0WPqbEtvlFVwwxq0ejRz/tnJoH1zfnDIRHeSm
         VoWQR3ZxICNa9Yts3hsUVLBMXcMZGNblDvFRQdm7EbbIejycB5oHFupq1FQkWrEiTN2z
         a6+vbYH/zFTsLgWOURsXrUMHdHdiSSAVpJCS8M6A602TPnUsWKPLmYKE+yetSP6HgEp6
         xiklYHSCi74siptAb42qSe1/KREDmEhcjqFp97inoKN/DAKGkrg1Oyepkv6W8enx872v
         4qJg==
X-Forwarded-Encrypted: i=1; AJvYcCWu9VRJ+287ahls1As7i2xOVPBf1ds+bCnGu3780Pfo0DXw4g5Vu22dxjrAtJA0hcTIpj9GA0KexKTR9gW3sgMVXHCOyE++dMQq+g4R
X-Gm-Message-State: AOJu0Yy2A8YHKjm661oH3Ec/TC4Scf7+LEy+cBTBSvOTG7qT/xLf51G0
	/GjQSicx9DLKWQCaT3WM9nLytTJ3SObaO17P87v3ahL71QQ1PcKP4sMEc4tVlw==
X-Google-Smtp-Source: AGHT+IEfOVhNrAeTDZZOT5dDxnFrZOlxDmQwSQJhCv+U2+iM1w/HDGwYbakEN6xKAfupUHXOX98LGg==
X-Received: by 2002:a17:903:234a:b0:1fc:3600:5cd7 with SMTP id d9443c01a7336-200ae4b2b0bmr29902105ad.10.1723229545610;
        Fri, 09 Aug 2024 11:52:25 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba02f2csm773505ad.217.2024.08.09.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:52:24 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:52:19 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "J. R. Okajima" <hooanon05g@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS
 configs
Message-ID: <ZrZlY-5h5N28PMH7@google.com>
References: <20240807143922.919604-1-cmllamas@google.com>
 <20240807143922.919604-2-cmllamas@google.com>
 <1503.1723080058@jrotkm2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503.1723080058@jrotkm2>

On Thu, Aug 08, 2024 at 10:20:58AM +0900, J. R. Okajima wrote:
> Carlos Llamas:
> > Adjust the upper limits to the maximum values that avoid these issues.
> > The need for anything more, likely points to a problem elsewhere. Note
> > that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
> > had a different symptom and has already been fixed [1].
> 
> I tried setting all these configs to maximum, but still I got the error.
> 	ld: kernel image bigger than KERNEL_IMAGE_SIZE
> 
> For me, these are the maximum.
> They are compilable, but could not boot due to "out of memory".
> Also I am not sure whether these values are meaningful.
> 
> CONFIG_LOCKDEP_BITS=23
> (CONFIG_LOCKDEP_CHAINS_BITS=21)
> CONFIG_LOCKDEP_STACK_TRACE_BITS=25
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=24
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=22

Yeah, I say that's expected if you bump these values to the max all at
once. The values I gave were tested individually on top of the defconfig
and boot completed fine (qemu x86_64 and aarch64 with -m 8G). I think
it's fair to leave room to configure these knobs individually.

--
Carlos Llamas

> 
> J. R. Okajima

