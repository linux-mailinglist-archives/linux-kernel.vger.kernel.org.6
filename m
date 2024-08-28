Return-Path: <linux-kernel+bounces-305444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818B962EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145F3281A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB81A705D;
	Wed, 28 Aug 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dan7nYmd"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6C36130
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866934; cv=none; b=pXreiVP/hNKb+Ajti+pNqdacg58yFii7zBBk37VVJzombemjFl9cbfm8g0M5nIR0JztI4iHXkjM3flFoQKLnBfzlB2sVoN3lFSu0wheUZdkTdR5hVOg6giBR7qvns3NMF4rsODmViZccaLOYbGqLVNVKmbZ6RPuP594bhvfVBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866934; c=relaxed/simple;
	bh=6sJuclRag21uFtJ/65qjts/K8N+xM6U/kSObYcqdsBk=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=n9dM0GqhAAx4Polfh6Xrd1U2viS2AohsA6hSNEzrHliQMAZ9R61zWQQO0AdVO62+xGsAHLWqscSmmTVJalCvR3X3Naw6uSlXqcNrty14PfAlF3p6Qq1ghszNrjbo+TTcOVK8w83psJwlRX318xvReVLVxaGYO2q3lb7dbHHbXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dan7nYmd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3dc16d00ba6so1309569b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724866931; x=1725471731; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0LS34y9FNgp7CeUUEOHvHKYwbGPvsi/kP5Wc73C6eY=;
        b=Dan7nYmdCipb8VcfVQqrsQzN9lCdPANwVdDlEzEgtO4bRrFeCLP6M8GK/NxwvT779W
         UixZQtEvc/WA424UHTEkttWWdHWMD2SJGZSig6PrELZMg8TRXWOcLRidnmMkUDLBqdAh
         6Fdyv6KRc3pH6E/9sCbfx7AaZ2GBVy7UhvOITUcVn+D6QJiC8a1z7mKBn0N0tqxTXzNS
         4nuGT6tlyrNDQb305Is7eK5+MpVICJ8ySdv6Kv694UQZl3bF9jp/tkioy6BbMntCq9Vc
         e5/7l/q9E7NjT1ptsa+UvUswY5v+3505JCm3vbzxsuAtsKKXlswvCxDpuSTXRvKJnkJ4
         qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866931; x=1725471731;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0LS34y9FNgp7CeUUEOHvHKYwbGPvsi/kP5Wc73C6eY=;
        b=ZpcHrZyWVdpwSyRy37OJ0vv47paaZFwm7IT2Fowr4fV+F28CmNScJf3cjVF9Gv7JUP
         NxU7GrkHFgxWEfcZbj0g/era/vA5R/fH1lzTgi+QG5vP8DbIep0/s237966asDasga00
         oZd8TB9HfDgNUT3d3300uhwinYJu+ujh3aJtO6016EVdvfGOy/YMPDWaXbpzg/y+gk2P
         22cl2B4hLM4Dgq07E6HRvMf4ZgO81MHgyFqaQSEbENf51HRGILc7r7zmZ6hBGvgy0hog
         kksrQHwkEVP2xd8ky6YBTjAxkRTfvydUg5CsbM1wHtsofox6IcFavnhYChO21tsnkSvg
         QAFA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3CcySoc4QQ9vRcJ8IUxwk2zGDMONRaBEithfN8v4aC66OdZtDmfjfH39yJl/zPcqABmP5R34usMTNyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKyycPPYSim+6cB4smiMZlBsisxPQ9WWwYf3RZ+fQeseWuzjK
	SIC7NBi77o4n5h73UWAL1CdAsYAnRT3wlc3coGbpi3cNTFdMEx/0SzDZQQ0g7w==
X-Google-Smtp-Source: AGHT+IF60W2ezbSV3pqqIsEGk6YQW3oqG7+k3EIiwJzJkjnGNJsVIJxaYuxkMOkfo6a40udSN+41lQ==
X-Received: by 2002:a05:6870:4708:b0:260:e453:5368 with SMTP id 586e51a60fabf-27790321839mr364416fac.46.1724866931173;
        Wed, 28 Aug 2024 10:42:11 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f34233csm656813385a.35.2024.08.28.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:42:10 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:42:09 -0400
Message-ID: <f3e7f421323bb99c12507299a658d572@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Zhen Lei <thunder.leizhen@huawei.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] selinux: simplify avc_xperms_audit_required()
References: <20240822140858.1998-1-thunder.leizhen@huawei.com>
In-Reply-To: <20240822140858.1998-1-thunder.leizhen@huawei.com>

On Aug 22, 2024 Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
> By associative and commutative laws, the result of the two 'audited' is
> zero. Take the second 'audited' as an example:
>   1) audited = requested & avd->auditallow;
>   2) audited &= ~requested;
>   ==> audited = ~requested & (requested & avd->auditallow);
>   ==> audited = (~requested & requested) & avd->auditallow;
>   ==> audited = 0 & avd->auditallow;
>   ==> audited = 0;
> 
> In fact, it is more readable to directly write zero. The value of the
> first 'audited' is 0 because AUDIT is not allowed. The second 'audited'
> is zero because there is no AUDITALLOW permission.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  security/selinux/avc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me, merged into selinux/dev, thanks!

--
paul-moore.com

