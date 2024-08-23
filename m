Return-Path: <linux-kernel+bounces-299454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033EA95D4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3253A1C21934
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36894191F6B;
	Fri, 23 Aug 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l27QRTqJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4F190482
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436134; cv=none; b=d+f/vNq26UmhNwtXTDxtogSXisgjdROhAmGs4zyyVPdYTl5HqLOuTvB+eG9MF7cLypBpPp74c16n5Bl4zZRAuesbr5NBjnnljH6TZm7LoePNgBf6swvXLt1uNJ4vNb7UmEpbE+2nLFmNEg8tJK6/9MwJlCVijXrPUIBLLuK3Gjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436134; c=relaxed/simple;
	bh=KFzisPDMHJo7Ln/wIh4AWQVO8V7I807m5GrKhyN8ij8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlFci61ScO0DR2TlRZFUsqTtmaIMtVmHektrBZIrZNhNq1lgMh8HKjVWi4QoG6N6F6ojOm0wDcCxKVbQzv4v2ZaRkI5iYW79Q9LqyrWc6HYDbUijszuwZoI0ry9cip1pGuYgCOeyfOK0fuRmc6IHd842g5/ffXaxus4fQ3MqVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l27QRTqJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so3174626a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724436131; x=1725040931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chz6WNcKqUHubBnvxXzbFav7NB3CIhhztw7hfQz7I5k=;
        b=l27QRTqJRTTUaiTKpACtd8J3FUkDUDPzEGPK4pPrp44NcNINlNuoSBJoVWAcjg1cDM
         SM7DaqTr3jnKTQKM1PhtrnTcJ4eeqEC15ltlplRiHgPlS5bgd2zr3VWkLeGanWDVJxK0
         tSc/kuFODF7dlcZr67az1SAlHNOklIMOlgfoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724436131; x=1725040931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chz6WNcKqUHubBnvxXzbFav7NB3CIhhztw7hfQz7I5k=;
        b=HfhIz3Rh6XByiWlDPLZO6cjsTaNw7ccuPnZigMDs/xL1mpnvQG8iJvWU4zNuCSfF53
         oBz2K8ZDcNucW3gElfK8Pc0sAClpOfbEFyua9nA7ZfxeCOoFlIXlIiBBsC3chdDMP3fT
         UdRqZ0aYzr5GRiGFZFd/Nw7iksqT4jpMBdALcYBtVE66UOQa4s2Meul00LzZDSfgt5Br
         47Vls4NP/ne8kdS5gEdju0VnGA9Oqpjx64ILcj1yr31wKKDftw6GjxlI3qwGNimna/Sx
         Kyy7gWvAWBN68FlgBA0l8OUQj/3F0krRNi8/UTPW4Gl3gebxb3/7I0/SuzKOIRU3Fegw
         2tvw==
X-Forwarded-Encrypted: i=1; AJvYcCUAml1hskR3v3GijRtjMj9mSZU8gDk8YAgulct7IB6drW8vVUiZSZMyo9FYW33pqL0Hz96XY4YNMW/wFf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iwUqwutIuxsN+jOl9bSoMljC75Y695D3jAhESypMZmrJW3xf
	PJXH8z7cxYm6CQs1neyzBhhNZzl/08gpiWASSWqUhrs5mj2o4zHifLLOQYN335U=
X-Google-Smtp-Source: AGHT+IHLmogsSLL4RG6OHQXTCvoGTD7y9oeQstqmNv9alfhru+JJ/kqYHZ2RPkrU6o+dIL+xFV2BAw==
X-Received: by 2002:a05:6402:2743:b0:5c0:88fe:261b with SMTP id 4fb4d7f45d1cf-5c0891637dbmr1859486a12.11.1724436130569;
        Fri, 23 Aug 2024 11:02:10 -0700 (PDT)
Received: from LQ3V64L9R2 ([185.226.39.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c43e7sm2387276a12.70.2024.08.23.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:02:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:02:08 +0100
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] net: Add control functions for irq
 suspension
Message-ID: <ZsjOoJBQBls7dl8o@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20240823173103.94978-1-jdamato@fastly.com>
 <20240823173103.94978-4-jdamato@fastly.com>
 <CANn89iJmp2yviC=Z-n7-=suw8N=SJ7uoy0xy5LMQRKDhubNBZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJmp2yviC=Z-n7-=suw8N=SJ7uoy0xy5LMQRKDhubNBZg@mail.gmail.com>

On Fri, Aug 23, 2024 at 07:56:32PM +0200, Eric Dumazet wrote:
> On Fri, Aug 23, 2024 at 7:31 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> >
> > The napi_suspend_irqs routine bootstraps irq suspension by elongating
> > the defer timeout to irq_suspend_timeout.
> >
> > The napi_resume_irqs routine effectly cancels irq suspension by forcing
> > the napi to be scheduled immediately.
> >
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Co-developed-by: Joe Damato <jdamato@fastly.com>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> 
> You have not CC me on all the patches in the series, making the review
> harder then necessary.

My sincere apologies, Eric, and thank you for your time reviewing
this.

I used a script I'd been using for a while to generate the CC list,
but it clearly has a bug.

For any future revisions I will be sure to explicitly include you.

