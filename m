Return-Path: <linux-kernel+bounces-525887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A321FA3F6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B52A17B09C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB3320E02F;
	Fri, 21 Feb 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHpHljQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7474433DE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147030; cv=none; b=aCcmdejvZ3yPQH/rTwIkMrEc+zxFCnXQB6Drv2OiSRiUxmzl1XrbthRjZ6bwdqVP1tP+G0soHmbKtK1369sftOS0/QiNfdYP+5l1WebO7O5GAbRX0SUQhhkLYQn+SJZ/VZsjlmbCQCSS4krynGKJG5sDw7VqxjSYc+CxHJ3wswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147030; c=relaxed/simple;
	bh=XIr7sUZNgQWUPYLD5rKG0ERPa+X60vn/t8Qu8B3gRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ijz9vvhkP0eWegnFbUTaBFaumGcEP0qqOHJ3JlEaB0CBbi+3ZqscQNz4hVJfS3JFLBNt3tTbXllgV8W8BUS/TWataeI9Ob/CcEZfY5pZxhrJZYPimBkO1VLnQwXSIqL3eAazPCysiYT9bPr7jlHu2eTNiERSG+yHAIiAUYASy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHpHljQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DF3C4CED6;
	Fri, 21 Feb 2025 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740147030;
	bh=XIr7sUZNgQWUPYLD5rKG0ERPa+X60vn/t8Qu8B3gRD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHpHljQ3HoOUInKWPA0d8BesxznRu+5er1aR7OlaVBIrxoF+yhOHFBhJLcAVSIaID
	 VLtVM9bxk/wYTxJMBJL99yC4oiYnaSLUfQVMwOf6ypCBBR5Rv9mKlvbXOwAN4VKz3c
	 wu+qhJgVcynbSyGMEnjV6vuK9jccuSUXFDL9jenhxCJ3h1hB8SEzh2N+UQXZ3q1BHa
	 snk6UD4muwKIdrHxwCAuzFAvANpnDdKjfUFcSxh+eAX78kSUgVNo4/eprkB56r5oxj
	 2aKsQryDivLH7uWt6Dyo33qKhjLSe69eUVREOteoBW0RBp1kg67qUFy2v7m6R2WkHA
	 dXfldvpfVsKnA==
Date: Fri, 21 Feb 2025 15:10:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: mathieu.desnoyers@efficios.com, peterz@infradead.org,
	boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	aruna.ramakrishna@oracle.com, elver@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pkeys: add API to switch to permissive pkey
 register
Message-ID: <Z7iJSyQYmtAl_z24@gmail.com>
References: <cover.1739864467.git.dvyukov@google.com>
 <9f33eaaea6fed2948502eff27c4627921d1e1e78.1739864467.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f33eaaea6fed2948502eff27c4627921d1e1e78.1739864467.git.dvyukov@google.com>


* Dmitry Vyukov <dvyukov@google.com> wrote:

> The API allows to switch to permissive pkey register that allows accesses
> to all PKEYs. This functionality is already used in x86 signal delivery,
> and will be needed for rseq.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org

So why did not add the Reviewed-by tag by Mathieu, while you 
incorporated his review feedback:

> Changes in v2:
>  - Fixed typo in commit description

?

Thanks,

	Ingo

