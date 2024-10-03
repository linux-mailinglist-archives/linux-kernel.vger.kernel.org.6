Return-Path: <linux-kernel+bounces-349401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8898F568
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA51C210A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF531AAE0D;
	Thu,  3 Oct 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXKaRqtN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7B823C3;
	Thu,  3 Oct 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977100; cv=none; b=t+Mqg1LlSeeSILXIe6qVJIVDhy35MdDW3X3Wap8OdbScl/+mf/FU5xGbvcIecwIZWJX5eVe0M0zJF235VClhK8MEkjYZmZY9uN2+xBfbEKUovIJ9U7j6x3fnpBy9E1PE08I3hl3CN2SheASPkNUadHtXdAFxLNtcnnPU9T5Mp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977100; c=relaxed/simple;
	bh=SgORrJ2SXe2oAPjb9K7t6oyVWHFvTDPYNgTEz7El9hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6dQo1SBw3zsVrAUtz89J98/SpWQrBWxuQUoSa2jr0ZmrA2JpCQjSS1N4VsTAV9i1CHfM4hVW8pcVghAE7qVSVuD+nEQ7XoWxzdcCUWJg7qBtvkpdsdhqQIxa9iBCsNC4whqkxpijbDjwdxNo3wn6CnLJuDWVE1AWJ7AK+5hnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXKaRqtN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bc506347dso10696145ad.0;
        Thu, 03 Oct 2024 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727977098; x=1728581898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkITe5Ytq6JmnVKik0QOxV4M52mAeQNmKpJ6MbOVMzQ=;
        b=QXKaRqtNdR37p3KgDI0x4xGDjAG6eMQpEgcqF+Q8kWq6canun5zmBbJfQ9pOvjuSmp
         2sQ8yNbyIj/Ouoxo5Gi23oi9ATmK84XvEwU8hT333BbNWEmTwQhJGhIowiBPuEX49MCo
         MRHD9tWYW6/tF5Ye6cjoGJNu4ymSe/co7v7oVbTUH4jIIfZaFFj7fwaM9QmyGrlPAhib
         KKJFzuUbLMTxMtmeuUweCujk4XAlzntjkpgffUKAV69GhejO11+Bs4rZH6+y3BJjIjwM
         5BnLfbe4OhPswaYCpGlCjHRVkEHHYgQhzN1GDb0b8YxLKcfrXPI5PvC6U7IWqw1DB7b8
         VtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977098; x=1728581898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkITe5Ytq6JmnVKik0QOxV4M52mAeQNmKpJ6MbOVMzQ=;
        b=T82fjbY24hWY0T/JdKiSd0nVvLRWRO+ssHNzcIdpPu1kk1ZI4Jlr006TDzTbMdp0dk
         RwzChC0jaF4bmiSSDU7MZsxLQNcTCLLKbrhmp7hnxYKcN5OV3ymgcIzH4ugVK8K9y9PX
         NlOzn0yNUPT0wChv3aa+OrtjRZYlB+DMAYIvo8iKtqcCEAEsSxVJvF7H8Z72Uep6FN/a
         ANcVHBu3AKOY5hUwIKmnqPij17K6N+6+HkgTsVXwHfR1anfa2TNz+PoGTCObLDp3mnuc
         9Dc/UXQOC+cujOpif9EhkNsl2BIqvYXlanEDAbBfRbI7jaGNi/AdQn01i5UJpSx7BF30
         M8dA==
X-Forwarded-Encrypted: i=1; AJvYcCU57F+gNLvLxmvlEO6rzRtgH/GMxm1ZKocemODEtO0GiQp/Rv3ftFAWPUHlJnUphMap3g4DRA2Bmqo=@vger.kernel.org, AJvYcCUpNpKup/iz6vQuA1WBDGHsLZgHMPmUesWWiD8MPdUmRNoDz3IOZMv+0EPaRVxTURoqNBV/XQlVguSIaGZ8@vger.kernel.org, AJvYcCXqyFMQ7pQd1IVsGRqhFvRXpXVeseJkE/4wzq5Q2W2xKXmCq8LwIJqpRK0Yz0k+00o24xJFvUqgvKPMnSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZKcI4BkOQRGX7zk7sYdwWk0WkV9zZnaiPFI9aD/Pc84Jkj9Kg
	npKCzGKok682vz7+axx+T2zZimdVvEP2oU/q9amb+N6QfnciTVYC
X-Google-Smtp-Source: AGHT+IE36Zh8skC7PrASbszUyoYNFkP7azc7fZwhBboN0Rb7lcEBTHiQJE6fQeLGCTrG9m7Pxq3DfA==
X-Received: by 2002:a17:902:e80c:b0:20b:51c2:d789 with SMTP id d9443c01a7336-20bc59e6496mr107875515ad.16.1727977098307;
        Thu, 03 Oct 2024 10:38:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7074fesm11391585ad.250.2024.10.03.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:38:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 3 Oct 2024 10:38:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: KK Surendran <kksurendran95@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: fix typo in max31827 documentation
Message-ID: <c894b9b0-9cbe-4911-a558-2515f13cb60e@roeck-us.net>
References: <20241003160149.43991-1-kksurendran95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003160149.43991-1-kksurendran95@gmail.com>

On Thu, Oct 03, 2024 at 09:31:49PM +0530, KK Surendran wrote:
> Fix typo in Documentation/hwmon/max31827.rst -
> "respresents" to "represents"
> 
> Signed-off-by: KK Surendran <kksurendran95@gmail.com>
> ---
> v1: 
>   - Initial submission that corrected the typo from "respresents" to "represents".
>   
> v2:
>   - Updated the subject line to include the affected subsystem (`hwmon`).
> 
>  Documentation/hwmon/max31827.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 9c11a9518..4a7d12934 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -136,7 +136,7 @@ PEC Support
>  
>  When reading a register value, the PEC byte is computed and sent by the chip.
>  
> -PEC on word data transaction respresents a signifcant increase in bandwitdh
> +PEC on word data transaction represents a signifcant increase in bandwitdh

This has been fixed in the meantime, at the same time also fixing the second
spelling error in the same line (signifcant).

Guenter

