Return-Path: <linux-kernel+bounces-339509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BC986624
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24151F25615
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C1184D34;
	Wed, 25 Sep 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3q0BoFa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C4487B0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288026; cv=none; b=HJQQKy/sqA8/E7ByS1qPOIo6fB2ctRxs2S1Ef5dJrzU+HPFWYjBsC/Aj0r4hliMlUwwoUaqqa9TVjpJxZ6Hctb55S1DLKIpo3mlP3BdZ8poGeqaEXyVNmcf0bjKNBleuZIuBwV7SbTatV8UJiV6ILWzMIJLWh14cjVSRc9jq2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288026; c=relaxed/simple;
	bh=JQYy6ttU/i/3yQtBNgzux6kaztcTklj0IHJQHcFlP84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3SvZppc11Y6Cbag9i9XNn3Tez2sZERYTG/OETnkbHwWoE0ob4RNSh1rY5dWMPHvSn6mwgyCk2BwsPw5g66MSKTSQX9PJINDRiOlYHTvdqUpFfFiGq7nDDT15qF7XAQjDl9mCrJgWco3NkPIzpcRnTeUPnghAd77yQM0VxW7gbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3q0BoFa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727288023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9ajmmr6XMjVjBJtF0Yo2GlyD0kiwIhRSnbtBKem+rA=;
	b=W3q0BoFam+w9tXEm+zWv3rfgQEyCdBhcekV4PooWCE+0Fo4ZvCB/y3fIdYcaL1aglrU1U0
	5wjIjx/IE4Ihp+hc6el81Xp+3LwI0fnRHIj77SAd5cZgCZ1NAXpDd9Wb9YRgYf2qUS/9d1
	J4GYjA92eHj0C6hdHcIHk60GDL1hAYk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Pn145fw3OUWjWfJlKT3e9w-1; Wed, 25 Sep 2024 14:13:41 -0400
X-MC-Unique: Pn145fw3OUWjWfJlKT3e9w-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6e1fea193a4so3889157b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288021; x=1727892821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ajmmr6XMjVjBJtF0Yo2GlyD0kiwIhRSnbtBKem+rA=;
        b=DJKlBGp2oOsn3hYosNEfqAlk2mHdFsrklx8KQ2pQuHNpNOzRbsN7YQtnaH7wVVxMhV
         jCfy1/I1lzqWQJgHyb7Y6tYJbbmrSAEP3Idx4UCyvwehJsvCdK696eqNEv2wCtY4+qY6
         LGFYS1Hzg03CYkn4rMi8jj4s+kBMJsPiqozPe4fo+susJgxZTo53dnOXdxtZUdmYjOEF
         A9qCp8FlEj8hxnYFc6eKaINRo0AdPfrUyzpqLxp/C13tpteD9h3juAed+WeV43SJkrcb
         0R3Ai4lGoUzSghona3X7ugcIgLNFmhBjxmJaMWGAY4B+UikzTv2eb3OvSWqUizzYtWHU
         2Vtg==
X-Forwarded-Encrypted: i=1; AJvYcCVMcjPKQyZ77FmkRS40d2w2qoUqwKqan2i4pOo7J551S7C8ACCgl/vO7o6JItefbFyXsneJBcMF26UGeOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UDSorz2a1BzsAa/IMfVzhGpoip63P+cvPpGPuyXQ0q8fbCCV
	HeCd7JFKGKCx+6ao8d4Mn0wd9TV3NV6P4ImYFrDnbNmILVS6rF8240LSMaOgzQ6sUL4+VnAfVlm
	+d7A83AswfYnxn6tjJg6ZnVQpqNiPs9tfwNVCTB2ILyAvDtVm4vSoUBOE2jEx+8O3gfvrJR6nc2
	svPtAXVHHm/YNThUEh/XFLAmepv9tCI7W6Ug4M
X-Received: by 2002:a05:690c:64c3:b0:6ad:f6ae:7685 with SMTP id 00721157ae682-6e21d838678mr34530067b3.20.1727288021382;
        Wed, 25 Sep 2024 11:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3dklGZZYoRlZu5kkgzc2LFblYFn21ln7HRQP0rqBowfCP/18/rjMGTRzXCUEQmLf+LbZHcJCboLxJHRn5o3I=
X-Received: by 2002:a05:690c:64c3:b0:6ad:f6ae:7685 with SMTP id
 00721157ae682-6e21d838678mr34529767b3.20.1727288021053; Wed, 25 Sep 2024
 11:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919165641.4632-1-user@am64> <20240924020824.6264-1-user@am64>
 <8eb45005-c6fb-4baa-a44a-243958a3a1ba@suse.de> <c960dc48-0a05-4cad-b86b-33ad59923bc3@suse.de>
 <CADnq5_OtdUvOUPpq1aUoxtgpt6a4h598019SNhe+9ZWUaANYqg@mail.gmail.com> <CAGtn9rmUfHHOGX-_7ZNUpJMjBkCOMaAuGQsJnpSrfjMfmK1xSQ@mail.gmail.com>
In-Reply-To: <CAGtn9rmUfHHOGX-_7ZNUpJMjBkCOMaAuGQsJnpSrfjMfmK1xSQ@mail.gmail.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 25 Sep 2024 14:13:29 -0400
Message-ID: <CAGtn9rnd1L7PbWs6K6vtB2hC_vX3qC3XNudJSt=X+VNd7q7-kQ@mail.gmail.com>
Subject: Re: radeon ARUBA NULL pointer dereference
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Arthur Marsh <arthur.marsh@internode.on.net>, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wuhoipok@gmail.com, iommu@lists.linux.dev, 
	"the arch/x86 maintainers" <x86@kernel.org>, Nilesh Javali <njavali@marvell.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Follow-up, qla2xxx appears to be fixed, most recent test was with:

commit 684a64bf32b6e488004e0ad7f0d7e922798f65b6 (HEAD -> master,
origin/master, origin/HEAD)
Merge: f7fccaa77271 68898131d2df
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Sep 24 15:44:18 2024 -0700

    Merge tag 'nfs-for-6.12-1' of
git://git.linux-nfs.org/projects/anna/linux-nfs

I suppose the most likely fix was probably this one but I do not have
the HW to verify
(report I got was on an AMD EPYC 7262):

commit b348b6d17fd1d5d89b86db602f02bea54a754bd8
Author: Leon Romanovsky <leon@kernel.org>
Date:   Sun Sep 22 21:09:48 2024 +0300

    dma-mapping: report unlimited DMA addressing in IOMMU DMA path

-Ewan

On Tue, Sep 24, 2024 at 3:30=E2=80=AFPM Ewan Milne <emilne@redhat.com> wrot=
e:
>
> I think we are seeing a similar problem w/qla2xxx panicing at boot:
>


