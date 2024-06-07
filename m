Return-Path: <linux-kernel+bounces-205457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E68FFC4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1CE1F2369A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A71527A0;
	Fri,  7 Jun 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6Z3qebR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55945008
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742148; cv=none; b=dwBLWG7+f+tGjIQT6V85yQf4hIywKYCRYQArgzlaAKOO4ZdpgsX/b8VA2VeRXFSLDa796O5RkASEQLSdgizh0dky4Zi71PHXK2E0HxuO2R9Mqj4grOi2Q0Ln+xX/43A4ZwsqJWNmwB/VuU1p0EZGVt5FFLnEOPJ2A1QdcEQRZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742148; c=relaxed/simple;
	bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChU8Uh/sC8ct728+DRg8Zg/COd3USynhgfA3q1MXZOeVb59D8jxadC1JYSbxOCJEAfz0t5so9pEOkqFPyfbk/lL8buWpFFgx1hRCgwS/ix8uDGK41gyB2GI2EISVcYTWqzyOquK0eNCMfjn8jsGKDiJZCuHEUyv78/DVM9A7QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6Z3qebR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so9593a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717742146; x=1718346946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
        b=O6Z3qebRozuaXrdItPF6U/X0GkPvJTO/BwV0iHOr3HgIdH7VyQMuctWBXynllyqEUb
         nxcaXZ7YCGM2HmZHsYh03+U9mqnS5LAhAAo2QEFrpOjjRTYlT+gYhw5CzPnbgnWLb3WH
         NQ0Z1T1GVjlGxTyH3RIVPbJ2XUu2hW5QegI/PQadVWQEb7YT17S50n6I9Wy9GZS4Riqh
         pyFB+vEy+mY9Wtk3TlzxrbJ9v2NWI7QAJKq7Q7zgCW3IG+4LJJ27RwHOoYQoFrt5Pzyw
         6c0gZ5uIuvU+PlA1/BDUhz3Gj0UH0S4bjEhKhtNFZbuaQsgX54jMfh2N2cOgCsagnieP
         WlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742146; x=1718346946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
        b=a4VcFX1xtyb/zyB8ScB9GHqAB8s4CurrFRycanNyHpuzJFskUtffZjIWb1SmdhZ5n2
         JptSqWlYRA3BN+zVWelH2M1MxWRxwKRKQwTG4HnWhuyGkMbeIDygSpM/R8O9Uo4YSRs6
         KVAUJCHPM3pzcG/9nHhpti93IC5BEm+z+vouz8DMHEuoMQHlxsO359qdeq4C+b5TffN9
         KeMVHlI2NGjAZtss2hnueeRZ5a4F7+ysLPfEFlUvXNZov0jszrrp8NSPyVIauCRSVRMg
         QdiqWNIEXZEa/0sLFVNriN0A+21Ld83U7SnAK+ce6mk6J1HoljvHYyzpqEFYIJpd1foQ
         m51g==
X-Forwarded-Encrypted: i=1; AJvYcCV02cJ45K1ieyDOp/1W0dUBqYy69VX2JMgJ9QE4sacePy+jYLEI1d/dMi8ZUdD80jhMmO7Qvd3TmpQrV5DqzM+CIJ8i56JVhuNDn2j8
X-Gm-Message-State: AOJu0YwRXkW9cjKBOUc/Nte6CVTx22KiRfNjmhlZpFf7dIgyKGlbN6d5
	LyJRQQaoW5laNf4c3C1v/vp3MUX5WIq8ox0g1JD65vKOyhAh8Xw4zaatV6DSV3WTzZWMhDcKMiQ
	eJR1sQgPstzIn42yIVJ8pY6rsGasvA0HTD8gbY7WFExkhowCpxA==
X-Google-Smtp-Source: AGHT+IF64JuoiPukSNP2gEYzmiAaRR7C51MbEvSdVrxmayAIXhwe79uUqXfwQeRF4HSgZ8lXBFI/4q1ZrGMcOMdXg/k=
X-Received: by 2002:aa7:d307:0:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57aad3278f8mr374926a12.7.1717742145328; Thu, 06 Jun 2024
 23:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606192139.1872461-1-joshwash@google.com> <20240607060958.2789886-1-joshwash@google.com>
In-Reply-To: <20240607060958.2789886-1-joshwash@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 08:35:30 +0200
Message-ID: <CANn89iLy1qGXzrv_coRcaRDOrOMHKb-NG1xn06Sat0QTvrDwXA@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
To: joshwash@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	stable@kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Andrei Vagin <avagin@gmail.com>, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>, 
	Catherine Sullivan <csully@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:10=E2=80=AFAM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
>
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.
>
> The gso_type and gso_size fields as passed from userspace in
> virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
> |=3D SKB_GSO_DODGY to force the packet to enter the software GSO stack
> for verification.
>
> This issue might similarly come up when the CWR bit is set in the TCP
> header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
> to be set.
>
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

