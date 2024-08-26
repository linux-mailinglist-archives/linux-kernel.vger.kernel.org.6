Return-Path: <linux-kernel+bounces-301415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F695F046
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC21C21570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48C149018;
	Mon, 26 Aug 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AwhBIz1F"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8214B08E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673579; cv=none; b=C2DV4eb6/wNR9vXHFgVPEhEcIJtETZy96BiPulxEkGPc7z2ZMyyFcCzIaOOP3UiPwsHhkI8+oRXh9XKpUltZfYVAXE0naxISasY/YK3wQ05fp+LM2JRqcTSy2rmHrrR9+OBN9WXLVrghIL68NZHP06F5pG82XQgCrDGtNEPNsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673579; c=relaxed/simple;
	bh=2Gc4rUT89+kCaOVxsaKCmlkj9zfal6pMrdwtwEvIMKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB4K9vqt2pZKQ2iL/E3Zudc2eBnT46dtpqs8DczoN70ngy1BF6veFmrSzpSKYMDXderOn4I9TGANeyWol6L5aXAmKW9TY1XGwQt6sAGMUGhItTmiaBQksLg0hvMBbXlw4k7qtLC6wDX3Z2bel0cWoz0KnjS8D3FbuwlIl6ZpWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AwhBIz1F; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so5475286a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724673576; x=1725278376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ataFHi6wYyiiD9cTzzrRwByuJhJC70WggWtUT9kwKg=;
        b=AwhBIz1FCTyOlrdQk960BhhbgpbKvtxRP0gzAuTJS6ubTU/2h6b114P2zfIk/I3KFp
         YPjLUgu4miLcqpxyCppSSv05uzWQSqUdgEKKQbBo7OMEHG+lFNt6xkKIJngXRleicS/H
         auFk7/YT+6JUtD0uKlZfUiAUv6WVSD8SahfmFXRbojzPyWyl+nXiz9Z93GJw4JaQY7rj
         GOEDLkKS14oB7holt+fxW5EMjlCDaKI+hskhdr1OEd5Q5LC2Wj3rEhtSPn1yLxOEqti5
         /zb5UlayyCKORV9k3S/J43BBBz1UDqnprM34yZ6imtcAqn8Ax+lAL6efifqTIcEr+UHu
         LwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673576; x=1725278376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ataFHi6wYyiiD9cTzzrRwByuJhJC70WggWtUT9kwKg=;
        b=eUiCvy8n8qd+nyeafGA45XbDcFbcxGvQAypxRTj9BgphtD0uZEQfaTY+7eCsBQc3Mp
         eoH3DYrFNghmKTTqRA9Q6AYPYJNtXYEeR21CR6LMm5sX++OL1m4gFlYZVQY/DAQ9XCmW
         Z7UBitUic1QcWZLMWjFBiU0zNm4LW9Heak/Qs0lOwhcGzoKrWcVnSQBBBv1cI+Kqcv+7
         4ACHJSl9jqfKmK1E/6T0b56NSIRy36QLNSjryWaV5J7/QonDtR+YtU/4L6hYRoHXXxVp
         FUGG9EkSVvQVlZvv3fk5HR2c7QHJOozyVqIW5PEXQmUsj1+fx/WwD7weTk6yitf5K2ff
         PRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5LsOd+EQjF7A1exNx4f87iC2Gg8lV3aC98jGXvxyVYFaOKuegdWEExvC7p0LhMKc8E06qUS/D2mH81rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1uyB87C4/ywzT9frz8FeUrGahmM2UdtS8AbvvLDuOy7EGJem
	d4YFUBfijKPv8jWYyBFOTYTFE66qpGgFX21KM6r8kvacCpTSYLVr0nBnJfXG/Cg=
X-Google-Smtp-Source: AGHT+IHJapUjUiMqfFgXQZN7btLnjR8mKnVNx99urgJ6GEY0QbCn3ebax3APSaYwnptj7nqVrP4y5g==
X-Received: by 2002:a05:6402:2754:b0:5c0:a9ae:d333 with SMTP id 4fb4d7f45d1cf-5c0a9aed520mr1578615a12.37.1724673576168;
        Mon, 26 Aug 2024 04:59:36 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a91afsm5529770a12.93.2024.08.26.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:59:35 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:59:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JoshuaHahnjoshua.hahn6@gmail.com
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	shuah@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] Exposing nice CPU usage to userspace
Message-ID: <tpqxx4hk45qkbt5e7sb3jlomfcqt5ickbor5gmclvbqxbrngp6@yqltckvwce3z>
References: <20240823201317.156379-1-joshua.hahn6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823201317.156379-1-joshua.hahn6@gmail.com>

Hello.

On Fri, Aug 23, 2024 at 01:05:16PM GMT, JoshuaHahnjoshua.hahn6@gmail.com wrote:
> Niced CPU usage is a metric reported in host-level /proc/stat, but is
> not reported in cgroup-level statistics in cpu.stat. However, when a
> host contains multiple tasks across different workloads, it becomes
> difficult to gauage how much of the task is being spent on niced
> processes based on /proc/stat alone, since host-level metrics do not
> provide this cgroup-level granularity.

The difference between the two metrics is in cputime.c:
        index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;

> Exposing this metric will allow load balancers to correctly probe the
> niced CPU metric for each workload, and make more informed decisions
> when directing higher priority tasks.

How would this work? (E.g. if too little nice time -> reduce priority
of high prio tasks?)

Thanks,
Michal

