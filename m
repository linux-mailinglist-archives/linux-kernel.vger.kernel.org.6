Return-Path: <linux-kernel+bounces-278450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CA094B05F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4461F223C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD916143C55;
	Wed,  7 Aug 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d9/SM6vC"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A2143751
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058079; cv=none; b=UI3GOCpquisQ0oYBkG6e/cW8TYlz8e3/loR9hHjvpWgBrib05f1MLh+eMdiWapDjz8MBkRENw2ZQVcuvON04Pci370d5Er7pLG3yg1p7ywe8VPa58/DZ00Xo8/yx/FiqUl95Jlf02wN9BDIpZp0sqgP8mEttrJwxSvNfjSPdoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058079; c=relaxed/simple;
	bh=xaphICs5Q06Pxl3/IEzJlNzaEmSgprYwNz0lwF3xxt8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=o81yH8MPVEonUfFD+hmOnnZK502ojiUXgzh2S3f85G8YxFqmT9Qu14VV032SQb7t40b8subpWLjszNQOVLFN9V5oNpA0MGCXl4RDS9wcaIu7rRO45MOlUxvK6Fmb1bvIb5ke3przktnghttgAceRBf/czshSLN38VAxI8NpGIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d9/SM6vC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d7bc07b7so16424785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723058076; x=1723662876; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYBRYs3ScUjdJGDBgb73mVo47iVS/aXnFSQhEqBnr30=;
        b=d9/SM6vCRRDHfKLxhYmFJS5QRwePC2bxRIAoVvIDF/cJVW/Qcd5V3945QoRjeb1/L+
         Y9aTuH+dx2HrnVDc2KIfmWSFmPpK9oEGcEVYzD7qV2yoqxWYS6NUOgGcOaW+L/lqwmVF
         NuNl29uob6ZWbBME3lVRGQm9gnvNcAjt5XhLm91Zt/X69bHsRbAZ5RiYEHINnPYPLXRr
         xIFicxDFYASVeWt6PGyo3c4f9Ee+0+4joTmArvDNkuSrWSCCl8H4DhUOvFcJBpwZkrap
         wNaad+0cAkU1DOVPjxn383RwIZigEAauKHkupNywNZOti+hpSK0uMZKXfxdEd3HioKsc
         rY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723058076; x=1723662876;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYBRYs3ScUjdJGDBgb73mVo47iVS/aXnFSQhEqBnr30=;
        b=bTOHOLPfg0XU4rzOzacr7Pq+QuGEwP6ZSSBZ+7qIG6v5vQLCOkV7wJxuHA/AYYffn4
         cMOZBL6yZSjdQK+sOmC7AQcNIOgE0Cc4ZAsmRhSGUym/er8QPD5NvF4hr7RJkkxOX87T
         WKcS9uRQzbrWOFAXvoZ21zegownZ8zuKw8OYYmbKfTWuYtxIe3zraDAQeNMgfP/e8AA0
         26Shn+aZO09FisLNVqr82lFVfXV30l9u5v0dSQjtB9XR7o0wEPeWO5pRAUQMF7uq0U8W
         I4cVoYjBCEPJJWUVyl+serL7uvyYuFyCZPHkcTi6KJmLtOhGNbX18ch1TKIGdJXZ1vh1
         rlCw==
X-Forwarded-Encrypted: i=1; AJvYcCXFVuJ4wDyAklovOV7iopTa0FDk5Z56k9rCQfJ35mJCo5WAaX5ZK/JgfWOKfgtF8+VbRVf4ecYS2TbY5B1nDfykcMR2z7JiIOedH2Ad
X-Gm-Message-State: AOJu0YwJkIbEFj9nXBB3w8WOssWZ4XR5sX8zvBMRRR3TdX4JKe7rIbIN
	5e0/4zEzYgK7DXrbCvqW2aeqraI8MCUr0k5rWztPBm0bo/YJhbTZlVHFJPKGjQ==
X-Google-Smtp-Source: AGHT+IFBzZBCHQuNdMzqsBwmQeYawZa/Fonhzcxk9qUtThYJx1f5gIFH8iSWPt6v9kTRQLHjRiDjAw==
X-Received: by 2002:a05:620a:24d5:b0:79c:f55:4fd4 with SMTP id af79cd13be357-7a34efd9390mr2390781285a.59.1723058076196;
        Wed, 07 Aug 2024 12:14:36 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a37869450bsm85820085a.76.2024.08.07.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:14:35 -0700 (PDT)
Date: Wed, 07 Aug 2024 15:14:35 -0400
Message-ID: <7063e0206fb6100d94114db6f8a0c538@paul-moore.com>
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
To: thunder.leizhen@huaweicloud.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH 1/1] selinux: add the processing of the failure of  avc_add_xperms_decision()
References: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>
In-Reply-To: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>

On Aug  7, 2024 thunder.leizhen@huaweicloud.com wrote:
> 
> When avc_add_xperms_decision() fails, the information recorded by the new
> avc node is incomplete. In this case, the new avc node should be released
> instead of replacing the old avc node.
> 
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, this looks good to me.  I'm going to merge this into
selinux/stable-6.11 with the idea of sending it, and your other
patch, up to Linus tomorrow, or potentially next week.

Thanks for your help!

--
paul-moore.com

