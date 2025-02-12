Return-Path: <linux-kernel+bounces-512067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AAFA3339F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F89D188A957
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FB20967E;
	Wed, 12 Feb 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ldvvc3op"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137E126C05
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404009; cv=none; b=LowK+ELfa18IgN9JWiRcbLvNxAuk9EiJw6LO3ubvtqJ82Kf3dSsAMqvLrU9H6TLHOOWaGI2+duxP7ZzVeTdGDZXB1SaovehQtMeSJ/ijBXy4CZTabzFBYlExqHDmIwmyd73oHgorNcD+9YoGyGrRRHpzoobq9VvyW88t6ma9Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404009; c=relaxed/simple;
	bh=o6FDtd+rlSa8IIiwz0tvMUjI0siD1ajnHXHA0qLGxTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJesRoUUMwMuqhWvU6zHkeJSZM7zm9wz4jkWR3mVcrfmEkvBMjAsj3OVZXSNZOzqT/1sSrbKU/U8NlYbMLpJ4zn2evQy75tagMCUR1diYdEmLsaVfF5QQ0EgFijMKoMGgNf4fzcwbno5P+nDhVAYKQtX4cQYZl2oGNGpq+vhCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ldvvc3op; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so75478a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739404007; x=1740008807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6FDtd+rlSa8IIiwz0tvMUjI0siD1ajnHXHA0qLGxTA=;
        b=Ldvvc3opMEZidGkydWHylsEzqF9pl5POspaUypyrzogGSdVRg1k906P1tyBs39rV6t
         qy+yFdjmO2ZkGbcTDRluUjoeSE5PsOQPpCOyb7OGh/luPH1HndqcbxcRbDM7h4DvrvEo
         qu+JY9hte81bH/6nPOnO5PPauKr3HE9ayDeWI90gbiNwIjkg9frNRoZE689CXtKgiPve
         9Jix32Joj9UpsVCdSnX8N1C51gnYybD+DVVVdnrqlLLyGhrKtN+D9qS1TrcyUPN6iFOT
         i0mTugUbkQkd7NQKmDlDabXKFFJdPkqC9uncChgS9u3V3nJtlOT+DKuxAssJj27d/Lx3
         HWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739404007; x=1740008807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6FDtd+rlSa8IIiwz0tvMUjI0siD1ajnHXHA0qLGxTA=;
        b=XBFSAyLf9pnfNqhNtGdvjgRKXqairtr4FvBnm5C6QVqjDxWrnjta0ROnbIdCrkoNfY
         mO+TUJpmriNChNEmIqNH1mELF5mzSzmnDeTda3ilivbWqZO16VvcNwBc6vIkUMEovcZ/
         /MtKwXjvBuFQspf2it61C4HDIpvKC4s0y/Hwr9NSnW1C9W7969A4vl+Ke2AQngyLYBJn
         rHun+pjdHnLESVjUclXYbqM+vzlF+D2sm0Ome/zc9ACY4sMo6/pfgtlXBb6kH5cOvSrI
         1Sr98QdeQzNVniSssuFa7SzC+5sZqQxiUmCtM6qtoeMU0KXTecjIHgMiyBZs5BDQXYeh
         zVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEBHNoSRgLB2VRd1MpEj3lFz2CCeKKQ4nu3XHYw6j5PPCNS6jx0qWdylSzhF0j/Y+mfFvH4OJkh+qthcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+iHyGCuGp4S6t9IfXFZJtU3BEkfrgZdGPBwGk2RY26o4fIPO
	gr3loyJleouzrhuWCL0SrEUnba1bcsliVuvGQvGQgZIu4yHYA77Z2F7DOBf4pi6meSngm6H4gZ2
	0r3lBaWzHFlod+NO68XysNUwK2mx918LXRvmeWQ==
X-Gm-Gg: ASbGncvC1MP+PUo4Eef+7tsRCF5XtlenORgYg89X3s5kVwsWPjjmGG1/BsSRF0Q7TTt
	kEZ1H2/BhzQgdGyHztVfqFL/h7USySyENwzrjkKGZnMko6cFnXTi2J72ek9K1tOGmpJBxOgU=
X-Google-Smtp-Source: AGHT+IFUzD6F21FEiPi2oFeL5AqMhJ27H5M6NGdg1O+UC3vP8pRfnkjBXARokV8Obb0d2BBChyHfyOpmrmhnjIGPTY0=
X-Received: by 2002:a17:90b:3845:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2fbf5bb8de3mr3010403a91.1.1739404006850; Wed, 12 Feb 2025
 15:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212204546.3751645-1-csander@purestorage.com>
 <401f9f7a-b813-43b0-b97f-0165072e2758@kernel.dk> <CADUfDZqK9+GLsRSdFVd47eZTsz863B3m16GtHc+Buiqdr7Jttg@mail.gmail.com>
 <999d55a6-b039-4a76-b0f6-3d055e91fd48@kernel.dk> <CADUfDZrjDF+xH1F98mMdR6brnPMARZ64yomfTYZ=5NStFM5osQ@mail.gmail.com>
 <Z60s3ryl5UotleV-@kbusch-mbp>
In-Reply-To: <Z60s3ryl5UotleV-@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 12 Feb 2025 15:46:34 -0800
X-Gm-Features: AWEUYZnYCZGJbY6mpKpWZGNclaPT0GiXmiIEetwGyU1NF3JZsUGwzvo9IcWcJjg
Message-ID: <CADUfDZqa5v7Rb-EXp-v_iMXAESts8u-DisMtjdBEu2+kK-ykeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Riley Thomasson <riley@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:21=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Feb 12, 2025 at 03:07:30PM -0800, Caleb Sander Mateos wrote:
> >
> > Yes, we completely agree. We are working on incorporating Keith's
> > patchset now. It looks like there is still an open question about
> > whether userspace will need to enforce ordering between the requests
> > (either using linked operations or waiting for completions before
> > submitting the subsequent operations).
>
> In its current form, my series depends on you *not* using linked
> requests. I didn't think it would be a problem as it follows an existing
> pattern from the IORING_OP_FILES_UPDATE operation. That has to complete
> in its entirety before prepping any subsequent commands that reference
> the index, and using links would get the wrong results.

As implementers of a ublk server, we would also prefer the current
interface in your patch series! Having to explicitly order the
requests would definitely make the interface more cumbersome and
probably less performant. I was just saying that Ming and Pavel had
raised some concerns about guaranteeing the order in which io_uring
issues SQEs. IORING_OP_FILES_UPDATE is a good analogy. Do we have any
examples of how applications use it? Are they waiting for a
completion, linking it, or relying on io_uring to issue it
synchronously?

