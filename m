Return-Path: <linux-kernel+bounces-233318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23891B565
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B681F21AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DC200AE;
	Fri, 28 Jun 2024 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b8QCBXiZ"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496F1DFCB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544785; cv=none; b=GtzYQ3X4My4Pt+wwYwBpGDjShe6OInEhnHQm5gBJ8FAhPF6lvueyoL6xO/G/PQ16pxPwM4AVFA3SC2bjLSTd9WF3ErZbuxUl+3mqi/pZ4FNf0hf5rtuLqlDuRTQ3CsLOTytQOcko+z90vopZSANsz9IRpqsBUPgrszohOOqSbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544785; c=relaxed/simple;
	bh=rfqBlL8PPZueN2AIa1+bw9K9o7r0ByAmPFLuAXrbJqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGC0gj9m+IuKM3G50/PthCsJungieGQYjj/8nOzlajULyk3viHCWD5DloX0TkWa0KFAJmBcBCkXrWjCCRKjgRIsBv7W96K1uhcSpU1tND2JTkhtDLY8xGocY953bAWeN9CL0QzujYiZr4t7DqaoecCA0PbyrXkRaNkpiP6oz6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b8QCBXiZ; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: senozhatsky@chromium.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719544780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFokgB4wZasxHxgxoe2aHiUXolXTIQhXISskpwyHqEg=;
	b=b8QCBXiZhu9TQf55ouEt1PA6vWNA0vmYkYrNcOguhWhLDhE/L58Qpd96nn+zo14nbefzzY
	aYLXsCthxCtf/CKOTcO636ar98s23s2ARck34XJ+M2pgOSgXmzuL+hLFVBCyZcXLBhDoon
	/HDNZT9ix/oLz1pldat6XRKOIRnWzoY=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: minchan@kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>
Date: Fri, 28 Jun 2024 11:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
To: Sergey Senozhatsky <senozhatsky@chromium.org>, akpm@linux-foundation.org
Cc: minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com> <20240628010812.GD15925@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240628010812.GD15925@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/28 09:08, Sergey Senozhatsky wrote:
> On (24/06/28 09:55), Sergey Senozhatsky wrote:
>> We can land this patch, if you insist/prefer, but it's some sort of
>> a NOOP, essentially (in a sense that it has no visible effects).
> 
> Forgot to mention, sorry.  If we land this then I'll ask for a different
> commit message.  "Fix" sounds alarming.  It would be better to say something
> like "keep that stat counter accurate, but RATIO_O is never used anywhere".

You're right, "fix" sounds alarming although it's a fix, but it has no
any virtual effect. I just found it when I last time changed to the 
per-class locking but forgot to send it.

Andrew, could you please help to change the subject as Sergey asked?
Sorry, I should have noted these details in the changelog when I wrote
this subject.

Thanks.

