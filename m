Return-Path: <linux-kernel+bounces-442397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA129EDC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5315D1889492
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBB1F2C40;
	Wed, 11 Dec 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AEjIPwM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97C17838C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733961078; cv=none; b=Ah6/XHJhw2JtOGH4t7pNx3ABYjj/woixbqgiNNHQrlTiwamYa32QwWWghxEG/LuJgcF7BoAxAvUmoJSwlAgTv4NGEEHOnKRkwxvuVflMtYN5JwAmSXfPt+kYSkfhoMId3eoxPUW3W1h9p8ZL9tk9FUF1rE8kQkYC1u/ZVotCMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733961078; c=relaxed/simple;
	bh=LEiVvkwba7PibnGd+fN2W+b/yEZjiKqI4Lt26cSZGQo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uyXiWkI3BRdZbhlTb+gfuqXyAVGbqqBJcPrzikOLcQ7iDvMmkPEFtBJlXp6hFN3pFdIiPvdu2XJMZa5pnV10TnGmZtVLCscaD6eXpiYyYWcDMbYQWb4liQ3lVzPZ7+NyBain2Xn/9QVr2P+el4oaqpczET3UyS9CqdJhcmgeW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AEjIPwM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D140FC4CED2;
	Wed, 11 Dec 2024 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733961077;
	bh=LEiVvkwba7PibnGd+fN2W+b/yEZjiKqI4Lt26cSZGQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AEjIPwM1Qxg5GFjYQxUGliwrUfTKfAojKUy8vXrh/QyWV8T5HPKO3/yc3/dR7cI0a
	 fkhqDfk2raWzG7K/6Ys2iU3rPUM1pExzsIlCv069GtYPVjEDXQLdeWmAhisDyt24EL
	 RiaNZjeJ/whbM/vkgrlP0S17TgmwQY6SXt4bMRWY=
Date: Wed, 11 Dec 2024 15:51:16 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] zram: factor out ZRAM_HUGE write
Message-Id: <20241211155116.0da80c5143dfd2e133203144@linux-foundation.org>
In-Reply-To: <20241211100638.GA2228457@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
	<20241210105420.1888790-6-senozhatsky@chromium.org>
	<20241211100638.GA2228457@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 19:06:38 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Andrew, please drop this whole series. I'll resend the combined
> series (including zram writeback cond_resched() patch).

Gone.

Probably it's better to include linux-mm on zram patches?

