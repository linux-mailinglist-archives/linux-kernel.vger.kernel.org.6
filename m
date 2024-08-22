Return-Path: <linux-kernel+bounces-297796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8195BDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B880528595D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C51CF2BE;
	Thu, 22 Aug 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IZ4jB7EL"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025C1CF2A2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349516; cv=none; b=VaMX2wr0vJwiGhEgji/D9yfJUxCNVXfc+6DzWPue+4LpOPRuRtQu54e8leuAsWEWvR5GV+aSJBS+3hFazVDaAxxCmLAUXiX9MO0e7u/ujFDJgz97sQDfFR8ewLUbG1tZDtMQlnvmx5zpF/LyV9B9oAV6tCQyeR5Lccc0QKMsD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349516; c=relaxed/simple;
	bh=S73uaUA0DW8CttN/Jhtd1B233vB6M3ngjcc3vgt+v/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CimSaSHYNFjI31VpwNho28KCwWbAVjv0nTMKqq3qZ+88eazZK6t98OCl+okHxg0TEtl/qd2yP4M6W6LnaXWyw4wpT9IVvPIXIUaRM5QwyBpm9USkDMeWZOs3SWIRnLpVVkerCtYjFZmv7bC7Gr1RCitVU6AcYGb0QA4mrCOa/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IZ4jB7EL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd967d8234so722049a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724349514; x=1724954314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aXl0P5+cZPWz0CJSmKBVPNCrelta2lMo8G0fOIDW74=;
        b=IZ4jB7ELFfR+JOeCXRJumpolI7xWgHqQDn6V8nZu1mlKxl/nIk6kbcIGlXictm6kNq
         N9/r9PmgYKOWZRH9D+m2SwuSxUZtLBbjWDmwdCKAtlmqDryIVMO1P2meROOb3TQ1U54o
         q8o4F8crSjnVyNGw108ohCC7mm/A7PR/TvZn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349514; x=1724954314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aXl0P5+cZPWz0CJSmKBVPNCrelta2lMo8G0fOIDW74=;
        b=EB0Qxj4J+Xb0CenxnYuLYBANfb879dMaEsp4Ob0s408ulvuIDysb4RoXIlRDtV0Avs
         0xVh1OGwFzW5UpNYkt0Z097kuVjkd9iGfYlxJMe0v631XZJ9foFX7rICTogbj7EQ7Sx7
         ResIYEtOoVKq6noa+2PGodnp9IFuZFKzdblYfqh2xXkkok2ocIdLWXLC18qe2HapLZO7
         cNWGCD+MYchdh/7UYrUwDcN1UPd5/a0PxV/ckGr02QHE0zCtlPCSf/TDFkGrJSmbA3tH
         W64VncYSU9vl0+/ZtZMMKUtoI+s1NJcJ//Qk71d4a2UlTNjrhYXD8x+WOxnCWzHzrPAD
         /jpw==
X-Forwarded-Encrypted: i=1; AJvYcCWMCqnJNAXRHZpEkPDeAhNAnLSKfrLAb+822OIA0yTASwk6xE20xzevGQqxwn/1BMNXEKoX7PCngjyIgMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJkmH3GYtkhkw5T5+CukGLCKtJBZXO1vkVvTSJyvmeVAghyuW
	rY5qzDBqRc3BivsiQPrUvnXdV6pAM26nIsqC7jrKLYinOogLbJBRV4NiapT6IQ==
X-Google-Smtp-Source: AGHT+IHRCAtfbv2wW3c5v+2i+dD3SGwv1uIaS3D1NnMthKKsznW2OPiT8cq1knA2oMx203qjIZrdww==
X-Received: by 2002:a17:90a:634b:b0:2d3:c303:fe14 with SMTP id 98e67ed59e1d1-2d5ea2caf9dmr6288794a91.40.1724349514149;
        Thu, 22 Aug 2024 10:58:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:414c:5b44:2fea:fb6e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d5eba287e7sm4473583a91.34.2024.08.22.10.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:58:33 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:58:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 01/31] wifi: mwifiex: remove unnecessary checks for valid
 priv
Message-ID: <Zsd8SPnKKJrdJj9W@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-1-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-1-320d8de4a4b7@pengutronix.de>

On Tue, Aug 20, 2024 at 01:55:26PM +0200, Sascha Hauer wrote:
> The pointers in adapter->priv[] are allocated in mwifiex_register().
> With an allocation failed the function will return an error and
> driver initialization is aborted. This makes all checks for valid
> priv pointers unnecessary throughout the driver. In many places
> the pointers are assumed to be valid without checks, this patch
> removes the remaining checks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

You already submitted this one separately, and it has now been merged.

