Return-Path: <linux-kernel+bounces-239834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA249265E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087D5B27F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EA1822FF;
	Wed,  3 Jul 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGE/en6v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B422BD19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023600; cv=none; b=UzuaPLNXP/KOpkzVIiab53bSekrI89SKnSTQc36jKrCugutHsMZbOc9FRURR4BiZws5N2hkz2K1eqnCbDm60ZtkT1mX6kkcdQ8tAYshGLmJcyS0UsoZoEGBvvLKjvxMW+kBXoFUj7AQmYQ/9mpR0EKPKdBt81yRuQcIj85xorig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023600; c=relaxed/simple;
	bh=Yb55tWCidbB7U28h6KIibcX9GbhOAIHz0lHdj7dTw74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYkDwLDyGFEQl8WXMr1FW2tGikyMZ5DkqjjNfIHjyBkZCNY4bzQoichLeSNo4omVpnI8JGWQdiD/HqQ1V5lG8DOetDmsIYRQ+3yzgqxjyYemHTf5AzAw4S4j/pUa2jUlmOfp8wL16TRZmKnwmksdVzuFJyWezuVBF37lLR+c120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGE/en6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb55tWCidbB7U28h6KIibcX9GbhOAIHz0lHdj7dTw74=;
	b=PGE/en6vqcM0peyIVKhiWi9PyFsOzSl/snxX/wOOink/gcYfSjnwL9ALgFGsdLwqjy5jnP
	obOb/VALCMWJ/FEtJ1kPVlP2RVMDy0kVJab6aon7+k81j8NPlxkYtoBdflCat4QbN35IXJ
	LI3TYFCrN9pobeFXBrtWC0JC22ZgjQY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-jswbS6tpOtCMVF-XSwoSGg-1; Wed, 03 Jul 2024 12:19:56 -0400
X-MC-Unique: jswbS6tpOtCMVF-XSwoSGg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c98dc3f5b6so135564a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023596; x=1720628396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb55tWCidbB7U28h6KIibcX9GbhOAIHz0lHdj7dTw74=;
        b=w7kA3STldQ1C1/4WonfYfwpqBS1pq/WO/8VRehx+ZgZuanBnoV96v+IVhH8dZ3nM2k
         sXW+woiuVOUQIInfs1+bORzSU+oF8QAmQvEmQxx+zppMP18mgC+TaWUqL2uRNWwDm/5Z
         js2JYPUU+JsRfexMP4p5hjpPlV7hn8VNSA3FGJyKlMyIgBAk+3CHUISQft0bPC7oM5vd
         /mSvGQMllIbB5AMWw4Egs2tVm7JjoDmjtxC9S/d2rw/MEOYCuzH0WR0PC38ktPZkjPAP
         dnVdSHGzixrV1svEsbR2gZg/fGLTE1fhvTVeSqkmWkeujUpu/AhvUnBOp6v2C4tS5hyK
         i7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVFSqc3EmwmdKWD14O3sDkUTNLv61UsbYvYmzMzc3eYkrgc0Fn1zJVt/gJve0FHg5gL3uouKXZdE0gA46LAZ2ai9mubztxxGcwVzkpp
X-Gm-Message-State: AOJu0YwT61H560KT/LNkvGBqdq7xVoM/1/MMGfWvVn4qj7gmdtYC3S+f
	x/7Ybsi5c9EzVwsdr21L961fkBAYjm8gN8UY0LpkOcGGA3nfW7rhTHvSvRn7DM8wn5iWTLzYzVa
	Pdw7fh5WaP7Pm7VPv7S3huVJ/kj5uzDLyF3x0HAHstjctR87Kp1NoV84gnWq2dB27QJIflgQtw5
	67rdEkGGB0Zj4Dvy3kFZUdPRRU1DZEnVqL/uc+
X-Received: by 2002:a17:90b:30c:b0:2c9:66d3:4663 with SMTP id 98e67ed59e1d1-2c966d34812mr3295004a91.43.1720023595691;
        Wed, 03 Jul 2024 09:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBYnJibkfu8VR+gdQSw9I+Q70m33hrU3O4k6VmctxXx22qFoixYHHOvKc2dtgGcMdXrvw/AVbdfSSbiO6qe9M=
X-Received: by 2002:a17:90b:30c:b0:2c9:66d3:4663 with SMTP id
 98e67ed59e1d1-2c966d34812mr3294975a91.43.1720023595205; Wed, 03 Jul 2024
 09:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703104600.455125-1-ast@fiberby.net>
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 3 Jul 2024 18:19:44 +0200
Message-ID: <CAKa-r6tRzP0xK8hSY3xraTyUET1xgLRE4RXRj5hoWFQSxcfF7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Wed, Jul 3, 2024 at 12:47=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use the unused
> u32 flags field in FLOW_DISSECTOR_KEY_ENC_CONTROL, instead of adding
> a new flags field as FLOW_DISSECTOR_KEY_ENC_FLAGS.

Tested-by: Davide Caratti <dcaratti@redhat.com>


