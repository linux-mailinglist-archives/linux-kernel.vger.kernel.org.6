Return-Path: <linux-kernel+bounces-179240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD82D8C5DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE61C20C75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31A182C8C;
	Tue, 14 May 2024 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EU402y/J"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11A181D1F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726935; cv=none; b=hStN4n9m0U8s6CPEy1bgZQFJaVmKATyhLwYwykJ8n7fiw5KU+MM5hoXC2uKhFKgCCLyKy4T2dvqOAxSROzY9TpQ98HHN831/KHViazMbR7/hFpTErg+e4Ddy9BWzuK69km9t7ypxA3MI0VMbq9sbrRIyRb+8OI7vKTqhFedpsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726935; c=relaxed/simple;
	bh=0nhAafwxI5HWL8JnwaWyPULuU+OENNhkR2+xS32Iz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9E/FwyI/LVeoWTHgIW6NjSS15+SR8z9zT5q1QUzN8ztaUEX47lxpAap3Kd+5fo0IWv08CoeUB/dFtV2OGk1n8pmnj/pkm/ZxP/GF648UoyrMA0sQ+pk6/jQAgwnxJGOH9/rJ4d5LPEf3spvwPlGTD1R8ldwCdt7kK6aWU1WNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EU402y/J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4472561f1so5620839b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715726933; x=1716331733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUJPFVJdz44IFmC7tap3c4+RPSoDFQyAX7g5ibPkXFE=;
        b=EU402y/JKIyMJuAB2SE8tcVmdT2F5hPBKtJyOcXjOKjuC0bi1A+jvE3BTYF8SihD33
         bOUs8cLbHJSVey7GGLQdKIevzMcEEmYsXn4AHOZiahg7p5gbWoEcA54SWJCXn2s/4NPK
         0VwFCmJ2fNMkhgpbb9l81RK2iAZ2l7dgAPs0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726933; x=1716331733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUJPFVJdz44IFmC7tap3c4+RPSoDFQyAX7g5ibPkXFE=;
        b=daM0I3h/2lOygqDUlTmNzut2qSuvGWeKUA7cawZZc0tCPFe99YhIhc1wIi+8fyvQyb
         SyJq+fZssQEOuY15MAPDoOa1HCV/aKqLdn6nqkddnSN7FaZWnE2BwhRRkrDBrHG+mFGo
         pXypRj6bF0EPOxF9Hnf6nbhlW9A6dyWCQH/jMmQThF+Uc+CKHMvUThXN0MQ/wgaiOEKz
         /erjRFS25vhMymJk9AzGfyw88dL7Xmm3o0I1mPAIEB3LSNqO3IiWcVuU9vCleEB992lH
         R4UFfhgdjazal/JCzJlx3B/HMsLLieewPeIM1fU01PGX2HuK7p3Dls0GB00tYu/qOFLx
         Ugzg==
X-Forwarded-Encrypted: i=1; AJvYcCUVOAGmk9w+OaNr8Y/XN6ayA0m52HPB2G22O91MLCZuvCoPtDTLQRBOjBwqb3j6nbBoTV6nthCB/jbfEliLDAHF3YDAEJRojf01Or+w
X-Gm-Message-State: AOJu0Yw6am1aa42KuI9ehG16oRBSDac55iu8ZCFxBSLLwZnoN8oJaaJL
	Tn0gXVg6Q9sL7K0UmNv2XC8WTOuffIUlwkrTzzkTVuAcVuCVNZYqWo5aY0WsCA==
X-Google-Smtp-Source: AGHT+IGU9RLXGa4w3EJiT/EMc0/Mkh53TeXUez1pHBLj1KnUfvY+4gA+rMJz4t5enAU3FThgSiFSvw==
X-Received: by 2002:a05:6a20:244b:b0:1af:dd56:76f0 with SMTP id adf61e73a8af0-1afde0b7407mr22397136637.22.1715726932891;
        Tue, 14 May 2024 15:48:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a6327besm8838766a12.6.2024.05.14.15.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:48:52 -0700 (PDT)
Date: Tue, 14 May 2024 15:48:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking/atomic: fix trivial typo in comment
Message-ID: <202405141548.E76E681@keescook>
References: <20240514224625.3280818-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224625.3280818-1-cmllamas@google.com>

On Tue, May 14, 2024 at 10:46:03PM +0000, Carlos Llamas wrote:
> For atomic_sub_and_test() the @i parameter is the value to subtract, not
> add. Fix the kerneldoc comment accordingly.
> 
> Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

