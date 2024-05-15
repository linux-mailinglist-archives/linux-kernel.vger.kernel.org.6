Return-Path: <linux-kernel+bounces-180258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A354D8C6C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C11F20EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E6158DC6;
	Wed, 15 May 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AOyIndn6"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AF15531A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797412; cv=none; b=NDvjS7DqKZcEfHhNeFZns4tD875ekVUh0c/hMqexRavLfKNopvsmvcdrh4DiuKKLjYLAfT+ukKaRsQK8fp5IhWB8uL/In38p+MVXDStF2V+BPTlZeWPXeTlJKkaKx+qA6kBTpN9sLJq8X4BapnJJEzYbJ7HJJTnDGZQxnH1L9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797412; c=relaxed/simple;
	bh=bhrqIlPbVhfRes4noyy0nljQpwH1beSggpkNJLiXOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN7fZ0psZNhc7/B5MkrSgn0wRkdk3dobZ83CUdbddMdjFUGHPS6eVephwQj7+QJKKjV4c41H74QZt7mYIe627qgHwMMHMQBkneNzQdit5uV+nmgiSyK6nk537Pea8AXYv9jaKTLlS68gyKkASLxfBBSojkNqAjaXxG5bFXbLbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AOyIndn6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f5053dc057so3697259b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715797409; x=1716402209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MR0I30sTNIW+eDNsgz3nyy/bRqLqCcJui9fOIARkXNk=;
        b=AOyIndn6tk/VWB374Zv+S+xPOG4I2Cc7WG8uFDlQvTygbBW9/5++vSuR1ZHeDBMVvs
         zbdsFXriaNcRT0Nm5GQHYIWE2bidxGbVudpj711MG83Hw/plPrX0bLYzEI76jcBeTHzp
         UdjrL2xF3KovRN7aNwfCW3MlAvcAiT5frUIz4XtzUAVaVc3jwDdOuXQ8MfiI/W2hO+MX
         3zqJp3tDkCIQsRUSivvUKAXjonfGE6DlJ7JmtcX36iswb2Jcjzc5ffg9vQGEhYYZaqpx
         oislL9VDa+/eowVmpFAAc5wu2/kZO8/It4ShnZ1wSgSLCFEqTglDGH8G0R+xd2DE3Du5
         t88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797409; x=1716402209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR0I30sTNIW+eDNsgz3nyy/bRqLqCcJui9fOIARkXNk=;
        b=ddmQwZGj3AlM/vw6mMSC1BOCZ3NX/kYRoZqFivUtjSpY4fvhThimYXBC0m+myeEFq5
         ee2x0BMK3SUx9bOy4hXiGNcCyDtDOQf1QeuMhqQAsaE+n7fQU/LPiw0c04R9OoyYNi3z
         kzNY4yDixrxgQBdVZbDoGGIFJ3uWDS6/0c3T3cwG/A+DREMUCTGhd1ZLxhuappd42ehk
         JU2Vk407/CfrVj/qdIFZY1UndZGQ3Vva0us+Qm/vVuCcJXEUAUrc7mXVEvwMAmo2DLsN
         PmgSGHTstlxV68OhmN9mfn+uoGRjm8VZMZNzIj+9B+pcxY0b99K3ggLNkc0YFWvLXAMZ
         tgYg==
X-Forwarded-Encrypted: i=1; AJvYcCVsJhSQ35/gP+8QjcicD1ZdezjA0M8T2CAJzGBFvIWQYtoghGE4k/RD+s74SzFqL1uVxzW0k/T6w/P718wJ1hlQk/RBJDEcfLbHrvvS
X-Gm-Message-State: AOJu0YzTGXlV+3Wj+voRcvXS0lcLNLXS17PV1k4j3wZYhxvQ4BPPe/Nb
	+u8wJu2zQosAMcKVKk7F1q11fX9/DzudqjFlDe6+i5YarWOyyIec0yAyOqfkRAc=
X-Google-Smtp-Source: AGHT+IH1Vnb/5u89cfgII3+fkua+2Ia+xPgavA+YViAzaYji4M7S54b9nq0WWxyPQOClFvQf2czdTw==
X-Received: by 2002:a05:6a00:3ccd:b0:6ea:e2d8:468 with SMTP id d2e1a72fcca58-6f4e0347b34mr18903324b3a.26.1715797409553;
        Wed, 15 May 2024 11:23:29 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a85f3fsm11373879b3a.82.2024.05.15.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:23:28 -0700 (PDT)
Date: Wed, 15 May 2024 11:23:26 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: fix Andes errata build issues
Message-ID: <ZkT9nieh0Pa3NQQ3@ghost>
References: <20240515-comic-sketch-3b40e6676f55@spud>
 <ZkTnlEnoFFrQdXi2@ghost>
 <20240515-slander-stranger-683758537aee@spud>
 <ZkTuc4fxXcS/g7hC@ghost>
 <20240515-bootie-patriarch-769c0ebff4b1@spud>
 <ZkT1K/c9hWsfOwWf@ghost>
 <39FEF902-2495-42A2-B279-C9FC95828F00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39FEF902-2495-42A2-B279-C9FC95828F00@kernel.org>

On Wed, May 15, 2024 at 07:21:16PM +0100, Conor Dooley wrote:
> 
> 
> On 15 May 2024 18:47:23 IST, Charlie Jenkins <charlie@rivosinc.com> wrote:
> >On Wed, May 15, 2024 at 06:30:36PM +0100, Conor Dooley wrote:
> >> On Wed, May 15, 2024 at 10:18:43AM -0700, Charlie Jenkins wrote:
> >> > On Wed, May 15, 2024 at 05:56:30PM +0100, Conor Dooley wrote:
> >> > > On Wed, May 15, 2024 at 09:49:24AM -0700, Charlie Jenkins wrote:
> >> > > > On Wed, May 15, 2024 at 05:09:34PM +0100, Conor Dooley wrote:
> >> > > > > From: Conor Dooley <conor.dooley@microchip.com>
> >> > > > > 
> >> > > > > Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
> >> > > > > helpers") added includes for the new vendor_extensions.h header in
> >> > > > > the T-Head and SiFive errata handling code but didn't do so for Andes,
> >> > > > > resulting in allmodconfig build issues when commit 589e2fc85850
> >> > > > > ("riscv: Convert xandespmu to use the vendor extension framework")
> >> > > > > added a user of a macro defined there.
> >> > > > > 
> >> > > > > Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
> >> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> > > 
> >> > > > 
> >> > > > I was going to fix this in my next version but was waiting for the
> >> > > > reviews on the thead stuff. I wasn't anticipating these patches to be
> >> > > > able to jump the queue :)
> >> > > 
> >> > > Yah, the reason for that is I asked him to take the non-vector parts of
> >> > > the series as 6.10 material so that we'd have less stuff movin' around
> >> > > in cpufeatures.c so that Clement's Zc* + validation changes wouldn't run
> >> > > into a bunch of conflicts etc. Same reason that I pushed for getting
> >> > > Andy's vector subset stuff merged today, but that mighta been before you
> >> > > hopped in.
> >> > > 
> >> > > Cheers,
> >> > > Conor.
> >> > 
> >> > Yes I was a couple minutes late to the meeting, whoops.
> >> 
> >> 
> >> It's prob at like 0600 for you, so w/e.
> >> 
> >> > The subset of
> >> > patches that was pulled into for-next is odd to me because there is some
> >> > of the thead enablement code as part of the vendor extension enablement
> >> > so that there was a user for it. Since the subset on Palmer's for-next
> >> > does not have the rest of the thead code there is only a
> >> > half-implementation of the thead code, it allows the kernel to probe for
> >> > xtheadvector but it doesn't probe anywhere.
> >> 
> >> I dunno, I think that reporting that the extension is there constitutes a
> >> user, it's not gonna be dead code. There's plenty of extensions for
> >> which all we do is detect them and nothing more.
> >> 
> >> > In my opinion, a better solution would be for me to get rid of the thead
> >> > code entirely from those patches. So that there is still a user, I can
> >> > replace the thead code with the andes versions.
> >> 
> >> The Andes stuff is in the subset he applied though, so...
> >> > 
> >> > Since Palmer already pulled in those changes maybe it's too late. There
> >> > is not a critical problem here, but it seems like it's bad practice to
> >> > introduce code without a user.
> >> 
> >> ...there is actually a "real" user in xandespmu. I did miss that
> >
> >I meant there is no user of the xtheadvector addition.
> >
> >> "riscv: Extend cpufeature.c to detect vendor extensions" actually
> >> contained the xtheadvector detection though, rather than just the
> >> infrastructure. I think it is probably harmless to have it, but
> >> shouldn't be too hard to quickly drop the thead bits either I suppose
> >> if you're worried about it.
> >
> >And the adding vlenb to the DT patches is unrelated to the subset of the
> >series that was pulled into Palmer's for-next so spinning that off into
> >a different series would be more logical. This is kind of a pointless
> >rabbit hole I am getting into, but when we start splitting up series
> >the code contained in the patches start to diverge from the cover
> >letters that end up in the merge commits.
> 
>  The vlenb stuff is also one of the things that I want, it's useful for the validation stuff that Clement is adding.

It's definitely useful to have and it's ready, I was wondering if it
made more sense for me to send it out as a different series to get it
merged in.


