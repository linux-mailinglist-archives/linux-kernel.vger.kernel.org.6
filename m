Return-Path: <linux-kernel+bounces-561495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC7A612A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134CE7AEA23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A71FF7B7;
	Fri, 14 Mar 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NvXk6MiX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A71FF60B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958986; cv=none; b=kXWhIFKOXjCi89sICWIG9MhEi/cTAW8ZhHmvNYgSxe+Ykx605DvRALxDhfHnZrR/o6jUpT9axvRDnKuGb9Hm69YXnlW6054dASi3BQkc2Rckgebiyjg4rzedDs1CkxGuPBEgxSjxiaCLEs8HFetMKpewMugbPTaOtiOmMBe5xEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958986; c=relaxed/simple;
	bh=0tSLTf9xsT/SWhyWGaL58IsV9Nm6rD84h8VdR1BZo7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIR78pNQFslPV+CsXAiQPMI3CqsrBw/xjd4G0D8ksoTGu+pR/q9O3AAYPCvdCE/pd5EUuxcMcgEtadOuQNXiryxj/gXPztfQXl86G8dr1/H5yGTc9pL6Z56Rau+9l9gIMlT7FNkFAYFEYeaWaKsHJRCOEtM2OTPNe3Qun2jPYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NvXk6MiX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso13389865e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741958982; x=1742563782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP+uNOM98k8NKXIW+A2NCgIQkFQBDqZRXpFtfAXJS4U=;
        b=NvXk6MiX8TTVqkk7bH40KwyfqriHag2etSFXw66CuxA3uVGf0q8TordjVjQg3KflmE
         m/CoK1AAAQ8Q8KPhbTvIOz5+kNFK5UetA5sHyxVrmJ5rywH2wDzKFW8y36Lke0PTS8EZ
         6er7dZE9gQmDZx1Sd5XtIX4VClDveG11mhRmW6mC4+zVtXlN2HLfX4AwiRup5/CwIP67
         9PmLtoSICgjR0D7q3b2WGwG2IKlDAX8xX0E/vIWDg0TrHr4pq0lV9T7XIO3miBM5c2ob
         u5mT1tpskAVW61FmouOaBFtAXBsdDd2NgHYeMX2bH/XJfYL5r+dJsoK1wyvSYUSGC5xN
         6HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958982; x=1742563782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP+uNOM98k8NKXIW+A2NCgIQkFQBDqZRXpFtfAXJS4U=;
        b=tBMELBtsTJkiNK1YSVkdHq3eiUtD04Wec8D3Tkz1tAPykOGtD2H5PtQLSJZEI33hdu
         gK/g/+hHAa6zjIEQ6BARlw59Zd2SClgeyO+EJcZcAhEkn+VrJKepyx4weuyHCyCkt7NG
         g4qyNHxGV2jp8Ep52honRuD0/G+BIV3t1OTzMuW83gIaH6NmqSadKaEaGccUB9H78H5v
         KELoY1kxxBn98nFzk2LedDEU9q3fkV5wWP32x0C+Kufeqd3POiULvG4vNJ8RTsdusaXJ
         JIZhjOKPhpUxPCrDRqnnZ8ALOgmc6UfrFlB1XTwYtCb7KsIM7PZo8gaoXNmB2+2CRL3g
         PtqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLbuiCVPk6FWOYJEwQTFNASL9J6/8pdoO8kJJbYlDz4xmoTPsBhJDpkdjrZ8ciYepcpfH57X63E+VEb6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhCpEbnqioCy8tju0XcX8DIDhKHXznAsfT+UyaFlOvu1imf+U
	yNB/c0oQK3WsgrBohKEjZMtE3UIGCjubbBmdv+yrKWfHlcWlnKdY+4zVp7FWcQQ=
X-Gm-Gg: ASbGncvOCyNec8thVTL8qRkE8GGfbmbZhvJhu0wztwdC3Q5KEFbRSvjT/VTd+fOFQKA
	kwwDvaMTLxekDGi4naonR3HvHD0cjy5ynkeyykV5TNg1dxYD1ghfyQ55u/TgCNkwXbDBzeLQaur
	eMSJP51gYgL5llBJISBSNdiHpFJ0k3XjlCXHJ0ZRxrfOXh6vEgjUbuy5uLgyuvsTAlO8Dfs8/3V
	17WJ2m2a1xXOT1PF9Qt5EfEcmCc1AfkN2eB6CksIyZGI+kha+DxHBL8B6JJVynj8NbwyfxJHUn6
	chuox/LFnw1aszq8ohdQhVaTAKvlglT/SBX69Yev/WOMWIJKpem1RXs9Lg==
X-Google-Smtp-Source: AGHT+IE38fHIEK56uEl/05JrmiS2ZMg7KADfrV25AuJoLIUtmBYrJdxZ9Tyj3UaE9TpYVp270vbvEQ==
X-Received: by 2002:a05:600c:26d4:b0:43c:fd1b:d6d6 with SMTP id 5b1f17b1804b1-43d1f60a4f1mr28413685e9.31.1741958982465;
        Fri, 14 Mar 2025 06:29:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e618sm17677555e9.40.2025.03.14.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:29:41 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:29:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>, Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
Message-ID: <Z9QvRJE0Yun5mfsN@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
> 
> Tamir Duberstein (6):
>       scanf: implicate test line in failure messages
>       scanf: remove redundant debug logs
>       scanf: convert self-test to KUnit
>       scanf: break kunit into test cases

Kees, could you please take the above 5 patches as well
via the tree moving the KUNIT tests to lib/tests ?

They seem to be ready for linux-next and the next merge window.

>       scanf: tidy header `#include`s

This one is a bit controversial and might be added later.

>       scanf: further break kunit into test cases

This one was just an attempt. But I personally think that
it is not worth it.

Best Regards,
Petr

