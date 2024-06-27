Return-Path: <linux-kernel+bounces-232766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD591AE17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A211C222DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC719AA7B;
	Thu, 27 Jun 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia7Lw250"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEA19A2B4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509586; cv=none; b=Vjl73gqv1yTj6LNbYSMaLk8j2AHH7EWOodCqVGLB6l3s69PfMSM4ZJgBkzEeyh8t4JoHtxT5HXbkB8VhSFNb4008OVz8KI+xlQFE0Z9Hw+2kJIWW4pf0lTnLolkcLb9AOSw4jdSRt0NmXmq5ijhEPaksaemGfRBG5FAj65x4f0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509586; c=relaxed/simple;
	bh=6KMR7PgsUZzS4Gtw9YtoPUY76plMCLiaA0INtD68ckA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9YU+ACF5r+u0fhhXEfpWm9NJo5SdOLEyV9tkmCQ4nrDcfkKQyM6npYCgKfZMwHT0TxDSz2B0MxgROrbY00NIfsQVxzdDIpmtCd6z6kNhyGR3w8Wg2CRvm7Etqvr9tsPF497cr6jObHoTsEP2ha9QLhfl0/hVB1nt+LpLPvANIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia7Lw250; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-375deacb3e1so3469105ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719509584; x=1720114384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KMR7PgsUZzS4Gtw9YtoPUY76plMCLiaA0INtD68ckA=;
        b=Ia7Lw250ll0AjoBUjmmpes/Ux3zdHdL2UjDCw1cDD/5QzwO8ktfxpkKSnn1Dqaagk8
         j8WM/AM8NbqTlsO37pWdY5Po+UtktzxIR4K7EgzjzTC8bMBxLzpXiZm+QuYev+/7j/Am
         Jty1LxYvzYZLFLlnHpyxkk+6YndfBaciOgvT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509584; x=1720114384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KMR7PgsUZzS4Gtw9YtoPUY76plMCLiaA0INtD68ckA=;
        b=ocH8psOplcZnsCuMNI3NFr7C3bSnDPzLA0/nZMPkMkM4DUecIBZ1TSd719iLP8UPzL
         haLatUzYyUoKPI9WhPgR0CqrO7rSWpwyd1DNFSCwBnVnySwsB0g97dpaVsV/ostzzEKQ
         4SnoV74QzPbwjpB1NEudGRHtCfD+pFGsgdMdIxl4t2fPUZAv1wAV7cCmLxPEKk16G+Q5
         KXIUjCrUphFmAHpjWA1OCKCBOY5jYc0MVNto1EBGU3mJAeOFNNJ6NAFz5xBr0q4YSoG0
         k2FTZEyzpRRcKNr1AqIVCwkY/tiLz8atQz0L9H2IiGFS9fTY/8gkWEzbX1QHmwlIxi/0
         tDZA==
X-Forwarded-Encrypted: i=1; AJvYcCX7B0JSTR571yKQtJv88wrzKxQIL8ON20LRkm31jjYX8lpe4TuYTeVdhHVjey3hKbMeBSu5gnMOLw7NEYy7IkMfOIOIdcmrnyYyKUm/
X-Gm-Message-State: AOJu0YxRtWJXw/ayZB5xJx2Dad1uecFk2z4VYWtJjfucMb8QkgzgeLr2
	fhYTDpFL3LHd2oM0ocP7ZfYBm/PU31pIVNq2jHF1AjrRMSqwM+L9pD+S/aPG0/s=
X-Google-Smtp-Source: AGHT+IEMU6AcW29OkWVmweJshUFJGfoNdG7kvYlvBcXgW69ACdRZg6teUH2RpIB4m1sqKiImI5XK+g==
X-Received: by 2002:a05:6e02:925:b0:377:117e:e26f with SMTP id e9e14a558f8ab-377117ee83bmr66551975ab.2.1719509583900;
        Thu, 27 Jun 2024 10:33:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2982818sm35465ab.36.2024.06.27.10.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:33:03 -0700 (PDT)
Message-ID: <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
Date: Thu, 27 Jun 2024 11:33:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 01:49, Roman Storozhenko wrote:
> When the 'cpupower' utility installed in the custom dir, it fails to
> render appropriate help info for a particular subcommand:
> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
> with error message like 'No manual entry for cpupower-monitor.1'
> The issue is that under the hood it calls 'exec' function with
> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
> path is defined in '/etc/manpath.config'. Of course it contains only
> standard system man paths.
> Make subcommands help available for a user by setting up 'MANPATH'
> environment variable to the custom installation man pages dir. That
> variable value will be prepended to the man pages standard search paths
> as described in 'SEARCH PATH' section of MANPATH(5).

What I am asking you is what happens when you set the MANPATH before
running the command?

thanks,
-- Shuah

