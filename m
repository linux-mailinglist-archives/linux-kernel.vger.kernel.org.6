Return-Path: <linux-kernel+bounces-323728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EC974291
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E251F27F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE21A38C1;
	Tue, 10 Sep 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA/0Irf5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350D1A4E70
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994033; cv=none; b=uO7WljsHQCXSNs/S0CyGNzCKypPOB3FnMoCn/779K/GDX13K6xJOe1hmbWkA1e41xsGk7tSgDCn6xRDilC6HLPQCdvPi+u5h7DETyXVrBlO/PHqLRAgYviiITjYITIgn+ex+cLcpyrrO3zZRQ2wIzkHH5WYVPCDKgNYtmjgL2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994033; c=relaxed/simple;
	bh=y6+jU1nkaFCJb5CtmFh3MI53xVH1yh3eKGITi0k/9LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiTyKA8pV8r9Kun/ig/+v8sjHU5IN8+Seij0lMFFrmzI3YRvD2JJLccGn18b1y5zutJHo7cycE9y0gSGtq0vnyJD5fNqzn2loXUekgfhOhNkt6VsTmEnJc2efOWI9cgmbT2oIJkbsnWQVOIIZoEyD499FrMqqT639eBbdlvmXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UA/0Irf5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso2663691a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994030; x=1726598830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=UA/0Irf5PNDvUjNfUDp/LeDjPLXggt04owx0ZQhNxMoJkyEqPWTStGRzlHYDAf3JG0
         LomLct0D2dtjx0xKJ72BZTez2lmu5t/r6o0nDKwZ7vGQGOMecKdStsCOq/UGdJSbdyjb
         UhZ66DfcjKEC1kdeFJrVYmb1qU3HOngwnWGPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994030; x=1726598830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPcgYLqFkVUYW17im6jAp29G4Hv8TcuOuscbjSMgOgo=;
        b=Th75JsFcWFFchWVQzECjrlvUdfNwG0gFBd9LhM2k9ma1QuCrNMrJacq2kNBzpzLeko
         py/4J1ijN5yJxE4Gq+aFj4KMEYKZASWKQzoHpaIs0a1PigV5ZZBDFDFvmbKnTkYuz9n9
         83dXFoUCWinR4Pli9fj3hhoBZ7vLGKI3Slau7fTS1qqGME2wwYZcEQJf4oZmWOAyjJFb
         /xV9hcN4RYR3fa8RxXy938Ts1Vma01060fy28n1aE7ryG3BFACQjSb/cnyOB2gtEe5GN
         8HatEorIfIRu/XNr420vUcs9LAc1/WaVcISBqOCK2tB3Q6quT+xuJuzV5fk/HgmqCOir
         4uCA==
X-Forwarded-Encrypted: i=1; AJvYcCX0bamIA+0J7WdlCASYs+OikosFZsSr25JlTRkp1ZJG8vme60+4mOyuCnqQd42ikJcQsTjeeQFw8SBBjvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1uDuIxETDrfERwu1W6jBLyQ/k5Vm+rvNBytvKwrAW8s0tc9D
	369KeQl6xQFig4W1ztGI5ZjoyKxYfW194FT3M5FzfJF8BRrz5+44VupPtBGSkIkWyZALdDUls8u
	/5NJ/0A==
X-Google-Smtp-Source: AGHT+IHlc0I3mZxl/FihQnfU2JjKkQtLz3wgVZ10g6yuFvit6dpUuxpR1DU0FAFqHvYsjQ5YalRrrA==
X-Received: by 2002:a05:6402:3514:b0:5c2:5f43:3e8 with SMTP id 4fb4d7f45d1cf-5c3dc78a886mr15739274a12.9.1725994029498;
        Tue, 10 Sep 2024 11:47:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467a7sm4489190a12.28.2024.09.10.11.47.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:47:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso2663647a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:47:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxpQ85UvM4vXszSaO6+MS5cP0nB1aJUD8B0fRI08620q2t/NmSRPhYymg8HKtZSOISf79VfvGTFUcRt8U=@vger.kernel.org
X-Received: by 2002:a05:6402:26c9:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c3dc78b469mr11458506a12.11.1725994026812; Tue, 10 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org> <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org> <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
In-Reply-To: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 10 Sep 2024 11:46:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Message-ID: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jens Axboe <axboe@kernel.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org, cassel@kernel.org, 
	handan.babu@oracle.com, djwong@kernel.org, 
	Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 11:38, Jens Axboe <axboe@kernel.dk> wrote:
>
> Curious, does your init scripts attempt to load a modular scheduler
> for your root drive?

Ahh, that sounds more likely than my idea.

               Linus

