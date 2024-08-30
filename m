Return-Path: <linux-kernel+bounces-307938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0296553A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11351284A38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647D86AFA;
	Fri, 30 Aug 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAr7klop"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEA7404E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984864; cv=none; b=Hwdgv7gwRQcROWDmI2sAYrRPZlGwpElBfAAdgCfPhLxbe2JtJNUrJZ8V4lHiLvYQxd0O8/6emjERQJZ+m6qfRU2Y1PlEE5luCs/n2SG2hbx6neGBeY2/UQFVk8cR9Mvr34FTTUD9Bm0Q8DRbS3lxqNElth9EHU1VWYCZ+/P2hdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984864; c=relaxed/simple;
	bh=7aOFzquSXsxWdg9sGe6soNpradm3zUkzZgIEXOgg6N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKXPhSR2FYAbryckjqHXm7AjjY3C15f6pAy3Kc6cnYJsmXiXok9e3HrDN37fPAmo1OH3DSZOTy+rVUaCvmLotLvg+C7rraVbHiNzXPgSxT6YKQYzywJxsdzWKolVThRbiK8bXl+Apdp/7vhhCHxGwHhwJRs57/EMn/bqRxDTxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAr7klop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724984860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqa6fnY1m7BN2MuwAFexWwsKLrqxXcsUqarIMqCmGqY=;
	b=GAr7klopEJFtFsTKgez1COygRolSKZPEh/vxKzgO02yLRW/IqsHvI8VtitrSxifL0YatTk
	/8j7gkBhK+U289oiww07tTQur8vqbGUx5VI+7gepCYs4Kax+GjNa7/ThFXE7D8U6ABJExZ
	UpztAnKExFvInHXU0FzLAVJb6HeLZPQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-rN7N6m5sNCG-2lMqnQcp6A-1; Thu, 29 Aug 2024 22:27:38 -0400
X-MC-Unique: rN7N6m5sNCG-2lMqnQcp6A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3efe18d05so1306935a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724984857; x=1725589657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqa6fnY1m7BN2MuwAFexWwsKLrqxXcsUqarIMqCmGqY=;
        b=nCbvk9kEkkjRb4bzfUp2YRaZJVfab9JMaPdeCJ8P4LLPMWEFs1phiml/vIlpsY3bwu
         UMyy/c+GsPpMGk3al0D9Vwpf4T1ZryWihOdlUQo55CIQMusXQFG5/bRlOLjzoQhs2GRj
         2q9S+ZiZiUOoV+Jno8dGal9EYiS3CuK2iXSkvy5FSWfaji4C7SYJdiEnzDkz/AWDJIH7
         tOJ/kG8OiZVbIyOo1cpPzmRFb5Ett1fwzwH9SVIa6736ftFDOrL19Fvnn1P+WSsEoEhe
         aMbB4WveioEq6OapdcipTWizLRCmRo5sm0u4mVtm84FBZUAWCRBrCEubdmjwRzhrlS0a
         ZoNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFidYk8NIzEIJ0ThAzhW2t7ciCTMIiQnGX5AnzGZNh4LuAs1rtEowJl3l/84hGPowB1jl9mVYfBNH1bb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWLNFFRJNFP5l/pK/8iqqhae3uazECoF1ZLX/QqzUlLVrGm3f
	Uo1mjCfjBR8Ugla9iEqjr5T02mSRcGDfdZHW+7w9JxSDq7HUFW6TbnZIYmAjLqGfz5i7zl3+xWx
	EJlwqIFZOW5+rL7NEF2p0W3ERE9CbsdqYFO0LHgyYrMwt18fwE2wu6dLzU82K5ONBL9aaV03McG
	htAi7Q8gdVByCfsSaBfc+AAzK6yvL/4FSXylOY
X-Received: by 2002:a17:90b:1c8d:b0:2d1:bf4b:4a6d with SMTP id 98e67ed59e1d1-2d856171083mr5715597a91.1.1724984857613;
        Thu, 29 Aug 2024 19:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPvs4K6ErQNk0JQcambzJJSK9Hb/yPLY7k6nxtFvEimYY7nj16dOoSPmKxLqdHCvR6Gg7k0fB8H2rbMXASD0=
X-Received: by 2002:a17:90b:1c8d:b0:2d1:bf4b:4a6d with SMTP id
 98e67ed59e1d1-2d856171083mr5715575a91.1.1724984857029; Thu, 29 Aug 2024
 19:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829143757.85844-1-sgarzare@redhat.com> <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
In-Reply-To: <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Aug 2024 10:27:24 +0800
Message-ID: <CACGkMEvS-kVERRhYHQh5=o_6O=-1qyrzraNq+3KsJLyVZ6LPZw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Thu, 29 Aug 2024 at 11:01, Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
> >
> > The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
> > managed pricipally with the net tree, and VIRTIO AND VHOST
> > VSOCK DRIVER. However, changes that only affect the virtio part
> > usually go with Michael's tree, so let's also put the driver in
> > the VIRTIO CORE section to have its maintainers in CC for changes
> > to the virtio-vsock driver.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


