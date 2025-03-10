Return-Path: <linux-kernel+bounces-553891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723CA59046
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3853A33F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8DD225771;
	Mon, 10 Mar 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlrbDqiV"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E0222589
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600246; cv=none; b=UwPAVSfYZTh0/C+0+kZMG4OdTjk56pNHxlNDmtBe1/tCOqjhaDSPAxzkqgL1y+IscyzTuM+QGLXFK3KNxl4JIJNES99Tx8oXlN87FsSl2X/pl+xpx/vJwu3QTUgC7a1EzFZJB4M/2f7btsoXc8Ya2DOdTL7IoAPOCNg7txVgAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600246; c=relaxed/simple;
	bh=TOgB3PbgApKpM9HteeeXMis/Iog1yG/ceAJzbz4WSC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=spj33whs6W3cA+zqTNPwGOPBf9zc4H7JAZwld5t9eKvZm2hbPYiSbqLEHl6215W0ig+Fx3PvAs9Y1ZAumrxCaTAaoJMZPJUvaKnGI7DeHHHioQLJF+9r5VYyMDzfnt/9/fT4dZv7m7VWj4vLaaSnegFWZy3MfeSxgtFXLKF9Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlrbDqiV; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-391345e3aa3so1634673f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741600243; x=1742205043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/nswyrml7wVD0q8mwmURLpx4kqpdNOs0AJ+kP0PTJw=;
        b=vlrbDqiVYW3MmqExT26JT1/9PZ7o+RPBKODTYkC3x3b/9vM9X2d2MWRq2KGZs2aAT/
         Y+RKk4ymLAzJUc9XwU0Bw3P9uT0OMrUeFr+IFMoo9Aish5Ww8hRSi3AASo+6cYnOcAal
         mX1VWM2Os0Q4tx0OuIVRdC7A6vQVrdmJ6oCq2BFFnJywMOSzRMdC+nZ8E3jNs9sXEcmd
         FCaqoD1WDbVwA24Cd/8YouSXkzO8WH8ceEFaBLMjlV/KNjwF5c9mruSplM4lGCbSYzir
         QRkRSHZ0NfN2xnbCIrHeCSqzk2rYlSW1lE9kd9h2YFoivD5egapZaabpJm7gLPnMiCXL
         ERgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600243; x=1742205043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/nswyrml7wVD0q8mwmURLpx4kqpdNOs0AJ+kP0PTJw=;
        b=hElt+Cze15WryJfVQGS+whf0HUK9OwgaF+9rtomJBrZ+m5G+QNYhtsz96Q5iopNBuo
         vCWbIe29ytqggjIgrJHimjvycJXNIVC0awBJHIef8umTsRknQTay1cao2j64M/0mFvmM
         GiWSXsoLQK23VJeIakwIEeavhzqDnX7e1Xt1X3YYWKQaIjKq35N5cWgxXodqhPt6NF6a
         O4gL7s5CSPMIwomo8D2U0E6I7oTu8K6EXLAg3si2EgRUEpRwzs3kQu89HkKH+3ZEOKsO
         K5qOo0eZ7AvJPTNqLiLOYTPxv1t0Qb2TJTUr3NtYUGNywKZryQ0Fgp/4yRS+210HWckD
         8Fxg==
X-Forwarded-Encrypted: i=1; AJvYcCWsJb3U0tnyc0S2gCTPPfox4F7nh8iW1T/Xqo+vpPdcHCD5jNoj6KZ7ZZx/jrMkU2i9/rnrXJgi9q0O69g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhoA6vkLhAnSiLezbkSmFrQCr4hmbs/tCj+iCGj0yenkkfkLy
	4SpKBwWrokefWEXWYki14YQZ7t1vf+xO8vInDH3Y7C4ErobC7CbjTt4ElGcKaexZCLTuy/rnrCM
	eU2L6Do/0y9ynKQ==
X-Google-Smtp-Source: AGHT+IEvw9gbRnYCa4DZNWLBplx0pkmchJgqVCESliNTCd+NA5Dn2Rk7SdB8yqxlQJfnZPEWxsK6Dn9tPfTSqLU=
X-Received: from wrbby18.prod.google.com ([2002:a05:6000:992:b0:391:3790:eb02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5888:0:b0:391:4835:d888 with SMTP id ffacd0b85a97d-3914835d9a6mr2535901f8f.42.1741600242967;
 Mon, 10 Mar 2025 02:50:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:50:41 +0000
In-Reply-To: <20250310-unique-ref-v6-2-1ff53558617e@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me> <20250310-unique-ref-v6-2-1ff53558617e@pm.me>
Message-ID: <Z8618XEgG1yNvppk@google.com>
Subject: Re: [PATCH v6 2/5] rust: make Owned::into_raw() and Owned::from_raw() public
From: Alice Ryhl <aliceryhl@google.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 10, 2025 at 08:49:50AM +0000, Oliver Mangold wrote:
> It might be necessary to be used from some drivers containing C code like,
> e.g. binder. It basically is needed for every implementation of an Ownable
> outside of the kernel crate. Also the examples for OwnableRefCounted need
> it.
> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

I would probably just fold this into the previous patch.

Alice

