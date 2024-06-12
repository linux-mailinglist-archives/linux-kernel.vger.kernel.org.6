Return-Path: <linux-kernel+bounces-211733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0790562C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C11F25198
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8C17FAC6;
	Wed, 12 Jun 2024 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fas3SAW2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FE1DDF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204479; cv=none; b=DYv+ikqSaJ/t9as/Eyv6LW6RlB9LpRZ4Slc1ESE7/WqUcP20x/YOKoOm6MbkK20/Rkqcdrp2msO0JnShiEtA+vh/6+Wv9RXTCcjPS4X2l4cixY5zkbqFhcL47Hn955s36pOdNLEJo48xB/r4N6rD+61JWJBLiCX8ynsgmCUC7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204479; c=relaxed/simple;
	bh=99ZGerARksGUGdw+E23Lcu8HvgTTG9/x1SmFsKpGl20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBQ4lcpfLxmUdb1xcntuc71CIREv1H8mewwe57hwClT1nTj6P8Um2JEHl9w5Rk8BjuvUdL521fkOJd6V/YkmoAQhZtuNfB08TTeImSiA00sTiXR/YqGyfqYbU3M1coHCzeMJ3CQbtPLmoxbwtGp0ouHy+aBLkOjPZmPeQJ+DsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fas3SAW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AK7Qzf/MhUoQm7mnY6EWFd26DeQUWTNXILgKlaTUO3c=;
	b=Fas3SAW2CjbWoV8KGQZvhGQVm07fkAW+Jrd070R1rod7+7lrOHyJp04Id/nC5w11bBthbo
	ms7Cj/w6JY5wd6oUdR4vhYiA2mXAjMCm2rAMaJvsE+0cbBKup/qMPbqvyBuw5RPV5TRtD2
	ZhLgfMF5UN/wVQYjX31Tm8C7hP3SYT8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-SoQ-7KDuMS-iP7koNzYsXw-1; Wed, 12 Jun 2024 11:01:13 -0400
X-MC-Unique: SoQ-7KDuMS-iP7koNzYsXw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebf7a0ed89so12806301fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204472; x=1718809272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK7Qzf/MhUoQm7mnY6EWFd26DeQUWTNXILgKlaTUO3c=;
        b=TKUXL8Q37YTH49UuOIQwmLn6IrI51k0CNRlVuzNa1FezZZOP//BLnvE4vz42KJ+Pf/
         1Z38S63BCdfyUlfPL6Y8E04RNg2yWoMjJWfjWxQBrH9gvgh/TzkLxzAiQcvc5P7Sj9ga
         C88F5V9HS54yAbBzxwyb0PaO9GhjGxRJdXwUzE8Lcss5fgRjItuh9R6S3PDYuUhwLyke
         fkPujXFuwTdsqx+Pu+73DgUhGgr3dSEkX3F4E21vZ7f892kuUdnUsHPqGFHqIbXDTBYD
         jzEoAXgCdDFgM6ufcDOYCfp+eH81d0Q72iYTYFp2mwsyzSMR8Z6IXGnijF9EPDGZlshl
         hWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Zqs5vMIrI+ezBC83XErh6cak1LmqmgaGsKxlNC3DnRr6l6ZUBfdiaymq3PwkLub/S9r4Q7VEUgU3x6dMFC50A+mLi7gA/Mb63nOW
X-Gm-Message-State: AOJu0YzUNPisOaV+VGh4IZ8TNyRMQP6RT7J8FUUaFxHbx9Nq9OAKpLuA
	IT8jCeCKoOuratOI20POBW/6PHWTXgfmUHFGa2XFIOiVzbsiE1tHX+tSCDOBaqdx57pOBvvNvir
	vqgPunQbl/ozvDiAMUUocKC3JVdpABNBVdTTb+0sEyV83bwV8809fYvzbA0RLLg==
X-Received: by 2002:a2e:99c7:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ebfc94de35mr14250771fa.36.1718204472175;
        Wed, 12 Jun 2024 08:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTuPBgbKAFLkoD5DUY4zQdrl9+ofAljCO8M4EqUgORhCBOFn2MvAE0KtkNSgtX7OadYbchrQ==
X-Received: by 2002:a2e:99c7:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ebfc94de35mr14250531fa.36.1718204471700;
        Wed, 12 Jun 2024 08:01:11 -0700 (PDT)
Received: from localhost (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f26578176sm7756461f8f.11.2024.06.12.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:01:10 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:01:04 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/9] net/sched: flower: define new tunnel
 flags
Message-ID: <Zmm4MMX_WFFEfLFd@dcaratti.users.ipa.redhat.com>
References: <20240611235355.177667-1-ast@fiberby.net>
 <20240611235355.177667-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611235355.177667-2-ast@fiberby.net>

On Tue, Jun 11, 2024 at 11:53:34PM +0000, Asbjørn Sloth Tønnesen wrote:
> Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
> flow_dissector_key_control, covering the same flags
> as currently exposed through TCA_FLOWER_KEY_ENC_FLAGS,
> but assign them new bit positions in so that they don't
> conflict with existing TCA_FLOWER_KEY_FLAGS_* flags.
> 
> Synchronize FLOW_DIS_* flags, but put the new flags
> under FLOW_DIS_F_*. The idea is that we can later, move
> the existing flags under FLOW_DIS_F_* as well.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_dissector.h | 17 +++++++++++++----
>  include/uapi/linux/pkt_cls.h |  5 +++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 99626475c3f4a..1f0fddb29a0d8 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -16,7 +16,8 @@ struct sk_buff;
>   * struct flow_dissector_key_control:
>   * @thoff:     Transport header offset
>   * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
> - * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
> + * @flags:     Key flags.
> + *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION|F_*)

^^ nit: there was a typo in the original line above. Maybe this is a
good chance to put the missing '|' before 'ENCAPSULATION'



