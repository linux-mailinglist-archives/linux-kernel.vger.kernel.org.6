Return-Path: <linux-kernel+bounces-348115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5598E2B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4891C22057
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121022141B9;
	Wed,  2 Oct 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OHZwnTqi"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165A1D173A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894315; cv=none; b=irUrEGamlVfTBVtm1VGXVuV4GDRucHhJYi3fBL2BcyL4Zy93oAg+TONC+nxtTdLcXuAx5Di5vNF7cBs+6as5gVFn76lMqUmJ9dsJzEnNE3Wyf56zr0mxzGAkjttdjMQBcxzKmXviAFCuMNWHBt6qgKVFSTmxEdIJhaRMXkEJVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894315; c=relaxed/simple;
	bh=xtCqdu3o/WVR5bOanAxpuwKmndQfilnxrYpVpFPeD8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrgCb78hmTMPHkvYmDtECmNXy2B01J9o8eOFlP3ihnt9LyytQjdHKFK6n2E9M4wjwiingqe22lnxSc57LVR3CB3BTyJbGDGBoFJKyZ/J9y4J3u1bg65tlm83PMbnq9fwhJBtKr0s8/xkjO/X/6ymcWOmHSJKKF9wSQJD27p36dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OHZwnTqi; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82aac438539so5553939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727894312; x=1728499112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJp0SLz4zhMPpN/9QdLXIlEOw6z2zlthBMJ+dYX71ZA=;
        b=OHZwnTqiOZX2pCYvohsJfzZbj+miMj8lxDg/jGGTDvONYw/rAq5rL5TFJ/WfQhHz1P
         SLbTRJgQuWMMEdvqexMNetzjeyGLQlg8U4IGgfeeovqHX5Z/cJ+pO1dbQoUuOs6lO1rO
         N3SEC5ECzdfBOg4m4ZUW5oLNPI39+GbYUVU1AIMqRJEQ/Wo3/hhhGYEEufSzgCUhiRi+
         5lBr8prbgDR9B4cbzPHyBOWETG4dUjgRnrsdk3fmhIeXt71vS22cVZ1Cedjg+213lMzm
         HFvJ2VadKLu0elO1csmGY8MSzAqKbcVocrcMZ3plV07vgHkjUedQ/3EqGZ2+upM3UM8O
         dmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894312; x=1728499112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJp0SLz4zhMPpN/9QdLXIlEOw6z2zlthBMJ+dYX71ZA=;
        b=WvG1LknNHDv66DgYCR6wr5sMADmKYAlwo3xfjJv3MHl5PLV14tItnTDTjhEeCKe5wx
         pv+YhSnaZY7AizINSZz9W8tpe3JEId9GNmDtp/+LA5tz7mVAeC+uNZxb+pWRR/MiNDGc
         2XJAYVccXR1JWNUEph8j/LCj1jNWJDn7sAh9KiUHQg8um+nSsvqsQpfdVIOdtiyWPpKG
         MdlmvWs00eEVLNXQa5p+nr5YFS59cANi+sywcv5kpLL28ajSFqrOIkn9B89B1LUJj6SM
         mHcVpmzNDV8vbEvYtyQkowPeNBOjhyYcYVDwnjoLlwZUhBE7GCGGG+V4JBIKflM7WmZk
         lpYg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Tu7mcF92hhPJtaf7CMs6Yw1z0dgpVAHi36WptPk0h1Tc4FM3Y3IRBQFpVVfWM1/XOj74nrprYkLoh/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHA2fyFZNTwALebqdr2qbYQNVOJ5iD9KgzFkpAbAiPjQGGnTPu
	tu7t3tcFkEdFGjrqvyzFUzOHrvRwpW6U3yf6WsHgpUr6MfH0vc2XHxUGkHXIZag=
X-Google-Smtp-Source: AGHT+IG/gozMX83QOgvNxZbi7a72D75ruQINKEcBndSq/tSeqLeSd64OqvSHja3mYl25NQFARSWvzQ==
X-Received: by 2002:a05:6602:2dc7:b0:82a:221d:51e8 with SMTP id ca18e2360f4ac-834d84f830dmr410358139f.13.1727894312385;
        Wed, 02 Oct 2024 11:38:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888497a6sm3232924173.37.2024.10.02.11.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:38:31 -0700 (PDT)
Message-ID: <e20707d4-53bc-400c-bb66-f1bd63e063e9@kernel.dk>
Date: Wed, 2 Oct 2024 12:38:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
To: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders <justin@coraid.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
 "David S . Miller" <davem@davemloft.net>, Nicolai Stange <nstange@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002040616.25193-2-jlee@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 10:06 PM, Chun-Yi Lee wrote:
> This is a patch for debugging. For tracking the reference count of using
> net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> same time.

There's no parallel universe in which using a percpu reference over just
a refcount_t for something like aoe is warranted.

-- 
Jens Axboe

