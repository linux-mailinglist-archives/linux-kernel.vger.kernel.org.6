Return-Path: <linux-kernel+bounces-568057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A996A68D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10DE17BAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A12561D8;
	Wed, 19 Mar 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/3AuL+A"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997D23AD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390217; cv=none; b=hzpe2iwi06T8TdWTDgmP70AJvzM/3zbgb32j9aJT8DzhLlAKHHrJGeTugGueQxNn9iGWLUEz94whHrP6YCNjhTBnm1d7CIotzOMR2ZyvcmRzR1HSCm1eWtdNt0whLxh+rm5nQOk8K2/aZZgadYxZOGo/JtFBe3kn3IvuufXMgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390217; c=relaxed/simple;
	bh=mIhnMEW5yuowNnYq0bWTeTVMLPHGSgJ9laVnEiA4/2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpQf2Yk95FEmFC0U99XhDaJ0BUrwEkm6aqPwKyxD2L8bT2nc4Zo0xl3oPlbDrrIHLGqHV1f97u+tS36GOPKlotwzElJbLCE96iX/2HlqnQ1wqXjSWR1UnW3ZwoS60aIZ2iTiF16oC1XP1HNnx0yKR6OVJzmYwBOcsVtGW3ThCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/3AuL+A; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so28514055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742390214; x=1742995014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZFXJ7cV5lp42vCux/Cd6AXi3tX+zZrjbpR69QN/IgA=;
        b=M/3AuL+AiVAWgICHx0fgUYkO1v3QJn/Pi+/Y1zuffvOTfHNGbkjmDDfabU0+KwL80p
         lQ4H9CkO+VaWca7hqRraH5O1FfkF9+cZ/1GT0W3+7xjS0qnQJh0EEaCXmhlrG2y6Hlr1
         K7kqhDpSnlN5nZbd5FSLAyTE3GNImnGGl1UgI4zDRxiiBIv6EYic1au8jl2Y4RG8AigK
         XUHibrDGu0peBb35v0wfGSRHFDhRENMFd6od2EvdLmAgi7KPJGHEeBQHo6Cl7krzkkbf
         8Bvf2Y9k9Vjj3D9UliDLSVNvH0jc2vvDMyYC3zCGfJAnXIviO7yS+jtG6r1XJrG7/GOv
         mJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390214; x=1742995014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZFXJ7cV5lp42vCux/Cd6AXi3tX+zZrjbpR69QN/IgA=;
        b=qsnwYSlNVIzlqEAFB9Xq0KpunR21pOkTiufUvSQbs3ZZCQA4fXoV0YdB+x5nZU71Xf
         LEvszAAlWjAClFDCiTQ4xo8NozhfIYNrq/zSE0iOEZ0AYUrylfit7YLL5hPToit//Tnw
         HeAXFJ3yzB7WE+CtNLMTgm+qaLO35CbFQbzurpqP74/T7LWqH6TKuzbXjs0Soe/JKC8S
         G5Dd6VyDbo/sX3cYTnpgM9+6mTsFVj7mSSmXAwCBuYqQxDSIyqTWZUuQVrSo3mXKq2vm
         C74Owm9FybIU/IECEznm0vlmjjOQdGtVD+XXMeVRvifpK3eVEBy7yNH1NiEAlm8a29Wv
         bm3A==
X-Forwarded-Encrypted: i=1; AJvYcCWggXwBJdh2jobmjSwFz7HUFSV78hGhIveWG02ARc1kfPrY3Eo7kNSZIQVFdRlGP/WSrTcwU9QJ1pnTO1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFVDS6s9tXOdfvm8vMtFbO4gW1RQZR2QbpICMGJ+Q88AnfuTk
	MVCq3JYc+7V7ajtwIA2DUEYpBySF1Tta8GukOgII4hIpEqgTU1C6tkcW0DrdkCKOrblrr9DltrV
	xpizcKlXmLAo6vA==
X-Google-Smtp-Source: AGHT+IGQ0tlk++4uoFRIvqDYa5fnv7Q7EnYkzjyoAXFfXjg3CJAiWVBpRU+wF6+JxkvPFHSROMZ8hlh0rLPLYIo=
X-Received: from wmbay3.prod.google.com ([2002:a05:600c:1e03:b0:43c:f5f7:f76a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c23:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d43798dd6mr20385345e9.13.1742390213917;
 Wed, 19 Mar 2025 06:16:53 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:16:52 +0000
In-Reply-To: <Z9q8xcsAYhQjIpe4@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318212940.137577-1-dakr@kernel.org> <Z9qy-UNJjazZZnQw@google.com>
 <Z9q8xcsAYhQjIpe4@cassiopeiae>
Message-ID: <Z9rDxOJ2V2bPjj5i@google.com>
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 01:47:01PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> > On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > > changed the definition of pci::Device and discarded the implicitly
> > > derived Send and Sync traits.
> > > 
> > > This isn't required by upstream code yet, and hence did not cause any
> > > issues. However, it is relied on by upcoming drivers, hence add it back
> > > in.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > 
> > I have a question related to this ... does the Driver trait need to
> > require T: Send?
> 
> The driver trait does not have a generic, it doesn't need one. But I think I
> still get what you're asking.

Right I mean, should it be:

trait Driver: Send + Sync { 
    ...
}

> The driver trait never owns a shared reference of the device, it only ever gives
> out a reference that the driver core guarantees to be valid.
> 
> > The change itself LGTM, so:
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > 
> > Alice

