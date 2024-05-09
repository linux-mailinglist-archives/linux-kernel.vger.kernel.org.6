Return-Path: <linux-kernel+bounces-174576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7BA8C10FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546EA1F22F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70D15E7E0;
	Thu,  9 May 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cFE+pOE9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23515250D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263816; cv=none; b=DHOpQYDjq6J2YFk8kZBlEA9uqHwGE4JmnAHNEEP4WUVRyCF5sGUl9KiVXCFAZkQUokr+PFHaiSUhzh8loXlPVazDmInSV2AIE+zNYlVeh/V719iIqwcX2xYJVSC70YuO54BLECqgcgCp7AwDusJ5t0LvkJrD97GaDP/ObffKbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263816; c=relaxed/simple;
	bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx6ASinVFrceXmE6AV5uj9UNAwnrBjeMfr6lbutIEIW4/n9wIyWJoQMk+b40uiwKscKI/xoTuDZzNVOTr3mBaUOvhQvknhKAVw1ztqgcE0T6OHn7lX6wr9P9r6HKONxcQRDI8qv03DrtgPYNWmTZSJ4sQ8mnqpyMlZMo6zTcBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cFE+pOE9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59cdd185b9so363812566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715263813; x=1715868613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
        b=cFE+pOE9L2Ei7YAn71/VuH8KXU7FP/Z6bGd6Xnp2m00NdiEZzyBen7BnukGvRvxESP
         pkzik6p9/Gtn0Da51jzaYDUR9Y1vY+SdH+MZeocsKT/xjlTYiDaq9XYOtrjWgyaFwxcz
         HHh6IYVuB2xU7CeycpjLSqQ974DtcYNhK1PUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263813; x=1715868613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
        b=ZptpHhFFsuxAtiEfJ3wcPCexT4tJJuBt0jaaPX6cTwCtvup0WhKzy2XCCzQWq42vfN
         9QwOF9cczkOKAJPOGXf0W0MDYrGD5H3odSBDzqWpttWLqC9UgjuM3DdE9O5iqeDnqS+1
         r3gDvOMQf0VN80neN9w+MuO3px3D+7PtxK3h+l5FjTKclflip0e2xcr8YN9slOrOCrZz
         EJ2nh+NFLmy8f6KtaMixGLdBTOzdenY3vKL1IzIU0Vjo8LKab6/Dhhn59CzM/Tcp7YL0
         J49R0CoOhjKfNqBkh8K8EqkKnHj8CRGNZxVlRgu2X//U99jmeb6Ix1Vv+rLnxBvdBG6d
         rR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsxGcKgyiDxA2UBN3wYqAg6YrDSsf1LwrKCwjDutnd92ZloamVPkUx5w5p/eg/JujwoNByiWVjx+q6oJXQP8QBOZssyJLkztQM5guL
X-Gm-Message-State: AOJu0YzaxfdA17omjcZrXRdMHoSbPLURe/qnqOjstZJ2gZEc9fHuyQK7
	PyszPrzsRmbpIS7ukiy5EcA8OXzN+YUZp0yGk7zfR+kSMP73jwf91arr1/Gzg5i8qxHZ2T11XSq
	913HylyBVs+rVTDUyic7kl+4LKtN2gDlnuUcU9w==
X-Google-Smtp-Source: AGHT+IFHGBKuV/1bvWy2Bm+fh2O34AZD8OxihJRS/BuyC/yZLmKQNTC7aP+veqoyaewftuyi1/G/oY1zcT9XdKrL3mE=
X-Received: by 2002:a17:906:7c4f:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a5a1165d1d6mr247358366b.13.1715263813135; Thu, 09 May 2024
 07:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1553599.1715262072@warthog.procyon.org.uk> <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
 <1554509.1715263637@warthog.procyon.org.uk>
In-Reply-To: <1554509.1715263637@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 May 2024 16:10:01 +0200
Message-ID: <CAJfpegvc=RsmozZCcp+cqMFxo0qR4vv7xT9owc1Epe9BR+zA3g@mail.gmail.com>
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, 
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 16:08, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > I think this should just be removed unconditionally, since the VFS now
> > takes care of mode masking in vfs_prepare_mode().
>
> That works for symlinks because the symlink path doesn't call it?

Yep.

Thanks,
Miklos

