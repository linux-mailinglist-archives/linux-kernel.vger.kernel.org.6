Return-Path: <linux-kernel+bounces-553882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D2A5901A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61E91890953
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDC225A20;
	Mon, 10 Mar 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIZHb+w6"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98094226D0A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599887; cv=none; b=ITS2WE11oK3c32fi/4krKAgvi7MjgftioBoA/0Bjesvmcsu9nvynXOXoxjzM/roghpD0Za/54fkzfBN1MJD49A5Nlhd+dTOMbih8saw08MqUgXBymA6hMd6saHGbG271KMIOA+IsvyAGoyOtEHLsjLD/ckd/UVmNFQaC+R2oRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599887; c=relaxed/simple;
	bh=gBsxJraH2VccxGdfoYatDUg8xaTF55kYrM6BAJWMFNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsaulkgyOsexvSfTmZC1nf+u5ZRLs5hUXnLbobOMoPrlG5ZL8dY7Mr1KJhfOnK/F3dMrrAYheAEII77TUg4AWjOEI2bWbvr5G8o0ZTRayAVnxV4fnmc7h0LOV3sIvtxBIcX1li/FuLz9hm7XJDms5IwaLLpPeTl9tIISY1buPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIZHb+w6; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913b2d355fso514163f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741599883; x=1742204683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4uT7Aj9nf7d2IT7mRwWlJl8JB3gxTUY+mQiV67L5Z8=;
        b=CIZHb+w6frU1eCTidgr9HQGGBMxs4svzTLld6UP12T1m9O5zv6QK0dUt+gSPPMpAlg
         wJXeXaO3Zqv+ulTKBtZ47p2u5wSer1WttrHpkARWGB1f8Tj2QsTolKYse4D3nf4YBwTG
         xncSeImfZ7uKE2wA3f3BLsm2rSFoxM5FR6oSuFbK+Zbi5kh5GEwA2GFUyEsZIPxS/Mny
         VqZcFzJT8lR70SPI0jiNYVeweytT6z3y4Obly8an9NzSas5kowcoJ2vtCOQhD5fHJnVJ
         CxgoaSkXgtyrXtbgjGzsbaXVRUR7IyTqKNMO0eUFeoLN+GTsm3Em/dUhyUbXcq/U4gTi
         8vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599883; x=1742204683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4uT7Aj9nf7d2IT7mRwWlJl8JB3gxTUY+mQiV67L5Z8=;
        b=Ndxxi7G6F3OAL/RvUj14m2HloMyVYWNi/0aM2fs/4cfZQUW/W47kXjcAjk6MoM8oKm
         SFF57qkXtygXT59wEey/EFusZafTbhVBj1QL8nlUzuBM+meaPJGWYnqs9mONPhUfJ+yh
         6JaL2NWXSzMztonJNo+ZMu15snsUIiO0KWCi6zVztdx6ZSnVZfL/MxbahrY8jKtevWKF
         4fE4NnkvX9b82tsIwfhl37/4ru6z0nenB4HzyQ5MiKIch++CsANdkjCXEVi5GXpFAJ9v
         RB+7K2Oj7Ue5S1DjphGNtUn7y8IEaG/ewlRvUQ8KcFCNfFrQ2gBqSz2P0G0uzlTBPKgy
         tgQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmPeLLtANZVglMCPb+xfuGrayTwRTu7rnoAK8U8/uxv0y6za0myJ+dwbSVZVZD8WIdjwVTsWYIuZJ/xrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMkCpv8xTLMbcUiQzz21LIyWRvwyYXwxiUXkfSGcPy+u/Mr7M
	WLr9R+whgF/PpiN4mSiAMeuuwLvWF+mlm2cQNzRYowUSuqY8JLzPfSiBZ0pSyWLe+xRkpgw/dI1
	w70Scjgkp0kk0nA==
X-Google-Smtp-Source: AGHT+IGVyxro7AL58g4XR8fKVbaaI1TWX7wPwMNwsGLr+PpgDItcCn2Z27WVF1wmJWCgCt0fQ+bi8w9hZQvKDuI=
X-Received: from wmbay19.prod.google.com ([2002:a05:600c:1e13:b0:43c:f27f:e9f2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598c:0:b0:391:3bdb:af5d with SMTP id ffacd0b85a97d-3913bdbb534mr4193539f8f.28.1741599882976;
 Mon, 10 Mar 2025 02:44:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:44:41 +0000
In-Reply-To: <20250310073040.423383-2-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310073040.423383-1-richard120310@gmail.com> <20250310073040.423383-2-richard120310@gmail.com>
Message-ID: <Z860iWGtaEFMD2hj@google.com>
Subject: Re: [RFC PATCH 1/2] rust: list: Implement normal initializer for ListLinks
From: Alice Ryhl <aliceryhl@google.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, jserv@ccns.ncku.edu.tw
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 10, 2025 at 03:30:39PM +0800, I Hsin Cheng wrote:
> Currently ListLinks only supports to create an initializer through
> "new()", which will need further initialization because the return type
> of "new()" is "impl Pininit<Self>". Not even "ListLinksSlefPtr" use the
> method to create a new instance of "ListLinks".
> 
> Implement a normal method to create a new instance of type "ListLinks".
> This may be redundant as long as there exist a convenient and proper way
> to deal with "ListLinks::new()".
> 
> For now it's introduce for the simplicity of examples in the following
> patches.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

This change is not good. The ListLinks type has an invariant about when
the pointers are null. The existing constructor argues that the
invariant is satisfied because pin-init initializers can't be used in an
existing Arc. Why is that satisfied here?

Alice

