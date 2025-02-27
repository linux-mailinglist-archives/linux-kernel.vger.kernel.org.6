Return-Path: <linux-kernel+bounces-535261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582BA470AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0E9188CA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB01758B;
	Thu, 27 Feb 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="a/XVr0aL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641861FF2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618312; cv=none; b=Jo6UKrSetAEK7tCp59rbE81N2+mYbQsKygZ/xPJMnlSAcw9zwXI7ZYfsdHhYiZaqEH41scdXh1VFIODtD6+VWSWtvuxtV4IeONfiXGDCMb6LAu+l80wKcBsJo/scvAA8tUjzoINBUeqmyzGGKCKmySJ/8x+zx3WbWoVzAwtcWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618312; c=relaxed/simple;
	bh=izJ/pwzPoAJ6iulm3+QddXFdSaGF6rlWdcXBgxPZiLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVpzZmYNxUusJd1rqE7WBwoKsAQO73vDX62g93dFyocsfqfZ8oMD25E2k1S/KC7KXs0jyVkBvND8gn6umiE3mpprAtld2WhHMcXQucPV0ZdXpkSOYE+xpiKQhlH0qrQpOaqjb+h1mIPmOsXB+WOmAC9VYOvrj1IU3D1SV+B2gxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=a/XVr0aL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2235189adaeso2164745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740618310; x=1741223110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCVNzEhlbjN/GYtjl24E53XliTJERCpf4lp1dGDkOtU=;
        b=a/XVr0aLTJdvZ4eIg1F7pC+9/ydq6AVsHnMg6Cj13j6chrtGQAT1C7WbdB366iLTjz
         e1BFDOKrcY3SAUgBVPmpaarDGqpaWfa3wFEqWwKNOLdJjWl2hXYvUeTDbVIbcH1tJXPy
         UUTFJnchS3sW+mqwBkVzo+w8Qsm5B/U6tkxNukQjklI8+a2/sgydVbwBccqhz5ixBByF
         NkwQqC0gBr1Xgji8XMPu2ydqfoIZ1wpQ/4B0CMdizBQBN7f3RWVR4cI0pcCbAIp7tmUP
         f/qyH/vjQZ6mpb3PlIe2v9FTUiQPyFCU22wJElFqru8LhhvNug0B4CYTsU9AurtVZlPA
         w7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618310; x=1741223110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCVNzEhlbjN/GYtjl24E53XliTJERCpf4lp1dGDkOtU=;
        b=HD05/O9J7BTJrcKK/sSXifJQWzG/F0nt4IFyPyt4UlF6eEBbh4BDcjTd9CSagHkzt4
         oy1FnxXivQmRH51gR+nZzcQ9XqDN+HJjpTHJcFlPXeJ1ykM2Ow19VA5U+u5Jy61DxIwg
         u2tURO2lHDHvk5XWgHvZ3VQkAT3/kPFQpmL9uyDzSjn72UmzQov0sE76CrnlDMtjBJCs
         xO+UAMFvwOhB8M01iSGiyfFM+nLBDflVWb7LPx52IQLpi/ut6yFtBT6kKlj2qTcGUqFJ
         5F5yTLN2GKMNK5l1EbZjjinFGbtRI0AjTPu+T7RH+8nzgV/sxVAiadCZixpXQotQRDdQ
         kgDg==
X-Forwarded-Encrypted: i=1; AJvYcCXeCAHKgiIKiab7bu2GIxjJZqeTjej7WH9YzJGLW7ArI+4kF5p30/IA38sozKoeGA2bNLi3Js0B/QlCaqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yYHSzHPwu9I578IicHnFzZaYNtrx358fiFQkzY/FWoBYX6OS
	lx6Mi0sem04cWxiozmBAF2uTUYYFhAfHN7cVF1Vg27cOyxmYq8M7M56lHrrvkaE=
X-Gm-Gg: ASbGnctcdd4HPEZD+1/RLmhbJlml3R5p0ahq6GT7Tl2uIKEhQhQCQsnHS02AYbV4j7v
	RemFbM19vP+9iV0bgtVsPpr3oy59ubNI/SlWbIS237OuiFWZ6avuYA4UduQV7H7GI88ROTpgJkb
	yBhZksga7Wm8WKyi9tnVMxk/TNP2H7cLkNOeh+WyfPa1qCs08ve6Lwkw9mlJrVq2peMcHDcu3Zz
	cmmWA/xq5hjEofxC1h2HXaKWNBJvjB0vjOt/+4KbV6KRQmKcfjqYPH2fymAlV/jS65ul1pNRiez
	aaq1BcMf+WaQvOOjtIUabG8Gdt3vNNxVSh5d+SiWwDiVKHw=
X-Google-Smtp-Source: AGHT+IF8iinyZ5bzcXrBop0+HPVufAsd+EqurIZLA35oY3Ww+r9E+VVyBAqJdXtpIgjPZ5uydA0Png==
X-Received: by 2002:a17:903:3b86:b0:223:517a:d4ed with SMTP id d9443c01a7336-223517ad6e1mr7535625ad.15.1740618310279;
        Wed, 26 Feb 2025 17:05:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-223501f9db7sm2847905ad.88.2025.02.26.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:05:09 -0800 (PST)
Date: Wed, 26 Feb 2025 17:05:08 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Etienne Buira <etienne.buira@free.fr>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] scripts/gdb/symbols: follow up on refactoring for const
 struct bin_attribute
Message-ID: <20250227010508.GA392458-mkhalfella@purestorage.com>
References: <20250112122149.9939-1-koichiro.den@canonical.com>
 <20250213043806.GA2552411-mkhalfella@purestorage.com>
 <20250227001759.GA351718-mkhalfella@purestorage.com>
 <5vhttz23b4v4fs57fv5o7e74bn2uewrmy6jdgeenwztwufjo5b@o72abjlumepw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5vhttz23b4v4fs57fv5o7e74bn2uewrmy6jdgeenwztwufjo5b@o72abjlumepw>

On 2025-02-27 09:59:23 +0900, Koichiro Den wrote:
> 
> Sorry for the delayed response.
> I have no objections. Please go ahead and submit your patch. There is no
> need to mention this original submission, nor CC me.
> 
> Thanks!

Koichiro - You reported this issue first and came up with a fix for it.
Unless you do not want to, I think you should the one who fixes this
bug. How about you re-submit a patch with combination of your original
patch and the diff I posted?

