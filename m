Return-Path: <linux-kernel+bounces-444386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EE9F05FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93312283A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF319F101;
	Fri, 13 Dec 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JLi1Ub40"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CA192D70
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077154; cv=none; b=UcJwihyK/IYg/2244bjr/GKrewVEcRm0WBOusudfpwS4PwJx098KAlDCA4VBZXkUBPZhY3fvVKPyNG6blsdtNtnkiW6z5c8O6ZRybScVT6dfBXq92r1YU9pyWGGD7f600W0MN2kE3rEg7iP79nhnsip591YotNOpRc9pLy92Vr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077154; c=relaxed/simple;
	bh=Gm1aSfPWn+6Iv90/f+5lwr4JIOMPpgZfZJbELp9SPys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om3A/1mqn5N191UUsHFJLpAGJkBtRmNm24cPCZlCQo9afFRqRUJaR/ti2TQ1iJIopGuX7Ly+cJtvGlKOo/eshAzf5e0AnWy7K2QJYt3zDgu46mF9JX+glM0x0wfjPwiqJmqwsxknPnE+Z4K5FTmLN1GjJCeseyKwAP/G+pMib4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JLi1Ub40; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso191754766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734077150; x=1734681950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=JLi1Ub40QBv66ZjD7LttDdNXIL9STIwTkkza6loCqucui2uM3j9xdISG+PuR+Ks4Dw
         VFQm2ZqQDTqOMUf26R5D4jr4ELtV//qcPMOupX3H2QD38yq3LwEL9JRUY7kMvdi+chwg
         rpmhxVyEShwyfM3PHOB4uYy5OfJv/z9SljmG8PLFEd8Wd3OFrq+11rPlhaf0jphRYp5/
         KOE0Hj0vqdVtvPWVcyy8IVbXrKSUUV82lvIM/0O+038nVI/fPRGrHuitVOgj5Aq24nS1
         vuOheIixL6exmB/lKTzdTtIB/c0Ru20ZK2SveaNytzw3QMb5lGXpaP4PCI8XKb2vb7VL
         n1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077150; x=1734681950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=PSNBdjFrPBxTIZ7/LqG/KaP8LtOJqABOW2hYPYGghwZZJudKkYVy5FCcFJAtMVCbhF
         /J51MDdsfR4YFnRorZIQSdn+TmCyfWAQjvd01sPmCxxrapO/qvdXnLONMabNhAGtMPKD
         NOy7pp81hNSGQG9jbmt0xUT2vzfLlAgK8rjMgH4EFIXF6d52wx5og9Blf4f4op3zNZsL
         7prAEeCRy8NwAk4sVNg5bftz+5Kh0MNRC3keM2sFu1En2cqUJ5FW3pQGAzt+vNHIntxO
         jmASdxcH5Z+Q+33Ec4d6U76xEKl+e1MzKnZzK5ffAaIpUUQFi1vbBRCA/E3Gt5R4mhI7
         GRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCivfVlkf9AxsErlWcr7IWubmA0F0JrW47oGxie9Lww5Oop8gulJDoTmyKYYOxx5vYW0DlKj+8kTg0zRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+FjLTVJ6RRyyJnhsd7zqH7VklrKgvKOjJSiM1YSv8eWnGqAR
	uDRJpFiCA8WSRCbJFMRNI6O/eXGuaDS+vQyppMltudF9jRCSg5NgLkX5u2HARZs=
X-Gm-Gg: ASbGncvDEKJvGAbz3JNat0FOiRHYlkFfsPzAyX7lBVMACDUNCPx47WVSRe9WCf5xBGW
	BTwe5b5scAa+1DxGEy3hY6tWy+WnIkT1UV7qe4t1FNNPMI+KBhtUYxxGl/YGQq4gyGbghKqHsuA
	qtJ4poEgMvped1UaOoVxzu0r3vcbRCsopi/cf6lSTOHrC2ONPvRINLDzo2eCU89Z/3fB60PuOGz
	llarKHiKs/zCndMHJ4CJ4selDZ+/bAoURepN7cX7NPNkMOpkLPF92KXfA==
X-Google-Smtp-Source: AGHT+IEBU3KaEVduDDJFmDiYKp43p4o//mXEFM4u7vCzKG7h47JoeDZ5E1DdrcH3VOsdWE+nfKrYuQ==
X-Received: by 2002:a05:6402:4584:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d63c318beemr3590523a12.8.1734077150211;
        Fri, 13 Dec 2024 00:05:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ef026a41sm7507030a12.15.2024.12.13.00.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:05:49 -0800 (PST)
Date: Fri, 13 Dec 2024 09:05:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	x86@kernel.org, linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
Message-ID: <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213054610.55843-2-laoar.shao@gmail.com>

On Fri 2024-12-13 13:46:04, Yafang Shao wrote:
> Since the task->comm is guaranteed to be NUL-ternimated, we can print it
> directly. Add a new vsnprintf format specifier "%pTN" to print task comm,
> where 'p' represents the task Pointer, 'T' stands for Task, and 'N' denots
> Name. With this abstraction, the user no longer needs to care about
> retrieving task name.

What is the advantage, please?

Honestly, I believe that the meaning of

	printk("%s\n", task->comm);

is much more clear than using a cryptic %pXYZ modifier:

	printk("%pTN\n", task);


The %pXYZ modifiers makes sense only when the formatting of the printed
information needs some processing. But this is a plain string.
IMHO, it is not worth it. In fact, I believe that it is a
counter productive.

Best Regards,
Petr

