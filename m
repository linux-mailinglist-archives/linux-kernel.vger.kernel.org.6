Return-Path: <linux-kernel+bounces-219678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A790D660
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5982942B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219413A89B;
	Tue, 18 Jun 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YEgnFPOV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3782869
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722736; cv=none; b=nxHsfpY85K36tZeaIwIkes02Sb9zfvfm6qrHz3b9Rbdca8dyGZBNLNqUqo5rH3ZQozwYJAQ68TDVrxFU910RFYtIE2CwkQLMxRADqn++ziNOgddJoz+TnSr3yo9KyGd7AvTrva24TkZkJ/sMfCgir3CHKgsU3pwNNWjfy+z9oFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722736; c=relaxed/simple;
	bh=bWsVoVFDNs1jkkJd+kXXlKTi0xZ56hpAFSilnb6yp10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMkgpHETVPIvmBrm6W5Kw/WJP44+CUi4B5M03r77ug1VJ9AaCUsgivMHS3LU7CgnFPnKqgQUSU4NT2VQFOPuS9Fj262u0ZBNiu8xfsypJvVrjIoD0Ds0gV3kkrU/cJ4h5NoxNjf/HfFUuGbJao9lmSkd5svOMwoWrQXEiT/mlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=YEgnFPOV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so49056775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718722733; x=1719327533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4r3MR9O5+PRy4ZfWPnTqHE3YhX8R4tD2dYUjol8FvqI=;
        b=YEgnFPOVEWQOPItoDQQSEPnXVKmtkL/W9+GfqJNOGwwNQIq1eRZcSbmjvJ0rw8Rc5f
         rb34DmEMjv1V00hxHe/yDt1IwXw2my8iWIgVkf9JPnZ4KrOi8b8trpdBAolfXorTFuzZ
         6b1CJY1uD0rqK/KeVIRFLVeCYWKmNwcWlneg+otQJrZPlS6AFN4mbHoeImn63XVzVSJy
         zTBd1TtHf30SS5SHKxgNAXJ17nk/cpYXcBWLNlhwB4GgT16UQrZ6edyarRLF/eNWRyGq
         nS9Uow+2nDVvHp20fd5fZHP7KGtwbJoDUiSLweZJzEAcOgKYb+dJrwAM4/ir2n5Jp4MO
         pJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722733; x=1719327533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r3MR9O5+PRy4ZfWPnTqHE3YhX8R4tD2dYUjol8FvqI=;
        b=QnXucj9RBvOOwIIi0RLoWOa5HHpGoria4xRG+NzTXkGDW9FWn4I/LaNJj56PUpGMA+
         IKXwkHSgzbaNxd+czXUlOYQqJ8vLKTILgxKnbhPD3b901Oga9I+NzVGawxKRE7HVX+xd
         qQKYTwNYzTlTQyvWadMtdw0BrDL0WaNIBXfrX4cSIwXymPhX5srLoffaezlutgZbcAe/
         nnU8wIuf+h/9ta4lZCFvaO9DGiZBgZ6+w8fY9NqGXlTYNyjCbCSci2tg4d7L+CrHCTWU
         gGsGPEjOdGbOwpVsirDXVmUiSLH1P6XGRm8DMciGmo4HMPZSvvm3TTibTq0eZfgcWJVb
         inAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaIyKxSpReR5tYvRnAjWLKrCp/DBAaq86Bi7jUcF/0ocRC/3193e44jFDJCQ1O+phtQYFHrY/ZQac0Ixeog8o1ECI9csCuqLeA9Y/
X-Gm-Message-State: AOJu0YxSkDq5+qhrgv9xs//rJ4RB0xY09HxW0bdqB77bb+8Dm2Bo/Sgb
	OdxxYoR06vZx3NC8m7jeIkGTzwGx5URY80HRQqm3fhybKPKW/7o8tjElRy8jxv8=
X-Google-Smtp-Source: AGHT+IFe9SpTww03ArRDna6kc98mVAzFwlA7d+uCWp1Tmdb6HESUIWUaP8XEN2UYC/ZRpcdCb8crww==
X-Received: by 2002:a05:600c:15ca:b0:421:5605:8c92 with SMTP id 5b1f17b1804b1-4230482bd1emr101175265e9.20.1718722732928;
        Tue, 18 Jun 2024 07:58:52 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4246b67f0aesm59216185e9.45.2024.06.18.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:58:52 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:58:51 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617110348.pyofhzekzoqda7fo@airbuntu>

On 06/17/24 12:03, Qais Yousef wrote:

> > Sorry, I miss the "fits_capacity() use capacity_of()", and without
> > uclamp_max, the rd is over-utilized,
> > and would not use feec().
> > But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> > SCHED_CAPACITY_SCALE,
> > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > return true, and the rd is not over-utilized.
> > Is this setting intentional?
> 
> Hmm. To a great extent yes. We didn't want to take all types of rq pressure
> into account for uclamp_max. But this corner case could be debatable.
> 
> Is this the source of your problem? If you change util_fits_cpu() to return
> false here, would this fix the problem you're seeing?

FWIW, if this happens due to uclamp_max, then this patch to do the capping is
still needed.

I think it's good to understand first how we end up in feec() when a CPU is
supposed to be overutlized. uclamp_max is the only way to override this
decision AFAICT..

