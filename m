Return-Path: <linux-kernel+bounces-238861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C45925241
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830921C21F73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167D713C8F4;
	Wed,  3 Jul 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmdbvZK7"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FD11CAF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980735; cv=none; b=jW85oSJIxTR00ouJtAj6CaQ8l5oaLAfRiUrUh+8ZBIN70L4gX0wZZ748tvQjnkxl9Mw/8llAuKiHfm86G0H3v0lZ6BBRLGeYt7YZlnmxp1KD/6UzKMqY6JQnPyXs46i08qGPg4jqEjZXDBkYqoltqDKR9DIUNB55pHwuzDKn+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980735; c=relaxed/simple;
	bh=dpAV08Oexo9fR5QvqcrX73dZ7ErBaFU3y+idp6Z/slU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnssoevMo09eWCnXQefte9AKfFx502Papwkxv7sch2BRcRIWTJFDdMMoAqoHdUAo3P7+Y3NDsehI5ufw6Y0Ql/UXwR0uX1KquMf8Y2C2FSm11gipKxz2v5b+0u/5cLioveSB6utS4GWw4F4G4ZU7OAobz8QmeA9l2FCOe6dSfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmdbvZK7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb1c918860so147525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719980733; x=1720585533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exvuh4jG3swb1rFNRwqUT2G+n5Pp3WdZAkE58wZf+yE=;
        b=kmdbvZK7Ucllei2eacfGHEGdZw5MkX0gwmvXDuqduaGc7uaV4+l383dQ3UaH4iJSOC
         vHzc/Uk9NKgSwxHkpKzqe8lXszek7gI3xgfTcA7wr0R47HTyHemv7Wjfs5dU78xO+ngN
         it0Gip3g4OUZVz/S6JPrt8d26/mR83K5sYa2p5ekoGhn5ecflB9Zm6c/C4iNOT5tt1fn
         jjivBPhxSNRsOjhv4e2TbybubWCeeXEJVHRgVECATq8/FvUptO8ABSrI35346UP9kYO6
         Ytxw8C2G4k9uWe+dBdtdE0yLx71TqJorojjtyUEDBX2aqOAdNtOfQmMCnTLLbeoZr/Fu
         A6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719980733; x=1720585533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exvuh4jG3swb1rFNRwqUT2G+n5Pp3WdZAkE58wZf+yE=;
        b=AL+nxmHS8udheS5m5bswxU0m7kR6nklej4gjQ2XzCKo3uKBnHtl23XNfd6PtA/WCOg
         VlO9f2YnMNpVuGyJLDc/A0OAGAwOiLXihB0ubcAD919LnyEtj++5d69a6rr8z675kGi6
         03i+4NtiBfffid6jAQESvWV7zcUKk8zm7NxUKr/8kDtpkSUmAtjpYQ1iOXZocAtITsrF
         tGoz+yQKMau29fI4vTURE8zfKm6bXQPx7sGqLkUHZ/6dibeL436HpOv3vAM6TprnmRM1
         xYj3IZbvluUWhonWckIpLC6piLbT8PI5fdnjwNUzlDyoQk1aW1IhQOjb9TQcE1fzo5TJ
         8PMw==
X-Forwarded-Encrypted: i=1; AJvYcCW2VF7hXug/+xwJ40whilaPfDjqt0lwD5kIveWnHruN9+eWJ6vpcr8aYph27ivXEI1SXPc5IeIBAVvoNXh8/dFsqYa9AakeIRxsrGr+
X-Gm-Message-State: AOJu0YxJqNCbMnpwm3OWtnRaz1N9zXYPET7bPzALOj01RhjLj3BQPmnr
	jCRz9M11w7AA3BSlNtB/3uhajBtVYAzK7YyHjvqUzyJVCPJ6Gg63XfnF6blZTg==
X-Google-Smtp-Source: AGHT+IF5AE1OiMz+EirwrVs9wLffqiAFjpnTed1WraA1jQyvfjsV4ubpbVdJzR5AirBSP6lE+33brQ==
X-Received: by 2002:a17:90b:4a8d:b0:2c9:6753:6192 with SMTP id 98e67ed59e1d1-2c97ad159eemr874162a91.12.1719980732860;
        Tue, 02 Jul 2024 21:25:32 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3c206asm9685320a91.44.2024.07.02.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 21:25:32 -0700 (PDT)
Date: Wed, 3 Jul 2024 04:25:28 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, aliceryhl@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] binder: frozen notification binder_features flag
Message-ID: <ZoTSuNwhcOOeaabW@google.com>
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


This looks good to me. However it should be sent along with your other
freeze notification patch (the two patches in a single patchset). Feel
free to add this for the next version:

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks,
Carlos Llamas

