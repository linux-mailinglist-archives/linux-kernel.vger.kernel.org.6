Return-Path: <linux-kernel+bounces-220134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB290DD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53513B22825
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752C16EB7E;
	Tue, 18 Jun 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pybXPiM"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F516EB4C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741273; cv=none; b=oNH81Z/NOq+HLV8xhWAVZAAzTN34qQMWmSQQB/VGXKcyGzQ99rDbpsbJczmT/NQb07ij8hHDP/G0QyikJHhRNQtoW+Y6RP0ws9ELwGrDKO6LZV5p1XN6M0H3N0fSzIiDCYK/xgeW3BWkUQKSpLuGsRNBvLDG+ym2VZ8zern89+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741273; c=relaxed/simple;
	bh=GS+MYpzkl/bTjJ1KKsJRovOoqGznlFU6k1AlD8YflpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxcXQNd8Y3+G+2g0Q+DZQt6W+UbYfBcOyNgKrNvAtj0ZuLSmRlJIIm3bEJdMllYmnnS8BEsW2b+GP/PNOMtkRpOjB9vFuQ4TRNzmXYItFnDGLLupKCFgCUcYbaYKoHPik3RtsVRGUvR3u43CmCPETdGu0O9MCaZ34Yet4Yz1TfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pybXPiM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70625e8860cso620929b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718741271; x=1719346071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DW1DlL1DLq+3wP/n1jncS7W2woNiKogvRNYb00e4Mms=;
        b=0pybXPiM3J1MqqjuPScK3RK7ekLiueihWGIpp1gjS6A5wGiwogus8wwh4SI5ZTrjOa
         pk3LaCBp3IQZCr8HsHObErlFY0mF2o5rmOqXhKfQLqV1C3HuHsJhjGbMxdzwdnwVmspH
         dzCGvZm5exO0QjkquuxNTszixpxwYTXV9jIrNNlCYx3RBuCthCwm66Ioi3hIlhi01SD5
         dEzyIaswibyQc11Pk+5pLcYIGFwIjGgUnJAa3d1jueNx8kMgjyRCY4P9JpM1NA7Fuz0K
         d40YdaNDrI2oio9X8AZ3Umb55jawLfsHnAc2uFjd8DUyO0sieg3TZgju3BrveD9TfMAR
         Xu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718741271; x=1719346071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW1DlL1DLq+3wP/n1jncS7W2woNiKogvRNYb00e4Mms=;
        b=oqkzYhht11lK6c2lKTxCnoJ3Po87ovTxyLaLmNakAF6l0L7rlFAmKUjJMqS1UV/mhK
         gCVOAA9eDoJ9J8ZuHcpDJ5cV9ioiYXKqJ8vvvyD+bXQnxYShryc2eUsfdMGS6ct00Mlu
         Q6GfiURM/AeIcaVeBVtacFotyUzE2r2mOFHcfccqRJzbukei9krsTnV7JXIlZ2cvvhMo
         5QOGQ4dI1l6yncG2wRfMlFqu6wENp2mYi1TYBwlv0X0ajvAqzUSg6SAIe2mLvty/kB+n
         BhghPvDuXQJg3yLbKV2L6bDPz35W4Z/KEMbu8PxHgGyIo4bbqkcljxchjvCC5Vorn99Q
         GMeA==
X-Forwarded-Encrypted: i=1; AJvYcCXZJj057nU3X7YEbCR/WQb3uzRF5WBP5lm22EFaBVJcbK5iq4wxI4JrchCwzYPzcG+M4t8BIFADfYsU/mA8jRFkzUO1iuW3u8pITI++
X-Gm-Message-State: AOJu0YwYYA3Ak7Vj/xGvOXTUSI/x9VSLnTW6JlKIbeUoq8Oicf6nbndo
	jsk8sc5jtHjo64C7hGkflPYxrj7c4IV0WhJarFHq34xx8OmoEqR7lxC1/bUMDw==
X-Google-Smtp-Source: AGHT+IGBxEmS/OHXtQQIWsc9ie2qVIzWvAZxfV32t6UbMfyp2e8b6CplgcXOur2GKUnes5dpMCsXtA==
X-Received: by 2002:a05:6a20:1aa7:b0:1b5:ac9b:a59e with SMTP id adf61e73a8af0-1bcbb55fdd0mr544609637.32.1718741270996;
        Tue, 18 Jun 2024 13:07:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:5dfa:e7d1:8470:826c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf35688sm6992723a12.13.2024.06.18.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:07:50 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:07:45 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 13/15] modpost: Add support for hashing long symbol names
Message-ID: <20240618200745.GB1611012@google.com>
References: <20240617175818.58219-17-samitolvanen@google.com>
 <20240617175818.58219-30-samitolvanen@google.com>
 <CAK7LNARL-Mtva-WuU-uktZsN3y1zyUNnFnZ25vRbQZ6M0wK0-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARL-Mtva-WuU-uktZsN3y1zyUNnFnZ25vRbQZ6M0wK0-g@mail.gmail.com>

On Wed, Jun 19, 2024 at 01:47:13AM +0900, Masahiro Yamada wrote:
> On Tue, Jun 18, 2024 at 2:58 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > +#define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
> 
> 
> 
> 
> I know this is a copy-paste of the kernel space code,
> but is barrier_data() also necessary for host programs?

I tested this with Clang and it worked fine without the barrier, but
with gcc, the code no longer produces correct values. Presumably this is
a load bearing data barrier.

Sami

