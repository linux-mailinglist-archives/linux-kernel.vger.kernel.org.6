Return-Path: <linux-kernel+bounces-404924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAE9C4A60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5982E28586C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFC33F9;
	Tue, 12 Nov 2024 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OiGEnLzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CA29A0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370021; cv=none; b=Err1xtoxpSEi9n7snF648D8ELsuMYtT/NElajRiRi6Y2XWdjZAMAoPvGELV3VmXZaLpzbkyeeTzApvrCsmNQ9fbgWMIvgzdGwKDja4XgAsLNhKllNiti3IWytfWDsTgiywQjceSpRUAKVfL6l5mCRakd9pYxJP0RW0L30B2PZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370021; c=relaxed/simple;
	bh=/ypcXFwtKmo17Sx1Km2s3tTzbVymXGdWnQLK7WP6Kmg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aIwSdIsS+7vnHD96qRz/C8VzqNeL9ASQJJEsavYW8nxSagC59AhrbB6RWtTmMidgnZtivznqKusJCz0pObuUu21Ti0yZsvOsB10Iva2gFtZsnnL5vZWfVl0M7yCXzN4ljRA6eqighxp7QYRwqBQeHf8f3qZcHVWlnBcODXjzDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OiGEnLzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61170C4CECF;
	Tue, 12 Nov 2024 00:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731370021;
	bh=/ypcXFwtKmo17Sx1Km2s3tTzbVymXGdWnQLK7WP6Kmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OiGEnLzuR+ZftpS5iq7PGeEzMH+qhU/I0cdXPuhZFANCbeaVwt9HumqRck96FtZnp
	 IlLjT5A2VDu3Ay8GngDn5CIM7I9hKA9iKInv26m/GMK3S5/93AxOkotPg6UtyffdhL
	 ZiqRw3kUS7bU0py/A9TThF7ON8jODpMXnX0eEBlY=
Date: Mon, 11 Nov 2024 16:06:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-Id: <20241111160659.14227aaa3481648df9892372@linux-foundation.org>
In-Reply-To: <20241111205506.3404479-4-surenb@google.com>
References: <20241111205506.3404479-1-surenb@google.com>
	<20241111205506.3404479-4-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 12:55:05 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

>  include/linux/mm.h        | 142 ++++++++++++++++++++++++++++++++++----

There's soooo much inlining happening here.  Perhaps we should have a
"default to uninlined, unless a benefit is demonstrated" guideline?

