Return-Path: <linux-kernel+bounces-328467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C79784AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1285B1C22296
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6D84A39;
	Fri, 13 Sep 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tq6rXw6A"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974447772
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240717; cv=none; b=n+HDejl9VK4ZuFZD4bNhCOdc7RBVO2Urg2bgIPbavwYgLFZiHjNbWPVyfwwKzIXsLioX4h5xpPT5umVKndInM1HgyaHjzhFTx50lUNxASnkeLnoZ6yo90EZPjyNePOwHd5UqbqSaqSf5BgsW7U9nmzq5rVo3TEqN5RWpXt92Muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240717; c=relaxed/simple;
	bh=ofnY92BfWw/2QKucsnWYXMioD0wxXc4P7xS9iiziCDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBd4ZxoFBLwPUFG3KhF9cAXTotvjkKwReH9gPLr0kDeDEiFCxZxAMWiz6gYSoPyMObxlpDZpU/nfOD1FGlYdVSXYNm7YE6QdQTYCVdhIpmmeUXpVzF5DdIuWqNzm0ALc8HRMi+NdtYZjvP1FnLeltRwte5bGi8mMSuDzUSF2pCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tq6rXw6A; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365c512b00so2952108e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726240714; x=1726845514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=erENPJZ+5RHEuuZ4KGIlZ8duewTsHT/YiKKhan9XJ38=;
        b=Tq6rXw6ARLaST9Fl0oZQCoJFyd+rkbTnEGL8IoSzM5X86XOB29AOt3lXQu8NwfgBbL
         rBGsi0102AxekSeNA1yJ7xO8U5F6MERbLsXHxADedfHrLJKevwUDx1o1Nz2fxHwi7KRH
         ij3DBML1Mn1U4Aj5U1fstmpVY15j6N+0klkFzwVi3TTUaFo4v10IXvxeP6bK3Gf+UbST
         KXX7U9RmnHAabYfHZaYuqW46GCYQ5LNZIK5eReGrqCyWoihoR6QBGxTGs0rJzR56aL1d
         dTw5khAGrSHR1SzKZJaRfUrqTcBMnO9m6fISWHyB2P/Hbf0WRmSnqLMtLH1nuN9DCu6y
         Sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240714; x=1726845514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erENPJZ+5RHEuuZ4KGIlZ8duewTsHT/YiKKhan9XJ38=;
        b=v3Y6C6TTXB6dGUd/6O3GllvrPt+/2Sd0+a/DSbD29SPnP1qPJ3ogo689rLTsvkntLh
         UXgd45SkrwJ7NOcTTfPp/r3SjuHWubmVnvww0ff2VQ7GXtI2bO4t+g2YJiVWqYBZPs7U
         OFhlFxznX5GIzYSX6yzq9h1H3CRE2KF8hcGhw/NOJN3MePznu1w3HbdBDM0VZnoxVQvg
         bjrD7OvXir91sFGiRnZCsc0mIZNQ5r4vUzfsoCCgbqbQ2Wrp6B4cHT4ZZsElhvxfq3aC
         QFfQB30olfNTzmR4Jbme9vaMH5NgWUKqJ1K9OIwDHo+zn5wbYlr7TDAKDq3Cxwxxp3b6
         iMSA==
X-Forwarded-Encrypted: i=1; AJvYcCXOOTa2qloGDZUZ0qcN3FOSU0dngFVqD87BnG09P4pEfRfptZVf9KD1sWNucQyvdVRGx49T8nH4elGI//Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sOqfoj0H4OhAtUG40dMut6n+KXr4q7vapO8R/AzCwE/pJVVl
	BoEOQdNH6kR+21oDcEWWLR0RAiQi+7zAzyFAIfmxsRCWEWfah7pUKmAa9JOHYNw=
X-Google-Smtp-Source: AGHT+IG1lNEaUhJt5g/N8BT5UA8mh5OVuIjbuvsCvrvD8rUXsejxN4URMYPbo267vlp/W/YFHYcWBQ==
X-Received: by 2002:ac2:5683:0:b0:536:7cc4:1313 with SMTP id 2adb3069b0e04-5367cc416f8mr4231936e87.19.1726240713432;
        Fri, 13 Sep 2024 08:18:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c74068sm876024566b.131.2024.09.13.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:18:33 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:18:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org, Adrian Ratiu <adrian.ratiu@collabora.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: kernel-parameters: Add uartclk to
 console=uart
Message-ID: <ZuRXxzjctzwOCTNA@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.1.Ic8770cb6e660110359b245808105e5310d3fa528@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.1.Ic8770cb6e660110359b245808105e5310d3fa528@changeid>

On Thu 2024-09-12 11:36:19, Raul E Rangel wrote:
> The console=uartXXXXX parameter is just an alias for earlycon=uartXXXX.
> This means it also accepts the uartclk parameter.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

