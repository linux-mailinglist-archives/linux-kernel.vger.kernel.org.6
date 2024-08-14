Return-Path: <linux-kernel+bounces-286247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80F951894
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5551F286DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1B1AD9C6;
	Wed, 14 Aug 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BP3hB0nk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9013D8AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631008; cv=none; b=ZEeiZJ/OvuB43zljv6iJGv4fabB8yyomvSNju9eHWNMDsORpHkmAzDRnK776eBr2CO5t92MbC2aMiau6gmcjnetiznDvAIOP3IRXHLnTpl7gjnvDfh6h4gPXzaphyfnC3b9RbdkintXo+R8bZUujCOrkpK/okQNVDniVECLaA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631008; c=relaxed/simple;
	bh=7cw1/AbKBPeqsJV9coJxF8dZAjVe8TO+fPAe15u0eMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LulDWy6zXioBM35R06gEigRodPlZsrdTeXSbWBiFGyK9MkThN785w0UiVT2xfeJrKy3wDmeSUKPhahihn/kc3xpXHYJN6IHerf0MOyvZmGOQ/FSD/dHGhmac1dmxMS1CgnY9k8aM3iC8TlqPxFKoXmjsceoGFl5BtuyDh8JV+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BP3hB0nk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723631006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xf8FewnhDBtJSkHfcGafEfhFMcIiUCCNI1/G2S8BSV8=;
	b=BP3hB0nk5gfqQHvO9D9nM2yHDrvu1hPj6qWkcC1jZ8u3/w26ae57/U58gJmG509CEK5GMD
	g3DVzriJcsBM3zKy5EYdiyofPPvWC3pC1+JTfy+w/jsmWR3JCmtw3MUugn7LV+Y41lu5PJ
	IjJ6cEd74VJPvFt7p3iC5/EeMSk/EXc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-us3zOpNiMcGSIqlXX7mvVQ-1; Wed, 14 Aug 2024 06:23:24 -0400
X-MC-Unique: us3zOpNiMcGSIqlXX7mvVQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44fe92025d8so70327451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631004; x=1724235804;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf8FewnhDBtJSkHfcGafEfhFMcIiUCCNI1/G2S8BSV8=;
        b=SACyQcH0DQbOWBomVk3a1uhyNB6EyCrgs1jt4p8Hnw8bjUKRMW3mbMsG/m8nqSLaJl
         0uOZuVj5cdVFLRGfIq/wZMAX480QzD6dhEKfa0bRQSPce/sC/vfb0KzjcZN48/If+cpK
         8ENdjOpqqYEPfHD/gaYlb8BR9LGv1rwHopvu2pi/Q6i3yogiX+2VtpM3WD/9XStivP0o
         qOOXziG6T5aztdTefuGO6gsksaqM+2u7+5WFtuaCjlTPGVEDCqZJ45nTDma72EZnU9Ge
         Wj2VyO+5rysIjvgHROzZmntrGXD4IhSYRtRQI/eASgnS9cznVDVoDIb4ex7uV4E4+sbr
         BD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/qqwPgF7ks7yvPfNEIkLbHTwVf1NmMfHRTKspD3CLGtRDoa8KzfJj3+UI6EoSXhUZGNEY9KrBZgcAFfxh9gVEq0QmjbGkG6mKxnHu
X-Gm-Message-State: AOJu0YxWgeQiie+dciEwRVz7AwgFJOKYCPPL2DzBWO9Q5B9vfUse7ryK
	ipIplVmNhJX5lv/6g2Ye2rYQJMUwC9bT8E0G0p5qeFLqdUs6O5F5LAKFdCgHzxwx6c9NKGqJQgu
	59wIYV9Ql7ce8c1fbiuoBnysY3EbGn/aYK27pzaYpcNFtCNFDFr1gi3RxbFOoQrLbJ31SlA==
X-Received: by 2002:a05:622a:424a:b0:44f:feef:d804 with SMTP id d75a77b69052e-4535bb8d5b5mr28175251cf.40.1723631003878;
        Wed, 14 Aug 2024 03:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZlm4Od5fa3O6bmSEd3xQHQa8InlgJn2CTPA0YW8+GZLXQ9jguTRXmBvfMLWk6lUGFsVfXoQ==
X-Received: by 2002:a05:622a:424a:b0:44f:feef:d804 with SMTP id d75a77b69052e-4535bb8d5b5mr28175001cf.40.1723631003581;
        Wed, 14 Aug 2024 03:23:23 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c291c11sm39593971cf.97.2024.08.14.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:23:23 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
In-Reply-To: <20240814072548.GB22686@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813221806.GB10328@noisy.programming.kicks-ass.net>
 <20240814072548.GB22686@noisy.programming.kicks-ass.net>
Date: Wed, 14 Aug 2024 12:23:19 +0200
Message-ID: <xhsmh34n7xv1k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/08/24 09:25, Peter Zijlstra wrote:
> On Wed, Aug 14, 2024 at 12:18:07AM +0200, Peter Zijlstra wrote:
>> On Tue, Aug 13, 2024 at 02:43:56PM +0200, Valentin Schneider wrote:
>> > On 27/07/24 12:27, Peter Zijlstra wrote:
>> > > @@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
>> > >       }
>> > >
>> > >       se->sched_delayed = 0;
>> > > +	update_load_avg(cfs_rq, se, 0);
>> >
>> > Ditto on the ordering
>>
>> Bah, so I remember thinking about it and then I obviously go and do it
>> the exact wrong way around eh? Let me double check this tomorrow morning
>> with the brain slightly more awake :/
>
> OK, so I went over it again and I ended up with the below diff -- which
> assuming I didn't make a giant mess of things *again*, I should go fold
> back into various other patches ...
>

Looks right to me, thanks! I'll go test the newer stack of patches.


