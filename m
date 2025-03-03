Return-Path: <linux-kernel+bounces-541376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76946A4BC40
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1439918948DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B601F17E5;
	Mon,  3 Mar 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp4f0Qjb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2B1F12E0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997737; cv=none; b=a4e/yXVjGJhtGQccUg7bGM4RDP5zYbZ7uxoKKdrT6gzO+smG+0+Vyg7yZy0f5yhSwMlBKRmPkoCSgNJHmAtCNrLiaEUrzDEqSkfWuukqTmHPTykyG/6E+nWKPfbVce2GYGzXq94462XHZRvNZneoSt9mstiN85AtzKCE1G1nGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997737; c=relaxed/simple;
	bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsrKfn+y1cwERLZygPMf1e7pUjR8PjFxhEtDMMM6CterRZffhNkmhgZ+VV3xQj9/mXrzh876N3tcZHB3D52s0b3SctZRj5NB6bgQC5I9mSrch5M+iUZcgd6PXPbFOrPCfD1XNCudiQNV/J1vmtNderk3pNYMZCEI/nPbUi1fC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp4f0Qjb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740997734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
	b=Gp4f0QjbIP1Wn4qm3jDcmmevsaB6So37hMAeZzwwOlWIgDWKta6z0KvKjAYkwcgENOmTHU
	jKhmhF1wL+LUFvqgsE5f+I/CSjVOb0gm8+h+xVNJYaMTJMWsUosEzIV7KH0KeEG3pjvHzu
	g1RJvYPmY7I72t0PHydJ1tkxE9RfHPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-AsmCCXQTP0m4jMij-l46gA-1; Mon, 03 Mar 2025 05:28:43 -0500
X-MC-Unique: AsmCCXQTP0m4jMij-l46gA-1
X-Mimecast-MFC-AGG-ID: AsmCCXQTP0m4jMij-l46gA_1740997722
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf5bf52939so36687766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997722; x=1741602522;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srl1pIA+ThlTF11L33x8WkwY3Gi/4wZSgcLDLWp5Epw=;
        b=EcUbBI0UEfbW54tGZxB+0Aka3ehcX+CvaD2wzCMprKAuK6uDbXPAUrlJT80PpXJmRC
         WaOkIhZuAz4DYjOPgzJVNXk3zIuUcq2TE9r5tFuJM31X+ieR4k7G+cmTSo3OdG9KU8+i
         gfjgP8Af0vNvCtBPhFfuh0vb2sQuq+4PG7qmiNcE+CIWnO0v++1vfvCOlB8uGDr/LUI8
         xB3gjyj+mtiRrBj1+zbuT2Y2msiiMVlSikYn+hFzt2sW2cIbftplaoRiKvgskYdWiG5W
         ZrobReyRoqnDXSp5DCZAHMzBbckWxcOSbpIeHD3G6N1Ldfn2EqDQ/Q/sphu2e69cOLJv
         4EEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxtkEhKSAdkc8aHKS9cBOVbyCsKJoxRpwsvgg5IiInSNTaTA+oIgcL6NRjn2PJgKb2W5lWfp8V0AD785o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmiCOBqiI9r9pPg4mHkrr3QTEbPtqE61xSbXZFvP+3B4KO0Oq/
	AwFjOQiHXWz+jgqCywis5Znz6JqyHvyGeRV6r9CpK6iXxifW2ert3xyf22jWSJIFnLjy+vADs2r
	JU6BPzP/zdc27M7R+qgVNVyseQioMXXsEYGsPxsng7OeYFUzduIbyCZrV60Lk1w==
X-Gm-Gg: ASbGncu70oNtndz7YTPhYgFl4d76WWmaUTCdgogsWuLItGF5islVdZG1t995t8PN1tY
	1/d6jRuVflfPKsguUggRoSykuNCFoBdqws6+xfTTFvbCixqy8BQYUDZHABPWy9n7bcqEuAdm1h/
	J5tlH6d0bFE8wyQ9ojolKi5LL5MkkLcQ3L9E3Htl0un75hX5KtNeY/rm2v+imCSd/WailczF5b3
	twTrejSkcPYz0Vn4PO9ob3V/bmc63OhnHf68vSWnVvDnpBY18FIcMpnmXqWnigt/i31j4SDRMZc
	KxDrxOGagx+6
X-Received: by 2002:a17:907:6a0e:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-abf4ca9583dmr1015488366b.32.1740997721890;
        Mon, 03 Mar 2025 02:28:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7aUVBrdX1KlvAg+sycMlUbpc7AuA9RpLTN4rd3uI2Rj9vDiIS1Rku9nxqomui03mBJPMx3Q==
X-Received: by 2002:a17:907:6a0e:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-abf4ca9583dmr1015485966b.32.1740997721466;
        Mon, 03 Mar 2025 02:28:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1debb25adsm77555966b.106.2025.03.03.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:28:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B0A1F18B6F1E; Mon, 03 Mar 2025 11:28:39 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ppp: use IFF_NO_QUEUE in virtual interfaces
In-Reply-To: <20250301135517.695809-1-dqfext@gmail.com>
References: <20250301135517.695809-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Mar 2025 11:28:39 +0100
Message-ID: <87mse2z9uw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qingfang Deng <dqfext@gmail.com> writes:

> For PPPoE, PPTP, and PPPoL2TP, the start_xmit() function directly
> forwards packets to the underlying network stack and never returns
> anything other than 1. So these interfaces do not require a qdisc,
> and the IFF_NO_QUEUE flag should be set.
>
> Introduces a direct_xmit flag in struct ppp_channel to indicate when
> IFF_NO_QUEUE should be applied. The flag is set in ppp_connect_channel()
> for relevant protocols.
>
> While at it, remove the usused latency member from struct ppp_channel.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


