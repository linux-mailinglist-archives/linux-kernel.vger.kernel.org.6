Return-Path: <linux-kernel+bounces-528262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E5A41597
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3FA16642B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012042080D4;
	Mon, 24 Feb 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7bGiyD9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E7207DEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379367; cv=none; b=gXcc4DJrm8cyb+HjTbE+JKp1MXeRE+53t+HFgIOfCcX87CI8KHg5VjoyIfiK62tgD0OWdhGcey+G8VbvncpJj8lKNFC9VTnQ58gopBnohG8fLM773JqlbVepVy/vfegOGwhVd5mPw+F/F9DOptM5Mg9Qjnb3yP/mOxvQXvd8bLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379367; c=relaxed/simple;
	bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9jeapS5fVCSELD/V8OBa3aP/oeCQ89kOsGw9Hx8yz3ehIMZKlLcCzMUPUiVSLtpgQnNzSAGdvUo/0bsBmYGm+W7EaVdNvLiCy4Wvoo/lU1+mZM3bPscdB2/eZ2ekrcu743YSNDoxN2MyC+34CZxrtrf+bs0K3p7f70oOu5AeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7bGiyD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740379364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
	b=h7bGiyD97fFMUzp4lOVFLfffKffqM3cOBVDRVZzhWTD2ypN+uG9guckjUcAmpTLvilIwFL
	82ZTBPUa2qcCBiq1dM4k7Rx862eMP97FE50Xq4nZ2hRaJ2RtLVKNvh00fh7RyGlIZiDzxH
	iLDaIhr1+mjARTVXim5GYEpU2xIsYPU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-3af_4m9vO1aLVZ8x-3ZzZQ-1; Mon, 24 Feb 2025 01:42:42 -0500
X-MC-Unique: 3af_4m9vO1aLVZ8x-3ZzZQ-1
X-Mimecast-MFC-AGG-ID: 3af_4m9vO1aLVZ8x-3ZzZQ_1740379361
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so7929989a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740379361; x=1740984161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
        b=wP542ipS45+MZiC8w//810C5+G4NNhTm8kgmMni+xieBbbwwnlX1CgbdWdUXufA8Zr
         BY6AeY+pBn80QUAk8akLh43XQkbCBEHesFAVby7BiiqIOyFL3Zaa2ca0LfKzM2yR5GD+
         RLMVeFAIFT7tt6oD17yNoLo3m+l/VBObWeWgbO+TQzyMRpZiF20P5ASvvxpkVjYmkMZm
         C6rHdrH21IzV8L7wLlZdyqnB2I+32E/iCpL8QNbG9r6g7wHEJttPvgYGzEQ6K8gnvtwa
         aBQ0dtQENkMdKFLPva3zjaJxMtvhYbw++Xbpo/vAiUPcqK1F7ADUdOxPTGpab4iCK9rH
         elhw==
X-Forwarded-Encrypted: i=1; AJvYcCU4SChVUZ9PENzsiFEg5Qg6mdJ+8O0HfQxD6RWrmy/ziaEij4dLKa8AszmJ5uiZp7Jy1U88J8lhNZHmJH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgopjceY4GKMPDdMpd0f0AFe6TVXOnbXfMxFDCH6Vr4V82DrW
	Vru1nCvcIJ+nwNO8lCT3od6YnzLKQG/KraylQcJIWIFqRbtsoLUOlN1I9mnbZkEykxjHvfdPoQ2
	s5a4lCdCq8IBZF2oRC1MdJ8acA5is2r5rzM7Qku5wSrg+vak9ouLW7BaMsDehfdsyu1dr3TtT0/
	pNKESRoKuU/TBaWDeeLuflQBIyaiKeLBxnUBvN
X-Gm-Gg: ASbGnctGmHy2u83oyGZw+ss1BI1j4ALFeU6Yg1uUZrkuQDY2URcMJxutG8/4fihGatG
	1bvA3rITcWAPx8olKRKmV/gRfwZGAultyuG/FZWdZcdp3abazUicVrJiGXx1fBXUPZ9Ue66o=
X-Received: by 2002:a17:90b:2688:b0:2fa:20f4:d27a with SMTP id 98e67ed59e1d1-2fce77a6382mr22454972a91.7.1740379361492;
        Sun, 23 Feb 2025 22:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuFD2ecIhUAFhVjxb8VN9DbbzjXzl6lNulCOdvpETmdpzPozqSwQzz5CU4bcDz4WMau0RfbbIjUtCAkxFwf68=
X-Received: by 2002:a17:90b:2688:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fce77a6382mr22454953a91.7.1740379361235; Sun, 23 Feb 2025
 22:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-2-eperezma@redhat.com>
 <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
In-Reply-To: <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 07:42:04 +0100
X-Gm-Features: AWEUYZnuYDjmdyQD3CYZL5hzzrYfofHBj4VHCbCLQNKiTNY5xfwbgaR5pmNcLH8
Message-ID: <CAJaqyWc6M+1dkLSMuGwauUKEOoaC-VfW5Ofn6JwYtnKYB-yjRw@mail.gmail.com>
Subject: Re: [RFC v2 1/5] vduse: add virtio_fs to allowed dev id
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Feb 22, 2025 at 1:06=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > A VDUSE device that implements virtiofs device works fine just by
> > adding the device id to the whitelist.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Let's separate this from this series.
>

Right, actually I should have said this series should be applied on
top of this sent patch:

https://lore.kernel.org/lkml/CAJaqyWdC-Tte+ao6pk22fq-mUym8C9guQFThSnG5gMxWN=
qWyXw@mail.gmail.com/T/


