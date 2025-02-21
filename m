Return-Path: <linux-kernel+bounces-525063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C3A3EA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AC9421A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FC1D5172;
	Fri, 21 Feb 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfyUmBCf"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F413B787
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102535; cv=none; b=QI/c12oXBFqmMDq8TRAnX2zOoQpLXKwTtTdinnq8QnBJe1cDIVqyU3h4qFcSskp7gp9ShV5VpdCcKgsMKDq62Cr2g7Ew1AdfvMHx/f0PLqfYINFaecvIH9fU1aGlrLnLQw+Qk+Sdm8YirqVSsCcwhRGxa6iOSgEt/SuX3kz2T6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102535; c=relaxed/simple;
	bh=+mH6qsjv0PgMpoMCWn7agHkRQWgo1Ruu1E9D6tZDKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IufWonvdbPM/+o6fwmrKnfeFVQHxw6hw2rMq1KkXuDyctsrGKKisMvGdCrvXMUKKQ/Lg7vomg1B1SQew6wh57HPRnQjloptKrAhjlhIKUL/oEqjSAa4+Fbbo0jLQPnNdwXmKmFIj77E3khnCv5qBDwIXsdwZJvoMGF5jeSK7a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfyUmBCf; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 09:48:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740102521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+euQk0QJrQhZN36BYVigsHr4hALLIbY8ZqkpFyXn1l4=;
	b=UfyUmBCfIQagcIW2UlpUG9jDmNebUMVi3aiPb0LHSybtmEb8QnzOeqxorn5TBWXds4Topg
	o3dQJ875Yx6ZfgsF66+evcb0UmRY8Nb14aWgI1+LCHxlgRP8fYODZhM/Nw6RDHngrXSjCT
	qWyV0BPeSLSfvfySj5r7I3CK8WFzee0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ricardo@marliere.net, viro@zeniv.linux.org.uk, dmantipov@yandex.ru, 
	aleksander.lobakin@intel.com, linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mrpre@163.com, syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v1 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <rqdpj4pdxkiad7amqp7qzsrdtgy3i5beqpz7gsrjy4dwkmwg2x@3bsn7svbawic>
References: <20250218133145.265313-1-jiayuan.chen@linux.dev>
 <20250218133145.265313-2-jiayuan.chen@linux.dev>
 <20250220152703.619bf1c9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152703.619bf1c9@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 03:27:03PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 21:31:44 +0800 Jiayuan Chen wrote:
> > -		*(u8 *)skb_push(skb, 2) = 1;
> > +		*(u16 *)skb_push(skb, 2) = 1;
> 
> This will write the 1 to a different byte now, on big endian machines.
> Probably doesn't matter but I doubt it's intentional?
> -- 
> pw-bot: cr
You are correct that I assigned the value in a way that produces different
data on big-endian and little-endian systems, although it doesn't cause
any issues.
I think it's better to assign it correctly according to the corresponding
header and add more comments to avoid confusion for other developers in
the future.

