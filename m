Return-Path: <linux-kernel+bounces-570461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F3A6B096
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0233A1899126
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B233229B2C;
	Thu, 20 Mar 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dgsqi3U0"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4015D5B6;
	Thu, 20 Mar 2025 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509044; cv=none; b=g5zkIK4EFyXhhS4uEtggHnmIv7paQ1kTekLABwUtx0+4uiQaxvjUBvA0O/znVM9VuiDkSUmGIjomRCZDDyxSfPDcbgVTGTwO8BnbuiTwQFrFSohrEseqTexuOZpqVJMuPSL0vzfmxKGkUvb7Ec10CpqPPyN/9YnexCHN0ABcE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509044; c=relaxed/simple;
	bh=xFlc6Q6TzfQb0wCt8sKQnHij0eKpqLd8jx0a8TNgiwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLjelvFJRNX10iOmMQwh913X3mjEQ4usSDVwfi9stCuWIB1wiUtF4BQJIX1Uhr9RGzSNAk2FoH2C9TwjErKi+apr10iFvxhHLTYpDMEf8x2O8U2XV+eeWH2lkV1fbh0ue5/uTKZAQoL78viqhPkTeiU39nExK/50A0JRpP/AWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dgsqi3U0; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742509034; x=1742768234;
	bh=UIuScVKVgPXJsm/Noly02l3epcZR+EAf8OYgOgJU3IE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=dgsqi3U0Qcm1zneJzI3+tlfm/GxVyVh4sA88fMDuAkWJtZdeAjKaD7Kt8BTJKWFC2
	 Pg0YFdT70aMr3EvzHQKUPUhB2uoVrJaYf6Kr6K993WEICJPXxoD4J4bmbhgcM/OVRl
	 mm2zWmtCem41qVX4S6xBRw6XKjETi77zDq7ndQWOVtwJoXYJ573W+kimPZf0rXeJDT
	 5TE1cZoHTjZ/24GEpSpGO18hoQXQC90zf+O/nT6TTCCblMjIpU9BLyXADM5kj6VvDB
	 CZQn/+Mjfs2uP+59EU6ghjs+IbZTU4Sl7TJmZRP4GVILcjPN8+dRteK3cJyTna2g83
	 N8N8nV6Id2//Q==
Date: Thu, 20 Mar 2025 22:17:10 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: alloc: add Vec::push_within_capacity
Message-ID: <D8LFWBYIFHSP.ZR8DMPGGM9SE@proton.me>
In-Reply-To: <20250320-vec-methods-v1-3-7dff5cf25fe8@google.com>
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com> <20250320-vec-methods-v1-3-7dff5cf25fe8@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 05417ab6c002c265e99ee01e8fae7d84f5937dca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
> This introduces a new method called `push_within_capacity` for appending
> to a vector without attempting to allocate if the capacity is full. Rust
> Binder will use this in various places to safely push to a vector while
> holding a spinlock.
>
> The existing Vec::push method is reimplemented in terms of the new
> method.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)


