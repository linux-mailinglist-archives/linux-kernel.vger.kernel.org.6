Return-Path: <linux-kernel+bounces-186586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1408CC5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806ED286CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F602145B25;
	Wed, 22 May 2024 18:05:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2791B145B18;
	Wed, 22 May 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401107; cv=none; b=e/Ufl15w8tQWA1KSrcHE+vGx6EykzuYmj4UldDw0RTbiopAl3njNpmdvWv1Pjc8HEWgTBwimD4aY5THiH9Y2aI3twoSCREDzGzpwGypaMYP8eRqe5lbA7NNa6HRv9T/wigqyf2bQIZm+WBhMSAMmkVev80ndC0O/7yKZxeKEF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401107; c=relaxed/simple;
	bh=FM8Nun/+WZkrxgrM1AclrLTVTXF8t/mYHvLX/RNYsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlLyD7njd409mD1NKLwJNNm24EH3l3lX4f+4PWOGLpo3GvfetlYNZdIVRLHkCIaFVAlUCB/laV9W6WWMCCAzfx5naxS+D/DP7Jl7d1o72C+eZUzKqBlSoS/DueUTpDP+IvgETa4Mk/uyVJt6jUIutQFizvImpIC1Y6PfQKuibx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C60EC32781;
	Wed, 22 May 2024 18:05:06 +0000 (UTC)
Date: Wed, 22 May 2024 14:05:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] tracefs: Remove unneeded buggy tracefs iput callback
Message-ID: <20240522140548.40dbd49b@gandalf.local.home>
In-Reply-To: <20240522124504.28982867@gandalf.local.home>
References: <20240522124504.28982867@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 12:45:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The iput callback was added because the remount could call into the
> eventfs code and touch the ei->entry_attrs array, which could have been
> freed when an eventfs directory is freed (via a synthetic event). But the
> entry_attrs was freed incorrectly and since been fixed to be freed after
> the last reference of the ei is done.
> 
> The iput clears the TRACEFS_EVENT_INODE flag of the tracefs_inode
> preventing it from calling the eventfs_remount() function. But the iput
> can be called after the last reference to the inode is done but the
> eventfs_inode still exists, causing the eventfs_remount() not to be called
> on an tracefs_inode when it should be.

Testing this more, I found that the iput is still needed, as the deletion
of the eventfs inodes can happen before the inode is released.

Will produce a v2 that handles this properly.

-- Steve

