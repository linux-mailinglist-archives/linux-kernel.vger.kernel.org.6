Return-Path: <linux-kernel+bounces-238904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D792531B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6D1C25005
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47760DCF;
	Wed,  3 Jul 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tzTBXAyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE2621
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719985224; cv=none; b=i+JtUv9vqfhxuKmVhNiG7mjplxmzWZf8B7QkpLrE5hOZCPPxsq+oZ4fRz30AjeiU5swfo9PzZJpwCw13Iu/igLV9sEm4Fe+JW6f+LP4d8bz9p0edwoukxc2ZJoEEBuXzE3tdtoXFlRv5zswYVkSZsQj54WyNSvokoOieoY7/aj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719985224; c=relaxed/simple;
	bh=anS1J6SWlEks8LjRWPJ+9Wrys4H8dx06W6CXq9v7Zgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqFrEe+JuPWWUIjwK8rvdHtf+3i8I4aPQxzRskYpxYwgcaIozqx5Opv0cgoyjx8hHZ/Z+OqoHyRlhim538qucsS/cQgEsyGZ0K35gwbCAJm/pbG/Jixn8vSzhQ0s/9Ko+WtUoiGhjLXOiMZ+ZopRgtoD/YvQprwRiEJbrwyuq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tzTBXAyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F54C32781;
	Wed,  3 Jul 2024 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719985223;
	bh=anS1J6SWlEks8LjRWPJ+9Wrys4H8dx06W6CXq9v7Zgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzTBXAyPO9Q/ByNLbTzBhwYaNVqwXdzMhYEG5WMPx8H9Y1Mnn7AkvO+x/VrVPgCoB
	 gF15ylUkn6FLWH/lg5bu65AyeMIBiQLrEw/pLR00umAGQzKbhI6N/92A8aB5S+NC67
	 jU06TFncGyxNjtqf1Xv9NWIBFNGj+tY8J3UeUKbU=
Date: Wed, 3 Jul 2024 07:40:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: cmllamas@google.com, tkjos@google.com, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] binder: frozen notification binder_features flag
Message-ID: <2024070339-clarinet-deceased-6200@gregkh>
References: <20240702230453.1441209-2-yutingtseng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702230453.1441209-2-yutingtseng@google.com>

On Tue, Jul 02, 2024 at 04:04:54PM -0700, Yu-Ting Tseng wrote:
> Add a flag to binder_features to indicate that the freeze notification
> feature is available.
> ---
>  drivers/android/binderfs.c                                | 8 ++++++++
>  .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 3001d754ac36..ad1fa7abc323 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -58,6 +58,7 @@ enum binderfs_stats_mode {
>  struct binder_features {
>  	bool oneway_spam_detection;
>  	bool extended_error;
> +	bool freeze_notification;
>  };
>  
>  static const struct constant_table binderfs_param_stats[] = {
> @@ -74,6 +75,7 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
>  static struct binder_features binder_features = {
>  	.oneway_spam_detection = true,
>  	.extended_error = true,
> +	.freeze_notification = true,
>  };
>  
>  static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
> @@ -608,6 +610,12 @@ static int init_binder_features(struct super_block *sb)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> +	dentry = binderfs_create_file(dir, "freeze_notification",
> +				      &binder_features_fops,
> +				      &binder_features.freeze_notification);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
>  	return 0;
>  }
>  
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 5f362c0fd890..319567f0fae1 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
>  	static const char * const binder_features[] = {
>  		"oneway_spam_detection",
>  		"extended_error",
> +		"freeze_notification",
>  	};
>  
>  	change_mountns(_metadata);
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

