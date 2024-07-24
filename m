Return-Path: <linux-kernel+bounces-261470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D793B7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410A71F24F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CE16C6A5;
	Wed, 24 Jul 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R9A/sF18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EB1514F6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850916; cv=none; b=JZ6woH21nc9EsazH62WhwBe8tbr4U1bAcbQNJ5fm8/AX0AJTkHVkAdJON6LjdzdXv8UQJR94LYdEVWs3Nm5Ztezo+Met24Uya8YEGf1elHt3muWz0juF0tWuU3gVfc+4dtZEwmiBGi130G+77Y3FirX4ekyZcqPPSCq0y1tpesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850916; c=relaxed/simple;
	bh=AeVzJzfx+eqp71s07hx1jErZV8mnRMLNVTYjy+2tzHw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uaFMFPJ7KEc1wrgOgZKd44jf5f279lGXMde4NZmPd6ib6IKmfXBg32Io8o0f1BARiVgo2Ry8yCwB193nx4PTTrnDfiTIcEFVkEwJPI8QxCP07NVNxu5Qu2Xhk4fVhMgsHIcMtx7lBio+LPxxin3JE6kgYM3ibzB3qIQjABG96wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R9A/sF18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D08C32781;
	Wed, 24 Jul 2024 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721850916;
	bh=AeVzJzfx+eqp71s07hx1jErZV8mnRMLNVTYjy+2tzHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9A/sF18DTCPJ4RAxck0P2jBF3EHcUCnPS48jGsrt+Lxk3Vv3jr+UfFa4ZOvlAF7n
	 kamu2/sB5eIR3AFtSDlsgCO27sBZRf4+v62gqUt4kkfim28GQ5lIaIF3btVcGIBs68
	 XFLhAs7OblhQwxoqUUrQA78vRwV21Hi7WKYTUeqc=
Date: Wed, 24 Jul 2024 12:55:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH v10] mm: shrink skip folio mapped by an exiting process
Message-Id: <20240724125515.6cc3bd8479ea8bcdedaa7eff@linux-foundation.org>
In-Reply-To: <20240710083641.546-1-justinjiang@vivo.com>
References: <20240710083641.546-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 16:36:41 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> The releasing process of the non-shared anonymous folio mapped solely by
> an exiting process may go through two flows: 1) the anonymous folio is
> firstly is swaped-out into swapspace and transformed into a swp_entry
> in shrink_folio_list; 2) then the swp_entry is released in the process
> exiting flow. This will result in the high cpu load of releasing a
> non-shared anonymous folio mapped solely by an exiting process.
> 
> When the low system memory and the exiting process exist at the same
> time, it will be likely to happen, because the non-shared anonymous
> folio mapped solely by an exiting process may be reclaimed by
> shrink_folio_list.
> 
> This patch is that shrink skips the non-shared anonymous folio solely
> mapped by an exting process and this folio is only released directly in
> the process exiting flow, which will save swap-out time and alleviate
> the load of the process exiting. 

Has any testing been performed to demonstrate any benefit?  If so, what
were the results?

