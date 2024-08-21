Return-Path: <linux-kernel+bounces-295940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA7A95A34A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A271F22F72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56D1AF4E0;
	Wed, 21 Aug 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhKKFw8q"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A001B252B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259457; cv=none; b=azWfFa6nRqT29ZuQTVWgk+zvwz2lp+uCjgnt80bSyeb8GvM9jVxZ095+d1HiI+TAedonABHqYvEKeINqQjHlqbJjsalW2yzapF2y687HZ7sjqUzYeJtkGHAfxuBH/H0gtEyWTLsujpnq+86kwsGh6ADBKdLyptLT5LRDyXGl700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259457; c=relaxed/simple;
	bh=8dxUiMbarxNSVN10VLkH2aAuHmJ9HwiMdn+T4yhOlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU+e0HOVCFj45hdDv25oZbw6aOKlEO6D0txEjfdKAXmz7Pj+2XpcysU5soGvfeN9Xf9PMnnt/akwkN3sFG5QD85veoLiK77DZT7oMumS+bD9AmuLcSqNsIMSUU3F7ar0iU2Aqch2k7LWeGe6kzWY4iX3W14OXWAqgIUmKOF9jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DhKKFw8q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso10491586a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724259454; x=1724864254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dxUiMbarxNSVN10VLkH2aAuHmJ9HwiMdn+T4yhOlRM=;
        b=DhKKFw8qnTpe0bh+wNzz8+H4snJMVnRlKYJhpPPu0pMpkz8K4S3JlRm0ztgJ/gr5/X
         NR9ODTD6HzO89tE7SVNI2D9DxxaClAPEA5LQ1a5IPwVit5xIDHEKDoUJqbbJxu/hOhBy
         nyaHo1BePKC4l8DeYuel2T4R552PIWFGaB4YtapYD0l1R436cyM+dB6dxgqRth0BnXLY
         enZnLubFCksWt0eEQyVM/HkYMDMezlj5ZKTjiwbYo2RIcx9QtiHWdbZOHSe9LUTlD1yO
         0HQugxCMXXedtIskinzdYk5EAhrYUOvcbBt8ayRYYY6bqU0P6tvjTubvLJUAlOHUk9Av
         0WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259454; x=1724864254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxUiMbarxNSVN10VLkH2aAuHmJ9HwiMdn+T4yhOlRM=;
        b=FxOyJmHCqNFSJlWMgTm1ysT8GiLoZxFD3/rO6QCtEzJnQYPeoE8bb37omokUQgflMW
         PLYMTbajmIMyV3hZVQpOHZ2n0OZBlMETgR6OAWasSZ2gwdghYm81xBkY4Bt1IRPg+v24
         QuLVKILwzfS0L1kLBUPSoldhpb4AoUwyBrAUfqfde2gL+//dpnzWEC4yxjLVE73fds1o
         YPWVh++c0YcFrwJTo/ce1I8xoW18dzs8mb4Dy8oJKb8BQaGVd3d2+zhlRL3WMD2efado
         E/CT3dZ5cgJb7l+id5k4cpCM3V8PED9dRx/j4qNq9QPPVFStNB00wqAB2XQshVNyvqsA
         1B/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4sBgBUCbvZMcUk67Rbmyfn4nptX/IJOG2HMr8BgrVNwhG4Pao9R84iCWDXmq53qeEps/eeeBROYeVDzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfNS70la1GHlRhZJ66WZdynCc2dLDeWIEiFU2P3HrBAw1N2s0
	YtNpFxYbnkXWHX/HjGNxcWFglXf3JdPC719Iu52SA0D65kzyxONdjZpm0hSYdFvbj1I+WPN42ni
	t
X-Google-Smtp-Source: AGHT+IEvEJ+EPt++NBzDRQ1STaWyB4ha5i5KFCyltbx7A+Qakg/N+wGXZU6wDYDHjsP0+lCshxd56g==
X-Received: by 2002:a17:907:c7da:b0:a6f:1036:98cf with SMTP id a640c23a62f3a-a866f70379dmr227543066b.54.1724259454196;
        Wed, 21 Aug 2024 09:57:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a867babbe22sm92810466b.183.2024.08.21.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:57:34 -0700 (PDT)
Date: Wed, 21 Aug 2024 19:57:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]The patch fixes the following warning generated by
 running the
Message-ID: <df837873-f422-462b-8a88-25c02d4f8cf4@stanley.mountain>
References: <20240821161539.541062-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821161539.541062-1-sayyad.abid16@gmail.com>

Also the subject is not in the correct format.

regards,
dan carpenter


