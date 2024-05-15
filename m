Return-Path: <linux-kernel+bounces-180464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497808C6EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10BD1F218AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9143AD1;
	Wed, 15 May 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pN4tAHtK"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F240861
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814503; cv=none; b=sfgr1EHcXO7bvLXbiZ2iSW/6cgx7iRPqNfhnZ+Lzr8ZVBgoD0piVjFjOqAmWGW3HcjYP7JHD04DLdps3hsra748Xo/AyBrBtXVL3tdeFaH8dixz/HaG1Ygn6o0MFf/ZRUdUSzSYE6e9YCmxcdYq2NvUUSfQSnAqU2Tg1Ok+Pz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814503; c=relaxed/simple;
	bh=xDFUM0sIcSy0DOZxqgnugThNR7lVLaZaiQ6S4YAD66o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvWAj8fN0QQJMycAB/O2TlXAmuwymp6s5oEz9PG4hoCu3cUCZQ+7dT/t1dTJmzF8Kug7Xp2geATLNvpwaBvJMFTasIYcziUD9t72fDBsHgcgrDQFvkIXyJZv5rhEQBG5XK3De/yROtiNxCF15tlB69YS4351FpAvqmOpYD6j9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pN4tAHtK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4e59081e6so4424691b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715814500; x=1716419300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ke/O00Y/Kjm74N+9XrjAq0nbRjFhCTAJyeNXJqA3ng8=;
        b=pN4tAHtKTaowkNW2IzLKHu4stbPP7AQZH/b7bNMltUj3UtSXCXZLWMX0ijcWoKuLcB
         A4BEbPvv0nQz3nyC2zDC/D95hpMPexMv/Jds+flu28etBUMMM+JR5A8v6GmUcrASKPbV
         Ywaz2tLHRbhitzcZw2eUWNt53bH/XeujPTNnfn1tgxx3+eJcKvAlv2EkYg98eUmp7GsR
         INq4mpkHMvKhwwe0+AcvmU71Kme76jj1RbaTtPwNYRBFkalZ7ENbV/ijiPUBHfwcJhPN
         GmkukInO/L4yISvaoWg4DrtavzhHBHuXI+8R54HLHHo+chD0JWeV8LFDyfaEHVs/79fi
         jmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715814500; x=1716419300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ke/O00Y/Kjm74N+9XrjAq0nbRjFhCTAJyeNXJqA3ng8=;
        b=XuWwBibiFbnht7s93kFmsjwBmoPaIyZuaXucqVHBajmi1hm8bX9p6/dABjv/iJqNJG
         fbDRAxUUJyPDoAKcXJxABBs/Ym0yKudgmEPJcATYZ61sGQHZUClbA7rGAgpMPMRD3bPl
         aR9AIRKgmGu+bDpHkJ4dI76yAb9jJVETBOJm5VxuRogrIGDYmLGr7RbPeTWHEWEaYXin
         KPCrBE5GPQFjBNzyZIuOK2Z0LAV+19CX9cNIw0ndfZW4m1LyQmE9vjSVVk/rrpiyT9Fz
         MU4YhvahaSJuFt3Pp0jRLsM/EvTXCB69cADMNaxWkVbkU0CYvHMGWfLAafXWtEx2tW5q
         NvYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDrxJCbuSFnyWG4/k8KvO5xvDyfs4p9fYgUpKLr8WnSHC0gPq7cKBb57qsAFLXcbFJzY/NULhBKi6UK0C8p8sgqs7tQ9kPxGIouIxR
X-Gm-Message-State: AOJu0Yx3vtlrZsHEX9Cay/F5tPDbdOXo3j8vlXuPnoJTqL5QgIF/yVfv
	DOrX//YNMOfZIF1mIp2E+quH5kHrQlyQ+cJmPjLxsAhy5K1aPwgFNKNGD7Og4hk=
X-Google-Smtp-Source: AGHT+IHTKntYjRB2czmnJQoB0Xk0pGWlCXePk30+bd9e9xQZBoHIBEfG3OP/NhLnJ8eL/896yjKHZg==
X-Received: by 2002:a05:6a00:174c:b0:6e7:b3c4:43a4 with SMTP id d2e1a72fcca58-6f4e035d2e8mr22362801b3a.25.1715814500626;
        Wed, 15 May 2024 16:08:20 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:144c:7973:ee0f:85cd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f9eesm11664479b3a.212.2024.05.15.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:08:19 -0700 (PDT)
Date: Wed, 15 May 2024 16:08:17 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 0/2] riscv: Allow vlenb to be probed from DT
Message-ID: <ZkVAYeNnvj99YHXt@ghost>
References: <20240515-add_vlenb_to_dt-v1-0-4ebd7cba0aa1@rivosinc.com>
 <A9EDD470-B8EC-4644-82A0-7444729EF885@jrtc27.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A9EDD470-B8EC-4644-82A0-7444729EF885@jrtc27.com>

On Wed, May 15, 2024 at 11:25:16PM +0100, Jessica Clarke wrote:
> On 15 May 2024, at 22:50, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > 
> > The kernel currently requires all harts to have the same value in the
> > vlenb csr that is present when a hart supports vector. In order to read
> > this csr, the kernel needs to boot the hart. Adding vlenb to the DT will
> > allow the kernel to detect the inconsistency early and not waste time
> > trying to boot harts that it doesn't support.
> 
> That doesn’t seem sufficient justification to me. If it can be read
> from the hardware, why should we have to put it in the FDT? The whole
> point of the FDT is to communicate the hardware configuration that
> isn’t otherwise discoverable.

Yes you are correct in that vlenb is discoverable on any conforming
chip. However, the motivation here is for making decisions about how to
boot a hart before it is booted. By placing it in the device tree, we
are able to disable vector before the chip is booted instead of trying
to boot the chip with vector enabled only to disable it later. In both
cases when there is different vlenb on different harts, all harts still
boot and the outcome is that vector is disabled. The difference is that
with the DT entry, no vector setup code needs to be ran on a booting
hart when the outcome will be that vector is not enabled.

> 
> As for T-HEAD stuff, if they need it they can have a custom property.
> Though naively I’d assume there’s a way to avoid it still...

T-Head does not expose vlenb on all of their chips so I do not know of
any other way of getting the vlenb without having it be provided in a
DT. That was the motivation for this patch in the first place, but
making this available to all vendors allows optimizations to happen
during boot.

- Charlie

> 
> Jess
> 

