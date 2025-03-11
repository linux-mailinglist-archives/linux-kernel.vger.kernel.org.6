Return-Path: <linux-kernel+bounces-556683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610BA5CD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE92517C966
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48924262D2C;
	Tue, 11 Mar 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0jKxy4P"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE362627EC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716678; cv=none; b=O+uIF3oFX7x9/Hep1iwqam3j+/CwELMTltujVs/ejH5IuvvDK1UlKiOnJLhHUiAaIGzUv/02r+5vsKYTSqrcMPFCYw/jYbcjLEuG7W9PuGAzAXYKZTDaqFQVh8kaabMewlGFyj0PkZfMxwkO/u/t9qh/kFtnLHlYUzefXvtkSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716678; c=relaxed/simple;
	bh=AEdBNyFmF49Xeo/B4rOVD0J8zs+o9tpxxbbteCwizeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyo2CVChlb/PDMCeSH04h3rY9mwCZ95milC7bToAgX61235Le9UH4ObrSOVXz6aHXoNLf6LYnDO6t+BMhIUo5hc4FWMxpRB9d1i1lwByYhtcAGe0jC+8PmCS3sg5QxkKfa2lAi1vN8H6CT6BemtNMXxjzxtDispQJ2F1RqWDDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0jKxy4P; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1191333666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716675; x=1742321475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41PVLFX1AYbFOO8iSJTaDeh8JCGVoEDoLLcodvBXC0M=;
        b=I0jKxy4P+V7n0KD5KZGS9YBLknbcRdt7tbRIJqC72b7X3n0RgWm3BoK5unVEbN6NSS
         UDhmzyGRA9/qxGIkUDpMNxngsaAT5YdRQdZdkAGj20WhT7a3v2FFJ88rZwOfyOH22nEY
         SDzvD84QsAfmP9Xs9ex5j1co8MNelgU5VOgaO2FCKyCstSEp0SRDxw3eTwlC9aSJYhNX
         GCArfjkNXRxq9xNGhCRLSn17DRvZwDgb3xVNirP6sXr/HqKNK8m0Ji7Y7cE0bSTRDrDT
         2UZ3SPNoBFZcgqQ2I9FT0agpN1SZcnYH0KbagMeImZpHZoIVsfvPXbaP9zBbmY4610TI
         1i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716675; x=1742321475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41PVLFX1AYbFOO8iSJTaDeh8JCGVoEDoLLcodvBXC0M=;
        b=LjXt0GhYJwa2L7+KtznKWfF0mIYZ177BGvyoediwyLytPsfeiznXtIlmYcqIElEq+v
         fQeRGmMC3v2LLfFXfizKt1q0QHbJotJ5hUiGyXwgUi937O3I5bhuhxYgKlME0t+xrkMf
         1zORke9gbVyX/pn7tnRT92Wu+e/nTAmNro+6Pd+QOm9wSI8O0X+R0XHaJ96XfObs7zH+
         gpnHW8JMdLtDVdlc1K9FN2kjsG92R56ElWgmH0FgSdSI4eC9S1Zu9A3LgcvEodwLKzO/
         GYJvy4fwHBronWNjWRhZCqo+CJeccPievqUGOLC2iBvoQq2cKMmCpJaeqQlskrggptf+
         whkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSkBfCzSxzr//FwOIqj1ArtLHtgVceUKwV2Sab7upjnYEOVcJcTxMFe5YWtNyyhUa5TkumU8yg+2n3rg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8Wm1fRz+fW7Qqrb2UnF47ydLlJC1g+XYf/V1z7LZrko3e+HF
	Wrdq+L8LRPHhVrvuBiaaU91MVkoLpY02NBFwqwwaB4yzUq30WBCJ
X-Gm-Gg: ASbGncuyuapJnJkIgFSsk0+gPEJeSK2RZS+l7c6eQOpi0TnUZyh12EK5oJZTLNeQ/OX
	qccsLS4VHdDgPnn0w5LRIZtIZQ6b/wNIF+/p0sH7mKTHYznhdXOIWO6RrM2oKpucNFhxVUWWDvg
	kbaIaEK+xktC/YgZBQUv5TLehHCSFBUdjQIxuWepCUir+HsZ6Sm5irGuTVLPuSURgVWeUGEcVxD
	ZwwyNc72B5/zlGm3IfundZn4Il8HWp7qikALOvBHN5WT5qA83smKLzqNbSdrggOBRckEosopcaG
	OqN51Uw1CUO8vemziomMCjzF0GOu6fz0JNhvhXT3
X-Google-Smtp-Source: AGHT+IFuf5jV1z/9Zb7FeABCoFloU76Yb/dVd5w+lI7W53ONofj3nILLix1YBAW9+jdvFrRC0/U+iA==
X-Received: by 2002:a17:907:c10:b0:ac2:7cf9:71a1 with SMTP id a640c23a62f3a-ac2b9ea16d2mr676508866b.41.1741716674872;
        Tue, 11 Mar 2025 11:11:14 -0700 (PDT)
Received: from andrea ([31.189.82.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2929390b4sm453700066b.75.2025.03.11.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:11:14 -0700 (PDT)
Date: Tue, 11 Mar 2025 19:11:10 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Andy Chiu <andybnac@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bjorn@rivosinc.com,
	puranjay12@gmail.com, alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
	eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel
 mode
Message-ID: <Z9B8vgdTq1M9r3_k@andrea>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-7-andybnac@gmail.com>
 <87ldtck8k0.fsf@all.your.base.are.belong.to.us>
 <Z9AwF5hwF0ES9Grl@andrea>
 <87ldtbwrdb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldtbwrdb.fsf@all.your.base.are.belong.to.us>

On Tue, Mar 11, 2025 at 03:53:36PM +0100, Björn Töpel wrote:
> Andrea Parri <parri.andrea@gmail.com> writes:
> 
> >> FWIW, the for S-IMSIC the write is already writel(), so we'll have the
> >> text patching and IPI ordered. Regardless, there's more than one flavor
> >> of IPI on RISC-V!
> >
> > AFAIU, this writel() is intended to order the insertion (and the initialization)
> > of the CSD object before the MMIO writes; so, the "right fix" seems to turn the
> > "other flavors" into using a writel() or providing a similar ordering guarantee.
> 
> Yes, that's probably the right approach, or maybe follow-up!
> 
> > As a bonus, such change should address/fix all current and future occurrences of
> > the message-passing scenario in question (the patch addressed the occurrence in
> > flush_icache_all(), but there appears to be a similar one in flush_icache_mm()).
> 
> Indeed. I wonder if the SBI remote fence.i needs it?

Ah!  So I am not alone: AFAICT, that remains a matter of discussions with your SEE
team/developers.  :-|

  Andrea

