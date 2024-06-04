Return-Path: <linux-kernel+bounces-200975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C28FB7A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF74E1F267C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E41465BD;
	Tue,  4 Jun 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbNYR/Zb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519EC145FF8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515720; cv=none; b=gMwoA30RwffFYfBJ7H/Wk2vtScBx1+QvI94njLZHXLWNEufTb7V4vUXqo1QTJXH0qzi+Q3zvmbN2zsJNFcT6qiarDcd0h0KJBsU9SHAe3PeKoZcPZ02dpDy3Hi/YER4X9na2NQv2uFPqgqNlLUw2Px9Q8BO2xuqWfUGh6juIj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515720; c=relaxed/simple;
	bh=2der58+5+M8sJ7S06tSlSPRV9DWuJlgIZ3M0EI+0TiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaIbTHgIVW06WqavNctLsRn8eI19sCF+exQj+6XU80jG5iR1aswbTJM7oeESz57dJayKc8gurKfB4xwDI0kkFjN3U8wTcIn4D4dxKcuaTZ3t3feDxN6DtI1RA3cOld4qJA5jqAZK779ICEGYk9oslmG8fU7t1od/w603WzflWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbNYR/Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C49C2BBFC;
	Tue,  4 Jun 2024 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515720;
	bh=2der58+5+M8sJ7S06tSlSPRV9DWuJlgIZ3M0EI+0TiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbNYR/ZbJnrYREWVDk0cbY3+SZjJoW12kNfP0nVniJW587W3Fz3XvVNgb6kYvWG1o
	 BdsGhqd+HrKceW0eYW/6aXo6wqCP3Dv7qmH364oHRUJFpqb5bAf46KNyP6iJqrLcqs
	 5Q5pkKyS+9rORKMAVJIgs/Aorp5IognvUMOb02Fo=
Date: Tue, 4 Jun 2024 17:34:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] kernel/panic: convert print_tainted() to use struct
 seq_buf internally
Message-ID: <2024060454-talisman-worrisome-ac95@gregkh>
References: <cover.1717146197.git.jani.nikula@intel.com>
 <cb6006fa7c0f82a6b6885e8eea2920fcdc4fc9d0.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6006fa7c0f82a6b6885e8eea2920fcdc4fc9d0.1717146197.git.jani.nikula@intel.com>

On Fri, May 31, 2024 at 12:04:55PM +0300, Jani Nikula wrote:
> Convert print_tainted() to use struct seq_buf internally in order to be
> more aware of the buffer constraints as well as make it easier to extend
> in follow-up work.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  kernel/panic.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

