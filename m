Return-Path: <linux-kernel+bounces-176466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4AC8C304F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EA11C20ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00353399;
	Sat, 11 May 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFwJvqLM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADB53373
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418387; cv=none; b=vA7V7KtCjK4iR4At01tMxsnT2pU87S6pq2oMYz9bFYdcR9OG8yEee1h88E4E3T44YqBVcw+NCn8lyOytHU7tKihVDxR+48T08S3McgAvquDsVNSvF8pKVnBOA2ZuUMcYY0QQoqbXy82L7oRxkJIxhNoa3LfaoYmgMdNKnCd/sAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418387; c=relaxed/simple;
	bh=5NSL/7WA1xl28WtO6/gO8hXXQ/GvfJrt6DfXLII+Lt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuKcE98D4O2AnfDFv8n7tV4rnp7Ll6XDZ1lWI1XuSlpvuMAwoeaxMaLL1GfOud22iYjbGmPELix8BF7heHTT4H2bmQ0HcmVGHr8/UxvoDL0nlMQpXbBCpwC5iXr1kBULhzi4II8DxiwKJecsOB1muWqqFnPMZzCxdyHEixEmMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFwJvqLM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f472d550cbso2214153b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715418385; x=1716023185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q6YwGBbQ+8Xp/WqzUEw7enxX3Yc4Ryw/iAVniu2284=;
        b=lFwJvqLM6Bd1SHR8SyCC2SmjjpZZvSwAvQf60VbPrGLLFuB5R54LMFaMwDZ9kzGRV5
         ZjZMDwLv1O5FJvxgLdQD4VhAHgzwVYmGUahdwYUGNQOVPJernpqgHeAeKV31fkFe2IIL
         8TGOtNs1ic4pOngGDJUNvqu6scRS5eScobo8orCAxV2Jt5ADS6i/9VlqFwf2UxD9pU3H
         hMAM9lPWbxR+U9bh7Mz4kG1LEBysHwcRwtj9VeB3HFRmsVDvDBpbCTV9Mu3LaURwVo5Z
         SuO6w6x0IhwQ3ppwE3WoqY3Lx1yrHMm4POq3cWHEdR6fAHHDwEkowc2uCekb0Kjhy9k/
         HWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715418385; x=1716023185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q6YwGBbQ+8Xp/WqzUEw7enxX3Yc4Ryw/iAVniu2284=;
        b=WA36Mzp1g2980ZrqUU4f9Ty2GDzrw0nAZHaoCR4gIxmeTQoqdgZLarPugXOS9Z7AOu
         xSkiSJYGLrnoloD3sahp+f4xG/psu0/gr+JmvmwtT7vs0J/YEbzuHIbUSItdYdK8od1K
         Mtd/Tdoj01Gm1dhlnWYwGNMTCd0BowOUuDxYjSAJkE0cgZiyfUoBbh1ajIgau+zDBR7V
         91pRm1LXcU3TK44RT9H0gWGAgBgFDoqPYInLovQS/v6p090nv7NI8GDgub0roW34kWEg
         JsfoApvTzrsTVLn/O9nMuakenJ3ihk+RyJ0iKHDdkoF4BP/baEhmbBUoggbXCBNNRnB1
         AVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSodAC1aRa3BsxrYkfX0Icq6m3BXyE84cNivaf4DDhxFFFiqWTGR+eE8H2TPFrqlBHEj6LrbzW44jlqTMCxc68BxYwNyYpHGk6IrWJ
X-Gm-Message-State: AOJu0Yw330J3B29+mj4Jz5ZgKXNxumtCcZZ4lexUgMofqTRWzVCBbOkj
	9czByjMBxcPP454HFrvm9TfeywNWkybas4blOJhpakhSoJtJ+5SI
X-Google-Smtp-Source: AGHT+IFstVqgGe7kvvu2WjpO8XOC2O55TU1KpEET7dhIyel4ePuPafnC96F1uqv482mFNFyi2CJnqA==
X-Received: by 2002:a05:6a21:2b0a:b0:1a3:b642:5fc3 with SMTP id adf61e73a8af0-1afde197934mr6037627637.41.1715418385256;
        Sat, 11 May 2024 02:06:25 -0700 (PDT)
Received: from five231003 ([2409:40f0:3b:ea37:4df3:ad42:397e:1d67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm4117699b3a.186.2024.05.11.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:06:24 -0700 (PDT)
Date: Sat, 11 May 2024 14:36:19 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] Use scope based cleanup in drivers/soc/ti/
Message-ID: <Zj81C3OZjxB4vtrW@five231003>
References: <20240510071432.62913-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510071432.62913-1-five231003@gmail.com>

On Fri, May 10, 2024 at 08:17:54AM -0500, Nishanth Menon wrote:
> On 12:38-20240510, Kousik Sanagavarapu wrote:
> > Do scope based "struct device_node" cleanup in drivers/soc/ti/*.  This
> > series converts all the possible cases.
> 
> Thank you - also will be great if you can indicate how this was caught?

This is kind of a refactoring.  I grepped for them manually.

As for the motivation itself, I would say

	https://lwn.net/Articles/934679/

Me and the other LKMP mentees are working on doing this to various parts
of the source with the help of Julia, Shuah and Javier.

As mentioned in the commit messages, this refactoring has the advantage
of reducing the number of leaks in case we add new code in the future
introducing new OF stuff.

Thanks

PS: I sent out the cover letter once before without CCing the mailing
lists and Nishanth replied to that.  So that mail can't be seen here
independently.

