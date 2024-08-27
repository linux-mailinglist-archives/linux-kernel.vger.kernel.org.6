Return-Path: <linux-kernel+bounces-303049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA396069E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEC51C22254
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17819CD17;
	Tue, 27 Aug 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UczegE51"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FF1758B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753006; cv=none; b=HlGSi7Fx+kAmPLUwk5qkWHh5tw29CQeboEPghe0MIMBWF2M4UZSt8lD2EG4nFs4XZ0XVuIlApAYZ8UPUXeVFHlSx4yhCuK+7+mipibpy0Y00cig0w496/3v1vIVgwsg898DflWHpzO2MIStxXUpUJCexESV+oTMbUHGbjKzzipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753006; c=relaxed/simple;
	bh=iXIy2MGZMO16gh3hzCW5LPWaQ1Od2aiOtgKYiO9W/Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXAde8W9P93DnTTJl3yqVA5srxaKP7RI8vcrAUUQAHJW9BHAHZHPtzSBNxrrHL6P18WCZxRJl24sfI1XcoMe/rHXMAmX5CpHbySu6HnVot1LsereJ+z9gyhc5SIQuBU4r5+Gyif22MfSfY4AOw2QDeEiWUD5Lo2M+9UDmRPUITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UczegE51; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724753003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ePo7LbhktsoCxUNbD8OGtiEOqKS27VH/hUgT/iOtx/g=;
	b=UczegE5117c4H70EICwzsHGYHVlXi5mpRfg/7RpCD2TkEBDnYyQ6OaAyPeRrLwjzJ02c9w
	2uC4KMX49zHevz50G4ZwNHIZwcNKyRC+GKZAw2MMyP3r+EzKJLvwjwdJYFO9eSDzGmj42N
	505PRBz+EkzOPQ3pWE79YElaK7yJz5A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-xphy2D8mPxqAP3lAZvmsUA-1; Tue, 27 Aug 2024 06:03:22 -0400
X-MC-Unique: xphy2D8mPxqAP3lAZvmsUA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c175f40282so43271116d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724753001; x=1725357801;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePo7LbhktsoCxUNbD8OGtiEOqKS27VH/hUgT/iOtx/g=;
        b=UwMfPZEDXst9FsYkuH7xToYjnvusqOqnkI1+WmXPODvOeYhb8As7eMhP85aXOmgcwI
         tOipQ+Mn35M1P8khNhh2DJ1zsGdKfmZ3F/vzMcXpSvN//im0S6wgBcHoxayyXJlX3Ud9
         y4Nul72CuytapaD6zW9bzvDw64Rj7qzK5S3zv1CWI0gZ9PYR1f0uZmnvPI0EUGQTsCT9
         UGGBcRtcUJhlRVgxnirju1tr9ajZY7uNzgQzrQBJfpIBMR1UxewHnVRykXnQMP5CkhsJ
         YcXSMXFh+8B+50K39M+dXk2r7yERLQd7hTX/4uu1S1HhVUf+tCIkJeh5SkOETGTO3EZj
         /i5w==
X-Forwarded-Encrypted: i=1; AJvYcCVbWUFIjasIzPPw4SLSClH6C5IJfgfKpsir5lXUCRwCKT94g4mIbppbApd3PU3OCszD8iB0rPb+A7MlT9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFSZ/zYxGOLaLPkSVMcR1flVkOmKA5Si81jvVADKU9TUPwR2r
	SaSGynWtVOnCEpAb4JxBS9kWpy1M00+84fNJiztVc4WFROvE7B3PbOCFdEOHT7I5YUe928YsXmj
	FBDbHAlw3w8OxTa9BLcQewBsv7/tYp6ydWsEEsKOtJ8hpGukmAWvU41luCBoQNg==
X-Received: by 2002:a05:6214:33c9:b0:6b5:e099:4d69 with SMTP id 6a1803df08f44-6c16dc6687bmr156669136d6.26.1724753001577;
        Tue, 27 Aug 2024 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaRoJeLC3RAwa6KhbDHYXuNtUK+CzXSM6BtZhXz/RxTCfBKmYUvq3UUrOeMINPe03dW2zkHg==
X-Received: by 2002:a05:6214:33c9:b0:6b5:e099:4d69 with SMTP id 6a1803df08f44-6c16dc6687bmr156668846d6.26.1724753001148;
        Tue, 27 Aug 2024 03:03:21 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4ecb7sm54932126d6.42.2024.08.27.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:03:20 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel-team@meta.com
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <b1824f4a-f5cc-4011-876f-8a73cf752067@paulmck-laptop>
References: <c28dbc65-7499-41a5-84d0-991843153b1a@paulmck-laptop>
 <20240823074705.GB12053@noisy.programming.kicks-ass.net>
 <xhsmho75fo6e4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <b1824f4a-f5cc-4011-876f-8a73cf752067@paulmck-laptop>
Date: Tue, 27 Aug 2024 12:03:17 +0200
Message-ID: <xhsmhle0inuze.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/08/24 09:31, Paul E. McKenney wrote:
> On Mon, Aug 26, 2024 at 01:44:35PM +0200, Valentin Schneider wrote:
>> 
>> Woops...
>
> On the other hand, removing that dequeue_task() makes next-20240823
> pass light testing.
>
> I have to ask...
>
> Does it make sense for Valentin to rearrange those commits to fix
> the two build bugs and remove that dequeue_task(), all in the name of
> bisectability.  Or is there something subtle here so that only Peter
> can do this work, shoulder and all?
>

I suppose at the very least another pair of eyes on this can't hurt, let me
get untangled from some other things first and I'll take a jab at it.


