Return-Path: <linux-kernel+bounces-268245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23567942223
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2313B22D70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09618E025;
	Tue, 30 Jul 2024 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0mBU/RFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD218C914
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374395; cv=none; b=Cp723N79lX5lwEa/+HtzBQkV7W1epHvw5Tb0oyhMY4uBWZhGCzYQK63qnfQGzq2EHzBpsmTmyByup5rWwvCDmL5nihqY1NzShcXrTQ3rEE5ZHFk8RbDB8+/NtPDMBHVRW2hukc7fk6ztLnfsBi1+cbV8+olSRllXgSTf0pywpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374395; c=relaxed/simple;
	bh=VIL8V4Dxo0yjcmnSwRFlMLvzimF70V5iQDwIq7P/EeM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nw56JoQR36LQt2fgUGYrKjkoCTY+aKXCs8p/ikt/QvPc+ga1r1/JtG4GsQ4ryFeWyviVmAhq0EbC+rL0hK6lDqUgjqvjVT5RD+o9rmwgrNlJOlZTOH+QHq8EXD93ky01WmjZWK/7PBhQtHsuni8gqrWwVigF1oMyqoyCbd43rvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0mBU/RFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315E3C4AF0E;
	Tue, 30 Jul 2024 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722374394;
	bh=VIL8V4Dxo0yjcmnSwRFlMLvzimF70V5iQDwIq7P/EeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0mBU/RFJFGrNITFEv4Da4/QOn31OgQpT+2B4njf/V4CIb6q3RXZkXEOG0Oga6uf4I
	 IPmUzKEZ0EF5v6jieCyuEbZSARliOBzQ+v3XPwcbxJAbFbxanJDwTKNReGHAqWrNYO
	 FM/JMa+u0RPQpr3PGoCbcr/5I52Chg8yfzS8tUSw=
Date: Tue, 30 Jul 2024 14:19:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: urezki@gmail.com, hch@infradead.org, vbabka@suse.cz, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: vrealloc: properly document __GFP_ZERO behavior
Message-Id: <20240730141953.a30fa50c0ba060fe0a765730@linux-foundation.org>
In-Reply-To: <20240730185049.6244-4-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
	<20240730185049.6244-4-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 20:49:43 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> Properly document that if __GFP_ZERO logic is requested, callers must
> ensure that, starting with the initial memory allocation, every
> subsequent call to this API for the same memory allocation is flagged
> with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> honored by this API.

I appear to have just seen this, in a separate mailing.

Please, slow down.  We have two months.  Await reviewer feedback, spend
time over those changelogs, value clarity and accuracy and completeness
over hastiness.  The only reason for rushing things is if a patch is
disrupting ongoing testing of the linux-next tree.



