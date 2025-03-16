Return-Path: <linux-kernel+bounces-563104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63EA63708
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F52188E611
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71E1E1E09;
	Sun, 16 Mar 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="xZtnF9D7"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476D1AA1E8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151294; cv=none; b=ILqGYEDYOxdVHpQkMI9yYIyDHdqadj1s01vXFiQ3V3UvQSrT/kTS1OMKXJ+TheP6xJtZkJykyavJSd3J8v6egAHGa7WlJSGXyUAj49gjVEXEJ9CaSOzh0sUVIBjHghy/NFm1hRNtOGH+hf+4pJXTMi7uawSosbZoyxv/SSZUAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151294; c=relaxed/simple;
	bh=zRRGLszJcI9Ww+80z26LGiQuD4y3P7H/6FdpcWOHEnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9YWmAuaEb/+WPzK5sUNap4cP6L2d5pEF9zmfta8vHORk5q9vaEX/W3p1GdH78IL5uUPLTAnLmwKoJ1zU/0oPVXnlLiasY967660CJG5XS0y1CkO5LwQJYWdjBgMvZ5Q4C5p6tG2Oa4mKKgwpS6SO4Rrbq4wSxW0i7B9A/SgbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=xZtnF9D7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6febbd3b75cso31489397b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742151291; x=1742756091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvdWb8P4BT1PgWG2fQCxo90ztiExxOPg6h8PgNmmvms=;
        b=xZtnF9D7c2bDn8Z5NbVpxJYmLAwQ2p3Pl9X1SkxcUPS3CTwg3K4sxgyXA7+o3P31MK
         iLM8S7BaXfoMb74BAqUd88Dd3hVB9EHklEW8Oa+U6eiOhMuM1jyICMAEA/7vnn0NZn0q
         GP842rAeRoUOyzKegKW5GzCqjNSIR8isIhe6PdZnXzbPMhgz2bbdw0K7yPDBHC3D8mX5
         a/yOCoNK6mZiSaRuuq8mFp1NRQslqdbETXkOAwTtDSX7GXmYRmRrYcPTuI+CVgUr5G1F
         jHqQeUKYnjkGOvZJrX1NUE2rz5S/UvMhrZ67OHQT5XP9bEoPCr+9YjF7F/CVJqDw67r+
         iJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151291; x=1742756091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvdWb8P4BT1PgWG2fQCxo90ztiExxOPg6h8PgNmmvms=;
        b=wDtzTwrExotRWqI97KWpSG8iWMxu1G53CKkv88ClrBzLPEke7FxLAvyOovyDPVEOEE
         odoaGGRgV52ym0EM+DC7iZuwNAYsBrILeJkJXPn5NlEQIoEs+7ACidgB5wKZE+Z6hur7
         VGBg091Kn+lE493xAGrVOzY8q98zc2iDrmbukXr/l98G0iZ/YMWmq/XP9YKyyNQF3Sby
         N3xgDA7D64lIJhtQirgGAJp5JQ9//jSZSfqEEn3Vj8vUyDMRqjHEOwfUcawJJgpBMmt/
         Jm+f02q95nmyJA4RInIkqzgsC3D7o6CIy4DPM1qOgcImMndijpJCArLPB5AOxWfBdNvs
         gkbg==
X-Forwarded-Encrypted: i=1; AJvYcCUXsHmpHNf83OMZGtYFs/uEPhyUOVPw+C/srZH0kVLXUZGPlwr8mTrYffm5Chmd34liEhdXV7c8pJLtAx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9duPskBqBvRgfW+8HC5xFWxBihqhU5E69ensJdsremeGMp/Rw
	jzdWyQwI63r5SFjkv6xmE6gQdt78gizaUPUcCx8QV95PCfE4LSW7z58vP1fW3eY=
X-Gm-Gg: ASbGnctrzEO7Gm610OPmsHGVeRub9nOzZMTrXxwu2o9BnDot4CP//Qg55Ipzhn0DUJ8
	vgMYcJ5iWlqAEkeklBKgCRpqxYXb4O6aaThHPBg00+/Udv6R3rg75ykB3BpGDbW9Hg2S/PaRZuO
	y6OXNKvG7WF9I/fEEWTgx4H7oFb6tZhiO/tNs3XSo0FDWCjEn9IP4K/dgkZdS3TUrTwWPJVapJV
	vTZC2+nruVNos5wSRHEY2E2iM+KLF/S4yvzak0etdyEkTWvPE5ja+7fL1Z9MDjd2zZpPoJBVb7l
	lWpWBs3bCbyWPWFAwzkCHgbdviHc2p1b4VVfLM/fhX1Ziir52dhJoCz5wCxI/JyewqaSkPJutUJ
	ryohfrNUbO6gXnaqrINyslv8JfKUTZ+l2mFcYq+LA
X-Google-Smtp-Source: AGHT+IEf61ITWXTQ0xB0/jw/y4GF9A+lDmm2UolrQcX9mgJQdmkAnFnfFmrsyIE1fbiYnjOGpVmumg==
X-Received: by 2002:a05:690c:4c0a:b0:6fb:91a9:94d9 with SMTP id 00721157ae682-6ff45e3cc5dmr134299007b3.2.1742151290797;
        Sun, 16 Mar 2025 11:54:50 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32d0036esm18493657b3.124.2025.03.16.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:54:50 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: benno.lossin@proton.me
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	contact@antoniohickey.com,
	dakr@kernel.org,
	gary@garyguo.net,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceWriter method inline
Date: Sun, 16 Mar 2025 14:54:39 -0400
Message-ID: <20250316185439.913013-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <D8HVNR3Q3UL8.1007IZIZTQ0XB@proton.me>
References: <D8HVNR3Q3UL8.1007IZIZTQ0XB@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Mar 16, 2025 at 05:47:40PM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:57 AM CET, Antonio Hickey wrote:
> > When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> > toolchain provided by kernel.org with ARCH=x86_64, the following symbol
> > is generated:
> >
> > $nm vmlinux | grep ' _R' | rustfilt | rg UserSliceWriter
> > ffffffff817c3390 T <kernel::uaccess::UserSliceWriter>::write_slice
> >
> > However, this Rust symbol is a trivial wrapper around the function
> > copy_to_user. It doesn't make sense to go through a trivial wrapper
> > for this function, so mark it inline.
> >
> > After applying this patch, the above command will produce no output.
> >
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> 
> What about the other methods (like `write` and `read`?) in this file?

Hey Benno,

The other methods in this file were handled with the patch
linked below. This was one of my first patches, so I was
unaware of patch sets and did 2 seperate patches.

Link to other patch: https://lore.kernel.org/all/010001958798b97c-4da7647e-d0bc-4f81-9132-ad24353139cb-000000@email.amazonses.com/

Do you think it would be best to send these as new patch which
includes both of these patches? also if so would it be ok to
start that new patch set at v1 ?

Sorry for the confusion I'm new to kernel dev and patches,
but starting to get the hang of it now.

Thanks,
Antonio

> 
> ---
> Cheers,
> Benno
>

