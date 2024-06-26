Return-Path: <linux-kernel+bounces-230462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C3917D20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64C01F2486C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF29176FC0;
	Wed, 26 Jun 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0pxryrR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28115F308
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396124; cv=none; b=rJEq7c+uimYydcDj1nW3fdU3rbO7Dl6An5gqVbWdK65Q5bKzvAhFzegt7HvJtqtv3PzkuW47WcngpxYCGuTTzU1JG0KYCsEPUsCcEUKIrbfB3ruw41hBQVHPPxnHFkT0z2khEjYg6RkYGja7TYbzRrqNpuZ8IckUsYsrqBUI7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396124; c=relaxed/simple;
	bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkkTgNa2uX1pceVCBU/g5wsTyawnq/5nvpWnVwtXBHu2YH/PKxJ4gmBokECmd8Xr/oQu4eKlV1a+2b8CcAVRF9bib7n/vOORHhK9LzmXAMUq/fdotDVk0TpI/CVMWWUjFr6toXrC6fA0Vv8KmduDQVEr7W98FVzigNM7Df/grQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0pxryrR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719396121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
	b=Z0pxryrROVf8za+/kUcaTdkikhjdczuAsfRht1NHwYnIXKr7dlQdomMXsPuORZMbSxlRZg
	fsFl7sBkNXGEGwFX5GjZAx7RZCh2CDwB2w+l+BTmo89EeFEjfex3f7mByIleTzpztcYB8v
	c2iZb4S5so1wN57r1KD6sD5UfNKPCZs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-tdO6bZYGP5O5_TVtW7GR0w-1; Wed, 26 Jun 2024 06:01:58 -0400
X-MC-Unique: tdO6bZYGP5O5_TVtW7GR0w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so8251282a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396117; x=1720000917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdrItU7Ucw4I2XnC8bz1GVIEN51yJvk0w7JU+tNIQTY=;
        b=a7RPKYiB4ahXeoNTBB7PXb7zs2HfRzU2C9EVOUVY6muTznDxGwo8WcNuXTlIhhEfAZ
         R3b/i4azFUkRhs98wmf9kcIRhpYF0YrHWubOnCNeFIOksugDrKL/XWx9Hkh3fPQKJdiZ
         28mDwx+UlRFCmlNEhyAh9mk7j6vhqww4lK5M51nU/AAsdYc4NyNJFa0xl4mqXvUsmn7O
         HkMCtzoiJ4gjoZ6faXz0ku1EJMpvBC9wPbhC8BsMhtF2gqBFZ52M+GrHtDk3YbgWVRxQ
         2LTQ66f1gMwgpnRSqZS3GJ/EhakxKYHrpRQgEsENKFep6yrA/veQ5SSyJf5gtnUaBbpu
         18hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXriN6lR4XW2976fmrOAJ4MU0sHfp5FUuYCTWYKRiDp+WXtNHH5GmziWi+NRF/HmMxzV0fp9bvfckwiIzJycBOA+RYKsDPa/+3mIwoI
X-Gm-Message-State: AOJu0YxmXsJYPfkyqRNDqZ4HkOVPTPfydPqkBofbLh1P39nPFu7KGcLz
	mtkx1yPUuFuXoSXrEUOlyGp8ish6m/Tb3CtoAIQuC9O8uYjBdx+cW07ElO61wbFhKaGPJ6jQIpg
	wzosEZcgR11mDkrPv+4Hw70vDWtcG2kSfgyjuUXaigjK3mspmBNouvNkDxmCWdG85s43MSDzFob
	X6ddDy69WLn8FTV4NjgkVZ1fNfSXZZ8bVubySs
X-Received: by 2002:a17:90a:17a5:b0:2c2:41cf:b0f0 with SMTP id 98e67ed59e1d1-2c858297582mr9204892a91.43.1719396117071;
        Wed, 26 Jun 2024 03:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP5pWyEB+/l3J6qcO21zK7BoGGmi0UDpkfJ7f4rzYXNXczhdeTMPXJZJp+/qspBHnJ6tS4vqXrd+ILXABKKY4=
X-Received: by 2002:a17:90a:17a5:b0:2c2:41cf:b0f0 with SMTP id
 98e67ed59e1d1-2c858297582mr9204863a91.43.1719396116441; Wed, 26 Jun 2024
 03:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611235355.177667-1-ast@fiberby.net> <20240611235355.177667-3-ast@fiberby.net>
 <ZnVR3LsBSvfRyTDD@dcaratti.users.ipa.redhat.com> <0fa312be-be5d-44a1-a113-f899844f13be@fiberby.net>
 <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
In-Reply-To: <ZnvkIHCsqnDLlVa9@dcaratti.users.ipa.redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 26 Jun 2024 12:01:45 +0200
Message-ID: <CAKa-r6uqO20RB-fEVRifAEE_hLA50Zch=wbKtX8vNt5m6kE5_Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/9] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:49=E2=80=AFAM Davide Caratti <dcaratti@redhat.co=
m> wrote:
>
> So, we must htonl() the policy mask in the second hunk in patch 7,somethi=
ng like:
>

or maybe better (but still untested), use NLA_BE32, like netfilter does in =
[1]

[1] https://elixir.bootlin.com/linux/latest/A/ident/NF_NAT_RANGE_MASK

--=20
davide


