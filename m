Return-Path: <linux-kernel+bounces-379795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724FA9AE3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BE3284057
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E811C878A;
	Thu, 24 Oct 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otbNvaSH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE01A0BD6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769554; cv=none; b=KQR9XgwYirDP4FgT5cai9B4laUBKGhUKo3P3JDnkeztkioTs1gWLSV5ScPLdj5nncCnmB2I942xI+2O1TmyV2pZDNQXtR44xPbIEOuyo+Lao2ojxB8OUGu+aXNk0tUww0v/+xkwORSlEe7U/4sP2n6qU+wLZpwX0/EOelmeCr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769554; c=relaxed/simple;
	bh=lC5eZfs2FBQN84Dap4OTkbcR06oVMccq9VOoICb1mA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2mH4YzZDPliJuhKvBQBKdOpHDxa2cNm37res3tnixqzY0tKVsYQcE66ZSDMi3VO5V8lRpa2airRAYCHgAYipmDqltgt7WaRZ4zKLqqkni9U6pDqAggaDPkAWRUUSZH46dpegMN7kfwm0TggrqiHN452ZKQndG7Lp/GT4Ne8CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otbNvaSH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so148505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729769550; x=1730374350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Erp1+OVg6Zvh2QGB7pP0w1YYkfDo5lKRK3PPeKeDOv4=;
        b=otbNvaSHy0CmMLOsNm70cSw2b3TvrRC2vse5Lo1OIywuPvIRmHb6iixTStGso8fvih
         HIWFiY217iRLLN0JoiRz2Rjsuood+dHp8DpA/8i0IWzdnzoQwGmwzgvesO8Bs5rA5eVj
         oa1hIZMIltlFzhXEVivlrMCK/ReOzJH/+o5Ppt84a1x2/YxDdXmpIxyq56eCaoaO3p6T
         gnfR+SlZmSaKkssQpeNW67mB9sYOAAn7fNwLNWE84i/jVuxVD+zDRiI1vyI9vA9WUnVS
         KrVtjKTqawmDdEylgaqG2YeBB68GX4ovwnaTryYrAsqOcYIvQ2jAzxdh8H+ulNbjR1RS
         t3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729769550; x=1730374350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erp1+OVg6Zvh2QGB7pP0w1YYkfDo5lKRK3PPeKeDOv4=;
        b=G4DhDZIazeKX4Qk25NBjfJl/Cj/yExuSxWt3aOM5GG+AAeorVX6qHTiuLNudnqVjSn
         J5rEK/GkWxucGdlpaQ6WYjtCeqIzPXuwDPrwI3Skssg8N0GEiAKhUxLS6WmDapkpou6M
         LCisOaTETK3Va4XDswJEmA0zmQHTaOJHw8iLgyG6nfvWMNoBj2btcXQtBhSvJ/8P8ONH
         GYFbBcxNPVymRV3t1KSlcMBs1YwGDHu5ks+gQ+/CPpiP3NGfhn/u296QbV4Ve9+ghttP
         aJWSFADBIdgZFyIuee0Sty9RTtnVvOutvAJlmuYtxs1haOpxsk4vUwrzXjav8ekr7jzY
         a3EA==
X-Gm-Message-State: AOJu0Yw1ympEj12o2GpXCoh4MB41BkUNBt1iCmgANZ/6RlEFcQpLPvrw
	mnoLWiN2BkGV79ABB9HPxkIfwUhNsvati0ikNcvehumL0aOjr2NnMIZ6mPrcCA==
X-Google-Smtp-Source: AGHT+IE07p1wY1vvq/4/9vbPY3LEzz4J2xejwqtPU6uKF3gb39IMRgXzep0l9PGpoNZbYvF5Fehu7g==
X-Received: by 2002:a05:600c:1f14:b0:426:6edd:61a7 with SMTP id 5b1f17b1804b1-4318aff2d08mr3020455e9.7.1729769550185;
        Thu, 24 Oct 2024 04:32:30 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5706c3sm14524155e9.34.2024.10.24.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:32:29 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:32:25 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, corbet@lwn.net,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Documentation: Update the behaviour of "kvm-arm.mode"
Message-ID: <ZxowSYHQeOq7W_JT@google.com>
References: <20241023171244.4031151-1-smostafa@google.com>
 <86v7xh3km6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v7xh3km6.wl-maz@kernel.org>

Hi Marc,

On Thu, Oct 24, 2024 at 10:39:45AM +0100, Marc Zyngier wrote:
> Hi Mostafa,
> 
> On Wed, 23 Oct 2024 18:12:43 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > Commit 5053c3f0519c ("KVM: arm64: Use hVHE in pKVM by default on CPUs with
> > VHE support") modified the behaviour of "kvm-arm.mode=protected" without
> > the updating the kernel parameters doc.
> > 
> > Update it to match the current implementation.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index bb48ae24ae69..59a0dd7e2de6 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2723,8 +2723,12 @@
> >  			nvhe: Standard nVHE-based mode, without support for
> >  			      protected guests.
> >  
> > -			protected: nVHE-based mode with support for guests whose
> > +			protected: hVHE-based mode with support for guests whose
> >  				   state is kept private from the host.
> > +				   In case hVHE is not supported in hardware, it will
> 
> nit: it is VHE that is supported or not, hVHE is only a SW concept.
> 
> > +				   boot with protected nVHE.
> > +				   nVHE protected mode can still be forced on VHE systems
> > +				   using "kvm_arm.mode=protected arm64_sw.hvhe=0 id_aa64mmfr1.vh=0"
> 
> This opens another question: none of the arm_sw.*, nor any of the
> id_aa64* parameters are described (basically, anything that's in
> arch/arm64/kernel/pi/id_override.c). What should we do about these?

Yes, I mainly added this, to make it easier if someone wants to boot to
protected nVHE so they don't have to go through the code, but I can
remove it if it's confusing.

> 
> 
> 
> >
> >  			nested: VHE-based mode with support for nested
> >  				virtualization. Requires at least ARMv8.3
> 
> Huh, another nit to fix. We only support nested with ARMv8.4 (with
> FEAT_NV2), as the ARMv8.3 version (the original FEAT_NV) is too ugly
> for words.
> 
> Mind addressing this?

Sure, I will update it in v2.

Thanks,
Mostafa
> 
> Thanks!
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

