Return-Path: <linux-kernel+bounces-285422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAC950D47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14CFB28061
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396F1A254F;
	Tue, 13 Aug 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuXpm8zq"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8543AB0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578052; cv=none; b=WsF7YounHMptJ8H1m7MkIFyDL/krHwv1LtX3WHIEpeaRIK7un1QNBB5LMGH+FITsEn/ikhmBY+XNwyCQFuuP0LG3HGJ0gh9uxK9AXjJOREvfQuS2983zEklyfQkXv7haXoZBixGVUkKF4BP2EmdM7NaZSE5B+ij0E5Z8PSQboHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578052; c=relaxed/simple;
	bh=0XCz4z/9nesUOFpikK91xRt3rXIBg+NxQXA82zBy2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKAIp/UQGSJtg+cDf/coz8Qz7GAVc5mP3+dk18NnOG8aEohGnC9vhDsWWrlO9lPknWHSgiLfJLC8hFUSmVCWCACFTBoXRtro70rDOnNWSNI1Qjpg3C1jpa1Nuajvihi6TF+1+bruJT0/2JEPnHnaTnUF5sOiL99gkfcZWcno0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuXpm8zq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5296e214so56300725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723578050; x=1724182850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI0xx1+8K5NJsUQsWsds8lFOqeeVisrv81Aups4+psI=;
        b=KuXpm8zqBRWLxpKyq7qkRXawGuX8eAJgjG86aUr0u2glzBlzKgey45eZoAMs8ffras
         5ffkpMMrlOzBTnLT5Q6CObhOciGcJ+AO9UcneQxWEAOYcUPoJJGEzOtMMkEWS9duJs6d
         7yfwm1+5UpZRBS/J0DxF/AgpJykY+uXK9iHn6yZswAkmI648lFmhZFGPst0SdR6YpXPb
         avT4iED/GhiAHS5j6fhQWzxBlBKIdmuDoL8hyzTwjx5V+V2hAM6pjBqeMbwklHjFiLDj
         izQDTBBP2b5BbzejRHX+SYFx/zbsoK3PesRU46apkwfxAS1HrMkG2BEgyFBnTSXS2VUe
         Y34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578050; x=1724182850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI0xx1+8K5NJsUQsWsds8lFOqeeVisrv81Aups4+psI=;
        b=RIXyXNhJ5MBeMXGdmOSLx0VgLZ6vjHpPBs4annfWexLke5NY+K4k1Kn05c+dbisXDj
         HrjIoD9MqilaBqjNI6mpS/f1jRvxqTHm4n+kpqXdIIWgy7DZuOWX2ScQRFIfrG6ZR3bw
         BeYDKjZXTeLx/9Ic0QsbyBZ9kYAfMfzBdrHD9S8BbCH/fBdyOl5s5dfK94HFu2MsBd59
         jengARA4cLFQtAy3deef1jfOZ8fA2af7g8Yy/mfUeTpKITEkrV8w6lfu+mmw1Dfi2yTy
         u2mDX1M6Ht+GS8ZXvmJLK6zPawGubQKzhfoAFEFp/yneastfnYJJee58eyIrFea5XI7S
         ubHQ==
X-Gm-Message-State: AOJu0YydB3/RMxrmFPkQPIc23XieGLi8ggAoY5cg7ioLJeiJHymgT+mm
	buxWaY2Lbym5Z8xogoJtwdObVItK46ZR3Z5nTAzUjB3ClPKk0UwZ066CEQ==
X-Google-Smtp-Source: AGHT+IGLkyBr+QXIGEvH3BMKPN5Ne7VSGDZikWg+16bqwcK0qMcxQKF1XBoS9EXsp3dFDkxn6pOodw==
X-Received: by 2002:a17:902:d50e:b0:1fc:5fc9:84bc with SMTP id d9443c01a7336-201d64d1ae8mr5571445ad.62.1723578049957;
        Tue, 13 Aug 2024 12:40:49 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a949bsm17222265ad.121.2024.08.13.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:40:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:40:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4] workqueue: Make wq_affn_dfl_set() use
 wq_online_cpumask
Message-ID: <Zru2wILO6RwB1d-u@slm.duckdns.org>
References: <20240802211850.1211737-1-tj@kernel.org>
 <20240802211850.1211737-2-tj@kernel.org>
 <CAJhGHyAv_jwMxFoU6Wa2epfCQK_0LsAkBhFwkGX-ZT-9tAdwYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAv_jwMxFoU6Wa2epfCQK_0LsAkBhFwkGX-ZT-9tAdwYg@mail.gmail.com>

Hello,

On Thu, Aug 08, 2024 at 12:23:32PM +0800, Lai Jiangshan wrote:
> > @@ -6909,18 +6909,16 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
> >         if (affn == WQ_AFFN_DFL)
> >                 return -EINVAL;
> >
> > -       cpus_read_lock();
> >         mutex_lock(&wq_pool_mutex);
> >
> >         wq_affn_dfl = affn;
> >
> >         list_for_each_entry(wq, &workqueues, list) {
> > -               for_each_online_cpu(cpu)
> > +               for_each_cpu(cpu, wq_online_cpumask)
> >                         unbound_wq_update_pwq(wq, cpu);
> >         }
> 
> I think it should be for_each_possible_cpu() for updating the pwqs.

Can you send a patch?

Thanks.

-- 
tejun

