Return-Path: <linux-kernel+bounces-441742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F19ED355
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701CD281C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F311FECB1;
	Wed, 11 Dec 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Hwse0Ju8"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF821FE479
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937881; cv=none; b=cuzGm+MzCP8LgQw2kureHBisp+j08xEYIyxFPmfYe5/oIn5IxhGf3G7aoCF9NkV7Pa0+FsmiB4KxOOHEc8Wm7OoUz3papo6Ae+tgYVCffYMaH5ttIQEG+Q4msbpE6juc+u7Ti4FFT4d89QbPOZD5oBz9SPpwxPW1r5YP5ip/ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937881; c=relaxed/simple;
	bh=TdrJ0SbMmqk7tEl4kBb44qSI7X5fDQGS/pk1FZgb02Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o19RLQpx7Gcz0SfI2ncDjR2tusovlLXlVvX6BYRxfmpGpLubhWnL97Tl6v6yt/5NHhxi2y6VAwNApgqRN3ApRRfi+m0fa+TyBizE+QE8rzVwnukT0ATe+1PNG6dVn/dZoy9/g864r7AgXrPw9/iEQeVZc5u0rYfu2nI3B2L4KIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Hwse0Ju8; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1733937873;
	bh=TdrJ0SbMmqk7tEl4kBb44qSI7X5fDQGS/pk1FZgb02Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Hwse0Ju8R5dII5eg932tcIQzr2y+1bY0mSoRggdOrl7iOAQiNvPGM7OzH26zxUVbf
	 Jp3k5sWBsxRaLkttKizM6VOqb+1gkhL61u5O9aGuNJhSvlphpQNnltmfwFJHZxRiXV
	 toNCDqZ5oXWivPlnkCWvSX3BX5DvEpkcDmXyKJ3Y=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7CAB8406EC; Wed, 11 Dec 2024 09:24:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7BCB7401EF;
	Wed, 11 Dec 2024 09:24:33 -0800 (PST)
Date: Wed, 11 Dec 2024 09:24:33 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Will Deacon <will@kernel.org>
cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com, 
    scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
In-Reply-To: <20241210113151.GC14735@willie-the-truck>
Message-ID: <6714a00a-220e-c43b-7f06-4a2397159cd7@gentwo.org>
References: <20241118181711.962576-1-yang@os.amperecomputing.com> <20241210113151.GC14735@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Dec 2024, Will Deacon wrote:

> > With FEAT_BBM level 2 support, splitting large block page table to
> > smaller ones doesn't need to make the page table entry invalid anymore.
> > This allows kernel split large block mapping on the fly.
>
> I think you can still get TLB conflict aborts in this case, so this
> doesn't work. Hopefully the architecture can strengthen this in the

Which platforms get TLB conflicts? Ours does not. Is this an errata on
some platforms?


