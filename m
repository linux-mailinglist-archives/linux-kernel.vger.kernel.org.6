Return-Path: <linux-kernel+bounces-567170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE0A682D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1465E3BFC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF6D24E4BC;
	Wed, 19 Mar 2025 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fX29XGyM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF124DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348599; cv=none; b=iTAiuK5UkgbXvUCuThYz4jdWs3K3mbU6FkoEYGfcxIkUa/NgXDm14YIlyPnDvNAkcqM9WfXe/utBq4rPbbefnrWlTR1eOS6lx87eekr3TCnfAE48zfkXXuL/S+BAsAVv8mDuDrDKjXoAYAyu/1vbf+F8Vd0VTfpvlmoAtbJHGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348599; c=relaxed/simple;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpaGf4w8qFdTxvrRoGcE8A3Ru/88GpZB3fwVDDZ73IDLvEmzKUPnZdOX2yYacGagJ6hpNvAHFDytHf6TqOWK+tMBnbCg6NZrYAB1OwHw5T7/y0IEogUuYLtVX0LO0EfjiBHYXeCBf6gmO3/47KvbQ2LjMnNt/dEFd8aNcgBlUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fX29XGyM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	b=fX29XGyMPw+STYQNVLF/TjUyTlCXpRjH4KpIX9UwvqraUsgmjrVOnpheTAZodxWQ+2FyMs
	l7OQSbBI6TlmoFDRWfF2/5v2hNJv89FW4tzqKlQFE44S6fm9wdYwfbU75jMepSKWkSjfy4
	BOSYKwQTNZg7gtMVXiTY45gb1ZlzKhw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634--k65sczfM32rawhwB4xgBA-1; Tue, 18 Mar 2025 21:43:15 -0400
X-MC-Unique: -k65sczfM32rawhwB4xgBA-1
X-Mimecast-MFC-AGG-ID: -k65sczfM32rawhwB4xgBA_1742348595
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso10359915a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348595; x=1742953395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
        b=f/NYTamA3RaW0cdZXZWjOQX5Nsndpwu9xCcoYq3S7XZfWKvye9pZPBlHOORqW6V+kJ
         w1ZjHiB21z/0/SHXkLnntljR8BDoLJsNtcDb4E4g+bIuBLhfCG8rh1o/ldenRpZJ+/cc
         xjmaVB2h5mqXTcdOCJmA4yYVqpFHPSZENnvK9BLN2ACnnZ7Fi9+gxGZkeZSjG/OtnNcE
         nIWLA2kzEKXwyOhZzLmiA6diJB/5KgsvZ5P+IMDrWiGzxs64MbowVL6rsl6PLgiP2jqF
         iIKITTFCV1y66+Ycm96fj6U9YZNfEv1h5ULl5SQf9rmcoCZVuGRaPUVS8rDhEIBYdRcR
         SobA==
X-Forwarded-Encrypted: i=1; AJvYcCXSTsQcXigs2yc4hQwirLGjvxNmbQHXJTjiJXqxBSBY6xBiCPn2g+Z+67/j12kpv9i0ogNmp/O79H2Rdrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslR9gA0H0okODbBbo1NepkZPs0XK4UpVViJL9hs8c7mnpYrwn
	S/mqUBKKrDFsegfQtZRAiUP9k+zlXfkiK9LcbXXzwnrQAV52+i4bLY7DHfnebdsZj2xtPz1lAug
	660yo4ZkcsGKYHQ9uOm8dDmylxD409DmxnRwecvLUpgKNBuvl8kk/y/yB2B1R65N9CerC2scJLK
	FI0ULHFyBhnMAhxR0BF0CcE8SNzQnI9KAcjs/7
X-Gm-Gg: ASbGnctQcUr1N5upDiR6Fq+ss97XuAl3M1eEnhY/UhrCM09Ed2nKADiSzcM65sGLDss
	+rxujwo7K/5/bFaOoFdteCXzP9nSVNAA/CY6AsJBNH0arhvHLrDMe7VHO8vZCkHP0CVxAadod
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-301bde6cf1fmr1638693a91.11.1742348594706;
        Tue, 18 Mar 2025 18:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFcg4dnJHM1uCFM2u2csupiktItuJlKGJc6MgtbCrZ17gemZAB1I9mrMnZFW3Wp0mx2Q/1cpCGqJkfDvMKT0=
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-301bde6cf1fmr1638665a91.11.1742348594429; Tue, 18 Mar 2025
 18:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-2-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-2-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:02 +0800
X-Gm-Features: AQ5f1JoMSQNYtVIT-ODL08ptBsIoNK10KPby88nDSI2xd14NsoDQzDvBrBl4FY4
Message-ID: <CACGkMEtmzJpWQjAD1FoYwH0HF4+y33Kjf-jUwagnOP3wg15oqw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] virtio_net: Fix endian with virtio_net_ctrl_rss
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Mark the fields of struct virtio_net_ctrl_rss as little endian as
> they are in struct virtio_net_rss_config, which it follows.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


