Return-Path: <linux-kernel+bounces-329306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAE978FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D9B1C21CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B61CEAA7;
	Sat, 14 Sep 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXsLhkbd"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFAC1CDFCB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308337; cv=none; b=AM8o0Z9VoB0cS2HfzQw0DpymEYWLbHTcVh+6DneQSVGLM+MSQCj9s+dd2I3sSweRO/IZ+JVQ+zrJD1nxL+qE5bZp2UvH0KqpK3y2AY3ZmM7xx7aRB/rLu4wgelNeVf03VknyV/WjkZ11slwqjPbGc/FZGRRMgeZyHf666EXcdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308337; c=relaxed/simple;
	bh=uyUo2fF7wfyuRfSxg2fJMYfWzcWgmdiUEo5RMmlO/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcvKyu639paYiPgtxNMTZ3KCR1ldO87qKoUwuvlk4FLvsvTJRqd+hGzBV4HTBQOc4iVtHE3ThLDqi6iBZbczNM2Ou0hMAfufdBETrm2z4WPfWIFP/NEOBfRMokjwcoS7nMv6R1/8UzHRlLJoeWnJDePk0DjyHGm1PlrSemlPVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXsLhkbd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a81bd549eso341742366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726308333; x=1726913133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQaP07kUjh9Hh3Vx1aYpBskYDsvr/ETiwaom9aVLxSk=;
        b=QXsLhkbdUv3OzkynxfeZvpleBXmyOxG55sl10ZgoZC6KcgEjo0cXvfKprt5kMCBcVf
         W8yLamK04g+xLBsK0hrhEvGxWRnW0BvRMfp21Xv1kfMYOU7/onrZNl4HKwmN/A9Q0H12
         saa5Ge5TWuMRYChA7wOW32FapGrIy/EOyUEd4G17AGQ7N3UYf2jr0+t5Y5uOttISSD0k
         h4/LDQ+kus4J0/x9bNMIVGWZoy3QsxRtMRYxTa/bcPu5f9CW8oiou14RUDZJccqW5Zcd
         JQ8rxask7Sr+ei7cY9Mt8ZHtJES1WYDrQkVdCyf+2BZblvBHYHJAetDN1fB7I40YRJKy
         P6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726308333; x=1726913133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQaP07kUjh9Hh3Vx1aYpBskYDsvr/ETiwaom9aVLxSk=;
        b=k3oixB/ucMHGZ2RXbd1DuruDnxtkHxgneAHfy/25/Hf21ZvsZ64p3tHPIntyr6ULmK
         N4NhNtva6aF28T4QO5RVlyUuXgtcjyac6oUlkeq2m4iTfmf7fbR3LOmPRZ4lRw7f6MQG
         Qn5llIqVbvGArqd57a9nu8sW/3FHTubHKc/twu5rR0J999lmof0eSDxLki1PCDEYJ4K0
         y1dwATKWgKv/hncSZB0VrY80k2MP92uFzFl81l0iTnBL+dLMuSBdzD4vkzq1DBGPwgbt
         QKT7NhfLuEyjprTx9QQjQ7GjOAw7Oc/LQrVSiZuxF9rvOQ6r0DVfRmAQ+OWgDQcZ1nVD
         04hA==
X-Forwarded-Encrypted: i=1; AJvYcCXKT6RRSGN9FSoc2vTyz0KYE0/TUEHpbg13wm6iEnMDauCIhKrFDEH/QZHrgmaDCwz6I7tygjI+1NzAUHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCipOKlkrjGiI5reT4lhGfCLZwjBd/MPbsXhw6CaSzBs/spFmp
	UugIGelLtBEEzQWe4i+JzuolyuF1w9n0CJ0+lFCFIdOR7Y9wdZqXRd1aWrK/vUQ=
X-Google-Smtp-Source: AGHT+IFUGe/YZnTvrPrKTN9LdMp4s56tVPxGhPOwQHgiH6EffJdxr/Zlk+uPLUhxjZOYMNerF5RjBA==
X-Received: by 2002:a17:906:478a:b0:a8a:8c04:ce9f with SMTP id a640c23a62f3a-a90296eabbemr942716766b.52.1726308333391;
        Sat, 14 Sep 2024 03:05:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm61912566b.33.2024.09.14.03.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:05:32 -0700 (PDT)
Date: Sat, 14 Sep 2024 13:05:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Su Hui <suhui@nfschina.com>, jmaloy@redhat.com, ying.xue@windriver.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com,
	tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: tipc: avoid possible garbage value
Message-ID: <f1279370-a127-4946-8c46-cc89fd2a90a6@stanley.mountain>
References: <20240912110119.2025503-1-suhui@nfschina.com>
 <20240914094244.GG12935@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914094244.GG12935@kernel.org>

On Sat, Sep 14, 2024 at 10:42:44AM +0100, Simon Horman wrote:
> On Thu, Sep 12, 2024 at 07:01:20PM +0800, Su Hui wrote:
> > Clang static checker (scan-build) warning:
> > net/tipc/bcast.c:305:4:
> > The expression is an uninitialized value. The computed value will also
> > be garbage [core.uninitialized.Assign]
> >   305 |                         (*cong_link_cnt)++;
> >       |                         ^~~~~~~~~~~~~~~~~~
> > 
> > tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> > is uninitialized. Although it won't really cause a problem, it's better
> > to fix it.
> > 
> > Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Hi Su Hui,
> 
> This looks like a bug fix. If so it should be targeted at net rather than
> net-next. If not, the Fixes tag should be dropped, and the commit can be
> referenced in the patch description with some other text around:
> 


It's one of those borderline things.  As the commit message says it doesn't
really cause a problem because cong_link_cnt is never used.  I guess if you had
UBSan turned on it would generate a runtime warning.  Still it also doesn't seem
intentional so I would probably count it as a bugfix and target net like you
suggest.

regards,
dan carpenter



