Return-Path: <linux-kernel+bounces-193956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245538D348A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AA61F242DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7813DDC9;
	Wed, 29 May 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Y6hQRlzp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AB13D29A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978612; cv=none; b=WhuKHpGGWud2mUWC70/JuGEDb4b9xbYOlHmw8Ks1p20tVtS80/1gS/6FI1U3vCuvRrtwbS1mJ6zvAjjF6IutgyuWwKe69pxD4rdfM3IeXPBLQ1SZNklHQCZ1OnrIGQ8CIKVDXaFsuSP/c+ok0UyZmcmJoK78w10HUFYKk0pThZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978612; c=relaxed/simple;
	bh=qcp2kwhYNvSXNHuKmDzEkKmUrhJ2Xale8EsYaXmmv8g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J8LN6q6Nwf7a4x1PrCEurUgZ1gXfM7jNBnXCDmBZsC91J6vXHh7U0wlAj/zgpc9kBb4M9mK5RfO3qnAFsPp74LRYM5AGjWz79LQ2k1on/x7AKyZ4QJq1peve6m8rN4tQh9gmnyGd+LFkpYrBGtVsbE1yuXZq30UFInnKsdG4h2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Y6hQRlzp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5785f7347cdso2058837a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716978609; x=1717583409; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac4qZfdkZfTNTl8ckvJUCvNWHqeRhzm0yO5BK/O6hjU=;
        b=Y6hQRlzpiAKT/flJwoCW42HnkDY4X94dnt/9wR7WaCGNXIj0eV7ONDiGp/WWSjIp56
         3XWi3r5X066jRidKn7V+gP14pZWbfGbHfFT+DrQ8KV9x/34UJLpQaoXs1fo/JKeVsIOE
         /6p/UFskcFv2V3gKIXu0TNQZDP30Xw0y/OurUDcf+FHttaomdxryUX1vjvcSJ0+YC+Ap
         RhEUfZc8VlfNyMnTnYlM1RAl6g1W1vaZ5ojDQqMy5D1FdHDOC2/79Tpvl77n59nykrqY
         dtzadVTB2tagbcJxtpZrjsyPxfWo6GnYvAIX9Th6CZW1vMJNlC8bStR+bHQf28qf7Qss
         3F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978609; x=1717583409;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac4qZfdkZfTNTl8ckvJUCvNWHqeRhzm0yO5BK/O6hjU=;
        b=qmSiI4oUGRYdF2bpTGAKNGeM+JdOlX8xi4GuVktPBfUUZ0WqZ83dBuDj2EtkiqkOIW
         NgXK35uyn+eOZAbq5nNV077p9glRzibCREoRA0AG6CihmHfsmjc/Fnz83H1cy19lLPzd
         Ej7iD4YSHaSlVGVIUh7EJs9idsTLpDXqAZDlOmVh6Yhnt6sUudStFEe5tpE8d+f78qjo
         HRVxtHChlHO/Lm4WyKDNp2J7qvOVVU7Z7+L3dp2Fd3xRdp4MIeOkgSedmcll0HYuWgey
         pSotVwjBhTRSHeWuMfBzqFpVvT9ZJl9DxRnItP28m5Uj26ALTRzCggx9LNv4noNnbQLG
         /8Sg==
X-Gm-Message-State: AOJu0YzeTEYOX0l1ZYIrgyRNa0XefMkvxLKOagJ3dD75sCrT8wiNR53a
	JRZ1sTnZFQ3Jyo1MvvfuWD9+4R4PTsEJJhgD+vy8fRJgmz8CoGSqLWx535asiYA=
X-Google-Smtp-Source: AGHT+IFcl7qIqIRKKgPOn0ZagLrucn8zYBaKRAwOJ9MONdyl90Fi/kvHFIn2wvxXfDrvkFTQMpUP8g==
X-Received: by 2002:a50:d64f:0:b0:56e:238e:372c with SMTP id 4fb4d7f45d1cf-57851a5cc47mr10109372a12.26.1716978609536;
        Wed, 29 May 2024 03:30:09 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:cd2:ba1a:442b:4269])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a111f8b3fsm65426a12.85.2024.05.29.03.30.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 03:30:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RESEND PATCH] w1: Add missing newline and fix typos in
 w1_bus_master comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <38eae3e5-cb91-436f-a422-0d03d4c8cc95@kernel.org>
Date: Wed, 29 May 2024 12:29:57 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C058E8F5-3F00-44FC-8294-93E0B767F13E@toblux.com>
References: <20240515101150.3289-2-thorsten.blum@toblux.com>
 <20240527092746.263038-2-thorsten.blum@toblux.com>
 <38eae3e5-cb91-436f-a422-0d03d4c8cc95@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 27. May 2024, at 13:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27/05/2024 11:27, Thorsten Blum wrote:
>> - Add missing newline before @return
>> - s/bytes/byte/
>> - s/handles/handle/
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 
> 
> Applying: w1: Add missing newline and fix typos in w1_bus_master comment
> Applying: w1: Add missing newline and fix typos in w1_bus_master comment
> Patch failed at 0002 w1: Add missing newline and fix typos in
> w1_bus_master comment
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: patch failed: include/linux/w1.h:85
> error: include/linux/w1.h: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch

Hi Krzysztof,

just to clarify: do you want me to submit the patch again or did you run 
"git am --skip" to skip the identical, but threaded resend?

Thanks,
Thorsten

