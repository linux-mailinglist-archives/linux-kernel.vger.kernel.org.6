Return-Path: <linux-kernel+bounces-248271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741392DB12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77CFB2102C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A3132113;
	Wed, 10 Jul 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYWV0kp3"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8461D535
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647334; cv=none; b=WZTdOT19H1r4QOLHemhRE0SfwK6v3oeU43J4yZe5/Im+p5785aPP/4KYbFgzDRv2MofmsXFoTyazPMoSseWgp+9sPaT6NR6tMxyUoGA31m5+vl1npP5R4aESFc42vF0FmH1MI3qJghV4/xN6RddApoqry1hJbZkYGSHcjunJ5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647334; c=relaxed/simple;
	bh=Pi8WdlhTSSJvc9pv+3NmsA4JZvFP5qgK2wjgiLuWAsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ergtk1jd9tx2GCKf8LlPmgUikSR3OpnqCEx5hojSJEPevhhSYsZlx4nsUjOPV7822hjVEzW5vmRW7LpF40WfLish6VoYTt7oecavWqt72T7mLkDWBzCnFWyab5B4noMzMLwerAQTIANsH1Vgz+IdAcF8g53XUHqI4w8sz5MXkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYWV0kp3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb64d627b0so1265255ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720647332; x=1721252132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mh1YKAf63/S0XqtjUv8ftSMZW1U9zvPprxysY5clxE=;
        b=VYWV0kp3iTIuIf4r3KVfFO6L6vcj/sAro/X7kKhoAjzSDEViEfxZDOQHyY+EAMQhuy
         PGDpWGOsbAD0NNg88C7pTlYu4S8U7oQ1AwRTVxyawZg7tCAOmNvFaooP+1wYFYCYL3A7
         cA199NCEWhXZFm1aiGrWNMHEVsN94GGq5cWbjE4Q3kTaGWHQdNzoLDaRj4NyVhBjx+9O
         ackoXx+9hdmJcw4JA5Lfu32flF/WZ3F1aL/0G1HTMka2Pgd44FqI4nGpj3uHa95rFXg7
         3QoWN1vv19wbkWQTgy8/4AEzwR2pJAmXlESKaNJRwxkw7KfhJBsXJ2wVj1W+gvDZhbwu
         tVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720647332; x=1721252132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mh1YKAf63/S0XqtjUv8ftSMZW1U9zvPprxysY5clxE=;
        b=GKKmbJJH8JU9bUvIXgeqAU9djyQSCU1TVml2GUcH296BM3giVCuTT45dW2XabcoLLC
         cyBBWtxFPKRYH3rax32rCL9aDbLea1m9/heG5LdchuJZrBwwxDQJkJIwLuYdDUoRaUsD
         mfdgIAWqKY52TNrev7Pb9b2HI9J8JpBMa1zCeL6Lcse9+2+x0Cv4MwVfR7EjReYPvN3/
         CKLhHonpYMurQ/4sLnrgrG+h9PLWsV/emcJwZ6YzeY8rFz4uzDdVX3RhML7ReRiBY3CM
         F4PaIRBMzeyQt7ld3NkAfPV7XYiJrLMkv+tWQgCwum5YkBEltr1+UEyh0iNgzq3ZvEKz
         iuVg==
X-Forwarded-Encrypted: i=1; AJvYcCUXyQEOTxwWxVhpc7OkJapGvSoprTxsGzWWYcmuf0EAV29K/qyhSY39PPWE3xa25zMp+NDQrYDHL4/8xBbUsvqz0ehR7+uvfha5a0Y1
X-Gm-Message-State: AOJu0YxZ3KdPSXSXqjpz056e0YpFsk0i4350BNuiSjT9vg8T/ZnvKR2L
	SIgPPAdFQuWL0Wo8Zs2iz2kUINZZRt0iex/bEof9+mfETV+ZnTkp
X-Google-Smtp-Source: AGHT+IHowEDtJHIVcOWj6cqfwZrZrnbWPf45TqOG8gduFJR1xDuf3YYCdYvQmPQZ1poRSpRSm8iDmA==
X-Received: by 2002:a17:903:1205:b0:1fb:4c2e:9803 with SMTP id d9443c01a7336-1fbb6cda8a4mr64193975ad.10.1720647328154;
        Wed, 10 Jul 2024 14:35:28 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6d80sm38250885ad.170.2024.07.10.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:35:27 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:35:25 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux@rasmusvillemoes.dk, willy@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] radix tree test suite: put definition of
 bitmap_clear() into lib/bitmap.c
Message-ID: <Zo7-ndzkju1QT0j-@yury-ThinkPad>
References: <20240710172701.21339-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710172701.21339-1-richard.weiyang@gmail.com>

On Wed, Jul 10, 2024 at 05:27:01PM +0000, Wei Yang wrote:
> In tools/ directory, function bitmap_clear() is currently only used in
> object file tools/testing/radix-tree/xarray.o.
> 
> But instead of keeping a bitmap.c with only bitmap_clear() definition in
> radix-tree's own directory, it would be more proper to put it in common
> directory lib/.
> 
> Sync the kernel definition and link some related libs, no functional
> change is expected.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Yury Norov <yury.norov@gmail.com>

Added in bitmap-for-next for testing.

Thanks,
Yury

