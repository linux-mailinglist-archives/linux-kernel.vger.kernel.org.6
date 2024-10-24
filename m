Return-Path: <linux-kernel+bounces-379456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4749ADED3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D828920F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCE519DF7A;
	Thu, 24 Oct 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWj12nDs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB91ADFFC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757711; cv=none; b=qQtRpihbJzBXqQw1fBJpgHjcXebhtBjkq7pVbwoiSLRAalQVJWTZ6HbxJJyLiYDYn2nQ3SfJexOO0RReFFywLNk4HD9ZK9LQsWdKukacmyKwpCRYqSeuRVG/1DCvAdmcN9CMfbqPArUSVmVNDzdCcb8OS1cVJHmEr2DTgA5kjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757711; c=relaxed/simple;
	bh=dXv7lh+BLcIRzudrbKwHjxbh1cdtzCTfOp7Kz2tK8h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRddB4iBFiwwc90gYQWi1BI3TxRLu39KRNoGfK6KnJfZ8GNxptb08G1fWm4gkmLK4uHSa8ixha1uKc4jxrxP18xcCMBne+HgzqJb1MHTZW/3BCigWGNSgIiqkEXCa5/VEavPeAOo/nUzjyv6I38svY5/rPmH65J0/xaSaLEZ/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWj12nDs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so6513045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729757707; x=1730362507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdHwvluF9d5mpTyj2QvbUGMMKLF4PrNsenGLNKqAMOo=;
        b=YWj12nDshmaoxJBuBPODCTba/ZR/mBjz3pFMW6XOEf9bHKqSCCN+wFAi0yLdzwWB7X
         CVlFxFKL02LXovsCuiWmLG68srrjtiPWVYvyJV3ml/v8+7EKESlz0QltORBt7XpNjqep
         +8z/hzeCsqFfs6rgj8OJKJso7JrdBuRf2THKVCiTVkdwTqAqbOSOwCYmg1I5M01MScie
         HzymM31BxrD7V4w/LXfKKi3ugzY9J3lUDgk2eE5nQUp37yGggtBEJbxvQiE2Pkq9u8vD
         0bSVKOs9smGnI1hQfrubkfHhFlUCOpLC8uEOTRo+IGJ0P+4cS95ygATzd0XrhF1h9Y9+
         YZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757707; x=1730362507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdHwvluF9d5mpTyj2QvbUGMMKLF4PrNsenGLNKqAMOo=;
        b=jRbT8FUodRMr2o7HkutJ+iUbKNmQAEcOo3YA9kyclspGRFDGiNTM3n035hEwC3II/t
         Oy80yf+F/jwIgBwvzVBsxAhve8i2lnluJ6UZqx0+DroLrakwx0jTi6noytQyNGRAjGOT
         2QZ5w3QCCi+wPirkThTJXw8XUqaXCKeEVxgA/HYoQM/jAWNVNFFpRV+HUVghjqkaRv88
         dnPKCOk1VCtWuKHxk2EHOzHSOqx83RQU97bPMqPeVcYb38P6iO3hsavLeNkc/h/v2S0+
         dDGf92hrJQAdMe9Av+x4X2l2eWgZ93st9/iHZxI7lfruj87Bqcr++MyshB4ywHP1TFXG
         /aHw==
X-Forwarded-Encrypted: i=1; AJvYcCVjJlmNZIRa4weYOi0ME6QeFlkAQJFCK0vge7/42EF4fb2F1+SYXss6SgdlIBQ/W6BlDHSTrpor/pVJezM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqv7mMLm2/UavzPeAjr2QyU3krs/DBYwmOq0M3BSa6MrxIvaY
	lFD1LYar0ipIkHhGYpaRUxsrIWmwrYs9bqpj5fc717sYieiSusSrXdqs0PHchx4=
X-Google-Smtp-Source: AGHT+IEXI5QgJVMoGUbzlfwpuFVn8bN9pJLOzzVjOGLLhtsS2RoOTGIAujFl+DVo4gw8s3lu3Fx8lA==
X-Received: by 2002:a5d:4444:0:b0:37c:cdb6:6a9e with SMTP id ffacd0b85a97d-3803ac837dcmr905560f8f.9.1729757707223;
        Thu, 24 Oct 2024 01:15:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5682c3sm9915155e9.29.2024.10.24.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:15:06 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:15:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/1] livepatch: Add stack_order sysfs attribute
Message-ID: <ZxoCCasDtqeXdSNP@pathway.suse.cz>
References: <20241024044317.46666-1-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024044317.46666-1-zhangwarden@gmail.com>

On Thu 2024-10-24 12:43:16, Wardenjohn wrote:
> Add "stack_order" sysfs attribute which holds the order in which a live
> patch module was loaded into the system. A user can then determine an
> active live patched version of a function.
> 
> cat /sys/kernel/livepatch/livepatch_1/stack_order -> 1
> 
> means that livepatch_1 is the first live patch applied
> 
> cat /sys/kernel/livepatch/livepatch_module/stack_order -> N
> 
> means that livepatch_module is the Nth live patch applied
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

This patch is the same as the one at
https://lore.kernel.org/r/20241008014856.3729-2-zhangwarden@gmail.com

So that we could add the already existing approvals:

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Best Regards,
Petr

