Return-Path: <linux-kernel+bounces-515217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F61A361E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63291896610
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE9266F02;
	Fri, 14 Feb 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EdL9ymag"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C5266EF6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547319; cv=none; b=GUp3Mj3K01ZQuyynRZdmHIzwpPp0O3y/g/nuR3gcnuS3S9cDfDAMyirOTWjxx0FtUesUB62FcVtx1UVj9byx1xaGE3uQZjTBff5I5dlkxMZ0kHnqN4E865E52Lc9MvMXcTxGGNUICRWHclmaGhjIg6CxP3UnnbGPi+JCWBmlO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547319; c=relaxed/simple;
	bh=3ROhaNH5ZNiBeQTZmiDfZeP6mXeJ+t8KXtX+3B8JUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOhn7Htuy8DHT0R80G9PRkj1pF5xWgLc7d0lHenBEJ39dQe9tFaaCKF+/oWvrWhMC+/F38UwWbAsbkxX6xV5JG4NZlA9m7LVkC6oTwRJnM2fzSu81PxIR6+DsvtOtTx17kdK97VS5V6hLSJKV9cE+8wquxF+3Ri0QZOdOlN7qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EdL9ymag; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7cb1154abso300534166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739547315; x=1740152115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Epi7Q+7wQY9RKlfsXwKc7BTRBEAbnD6Wjsq4fX0UxxY=;
        b=EdL9ymagkWy3zPMNNDaXw/RPpHF28fvKPhelcYIjQ7kRsOyg/OXHNmaT1JN8dM3IYy
         QEZd/Ku81JjWY6ZzbyY90nv5XOHMedjpvNhbTDsQlaVYilEvHLiW90TLP5YiX0waGs5V
         vQMudZzPQxWaPYhliqRy91IiemOleK9mPxUwuGgYSwaYEma/mOthV8cQzksIQpYWBEhA
         XOf5aqGxu7TfmjvpIV2En6oIVqz2HaLuy6h23l57wrtEU7laMJ5e3FX2p4tOIP3h1FFL
         UJzNNoSeQDR7X3ewCVzOxG8+ITw61govNyRMxOGfqERCE2C9DQJupRvvhxZyI5z+JWGi
         zDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547315; x=1740152115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epi7Q+7wQY9RKlfsXwKc7BTRBEAbnD6Wjsq4fX0UxxY=;
        b=uMJ6r37yara6wLMqj6vhznmVEAPTyXjP/mynZZF2mMNwlDecVREqYwQCbTZ017zvC8
         A/DtKFClAi2ydFI/erAZ9jtA5b6OwZz0K6fG2RLwNpsB0KkPYcTNL441XzMGXwm/4jIc
         afznlGd8JCATQuHVhc07ASuC+HFxZFODGmiYF4j3sz3xAM9VibvRsLXvHg602xE5SQ4Y
         EXnA8LaIS8nYZ6u4O63i1SneYJ96+LU3R2DEdkj3+yTuUhkZNns8L8jRQnpSAHe3ME+l
         40Gn96BBuz2cyEP7BupDWcbtWbCxYBxFLPGUOq9gogSW7fm3upF+D9dFjHO7EKNNuNAu
         1pCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzQKHEW4k7JZMzHTySwqBUoE9G7Y+EbygBVc3PJDyWzVaUpl7h06rKNo6B5/YlBbbQlHez4kKads/aOg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0w687PI/Q17xEKrRRqDkXR5ESlXsIMo2yXL7D8rXvkFSOjyk6
	7/O7Bc2kgfKAsO7NmcDYd4hnDn2n+le9mLWjkKTzLMd6ReORnZzITRmsRBTjoKs=
X-Gm-Gg: ASbGncu5BLTiaMh3uHF/YHnHXvi3dNrQekg3Ujqdsscv3iuNfxH9711j0p2kaH+10Aw
	RzZABgXIubOfhzYYIsVh38DkSTZTKcgzVVeguoc2+u1Zq7ygRzd5Q4QOseNY36Lp8n7/8gLAZ95
	3zaAwv+reP96mWz2dAZ+d6oDSvdZ2ZdR2tO2nkLsJaUy1iGVCX3OGD1lgh782uFyMA3Ix0yu17Q
	BP+Pf3886Fa8FtXx14LuexuGMzm4wXJxoaJrTQtb7KI0Wjok3d80DnK4lB1PtDqVWjHKX8j1ijf
	LQSdwG1HVJlvPFJEDQ==
X-Google-Smtp-Source: AGHT+IGJzwISDCnvraLVLyP20Cfh4hPSTu9kDD0t/YPlFJMdBbmRyuUpNouBSir5X0Q630+BioQj3Q==
X-Received: by 2002:a05:6402:2387:b0:5de:d98c:3b4e with SMTP id 4fb4d7f45d1cf-5ded98c4a30mr6607100a12.21.1739547315302;
        Fri, 14 Feb 2025 07:35:15 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm3052385a12.37.2025.02.14.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:35:14 -0800 (PST)
Date: Fri, 14 Feb 2025 16:35:12 +0100
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
Subject: Re: [PATCH v3 0/2] printf: convert self-test to KUnit
Message-ID: <Z69isDf_6Vy8gGcS@pathway.suse.cz>
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>

On Mon 2025-02-10 13:23:21, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and scanf), the rest having been converted to KUnit.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 printf
> 
> I have also sent out a series converting scanf[0].
> 
> Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com/T/#u [0]
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I have just quickly tested this before leaving for a week.
And I am fine with the result.


I tried to simmulate an error.

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 59dbe4f9a4cb..d2a1af31a540 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -590,7 +590,7 @@ time_and_date(void)
 	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 
 	test("2019-01-04 15:32:23", "%ptTs", &t);
-	test("0119-00-04 15:32:23", "%ptTsr", &t);
+	test("0119-00-04 15:32:24", "%ptTsr", &t);
 	test("15:32:23|2019-01-04", "%ptTts|%ptTds", &t, &t);
 	test("15:32:23|0119-00-04", "%ptTtrs|%ptTdrs", &t, &t);
 }


The original result was:

[  787.626709] test_printf: loaded.
[  787.627398] test_printf: vsnprintf(buf, 256, "%ptTsr", ...) wrote '0119-00-04 15:32:23', expected '0119-00-04 15:32:24'
[  787.628496] test_printf: kvasprintf(..., "%ptTsr", ...) returned '0119-00-04 15:32:23', expected '0119-00-04 15:32:24'
[  787.629939] test_printf: failed 2 out of 448 tests


The new output is:

[  585.652278] KTAP version 1
[  585.652675] 1..1
[  585.653085]     KTAP version 1
[  585.653382]     # Subtest: printf
[  585.653702]     # module: printf_kunit
[  585.653716]     1..28
[  585.655223]     ok 1 test_basic
[  585.655908]     ok 2 test_number
[  585.656824]     ok 3 test_string
[  585.657522]     ok 4 hash_pointer
[  585.658547]     ok 5 null_pointer
[  585.659572]     ok 6 error_pointer
[  585.661057]     ok 7 invalid_pointer
[  585.662290]     ok 8 symbol_ptr
[  585.663390]     ok 9 kernel_ptr
[  585.665162]     ok 10 struct_resource
[  585.666231]     ok 11 struct_range
[  585.667257]     ok 12 addr
[  585.668399]     ok 13 escaped_str
[  585.670212]     ok 14 hex_string
[  585.671903]     ok 15 mac
[  585.673389]     ok 16 ip4
[  585.674886]     ok 17 ip6
[  585.676255]     ok 18 uuid
[  585.677875]     ok 19 dentry
[  585.679138]     ok 20 struct_va_format
[  585.679783]     # time_and_date: EXPECTATION FAILED at lib/printf_kunit.c:97
               vsnprintf(buf, 256, "%ptTsr", ...) wrote '0119-00-04 15:32:23', expected '0119-00-04 15:32:24'
[  585.680264]     # time_and_date: EXPECTATION FAILED at lib/printf_kunit.c:135
               kvasprintf(..., "%ptTsr", ...) returned '0119-00-04 15:32:23', expected '0119-00-04 15:32:24'
[  585.682436]     not ok 21 time_and_date
[  585.683115]     ok 22 struct_clk
[  585.685807]     ok 23 bitmap
[  585.686576]     ok 24 netdev_features
[  585.687243]     ok 25 flags
[  585.687875]     ok 26 errptr
[  585.688930]     ok 27 fwnode_pointer
[  585.689544]     ok 28 fourcc_pointer
[  585.689886]     # printf: ran 448 tests
[  585.690215] # printf: pass:27 fail:1 skip:0 total:28
[  585.690582] # Totals: pass:27 fail:1 skip:0 total:28
[  585.691013] not ok 1 printf


I still have to look at the implementation before I add an ack.

And of course, I am also curious about what other reviewers think
about it. And if this is OK for Rasmus.

Best Regards,
Petr

