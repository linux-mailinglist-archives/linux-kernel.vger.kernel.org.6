Return-Path: <linux-kernel+bounces-235814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBB91D9FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49F6B210A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E683A17;
	Mon,  1 Jul 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5QgfmyB"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFE39FCF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822808; cv=none; b=j8qtidSeThgi8eM2zbgZLID/NklO7n77nQTMa5YUXruWUuS4nQfdm0hv3G028Al2vUCf6w1/H0EC0kavd8w4Crd2qgKNRBPxWLlm71fI2yCvmscNqL2htIBxc+Zh5Fwa4mtkqEzbRLc6R8e1ptLL1y4KIEvSQpC/GmaiMLVkVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822808; c=relaxed/simple;
	bh=hQ3wIo8jfp+1QpIFa1TH6fMJr5lMyi6hFqlV4E+krQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbCuZJJ68bTD1OStcPYT5A/+ap5COTYmv+YdAugeQULaMiIg+Nx64uEFIpngikLxs6rbqhToFxVHtMVehJPD+PJkNrkSr6g4451K/xEk1psSM9SMJl4V8VysK1L4hLHne0I6Fp2eWx8zjn9ec+pC435jXblVG3uTq5GAgcMX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5QgfmyB; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d561d685e7so2032607b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719822805; x=1720427605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plmjyndby8wCrQ0dzhsOGEIbNYKVIMLD81+XwlR3F9w=;
        b=J5QgfmyBoeorJkdPqoFp/l1yjZR+g9jGrNHMV60lcxA7aP4+p+/wSXJPZJnIjmjgrR
         feW1hPvaTGbIbuOzyDJO9G1VYh1dfdkqponINWu4NfKvkf3NRjZH3hCuZStGx7UOBQz/
         oVtcBEHpsYO2zWTIlp7qXKsomqbl/M/ZwnqF6ntFBmqy5uvqKJmX29IDFbqt60ckBJUn
         OFTBKlUsT079gl7t8AM/EeeXQ7BFrOcJ48JY3CdNB+Q0CcP9yUtZe4UyrSkPJB3Dkq/Z
         cf4faQNQMPn+RZz3Um9kbHS8aoP8QExhIB4ubNCfnmshpN4s6x4Ylwlw/lAW4/GjUQOh
         tJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822805; x=1720427605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plmjyndby8wCrQ0dzhsOGEIbNYKVIMLD81+XwlR3F9w=;
        b=sfXriDz8CEQ/5pI5iffHEoOeYlCj1ajSvaYLTDvyXLixuWwaECxHKqSbziQ/rsKSHn
         5U++537kTYrSkMYKDZ775rWl8Yz7XqsQm54pz6T3YPy8uvd4uaisJDLSeUoHvUAu6vYa
         3TAQeXQ4uoP1NDZHeCIZ/fyp6qp182GxHUB0Yu3Dj7VUOlHdKAFxnDIby1/y0yHSkzv8
         WUIqr7g8k43vQ1WhsVm8A2+idZRAgjjChxkQNHQz1+xeZSM0IpYBGbqmetdfTyWwgQTO
         miBPDiDBCYjLzW15jG+P5DiJn5RdWT2k/EgnUXUdV4gXCQ7VVgJK6yFY+Ca0tLtSrhr4
         NkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyvmLYwVMsLIYZC7Tub8l60Q5ruoT6xszMY0sR3z5cxSohCH1Wk+MqfaMg1xiij/2clcTTFZT7ZYRAxDxtwxDEnio9ituEKbjVwsHe
X-Gm-Message-State: AOJu0Yy57UNKhXUDS4J82lTC8Kcsd6BvOfW0HDqk5YonQXWpDNP0QQ8P
	1oOGTlfb5fQFjMZya5iHiy0KZVWTdrtP5HTClzE4has2piRvzClJLWUydtq89Js=
X-Google-Smtp-Source: AGHT+IE1oWZE1bOQ7gPCQ6D2Kkco7qOvhQLh2xnubHsY9YThCuK7aoKubwEBd7IojI4Hbf8ohqHZIQ==
X-Received: by 2002:a05:6808:14ca:b0:3d6:31eb:69b1 with SMTP id 5614622812f47-3d6b54975afmr7594905b6e.58.1719822803407;
        Mon, 01 Jul 2024 01:33:23 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf63esm5885051b3a.123.2024.07.01.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:33:22 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:03:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
Message-ID: <20240701083320.c3r4aussa4qojewq@vireshk-i7>
References: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>

On 14-06-24, 23:08, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

