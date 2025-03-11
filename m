Return-Path: <linux-kernel+bounces-555313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7374A5B589
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239FF16CB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A221E00B4;
	Tue, 11 Mar 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmBxL9Fs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EF1DE2BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654802; cv=none; b=NeisgU9J8xT7wckYpD/4lPOL9RmJg1u5J5ofMDJvuRo+aQYamxOQVB/jSWoX/DLzr7ln2gR+BUVxyn4RP/5IueuSxuAuw7gKdZ78qOqsoNkNgQwOTcnDJifX0nmNQrHLPg+N015zL6ZJZZFW0uEQlfeBOuhZVaqSZqRuBViIw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654802; c=relaxed/simple;
	bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OL/sgzJOJQ2Qkp4KhaAFqZLaggRMuos6Y4bYBlUfdLiL0xMYJm9Kpvdpb8CUX8zpiddCloiVTRNWjNcw5ydUuFSvbRH7zQdS7oPGAF4O6+jsj1Iv+y+ZQZQ6x8r0/7TDDAowLcqznORfY2PRUIEKRVaf+OGM+SwTQu3UmGledyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmBxL9Fs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
	b=cmBxL9FsS0OPHmZn54vyq7mokOjgU/L0UCRCXjrc1yffPK/L3fCGJIDtcKQPpAQHHbQi7K
	EtAD98wVI7ah4hS1QQ0O/MsiOj4gOLr/V/HcvM6qCQAggRlxOH0JMaxgtSyyzGnmgMwUhw
	skO6PY8me3N1pj7eWxx69/wcg7b041M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-yZE-mfj2NO21zQvT42E0MA-1; Mon, 10 Mar 2025 20:59:58 -0400
X-MC-Unique: yZE-mfj2NO21zQvT42E0MA-1
X-Mimecast-MFC-AGG-ID: yZE-mfj2NO21zQvT42E0MA_1741654797
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff581215a0so13774101a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654797; x=1742259597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
        b=hTuApHuMtNqBljtUTaEtD+l4Jq3jnoFiMCigGdQuHNOfLTo6F4BBVcLJ/U/+3DjfJV
         cvsILwDYWKF6kypkE0YVwFBQhBJ9PLm1KtI3xmqaa9J3gyBMwkUC+B7dmZiV5ZdmXp+7
         4RXAYbMfakkWYsBzOBGWuwkHTamBk7rE4krtiMFfc6b+t0+lj+unmzskC1i5qOq5avqq
         N/dNCIgPow51S3e9con0dDHwhRhwWmfeMCuX6V++uMaeu0VMo1u+ZPoJer4e+4w2fOOg
         k+Va/8qJn0ytbKTASpO6BdJLL6EkR3qoZwy6/sWGRqKYny08I6dod6z/SUVn7iIyBDc6
         Ga/w==
X-Forwarded-Encrypted: i=1; AJvYcCWybUaLOseI2uz+7mmhKMc/0DL8e3SIcCRn5izbtnOcwVDUVvCGjBW/F6/NWo2yr2JxFuFEhcQbQrjG2X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkH9Eh8JRd7Nu7uIfOOvkXR2I0o/ZIxxAHirkBsrgiPly8gWo2
	+1GGruU/Z/cuma1Cv5k38BkgNtBlpZNWlwKabXnc9XLj++QyYBQM5gN+Yp46Hu8M+y7uSOkehz3
	/3MYqVGIrDhQTcw8mmZlYXR6dIWB+lRakyCUVlSr47LUsmT6PlPMWbiNdFDsm512anJlySrogpW
	11qIeTrsyDikn5cuHuq0BA0voUhh6l5cPZEAro
X-Gm-Gg: ASbGncsew3kdcK9QcA34UrwRUHaM85hm+TcwhqPCDvT8/dFWurqLibamMhW3jjP3TlG
	hXgAjDxfg6wctAfBCm+fMxDL03GDYH84bAbq809xrbWAF7P8skAFV3x39DWzd5o/g8QktMA==
X-Received: by 2002:a05:6a20:6f88:b0:1f3:3c5d:cd86 with SMTP id adf61e73a8af0-1f544aeda95mr23372506637.11.1741654796474;
        Mon, 10 Mar 2025 17:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFAjXRLPP+KLwqouY2d8xVCf5YkchPJTuZnlD8oM2zbnnMfHxkuX6t5KA0j3l2vfmnWt5WtbXtWP67UCxPLOE=
X-Received: by 2002:a05:6a20:6f88:b0:1f3:3c5d:cd86 with SMTP id
 adf61e73a8af0-1f544aeda95mr23372488637.11.1741654796116; Mon, 10 Mar 2025
 17:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
 <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
In-Reply-To: <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:59:44 +0800
X-Gm-Features: AQ5f1JoCYAYg3sSzAq1y95KxGgfuxvQDmD7hYAz9zEwdTX_uuQgCUXsFfxfhrfk
Message-ID: <CACGkMEskp720d+UKm_aPUtGZC5NzH+mp_YKoY2NQV6_YBbRz9g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 4:14=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Wed, Mar 05, 2025 at 01:46:54PM +0800, Jason Wang wrote:
> > On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> > >
> > > On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > > > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > >
> > > WRT netdev, do we foresee big gains beyond just leveraging the netdev=
's
> > > namespace?
> >
> > It's a leverage of the network subsystem (netdevice, steering, uAPI,
> > tracing, probably a lot of others), not only its namespace. It can
> > avoid duplicating existing mechanisms in a vsock specific way. If we
> > manage to do that, namespace support will be a "byproduct".
> >
> [...]
> >
> > Yes, it can. I think we need to evaluate both approaches (that's why I
> > raise the approach of reusing netdevice). We can hear from others.
> >
>
> I agree it is worth evaluating. If netdev is being considered, then it
> is probably also worth considering your suggestion from a few years back
> to add these capabilities by building vsock on top of virtio-net [1].
>
> [1] https://lore.kernel.org/all/2747ac1f-390e-99f9-b24e-f179af79a9da@redh=
at.com/

Yes. I think having a dedicated netdev might be simpler than reusing
the virito-net.

>
> Considering that the current vsock protocol will only ever be able to
> enjoy a restricted feature set of these other net subsystems due to its
> lack of tolerance for packet loss (e.g., no multiqueue steering, no
> packet scheduling), I wonder if it would be best to a) wait until a user
> requires these capabilities, and b) at that point extend vsock to tolerat=
e
> packet loss (add a seqnum)?

Maybe, a question back to this proposal. What's the plan for the
userspace? For example, do we expect to extend iproute2 and other and
how (e.g having a new vsock dedicated tool)?

>
> > >
> > > Some other thoughts I had: netdev's flow control features would all h=
ave
> > > to be ignored or disabled somehow (I think dev_direct_xmit()?), becau=
se
> > > queueing introduces packet loss and the vsock protocol is unable to
> > > survive packet loss.
> >
> > Or just allow it and then configuring a qdisc that may drop packets
> > could be treated as a misconfiguration.
> >
>
> That is possible, but when I was playing with vsock qdisc the only one
> that worked was pfifo_fast/pfifo, as the others that I tested async drop
> packets.

I guess it should work with qdiscs with TCQ_F_CAN_BYPASS. Or if it
turns out to be hard we can just bypass the qdisc layer as you said.

Thanks

>
> Thanks,
> Bobby
>


