Return-Path: <linux-kernel+bounces-255766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD59344DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F9C1F2239A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D285381B;
	Wed, 17 Jul 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mvTtJLVV"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C818EBF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256182; cv=none; b=pIM9jrVeHKno3wd2AX9sBIJiEzgnZoM1jiVJDsBb6k8ipbjXBhUxx3ZJQb10Nu0LYsEodjAO0zmqhPB8WKKazOgUwCu3WrEpJZ2hL69D6lmdndGAiMWezlI8yVSK1xMkmLbPRjlm/vYDmn0uBJ//9hRb/6KUmM2M5vSKQSZqMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256182; c=relaxed/simple;
	bh=4LKJAGaHGvPNEZ9UvqrJxcaNnxkVxqT67rRUgPNfpus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8b4biW+b8F9Shahtdw/P8/wy0UualIwl6oAL3T66H6wkuDvkyHvATN+exztY9lmQeBAt72LxpjpHu4otkW9XunBWNv6iYk/NFSyxEiByHq5RsHNQqizk3yJqFOx9S1OqoY7YzgBoERw3bg3z9NTP78ZJzwp4EM6Xr460IyoTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mvTtJLVV; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso123834b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721256180; x=1721860980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LKJAGaHGvPNEZ9UvqrJxcaNnxkVxqT67rRUgPNfpus=;
        b=mvTtJLVV0i49SKUEIaUzBzKxhsRXx+HgsT/sXmUeWh48+gMQ874GcdMe4BKo8P+gpM
         /tplFyf8BdsOfdXPetg+iPtEWhiX1Oz0NwBVGRVZ32mRxbjakecvmXOCe1AuwtfYViOE
         Mbw5zBxjIpZ6tS8dSwORQ6CZ+bt2dpM4Tk/0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256180; x=1721860980;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LKJAGaHGvPNEZ9UvqrJxcaNnxkVxqT67rRUgPNfpus=;
        b=K4jNCVllPfTa3twPxeuf7NlIiDbzhywFXb8SgvTIO/zno7gQeh4G7y4mHiv8y7MSdF
         631UM4G4aP9wHG3hgzHMoUGXjCcs6zAzhKso3Z1m3P4pgxPwDOOn2+p/+eEcw4r03bSq
         iVuYrDiS+IkpejUspSP3ldaE+Zx5TlawDJkzBMP9x/QEgD/9cxUiwvdFEIyMKZQ8LlWA
         9aHWKbWaC7mb3GvMtcN9Pj1pnwSm3NYGaOsw/dJ7qmGkKZNJ7csc8jkwffgS4SNWAQTs
         3Z0AS27SKIhM0G8NoBnPtJ29Q/I583Ds1lN4nh9z637XeUiy2ExWQXQHdkC5k4Ov8MkV
         608w==
X-Forwarded-Encrypted: i=1; AJvYcCUNJ0rxRswcF3lk+UNPnBjv8sN5iJTxmTq2+ZXjzo/x0UzYfqFGBxS3Z/drLdsr1i7I3vVAoebc9P9DAdAtWFNbJc3j1TmfXGDdA1rW
X-Gm-Message-State: AOJu0YwItdIwVm4qHqQ9EAapYiiecGdv3WGEDnoaVyS+dK6uRZ3Ye2F5
	T/ydXdu1clYElr4kGcZTy/QM6qAI1WodMjruJkmqRxM4kGJkuR8Gg9Nfs2pDFl0=
X-Google-Smtp-Source: AGHT+IHvVu7dD6e39qfjBq4LcOCOSqjRIbhJfaT0GnWVja/LKd3zcb6HhdQrirpi7Bj58JS1y/2PyA==
X-Received: by 2002:a05:6808:bd6:b0:3da:aba0:8255 with SMTP id 5614622812f47-3dad1f34478mr3569237b6e.16.1721256180529;
        Wed, 17 Jul 2024 15:43:00 -0700 (PDT)
Received: from LQ3V64L9R2 ([2600:381:d627:95eb:19b4:6e7a:6e37:ba63])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dad5297a26sm221670b6e.40.2024.07.17.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:43:00 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:42:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: James Tucker <jftucker@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: uapi: add TCPI_OPT_NODELAY to tcp_info
Message-ID: <ZphI8Z89iLe3ksVP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	James Tucker <jftucker@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>

Hi:

FYI new features should be sent with net-next in the subject line
(e.g. [PATCH net-next])

On Wed, Jul 17, 2024 at 03:22:14PM -0700, James Tucker wrote:
> Nagle's algorithm is one of the classic causes of poor performance for
> certain classes of userspace software over TCP, but is currently not
> reported in userspace tools such as ss(1) from iproute2 as it is only
> observable via getsockopt.

Commit messages should be written in imperative mood.

Thanks,
Joe

