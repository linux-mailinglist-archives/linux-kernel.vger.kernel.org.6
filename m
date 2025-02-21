Return-Path: <linux-kernel+bounces-525006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E389BA3E9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F6C172781
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E1757EA;
	Fri, 21 Feb 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/bHJm7H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375413B787
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100515; cv=none; b=k9ZmdKvE3EK1wzQ/B/NwoR6Xqo+ppAZ1OMXi6URHIsT5bDLX5iZISEoP1FIHGlLSJgBGI4/gami/5xXyEPOJ6nxAZxJGC8aYT8utXylbLKnOP3q997n4hNH3h4wG1BMdCyhZ2hV94jD0e8Fxh19U5qOuM89mxeUVdfO/HAz9T7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100515; c=relaxed/simple;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p91ypZbmu2Vf3p0PB8QxwuZfDCvqkrB1MQO/6rWMrgjcG5L3VDTUPfsR7k//QzBWiyugZIIcKRNbxT0qM/hLb4afykTKKpSLKCJwUkP5sZnfWbI2Rf/NJJZs1uWRymw0cztLSv+eoxjlehiFSqB+HbqQAUzr0XT6xp48Qbg7xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/bHJm7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
	b=V/bHJm7HHy849dnbGLvJyMOjN+PYg876C2iBic+Znf3c+MNBD/1XIGCO45SYbPXqZ8Rv60
	ql6ZhVXlPJvivicbIRx5bvhnmbi4VhrVXkKGe2fM9+bVZpyCw2x/IC6SZqshiFCkGkme3j
	ZOyORzpUCIAbXr2dXrPp98m4/toJPkw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-03yZiLxlPNul-E3mmIZF3w-1; Thu, 20 Feb 2025 20:15:09 -0500
X-MC-Unique: 03yZiLxlPNul-E3mmIZF3w-1
X-Mimecast-MFC-AGG-ID: 03yZiLxlPNul-E3mmIZF3w_1740100508
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2217b4a48a4so31555405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100508; x=1740705308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bGiavS8jq7e1a/UcoH9zlpN1YkLl+PW6P8a+yl2sIA=;
        b=SvWSF7L1q7KbkgINtaTm7coBCuvI8I9hz2Q6ZcPFjOPUtaRTgjy8J5BVqSo2tgAHCK
         6U6rHZK8j//B9LUGeqXOvJVAa3cPJz9O0tgyXJQ5ddpD6ZrWquwBcuAzuxjcsP4y8yjb
         Yx5o6/6pQjda+k/y6apfW8bxmlecfpzujhK7298UEPdpjEAArzf4J8BZR+IRKRTTjYvu
         u4T521Iyvub5qieV8HNXKONYq+3xob+oID89Cqkcz+A2985Tj3qlyl50Gntnb0vbvjv9
         yZcu7051vBGamfpoz67fRhho0odvKws/uZgq2vSPAYQXosI92gC9FNwwlpemTAcUrG5P
         Mgsg==
X-Forwarded-Encrypted: i=1; AJvYcCXjQzpFBtzOHuuVx0OjSJ9/GejCHaS0sMciRdeoVLhg7QvdyNlTBx6aNqHDK83i6ZAuO/xZBYlqK8ysdWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsq6r/VCBkdRT8v/dBgS8nvRvZaZDIIB72boCXAt8NYhAbKgFz
	H8v9RJFFZywc9fDL1EYz3I3+Br8TXXZR93KabtMT2slhmN4rXsMDof2sANx9FmPTTyElTsIMrDQ
	Joo6eKBz9iePDgGxi25V+nkPhvY1DUOPU8G9HOctUblJJb5jEY9pj0BXFx7C6574Lw7k4Jlnt+a
	vjCX8y7zTQzwcL1zEptECaniaGfBflkVAe9y1V
X-Gm-Gg: ASbGnctuTF6yy2SeJiD917lJO+5RsJSYMCDkw9pevCT4VoFzD6a3EuqgrJQznLLgSlJ
	jSyJ3L+XH7lXjrTyQft+tsRzpr73P8LHxdqfdJsHgeRXbZtwt9cq8kh1zIDh7Rjw=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id d9443c01a7336-221a0ec944cmr13551865ad.9.1740100508436;
        Thu, 20 Feb 2025 17:15:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNUoAtdLLCDrmQ4E0KhxP1/v8E8OjE3hwAErurd7Thltd/lsB3alr0YyGDAyw/Vnr52MolQRVxcb5jecipEJY=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-221a0ec944cmr13551285ad.9.1740100507900; Thu, 20 Feb 2025
 17:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
 <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com> <20250220034042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220034042-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:14:56 +0800
X-Gm-Features: AWEUYZk12eKYMoRdAhOr_VqKFdK71rl0l2JCQtxsCVicbAIDmOs5Fp4sSGUmfl4
Message-ID: <CACGkMEtN1K7jRVmZwxah1vET=p5k_Nd0cpov=R0B8sP=bjC-sA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Feb 20, 2025 at 08:58:38AM +0100, Paolo Abeni wrote:
> > Hi,
> >
> > On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> > > tun simply advances iov_iter when it needs to pad virtio header,
> > > which leaves the garbage in the buffer as is. This will become
> > > especially problematic when tun starts to allow enabling the hash
> > > reporting feature; even if the feature is enabled, the packet may lac=
k a
> > > hash value and may contain a hole in the virtio header because the
> > > packet arrived before the feature gets enabled or does not contain th=
e
> > > header fields to be hashed. If the hole is not filled with zero, it i=
s
> > > impossible to tell if the packet lacks a hash value.
> >
> > Should virtio starting sending packets only after feature negotiation?
> > In other words, can the above happen without another bug somewhere else=
?
>
>
> Not if this is connected with a guest with the standard virtio driver, no=
.
> The issue is that tun has no concept of feature negotiation,
> and we don't know who uses the vnet header feature, or why.
>
> > I guess the following question is mostly for Jason and Michael: could b=
e
> > possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
> > to explicitly signal the hash fields presence? i.e. making the actual
> > virtio_net_hdr size 'dynamic'.
>
> But it is dynamic - that is why we have TUNSETVNETHDRSZ.

Yes, tun currently only recognizes a subset of the whole virtio-net header.

Thanks


