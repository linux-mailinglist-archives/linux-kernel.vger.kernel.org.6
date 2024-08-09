Return-Path: <linux-kernel+bounces-281414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891194D6BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FC91F214F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058415990C;
	Fri,  9 Aug 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ky7Yglvs"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2E1474C3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229781; cv=none; b=GBaNq/0agS8YqdXLITOdgQ3BNW2lH9meW7Z99dMr37os/LXHjxQNZd5cyli08YvQjPAd54RY07O6FHkCkcO+PG8TubnErPUasf/OHD8uYVKf3lOMFke1xAa8o/fKC8IQvAwh71wsVihcdieL70l6DZYswRRP2fMfjZwjTE5DfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229781; c=relaxed/simple;
	bh=ln1qwbakUg9GGr4j6LkyGcMN9zeiqnC+Rh+biufC0wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwkJ+eFSiJ2E54UWuxykUTFqQ7y3vt7SsnUFOwc97x58zfzDL9nEFeK/iw3dOKibltG5Yn9aEeyrifur56Jb/n6+N650L6PxZ0QbQnZJYkfg9bddCFy/nZcjWYEbfqWX5P3L9Mp1QKeMYkM/pAZa4fUuOR+QQ35I73UzF/H8Pyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ky7Yglvs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso1763822a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723229779; x=1723834579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3Qkeo+W250W1kX4t1UlG+kDZd1Dez1YmJ5bcZ/eiIA=;
        b=ky7YglvsHnESkGOMfhd9nNP2kmLDHh0a8rPkMJcXHMy6UGZrfsJlQQ4PDdCfFIyT/4
         sHew5e1EKu8ZV8c6dOKjqZ2RNATjrbiuwV7rT2izigf9cBFC5tmPB60Ao4fFS9kYGg4X
         VTztdtHN8qwaD9lybYWPkWPOQsf2tfe8J/B6WXd6DxJQLxlXGwzfnTNM+GZFHx2qKXRK
         xkD5tRoOs2utBxr+6M1KgqYGDEyTDBU2B35eupxiWJugewhFaMwEP/YQmjt8AaG3iyCV
         1LMddHnHOaoUJ0+fH9sDy43KdX03W4XqtvJwh7tYxkyC3JbSyV+knBIIKAZeZdzblACl
         KxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229779; x=1723834579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3Qkeo+W250W1kX4t1UlG+kDZd1Dez1YmJ5bcZ/eiIA=;
        b=BlNjCQ+TScuZT2dIwF3okTYaPwv8igphW+OdGlGdYvzFIAk+eyUJ6Al/OdM6oEWRkU
         VETH7dHPK+ZjnbeqEWVTnlaug2xhabRvPkzR9BRSH1sHD3aPw8tTEzw0Q2C28k1SCV9f
         jDk26uovmO0BMR/Mz4piqaIbUZTWxGQb218A1g0xLml9ZGHY3KWuXCSv0B1FuO+I9T/m
         UuwZX/GVhRNLq6pII47sNhCCCOvhEyXkuyCY7mfPiMVv8EivZW436M9nxW4oxGaLb4x6
         K985zKzZ6BU7GgvS7ck/GjvHE/SR9+NNLOibG+OSMFMH2WQOh1LdSlXgplYjIRYJTRLf
         wrBw==
X-Forwarded-Encrypted: i=1; AJvYcCWB7rg0SRSDZZK7b/R2HcZAAYhphWSzMP6SqETtaXLMBYkWXWosOzHQybjiKFG/KEJCpAW+As9IAgP/UdqAI/YfS5pWmcneZsd6SWH9
X-Gm-Message-State: AOJu0Yxu7CX68MqGjf7s4Gk4SvlVvMmeB6iwgtQb/f9I1sxoKlYt8OVq
	gzneeNYd47sNixkj9FGhfRHqNUVqaeiHAIe8d9d5b/i2HD8mgi7vjflWqnbFV7I=
X-Google-Smtp-Source: AGHT+IFtri4zHq80gWpj0M+3oaa0JsIqMB6/Nz/RW24XYkQW7jPd+vTe5dieCHLB32pMTRX192P1wA==
X-Received: by 2002:a17:902:e54c:b0:1fd:d55b:df26 with SMTP id d9443c01a7336-200ae61452dmr35328755ad.61.1723229778955;
        Fri, 09 Aug 2024 11:56:18 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:c486:937c:35d4:b6a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7ee40fsm924035ad.14.2024.08.09.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:56:18 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:56:14 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Rob Herring <robh@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: Add Zicclsm ISA extension
 description.
Message-ID: <ZrZmTvJgyQ5nB70H@ghost>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
 <20240809162240.1842373-3-jesse@rivosinc.com>
 <20240809181536.GA976083-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809181536.GA976083-robh@kernel.org>

On Fri, Aug 09, 2024 at 12:15:36PM -0600, Rob Herring wrote:
> On Fri, Aug 09, 2024 at 12:22:40PM -0400, Jesse Taube wrote:
> > Add description for Zicclsm ISA extension.
> > 
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - New patch
> > V2 -> V3:
> >  - No changes
> > V3 -> V4:
> >  - No changes
> > V4 -> V5:
> >  - No changes
> > V5 -> V6:
> >  - No changes
> > V6 -> V7:
> >  - No changes
> > V7 -> V8:
> >  - Rebase onto 2d1f51d8a4b0 (palmer/for-next)
> 
> Please also put the version in the subject. '-vN' is the git-send-email 
> option to do it for you.
> 
> Rob
> 

These patches were originally part of a different series [1] but are no
longer related to that series so I had asked Jesse to spin these off into a
different series. These version tags probably should not have been left
on here when made into this new series though.

- Charlie

Link:
https://lore.kernel.org/lkml/20240726163719.1667923-1-jesse@rivosinc.com/
[1]


