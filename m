Return-Path: <linux-kernel+bounces-262907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06D93CE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BFD1F24281
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63461741F4;
	Fri, 26 Jul 2024 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="XP0wf5dV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23823D2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977763; cv=none; b=rwk8ArHsOkCQIGlZtuiHR6qDM87lIZuqo36v+x75I5RdyZ7wuc0izqX+zldfw3iE72Jd7Uwdzo1RL89Ad0uO6pFyU7sag+SyjRks6MMrs+i5sQtXKXomOokWkj3eqi8gjjcNEI4krSrxXFcgeB53KcMZNpFmvz4Vh2PRyXLXgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977763; c=relaxed/simple;
	bh=7Z0Ipny+/EO5mDBlLA8o8pEfHzy3PJBPjInwU1ZukTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl57IZWbakQjrlfdQG4Z4IH8cMrfcLv1Diso+u29c7Aopq1oQLBjMLxfEw7yEh79i+GUoskDCdNN+Y0+7CZADDOzOAyoWhkP2HmzdKRnjxgr5dbfCCCrNfTr2zWW2gQuxnVTsmnnvzGwtmMJP8bcIjlrgUAGEBWJzDXIL4lg3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=XP0wf5dV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fec34f94abso3422065ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1721977761; x=1722582561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIi+1n0BE5cXO0JfUgssmN3IZj5Yaclq0DA86undi4g=;
        b=XP0wf5dVukm2F0hyQcKtho3DpJjA4CuVCGke3C/SjXoJ2/zTT6s1qqx3NetDFMKV1k
         fctlMXSzUhGrJkLFDV71xGVqJbfe1vlnN+gdz+4r8/NkKlIGw/BbZbtNWvolvzm4Q1t0
         DWlhwB5cFNeuUqFwCXicZVqDnEg7o7pIKm+xuArrXod34MSElpzeLoKk3QTpC0SxrO3E
         F+Wrs9ViJGzT728kdfX2IuYexyclVruIiyina6ttaxyN2bClzaRXqAvq3riHDNEIENZI
         W1FJaJj9LrIZPvA+sHut2NJxr2Wr8Qm/bhVxIEBXBW+9qKUprXl6WqhtXYvG03Aq0mCk
         ksPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977761; x=1722582561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIi+1n0BE5cXO0JfUgssmN3IZj5Yaclq0DA86undi4g=;
        b=P9HlXOcZKNkU7X2ytfd7omuqXieU95F4Q11/B4slaPJmzPg2ihiGO5WL+T9JmVqMU/
         XaYF6e44MJoNqSoaZQiEv2pivx1TebuI3DSCMfnhUD8tc2xL08Ss8NpkBX0kuV8YeKua
         bvBdC85RzoRuwwmG5JAuT9rMJdXhyTrY56hQLe55un3cqAXbB5sIjmxigCrM/QGhuJ63
         FrwWKksLy287kF9jCDgVmcN9vxY9OynTyKfJCjfoeuYqlbo2m8+dAr8rKPes35JGIUCl
         rugFKow6sri55SiiEpR1eFmMs7gKzu3Q4mSvMI8OIBG5EdNavDhvTYtSKr3GmHTSX59u
         00Ug==
X-Gm-Message-State: AOJu0YzQkVIqNuhbNQpBxiOw5c7bWmzrC+f1yHXFtgP0p8r7nEhegNEN
	71ps4SVFGraJeATprGCYEfRb5RzQWoX1vFkFSnaI3sPOdfhazkLnyajJRF3JRDo=
X-Google-Smtp-Source: AGHT+IEvmPNQfRqC3/grHyDx4el+OFQQ8oe9n2Gq9VfCTUQp6PrcZWAE12UYAe5NtDZsMTSep6VE4A==
X-Received: by 2002:a17:902:e547:b0:1f9:c3e4:4c0f with SMTP id d9443c01a7336-1fed924805dmr46361855ad.34.1721977761004;
        Fri, 26 Jul 2024 00:09:21 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:f62e:7a83:ff8d:7ad6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1fc88sm24971025ad.204.2024.07.26.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:09:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 00:09:18 -0700
From: Drew Fustini <drew@pdp7.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the thead-dt tree
Message-ID: <ZqNLnsRa8m9GLnLH@x1>
References: <20240726135905.7aaee0c8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726135905.7aaee0c8@canb.auug.org.au>

On Fri, Jul 26, 2024 at 01:59:05PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   3ebe71474079 ("riscv: dts: thead: add basic spi node")
> 
> is missing a Signed-off-by from its committer.

Sorry about this mistake. I have now added my SoB [1] and pushed a fixed
thead-dt-for-next branch.

Thanks,
Drew

[1] https://github.com/pdp7/linux/commit/0f351f8c4f4ee87b729cc366917e67e3eee2d3db

