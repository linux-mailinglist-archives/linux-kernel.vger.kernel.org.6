Return-Path: <linux-kernel+bounces-218989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6E90C87A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BE21F21E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8E1AC794;
	Tue, 18 Jun 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MpxSbLbc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B31AC78B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704333; cv=none; b=DBhdvEnw9z4+WH5Q37twV92ZZj76z7XH+YJ2O0RczcMm3/Z3aQCu7RbPUFafcxVzyNYKLwp8fXkPTrB/E2M7mgYiLPHDuB8RXogFBmdURumSAxThERDXe5QLoGqTpmOISMyz7KKiz5csFDNyOqCkPvNJPaiyalSQqex6KL4pYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704333; c=relaxed/simple;
	bh=lpstofRG73uDVk1Z/6guZiSclMY2OFnjBUOwbBpQQok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsKiANKBuBo64N9obXmDnwNyWpoQeQdSelLPyNf7tdsPAks4/QQRWo9FLIdjnI8V7gF7KbQHBXvCTjZIKc4OMpElZbdaft+wfdB80sAx5N1Lvv6VQ+2ISMhFupgKC4CI1y2e5ghCJ2/lDFtCOvIpAgZV+NEFin7ObDKWIZNDvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MpxSbLbc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c82101407so8664079e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718704328; x=1719309128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLKpOAPm5+5EAsIFns7yv/QxPTfttBblX078jzEuTPs=;
        b=MpxSbLbcjSv7dLNlZFbWc4nKBXum1UzzH7X6Rf/AaGaGMhhFnp0CxwSdDrASb58msy
         /Y3UNBd3mGFQBLYJ8AYtvz/Ub+QYehAvORfUqlWD8Przym+9OlMd7ACOzxZ9Mz/5D62N
         yqsiQEFQlsMsGbJlBIJA02q6VxyBbYZi5x8HAxp48dVJq4MJi/Hi3wGUU7j3YFIPEzi4
         XcDo0VfMCDrGQnbVKm01qQVQW6Fk166Lx6utglSN1NjOjf+DJHJV9IqgkTfaw7R56LDp
         bk6UIujtKlJFABElN8Z4sB98ZIDeb9zZm73RW4iSk6Qg0IghkeBKTm5T+k6sCbUdf/Ds
         wDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704328; x=1719309128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLKpOAPm5+5EAsIFns7yv/QxPTfttBblX078jzEuTPs=;
        b=Lf9jEK4YEHfrH9rDqPrg/irITbHF9bLQLxmyGWfqLCY4EZw9gkCYeBgiuk6dquAkr8
         +4DuO+Mf0St+A9f8hq2u9sIBGAQ/BINNhAvDwMpiJ9cf8XrPwa4ZINTFgGiDJnfbIBQ3
         7zjP55hVG1+tatUTgeX+KDwSKCbRJ2gGnxd6eZcGg5lL+/6FsEUNg7XRiidvcQdDBOBJ
         EJoZ5idOqALjY2P9ZQVYa6scLsrTE/JlgZA95QI/6Y4+/mV0KztaaCqhtD4PkRuw5102
         /pMMJ+xo81G6g1HMK7h+FsX5XQhqfyJFI1fLix8N3GRXJV8ayal4BoB0b/0b4wnDT3N5
         DCXA==
X-Forwarded-Encrypted: i=1; AJvYcCUK7fMdZs112pgbDeC4b3zbmu8qJubeY90LX3tkRVTbSabF+YjODEBbQggRo4HkHmQkLn0gAltkF6SU4iXxaaKX2H2nxAAlbbN+Dl8C
X-Gm-Message-State: AOJu0YzTzhyTlJvJxtIPi28JJF6zPoGvQ8kykkfCuWOhdSvOcgcZT1jk
	qajG8I2yYWCZ60PTTGHmZFpqLO91DzcdJIHfDjcCfSNk7eTUCg2SMRU1MJaRzM4=
X-Google-Smtp-Source: AGHT+IE8Ks5Gv42HRh2TCcFWfJCLuZfM37uk5Vb6/c9+mGJ0pB6v4kY9eJ8v4BYixiUCLEhQFme3Pg==
X-Received: by 2002:a05:6512:3984:b0:52b:fac5:a3e9 with SMTP id 2adb3069b0e04-52ca6e56fc2mr10158452e87.9.1718704328119;
        Tue, 18 Jun 2024 02:52:08 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6b2b04f5sm453640866b.192.2024.06.18.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:52:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:52:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <ZnFYxiWXvE7dq6Et@pathway.suse.cz>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>

On Mon 2024-06-03 14:26:19, Marcos Paulo de Souza wrote:
> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

JFYI, the patch has been comitted into livepatching.git,
branch for-6.11.

Best Regards,
Petr

