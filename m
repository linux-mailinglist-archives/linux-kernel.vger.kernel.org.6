Return-Path: <linux-kernel+bounces-545336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A54A4EBC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB69188F481
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305026388D;
	Tue,  4 Mar 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWL6HwQE"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799420458B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112539; cv=fail; b=NLB6zHytyqeDrmHBE0zZtLkCPTUJJDl+jJPzrqxOMB6ON7Bg58v23qoymePKE0UEecSjjcwG04zuSJh0MLVnMsXMM4BwyslJTyF6b3AN/yiGhClOQoGoSadAIJjpcpve8lIqsj7Wx2lN37yEWejY3aqOszA/A4WNoz70CS4tSGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112539; c=relaxed/simple;
	bh=GdjOY2SrkyPtke5eAYK+DEgJfqeH62n+FBszzcnXhBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LH60rOZezf8mtWkSgBVxtZFaVe6Zn77JZSd2hT4SxMB/vph2R63iYUUDUXBp5sghMPsJY4YsizzDzYQ8O60rm04H0zHlTkmTguRLJLKJ6Cnj78gAGNvTUJopux7FOVnv5A6c8BXCmRI7X8uCRQ5X6/20n5sHaMuB0ejUlwuZ+48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWL6HwQE reason="signature verification failed"; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9EB30408B654
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:22:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IWL6HwQE
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gsH0FCKzG30g
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:20:51 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id BE6AB4273A; Tue,  4 Mar 2025 19:20:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWL6HwQE
X-Envelope-From: <linux-kernel+bounces-541255-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWL6HwQE
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C9641426C7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:15:13 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7EC2F2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:15:13 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA116662F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A11F0E48;
	Mon,  3 Mar 2025 09:14:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5111EFF8F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993268; cv=none; b=cG3EgnfdzcVGYK3KnO3HxqeJRhA7KtjVW24nssRsKB9nPW0KX/teoypRtj90YvSK+rRwY63MDWJTv0qd5adpYxmwKBm5b1tWd84UdWu3ySXEkx5+2h1PFhijsrr78L6fFWHnIRBUwTS8xLGX02sH2V0r60Nl8jR9sYNR0g/G5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993268; c=relaxed/simple;
	bh=mCZCBgNa4JfBeO+UdN202MOC0dBcErDpaZ9+i6y6j4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OR9J2XqjOWOfyiXjhwXrAyJO5nGUoxqSRuLboBD8/wDXnMWnVm7pIWyF1enPbaA9qI95QckCxsBMjTiF5MdK+zSSF66QBp/orn/54qxsMcm0UEH1OCS1UfgWVoDv2BvZLvED5dmhunvycu3qmGtB1cBtGMRph9C2JzsQE1+DNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWL6HwQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740993265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQw2p5k8tqJ4bzlOs89ns2VtMHVE85d061ZtoKnG6Lk=;
	b=IWL6HwQEXW9SaRT0noxbqvrvnKqXKJfaHUwOe/ya0r5ZRyTJ4ZByNxSljj9zhl+jC3ysYP
	tcJvHybLzMF6+xedt1Pyt+MME7E+WDfraLQPpi9c3UO4rs62/BIkzLEcbPRg+oHznmuS7/
	AmGrxrXiBSsPD8nEmRtK/s3BbD3MX8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Y0A7dobDN5a1SSmabG7Tvw-1; Mon, 03 Mar 2025 04:14:24 -0500
X-MC-Unique: Y0A7dobDN5a1SSmabG7Tvw-1
X-Mimecast-MFC-AGG-ID: Y0A7dobDN5a1SSmabG7Tvw_1740993263
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so2794655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993263; x=1741598063;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQw2p5k8tqJ4bzlOs89ns2VtMHVE85d061ZtoKnG6Lk=;
        b=F5PTFxw1k2UlrS1Ej9WI7KQCroxNq0rjLRFtLO16/OIwX6jVb1tlbGpygHhcUescXE
         eJrGEo810MqJRctTUgMibcadxB7P8VOgscEfCxTcHRo4FdHNbTrJuKEvX56S5KxP9/HY
         ImIUMX1vT+yYWqBz0V6asEREiqtMHMLlMi3KKVtxd0Z5hJ4EQztNgZc8EAF3r1XRyi2J
         KXsjvmQAAByvRb9cGUeCNL4jz+wQlDy7UAJuf/rJEqWyNgQkSN5JiPypiijeoFLEQ1NF
         aFWKNaxO+7+fStjMVEdAcglDCpRAVVzQxlhMNU/8v8u4odFz1KsMDQHQsqvXF9ErKz5u
         fz6A==
X-Forwarded-Encrypted: i=1; AJvYcCWXGriY25xD2KCXOrsnibNAd+ichU5+TVmX39IF2/xBYSEfOSDRNQuxCMqB+/MMbhz5yRnRWLTiHbEYHKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRa8Ur4+7OyU2D0fleTM4WXB+u26H3ezHTfShwbn3Vdj73+Ea8
	cLXd1NS+55mNASJ241I8ba4lq7vSc9bJWeE5LRVvMn4oYPLRFzZbDufVWJNLYOplVqt3WAU97jS
	5MwHAHbsS6KwLiNlmtzZSFTdBPEZ9NXAud0AlCFIF123jLE1/D97AfLqnNHJWcA==
X-Gm-Gg: ASbGncsJysqjPP4wr4QR5i+5sR+arNZBBI9MQW97PqYaZRaZxPkCEDzvT+niiatTOt0
	iPu15wlXZejXGjf4KWzZEf0NQOwm+tKHyPcn+Phb+gcv0LE4ED1RYuNiClKYD15e9usljG3PkiD
	8wSM8wLwuu1MrAMXKxvGJBQ+kGi+Kr2gaTMu2C20nxaK1X80AeaLu8sUlpTDLilTkGBVixfvj7/
	53MMaGx8CLxsliiROL+13kG+ByZj+poQ46dyuGYlumupeJ0QB8GYto06tQd0F5uE8j2hzB5MaFV
	8mGQr8Zl9efj91gsfmS4ut8Kbu14ksNCWFygepUJ9qSqikDuBqa1xQK7kl2AKlmqMG0Wa+zKFDh
	+alzMzgyv+1l+NsluhRaz+1VOkGiU0duWckdE3Pq6wsg=
X-Received: by 2002:a05:600c:45d0:b0:43b:a412:d39a with SMTP id 5b1f17b1804b1-43ba8368a6dmr102314025e9.0.1740993263145;
        Mon, 03 Mar 2025 01:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBk2txAHyLgtnxudgOZTIcyeZpAosbYSo1SOfl6vxw93VKcatMetKhoauJTs0xjcyLQ0p8Vg==
X-Received: by 2002:a05:600c:45d0:b0:43b:a412:d39a with SMTP id 5b1f17b1804b1-43ba8368a6dmr102313675e9.0.1740993262815;
        Mon, 03 Mar 2025 01:14:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbfece041sm28684095e9.1.2025.03.03.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:14:22 -0800 (PST)
Message-ID: <8609f693-0786-40bd-9136-3a8f9ee9304b@redhat.com>
Date: Mon, 3 Mar 2025 10:14:21 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Initial BBML2 support for contpte_convert()
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, yang@os.amperecomputing.com,
 catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, mark.rutland@arm.com, joey.gouly@arm.com,
 oliver.upton@linux.dev, james.morse@arm.com, broonie@kernel.org,
 maz@kernel.org, akpm@linux-foundation.org, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250228182403.6269-2-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gsH0FCKzG30g
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717227.18971@TgXSgYNZsqghMUVMMZfcXA
X-ITU-MailScanner-SpamCheck: not spam

On 28.02.25 19:24, Miko=C5=82aj Lenczewski wrote:
> Hi All,
>=20
> This patch series adds adding initial support for eliding
> break-before-make requirements on systems that support BBML2 and
> additionally guarantee to never raise a conflict abort.
>=20
> This support reorders and optionally elides a TLB invalidation in
> contpte_convert(). The elision of said invalidation leads to a 12%
> improvement when executing a microbenchmark designed to force the
> pathological path where contpte_convert() gets called. This
> represents an 80% reduction in the cost of calling contpte_convert().

Just a general comment: Nice! :)

--=20
Cheers,

David / dhildenb



