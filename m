Return-Path: <linux-kernel+bounces-531778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1474A444C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484AD17A624
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67954140E3C;
	Tue, 25 Feb 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CWgPECr+"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32F14A627;
	Tue, 25 Feb 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498151; cv=none; b=hJjcLGnm/TAZ/aXDXTB0hjvXChmM7vTR7X/XNnLzs2/f6k0faP2asPSOVu/KiBjUOb29urhGVEmgG+yV0jMbqwOyWwRIpKNgCncgcxOdzdgzZ6Dy5/pMq2dSqZ93OGip77BybE9hEhjFJ94FOEL00StGZxh9vwnZFhTgml/oHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498151; c=relaxed/simple;
	bh=onozFvlgtS5C+M6OWjVfwwdRmRVuXkGoh6ZZnb4TH2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KpTqUGchbQKh0PV1R+hVAfmyDDA18kl8ed2jgX4NfJWK9uj+RCZsaWc5Fpk7+XtO72gGCFQ4g4zKZdbN5kabo1JLwRnwQdnMxXphD9Q8QV87Zl6nPTaXUXzh81FRraaK8JSF9OVVJwc7y/941KAGdhDwSElZJiLujZ9A303zTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CWgPECr+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PFgKn21329958
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 07:42:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PFgKn21329958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740498142;
	bh=onozFvlgtS5C+M6OWjVfwwdRmRVuXkGoh6ZZnb4TH2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CWgPECr+v+nsYievNAxJAMrXPU4mLjMa86deAsHfSC3+8r9qPOzR65khmAC9IbehW
	 S/eZuKfQ1CEWbEGusk1ZMlyx9Aq2zSem1mj+4ulqu0j5WwOwtBPK4F1ffOkSAuTyLz
	 oH0nRCfPDX8b5Bb8nHIay1D4JQ4orpROHTwttPjwKUJ2oMg9KYQTDCoGP6hJYIYYkF
	 VvUOIn8stbZ5Hgxb3iwzAYkQgrr+tEOLhjYxLmCJwB8+zgTYfTN1JjAG4ZduoCd9cV
	 Jbk4HUb4PZ0haelG1nyyaZvfzW04nOyA+dSD9Y1sbq+SbXgSMJccJtLeXJtdBPvFWZ
	 ELKqjUDzy7Q6w==
Date: Tue, 25 Feb 2025 07:42:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ventura Jack <venturajack85@gmail.com>, torvalds@linux-foundation.org
CC: airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
        ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFJgqgRZ1w0ONj2wbcczx2=boXYHoLOd=-ke7tHGBAcifSfPUw@mail.gmail.com>
References: <CAFJgqgRZ1w0ONj2wbcczx2=boXYHoLOd=-ke7tHGBAcifSfPUw@mail.gmail.com>
Message-ID: <9610C397-39C8-479B-A727-1091BB8548C9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 22, 2025 2:03:48 AM PST, Ventura Jack <venturajack85@gmail=2Eco=
m> wrote:
>>Gcc used to initialize it all, but as of gcc-15 it apparently says
>>"Oh, the standard allows this crazy behavior, so we'll do it by
>default"=2E
>>
>>Yeah=2E People love to talk about "safe C", but compiler people have
>>actively tried to make C unsafer for decades=2E The C standards
>>committee has been complicit=2E I've ranted about the crazy C alias
>>rules before=2E
>
>Unsafe Rust actually has way stricter rules for aliasing than C=2E For yo=
u
>and others who don't like C's aliasing, it may be best to avoid unsafe Ru=
st=2E

From=20what I was reading in this tree, Rust doesn't actually have any rules=
 at all?!

