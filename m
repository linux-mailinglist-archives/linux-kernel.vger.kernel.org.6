Return-Path: <linux-kernel+bounces-565335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB4A66614
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC39172FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4618192D68;
	Tue, 18 Mar 2025 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0k64aBK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22197158DAC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263834; cv=none; b=s8ydyOq26Syjd9vq5WLzabuq/sLONetC+ehllufKnP5SLgckEUslBddnlX9OMNHM2Zvq76mK7iBrsjWCJfcyOxscSoSecQENeYNWgUFe6KFoyDzr7HvD61+tElSOLAmMFcGtz+AnevxmDVmWk6WRx3qKQyaJrL3nXYB+jHegpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263834; c=relaxed/simple;
	bh=QR2+CQhFtF3wiXNVfMMn04N/Zgc7E9vWUP/WZyEzsE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7qguRyJwIQTsVYazebzglkyVY9HNKmRFZQGzoSBgtAhMuHC/ZzHo0MLiTi/u2T1laHFJHOttl5gi25bVYIHkIrbxIoP//wC5PYywwTYzwpDl7zfUWtqt3XAM0+kv8Ihy3LB69UkXgUUGD0BFj79TyQ+1sIwe3Vo4qymmLJsM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0k64aBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742263830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bocJ4xY+cvLvF8Z2x24tl3LRmmXAsvkZEGxfx5yQFuM=;
	b=L0k64aBKhp6EbDzupLaFCy+aPU5PrxFhExHhz/+PM1VwUpxn0oFPKX+3zTvabHatSTYEvL
	eczio3BysO3SeOPgC5KWjqCSVJz2U6IwRwx4GVa+vCs/EguTBT0WbQ6mOx5mr3y/vdxd0y
	nyGMqBmL4vikhmDdUUOhj5OJZDwCL1g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-UF3K3VpvNQWShhDmfwlneA-1; Mon, 17 Mar 2025 22:10:28 -0400
X-MC-Unique: UF3K3VpvNQWShhDmfwlneA-1
X-Mimecast-MFC-AGG-ID: UF3K3VpvNQWShhDmfwlneA_1742263827
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5c76fd898so4359522a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742263827; x=1742868627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bocJ4xY+cvLvF8Z2x24tl3LRmmXAsvkZEGxfx5yQFuM=;
        b=xP7e0ERwE4K6gpgF+3AYtl18cnf8MslACWLILejjS5mXvQZPvjezSMR+NBfjlC0Up8
         qXfdberfbpRbXXbCOvw53IbOGV3pBDWS+pMyOCqaXt7uVGrnozM8vzXmhsj/bmDCw0uH
         /D/t0M6Kh48lq5+ecAysftw46SqpDMiLwGUSReCy1UavBrfj0+VPJersTsW3sXuM3dm9
         NW10BqFbmcvE89IMZBqxg8ds5a/aA9ZPo7CVyweKOBRaFHo09n3AHDW2GpOzY1i5AXB0
         kwQYgnwPTxZClTQGUUIBBHJxGMrBbInqvOlYVexioSbXHtrYCd1OCF+s3MzlGbo/04OR
         zTbg==
X-Forwarded-Encrypted: i=1; AJvYcCXh5fD5a07dQu5g5IERkug4h30w5Sh59JvEAHigvshZD2U3tZFz0mqE2uUHzrXj/iEl1IKNyekcL/3EZsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/H7iht8ZxwXo2C+Tm4Ylvq4uw70UA2E5UheJDeTU4gnsxejQH
	8TtGMMex3350FLZ9IofDkptAnt+DTeBgt4fc709GV+aZYXs2kzESn2am9+mT2sInrcerZTmLAEF
	MdHG+a5ahZCcAzSDzKBHbw7p6Rb+pJNwAa2oFN6xVy6gaq98C1OWi934oV+GEXQlI8bIdeRF4J/
	lkU3LHdT8Ghf+zVS7CoCacFdWcAo1bJXHkTGaa
X-Gm-Gg: ASbGncuAIf/B03L3J2dcTJNeJCwM1nHzcsk2jwFU8QCstuqhAKYHHn51sLNSOVsfQBF
	oyczd6b+UXm4zJ8LcRzEqKuqr21uCLRXDDyKVnRFtKqLlPfP/yzSvNyniJjbeNfrjt6rYtZ1jGQ
	==
X-Received: by 2002:a05:6402:348d:b0:5de:cbed:c955 with SMTP id 4fb4d7f45d1cf-5e89fa5252bmr15904548a12.17.1742263827514;
        Mon, 17 Mar 2025 19:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCvFJRxiUrK3Hl8RQJ4gACrb1PAEIxR0Zqht6rIjp/tdZBCVDepPjzyLxDhCMISfCanvYlkZjNzb4UQTjWFWQ=
X-Received: by 2002:a05:6402:348d:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5e89fa5252bmr15904525a12.17.1742263827103; Mon, 17 Mar 2025
 19:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com> <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
In-Reply-To: <CACGkMEu=pPTd-QHKRDw7noRCTu-18c7JLJNKZCEu5=BHAE0aJQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 18 Mar 2025 10:09:50 +0800
X-Gm-Features: AQ5f1Jpjunc8xib_cyTewZlm6iAFgRKVvfy1UVZQ0lyOQH2XWEffoxUQGNr9u5c
Message-ID: <CAPpAL=yfgiuFA-SyrCe0Ud8Wm9tJMcMm9L4Q-AnnuRzN+Q9M=A@mail.gmail.com>
Subject: Re: [PATCH net-next v11 00/10] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches v11 under linux-next repo with
virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 18, 2025 at 8:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Mar 17, 2025 at 6:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > virtio-net have two usage of hashes: one is RSS and another is hash
> > reporting. Conventionally the hash calculation was done by the VMM.
> > However, computing the hash after the queue was chosen defeats the
> > purpose of RSS.
> >
> > Another approach is to use eBPF steering program. This approach has
> > another downside: it cannot report the calculated hash due to the
> > restrictive nature of eBPF.
> >
> > Introduce the code to compute hashes to the kernel in order to overcome
> > thse challenges.
> >
> > An alternative solution is to extend the eBPF steering program so that =
it
> > will be able to report to the userspace, but it is based on context
> > rewrites, which is in feature freeze. We can adopt kfuncs, but they wil=
l
> > not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> > and vhost_net).
> >
> > The patches for QEMU to use this new feature was submitted as RFC and
> > is available at:
> > https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
> >
> > This work was presented at LPC 2024:
> > https://lpc.events/event/18/contributions/1963/
> >
> > V1 -> V2:
> >   Changed to introduce a new BPF program type.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v11:
> > - Added the missing code to free vnet_hash in patch
> >   "tap: Introduce virtio-net hash feature".
> > - Link to v10: https://lore.kernel.org/r/20250313-rss-v10-0-3185d73a9af=
0@daynix.com
> >
>
> We only have 2 or 3 points that need to be sorted out. Let's hold on
> to the iteration until we had an agreement.
>
> Thanks
>


