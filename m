Return-Path: <linux-kernel+bounces-345776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBA398BAFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873141F22804
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FED1BF814;
	Tue,  1 Oct 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BgGhfEt0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FD1BF801
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782032; cv=none; b=mvInxVbyoebBtCsMgiXWI7UsIm1FuLe5kZ1RuIy7iVTQTAB8KdfUsSrVCIYlJ5yzmjtkafCkZQmfDpOmR5SIQ5fbFqQi4kyrAScaUnO2nwsHtXGPpZYBgsigDWdk/1oV9eR5CPDLgi44cmohn0xVZZG1bchnH4JdHIcEOVpB+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782032; c=relaxed/simple;
	bh=P4I54XKTZUlYV4aXQ+nePoFMXTHtXo2bELKDBI98VKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVTMRElHjebui+4pWAryzaZXvMFVIZ5xihnMkL3JU7O1O5Ds+OfhM+JPEjalSFzSGDCsaY4lAOlAZzyp163qBvSpqJrfq6O0X2R+g86bj0uvv3bTTuI4ScYjDy8MAdnc3DNu/aKuXruwbzcd9evteO/o1D5a9ZbmCCDg3h/Z8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BgGhfEt0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so5467397a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727782029; x=1728386829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU+eaXN2VMQr/CnUSjzwjuqNMWNk8qK3UkmQlUys5GE=;
        b=BgGhfEt049foYjzTgBIM/vpiQS+sffXdAlT6FPUcoQtKwDsVlnJFy1QjtW2j3Vv6UY
         v3AwgApbDNmUY6YPk0Us2koxPECX2aWIWmx9rVJIcA97BAbeXSEIasHzcpjpdUwLb7bX
         MjCyTm8OpyG5MPvWMel7cFxQ7PkZU01BQ8/1/q149DNunqM4G1zOBDIo1aXteFwFP08j
         QdEr22y5PBiy/k3B3d3EpSdlnMubEEvh4666mypE/vUQdkb37wiIvgvIIIYH27TKNkWc
         774TuU+I426TJ7VWXEoWTEkJr1WSE2DhFmlwAHYmsqokW1HBA8SkqPhYopKp9D3IaU1N
         DUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782029; x=1728386829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU+eaXN2VMQr/CnUSjzwjuqNMWNk8qK3UkmQlUys5GE=;
        b=OHXnQEN7RhExmZOrlS/ut14E2BrqBcG56OoBwQ1kRw+vNjjWGyIXgFeKdCKtr94pDc
         ZoS0qK03idD+sxzZWtzifzbMh7/r3wzKd9xA6/I2IyXiXMN+o6WCY/Yb6bePspc51yb7
         bz1YxrE19RlnfRGS9uS/EJyYyi8TafkU7tPAGK8s+Xad58zHMmLjp+neofaTepSArv6f
         oJkdL/5I0vWbDS0ExS4AqhVvw1veXaBVDrC+4SipSLQ75C2SviGYQvEvSakjvcoGBcCx
         rNvM5KfeFoNt0VIbfkUD2LT185/siWkb5tV7xpHuNgcnofFrWYYqQCuY4I9/XJARnZ/G
         iSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpr0eQToSuXiOfEiuGmsUl9FkdAWJd0+UoTs24Lmrf4aarZubNz+mmc6DzkszwgfJLOJiZt+NC9+KWGtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PRsqBeW3upDIusF6OGV8CtF/kb3hsVapyWJk9exCXjOFiR9K
	LBtM7yK55o0wr/8MWn/BAbollPwsU1UvcZiHCwUCOqYOTZyb0jZzBS9DtKwcHOw=
X-Google-Smtp-Source: AGHT+IGrqXcAbdFf9QfytWnOzYVfkCZaMgZP7PqvMbIGb/jRj3N+2vr1wO/ZYV95hqZFbJ8yMKwlgA==
X-Received: by 2002:a05:6402:40d0:b0:5c5:ae24:4616 with SMTP id 4fb4d7f45d1cf-5c88261a9b0mr12454725a12.22.1727782025094;
        Tue, 01 Oct 2024 04:27:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88640fe9asm5019913a12.82.2024.10.01.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:27:04 -0700 (PDT)
Date: Tue, 1 Oct 2024 13:27:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Fix signed integer overflow when defining
 LOG_BUF_LEN_MAX
Message-ID: <Zvvch303oFPCZnJ-@pathway.suse.cz>
References: <20240928113608.1438087-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928113608.1438087-1-visitorckw@gmail.com>

On Sat 2024-09-28 19:36:08, Kuan-Wei Chiu wrote:
> Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
> leads to undefined behavior. To prevent this, cast 1 to u32 before
> performing the shift, ensuring well-defined behavior.
> 
> This change explicitly avoids any potential overflow by ensuring that
> the shift occurs on an unsigned 32-bit integer.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Looks good to me.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

