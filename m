Return-Path: <linux-kernel+bounces-379183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A79ADB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D431F22546
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B9170A0A;
	Thu, 24 Oct 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfT0X/QZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580515B96E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745683; cv=none; b=SgwsGTUQnwLXRk1185WOUAVH2ZcGkd2pgZnSzfcoPQCXPgdlBteS+8l8s5H37q1C0k2QdQ59CpDz4VhHkMg4KDnVutV5DUU6gmHUgycU8hsLys0OnFZB7SZO2QrlmwEiS5Ppv/oSpDihRSxVM2cc1jNqFuH3ao5MN7Env8fqGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745683; c=relaxed/simple;
	bh=s+aT90Sd8qx0evAuMI+iZJAVrl0tTcfoxDMPhcnVPck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9LBWx+5Vd+teyxe/rR1dM9x5tjmuTLSIyLeKLv4rmDlPjiqPNlY/YdTPp8D7dZmgHNXbNbS6iaULfN1jtFVsQsDTyb+zieUuCtJcnPYdX1QByeV5fkJWjiLuYex/1bQQgJXjglLy8AfNRZSVYQi+zdWiRrmve0JXhhHw/OsysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfT0X/QZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso327101b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729745681; x=1730350481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YROL508pV/aVzcOA2vaUPlhPnKjiiTn09b259dUerBk=;
        b=ZfT0X/QZo2duNJgjAsz0BegPgm0oQTE3C/AWInp0PGb+gp7a3Fz6n9nVO/1w4k0iO/
         5E4sbsN2Ind7mx16GKZsGXjQWpbNonaJbh3Hva9Nav6YmLGty8aI1UB1H0zf7/G1Kzpl
         0IDa/gLlsd8FPLHYBFPE1N/rbcfu99AWyJDDGuaW1O902Ia8eSM8cQ7yll9g3F8RdHdn
         MlOjqDuYi/AXtxxMivJr8IX9RgJs4vR5BRo/HT3OVGo5oCqKN4GnDNirHEPKpymSgi0V
         M/NTv1mnS8ZIiGcpZV/26KjASjVXv4Nb7CmtL4VOSEy3eqgQovWjh+UgO0r7JhoxKdsg
         FVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729745681; x=1730350481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YROL508pV/aVzcOA2vaUPlhPnKjiiTn09b259dUerBk=;
        b=QNhXIheeVAx6RbwXpLQsNp4UtUXd0K6voi5+YdnfRy3CVrcuLpSlo0bUk0TOYr3IyM
         84BuY9Xp6v9hTRJn8CSdKvsPjPU4bBPsewHt+FfjtnNqNHI4x1D/aqElXi+J2UqOfQ4e
         HmAYXkpPNY7J1L3yqg7jw8V0juFn2DWXilaXhPW8zewiJEIfjpezBvmNuhCn/RNlWSVj
         tMg1ig5FSTXtU467woaq2Wx6Vm3YEWIVBg4h7Agpp90WnB57FyilI2t/eHVRy9kuZZ7p
         vp3zTzqL3U2SPsqQUYbHqeDutuRYxXH21okI4HVNQhJlhNyGv5GJMlN/iTTW+y+cE6w6
         142w==
X-Forwarded-Encrypted: i=1; AJvYcCXS5ywPLK/vV3B+qNfjb0LU3eEN6BsD0cMD0cqXEWmxOo1JiO9NEIa8W+9GjEAahzu9NRrgOwvsFbF+3W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMx7AzBQgluhm4fJR0v6Em39QcOWt+BmR6iEYPNXZJ9YElYViA
	UQTDDcHBA0V6aU7GRihYZXHxg62LACs8i2IQGZJ1LovIorbjNcjN/1+VyQ==
X-Google-Smtp-Source: AGHT+IGGZOP07noPq3cIiBbd+28oI9FWwIKBaLJRIUE2kwp5Hj0XzDy8KQfPxtumYBKqzka9F+K0cw==
X-Received: by 2002:a05:6a21:3416:b0:1d0:603b:bf76 with SMTP id adf61e73a8af0-1d989caa703mr681629637.34.1729745680569;
        Wed, 23 Oct 2024 21:54:40 -0700 (PDT)
Received: from eqbm-smc020.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1356a24sm7297505b3a.96.2024.10.23.21.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:54:39 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:54:37 -0700
From: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <ZxnTDYiQWU45eX-Y@eqbm-smc020.dtc.local>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
 <Zxls4HqdkV_yBYxZ@tiehlicka>
 <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>
 <Zxl3fB9FVz5i1huh@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zxl3fB9FVz5i1huh@tiehlicka>

On Thu, Oct 24, 2024 at 12:23:56AM +0200, Michal Hocko wrote:
> On Wed 23-10-24 15:15:20, Dongjoo Seo wrote:
> > Hi Andrew, Michal,
> > 
> > Thanks for the feedback.
> > 
> > The issue is that CPU-less nodes can lead to incorrect NUMA stats.
> > For example, NUMA_HIT may incorrectly increase for CPU-less nodes
> > because the current logic doesn't account for whether a node has CPUs.
> 
> Define incorrect
> 
> Current semantic doesn't really care about cpu less NUMA nodes because
> current means whatever is required AFIU. This is certainly a long term

I agree that, in the long term, special logging for preferred_zone 
and a separate counter might be necessary for CPU-less nodes.

> semantic. Why does this need to change and why it makes sense to 
> pre-existing users?

This patch doesn't change existing logic; the additional logic only 
applies when a CPU-less node is present, so there shouldn't be 
concerns for pre-existing users. Currently, the NUMA stats for 
configurations with CPU-less nodes are incorrect, as allocations
are not properly accounted for.

I believe this approach improves logging accuracy with minimal impact
on the memory allocation path, but I'm open to alternative solutions.
This isn't the only way to address the issue—any suggestions?

> 
> -- 
> Michal Hocko
> SUSE Labs

