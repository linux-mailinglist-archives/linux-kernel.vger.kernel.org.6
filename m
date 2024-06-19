Return-Path: <linux-kernel+bounces-221552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E0190F564
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DB1F21AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48816155C8B;
	Wed, 19 Jun 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcrbAGCv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8577107
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819066; cv=none; b=MYsui8QSXSsAWsgJfm9uowSkkNmaiomn0Gcs70naVa0r7J3fvsDrsu6Dlprg3J9csbj211xeK2FYwHYxfxfx1efRfIU9Kj/l/Isgb3bxwklWbwhmIFfbLP/yxYFG5WCyWp8tD7xTOJ53tpoJAEDEIbwNuA8Bt9ec/HJybO/W9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819066; c=relaxed/simple;
	bh=ZacGsa+fnVhwzElIqfwiBwjV/z/3ZhvBADv8yj0eJjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdL4T4Nw47n/cC3p9VHVcuRr1nSkEsPqrRCxy7CA9q9SkuHAKmHuaXPMWbOWQGmRmK0RO8m/SyhRL5LkC+AFGMMn02KAuyQgiuf9iiOJU9LJJWIa2Ky3BiHwW9TSOcw/5/weq/AO5eupZ5ZrUZ9L1gOHIFZEYEaakkYqdftRjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcrbAGCv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b594deeso85795ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718819064; x=1719423864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTTBYpViMpJxszzvYuhfNzCpjAqqcA4InCuOVHZ8/W4=;
        b=fcrbAGCvr89/KOx9PlGSzCudDCjTwr/V9I+N8eKjCyzRKmWFxFQNzH0b5fLXmWqV0b
         SguGpNojF308quHJiw6vd570LioN7bxrQzCblU9XwF83WwcEjjhlZNApLuFm3FCa9e3L
         tD9YI1KxG9E+vNR6fJGB0ybwsu+08/d6Pcy6q9CurvlV+13LEsSQEn41/X7fuvAM7wTt
         JZzRnomanpbYD7QCkxmm72eVoiqM89wXzzKfzNFFgoVjIP1s20ZGyGBVnAhbXAkMlmsL
         3lSaT2yvWG8hvrgR8yLEklDNJiM8EKyuQfxWdVBaFq+xzMi8F8WJJrerdq93MjXTefxm
         AjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819064; x=1719423864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTTBYpViMpJxszzvYuhfNzCpjAqqcA4InCuOVHZ8/W4=;
        b=ZTl9aYlQgjib6UmJMELiaVBj6eIo2fkWGT94P9MEWb+mui9BphFSG0P3q22itt1yWG
         YhypEJYKROwMhBqEAqEwRYvGmEyMq3yDmdlWRw9RCUra8mOFaowdtLtGrcv/6wjJP12T
         HMZ1fA89NsHpeOMpw55iqQDOotm30hzVymw5Gks21WpyVxtBa2cGMbnzu3ah/jFLZGBC
         /PKes6LvtIyLrxXWPdzkjXibLKj0YQisxVYXJU23P9XWGp+5vQGqQuE1fnUY1/T313c1
         EAaSv/tbqaXgZbd5GTqclfYhtq55rJbtGRvYlh5nGOj70x4yV9fcqivAq+gxW8dr+EFU
         WO7A==
X-Gm-Message-State: AOJu0Yxxh3HIeMYFEfW/CoG88/vZjd7zwaKMpKaR9dHIXoobH5xgd3pO
	Oj+JwE5q7YfAY4EyT39DPJTLQY2CLz/i4ObaNzZYHvpyg9OLb4JNN72kcw==
X-Google-Smtp-Source: AGHT+IH/9DffqorN3zwsi//jv3senX/h/5kV+2fYYT/RAsPffVqFz8FaDhDqevyRrZenJxdutMVvbg==
X-Received: by 2002:a17:903:1cf:b0:1f9:9a87:76f5 with SMTP id d9443c01a7336-1f9aa42d459mr36798215ad.27.1718819064458;
        Wed, 19 Jun 2024 10:44:24 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee9be0sm120960295ad.176.2024.06.19.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:44:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 07:44:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH] workqueue: Avoid nr_active manipulation in grabbing
 inactive items
Message-ID: <ZnMY9qE9Es3_3kEp@slm.duckdns.org>
References: <20240619103934.2701-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619103934.2701-1-jiangshanlai@gmail.com>

On Wed, Jun 19, 2024 at 06:39:34PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Current try_to_grab_pending() activates the inactive item and
> subsequently treats it as though it were a standard activated item.
> 
> This approach prevents duplicating handling logic for both active and
> inactive items, yet the premature activation of an inactive item
> triggers trace_workqueue_activate_work(), yielding an unintended user
> space visible side effect.
> 
> And the unnecessary increment of the nr_active, which is not a simple
> counter now, followed by a counteracted decrement, is inefficient and
> complicates the code.
> 
> Just remove the nr_active manipulation code in grabbing inactive items.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.11.

Thanks.

-- 
tejun

