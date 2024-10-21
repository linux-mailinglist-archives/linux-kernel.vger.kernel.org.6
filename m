Return-Path: <linux-kernel+bounces-374795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA999A7017
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B1E1F21C64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348651DEFC2;
	Mon, 21 Oct 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="I0CNF5b8"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58C178395
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529474; cv=none; b=HHhsYOAk0uXGm9pRk3MaCPFUtwoQdRHc/qTVTbhm/2XqZnTP3E82FehmYWLpo9h1BYkb4os5XHijs4bLDClCZICC+aG4cchpZlxLJWXB/kTk8cHbslVEuVux5kbCkxsRCIuEi2XJfzktdUQY3ZX+dCrBUTti9ferqhODUBKlc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529474; c=relaxed/simple;
	bh=1Do/H+JvPcest5Jvj0r8Ys9Fu+VsUOiekKsE5Dp3bbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=alFw+3iSL2yOM+Ns5MOE+Krbk7OC51o+6a7K/nMOnbvGbJ8dTx9ehhC3ehPnZfCp+edN+lARAOAskqBoiumCyvxDeXfPzCd79e/Cjrk7LIDlOPbWuiUnqn3ebh7RvT4jV9bBBUwSfxXZkIY/VLvihVf7kJdzQHlFKd7J5RQQq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=I0CNF5b8; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729528927;
	bh=1Do/H+JvPcest5Jvj0r8Ys9Fu+VsUOiekKsE5Dp3bbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=I0CNF5b84Zxr9jcDaIiaWoA71Kru1KQBntNS3j6DzX7JLrZNvrlzIpLCaNnL8o1my
	 vWTRB98H4HR/ZOXf76pMb/pJ2+zXZr1ZLt+DPClxsaiV8BBpY0XGBMWpPFp8HRlf3i
	 mj5amEARd+yi/qXiYzUl8Kf/ktVjeFa7BkfRNCKA=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7FC8A4026F; Mon, 21 Oct 2024 09:42:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7EE2A4026D;
	Mon, 21 Oct 2024 09:42:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:42:07 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Uros Bizjak <ubizjak@gmail.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] percpu: Introduce PERCPU_PTR() macro
In-Reply-To: <20241021080856.48746-2-ubizjak@gmail.com>
Message-ID: <0348bc63-d396-b261-9131-3dad51cac108@gentwo.org>
References: <20241021080856.48746-1-ubizjak@gmail.com> <20241021080856.48746-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Uros Bizjak wrote:

> Also remove common knowledge from SHIFT_PERCPU_PTR() comment,
> "weird cast" is just a standard way to inform sparse of a cast
> from the percpu address space to a generic address space.

Ok. Thanks for enlightening my ignorance after all these years.

Acked-by: Christoph Lameter <cl@linux.com>


