Return-Path: <linux-kernel+bounces-386473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18F9B43E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B8E282416
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9320370C;
	Tue, 29 Oct 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6KJX1DQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5B4C6E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189555; cv=none; b=HkWGrhOFrWW85vBcX45gnxyZOOg0Ib3PtANtI1lXdAbY3b+V8ceakOLwrYkc8mNbCak7PyWZssB6CLXzLZAN090jTrrTpP2oPnSx8Nemetl0KP/ygnwlJq396Raz1/ny9xaPXpJfEHPNwQHDxk+se7m/9oNIPxz9+/mlhi0YHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189555; c=relaxed/simple;
	bh=L61YEgx/lo9JZKB73OERoCqdxQb3RDZR5YshtpqNrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptDRFmYxu96XbV9KiiaX36mUPPNOgnrnfbscJOwg8O71TWN7xs5E439b1gt5upvqn3vOdL14Eu25+KUMCxt4Y+my1Lb8NKvGlkc+mAJYK06Ia0KE2LkSQBo5YyIiT84RlfIvxKJfuLZ6Gx3Dtk3f/d8QwlA7AFagBelk9b8e7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6KJX1DQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86e9db75b9so767255166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730189551; x=1730794351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HakSva0I9pwaUyWDMav2cQ/m5Vq/WsZqCAl3dC4haeg=;
        b=M6KJX1DQ1lTmbOxf9FbG5oRrumhea0DCglwWYe1hHV43jxHfpnD9bVxwh/OmbxIIDp
         iGFSXwGu+ZYWGimnP/4JF+EQ1u0lSdK8rjIFobyOVv2uaxeyoneamb72KD1FQP/JwldO
         fc/qGPHotWQTfmEtFPSHpLeq7coigAHSwMjdyQi1VbC4rhyB8XDJHnXbEuRqVjrrefM7
         /cqZdUR20DHooS7fmNd76jmIqgjQSHtgvkPGFsb5HF3J1IKf6zZTNhGVg4jHr3GZ2Jdb
         o3kmWANHoo7tgxxMiOU117m3clZ3gRc1x8DCH0sISeSDXsKHy5t1uJMEHdroN5tVaEL5
         aTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189552; x=1730794352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HakSva0I9pwaUyWDMav2cQ/m5Vq/WsZqCAl3dC4haeg=;
        b=O0My4AMQiD7wDgr3t9QNErEKMsYdJrsHxtIA52ziQTgv+IoLkdKyc5AT4SdMM/LsA2
         Iok/jG3GMYxjkuUlSlIBYmEjdfbKp6Y9nn06m/RtiGlvtfDCcf6v9aNykSsNfW1/SEe3
         FlYsV/vLSn5Y+WgSggEoPYuAV26oj6EPbn++M65fpbmuu5ZZ/94HmwYMQwPtcu5KrlrE
         4hBbJ9JNlBcLeIxDU8/q7BKiVNpvp8/YsscRfFBSujVITRgXrF+fpQNrKJ6b5NtL3bE1
         /YU15eJJm0dxIV7dpR/R54ORQBvkeBgfKTlD+V+BMNPu9DLaVIMZCGWEhhNLIgp99mFy
         sexw==
X-Forwarded-Encrypted: i=1; AJvYcCUTM42Ih4rT/YDyCRLdb0tDaoyUxn+XYvQRuxSMIJduWBE560DlPxzd/DgtHM0piz0jdCRZuS5gDx/ON5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RuH/K27aMOv9jBYHqoojRmbK49bUfPzmV9PlNdhlyiWbHEEh
	wYAU7iooFvdDc/OZIf2Dj+/t4CLSEOJ4+UbblRuc0UZ9tZbNkVLr5ANmpMN66Po=
X-Google-Smtp-Source: AGHT+IHEeefsSzqeEql5jjfjKyH3oJc+6dvCePlapfnGvC0uikLE2N/GI77Z8Uwy47h2ONHKBhgQiA==
X-Received: by 2002:a17:907:980f:b0:a9a:46f5:d6d7 with SMTP id a640c23a62f3a-a9de5c92bcbmr1203699066b.5.1730189551541;
        Tue, 29 Oct 2024 01:12:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08906dsm441345266b.209.2024.10.29.01.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:12:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:12:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philip Li <philip.li@intel.com>
Cc: Matthew Sakai <msakai@redhat.com>, oe-kbuild@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn:
 inconsistent returns '&pool->lock'.
Message-ID: <ba8d1a6f-1b4a-4ce2-a426-ce8de23f20b6@stanley.mountain>
References: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
 <f074f848-5a26-473b-ae98-1932e9a8cbd1@redhat.com>
 <ZyBQa45RTWXiXJke@rli9-mobl>
 <ZyCLo51ZyjxX7eQK@rli9-mobl>
 <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13937d22-46ac-480a-8956-f89a0fd295ac@stanley.mountain>

On Tue, Oct 29, 2024 at 11:07:07AM +0300, Dan Carpenter wrote:
> On Tue, Oct 29, 2024 at 03:15:47PM +0800, Philip Li wrote:
> > On Tue, Oct 29, 2024 at 11:03:07AM +0800, Philip Li wrote:
> > > On Mon, Oct 28, 2024 at 07:00:40PM -0400, Matthew Sakai wrote:
> > > > This should be addressed upstream by commit
> > > > 872564c501b72ae0c84af51084753e8652e4a84b ("dm vdo data-vio: silence sparse
> > > > warnings about locking context imbalances")
> > > > 
> > > > That commit is from February. Would it be possible for these checks to use a
> > > > more up-to-date version of the code before warning us about things that have
> > > > already been addressed?
> > > 
> > > Sorry about this Matt, the bot side will check why this happens and fix
> > > the issue asap to avoid meaningless report.
> > 
> > Hi Matt and Dan, would you mind do a further check of this, per the re-test,
> > smatch warns as below on v6.12-rc3
> > 
> > 	drivers/md/dm-vdo/data-vio.c:982 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.
> > 	  Locked on  : 972,977
> > 	  Unlocked on: 982
> > 
> > The corresponding code of drivers/md/dm-vdo/data-vio.c is below
> > 
> 
> Ah.  Right.
> 
> The cross function DB doesn't scale well enough for the zero day bot to use so
> it didn't detect the fix.  If we had the cross function DB then that silences
> the warning.
> 
> 1) I re-wrote the locking check so it detected this bug where before it didn't.
> 2) The kbuild bot was using the new check on old code because Matthew Sakai
>    did a branch based on 8 month old code.

That's not it, is it...  The branch was based on the latest code, and the
kbuild-bot bisected it back to 8 months ago and it happened to be right.

Anyway, it's a rare coincidence.

regards,
dan carpenter


