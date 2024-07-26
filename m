Return-Path: <linux-kernel+bounces-263394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E693D547
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CD11F217D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705B17583;
	Fri, 26 Jul 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egXmxpt2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13111CA9F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005010; cv=none; b=DbWXoDtgYIvWR/ZiMa/3JI8XyIe5CtHBhCPm7Rv8scsr+cPsdwxKuA72E1Lx1C+ac4MWcmxgQONNl/Ce/K3lg3IjjdXrwTVVXMKMvuw6iy/wLioyypltwBGtT/UFSqhHHQabqAoJXWOCuy5DSrGBdTvW+xKsaEwhB1qtN4WhLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005010; c=relaxed/simple;
	bh=ZrV5WAmBS0RFas/hG6XTL3Ez5wjy+zbmVCb+bXNpYek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VL4OkERi12p8ZWcPV73AghD95yw8eLYfSRj2w/RPa2WLLF29IJvXbNizwaMGFGu7S630OrOah14/NFDxgWQtwdqef+x8yR4Nb3prhBDL6N1a3v9c/sYgJBRuTToMb2/TS7cl/9B22gCpV07WohWqD2rZMPeIgwMMTTP3eJvsNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egXmxpt2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722005007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrV5WAmBS0RFas/hG6XTL3Ez5wjy+zbmVCb+bXNpYek=;
	b=egXmxpt2mz/FdFaCyoHe4dIQ0Zs/A0ywaWOb2rcpdMbZihSL6LZP86FBD8S3TfXQ9aZqoi
	ZHiRsY7CvGfJMrJ7TzeA2hK2ndvbjEsfxnokq9AxGT7/A4q9qdAKMD5nllKp2kYYkg0Ck2
	j6TtT+riuetMU/ryTHFpXzjAAZj8v7I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-01sjcMI1PBa1LnGSU9ilfg-1; Fri, 26 Jul 2024 10:43:26 -0400
X-MC-Unique: 01sjcMI1PBa1LnGSU9ilfg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1ddd9812aso99797285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005006; x=1722609806;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrV5WAmBS0RFas/hG6XTL3Ez5wjy+zbmVCb+bXNpYek=;
        b=AZsc8btW4ZGjsSSt+u75kb3MwLWrE2gk0huaFmzmcfPh+zYBMC0hi8UOHaKRzyrpas
         ihN009PRe3s6VOvi9Y282eJPSeEoS9SbHNoPpb58dDoosVcEuTIKvb5yarhn6cK5teXE
         kSdvzXrQ9Ll2pNfRpdqBgsf75vvDW3Iz5VTm8iKlIrmcRleOrwjCgJ9+/bFZMvDmNVeF
         NeEie/HG3tSKe8AIvGLTIVcG0KINziizdc1W9o2jQFNHylVJkkEThar9k/3lLjLP1wsf
         djoPV4Zfe16H+8kOIQu7KeLw3+YFrG/8ELLGQj4BiecOg5IhsG68GNLtd40qeMmMp2yU
         Uzdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1qt1UYn9S4e6PgYiRoDOX10bwFM8tcli4kRMoh0jlgnDV23nDlupD6ePDZEETK+U60V7UYc1Hbv+0kagMyS+F0gZfl0ErFAf6UtiJ
X-Gm-Message-State: AOJu0YwwZlVAlLaIzj/mp3xj+0/W6d9+l/vbYuQW5e6S2KyEfOahvpIB
	1hLulo5MvIDPDPP9R9g0mZOY2rEx3Bt9qP65Xos//IXwAVj+++/Wf002fUczEJF+b0404kG41WJ
	nhvcrN90KDzY2yueG72FAVjii4GO3PdSa9gQ8YukniQScfCf/P5i0UR68tsM14g==
X-Received: by 2002:a05:620a:4041:b0:79c:9431:f71a with SMTP id af79cd13be357-7a1d7e1415fmr683370685a.11.1722005006012;
        Fri, 26 Jul 2024 07:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCPQW+6labXNXRpDy8sCt4PzStZaupkqdWvMvSBjp/RdjhJtXVZFV56WcmMm6Q2/aHiRhvXw==
X-Received: by 2002:a05:620a:4041:b0:79c:9431:f71a with SMTP id af79cd13be357-7a1d7e1415fmr683367985a.11.1722005005643;
        Fri, 26 Jul 2024 07:43:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955ccsm182287185a.11.2024.07.26.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:43:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
In-Reply-To: <20240725152212.GA927726@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240725152212.GA927726@neeraj.linux>
Date: Fri, 26 Jul 2024 16:43:21 +0200
Message-ID: <xhsmhed7gciye.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/07/24 20:52, Neeraj Upadhyay wrote:
> On Wed, Jul 24, 2024 at 04:43:00PM +0200, Valentin Schneider wrote:
>> Git info
>> ========
>>
>> The series is based on rcu/next at:
>> f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")
>>
>
> Hi Valentin,
>
> I see that this series is based on paulmck/linux-rcu.git next branch,
> whereas the RCU tree has moved to shared tree now [1] and the next
> branch there is pulled for v6.11 (tag: rcu.2024.07.12a). I get merge
> conflicts while applying it. Can you please rebase?
>

FYI I've stashed what will be v4 at the below, based on rcu.2024.07.12a:

https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3-rcu-v4


