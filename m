Return-Path: <linux-kernel+bounces-546919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC1A50092
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AD23A43B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7E24501D;
	Wed,  5 Mar 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBkRY4SB"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13BC2ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181540; cv=none; b=bRBiHhZIuQEAuJam/SQIPmDQNKTKe2b83MV599i205lp0JMC0WSF+tK7Xmt6wrAENEcswa5ZA0LgR9AcI48Hs06Q2yNP4YnTQwMwZA+ao603aP/yhBTMaclCnLVLmrqaRHENzrbpLotzFAAqfRDaf+rNXxk3gbANcLM0K47pe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181540; c=relaxed/simple;
	bh=MA/Tl5K/HzeGHY11yV+JGFQTHKF6NRYd26L2b8QqFyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dd1In50DmxkbIKkQ24m20WW+RmyIEUY1dVEakLrxSppTw5mDDbvaSSmpbX1U3XG1qgBt1aQ8/qY5lO051HAy++v5mYqGsVeVdu2kitn4WpxVqkfzE8O++Lg9G/VPrjm45UrgQ8f7PKIO5FofAlmHzmUxdbQhSSnyVMNaWGReHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBkRY4SB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3910b93cb1eso1550697f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741181536; x=1741786336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhZGVnCd1LrD1r7cIo0XuyDXMDAukxGRXDEbG9YaT9M=;
        b=BBkRY4SBFth7JiXR1NcIKNRPFp3Zbo0aw+tS8SJkPtCT11RxGZouVhU73Qr3AVcwZS
         CkeeogZi8PLjLQGh/GPFLtoQFRgJWxgCUMd1DZyhjJyA7PXU3Nl+9yS5y/In2aEdEJE2
         SXmemAE/W2y6ZD5lgWqrfrlrQDdMDuNoS8uOqcqVFHF1jPvUUlV2i4TeqzoF2K3bsIWb
         v5820P6avKywS7f0ThGy/B81G2HNDGbad20rEjITW5IYfKdvbnVufn7jdcTBkq0QQ2Li
         3D2YWf893AAV/xzPM0giFzWdLA0PTXMLEXGanI1+Q8cR5q+tCeGfWWRGX0TZXZH6WLp1
         dBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181536; x=1741786336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhZGVnCd1LrD1r7cIo0XuyDXMDAukxGRXDEbG9YaT9M=;
        b=omGvr6OMYJ9XEPpJzNDtabcikuT99ctTmia+AzTa+C2XcC/Nbsy1xSBa2JGFL/YWV4
         VB8V1B+GZ9e31wnkup9ERLX5foxNok1b+XbOWwAEeVU9n6pkd+klMTqVyJL7h2qBOMmU
         W8T8LqrjnSwAhPdC/5EgeCzmG2GTZnnBRpXZJLC+ZZkJyaTn46jRnrRyVsTjhSv/SBBq
         EwwLNA3txTGLKmSwTar30rSL4rQgZyZoxl7ZqgwhhE+ZTPe9iGPkK+kjhSn+GnWaoFXp
         PiqQYg7jqsVEkyhlhv9IgXbgOVkLT/p7GiDVyJxPYWhll4S6alftsWsKCF3k0bnsV3Fv
         3f5w==
X-Forwarded-Encrypted: i=1; AJvYcCXtGlLzA29DjQ9rJYFafNzzrqg6XjWbevzDntQBhFjnwzkaLUlS0bJ5QCa87aJNCpvQ30ovi8YUmIKno8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhCfzIs2CTs1gz/vIPbnqJgkIXZhLMQvY981tJ/Yp8jgB/Ggt
	ChP7yq00qd35yQIOcT2uLcdad0MTtV0SS3AROHkdKGiMiU0pvYaYIW3xOka8uy/xQNjY+d6F1pF
	GXLbHj/wS+3cuow==
X-Google-Smtp-Source: AGHT+IGqv7w5ZYvUvIWCvfPNCsKIl2w0sI3jypHqC/lLiiOmT2zEfZbYg6IijEn1V2yDy4haEHjOc40D25h5t60=
X-Received: from wmbhc17.prod.google.com ([2002:a05:600c:8711:b0:439:8e3e:b51b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188c:b0:391:23db:f218 with SMTP id ffacd0b85a97d-39123dbf45cmr901576f8f.40.1741181536569;
 Wed, 05 Mar 2025 05:32:16 -0800 (PST)
Date: Wed, 5 Mar 2025 13:32:14 +0000
In-Reply-To: <20250305132836.2145476-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305132836.2145476-1-benno.lossin@proton.me>
Message-ID: <Z8hSXgC-ecXCEPiS@google.com>
Subject: Re: [PATCH] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<KBox<T>>`
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 05, 2025 at 01:29:01PM +0000, Benno Lossin wrote:
> According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
> such as our custom `KBox<T>` have the null pointer optimization only if
> `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
> case.
> 
> Link: https://doc.rust-lang.org/stable/std/option/index.html#representation [1]
> Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.6.y)
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

