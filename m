Return-Path: <linux-kernel+bounces-337957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF830985170
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2181F24B01
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98DA14A60F;
	Wed, 25 Sep 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSfNEiQr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965282F52
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235073; cv=none; b=SQQgj4Ml50IObmBmAEByypaVRnIunVhVi0hLmjt594CPsOBNHihna+Li1vNRJYmof8B/3xdvpxEc4ChXb4cFgP9lE84Tip2ZWGEFK3uORupHY5SEFHdI0+V8LGQ8aVpT1l1Wz8Q92EgklZ2PgAKxFqW+kMt6jHvjFkbmjlbxCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235073; c=relaxed/simple;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdt+tZAy4TxrKlscDZvEi0XJhq5penqN100dqCmtYWtRbs1+uW95IhITNnTDIbyjOFnLwq5YwRpJMibwY4Dd3p3AFqJmDgQRxjinpFvZfiB5ye2e/RePf8g4RcxNxCRAR2jjLtUZ34OQW+itP3enCe348/uCYyaMnEhExT8P6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSfNEiQr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727235070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
	b=gSfNEiQryX5Qntgto1tG6oWI8Yteq3asQBw9mV0khYlN/cDkXo1gOithLrHHonTnbrrbCy
	aQL16PWKNa9TQLZJCbQV+YztanCBtx+JWlIorV7USyWzhvFMH5+I1g8ZIE69cRxTKis+wP
	w8Wf+q7zw4l49h9OTQtL6/8dzH890ks=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-qhZdi8vKN5asgANo63mMHw-1; Tue, 24 Sep 2024 23:31:09 -0400
X-MC-Unique: qhZdi8vKN5asgANo63mMHw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cd7614d826so600465a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235068; x=1727839868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0Ynl+OetR8GBYZEwi4ht5kW6Ch+UvBVR3yT5ZWcE34=;
        b=sU2Ffhzv1CGMW8ZXIRva2PtnBxDt6Xz/Spc17Lcu4kz6zlGqjcsACqGVBQ5EWmDtlz
         FloFiA1g/LEDf/ciLl0zfym3s2seb97mMN3Y9e978+oWYrV8L76v4jfz3fO39j5s4Uvt
         uNtnRMGer9yNhF8enXBev0z4hNLmLHMfb+jvfxY2SsJW2lgKHrzR4m+Zb3tCJxRCDGCM
         mdu6jsUBeMNOYrIy0hTV96moWcJnnyPn9S1Efg2DI6otGYWHHDeUAe6u0XWiXDh3EWcI
         jrslaw8X2tLCfWwls04NtV5wkGIeUBbGi3A3VjV7zj/WRCkIjPiPnCQYza9jNfCd6EnK
         TIOg==
X-Forwarded-Encrypted: i=1; AJvYcCULA98vKOw+uLYqYl869FDWu70mP3NHj3MdukRZxj23Xi09hBZOZZI5fP+uiq8bTMVNTGiMcjRjMVFJUKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbD8dx991veTOxRbT3GfTnT4CR4G83fRfSnOOKNgRc8Fo3tCD
	rKNDL7XsgC7yfl4NM62j2pNxtcumxhkcadeEX63S2k/qsubFmJ0Z4W8opkZ0TJ8NpvUYDz0p5EG
	yk5kdzWZ9ctCUY1vImymFO0qu1RashAFFfzi177/lc+pYEhw7dvmKud/Otl8HKNR/XO4KaTYkEU
	IbmrUVDb67CjkSJAzTZt9RePWvDfurDpMLlIV9
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2e06ac390c5mr2020776a91.14.1727235068207;
        Tue, 24 Sep 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSXnVXH4KJFogFRlAqrxz0oHdsU+wQjcpSOWPpZkunKpdZpa8uVOFkj6NCDsQxAw+PRNHCHqUsGcOkqjm3ok=
X-Received: by 2002:a17:90a:d18b:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2e06ac390c5mr2020746a91.14.1727235067738; Tue, 24 Sep 2024
 20:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com> <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 11:30:56 +0800
Message-ID: <CACGkMEvKPXCPi6=1938J-k8JNA+hHqzRSt1gPQtqBvSfcgGZeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
>
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

If we decide to go this way, we need to make it reusable for macvtap as wel=
l.

Thanks


