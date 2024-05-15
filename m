Return-Path: <linux-kernel+bounces-180229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA2A8C6BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E96B2496C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E1E15887D;
	Wed, 15 May 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2qdLzqgm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7F17C96
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795248; cv=none; b=PuxYjVPwmSOIZlO6UJF6+t9U2eba/kv2r2iGlB+BLYf4KOipa1irx2RAgfK+/5NNzpQvwNE8tpWGRtsFbSMlMzzo8atzhzk+4+yRBKn+WQgFjxPW5yFwqaPEpLzTa3ltvspJBGyjB1afskO6vKFT6QLD7xQUPlw0rF0vF6ppZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795248; c=relaxed/simple;
	bh=+5fqOiTWRoYcpXlleOV5jYsahyQV4EZz090bAbaiTvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdrbzOqzfKMOjkx8T4HZvrvOGhsHVMQLOIgmMb95PA1twpOqiT1//E0fMx/prWPSXLNoYK/F5timi4QaewWr8vrMCmg9t1w7ZCGkOlNwXLfX+89PLU//jtGbI3zyerBBbQoyT45wjOxjhh4SIV1yWlFveCCQtMqYrB5PCz71zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2qdLzqgm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3c3aa8938so49895365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715795246; x=1716400046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNQBK45Jbj2jrow2+tGAdK6aG6vUrJlKW5RKoJXeXKU=;
        b=2qdLzqgmGdm+Zq2ATg+idnG7lSAsFBfbflzBcZDdthuP3tnTgkbAOeSNYNysWsOzWG
         DhcR4R/B9ARZdTUYc+MYq1zaM8Pm786AVZh3D15bOq2WHzBrJG10Gw5CftKtq1GbfhPn
         AH9VfAODWsLWo4aZTUgqg5AP+61cdJGuyvKQQ+Sreq7I/xuao4hFQa/MkQO81G0hKFLW
         4xg5WvH+prKHWVtQpMa7Y8++y5keFk13DYCqxaJYxfiYwwILBqKWgUCGrzOqAXv56jlu
         Y11LaKlhoyNLGhB3hKb+UN7HJ90KZm/wCFXA6ZizQv3ablcfAgRDmJXyaOoPRF6mRrG2
         f2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795246; x=1716400046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNQBK45Jbj2jrow2+tGAdK6aG6vUrJlKW5RKoJXeXKU=;
        b=ggeBHk01v6SuXSfFWZyLP13Y10l6iSOi2Cgt2J54quotWgt8Evi9TQ9zn+ixKlXLlb
         kQobkYJNLLvRUHcdEPHmEhmnbPa4R+W4GzMC82OIilEXSX9rmftYsBOVdSEOPmk0sQdX
         VQKmoZBjoNr709WwocR4D5pM/6BdCfXv4N+fQjhxtLtp5Vsd8p4FgNexwWPYj5lSGZWh
         ocvcuD/jH3jbVHN/+unwwvyuB0X8wMioneiV9XXuLsNBKoLh+tlNAfx2JNk59mPPMFtx
         mrwIwfRMFdkPEYYMi3fNG2nFpIvAgttTAQuN1TXkTYsuTvgHnnJE/tTdI7zjMlUiupL1
         nDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeUjhTGdTaadIVj3mMrvonRhrLKfn16VMFOv1F2SZv1FQ28HtFGUPTGmm2h2u6JAd4LrhA4WQ/T1J7bXJy60pa4KmqC4WVduYxAs/a
X-Gm-Message-State: AOJu0YxTz/jOfOoQTUSUAxy1DZpB2uOt24CNgN0ZHpih4XbfrZ2I6s05
	KZpwDQQit09Vr76o/aEgvEfpKrDuE9xsVNqhZtmuaRNggljmDcaa2QKUiklsM7o=
X-Google-Smtp-Source: AGHT+IEJY38pGt2rAu92x314kl37SMl9wTF+lCux/msdi4krymsAu3gF+nWVkviFEyHAKHoShTZ2hQ==
X-Received: by 2002:a17:902:784e:b0:1eb:3daf:ebaf with SMTP id d9443c01a7336-1ef4404a932mr148259035ad.57.1715795246056;
        Wed, 15 May 2024 10:47:26 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30caesm121246705ad.160.2024.05.15.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:47:25 -0700 (PDT)
Date: Wed, 15 May 2024 10:47:23 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <ZkT1K/c9hWsfOwWf@ghost>
References: <20240515-comic-sketch-3b40e6676f55@spud>
 <ZkTnlEnoFFrQdXi2@ghost>
 <20240515-slander-stranger-683758537aee@spud>
 <ZkTuc4fxXcS/g7hC@ghost>
 <20240515-bootie-patriarch-769c0ebff4b1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-bootie-patriarch-769c0ebff4b1@spud>

On Wed, May 15, 2024 at 06:30:36PM +0100, Conor Dooley wrote:
> On Wed, May 15, 2024 at 10:18:43AM -0700, Charlie Jenkins wrote:
> > On Wed, May 15, 2024 at 05:56:30PM +0100, Conor Dooley wrote:
> > > On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
> > > > On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> > > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > > > 
> > > > > Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> > > > > helpers") added includes for the new vendor_extensions.h header in
> > > > > the T-Head and SiFive errata handling code but didn't do so for Andes,
> > > > > resulting in allmodconfig build issues when commit 589e2fc85850
> > > > > ("riscv: Convert xandespmu to use the vendor extension framework")
> > > > > added a user of a macro defined there.
> > > > > 
> > > > > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > > 
> > > > I was going to fix this in my next version but was waiting for the
> > > > reviews on the thead stuff. I wasn't anticipating these patches to be
> > > > able to jump the queue :)
> > > 
> > > Yah, the reason for that is I asked him to take the non-vector parts of
> > > the series as 6.10 material so that we'd have less stuff movin' around
> > > in cpufeatures.c so that Clement's Zc* + validation changes wouldn't run
> > > into a bunch of conflicts etc. Same reason that I pushed for getting
> > > Andy's vector subset stuff merged today, but that mighta been before you
> > > hopped in.
> > > 
> > > Cheers,
> > > Conor.
> > 
> > Yes I was a couple minutes late to the meeting, whoops.
> 
> 
> It's prob at like 0600 for you, so w/e.
> 
> > The subset of
> > patches that was pulled into for-next is odd to me because there is some
> > of the thead enablement code as part of the vendor extension enablement
> > so that there was a user for it. Since the subset on Palmer's for-next
> > does not have the rest of the thead code there is only a
> > half-implementation of the thead code, it allows the kernel to probe for
> > xtheadvector but it doesn't probe anywhere.
> 
> I dunno, I think that reporting that the extension is there constitutes a
> user, it's not gonna be dead code. There's plenty of extensions for
> which all we do is detect them and nothing more.
> 
> > In my opinion, a better solution would be for me to get rid of the thead
> > code entirely from those patches. So that there is still a user, I can
> > replace the thead code with the andes versions.
> 
> The Andes stuff is in the subset he applied though, so...
> > 
> > Since Palmer already pulled in those changes maybe it's too late. There
> > is not a critical problem here, but it seems like it's bad practice to
> > introduce code without a user.
> 
> ...there is actually a "real" user in xandespmu. I did miss that

I meant there is no user of the xtheadvector addition.

> "riscv: Extend cpufeature.c to detect vendor extensions" actually
> contained the xtheadvector detection though, rather than just the
> infrastructure. I think it is probably harmless to have it, but
> shouldn't be too hard to quickly drop the thead bits either I suppose
> if you're worried about it.

And the adding vlenb to the DT patches is unrelated to the subset of the
series that was pulled into Palmer's for-next so spinning that off into
a different series would be more logical. This is kind of a pointless
rabbit hole I am getting into, but when we start splitting up series
the code contained in the patches start to diverge from the cover
letters that end up in the merge commits.

- Charlie

> 
> Cheers,
> Conor.



