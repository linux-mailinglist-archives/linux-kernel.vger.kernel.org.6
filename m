Return-Path: <linux-kernel+bounces-307827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A798965366
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF27B22336
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E018EFED;
	Thu, 29 Aug 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QdlbIuDX";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="sGSHPI7U"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12918DF77
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974093; cv=none; b=r9eIx79pBIGa4ZKYNl3w5rb0CZdcPoQ50iVKhW66EHYoZcRcKUphYAaqX8n1mKd5Z8iWEJJ3G8+O/iy0sIdGufVE2arPYNbSGbhIBylk4GH6M4JvQGUUEzQYjYrRbqTiHvFP/VWIaQVUD2rsTZ48AygF7fhmdeBMD1zJa2xMtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974093; c=relaxed/simple;
	bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olRLiyL3rtCJ6nYt3rTu/DO8wvRqln6TmrHTaiuyvkuXWN6xF4oNS3EkVABbasmn7LaMoZ51kKwxXWlgoXI9r3bNe4xTVTWLZAXQlHgg7XcBtk0/nJEeKt/cnEZJzRsuMsNnYrf6jGOoHOL4QF77N8rzr/aNhrfhpoKp/74UOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QdlbIuDX; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=sGSHPI7U; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724974092; x=1756510092;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
  b=QdlbIuDX9UDeCqTLOqINdzXocYGxEKcFDcyKZjt3nsBeuC0WrRvomCV7
   3GbgQywTfBsR4/U+d3vnYvZMmh3XgA/6luJTTNO9+KF/dg+c9zLbvkSk4
   7HOPxWMTL+JE92RV7jjYbXAZKtyaIGA4m+5j/6t8SUUYtBozOHAxj/OBi
   4NmJeK8RBDu04jMDnuFtiYQ5KoceTY4cNzapDQyhxq0AbjGkQ/+/d0x0o
   ZW8JL6skBKUuBMXEH77xOmxbk+mVxoX10IBNeiugb3LA+hfWh15rmk8VD
   jB1Div1ypbDY7d4uCJybm9R6i4j6jUHkL8NhYYagg8DjChvyRZG36SGUx
   g==;
X-CSE-ConnectionGUID: EZ7ncPYjQbWc8tE4gh7yKw==
X-CSE-MsgGUID: +gvtA2nARrOrUcw5eEy1zw==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 16:28:11 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3baf38457so1970352a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724974090; x=1725578890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
        b=sGSHPI7UDGlPV1+93HNFNYLl9XvqGa4fU51cLNl+qmPAt6YHKg34Cqli2J1VLR8+7i
         MJGWwG+8/0JAY/mv5YD1+O/mRj+G545ywlfRP2ceNSMyC/lZhfAY18qzEr+ODhT4zlt4
         j9q5pE1qmzOpVW+B/+5FdKanf1GKA2qTx6FPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724974090; x=1725578890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPBGdzIUtqksQ7B6dOMgEsV38mKnXn6qQ25F7q2ECnI=;
        b=anhGovdao+CAaOwHSa0MpSW43SUC3D1rdIvlGJoZz/PFFg5vARKCWh/pasrdGu0aap
         mZlPvuwb0ecoiJf4yGJqtz03WNMiv4/4E985YhkrSe1lCaYEmjDqLgdaFbg+tE244f/J
         3tQcoNA4o2ckmfVBMBRsejZNenCGLkEKzKO9+qHX8FbfCxME83zEgTKlaAX9ezrrQiGr
         aoyCv7GOfAhU52CZFnn5sCq4olI0CyU0FHWFXS+0lJHZv+lOKvkiM/8IiI8AAm7l0aVZ
         bCCRkTH07PmyO7R5JLToIcUdnInEvIBYJ7D/4ZyFLMrGLx4jzFq+pJCakmxWqcXs6huU
         hmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcTBEb5H5oEU/XoUK0HZdeFqRizrk1XRUiF3OglHXhuQsEJTLRv8280itVxfw0Pu1Z91k+2t/3fwLdOzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlP+CIfEAFm2BcXAwrIBZLvotRZHzehKWO8VR3YRkuCGWk9PoQ
	/MSTJhBcgOu82luUG+TN+nTUIUFLfQKeTuAheAr0GbFBVs7jjyYIX0ROjuBCUPVCz7tPcqk50W9
	jivxE0BXygVqQNCXsnmOMqjWXDg8Gb4B+ehjRAIvFeUMAYCaL+4ecKmjgQkDKh8hRTF90p5BwPN
	VdfDxu4ZF5+82Mj0MMn8nJ5GK7cMgXO53UVZrdKg==
X-Received: by 2002:a17:90a:7807:b0:2c9:75a7:5c25 with SMTP id 98e67ed59e1d1-2d856c7e4e8mr5697855a91.15.1724974090038;
        Thu, 29 Aug 2024 16:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/ftKnmUjyZCuqOjMEk1OFSOiaq0Iaf0lLk96xUKx8Qd1ZghN5c4b5HHa1WIK0tLHqz2+6bwA7Ogb8xZ1NyYk=
X-Received: by 2002:a17:90a:7807:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2d856c7e4e8mr5697833a91.15.1724974089662; Thu, 29 Aug 2024
 16:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com> <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
 <ZtEDEoL-fT2YKeGA@google.com>
In-Reply-To: <ZtEDEoL-fT2YKeGA@google.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Thu, 29 Aug 2024 16:27:57 -0700
Message-ID: <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, Juefei Pu <jpu007@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Juefei: Can you give some input on this?

On Thu, Aug 29, 2024 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > Here is the kernel config file:
> > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> >
> > how long does it take to reproduce?
> > Juefei will follow on this, and I just CC'ed him.
>
> I ran the reproducer for several hours in a vm without much success.
> So in order to make any progress I'd really need a help from your side.
> If you can reproduce it consistently, can you, please, try to bisect it?
>
> Thanks!



--=20
Yours sincerely,
Xingyu

