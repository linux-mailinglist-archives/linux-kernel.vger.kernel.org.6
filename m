Return-Path: <linux-kernel+bounces-522620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2DEA3CC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C507418886DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5B25A33F;
	Wed, 19 Feb 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxFzkK8T"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C325A2D0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004676; cv=none; b=Upr3W/5iRP4yAdbBfBZRactBzJOCf+Aola4lEAhIsCdemMy3Teu1/DidUR313p6Ur7x8UfBBpMsXLidyB3Mx9kYX5h+yc/EXicmItdCBvIW/cgmWuGF5AbOIrTiamao7/yvUbVAd9snsfFw3jwBFYeDEBoZ/82Wfw5zwGWUPmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004676; c=relaxed/simple;
	bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVZg+DIv0Qbokse0ktYlqHDUQ0KhzGSjyON72OxMQOrd6JvEBmjQHli/zkiCIZNGJlJBhDOyUliF9zXdmrfwb34rYTIRrXkTBqZIFsUwFFO6IJWHOpAGbDhDXLdasNRvIMHMFEmYrm8szVlhRYStAo/q0mubh1dFRVzsv3/T6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxFzkK8T; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f6ca9a81so21775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740004674; x=1740609474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
        b=FxFzkK8TDjMNIhLyHbRwJrY1oyAwbBO8K3biZQlohguwAfElOrr20O1bh70oFEtOkP
         6E4m14vtwU9lnRhh4B21zyb65wvybOnUZSQt1RXr/jAUXqfpMm9BNMjCQyV+pFa90RUB
         l9X/84Iy1tgBhDNrCYqAfWgKEaiJuV75gYwuO91tfpOWbbLbiPKkb4VO33o3kmZKNk8y
         0MA24y15gfRHwadSztUXjDL0zCbTgtr4mNZVnT3iJchkYwVsx2eyw3BnhJ9ABSbKkUth
         RhQXsnxmqCzmCR+btGg4O7/9JeVquLWz1SKNUHCHNOYXesQNEcMJcnmwe/JpI5xLd6Yz
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004674; x=1740609474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhC3wygLORR7zsQGDIm40sQTPhR9KgGwxGKhnkJUH2c=;
        b=lKK5xo010+HVmHhtU0uwpCRMoiU5WQAubPGloDbvwCdhghs7o02tj0ZyLUcFI6MTwe
         Uq+pT+A97V69XnSndJwB/eLiG5lxdxjOco+sAhkxV5oxfuqfoFmGBrC/trj0fZN0UnGD
         ZUgtoZNJgXRd8xg4TQC/wGFy7mIDX8R4n2Govdkaen/VW8B7MPHifVsSa6VJPb6MQnDz
         GcWHjK56GRtj3M8A7H/YoPpDrDLQfCi2ffmNVS+112uUkBEBKh70DKkCp8E5LoKic3UG
         uDYFGO1raxjz2MJdz/hH31TTY2pI6cLoFfFsQ2bR/wJBCDDDZU8Lsork0Rc1qqcvHkF2
         KSlg==
X-Forwarded-Encrypted: i=1; AJvYcCXdAO04WyeS07dnWPtL0zwZ08+SHlG7Uuob3j8Dm9/K8ksryDTb4df6kLh/9If4gEO01UAe0lTsQyb/Tfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBoZu6hETHnHBpXIvFmHr+nBL8BAz9AAG7IhhbtYlEO2Htqwx
	nBhyOnJnjxPGB1n2SFNFHrEIBYBO+aPYHlUjlOWG53YSMsecP0YB9UhaBnF7bJAibmENDshQs/X
	pwotWUlBd8sUhrZMGVPPu2T0yFK9HhEFMjoCG
X-Gm-Gg: ASbGncuFlgSYWPuPHkAnrZBflKusF7kKNaGK4gwrdi6GMHo5q1QwQE4PQdCp+apM8E3
	D7/jGQY9M2RXrRRJA3pZiWeb/xulQiXT+Inv/El1Wf0qLw2FV6x7tJJVb/aXmuMmnLkdApZHT
X-Google-Smtp-Source: AGHT+IF0adqp6BJMWWYjgKq0IW4QVon9hnaPRO4nKLT+UDkOqC0hTXFQIJZpY/Iok7FAftfcxyKvXkHOsRQJ1NFPF64=
X-Received: by 2002:a17:903:2289:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-2218db4dd79mr890985ad.6.1740004673917; Wed, 19 Feb 2025
 14:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219203102.1053122-1-sdf@fomichev.me>
In-Reply-To: <20250219203102.1053122-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 19 Feb 2025 14:37:41 -0800
X-Gm-Features: AWEUYZlrz6Rk78gsxnJsp41gH0btlBHazQiyiMfwOnDCCxkT-y3JHO_r-_Y-uqA
Message-ID: <CAHS8izNWx39025Hm=cY6JDDL-VY1ggKWsx0+RvD-NCHULTT7sQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org, horms@kernel.org, 
	kaiyuanz@google.com, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:31=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
>
> Consider the following case:
> - sizeof(struct cmsghdr) =3D 16
> - sizeof(struct dmabuf_cmsg) =3D 24
> - total cmsg size (CMSG_LEN) =3D 40 (16+24)
>
> When calling recvmsg with msg_controllen=3D60, the userspace
> will receive two(!) dmabuf_cmsg(s), the first one will
> be a valid one and the second one will be silently truncated. There is no
> easy way to discover the truncation besides doing something like
> "cm->cmsg_len !=3D CMSG_LEN(sizeof(dmabuf_cmsg))".
>
> Introduce new put_devmem_cmsg wrapper that reports an error instead
> of doing the truncation. Mina suggests that it's the intended way
> this API should work.
>
> Note that we might now report MSG_CTRUNC when the users (incorrectly)
> call us with msg_control =3D=3D NULL.
>

Hmm, this happens when the user essentially lies about the actual size
of the buffer I guess? So the userspace does:

msg.msg_control =3D NULL;
msg.msg_controllen =3D 100;

If so, I think the user is giving obviously invalid input to the
kernel. I think the user getting MSG_CTRUNC here is fine.

I prefer if we handle this edge case. We could have put_devmem_cmsg()
check for non-null msg->msg_control so we're absolutely sure the
resulting put_cmsg() doesn't fail to find space. But I don't think
it's very critical to handle this very invalid input from the user.
MSG_CTRUNC in this scenario seems fine. So, FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

