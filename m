Return-Path: <linux-kernel+bounces-551516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F56A56D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85CD1898965
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706D23BCF2;
	Fri,  7 Mar 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3h62ObV"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673F23BCF3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364642; cv=none; b=FpvFVeitBFO0M53u9ivTtCTJ+UVvd8TWaSer2c1GY4vqOsBMp4pMK71VZYrcYBALsTcuz500LfwWtOoQZT4uNvHMCyVbEyN3R0/8XDDanb/xIyYLo38G6ymBp4R/HoSZVpaT/nQ5dthG8MPAfeubvvcAODouD5yt7nXSZiT0DX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364642; c=relaxed/simple;
	bh=mXtKy6AqPJTsyZQnFb8LDOzMrVCF8Jxpd5iGHDtoCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKbUpD5+NI3LAVM3AAaYXmage/5WgPq86X26VY66NQG4dCZ3ehgOPI2o+BwHzv72HOP3WnYJfnw+XczIXZZvGB/USUak8KReqoidceIVnY4LT9od73jLFDoMcq0wCvBzgUWKQcgta+MVEPRVpiNU4Szb6oH6HGyhIIFaz6UZnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3h62ObV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912baafc58so1385299f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741364638; x=1741969438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFC22TuZGe+bG1f5l5pg/Qemq+Rum0/SnOpCdO9V/4E=;
        b=Z3h62ObVMeGJPieKQt3rx0AECyQt8nD55EakDE6+10CK8l/oDR6j8n17mRlyav5VaK
         +J5PZcp1zeIuKoJi/IF0pcT6axroQOsFpJu3B6XlNAbTbZ44VL2UPmiGXI4atPvMUPvw
         k7W39V/KdvELNNYVOnwBIAVHaeL0k+w48aPMkpYJq1q9bPMc24PISlA3jE/JUN3izZNJ
         g4tarfag2/SWykLqOeCt/qhJ4AoA5qGz0FmMexxqszHLiaqxEZ/SqFA46AtnRRorecmV
         dGgc7stlZ4eSivUucXSGKHRoXwLWB3ruT/HrZld3uOGjySHpHx2k36IqToUcdZW4SXFw
         qinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364638; x=1741969438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFC22TuZGe+bG1f5l5pg/Qemq+Rum0/SnOpCdO9V/4E=;
        b=TStsWcdED4YytpKcEnEtXVLlYqHVkYLZQG1VRVE9mViGgH/TBqTgMCME4OGpP8Y3e7
         7chz2qUv7JJCmiU3npeQB5VcwlUyFeHz3StfCAbsNtN3Bs+gfqTznRlz7aNMv0SWGBsu
         yoLU+ipMyo7PvrO+XUJFl8TWavwlGz6nH1ynNzg+IW08LylfyQwAqdMbk3FpRt30epxA
         vhHYF7HL1KrV7h1ODXQ+45kl6p4nYhYUSNxSJp+1m9zHLn2CFpVbHsU+8KW8pEqsVlBC
         szuiSf/rEOXJmD8KVTP7wpDt8CorUMXMJ28sn0hkyXGXkAleK5nGfKrECoPRfWnvmvIz
         yvmw==
X-Forwarded-Encrypted: i=1; AJvYcCU++tPmjVEuw3EOThbd5bgxojXPnG8M60sSnX83e3dKlgh7kjnXA2mTU7rhLfAZV6gmJRcfGNASk7SgeS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XLOZM8wVykgypAl+/o87EYSbpDzuv+pyOsbitVVeohR75aTO
	y0reMr6Xr1rYLdVznQuiwI8IMdaW1pr+4Ntpd5Ix05ixKgcNlFh2G9Cx2VrKlK4=
X-Gm-Gg: ASbGncswSwBfpm/xDsF41QW9AQibEli1FfAFz030E41eCqJTqZuzvMG/anhMBd3xs+F
	Kn/ZxoYmwFcSrlHf1ZDmTJfy56WuD+cIeRbuMKFV2+9bYjAS9Is7fgKJha8fDGAPrdULYfaj7i1
	6abSV8nUdhPVrf/qha/EjHUv0ItTD5RJip9C5+JLJLPfcnkj6F45CJp8upnzKSOymGs2fF17Wgf
	egxPAMzfHI9rFp8hJN+xApZv5fWX+Hfxh5cJ0ZdxyH6Odrkah7bXbc15auJRyv1+KVONf31zbxn
	maWvDRPcr2bZRsqikRgtIjnl0SQlGv2Zcqd+RqEGxS6cVV8=
X-Google-Smtp-Source: AGHT+IHn0r2Cn/E3lALMkI80pL0QtaTbm6Rd+OGBd1NolTMQ0z7qv14g2CG0Lk8XXwV55vp2Eib2dA==
X-Received: by 2002:a5d:64ed:0:b0:390:f55b:ba91 with SMTP id ffacd0b85a97d-39132d4e369mr2759140f8f.14.1741364638354;
        Fri, 07 Mar 2025 08:23:58 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm5731100f8f.88.2025.03.07.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:23:57 -0800 (PST)
Date: Fri, 7 Mar 2025 17:23:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] printf: implicate test line in failure messages
Message-ID: <Z8sdm7Nhk4h3hoUq@pathway.suse.cz>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com>

On Fri 2025-02-21 15:34:32, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test, e.g.:
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
>   lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1234abcd  ', expected '0x1234abce  '
>       # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
>   lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x1234abcd  ', expected '0x1234abce  '
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Just for record. I like this improvement. But  I am going to wait for the
next version of the patchset which is going to add back the trailing '\n'.

Best Regards,
Petr

