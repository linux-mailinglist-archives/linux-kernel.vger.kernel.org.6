Return-Path: <linux-kernel+bounces-221094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9590ECD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107D41F21A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBC1487F1;
	Wed, 19 Jun 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ojlevmjd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AC146016
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802686; cv=none; b=tdGUu9Hk7CZJvPo+3SDl9Rqwm1w7Bu8fMl5hiH9yez32Y2C/SJp+Y8t2eJK9FZjZ2ElKSN+iVaYuwUYjNWIWePvwzq0DHleoqsLdvof8XM+hGX7g+kmD6drcJeXaWieU4v+DJtybqxMQNhI5vnbKlsbM6/jp2BIXIQc4EV53cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802686; c=relaxed/simple;
	bh=6MMx9/E3X3W91ugE851hUdJfDhuyenBEGy36UVjDJ3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBJ+5OHuLZ46pUZM8hEmjkQRuWRu5CCxOcAmNkSoapIPq6jkrXFPBerJhF+F0kU0MET57DIfd/Jw+Ng1JNrYzcEvTCGQwyf14npy7+6YexX6CVEBWVAp+4uT4Zf2RasLowMy9rTXxOiP5OWpFyhVYM69lzAkJNMlSF6s9qgan2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ojlevmjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718802683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNygLwLxnRl00trKraz6/piCD3IZTxeSu/NBGyrNrIo=;
	b=OjlevmjdRki3yyQMPCBTTR5j/Mu7Yapb0HwttS6m63zV5Hku62GHP3ZFjozRxUCY0gBQtX
	AJseLsUqnft8Gs2A0Taizf7itPYBl6NqmQtHL0W1SMZd5cs7Wnn/R696RBgWsaXJRIJN+B
	o1nwFgS5FW+9VSyFagZWFtevl4qhmls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-5HyqtDr8NTCupvPdNf8Kpw-1; Wed, 19 Jun 2024 09:11:22 -0400
X-MC-Unique: 5HyqtDr8NTCupvPdNf8Kpw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6ec06ed579so357361466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802681; x=1719407481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNygLwLxnRl00trKraz6/piCD3IZTxeSu/NBGyrNrIo=;
        b=VHCCGRc2m2JGWxG8603WMdLWHRHD/5wwu5mBGmFPWPb9YzP42Iqcsxjv7gdFXWeyqW
         H0RHNn9NihOjWzLUNAtntfDm832F2ZlWRWyUAbGpZ27IrSB4o5Z3WMETRNByhxzUISKB
         ugalkfm7v9Rl8cUUw9mRo/AeXATMp9E7T6t0v+N49csWeICqGU5K3JhF1SugUAoT+aIl
         NwCmc+SsMWipQaitzJ5aoKFwcxtlYZ8r8yR3RdG592HI9RLOCsAjhdQdL0/LqA2LiPJF
         RAB7tRq/9H7mCKNbHREaUNqhgkr/hYqzoWxE5/zFpRzvuOlvGj00GmdxkwjfXmjLZ4l4
         4X+g==
X-Forwarded-Encrypted: i=1; AJvYcCVCiE1EmkU06zon3XCaHcehQQITGPRlsIFHoE/HpKqo3/emA40GuxjRs6NFiIZBLUVP3yReAmpxvxnl7/BK0ZPFCASewt5TItctf1+g
X-Gm-Message-State: AOJu0Yxm9xkv7b3dL02YrY0YGrdU4rCWb1Zn+xrULweuQKooPeFsACQu
	zinKesSOz3koQtnnxOBIw+r6Il6lNeZQ/Qws89lxgTGEHreSnqfeJZ4N4dFjoy1taiPovk4ohuP
	v1o2gPL0XjfEhVc0UXDt2CovZ6J3dYGWW+ctgnAdoO5MlsM/njbtjsgroKomPBqvV6AKhSOHZ+A
	PYGgO2A8O7MV65a3mLYKjghPBJhfw7cT0/XiBe
X-Received: by 2002:a17:906:31cc:b0:a6e:fb9b:676c with SMTP id a640c23a62f3a-a6fab7dcf3dmr132240066b.68.1718802681425;
        Wed, 19 Jun 2024 06:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEEmubgGou+QZ+1kvAFjWIGTzn5KXKVv/pMwHZqrSCREnG5fUXo5Bg5YKnt2dpd+aruHL5m4QRsXhSoeJdF9M=
X-Received: by 2002:a17:906:31cc:b0:a6e:fb9b:676c with SMTP id
 a640c23a62f3a-a6fab7dcf3dmr132238166b.68.1718802680997; Wed, 19 Jun 2024
 06:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion> <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion> <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion> <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org> <20240617121929-mutt-send-email-mst@kernel.org>
 <20240617094421.4ae387d7@kernel.org> <20240618063613-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618063613-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 19 Jun 2024 21:10:41 +0800
Message-ID: <CACLfguWhi9P2ZJwRYiqUDUeCdihQtFFth9OZugXgiisSMaVzqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, 
	Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 17, 2024 at 09:44:21AM -0700, Jakub Kicinski wrote:
> > On Mon, 17 Jun 2024 12:20:19 -0400 Michael S. Tsirkin wrote:
> > > > But the virtio spec doesn't allow setting the MAC...
> > > > I'm probably just lost in the conversation but there's hypervisor s=
ide
> > > > and there is user/VM side, each of them already has an interface to=
 set
> > > > the MAC. The MAC doesn't matter, but I want to make sure my mental =
model
> > > > matches reality in case we start duplicating too much..
> > >
> > > An obvious part of provisioning is specifying the config space
> > > of the device.
> >
> > Agreed, that part is obvious.
> > Please go ahead, I don't really care and you clearly don't have time
> > to explain.
>
> Thanks!
> Just in case Cindy who is working on it is also confused,
> here is what I meant:
>
> - an interface to provision a device, including its config
>   space, makes sense to me
> - default mac address is part of config space, and would thus be covered
> - note how this is different from ability to tweak the mac of an existing
>   device
>
Thanks Micheal, I will continue working in this
thanks
cindy
>
> --
> MST
>


