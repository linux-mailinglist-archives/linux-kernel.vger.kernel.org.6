Return-Path: <linux-kernel+bounces-390372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7D9B7904
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DB91F21BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4280199FCC;
	Thu, 31 Oct 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB4+0v/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DA198E86
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371869; cv=none; b=anfnjoaYmbjL10MvZQEJebzYvbSCiPJSdSyahH1IyeAJrYc+uOzeOwMHwCzJKPf+rvKMQ302ThuI0mxtOP7M1BAMCdNPhqwxvZ3dtQCc+COnxd2437cLy0e0EW8xNKSZrYTokunv0k5E0QvoO8ruxoJDIGUpuBdaWRL3iiZsAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371869; c=relaxed/simple;
	bh=uh9+w29J7T5ImrWhnSAaEfztZF7N3Bb4bZAX+Lkmx1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSnnoL0SWngkzhs9VLz6emCNBDdCaq+dtAa7QptM3gn8ESW1m/FihO8vQaI1whI+Zl+xl2DUTbjK/9WSqULvmLVrPXILc18O4kqn0bukc0zwuVr1TwS3AlezIn6RlGerA5FKpDqUP0i0C5b3k1EYSZBaCcrT2cK5RwQdTN2DJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cB4+0v/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
	b=cB4+0v/kbOCKqnRBDxeJfrXNfafKGEIVwUuhqJK844Wc38TOD7x/6G0iCy9PGy+8d/g9ov
	gH68u9cIYNJ6CPVGJQC8WDJ6JMoRYoxxvNZ/fGHsqvd8ZRK3nMTqMrNh9tf+HCqoZ19cNk
	oov31ylY2Ffn0DDS26jt20yBgxL6v0I=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-w2Oc8IPSPKOaSI7BUrC09w-1; Thu, 31 Oct 2024 06:51:04 -0400
X-MC-Unique: w2Oc8IPSPKOaSI7BUrC09w-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4a46a68064eso258092137.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371864; x=1730976664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
        b=wignglNroqiyemC+Pzeq3opZLBoVjYPeV4Pr8qWx64etP5FC0hGL9+otNxIxGQFCIe
         kna3BG+Xcc7YDmsqm2DHVHIPZPF8MBZITrZdDAGgl07LDNgobhiXSgrvUK0DzhY6xJzw
         vg+0I3yEBx8oKn8EhEWYN24Dr/01L9Nsmhpx22OJVdxNCMCwps0JBCmTVt8L/54m3b5Q
         ITRbR+0FU76sGsM6f356Po4wThWHnkp5XvfkVcUeReOs+CGcAv3eiWBlt7SIvrTwqZFv
         BX4MtT9jU+HFuBLTFdxR9U6GdoyFLY9fg5GuWf+HL7OI+Gd4483Ct0GtCv4NIovtsS44
         qjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXHFpS8PLODMuxZQ8KuqyBRFYdsw2i/gwCjbPHIRAwq8vw9/2oEwfQy4yw/uKRkQYhoohVLacIleOKGS+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95VQhQzQqybogqNufJAtksZgHVmh2czafNDDnuxw5p59Mp+zH
	TEmcCk9Db0BXRBNAmCGznq3XbOyCksWtY/1YdtKS5sE0jFHEUNelL2/H9+88D66sj+LrF/JjHG4
	f8O1lZzoWykHr6h8ysktrvBnU7CH2D4XofsUUl41NmCGY47DLNM0U95NkkoSVh8x2zvzWAzv2uY
	Ye2/+9MpjEAxYhXn0avDcNws4mkyjEIz+zfFjr
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id ada2fe7eead31-4a95437210amr3812160137.20.1730371864244;
        Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfzEyODsd5Ja8ZyzC6TH+ukrerObDa1tg1mi7WbgzDduWTc2C+QNy9WoO6WjMViQRFfbhvhDuBNxMti+84S8=
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id
 ada2fe7eead31-4a95437210amr3812123137.20.1730371863840; Thu, 31 Oct 2024
 03:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com> <87v7x8woeq.ffs@tglx>
In-Reply-To: <87v7x8woeq.ffs@tglx>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 31 Oct 2024 18:50:51 +0800
Message-ID: <CAFj5m9KZRjupM+bsuc-r_kTu1h8+wtc_fdmkHWS=cNbg4aU03g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Cc: Guanjun <guanjun@linux.alibaba.com>, corbet@lwn.net, axboe@kernel.dk, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	miklos@szeredi.hu, peterz@infradead.org, akpm@linux-foundation.org, 
	paulmck@kernel.org, thuth@redhat.com, rostedt@goodmis.org, bp@alien8.de, 
	xiongwei.song@windriver.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:35=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Oct 31 2024 at 15:46, guanjun@linux.alibaba.com wrote:
> >  #ifdef CONFIG_SMP
> >
> > +static unsigned int __read_mostly managed_irqs_per_node;
> > +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_al=
igned_in_smp =3D {
> > +     [0 ... MAX_NUMNODES-1] =3D {CPU_BITS_ALL}
> > +};
> >
> > +static void __group_prepare_affinity(struct cpumask *premask,
> > +                                  cpumask_var_t *node_to_cpumask)
> > +{
> > +     nodemask_t nodemsk =3D NODE_MASK_NONE;
> > +     unsigned int ncpus, n;
> > +
> > +     get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
> > +
> > +     for_each_node_mask(n, nodemsk) {
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], premask);
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], node_to_cpumask[n]);
>
> How is this managed_irqs_cpumsk array protected against concurrency?
>
> > +             ncpus =3D cpumask_weight(&managed_irqs_cpumsk[n]);
> > +             if (ncpus < managed_irqs_per_node) {
> > +                     /* Reset node n to current node cpumask */
> > +                     cpumask_copy(&managed_irqs_cpumsk[n], node_to_cpu=
mask[n]);
>
> This whole logic is incomprehensible and aside of the concurrency
> problem it's broken when CPUs are made present at run-time because these
> cpu masks are static and represent the stale state of the last
> invocation.
>
> Given the limitations of the x86 vector space, which is not going away
> anytime soon, there are only two options IMO to handle such a scenario.
>
>    1) Tell the nvme/block layer to disable queue affinity management

+1

There are other use cases, such as cpu isolation, which can benefit from
this way too.

https://lore.kernel.org/linux-nvme/20240702104112.4123810-1-ming.lei@redhat=
.com/

Thanks,


