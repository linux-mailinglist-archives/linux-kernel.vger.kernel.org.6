Return-Path: <linux-kernel+bounces-420938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61779D85F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F85BB34119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8819CC2D;
	Mon, 25 Nov 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KE5ryPwa"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF541922FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534436; cv=none; b=s9mdYE8h5Uh3HxfEzd6EbjycHIHdk36zqF7U3bFa2Xns3r+l/pHIpoHgbEaZ/84E3blxvupOBybTpbQEhsE9whaffzC/w2nVh3zdNxYfx+ZvTtkOvwHDMQT40Y/6LozVqhrtlfkMu68twklofMyBRBCVdUBoT/2zXRufvyY5OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534436; c=relaxed/simple;
	bh=NUDgmZFcDa9nu5S4aDFg96KUr5KYAWfbDYZxM2bAyc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj7a2xMWUkkoZ7rMG3gya9NlTeY3Fk6MyB8gbsChwB2kaRU4pda6M3FqW8pMuswSw7my3CLTvp7IO0V92LcBUmoAWIs81bp8H6l8pNUQFFDrXWimGiK3rQ69rjfRVi4w71btYsp9BYJIohzufaM+0tadJnAAQuOyamKEQ2iUdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KE5ryPwa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314f38d274so54999815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732534433; x=1733139233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTM76Mdzqwb1GuClwHSoU2f/CrBS4pEthO5eWu6Q3V0=;
        b=KE5ryPwaKfisM8l9Z0ES/TuGTYpyl4Nws/lhHxGZk3vHICknmkeZMEQ80W1FODVwNx
         3cwbfFdKkGRXNNtqEHSQ/yidDjFumlj+u+yqtPnjfT/NzHwdyto4Mgarz0Aks7KoUUrJ
         2t6aaW+Quda+EUkCy7JlTLdDbQd0THuPr2zqWeNPUh08moMR86YAbDywNIg64mm0wNMo
         gnptv6Uu3Wz/Ru3z8xs/ObHfTndFyBG81FTLeQkuv+sHxqqbU0L/nMDRK7ID0V7u8dn6
         22dsXfbZqIjC6CIHX2C1TQV7nO/g2OlGGe7oIpImq7I30BUisD+ZGccF+vJVyZZGuL/+
         GZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534433; x=1733139233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTM76Mdzqwb1GuClwHSoU2f/CrBS4pEthO5eWu6Q3V0=;
        b=RPXhvtFQXRiCtfMw7gyfdoO68BhyA3oA8wchw3TGCVQVkfThxDJEsoFhx+gOJBIMVA
         nRF/GeNZ4hTX4EEo34TK4GXTas9m85EXWjH92oQqE51qZxycvHumdszPFdHYKeQEbHu3
         c7E3FrticNobdX3a5n7QcXSIfmfvuGUqUO3e0PzY+R/3K+bWzpV9BcnCnCcCy6Kbe/vt
         48mEPzEwN66QAEWY3iwnVBzFT0UIKjdpu/wPlbRp506nbHrM11uxfPQEYON47yYPmU2L
         HlHeMna+HEU4wdzOAxG7NcsygyBhdAebofCaGGaIzm6uRtAIXAgRi+SOdGlXYjotpYgs
         7BUw==
X-Forwarded-Encrypted: i=1; AJvYcCWkyLPvUjKHqHq3wuNyFqV2NlnkA4v9uLuNnf4ueQ9DFlEW4LH3kKTyWocwXqqllBglCnCQ1+5IfK6hXcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztc79DCqc7lCn/lTM5WvEzp29DLSL4JNFRtesbjWUfXzo2Zwx8
	8KALy1nXKVVWOwHFj4APdlMzvyUD4VQXoegJ8kph+BJm97DE/tfEkfoxmfSyAKk=
X-Gm-Gg: ASbGnculpo+R3XSzQ1dzm18DJGKvH+pXnUyHeVdJbitSWl4R4MQuArkaywKtvd2B5zY
	W7OyesKUFMXN5COROPFfkewk+qHhP3MG8cRLUINqYKvM8VszfqsjN5tnO8oJ0+9sEphj9LXZZ88
	m4NX7SakNhMYnrg3frCaOlukaUYq0UvaJXT918uOI+hG6Or5kOVN17tGyH+ySr3My/2T2P4WwFX
	MAw2MndpvIleUswm9K+O6nv4IaZPDwyeXAIQbAv
X-Google-Smtp-Source: AGHT+IFYVyoFFMSqiR1Kn1O5xE8JxWbX8XxZKjBgzdjMtFSUnEr6pflHMkezvxbC5V+qeE5ilJxAfA==
X-Received: by 2002:a05:600c:3ac3:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-433ce410255mr123612545e9.5.1732534432768;
        Mon, 25 Nov 2024 03:33:52 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432f643e65bsm174028585e9.0.2024.11.25.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:33:52 -0800 (PST)
Date: Mon, 25 Nov 2024 12:33:52 +0100
From: Michal Hocko <mhocko@suse.com>
To: Junjie Fu <fujunjie1@qq.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, dave.hansen@intel.com
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
Message-ID: <Z0RgoOHMRFCTM1JB@tiehlicka>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>

On Sun 24-11-24 03:09:35, Junjie Fu wrote:
> When handling a page fault caused by NUMA balancing (do_numa_page), it is
> necessary to decide whether to migrate the current page to another node or
> keep it on its current node. For pages with the MPOL_PREFERRED memory
> policy, it is sufficient to check whether the first node set in the
> nodemask is the same as the node where the page is currently located. If
> this is the case, the page should remain in its current state. Otherwise,
> migration to another node should be attempted.
> 
> Because the definition of MPOL_PREFERRED is as follows: "This mode sets the
> preferred node for allocation. The kernel will try to allocate pages from
> this node first and fall back to nearby nodes if the preferred node is low
> on free memory. If the nodemask specifies more than one node ID, the first
> node in the mask will be selected as the preferred node."
> 
> Thus, if the node where the current page resides is not the first node in
> the nodemask, it is not the PREFERRED node, and memory migration can be
> attempted.
> 
> However, in the original code, the check only verifies whether the current
> node exists in the nodemask (which may or may not be the first node in the
> mask). This could lead to a scenario where, if the current node is not the
> first node in the nodemask, the code incorrectly decides not to attempt
> migration to other nodes.
> 
> This behavior is clearly incorrect. If the target node for migration and
> the page's current NUMA node are both within the nodemask but neither is
> the first node, they should be treated with the same priority, and
> migration attempts should proceed.

The code is clearly confusing but is there any actual problem to be
solved? IIRC although we do keep nodemask for MPOL_PREFERRED
policy we do not allow to set more than a single node to be set there.
Have a look at mpol_new_preferred

-- 
Michal Hocko
SUSE Labs

