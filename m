Return-Path: <linux-kernel+bounces-328571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD629785F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18AD7B23787
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BB78C75;
	Fri, 13 Sep 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDOFmdE9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521D78C7E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245527; cv=none; b=dJGqG4cCNULMzoGeIZBmiFhGYW/jJ/BhFoRPOugDLf5ktihNj61j492TVk9KKVELTgb3gAEedYAl+3OA8ZfLDrHRCaJb5oIckERJ0z1cLiDNvyxjVswuVIuVDh4RQ/0R4WR4xeGefe8WHYSHlN0DY35k/uDWnv5Cqaq+Fm0VicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245527; c=relaxed/simple;
	bh=eKRWbCrqp4Hi3KZ1gin7DIWDPLN6BS4r3sT0Wq7+39M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeTxoJCoSUroQrvedhhnkbVYZmIZ2bxGJ59gxpf57QKZoUbOvqJdGdezR948NVT5uEptm5rpjwN6m9tHeASIK//LmP8Sv2ovXxvb8mcgCWWs4IGT5d86asxiv7x5zRlBspKE4g10o/UOOXM4WxuovKSq2QpOJ8Lk+L3eslaillE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDOFmdE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726245525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaZvsF0KpssXiytVEqsYTDYy7O6eYu1DovquR/AjGh0=;
	b=TDOFmdE94IB1mhy7bNFbcJ29qdMKoAd+oMA3xkS7OZ9kU4wlN95EXdbWryIDU2wxJqoeIa
	cUSE0kdpmmRnyo+eSht080xOeTbE6+txp0k92G43DX4KtCXSanYTxjjpf+KrfseQrNWq4T
	9HNJHg0k/A/++NLOYNMIGZqki7Cp9AI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-8ftL2QnIPdGbrn7qN7VoGg-1; Fri, 13 Sep 2024 12:38:44 -0400
X-MC-Unique: 8ftL2QnIPdGbrn7qN7VoGg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a99fcd374cso195522385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726245523; x=1726850323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaZvsF0KpssXiytVEqsYTDYy7O6eYu1DovquR/AjGh0=;
        b=X6Gj5X8WT1RNN2OJ6g3+9VlvWt23kAY4fZjijEa/AepwzylPcESI95Y4jiIhIoQVZj
         zQHD01F2/DQyq+rSvDCc2dsQwaY8dasLvYTL/LwK2iHcAwQ/unxcDUbekb6dl2jHxZ9w
         HY34gaQ02Mx4qpG4E0a1r4nimHNBYEnmnpzIGMyHNRwQnAoL2HFlFxWUxat9/o0EZcj8
         FREcFB6Qsh46TNiTGtsLutCYPb5SMaEDx86CaNlbk0gOhk7zpZFM41mm1T89ZRuDP2IH
         J5DyfvRy/glOi2VYciNJ5ja7ZKneiJRMlzHKR+jCzzIBmFI6lSIo3ecNkuR9z25KyWkA
         kW7g==
X-Forwarded-Encrypted: i=1; AJvYcCV/IbRY3IcXH5tcZYLlxXnobWq/frciZkiVbCOh2L5UqLmW6C6t29XwZFM0gqJNmUE3+Hr2Sj+Asz+/Y6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEr+IwbZS+UHvRfHNC3zZXJENHVmGnG4XtskITccavoyquMykd
	O6CxsKEW3DnoCjHTavfnEQJq4RA41uk0Ra1wSgm1aDCoHga7fKeMWUtuGL8PgvunfkKL5SmR4TF
	Lw6gGE1bS2kpYC+g2yXhYd8VfJX55c0NzEyKdz8WFKuhzlq7IYbFWulvwP0LM4A==
X-Received: by 2002:a05:620a:1789:b0:7a9:d0ec:2d99 with SMTP id af79cd13be357-7ab30dc40ccmr472291285a.60.1726245523436;
        Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCWFymOpygZPYJIdqdGAzh5LWofNDVQvIv+azfhWI0wpBA+ObnwQLFnynF0xMguXytDYqU1w==
X-Received: by 2002:a05:620a:1789:b0:7a9:d0ec:2d99 with SMTP id af79cd13be357-7ab30dc40ccmr472288385a.60.1726245523073;
        Fri, 13 Sep 2024 09:38:43 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1dc91sm683815585a.106.2024.09.13.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:38:42 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:38:41 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
Message-ID: <ZuRqkbJixRQEScYA@rhfedora>
References: <20240912230102.157534-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912230102.157534-1-minhuadotchen@gmail.com>

On Fri, Sep 13, 2024 at 07:01:00AM +0800, Min-Hua Chen wrote:

> To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.

Would you please rename this to .swg instead?

'''
5.1.1 Input format

As input, SWIG expects a file containing ISO C/C++ declarations and special
SWIG directives. More often than not, this is a special SWIG interface file
which is usually denoted with a special .i or .swg suffix.
'''

https://www.swig.org/Doc4.2/SWIG.html

I tested it and .swg is not removed by 'make clean' or 'make mrproper'.

My apologies for the extra work Min-Hua. I can send a quick patch
instead if you wish.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


