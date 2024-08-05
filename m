Return-Path: <linux-kernel+bounces-274767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA36947C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252DD1C21CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90D7710C;
	Mon,  5 Aug 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbEtLJk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="80Abcjvv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D517C64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866649; cv=none; b=AE8Pn+Qi70WUPzms9JP1WKc7Q3mU8Ermud45s3DHM/uSrQvhvF4cHFwZz5ZC12bz/DqNrQZOs7F46GuPhVFV+kESVEpNsR6L1KZgzjTTAWcWPsqwpsB4XQnoxXBETg+Oa1pbC8Y8k6A71+L+2mLHeRlcFMkbLo+fCkSF7K4I8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866649; c=relaxed/simple;
	bh=ePrYVua1laCXGq4q1i55+CJ/wEtVyVmdDDCTUUvBoNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLmDEw/0ixtV1gLB+PpW0rdzXW5iQAG2YBhaqkEX2twI1vprQCcj/oLID4J+Lb/7ahJtiPL6ay79bHQJYZKgBcc9uoeUC6BYWOkbOw7RKKLHvdrqsYddhnmtsjsrwPlBYYtrtrxtAgu+HEerV3MoCtH9ZzJawoOOyRz7+1nmc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbEtLJk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=80Abcjvv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722866646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rrD1a6v/oagmS+NjDszo30GG9Ofc4604WyXXoz1FYo=;
	b=ZbEtLJk27Q0VsMq2pulY3u8Oj2kgRocn46wEM+V/jqSF2bdV0iOeUD+M5dURoyiZ+UJbgH
	7E7YhDaWyYdbmrJ+A+iNaeC96rKzTz99Oq2crbGgsDqB4b+FwojnyNoucmwC/2n0ecqtXP
	LlxOe7LjgBnwoqURsZ4vFkdpSdQ8NKSQvgVySMOmn+G+b/0xk3xhSM1AFYxuCd4hDE39Z/
	RFhLw6FXRF/Q7u70BIjLPP6mYVkaxZrG728DlXtJMmq/PMcR3dZ92sPYbrzPH7KeDliG4i
	gSWh1WvKIJvfzYvServgYf3ZjfepSHPqgWh+YAt27vtKBYsIE4WyVce3bGlZ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722866646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rrD1a6v/oagmS+NjDszo30GG9Ofc4604WyXXoz1FYo=;
	b=80AbcjvvqKtSbewvDxKlCp5TjBGEi5OHwEI/+EmRnd4jFaM3SuE5JnRwhAU23XkrFyUzI9
	ko0St55ijthcI7Cw==
To: takakura@valinux.co.jp, pmladek@suse.com, rostedt@goodmis.org,
 senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
 lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
 feng.tang@intel.com, j.granados@samsung.com, stephen.s.brennan@oracle.com
Cc: linux-kernel@vger.kernel.org, nishimura@valinux.co.jp,
 taka@valinux.co.jp, Ryo Takakura <takakura@valinux.co.jp>
Subject: Re: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
In-Reply-To: <20240803081230.223512-1-takakura@valinux.co.jp>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
 <20240803081230.223512-1-takakura@valinux.co.jp>
Date: Mon, 05 Aug 2024 16:10:05 +0206
Message-ID: <87v80f2hii.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-03, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
>
> After panic, non-panicked CPU's has been unable to flush ringbuffer 
> while they can still write into it. This can affect CPU backtrace 
> triggered in panic only able to write into ringbuffer incapable of 
> flushing them.

Right now, they cannot write to it. If you apply your second patch
before this one, then the above statement is true.

Perhaps the ordering of the two patches should be reversed?

Either way, for the series:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

