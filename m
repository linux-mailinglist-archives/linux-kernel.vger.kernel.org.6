Return-Path: <linux-kernel+bounces-197736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3D8D6E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304C71C244EF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBF134A8;
	Sat,  1 Jun 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KqERcdEB"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5617BA6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224386; cv=none; b=CSEu3UG6vnOogHyCp665BZafRxkqSb7LNdtzCs6QJwOP0EzXPwRuf/6VJG6lw/fjVWO6ReyA5O6idqbNW5XhK/aWSOBILLYjLSGPPpSiMdhnBslNwU0Fxq67azWvQeMdnFSrhzFakACxeRqaYn8VMDs2+w+alr2fxWBB3dMUpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224386; c=relaxed/simple;
	bh=a5vEx8H9gKBkP4vqlI6DX6bXvkItra2KeiKX6S1Ptts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsP6iJnbE0tTO+Ul7eTm9sEYqljZ7W4R4OBvR7orbYujiYB3rsfyPxxEa37jSy40KcI4aX+m/HjZs3D84a6BQM50nfdI53rHDTte8nE6RbKBw0m7i5jNfbGfuRdEvi5cH6WR5Hhz6/349/3kmssdM0NQIz8K2Dqrtswpc6s/REk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KqERcdEB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ySwpCnt7wUuO1AkcBnXhj9eO8K9+LufLqvIrUfOCjI=;
	b=KqERcdEBoW0ie2hl3+prl3NuhNExML8IuARBdsdYGnCrXoEeAaOJHcrzON/H1skszEODH8
	V/VyosqwH/dN9hpDYuKr4WNy6tZ+YTMuch+kSC4kc1AYj6VgB3KzRitzQP+Vm1BjjIpd3z
	KS6QZ/oo932V7/p4fxLolixoWNJoYl4=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:46:15 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/14] mm: memcg: rename memcg_check_events()
Message-ID: <xjfakt3rtxufidb2kizrcgeavmntkdupmrdj5agw4asd6jzs7y@yu4eu3rtnzrw>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-8-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:20:59PM GMT, Roman Gushchin wrote:
> Rename memcg_check_events() into memcg1_check_events() for
> consistency with other cgroup v1-specific functions.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

