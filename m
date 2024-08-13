Return-Path: <linux-kernel+bounces-285141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080C9509C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C164E2867EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD81A2573;
	Tue, 13 Aug 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5FWnmE2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C11A256A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564956; cv=none; b=NnGKF1izz4hPlrrjRgBrY2G6WhwqE8vUyLnZKPW0b2TiP8IEsruduSOzUXifA3E5dfMuo12hc+6I2VqSXelOsAm6LAmekHtVtXM+Dhtx6F7R6QVtWY5PCd7Bh2vmfPbPdW+hMEH72vBSvwLaiVNdlTRf5kec+faJ1++Wg3QbwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564956; c=relaxed/simple;
	bh=yI4QT6NbkEI2TnpG1DH/ktsdWdj4x/PaPPzhWgaN5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWnjjZfWfDIgBLXUz2SjXYme0/g24fJXuULsH3/TAqpXk6dayFG/NQyjQvL1ddCROYdLWguftdUrkH+Hi7ndJNb2GBmkpy0TnWdrnJDzkyiCRUPI//Ftrvljoqo633ACJPpGV8EON30FYaXcFtxkTg89NNsU/GgHVOdXiR0mqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5FWnmE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723564953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D++Qz8miXiOrQPRHHoq7zKM0nUNq5aQKlQv/1zqdyj8=;
	b=F5FWnmE29wKzr1qBqZCN4ub3ZEDkJ82sTYbbUWdfzTOyMZjkQJZDZBoc6jeQosrYZUbufQ
	VGdT6ggJXZLiZOtu/KE19AtbJ//05005OkoUapQYsuNuYsZIBBj2nek8uHIGvYdjINy6c/
	ZwVWOCG5X4QdDcfFUJs8dt1uTMpNfOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-KgPPz-zVPCSqb0NkF3Ch1Q-1; Tue, 13 Aug 2024 12:02:31 -0400
X-MC-Unique: KgPPz-zVPCSqb0NkF3Ch1Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so61455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564950; x=1724169750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D++Qz8miXiOrQPRHHoq7zKM0nUNq5aQKlQv/1zqdyj8=;
        b=eQSUSY2WSGiTOWFrlP2EOgkM1Zm8+7BhXM2aDo8SmEY2M/jqe+qpJv9F5EVSv4qCmC
         uPn5wjTz5XH15lmS5NxU1XC/hKboFK7PpdOis2yWNUlWwzfip/OVVnu1liCimIHWxYsS
         evMQGwC7wCMZ5M+VTek9MqTr8lBGmNlkcAvF11+YKRexGwqgj3BUv6IprV8b52DBaNNc
         XjhFa3oq+va+WTDQN4tw2qOAGcaoeeyiwBXDGJIjEGWCRZYnNSKeaqHzCvZK0bAuBIs5
         Xed8F/Ttjm4tdhKRO0X7p+3nk4+r3SK/I/ns4yS+q88lsa2I6Y77Pm+9TnZUXK57ndsR
         +emg==
X-Forwarded-Encrypted: i=1; AJvYcCVoEGCVzLb1Em0p9qVLVJKt5wQTvw/GWb9qckcJkT3oESNjho6Q8Y12kggk3vX+ezyrG1KkjzNbmmsPBU4yUh6COqeJLLtNwp/3+vLn
X-Gm-Message-State: AOJu0YznfAstjjevzfd9aZ+JgkkNgfX76ESdy0QykEUqp6CPrBoO1O9W
	ZWnvA6+IwDHJVNgcA3tLaOCigL4UJRAxlDMUs/hhTWxYhUFYmtS52kHxxLvAE/BpG82ZK2PwWLm
	lNDkRq+YSv+l6KQHf41AcY5kOq9KajQdWxQ8MLsgkzSCp8wSVtKGBovl4BM5sYA==
X-Received: by 2002:a05:600c:3b11:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429dd08a9f3mr1463985e9.11.1723564950019;
        Tue, 13 Aug 2024 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3A88gFDYhC58A8Kf9B/0ejJ6yVjHXP8p29e8MFNq/2z0phpryiFnmZRdavxV6qepB75pIXQ==
X-Received: by 2002:a05:600c:3b11:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429dd08a9f3mr1463595e9.11.1723564949521;
        Tue, 13 Aug 2024 09:02:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm150179755e9.29.2024.08.13.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:02:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 17:02:27 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, vincent.guittot@linaro.org, qyousef@layalina.io,
	peterz@infradead.org, daniel.lezcano@linaro.org,
	rostedt@goodmis.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 0/4] sched/deadline: nanoseconds clarifications
Message-ID: <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813144348.1180344-1-christian.loehle@arm.com>

Hi,

On 13/08/24 15:43, Christian Loehle wrote:
> A couple of clarifications about the time units for the deadline
> parameters uncovered in the discussion around
> https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com/
> 
> While at it I changed the documentation example to chrt instead
> of the schedtool fork.
> 
> No functional changes.

Looks good to me!

At least for docs/uapi,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


