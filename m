Return-Path: <linux-kernel+bounces-561554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7865A6136C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB07461D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9243920012A;
	Fri, 14 Mar 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjD8pehu"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470261FFC4B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961627; cv=none; b=cK3PN/fBk0AQvCsDTjaWY/+DuVlmYndWoup66brwG3q97YTrsq/myK3Yh81QEWZ241XXHNYookqBuzCg9sPnaGd8Tjrr5QH0WeawjbcrX+cC8hFup2F4/I7hUbFVxZYn3TRUIABHhM9NQb7e5u7ceYxK0aERSVK/3wLI2J5M+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961627; c=relaxed/simple;
	bh=JUsDXgouHhGyx7cEbegPi10ShS3Z3geQcMmJBEeY2eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD5nJBpRCGT4xpl2tNPjAu8OI//od7UV2qthb+7vkaNSHa9WeravAvBbQsfHunNLBXCkqupjhiQ9F+V+3NIpLDevI4Hy5gsqdd5TKRqugUWv++d7uVyIEcmgvrirMdbApWvRcnYlvLgLv630zfw5vX33tl4Tv80Zt9A+qu1zqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjD8pehu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so616084766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741961623; x=1742566423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e8bQc3GvargUcdnmcUpU13zlbK5uT7tC5qOX+GAjSg=;
        b=kjD8pehuIx49RgxfNq8ARiH+VY+A8qVpTD9G0XkFQrknwQgzAJyZkgq/BdZcceNJcg
         lhL9bD7oVI6gKKFo3mlCFsntL7/yeBqltQAX1LZBgatkavt+2rYEV0+L2IIruKpaT885
         VVb7cC+lYNhF6zF64KnrpINiq4yUAiOg5tJjLExz2fhix60z7TclKC4JhIocvUfanhxA
         5eT8PF9El31mASQp2K4VZim+QyppaQjlOP6lInHA3sWL0LaULJUbjCUiaK30LugtOTM6
         mbyRRPC/hnFuYl99hid3shLS50FrsDlJxy77VLs2NS6oHWC247kRwUVa6lHMB5/ayC2f
         TFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961623; x=1742566423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e8bQc3GvargUcdnmcUpU13zlbK5uT7tC5qOX+GAjSg=;
        b=XVXYxErdNwt97gF6PEhQbXDnP99Ho1MUQ/5dZoQBERivcWByORDw0q2/h8q6p1Fkid
         dZzE3rHmjiW1Uxpg+ePWDGQMREjOhQcVq4Qxd3kdoF2P3AyrMKtpfL96+awkFrf4pBpw
         l3Piz5hYHsjTDSQgPbKXXXA+6pewB0YiEwoq54LGE+ERUiuuP6a9sHI2GZPfyFg8xLmA
         xkilYooDB7iTvGyjAfan7pnBpMo3O2bzIaWaezMqE8/yjEStqfvLPfmSboCXhE1/XmOY
         Dz4Rfj1MWxLzXuxkEvRveNATkXXhFY8WfwiETJQwQQS6vMovECKM2iyyT90eoJ+ARBhr
         Cw8w==
X-Forwarded-Encrypted: i=1; AJvYcCVFZ5m+XTMQz2Yk8mQlA6joVRYZM9m1D53AM6qSiSKC2Ueo6KeQ75evlFQ3Le0Z/X2KxKsVmf+vYIlJ76A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWoizud+YgiWD7m08CakR0gCr3QhoDnrehbs2pdJGdThlKtfd
	Ik1OvrbROjUURVrUgFElnOiQRjX+eW6Ob86shLulR5gjY4JWwuojSF29BRs7Cw==
X-Gm-Gg: ASbGncuevHrsp61QT2zvE0tbW9S0Rfe5Nb1TIr/1CTDpcdNmxdpEudb4FXHMGen9ySa
	fCS5WRNbAi2DxmhKkbUi65kD4/wOdR51CvmgL6SDuB+hhG5MT6h3BedQciq82zu2ZqUomT8IJXl
	Bhx9HgaZBxRy0haqV8MLsyvL0RYGLg27Zsaj8RBavexK3JAxc09xgwA3OYwShtE/T9xEgzant7+
	/PJ28jRHXyPIc6TAl8pfwVRnx62aJJvb8a4yKL9tNr9TivE2R7mRPADrRLlqtlSy4Rl/veX8CcS
	rKrzcZwjdOcVBXu5HDRZXRqN1nqKFrjX71Sk3bDsmVDJIh+8UV+cCN0tKrjWrzSfgf7GbvGlu5E
	zZ8I=
X-Google-Smtp-Source: AGHT+IGXahv+MsWEwcBurmP9OU88In++x9q7BRsugIE07NqITWt221lmP5KM9LJmHcGfmeGrdzPtkw==
X-Received: by 2002:a17:907:7d93:b0:ac2:d1c6:4269 with SMTP id a640c23a62f3a-ac3314f4395mr235627766b.22.1741961623363;
        Fri, 14 Mar 2025 07:13:43 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm226415566b.49.2025.03.14.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:13:42 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:13:39 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: arm64: Use 0b11 for encoding PKVM_NOPAGE
Message-ID: <Z9Q5k5C50Meeog9q@google.com>
References: <20250227003310.367350-1-qperret@google.com>
 <20250227003310.367350-3-qperret@google.com>
 <86cyejooq2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cyejooq2.wl-maz@kernel.org>

On Friday 14 Mar 2025 at 11:07:01 (+0000), Marc Zyngier wrote:
> On Thu, 27 Feb 2025 00:33:06 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The page ownership state encoded as 0b11 is currently considered
> > reserved for future use, and PKVM_NOPAGE uses bit 2. In order to
> > simplify the relocation of the hyp ownership state into the
> > vmemmap in later patches, let's use the 'reserved' encoding for
> > the PKVM_NOPAGE state. The struct hyp_page layout isn't guaranteed
> > stable at all, so there is no real reason to have 'reserved' encodings.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/memory.h | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 34233d586060..642b5e05fe77 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -13,18 +13,15 @@
> >   *   01: The page is owned by the page-table owner, but is shared
> >   *       with another entity.
> >   *   10: The page is shared with, but not owned by the page-table owner.
> > - *   11: Reserved for future use (lending).
> >   */
> >  enum pkvm_page_state {
> >  	PKVM_PAGE_OWNED			= 0ULL,
> >  	PKVM_PAGE_SHARED_OWNED		= BIT(0),
> >  	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
> > -	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
> >  
> >  	/* Meta-states which aren't encoded directly in the PTE's SW bits */
> > -	PKVM_NOPAGE			= BIT(2),
> > +	PKVM_NOPAGE			= BIT(0) | BIT(1),
> 
> Isn't this comment stale now?

I believe it still applies to guest stage-2 page-tables as the three
other states above are still stored into PTE SW bits (well, sort of,
only SHARED_BORROWED is at the moment as we don't supported protected
VMs, but OWNED and SHARED_OWNED will be a thing for protected). NOPAGE
is still the only one that is a bit different and doesn't go there.

With that said, the comment could be made more explicit about that and
explain this is now guest s2 only. Happy to spin another version of the
series with that changed if that helps.

Thanks!
Quentin

