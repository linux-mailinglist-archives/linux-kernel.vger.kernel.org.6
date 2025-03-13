Return-Path: <linux-kernel+bounces-559214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C41A5F0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353097A3A06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08826389F;
	Thu, 13 Mar 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RMJ4vkFb"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C932641D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861938; cv=none; b=eTiuKdHA9AFHRp5UAVVV4IlSwaXXYX6c3FiARuDJnFtz09obwYdUqmJdisfwAL2KXPih68fcd7ofGzDd0upWjBODAO532smBgGw3w57mal7KsQM8dmTuf2RTDKlynrxke9nngP0Uw1nf65wtUa9EKplk+Srs2Zdfj7QTnrUkXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861938; c=relaxed/simple;
	bh=IQnwkbJdURJ0nJmN1Yz9ofHPCB3tRF9+FkMCtc6tar4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSF6xtwW2G1VsAb1QlgaQ6IeWIUjOpnrDpItWx4Rta7vOfdF3ktlgwqzGJ3WaUgO0lc0FhnG29wIwl4j1Rf/ggXbiXNcHCsa4WVRVFGwPB8nM5miTjosjU1zlaIiODNlYmMpra/CO70t8dtYQTScKXuBgaJPa5h48aemQKWkUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RMJ4vkFb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47690a4ec97so7133941cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741861935; x=1742466735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muAQHFEgNLZMG/SuC+aPWWR+LDpxUfw93H2VEDc/yJA=;
        b=RMJ4vkFbKAGGNuzOIv0tQXAoF5TOcHFivlAgiBMbpFyn8YLGlr4SJ9G/zKszKrIyO4
         gmvXDZarph/4GFmlHiMZNhr7IIeCDmvJoHqpFli7xXeFI1CF22i9EC4FUKoBX8puKyGP
         lQfQiG7Cv/vurRnV2bmy2kpA5qdOMg7SG5Um0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861935; x=1742466735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muAQHFEgNLZMG/SuC+aPWWR+LDpxUfw93H2VEDc/yJA=;
        b=AzplWkL91XQ/rggQJzRB2AHAdArlrnPUZ3zaPRcBNaZZAiv6drLj2FFlRDh3agXqqB
         XTfi9HJm+8QQx0ZqDQuVcf5sXzvkZKVqD8GF5/3lH5S9QB10dkuKYi3SU488DSyZ9uG7
         IpYuuC1FAtux3ar/fA2buPMzcSPq/QGu6qwqTVDNBtEpyExOufi5fa9QWaV0PKI4X9Ev
         fjn21UyrmEuCA7fSI1ljbdITDlg2+9tHq4Tzm37JryvcK9jNt2XLvQ4SLYMrc7SyDKDn
         n5jx+bxL9njY6jJGjoACC/hQA2Ufg3vsTJploYD7AUQx6SLBUAH3me/lPSxyri/wwRsa
         iY9w==
X-Forwarded-Encrypted: i=1; AJvYcCWrs0QwAk6o0f8rxp0PIqoaP0z+9siydt7Sq3RXwvb9nC7qIUWy9p8H+tlaxG7toSt8pXgRCYvWCtlrr9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxgFy9jPYzFM2BQ4mNmQYYCGM1Q3PQt+HJqalIvVVlEekni24
	U777JHSVShg3sTtD7lwHm1rjCbdgKUPu8zWogyeYJkQ7YRkZ2mW5+4JLamU9Kvf3dpghfdLHkE/
	0rVihQjx/kqdnzGS+Odr476jGIgN1Xo5k4nw9Kg==
X-Gm-Gg: ASbGncvzlQSmJtYyJXqtUV2TP1k8V6vi0VOeSrhntpkHk7EnwE9VjukJGsBOhhPk726
	OBicWHekTJ18yWZ7K+hW+SdOk8jdCvg8KJHt7GpkKa00UeH5Rli1d8Rc5tprnucuDWkIEx+hGKO
	mo2SfBi1DlZbKTi44NOm5LK5Wp9ozeE7lYagOy
X-Google-Smtp-Source: AGHT+IFvV+R6NB1RTSGjApLwDmw/4hA6BuNsaN2pzZiGmqLxchQfn6CPykE91fBj9CIdL5LgDTEVx0RIRGBSevEA8XQ=
X-Received: by 2002:a05:622a:164c:b0:476:9296:80c1 with SMTP id
 d75a77b69052e-4769950dc42mr192797031cf.31.1741861935681; Thu, 13 Mar 2025
 03:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com> <87v7sfzux8.fsf@igalia.com>
In-Reply-To: <87v7sfzux8.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Mar 2025 11:32:04 +0100
X-Gm-Features: AQ5f1Jqnkql6G_Btdn3PdfZNt5_6gSuKgmk5jF61L-Z8GT8L1srjija5P4cysU8
Message-ID: <CAJfpegvxp6Ah3Br9XUmnz_E5KwfOTC44JTa_Sjt0WGt8cAZKEg@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 12:08, Luis Henriques <luis@igalia.com> wrote:

> Well, the use-case I had in mind is, as I mentioned before, CVMFS.  I
> think this file system could benefit from using this mechanism.

We need more than just a hunch that this will work.  Having code out
there that actually uses the new feature is a hard requirement.

It does not need to be actually committed to the cvmfs repo, but some
indication that the code will be accepted by the maintainers once the
kernel part is upstream is needed.

> However, I don't think that measuring the direct benefits is something
> easily done.  At the moment, it uses a thread that tries to drain the
> cache using the FUSE_NOTIFY_INVAL_{INODE,ENTRY} operations.  These are,
> obviously, operations that are much more expensive than the proposed
> FUSE_NOTIFY_INC_EPOCH.  But, on the other hand, they have *immediate*
> effect while the new operation does not: without the call to
> shrink_dcache_sb() it's effect can only be observed in the long run.

How so?  Isn't the advantage of FUSE_NOTIFY_INC_EPOCH that it spares
the server of having to send out FUSE_NOTIFY_INVAL_ENTRY for *all* of
the currently looked up dentries?

> I can try to come up with some artificial test case for this, but
> comparing these operations will always need to be done indirectly.  And I
> wonder how useful that would be.

Any test is better than no test.

> So, you're proposing something like having a workqueue that would walk
> through the entries.  And this workqueue would be triggered when the epoch
> is increased.

Not just.  Also should periodically clean up expired dentries.

Thanks,
Miklos

