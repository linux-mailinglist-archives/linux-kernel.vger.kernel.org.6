Return-Path: <linux-kernel+bounces-572002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069BA6C549
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B5C178938
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8762231A36;
	Fri, 21 Mar 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D3YWjS1N"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FD2A1C9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593113; cv=none; b=L1GD8mnA8iOZiP7dr+Ynm2jOgHMhrGlal0/o2v+Irx4XQJEd0JJ6exVPznZF/4N/5GVYkHEWLedkIbFVHqGwLrKoWjbzqEe7DylzMGTo5YP+Njlz5qejqEy5DyBYXPI713EnHPCilTU4AMzhKIwRbLWw2mhXmU4wruPyKqrWyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593113; c=relaxed/simple;
	bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZoAfXgO/htjvlSG+sqqcDwAyzEVxk5I03QyhjMeM41KTpyXYy5TsLJlglENTJU+cDQFliEaGYzurHTv74YvlmZMl5zk5/MpORyz1KNPFGzJS+S3sevmbn+iH0We2YkKaa/ynR3yRiV/wjTWqVCCA9cBFalOXeZtKgIyACWoTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D3YWjS1N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc3b5so6494025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742593110; x=1743197910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=;
        b=D3YWjS1NLsOrQQgbH7niTFYfhZE0Njg3cCEj01M2mCK3fDbRsGWAP+kVkScg8jXePb
         6Pzo3q5IwnaRm4YCaru+xtjxTLS1A8iF8OGFAxtceJYxoHQMnJ6eVxnPUJzz1TWHcB2O
         fKCkkh04HcG7FOpKKvy7wfXPTgEkxiGX5gOwA1VQUAjYDDHqYNPOSGaXhNYebj+Pymgr
         ILiwVRYYoZlpqgl3X0PMNpVjT5axrDs9dsFk75R6leq4hJc47nTk3/fb2If2aCKo8IJD
         A+ZzFGMNixKLEe+i6s+VOqJAphwpw/OpDJqg4tpTM0+VDbNbmhXpqFt0Ba8NooHCKlBd
         2dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742593110; x=1743197910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8PHm04p4vmMdRlrDb7etA3hydAU6JK9t4r3Yd98L8=;
        b=v3kDwUkbxvy22ElTQs4yXpCwThNFDkF3y3KWCNxTbym/7joVJh7Dlhc5J6Hx2KEkDe
         ZrA6OLus4LTzGBLi0YpVirLLfO+IsX34qb0JbzAC/brzDkoSXGWLOn4HrPgjKOoRonPV
         Wxsw9gKYgDy55Bf0WruxWufJQZU3/ZDK92GijBE+GtQURo/bAAsJXzDtEJsu3hwAOeXp
         M393iA91+XZTghulg4biw9jjt/yYt7Lub2N/SmQ0BLFX72ZnXpRDCObV2S3ftvwrcS0B
         dat3Cn8FH2jV4Mk8+WBjyVo61zKh9VV7Xv83GdVzP4dZAUoTnWhEfviRJuW+nhJz4CfP
         pn2w==
X-Forwarded-Encrypted: i=1; AJvYcCV7tqetnciiMV+F1bHGiqx2diZLyAy2Sm4KIaB3ywFtA1sygHLXuOLAjMcsyctJaNfdK77qH+67s5g1cCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqO3DbOT/YZvFbWE1nLYSvdExFdFCpyfUU5OF+l4OjvulANs07
	Z8tEnm3lwzmzPytw0FcLTp4cL2+XQdCOkkuchON1vqBu7K0SzK5Pgm5g0/svdhVvEEVDpZsO/Wh
	WSUGhn0FlRIsCCydKbyU2ygo/nHp4Y5sD4l0rRg==
X-Gm-Gg: ASbGncuAu6XqP+hsq6v4ha3MGkgNcMlhKdPqMXBOxGmCKSDnVJWaxcDSb+0ZN+2gNs4
	Ks1BbqVkzynIljUwDciNYE+NnZ9bWV8i4qS65YJui+7+FiOjAi7ba/cSVzrdLXYJcXDvy4saiy5
	ybLPu9ij5xnThG79Dx64B5YWyP
X-Google-Smtp-Source: AGHT+IGSk+bsBxz+JO9UqX1StGRAOw80slB+xBi/7szzHuQU/IKincKxZ1fz09uQ/n1u+YujF0fQ7TN14YtlTnBH7/c=
X-Received: by 2002:a17:902:db0e:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-22780c7cad0mr28361055ad.5.1742593110608; Fri, 21 Mar 2025
 14:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-4-csander@purestorage.com> <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
In-Reply-To: <8338ac70-ed0b-4df5-a052-9ab1dfec9e26@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 14:38:19 -0700
X-Gm-Features: AQ5f1JqF7084HWCX45pZ6paHlx6q6XUtczTCEEBO8pEFGjQNkwueLYbERoxLSfY
Message-ID: <CADUfDZoELiri8Fuq3tHSsKf1XhPVaZ1eoCzfXK7g994VY4o9Vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going async
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:34=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > For uring_cmd operations with fixed buffers, the fixed buffer lookup
> > happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
> > implementation. A ->uring_cmd() implementation could return -EAGAIN on
> > the initial issue for any reason before io_uring_cmd_import_fixed().
> > For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
> > which can return -EAGAIN if all tags in the tag set are in use.
>
> That's up to command when it resolves the buffer, you can just
> move the call to io_import_reg_buf() earlier in nvme cmd code
> and not working it around at the io_uring side.
>
> In general, it's a step back, it just got cleaned up from the
> mess where node resolution and buffer imports were separate
> steps and duplicate by every single request type that used it.

Yes, I considered just reordering the steps in nvme_uring_cmd_io().
But it seems easy for a future change to accidentally introduce
another point where the issue can go async before it has looked up the
fixed buffer. And I am imagining there will be more uring_cmd fixed
buffer users added (e.g. btrfs). This seems like a generic problem
rather than something specific to NVMe passthru.
My other feeling is that the fixed buffer lookup is an io_uring-layer
detail, whereas the use of the buffer is more a concern of the
->uring_cmd() implementation. If only the opcodes were consistent
about how a fixed buffer is requested, we could do the lookup in the
generic io_uring code like fixed files already do.
But I'm open to implementing a different fix here if Jens would prefer.

Best,
Caleb

