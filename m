Return-Path: <linux-kernel+bounces-229511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECF917055
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F3DCB26750
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC99E17A906;
	Tue, 25 Jun 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx6cvJsf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74314132127
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340385; cv=none; b=VkEOBj4jp0uSeSjB7Ghhb7sJcvnkv+VvuFxjLCa/rGmVhEvgQg5/5Hl4jP7MqEymCXdP56BkVPKv8IGKRP2rZVTRqs0Y8+OTcgtHXSAT1b+CvzuyWUFKLS8mJCkA7LtqT03285g8KsOVEhEQ7M2NXnj5sXNE4Vi5etZqtlu9rVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340385; c=relaxed/simple;
	bh=4Ad8N9uab9l+LoLS0UE9cq2Gdmy+iPrKIoMAbpPxp2k=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeSLgfFvCcaqRtWf1rGwIfKp7k2GWrjUVHHy1rVuWi1DDeOgrztgyAMRYku315KRDzs403IWA9e/4hiPlPk3zCKf+e4l5eupcQVPuT1KLXJCE3o1K+uKp6CjebU2wogMHVvOaKYwU9J40nJWvPHaUZBbZP3gpJGSmZEHRDC6CQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx6cvJsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719340382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8wFcnOIW6tFeAYT/3mDDMjyRUaYB/izXbbbY0HfQIQ=;
	b=Lx6cvJsfGUf0Ju2ua2gFbBvKm7SCNjKnbXMG6GSAPU03iPIohfxSXIKt2fCvP+bFE4z8qA
	kPrv0FI77rOjWKjpz78jzGcjplBrCcZgm9aKQE0xw4q9E+PcpsHTSW4G2aB7dSb/BtSPSD
	U4708wRqkcjK/6UP67lerSssHPaoJ7E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-VgvlxBWhPz6_1s9dSwbJyA-1; Tue, 25 Jun 2024 14:33:00 -0400
X-MC-Unique: VgvlxBWhPz6_1s9dSwbJyA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b50f078c46so93349166d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340380; x=1719945180;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8wFcnOIW6tFeAYT/3mDDMjyRUaYB/izXbbbY0HfQIQ=;
        b=frlyULh492IttwMY4G+zCDqAmZCFZVpY39GjsqZiZvXRDnb/4hxMtvsAOOrAh5It6U
         aw0x2sZ6yKdixauWoKyUZ4kkYo039o+O21Vm5Cq+TnF0Uj2/D6W3IM0VcVT5r9hhbHD9
         DZwZAUq+5+v9KLf+6cXyN0BNHVvOo+n7mcHO+QXXdQ1eW3DJPJrc9IHHtH/Shi5AH3jq
         4KbFQQF1sCcGiK1efLcYVIEXSOKWOCmfJd83477CY/HNk+ubqLkJ48gio3NTsh7ymhTQ
         i7+YRi4HW4qmV6hQHpmt830z58yrox+AOVQYD0/kj+5FQWLL8c/XAZdc3vU6HKW39d3e
         ShAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfb+tEk13XQO1rORvqT6jjTOoYFqDTPtDzDWCEstlbg10KPrDnpz9IG0FYEM503J2lqCT5VgZ2NLB1oiPa5X+zeO7k2Gast7z8O2ol
X-Gm-Message-State: AOJu0YwQzHfO0Ktl+mBgp4OY5UdcqJ0TxSQ75JPWV4oNyaXxocSVfMAC
	yN+XQV7SvcaPMYpHaKe1iyvRy9I49hpGPqojyx4JrGAV6606hTqlsJZDG6KWGNGBqIJNI9JPzsx
	GldFcniyy+uoA+IrwJqlbyBt7eI5cpjHZsMaKz2p35ZRLlcIenrLh2BjUzoH3xdu8AzEMbwRe8v
	YkeUVTXBeuy/RV3Nb7w0pqSQ31RWhiqGuf7FFS
X-Received: by 2002:a05:6214:20e2:b0:6a0:c903:7226 with SMTP id 6a1803df08f44-6b5409dfce5mr115022016d6.34.1719340380534;
        Tue, 25 Jun 2024 11:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwfGaPXUa87XOWHSBHXlzwjzqYtLVv1PpXuLiyIDn5haTRgZBxULpCbMbu+rq4ZxJhhnKRXE59lKpgxzZJPdI=
X-Received: by 2002:a05:6214:20e2:b0:6a0:c903:7226 with SMTP id
 6a1803df08f44-6b5409dfce5mr115021766d6.34.1719340380237; Tue, 25 Jun 2024
 11:33:00 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 18:32:59 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com> <20240621101113.2185308-5-amorenoz@redhat.com>
 <7f6aa18e38ff3c161805b19780c6265d05b4a235.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f6aa18e38ff3c161805b19780c6265d05b4a235.camel@redhat.com>
Date: Tue, 25 Jun 2024 18:32:59 +0000
Message-ID: <CAG=2xmPoZkWTzFk9G9OU1gntc67qNhoabUYEaoffvRkPVi8smQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/10] net: psample: allow using rate as probability
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Yotam Gigi <yotam.gi@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 25, 2024 at 01:17:19PM GMT, Paolo Abeni wrote:
> On Fri, 2024-06-21 at 12:10 +0200, Adrian Moreno wrote:
> > diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/tc_act/tc_sample.h
> > index fee1bcc20793..7ee0735e7b38 100644
> > --- a/include/uapi/linux/tc_act/tc_sample.h
> > +++ b/include/uapi/linux/tc_act/tc_sample.h
> > @@ -18,6 +18,7 @@ enum {
> >  	TCA_SAMPLE_TRUNC_SIZE,
> >  	TCA_SAMPLE_PSAMPLE_GROUP,
> >  	TCA_SAMPLE_PAD,
> > +	TCA_SAMPLE_PROBABILITY,
> >  	__TCA_SAMPLE_MAX
> >  };
> >  #define TCA_SAMPLE_MAX (__TCA_SAMPLE_MAX - 1)
>
> I believe Ilya's comment on v3 is correct, this chunk looks unrelated
> and unneeded. I guess you can drop it? Or am I missing something?
>

Thanks both for spotting it. I'll send v5 without it.

> Thanks,
>
> Paolo
>


