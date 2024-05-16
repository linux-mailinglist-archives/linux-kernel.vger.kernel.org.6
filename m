Return-Path: <linux-kernel+bounces-180525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC198C6FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96774B22AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BFBA47;
	Thu, 16 May 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/0rnoIm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937510E6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715820948; cv=none; b=C+q3xvfgEnfZi+VcuqhZ2TOoyoCunc7sEbc4gHcdRc8V5vAZRuwUoIj1+iH79AjwD+4MF+R2NbAYYiiTf+hVrIzwWk7FSDzzl9NiJ+eyMvTxyrJLA197/INNz+RkXRUHwPsgriQ8oOYyYa/7v/QSxBiyS98K1B1K4r3w+o6Yyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715820948; c=relaxed/simple;
	bh=jq5NDsE8krBPRzdizrRrNw7LvlIgtZ8hTHVxl8AhAN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU9XmoWhcdGGUge5pEEE2xpDn4x+4u85DGi72VRRnjcQZVakNgUQuLzCX73O7V6z622/H31fyETshhryLXGHJ2l2O391J04XKTUIbEMTPcRMcY2ahbTotH/YG7OQptbvGiaryTvJrT3oFOG8j+d+AkVbBzmCBy9pqjh3NO0xzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/0rnoIm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ed41eb3382so54885835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715820946; x=1716425746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2P7yzLxBnzMoi3fENFM/uxjPiVfW548Xp/8Kzh664X8=;
        b=Q/0rnoImr4LxmuYgLpbpWSdvOcjA7bUvJvHdWkx/d1NOEJgy7eY98Po6TsEPDTTsHc
         ztiBfhvkN6gKw6cEHGbNzIJvwe7K/14KH/j6cmjxjFK6MVSkiRG0+ICmt8bdpNHlK+cs
         /hLBO1X2C84t428ahAQtn9gYgXQZ4TRiIxHQC1ZlmvxboyBDGhvCusk2J0YHqnr25fL2
         8T6KlyzwsbIGL9LFu+sUnRlR8l3pW70Qaf5Ju7mlAdR4PXqX9UmgXktEFuT+uaKdRYmS
         q7em2g3Nda9r01VRXyZA3CXJiohURExDcK/pF563KDpY+J/bkweZSdGPgiOVmCOIlW/Q
         bjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715820946; x=1716425746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P7yzLxBnzMoi3fENFM/uxjPiVfW548Xp/8Kzh664X8=;
        b=pMLUPiXCxMC+IShR1YLYZ627RR6dgBoC4NvelOys54VQxW2KA51F7FqkLH2Vy/3yg5
         wUst8yHnMPYqagFEDyALTOsAavO/wqKUy7YDEcqjWjlxfMPVL4ntc67mnZjGf6olK40D
         7vm79qYY6Jp+Ebl/wmrbk1k380BngUABfGvB9Pe4k7gR3fMNPVmNM5r79enzllOu/qkK
         wvyQX1FxOn0yTNwLfJBUGsTg2BM7i3ykWVcoN5Zkh8S3YtRjZEzHQT1bdjontepF5LkT
         0B6UeaaskwRD6TjGzxNpn/Ey74DnnnusCYGQh/r37HfnR1NTqVTZDrQUq5epCh3i87jq
         mIEA==
X-Gm-Message-State: AOJu0YzSoqDfCshktX9Uku0FpKaNw8mzdAyi48FNt4jvdH6w+nhW4B/j
	O+ZCorg4zsFaaghwAViHtVCq/8PfLpXjEEEu1t6cGTDsuqKWWi4sQsliVg==
X-Google-Smtp-Source: AGHT+IFP9UzNqFN3rtStNkZ4QamF72vcYLYbBpSsl3w1iuUzxxHKSJ6JjFDspq9ylcK8VtYZMgV49g==
X-Received: by 2002:a17:902:f602:b0:1e4:19e3:56cb with SMTP id d9443c01a7336-1ef43c0954cmr300407625ad.12.1715820946492;
        Wed, 15 May 2024 17:55:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad99a4sm125195945ad.81.2024.05.15.17.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 17:55:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 14:55:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [GIT PULL] workqueue: Changes for v6.10
Message-ID: <ZkVZkJPznWI8Y6ZN@slm.duckdns.org>
References: <ZkU2kmQxdZ3jRfyB@slm.duckdns.org>
 <CAHk-=wjTVMV2hBx6pQDBuG6sn75CtTfXrm8TF977fL9sqwnDFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTVMV2hBx6pQDBuG6sn75CtTfXrm8TF977fL9sqwnDFg@mail.gmail.com>

Hello,

On Wed, May 15, 2024 at 05:36:48PM -0700, Linus Torvalds wrote:
> On Wed, 15 May 2024 at 15:26, Tejun Heo <tj@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.10
> 
> Hmm.
> 
> You seem to have tagged your test-merge, not the actual commit you
> *meant* to tag.

Sorry about that. Yeah, I incorrectly tagged a test merge branch.

> I guess it doesn't really matter, but it's ugly and brings in a random
> merge commit with no commit message.

I'll send the corrected pull request right away.

Thanks.

-- 
tejun

