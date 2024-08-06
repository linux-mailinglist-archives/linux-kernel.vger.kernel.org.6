Return-Path: <linux-kernel+bounces-276595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9929495DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E41C239F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0786F47A6A;
	Tue,  6 Aug 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex97kw5Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CE38396
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962763; cv=none; b=R8am+1LUs3xSETvsTRHVucR5Ho5ZyUii8CjvDQEo5wZ9Op6dap5yAIvmso0zmqJPlgyLdvxcy3QFNGwwnmDog4WgjLOShzq/la3d+ZJSryc+L0YEI5XKLhez9eM3oQurnK0fuvvKeGpozHXJRvfWpKDHBMq+TkqquATpeQF1Ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962763; c=relaxed/simple;
	bh=E9l70jJaQyykusgTWUUnXUryASZQduz2DF5zqC8MC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir/inJ/fnEb3SgxCnCbyavjkbXCVlZ5u4wEM7Pwhd1OJ5qvkTwlSFYsbyGAWgxLaw6itdSff5kmjJMV45zOOcxk93y2kbSJE3kNWR5ihi7IRQp3wITUk1QYyyf5v4WOJsF8r2W6pyHeTwgKHAECbKVK/Yze3N0/MX0jBe+dwwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex97kw5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722962760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
	b=ex97kw5YmBsPxQy++tixyCYYUOPY7dGPuB8i482PCyTi9uTz2aDEk889jRBzVKs2SsMRES
	DKHOQF4pZfNB8sRcMSjmoYtL44AOfzuNvzuz/c27SZdG7aT/pizAAtq+EYezwdLF+XUOom
	EiCjrtw7zxNmqKqyrgFDhxm0+NTHqlc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-kSgD8CkTMC6VhqW9IlblSg-1; Tue, 06 Aug 2024 12:45:58 -0400
X-MC-Unique: kSgD8CkTMC6VhqW9IlblSg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bb9bfa4b10so137219a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962757; x=1723567557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
        b=BSnes5yl/b5pbSkhQb06a2x6oJ0+Tt2JOaek5jPfqlRWJx/xUSxk4OSzmAB8mFTPrl
         8vXcQCePo3t7wJL1VuqYmTvJM1n/HAcBYlIRg3OD8mJyse3DbZTnthA5jNssiRd1HjRE
         RlggM7gE9+Qs/+uVFsz9e7VpNBn5RcTXCitP+vSIn5ixfyUhewSULcwK9Rk1OXgbPcS1
         fPccNIMBs44FKFgKQlJF0SlCn6D4lf+pMtwx2ikAK725QWjM1Q05ZMhvehnxbieMZnGM
         tEAP+ulEf0cKCIT0sbZS4BgNKFJqWO6BvqH1JERpL+083wpJrLTmLnLNSuYcJspBNb4w
         qMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNLEkqSrM1Ivz4x34w0ii8RN5qplT6Plx4p5ECuQq5gyOZ6fnAeDmNQ06X+IznMuJRYZYy/cX7vyIDn7OnhIxUGZUj8aBsIWiwpYjR
X-Gm-Message-State: AOJu0Yx5/qIzV3uHx9s1j2izjjxjfQgn/RpDEcgXQV8RiMxjN3WC3bLW
	JzX9Lg5081tlXHXg3jeM/U0UoAv5jlwWTIDzU5iLpYbg8SiAh6r2JF0+4nT7jwm/vDlbSaVI8yb
	SfHupPgLhw+oP0ZSDvN5UTKVIHdguAHLNlHBTBO9HWy885qfjNdOxLdoobpDLBw==
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590410a12.32.1722962756762;
        Tue, 06 Aug 2024 09:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESyQrC5UzGzF64K7apX07hUu3twGVSZOhtmGTLXe8INI/Ij1pbHzqjoqEDGmV/r2tnzicC/Q==
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590380a12.32.1722962755874;
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb6609d7afsm3140107a12.52.2024.08.06.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:45:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: luigi.leonardi@outlook.com, mst@redhat.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <uhrf5ctkvc6ic7frpfndtdf66u66lonhfgane7bigb72damukf@mjavswunu7ve>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
 <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <20240806090257.48724974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240806090257.48724974@kernel.org>

On Tue, Aug 06, 2024 at 09:02:57AM GMT, Jakub Kicinski wrote:
>On Mon, 5 Aug 2024 10:39:23 +0200 Stefano Garzarella wrote:
>> this series is marked as "Not Applicable" for the net-next tree:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> Actually this is more about the virtio-vsock driver, so can you queue
>> this on your tree?
>
>We can revive it in our patchwork, too, if that's easier.

That's perfectly fine with me, if Michael hasn't already queued it.

>Not entirely sure why it was discarded, seems borderline.
>

Yes, even to me it's not super clear when to expect net and when virtio.
Usually the other vsock transports (VMCI and HyperV) go with net, so 
virtio-vsock is a bit of an exception.

I don't have any particular preferences, so how it works best for you 
and Michael is fine with me.

Thanks,
Stefano


