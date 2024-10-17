Return-Path: <linux-kernel+bounces-369991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8D9A255E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56AB2834A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864CC1DE889;
	Thu, 17 Oct 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+hKGFCA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5321DE2A4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176324; cv=none; b=uey3NAeJeGkzUxlil4tbj4q1x0oG7DaCvjkgQ0hD/oMn0dDSOAORB2QL8rVFI0mLWu0KHVoUzbrvwq3R9LBtz7X/DzE06rTjd+51V8DFYMNObIQqDRZrRe9dbPoRwrQo57OaEzazKkq3JJM0gv82GbiqmOKgkPJIamH9Cvk9LxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176324; c=relaxed/simple;
	bh=wxpEnPUPR/5uTo8/QFidqpzx2iJ/f+EeTj40rscTLUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZ55QyXg5hbr0+/rWKvKqnJZn8mVw+AyLRzXvh0llHHAk7nHln+SXO+DtKIU7WPhriGKdqCIuqCp7pq6q0hUxjDyCXW5NYbsxRtJjJTLG6Q5JKMdXUWJOvfbzpJ/4VzibS/Xdy/iC2deVzvIBcR4XcJ/y6nXNAlryw1kY80h5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+hKGFCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729176317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxpEnPUPR/5uTo8/QFidqpzx2iJ/f+EeTj40rscTLUY=;
	b=L+hKGFCALor/qnsPLhhh/PQta/U3HLHysTiWpETuJRGvS9wHWuRZA8cgEetopAA683/1qn
	vh1kc/DxetcpxJuxNSYuMWNRJnG6u7h8PJ/I+I4bM40J6fr9YxWUPr/9Cl1v6Y0c6tYETR
	+r6wSIOQZpvgwY9dTPvSrBUlonm4KP4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-4uKSyhUQN7G1wj2gRnZ8mA-1; Thu, 17 Oct 2024 10:45:16 -0400
X-MC-Unique: 4uKSyhUQN7G1wj2gRnZ8mA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99ea3e1448so63512266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176315; x=1729781115;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxpEnPUPR/5uTo8/QFidqpzx2iJ/f+EeTj40rscTLUY=;
        b=QLzZ06vq7jaONCgvRKMufg5078vlZVyU/dbZbbQ9HdDqvPzfD6E5qqAQOJMS4QYj+k
         HvS/Y53Ca1+eQv6qJYYgu7wjkspWaGSYuB309Yt6ZQ0dIs5tdl7/xL/aUt7Z79vmEUrf
         0vtp1Fb6HJhIuA0G41MoSswTXODAn1AVifWFzDFfSMMI2QObOUdBMLguG1IpexFnABrl
         FuDENfXGAlekJq6/lJJqIqzPDr6P/EG1o0kG0aXm2zvolyShK4tYOYw9hPEjqwB3m/oP
         8W/keuK5XZ6urhcktfWqYPA9zUycGPS1Wiko7QhkXMwBFZBloScGuKtcR2oJWE6vYm9G
         bRdg==
X-Forwarded-Encrypted: i=1; AJvYcCVco18yQVY7COliirBCNZNh/GKlhaHhclIv8F/Oc/dsPP0Gm2JTZv2rqXEzIjeFiAXv+DxRa0VNxRAc8+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9gu/mLkDLL4QWxSqtP3AZOV0JJX0KPk6ENy9mWSm9g9xKZT7
	4Skd5piP5fK6bijh89LqBgx0oclPyslADi6XqogT4TD5b441ApJyu8DNjoAN4pjHQBEFlyyuhG7
	scDiR7KaMGKwrs5vNPs+pH0P1tsX0Hnf4GJi2rS6jB2cNa1QffzSisaAwXSuCpg==
X-Received: by 2002:a17:907:d3e4:b0:a99:45c5:339 with SMTP id a640c23a62f3a-a9a34d0ae93mr643408466b.32.1729176315481;
        Thu, 17 Oct 2024 07:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExQkfyHcFy//Hqbg2rl4jzcrlAL15Mc96dN9JnB/hqdts0BUtGI7iqAMcORsdlQDKCEyhmVQ==
X-Received: by 2002:a17:907:d3e4:b0:a99:45c5:339 with SMTP id a640c23a62f3a-a9a34d0ae93mr643406266b.32.1729176315049;
        Thu, 17 Oct 2024 07:45:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298433a1sm301653266b.162.2024.10.17.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:45:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3809F160AB50; Thu, 17 Oct 2024 16:45:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 1/3] bonding: return detailed error when
 loading native XDP fails
In-Reply-To: <20241017020638.6905-2-liuhangbin@gmail.com>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-2-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 17 Oct 2024 16:45:13 +0200
Message-ID: <87bjzizt3a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hangbin Liu <liuhangbin@gmail.com> writes:

> Bonding only supports native XDP for specific modes, which can lead to
> confusion for users regarding why XDP loads successfully at times and
> fails at others. This patch enhances error handling by returning detailed
> error messages, providing users with clearer insights into the specific
> reasons for the failure when loading native XDP.
>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


