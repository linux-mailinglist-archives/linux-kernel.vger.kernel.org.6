Return-Path: <linux-kernel+bounces-270932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610AA944735
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA3286138
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA4170858;
	Thu,  1 Aug 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWO1OKc4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rgKW0lkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FF16F8EB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502655; cv=none; b=S/AbF0W3SLc790G5kyED5y7+QXJpY4Nl7pd+NDtzNQtUVRnyqBylORaoMOfBOq+TG8v1vj7rKgK5NpBLGUhO8kiMQceyHtpC0bBQgubX5kWG5fN3nAY5RounSKLa3gflfKPJ0mv+YdhhmzGbkwzHVlWigTCbFo0epJcOEVVmdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502655; c=relaxed/simple;
	bh=7JTpmPQcCBM3sRPjm9hPcUVHAMOdnycFktlpGCs6Lkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ee5VJIO19M39ZbASl9dpTfsals6tOVobTo4IQekB4o4R2ipHN4TkZD+H6PlHn5uP2FV7ha9tQAIq+LRhvAbI3mWJfzNC+adKxCDofYwczHvxrOj0kg7YgE4XtjWXtDahoX5EnzbpjZZHdkKRFQELncFnwA8CC49b0hp+D+BA5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWO1OKc4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rgKW0lkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722502649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNGtxNJnnru0fB1WEZd0tF/jrKpevqG2aVOElVy9DD0=;
	b=kWO1OKc4mUeARHuVfj6PBXzwknpjCsAZsrW7fWLvDnvPKpV/aeQjCPN7BLs66z9aCtvdfJ
	YNxGpGtArSGrQJKphtw1aFuZg1xlEbRbndC3YtqUHNHV0F3BM6sWirdX3BXgP89yjrhfU0
	iGNpuEF5TqAUlTWgtolVWY9WnAYBzX5KDJ68d1eBxHpWiL/q36/xwTliUXk8/fOmOzRzMH
	9bs+jF7KH1JegTqCSjDT2wFzoex5fBYvDM+5dMhVu4zkNtcZTtUa7IhSWYwLbd5+oIT0VG
	RdDg3Ns5J+aARAauXdXX0hrWL0osTtsP6yQktRO1RueFXHNEdVMrwR8nm/5ukA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722502649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNGtxNJnnru0fB1WEZd0tF/jrKpevqG2aVOElVy9DD0=;
	b=rgKW0lkRdd8WQmqpz3XDTDj78GIFzvnExDEA7JyVWnuLILctr4mThDuS5RUcnuRZRLY6cr
	wR4Ukq7qgwrxa3BQ==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 linux-mm@kvack.org, keith.lucas@oracle.com, jeffxu@chromium.org,
 rick.p.edgecombe@intel.com, jorgelo@chromium.org, keescook@chromium.org,
 sroettger@google.com, jannh@google.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH  v7 2/5] x86/pkeys: Add helper functions to update PKRU
 on the sigframe
In-Reply-To: <20240801065116.2088582-3-aruna.ramakrishna@oracle.com>
References: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
 <20240801065116.2088582-3-aruna.ramakrishna@oracle.com>
Date: Thu, 01 Aug 2024 10:57:29 +0200
Message-ID: <874j844o3q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 06:51, Aruna Ramakrishna wrote:
>  
> +extern void __user *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr);

  *xsave lacks __user

Thanks,

        tglx

