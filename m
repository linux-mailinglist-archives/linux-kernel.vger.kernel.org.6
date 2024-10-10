Return-Path: <linux-kernel+bounces-358919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC16998549
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250A31F223CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF031C2454;
	Thu, 10 Oct 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DSWwCyki";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbzAb/Wd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C7183CD9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560796; cv=none; b=pKd2qKeReew9qHk7zk5gofYUBQGX2cOlpX3GLysQXuAoGSgOURSI9hZ6xuTlr+LaOroKLo0BKfm3wdWjGeVc66MSutr5MIP113BP+tv86LTpIOxQE1xWc5Les4kYiC2KgiQLBJ4RBRBQ71s0bSLJfs/vWJNVLTp3ZtooR2Xmdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560796; c=relaxed/simple;
	bh=rFkxvfPO1JHC/WQR6HbnlLOaMbVKXMFENzloyo6155s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8AeBW86SRwXEUWiM+LB/iKQ2nY/l2VyZidpFUzFvRqA3ZDN+//aWR1V85Z2hDK5B6Fhk0dHag316XrkMCBspSVGIrMnhx3g9kOKDXlrlsFQcMkf08LUub4xG5iE6ZM1hUxS+omWP12ka+MkBV7WTVNYBWlbCPQbRpSgBuW6dMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DSWwCyki; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbzAb/Wd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728560792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlMv9tmvfuxRB+hSunR/bD24PVWzP/WzhnKYM4KcZI8=;
	b=DSWwCykiDPoqW6qwi896xbYnYnEYM8Uvjfgf5pddMmI9CZEGjJ5IXuvVW0QTWLP7VNPszS
	+3Dm/Jh6+keNsbiNWYwon8sKGfgqi1okrNBjViX/XUv8pY0EDOssHelGSAMAnen8okcNzv
	aUr0ZHrcBuMJLo+vRmwoc4UustJqgNCbGdYBYOwPi2UNJx8g+w8YJeNzR+k518Ih4OCkX+
	7LD6Yo+RPD8FyUY8idRDUT8fl6UnUIUtubbe4708jKk81zDJ+OoX0Sw0MI/LSoZoDHC65q
	tXNHfJRpwyzdTtxUqoM+HegW5OgMBu/gqj9tBBsa6zYNra9ZRylWaH22BSAE0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728560792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlMv9tmvfuxRB+hSunR/bD24PVWzP/WzhnKYM4KcZI8=;
	b=SbzAb/WdqSuZe3iS2pCMRNc0hdq+CYiOwDZu8kenLwtKWJ2EoFV720KcVf6LDa6MfOjtfD
	eDpsX+ax/vbip8CA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 03/25] debugobjects: Dont destroy kmem cache in init()
In-Reply-To: <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.137021337@linutronix.de>
 <c118dad2-4e39-78f2-c09b-0fe771feb86a@huawei.com>
Date: Thu, 10 Oct 2024 13:46:32 +0200
Message-ID: <878quwi3jb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 10:14, Leizhen wrote:
> On 2024/10/8 0:49, Thomas Gleixner wrote:
>> -	if (!obj_cache || debug_objects_replace_static_objects()) {
>> +	if (!cache || !debug_objects_replace_static_objects(cache)) {
>>  		debug_objects_enabled = 0;
>> -		kmem_cache_destroy(obj_cache);
>
> kmem_cache_destroy(cache) should be kept, or move it into debug_objects_replace_static_objects()
> and place it above 'return false'.

At that point it can't be destroyed. See the backtrace.

So we just give the objects back and leak the kmem_cache.

Thanks,

        tglx

