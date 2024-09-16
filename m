Return-Path: <linux-kernel+bounces-330421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05D979E61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FAA282AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62ED14A4D1;
	Mon, 16 Sep 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VmzdLf7H"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB614900B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478623; cv=none; b=RDUZtpLxctcEGBRyaM5nD5syr0aBzF/K5yhDmGgyDhSrHmPFS6fWWWgyHiJ57RqN2JUZbZUff8DI0j53EfwqGRbvIDnNuspKGr7ChPOfzlx3XhFVHv58yK9bfF0LFWMLCzSlLjFZzUrcF8tn/rWlXogbeueZm0kREXHIoxw6ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478623; c=relaxed/simple;
	bh=5FsEHtEj/NvtQYRLA0oR0Szlqlbhk2HL9IujoJ2r9E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZKFbZbRyUPK17+KM+oxH4ehbcfF20Lo4hPjfvKUmKrUpAEiGga0ZxrcznsuBwHzb4iSHv+Cy0Edl2F+fylU1unjJHjqGT+iOdXRZiSJ1Q14bUlRYjWPf0SIuYH/ZkMvlC+GobY9LZzqJifxBeWGwfWCtFAadFA/LXQf79qeeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VmzdLf7H; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso46023311fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726478619; x=1727083419; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUaMYwgpZ2Ku5tNMW6Im6QjDbcaD3sCpWLaYf5Q5iVI=;
        b=VmzdLf7HYzzt2QNbs0PoXYk7LxpCYulktAr3pEOL2AitOoSuDJPps99ooGxlNmaJ91
         t2I1QlMjHefaK7VNMjRZIGDyfZljXKE7NE6914JzR1u3tKJuW2G4zxmWTerPZvePYiOx
         VqZpB3wWmdKj9cPY0TGay40aklkIwBFEgC0ra5U+wJR5dsaHwDcAyEMTlx/YgqgdbLC6
         AX2Mp2k77w79ANlDObNrAnGPg4ApG57j1MQBObiJaqFypJdaqJW1R+LAp+q023Rj/aZQ
         TpHdIWLY5uqjX1bLp3C6e63G9MIkYI/zLn5ZAWiK6DAdR95smz/2F8Z56VdYmN3WJig+
         SL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478619; x=1727083419;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUaMYwgpZ2Ku5tNMW6Im6QjDbcaD3sCpWLaYf5Q5iVI=;
        b=HoJZ3Y9UffTKaFH8QtTSBtCFMoEfA4ls/jw3VIcJ1hWjqylhReM2ZiCM3vHrkle9pw
         mgwZ/Zv/e5GyRXeI89Ss9lUYn9yERwAQbKp/9kq4Y1w4JzD9fBXL18KbNnhVRBzRUJos
         qTsTGN6uII1sXsi5z1UjlyPlDFLdPICHCreM5S3KBs6Bxz7asRQdgs5TOIkrEiOcpVLk
         OE2UF+TNvfrbcOOp90KJDfKwvh6Q/ion8iN21AEqecwCNkAGKPhpX+pIifcOajuApIWS
         ZQxUf8xdUW/sUzjQIEuxBIwRTWTPBRH2XhkFdJfvsAcIMO54EVfY7iOtQNCgYiZHJFuz
         DY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIcTD2LoAb7wGpECKNRwIum+fUY90c0Whw0JrBbmpuRDfD9bXvzcgWFMaZw6sOPiIkrv7L+Arpa+0w9F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48ssBmUnki5hn5YMln1iybNNbXIDy7B37hRdNnJVCpNBZg0pt
	/fXEocUv0fVjVWo32gkTKHZD2HBO1u0iZ/7Bn3oxHx0TExITlO/uURccxSxevXY=
X-Google-Smtp-Source: AGHT+IH2cZxToR1Mm2fvGCS6avu+/Woqny9ILHMW+m489L3DnVmBj/IMWkXo2pwKbd0ZCc3idTj8qA==
X-Received: by 2002:a2e:be22:0:b0:2f6:63d1:166e with SMTP id 38308e7fff4ca-2f787da0b93mr79504571fa.3.1726478618471;
        Mon, 16 Sep 2024 02:23:38 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fcb77sm32659395ad.209.2024.09.16.02.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2024 02:23:37 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:23:33 +0800
From: joeyli <jlee@suse.com>
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240916092333.GF3296@linux-l9pv.suse>
References: <20240912102935.31442-1-jlee@suse.com>
 <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Valentin,

On Thu, Sep 12, 2024 at 12:58:46PM +0200, Valentin Kleibel wrote:
> > Then Nicolai Stange found more places in aoe have potential use-after-free
> > problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> > and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> > packet to tx queue. So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> 
> We've tested your patch on our servers and ran into an issue.
> With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting
> indefinetly on one core) that can be "fixed" by running aoe-revalidate on
> that device.
> 
> Additionally when trying to shut down the system we see the message:
> unregister_netdevice: waiting for XXX to become free. Usage Count = XXXXX
> on aoe devices with a usage count somewhere in the millions.
> This has been the same as without the patch, i assume the fix is still
> incomplete.
>

Thanks for your testing! I will look into it and reproduce issue again for
improvement. 

Joey Lee

