Return-Path: <linux-kernel+bounces-195671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC728D5016
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D061F247A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB436AF8;
	Thu, 30 May 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPMvi93u"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077A18755F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087694; cv=none; b=Vp88h1XNU61IRrv+POmJXJ7Nn0LPf90kveyBe5Y4jblVacDM2Y+UaeB+y4svGkINccx2mp1OgZRskPLAwt4s0bkkn3QuT47wGJ9+HRDGR9/RzcfnBZ/yRtmGKfQI36IXNHLFD2gQEmlO13Up6CxaSKbB5HAi/TkhEy2j2TTMVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087694; c=relaxed/simple;
	bh=+iibMyBe6CkUG/bW0sWYlzZX47cbTNxCC4APHJZN4KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjljJgpO0qGr8vI38XBTCrHduA8UnDz3i2ZWeWWKEa9YTjaFbyD3L1HJtMvCIsxnMFgM/vmj+dVr1O2dtj9mKn9XBZ7tPVPdecI4BdgRCPslNAsTdydqBzNROiwFi3q6pRBvodfLkvlEFFIYXQ1toGbKnFaBYlCnr7EcVLeEnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPMvi93u; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so852485a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717087692; x=1717692492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44kjXC5ZdbVBGNfJAzWqyaTd7dhWd5azryjkTcby7nY=;
        b=kPMvi93uukPjZ+MezFr3+G8ipQ5t1itS/fVt1y1diguN6dq+k76uxQ56n5GBad8kxt
         9/apDcIHvx/4X7QXkac7PgMSr73dGfFadiVwrSrhXzCh45J5hnQSSBr+oN4SAoVSk8hU
         W/RgLAGbKYKlx29xdiRooN7J+1SNXVKtkXhzKZtgp5xGcB3YRJYJyjotW7eu/Tk3IU/x
         OU7PHYd1B0ocgcVqIjNYFSoBf6N7FhEtKP0qIHH5QvLyStV7zJoz4GcrUNOFu2ldHcNW
         hqvAlQqTLBvfiW7bXrpym2WohP5mq5RYt6nTr4RJ2tbxGPCKDPnT5KJ1+MHlRsRQHHVS
         mJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087692; x=1717692492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44kjXC5ZdbVBGNfJAzWqyaTd7dhWd5azryjkTcby7nY=;
        b=gCPeMs1Ri6dw6qkKoFviioxRfqxZ9FA8jHJbvPbj2AJOK0ED84SZFcQ42yllaSTiSE
         KsegU5RbjOUyCXWwUJQImkYSHwY+/LsAGh7ZD6wREorzcAGgxXevPeDw6K9FoT9ICSct
         AUry0VJ3bHlHuZ1QqXGFsPxsGgnPjt/Gl7NDrreG4p5l6UElqpqUrTN7Cjy4GtYGBCEu
         LTniG3qY+asWn2imfvwiCdEQe3CcGTVH6ynY5N6uIHdW725CrI/duhzj0n2nsYYekzS2
         qED+bLziEJ9ZfmxDN4qcu0D76i3lGbJWwAJaHG5I530PzPZrmeKbg5MkR9H4bOOodRcp
         v8oA==
X-Gm-Message-State: AOJu0Yzyl77KdXVS1TIbQKzACyk4PxmeXlQjZlm/FudnLeWp3yap6z+Q
	cA3sfH4KycT2iTaRo1gh61fbHadP9Y/kajQVvAJHKjmJUMbB9MaepZd2WA==
X-Google-Smtp-Source: AGHT+IHIby0s6tirUbLWLYDO5H4P5p5ypbNhdZYQIBQtdi/dLFyr5oREZHgrftNscdiFXS3h2uA93g==
X-Received: by 2002:a17:903:24c:b0:1f3:2a25:9361 with SMTP id d9443c01a7336-1f61a4daf21mr28561355ad.64.1717087692453;
        Thu, 30 May 2024 09:48:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dd6bsm97555ad.54.2024.05.30.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:48:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 30 May 2024 09:48:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <475891b5-6bf7-4ecf-a647-9b9b554ed07c@roeck-us.net>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>

On Sun, May 26, 2024 at 03:31:45PM -0700, Linus Torvalds wrote:
> Ok, the merge window is over, and 6.10-rc1 is tagged and pushed out.
> 
> This seems to be a regular-sized release, maybe even slightly on the
> smaller side. All the stats look fairly normal, but "normal" obviously
> means "much too big to post the shortlog", so below is - as always -
> just my "merge log" that gives an overview of who I've merged from
> with just the barest of descriptions.
> 
> We don't have any new filesystems, and the xfs online repair work
> means that the bcachefs fixes aren't even the biggest filesystem
> change any more. But all of that is dwarfed by all the usual driver
> updates (and, as is tradition, GPU drivers are in a massive lead, with
> networking a distant second and everything else is relatively small).
> 
> But we do have all the usual architecture updates, core cleanups and
> fixes, tooling and documentation updates.
> 
> Please - let the testing commence,
> 

From [1]:

Build results:
	total: 158 pass: 149 fail: 9
Failed builds:
	arm:allmodconfig
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	mips:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	powerpc:ppc32_allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 470 pass: 466 fail: 4
Failed tests:
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd
	riscv:sifive_u:defconfig:net=default:initrd
	riscv:sifive_u:defconfig:sd:net=default:rootfs
	riscv:sifive_u:defconfig:mtd32:net=default:rootfs
Unit test results:
	pass: 228437 fail: 0

The problems seen in those tests are all fixed with the following patches.

9ea60fe541a0 powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64
005cc05a58df clk: sifive: Do not register clkdevs for PRCI clocks
71a1fd19a06c sysfs: Unbreak the build around sysfs_bin_attr_simple_read()
d304cefdad3a drm/nouveau/nvif: Avoid build error due to potential integer overflows
2afea78e811e scsi: mpi3mr: Use proper format specifier in mpi3mr_sas_port_add()

For anyone in details, those patches are available in the 'fixes' branch
of [2].

Guenter

---
[1] https://kerneltests.org/builders
[2] git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

