Return-Path: <linux-kernel+bounces-341276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D2987D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576ED1F21756
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27919175D33;
	Fri, 27 Sep 2024 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU5EaLe4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AF14BF8B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727411502; cv=none; b=HJlvNGuMayBuM5IQKz06NYDA4XmZjjlf3hnv/x+XQChwc07pqrqyIpjJ1wfX5yW6CXAbxyp+NVvzRCHg263lAnNN7RaEfI27mDBaodlVtQetelho/GB9LfjaETWaENwPJcB5379l9xYvrRJCJmJ4EIODJ+0vIq8kw89gmomMNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727411502; c=relaxed/simple;
	bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2exMJOx+c8FZiIAVfn9s0FeHc1pM6xB9u+W7N/abWAnEmW9GbxBsCcaNZIXaICLdhjmytzxT+0f+6ys7dbLVSOEXMzzjj7lcx6KWKIn3w2dtAIiXGJyb7LJWASwYEy0xJ690RMRux3P45zkkG6M0M6rGDM+ahKkVXETD3SGngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU5EaLe4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727411500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
	b=SU5EaLe4lNFhsr74QQnXXwGrnYvM8MS2xIMXFawfxs0PLa1b051GNpKSIn/AnZhGgH53GA
	aJVmjzzqeOoIXSsJZBoSQFbxE0jnozfOjvZmVB8jsVuKhNbUTzACU/yeL4F5yFk5BAI9id
	23CaMuWc4u9N6hfLmYD9WPE5Yl9W9iY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-sZ8TNeCCNzCUrPWMu8pTvQ-1; Fri, 27 Sep 2024 00:31:36 -0400
X-MC-Unique: sZ8TNeCCNzCUrPWMu8pTvQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8b7c662ccso2319507a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727411495; x=1728016295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBFmWoNeX1W+Cqs2iNWdisHneux0lZanwha6u5m3aww=;
        b=DeeL/kGb0IepB/0LxL2He3nLF9bWtzF4o5zdKUFpYv/K8Ds0yufygZmEvfL7S1UK0S
         dPNW/gViwpEwTdLfuOnEEdbinuxrSB8eK3dch0duPJKH/B/j0SZRgoeArnbhUc0qCt9z
         kCIccqQ/5n4/2ap/odp/fJ8XEKRU3Crf1yFfWG/nwXeBX+4IQLp9VnjSI//kAT1gyk1q
         YOStL5qvfB3ww4h4rQJOiI8VIHeiZWPZbIfCPc1PMWMI6SQ3bPGi8r0H7JduaEm77whb
         pYDo/TPFXjycURTq/meqBwrZSXi1JGcwc4BFxfEbLhhOgaz4ZcviXh31UnHhurF7IGPg
         Y+GA==
X-Forwarded-Encrypted: i=1; AJvYcCWColplssqWfl7BvsmxCXHX+0nGNlTw0nFRb49PehRE5AzdgEZPcvXpG/ndGdm7SSoiVYX3fJAd2ZxO20A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIxqeci4Zg+mS0TjFEFDGBX70YQBqixnT4dEn8zamUiVC4XEn
	HXRgZ1Sx9FKr2vbB3fuH5Y45XFsT8DhTYWQN4nzilj0NKPC4QncRDTP5vunJXk+/HUA+JVGVVaI
	hAZsQvIZXZsXwOPLegDctl/b0nuXiphH1z9SVdl9G7FJFfhHVqJD0j76DMXVMRKhxH87urbbQ49
	x7Tn5I83/tSRlhWKwmX7ryxC7Nyt/AbMUWNYJY
X-Received: by 2002:a17:90b:234a:b0:2c2:df58:bb8c with SMTP id 98e67ed59e1d1-2e0b8b149dcmr2167117a91.18.1727411495492;
        Thu, 26 Sep 2024 21:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIh5lwZF9CJKh17SEpxaaZJy38bFfod3VEXz7y4ASCqLDiCeaKdZmiGJ67AwnOYjAbQZ+yUYlkT0W4m1tjn8U=
X-Received: by 2002:a17:90b:234a:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2e0b8b149dcmr2167084a91.18.1727411494914; Thu, 26 Sep 2024
 21:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
In-Reply-To: <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:31:23 +0800
Message-ID: <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/09/25 12:30, Jason Wang wrote:
> > On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> virtio-net have two usage of hashes: one is RSS and another is hash
> >> reporting. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF.
> >>
> >> Introduce the code to compute hashes to the kernel in order to overcom=
e
> >> thse challenges.
> >>
> >> An alternative solution is to extend the eBPF steering program so that=
 it
> >> will be able to report to the userspace, but it is based on context
> >> rewrites, which is in feature freeze. We can adopt kfuncs, but they wi=
ll
> >> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> >> and vhost_net).
> >>
> >
> > I wonder if we could clone the skb and reuse some to store the hash,
> > then the steering eBPF program can access these fields without
> > introducing full RSS in the kernel?
>
> I don't get how cloning the skb can solve the issue.
>
> We can certainly implement Toeplitz function in the kernel or even with
> tc-bpf to store a hash value that can be used for eBPF steering program
> and virtio hash reporting. However we don't have a means of storing a
> hash type, which is specific to virtio hash reporting and lacks a
> corresponding skb field.

I may miss something but looking at sk_filter_is_valid_access(). It
looks to me we can make use of skb->cb[0..4]?

Thanks

>
> Regards,
> Akihiko Odaki
>


