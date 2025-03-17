Return-Path: <linux-kernel+bounces-563650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB579A6460E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B9E3A56B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475CB21B9F7;
	Mon, 17 Mar 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK+HoQdz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C1290F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201248; cv=none; b=uToYW48FW3Lj+3H1j00ZkfCbCs1PIKhfzV8C/gl/fSKXZBSd5zvoiZNycIxV4lTb0hqipW1Y4u/wgD8zjQM6oSvUztBNVUx10rXTbN0e3PbGFHHPFq866cSUthO9lcHGJuI9Np12spu2f8tScu8+U2Qu8X4vhf/Eancxcjd1lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201248; c=relaxed/simple;
	bh=GcbYMMUSIE3M4i78Wxii4boc3e2DKtEOdBzPXwAlr8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx01fGTg0gxg1fKQ/2w19R5Yd6B2BdcDmCbCEsjEvWbMXWbtrvpl4ys4Wsq6u/DeL5JpmwfML+40gXpDQjrwEpOclDF7X8myeD1C8mOa1+6kW9M36GuiTAZytmtkw88RXG2QGvbkepBk87Q0H5mD9Bsw7dVPPSM2T7xwfGn7d0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK+HoQdz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso68575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742201245; x=1742806045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/fkYxvznXVkWYdwjft7DNkV/shj8zHmAOJFoExLy+4=;
        b=PK+HoQdzCSZ4G+HXXF624YPzcyOJVXHnoKVI04NQ3e9UAAUujlTgrjCqgKCophUcy3
         YkEHc5VVQidBm8qYpfZOOX6iUF3+YkOde0F2gNhi81bZ+JXWE5v4ypvQzpBcRYVFR5Ct
         1I8aL5MSDALWRhx/x+mTIGIBRe5ciqlAmTo+6gloJvCtNZbMiqcJ1A3ePBSohrD3H8eo
         kHZ9x45kz1EtTHfyEGKJi+7Rzm8UeQJlB9xSkvpf3BUL0XB6LRNxgjzCqEsvo5uvZVQx
         b1e0La3CIa1/Y+0P3FvtIukMajqVTc8zh2j1WQy6FadIvtk7J6/jXvc4TuSAdN+rqZ/N
         ZA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201245; x=1742806045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/fkYxvznXVkWYdwjft7DNkV/shj8zHmAOJFoExLy+4=;
        b=dZtWUR4KUsjRj31oOW2SzlSALs9Y3c5Ad/orNrgiksK4y8IkmUmKcEGFDN3e9TWn7S
         h94tCqjGxyadms3EGMuGyr2q0mYyb+IeRGS26o3TLSluFXJav9UkEc6v8bRoK3yd89wg
         40T3EdNdVcZ8BrPX3r+CSlk/7yqwuE/q7VVxJByRV0Juk8MooJ6HsRCd5P5cQrv7AKrj
         UncMGQiv45HmlxAWIf7iQGNPvb9kyn1t4VjX6JIh0P8xs+rjlm5dbTW/guHPzGDwTM2y
         XT5wUgpu/YspPVHxGu2Ww8vuofBQ50fUpSbEFbUpKgOayOZvcralLgu7wnKpwG6suoXH
         Ui0w==
X-Forwarded-Encrypted: i=1; AJvYcCWJQlsMlArbWkqyChOBc0RHx6uhFWLqYnsztV8TQy9nsLPqUtsOBPXbWzwkgoNSMWTwXodhNb/Mrn6Ir/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YydyzKJ4rjXaVKm/rz0vRncz38x3PYUTaJ8qIsT47T9PzZLbGyU
	zuEui0v9IoE08ZBl7GhIDIKBnN3RX6kAJGBcwT5VLDKDoT1THnt4fy6klzV8Mw==
X-Gm-Gg: ASbGncsy4HqU4y8xrSRq/1gx2+NqGfxEsmpQGTTN8F3hDs5HCtzwXdoNZi8dLm0p65t
	gxrxIdnXXnpqRH/faA1ej3G02HRpyfbJEKpa6vJ1asr0gUXNBhsXAi64RDbGpfc+Vqlb9o1P2w8
	EWmawlnxtqSx3GHaqHsZRxBXMB5gp/nzWVMopfFTku4iR+hatBQrp29qMeybFvNWO5wQjjqrlxQ
	UmYCwNoytD/7mUKwVQWSe2PvUQ0ir62/rDRjGF23dM+2KIlrpAb77BCw0u5sVNrNqI3bDulmmoK
	ZD/GUhzkoRa8kEqxR0zysGLiigbOHRVhD9cv2/YR1sXcUOkbst6NrRlanTagt80atnrANuU0lIS
	sZHm63To=
X-Google-Smtp-Source: AGHT+IEdU8jg9DLExsfx/Dignybsg8rNFerbvJiYjWiieoEf80yLDexyq7/WybhQskE8MGMn1w2icg==
X-Received: by 2002:a7b:c389:0:b0:439:8d84:32ff with SMTP id 5b1f17b1804b1-43d266e191bmr2132585e9.3.1742201245192;
        Mon, 17 Mar 2025 01:47:25 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881187sm14080655f8f.41.2025.03.17.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:47:24 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:47:20 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 04/13] objtool: Update documentation
Message-ID: <Z9fhmCS68Fc8GGw_@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <2552ee8b48631127bf269359647a7389edf5f002.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2552ee8b48631127bf269359647a7389edf5f002.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:02PM -0700, Josh Poimboeuf wrote:
> Fix some outdated information in the objtool doc.

Regarding the switch from ENTRY/ENDPROC to SYM_FUNC_{START,END}, would
you mind adding a bit more context to the commit message for the
benefit of ignorami like me?

BTW in tip/objtool/core include/linux/objtool.h still says:

>  Such normal callable functions
>  are annotated with the ENTRY/ENDPROC macros.

And o we also wanna update include/linux/linkage.h to mention that
these macros are deprecated?

> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/Documentation/objtool.txt | 95 ++++++++++++++-----------
>  1 file changed, 53 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> index 87950a7aaa17..28ac57b9e102 100644
> --- a/tools/objtool/Documentation/objtool.txt
> +++ b/tools/objtool/Documentation/objtool.txt
> @@ -28,6 +28,15 @@ Objtool has the following features:
>    sites, enabling the kernel to patch them inline, to prevent "thunk
>    funneling" for both security and performance reasons
>  
> +- Return thunk validation -- validates return thunks are used for
> +  certain CPU mitigations including Retbleed and SRSO
> +
> +- Return thunk annotation -- annotates all return thunk sites so kernel
> +  can patch them inline, depending on enabled mitigations
> +
> +- Return thunk training valiation -- validate that all entry paths

s/valiation/validation

Also did you mean "untraining"?

> +  untrain a "safe return" before the first return (or call)

Nit - assuming this is about the SRSO mitigation I think it's better
to just refer concretely to "Safe RET" here (with the capitalisation).

