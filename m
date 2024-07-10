Return-Path: <linux-kernel+bounces-247326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05492CE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2CB1C21A51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0118FA0C;
	Wed, 10 Jul 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HITQGpHT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7B18FA09
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603071; cv=none; b=R3uApPlnG5G7avK9c8WrYemN8vFPxIKb8MV+oluuWKjvRXjWkpJDxyNhJ0C+ynO7y0c+2Bn4J0eapI/BkrArBkD0Zvk+nrVsd1qEwF8iPCFf+jie3D9gswIYUEfm8mP8WfN7tHSwLALZHUZ4lu0YXLeDfMk3tjetzHfJ3APL6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603071; c=relaxed/simple;
	bh=ZQWrn2jZXBMcxjLvNUDXmqUFj1MpWI4gDWeA40iyAMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei7uE5LNh3e3BnzMZaiNBXuQUtJUwdPkMWRHwzTYRjzmdZ5Efwm6Qe7SCSnGFBrtFTuKMjukNDT4igXDnYH+917TYvRdaCdHKKwH5/cgllA52Q2zyNs/z8UxXMF15u3CN1X90BoNVvsgauwD4fl8oJbYRw32FAMrFTRYEW60hFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HITQGpHT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720603068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQWrn2jZXBMcxjLvNUDXmqUFj1MpWI4gDWeA40iyAMA=;
	b=HITQGpHT0ELHTnAxmpV5jx+2FKsvsHUYJ3roBsBQo8+bG94m0eBlsPr17g7SvC79goI57Z
	7Mhj1p+rIdXVjJ5F1ZDJr7HDRSd5LFOb8gAUVkRISyfZVpItI9yA68w1XoLUyUhuA3zmrx
	D2UvRX/U/zKfgytLzoYBtpPslRKHWIQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-_NWJpFpPPOmTc45J0q9gsA-1; Wed, 10 Jul 2024 05:17:46 -0400
X-MC-Unique: _NWJpFpPPOmTc45J0q9gsA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77c5255b1eso438063066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720603065; x=1721207865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQWrn2jZXBMcxjLvNUDXmqUFj1MpWI4gDWeA40iyAMA=;
        b=aRyDx66UIbjGA+bna36I5yCVj8HHf54ifICkJJ+AwojvAVnXQnTSNRsU/qdPgvfpQC
         nThduXSGsAi2mepEhnoqYvsfQQMP73EgMUws8TSJVr3OvUACQzU38XxA5ApnLNZztoto
         78mY4FjUdiDPHKkYhIkcO2Ebl/RYwQTLLS3cEL7ayhUMiWd4AKm2sUHxK8TzL98mdHKc
         BYfcjFNwjbRgn6oaCvcVC1cd/p4Xw88dTJC0A0/QvjJfk8q3tgT5xDOnkpdmnDl7QKxc
         +Myyh9tdEkYNF5B5x0X7B/F04bEJBenHZHbabSFOh6svimR63av5hV1qAJ2lmj1pRxt3
         tGDA==
X-Forwarded-Encrypted: i=1; AJvYcCW5F3tHDw7BGxbR9b7TDB+kVEcG6ZPgJ6spU95z46LZbGyMTIUU+90JoHWGh1qGwV4ZmKliHV5ZZcjEIpxJEtvIlfFQWHljLZZAVH+G
X-Gm-Message-State: AOJu0Yzo3nLE7FJ57WQCmUCPJ3/VSIjJyRPgnTuhvm6IBztncteJmSiD
	o4T6P98C2gktjArc+dXTSUR44WKu7K0VzBDuCgjJ1b7t7MujBDbt7ZbH1YwrnROoDk5LyU88929
	g6ktWvpCSKVgE6z23d1lPlTQNsCkdtbcVSi0UhD+FHvHMDWjukpHRVZWdiSWakw==
X-Received: by 2002:a17:906:12c1:b0:a77:c4a7:c421 with SMTP id a640c23a62f3a-a780b6b2fc3mr294992466b.30.1720603065663;
        Wed, 10 Jul 2024 02:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3hqKP51AfcMgz6TrPTDHAfFrt/pwlacg0Av+pQs0AhHIjeRKThdlDa+17MBTukyAKy+D0hQ==
X-Received: by 2002:a17:906:12c1:b0:a77:c4a7:c421 with SMTP id a640c23a62f3a-a780b6b2fc3mr294990966b.30.1720603065213;
        Wed, 10 Jul 2024 02:17:45 -0700 (PDT)
Received: from [10.39.195.49] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a855e73sm145332666b.174.2024.07.10.02.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2024 02:17:44 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Aaron Conole <aconole@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
Date: Wed, 10 Jul 2024 11:17:44 +0200
X-Mailer: MailMate (1.14r6052)
Message-ID: <F2D00F9E-8714-4D49-8D74-8310708AA11C@redhat.com>
In-Reply-To: <20240710090742.1657606-1-amorenoz@redhat.com>
References: <20240710090742.1657606-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 10 Jul 2024, at 11:07, Adrian Moreno wrote:

> A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wron=
g
> sk_buff.
>
> Fix the error and make the input sk_buff pointer "const" so that it
> doesn't happen again.
>
> Also modify OVS psample test to verify the flag is properly emitted.
>
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Thank you for fixing this so quickly. The change looks good, and I've ver=
ified it with the OVS userspace part.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

Cheers,

Eelco



