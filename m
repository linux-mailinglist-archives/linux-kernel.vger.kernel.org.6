Return-Path: <linux-kernel+bounces-400859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DA9C1355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73AA1F23712
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BB79D2;
	Fri,  8 Nov 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRP0eL9r"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B17462;
	Fri,  8 Nov 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027138; cv=none; b=EeUfi0bWeyNqjrNCNtNNSI14l/vKqlvAz3hfXtZ+EMzUYg53JxK1leU0b2MJAp721+okcgfs3CxZ1F8wlWF/R+AXRo2xF5NQVLStDh5sOY6axbpnP72Q0htC/wby5AYDK3ElG3f+1glrsGhY3nXEBEhUIpo4mUkw+OGCKrGYbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027138; c=relaxed/simple;
	bh=RvxY4a3WCb96CrFLRYIXYbqrR9Gkr0oINd/naqKrMBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tob13h4+oxZ/cUWnedDKgXO9/nkjZh1zVf32XzkZ0il8s7aSMZwKVnzMpXroDilJM86IwllY5svLgizoTncp1qyw0ex2F6HssIycKtTD5fULvkehTyniSbirGUmqf7JsBkcHUp2FEWd5SZ8bYJB62loWffBngTXROy3q/KtZOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRP0eL9r; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so1310217a12.3;
        Thu, 07 Nov 2024 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731027136; x=1731631936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vmX3lXsTDc4GilAspkSHux0yJlii6bjqc6VWWGKkGY=;
        b=HRP0eL9r5oyOzWGpxFSNrMnbYIH17qIs77u3fqfc5AHs2o27xR76pP+eoW5Kpja2Qt
         azQCIJh6l890s6OnifyPpS8c+Ml5pvEJkDZt9I+osX/ing5MqjY8QQaYCHijTRA7WPMx
         thrkqGRfp2sOqM3+EBEWRl57Q8n6uuHUMtFw91cjhDh8Za7bLZbkTIHGnl3QLXvFagMk
         EpD+KPx4CNQKZjrrMoS1w9IPkCQZ3GMfZCMEvvSByj7t+z4B5yHn0+3gaXvofEnqAqN5
         yH4ceyl/Gqn5pxDuw6mUIZ30v0utdFUifk+KQH8FasTb0Twp+1MxYFVddLNRZhaVRdzt
         A7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731027136; x=1731631936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vmX3lXsTDc4GilAspkSHux0yJlii6bjqc6VWWGKkGY=;
        b=LlXwunXQKE24R8cCuBTnz54ZHwts+w+74bfMNt5Sgq01FTun4RJrNJhKFs/2WmKaDh
         41FxZE/d4iAbcEcxwFkYY5k6o8GjEcZVfcShW33lQUpZf2T3rrZEiP6kWoIZl71sXMMT
         +hu/7jho8ezYEY5F+aWnhfGd3ppOz9SeLVEHQk+LOVe5dm14UxrkysslUjFioBEWLfZp
         TZavH0C7SqmC0DTjWpEoJfrOp992Rvy69d2O602nEzk4L8+HlyEFmV+GIK2kVXnz6VKD
         QHHuDHeroM3YVIeaPuK7+S56bSEmJP4g36S4K95G5TMK8Aw2nRBjfpzHaZWR44wlxNOy
         d5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/B0etPVQmBGlt1yN3AKz7WYKdkalZyI+gFOpPz0IMUOn78ID1gGsgzeG10kv0dYdy+E9QHzR/QqY=@vger.kernel.org, AJvYcCVWeXaUUaTT+jsy6PEWZa7taqj5YpcoKeoLRkvuRG6jB+K3oTg8/panoujQNFchy1teNQKcULdiHfgFKJU=@vger.kernel.org, AJvYcCXxHuRPMLHjAFkp25rJYtye1Zha1Reaa0aY2jmhUIdcgpB8VQii47t5TGcMdTXELNo9EIQcR27cPhWNmrSF@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWfjYCsJUTrU1P/eUQo6kIBzCgBSAmJlJJWjDawxdiNhas00p
	I4uRzwLpcigGD5XF14FS7I4OBJr1UB4u9RVoDom/gs/Fxq+xoOOf
X-Google-Smtp-Source: AGHT+IHZukLAtGIpoxOU6vQP3kwwzNCueeorSKv/5xKNmHlTvDCD0P3IMlLzdm6raX4gDbGTWLEinw==
X-Received: by 2002:a05:6a20:7fa8:b0:1db:ec07:3436 with SMTP id adf61e73a8af0-1dc228930fcmr1458163637.9.1731027136133;
        Thu, 07 Nov 2024 16:52:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a403fsm2447659b3a.105.2024.11.07.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:52:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Nov 2024 16:52:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] hwmon: Documentation: Fix grammar in fan speed trip
 points explanation
Message-ID: <07b90400-7f6b-478d-80af-c7e71ac205de@roeck-us.net>
References: <20241107013849.47833-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107013849.47833-1-xandfury@gmail.com>

On Wed, Nov 06, 2024 at 06:38:49PM -0700, Abhinav Saxena wrote:
> Fix several grammatical issues in the fan speed trip points documentation:
> - Replace awkward "which % the fan should run at at" construction with
>  clearer "that specify the percentage at which"
> - Fix incorrect "is chip depended" to "are chip dependent" for correct
>  verb agreement and adjective form
> - Improve readability by reorganizing first sentence and separating the
>  complex explanation into simpler parts
> - Add hyphen before "see" to improve readability
> - Remove redundant "at" in temperature description
> 
> No functional changes, documentation only.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>

Applied, after fixing the subject (which needs to include the affected
driver).

Thanks,
Guenter

