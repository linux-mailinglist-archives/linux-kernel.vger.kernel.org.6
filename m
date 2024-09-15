Return-Path: <linux-kernel+bounces-329811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73797964B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C096A282C77
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3DB1C4604;
	Sun, 15 Sep 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bePWEp/y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253E198A1B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726395540; cv=none; b=k+H2IIcraDuIl0dzDs2HUPwYw+IOtJdCNnWwhNgRG86fcHhp87FnNLiqlVq6A07MqI+W+x99niHwXYzrHtNH40faYxuyiEvwwtZcgjgm/AmR9i6x7SwB7RlsEe7T5sWtj7HwsbgQIK38n1zEkc9WMLc0UZpwnIXVwxuqEm6t4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726395540; c=relaxed/simple;
	bh=5asS+9IROfr+gx/EpfDa3DPhIlJPUyQA2tTO6kw9JvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grSkk44sSKmHLY7tu55mDiIxN0yRylIDBoIFJdWOX6yI0CfTUDlH4Hor8B1nPnzM5psAuTFw+SY/pP1gNGDcq98syE4HTXBwqViFZVI081n3dMHTi2xyJjgr/WeWXyPbXnhFw/jqhB8qObRwhlwUi6WsGTByvatMGATt+I+dzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bePWEp/y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726395537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmbz14FTYLX02iYWpuHPfKuf/8mbf1kjNdoBR1mare0=;
	b=bePWEp/yPBv0DUc7ewtg8wnH8R+wkrEZsb3Y6FIG8kmq9N8L8rwIgPoDl4wC5F6xWtHBmF
	xXpdAtzuXg8C2EqjRwM1rSF/rV7gsd8A9HL17arr5XhqiEg19kBfKnk93nU9jRFO+kw5z2
	yD6NQXUNUlRtYLSkdOs08T0Qx5seQq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-BN_Iqd-gMmiRJBzj1Sqq0A-1; Sun, 15 Sep 2024 06:18:54 -0400
X-MC-Unique: BN_Iqd-gMmiRJBzj1Sqq0A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374b9a8512dso1956288f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726395530; x=1727000330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmbz14FTYLX02iYWpuHPfKuf/8mbf1kjNdoBR1mare0=;
        b=w/3J+P6qJbhmbfQ+UQOzFKeYcsZiQvng8Z9mhITRhK64+qupJKrdiDEHpbg2UlIS4c
         CBZfoke1SBGpMx6Y0vHbaweEivo1gElUMzVyt5XJleuJHakECJfH8Ogdhdub13TijFBA
         vJtTQORx07ASfJS5fNCRcASwWD9DXz3hFO+4AJx2u3lV7cV/Uj1630jvNx09VnR+vKiK
         vjaA0Iwf6XDP78Tx9RArkv3q92Yp2maiD7THEvfqzbWeL6/LN8DtX/5tfJhkPHvKtL98
         U6LcPSKn70WfsyrdYzIUEdPv+nyHLqvLBlElSu9NG6Kb3JEFyB04IWhs01sB31ebdU4K
         Z9gA==
X-Forwarded-Encrypted: i=1; AJvYcCV0CUyNGXe5iLIYVwHPNzUmwQ01mGMrNs4MYRPkuhZs4oLAwmUvcVJC62/I2c4wPRXcveoJwl4LWuJZSxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3f3bYM/9ZvOHla2svPfq6Mcgqcl75n2pkgYZLpgVRRf21M0fh
	/O1tbQlwkIX9y8hlhyZBUg7AXT24Wfj/6keOO6nnKiddZYl1Vnci3ubqgGYyEXOxGGOnC6d1VVL
	SFhjoFDcZZqdWrVF2pKQCodVjV6IFTdfC4EKw+4Ns3oQXDM1bwjiuFTZuQR7p+Q==
X-Received: by 2002:a5d:42c7:0:b0:373:54c:26a4 with SMTP id ffacd0b85a97d-378c2d5782bmr6228067f8f.54.1726395530569;
        Sun, 15 Sep 2024 03:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB48f7P6d5tWE1CN4fj3qaV7XamhtUAE7O9AfTIiv2AqG4TKhfjAP1n9uCEoD9oAMV8D21yA==
X-Received: by 2002:a5d:42c7:0:b0:373:54c:26a4 with SMTP id ffacd0b85a97d-378c2d5782bmr6228046f8f.54.1726395529478;
        Sun, 15 Sep 2024 03:18:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:64c8:bef6:26d5:abb8:992b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81a5sm4332957f8f.34.2024.09.15.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 03:18:48 -0700 (PDT)
Date: Sun, 15 Sep 2024 06:18:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+843fa26882088a9ee7e3@syzkaller.appspotmail.com>
Cc: elic@nvidia.com, jasowang@redhat.com, jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	ocfs2-devel@oss.oracle.com, parav@nvidia.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] possible deadlock in
 ocfs2_reserve_local_alloc_bits
Message-ID: <20240915061811-mutt-send-email-mst@kernel.org>
References: <000000000000ac4a9d062044e498@google.com>
 <0000000000000c5506062224dd83@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000c5506062224dd83@google.com>

On Sun, Sep 15, 2024 at 02:13:02AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a3c06ae158dd6fa8336157c31d9234689d068d02
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:03 2021 +0000
> 
>     vdpa_sim_net: Add support for user supported devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174bbc77980000
> start commit:   0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14cbbc77980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10cbbc77980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
> dashboard link: https://syzkaller.appspot.com/bug?extid=843fa26882088a9ee7e3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129a6407980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167617c7980000
> 
> Reported-by: syzbot+843fa26882088a9ee7e3@syzkaller.appspotmail.com
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


something very weird going on here.
don't see how this can thinkably cause a deadlock in ocfs.


