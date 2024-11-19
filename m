Return-Path: <linux-kernel+bounces-414325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FE9D26BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA476B31B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FBF1CC178;
	Tue, 19 Nov 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dbTnPrHD"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8301C2454
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021350; cv=none; b=ckSSvr7s+1hMSZQFuaJLJ51EtGbpikkvQtcjn6UXMHUO83JCpQ8qJgicxjQQHK01eEjsN7kh9K+7OpAvcnsUA9O2QYOEOzaW4rRjXYuJbHFRhznvuBAr6k69KVyEBn0f8p7pfLepZRezuOvr1qogAAdH3CX/bHpwSoFw0dIWSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021350; c=relaxed/simple;
	bh=k8xRxnqYVuI+r7edN+n5q6UpqC4TdTkm7YjB2vRIXcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baejMZcKDESc7jHWYZcTVMzbhZc3OFTVmVbZ5AGgT40ELCtfEik2gy66FCoxdCr3NfrxbGYn88O4b1KMbAgTEFzUxv9l9DGKUjNp7lqaDOqZinp/HlEFhzrhE8Zw1blhGPxdrOSyMak8PkAc+NeZ2BjWg12bUPqJRsRVHPFHMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dbTnPrHD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e8522c10bso871427566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732021345; x=1732626145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8xRxnqYVuI+r7edN+n5q6UpqC4TdTkm7YjB2vRIXcA=;
        b=dbTnPrHDV7juxqm1qzkhKVgansCTBk7zNOPWD9OWD8eB9Ajn97CikcsmPLkaYN5r6J
         QQMHs3Wr+A3LhznMl1r2VugX6fwzpJDl6bkSRxdQSxl/MOCQXCZr4kkvoZkTGtjRvZ1u
         A06zCwoLcdgRM9nWc7f/yQXySf0PjFCSBbmhlpr3Riu6OZhDmuO+Uy8BFGA/Q8vzDksm
         EonqCts7M7pjyq3uFlfbbtCo36gjK2Zp+Rp2tIyB249DoIuUUkd9/KTJpUs92uC9gP0L
         a4MXSdCv264RfK/JofzodsJZ1QFBawH49z6Y2KhOB4fimVVJh3a2MblqQ0p7E4fiLp8n
         AVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732021345; x=1732626145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8xRxnqYVuI+r7edN+n5q6UpqC4TdTkm7YjB2vRIXcA=;
        b=kqs2K1u0wS4i82P+wX8k+00RH0y2Ue4fi5HBg9edOE5mfqtS9TDlqeVMveO1UYmeFD
         /j5SBVBhbPwtjgs6wf/3KeOE9B+ALUrhBsboICJdGDB5znPjzBX3qHh6lxat3jTT9B0l
         82YP/rvDmQfC/CnfNMaFGtLhBrCAesBsmSGIyt9GbabY9YTJYvM8aX9LZUStjV+M/pNR
         YqIqmHgcPx4MsMdox2yDipJD4QPHjbTPHP7GotPCl7ClmML/ZyVidOCIS79+BMCe5ase
         IB9RdF6Q0stIqScKHB0+X8kllqqeHKAqSu6Ip+J7uvcMJcsheL4L2a6hohrzNXwMPbdk
         i2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVk+2mhTx4zPKFBnaqV4gF6Xad3QO/RE9FUdtIZOhw+mFAs5WwsNXwIgtjk41Rn18hJQeqq1/99hu20AGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38X6oOPSh5oGpFvAP/g/HC/0OyxJaVbJfiknlEcOqdQ0bggzu
	PP+3pfhu3h3Tg4leeEH5rlEqwzMj6mGbZ4K/MFA5TvuzQdzfL0p0hjGXEze5LNYNo9pGAA4CYKM
	NNHjDuvx6B+2tt4GhlAVkBuHc9++iAVLbFFOSVg==
X-Google-Smtp-Source: AGHT+IHPqFH9NJsL11VLNRVzzjsfqZGSx8ZJF7O/FDK1wGTHOoOyscQMd2ARzUVmBNyd6G4ApL/FrqYfGFsam3uMdMM=
X-Received: by 2002:a17:907:3fa0:b0:a9e:c4df:e3c9 with SMTP id
 a640c23a62f3a-aa4c7e7c2bamr293614966b.24.1732021345431; Tue, 19 Nov 2024
 05:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com> <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
In-Reply-To: <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 19 Nov 2024 14:02:14 +0100
Message-ID: <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dario@cure53.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> -ENAMETOOLONG could be problematic there. This function is often called
> when we have a dentry and need to build a path to it to send to the MDS
> in a call. The system call that caused us to generate this path
> probably doesn't involve a pathname itself, so the caller may be
> confused by an -ENAMETOOLONG return.

It is unfortunate that the Ceph-MDS protocol requires having to
convert a file descriptor back to a path name - but do you really
believe EIO would cause less confusion? ENAMETOOLONG is exactly what
happens, even if it's an internal error. But there are many error
codes that describe internal errors, so there's some prior art.

EIO just doesn't fit, returning EIO would be confusing - even more so
because EIO isn't a documented error code for open().

If this is about building path names for sending to the MDS, and not
for the userspace ABI, maybe the PATH_MAX limitation is wrong here. If
Ceph doesn't have such a limitation, the Ceph code shouldn't use the
userspace ABI limit for protocol use.

> You may want to go with a more generic error code here -- -EIO or
> something. It might also be worthwhile to leave in a pr_warn_once or
> something since there may be users confused by this error return.

Users cannot read the kernel log, and this allows users to flood the
kernel log. So we get all the disadvantages of the kernel log while
our users get none of the advantages.

