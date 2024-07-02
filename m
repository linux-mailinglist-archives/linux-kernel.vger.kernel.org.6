Return-Path: <linux-kernel+bounces-237549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D2923AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0725281800
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD3156F46;
	Tue,  2 Jul 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgT+ir4V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDD1534E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914024; cv=none; b=C90nW8w8ZPwjU0OUZZO+XJmg9JXdi9rwTMnfEDUFr24e2X7kWMmXaKjclZDxqRL5tcRQyp41v1dc8osbmOomv2gl7YLDiZRzSHH9vpslCpsdL020GWBFNwxJlQ0v+DRYO4Jbj3gh051UFUl5yM5WF+mfeP9QQ0AZcFNU69/+OPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914024; c=relaxed/simple;
	bh=MGSzto/cq3LB0E4ecOkYu6NC/5l/m8jXuofARCe6LEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6gDuxJNxLxyTWDXethM3JN9kHcq8bnoC2HTUqFnVvuIn3ctLfqdkqjW7bsuJ4aYIkdnsNpRXdrc7E423IOvST130Ix3zddH12WXhKd17L3ux1B9h4V3RR93YfLqfIyZAk1wvsOO7MmV/qY1jkonkgqRMY60UlMUxvar0dQi7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgT+ir4V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
	b=dgT+ir4VmhCucplpg2cLaCAQR06RL59RzwDj44jquCDNw6PJCgXyOtiq+X2QRPrkEKpVU5
	dHR5GGuOahy3KXTijEa0OkU2i1+RVC79dsh6xqLz5wtJi7+W84MaOrqtjfbhIspvlV3OBG
	Z2+tFVREnO076fkEqhZUjjZmY4qhuEE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-8DXOI_qlPeeTK6MaedB-vw-1; Tue, 02 Jul 2024 05:53:40 -0400
X-MC-Unique: 8DXOI_qlPeeTK6MaedB-vw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44645ec39d4so51396031cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914020; x=1720518820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
        b=jtdtqPKjz6Bxe1r+t805k+QtNySLdDQkqeur0/Yo6+OwlM71uTUveEaub5Ea3n2huN
         ensdEqyNe6Bk/8JhwZlRdVnYrX4L9huebfZf3skmdRL3+oiR8J6vF2/b1vAAUjgS8MkM
         N0zA2tyLZEL/9zrlOBM8zAwnOGqE78RZ2j4wSQeAu2MeVCaM02Wc/LynEOHqYPV1F4aj
         V++mEfHo+pEYBgUZoBdS6I6/1e8ydNvewwkrNT1bAoBdY2G+I6S6RJwAE55krpMrx/gh
         H/fbfY7JnhI3+kv9BxhlOSNZ+TXaB20Q2cpHg5GpcoeM3m8xYrsKb15nRtnIYKRcBGSp
         wx9A==
X-Forwarded-Encrypted: i=1; AJvYcCWgjxQL+6P+YqD5QhPFSxF43zkArS7YiQMYhSLnx95HVjzr3kHxR9CJ7LJ84P3SDwkNdjxiUt4lgiIKcvXc/Cx4rWbCB+Fv3BhoEmIY
X-Gm-Message-State: AOJu0YwKD0aaEAbKt7FXQ+Guxnn+ePPtole49+2nBlofZ83ssqzDUDBz
	15cX0Ll7jT/6doUHeerD9ac/9CXBUiF08pXXF6h8PQiVHCymXd8Ctb4hAChn642OzDRJK8M3dfM
	hMQdx059e+Gw2ZSWWOzkzeM44YHA8ITK0dTlpXEFRC1hfRi+hvEvQN5zyL8J7Rw==
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715651cf.51.1719914020142;
        Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCcQNmIPoKc5Qmxn92R19gzUW4REeysnZ+oNphjyAhLmalfFvXnVJlo/R+c80Iq9xcgNw8ug==
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715461cf.51.1719914019651;
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b2484sm39462531cf.81.2024.07.02.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:53:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: devnull+luigi.leonardi.outlook.com@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH PATCH net-next v2 2/2] vsock/virtio: avoid enqueue
 packets when work queue is empty
Message-ID: <e52cj2hjqmx5egtvnkqua3fvgiggfwcmkcsw3zswbey5s4bc4p@qp3togqfwgol>
References: <20240701-pinna-v2-2-ac396d181f59@outlook.com>
 <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Mon, Jul 01, 2024 at 04:49:41PM GMT, Luigi Leonardi wrote:
>Hi all,
>
>> +		/* Inside RCU, can't sleep! */
>> +		ret = mutex_trylock(&vsock->tx_lock);
>> +		if (unlikely(ret == 0))
>> +			goto out_worker;
>
>I just realized that here I don't release the tx_lock and
>that the email subject is "PATCH PATCH".
>I will fix this in the next version.

What about adding a function to handle all these steps?
So we can handle better the error path in this block code.

IMHO to simplify the code, you can just return true or false if you 
queued it. Then if the driver is disappearing and we are still queuing 
it, it will be the release that will clean up all the queues, so we 
might not worry about this edge case.

Thanks,
Stefano

>Any feedback is welcome!
>
>Thanks,
>Luigi
>


