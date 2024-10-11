Return-Path: <linux-kernel+bounces-361066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B777499A2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA0282F55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE220CCC5;
	Fri, 11 Oct 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWHLoBIP"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562417D2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647280; cv=none; b=KQrDSXqgP7sdzHh7TW3HdZRtUh5eOXj0fb6+PCI6TYQq7T18mKoT3RTnIXGSQHwaMFj/rsaG3bNbq6lVC5Hox5YesJdGSsdpHvzmw9tp/bsq3EE4ws1GdHQYo1IvK4kTGIy0q/GukjIZ+xO0t1ZFn8h3G8QvDP2Sx4DNGdLHEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647280; c=relaxed/simple;
	bh=YlS2IMp98Bre66mTX2XACoHGnCmtyFoDwEtCatrn37o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogwFjgHlaQFylNd/+ahlXTMRMpYmwz5UFE1eZgGs5imITHf3KqjFxDbA/rxdWlD8xR2RlcQ0bB6yw3lQnEMrneQbtANR0Jjh0mnDqGIrS4foE4x9nJl1HQDX+GahvmSgpUYAgrU+x6skMSBsLtDmJ0pNVd6xLT/7YNlDJb7GQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWHLoBIP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso17291561fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728647277; x=1729252077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqfE0b2kghW+la5PW6I2qXSzxR7wAN9/SBpobg5HUto=;
        b=AWHLoBIPq1GvDHNDaRwfAFvuCQ3kfTeBBuFg3ECIQbJmaJukDWtUZlLvGY/5GmbEQ1
         aqhYMoYqM4uayx2A39wVZqGpUTAukt4mwT9KOOD45sdvQquGiwvj5g5cmXxdXP1lzZug
         iER0i70bwWEMkLJhw6E+mqiVpfXx8XkHOnRgl4msUHe1f1gykgql7r/v29pkLxH+aW+Y
         WFkZmAgKA84OSzGZHwqBGPbq2BKNMxw1nHKJKtDFVC38M+oIiL9Y1kerhld0dEI0ufPj
         cXgyvGtipKA3FuDPRkFJgoyNtjaUCbRUSX8XrA1MzShAwtS1vt4TZ19t/JTtfcAYzf46
         bi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647277; x=1729252077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqfE0b2kghW+la5PW6I2qXSzxR7wAN9/SBpobg5HUto=;
        b=g8ZaZ7w06iRtzQdV1oQOwW7lLTUQpDoG6e9OwBppolnfEX7vC6q9T+DAlCF4DS6bct
         Q8aku0jr56q7e3RqBuqTVdSDwjPmfR+UgyKxTD5Xojq6jakY0Z5V454QFRqxtWcGx/L3
         6yyE2Gd+901K7OTDQMmeklMjQmleHX3EaxyyEVVjN0Kf5kP/FJ9f0M6nhT7EDBHJ7mtQ
         1yTztG7dBw247dO0b39cwX9wbzkCHUnMp0Wpiyo2hdketgfxrBYUjxFpum+cHKku9iQr
         VFaqYTrKKMJ+oFrTDXga+FMEy4Qqixn8F99eyNbaG2mktzJZMT0zEOSr09R2ojq2ZkZC
         +UuA==
X-Forwarded-Encrypted: i=1; AJvYcCUzzLB7dZOT7MBJvbLNmuo852LzbK+86zNI9Z9RRN+WEYJ8HfUHDEEGVdtEJV7VrikjRtkbQUsSCBksKgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpA3TmzfJf5tQeqPNew239imWLGOhOnHDLvNrdJGu74NN1iHvn
	jEH/tz1WrjKaCMIhK/g1kNvdGlUJwhYZAgb7AT1xa5O3xDXvl/Pq7zukviep9IELBhDcGk+92pP
	F1jXxH7mFj+Sp4tPYKgwoQ3ey8vUykQNcSNTs
X-Google-Smtp-Source: AGHT+IFdDzZxZVbDOPjv7nxSZE0dgmBO5xGT9hDiConG4WfrpVy8eFfOP9S0VuP3GaOzQYLYCb/M1YGSq/u6IVe77VI=
X-Received: by 2002:a2e:131a:0:b0:2fa:d84a:bd83 with SMTP id
 38308e7fff4ca-2fb32770fbamr9707871fa.24.1728647275817; Fri, 11 Oct 2024
 04:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011114537.35664-1-niharchaithanya@gmail.com>
In-Reply-To: <20241011114537.35664-1-niharchaithanya@gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 Oct 2024 13:47:41 +0200
Message-ID: <CACT4Y+a=c3qOb3eW-CWbdjignJg0WYvZcPhP63RRekF0sHqVDg@mail.gmail.com>
Subject: Re: [PATCH v3] mm:kasan: fix sparse warnings: Should it be static?
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: ryabinin.a.a@gmail.com, andreyknvl@gmail.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 13:46, Nihar Chaithanya
<niharchaithanya@gmail.com> wrote:
>
> Yes, when making the global variables kasan_ptr_result and
> kasan_int_result as static volatile, the warnings are removed and
> the variable and assignments are retained, but when just static is
> used I understand that it might be optimized.
>
> Add a fix making the global varaibles - static volatile, removing the
> warnings:
> mm/kasan/kasan_test.c:36:6: warning: symbol 'kasan_ptr_result' was not declared. Should it be static?
> mm/kasan/kasan_test.c:37:5: warning: symbol 'kasan_int_result' was not declared. Should it be static?
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v1 -> v2: Used the aproach of making global variables static to resolve the
> warnings instead of local declarations.
>
> v2 -> v3: Making the global variables static volatile to resolve the
> warnings.
>
> Link to v1: https://lore.kernel.org/all/20241011033604.266084-1-niharchaithanya@gmail.com/
> Link to v2: https://lore.kernel.org/all/20241011095259.17345-1-niharchaithanya@gmail.com/
>
>  mm/kasan/kasan_test_c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..7884b46a1e71 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -45,8 +45,8 @@ static struct {
>   * Some tests use these global variables to store return values from function
>   * calls that could otherwise be eliminated by the compiler as dead code.
>   */
> -void *kasan_ptr_result;
> -int kasan_int_result;
> +static volatile void *kasan_ptr_result;
> +static volatile int kasan_int_result;
>
>  /* Probe for console output: obtains test_status lines of interest. */
>  static void probe_console(void *ignore, const char *buf, size_t len)
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20241011114537.35664-1-niharchaithanya%40gmail.com.

