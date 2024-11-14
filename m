Return-Path: <linux-kernel+bounces-408639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51E9C8162
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A628199C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E771F26DB;
	Thu, 14 Nov 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo2zZh1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCC1F12F3;
	Thu, 14 Nov 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553825; cv=none; b=A6Mr/SxIV9LPZjt+WJ40Y+kTrWFywoHZGQP0kG4GCybydB4q6f9hJ6aI+f9XZTOf1pZCJJRCa3/OAXxMAbU6dkTjPJpDEWwqSL9298I4RQ646VsGLl956hE8YNKyE34T4a3Y3Dakbl1ZJ509eaFri+d8/3nKuhEuj00FwQU9enA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553825; c=relaxed/simple;
	bh=8LBZhTyUmqbp4I0278vs9a/olUqdNWfuPwRflqnmJfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaH5+w9PsGIc7AlbzTOLAiFwZ8/J7t549MvlnAQEY6SWyqLQ2nZj6gOcxmpyKWSG4d5HrIIhsDv2/QhxhaU5n1EJbChlkI/K3u6qH+4kDzhxZuZulFsHg99skRxBJCjg/kvj+yKnzTjBZODDm6uMdwdluKgxNi7GuByfo/jOmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo2zZh1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEF3C4CED5;
	Thu, 14 Nov 2024 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553825;
	bh=8LBZhTyUmqbp4I0278vs9a/olUqdNWfuPwRflqnmJfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qo2zZh1+IdFKI2JY6dhamMPROx6Ib4CTTNAH80Cdh2kGL0rJWq0KoTXMJjqWUfqvj
	 gtBjhE/aWc8nckVdzmHqzTSIv8Sggo/Yxrw7yTd3EhjaCgThc0z78wNqWFh47up5p+
	 o0gmcsaIe+ehxFI7SFUpj30KN49L9H9QA6xrZmHTN2YyU05Ccfih7hMzxULR0y7rmS
	 uFxikSCJzeB8PVfT1G53zyiAoiaJ/4N6ebugNOKQ4R0XI9Sg06iyvCG+tkbO285/Sz
	 ownZx4iM+SOBYmL5QWXQiaCzwWCKSe8rAXpkjoFZ93Ejfrt3EZweLfAvNSD1OwPibS
	 uW3LJthzyatXQ==
Date: Wed, 13 Nov 2024 19:10:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241113191023.401fad6b@kernel.org>
In-Reply-To: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Nov 2024 06:08:36 -0800 Breno Leitao wrote:
> Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> following code flow, the RCU read lock is not held, causing the
> following error when `RCU_PROVE` is not held. The same problem might
> show up in the IPv6 code path.

good start, I hope someone can fix the gazillion warnings the CI 
is hitting on the table accesses :)

