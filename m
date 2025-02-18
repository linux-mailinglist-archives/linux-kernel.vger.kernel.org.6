Return-Path: <linux-kernel+bounces-518502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870EBA3900F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D013B2DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05BF3A1B6;
	Tue, 18 Feb 2025 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="l/b8xtS/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB28E56F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840144; cv=none; b=LB2cG+HWbqYFRIodp3g1G8sz2rRlD9/eb2v3jTGbl1bRCVxWiDgK3OeGZt2DEpCO0hChE1KAjTUF3D4UESC7JecKYC3o06w9Dhhuxd5djGvxKQxPTbsvgQT2c1XFVW56SdCbZ11+aAq/CHO8tbgIkQqX1xa73goGx0oWttO8Cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840144; c=relaxed/simple;
	bh=5iuvPIe6yThTSOpvBOv+EQ4YP0v5TOWcae6xoF1FT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlTVHPsTL3P5mBjmmArs7pPVAYGRBIyI1r8OsYAZoMKnL5RKo3wcxw25Z2kNmlJvpLjhX4Vjpwe2nnS2kiuXLSVdOAxqB0tg8DGmdKo3gm4sQrYxYzpif5Qqe3tehZnCUCfjeEiU6rXrTF9zD0i2TVXGAaF+ezEBDh/l8jDLp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=l/b8xtS/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2211acda7f6so37704335ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739840142; x=1740444942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nry7GFraP5dID7OEFezKs+H87qqk4KNOlEl9BWM4owk=;
        b=l/b8xtS/bAfry6WThw6zhkwA/GPQlF5r8Do0uquunXOgzYdXa8DctAr4GUJyjAVpRC
         YMmNN9aDejYfoVcAVLJd/Z4tt1q51JpiEm/ul3eYErm3LhJ4YcME0qKBYyiESq/kDbkD
         H5I7Rd0nX3TNkzqFcF5GuJqxfednzbA/9ROhx5+eSB8VFCb05V5T+PLzLOASeMf06tY9
         mI0dZ5Fj+8XzWXN6K/2sjteiIU9/40v5g+cb3gSivEQpsrDXONtrxhrTK0zO1cRb5E90
         Hdjqcyf/8haAx5MuaBU30Favm/yWKpwzTA6vs0VeCpmKLBbsFlWXsv99AwQOrzswTJL6
         Ve8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739840142; x=1740444942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nry7GFraP5dID7OEFezKs+H87qqk4KNOlEl9BWM4owk=;
        b=qo6T24clxYBpr3yu9TZ/8zIizvPIU7+Uww9SSVL1xEHMgoYCsKsJ+NaNxQ2NlBg/Q0
         oIkJT+zcY9u7qBuvzS5K+ac2jdMXv3+XWof1kcmrm0trGxK1NvrtL0D8EInBeSG+eRZw
         NsETo80DLWZnrS9iSQ45XXR2m1kBzrJt9XRBwfP1m3PuPA7dht8amjOj2CLM5xtOx+ea
         3Cntnm7k6Mmp6fDZZI045v5a5exhd4C+JqfjO4jyygpRRVkYAZVSRg3uZDiFViarrBwv
         mcKq/sTyTFrVw3YLL7lKhWHkE641Fyk4D9JOPgIzO91z4Tk0DYOS17NJ4Q5aJbtxu2E6
         IVYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0URw98/Ccr7XWM5u/exT1zyfqo+Edl4aJQUGrZ/Yizz5/yNAJWU0JWWLO+29RK6WI9Hdwo3Ht1q8PqLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmRocztlNXGe3q2aQn4t5fAWcPvQLm/dasaOHECEwVUwG+w8L
	uT5j/3KB+U3sxX0rdWyDGbAV64OSYFv3umio6ydMG/dlYgVQ7Yi0rU87vhB/ucI=
X-Gm-Gg: ASbGncuFgtmRk3/5wDZOIyJYgFkHEeKKbYm3U1p7NzlM1/T2KLITXAaH7wXw7ntPbw6
	eDmzF0mryBAZqMTNQOUDoMOztBWsIKBlVhxp9/M3GNLQ5rUE9KgP+9/xvNc3+beEUxIcrDBboit
	HMoZ3HsqppKLY0fx4Wf4sH37CvKwVf/Ip8dK24PuOasFZvX2/yeb9OiwzSCJVUiw83lQTEdB88W
	kBHyuijM9QFOj0vUeHTYhgyOGOd3wStqHLDqYvhrFdQ5oqW19fTqdrDpQgWiG3t89KEX/nOTyZA
	4Ama+BGyTLBlMu8A6spqdeOjKu+aeuhjEDy0Bkh6O9hXdBMiD+6Po2Ba
X-Google-Smtp-Source: AGHT+IGFnm0d4B9MpsOMTdi9dSjhG9Pb2tiGpMdEdFXl3Ihlm4sCRnTwugA8JT8DiRGGw0PKCpmO0w==
X-Received: by 2002:a05:6a21:1707:b0:1ee:b7e8:5e14 with SMTP id adf61e73a8af0-1eeb7e85ef2mr7886159637.8.1739840141910;
        Mon, 17 Feb 2025 16:55:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546149sm8705791b3a.36.2025.02.17.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:55:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkBti-00000002be0-3zn4;
	Tue, 18 Feb 2025 11:55:38 +1100
Date: Tue, 18 Feb 2025 11:55:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
Message-ID: <Z7PaimnCjbGMi6EQ@dread.disaster.area>
References: <20250217133228.24405-1-luis@igalia.com>
 <20250217133228.24405-3-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217133228.24405-3-luis@igalia.com>

On Mon, Feb 17, 2025 at 01:32:28PM +0000, Luis Henriques wrote:
> Currently userspace is able to notify the kernel to invalidate the cache
> for an inode.  This means that, if all the inodes in a filesystem need to
> be invalidated, then userspace needs to iterate through all of them and do
> this kernel notification separately.
> 
> This patch adds a new option that allows userspace to invalidate all the
> inodes with a single notification operation.  In addition to invalidate
> all the inodes, it also shrinks the sb dcache.

You still haven't justified why we should be exposing this
functionality in a low level filesystem ioctl out of sight of the
VFS.

User driven VFS cache invalidation has long been considered a
DOS-in-waiting, hence we don't allow user APIs to invalidate caches
like this. This is one of the reasons that /proc/sys/vm/drop_caches
requires root access - it's system debug and problem triage
functionality, not a production system interface....

Every other situation where filesystems invalidate vfs caches is
during mount, remount or unmount operations.  Without actually
explaining how this functionality is controlled and how user abuse
is not possible (e.g. explain the permission model and/or how only
root can run this operation), it is not really possible to determine
whether we should unconditional allow VFS cache invalidation outside
of the existing operation scope....

FInally, given that the VFS can only do best-effort invalidation
and won't provide FUSE (or any other filesystem) with any cache
invalidation guarantees outside of specific mount and unmount
contexts, I'm not convinced that this is actually worth anything...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

