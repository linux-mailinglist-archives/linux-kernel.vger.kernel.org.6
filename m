Return-Path: <linux-kernel+bounces-376055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586EC9A9F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD41C2524C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3A199FB5;
	Tue, 22 Oct 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpQCMdAz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F50198E91
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590938; cv=none; b=RfRHk1C4JyyyKtO8z/PaSGxFrfetqrid2ZZeNGc2D4msA2mjTvNoFeXsugXNYhj0c4M323+gxNz2nKaUgNNvhIJk0lKxgWUWPwyTzJGjjX41uPLCTytCN+kYN4E89cuY2iHjmGr03HpenmbhlMD9yfzCZnK5nGuBOyeL09FRoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590938; c=relaxed/simple;
	bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsNU9Dzq71SSuxTUXUFAssq8aQAOI5ve1RIMMS+gkoExx43OOdqGkExikCYbMubC7uDRNt5F18yekCiaPYvbdFq50zio6cAEMDH6rIzcQreaLIGlS9MoQ3Gdr5i/Evl/T3gXe0cRhOiluNJQ2r2/6X78/1ylM4qXelPWT0I9e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpQCMdAz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
	b=SpQCMdAz5l4Q/BYwYXQ/sER5YLgSIL1kt53ppQyKGtInB/G6bgfi3diAIbmkyRuGUr/qZ3
	S5XKWiDpEzXjxaynVYdwOC3DNwEMDKHX1FPjybrSJP9gMZiyU2BidyUBt71MdHbzH7C3po
	aj5CkTFePZ9GrHKBAfiIcpAVPd5hTTQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-V7oviks_M1y8tq02Of1UWw-1; Tue, 22 Oct 2024 05:55:34 -0400
X-MC-Unique: V7oviks_M1y8tq02Of1UWw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so39723405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590933; x=1730195733;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
        b=l+u4ob0aTg0EjJCYQk8NtT8SaRwm16FRcUV8S3OaKG0YjlvIRGQdty4bQieGw5R0Vq
         kSgm4l+vHQbyJ6H6YKOd5QSQIxAaB4c2czOTt6LOOA9/rIFLI0HtboXQioojDNMUkKWJ
         DW1iSsUbQjLohTkvINeXjgKkh9nkEJlgcGXklCu4RfMQkvPz5TIFx6MkCfmMcg47v9PW
         2DqE3cXefvAYx1gQ3oJ7JeBl7QeWw7ozTJykxFQr6J5DvNJdPjKYAgHaAWYMLeBMWffc
         88cLxFqfVZvsIp8H6hD+2ojYogmwSr1uKBioqY2IBomACwiPKRxMsUJu2LwKWDm0zvuy
         eUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdv0jWkVJ4Ba/GF+yA2nn1Jsk/ySewrZ6wmC1j550238S/JTDpe7yD4CfXbiOakjNJUQE//lODJyvN6fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7RnS75Qwk1jLppCP+3EhwxMS9kTd6i9Mz19uCqnZEKKF41f1A
	FxAEjyHC8INgIkdyZWh0ofVDvIal7WZKxKUPzPcYZnvGmRGcvDN/l3h+zKXXmUWGaZspXfTtq4f
	LaV6ERtJ8vrjbP36ftGedz1Jhl2SM1ndhMvIPykkcKVu3IK9/ITPx2R7iwHl3JQ==
X-Received: by 2002:a05:600c:5124:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-43161691682mr122114235e9.30.1729590933370;
        Tue, 22 Oct 2024 02:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgyq6n+8jcts2tjTo5SADW9rqMjfT6xN3E7y9DOoeJqaiyEJ0e6Yke+AVbsNQve6hNbgctXw==
X-Received: by 2002:a05:600c:5124:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-43161691682mr122113835e9.30.1729590932884;
        Tue, 22 Oct 2024 02:55:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm6296161f8f.84.2024.10.22.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:55:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DAE67160B2D3; Tue, 22 Oct 2024 11:55:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Helge Deller
 <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shuah Khan <shuah@kernel.org>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: don't mask result of
 bpf_csum_diff() in test_verifier
In-Reply-To: <20241021122112.101513-4-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-4-puranjay@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:55:31 +0200
Message-ID: <871q08ihrg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> The bpf_csum_diff() helper has been fixed to return a 16-bit value for
> all archs, so now we don't need to mask the result.
>
> This commit is basically reverting the below:
>
> commit 6185266c5a85 ("selftests/bpf: Mask bpf_csum_diff() return value
> to 16 bits in test_verifier")
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


