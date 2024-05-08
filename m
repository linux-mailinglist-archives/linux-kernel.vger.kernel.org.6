Return-Path: <linux-kernel+bounces-173328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E28BFF00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D30289AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A317E573;
	Wed,  8 May 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhsM53EH"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757047F5B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175534; cv=none; b=N1nl37q2kQr68HO8IFdE4O0koAHzDn3E5JDXwXXj0bXJ9ud5j4BXxUrkNBvY9jYccWbZo6kOUklbsundzFsEduCcITG0AFjrDquHJL5SFdW/vSh8ks45lx5FYviUWuuLXJ2nz0Cnqd9w/xQErsk29WROBQjUN8jWkCKb5fnvvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175534; c=relaxed/simple;
	bh=KXuV8RoiY5xdXgYVrpJ2IDhSwHXnabJ23V1GXq8N3K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjBnlZ1TbqXYTQyEO76dNaKEvfTb/imqOj46kjEDlNeSsJ8zsNkzjLfoH845P8yxA84KDhq0cLtd27SNT6cSjDo73qhunaenB7wjxxYGqAuPyWlj2i3kQAot13VZjuKhRGL5GZLrK7ys4c6K4S6SsHDOFyp/q/gGXqQO0HJQYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhsM53EH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1010494866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715175531; x=1715780331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CeiUxlPokRBNj/XrnUanirZmaFrCz9byAC7MP/B4Crw=;
        b=yhsM53EHF3+2iMGxRrTZSKpLHZqhR5xmkeRVlsD+IeDTL9J8Ul2u+etscxeuZ32vVR
         2duiIUcJMYm0M9dFusOl0oEoTA4PEs0USCGr9BPV0ZNqCH6ROlQh5dWuA/qGuFt7kYxB
         UQwcenO3sz6B0bhFnWpaP5fwkU9uFEA/tddXDSeCP8q54yQXNkXwuXmdCF0YPztqXl7s
         0/8xSfG57LXKhOwD0vdKuPm9qIv2BXajPtHLU7Zauc0Da0SNz9hxducxoy+FmU82m+Ak
         4VAEmyBDZHxyBK2F0YX5oXrmZZ5CrfTR9sD7BUzHi8M7CuBHUUd+Z+0G5n+IUPbfsLMW
         a1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715175531; x=1715780331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeiUxlPokRBNj/XrnUanirZmaFrCz9byAC7MP/B4Crw=;
        b=rf7dUrsMThioUmy/n/6Wj24ywbzUy6fqqUycW0lXEn5TSp0cpi+Sk52XgRKsSAzbQo
         19HGEpZCb4owvbbGy+DBjD3awVkL+Asqp+HrzWaALMyk8SYEuOGl5lWcykfBxYufsryi
         A4rNjSeW/AtfexA+CHva20+klSrs87SrE+K77Jx7PytgxfNCLKhVoMgQ4DXOV8s5yBGX
         8lul+8YJGF3ZZQ/1QMTEkZIsAYdeF3hPUQrcjeN4tlnla4lUjLSlna1ArpoCs0ab0E/m
         yXc3XtSbBKDitCnOlHH5dwdujvdsbZy1J15yLONAJKl8zaw+arY+orylLLnmPVLTtula
         omjQ==
X-Gm-Message-State: AOJu0Yzq/9dRCrOj1CEzBiH0w9vkqcmAKvV+JP+Jw0CeHQeWwhrvgtOV
	47ADl/fFhjsHdLM+zqGiPEBe6DCy3ZMilLOWn5C7bqSFReBsjNjHAzX0YiafISo=
X-Google-Smtp-Source: AGHT+IHUEJrR0vQ5S1q+SZ9fehvy0TtVHXmW5rIqD8OHCOWuVd2BODEl8tfj3O4q9WsZzin1gDFlow==
X-Received: by 2002:a50:d78f:0:b0:572:727f:d0db with SMTP id 4fb4d7f45d1cf-5731d9d37d3mr1991213a12.15.1715175530575;
        Wed, 08 May 2024 06:38:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e22-20020a056402105600b0057300ba262esm3523428edu.34.2024.05.08.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:38:50 -0700 (PDT)
Date: Wed, 8 May 2024 16:38:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
	lkft-triage@lists.linaro.org, David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: kasan: Unable to handle kernel paging request at virtual
 address
Message-ID: <3a2e5e75-66d4-4411-aa8c-b028259fe8f6@moroto.mountain>
References: <CA+G9fYvOjtEBtB21FwFmvbautebx_2Py-tjqduPcWyS5B9nB5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvOjtEBtB21FwFmvbautebx_2Py-tjqduPcWyS5B9nB5w@mail.gmail.com>

On Wed, May 08, 2024 at 04:59:10PM +0530, Naresh Kamboju wrote:
> While running kunit tests on arm64 and x86_64 the following kernel BUG
> noticed on running Linux next-20240508 kernel and stride tests failed.
> 
> observations:
> 1) The null pointer dereference notice while running kunit_test
> 2) The stride test case failed on today's linux next-20240508 tag.
> 
> The detailed log provided in the links below.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Crash log:
> --------
> 
> <6>[   43.086497]     KTAP version 1
> <6>[   43.087004]     # Subtest: kunit_fault
> <6>[   43.087577]     # module: kunit_test
> <6>[   43.087748]     1..1
> <1>[   43.092588] Unable to handle kernel paging request at virtual
> address dfff800000000000
> <1>[   43.093687] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> <1>[   43.094770] Mem abort info:
> <1>[   43.095425]   ESR = 0x0000000096000005
> <1>[   43.097071]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[   43.098034]   SET = 0, FnV = 0
> <1>[   43.098542]   EA = 0, S1PTW = 0
> <1>[   43.099104]   FSC = 0x05: level 1 translation fault
> <1>[   43.099837] Data abort info:
> <1>[   43.100679]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> <1>[   43.101535]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> <1>[   43.102321]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[   43.103287] [dfff800000000000] address between user and kernel
> address ranges
> <0>[   43.105111] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> <4>[   43.106046] Modules linked in:
> <4>[   43.108961] CPU: 1 PID: 375 Comm: kunit_try_catch Tainted: G
>             N 6.9.0-rc7-next-20240508 #1
> <4>[   43.110433] Hardware name: linux,dummy-virt (DT)
> <4>[   43.111555] pstate: 82400009 (Nzcv daif +PAN -UAO +TCO -DIT
> -SSBS BTYPE=--)
> <4>[   43.113232] pc : kunit_test_null_dereference+0x2c/0x114
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This function is supposed to dereference a NULL pointer.

regards,
dan carpenter


