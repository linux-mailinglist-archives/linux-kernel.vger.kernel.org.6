Return-Path: <linux-kernel+bounces-223950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4C911AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA313B20CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839C13C802;
	Fri, 21 Jun 2024 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/NJBUm9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45F12D771
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949944; cv=none; b=Co1Sy19f5gICl8p7Fj/tnSZrbqb9GL8vMPnpjn5Bxy7AuQLdnItWTi5lpyYZm9Fqicx6V7fMXFH1fzTbwfSr7czkw8JoGHI77KJNb0HDt6DbKfJ4wb/AtiZYeEqW8MXXo3bE9aRvb+Que/ALnIqYedeKCgqoOVcLglpfHsKrvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949944; c=relaxed/simple;
	bh=GUy7R99gLwzHx0zFkTn9A5vQKrLVoOf8O0raDwM58qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx50SLbIm2+s3dFHcmVh8rl2Ll0tuUzKZkYkUeiv8jr/fl7xKmt3PdaRHBqfZ+2SJ/nMM8NmBGYqiZFoQH/zhk8YjO1Nq2ddWceMaRqZyGyi+aR5H8aoiOUPDq73LTuiABCnRurGNKMAH+k+B0SQCM4vb2UANI1/aXuGYEnoQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/NJBUm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA747C2BBFC;
	Fri, 21 Jun 2024 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718949944;
	bh=GUy7R99gLwzHx0zFkTn9A5vQKrLVoOf8O0raDwM58qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y/NJBUm9Zg96v7wTcZ7hwAhC+vg2f9fyoclp2PrbQEmme5T9fOLVGnrIXoXtPxrUz
	 VTkkH1dAavy5sGqft3kKGIX87nCWsbqa4AuLiTH2Z9PqZ9pBVI3o4sa1RVJKTeJgSQ
	 sm00rZidlMonqBSX6t9EwOhDGCsrankAA5WsrgDM=
Date: Fri, 21 Jun 2024 08:05:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] binder: frozen notification
Message-ID: <2024062137-mannish-extortion-e989@gregkh>
References: <20240618221925.108173-1-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618221925.108173-1-yutingtseng@google.com>

On Tue, Jun 18, 2024 at 03:19:08PM -0700, Yu-Ting Tseng wrote:
> ---
>  drivers/android/binder.c            | 321 +++++++++++++++++++++++++++-
>  drivers/android/binder_internal.h   |  21 +-
>  include/uapi/linux/android/binder.h |  34 +++
>  3 files changed, 372 insertions(+), 4 deletions(-)

Nit, when you send the next version, be sure you use
scripts/get_maintainer.pl to know who to send the patch to (hint, you
forgot me, so I would never have noticed this to be able to pick it
up...)

Oh look, the ANDROID DRIVERS entry is pointing to the wrong git tree, I
need to fix that up as well...

thanks,

greg k-h

