Return-Path: <linux-kernel+bounces-234352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F691C587
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2D284F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776C1CD5BA;
	Fri, 28 Jun 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EArBTuls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E71C9EA7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598519; cv=none; b=ix4A3G5VitwPcy8pdfLDUrCAIEvS+Pdv4rspe34XsrxdJDgoDeewgYOjSEjFyUA7vj72oK/m0PJasml1y232uy8Hex0G6RkRX6rIlXKl9kICCi9Cuew21Vg31KsOVqo6sUHfrJxNETqx7HIoQ0qaoNjPzDHG4P+kjIIM8TDmubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598519; c=relaxed/simple;
	bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocMSBCUOS3E9PgQGgfaPtMK0hUbON9VriiRHBPeKcJx5XgFxGmVtcksGsZEBiS47iggu7bgZ1VqE9OqBzp19FRZ7xPa57L95R55ATROt+LI5Eay90vv6P2GjNnnZ95JOmZHGDapKYIb/OjWZtC4t6+VbMC4xd66Lta1RY55w+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EArBTuls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719598516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
	b=EArBTuls+sXTlwRCzWffOn0L41peN1XDZLB2w6CXFU0ppqSMU0BYEVzDyV3ZLRNY1RI8s/
	io1aqywyWbEMKas+5Y30au6TxZv+8roTWRqCrnzyf18CBqPqB+yvb7AIah6HtDHKNIV9Bm
	QisRpuGHEwuiTQmgt+5Wt95e8ulbpiQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-wnqp5D4UNluum20LF7vxZQ-1; Fri, 28 Jun 2024 14:15:14 -0400
X-MC-Unique: wnqp5D4UNluum20LF7vxZQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a72af056bffso71631966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598513; x=1720203313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
        b=Z10yyxwbNal1vQPjKglh3nExQB2OonkFdUqHo722f2ti5Dn608PihD8Subke06GAgK
         gGeSnAaBkGAOB7yt66hrFFAc2vFQBoyNQSmjzI0v998eA3gVy99umGjYXFk/CGD3ofhJ
         fXI0cdtJThC3QOxLxl/0N1Hw/AXFTFR9W9XnOJaRibzEZOhUz08JmZLp+LS+wqOWjwB0
         teFmRyTSf3vWHGOnf5aOtzPHMjzIPNkuk8EQxSECcELTnbObAGTIdPgaqRVlPh5bS3X9
         U2lG7fHVzGEDkX6laockwMp8QPoF70MfRfLVzZ1xeuSlA8nE7Y+J/8JH+3GGTLTF6jGJ
         yQrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+gjAW2iwNO2R8k3gzMnoK3C1I2qaS5SO5iKK4ZTlKb0eZ1cDmCchuTMMeNQpeurFJ08VdXiI9F6xhXZ5OA/ZRa0fu6St2rlRAp+3r
X-Gm-Message-State: AOJu0YzpnEvONEN9GkxC8hF6/9iBNZAdpgpdySk6CmLqmrHVYrPd0AwS
	/i324Kg0FcOuVB1czH3YDusdl0A9vst7GKlhkmJ7esqM6OzjGzg1ax3fgt1SMpSOHDO5Vj5JlVX
	ewiqYLX4qmlrnoB3efWvTq7ysoTF+aVi5aq+jF5aDzpIRT9NC4AQMpKbt5Euh6Q==
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id a640c23a62f3a-a72b055407bmr190680166b.1.1719598513221;
        Fri, 28 Jun 2024 11:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqybnIlUkh6FCuDhsxUzrNgEu8zdev7yIXr+vZIF1T8yLJCjO+nmuU1Eaa1BjPkAvAX9eDrA==
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id a640c23a62f3a-a72b055407bmr190677866b.1.1719598512804;
        Fri, 28 Jun 2024 11:15:12 -0700 (PDT)
Received: from [10.39.193.120] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b8892sm99875466b.222.2024.06.28.11.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 11:15:12 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/10] net: openvswitch: add psample action
Date: Fri, 28 Jun 2024 20:15:11 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <437859E4-AD40-4257-8860-841097AEE51D@redhat.com>
In-Reply-To: <20240628110559.3893562-6-amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
 <20240628110559.3893562-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 28 Jun 2024, at 13:05, Adrian Moreno wrote:

> Add support for a new action: psample.
>
> This action accepts a u32 group id and a variable-length cookie and use=
s
> the psample multicast group to make the packet available for
> observability.
>
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

I think this patch looks good. After some offline discussion on alignment=
 with the userspace model, we decided to proceed with a psample() specifi=
c action.

With that in mind, and considering the additional changes, this patch loo=
ks good to me.

Acked-by: Eelco Chaudron echaudro@redhat.com

Cheers,

Eelco


