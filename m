Return-Path: <linux-kernel+bounces-306851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA992964498
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E321F220E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79F196455;
	Thu, 29 Aug 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXrvQv/4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD411AB507
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934802; cv=none; b=TAlsPtQpdYAJqsyl2UAKXg9n9twddlhOFgCXOcKdmLbnbP2QZkWFrU/7ALk9TpmyUdiMNjlsdMvFWW3kVBW5AqCzajZN1NtXdVdJtDZZrWrKe8rIvAiifTYZN2iPaYj3OupybVMzBUuzdaiWSTcP+K9gj1CLkEmbR04DAaUXgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934802; c=relaxed/simple;
	bh=EcAhnCfMYdSXlmNlommpCdA4tVwrlwjRudKqztdv2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhCGdL/Bg/yQ8qyqTWaOJzYI6MVJv/c7mQwMdafWm8yc92a1EGcM35UOzTAgJOKdhIUrsqd74+theDbPSf/RQ0n8PLcCjfbQW75F2mAOF3SU8BoWGfezxu+syNfSlooVMelPEyH+AnbtbqRE08uRlrNJeRFnq7XEks0YSbDghAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXrvQv/4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724934799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
	b=OXrvQv/4rDK2EvbHRjcnxU3DXySHJCtbvYRXtfBBy7Y83ZpukbzC/Laj6B6RiGBlGj89ht
	89/2/eUJLLZpzYAYuHnIQ0nEUGWtCax+w7YzFaEHHfT211UKKxnTbeMM4IdElBnNSEBmTP
	i44kUnE7bQnq4M0E/e764UApiW/+uHc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-REbwHcDgNAK_orz4T5p4yQ-1; Thu, 29 Aug 2024 08:33:17 -0400
X-MC-Unique: REbwHcDgNAK_orz4T5p4yQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a86690270dcso54722066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934796; x=1725539596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
        b=pUDeKeDuB0srVC18YIsHRM4x5Vox6BSO8CR3wtekr3i5NY6leqGLRb3LFclTtw4Auh
         PMUAFKQ/UPORM1JnfUXxa6Nts8ltha6b9CScCF+KsDAX7NCTSov52VjzVNR1c/xGT26I
         v28QKhOjSr/6MsIro357Y7TnB5wumJM4tav4jkElD0sWCa2pMmhAzHH5JL/RFopBlq44
         +ySJvtZbHRk/6hwf70yEjWpTxHSedpl3GMQsqQhJAeLoIefFzZX1fHnzfWO9lgznY36J
         KLcZy8FZd6rFXT7ftMvJkT4fCe1jIiHDQbFfqTy21U6ITyLROLrGaNvTVcMLulH8VdoC
         eOmg==
X-Forwarded-Encrypted: i=1; AJvYcCWW/5JTSE8LdMBpdauDfBDIJAChxoOepfILjysC0i0ziOdOPgvW3UI0wc6DEsmekk3h+DnO1mvY9UnAG8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftLLvMjNu1jyYb7XmZXhVIVwejqx44afKtjSJEY8b2dh7730d
	7ZKBYJmivSDdHfL7OxECwbE33wknRaaVPFvClx5gk9DxJNatgFuPClroZsULxcqU0/TGDYONYzg
	UxlYH/Plvk7hVtkR3dkcbq36ts8r0lWM7xc8BL75KFV/zDPQR3HZkOf7pLBK55g==
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195703766b.51.1724934796391;
        Thu, 29 Aug 2024 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/JxqSYvZUsly+VKW9p0GbBwk8Ss46rzovAiRElrugRH0yhB2zK0/lvCUzjRHB8flUdXeiqg==
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195696066b.51.1724934795491;
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.99.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e8csm74386366b.105.2024.08.29.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:33:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <22bjrcsjxzwpr23i4i3sx6lf5kkxdz6zjie67jhykcpqn5qmgw@jec7qktcmblu>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
 <20240829081906-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240829081906-mutt-send-email-mst@kernel.org>

On Thu, Aug 29, 2024 at 08:19:31AM GMT, Michael S. Tsirkin wrote:
>On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
>> Hi All,
>>
>> It has been a while since the last email and this patch has not been merged yet.
>> This is just a gentle ping :)
>>
>> Thanks,
>> Luigi
>
>
>ok I can queue it for next. Next time pls remember to CC all
>maintainers. Thanks!

Thank for queueing it!

BTW, it looks like the virtio-vsock driver is listed in
"VIRTIO AND VHOST VSOCK DRIVER" but not listed under
"VIRTIO CORE AND NET DRIVERS", so running get_maintainer.pl I have this
list:

$ ./scripts/get_maintainer.pl -f net/vmw_vsock/virtio_transport.c
Stefan Hajnoczi <stefanha@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
kvm@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
virtualization@lists.linux.dev (open list:VIRTIO AND VHOST VSOCK DRIVER)
netdev@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
linux-kernel@vger.kernel.org (open list)

Should we add net/vmw_vsock/virtio_transport.c and related files also 
under "VIRTIO CORE AND NET DRIVERS" ?

Thanks,
Stefano

>
>
>> >Hi Michael,
>> >this series is marked as "Not Applicable" for the net-next tree:
>> >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> >Actually this is more about the virtio-vsock driver, so can you queue
>> >this on your tree?
>>
>> >Thanks,
>> >Stefano
>


