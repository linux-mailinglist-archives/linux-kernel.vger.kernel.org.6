Return-Path: <linux-kernel+bounces-206989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FD901114
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951A31C216B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E751176FB8;
	Sat,  8 Jun 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAuYuNk/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728D18EA8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838250; cv=none; b=YnPLuZQ81TyNaFZ+mIXWKljY7kdtYio4AQzUxidFfDmOT5oKUGiMbINe5F8Y0rcz0v/DD/KVZu3hfjSsduqUjiArLQvgck2IKDb2/qoMEBgi3rgIoWhjTz42Pdiii73+sbdaNcrdPXbOWsW7fVQWYON0Eqhp8Ch0Uvsj2Py1tqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838250; c=relaxed/simple;
	bh=yn+5Ni0OD+DEhhZFp+UeHCOaFS+lfeDdpvC3bDCDk4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZJbpxT3YwEcPcfHL8wfN3hDbqJhaSx5Bolp+G874DOSrWY7PM5gt7UEcYy7P0KWlQ6NAmpqtQahj4FfcrEBPnDgjH29wE55ZMI+7YQMPhowXKmaDlg7ImzmKKPD4mxJ/7nPvZ35hkQexmAHAcCfoHTVA2fjlnAbOlxki7uIIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAuYuNk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717838248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yn+5Ni0OD+DEhhZFp+UeHCOaFS+lfeDdpvC3bDCDk4M=;
	b=fAuYuNk/1fEAr6rUL/FskmdLW3jgf9Gdz3aWc8zC21sJwNHZLOghBVZ0KWUP1q0+EhQFoA
	9/SImqtELlbXtIKRE+nVDUGg6Xn+7iAuI3eEOnnG1lP9xXZ+per6Uo5b4JfaWK9x1f76Kc
	KlV7pejmWMm502ThFAu+CYhsQfvgOB4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-UblGZ_1gMZW8ib9s6NGVxw-1; Sat, 08 Jun 2024 05:17:23 -0400
X-MC-Unique: UblGZ_1gMZW8ib9s6NGVxw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2d89be34cso612226a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 02:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838242; x=1718443042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn+5Ni0OD+DEhhZFp+UeHCOaFS+lfeDdpvC3bDCDk4M=;
        b=bo/FfqmaJ/N0UNkQGTdS4uPEh2Uqx2w2ouUE78E4x0Y5EnT5630sF5GsyCKaBZsgq1
         IgHRnFDelkMJQrsEltjHypou6AW4nHhlS3tWYDa2W/HxtDD4ccCpvFWqvlSOoohLvYB0
         HtQ7bHBb7J7MILKgRkWRvRM9ZbOxJg+omHpFnCNyP0F3/MacJW+jFvUnxBriIuCOklXg
         lUZcJDpdpoYqTA2PcD5Kjs13vgIkQOS7IeYtQ2I3xGnt5i8VGyJaq8EmY/1OVwvuUrr2
         ZW3cKpq2Xty6JOEAcixnXkKWhdR+pbiHtW0DCsXFyLGf5ugc9TC64/QmBaToQaOlFyJY
         dAVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUEIhd4srLPSVKls3bGkd980fbsWsdPitn7oUzGIjo/cj/D0v21B0TnXyUVQZ96AxuVCgoVBMw+awuLRSphlcSakUoOfru5LUI3XFj
X-Gm-Message-State: AOJu0YyHuRExH8RJxHtIJ0CRxTDQmFZKvVmWRkmvxgMUTtH+c8xL70X7
	eO288oEuDHm0TGjxcPi5vK3uEGODYQLku5TP1SV4VSXJfcsECpHJAvgES6Y4wO8A2AgvIva5+2V
	N4YA4zHSlfIaX4l9T+lgbCEBQKIMaxMOCWIM0WMLO3jwNgGCMXgpdWXnBOHPL1UOBH6tH5dBtV+
	H0Gm/9wmFpS0XZzcrpgsXUnTF7sZuc5qvRYCJH
X-Received: by 2002:a17:90a:742:b0:2c2:3b32:a1b8 with SMTP id 98e67ed59e1d1-2c2bcac9f74mr4642516a91.17.1717838242014;
        Sat, 08 Jun 2024 02:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvyEuqeUH7Yq3Z7xIB+QPWu94/YeFGsuuW997gf83B/fNXG/k+oroA1mfbvwrCDmVT2Gmd1wZ+PAVo4g+sKX8=
X-Received: by 2002:a17:90a:742:b0:2c2:3b32:a1b8 with SMTP id
 98e67ed59e1d1-2c2bcac9f74mr4642502a91.17.1717838241712; Sat, 08 Jun 2024
 02:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
 <20240530210714.364118-16-rick.p.edgecombe@intel.com> <CABgObfbpNN842noAe77WYvgi5MzK2SAA_FYw-=fGa+PcT_Z22w@mail.gmail.com>
 <af69a8359cd5edf892d68764789de7f357c58d5e.camel@intel.com>
In-Reply-To: <af69a8359cd5edf892d68764789de7f357c58d5e.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 8 Jun 2024 11:17:08 +0200
Message-ID: <CABgObfb7mqQhPnm+vE4zdnFdBCYgnYR930=P5x0VsbuarrESUA@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] KVM: x86/tdp_mmu: Add a helper function to walk
 down the TDP MMU
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:39=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> We were discussing starting to do some early public work on the rest of t=
he MMU
> series (that includes this patch) and the user API around VM and vCPU cre=
ation.
> As in, not have the patches fully ready, but to just work on it in public=
. This
> would probably follow finishing this series up.
>
> It's all tentative, but just to give some idea of where we're at with the=
 rest
> of the series.

Yes, I think we're at the point where we can start pipelining.

Paolo


