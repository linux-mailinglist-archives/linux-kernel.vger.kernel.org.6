Return-Path: <linux-kernel+bounces-246511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1788A92C2EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C081A1F23696
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8717B047;
	Tue,  9 Jul 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="loSr7xEV"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50617B02D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547816; cv=none; b=XKUyzqU7W/d2IrBfvOFA7etVhFY+BX03ZN6anVWLSfdQGagsedokXfg6Rjci643I2hG2PXB6sByDIADt/FvehtwIwrwCvRPmQ0NkZ85GrxzEnQdxKIM3OoLDcPFBPNwrWZtpuuqWGvW1/9wrT6IIiGYtF1ZnsbfP9q45LQssNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547816; c=relaxed/simple;
	bh=7ct6fmJRRthyBach+v0Gutk8b9CNRhWPhvYKKj1dkBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf2i4EE+JiIcWNOZX1+ODP+LKgfxMqBF8EUKWux8l/jWVRnBny+Q+CqNULbhNPqxaNa0xY/15/bmkkOjjk6WSa8bqCMOAELqoZHy8EGipeBK5DMsfkrmqSVPjt96o3ZnxQcET7JALvM6XVX+m6v+fYrP9afJF1S4CmOrxVLLd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=loSr7xEV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5db7936b3so29684846d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720547814; x=1721152614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27GNx3rgssthvowIuYiHcRneaeD/UKbqkigSyCrQmiY=;
        b=loSr7xEV4c0ywwFhgSgOWa93gRWIgXyzYr8Pye2Ecz8a7IhFpdUeN+eKfn/RJ1Y8j7
         QLkmjjxufuLadEtMLdlAYmVYR1bpSd8kSJ3GNRMPyLBcOoNFYB7TJNP7hTdw6KHi677B
         Rj4n5fFrfw4vvhtZjV9K/67kv8F7AlEF60b+/+oulEY2TsUcxui5XWCJup4Rj87xNXot
         ei3r9bFjaeq4LGwaySwVE5L3boh62VR7AYIaYIVaRxasZYhxkFrjZM+8mQQGXPOIm7MX
         jqoDsyd81BJctDKKMkiXrp21S84Lw/wCnHGb+x4lyGAIBpqq/lX2EVfvQrzS3lFpyn6f
         gm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547814; x=1721152614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27GNx3rgssthvowIuYiHcRneaeD/UKbqkigSyCrQmiY=;
        b=Qm0n6VHTlDx4Ns0tS5lLeF608ZFwSvCBHp8UBjJNnycg81lZSBbKuFWdIudz/ktrih
         neCo4+0200kd/jz6tJ3yjRMAWui292YhIGm4Fpg5CDlrOr36yzcIzVAEfPjsuuPqxlvT
         Bk3zEdIVaI8k5/wEl8moqhmvo1+hnmEcdJ+wdw2XvMFy48fjgSvZP12L3O+WahdZFZXo
         IXbnQcrYn5AfI7Fe0hXZ5HEBeI9NS0aR8c6MYphLw2v9pkfrMlHL5DOFATeV0dHMjzDI
         7p2xGz6m8Ops3dny8iPMI/lzWSeUewSbR66oWlZR9b+UjQbqlgmq7v0UZQFH7A2r5EuN
         Cv3w==
X-Gm-Message-State: AOJu0Yz95O90CJ174fel0QIAuW8h+tuNHMM2gO/hRxnxIGuFfk3ce0I7
	vHbdl0w95Qr+N5if9ksmJYhbHq6cwfratsO9l2BOwvvYu/O1TLZGabGpA4YooJ4=
X-Google-Smtp-Source: AGHT+IFhIi56Uc36YELLWajaoQqFRruybsE/k0kAjiGitoyDDRkMJoO4aEf3TSXtrlW0ke9B7QICQw==
X-Received: by 2002:a05:6214:240f:b0:6b5:e58a:6388 with SMTP id 6a1803df08f44-6b61c1c50f0mr41549816d6.46.1720547813948;
        Tue, 09 Jul 2024 10:56:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba047efsm10796556d6.58.2024.07.09.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:56:53 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:56:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
Message-ID: <20240709175652.GB1040492@perftesting>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>

On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
> Hi,
> 
> We want to be able to mount filesystems that just consist of one regular
> file via virtio-fs, i.e. no root directory, just a file as the root
> node.
> 
> While that is possible via FUSE itself (through the 'rootmode' mount
> option, which is automatically set by the fusermount help program to
> match the mount point's inode mode), there is no virtio-fs option yet
> that would allow changing the rootmode from S_IFDIR to S_IFREG.
> 
> To do that, this series introduces a new 'file' mount option that does
> precisely that.  Alternatively, we could provide the same 'rootmode'
> option that FUSE has, but as laid out in patch 1's commit description,
> that option is a bit cumbersome for virtio-fs (in a way that it is not
> for FUSE), and its usefulness as a more general option is limited.
> 

All this does is make file an alias for something a little easier for users to
read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
necessary to do this in the kernel.  Thanks,

Josef

