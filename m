Return-Path: <linux-kernel+bounces-447910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E69F3873
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F00016D3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646F20ADC3;
	Mon, 16 Dec 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0/1MESJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66C207DFE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372093; cv=none; b=Dgzc8bdGCsf9hSXLYIvF7EI97kIHronF6BNbpJvc467Vl/WfC0thL4J/YrLD1pYo8aw7PD+JEcjtouX226GqY2msZKjP2yyXIIfGwGsX0JiPOKzBUDCiRAsdZZQOk/hOK36PjZsBeBPdm/jj1nJJGeiqFfXztHx67c3kts+Kfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372093; c=relaxed/simple;
	bh=TNfva8Q6ky3jlZGdUL9mgkSi6s0mbMUSjYqQPTb44Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxCpRriuociaYVygm3zJTomi7oZVxg/cPDbIvgOm2WkQVLqIVMrul8Y0b7iEQBYjDaLmFT02he1xpE2wVqEoDnH5zq5oe8dtm2tJwLegmmV8TGfz/Qx6iG21HSzx80+jSVjYwuFJbl1awUpyErckynfIimzS+93qBoJDks32SUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0/1MESJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21625b4f978so5995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734372091; x=1734976891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPQIIei43g7kqpTU4ih+SdwtTSlvo9YRppIwW8lHav4=;
        b=c0/1MESJ3NsGsL/fzy/xuxkxSU6G+3YdheqhAiPu5YNGqpxIb1dKePPN8/jQCkSSAt
         /otMdqMsdjXuEMGrRs7FKRTYCPMFQk1/clGbU/1a5kUgMldTp2WvuFmKDb3e3UkC7LiQ
         2xkvP4ddt/lpJ0Gi7f6sLv4Dw4sel6YURXrNqk9aHlCdlKuG1TsDc/aywVh0kj6374gM
         RIWPk3ELKukwJjBfqVklMW18IlaxuKlOEkKczwqLz8S3Nd/cMcVR6uPHqbL29QR4dYk+
         ObIjHgRWDuXYRMX/gOy1FYqic9VlKyC7wT5Trt5AX9wZBxsjs49uc7DHFbGJjd2ZW3O9
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372091; x=1734976891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPQIIei43g7kqpTU4ih+SdwtTSlvo9YRppIwW8lHav4=;
        b=CGSW2r3OkVzTmQ1PiA6xpnwZ44xIPAiYqiIF51txkZ7RJiaKtOzElSkBNBj/GIozqo
         RV9PRzdmRIYdxhG+rwDEsO5+YnYFtDcVKodrjS2j91n8OjE6OSzdNS+MlCLpPNu7hPTm
         p4Eswv8qHiZWb5deNhc8mRv0eWHKxzx8U6dzP8IVqCJi0Iz0ujlh+o0FG+weQHTlEAak
         xBLZpabOEuPWLhbHWLVXecGc5T0/jCl7NEQ6ZLrzmyDjZPHnaFxnJudwol+iRQuvzsq/
         5bBHNAs6jKsI2bCSe4d/qFnwUhQw1gkgG8dn6AAg7N2vVBWv48/nNbwKOo+Hk+2J/RfW
         KYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9gYog4tGGYhkVGjTAtmOcKxt9L6N1WQ7a6hhmiXw+1mqxCeTgapOvE1cKJC23REzlbmBiToSxKY2eSao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDf6YG4ezwLDu+SwlMinGfBpvGU1QX/4A6epKdGBkGY+Cs7tIb
	A/HItPKYWSdX5aXcj+cv/EOfbocT2A2S1KkdZmYkG2y/xxURIdCBgQTPUb1M8w==
X-Gm-Gg: ASbGncv8T4eNsooLiUBbYlrKz4N0XNefqrjYTeBkFvRZMhRCnguzPb/bA4GuX9xas/q
	7j2D3/sXIPzkB+vCUk7Qna0lc+CP0+lJbqU8l0AihqY4prfmBqePcUWs6pYTHHQNOGf+CLQB2wA
	gCsZ7MhZp5WeDmn1sGEaX+lAtYr1RIlHbU5HHndELqQKsGX/PfXmYLs+a2CsiD1zAY5gK2Pk++w
	r4QAm0gAxKksJz6YuIafJIOz9qdC0bXR0CkTUSNd+mDHt5KCy/Hi7TwYDot3JsPbwh12BSyr8GZ
	PBl49nmUT98Pju7+wlM=
X-Google-Smtp-Source: AGHT+IHHEXazswLI1ZC1yYlfJKsVFipOtHWE0V0uoBs6pGbMlIW0+1tuLPmPdqqn8TQk9Mo751rpqQ==
X-Received: by 2002:a17:903:1252:b0:216:6ecd:8950 with SMTP id d9443c01a7336-218a4539480mr4010465ad.19.1734372091319;
        Mon, 16 Dec 2024 10:01:31 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db87c9sm45727125ad.8.2024.12.16.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:01:30 -0800 (PST)
Date: Mon, 16 Dec 2024 18:01:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH net-next v10 1/2] binderfs: add new binder devices to
 binder_devices
Message-ID: <Z2Bq9CjXO6FXIFjl@google.com>
References: <20241212224114.888373-1-dualli@chromium.org>
 <20241212224114.888373-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212224114.888373-2-dualli@chromium.org>

On Thu, Dec 12, 2024 at 02:41:13PM -0800, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> When binderfs is not enabled, the binder driver parses the kernel
> config to create all binder devices. All of the new binder devices
> are stored in the list binder_devices.
> 
> When binderfs is enabled, the binder driver creates new binder devices
> dynamically when userspace applications call BINDER_CTL_ADD ioctl. But
> the devices created in this way are not stored in the same list.
> 
> This patch fixes that.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  drivers/android/binder.c          | 5 +++++
>  drivers/android/binder_internal.h | 8 ++++++++
>  drivers/android/binderfs.c        | 2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index ef353ca13c35..0a16acd29653 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6928,6 +6928,11 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
>  	{} /* terminator */
>  };
>  
> +void binder_add_device(struct binder_device *device)
> +{
> +	hlist_add_head(&device->hlist, &binder_devices);
> +}
> +
>  static int __init init_binder_device(const char *name)
>  {
>  	int ret;
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h

nit: I believe you the following hunk should be in this patch no?

 /**
  * struct binder_device - information about a binder device node
- * @hlist:          list of binder devices (only used for devices requested via
- *                  CONFIG_ANDROID_BINDER_DEVICES)
+ * @hlist:          list of binder devices
  * @miscdev:        information about a binder character device node
  * @context:        binder context information
  * @binderfs_inode: This is the inode of the root dentry of the super block


> index f8d6be682f23..1f21ad3963b1 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -582,4 +582,12 @@ struct binder_object {
>  	};
>  };
>  
> +/**
> + * Add a binder device to binder_devices
> + * @device: the new binder device to add to the global list
> + *
> + * Not reentrant as the list is not protected by any locks
> + */
> +void binder_add_device(struct binder_device *device);
> +
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index ad1fa7abc323..bc6bae76ccaf 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -207,6 +207,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	fsnotify_create(root->d_inode, dentry);
>  	inode_unlock(d_inode(root));
>  
> +	binder_add_device(device);
> +
>  	return 0;
>  
>  err:
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 


Other than the comment above it LGTM. Feel free to add:

Acked-by: Carlos Llamas <cmllamas@google.com>


