Return-Path: <linux-kernel+bounces-567952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89094A68C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F6D189B5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972A01E1DF4;
	Wed, 19 Mar 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQ4r6ggi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7325487C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385919; cv=none; b=pR2JdehLZHKmnFGgfrVHH/Xshpc8Tdwgc7mkrmdeez16UT1EIshDahMAFkr31pYNUeWh0eHGSY5R8QTBhz52tzgklPfrxLshElRVoTQ3Zvo8TBy7+JjkmxJYaaBy7IBLFR3aJ+ORJFDbf5kJ7C4fL8lxykfASSulzQsRauHTHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385919; c=relaxed/simple;
	bh=UTpQE/WDHXX+Pj2gIRldO9FHapRhYQUBIR9vGMBjXz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gxjdx6+CHlfLfgV4MmcrDTKabSN8faCWOe4qjpjCF2rFXZ82fNAvdfVymQWYBPOBHNq7QFxHoPqfyGYLorAkeaXgyybq6GeXiLF25tt7z9nguL8+DuEeAiqy6nwcka49XyU7odr+IPal5eKi6moR168y+OFbi/7slxH4gSBJimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQ4r6ggi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso50824515e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742385915; x=1742990715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHjoqVYNu/hQnnRhnhN3ZDP1fdRodfuuB9jqsnKQgGY=;
        b=PQ4r6ggiGR2/zST+7vBh48aOU2o0nxQZDUg+MwLplpcXccsUka3PTxE4itSf4wBGfi
         bcYHNQK34CurX73QC4V8B406YPxWQrTylIXaTM6JBWvEMrd73XcbCAbBTzevhvCeT8/x
         67bJ/BZ83zp1gDWinpp0eFffxspueJuhnIPp2xNS9ugQQlG1vp257HTQgPrzBljenc2g
         kHHqOQ0g962hRqinysqTrU0/yUAhs2qAAK4MZv/ylvP5k/dLW7d0pLrMkacwlZK9acuG
         e73VoDRmL10crIoFhpljJ+5LGO3xdxiOOtlmtx1jHE389OCSP74oWzUNCVBtXO5KhuGu
         eYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385915; x=1742990715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHjoqVYNu/hQnnRhnhN3ZDP1fdRodfuuB9jqsnKQgGY=;
        b=LlFOpXuVEkSYAlWXJmvIzYSGtns1Bvu71nQPVVNtFrsN8N3iPwWpw3oaQ3nH1UwYbH
         DqNlpOPr4SJEfCN15YgsBL3Rid7HrJe8nyXYri5pA5ux7AN+1ANu5LBEJLpz8G5NzEGR
         VcFXvYJ94ZLijamIWHgvZaEmscui+6XX5JIgIp48EfhFLQXhM7YcFNM/GKHKutx96nO8
         TEb+Wan/RSKigF3Z/tWtxLqrKpT5QlhDVahKjpT0tBMmo8KsdN2bQSXoOd8Sj/sQ+3b2
         3H1iJTiQG7Ze9ZPo3Fy9NlXS7Zk8y/9rQcJvm/BWLKEZby8n40+cHL6zjJYRNcA5H9hT
         HUBA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RTdFHKfNShn/d/5545X3n5nqUN7yvJ0LHwfCBKfTzeQO8fTuXVdP5Zve7pCUlRaqpQ0kkCntqgnab3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXInnL+Lr0H6R4rMEvXAw/6oXLfp1Npm/eVz2qyp6sq8OMut8s
	o3Ch0DcJt4tB8oiaEFBe88DCVrXdtCWaiDvsWOZMee6ppM9y2ZwagE4Arurd3FLZoXxjkdI1OtN
	e52h82ic7UJ0Sag==
X-Google-Smtp-Source: AGHT+IFaXPdS8TCkZsZefth+83S/r0xkFDIhe42WgR9A4FWNHKsaSXTQ6ADBjbZgLGd3yEXt0ppyKH9qlJr1n6Q=
X-Received: from wmbbi21.prod.google.com ([2002:a05:600c:3d95:b0:43d:cf6:81b9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3482:b0:43c:efae:a73 with SMTP id 5b1f17b1804b1-43d4378e8d5mr25155485e9.10.1742385915734;
 Wed, 19 Mar 2025 05:05:15 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:05:13 +0000
In-Reply-To: <20250318212940.137577-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318212940.137577-1-dakr@kernel.org>
Message-ID: <Z9qy-UNJjazZZnQw@google.com>
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> changed the definition of pci::Device and discarded the implicitly
> derived Send and Sync traits.
> 
> This isn't required by upstream code yet, and hence did not cause any
> issues. However, it is relied on by upcoming drivers, hence add it back
> in.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I have a question related to this ... does the Driver trait need to
require T: Send?

The change itself LGTM, so:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

