Return-Path: <linux-kernel+bounces-211119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A42D904D57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E21C22110
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CD16C847;
	Wed, 12 Jun 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WCd1yQzN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC04C63
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179249; cv=none; b=XbmbRdkweNfjOU1b8505honVPJplbzdm+bgO9J8T3FcBSUuO4F5dcD0lcKpjspzUCLbHfq3D7QcQ9Dc1bNyA8Xe+ThuWAiu2IuuhBHDrMPER97SNEEM6o7Ca81s7DZTUU19rAuyVHGgRW9lTmfexIVJVXS4HoxCJbcWXAR3YMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179249; c=relaxed/simple;
	bh=Iye8NbZSQ6kLwre3fp7X6/PawuNxoVKqvT377JMBMRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7Lyr9uilP/UPLlyjNMBu8mAmJHx2264sf0Sl0QjVZnF3kkwiGX0+LNsXahQoIbfAWDRvaK2kR2K21/uNXK/Ejbua+D+vWWEm36mKai5sOh8QaKH5A19HRz0UgFAYGlXq2CuVep89iFa4msOWJmJcWGPkyTdzFI4tIGaTD7aqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WCd1yQzN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f1c4800easo384937666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718179245; x=1718784045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wcRVW/nhW18asiOmcxYMI52nKc1Lau2tgBza0fWM8k=;
        b=WCd1yQzNAYSGRY5yoZmDG0Ys/l/UB7zu3NtU7wYnfwloPUHO2DDCkcrQxGt9ibExKz
         vQa4YWDbibA9ox4t9v/vOuHs4AsPWcvb3UxxADMMbY2eaF1gDbvMvSiQndF5PwzLItbQ
         MkiJmguaTYizyWPfmRbgA7hl1tY7zZozK+aNI+LnbS0WAhiqQPpos8oLbYuEOrf8Zqne
         NCdl1pUqEQoJKWUXrTVsSojV5114pEQ1I02PP3KJ7JwenhivrgvcOyx6X3vHBXYGpv5r
         NrMIIBZu8LZNUAmQy6WMhiPdTIfJZZSSeE0aPQdQd1tNQZWMuSt3kHcfzgCATMg9jbkg
         dHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179245; x=1718784045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wcRVW/nhW18asiOmcxYMI52nKc1Lau2tgBza0fWM8k=;
        b=Hk4Q3GYffVXq3DGVtVEauuH9fiyXjoKwyQImLuvVQuGO2yw2Vz6Wk6poqa/FqU0+nP
         J+PhHGCR8PFARvGvqlkX+R17DnIhuhkwdil/kISWsmr2r4EgHTEpTVfbTeXJe3UqZneS
         QyOvDpnj1jMtXbOLdjmOFFBysj2/2WJxshztqAalZLpb1fxKYlrjhF6bX9bxAjVazmcw
         DLdfLbJd7XbilvK+jpFI7RB4Bf+1150phcjlJkx8138OHRB6RBUi6nVr3jwbsTR7kKYC
         Q6gFYA/xeis7yLosbKLRedz/UWFMjmNcNvxIaiaZpBNPOyI6Y1yKKpquBp4UPqBfNvW+
         OJKg==
X-Forwarded-Encrypted: i=1; AJvYcCX8R1rdTHT9ak4ODIxs/8BRquLcxXrB7DSgoBdH8vipTog3ldCpEwopYtjgm602JKDrPuAO7YJ1UMAreP8/2McsP3bPPJ3RAaInNkin
X-Gm-Message-State: AOJu0Yy86jjItVmaX6ntwog/Lx0HzEj820N1fcW7qNl9o/8AzoEM20D0
	RzP12DweMUJfYGwuiUMvZymxVFb94X6mZodeHwSN+WIMSK3QQZXLYc0EN5k9sK4=
X-Google-Smtp-Source: AGHT+IGRFholVNe/4JMsUiq5frRKGJ1K2M3+HujTTgz1BQSdVdgGDoBmuhS1E15RnAK9dM3I9sdihA==
X-Received: by 2002:a17:906:55cf:b0:a6f:e55:ba1d with SMTP id a640c23a62f3a-a6f47d1e186mr58094966b.11.1718179245217;
        Wed, 12 Jun 2024 01:00:45 -0700 (PDT)
Received: from ?IPV6:2001:a61:138e:201:27e2:fe9:90b9:6b9a? ([2001:a61:138e:201:27e2:fe9:90b9:6b9a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef7913eb8sm626424566b.178.2024.06.12.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:00:45 -0700 (PDT)
Message-ID: <378bad75-dfc7-4462-8fbc-a462e129a0ea@suse.com>
Date: Wed, 12 Jun 2024 10:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB Denial Of Service
To: Alan Stern <stern@rowland.harvard.edu>,
 Greg KH <gregkh@linuxfoundation.org>, Oliver Neukum <oneukum@suse.com>
Cc: USB mailing list <linux-usb@vger.kernel.org>,
 Kernel development list <linux-kernel@vger.kernel.org>
References: <40dfa45b-5f21-4eef-a8c1-51a2f320e267@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <40dfa45b-5f21-4eef-a8c1-51a2f320e267@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 16:35, Alan Stern wrote:
> Greg, Oliver, or anyone else:
> 
> Questions:
> 
> If a broken or malicious device causes a USB class driver to add a
> thousand (or more) error messages per second to the kernel log,
> indefinitely, would that be considered a form of DOS?

Yes.

> Should the driver be fixed?

If a broken device can do that, definitely.

> What is an acceptable rate for an unending stream of error messages?
> Once a second?  Once a minute?

Definitely not once a second. I'd be tempted to call a neverending stream
an issue by itself. The approach the SCSI layer takes by giving up on
a device if all else fails seems wise to me.
  
> At what point should the driver give up and stop trying to communicate
> with the device?

I would propose after five cycles of all error handling.

The exact number, as long as it is greater than 1 and a small integer
does not really matter, as long as it exists.

	Regards
		Oliver

