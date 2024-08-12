Return-Path: <linux-kernel+bounces-283819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82794F8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5752833D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4E1946AA;
	Mon, 12 Aug 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+SX+yV0"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE054759
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498419; cv=none; b=YJYcpFp3IxHWemQDDBjsly+rZe8ot8Jx4WHmM/tNaZskX4z8f5jkCIl4UVpT5zfzsG+10D7Nc90GFdM4dcGG46Ls6BmzXuMyC3tmQdXT5qtFwmqqTJjhcOE0zIIhDwwRajW/m+H3iR1Rwtbb89h1VKscm3TYPQjmRvrjiPsc6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498419; c=relaxed/simple;
	bh=/5Q9vfmaVgqsrhTOZAnYo2hvSCmd6kfiVXfcTEk5Cdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gB4KQS5HAgVivSy49xkhV5roAJccu0YCNYAK/6XAIK8wUfRUv816K844T2EhcwoIGDiFl20tJpPMQ5yXL/s0c9qpLkq91ZJhSy1huNCjjhiAisBO5bJwFN3A/J1WDe1da777M5r+w/6Q6ibCdnX9cXMlLQJdQjgawj5sQxXgwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+SX+yV0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-651da7c1531so43882477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723498417; x=1724103217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5Q9vfmaVgqsrhTOZAnYo2hvSCmd6kfiVXfcTEk5Cdk=;
        b=G+SX+yV0s1mIlEMQZKD/y6W0rj/6fKDVO1pBYpSRHH1dufWYlKfKV6YRL1224Wm94j
         fzgjnR8mg0bQ8ip9qjc5ZHbEHqdukfB4i0EkVjNX4hanRnN4fjL2nsVSUc7IX+fD+Vdd
         3myS4QRfFh3ST9ITXqmwq2OJtl/Vh0m2Vvuf8cy6iVJcrjocruw/6NezABwq/YRVK6qb
         tkb/Bh3D2BkpMTgvvCmbhwfL/sUqInMr3Y1J6YBYswBjCYf/00ye8g5PDXiSkzGFBrkr
         iP1oXMo7Z2PaWTdgI8j8iWacnKoaLrhjiI1nLRZLFHuen58BxsuLYwRqep0JB8OBsLku
         5/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723498417; x=1724103217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5Q9vfmaVgqsrhTOZAnYo2hvSCmd6kfiVXfcTEk5Cdk=;
        b=gCyab+4UsF1IJB+8p+9TQvI3ryIl+J7DdmMzSiJxr3ttZ6LwSWFYtUucAjZFobeYjZ
         cUr8bmwyLRCR8M8wozni+Hq+AN/2+SSjzJYZZ56QU3EcX5JKkH9/+lY0MkrKBfaLwmtu
         FozQjc0guZFMk9O1TYffWs9KYOoxe8po3En/ZQgX1mNPKagMJL5fuhpWbKPpuJQgIOqb
         QGF/W8CFxiwtK9aDYgB394ociJ8xO4uqbbdK1vTUM+nAk8PJX+ksXQPYSyJOxiHnEnIn
         zj68T+9vzATVCbhnV+phxGJ2lXxXE8LJMTk6gvPS6BacdCf48bJOUDHOzwBadjBThODI
         D+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWCJPiPoiJzrPSpSDyKP7k0GXGDX9xsrRud9Vg1YVRLT62JUp7rpf9XNAZ736fDDEU0IVU11SYsAmd++Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7lUXx0W2Sn6YeC5y/flHp+Lkmjh8Z+sclH4AOzPe0SP+NHkr
	DKbZ735N//TclREErn2R5O1zysFntHQ9AnpFym/lAB7tRL1et+1UXFh79QN4ciXVHgn/ndJuU4o
	4s3i54K6Fb3QO1BdENv25divNA2mma/6SbVbe+Q9IpMALQKH5hTmy
X-Google-Smtp-Source: AGHT+IHx+CMwXHdpsKjA23zMjprnRlc2m/dc/YqFXzfi45wEc/rWMAaL1YIxZHr+tHYMUGUFGgHs5V1oX8Kb8XJxyEw=
X-Received: by 2002:a05:690c:3208:b0:65f:a486:5a61 with SMTP id
 00721157ae682-6a97267306bmr16909747b3.10.1723498416968; Mon, 12 Aug 2024
 14:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com> <CAKPOu+-8DXbCSj1OiWbS6+MuGPN9-kgsFkWn=hvr2cFwaDEEqA@mail.gmail.com>
In-Reply-To: <CAKPOu+-8DXbCSj1OiWbS6+MuGPN9-kgsFkWn=hvr2cFwaDEEqA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Aug 2024 14:33:22 -0700
Message-ID: <CAJuCfpFfLjqoP1ojkUU9uV_2QQ43CFXD-2fkjoZk=Sg8iWVkBA@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:06=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Aug 6, 2024 at 5:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> > Hmm. The original scenario I was thinking about when I proposed this
> > WARN_ON() was deemed impossible, so I think the only other possibility
> > is that the task being killed somehow skipped psi_memstall_leave()
> > before its death... Did you have the instrumentation I suggested to
> > track imbalance between psi_memstall_enter()/psi_memstall_leave() and
> > to record the _RET_IP_? If so, did it trigger at all?
>
> No, unfortunately I did not have the instrumentation because I don't
> know how this works (and didn't have the time to find out). If you
> have a patch for me, I can merge it into our kernel fork so we have
> the data next time it occurs.

Ok. Will you be able to enable CONFIG_DEBUG_INFO for this test to
symbolize reported _RET_IP_ once we capture it?

>
> Max

