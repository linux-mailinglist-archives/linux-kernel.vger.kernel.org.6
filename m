Return-Path: <linux-kernel+bounces-268301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE29422F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87202284984
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9C1917C0;
	Tue, 30 Jul 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0eobpUe"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B438B;
	Tue, 30 Jul 2024 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378785; cv=none; b=GF3BZQcR4bS02jLkR/zuEiCShg93gNnBxaYC61A4uW/vPvscKWNqcBomOQnypP6Y2POJt008vli7B6/+y/h6+ZJsQYzL4DO+AjUHyQaVgMGmrCAi6i9Q9Af4Fg4wmqXMA16BNbxiDAdIseKSjRvWfxArKV/oTG/4tDmXjuH9B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378785; c=relaxed/simple;
	bh=4KyrR7IBFroJVL6n5U1GngfyCCWFp7LmRr5KSEnFCjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXqhuB0IBv93OFdd3MbTK6VjcnZy6v4C+Z8XSh+qN8sq3OQpPE7CQCchNUP5BZJyqPb8UE+u469102qgKBgFEuKSLcHZEfheoX+Pq4m+Foj/MqB12FltmXi0rhr/QsyqZXtBo0qw+1TV9MpwS1YBfmI0q1o6bWOZ+n1pR/dtXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0eobpUe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so3341773a91.2;
        Tue, 30 Jul 2024 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378783; x=1722983583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/KILlL1Tc4x1X/M530YMHjk8qNUj5A9ozgEiMjiu+s=;
        b=k0eobpUe2racFdh2iZxouIUbFJuCB9hF9zP59MD8vYQJu8zcy4llkFLXPwW3EiRi4w
         2K6gFYAY9vOgs3weQNFK3XFp75TCTElCZCv2NiQi83NZyo2qQ0P8c4orS5FVTx5VEOZi
         sIJNcgav3skoNGJF83R+45Vb0U7KMS9FezURAWy2eOB7L53i3RyMbUu4YByGn1UPm9d0
         7+mxw6lyJPamoKBb/hBnOCYPGBacR/LUBwfpSZeaxCfToSd/hlUmYU9Icr42c24AYTwd
         eQTD941Vz4n5APJZJl7ysIkS5/JJCFfL9Bo+vhL2Zp5WQwFBTG5sRmb3qVJzImBv8dnA
         t56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378783; x=1722983583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/KILlL1Tc4x1X/M530YMHjk8qNUj5A9ozgEiMjiu+s=;
        b=SD4Vqxk7xsv42SHAIVF16ueSJ5RCin5qPbUcIbdwVER3+EICSo/Uq2XGr3kzLKreNR
         nO5jFHOtzfSiFg7gBBjcyjn/xZNSSD8PmVMmuvTtIZJGpzVV9tDdWAkuAUb/wDKvjTIf
         D5a6lcqPeqfRY7pFsH/xLIOjLV2DQ/ZrASexkm+/u6rCis1LEFl9ASK04YBOdt+kyLRg
         XjdoqD5qqh8sxozxHaslk7QHDWDNh+wHfgmX9qrK8HYy9Cx0i6xeTK1+ahMgcploYoPf
         PFEZJ7Oop2inLvk9zrGBhEKXb+rGuFgP6kyY13I+6wDPo/H9H2TslKD94de2qpppAR7W
         lC8w==
X-Forwarded-Encrypted: i=1; AJvYcCW7s32uND2XGWTr2GROMNdIYu/6Xy2QHT3i6hbWJwwPlzG1u49Ub8FwIHXeCSsfA5ltN98Zi7wSlUe3MPRDXfa5iACP+BXQC4jRpGVHPdmND7hC/3fp3KdCcJnJs5rLN2n5FOUgbbpfq/qD9aA=
X-Gm-Message-State: AOJu0Yy1JgpY2/w0MUg5PIy/4sS+HHWcXTvuvlfW2F3cHPXKSH3a3QF4
	gGXoM9Y1qYhEnumA0g2C2MrqLntfcaCz3m+U5Bn/6ZGgt9fLi5NT
X-Google-Smtp-Source: AGHT+IFdV1/gP8EJPMtyj+owOMo5lX+sPiezN2WkqrqktYYE1JaS/XVJCZLCNnLEnOGFfXinqt1YoQ==
X-Received: by 2002:a17:90b:b83:b0:2c8:7897:eb46 with SMTP id 98e67ed59e1d1-2cf7e831814mr10242028a91.37.1722378782857;
        Tue, 30 Jul 2024 15:33:02 -0700 (PDT)
Received: from Gatlins-MacBook-Pro.local ([131.252.51.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7b0b3sm11382488a91.15.2024.07.30.15.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:33:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:33:01 -0700
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: support arrays in target JSON
Message-ID: <smaafae5mqjcxm65rddnsayhsvwb6kd2joj3mfghskmtzspwzc@d5wg2its6jac>
References: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
 <20240730105646.1aa7ac07@eugeo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730105646.1aa7ac07@eugeo>

On Tue, Jul 30, 2024 at 10:56:46AM UTC, Gary Guo wrote:
> On Tue, 30 Jul 2024 09:26:24 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > From: Matthew Maurer <mmaurer@google.com>
> > 
> > Some configuration options such as the supported sanitizer list are
> > arrays. To support using Rust with sanitizers on x86, we must update the
> > target.json generator to support this case.
> > 
> > The Push trait is removed in favor of the From trait because the Push
> > trait doesn't work well in the nested case where you are not really
> > pushing values to a TargetSpec.
> > 
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>

Tested-by: Gatlin Newhouse <gatlin.newhouse@gmail.com>

> > ---
> >  scripts/generate_rust_target.rs | 82 +++++++++++++++++++++------------
> >  1 file changed, 53 insertions(+), 29 deletions(-)

