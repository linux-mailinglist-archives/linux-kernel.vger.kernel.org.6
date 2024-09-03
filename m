Return-Path: <linux-kernel+bounces-312647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB396995F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E03B25524
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D41A0BC9;
	Tue,  3 Sep 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKAjHEJw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDYadUxW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE51A0BC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356274; cv=none; b=lwZSP7UrKq515IRFn7cQXGISGUeS+0PDYBXons/oxPkZvhu7iN2bd5p4kyMYfmS+uclenEsRk0+S3czQfcyjYR+mHX1q6dR8sjf9fWjcOA79opYzXbfXIjCFBz2KGfKO4BJOZaMRTrjIh7VdTUEKSeZOuLM4Fs5gOecFDiEivr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356274; c=relaxed/simple;
	bh=5owENPUpHeTyQSQfpeKzSn3pwcPBnuBMu3AJfFthQ0U=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQ+I1Hay5Ut9IMtVeBoHzguSzFW/sCZsubnFjSYQGd3pHfUwPvhGcWyPQe0DwlwM6OWHpCGx8VzBeyq/tufpy+SZGj9E8gJXPuFgsppwxUwAOkFzwU2uhyf5MvTAp60z00sRBzC3VSy4l36JsqFE6oKaWKRUNJJwnXT/BpNko98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKAjHEJw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDYadUxW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725356271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RqE10hI3QOgAEO71wJ+N+VawSeiWDqVE66hPggIFXso=;
	b=LKAjHEJw5kEBD7n7BMkvd1vwOy4IlBTCCVO/UgyJsKDiBHtxBM/VOleZ6wsg6xo+WOJ2yT
	GsVxkc3kCfPV6997d3mtW18BTAQ9fM7R3yamrQnw9dEzeMB8+LS5MFoEP4O4xMV1bBSMqN
	O5VzELpDbEowwPY8gTvWdkZ65Q1lqu4So8oOKV+vM3dqs38z1n70QTpDDU+tqH9j1nHCyz
	saeQTh/gOIVnUT2xq44/J00xKP7Qt3nDONYvu6A+998a5VF9+euc2D16tcs8Iqqv2xw/1+
	i4zEOCq3Exk2iGZ9UTX98k88f6CVyX1GKECp98eIn3sdG8PLr5IwKKZCcyeiCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725356271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RqE10hI3QOgAEO71wJ+N+VawSeiWDqVE66hPggIFXso=;
	b=EDYadUxWOdUcfba9SLO7omxNxpNpQ6mOwBW/faB8XB5Ahwk80n3TBXLV89kp5grXl+5A6t
	RnDXg/UTojaJgdCQ==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
In-Reply-To: <659f0321-e567-ad48-4545-4a47a158d6c2@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com> <87mskq58l5.ffs@tglx>
 <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
 <3bb35c94-dd54-33d4-b7ac-64f0d2b77c07@huawei.com>
 <659f0321-e567-ad48-4545-4a47a158d6c2@huawei.com>
Date: Tue, 03 Sep 2024 11:37:50 +0200
Message-ID: <87seuh84cx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 03 2024 at 15:00, Leizhen wrote:
>>> @@ -84,10 +85,7 @@ static int __data_racy                       debug_objects_fixups __read_mostly;
>>>  static int __data_racy                 debug_objects_warnings __read_mostly;
>>>  static int __data_racy                 debug_objects_enabled __read_mostly
>>>                                         = CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
>>> -static int __data_racy                 debug_objects_pool_size __read_mostly
>>> -                                       = ODEBUG_POOL_SIZE;
>>> -static int __data_racy                 debug_objects_pool_min_level __read_mostly
>>> -                                       = ODEBUG_POOL_MIN_LEVEL;
>>> +static int __data_racy                 obj_pool_min_free = ODEBUG_POOL_SIZE;
>
> Sorry, I rechecked it again. After this patch, obj_pool_min_free is referenced in the
> same way as obj_pool_max_used. The only race point is located in debug_stats_show().
> However, this reference point does not need to be included in the race analysis. So
> there is no need to add __data_racy for obj_pool_min_free.

The read races against the write, so KCSAN can detect it and complain, no?

Thanks,

        tglx

