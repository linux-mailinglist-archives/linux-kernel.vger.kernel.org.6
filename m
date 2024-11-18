Return-Path: <linux-kernel+bounces-412898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDFC9D10D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307A4B26BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0619ABB6;
	Mon, 18 Nov 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYawFjZ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D3199EAF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933764; cv=none; b=gu6n3mYyBCcT5LgfuSkwXhlRHCh2ZRhFc3dY1czEaFijdT1kThgbIcBsXlvqIpcITTsya6ZvSTkE5ruD3RK5Yq/pGfrwAji1WI8bMvbS5bxS05Pybq7yYkt8lWRS1DP8FL010qRmNdeWJorpQj5AjTaJ5weqCLGeduuBIvnxei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933764; c=relaxed/simple;
	bh=FCpTZ+OXty+6I/LwhoSAfoMCBQPfYWa97QmGJQZD/Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftW11elgYSiAeDTeFzwcQXRi9aU80GaPQNtIcsaYnQdBjXJUVT/ZWqUu0YnTlpGjJDufaMwMNgeRb2Siv3CbsMFfoA/wdILElmy9j6b11d6/AtH3ziRIBT7p5pkRG8QUj0W2cVMCauRoQ7pdcXft5Y/nZkk3fq++P1LU58pThnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYawFjZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731933762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7Sl+0ry/66y5Ln6cucWmrZ7ZUf6a8KZ/clf2OlUzn8=;
	b=IYawFjZ20nZt0S5Ddm0CE5sdrL58EKOPoM2NuebnKQdrUNWL5ueCFiMSFo7hXaq6oivQQr
	INnRSHwWt/tNRJPrgnlU+Twd7n2oknRyxVtKVPvfrQRxPdu8c4CrWCfh1WfSPT6pncvGf1
	6zVo1EZJDqIgKYMuEEW+xxo1PTg9f9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-aLrUsOXhPjCveX0KPSE-5Q-1; Mon, 18 Nov 2024 07:42:40 -0500
X-MC-Unique: aLrUsOXhPjCveX0KPSE-5Q-1
X-Mimecast-MFC-AGG-ID: aLrUsOXhPjCveX0KPSE-5Q
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-382428c257eso615268f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731933759; x=1732538559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7Sl+0ry/66y5Ln6cucWmrZ7ZUf6a8KZ/clf2OlUzn8=;
        b=bLdfyw9+Eqtfh5U3EsYoc+4/UJzMyPyA7v6RbZFwI7p9Hnw9m0Xf/3GIozd361w4Hp
         gcfSPKwQfGv0S3SV07LRJLlHQCgMHvPVcbpwA9iq0Ju5feAgjX1SUUoKpSB4H2JkzC5m
         lwEBGgA1JvgmeM5xEjH0vNU9dFF71eTuw+vzuhRrG0aoAxpOtxMffckHz6tz2Q1CIYeH
         S8BDl0I5lS2IIOL6eHQyDs2WZ4CyeiQDya3hlYtIoLCfzaoBIQIYZJjXs+IXENGCa1yr
         3/MopM8Q6SnxfP3kP4LdbbeDbkUq83oYAlF1sm4FmnlJtF1iGYnDwkrt+A3jy7i2lGoE
         qjRQ==
X-Gm-Message-State: AOJu0Yxh1mUOVGPnzrmZsvz4a3FM8CgB604LijV339/+g9ivnFawEWuS
	nXqgajWJ3PYd4WSaKA9ih59XfLqJHbjj9i5DZljWJalqZThxfgKa5DURRbFnU9GMCiUk+I1EICs
	pwPyx4I313ItWlwoK1/pyZT6p5Pkt4anAzBlcRmGZOSejj3AJTfTm4cJ6v4zmamMDgEpAwDD26U
	IA5TKvlY/f57jdGrCW/KDoHZr8gZbsTT+EBj9z
X-Received: by 2002:a5d:5888:0:b0:382:4a69:ae11 with SMTP id ffacd0b85a97d-3824a69b1aamr1300427f8f.42.1731933759338;
        Mon, 18 Nov 2024 04:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1eUySvRKvHgaDBZuHDcttwQpLs5scn4ecD2wAoOE+UAhHhEQ3Kutp85qvyoc832LHDNr+gBR8RNIX+d3RGu0=
X-Received: by 2002:a5d:5888:0:b0:382:4a69:ae11 with SMTP id
 ffacd0b85a97d-3824a69b1aamr1300414f8f.42.1731933759009; Mon, 18 Nov 2024
 04:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108130737.126567-1-pbonzini@redhat.com> <rl5s5eykuzs4dgp23vpbagb4lntyl3uptwh54jzjjgfydynqvx@6xbbcjvb7zpn>
In-Reply-To: <rl5s5eykuzs4dgp23vpbagb4lntyl3uptwh54jzjjgfydynqvx@6xbbcjvb7zpn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Nov 2024 13:42:27 +0100
Message-ID: <CABgObfbUzKswAjPuq_+KL9jyQegXgjSRQmc6uSm1cAXifNo_Xw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	michael.christie@oracle.com, Tejun Heo <tj@kernel.org>, 
	Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 5:59=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Nov 08, 2024 at 08:07:37AM GMT, Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > Since the worker kthread is tied to a user process, it's better if
> > it behaves similarly to user tasks as much as possible, including
> > being able to send SIGSTOP and SIGCONT.
>
> Do you mean s/send/receive/?

I mean being able to send it to the threads with an effect.

> Consequently, it's OK if a (possibly unprivileged) user stops this
> thread forever (they only harm themselves, not the rest of the system),
> correct?

Yes, they will run with fewer huge pages and worse TLB performance.

Paolo

> > In fact, vhost_task is all that kvm_vm_create_worker_thread() wanted
> > to be and more: not only it inherits the userspace process's cgroups,
> > it has other niceties like being parented properly in the process
> > tree.  Use it instead of the homegrown alternative.
>
> It is nice indeed.
> I think the bugs we saw are not so serious to warrant
> Fixes: c57c80467f90e ("kvm: Add helper function for creating VM worker th=
reads")
> .
> (But I'm posting it here so that I can find the reference later.)


