Return-Path: <linux-kernel+bounces-292957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012799576F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02E11F23DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8BA1DC490;
	Mon, 19 Aug 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykPThEUD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6CA15AD83
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104665; cv=none; b=Yzp7lBe13bCPeXBQcdsb6Hpx3CdhT6yyta5StcId8HIYv0xy75R1JOfw4W4wIJalTN79AthWswSWaJsFMpMYppz/D0+6vwvDyZHlMe059uSTnVRl5oB0u/LCoeRpzpXXifsm18b9f7NCazXgW7sEVS2swFGe4tnBO6XNToYr3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104665; c=relaxed/simple;
	bh=11AWEfeX8gkNsffN6s/jopBvYp//bAcM4ZD0b3umqus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKx1bgSipiqKujarTQU94C/wpSxHy5Nz+AoHTapgOsg+7d9xD2xnnOGYq/zwOpP/EHAvniDkE2dFirU4ZgH6PqKXrRuldugM9IGna6IsW+GCRiyjRpq9piS0e7ArpQLDGfxMaUqh3unCYc1d8TJfo2RceSOz5xOijPoP1MIFDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykPThEUD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-713edc53429so1324766b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724104663; x=1724709463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jPe01YcT8Gb8uoOTu47oxOa1X4IlqTXEEaghEJldB3I=;
        b=ykPThEUDdujpeop19zSKPE51YO6aI92nhtYNDBoqRpGM/nLpK5BMDDZ2D0HvXjwIHP
         3LYTWPOcBdLe5f6M0mmi4P/ykXBwlZzksqaLuJTPKrj+BtSlsVE3GiMXNzUjQEyycyE7
         jz7P+xan/g6LZuxr1Smo8vQO11619a7gZcPWBNoW1XNTjXyjqLvI0SoWj2nhMAdbOAFy
         f2t2zWlCnxyztOJPEjg4+gRGRzabAyuUqz5aEYMiDLS8AT6QhM5cs7PDeM76kwn7xGXq
         idMEa0xGbaR3zP645khsoDwklXmrfhGimtYUU8tXOzym83Gf4NmxpodWa2lJNxhOIEDM
         Gppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104663; x=1724709463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPe01YcT8Gb8uoOTu47oxOa1X4IlqTXEEaghEJldB3I=;
        b=fPOGZtHkqVlOACFtDtkjpOmRiTnTqaAnksv0nAheCSM/USmUl+VQePGl0+nTo7yRAX
         VC0sGXfSDcvxDd5wTEOSEdxYPbwVG3LKyfBMWXCZO5k2JDGYJ5pHdv8aIhj6s/v8R73f
         MM6x1T4UAl3SXRzeEkU2pSXb7cWxLEynzt90zlM4AT+XE0H/G/5+/DNgEI+SpyRVHqds
         j8TFnp0JYzmlEry/+k2QBQ0oIr9eMJBYKCxjyY8IpltBRba3C6j/tW0wg8rf4y1jFbF1
         UEKdomSUkyj+2UxpAHatF7Nh1yQ1+FSfG6vXihXXGs1VPCuaqEWh0wrF4WL7QGGZB7Nx
         1BPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtXeFmcRESL6a7GI34QfDA+sz/un2OfAZj4Q0nuijNbr6ahMQCkbcymAzqtYLN65AvAL8W+mnKaPff5Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyyCVoJ34LUZrjllfuYEvR3XnydMLEokxFqmbCFqmHuBmgDco
	7/YrrEn/YdWZXLVdyiSxRGTEmLv9TctKM8kHkSF3TSE53PDX2p1XDqkENOBsrQ==
X-Google-Smtp-Source: AGHT+IGkVnv3j3x/OZV8oCttMMGrwCrhUjxZczJ0g0gJTVKT3XRuoNTXPGo1tEKRTpwDQeRZh5PHVw==
X-Received: by 2002:a05:6a00:14d2:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-713c4ed2c6fmr11932026b3a.23.1724104662882;
        Mon, 19 Aug 2024 14:57:42 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef3c47sm7005835b3a.102.2024.08.19.14.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:57:42 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:57:38 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>, pbonzini@redhat.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Split NX hugepage recovery flow into
 TDP and non-TDP flow
Message-ID: <20240819215738.GA2317872.vipinsh@google.com>
References: <20240812171341.1763297-1-vipinsh@google.com>
 <20240812171341.1763297-2-vipinsh@google.com>
 <Zr_gx1Xi1TAyYkqb@google.com>
 <20240819172023.GA2210585.vipinsh@google.com>
 <CALzav=cFPduBR4pmgnVrgY6q+wufTn_nS-4QDF4yw8uGQkV41Q@mail.gmail.com>
 <ZsOPepvYXoWVv-_D@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsOPepvYXoWVv-_D@google.com>

On 2024-08-19 11:31:22, Sean Christopherson wrote:
> On Mon, Aug 19, 2024, David Matlack wrote:
> > On Mon, Aug 19, 2024 at 10:20 AM Vipin Sharma <vipinsh@google.com> wrote:
> > >
> > > On 2024-08-16 16:29:11, Sean Christopherson wrote:
> > > > Why not just use separate lists?
> > >
> > > Before this patch, NX huge page recovery calculates "to_zap" and then it
> > > zaps first "to_zap" pages from the common list. This series is trying to
> > > maintain that invarient.
> 
> I wouldn't try to maintain any specific behavior in the existing code, AFAIK it's
> 100% arbitrary and wasn't written with any meaningful sophistication.  E.g. FIFO
> is little more than blindly zapping pages and hoping for the best.
> 
> > > If we use two separate lists then we have to decide how many pages
> > > should be zapped from TDP MMU and shadow MMU list. Few options I can
> > > think of:
> > >
> > > 1. Zap "to_zap" pages from both TDP MMU and shadow MMU list separately.
> > >    Effectively, this might double the work for recovery thread.
> > > 2. Try zapping "to_zap" page from one list and if there are not enough
> > >    pages to zap then zap from the other list. This can cause starvation.
> > > 3. Do half of "to_zap" from one list and another half from the other
> > >    list. This can lead to situations where only half work is being done
> > >    by the recovery worker thread.
> > >
> > > Option (1) above seems more reasonable to me.
> > 
> > I vote each should zap 1/nx_huge_pages_recovery_ratio of their
> > respective list. i.e. Calculate to_zap separately for each list.
> 
> Yeah, I don't have a better idea since this is effectively a quick and dirty
> solution to reduce guest jitter.  We can at least add a counter so that the zap
> is proportional to the number of pages on each list, e.g. this, and then do the
> necessary math in the recovery paths.
> 

Okay, I will work on v2 which creates two separate lists for NX huge
pages. Use specific counter for TDP MMU and zap based on that.

