Return-Path: <linux-kernel+bounces-294717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10995918D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74848B23730
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBB4C9F;
	Wed, 21 Aug 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5hEnhVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358914687
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198659; cv=none; b=pBbjD13R9h1VaDAcvxtejb+/I3ofy/Dsg7zw0mndnOHZ1zm80k3akjpcHTdL4jkaW5QW/vnw0XpVHu8xDtR/0QfJpVAbZGyn/5pYZ/PGrBqU90oYegLSVOYi81owpLer5TsDAwIxappv9Cs48DRk9fKBEjb2UagfyadnC1a3z+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198659; c=relaxed/simple;
	bh=n2nuOeIyJq1hYjiY9a0jvifNqlY6SYRcg7mo6AeIv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo+0FFWMFPT6MNkitA4O7UJqVnR1ycQVFORcWayFvShtDJUhZtYlDEnZJaUpHg+Ok8Swif+Jr6x43QVmIQbnLEFqcZHTWYUJhtq9uBtUpy6zw4iU907NUvmt6z9crMK96t+FbzI6I+sYRcPnmItGZ87KZG1wtwtK7vcke1xGnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5hEnhVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5462C4AF09;
	Wed, 21 Aug 2024 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724198658;
	bh=n2nuOeIyJq1hYjiY9a0jvifNqlY6SYRcg7mo6AeIv9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5hEnhVZ55f5oE/tuLwiquCrANZ/Ae1uy/aYPBuom/JejDOOvnG1qA0OzbqdkrCL1
	 AxB3Aph/jmIlB5O2nVv7xtiXkRr4zTenhyThjgZToa0vaSWNmtUl/jipAzZeXgQ3cP
	 sAHwAEy3ebMk5M26Bmcj6ulb1IuEzTKC38is+shDNfdb60ir43Znj8hG+6goAnydBu
	 nt5wmCAqD09kRrowCF8/6wjmSnxReT8Gy6hEjGrpRG6zpwPi1hea9WpksKuu6L1HTi
	 gYinebnZIamL0x/eO+RBMbQ1vHEjtGxVb3TT/y7i/pSB13tukDLJOoFnfqZYFM+t57
	 wUi81nhgCsAEA==
Date: Tue, 20 Aug 2024 14:04:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <ZsUvAUnCjFp_jviq@slm.duckdns.org>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
 <20240820235412.GF12106@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235412.GF12106@google.com>

On Wed, Aug 21, 2024 at 08:54:12AM +0900, Sergey Senozhatsky wrote:
...
> Well, this will make the tree unbisectable (for a range of versions),
> because the errors in question break the boot.

The span is three commits with one htmldoc fix commit inbetween. If anyone
is unlucky enough to hit that, `git bisect skip` is going to do just fine.

Thanks.

-- 
tejun

