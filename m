Return-Path: <linux-kernel+bounces-263309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4393D425
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36443286C57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9C17C20A;
	Fri, 26 Jul 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="exuypf4Q"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EE17BB37
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000210; cv=none; b=dgKWhglGrye5lOWH7MkP9wD947bCsRJho7btb81dX5nWpGXga+TgixRmhLNTa/QFRK4BiNsa2P80TSUft+3CWJ2GGoTmMhK/3+Wxz0nhoA5tXy5pH3AMFwKFRt4SZL949POrAZ39iGveAm0eCMy+XHrnp2+rtxO5EIsKnebe1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000210; c=relaxed/simple;
	bh=4moRCxq16Fkt9ByPEhARvMciuCmBZ/IBbaE7Pu3jWyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKeaUm6w/acD18FiR+gQMnjrMQghZgEjkfVPpuwAvMhuCmY4f5K1h3iGiLT80Bl7EXNBCZn1i6Y+Atx9bQVI5SMiDCn3TZG/sDF/nbCVlGKmhhwMvG6oq49uOexaRYoHvGK2a3L+BKeQeePcEcuMeqjT+SZlw56Qn26p781Dkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=exuypf4Q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso1616629e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722000207; x=1722605007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcOwUQZvHea6wP3SSMF8x2gLUtSeiLMW/cskfTjMV7s=;
        b=exuypf4Q1PQnndqB5jisuVHpYMutSDsjj8yjFf8Unp6VoAa9VLSLlodQbP9Ymk0Qab
         Afgsw9gNmt4C/0V3djPEGiQdN5hZyLCv6nc++H8Fnr4WDdqga3FKtQs/nhmH3ujs8wZy
         upKs0DsgMlf2YYeglUvKeX7AEmPNJE0isaq5BzK9qZh9eLp5Y8VgJW/c7t06dEnOMHCG
         cxJ0K9l4NA9KWdJrFgJhSEUeQ3P37K59PpXeWBXlMLrZKeIEecry7sSF2mjngby7YdtX
         HuEzAh2h+GVVGCF5APN00LMMe/3tY1dSpD/0J+QqN9kZUG5y9NfKmp8/b/akjDNJdkWt
         KQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000207; x=1722605007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcOwUQZvHea6wP3SSMF8x2gLUtSeiLMW/cskfTjMV7s=;
        b=ucxfgNEbeYmJ8cej10MagLKUOKF2zEhc+POpHbAqAi4xqOuBxW5vFiLLRQ539DnMF7
         C3qGbSlCYnxAKOL99GCjV8iqWS9XZDQS+Og+qYSXM+Wc9oZIUvaax++7fPt6xl/6k6DH
         OXdliCkyKyC8F6pGdGz4/qvvvM7t02Qw6BbSmjlMU2BVfRkun0zgfn9rSH5ReeLKmTYm
         W0+zu7vGnjVr9zN1AZrGl2eJsYblt5cm3vVxqPe1rDh4xNx1rL7OK+hr8xqmdkrSEYkU
         O00K3Ig874oP6/XyhfkrYlwlIs+XurlsC4n8zFVRzlcRshHeiF1mglRb4qtSoCLI36CF
         bTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qxHeyGfxn7Hm0dFClo4X32WZiwKLvOML4k8zf0zdSWomQp/cl2oCSvF08C0YAQUc3WzIH0vvNeG2u1g6CdIt/KCdeyRd8PIoz+vs
X-Gm-Message-State: AOJu0YwqcnrWpJ6lsr99rGfNKWfsiGMCID2o72Ppk6k8fe3Bdag7FfEi
	BDSsoy0eW8OgPCoGXweFyeuIjUjRkkW/fHDrwvyyX8G1xD14IwvTMc1OCEDoEp8=
X-Google-Smtp-Source: AGHT+IFyffCCLAEXBptYJGAUiuYH6wA3N7rNyP6IIgQch3maIbvNg+QyW6+Ya3tPkT0UGtqVj/VMAw==
X-Received: by 2002:a05:6512:39cb:b0:52f:c27b:d572 with SMTP id 2adb3069b0e04-52fd3f92f08mr4981974e87.59.1722000206405;
        Fri, 26 Jul 2024 06:23:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2366esm176453466b.23.2024.07.26.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:23:26 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:23:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 06/19] printk: Flush console on
 unregister_console()
Message-ID: <ZqOjTBD4GGhV5aQQ@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-7-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:26, John Ogness wrote:
> Ensure consoles have flushed pending records before
> unregistering. The console should print up to at least its
> related "console disabled" record.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The code looks hairy. But it is because of the unconditional CON_ENABLED
flag handling. I do not see any better solution.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

