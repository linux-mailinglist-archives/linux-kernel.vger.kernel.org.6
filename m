Return-Path: <linux-kernel+bounces-281368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEF94D619
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A631F24509
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5C1465A2;
	Fri,  9 Aug 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2Psol4Z"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CF28689
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227079; cv=none; b=f2iAPbRgeJA/2lXHwksGIdPYNKUhePnGLqRrV0iFWA3dPxNGNgzitmPrjv1p3VB9CnvJkMNwoC2w+Y/Z176qjYwfCeblWcPNYfh+CklDksYVX9F8l9FtE1xI8eiOhXiR4Ez/6j6NNyT1/x92UPjLu3uHvGjmZqdVwArcFsad7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227079; c=relaxed/simple;
	bh=dU+r7VOamTbIzKRGk61+3yej3hQO9UMG0n5WJf0sSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=njrI/NbjfwToXgfqNb3C383agjwarioaKzImAdIEfjCRK3XJB264TYfWzNzeZFSGg8dTAzKsa8pQGYWBa2jUagd6SC+FZd7IzzojfT6pEiDiWzsM9VpvdEKz02uvSyQZ9cVvHG5aC1FrjzKk7J3HZ/EhnFS70pc7hPpFSDRRrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2Psol4Z; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-264545214efso1352147fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723227077; x=1723831877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuw7T3Yt3Ctu569RBxvbnGXOxVG7cjyb7fwS4T6fpes=;
        b=H2Psol4ZJecUMBKwhX4NeLbTwxDmdm8sONuBZFEBLic7E29kYJlQNoIYsyalAK68RB
         pFJAwLVX7K5YhuF29x/KCaCPPJu4/hKTb6biFY5e4RxrLLICKoRqmtTMOQmpscCHomRe
         fF8ww97NEcQsUa2726a/4lhJwOuBVctwdtQHg3fEQ+VbAAKB2dEahTYVJSyrynpAbwUq
         RAU72M4ci3BYqrH634i+AYb1kghR8ouxVsHjL7UcQ7vRJG+ADrDGlEyhsNU6z07gObyg
         /xdXBtP0Ql7yUR5AYGKHN9mObAjsHY8n8BWC5YeqruDCC/oVREFIYLCU6MvWGi4QLKco
         0iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227077; x=1723831877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuw7T3Yt3Ctu569RBxvbnGXOxVG7cjyb7fwS4T6fpes=;
        b=YFL5zQKVC4UIfltiUPXu9KKWkCo3lmrf60KuvMReTO3pZ7fvqHQk8QTAyIUCRLiLZJ
         YBcb6oYO80UOKKeRUgO2gZlZGkK1xTnRAmxSnTosvSiX3DXUx60ztI5CHdlUGCS2e0fI
         E3pgW5Ay5ISBVUMmSbxhJsMk8jZpdCJEa5baYO2t9d0BTCld53kmDx+dq9hT4oTsMhqc
         4rgM9Xq0RDDDumDeG9L1yNhtTUITyh5xsQJQXJNkuVQsNgI9VAzox0+0nqO6tObG2lm8
         q5ejoTRJ/oDHmldPJuNZw1B17EfJRUMbKuAhch4xp+QfKF3UIGAO4+X4iP+kOQH7xUST
         t7sg==
X-Forwarded-Encrypted: i=1; AJvYcCVlTAAu/pUW89r/hVkNDTw456z97Ou9+nlNPHqJqGh2dW+NVtAGOI0zKTXjol8Ot7GnDf9gvzxWl/TI35tZ2II/gD0YqHYxnzfe3JC9
X-Gm-Message-State: AOJu0Yy468fMz8M/wzTNlewV6vbMPsZJdTxGRTje3y0tw31gUnxKAtuU
	3zt1Cr7w84gfqXs3hceA9D5VRzwE7EmCfKAs34v5Jm6PJ9ZPK9ps
X-Google-Smtp-Source: AGHT+IFdeYtwrlXkAvUrKn2wTRAbVNVOcZZaN4uZIrAoeLv5ToBzVzgbxsW04xClxGacuJmBVkKi/g==
X-Received: by 2002:a05:6870:e38f:b0:261:2357:5a29 with SMTP id 586e51a60fabf-26c62f9f8admr2630828fac.46.1723227076604;
        Fri, 09 Aug 2024 11:11:16 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8a2f5sm44349b3a.166.2024.08.09.11.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:11:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:11:13 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com,
	salil.mehta@huawei.com, shan.gavin@gmail.com
Subject: [GIT PULL] cpumask fix for 6.11-rc
Message-ID: <ZrZbs3oPNhzqR3E2@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The following changes since commit 5819e464a17587e6830cfab05f3e91a9a8753a41:

  cpumask: Fix crash on updating CPU enabled mask (2024-08-08 10:39:41 -0700)

are available in the Git repository at:

  https://github.com/norov/linux.git tags/bitmap-6.11-rc

for you to fetch changes up to 5819e464a17587e6830cfab05f3e91a9a8753a41:

  cpumask: Fix crash on updating CPU enabled mask (2024-08-08 10:39:41 -0700)

----------------------------------------------------------------
cpumask fix for 6.11-rc

Hi Linus,

Please pull the fix for set_cpu_enabled().

Thanks,
Yury

----------------------------------------------------------------

