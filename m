Return-Path: <linux-kernel+bounces-403993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718729C3DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70DCB245CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217418BBA2;
	Mon, 11 Nov 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGe26UZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE40139578;
	Mon, 11 Nov 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325569; cv=none; b=tJEF0CexUbaH60yDBNJ4ASyKnBM5NML0PO1roMvRPiAG/5K/j4SNXwgmnjET4HivPBZrUzcLcsVzb/WryQ5Bk1VjJFKAXtNYt57zfoF1FiffNkRc+aY8Gf4EWmXMIsiCs9m4Q5Ld8Nq8KuJhvXb/fd2npSeVQCA9e871i0Sr4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325569; c=relaxed/simple;
	bh=AshHHOhRU0QFiLb7JHg/jZOQEAGa9l+uFwKSteCqsxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/LbXyhWzCia2TXFCNSE7ScOtUffy/XSTlqqbeLkyA7uv9dY+6Gp23zYmX4oZgZ2dSDHJCd7xc998j+H90lvSiyyXGmLiB4NLiWFwRABnFgFpNvAVGmlWAoLlQLG9Vjd8eadWPmvU00zsJ+GzZfyy6iz65Yotzg5Vj95qb8sGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGe26UZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E80C4CECF;
	Mon, 11 Nov 2024 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325569;
	bh=AshHHOhRU0QFiLb7JHg/jZOQEAGa9l+uFwKSteCqsxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGe26UZF0twPw/ww8GtIWmaZjQmRJ8Z5Wq57uW6xyNaZ927NU3gchBrBsagRA/S4w
	 LB6bQ2C/df2awi76pJiLhBXm7o4lABXS9tb/l1bLbRjmUsrBUsWmpTt9HOLzNiMZJe
	 5lFs1Xmmg2Fu7klni1vIpBfAn9RhFGlRdvJWfxK8=
Date: Mon, 11 Nov 2024 12:46:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>,
	syzbot+9760fbbd535cee131f81@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] usb/cdc-wdm: fix memory leak of wdm_device
Message-ID: <2024111145-stoop-blot-a740@gregkh>
References: <000000000000e875fa0620253803@google.com>
 <20241109152821.3476218-1-snovitoll@gmail.com>
 <825be5e2-31b2-4cd6-a283-05935ea6161f@suse.com>
 <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxjD0PceaD27Ya6fFxKnSQZajtG2sEArqX6toS8SjNcinw@mail.gmail.com>

On Mon, Nov 11, 2024 at 03:40:29PM +0500, Sabyrzhan Tasbolatov wrote:
> On Mon, Nov 11, 2024 at 2:44 PM Oliver Neukum <oneukum@suse.com> wrote:
> I also wanted to request a CVE for my CV
> after the fix is released per kernel.org CNA rules :) but it's not so important.

Should not be a problem, but has nothing to do with this fix at the
moment :)

thanks,

greg k-h

