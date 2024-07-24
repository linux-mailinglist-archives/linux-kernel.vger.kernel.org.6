Return-Path: <linux-kernel+bounces-260491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0C93AA31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5181C22BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C344A35;
	Wed, 24 Jul 2024 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y4MT4NLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839723BF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721780770; cv=none; b=g+GTr/Fuw5FvjuqKaVk/BItES6ZzvNuPgDPLrJ6QHMajht6lPyeOXOyh95UKDm0G7WqNKyeb+iLvB64bbETaUGX6E3xCcV5nlzu7kq0ASjZUnqKcvnczso4tcYXReVGo5Cw7NuuVaVf1aDcGLsxZ2SiBrHJkEWsltFvRmfYfKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721780770; c=relaxed/simple;
	bh=1+I8vMC79vQp7OPU3BB+dh1nrMYCEggSaUBbiLHsWco=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PjIQXAtNGihiLA+vaYedsEs/AQN2+jlswlzGDjnHxwaJC5+QDItlzwQPKphLQpkUFIIs1fcd5uWh7XC8B3M6Zygr0HmFYeH2b5JH3kobdD4kq5QLpDIyH8HmgolbXIt7FJl3ebW1yoCrFgxP8Cnpsu3ouGlG4VLShzsxBoJEwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y4MT4NLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D875EC4AF09;
	Wed, 24 Jul 2024 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721780770;
	bh=1+I8vMC79vQp7OPU3BB+dh1nrMYCEggSaUBbiLHsWco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y4MT4NLrfrxrgR7o+ZHOLuPa599IgxBWcmeSeXiVHbFw9xI+hF3MLflLR+uCHkTVW
	 tMaQlZ/WQePbzOx33kQWaZ0/5953EdISCn1krEr09cZGFmEVW5KtfTKJq7nigEoMMx
	 dRxJlmsuFVf4eAPtnVOvp2OnrH7s3OVA2E768MEw=
Date: Tue, 23 Jul 2024 17:26:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: zhangchun <zhang.chuna@h3c.com>
Cc: <jiaoxupo@h3c.com>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <shaohaojize@126.com>, <zhang.zhansheng@h3c.com>,
 <zhang.zhengming@h3c.com>
Subject: Re: [PATCH v2] mm: Give kmap_lock before call =?UTF-8?B?Zmx1c2hf?=
 =?UTF-8?B?dGxiX2tlcm5lbF9yYW5n77yMYXZvaWQ=?= kmap_high deadlock.
Message-Id: <20240723172609.7694b76e90bb18a0fd360ede@linux-foundation.org>
In-Reply-To: <1721319512-23585-1-git-send-email-zhang.chuna@h3c.com>
References: <20240710103611.809895ff809df9ed411bfaa8@linux-foundation.org>
	<1721319512-23585-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 00:18:32 +0800 zhangchun <zhang.chuna@h3c.com> wrote:

> Very sorry to disturb! Just a friendly ping to check in on the status of the 
> patch "Give kmap_lock before call flush_tlb_kernel_rang，avoid kmap_high deadlock.".  
> Please let me know if there is any additional information from my side.
> 

Please update the patch to include a code comment which explains why
we're dropping kmap_lock at this point.  And please update the
changelog to explain why holding kmap_lock was not necessary at this
point and why this is a safe change.  Then resend.


