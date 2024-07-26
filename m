Return-Path: <linux-kernel+bounces-263459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4593D63F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC521F23A59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB017BB0E;
	Fri, 26 Jul 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CyS4mZsU"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1542225D9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008352; cv=none; b=QB2bvR9BpbLK7uOx1tdcRrMClqmS7SdTCrM2liSZ7m6cPL0bzXOXYJtWIa7f0b0Yq+h5M5ac6NrqeQZtCAjiHvDExvLXZnDUsZbNIZNWboQ/yK4bVY8Evr4jtsBS6L7YavHeJtCMYsipa9bJZOhJ2ituMNL2Ew0Cbkf9+ztNJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008352; c=relaxed/simple;
	bh=sAxssKMAFh3wj5z5ValFCN6FM/9YkEQtjr/NLO/YYSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHRoUs+eiU6qrJS9vBIdOpwXyreNOz9Weyz/ZyMh83uly6FQFqXTVADnI+jP1010KwLUQ/fP3PxZBZhRshEQZDv0b+LUvQ27AKYqQQtGzGppTmhg9tfW+9T/p5MrgNBzJPVjFOnuttw4bW/Edzlb8jswR3fTJckO6a3HtT1H37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CyS4mZsU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0b111b59dfso2049904276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722008350; x=1722613150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTlYN7qwNIA929u7v0Vi1ftjGFAFw9cUGVs6Wz432jw=;
        b=CyS4mZsUSsAwsdUHGH8xFvPPUav6Fwkud9F66gIwpri9iJU9rKyp7Qi4E57bq+IWt0
         kozKLraGGHwePKoYj2+uTMblV9NpD3GmPo8SHXnSJSE+AETSvyWZnBs6L0HW2a0WqLpt
         QtwmwEujFycIaK2fedOIoIO3d1GMuotGmgYrrfoj8b5RfLjuhZAsVz+yTZmbA91Ef2sl
         0TwveTdU/S8IK4RdLxPwaBbwP/9PERHyQzbdPDDGXCXwqBQaMZjOSZN6DEHaXxi+GUwh
         W6f88tcbsvDAkvVpSmi4IyTzBvVO8VqRcZvr4JjcSzQQCT4PcYh0rinmcz/8QRNx+AzP
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008350; x=1722613150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTlYN7qwNIA929u7v0Vi1ftjGFAFw9cUGVs6Wz432jw=;
        b=M4sQ1SzjFGc8EAhU09+zKN/oI934I91OgSfZ+ZmLZYcxJnbdUlRxMXHvutIoD+0b1N
         MEanpbm89ykI3wb7bAgYyRKvdKiRF9ZIpn7enpuNhI7uKHnXaVgdNt5xvU5C0Oha46Zu
         HMfo7VkfBoHM6W2IS+Rv2vRfY82vF8pTJlHSJzW4xPVP8FSH7gks6ZvXveN/7rPaVKWF
         egs1YxbRG7Tcy/4+cOz5ngITOBLcnxawSBrmCsr+1fQZ+b6LHQjvzFZRiGmDH9UixoI4
         fiUBv9xtYe9t+FqYATkedGMRU0z82ZrQPvlYmyqA+1fK+F39jH0hdTv4Br9kbmH2tTID
         o5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWoTJHht8F/Qdfcrb7b57p+ls0Jdf/+BdKH4C+ORSU0tNKuvdjjeheFvUFNlMciodAYCTZN5Ax9sHt8OtFqd8T0l5FODN2OV0lWgRfc
X-Gm-Message-State: AOJu0YxmE9jwmr6bOl0SNx/YEMOf/yQAlS7oaJDsBRlxWW8D+QwxBZmw
	Fnx8ukscAT45ymKfALf3xFLnDWD99EQHaxivORroDq6j7oWgnf+dtPWKBZgIF7A=
X-Google-Smtp-Source: AGHT+IE1ay+RcFkuxSAz/JO5WDaqi3NilkGfwMA1C1SFVbQCUE+iQOkQRIuXWxsp7iwhJQggkvZn/w==
X-Received: by 2002:a05:6902:1501:b0:e0b:286b:1399 with SMTP id 3f1490d57ef6-e0b544b6080mr149742276.29.1722008349708;
        Fri, 26 Jul 2024 08:39:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2960b4f6sm787385276.0.2024.07.26.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:39:09 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:39:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: yangyun <yangyun50@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse: replace fuse_queue_forget with
 fuse_force_forget if error
Message-ID: <20240726153908.GD3432726@perftesting>
References: <20240726083752.302301-1-yangyun50@huawei.com>
 <20240726083752.302301-2-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726083752.302301-2-yangyun50@huawei.com>

On Fri, Jul 26, 2024 at 04:37:51PM +0800, yangyun wrote:
> Most usecases for 'fuse_queue_forget' in the code are about reverting
> the lookup count when error happens, except 'fuse_evict_inode' and
> 'fuse_cleanup_submount_lookup'. Even if there are no errors, it
> still needs alloc 'struct fuse_forget_link'. It is useless, which
> contributes to performance degradation and code mess to some extent.
> 
> 'fuse_force_forget' does not need allocate 'struct fuse_forget_link'in
> advance, and is only used by readdirplus before this patch for the reason
> that we do not know how many 'fuse_forget_link' structures will be
> allocated when error happens.
> 
> Signed-off-by: yangyun <yangyun50@huawei.com>

Forcing file systems to have their forget suddenly be synchronous in a lot of
cases is going to be a perf regression for them.

In some of these cases a synchronous forget is probably ok, as you say a lot of
them are error cases.  However d_revalidate() isn't.  That's us trying to figure
out if what we have in cache matches the file systems view of the inode, and if
it doesn't we're going to do a re-lookup, so we don't necessarily care for a
synchronous forget in this case.  Think of an NFS fuse client where the file got
renamed on the backend and now we're telling the kernel this is the inode we
have.  Forcing us to do a synchronous response now is going to be much more
performance impacting than it was pre-this patch.

A better approach would be to make the allocation optional based on the
->no_forget flag.  Thanks,

Josef

