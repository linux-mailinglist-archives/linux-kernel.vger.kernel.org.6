Return-Path: <linux-kernel+bounces-218785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F190C604
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9A1C21BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50C8060E;
	Tue, 18 Jun 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXYTaLZ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E917C8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696333; cv=none; b=V0HQ37WzG8kjqRKnaWU+RWb5WSn1j/8WH4ht/23SnemqUVI+Hj9GQBsZBRyhojFAOudboZLu6nU64iLXIoJb8l4r11EzxjLVn6KOvc1rAn1OTgLVJb420vOQfiJeaPUxI6JaM6GDFXw4YvW1BZh7lSQXzcRhaJbVed+P2RBzvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696333; c=relaxed/simple;
	bh=M0YJClBO4I10mGGrQvNSUAkg6JBeDSss0hFeaki0ouE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqaRBhO2gYlsLg/QUj3RYl3v5qR0eZ8RlInV014grUPgoM6KD6ug1FNAAlXBeYIuiqPNySK/otdoN1gt50uXdUO1GsXGf1MBOuTtvR/j87ncadFb+FYjrKWKPHKYi7rrDIzdkKJsPLpBr2gDwDl+L07cA5SZFZdpuBskd56vIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXYTaLZ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718696330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vS0L8gNZ+c55CBoTy4Q79OS0/z+oWmaelgdSL3NjO84=;
	b=CXYTaLZ3TUt/823qTQF12/WGyKn9cKNamu0ZueihmZXkWu6gnUr/lf1XQ3W8m5ixOan5al
	m8nIwCk6RVCrt3DM7FmLgUaTgN1LtC2q/1o3mIVaasUA3ZomL0h6vTZvs33lIZ1hk1pioT
	HOnPe7U6nPJgwqQTc68P6d8Ylk07CpU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-zhuFmbX5OPmBtAhggwycRg-1; Tue, 18 Jun 2024 03:38:49 -0400
X-MC-Unique: zhuFmbX5OPmBtAhggwycRg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b2cf9bbe69so32275516d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696328; x=1719301128;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS0L8gNZ+c55CBoTy4Q79OS0/z+oWmaelgdSL3NjO84=;
        b=TIy1FPTx9iEkehoVfp2iKXhHstqY17NaTyU9q/crxBgj9TrAtVUrUalVMT/ndGHG2U
         CNHJR7EHji8Hw2X7qSRrOZgQr8/zXLA8El8t4oBfg7fAbsFi+tTv2qGvL8gRfowXqxe2
         lZTgPVmuzkcJoB6QLd9N7SORSKHlurvDrWrvjFo+27GDeUP3psb5CgH8oSGu00IWfUAc
         YCGaUD4fw5YoTL1EIkTOYmH34aMrNAZFYTZTkXAEnv1SbKqfIFujNeVh6QMnKoYh6Vl3
         RT1oFB/13WjAQfTahE051rf7Wyv5u6MimeKi7lRWDJ8NuqWpETspHQhKXAngU0RDNWBK
         x40w==
X-Forwarded-Encrypted: i=1; AJvYcCUnoavVqAJQFCSEbjHVuLR0pFbpMpQ1lyeeO98xnOLnOfiFn9BhVKf0yGIHLnmdQMQycq6I7f/CCs/DlUJMN3gh/snP9XUK4JWovxKP
X-Gm-Message-State: AOJu0Ywq/hZ6ROX/Rlb0rcIU8DR7r8k+ZSz0mFJU0HgusjHwKeNZso7i
	W/NUGgS4okL3SYHgN2YOXjTw19+TLxb1UfJ4a2Oei39ou8neR9PYZi7wsuMeCJSwo1SwPJzOvvK
	Ja7sUtc6hTPAP474gGX5cbU1xrTnlv0ClAXeZ42I9LWadOw/fGtBk2xe9QDH10depCSksuI5hcd
	8fGWAoDV/loQg4IRhDamsQUYB0i0Mmp7bVSXji
X-Received: by 2002:ad4:420e:0:b0:6b0:8c25:abfa with SMTP id 6a1803df08f44-6b2afd8571emr104202996d6.57.1718696328425;
        Tue, 18 Jun 2024 00:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3F5G/KHtjnRX2STbBX8sqxnLPA6kAkwk3Iqz/SG8R6aigMHaYs3OJzjUa58lLUtE2JyX2Ynuwxi792BgQ1zg=
X-Received: by 2002:ad4:420e:0:b0:6b0:8c25:abfa with SMTP id
 6a1803df08f44-6b2afd8571emr104202876d6.57.1718696328128; Tue, 18 Jun 2024
 00:38:48 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 07:38:47 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-3-amorenoz@redhat.com>
 <282d4b46-70c1-454b-810a-ef3353f1b0f2@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <282d4b46-70c1-454b-810a-ef3353f1b0f2@ovn.org>
Date: Tue, 18 Jun 2024 07:38:47 +0000
Message-ID: <CAG=2xmMqfBLeFjqzzHG3uHLx9d8sDsdbguxZm8cxbR5nEVDZ7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/9] net: sched: act_sample: add action cookie
 to sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2024 at 12:00:04PM GMT, Ilya Maximets wrote:
> On 6/3/24 20:56, Adrian Moreno wrote:
> > If the action has a user_cookie, pass it along to the sample so it can
> > be easily identified.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/sched/act_sample.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> > index a69b53d54039..5c3f86ec964a 100644
> > --- a/net/sched/act_sample.c
> > +++ b/net/sched/act_sample.c
> > @@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
> >  				     const struct tc_action *a,
> >  				     struct tcf_result *res)
> >  {
> > +	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
>
> Is it necessary to initialize these 16 bytes on every call?
> Might be expensive.  We're passing the data length around,
> so the uninitialized parts should not be accessed.
>

They "should" not, indeed. I was just trying to be extra careful.
Are you worried TC_COOKIE_MAX_SIZE could grow or the cycles needed to
clear the current 16 bytes?

> Best regards, Ilya Maximets.
>
> >  	struct tcf_sample *s = to_sample(a);
> >  	struct psample_group *psample_group;
> >  	struct psample_metadata md = {};
> > +	struct tc_cookie *user_cookie;
> >  	int retval;
> >
> >  	tcf_lastuse_update(&s->tcf_tm);
> > @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
> >  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
> >  			skb_push(skb, skb->mac_len);
> >
> > +		rcu_read_lock();
> > +		user_cookie = rcu_dereference(a->user_cookie);
> > +		if (user_cookie) {
> > +			memcpy(cookie_data, user_cookie->data,
> > +			       user_cookie->len);
> > +			md.user_cookie = cookie_data;
> > +			md.user_cookie_len = user_cookie->len;
> > +		}
> > +		rcu_read_unlock();
> > +
> >  		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
> >  		psample_sample_packet(psample_group, skb, s->rate, &md);
> >
>


