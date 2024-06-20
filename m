Return-Path: <linux-kernel+bounces-223021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E6910BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EF1C242FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CC1B3F1D;
	Thu, 20 Jun 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuJojiHt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F081B14FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900303; cv=none; b=WSvVrJARJaLt/WtZr+y6E2hBPa2fnlZVVL1UV3z0tSG5VHFE8wBSC4pIC86GWPENSVnLbUGGYc102IWQQIZbkBxKsiRjX5/0ZrouomtMetI7RUEDcL6K6xd2EVic+PXjnNWb67DSHzjAQDIHLbL++qkaV8kDxpycZ9ifHvJMKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900303; c=relaxed/simple;
	bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2m5AraSOAeB5KheaFJqp/+7t+x2cMhddp0xVoScvXtcnc2qt8OXjxX807mlJUNPEqCWGSccD1QueS9bMA4u+bHHMGHUJyi/tCVwbrKhpX+eKwtBJnSI2vG9nbVhoqPqpdydQg2DeSO4TkVs2e7TjgzAyxOTgAVp5ft+uo6pX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZuJojiHt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cc148159dso1172232e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718900300; x=1719505100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
        b=ZuJojiHtM8pqmEOcImp4bpsv8cNm+3QGxS/HU+mP5Ts2QW332SAfN6gsAtju68IMvf
         CGJkAe5wnipN2iiHMuGNIueZxL99jNrgCSbKXr7yij6WAKPks+eQAG4ehVUN8mf4yTd9
         eOWvIxMSj37sUyhSXUrAnXa5z3UWU3DKM2jts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900300; x=1719505100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
        b=NB+ywdE4mOPPEO2oYgm/1xGSbFUsE8ZHRNU8i7yMVMfaDwE7STQbZZ6sgdSmQPgENZ
         01CuQDsy7g79fUWBXhDedxsNKL5rYhaDvxJrivolxha5yZV+rKQimkWUyPeCYkIgcXcI
         aHHHKy3wapGyhg5m8dM2HAwyAfJWmg1qVJoIsfKJd/lVYa6oMh0Vp/KLikGr7XcFevED
         IBSYC3JmFi/GQKfr7bOL3ksyNYFwmlUOo8yBpAFmWdQGw0oLa4Czgk8EtKGlg16mTYip
         YO5n73AR+mHzekbiIgMkYTRQWRaXdaxxskfwBUiM2yA9XfTMI5M3PZweq0flUB9IDoXL
         yscA==
X-Forwarded-Encrypted: i=1; AJvYcCXOC/DrMMDNpv0rZzgDFP9wue9ILAZWlkN1TmxxbRyFZ/C1kXuM63zOX9Xt7zVbevEheIvVgbNSM74Hp+FE6OIX8A3GIQSezupFHK1S
X-Gm-Message-State: AOJu0Yxi2t7qJzWpOUlmbEhP6N8nI5eoG2ARWflQwR1SbEv7gR+o7tuK
	AY7v0kyr1WVhQI3BhzBiClbGCQjqS4R/ihNPU6NntBJFFgSH81Nk+CHZbLZ5fCApHUrvxQkHLas
	74PDdSaXyEoNkoJPzBKCx4/cYq6rp3lzhwLo=
X-Google-Smtp-Source: AGHT+IHDU8ss1nc317vIe2fyNJOwpxsq9qAqH9/zotSaIpik4JcCY87vNSLPwSCr4vV4re+EvLAuOJ0Jy254SowvUGM=
X-Received: by 2002:a19:8c0d:0:b0:52c:af5f:8535 with SMTP id
 2adb3069b0e04-52ccaa5a8cbmr3226753e87.18.1718900300382; Thu, 20 Jun 2024
 09:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618093656.1944210-1-takayas@chromium.org> <ZnNHvwV7tDlSFx8Y@casper.infradead.org>
In-Reply-To: <ZnNHvwV7tDlSFx8Y@casper.infradead.org>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 21 Jun 2024 01:18:08 +0900
Message-ID: <CAH9xa6et8XGg9Et1X6K2o3vFF1WhAQQZqiPmTtf+BKfykSV_EQ@mail.gmail.com>
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and fault
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Thank you Matthew for taking a look at this!
I fix both points and send a V2 patch.

> This needs to be cast to an loff_t before shifting.

I found that this applies to add_to_page_cache and delete_from_page_cache, too.
I could fix them too, but I didn't since it will change the max value
of those traces from %lu to %lld on 32 bit environments, which would
be a breaking change. However, let me know if you think we should fix
existing events as well.

