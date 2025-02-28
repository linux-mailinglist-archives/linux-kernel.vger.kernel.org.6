Return-Path: <linux-kernel+bounces-538131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537FA494E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1B918953FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACF2580E0;
	Fri, 28 Feb 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BavGDj5/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097A257429
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734791; cv=none; b=q0JcN/Dm/RF4KMti0YsatsOxXaMo4MRxU1ccYdGa/QtfPAgClN6SCmQqFg6Kfedi6MONIPQbrjKZB5asf/3ixe/gLO2oXcreFWKsit66qMXbGo4flRfJDKY1iQE8uMWbl4G3wHDSy5cOUsIpl12NE7kxpDrsdMb75kgEb1ywQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734791; c=relaxed/simple;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy7sGB2wdlTEPZEQRGQUCKKHBdInMUy7MOZCLOng5EnY0x59TBEGoINAcrosOLFLxLyouMmNi9TWtlfQAz3ykDJS+bcd3woW4GPg5vE4BoIldelI/4wqBMC9wARM5aE27Wwqn81qJ0KX7k94y74FnZ/dtCpUHvYjVrjdybzFkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BavGDj5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740734788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	b=BavGDj5/i86PhS/FOnIADA2YgCqonFhRr4ReaM5Qqxn36Fa99XWaTHVyrQXLuEmE9R/OeB
	0kkRVY4KHIuPXA8gVrop7tJc5CGjzOp9KRxbTDX92ukd5oA7vJmZDVW4h+YT8tqi3xvbTE
	4TiRlEJjLL70pb9Yv103EWIUvoC7mRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-jPDHvF8bNvq6ECP5o93GHA-1; Fri, 28 Feb 2025 04:26:27 -0500
X-MC-Unique: jPDHvF8bNvq6ECP5o93GHA-1
X-Mimecast-MFC-AGG-ID: jPDHvF8bNvq6ECP5o93GHA_1740734786
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399c5baac3so13728635e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734786; x=1741339586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
        b=ruRmz9ED+fljIofwAXtH/qF4viKdRZsZh3J3Qu2KnxbKBmnm2J2T2GTwwEnZarlMf+
         W470idKslHBNu4geplRY4sGg4OU4zGjLKavN05q9TacfpkRdk1M73UnilxRkFWLb9EsF
         jvWDXsJWlfE9GKUAhTZhkx5H9bUd4RMbbHw6bLkC9uGbr0JpIpUqnfevbqUb1biiePNV
         TVMXcRSX/svwQ7+6TcBmXcGMGpMdilDDkY/G0P2wQaMYtP7SfjQdDn2xZmoKnhudh4Yc
         Q8Pug6cw51aE+5zCofNcOKqjinEdGjhr2vxbxQSYfdWl+OFkeiVV2Vcppu+t6wb55LDd
         zvkw==
X-Forwarded-Encrypted: i=1; AJvYcCVasFOrd8zP/Arfxi5TZ01m/DMc6ZGdGMHSEtn2Doh7JqQjOPDdklckHQVadHmTCkIBSPakB0/tZBhCzxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQ+74sEJiz8LHpq6ESxHmNVTTfxvU+eNrhSGUc7dIje/VayXe
	KvSYxh9kJGbo32qOToQbHuhGNjWnmpAPRel44vwpVjIXQ2rL9k4Q6313GQ6LX7wNF7S+YDgXawt
	OXmTuHbnxGTDyr7RB4ucz6Q9tsi2rM+GwJDsWjB/hstniO2i7JP0zp1+Jkdf3zg==
X-Gm-Gg: ASbGncsP/uH1dRtv8PWGk1BitxxhMe97Ysaw3h0Iad9nfyogh0sNFuoRe+LC14ptK45
	BbpHbwbOT+5sWhnV8fjklZgDT0MlREY4ZQRIX3rMgkCGUJt8ab6cWudpImidLxrzYYoPvGTeBU4
	/3llooMrP6LvvdtsrDp1p0g/gQ9Ao/JnGYo98mwSSjiV3tyF0YSN17VLaQDlTVQiiPrCUBTShjj
	WDAQdY/Qouf22WuaaID47hQG8TceIdXrc7gOgu6KmhhRH9HPrr8ulfousumjO0Y3q2VNWOsVF3a
	Vuf3ijIBhjVeyBt5Ol2kwPMJq7R5Y4P+Z6twYGvUmKC1sP1vU/pOSIVxaMCFK8+x4w==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161745e9.29.1740734785953;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrk8HCJDFMTsz7xCP+NNdsyxhZ1X9lB/qPY5M9JGAe9E6mxJhigejXtxTR6plCVUKRLft8mw==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161455e9.29.1740734785589;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Received: from ?IPv6:2001:16b8:3d09:ac00:a782:635e:5e55:166d? ([2001:16b8:3d09:ac00:a782:635e:5e55:166d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27b27bsm49277385e9.31.2025.02.28.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Message-ID: <a7720a091ea02a6bbaa88c7311d7a642f9c7fdff.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to
 PCI function
From: Philipp Stanner <pstanner@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Huacai Chen
 <chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu
 <guyinggang@loongson.cn>,  Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,  Henry Chen
 <chenx97@aosc.io>
Date: Fri, 28 Feb 2025 10:26:24 +0100
In-Reply-To: <20250227183545.0848dd61@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
	 <20250226085208.97891-2-phasta@kernel.org>
	 <20250227183545.0848dd61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-27 at 18:35 -0800, Jakub Kicinski wrote:
> On Wed, 26 Feb 2025 09:52:05 +0100 Philipp Stanner wrote:
> > pcim_iomap_regions() should receive the driver's name as its third
> > parameter, not the PCI device's name.
> >=20
> > Define the driver name with a macro and use it at the appropriate
> > places, including pcim_iomap_regions().
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v5.14+
> > Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
>=20
> Since you sent this as a fix (which.. yea.. I guess.. why not..)
> I'll apply it to the fixes tree. But then the other patches have=20
> to wait and be reposted next Thu. The fixes are merged with net-next
> every Thu, but since this series was tagged as net-next I missed
> it in today's cross merge :(
>=20

Oh OK, I see =E2=80=93 I'm not very familiar with the net subsystem process=
. So
far I always had it like this: fire everything into Linus's master and
Greg & Sasha then pick those with Fixes tags into the stable trees
automatically :)

Anyways, I interpret your message so that this series is done and I
don't have to do anything about it anymore. Correct me if I'm wrong.


Thanks
P.


