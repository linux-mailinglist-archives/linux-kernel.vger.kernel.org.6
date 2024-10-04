Return-Path: <linux-kernel+bounces-350208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569C990182
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4C51C23A10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497711369BB;
	Fri,  4 Oct 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzB82TEd"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7D156644
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038464; cv=none; b=d2o5QUNKi2ze9Hc708wfJ1VteSNdqppj8Ik4Byc77Lo87F9KrbFznOtYK/AKPu4KIh2vzLW/7GeGRVgVDhzHjtn6rSCBFlLi/T9LagLo1u3A8Rfspk7ZSl+vXHcNtHqtFU483CdLQXyuLCpI39lw++mxdFJj71oUxTdLgDpMSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038464; c=relaxed/simple;
	bh=MJ9SS7wuFxx4IxrtT8ysk8y2mxUcn83msldULPlyJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E85T2mJV2NP5hDRWCpROXKvWa7O7XSXaB3XMBEmaSGF5D/LlQfejY8L9KjMOZL1WyDlteKuupoo4LrURJ4qPfwzBEFwv+0W5SBp62iq2tevqc4N4nPM6fDiPbZOt31oF+TIt3hGgzZ8lzdssPvxABXW8788X2NbEjbZixsYEH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzB82TEd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso22770801fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728038461; x=1728643261; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7PmH07HIiK1wIfwMtRYMnhYqfowrL/1RwJu9Jk8bm0=;
        b=JzB82TEdAdOAr5iXM/2+t7UpRnVmQRLmPVP8MUKsxNh1kTvCDLLBSmTeaSwo5ca5az
         PedYg8uGaECJqB/k4QtPx/aGsULEOyPggDvonCSYlSfBZbVlGLGTggEWVYgW5eSPLBhO
         kZkriNQgiIo8pJQxWhKyTZ2W62ilWMdFlfh3T1K6o3FJcaj8pvhUGMtkZUqehjz0R2eY
         ke7nFqhFqOl0720HZh9rv+0W2kbJ1qlPqnITjxck6slnkTduhdx+XOWhrBNZlW+wggZj
         g0qsb6TGboSpRrlb8j4vekvkRDL7CeOoCUPQCTGdKW/GsOsVkcs9/NnsjuO15091+Zr9
         bBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728038461; x=1728643261;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7PmH07HIiK1wIfwMtRYMnhYqfowrL/1RwJu9Jk8bm0=;
        b=qrDEnQhywXFbYyoQE+d3oGMvlGTEN1fXuY5pT38klEdFUaS1xkMMa9fHgQ5sE1o/LH
         opiteN8YBCvQH8REYH+YS5BFARCsjbwjr+XMpqCnvwk9JM4h6r3qyxnTiviA9F10IKUQ
         LedIcgUHzEGA7ksKVQYddj9r/HCM42oF4nugWA4i64BDa5HZXeA9fWqnPsdx4YbMGVLR
         pLuPM30O82H/9HZt9AL/JVdOBRL/0d6b59ON1HMckWuVy0ThKKieUwUl49XD5pa2BvWn
         knl3ebZqiU0Gb/AETF5NYMcxQPpALGCmtKCv+O7ELTwTXNrCR3vouSGhrw7QdjcgxhwL
         8YAw==
X-Forwarded-Encrypted: i=1; AJvYcCU9HRXaRX1dHKfp4b1GnZbiVLTYm7KD5+knvdQ2qg8ShNLJUBUFOyVYjbYTg1HW9mxuOxEe1olFOeCtD+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugpweBsVjxC9kmlC/pe3Re1eYE4cJMQeI6p/E4JADESGd+snD
	8OSftfhXUlS+8eEnJvNueFI9c5QOJqAxs6f7NPBnjr9Viqg4n71Yy0ntct0G9aw=
X-Google-Smtp-Source: AGHT+IG1YRkmJO1uW40VGoEQ/zmCD5PRanqljw7b7hellT62vHdQUmTOOb68rz0pdZxxtE9k4kWw7Q==
X-Received: by 2002:a2e:bc0e:0:b0:2fa:cc50:41b with SMTP id 38308e7fff4ca-2faf3c508ffmr14062411fa.5.1728038460307;
        Fri, 04 Oct 2024 03:41:00 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dedc1e407sm358346b3a.160.2024.10.04.03.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 03:40:59 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:40:55 +0800
From: joeyli <jlee@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
Message-ID: <20241004104055.GN3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
 <e20707d4-53bc-400c-bb66-f1bd63e063e9@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20707d4-53bc-400c-bb66-f1bd63e063e9@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Jens,

On Wed, Oct 02, 2024 at 12:38:30PM -0600, Jens Axboe wrote:
> On 10/1/24 10:06 PM, Chun-Yi Lee wrote:
> > This is a patch for debugging. For tracking the reference count of using
> > net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> > structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> > call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> > same time.
> 
> There's no parallel universe in which using a percpu reference over just
> a refcount_t for something like aoe is warranted.
>

Thanks for your review! I will use refcount_t in next version.

Joey Lee 

