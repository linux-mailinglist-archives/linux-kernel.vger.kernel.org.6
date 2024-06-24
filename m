Return-Path: <linux-kernel+bounces-228001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCF915998
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C305285328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B981A0B10;
	Mon, 24 Jun 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDc6NSO1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAF1A0724
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266891; cv=none; b=fuc0lgAHp3Y6qSFbln2m1srTbSz2fEWL3I7o55YO3Jg4DIAtQUaFSTO2+7DqwnNAoN9fVG+r2d0dJQoZdvKXUbEYo15xTBLyzG7c/Kq7Gc9sI98YN0dmJ5W1n+f/ARBGyqBaqBM/ASRupRjiOMzSWJum2c+x0sRDDwG4/tgbUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266891; c=relaxed/simple;
	bh=Hq9do1H3ZbS1nGGNaTjnNZGWZHsnBLFylaiBn05T7jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtKtiugqhG8F6diIksWU9oJHT0cSH9kuesClzUvb9B2gMnUvvuc6FnCCUk/Url2KmKNeoCWd5xG7z06LSztlIioQXcbmC88CPcNsk1jjWGhD8EbueGuK1bWQeeHqx+6HJo9nC09eVnCXwKoFHBkNkknXTRNjhU9e9SODMftwPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDc6NSO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831D4C32789;
	Mon, 24 Jun 2024 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719266890;
	bh=Hq9do1H3ZbS1nGGNaTjnNZGWZHsnBLFylaiBn05T7jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDc6NSO1eUd6JWQTE3fI6/8mf4VLfqT/zNXt/IhmSfCAeCri/CRQwgd3xeOy3fOQ7
	 WG9kxWK+Ynv2/y2xuy6K8lEUAUr/6nELoigtcqEiOpKpYLBPi0k5pG5OLufWzRCQVd
	 SvYi5HQKJop8tDPlQR3rAU3c7qmcb432XMVi3QmIGyfkEQLN+j/DoSI5eE7/PUNGKr
	 8QpG7bmFDuendEXSkiPJGM26TIcwJxN92M0mk67oQxspQSw8j+huB1xaE37ol4NPjQ
	 fQQto/7hz9Xw70PE0HbjixYV0KV3QGzAxopAKYIvKi1rhXLJs3l9CgnUctHABK7uM6
	 OPGxUPi7qdBLg==
Date: Tue, 25 Jun 2024 00:08:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] timer_migration: Spare write when nothing changed
Message-ID: <ZnnuR8Qp7HeOrSC7@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-5-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624-tmigr-fixes-v2-5-3eb4c0604790@linutronix.de>

Le Mon, Jun 24, 2024 at 04:53:57PM +0200, Anna-Maria Behnsen a écrit :
> The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
> there was no new next timer expiry that needs to be propagated, then the
> value that was read before is written. This is not required.
> 
> Move write to the place where wakeup value could have changed.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

