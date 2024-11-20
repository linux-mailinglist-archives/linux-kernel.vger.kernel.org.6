Return-Path: <linux-kernel+bounces-416358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E799D43AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B780B282825
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE771C1ABB;
	Wed, 20 Nov 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Y0f/gF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E416130B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139704; cv=none; b=B96T5oxoa1ttVco2jQLdJteEw/FwvpPQE9RjHDwT5EQlc/D0xtOG/6VgEi+8Rh0iHMzW43QiNPoapRDiX2TSH3wDS1cxD5Me23POo7ez3exhmeACC+cd+tkvWetlT4HkvFVAlcaqqSuFpkCyY3yfd6SYBJP9sn21H4BIgbNk3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139704; c=relaxed/simple;
	bh=p/2HQRb8DSnOeN4sdRAF0ATMaB8otlVUnnqv1o1FzGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmXFXmpJJoWjJK78pLPCHmU4iO8JJQ0HCeNh+lQ9YAzzN/v2yxlhtJGe0zVb9d7nTaxcjuKUNH2vI62pMf0Sl+1Os263FxjXMT3W+lvtpjeOgWxTMEts8VJjSuL8uX3IdS+W1NMYFBFloTGEhpZkvuGWpVts96OiqO1MJZUu3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Y0f/gF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-211f1a46f7fso42045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732139702; x=1732744502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJuMd+zGRgDKZ9hMGh3NL+Uf9ATMzUJl+LIc+tHuySg=;
        b=C4Y0f/gFqtdzQqNOxa9+YQDrWocL074QKpC6V0Xo4T4sVirP5UJyUolbJXhtl2KcoB
         mvCoVYzQFhflAHmHgqnKqFUrwV1TkjnNwb4ywWFTAAsWQvqQeM6ETxtn7bG/NJgkZg52
         dVZlRHGWKXntAcd6YXUsBH6TmfzJONqtSBaXS9eC+oGpUaFI3VmuO9r3E/FS6Z2T2Yct
         hNKS/XOwneUIzbnC8/typZKVL3XliTMPo2qAxr8zNHzP2fYQ4JkOGaVE82nk5/H+t4Ou
         uAjaH/iva7OEaRPpbPX342xMr0r9FB+dv4jgjdfGW0bXM7d/knDrHr5Zyho4xrECMY4K
         wEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732139702; x=1732744502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJuMd+zGRgDKZ9hMGh3NL+Uf9ATMzUJl+LIc+tHuySg=;
        b=MvTa0NpktvRlPHpFfqYd927HOOLjwv3KnA9AitE6fmTn5XUhvPqKntt0c0MRtP8LeV
         QOTVaYrPJ2LAcpZ0oK+GD+RPORa2ugzLkBVSWOtOp18hkvbhNlMcf4rFI69z+xUXgOzJ
         icyycVnXCjK27VQqLC+AtsTUGBqLS3FhMCE0IR0XPVxqJmW7vW/5Y1KOnoXrkrqu8P13
         NFboxEOhuSFSE3FpXYFIbzHRA+ebsde7w1+Sd/06y4KRG7hCEg46hoHvZwMfhIuksJKX
         7LcivFh9kRSyIJC8A0DBNtmFDz/HgFlV1AswrZ9s9AM5k9dOoX+fxcs6aM9vTWx1wVxx
         rZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBN7XPGIVlItpIVIN5XU0OX6NcD0sE3KHW1AEEKzHp1dSr4J5qrMdMef9V+V+wF8OzkWUrVk1XOtwKkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBe2ntaqUlUL9LdOKi5E2X6W7FX82crh3UU8hkK5hHF9sCjlN
	uK3Lbee/cU4KMSiIznNmM1WJNRK8LDEcjA4p0KBuEYtcYXlQY+iVKYWpW8SoSw==
X-Gm-Gg: ASbGnct7z7dlE/8X+uJoe59l2jtIL18QVDSazEl1KEHsQU+wmu3sjjeCT9kK4H2YlgX
	Mm4SZLRDTp9ehiCW6EU2mmfGanwoZwN0NS4Jz5j6l8wxN7Q057luHMoM4R7OJVQ4wZ7xSbWhDND
	agE+Z1W8B3x9RIv7l99xFVo7uFEY3n4pXBvijymGuCcQbKrpQk1rLcs9ZxL0rkdVPFyV92KI8yS
	TI66e9TEp+LQFxLqvc1w2+1hGDHyH7Mhw7LVodxkN6YxBW8Yb3CzjGIvh76wKcj0Kr5sD7MvR1B
	LrLsa3wK75TI9Ks=
X-Google-Smtp-Source: AGHT+IGKc9ZvPmJIK0nWwQcxR6PLarmpQvpHzkZoZJMXfvRSrnEfA5c5NwlyeWO3fgYs+0aWUjKJ0w==
X-Received: by 2002:a17:903:178f:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-212878a076cmr162705ad.5.1732139701962;
        Wed, 20 Nov 2024 13:55:01 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212880d16d4sm271285ad.167.2024.11.20.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:55:01 -0800 (PST)
Date: Wed, 20 Nov 2024 21:54:54 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
	Miroslav Benes <mbenes@suse.cz>,
	Asahi Linux <asahi@lists.linux.dev>,
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 10/19] gendwarfksyms: Limit structure expansion
Message-ID: <20241120215454.GA3512979@google.com>
References: <20241030170106.1501763-21-samitolvanen@google.com>
 <20241030170106.1501763-31-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030170106.1501763-31-samitolvanen@google.com>

On Wed, Oct 30, 2024 at 05:01:17PM +0000, Sami Tolvanen wrote:
> 
> For pointers, limit structure expansion after the first pointer
> in the symbol type. This should be plenty for detecting ABI
> differences, but it stops us from pulling in half the kernel for
> types that contain pointers to large kernel data structures, like
> task_struct, for example.

We spent some time backtesting gendwarfksyms with android15-6.6
releases to validate the kABI stability options that are currently
implemented [1]. While we discovered a few missing knobs that are
needed, we also realized that pointer expansion limits don't work
when symbols are removed (which is possible without breaking the
existing ABI when TRIM_UNUSED_KSYMS is used), as the processing
cut-off can change. Petr also had some concerns about this earlier,
so instead of coming up with an alternative solution, I'm going to
drop the pointer expansion limit in v6.

I still think that it would be great to come up with a better way to
limit how deep into internal data structures we go when calculating
versions, but I suspect that's going to be challenging unless C
grows an annotation for public / private struct members.

While looking into another version stability issue compared to
genksyms, we also came to the conclusion that private structure
definitions in .c files should be excluded from processing as they
are opaque outside the CU and cannot change the ABI. I'll include
this in v6 as well.

[1] https://github.com/samitolvanen/linux/commits/android15-6.6-2024-11-gendwarfksyms/

Sami

