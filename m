Return-Path: <linux-kernel+bounces-311445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5E96895B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8432C1F2284C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E420FABF;
	Mon,  2 Sep 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvffKDp6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02E19E98B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285839; cv=none; b=YcQTqfaChIf1NtvNehZdYqu71RX9cpzCv7bLEum/qsnzg4k5Lb5RhGjO9Ew2Q7aRBRs/pEIf3+m0IMZqEr+qeR51ZBkAXZhpLgu63LndgBTkT4c0FNF/EBGeV7BpUcrHU7CL5NWeBI3I800up0Y7haDVzod0qfBWnMuqSWnYbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285839; c=relaxed/simple;
	bh=EfAiz+U5BMU91xVLXAOVgtEAjJF7vM7H40UYKo/7Tvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiNnABLq4rijUvfWby4hnEcHd7qJyX1bNoJCxmSxN1PchqE8ICfadCZhF09/AnkzmpmLCQPXzfGiVYK7H+LgGZGrUtp9gEDeGl+aDrAGMFeMxOiDcppoVoCHhHfowFvGuCSuh8vZDH6rPAaxA7GWWBrqT+Dh3i+qj63SCdhF29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvffKDp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725285836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKMsgol2U4wBS9UHrpn0GIEdQ1ZBDSf8dOGayq9yXeU=;
	b=VvffKDp6+9U6BkmkuF5XxVolv9wVpEFCGsgPfB53oh3hLARe5jJ5DP4K+37MP3TzZBRpBZ
	a340uvROMYda5ScLUd7zZaRl2hQ2eiUnpEDlf7FpCV/mpFrTEtIXrNEzpt3z2owPpmWDG/
	rs9C+mtGDiP+AdjntVRaz+kkHxlcR8Q=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-wxgQZriNPXie1h0798LZsQ-1; Mon, 02 Sep 2024 10:03:55 -0400
X-MC-Unique: wxgQZriNPXie1h0798LZsQ-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso8755658276.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725285835; x=1725890635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKMsgol2U4wBS9UHrpn0GIEdQ1ZBDSf8dOGayq9yXeU=;
        b=J7h9LMoVLGmuFUuKN0XwMwG1kF6+W6bewgtgxpLPgwqHWe6ofXUBbcmhMclrFc469T
         yIGieWZZsiHHkMi7WzKHus19Q8WlOMqHRpmYpNdW9sQJ9+DRynCHAMccN8i4Pp4+DlC4
         CreAboTtBiF8YCp0XjbsZ5ZXmqE6dZ9ad2QxTLUro0JBaY0lM+1+35VFtPS6bmbMEEDa
         UR5FjzRxKZzDGet31ELN8grie20EvS38707SWZ3C554Jw2muSoUdL3QteC+EGFFOfNIC
         cmM7/3Qq9rIouLq3E0ESkECZwPYGOenIhauN06PGhbDxnmhJi1dGQ2EJXHffuFrm1dOw
         2gzw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEgbRvFOm+3wMOwX9CATskleEdy2T4IDLiAkDVbGDygw/Bm/d23PuZkHTgXrqjRbCX4fd9s3H5iU8E7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcy6f34hH/AduSuSEuAZZdBQQQwXvWqfarVlFvyRBn8rsyG1VK
	tuKS7+W0cqXK0JV+pbttoUAm4QbJrDaLQeBZNJaRubMqBq84NFSNa+kv5DBtmH122FqKuQR0s9I
	Q9wCn9y41fsoGb3Tu5C2OmVe1lKZkzTpN7POmq418+VbDOi4l/FcphsFcnfK6IForp5JLrikgNT
	PNq2+w/9nClYmwgnxdp7vi984OtB5DWhrGBCXb3reVGe9s
X-Received: by 2002:a05:6902:188a:b0:e1a:ae94:ee5c with SMTP id 3f1490d57ef6-e1aae94f12bmr5253847276.18.1725285834631;
        Mon, 02 Sep 2024 07:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQsacTnS0D6N6Jd10E7crRKUmSlm+76uBH6AW/8tQD4W84q7mKJMeHQ3fF0H9afXiZt4jGCLjMptVUMt3bEJI=
X-Received: by 2002:a05:6902:188a:b0:e1a:ae94:ee5c with SMTP id
 3f1490d57ef6-e1aae94f12bmr5253816276.18.1725285834272; Mon, 02 Sep 2024
 07:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133447.2853-1-spasswolf@web.de>
In-Reply-To: <20240902133447.2853-1-spasswolf@web.de>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 2 Sep 2024 16:03:42 +0200
Message-ID: <CAOssrKfDfUBt8YBqo3-Wivm1gHhv6B-6jZA2ifgDXooKf8oYFw@mail.gmail.com>
Subject: Re: commit 5fb9c98e9d8d causes deadlock
To: Bert Karwatzki <spasswolf@web.de>
Cc: yangyun <yangyun50@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:40=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> wr=
ote:
>
> Since linux next-20240902 starting debian sid on my MSI Alpha 15 Laptop h=
angs
> before the GUI is enabled. After rebooting into a working kernel (v6.11-r=
c6)
> the following messages can be found in /var/log/kern.log:

Thanks for the report.  I reverted the no-forget patches from fuse.git#for-=
next.

I know what the bug is (spin_lock instead of splin_unlock in the
nlookup helpers), but this was clearly not tested (partially my fault)
and not well reviewed (my fault completely), so this was just hurried
through without proper QC.

Thanks,
Miklos


