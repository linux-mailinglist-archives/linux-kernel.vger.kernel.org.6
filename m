Return-Path: <linux-kernel+bounces-231974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C752491A100
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD21F228F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720073466;
	Thu, 27 Jun 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMAD5VKo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD973440
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475144; cv=none; b=KQMtvvN0WuUmeLb+5IYlECNzv5HqfrbpfqGfDx77XwP0xmuxueM/d0QGIIF9M8i7309pQ3N+xU9HqRFE9Not28r6vhfytE351ZcpCtin20YhHgOz2ynxsLd7uwS6s7Oa54QQvAR9mq3ykljQOEAfMji5j/chGGkO3GjtJyh++iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475144; c=relaxed/simple;
	bh=xcU1eFpqgSU/Bh/CKmAiD64jwZruaevOEqyVUKJm0pM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+MGHGdUA8y0X0vuU9d7maOc7DVvrACMW2ECYMUlJKOe8o4s9MJWsUR+ZRq354M5NcIyUx9p6cCmnebC8qG8+flvDaafqVc8CggZp3RBOMh/KAGoDTVN1Lq8DNgY3Ljpo+Fhc6jNmpzgwd3Ynh1p/Du3jc4M/cvIjvQdRe5NJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMAD5VKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719475142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
	b=LMAD5VKoUjavtby8V8bi29WRLeb3awsds7IJuhdleTap4Ns2bACafjYymNP+JsN3Qf2aJv
	9+ZQnik0LkVMRZOV7Q9lsIMK8O0B/SSL8FpvzdxvMJMsjQlJMWuabo39NH0m/Tp5aEHZkE
	gJe+ItmeXWxMOqSQVvVkKjFtaOJzQm0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-EmzT30-DMpG0Jn8re4W6WA-1; Thu, 27 Jun 2024 03:59:00 -0400
X-MC-Unique: EmzT30-DMpG0Jn8re4W6WA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7278c31e2acso343402a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719475139; x=1720079939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UeushS7zvrpsIs8SYBcVSJVunv4P3aSomIKJ3BjOrcI=;
        b=rWK4gK4m5r8SxDWbLn1r+Z7FDfnL/XVxgV40KxN/7p7Wgv1gqZ2OkqJM5shWWjjI+6
         uaxa+UArX4PJ8YoTlCxLQYxta33RmgTSAUzna2HisM3bYl+XYaH5efC2kyy7Uk54QGR9
         k5Rv8DnZtczvocwEYyMi+5JDvRkAY5dgC5G+vAa2zag0vJYkZllvIi2GvIa4BDGvhcMZ
         fkrSyPMYi40iLUpR/ctNcN/9BHDlN61llXsV78yX/uIsTb/ZpP74iqRQbl3yQ1m3vwkw
         0nglbA2T7bEfJwdqvf+ZCjz+h9ydw+f9hmLOfXN/hKUjswBYNFbZiymqPvR2lSWbNGyR
         Fa4A==
X-Forwarded-Encrypted: i=1; AJvYcCXmRwQsJFSlKTxBX/PioI4oCKWM+wi3/pDQZuR+UjfylHtez9TOhaToPwPRepi5sdO3m4R0VvUC7DuW/GM4O9Th/wtHYrgjT2CSbU+6
X-Gm-Message-State: AOJu0YyW+7RUUGx67ALXn8rpMsb1Ss5Ge2S+PKDNgRJba3J3K+BlIcy/
	j+8jflcTKEoPAbajCcP8ZrtxlmwyjQ5TspOnURi4QZKdWSXaBNLoEx/nNxZh8Xtc6Tgfk1WFx6s
	siQXD7Eeg7sFn4XKyvbe3iR0BAiewfhjJK8gVU1rr9Nz+LOlQojOy6h2H/PTwiXXRZr+iYfSHXq
	mMcDnIgQJD5optCv+81hQm0KyhFQD5XjcwDjky
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id adf61e73a8af0-1bd1b22dd3dmr6599034637.30.1719475139138;
        Thu, 27 Jun 2024 00:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEhtQavUVxjiWNx9N6Un/I/J3BmWyhnPpVIhRhfNfnMVfGkd4OTnKCID/jsmdNPWflpzAhMX/5qaCB6D6jUe0=
X-Received: by 2002:a05:6a20:6d18:b0:1bd:1b22:dcce with SMTP id
 adf61e73a8af0-1bd1b22dd3dmr6599019637.30.1719475138754; Thu, 27 Jun 2024
 00:58:58 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 00:58:57 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-11-amorenoz@redhat.com>
 <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3395bd94-6619-4389-9f07-1964af730372@ovn.org>
Date: Thu, 27 Jun 2024 00:58:57 -0700
Message-ID: <CAG=2xmNfdAm1s1bDc6TZJL5wB3p+bOe-r=OwSm-RJ5zJ_3NqkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 10/10] selftests: openvswitch: add emit_sample test
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 01:15:21PM GMT, Ilya Maximets wrote:
> On 6/25/24 22:51, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  | 114 +++++++++++++++++-
> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  73 ++++++++++-
> >  2 files changed, 181 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
> > index 15bca0708717..aeb9bee772be 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -20,7 +20,8 @@ tests=3D"
> >  	nat_related_v4				ip4-nat-related: ICMP related matches work with SNA=
T
> >  	netlink_checks				ovsnl: validate netlink attrs and settings
> >  	upcall_interfaces			ovs: test the upcall interfaces
> > -	drop_reason				drop: test drop reasons are emitted"
> > +	drop_reason				drop: test drop reasons are emitted
> > +	emit_sample 				emit_sample: Sampling packets with psample"
>
> There is an extra space character right after emit_sample word.
> This makes './openvswitch.sh emit_sample' to not run the test,
> because 'emit_sample' !=3D 'emit_sample '.
>

Wow, good catch! I'll get rid of that space.

Thanks.
Adri=C3=A1n


