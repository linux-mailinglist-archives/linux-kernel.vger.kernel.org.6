Return-Path: <linux-kernel+bounces-533089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F7A4559D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638D63A9664
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C12690CB;
	Wed, 26 Feb 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K37PiYz6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4A18DB0C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551511; cv=none; b=q1JaUldRz83vKvjG36A9oniPzryrgIH/KB2RcU7eKfXnONZbdpnrShI1z1+JdsjEXAtnkA2QOxGEkZcnjP9Sjga0vjgeZCvY4RDg/E/8PpPoGPpAJF7HXJpw1Dqm9ix+ioNo0V+KELfIciFja+mkbMsxXKerELxwW7+eXs5hHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551511; c=relaxed/simple;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3oRrrws8ygunkVQk4pKAD382z6pLOWRhyuhgkc2NpYDMuC6ccUh8NgvW3IYNNofTbabZg7a9rfSKpP9P/s3cuqkypmTMO9Fyqebb7VQpeLCYgvcyl1QXPaLdY42xPr2DoZmPpgkp2gJMqaB0ZZuCvKXunWrAQPmzbcclxBYcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K37PiYz6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740551509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
	b=K37PiYz6V9xEAAhAKfDA569NqHHfz2njpCvNZ6xT4gSDRx9t1TsfPOkE+jpayzsfNe/WBu
	8LN9A83onEYzV44hHVfUrbw4B1sya4GDfcYtwEgQjk5d6tdGnLNHxBryJJWLTzRZkcnSzX
	h1v4KIweUJOa2+nfZORwZitmKuKixoA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-xgno1ajIOq2_qoK80PG3-w-1; Wed, 26 Feb 2025 01:31:46 -0500
X-MC-Unique: xgno1ajIOq2_qoK80PG3-w-1
X-Mimecast-MFC-AGG-ID: xgno1ajIOq2_qoK80PG3-w_1740551505
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc2f22f959so1148339a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551505; x=1741156305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMIoZiMZ4mhGg+0vrUQlsibF7NLzRddktgUROVViGko=;
        b=GfWCrPsRV2ySXxGJWx+I/ZDfjH/8d1noQr4qSn4jFsN5ax3tmsEAOs7kFrjnusoyi3
         rIjd+Iisy7E/VvpADJIkj8rvUc85fDCYBeZZjLaO+bEJcf6WavunJKwdo/AbOkTRBt4O
         qKaToo8phVfrB1lVc8NmcpJk+gN6UhWRPbHiNuNiIwlXqgagxoZaOmcz6koZx+18cKwE
         oTT7g9DVTo6yV6KPfxyVu4d3MIwnWQQTFLO3OuUVR8Um7dPAOY5OLjWRYKrwDquXUKmq
         U8Uxws6zPypqMocjjwE6VNQHz7BiNIwNPQm8/E8UoUVRYZcPm9fYs1xdfZ2dkh5IOqSS
         7mAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv9STPfk/EBaei7MaSPvPo6+66X95o5TYkCiuDDOvAP2v0Y6pLoKmaGOb2741sYhAtYJL/RjAsl9VgLUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0rgz4/V+Uc2/ZJcoePBF3J/MgkvNsgegDOdkRmIWFTGr6TQB
	cbmwSIbmPALx21l7qDndNkY+i11ruHx+Vz37wi/ZdYm+DF3Cr9LuVV31RJuKyL5eCYCZ5vsya+x
	DCbUbeFLbeocXUgMtF2JVthR63+2Ulfr6um3qk+kyRSa+0kDjQWCUSBosoWWJtQDJyACa/ETjqW
	sVHwbjHjpO743zP09o5hAt0N5XpWlQCyC6adma
X-Gm-Gg: ASbGncudJdyHIsOmLUTplomnuG+oubRCDUu8U4CgQWTK9dbqw0/0i/3AL4HL4JUm9SD
	ShxjhjVuxqWq6uidIAhlKVdLkBcMn1nwukkORjq3GIfuKTtZy9XeSH61mARwvOzcRViFo1EZp3Q
	==
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-2fccc117c76mr44400174a91.8.1740551505315;
        Tue, 25 Feb 2025 22:31:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgJ5uK64t8Qtg0HyTf+eyJQk/RcSifCuXdoxenxtpslxzpKs5bezA8wPuv+n2H82B3bP4YRr7ay+RtusUhlC4=
X-Received: by 2002:a17:90a:c105:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-2fccc117c76mr44400139a91.8.1740551504951; Tue, 25 Feb 2025
 22:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 14:31:33 +0800
X-Gm-Features: AWEUYZnqLtwn7p8rdsbyWWPnxjSlaXy5DuVDq_eYBndkM_qofe9C8RC5AoEl0-4
Message-ID: <CACGkMEuoaqKB-4rs1QgsEU2rDn5s5GTJaL6jOiFj_TDSF2pC0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to
 network helpers
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


