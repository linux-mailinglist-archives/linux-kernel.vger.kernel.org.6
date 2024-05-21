Return-Path: <linux-kernel+bounces-184657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED08CAA23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F10281D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642A6A8D8;
	Tue, 21 May 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq1yBoFX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD554720
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280542; cv=none; b=lHiiuTs3cOX6SXnkkeXBFm59X+YKqgME743p3j9vqGzfW2NWRYfY1TRkhCdUt3scKg//6ye2WJ2dKQ2Jp1J5q/CV2vQgwkPRok6Dg8adkGSGwyLQ+nAs/7PvL/+luwOYaEsHNoIKSRiEa5B8YHEgOws56KCE6FSF5/wzSS4nTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280542; c=relaxed/simple;
	bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8RDLEClGtN5NATs+nP5aX0Un1PL4Ra69FdmgxlHBz3yfPzn4lAYI/rpgX1XoqmrBQ9tfGiAqC42cme1ichmIeOPsGiLZ9qXAT89x3eLInlbnHK6NxMYS2N2h46TwbvmlfMeGnJmFCwGj+Q4n5CWyYJkX2JO0W5e0209czsPXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq1yBoFX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716280539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
	b=Vq1yBoFXHHMvt5tsLwda1loOTFP1D+VAE8ywrjC2wjzBszNRk4HXory5MPhJWWjm2aQa5N
	ewwiKZxIhS4vpRg95yngUEFswuWVXfQg1I/mtdoB/XiDXy1tg/QGd0CcY02tijSmMTOylT
	XXzIY80+wpgF79fCgZ5N1qG/BWRdosg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-wlQ5Y7BeMWy2ArsfjliC8A-1; Tue, 21 May 2024 04:35:38 -0400
X-MC-Unique: wlQ5Y7BeMWy2ArsfjliC8A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-351c61ba557so1181025f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280537; x=1716885337;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nGdawp2NaYJ0qEGR3Cc8zC9byjD0t+r7RzRvUaR/TM=;
        b=v73ptA0t9gKtFuC2bLY6dPFF+fQz5ZvgZvs97Q8JFIo2aBI8pfC0v/Tk47K1Tia6Nb
         KKtFc5fTbMc9QPhb9b3MlU95tPFrLxSyLH/70FpJpGTq49XESA9yRBZBw7QjN7vI0aoZ
         QU9AsFyR/8/I3whMMHDcQUlXVq/LCuayrKBz7fc1VSgwcxLf9wGAxS93sLGfNGCdVnVi
         HX1RMFN4WG0+kKUD/FD0gMIPycWtoeeyMkw94pfQQBKD9M82cYmaJ9VlkpztbNlvMZq6
         s6WV4/9zwAXk+WLbQj1OxDLfTK5PbqPnYOeJQp1RjpZOaFtrg7TBXCpUo/xmFMz8WFrF
         GXdA==
X-Forwarded-Encrypted: i=1; AJvYcCXiCLRIpeVqUGl9ILkD9JftBihqgrIT3d4Us4TDGmjMaVoObuLQCcxdElNshDmPQmpVKTyRYC1fwQrS0exbvr3tBmpd967/lk2GZ4qn
X-Gm-Message-State: AOJu0YzR9oYvhA8qZnS+T7i2yO6ARZPYYn27QMKYsRezbtunqth14DBl
	MIkZZTEo6/LHAVAK0Huo70CPwGtubOQS2quEFGnBdNALDHHZ3t8lU/VXEuSeptw3Kv3C1iWi0h3
	k+ccgE3MbdtcHG8eor1dbWXDksHHC2idMlUHh3GDZVfLMPmpV0IdHnckU+CY/2Q==
X-Received: by 2002:a05:600c:1c11:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41feac59cffmr228440985e9.3.1716280536958;
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpybhh/i3FLT5nkv4Urg3DzXLx9HVwc1fXQ0xMS+QznFaFgm5R/ZSrF8/c3HPL3ZwWVq5B0g==
X-Received: by 2002:a05:600c:1c11:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41feac59cffmr228440805e9.3.1716280536578;
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010b1076dsm370769955e9.41.2024.05.21.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:36 -0700 (PDT)
Message-ID: <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without
 hardware offloading
From: Paolo Abeni <pabeni@redhat.com>
To: Chengen Du <chengen.du@canonical.com>, Willem de Bruijn
	 <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 May 2024 10:35:34 +0200
In-Reply-To: <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
	 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
	 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 11:31 +0800, Chengen Du wrote:
> I would appreciate any suggestions you could offer, as I am not as
> familiar with this area as you are.
>=20
> I encountered an issue while capturing packets using tcpdump, which
> leverages the libpcap library for sniffing functionalities.
> Specifically, when I use "tcpdump -i any" to capture packets and
> hardware VLAN offloading is unavailable, some bogus packets appear.
> In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
> device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
> usual PF_PACKET/SOCK_RAW socket.
>=20
> Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
> does not supply the packet's link-layer header.
> Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
> the original packets and provides SLL for some L2 information.

> From the receiver's perspective, the VLAN information can only be
> parsed from SLL, which causes issues if the kernel stores VLAN
> information in the payload.
>=20
> As you mentioned, this modification affects existing PF_PACKET receivers.
> For example, libpcap needs to change how it parses VLAN packets with
> the PF_PACKET/SOCK_RAW socket.
> The lack of VLAN information in SLL may prevent the receiver from
> properly decoding the L3 frame in cooked mode.
>=20
> I am new to this area and would appreciate it if you could kindly
> correct any misunderstandings I might have about the mechanism.
> I would also be grateful for any insights you could share on this issue.
> Additionally, I am passionate about contributing to resolving this
> issue and am willing to work on patches based on your suggestions.

One possible way to address the above in a less invasive manner, could
be allocating a new TP_STATUS_VLAN_HEADER_IS_PRESENT bit, set it for
SLL when the vlan is not stripped by H/W and patch tcpdump to interpret
such info.

Side note: net-next is currently closed, and this patch should target
such tree (in the subj prefix).

The merge window for v6.10 has begun and we have already posted our
pull request. Therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting bug
fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle

Cheers,

Paolo


