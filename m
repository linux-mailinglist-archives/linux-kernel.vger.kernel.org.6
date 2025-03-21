Return-Path: <linux-kernel+bounces-571576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA230A6BF08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BB417F294
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44186226D1B;
	Fri, 21 Mar 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNNmZMeT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305011BD014;
	Fri, 21 Mar 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573103; cv=none; b=Nl+B8eKozloh6c5Gq6+UXBzrYdm2hS6o4fRCEKkwmcdIKUnB6vwUPYbGuko68TYJi5aP0JYOfxkzhAygACQyMqC21RUMMIiiIyYx+riQcPhfusesNI5V3vzmI+FwJC3L+3PUmRIs13rgxmv23X613qg6D+cEFymEfZzjjDGVxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573103; c=relaxed/simple;
	bh=Evyh0LaqIwVSS5SaXfrG5DXRqb5OL7vGg5nOCVnZdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svkfWd1PUeaSTWki9LlzsBduhogsG1XKSEApuswNGcQ+hi9zZCwdSgfAR2GbYOUREe4mguuQVoprLsrdSQXIk4hxO1S61pOQ/gOvEukGDA7GSIIh3HUYxKU/HoPhXO97WorCFTu/pfzrSxr9av8gl4Z0hKmqrbkJiffv1RlLG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNNmZMeT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso54060745ad.1;
        Fri, 21 Mar 2025 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742573101; x=1743177901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULdfllxgP3r3dO+/77mZNKZ9XML6aqvmfo2ffYUWmbc=;
        b=CNNmZMeTgnUWf5Ll1zDgaNxWLOrv0/fm4xB1QdbDtkgcUrPPN0rfTZgI8WMh4W0xnE
         WmUewnzNMqs7StWMFVEHu/Pc4SA65S4VAkzgSS4Ca9iEfgGwglRtPJQNLVe8QnddlL0n
         39W1o2TOv5Se693pe/0tW6OAkyvJUmYy5Ma2cD0y8yHER/P+k3ZG7L9+570yBf8hiJYw
         1yzlxCpT6UBKAgcGt6e8oUaeeTtX9zaglEIpLu4zaQviDUGAVYFU3FkHe26J2eb3dcEV
         OnWiwt35r86M06OAupuavr2xArXmdMzszsSWwqshsXLoR82hkDauJDSu0o9ImHLxmHau
         m/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742573101; x=1743177901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULdfllxgP3r3dO+/77mZNKZ9XML6aqvmfo2ffYUWmbc=;
        b=QXpAMGBwzY0utOzsNSvW4BO7ZP7pBidP5GLrWqdFyiHVzXf93ir+EjhqNOv8CxfAgq
         2tEZhdO/mG3r0TmU27KnBYOoS1inUqPAWMRRTCWOfdI2G4TXtO3/5nuqWnSpHahfadBd
         1OhX+0wMukvpgzS/blPyBegVB8Go3iklWHP1/Fo3j4W391e/Ya3bi96RhohRRpy21P5d
         Y8jFQDawwWSb8MALQqRF651kqG0wZTtCftv619SahjQgvWPokGyB4koHJ01VET+6zkPX
         E9Ge5Ka0twTWesBkOEcU8uflGvksY8lR1v6sjeUToor2UXBREh7Ph9/nM3MOlwEiS2/g
         mZSw==
X-Forwarded-Encrypted: i=1; AJvYcCWwL2U2YZ2LpEq7I3UhYJbIftO0xSpX3/O/QbQiC3r/qG+lMgRbu1kw1/i3x80du3uUJrqLRjn0PTW30WxapQ8=@vger.kernel.org, AJvYcCXGdiggQwwsWu2UaE+DnccQVpYN2w2WSxnQypOkca/kMr1iOLBDh172R0U5wC/UbawlPxajApSrIgsaSw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Vpv2ZpSRXlYhjVjxMaqeJRhzyOmuB6fFER50ytdiucYcfVOJ
	AlfIrt1LBOt6mUD751waZkMsN376ngsWZd3QTGViFV/UC6p7+9WQ
X-Gm-Gg: ASbGncuUAiFfLFjmZEUQAmjyug7dCM5kn2iZ5BsBoMrGiCGvjPaKY/3h2JDFxb4pjJP
	Xf09WnTBVlP6zOJhUG1WBZBm/iyRddUz8M8k8giEw9O6ATQYtjXGBcQ0lc3iw5+X7IoHI/MtlJ3
	tRHL/2akX7f5mym/hgt7jCoM2quu5v5EV1J/hHwBa+Lk3x3GNSWJhsgdrdxhmmjgUNK1v3tvsHU
	q68Zhyc67kW6r0zvk3qiebgRkyXy6TX3V1Dmt+st6yscQQ08IlztrDY8eZNKXBClvizmByLET8b
	tE6p6PhzNBIuRR6dr51eAGo7HOkowMFZLII0ZZBImtQK
X-Google-Smtp-Source: AGHT+IGSXkg2s3NL3qakms3Qx/g7DIhDho68WOUq+33M4PsyHhlNfwxT7iHrVVS0zV2WpDzi4qJeyQ==
X-Received: by 2002:a17:902:d489:b0:224:13a4:d61d with SMTP id d9443c01a7336-22780d80143mr47435085ad.23.1742573101248;
        Fri, 21 Mar 2025 09:05:01 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f651asm18541175ad.209.2025.03.21.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:05:00 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:04:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] rust: add bindings for bitops.h
Message-ID: <Z92OKn8V_PBEjNme@thinkpad>
References: <20250321111535.3740332-1-bqe@google.com>
 <20250321111535.3740332-3-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321111535.3740332-3-bqe@google.com>

On Fri, Mar 21, 2025 at 11:15:30AM +0000, Burak Emir wrote:
> Makes atomic set_bit and clear_bit inline functions as well as the
> non-atomic variants __set_bit and __clear_bit available to Rust.
> Adds a new MAINTAINERS section BITOPS API BINDINGS [RUST].
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS            |  5 +++++
>  rust/helpers/bitops.c  | 23 +++++++++++++++++++++++
>  rust/helpers/helpers.c |  1 +
>  3 files changed, 29 insertions(+)
>  create mode 100644 rust/helpers/bitops.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52fc47a28b4c..7cd15c25a43c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4128,6 +4128,11 @@ F:	include/linux/bitops.h
>  F:	lib/test_bitops.c
>  F:	tools/*/bitops*
>  
> +BITOPS API BINDINGS [RUST]
> +M:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/helpers/bitops.c
> +
>  BLINKM RGB LED DRIVER
>  M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
>  S:	Maintained
> diff --git a/rust/helpers/bitops.c b/rust/helpers/bitops.c
> new file mode 100644
> index 000000000000..2eaab292db4f
> --- /dev/null
> +++ b/rust/helpers/bitops.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitops.h>
> +
> +void rust_helper___set_bit(unsigned int nr, unsigned long *addr)
> +{
> +	__set_bit(nr, addr);
> +}
> +
> +void rust_helper___clear_bit(unsigned int nr, unsigned long *addr)
> +{
> +	__clear_bit(nr, addr);
> +}
> +
> +void rust_helper_set_bit(unsigned int nr, unsigned long *addr)

volatile

> +{
> +	set_bit(nr, addr);
> +}
> +
> +void rust_helper_clear_bit(unsigned int nr, unsigned long *addr)
> +{
> +	clear_bit(nr, addr);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index d4a60f1d6cc4..0c25cc86a52a 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "bitmap.c"
> +#include "bitops.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> -- 
> 2.49.0.395.g12beb8f557-goog

