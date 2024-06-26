Return-Path: <linux-kernel+bounces-231397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6191983F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176A21F22C69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B2191473;
	Wed, 26 Jun 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wV0z22DX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2A15B7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429897; cv=none; b=Pa7o8QwEAIZI2/FvsqYqV5AEUCth8xu+z8daPp5h3BYvANLin4FJP0RnQ+e1OS9tO1ECbct7Su3MGr3Nw3jPCvNFhhrMhSVTWTQrQJJELE59ojFSVaIad4aQGh5VDc5oO4A1oqMhjEc4qvJT/pP0FUr6UqHndZG+/QyVT+JYbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429897; c=relaxed/simple;
	bh=L9zv1zyg6ZWXDVeXJlJkvdGhYyFdYxzY1zw9yYHh1Uc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P9u2hPrHi9w23aXlaj0n6i3eSkxod+wjdA+eCu+a0IJ9qPX/2DA1S8K54sxwj0nbhXfOQmaX6HJn7jZtoF++u+VteJREExLCWpF+5LYcOk76boImXeCkrQr9rfGqhf33xSfjSafuqkTPztxgMQ/fetKZZUZmGKYl7bJjJUSn28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wV0z22DX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D86FC116B1;
	Wed, 26 Jun 2024 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719429896;
	bh=L9zv1zyg6ZWXDVeXJlJkvdGhYyFdYxzY1zw9yYHh1Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wV0z22DXSxzOeOhpjs7JU2h0sNhs3+EaJG7CkjUmKgK+xNzbvC9WNthGXlAPitnho
	 YWnqSP43zyoSfIDzMLIIejcFbjF6BfX1kpVIqv6ctYYXK8QyKRRcTSxL+lFnDT9Khu
	 WYUEOoNpI2yqF4p1IZ1jZ2pu+ytWAVnw3JWp7GlI=
Date: Wed, 26 Jun 2024 12:24:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Christian Brauner <brauner@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <axboe@kernel.dk>,
 Jinliang Zheng <alexjlzheng@tencent.com>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Tycho Andersen
 <tandersen@netflix.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/2] memcg: deuglify mm_update_next_owner()
Message-Id: <20240626122456.a9eb021e4ccbfbb1b6b93d1c@linux-foundation.org>
In-Reply-To: <20240626152835.GA17910@redhat.com>
References: <20240626152835.GA17910@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 17:28:35 +0200 Oleg Nesterov <oleg@redhat.com> wrote:

> On top of mm-optimize-the-redundant-loop-of-mm_update_owner_next.patch

What should we do with
mm-optimize-the-redundant-loop-of-mm_update_owner_next.patch?  It
prevents a hard lockup splat so I'm inclined to merge it into 6.10-rcX
and cc:stable.  Further improvements (this series) can be made in the
normal fashion?


