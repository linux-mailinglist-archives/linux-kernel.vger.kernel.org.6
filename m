Return-Path: <linux-kernel+bounces-324698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29669974FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77AA28A575
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABA187866;
	Wed, 11 Sep 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmZcWpyX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF220185B70
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051169; cv=none; b=VevoF6kb93JmGdce5U6bT/nVCVoeTd8VKGpd85e7efu3/wy2dsazXkvl/8SWxPA5Vm4uQuJWwPZeVzOH4SVLT0LL1d98X4AY0yI27anoS5LsKTZQZxvZ3rQRQ4+UFRSN/P+kHr+6GZzTzE3koj/iSJ58kA8VhIpGcTA9LmBDjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051169; c=relaxed/simple;
	bh=UJ8q0kTm4tCbpogVJ3elIuVisVpgJWMaWJ0s442CPXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkt4uU//sguAhfZHPzNaUfZOfsUn42gNQHUjX84W/mXlr3BMHnXh/6yIPOlE/7jaaAXqKvY6VPCieTbdhgh+Z1Buhbc3mkpXoLH8l89F5V4eVqv0KRTwnAauCSvFtyWqWrzqCGnj/h4vw6lVA0jerBE+iiQHQiqBe98Iv0RveJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmZcWpyX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726051166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJ8q0kTm4tCbpogVJ3elIuVisVpgJWMaWJ0s442CPXQ=;
	b=EmZcWpyXHBd+0SYhYb1xx40nziVDewd8d7o5K4bGfP7Abu39kRndLsjgutbmLzSsr2KTRR
	ibpKwg9GOMVKNNHbR3aaIP7XDU90wf6RI6vxXudOwgAPVJCovhlYxNcAe888LybleHQDk6
	jgA7TzrEjbEb7aQguq2G6dKSggFzEao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-lGAhG-SXOSq11Il7qJsifw-1; Wed, 11 Sep 2024 06:39:25 -0400
X-MC-Unique: lGAhG-SXOSq11Il7qJsifw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3771b6da3ceso3416031f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051164; x=1726655964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ8q0kTm4tCbpogVJ3elIuVisVpgJWMaWJ0s442CPXQ=;
        b=UOg1TQFNvskGlnXKqFNajZuas31exZW3/XkvZYx/KBn5d1KeL3131Rb/UHiRq7hUG0
         MjpKFPF1a4P4zfwvcKBU4uy2rMxDoJmN7Ek2kE2h49DAwQNSmPkRpENq9WlYycdj/Kzh
         jMWIGW12ATecjv8PNbACtQIQcpcf+vV4eL7E1l/6R4b3jqipPwOVTlrAe9hDl6TuKLcM
         bTsLD2X4LmRjD/EcNbQY5UFkC69JlYKzFc9vXRS8+NvYSLzzljNXljCXHoTxnuxt0Cov
         xYi6d+Y5wIUEuj6WzNdb2TuAG6YewauBA90ARqlHC4uId5NETE1Cp0dwbEozdgaI/bdy
         /dCA==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ0Ioa7EZ/yomcMD4D4roxoVLMGQP6bqkCCPpy6E0+9pAgdZQwjZymXb1kwahgCl5GH/AiwzmqfMpGCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSJ5riJvl4dI8DqrDdJxDvJ15wqUyPyZkZRulJUfY4/vWoGlG
	S8yLviocn+ePuUY+bhadO3pY/nLrHMvMvV7PbBoquYGpxR1iC3fCWtqzs8HJT4S9WMvWTrShwV2
	xOZgZ8cSkE0H43x80yFgH/FbZ4Ff1s8B9YcH9GicIrY/i2kBpZvpEJBQX1Dz65GvNAEL78MSlj6
	FI3GSMPqRW5FXATgiyJJuV9k6yazD2WMC631D4
X-Received: by 2002:a5d:47ab:0:b0:374:c122:e8b8 with SMTP id ffacd0b85a97d-378949ef675mr9997542f8f.11.1726051164169;
        Wed, 11 Sep 2024 03:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Gb/2HI49PjllPj8NU1cxqsZ2QD298EaN2kurZK5VW5FJwIMKpjSqMMZjF+qdADR0VC1HUbkbMjjhTqnVqvI=
X-Received: by 2002:a5d:47ab:0:b0:374:c122:e8b8 with SMTP id
 ffacd0b85a97d-378949ef675mr9997525f8f.11.1726051163746; Wed, 11 Sep 2024
 03:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-17-rick.p.edgecombe@intel.com> <09df9848-b425-4f8b-8fb5-dcd6929478de@redhat.com>
 <2f311f763092f6e462061f6cd55b8633379486bc.camel@intel.com>
In-Reply-To: <2f311f763092f6e462061f6cd55b8633379486bc.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Sep 2024 12:39:11 +0200
Message-ID: <CABgObfYiMWrq2GgxO4vvcPzhJFKFGsgR11V52nokdbcHCknzNw@mail.gmail.com>
Subject: Re: [PATCH 16/21] KVM: TDX: Premap initial guest memory
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:30=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> Arh, yes this has details that are not relevant to the patch.
>
> Squashing it seems fine, but I wasn't sure about whether we actually need=
ed this
> nr_premapped. It was one of the things we decided to punt a decision on i=
n order
> to continue our debates on the list. So we need to pick up the debate aga=
in.

I think keeping nr_premapped is safer.

Paolo


