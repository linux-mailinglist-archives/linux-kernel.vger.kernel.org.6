Return-Path: <linux-kernel+bounces-430990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90E9E37E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83921282758
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4D31B0F33;
	Wed,  4 Dec 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB7E5aLB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09D1AC8B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309420; cv=none; b=Ol0piy+jrgTQ7GicTGlWXFi7rMMIeBTrkjB/tY7j9HasTkK2wmL4+f8j7mjJqXMcThvZUtFE0DT9Jfq15Kve4/g7oInHKUDYbg9pL8r4tw9oYPDFW+wmSbmVzX5EYNAzXivz0r/59Vd6oJAK5nNvzAJRqXf4OYqUz5OXo3Dvf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309420; c=relaxed/simple;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSRcyEsC3y5uWk/G0zHw8F0nUk0pfSuQAC/xJ18G0zngEzDHkG2ISJXSLfsJedisObJM54NQNAfIhSzszbewNwnlX0Kcq0noXmkgXSOYOro1PEU/G4n/eNzkmmB01AwIo0XB6yRZnwCznfu8PNnRxOhNxS0jANISgoEtfdsipfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB7E5aLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	b=KB7E5aLBHCgKZ3EpzCB0MaC385AS7BbH7BQDPDAcssAqALFvp96GjBXUYSXq6WMa1bdQOA
	JfjldVgQaXsYWP7Yb7hvkPzv9vj6VY/W3DBCDZk3fFdEIb1bwulnXH+XzbXJ3mv45ta2dM
	+6jWQ/5w/deqLhY4Qg/Xf0BlJ2gAXpg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-qGs9JrrDO3OTQ0iKGgrKDg-1; Wed, 04 Dec 2024 05:50:15 -0500
X-MC-Unique: qGs9JrrDO3OTQ0iKGgrKDg-1
X-Mimecast-MFC-AGG-ID: qGs9JrrDO3OTQ0iKGgrKDg
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-300182b93easo4588111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309414; x=1733914214;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
        b=ds39/umClXsiHReg/1eyIFS+X088M8J8dSoXQo1nFY6jtWlWkMrw5PEjvnGrK4Z1rR
         pom33SR3bbejVRUKtZf+RCxW0RncpC0+9zlK33fZazF7C8WHX98Jb/SPIlAcGGFZEiLZ
         fDj6CVd8M/T2rThOXkv/eGMc6KnCY7oY0lrLj5A0wmciTqT43fwG75EjTX5dq+YiHrqD
         +Q09njxLAbfi3NyjK8ipJJOXfZS7Fl4CHoSZHjDirNGUK7VriTR5coxnLhfu/0eVpwo4
         +TMBZe1ACEwBGM4Y4YscMZ07ojIippik07TRI7+zk2PmRaLBk2DTzh4nfIN53BUMhgPD
         oSyA==
X-Forwarded-Encrypted: i=1; AJvYcCVzUDMO2iX4xRhR7kSmqFIRhBDzfaHX8oZg1AF2ScQTQ39n2toQmcBLrLiZ9BkNrx+AgYpYeoTWtpXfsKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQ1oKw5JSTHguy7THo2PX4GygjxAar8tpUUXbDn+AMT2pPy/1
	MpEd/9ZkbwIZ4xnrBlFq9ojUL51NhMZ2n42dwFW/xbpxyV9OUwnh28gOcAILrdtZLtlb8IfrlZ5
	duzvcs3FTxUA9RKg9awMkQh8Jra8qu0zzTOkipUuDz7TQ1xx4Bll+COCfjllCzw==
X-Gm-Gg: ASbGncv4qaQDvP/Yq7AlPP2+aTeuIRjFsMwF5SBSRsDBP93G8530Tu+RpAslDxpouka
	vuinfZgwXWWX29NdRK263nbNcUeqOfEiFPtOUlTmNUkcLHSBxY7hV9nmN1/d1jyZqSisc2QuXih
	wRM71bhcLQzg5ceto8lrKtIxsqqJJm+f4JbVR703WL+eTDBN3+fLq9VpgrRv7bv5V4lyzATjOUA
	wybllylD2wBCJNK5qmRvwu0YgYHRqslK6nfPgpSn/kHMMM=
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657411fa.27.1733309413916;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfxB9/ZapzifOSM+BxHGW3corqQgL/f1b34L8O3QJCLkSmKjBpOXgMxOQShubXYhGxcR45sA==
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657081fa.27.1733309413497;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599973202sm712069266b.198.2024.12.04.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:50:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F2BBA16BD10E; Wed, 04 Dec 2024 11:50:11 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/10] page_pool: make
 page_pool_put_page_bulk() handle array of netmems
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:50:11 +0100
Message-ID: <87r06nafj0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


