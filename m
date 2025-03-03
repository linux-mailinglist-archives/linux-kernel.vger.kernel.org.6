Return-Path: <linux-kernel+bounces-541098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D8A4B870
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6353718917BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAF1EB5F7;
	Mon,  3 Mar 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZMpYrYq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11121EB192
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740987629; cv=none; b=IeM/8wcHCvdNaqWvXRDhLmg9LHyExyo/IpUy4xr9hH7mJxbUMQ6Iz2S3I2yIikCx08wTmC93FNVgb/LTvSiHOMXo+H9uBbqY0pqGRN2EnN8XZw/QnumnB9d1WljFt5/O+OUC6iSyWDYsJI3rxAVf5zs8feEScjxlveUsPLTarH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740987629; c=relaxed/simple;
	bh=IzeGHhNg9guS+bb6Xf/SXPSItFc/WQddL0VKXCsN+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qPClxHVnm3CqYqZSW8VvVu6rDzryysna0X/JGsnYSiPS/vbbEgYpFYH+8DZcnVtmSiiZ8Yg7Z/HblzBY4YHkJwx/nSZsVRzhJThmuY2ZU3SRAZAQPr9H8SjNW0Bf/vNKp4PqBvhD0O5jq11ZCGkH/EOzoE2jJbY57+Uut91XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZMpYrYq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf52666efdso210998366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740987626; x=1741592426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=bZMpYrYq8SmU+1WmTx/80imEvMa0yB74Vr6xlejw6sFZAlnT1Bl/W4GCPt63wwLOO1
         +5UJD9ENZawuRtTCHXsNJi6TL3GHu4uy71jMDTqN2S8BIc1TEfX5KVQ7+qKEiij44G3b
         osYyOTUC5h18vArHUU1ehxOIX6RYAw/hUIbFUCVzLi+c7L5tHmmq1Cyls2nczEyBcbqm
         sBrLx88Yf0w8hVri1pLA+duitT81weW+fAQBmgXGL+i7/m8fRHYEp56nY0CZZub39JXc
         r/Bbi4PfiV4YpxN4jFHBTKx/UrWqF8gMeLo2P0FwwW4Y5f6OfbsnLr1rn+/FurtpbDQj
         d5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740987626; x=1741592426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=VlxZTRYoIxiJASoiLjAE52M4TYUStdo4uFvHe+yXcRiZ4Ry+tQoaLi89QU8wMPBFSb
         PoounXLIohy+tnbb9tYNnVkWuCsMDwpUcuUh+9IFlivUgZ1pfUaVdXj+yZCgMilv/CaC
         SM5qa0PhT/j/fWzYQfaE2ZE1Mg4H+oCtPy+2o05sDrtVstC/N2O8tmF58qC+iyCRqodU
         PCKorfYq+IrM2q3pcLrYgKlU/BjR1I3OdCxFhvAm67mDVyb+mnQJYPoY8GwiSMv0cBKc
         8wkAvHrK5WkbRKFDZgpgP2T7WrtkGSwkLvXgdlyfu77C1+CfVs/VgMYamq2yVlTfxKDb
         Q5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8sIu98snGedlNzg7LZPwyZLP4nkHmKSrQlwsVJkSjQ/G/0A5yIF23I4tNS+6BO/PgGZqdunGmyzdXzMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTW7gLlyz1DVK0J3CKS8X55rY0IvctCvn4l021BBkMFSZYuSi
	42eG0wTNCL1qJUrIAzujiuS05q5BeI3U3hDOpHoRfTMYXLMN9vbZp5PAfEX5Hbg=
X-Gm-Gg: ASbGncvLnaVoX82j1b9ktTKAw6GcM/kLu9XmuO808wrPeAvMJcWAsFCMgIwaLmuXt/h
	hjyux4aiRCE3EXiA00ZmI2xZj2kj7EgXQ6YzBaJmFYgQsdiV5xrpTwZp77Bj0MHNkj2qv0z2a2O
	p5btfmAqNaNezKlUm7HumopV4tsvbwkH9/99HaMj0aPx2CIsSCunGl8tEeMZUw2GwE+VMznjran
	6GPG9GzOJHxJsTJ5n/GHAyHnYo49zxnbq5HV6GZO6wONOsnwCDNsPlxhxf+6jX1Jn0x9PT5W0xV
	HAx7hgCCqovDRo2YkaUXwNnK61nd6Ktd3dX8jyFrosq+GeUw7Q==
X-Google-Smtp-Source: AGHT+IENHB++EW6cxUTVldIAQkOiV9MmVqFnw5XQy2hy0OzVOdph9rtPPbQGZ/IPOrVxn3HuLojH1Q==
X-Received: by 2002:a17:907:7f27:b0:abf:7406:d375 with SMTP id a640c23a62f3a-abf7406d6aamr378845466b.0.1740987626156;
        Sun, 02 Mar 2025 23:40:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c75bfe2sm758421366b.151.2025.03.02.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:40:25 -0800 (PST)
Date: Mon, 3 Mar 2025 10:40:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Message-ID: <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>

On Mon, Mar 03, 2025 at 07:21:28AM +0100, Michal Swiatkowski wrote:
> > @@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
> >  static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  {
> >  	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)cookie;
> > -	struct qed_ll2_rx_queue *p_rx = &p_ll2_conn->rx_queue;
> > +	struct qed_ll2_rx_queue *p_rx;
> >  	union core_rx_cqe_union *cqe = NULL;
> >  	u16 cq_new_idx = 0, cq_old_idx = 0;
> >  	unsigned long flags = 0;
> > @@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  	if (!p_ll2_conn)
> >  		return rc;
> > 
> > +	p_rx = &p_ll2_conn->rx_queue;
> >  	spin_lock_irqsave(&p_rx->lock, flags);
> > 
> >  	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
> 
> For future submission plase specify the target kernel
> [PATCH net] for fixes, [PATCH net-next] for other.
> 
> Looking at the code callback is always set together with cookie (which
> is pointing to p_ll2_conn. I am not sure if this is fixing real issue,
> but maybe there are a cases when callback is still connected and cookie
> is NULL.

The assignment:

	p_rx = &p_ll2_conn->rx_queue;

does not dereference "p_ll2_conn".  It just does pointer math.  So the
original code works fine.

The question is, did the original author write it that way intentionally?
I've had this conversation with people before and they eventually are
convinced that "Okay, the code works, but only by sheer chance."  In my
experiences, most of the time, the authors of this type of code are so
used to weirdnesses of C that they write code like this without even
thinking about it.  It never even occurs to them how it could be
confusing.

This commit message is misleading and there should not be a Fixes tag.

regards,
dan carpenter



