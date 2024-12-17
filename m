Return-Path: <linux-kernel+bounces-449813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C59F5674
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0CB7A3FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AB1F75A7;
	Tue, 17 Dec 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zDEs9lQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB0442F;
	Tue, 17 Dec 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460941; cv=none; b=sd4CBc85dXuih65+anPl44u/WdtLhkt9TWLpYeglU0G9d8sQgMHa0Nd1c24cNH6t7A50BTvgp9UzbSUDpwwg7zhKWiUgFI6W1rj3O+UowOpGJySFoEx6tk+JfvfkZYJFoL9y10g0mnDneVm3kh8ppmLpa+pdRvx+yjwkST5Fkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460941; c=relaxed/simple;
	bh=GWzdSVxsk5HvUFxwCBmAjB4KeW9Vk0N37P+SEQjdPIE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZsfyekmqDZ7RWWv8fel2z3JLc2k3NcvXn2XrjAY0iMLzbbpRlKIoEzYjNaKHN1f+cW/ikuun3LRtq5dSH5yDWB5V9wdvjhB9xaPjq8TzXOMEdz5PczfB9herVYAn0M1xHUS+n5Hex/mzUbhI9YCJr9dCC24Mz0hqdafMBb2Mt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zDEs9lQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94793C4CED3;
	Tue, 17 Dec 2024 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734460940;
	bh=GWzdSVxsk5HvUFxwCBmAjB4KeW9Vk0N37P+SEQjdPIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zDEs9lQsKTR6UEFOzWnHYNHawM5msCTXTdYyzjxhQ9A1VMv020nn564/w+R+uaHLR
	 0uav94hP/pxYQmpoSIodvl6xJGXaLQxsiCdCSwvwQ29/DqyJK85MPbyj2B0Nf1ygrk
	 CjMKt3tOzCPY1CGPJRzFwwgYlIHzd9XO6uscTDO0=
Date: Tue, 17 Dec 2024 10:42:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 lokeshgidra@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 00/16] move per-vma lock into vm_area_struct
Message-Id: <20241217104218.7ed493c6647cea5c5c0a73c6@linux-foundation.org>
In-Reply-To: <CAJuCfpHL33E_=hHmM-4sgcG892j3NS+J69RWHJNmJs-N16y4Lg@mail.gmail.com>
References: <20241216192419.2970941-1-surenb@google.com>
	<CAJuCfpHL33E_=hHmM-4sgcG892j3NS+J69RWHJNmJs-N16y4Lg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 11:39:16 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > Patchset applies over mm-unstable after reverting v5 of this patchset [4]
> > (currently 687e99a5faa5-905ab222508a)
> 
> ^^^
> Please be aware of this if trying to apply to a branch. mm-unstable
> contains an older version of this patchset which needs to be reverted
> before this one can be applied.

I quietly updated mm-unstable to v6.  I understand that a v7 is expected.

