Return-Path: <linux-kernel+bounces-177527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C28C4035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1121C213A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6214EC7C;
	Mon, 13 May 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kew62/v5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5ED14D2B6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601378; cv=none; b=lq7+VtGb5HHOQolDUTwzPeCD5TZJ7qWs0eR6ect/u+GGw2gCaHmIPzZwVH74WdKHXUBT4++96aYQcpahnpQ01IcbLzWZJcB1q42VFGy03ujgvIu15/G0FdepizjqPKMvtIWt/nTQoX3LN8n/HT90XPPPGhTniffdBDdxQGBOxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601378; c=relaxed/simple;
	bh=/K5+pcbqvHdmlKOIY6EGxlQYW8ZajxPOAOvXpRv0FbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMIdBNHIdlthl90/T+CP1Rjf3Te3WQMbMSxmc0X9Lpd2lAlLoPuugkR4x88vxuTGnJSZ2DMeXlWef/G2uHKuhzb3fxOHX591HUkodIu2vL50fEjZ7KIoij11bXxQsTtKoiIl8eDkt3qG9Yc7pSl6fppLnvidXQkIbTv67hLVkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kew62/v5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ff5e3dc3bso19803655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715601373; x=1716206173; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SVjlWqAdfLnp41PpnyNhWZSZIhghyWvNnJwtCIztyEM=;
        b=Kew62/v5idseMPnkp4F3MIDryaF9FFyCBe5IoHp8kdaIv6s/GZeDW0KGqOLqak6pH6
         vcER/yR77fsBwjMmEo5E6WugXHxSkbK0gRbnml211CHOyWG0Fx+tVLP07fjYDFVO6Qim
         25V7eS6KfLRDl106PkmJdncPCcR1PTEmidqk3mjaS/ggoe869ELFKrIwjrlcJpOI5hrE
         4SRwHicZx6qaFmaCmAHU5I5gX1jPTii/a7t0+p8tKWfALRLBFsZcCM5SAwE5mDuKxEGa
         c39mY99OHk2VkgwuLTh7rU0JKXBRjYFSYp5SVDWNh/2/uZY3PzaVPMFC7MWGUrJJIeBJ
         Dy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601373; x=1716206173;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVjlWqAdfLnp41PpnyNhWZSZIhghyWvNnJwtCIztyEM=;
        b=OKk62KME8/SNvV4ALejtZzdxbvz5FRw453I+Y2Y3hUVh3AIM4Ifk3fLm3vqRb3Y6xU
         rBIZDKoc1dQlL6ZKbV1bm0nWoN+MKl2Llz9y/BjUXnKy4qK1i4lfs+uvXu3WV3ePnqNQ
         uOQ69u+PSLmIWd4JU4vb+QvJaSzYs0Qd1CZdNX5aHlSSBjxv2ItrR5ewpJ1maPt0eWVV
         rAp451s73rhL6H2NeA7sSraSp2k3OLaRQ7NW9Mf6Dnt0ZrJl7SeirKDbrN0xfFVBP3U7
         3D9UQynp6ywvfGQ3J38707bwfb60QAYp6jMYKk5ElKm+PlVZc6F2jNx5z8sg/xKsu+Ov
         CvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbb14WLsf6G2SJdEu58dj8jgzIfv7YcAnKvz4ZrF5aY+3ftym5zzYOkX7qI7/DOcuGHxza4PZxbIAcuxtpM5ocFJMQViqm0EdKxPjt
X-Gm-Message-State: AOJu0YzVUD1vQ26e/nUUA83aK8V2p7ewwAdJrFbz0MmMOShYdXoX92e4
	J7aE5QgyBXSMee4YXSDMsnIMuOzoEjdGXUOegCpeW4HXLFtUqUdVPhdxYK8835k=
X-Google-Smtp-Source: AGHT+IFgswfetSuy8fSnW1jZdJ739NMwh+RprYAmO4yJuBB3g7hQJgzPn7f9sw3vDrnKs/BAr/2Q8g==
X-Received: by 2002:a05:600c:3b26:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-41feac55f70mr66726895e9.30.1715601373573;
        Mon, 13 May 2024 04:56:13 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm154180975e9.29.2024.05.13.04.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 04:56:13 -0700 (PDT)
Date: Mon, 13 May 2024 19:56:05 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Justin Sanders <justin@coraid.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Kirill Korotaev <dev@openvz.org>,
	Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240513115605.GE4433@linux-l9pv.suse>
References: <20240410134858.6313-1-jlee@suse.com>
 <11361de9-b145-41c0-8d5e-5312cd710124@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11361de9-b145-41c0-8d5e-5312cd710124@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Markus,

Thanks for your review! I will send v2 patch.

Joey Lee

On Tue, Apr 30, 2024 at 06:16:00PM +0200, Markus Elfring wrote:
> > For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
> …
> 
> Please add a subject for the mentioned commit hash.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n99
> 
> 
> > This patch adds dev_hold() to those functions and also uses dev_put()
> > when the skb_clone() returns NULL.
> 
> Please improve this change description with a corresponding imperative wording.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n94
> 
> 
> …
> > Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
> > aoecmd_cfg_pkts")
> 
> I suggest to omit a line break for this tag.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc6#n145
> 
> 
> …
> > +++ b/drivers/block/aoe/aoecmd.c
> …
> > @@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
> >  		__skb_queue_head_init(&queue);
> >  		__skb_queue_tail(&queue, skb);
> >  		aoenet_xmit(&queue);
> > -	}
> > +	} else
> > +		dev_put(f->t->ifp->nd);
> >  	return 1;
> >  }
> >
> …
> > @@ -617,7 +622,8 @@ probe(struct aoetgt *t)
> >  		__skb_queue_head_init(&queue);
> >  		__skb_queue_tail(&queue, skb);
> >  		aoenet_xmit(&queue);
> > -	}
> > +	} else
> > +		dev_put(f->t->ifp->nd);
> >  }
> >
> >  static long
> …
> 
> Should curly brackets be used for both if branches in these function implementations?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.9-rc6#n213
> 
> Regards,
> Markus

