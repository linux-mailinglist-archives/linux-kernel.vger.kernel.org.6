Return-Path: <linux-kernel+bounces-250203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1C92F51F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD391F23B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA31BC37;
	Fri, 12 Jul 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSSKFLgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722B1B978
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762843; cv=none; b=CmCScHxPoDG4WvtVtEr70zPT6Qs4jWU1tbAIN/9VF1QDJpNOs2pa9gkbhg0WZiIjcJfj9tug63L1FxT8WA6q38NFRcXTZoZD/hltF9V9cuaNE1LtPADaVhMk4q6jQvcA0h+0o6JA7sMfD2YjIt5ZvsLjv7yr6rMmCi5JN6trrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762843; c=relaxed/simple;
	bh=PSWNyWU73EQqInxpASB2ScYA1nv0h1QBrxTVK5/K9Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9++vHPLm8wlCTOgyvb+o8HM3pEGz8yxTHeVAdO8U1mj+Kxg8CAPApMNSOvo9+bfJsrKYlIACalb2L6xY9QynKWAfju5P9jIR7f9Qaz8SwZ8R3EWaBtXkWiQKwDEFqs0Y3DA8MuMkOiaczWiV6vooiZ2pQMFEECqW0RlGFlmcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSSKFLgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D44C3277B;
	Fri, 12 Jul 2024 05:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720762842;
	bh=PSWNyWU73EQqInxpASB2ScYA1nv0h1QBrxTVK5/K9Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSSKFLgk/MjIM3OwBgy6wqcOPaOzMM01CwlvAaug2ie+bOxfSD5Lxj6T2aypKerbp
	 KDm+71/QswAoYZG02gHAorXcZjXHbqpSxPRFNg0u4ErPAs73NHkKwl7LuWb1/ypoHy
	 Q0FeYLmpN8tdfBSW8OHyKtRgfdtouoLxl6UnOl3g=
Date: Fri, 12 Jul 2024 07:40:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
Message-ID: <2024071214-onshore-moonbeam-4eeb@gregkh>
References: <20240712032140.4012667-1-lsahn@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712032140.4012667-1-lsahn@wewakecorp.com>

On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> It better prints out an error message to give more information if
> calling debugfs_create_file() is failure and the return value has an
> error code.
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---
>  drivers/android/binder.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index b21a7b246a0d..eb0fd1443d69 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5673,6 +5673,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
>  
>  	if (binder_debugfs_dir_entry_proc && !existing_pid) {
>  		char strbuf[11];
> +		struct dentry *debugfs_entry;
>  
>  		snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
>  		/*
> @@ -5681,10 +5682,19 @@ static int binder_open(struct inode *nodp, struct file *filp)
>  		 * The printing code will anyway print all contexts for a given
>  		 * PID so this is not a problem.
>  		 */
> -		proc->debugfs_entry = debugfs_create_file(strbuf, 0444,
> +		debugfs_entry = debugfs_create_file(strbuf, 0444,
>  			binder_debugfs_dir_entry_proc,
>  			(void *)(unsigned long)proc->pid,
>  			&proc_fops);
> +		if (!IS_ERR(debugfs_entry)) {
> +			proc->debugfs_entry = debugfs_entry;
> +		} else {
> +			int error;
> +
> +			error = PTR_ERR(debugfs_entry);
> +			pr_warn("Unable to create file %s in debugfs (error %d)\n",
> +				strbuf, error);

Even if we wanted to warn about this (hint, you don't, see previous
response), this way to check is incorrect and will fail if debugfs is
not enabled, which you don't want to have happen.

So I'm guessing you did not test this with that config option disabled?

thanks,

greg k-h

