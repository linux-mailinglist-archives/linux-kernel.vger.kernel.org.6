Return-Path: <linux-kernel+bounces-446844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E59F29E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB416695D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D911CC89D;
	Mon, 16 Dec 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nm4m9ZtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A61BC064
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329416; cv=none; b=b2sVheyDja/XrkiDmBQ1tj543U6C3EUbp8cc7UjeQAKlBwNGjjErrfn6IeY9KabdEkW98NO6znRHn28yRbe/lrsHkqauYVnKBhFMplRweURJLqirQVH5lDoCSTl7JzJdUJLphQwOblzcsRd2i8UaMGitfKRhTNLUMhlkhcs8sCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329416; c=relaxed/simple;
	bh=1gZQIqyiwWcONrLVtGI2TjmmbY9fCtHnq0EGsLdNpGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kdSVleV+rjoCsvJ6bJi1W5hFPgvMCIuuZQce4eNxWqM5tf85oWVRDOcpB46J/SoyG5KZ6yKaZifN+Kcjh6/NKw3TRJn/RnvRFmVseEEqjNrgFRBwiaMBWGh//lKzUdZDNGxL4Su84rZgysyY8m7fewGbLyQcRgk/WZWcxIwtXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nm4m9ZtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1EDC4CED0;
	Mon, 16 Dec 2024 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734329416;
	bh=1gZQIqyiwWcONrLVtGI2TjmmbY9fCtHnq0EGsLdNpGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nm4m9ZtNNzNVzf1kokB7yNbzF9UVHGgEglk4/GB85xNC97ILhtOua7pOLcfaAq4fW
	 Weg8dcT51Aw9QvSTkZlwTT0WZh/h79+rLKSNtETpTAfHJKn36pwk5bxOo9lFxSwQ+e
	 QqxgpKovMCYiFB9m3LrmJ/ZWXsdZeeU8wRk+qBkg=
Date: Sun, 15 Dec 2024 22:10:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Yu Zhao <yuzhao@google.com>, peterz@infradead.org, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
Message-Id: <20241215221015.a567dbf38c9a98d672aecd3e@linux-foundation.org>
In-Reply-To: <18bc52f4-ab02-495f-8f8f-87f69ea5b914@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
	<1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
	<CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
	<18bc52f4-ab02-495f-8f8f-87f69ea5b914@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 14:29:38 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> > 
> > Acked-by: Yu Zhao <yuzhao@google.com>
> 
> Thanks! Once the review of this patch series is completed, we can simply
> drop "mm: pgtable: make ptlock be freed by RCU" from mm tree.

Can we drop it now and does the remainder of the series "synchronously
scan and reclaim empty user PTE pages v4" remain valid and useful?


