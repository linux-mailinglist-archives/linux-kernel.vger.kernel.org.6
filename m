Return-Path: <linux-kernel+bounces-242521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B676928971
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EE92829EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1114D293;
	Fri,  5 Jul 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2wuba7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874814A0B7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185522; cv=none; b=dNewwrB6Qhjr1nMynmsn4DNrZexYZ+Kgb1hgo0D1DEpE6IBymzFC4H9+W//VaBBIGezbMHp56sud1ImmZRZM6ymAmpzKSD8Phvmv0mVkk03YeV2jQiA/UcJNXMDdgUwDRUgKEOF+i56dL6lORCgqiU+zk4kaqANRWaZa/80IN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185522; c=relaxed/simple;
	bh=XabRrceFxcF0KBIJc9MbE+XTnegGGAzIgYPWZjAd71I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZO64Lnw/UyvNhJ+SrbgkXtSpIGW+VpNqzgt3ggz6YSVMY+XQsijP1CscJVQNrcathedQqQXLF5FhhW9rg6W3pbbptjB96RcHyCp8PNDBZxUwU+xBNCif9+2zFfRNEcYUnfcMwu6PV7UXdWJQWi2dB6Qj8+Wwhq6rHMiZpGAj2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2wuba7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720185520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62aYuvlj0aJrfftHw3OdTbReRjrfxK3xjdMTv0VrPgI=;
	b=J2wuba7YG32/uVrD3oF1HD50sfJtCWej2HxgTUzrWmbPVPIlO2XoU/OjawUQHqIyfSozjn
	lJ4K6bP8sa4L9OlOOx+2ifVAF8n+GvWHnci6e5RpLaLSTBtVPONRaxcBHt3M1PnqPD8yqM
	XgBQM8mtUZa0at/di5HDkju0VlFgg6g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-CgdmQTTCMpme_GKrQqBZ9A-1; Fri, 05 Jul 2024 09:18:37 -0400
X-MC-Unique: CgdmQTTCMpme_GKrQqBZ9A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77b2edfe06so130988866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 06:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185516; x=1720790316;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62aYuvlj0aJrfftHw3OdTbReRjrfxK3xjdMTv0VrPgI=;
        b=BW1ZBeI+YKZ394Na0535f6fNf1YRThQzCvkiwnLpdb+eclE1ibP7gvJ0IuQddUVJSe
         48gtiorF8dA5PF/dfhwT7ymC7+TX7frfJZd0Sit9t7iKNhD2ikAzka6mjUTSf7mPovkI
         ovVSKxvdTpBbUdjMkJB6RVhjPMCAbq82ZByAbTlhHgsintzx8Z6BUsCEGBlzcTNYNDQZ
         F+CDdsSzWtBeBVPhoNNZPPfORCbAgv5UibzDRSl60QlKyMpnCc4fvLqSCl0mOQHSCNsV
         Acscec4z6RI7cmHUpB/IkKsyLSLjwsAQ33FsTdnNICpnsesUDRMg2ynX530tYO0M2ZMo
         MYyg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbEX0LISjHmJJKsF+EcdoojIvDO+rmouX7g+dsZtTmbv1RneOKFxxBVaXSZthGT9s+ucquAnenCo1XUqCliq238qrMhGjNcc33Uto
X-Gm-Message-State: AOJu0Yysot/gEjP26EdbAvuVWP5fsHDorAPL9DCJ3+USY37Pd9lQIJAy
	QxyNyoNaOjQs/SxYAF3TXQeQGazW8tZfBmde6xbAWoeuQ2xVX8DSXVYAZyuk9Qk8mXnm7QDs6JB
	WdYEGfKUBvX/Yze9Bc/0GkhqK4Wwb7EY9s/FSMdc3/uUWbsHcBSvJ7pg2cMKzRw==
X-Received: by 2002:a17:906:c9c6:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a77ba70e46bmr325709666b.37.1720185516239;
        Fri, 05 Jul 2024 06:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb9mUZwv0LhDRrdW6Gq2ToasHLSkXTvO7pDP+kDNwoiP/yJeMD+4Nmr3QADNVIspVclQSnJQ==
X-Received: by 2002:a17:906:c9c6:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a77ba70e46bmr325706366b.37.1720185515818;
        Fri, 05 Jul 2024 06:18:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c2aee010sm103537566b.102.2024.07.05.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:18:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A1F313FDC48; Fri, 05 Jul 2024 15:18:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Florian Kauer <florian.kauer@linutronix.de>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 xdp-newbies@vger.kernel.org
Subject: Re: [PATCH] bpf: provide map key to BPF program after redirect
In-Reply-To: <987c3ca8-156b-47ed-b0b6-ed6d7d54d168@linutronix.de>
References: <20240705103853.21235-1-florian.kauer@linutronix.de>
 <87zfqw85mp.fsf@toke.dk>
 <987c3ca8-156b-47ed-b0b6-ed6d7d54d168@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 05 Jul 2024 15:18:35 +0200
Message-ID: <87wmm07z9w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Florian Kauer <florian.kauer@linutronix.de> writes:

> On 7/5/24 13:01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Florian Kauer <florian.kauer@linutronix.de> writes:
>>=20
>>> Both DEVMAP as well as CPUMAP provide the possibility
>>> to attach BPF programs to their entries that will be
>>> executed after a redirect was performed.
>>>
>>> With BPF_F_BROADCAST it is in also possible to execute
>>> BPF programs for multiple clones of the same XDP frame
>>> which is, for example, useful for establishing redundant
>>> traffic paths by setting, for example, different VLAN tags
>>> for the replicated XDP frames.
>>>
>>> Currently, this program itself has no information about
>>> the map entry that led to its execution. While egress_ifindex
>>> can be used to get this information indirectly and can
>>> be used for path dependent processing of the replicated frames,
>>> it does not work if multiple entries share the same egress_ifindex.
>>>
>>> Therefore, extend the xdp_md struct with a map_key
>>> that contains the key of the associated map entry
>>> after performing a redirect.
>>>
>>> See
>>> https://lore.kernel.org/xdp-newbies/5eb6070c-a12e-4d4c-a9f0-a6a6fafa41d=
1@linutronix.de/T/#u
>>> for the discussion that led to this patch.
>>>
>>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>>> ---
>>>  include/net/xdp.h        |  3 +++
>>>  include/uapi/linux/bpf.h |  2 ++
>>>  kernel/bpf/devmap.c      |  6 +++++-
>>>  net/core/filter.c        | 18 ++++++++++++++++++
>>>  4 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index e6770dd40c91..e70f4dfea1a2 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -86,6 +86,7 @@ struct xdp_buff {
>>>  	struct xdp_txq_info *txq;
>>>  	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom=
*/
>>>  	u32 flags; /* supported values defined in xdp_buff_flags */
>>> +	u64 map_key; /* set during redirect via a map */
>>>  };
>>>=20=20
>>>  static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
>>> @@ -175,6 +176,7 @@ struct xdp_frame {
>>>  	struct net_device *dev_rx; /* used by cpumap */
>>>  	u32 frame_sz;
>>>  	u32 flags; /* supported values defined in xdp_buff_flags */
>>> +	u64 map_key; /* set during redirect via a map */
>>>  };
>>=20
>> struct xdp_frame is size constrained, so we shouldn't be using precious
>> space on this. Besides, it's not information that should be carried
>> along with the packet after transmission. So let's put it into struct
>> xdp_txq_info and read it from there the same way we do for egress_ifinde=
x :)
>
> Very reasonable, but do you really mean struct xdp_frame or xdp_buff?
> Only the latter has the xdp_txq_info?

Well, we should have the field in neither, but xdp_frame is the one that
is size constrained. Whenever a cpumap/devmap program is run (in
xdp_bq_bpf_prog_run() and dev_map_bpf_prog_run_skb()), a struct
xdp_txq_info is prepared on the stack, so you'll just need to add
setting of the new value to that...

-Toke


