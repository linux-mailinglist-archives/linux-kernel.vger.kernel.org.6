Return-Path: <linux-kernel+bounces-268237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DE942210
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563C0285FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4B18E025;
	Tue, 30 Jul 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O4ECAOJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3118B46E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374109; cv=none; b=IYySXmT6+nqXRb1G/ATHUs13hZ7pr8dAhaVYFGcJ+qeeFlQKOLKiBC1KvaigrL6l/EBOK72xjMdN2Ml5mGmbxaG8ra4HLXhQMh0StwnkOGqwA+FY7CyMNFVuuhcDj1w+BquafhsaRxnIUngwa3aXdhR8vEHZTWhhxVkOLt4/ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374109; c=relaxed/simple;
	bh=KMhxnxs9Pt7h9nrZs/lf3fHMfcJjoqMjNXpHVJ2kK94=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ruGvFYY38bnLg/ZrspNOgKSXYBFGp8/b5/bIoiJCBaVooegq0ZJTi3ALROvYeCJiCpX59xqoWNSsN6b6c3bdL4xSkCpMM6y46x/5/Ld9TLsT5vvo1pD/fWRN1rnunOE6aFPEBEBAqJLgYb/IBPWpccIWuEnTYloxDUTDEsyL7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O4ECAOJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4EDC32782;
	Tue, 30 Jul 2024 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722374109;
	bh=KMhxnxs9Pt7h9nrZs/lf3fHMfcJjoqMjNXpHVJ2kK94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4ECAOJANMtYeu4e1JUrjrHkdEn8xah1KNCMaTQCF8mA97jkbs+IMKnWFQ6GmR4SU
	 FXQ7G6rtU6KoZ5kCqU+EUizgkZ6+GRQW/175FcRmjq2KQoOPxe1L3iv0+AUTM5WlIk
	 GWkyBwYx0QCaxtFPlvPsiP811IxCrXIE4PQUj9iU=
Date: Tue, 30 Jul 2024 14:15:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: urezki@gmail.com, hch@infradead.org, vbabka@suse.cz, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: kvrealloc: disable KASAN when switching to
 vmalloc
Message-Id: <20240730141508.2da2194a2faacfabb6030c18@linux-foundation.org>
In-Reply-To: <20240730185049.6244-2-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
	<20240730185049.6244-2-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 20:49:41 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> Disable KASAN accessibility checks when switching from a kmalloc buffer
> to a vmalloc buffer.

This text tells us "what", which was utterly evident from a cursory
read of the code.

Please tell us the "why".  Completely.

> Fixes: 923a26b4c679 ("mm: kvmalloc: align kvrealloc() with krealloc()")

For those who are following along, this patch in mm-unstable so this
patch will be squished into the above.


