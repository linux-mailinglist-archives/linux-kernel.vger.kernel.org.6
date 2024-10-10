Return-Path: <linux-kernel+bounces-358801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167739983FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C10281668
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF11BF818;
	Thu, 10 Oct 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMROIh92"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D319E7D0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556833; cv=none; b=gFS3wKKU/Bh3zOJRzBFcVghLbM5g5ilK7myAoO95mUlHERGr4/Xzl+1kuc46k8yb97DbG7pwWSkxoeKB4WYn40Ep5KtuKxnAU/P8agrA8czrllMxsrlmWbB+/RHQLnJjqCSLOKCNfaF/7Qe/F3O8HuJlbDX2a/glc8oztlp00qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556833; c=relaxed/simple;
	bh=6IZ/lCHicleSJFqXu6KLb1FlJSmDUPAbcpMj5ss5U8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY8yyCXpn9CsAnuRLT1bgtOqsTiRP6O+Y2uhDtU8Pvz3IpYIRlUItUSI4OTnWsbkkcbXuJQ+h/H7jTxKIcdHJYrzWQcFfN862wZ9abtBEMm6Rcbq62FZkfQsfY6CD6IAq9zZwN6voNDYey5f/wrwaWtTp8LtH2VbfVVA5kpM0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMROIh92; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d39d9f782so429088f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728556830; x=1729161630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBHWiktfVYlgbYifeV/Ct3rZTbpPbZ7HKtEDGENAOyk=;
        b=YMROIh92o6gbrMISiQEWnoTF+fAPEk4mztfh5XdIIofEx9pgjfm8AfPXQtTrIcF7g7
         BEdUgI6xK+d/YfSisJoG46bpKZjVh8E5lBychBE0vkq/a/xPMvJfTedJACMr6cvR5Q94
         iDuNdn9F3dgqzfiiei+Df3TylC0cyqRtqFn9KJQj8G3/Nt9LcVVtqP4bcwwrSd5ukLov
         413EtHTjcSjlVXFUcl2sM/pGhNhF7WV0qps33abKdUlWkkFJgVpWHPdiIHbQsg9eiMjD
         NjypqyMSd4bZWHcF4ukm0IgYO4uh4dHQSwZXFi7pcAqCMDcZFO9QgNCd21BkWzA9C7Vf
         Z+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556830; x=1729161630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBHWiktfVYlgbYifeV/Ct3rZTbpPbZ7HKtEDGENAOyk=;
        b=w6gr8LQLXBsT8t594QjXp1SYbQLz2hey9LSdiKguYzmEclWW3tBrbFx86IgJnMBilT
         MXpRrFutCteZRz0QqofLM70xNqsnMErpYLp8pbrFx6gyP9ilYkVcA7gnXV5UTLZS+nAP
         fdqKn9k4srz3x4E5iltOf0mbjKke/yWr0XQuSok28G7Nb8XNDK5n+cPuv39k5nJ34ZoY
         q3hQLNoZbcSGqrt9uYzP6VsBxCNH6MuMdmo1quAc+4Rn0lTvMi6t6fHhn4GMNLcpmFFO
         D69/sjYswNiA2OsoFJW1WLOd5sHGjI3Ost3TIBhC1vy8VSMTqTJT2AVW1IQYhqCrH7Fm
         EYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVWXkBkXeJ1CksRjGALDc44yjcsdGcIwyhmxHCMtLt1uRRxqD0qWW1NU8qGlPD+a8nv4u2xv2DOPF8iWB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/gEC67dU7KaBGtjUJehDUx/+d4iiHsNZQNYhZNv7gbnNj2EV
	wPJeMMnV2PljKJ01DtCAF+sfrkuzxpy5j11BjWnPcmN4iGkD9hyaugZRNWHIRg==
X-Google-Smtp-Source: AGHT+IFO5jDd08ddK1X0YjR9dIy7JGWXcVcRqZfK2+MjUcvEOY5tKA5RJvpLtMudOT6lSTGNeMHZZQ==
X-Received: by 2002:adf:ecca:0:b0:37d:4a68:61a1 with SMTP id ffacd0b85a97d-37d4a68621cmr1116060f8f.56.1728556829836;
        Thu, 10 Oct 2024 03:40:29 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8269sm1183712f8f.1.2024.10.10.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:40:29 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:40:25 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org,
	hannes@cmpxchg.org, anna-maria@linutronix.de, tglx@linutronix.de,
	arnd@arndb.de, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <ZwevGZHiXOBqoslA@google.com>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com>
 <20241008005136.GA241099@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008005136.GA241099@thelio-3990X>

Hi Nathan,

On Mon, Oct 07, 2024 at 05:51:36PM -0700, Nathan Chancellor wrote:
> For what it's worth, I never really saw Matthew's comment around what
> value does this warning provide addressed. I was the one who originally
> moved it into W=1 at the request of Arnd because he felt that instances
> of this warning could be bugs and they should be audited.  However, I
> have not seen many instances of this warning pop up in new code through
> 0day build reports and the ones that I have seen seem to be intentional,
> as they are using enums like integral values, such as here. If that is
> just going to result in a bunch of patches like this adding unnecessary
> casts, I think it would just be better to consider disabling this
> warning altogether or at the very least, moving it to W=2 (which is for
> warnings that are noisy but might contain bugs), since more people are
> using W=1 as their normal build configuration nowadays.

If time has proven that this warning has never found an unintended enum
conversion, then it is worth to disable it for everyone. As you said in
the original thread ([PATCH] kbuild: Disable two Clang specific
enumeration warnings), W=2 is not run by any CI, so I would prefer to
disable it completely.

Alternatives considered:

* Enable -Wenum-enum-conversion only for 0day build reports through
  KCFLAGS. It will eliminate noise for regular users while keeping
  developers informed about new instances of this warning.
* -Wno-error=enum-enum-conversion to keep warning but don't block
  compilation for CONFIG_WERROR users.

Arnd Bergmann, what do you think? Have you found it useful after all?

