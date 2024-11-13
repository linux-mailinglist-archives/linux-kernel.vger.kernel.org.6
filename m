Return-Path: <linux-kernel+bounces-407159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887829C6981
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E38B25804
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315D17CA1F;
	Wed, 13 Nov 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YY43THN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxOQ1lzC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6214F9FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480712; cv=none; b=Wk2oSpF8xlqN502HdlwRy8iZ4cda18XsmE+NSUW5oIwfIsaK/SIqLB2onJgx2llfzbQtrr9do5CrSfni4ufH17/rv3MKKaYmsoUOBVIojPlxCEzuW67vX3w+26sR/BYqBlbdRHAK+iHmBqB7Z8tLbMqaOC+hV2QX5VTJF/MU8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480712; c=relaxed/simple;
	bh=BjeHUVolng3WC4LjVpOgM0y0IcDOD/uCDFXWlRHEKZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ID70yLh8CnCD27JuGIykhl97Zra8m1WS6VdP0Sbh8ZbBTorDjM4MndmOZfoVbm7h8L0/Z7veAx0K/sWa+o3uYxZY3oxdFWcb5JvIzWlv6j4Fe+nBxsUYu6fSDReVqUbbf2VOAivJtRVdXQbcAXq9xGcfAnMDqeHkBoVuYbiK88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YY43THN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxOQ1lzC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731480709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ds7nLYU6mFEIHej0Le/4lq/BwsbwKA+5f604fNx28XA=;
	b=3YY43THN/zf17pu4/6rOc0IzHJbYHOaawgrHUZv3fLqAL39bOjTPUlGbsguhdW8ZfYsJxJ
	51ze2OXzEFujKkjIvOZIiA+L45XBXe2deYt0WtzUAX+JBkWoC643kVT5Gi6w+qRbLiRdUK
	N4UIswN6Nk0WSQ54H3Xn5RMufDga1uLmlHYZR3yc9++j/bU4djt0NFhiLLcvCnQk4Rkmpp
	G76ujihQAOq+vGm5N4TEZV6jkY+Hv4nv1bAClE/GTHpQP+qph2D1cQI41QwSiBbJDTMqA2
	MPzBeVhYxFoZqFIKws27t/xaP753qidxsFo871Z4S75+mFAa/q3HxcSI1eVIEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731480709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ds7nLYU6mFEIHej0Le/4lq/BwsbwKA+5f604fNx28XA=;
	b=kxOQ1lzCsdeRHYGgyYmnI0s8cZKtKiIBDanpR2/J0PurzDuxWQhV/WqqDDrY7xc1ztNw68
	t93Vc+KcMzsE8dCw==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v2 2/8] powerpc/entry: cleanup syscall entry
In-Reply-To: <A71D1C71E9993C21+20241111031934.1579-4-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <A71D1C71E9993C21+20241111031934.1579-4-luming.yu@shingroup.cn>
Date: Wed, 13 Nov 2024 07:52:04 +0100
Message-ID: <871pzfmxrf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:
> cleanup do_syscall_trace_enter/leave and do_seccomp.

What's the cleanup here? All what this patch does is removing code, but
what replaces that functionality?

The subject line should probably be: "Break syscall entry"

Thanks,

        tglx

