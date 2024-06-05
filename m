Return-Path: <linux-kernel+bounces-202173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8B8FC8B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30966B25789
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8715190060;
	Wed,  5 Jun 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f22VGsT6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40C18F2DD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582254; cv=none; b=sGnotdtLlhTZnsbdLXc42Od4HjdqLYTRv3B/188b4rbAdoHNanhqcpGATmg6pCWLV6uD1sRaQtmBRbFJLAEKXcaF7NFujYmYS95Tcjm+lnO8mabJkcOGv7+jx9TG7RsXa8cKurTo6SfQ5i581bSxtsMGyRxgewZxlBK6Hw/lLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582254; c=relaxed/simple;
	bh=qglBQ7rwNv7Li7vvSQYY+g6s2ZyFxgycV1UGyNThHl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlZOZNDv2t4fTucT8y1RqpnApoSMmwGlpu7xJwlT94KZ9QyfCgRryESV7p+pViaQrulxjleTWVwAUJaKvn6KluhqVJFqHxKGfvHk97v9wCSDCu7G1bjWK9tSqfDnXZ3l5IBdlGHyyMOv5DQMJjSzpGyhcsU5ljdLLG+6xFOOsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f22VGsT6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eacd7e7ad7so2436431fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717582250; x=1718187050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mku7GzZWs5xanYMf7QuG6n9lfp8wLHBzVIbTOzZoCDQ=;
        b=f22VGsT6xc2gIcck1vuV8t01SREp6SboC3PJbt2QaYbpzjFSRzosvjnDDRFaE9r55L
         K7Ja9kQzxKCCY8fhx/brZ7ZasqPRpfj+G3Lkk30BHoVPVv3MthPzEC7aoUG0SRPKwP6/
         SXbozYbKlU8kgVY/m6wVxfHiCYwJoINBWPZpKkD9cYW6PAkZP7HwfbZfjOD5alpVJfvI
         r+k5l0mU99HPlCtfOqxDj9uo55jmV1lzb9Q1qmzlcRBTQGHNDZOfOD1kqJuhd+ZGEKW8
         i+DLvv7Eo8LhXJ+/+DiSJqg10PZxFPndKM5ILXJ3BFljomd/vVM8k7aeyTp7DgJNIjwE
         qIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582250; x=1718187050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mku7GzZWs5xanYMf7QuG6n9lfp8wLHBzVIbTOzZoCDQ=;
        b=WskVNvGA7t88JeGXJoiuQGoC7Mbn5H5A1DMekat1/W620DIWy50cz7B9y1oe6NuajS
         JPrXfJ3l7CO9CCU+SH3+wXUH1NLf/ht/cXscrQTjnkdQR+rfL5mkR1tOdJ+6Fk7tzrrj
         EIMJYFfqdRYtoYpHxm97KYH2QKZOfOhofPkH8UFO4qSO4fp8Ld5cjXB0WojCeYJsrdX1
         F6OWMtFcVVfMPqBrgEXVyaxBVKlNO6/qNQEKFxg0SZWp4Rm7TnwkvpSDwuZbrwfS22H0
         TjtkGUHcCOKtJ+t57aB5exK1J3sFXnUNmPI5dkUDDd9bahLbJg/FBv7hejS1NtranhYo
         AnXw==
X-Forwarded-Encrypted: i=1; AJvYcCXYJHm/5uJOCY7wddgjNMhx+duam8oJ9T05aGpd39uhVa4p835YE3Y9AH7b7fiMoAT9h/LyFrKy3D8pfhEDbSZj6FKSA+gAAiZGKdaR
X-Gm-Message-State: AOJu0Yx+MwtwzgU7FMSEK12Hhb0+5Poi0XstlpsjNvDx13PjnU+LUe/c
	2mujESbOVArBfLPmswjCp2lRSkGog/1ifVsuVqQL8JxOMrbxnAnhf3Tx4GUelM84Np+QPu30HIG
	I
X-Google-Smtp-Source: AGHT+IE8WDyz86+CBmU5Yun7o6qjUBmFSvF0F+vN+plt7b7qCALDSxPKHPC3yJtEQ38n8UzyTWpUTQ==
X-Received: by 2002:a2e:8604:0:b0:2ea:c7f7:ea20 with SMTP id 38308e7fff4ca-2eac7f7f536mr10871971fa.7.1717582249973;
        Wed, 05 Jun 2024 03:10:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067b192sm1103246a91.30.2024.06.05.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:10:49 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:10:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] printk: nbcon: Fix
 nbcon_cpu_emergency_flush() when preemptible
Message-ID: <ZmA5oIkImclKM0vx@pathway.suse.cz>
References: <87zfrzvhsp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfrzvhsp.fsf@jogness.linutronix.de>

On Wed 2024-06-05 11:57:34, John Ogness wrote:
> nbcon_cpu_emergency_flush() can be called in a preemptible
> context. In that case the CPU is not in an emergency state.
> However, in order to see that the CPU is not in an emergency
> state (accessing the per-cpu variable), preemption must be
> disabled.
> 
> Disable preemption when checking the CPU state.
> 
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
> Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am going to push it...

Best Regards,
Petr

