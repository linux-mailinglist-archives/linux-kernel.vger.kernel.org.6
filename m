Return-Path: <linux-kernel+bounces-431324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C19E3CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838BFB285BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B71F8913;
	Wed,  4 Dec 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZttcWP7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C11F7590;
	Wed,  4 Dec 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320869; cv=none; b=E74Uu7X39BX2SW3tuntQeFH/57YcCHqFQQOOo0ioIZ1Z97knnv50NfOd/794L/kGhWdMEdNBL1EEMRXmUl3u2nbUpyC9XK6MvcGq9Bh3u+xkKGDqo/CoYdOdbSLSLnZprmcKEMb+FekeInRyX0E3SqLLptEZ/VLfuLp8ELp9G9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320869; c=relaxed/simple;
	bh=MGEvqvMYZSsXKz1cSlSmQFCU+Mj+aY6ZEuVyXB4SU0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+bygIEJuMeuR7FbzhAmuemX1RDzwdum6Qh7BQorKK1ZMsCLx3YzqZxJZKu50sdHhFV7xa0KLqDBmr+kchL1DcGjUOkPVIuacuayfVdOoH0AvrElFbdecU1qCzHLR7D0w8KHBndzx8h9w6jwxurN5oQuLfWYwcOl5i6bTl8+FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZttcWP7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215b4681c94so22151345ad.0;
        Wed, 04 Dec 2024 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320867; x=1733925667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzzDa0aFdpaIXwzbyXGO7YXDNsTj4+iJDn2MWFiANDQ=;
        b=SZttcWP7we5MsVQEOAiMTIweLqmS7RkBw9KVZK0vZ2bVVOymV2KnOjxPg1dBgZbxxN
         Hi9Hdkqe4+iT+teU09vJEDSz+5s294RBmKptwLOcrD90esGzoWLkOvu0CSqQvEJs5C9h
         d8J0iUbTblX0AZYn1q2VJgNFedlLW6QlyHc+1JC9AEEoPPkrs3vv8LV7veL/NknF/WTy
         FS7N07gFo4u+YgIvVfufNKIQR1OFgC2YN8B3rzxWXi1wtMJZqdlj1p1RjpdNIsk11951
         n5LIymHv3S5ue7RMqdLDkmzwhu/dbyulOavvEyV6g7d5NyT3NT6+G7GbyNlP41LJf17U
         YwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320867; x=1733925667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzzDa0aFdpaIXwzbyXGO7YXDNsTj4+iJDn2MWFiANDQ=;
        b=q4iCgan8/5PAise0cbibXhab4grb14r43LAVkk/Uj0ECUUyfm0qH2w8zEsXAfZTvE9
         1ClrD7BIGg9Oypk3ZTrroxUPh8t2utq0fHUeZ7ko/MGVvUCptYdIrfgreykZh+jygER6
         9UzH+4bqPLO9iXiFG46kpuLpXMiHB0uGGOcKfQj3UzKORCzADPFkpmcOgNuTF81O1dXK
         GJRTpsp3AFBC/xt1LAyGcjB4Ovgh80o2Pvodh4f55JMwtKLVZER06GYFB6CbNB+eOOg5
         RqfSWTn5s9tSfuV2YPFhQR7lTL1Muf7VK3isJMjnUgidkwjS8uKERiTy8BZAO6mUGC2v
         ZYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1VndAknRgC62gsV7fQgnAYBNc8wQtZ37XwBtsOQGbXZC1j2EaYnFGsyL3z0BOkxdQ7ASBy4n0FMXWBUH/@vger.kernel.org, AJvYcCXLfjNbzk7fEW/FSW1D1gwV8/ekZX4haUFGRCUczfoxywzkY42qJIRnXM0xEIRJVn4l4N7SMEZIm2XyBj0=@vger.kernel.org, AJvYcCXyeYgwczDwi57zIFczE8WE5c5cAr4FTrmduwSllsEhyIYA8NccVoY0MhzIUMp8fmCGfddlE2B1qZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJ+vulr6z9vayvvh2p3+Hdn9Ad9HX08wV0xBdSxyQeOQ4g4+1
	f2BBxLAd1pJzVR6rA4TQlaTuDAA6RWM80xhKWkxPm5JYkcMnPgNA
X-Gm-Gg: ASbGncs3ycn0YWq/vxW/wKWseJnZrO6T5M8sIlanpJCDKHbyOOCBYuqckrZq7qUF1vu
	A1xCQivuLTqYX2iYnoSL5fa3eVDKRHuZeLUGJGUbUVzIl7v4oiRWM0RmetEMFadAHTSzbn/9iwg
	vgOHPA0hiLobvKXUJ4wd4gjjr08o8MP59u+J0Qf2E2Zjjn/ddHRZAab/LRnVBVhAYuLqgYUEuQ9
	3Cquort7M4HjV3VslKmLOhq/ML6TXqbwenjDxmIxyFQz7vu8bYYzKYEI1dK5aE=
X-Google-Smtp-Source: AGHT+IHJuJ84539BMjM0hmNjSWckYSQ7ClNEvUUAs0hnuWZoq80yKPp3GPMr8A/AX60BrU1mGAA/zw==
X-Received: by 2002:a17:902:e886:b0:215:4394:40b5 with SMTP id d9443c01a7336-215bd1620cemr80728915ad.43.1733320866395;
        Wed, 04 Dec 2024 06:01:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258bbfbcb4sm1630390b3a.168.2024.12.04.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:01:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Dec 2024 06:01:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: eugene.shalygin@gmail.com, jdelvare@suse.com, corbet@lwn.net,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (asus-ec-sensors) AMD 600 motherboard add
 support for fan cpu opt
Message-ID: <0d6e40b0-b6f6-46ff-a6c5-4b8a335e2cdc@roeck-us.net>
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
 <20241201034803.584482-2-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201034803.584482-2-yanhuoguifan@gmail.com>

On Sun, Dec 01, 2024 at 11:47:44AM +0800, Li XingYang wrote:
> Refer to the LibreHardwareMonitor project, LibreHardwareMonitorLib/
> Hardware/Motherboard/Lpc/EC/EmbeddedController.cs file,
> fan cpu opt is support by amd600 EC.
> the registers are described:
> BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
> {
> { ECSensor.FanCPUOpt,  new EmbeddedControllerSource
> ("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
> }
> 
> now add the FanCPUOpt support for amd600
> 
> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>

Applied.

Thanks,
Guenter

