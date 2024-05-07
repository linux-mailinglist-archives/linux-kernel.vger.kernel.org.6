Return-Path: <linux-kernel+bounces-171797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542C8BE8D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DFA1F21C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698E16C44A;
	Tue,  7 May 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LzrbxRXH"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E616190C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099226; cv=none; b=sTallpQL6YC/bWyCDTVdhMVNphnJTNDpzesHwFBTAqQrsdAmZ8YPtXluyCuVJxMRg90XUPeYV874KpM+CDeGczVXK0PlitpNFOEM3J40ncowbqg/VTuT5L/3BBnuVlIJk0GaqabIXD6Om1JjAYje1WBtZ6SEM9N2G4NibKUrr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099226; c=relaxed/simple;
	bh=/fHOaF8n/tPSfg+d3vJ0ysOAwjqElmfYyxoyclsGm40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLBdppXKSW5o/IMCoeo0LWqIIE8VWyEO++6vaZHQnQj1IISib0DSbXL8kgfSc+TF9SG26fHBGiqFjiJzG0HSQ2i0W28TJzwOr1ws7XQTISDwHgr228BqlImzhaEVMZATvzEf9NAhPJaPGOYOseO2Dx1de8V/GqyEF0uCYjhgOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LzrbxRXH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7928c5cb63fso241046685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099224; x=1715704024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9cKDESKTiP97lhdcYXkoeInlU7bxEYJkwQ3k3Yr+CA=;
        b=LzrbxRXHnHw4fDaTWQcR2CKcmwALEXwb9a1EMB8NCyTYCm0qik8rWJE39+xzi2NEUs
         ZCnG0quFnpLMeX1HTlya2Az4OyIzd3BJN2cREazNA3SWxvTj+vj4oQqAMNyD+buKnMbT
         dj85R0zzDv3/xT/UNyIJ+Y0dyuaJlhWCvKiQPjJPu/262g050/QBeOpdlbCXRLVnDdhK
         McHbp8ZNB04aoAXf2HTrWIjOsPT564yZe38CBfqI7u0hvXtB4kQKAKA76F2LGEi5lzGS
         k2CIsZys17gpq0crMnzIHLZ8VA6r84c5q5RXkv9DQWjcAfHi+lXw3lSeg5VBmt24RdIT
         hx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099224; x=1715704024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9cKDESKTiP97lhdcYXkoeInlU7bxEYJkwQ3k3Yr+CA=;
        b=qf0jIMh2077sqX5ZJD7LqX1ZPU3Io/2/S/RmFnrg1AN3nLcbMYQnfSZgAMbI88TQ/h
         iQjZC/tFrQscLnrk498ax13uKciQkmisoGuhMuC9OaYvMf54pAyulknUEiZQuPhPPIR3
         nMNZgFg7FYM/JSQsQs0wGBpncB8Kop5iROLgCJ3FDr55Z/RpHRXcMlsaKc4HfL4wE9jH
         VHjN3J/KXtByZZwfE9EJQ1SCAxVmiMsjGoKbvwYHpXbrL3apChw7rjRbDm+A+SabJIAp
         of6y/re1aQDSfeYEbm5w8QhwDXE8jhoaXRzmt/SVk+ibpXUP8UlepOJzgk24yyGgeK5W
         YAzA==
X-Forwarded-Encrypted: i=1; AJvYcCUbKf5csHg9gFcGaTRvNnNvdgh+Ss/rP0Qq6iT/mpqxU0CVW3YX/IZTNTd6BD/AMGC+ftHEX49cklg4rBgjcD68Wlg5X2JJjU/T+Wek
X-Gm-Message-State: AOJu0YxsmUq7i+tKI48ah34QF1gOwdn5dvdKITwEAKKPPwWs6j891Vfg
	Kj6GruXaJjvqQPi43+dPaami35AjcM+B918ivBOLJU7AjTv7RjLfmokxf7YFEjI=
X-Google-Smtp-Source: AGHT+IFHOfTfE3EmH2freuJBBL04oEuzM8UFJjSGZkYvzSYQQYKXpHT2OlnFg74U2ZgMJcQo58TcyQ==
X-Received: by 2002:a05:620a:e85:b0:790:9e84:9b75 with SMTP id af79cd13be357-792b247fbdcmr40793185a.12.1715099223899;
        Tue, 07 May 2024 09:27:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a05620a13cf00b007929f035e9asm1688278qkl.109.2024.05.07.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Neg-0001SK-Do;
	Tue, 07 May 2024 13:27:02 -0300
Date: Tue, 7 May 2024 13:27:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <20240507162702.GC4718@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-7-zong.li@sifive.com>
 <20240507150829.GJ901876@ziepe.ca>
 <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>

On Tue, May 07, 2024 at 11:35:16PM +0800, Zong Li wrote:
> > > +     default:
> > > +             pr_warn("The user command: 0x%x is not supported\n", opcode);
> > > +             return -EOPNOTSUPP;
> >
> > No userspace triggerable warnings.
> 
> I don't complete understand about this. Could I know whether we should
> suppress the message and return the error directly, or if we should
> convert the warning to an error (i.e. pr_err)?

A userspace system call should never print to dmesg. Return an error
code. Put a pr_debug if you really care.

Jason

