Return-Path: <linux-kernel+bounces-328593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD2978647
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D575AB20FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F681AC1;
	Fri, 13 Sep 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2ctF0f4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFD80BFC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246543; cv=none; b=bkD23c85Rt6Bj1I3wOX3SdaLWdtKWAGEu5YKCcak2+8QwYBApibiumhWPittBtE/Ng77IRnPif7tuABxb2R7zPWy+u22Yr03FX0uJamoCEuV64mY//o22xTl5+oIMjd9CRB4ZCdtaUzoX2I1i96wgYGxymQ/Uye48JflVM4SRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246543; c=relaxed/simple;
	bh=M63V4u8RmF7+M3N3nDiiF0Dajnihv8lFCdb8FHkCYXU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOx0EC6GStMlqciI8YufeNbyq4ghP7yd3XbvkDwkkB1q6m6saUHLjxJ1zkBqkwBRRfghxSv5W0aD0VP4PXrNcrFWRIRoMZNT0lessbAwXKCDa65b0MXbd5gZRf4KK7TGDhZDXa10eukV2ki9mWlit0ZFqIGfUXne8+sAl28LYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2ctF0f4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726246540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMhbGtSuThhbSQXpYh3VPuR4XCfQk2qjBVR7P5AL4lE=;
	b=A2ctF0f4W5m0udJjioYp1MotWdErEKI9KksL4PxC1l3svXue5h/YsuUrMj2Jf3+wL1q6ob
	wfIv3BYxOLFmUzrO0cPpeKHIL7oD2vtYC8TBFiLSGPHzSC+SMLkpLQYD+MT/+F41vGRT3k
	MYBFOHOfSWSMvnjGr3ZaWtuk5Gl+UpM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-1F2izIyOOs23G9plYSrSJQ-1; Fri, 13 Sep 2024 12:55:39 -0400
X-MC-Unique: 1F2izIyOOs23G9plYSrSJQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5012986958aso725891e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246539; x=1726851339;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMhbGtSuThhbSQXpYh3VPuR4XCfQk2qjBVR7P5AL4lE=;
        b=Urebx32qECddxEkBdihtsuqO4eOxHZ79kGeXYC/9epoDEL24upn5OCBokeCXXpKp4M
         WbNGjl6o8pYfQyHhfBjW/fpwUfpSc0TlB0iqQFxg2U/np8FDDO9assg1GvSl6S/VF94v
         2liRZyBrWjArzr5IscVKJZZSQ8hZfUz3kBiNkp1d9NnuN3nPRXDqME8wsdyoLgCK0zXx
         3F0uwFI7M0wh3t8j//9goEV7BOF4GKCj9Qdtd6RPYm74GrR6EWMcEWfjYvw0EtPttev+
         wj9I3mJzIXjlfQamauQIP/DnQwJBCaWBUVqB6E90P3umSKKVJsGKl3+eRmYjkdyGceSZ
         xF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXCvSN/Lpkjk2Rif3wtJ2pYk36RXDR+Gmu5nbw6AR4j6xYWoOARDtbIvCHLKoO/f2/+Mv7yOa6YNUz0JYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/H4z98aTETUB7+hZE30IJL/1eb5Crxf5Gcemu6YN/Z31GcWM
	i2gbitjnbcIig4Mj6fMYE2wp9uyS020Y2TCT42npOhofQcYAOnFtyHHag17CcAX9nsodtvoEFK/
	9Sx2VX1jLKywt1w2LupnsG5/Vq5KaNa5xFeMeXO3cDwDnBFh0VFxcTBaVDMug1Q==
X-Received: by 2002:a05:6122:8cf:b0:4ef:5b2c:df41 with SMTP id 71dfb90a1353d-5032d4a4fd0mr5917759e0c.9.1726246538896;
        Fri, 13 Sep 2024 09:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGridi6K82jf+EuBY9jFj7weDJRRCIARJdUQs7CRVJyyWanQpJWjhHgKxRi1h6aNlvWV/kzng==
X-Received: by 2002:a05:6122:8cf:b0:4ef:5b2c:df41 with SMTP id 71dfb90a1353d-5032d4a4fd0mr5917723e0c.9.1726246538438;
        Fri, 13 Sep 2024 09:55:38 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-458320392cbsm54448461cf.61.2024.09.13.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:55:37 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org, Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel-team@meta.com
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <182ef9c6-63a4-4608-98de-22ef4d35be07@paulmck-laptop>
References: <xhsmha5gwome6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zs8pqJjIYOFuPDiH@chenyu5-mobl2>
 <xhsmh7cc0ogza.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <5ea3658b-5aec-4969-92c5-49a2d23171c3@paulmck-laptop>
 <xhsmh4j74o6l9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <8094db32-5c81-4537-8809-ddfe92a0ac6c@paulmck-laptop>
 <4b93e5cf-c71e-4c64-9369-4ab3f43d9693@paulmck-laptop>
 <xhsmh1q27o2us.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <cc537207-68a3-4dda-a8ec-6dda2fc1985d@paulmck-laptop>
 <250cde11-650f-4689-9c36-816406f1b9b8@paulmck-laptop>
 <182ef9c6-63a4-4608-98de-22ef4d35be07@paulmck-laptop>
Date: Fri, 13 Sep 2024 18:55:34 +0200
Message-ID: <xhsmh34m38pdl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/09/24 07:08, Paul E. McKenney wrote:
> On Sun, Sep 08, 2024 at 09:32:18AM -0700, Paul E. McKenney wrote:
>>
>> Just following up...
>>
>> For whatever it is worth, on last night's run of next-20240906, I got
>> nine failures out of 100 6-hour runs of rcutorture=E2=80=99s TREE03 scen=
ario.
>> These failures were often, but not always, shortly followed by a hard ha=
ng.
>>
>> The warning at line 1995 is the WARN_ON_ONCE(on_dl_rq(dl_se))
>> in enqueue_dl_entity() and the warning at line 1971 is the
>> WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node)) in __enqueue_dl_entity().
>>
>> The pair of splats is shown below, in case it helps.
>
> Again following up...
>
> I am still seeing this on next-20240912, with six failures out of 100
> 6-hour runs of rcutorture=E2=80=99s TREE03 scenario.  Statistics suggests=
 that
> we not read much into the change in frequency.
>
> Please let me know if there are any diagnostic patches or options that
> I should apply.
>

Hey, sorry I haven't forgotten about this, I've just spread myself a bit
too thin and also apparently I'm supposed to prepare some slides for next
week, I'll get back to this soonish.

>                                                       Thanx, Paul
>


