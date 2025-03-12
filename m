Return-Path: <linux-kernel+bounces-557723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0805A5DCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CE23B8F01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DB245013;
	Wed, 12 Mar 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c26iGCmI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320F245012
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783269; cv=none; b=QkJVJLDvAG3jLtTVHij/btONqGGQXV94s2G0Dn9J6s3Ie+1IvFzdMTcaxTYD15oPXVIQ+6oZbqq6rVITFkW62A3Vvs9d0jnNOPDygOXiJulRlpmqjN9KO/PFbAnir54wJUo/ANcdqR2C0/mzaL8uAE+g5oanc4XZqSfTy31cufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783269; c=relaxed/simple;
	bh=bn69M2Gkq8RHaHtsLsqCouGFZNkU8lvwQGkB+OvdoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJyo0XXdK3D0IeotnxGaAZJuCWJk1RVnzoAWjs3/ecBJw7Y30TOnTijXlXaSYTBawpqN1vN4vFgBdY+/onFeLENgcVQPJ8fuCvMhEWpO+IfPw9d7g16Ja2ClZsyTf/DdiupxCz/xirP6zdU1NyAvaDT4rl/b4baNFgjVfo0Sryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c26iGCmI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499659e669so5787470e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783265; x=1742388065; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45O061CUNUxmAb67C2dioGcC+L0Loubx6IMZ4z4rDME=;
        b=c26iGCmIbEO/ZRZ88uTqSmbRWWVW9X7u1wT+hKAfwG6cCe1Xp76RGNm+zkGZcD8iD+
         Km2NUI0GgNGszkrQMvnM7i4KAnpuTDCJBF73xBGJsQ+IBbex/E+y8CTcgNHPeS7BmsLU
         Beg4z9DKD99zf+ng7eEMtvlHP5HE0mVbdW80hJESAi8Nf0r2EBCc7s+/2o3AG6Cwp5up
         3qRWau9sW66hji4ZWhZj/S4/LciPh1atxojQkr5vBHrqTBG+SHbT9DtBTtNicnh1B31C
         5454UpNX9wMeQsOSw7rm5WuvGutS9NXBkQ2tVwPPbnkax84glGBIYt+XXO6d41oqEgNn
         EkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783265; x=1742388065;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45O061CUNUxmAb67C2dioGcC+L0Loubx6IMZ4z4rDME=;
        b=HknwR4BmuPiR5q0L8JaKzTaWbscMoc0zzN6PyDQocFENU9yNNIZNMJ3SInYWtc4ZzX
         ga222ZcpeHMfKXmDjLF/oCdG5IxAy+h4D7KExq2PKaPinpXMttwHMKQJTwQicbT1hvYr
         OQefPoCGJr4JvkD2lOs5gB/Fiu+os4rwgNlpIsgdusMbRzkVYMxVlNgQQzz6XUC8Xp+L
         luzyIY+it7jLoU57KOkFPxlFtpq3j599IyKm6bL773Wen4+3v/h3+iLC4ZFdi3ye2zQ5
         rXNv5rA07b0Pq/e3W7drZwegRBUnbddqscGZ5kqpCJfEFLGP3g/HzY6EZCiZiHX3hX5e
         7vyw==
X-Forwarded-Encrypted: i=1; AJvYcCWOqzj0WnDjUK/cUWksuTNBviQfgChsv+OjcXdXU9YcQugtjKeI9+VkUQpfb5at1Ck6ZTQ4wXm/58pbfVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgyZHAiZDcce7EFUSWxLzcFA4/Akdms1GBjPmZ/cu8pC6TGg+
	nVWVcMObHuQmB2i8bitsN06mgDpp5PPYtamatAAHtsCTJL+tskMJ
X-Gm-Gg: ASbGncu9JEwmMbNschJY79j4oAoqZhoCDzF0X32Xt6b82vyfvkmqjsbW6YYnYJg+/cL
	/6RZ/g/t0usSahUJuw9/W1acgJb6hUyaSeS3vKzOwT8ytYTxrmHeXczjaWQ3enW3VM0tp77rEJN
	1GYmYfcXU6vlEOp1zIrCY+UjwS//sT3sc9VNxv2+8mSOoW007FZYskg69/t5i4RG40MNjowMfr3
	Rw5Y5C2/bI3lHE9VcTbesxBO5d7vomddhiaArFZkR8bq2qcUGZJGsdVDXBrKCcjwDA+/CnZ4Uw4
	boVMKPc1/nMzNZhFcIq6iT/EU2yqtkC8xGAEp2t7Yv5iqrY=
X-Google-Smtp-Source: AGHT+IG55WSSAT/+Yyny325JTEi9ncIf1SaTm13YRvGas2xg2PdDyMUQdRQc/QVTmM4lURBeUumKuw==
X-Received: by 2002:a05:6512:124c:b0:549:8db6:b2da with SMTP id 2adb3069b0e04-549abacc9damr2502652e87.30.1741783265112;
        Wed, 12 Mar 2025 05:41:05 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c3d73sm2105096e87.238.2025.03.12.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:41:04 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 0B62A5A0044; Wed, 12 Mar 2025 15:41:03 +0300 (MSK)
Date: Wed, 12 Mar 2025 15:41:03 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
Message-ID: <Z9GA35aiPFL1GaXW@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
 <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx>
 <87jz8vz0en.ffs@tglx>
 <Z9C6GpaB9WvNzvJS@pavilion.home>
 <Z9E-L1pvl1j_4E3f@grain>
 <87bju6ze2h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bju6ze2h.ffs@tglx>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Wed, Mar 12, 2025 at 12:24:54PM +0100, Thomas Gleixner wrote:
> +	switch (ctrl) {
> +	case PR_TIMER_CREATE_RESTORE_IDS_OFF:
> +		current->signal->timer_create_restore_ids = 0;
> +		return 0;
> +	case PR_TIMER_CREATE_RESTORE_IDS_ON:
> +		current->signal->timer_create_restore_ids = 0;

Thanks a huge, Thomas! I suspect this might be a typo, you need "= 1;" here )

	Cyrill

