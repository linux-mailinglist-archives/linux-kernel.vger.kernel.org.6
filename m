Return-Path: <linux-kernel+bounces-546336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD7A4F961
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A483A4D05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FE1FFC6A;
	Wed,  5 Mar 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OCFDivGY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DB1FDA84
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165201; cv=none; b=X0Sq4q7YItt5Ec4KBTanDVEusbzxOd/XBdAW/sn6EB5xhpmiOvHsERtilxyx4VjsB9p5aMbSbHPL7p8NXreGNsguTpMxMqyMEnnkJ5KPMZxw+xXuSimqmdQ6zekkaTG1svJjnd8IccnWa5N9Zq8mP5T1+4tvblS3hxBrdqrd+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165201; c=relaxed/simple;
	bh=tJx7lwrM9+hNA+h463XrNadKsRCyuDOQd5JGTAryAZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJxdy+UlS2K87Yn9+WxJYjsMUOSJz7BxzSS84h6IHSa03Mb4tMQzeJRxc07616uRhCVGtNzW99Lnzj/Jrk/gJvlM4Iq4s2ZzB1yEsoDRfGa9MpBj5SlqtnaK8NxZUotGFlBdquK+3g9gP0bfn+LgVJAJoWTt2gdypLdy137B7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OCFDivGY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bc38bb6baso18744365e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741165197; x=1741769997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edzNgY/MPBOzvWKALkFKwqQhfIF0sH1L8akqPC1eS3w=;
        b=OCFDivGYg/wjW6NGQ+W+vtySz/qndYFexlz5zXtcq1q6QfUrubsuNPTC/LuPwm/5Dv
         4gBBAweC20wm9PwS8RF9wifWhOu1sFStRX2HJDyGiuQI7lwDe0SDDnE0cNtX46M8qKrP
         5A0UwdbpVDporwBwxgFl0dRin1E2XO8uVPjrJ/puKrT7k7Qho8ZccWU6dCL96PmzfWER
         UIern3FlNxRCILPVyZP4fJM/b2VECRx22bx3xytCRKrmDjA9yb7JA6iHoPMVl8KtL3xN
         jNz/zVW2Mtui2SIsfP7aKi9n86XBgt7n5GZWl4lHbIexuuZDZGCkIt+Ft0S65DllJFQS
         yrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165197; x=1741769997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edzNgY/MPBOzvWKALkFKwqQhfIF0sH1L8akqPC1eS3w=;
        b=kffahDX8Urrw/j4uYSJ6OqZaqXCY3apJ51VgO8U29TPwsFXiqCm9tRWsjndw3k5YOs
         Q2EhR+1dx60XNMK1jqrcHhsVUz6E/7vQpocZ6MpcwOiHcV6zXdejEyie8V4/Kfcb8QHh
         DG2XAG+PfnmKPpBtMZhte0F1EPld/VXDk4HTnzAXBAkX8bmJcwMuhK/+VzK8AzzYO59i
         quyCUs0Pfog0r/BGemXgMc+GJh+kUsoGXfaDinCyUzuGaLj4byC3Di9yTDOShuQxu4d8
         40OysgBYoKGkXdlGKTjOOfV62GvccuPYBqMoSjz/AbQsHxuqDiGN89gvUqvPZEy0Q3eF
         vxFA==
X-Forwarded-Encrypted: i=1; AJvYcCV+4yS17EEPn3r8x1LeZr5ja9hVEpn4O/o8GUz9J1xR7uMC0YIJZ8xBTsbsdcYoW3rpONilqAXLmObjfyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyYqlTfmvXjGI8Q2GV6EALZCGSAxg9XCxh4rhj733lnsbNpM8
	STrLXo49nRXPS6l7JPcOZPdi0BFI4uvB+SvKwWZxGWt9e7aKVHaC44W4HY7A+Jg=
X-Gm-Gg: ASbGncsYM8EwdnvYSE27JdG8b9ocmy/Wez5uxa2AlqoX/RKLhlsiicGmVCS8HMmd2tF
	yPTB9otaDNqKTjxypoDaijlXaq7huOtOkE/jahyzQXOcPIkteNvEWSqJCt+x1gCl8Or8rX30Yrw
	kpfTPgysx1PChtYvLynUfUzwxGzFYkX8S5JMFeIA1nT57+RhPUP4d52XKHfK5gzvz5n1joPxNGq
	VAOZUjTx3kVxg2k86QcCe6vxxvh+iAT3p7tgFcwKNSxxuCkS/n/Mu+BSBlX62vUwKx0OfvfsWir
	0NKgu2nBKKdW/dCun1iq1m0sOyW2p3xM1a+I+iB8CxfrIeM=
X-Google-Smtp-Source: AGHT+IG0L0lleGaL3ooAvq6ErAKRkUuJsxECYWmDwticl8Duw3jSln1YBb7ulpdwFEB7XpaIISFuhw==
X-Received: by 2002:a05:600c:510f:b0:43b:cf12:2ca5 with SMTP id 5b1f17b1804b1-43bd29bdf43mr13912775e9.8.1741165197593;
        Wed, 05 Mar 2025 00:59:57 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd429136esm10966665e9.9.2025.03.05.00.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:59:57 -0800 (PST)
Date: Wed, 5 Mar 2025 09:59:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 2/4] scanf: remove redundant debug logs
Message-ID: <Z8gSiwsSvjl7c4rR@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-2-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-2-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:19:59, Tamir Duberstein wrote:
> Remove `pr_debug` calls which emit information already contained in
> `pr_warn` calls that occur on test failure. This reduces unhelpful test
> verbosity.
> 
> Note that a `pr_debug` removed from `_check_numbers_template` appears to
> have been the only guard against silent false positives, but in fact
> this condition is handled in `_test`; it is only possible for `n_args`
> to be `0` in `_check_numbers_template` if the test explicitly expects it
> *and* `vsscanf` returns `0`, matching the expectation.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I am fine with the change. The debug messages have been obsoleted by
the 1st patch. The file:line information is more convenient to find
the failing test.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

