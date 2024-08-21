Return-Path: <linux-kernel+bounces-295777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0347995A15F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229541F2159D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DF314B940;
	Wed, 21 Aug 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aCQJOvK/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1413BC39
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254117; cv=none; b=tb/qdCoEMelwo3hTlHIhZhQ6lWFwiqiyFTkJK4TPOAlZpvczCfYOJr7ibThihg+QKkN15H6EUuDNZKs7cfvnFNobEXZw7fBnwvcfnemFk50vKUdI6o45Gpohbfqjf/ON33tSfhSKxDjl43/hYKsPpw/ndKSx8dlKFSqc8J22BVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254117; c=relaxed/simple;
	bh=aHJwu22mGm0vHo0z8Wvt6XloaFk3GnDOjYuqvNlu4HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY/mHuZBKtBgZFkxQQ+ZMOghSRHuXTd4G1P3+u1QJM6Ifwdc4saGheXAksDwNXzNORfwiHAdVs0i/hn8rXOR64gEHGu6RTVkDkgg/Sjjrp1QSj5RUKibXsPK2iYptQD0a7uE8OF7N9+FhHihS2D+J0PZw4ZuAjMynZipQk1RQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aCQJOvK/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8647056026so254604566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724254113; x=1724858913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHzZjfhtaTyCCMfXsIKS9YsrGPPreAS4gjZt5OgSCf0=;
        b=aCQJOvK/91GD+9KrS2w8kP3UYNsq6cHFndNuPOSWcYgKU+nJdsK1StmULb7kSI9wtb
         UfPdDJ/b968sLD5y9UdA6SIGEyv0S1/8WYPJrZV2zdPJavuVMeHbV0lW8CNOHQu1bvzb
         Qke8QQhlRiA+y1IxdoxUMFn2oiYRhmwH2gniKe/68Z51LZk/oFVfk262UTFncRcrOMHG
         f/3Vod6SyP1kXBUUqFFMiz4ft4XTKQIBXFdlFsEtH8gM7tJz5t9SzLTCCiY+RjBOXIc5
         jR42ansn6asv4rKqG1GcLcBaHFGvmfi+x7d+r1qlfpgmupWDOBoRlDC4hhOObiDtn+eC
         wGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254113; x=1724858913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHzZjfhtaTyCCMfXsIKS9YsrGPPreAS4gjZt5OgSCf0=;
        b=RfbYtH0GvV0YsG3kXuU5SKS1LQHhqhLvnvgwOVTa1vUOqH5AKA7tyCKbZmam8JXT9u
         B49coGIMMgewIAv5wlh1sdseDFnAB25CZzX043lFgwvC7NIkG/KKp+F7mDEacdY9im/J
         uF2InH/Mvskm8x4AkRdLaHns+iLq6IPfXGO21+fWSX+LQxI1PT2Rj97OcMCfe9hpaxty
         9YnRmYC0JCPJ0YRX3N+ykWQhdSUDPjf7MAiH2owVJVtvMnlIE0/+jNYgAKEwXJcYCLBr
         LPARcmNqM/O3QD4IaXRKgYpr6PYYKjEFtt0DDPCwTSF2OJE6ItM6ss3VlEhlYk8oOrNd
         pZuw==
X-Forwarded-Encrypted: i=1; AJvYcCX9+hSr09WgroZNw0Q2Ll+XCDNRhP1IGUsQNB7uyvixTQGAVDBpoWeFB9+l79gUHoJeIFxHDpBsgSE169E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ylzKhYKvs5FZ0xxtTvweHDoF/pw28W1807eXPXJSesjcm/Mt
	OIuvTtk0mhDQzdzAWPxsaghFnYPEfRdw0XFrZwOHLWf2habJL8F1OqrE+fnkkf4=
X-Google-Smtp-Source: AGHT+IHQsAAjCMIiRKfgwLUDYiG7yQAKuvlMLtEcOUrNyQw2LRfT1jPFsKvx8/MDzjdSYst1M/WopQ==
X-Received: by 2002:a17:907:3f11:b0:a86:880e:eb7c with SMTP id a640c23a62f3a-a86880eec92mr34460366b.60.1724254113115;
        Wed, 21 Aug 2024 08:28:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86876f62a4sm15905466b.129.2024.08.21.08.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:28:32 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:28:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [POC 0/7] livepatch: Make livepatch states, callbacks, and
 shadow variables work together
Message-ID: <ZsYHn3XoJu3npb0E@pathway.suse.cz>
References: <20231110170428.6664-1-pmladek@suse.com>
 <alpine.LSU.2.21.2407251619500.21729@pobox.suse.cz>
 <66a263d5.170a0220.b2c84.1870SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a263d5.170a0220.b2c84.1870SMTPIN_ADDED_BROKEN@mx.google.com>

On Thu 2024-07-25 16:40:20, Nicolai Stange wrote:
> Miroslav Benes <mbenes@suse.cz> writes:
> 
> >
> > Do we still need klp_state->data member? Now that it can be easily coupled 
> > with shadow variables, is there a reason to preserve it?

Good point. I have actually forgot the pointer completely.

> I would say yes, it could point to e.g. some lock protecting an
> associated shadow variable's usage. Or be used to conveniently pass on
> any kind of data between subsequent livepatches.

Honestly, I would prefer to remove the klp_state->data member. I can't
find a safe way how to maintain it.

The pointer is in struct klp_state. It means that any livepatch
supporting the state has its own copy of the pointer. We could copy
the value in __klp_enable_patch() but where?
Before calling klp_states_pre_patch() or after?

It might somehow work when the value is set only once (in a pre_patch
callback). But what if anyone tries to modify the pointer.
What if there are more livepatches using the state at the same time
(not using the atomic replace) and each livepatch has different
value.

From my POV, the klp_state->data pointer is a potentially dangerous
thing with not well defined semantic. IMHO, it is not worth it.

It the livepatches need a new synchronization mechanism, they
might allocate the lock in yet another shadow variable.

Do I miss anything, please?
Could you come up with a reasonable semantic, please?

Best Regards,
Petr

