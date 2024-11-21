Return-Path: <linux-kernel+bounces-417232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F19D50FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A71286441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2C1AAE1B;
	Thu, 21 Nov 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj+7i4Vn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C461A3BDA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207823; cv=none; b=qqP3sKAg1AC0hyd+nwdb7QXIsoovqMsEwyrcDhVp/+oqORNxecnUx4axgF1RUNcrrQVj1A67mVuUD/PxdaEaq6R6DjSyPv3kupWtSwwit0IXk13hvLawSDKsHq2DH8EaTlZrSLXf+bBqBeu9vhBNn+VdUJe94PQ1QlBixUt299Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207823; c=relaxed/simple;
	bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HflOeizTrRycWqXMIaWs47fDztJMblfdTFG2qbXU1bQShpiHK1aLtpcZ3H4uopmlXwMsGklr+DHempqNOWQWYDssefPAPTlPgpilW1GjJ+RH4VFaoC5d/Z/KG/FtIzk1D9MqC2FntXwUwvVQ+ipEAW7KvLXUd30X8K2k8RVOtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj+7i4Vn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732207820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
	b=Aj+7i4Vn1iNZAwLOOLyCidTKQnnAChD4T9mkeq43BJPfG5SnsNBmfUYMVx+0tCNtu17k4O
	/+Ytc0c9xrQkK4L1DPJM0PD9Z9OpJgsoghIXmlZz3QV+nw9MNIuiwcC2alsl0tBmSSo1fb
	gfys+zDIZR57YRwwkmdg9NFuM2aWK4U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-G09oGTVLPxKLFzlSJsApOQ-1; Thu, 21 Nov 2024 11:50:19 -0500
X-MC-Unique: G09oGTVLPxKLFzlSJsApOQ-1
X-Mimecast-MFC-AGG-ID: G09oGTVLPxKLFzlSJsApOQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20ca1692cb7so11432305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207818; x=1732812618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
        b=OztI6TXXVuAFMwzJXUGdb7o/Ms+7brrhrTSf1s2sFtiSdrx5PvejCCySiUw3eEVKSe
         t2KQOj/S7fU2Tjr5+gLbU21WSnaQ6ATuhnsRxaksNUA3ZKLQ1L15tsih6BN+5zH8VeDo
         NK83tVQYvoFcRvaX61LaLOojaj5kihP0JFzsdMgUi4tHxCrRwqi/kKzzrt+le0ldLXze
         BuftDHnnlE9Q2O5c0hZC/F4y8qHLzPb2J1+6kxmlIkcGtisuYaelF2v2G2TQ3DxQvFzg
         NBvYsVv9Q5AwTQxblckz13vW5F2dqmKsyN8wcwOJfGxoLq4faMnxWS+QdKs4XePG0Zgq
         01Og==
X-Forwarded-Encrypted: i=1; AJvYcCXn1XScOfk0kHbOHfKXCN5NttISkRL//IpwXpDyX7ii7DtAsMCPFWu1a2B71+UUKCCZXhXP1WmMp7qaGOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrS6NooNSURmwvhIOGpx14HGSQr8IoVIj+GlxHm7TR4QDNiBb2
	G8z3Q878EYEKMqp7TCjAyaTSm3BiLdguskaUtFMCReHwF4kN8gEZImcRSZ1MblKEGFptP9tbriU
	DdZmRn5bi/6x8wOF2sUhd9YrdBul0oVhvLj+QoqY7drhv2VKItrXb7XFrncZF+a9GzXDJakHMna
	yAXR4EdREbeD3fb3EJ45v7ydYGmWkgjS0p1XDX
X-Gm-Gg: ASbGncsJd+APCV23mtsCYq+C0I8I/9NshdcgkdglqOTA9usxtO/irgeXVaSTpq5M+Cu
	8M0O5jcBXPDxBPpM1u8J2Q2baljqaYpyF
X-Received: by 2002:a17:902:ced2:b0:211:f52d:4dfb with SMTP id d9443c01a7336-2126c1660aemr96184415ad.34.1732207817957;
        Thu, 21 Nov 2024 08:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYwUegOvnUGuFukyLEfp4g21DL42Vh3B29dqLz+MjQehoS8+iFeVjSAEr24CHu4SkIJ/uk9NSquFZC4b2ShW4=
X-Received: by 2002:a17:902:ced2:b0:211:f52d:4dfb with SMTP id
 d9443c01a7336-2126c1660aemr96184165ad.34.1732207817661; Thu, 21 Nov 2024
 08:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home> <20241120164043.T1JuBALe@linutronix.de>
In-Reply-To: <20241120164043.T1JuBALe@linutronix.de>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Thu, 21 Nov 2024 17:50:06 +0100
Message-ID: <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Wed, Nov 20, 2024 at 5:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > The "%pK" dereferences a pointer and there's some SELinux hooks attache=
d to
> > that code. The problem is that the SELinux hooks take spinlocks. This w=
ould
> > not have been an issue if it wasn't for that "%pK" in the format.
>
> That is missing check and I think Thomas Weissschuh wanted to add it. So
> we don't call into selinux.

Your comment confuses me a bit, as I'm unsure what Thomas is actually
working on.
Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ensure
that sleeping functions aren't called, allowing these functions to work in
any context?
However, his mention of "This fix for kmemleak is still needed as the
pointers in the kmemleak report are useful" adds to my confusion.
Meanwhile, Steven suggests reworking SELinux to resolve the issue.
Could you clarify what you mean by "So we don't call into selinux"?

>
> Sebastian
>

Thanks
--=20
---
172


