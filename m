Return-Path: <linux-kernel+bounces-321686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE0D971E04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051E71C225DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F173A1B5;
	Mon,  9 Sep 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZcpSuQQ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205538F82
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895588; cv=none; b=LgpFTpp1mNICUtowgrkLOeDeAMf3l/ysiiZCXOdYiOTI77AXaBa+AIQwWZ4uLpzM3C8IVDbxKggX0AdIpJf3lXSq28w2D/95iXkjczRTd7VjcFkkLiZTvNp3FCN64BT9GLero5iiEUeR5vJeZ84Q0+P8p1x6gfaY6g1Y56m67f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895588; c=relaxed/simple;
	bh=OuOHiTQ1zD0ACXc91U0MzSnVcZpraQcszv/Xl2a+Upk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDEzFBD4/vKr4qzgLtr2UpGu2jRG/lPSHGsAydgWxDcsX5mZBCDUlkJRrvazWSxvU9RRuIaC5QskFOtWv28pVnsOACnWg2kl/3T7mWyOeuEcZgTdhrVv8TD4zx+OtIHKDKfKK3HiSDF4csVAmOrYa8q0w+AwcrrzTR7uWASbaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZcpSuQQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so3185967a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895586; x=1726500386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojy6qQZnviz4l0blWOmoVPRRYNanFq5PKPYOlD3s0dM=;
        b=PZcpSuQQetbTmvIEDgkFL5U/KD2Hm5oyA0YY3gD0Z7H5RW1XUexNR1o0sUNe4BawOZ
         Gm1ZTVSr38M5bberYRMjxWKDvGfCAyN1urOwSu1L0OhngOzqGh//v0oLqkBUCmA8gdUJ
         lKOe4FAHyf4Z0l0aIYsFenqDXCei1LEaiOQGhSOYBoa6RXyXNG2CZtuZhPJ/YOyFrPy6
         FdJK43WAYs0Ml7uZTZvKmh8rh0+EDh6Zsf9qhGsglyWu1kO6CMirTK58p0DzcZtY4paB
         yxJ3UXFNLZQu5sc5XkXuDwje2FU8tpiBc35onrOm00snfjEZpJVJlaDbk6edSg1aKQB8
         3RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895586; x=1726500386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojy6qQZnviz4l0blWOmoVPRRYNanFq5PKPYOlD3s0dM=;
        b=ef6bHOk4k37XmUFI1hANtk3L+6CyuiusDs+R+d+cvk32g1k7hgu2bqTYQFUPW5Z05y
         HEWM7iU7PHQUfLquMTY8rkgENE30Gyxw01lchs3CmJj/7pcTlhR5u3A4sb8jhYq+EWNQ
         Jl6T91g2gt7BO5678sFX1SqN4r1gPpjxnFQ7/42XfNXn+D8ZRJCC2s/VF6LBwM5fHHjO
         pRLEb4xlxqb0TaP26O2pDIUq/sra29xjdgyl+S7p3PQZuiUI99CllD+rfvU+1tHx6rha
         ulnpxjFuBmgDGT1gi1IVuWtVMTgFO42YSqI7EHoYg0N1Dh6nPxIIosF630qMA5fslzCo
         ajqA==
X-Gm-Message-State: AOJu0YwgFIkIKsIwHmLRA95w3CwxDYxeErTtqgf/KtNHK6p5C7K5VSXQ
	YEgiscEvlCus55N7DWpIkcefmla65G5561IzHxdjf+l8ChB+uYFb81myGg==
X-Google-Smtp-Source: AGHT+IFQWjUWKgVt0nmZlxP8GdjUS5lFdkTyEKAR2bjB9PbHi4r6FOQmdPpIS/1J+tbXR/PTy4hPCA==
X-Received: by 2002:a17:90b:4c4a:b0:2d3:bc5f:715f with SMTP id 98e67ed59e1d1-2dad4df9581mr13851986a91.10.1725895586307;
        Mon, 09 Sep 2024 08:26:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db070b14d3sm4536524a91.6.2024.09.09.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:26:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 9 Sep 2024 08:26:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc7
Message-ID: <2f40be3e-3ef0-4792-be51-6162f213981e@roeck-us.net>
References: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>

On Sun, Sep 08, 2024 at 03:04:56PM -0700, Linus Torvalds wrote:
> So I'm back in my regular timezone, and rc7 is done the usual Sunday
> afternoon time.
> 
> And I wish I could say that things have calmed down, but I can't
> really say that. In fact, rc7 is slightly bigger than both rc6 and rc5
> were, both in number of commits, and in actual diff size. That's not
> really how it should work out.
> 
...
> 
> In the meantime, please do give this rc7 a good shakedown, ok?
> 

Looks good here:

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 547 pass: 547 fail: 0
Unit test results:
	pass: 405038 fail: 0

Guenter

