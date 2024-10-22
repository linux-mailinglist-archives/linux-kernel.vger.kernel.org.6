Return-Path: <linux-kernel+bounces-376375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9D9AB08D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DC11C22348
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6E1A2567;
	Tue, 22 Oct 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="sdAfroUk"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2F1A0BF3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606368; cv=none; b=NGZU0mMEopNuQwpMsqzxb9gdmdBEEdmJOZBUTxim5+aRhCjf/yGNLwQXKOksmjrhXfqaROWQMwOKrOYNOVpDLLMJ6J7RttfhH7EQV21x+BNxoT89i4odbpA7zZHvYHyypD6V1kSYEtrHVVDfNJu9tKpnCoZfjhnecpMLUAzaqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606368; c=relaxed/simple;
	bh=e4NMuosVLVoXUYeYUj1Huc2tRuEwEa4DeJkVYNLMYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxYE4BrUQpvk/C5qMnRXx8ZdiqaFzMKQpn9Zfcqmhe6EPBETE6JJrGXSWzNck8cFEoZcWzPn0mWfqhZPvy5k+iDGgjIS4qLoqjhtnwSaKW6nvu88nT/J+U6cHe4yZ/mHY9o0s7LPqb2i827tw9sCUAE3TCxUDYFX2fB3Z7HoVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=sdAfroUk; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1729606358; bh=e4NMuosVLVoXUYeYUj1Huc2tRuEwEa4DeJkVYNLMYZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdAfroUkGv2sIqEcSl8Yr6liFTbOB8J+o0p5QMnHKF/dOBmgvRpSu4MjErySl8dqX
	 l6N3s/KhbsnJfYkM+KdSZBY+7qw0yYCY7CC53WqbUVIOed38tPb2BfJulfz6vjU1JV
	 sYZT8M5PuJyDHrLzE0/YsFrecE1LLoXbr8cMN8VxFbiZ2svqKVX6pZaE7f3bChUt4E
	 7cil6ot9I46naR6lPkqSkWHNNZRWUl//8GWPPBn9Sdl2hsav1uBrpWcMC8VoGfxmcF
	 aVEaAwWCJJW9ICKRXjjNi9dQw8+17OtOu64gftAzU1kzzJSW/kbuDgVwszLuPNwHEP
	 GUQsUUaUknuCg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 3D2371000E1; Tue, 22 Oct 2024 15:12:38 +0100 (BST)
Date: Tue, 22 Oct 2024 15:12:38 +0100
From: Sean Young <sean@mess.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, andrii@kernel.org, yhs@fb.com,
	linux-kernel@vger.kernel.org, daniel@iogearbox.net
Subject: Re: perf_event_detach_bpf_prog() broken?
Message-ID: <Zxey1hxhnp9_BebL@gofer.mess.org>
References: <20241022111638.GC16066@noisy.programming.kicks-ass.net>
 <ZxewvPQX7bq40PK3@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxewvPQX7bq40PK3@krava>

On Tue, Oct 22, 2024 at 04:03:40PM +0200, Jiri Olsa wrote:
> On Tue, Oct 22, 2024 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > Hi guys,
> > 
> > Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
> > -ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can now
> > return without doing bpf_prog_put() and leaving event->prog set.
> > 
> > This is very 'unexpected' behaviour.
> > 
> > I'm not sure what's sane from the BPF side of things here, but leaving
> > event->prog set is really rather unexpected.
> > 
> > Help?
> 
> IIUC the ENOENT should never happen in perf event context, so not
> sure why we have that check.. also does not seem to be used from
> lirc code, Sean?

You can deattach a lirc program using the bpf syscall with command 
BPF_PROG_DETACH, and if you pass an incorrect (as in, not attached) program,
then this commit ensures you get ENOENT rather than success.


Sean

> perf_event_detach_bpf_prog is called when the event is being freed
> so I think we should always put and clear the event->prog
> 
> jirka

