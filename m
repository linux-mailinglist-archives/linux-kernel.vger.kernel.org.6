Return-Path: <linux-kernel+bounces-247028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11092CA19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B182856EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D424F602;
	Wed, 10 Jul 2024 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="o95kuCvX"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F724A08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588559; cv=none; b=atSip7qPFCpVGYJazpBbDl6tFbCR5oC224stRU1Lq/nYH01Yp5xhE1XPhNAjJ7YLo9+suBAWb21oE3esuWxAfz80kMe5CItZW24Pn829SthtgqfsAT4CrVcr0aZs2/4Dx12kr51m3CRXT5etnh3G8UbqBFXZKAp77U1AKNFnQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588559; c=relaxed/simple;
	bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVwVY6RruOi2seEVDTdd5rdploiTNIHQpsupRDq8ekpYpp1oLenGxO5AeKswLt8sbuhi5+RzSOYNA4oUxmgWrbq6swu93pD+WHRepwRCZ0B8r+NNmc7wHz1+7M3lhZ1eAHx2aHUCFDxcjG1M1l/7KzyUKZZl3uImKv1oHZ6SZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=o95kuCvX; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 25FB23F733
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720588547;
	bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=o95kuCvXyyGPMukVMtI0GSEgGpHACThrC5C/giUTpTKMVx9YgDqUsjqWwbKlflx74
	 KHgoQ+IhkfdVbu7dVkIvBkyWGjz4qtqXNoAE0WzDB0GOQTqHdjEttrjGNOxWxC02ah
	 KKs3qnXLMzglKCCGUL5xzZE4ThZ+Ljoh6DM+D56U7wbsPEQQRo/L51C3xhmln1qJe+
	 oh/WnlORC96x9UsqLwCnw3gLNl0S+6g9xigstSLXf2BWANu8b+o30D7zacGPCV+0mJ
	 oRXzyGqE7EEAkY5cBSgr4XVs3wjybyHZaeqLCPvc0ubao2IPaUVJhLv3F1IrXEoYI7
	 fMdKvZWHEk+aw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77e499d040so253622266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 22:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720588546; x=1721193346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF4Nl2dxPIhe4X4B9P9hGydA3Smed8+uIFh3AvT2JOQ=;
        b=WXkKtM6RCyoAObOnBByNM6d/xWP8lqjL1VPff/72c/jzzG4i78HMDsuVYz2VJ6MzFm
         4wcZ5Hg7B3HvMUW+2hmFf1d0/AzpycIRVrzscEB2dhiPxo/cNq/D4ED2ezLvkiLRuZ1P
         gzJt7iVsG3v8DQRPn1vfCKafV3SWXBI1N1aswpnrSvEu3LlJHNZck5Q1Ys/VVIEPRHcu
         wS9cKhf7HW+TySEdK5SBZmKL1+B7MSExrgcgfbGVnRgzM34toH/yqe/+qdLwgtoyo6td
         8y8aCKpgNm7WF84jI7ETc9xA2pRGwynRJqOt81LWrvkOSJUrLgrJYXK2OleHv97dhweE
         vbNw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKEpKi3y90suFcRV4uC1Hf0drcBf+i7ImxDcmr8TIgLR0Wdg4Simms2ZotwuX4j58Gk4602f8QHPhHQW+Bpn/RfFEFsf1yEYued1i
X-Gm-Message-State: AOJu0YxGPBpBQ90gQFlUwQ5X07Wxh04yhFBoUZwhc8nUZs+sT3HLKkK8
	TWkgKDOAEyy/p9G9/ZqDRWtZP2yScvMZnwk8JMEa/BthKfT/f/Bp5/NzvrL7iLCdSWe0iyFgy9E
	a2reI9lkcpmxkMe332SqGz3oEZSQlxhiUi/9NDI7w7lwbn9HV11D5PNibakqrlOaxSZTlKmEDg8
	72IFfGcILhPNfkrLJc2xKWSrosDt0GOjw3zDiqUcrMHNHZyb8DgMxR
X-Received: by 2002:a17:906:714e:b0:a77:cd6c:74e1 with SMTP id a640c23a62f3a-a780b89cc91mr305240866b.69.1720588546417;
        Tue, 09 Jul 2024 22:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP7SESNVVCpvQMasACgsvcr86RJx9MBlUgc7j+w196eILbvXyXE0m0sVsYPOnB5vYVbhVbHZN96/g8O3ly+mU=
X-Received: by 2002:a17:906:714e:b0:a77:cd6c:74e1 with SMTP id
 a640c23a62f3a-a780b89cc91mr305238266b.69.1720588546094; Tue, 09 Jul 2024
 22:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
 <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
 <ZoukPaoTJKefF1g+@localhost.localdomain> <CAPza5qc0J7QaEjxJBW=AyHOpiSUN9nkhOor_K2dMcpC_kg0cPg@mail.gmail.com>
 <16e61611ecc9209bdf7de68f77804793386850dd.camel@redhat.com>
In-Reply-To: <16e61611ecc9209bdf7de68f77804793386850dd.camel@redhat.com>
From: Chengen Du <chengen.du@canonical.com>
Date: Wed, 10 Jul 2024 13:15:34 +0800
Message-ID: <CAPza5qdn=5zOAjHdyK-iHrmP=sEL150Mrgz=w_wgEcL5MBWZRw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>, Florian Westphal <fw@strlen.de>, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Mon, 2024-07-08 at 17:39 +0800, Chengen Du wrote:
> > On Mon, Jul 8, 2024 at 4:33=E2=80=AFPM Michal Kubiak <michal.kubiak@int=
el.com> wrote:
> > > For example, if "nf_conntrack_confirm()" returns NF_ACCEPT, (even aft=
er
> > > the clash resolving), I would not expect calling "goto drop".
> > > That is why I suggested a less invasive solution which is just blocki=
ng
> > > calling "tcf_ct_flow_table_process_conn()" where there is a risk of U=
AF.
> > > So, I asked if such solution would work in case of this function.
> >
> > Thank you for expressing your concerns in detail.
> >
> > In my humble opinion, skipping the addition of an entry in the flow
> > table is controlled by other logic and may not be suitable to mix with
> > error handling. If nf_conntrack_confirm returns NF_ACCEPT, I believe
> > there is no reason for nf_ct_get to fail. The nf_ct_get function
> > simply converts skb->_nfct into a struct nf_conn type. The only
> > instance it might fail is when CONFIG_NF_CONNTRACK is disabled. The
> > CONFIG_NET_ACT_CT depends on this configuration and determines whether
> > act_ct.c needs to be compiled. Actually, the "goto drop" logic is
> > included for completeness and might only be relevant if the memory is
> > corrupted. Perhaps we could wrap the judgment with "unlikely" to
> > emphasize this point?
>
> I agree with Michal, I think it should be better to just skip
> tcf_ct_flow_table_process_conn() in case of clash to avoid potential
> behavior changes.

Based on your suggestions, I took a deeper look at the code and found
that the drop logic simply adds a count to qstats->drops. It did not
work as I expected in terms of dropping the packet. I apologize for
any confusion this may have caused in our discussion. I will send a v3
to modify the error handling. Thank you for your advice.

>
> Thanks,
>
> Paolo
>

