Return-Path: <linux-kernel+bounces-195493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032798D4D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7E61F22DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1340186E53;
	Thu, 30 May 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4FuDl3i"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439D186E3E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078166; cv=none; b=Dafz2J1KBdvlXavCI3jI4T9xy8iOXi4zk0l9Wrp0cyfpqJ5J8jDf+rjKE5PdqHb8+AERD8jJgqq9RM/or3fA/Y/NvBP592XlEZwf75CKdWm/5BbZE99CEsn9xzI6a7aB2RbVSevM6rIoBDZ6TJ8TtpJOXhiHdR3xz5KfwX4opww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078166; c=relaxed/simple;
	bh=qPa1tPluiOzkQU3NbAlQqu76f9puWu8Zmwi9kLfJnY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaJ0IrxAJlfzhdp5bkxzbTN+j3c2DEaULghj9Xf4Q7Tbp7/wgseNTJZvrfgJVCq+9F3ELO4BQ2HO+bJFnezqYmPORShJOGZ97sCkUB52TdUXFeXESf7WWy6Fa5sGY/gOCJCdRIZJFDfFqFDUpH/14lG6Ibq2cjC5b8pb5RylsAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4FuDl3i; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52962423ed8so1163816e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717078163; x=1717682963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mflbPVUEVN5KoG/50XqrCGHjXlLJoerBkLPgw0zOWSg=;
        b=P4FuDl3ilOrsHMXE76hOhWYV2F518AcZOHulB+o4AtVx7jvC0ChOVw1lvM1yc5TQGs
         ZHD5gM/L1JbMK6CkaGjV+XRXyTNpMdQzWD9VeZ0lmTcy0bNskVGlA/kjsTs3yZR34DjJ
         J72J6BPB3tSiZ7VLr87Vn6/X++pdvcyoFJ8E05Q6889wSWScspZc+Zrqv8Y35yOmdRNA
         KN4+mfd5pb8mJVYzofoWK6jUl7upWvYRHt/7zg61j70rnYO1IArV3X3cturfKotNMQzR
         LqzYWetuCepJzR6pJnVQz2YhdnWh+2boVAAD0elghk9u6Ds2h8aVCWxFz5zwPNKxAzR7
         goYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078163; x=1717682963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mflbPVUEVN5KoG/50XqrCGHjXlLJoerBkLPgw0zOWSg=;
        b=AdsQinwxmxG1RHiB+FlDqgZv0Uydv5SWqLq9lgkP6bMVQULYmYScPSzzxqo//HwkfP
         bKi/bkBV42vQoxA9ujte1pzrnj8BsvvSsegAOl1zYpcyr+OSnYz+h00wdLNsRD28hiYc
         PORLea3kvtpq+eRPfp11xi6OuT5yaXzX1mlr6p8vAA1jA8rXu3a7lw6X42LCz24jw2HP
         NH6OSOneINfl662cTwmoOVJH+O+cLld0qLI7ITQkD0OH/+Nea+QaasZQ5o91P4u9s+pb
         RbMjVU5WbGIuSkwIMIckt9rnoiS6FrMipEpborZ7Ze3KIZnR7QsPzgfW4WwoRXTkmL78
         3hqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjorsMnxMb0tYeGqToz1LRIgztdXws1laV3t9K//CP03nGaV2quCNuUiMEjL4trdFEuY7CGetfDOn7jJC+mc32CLJ7fO+z5SyoLvt
X-Gm-Message-State: AOJu0YwAcVm5hTaVpjWMPinPoB6wytIlJ67+sxW3QL6xST6h7ha7KdYJ
	CyZJL4AXBkNmhpF1u6dmje5yNTSTuOXFjbJG2MBjnUrSdOBgoCBDQf9HbA==
X-Google-Smtp-Source: AGHT+IG2pcFtvxeZ13j+AVA7gE9C/9R2T3iDq+lSthzGXcayIpO/isarwQfFK8O9nusR2DNnU5XpeA==
X-Received: by 2002:ac2:4218:0:b0:523:8838:cea8 with SMTP id 2adb3069b0e04-52b7d4919damr1570148e87.69.1717078162433;
        Thu, 30 May 2024 07:09:22 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785cb3a3dasm9195355a12.67.2024.05.30.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:09:21 -0700 (PDT)
Date: Thu, 30 May 2024 16:09:17 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix fully ordered LR/SC xchg[8|16]()
 implementations
Message-ID: <ZliIjQvbQRGq+oL0@andrea>
References: <20240530075424.380557-1-alexghiti@rivosinc.com>
 <ZlhpA9NsgI0z6t/E@andrea>
 <CAHVXubi+XW=v=MKDov5j0v2QG-cAMjWxdqMRhgfLmo1JhCkryQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubi+XW=v=MKDov5j0v2QG-cAMjWxdqMRhgfLmo1JhCkryQ@mail.gmail.com>

> And you already told me that privately...Sorry, my mind has been
> elsewhere lately...I'll fix that right now.

Np.  While at it, one nit below.


> >  #define arch_xchg_relaxed(ptr, x)                                      \
> > -       _arch_xchg(ptr, x, "", "", "", "")
> > +       _arch_xchg(ptr, x, "", "", "", "", "")
> >
> >  #define arch_xchg_acquire(ptr, x)                                      \
> > -       _arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
> > +       _arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
> >
> >  #define arch_xchg_release(ptr, x)                                      \
> > -       _arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
> > +       _arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
> >
> >  #define arch_xchg(ptr, x)                                              \
> > -       _arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")
> > +       _arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n", "")

The plain string can be replaced with RISCV_FULL_BARRIER (cf. asm/fence.h)
to match the style/approach used elsewhere in this file.

  Andrea

