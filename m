Return-Path: <linux-kernel+bounces-328063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A14977E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E56286F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF91D86EC;
	Fri, 13 Sep 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G6g0Oh3s"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4E1D7E2D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227148; cv=none; b=i3LAC3XKzVzeg0DC/7HNDcDAFFTIhc1Hd5nKTSjU85WzjLwgDsnj/84TtptYqMIO1Di+kg3k91loEXB1dPB3t+XVu0fZw9sNkSkq4DHDadSJ5l1dQ/zI4Ay8aAWo9MTqpk0+00Bx+vxboXDJhPM0IiXNYchsQVtb6jYfNbsfcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227148; c=relaxed/simple;
	bh=5v4NdqbYPDiRqhfNWq3dTnXzPLJsQvlk6g+gl0hStGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5ek0g1CXncWjJDIgHWTD8rdodk6AkAEklK/z1BQKcvhLKUOCY9JpJjRgzWS80UqNa+ZygtW1s3SBBfsBMNRYJ91EV8kF86izYxIeAJ3j9zn5GVhzqeNJCWTbt78CB7Tr/xmjwscazy0Vp4WZkyeWvcbZpnMUo//CU/OjkNGORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G6g0Oh3s; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso2251232a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726227142; x=1726831942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XvQ+WPCgnw5TpCVTyzWv4NUFhv6UE6SYFp22sYw7Dw=;
        b=G6g0Oh3sKOOyDgcml47ep+d7Wfupj3bJwl1LN2PCkQbTaBHTboxRsxWHql3264n1k1
         zkaLes/BUnvQjnjjdxno0mDBeidG8VZ36Vg/07RmzphVIhzMfBVtKT5E6qs0jK/nhzeH
         4ZELunmkv2FaRa+DW/nxHeuhnD1tnZYRXS9kTGa57uO4o89vKFk5/2JKYMrNauhFNQzI
         PpeWJkuhv4Q2DCMpAR2KeTPfeo3SLWt5UE3erwh3tQPxd+1IvxhdMQ/iNz9wXBYfV+mm
         ePzg6mfv1eFKQqbBDfuy9k9ywuaTNhZqKKp8mXk6J1E44xfbp9N+Kcqsa01fUIjtunl2
         JeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726227142; x=1726831942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XvQ+WPCgnw5TpCVTyzWv4NUFhv6UE6SYFp22sYw7Dw=;
        b=C3vrKQiVO6KAG3XpA4TF/nfkNwvuF4UBijpShz+wk15wQGaQ1JYw+ToZEcZm/G/qwi
         ISBC413PjmuAliLY0bgFAhpRCFJmqmoFMYqmnHpRGX5Ingybq29QKM1D4JYvWI+KPETP
         eYARZohWmCB3PGPWbQl4r23RSl6bT7A8DxBwU0RpTCl6VMQ7H5AGAgocL5AY4HRgCqXJ
         Qg6O5+rg61gFl6Kl5Ono+YObVVUHurMf5NG4Cbmy3WXR0t9gAJjxSFG2FUdEs/QM7qhk
         2++USeawzlT8eCzSCxChaUsC4xUI91PCv6H+RUIUDjAZT4x/HmjE+GtXZ9T7pLzN5Rnc
         h8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW2CSxDjV3Sc3Y5uXXD4o8tCxT2337I49HUw7OVUZPWswne37iw9G3MO/kww1fLSBrIRmJyKNX97bCKI40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TZ/92kvtZB1D0+5znzVddhkdSyysRSkq1sWF2VOBYcrPloQ3
	Nb5RO1Imo7f5D8MFNL6KQM/meKTCCvDEjKm1egnq9eTHCrX+aX03FbPau3VG18k=
X-Google-Smtp-Source: AGHT+IFk2He77TP2kioeSwXBmwlMwi0GakIdhMDY2pNCObI2N0QZNysVa9OynBPm0mzSWIm+r0ei1g==
X-Received: by 2002:a05:6402:234e:b0:5c0:a8d0:8782 with SMTP id 4fb4d7f45d1cf-5c413e4c56fmr4214176a12.28.1726227142107;
        Fri, 13 Sep 2024 04:32:22 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd424dasm7600339a12.9.2024.09.13.04.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:32:21 -0700 (PDT)
Date: Fri, 13 Sep 2024 13:32:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jan Kara <jack@suse.cz>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs/inode: Modify mismatched function name
Message-ID: <ZuQixMvfcoI1Kg0-@tiehlicka>
References: <20240913011004.128859-1-jiapeng.chong@linux.alibaba.com>
 <20240913102935.maz3vf42jkmcvfcn@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913102935.maz3vf42jkmcvfcn@quack3>

On Fri 13-09-24 12:29:35, Jan Kara wrote:
> On Fri 13-09-24 09:10:04, Jiapeng Chong wrote:
> > No functional modification involved.
> > 
> > fs/inode.c:242: warning: expecting prototype for inode_init_always(). Prototype was for inode_init_always_gfp() instead.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10845
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> I think this is a fallout from Michal's patch [1] which will be respinned
> anyway AFAIU. Michal, can you please fixup the kernel doc when sending new
> version of the patch? Thanks!

Yes, I will. Thanks for heads up.

-- 
Michal Hocko
SUSE Labs

