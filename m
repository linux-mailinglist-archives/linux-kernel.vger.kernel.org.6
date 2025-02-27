Return-Path: <linux-kernel+bounces-537480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D07A48C76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E8E188F7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050B272922;
	Thu, 27 Feb 2025 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izwXnQOC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5F2309A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697964; cv=none; b=HuWs1BW8HqIs+Ziv9UcIPZig/98nxc9TJ7uVuXSGhHitydI6dxAp9Pm+4zkE02BklSTe5ixD/8ttVi/5GRmBoK4TNSHGqfECbdP9XzrmcaL7rEWpY+RZluzI755rm7xAPIT0zoLR+ckrgBch/0t+Bp2FrRckuv725snpvUs5FE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697964; c=relaxed/simple;
	bh=qXZYUb+38s6T7BVpnd2FbZlzNg9yTJdtjrYvUzxnbAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDebrqnfez59YgMjXoKKME5OsOWZW31wLQO/3k89MuW8LW1zvXmCzwczBRMnI7uaPxkKok3DrP77J04PVUhYtLZ6itJsOyK41aMyz2HKhwU0KCVKupV+YpzjUqDnW12wxN6Q3TQ0SHaaRPL4KR7vHLD+P75cqBoxfbWbPscJDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izwXnQOC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso22085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740697961; x=1741302761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fj7LGOSrk0w5SNsFMZf4HWgkzLmJvJuks0dPBWfMtzY=;
        b=izwXnQOC3oezjqJaDBj5Na3lRnnk2yHvqk+RJEanAlTYYOhhn2Ka9kef/IEU+gWPJY
         jFuZsGDIv89x3tezwnqVu081Z091F4RqUEIVa1tZ7cjP1S9EEZwKjoCh70LJM/+zzfXH
         fFazwtOnXy7iZHh6kRWzAiSqLhkR2Z1/RihqEVlGPYd81Xbb6ThblghqXJ/CWCtNDQzN
         hfSLCvM83WRctLrYb9UX9zi7PCvfubCe8YUCgRQNxCpvx1bPMf5qwOj4Ocn8f1Pc78zI
         vRBlMIYn271JM9ZZxLnyU+UoYZMWk0LNZq8+Ii92E+OJM63W1o+gMye12TSaQP+SdlJR
         If+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697961; x=1741302761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj7LGOSrk0w5SNsFMZf4HWgkzLmJvJuks0dPBWfMtzY=;
        b=SJ9eQEJuxfOxojSSf2j0zdXNkO7EBPCPxHdZDc9N2PJFOZ23PXT8HZl+2hY4XlsfN8
         bj2EAdzVCOGiAm5tPAW3d1f4dlcuAvajitbYNfaB5S15Raaiui4DvMPr2C4icyqtCLe+
         OuANL/3liMHxx9HACSSqTnxeK41asG77+Bmd6b2pRU7WpZjt9IGdt2PHAaNlm5/5gu8P
         yp4pJz/S231fl9u658nk8P4+M4JIld591W4wx6V5BttnEOm3C4S4mP8BxcPhCTzBIW2a
         cidbcZFks38aZp+k3DwjgJA+2th/BoEyVwlnNZeMdlg1UqvKC3cnEgu44A3KHgi7Curk
         wtDA==
X-Forwarded-Encrypted: i=1; AJvYcCV2SX/Y1c552ZxKoFuZ4iu7qV5Z9xbYxrjMeIVviw8cW/TrGbW1QUEWh+UV6PDq0h50vKl3Eci41J2Wjq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQW4Z14Oqhqa7g626Oe4pgS6x45mrhHqWmJuZRVR663uRTYH+
	alBRAxLtWOlEbioEiaw53v29Gnx95HZskWX/i8Widw9qiv2dN1EWkT+DRCzo9A==
X-Gm-Gg: ASbGncuVSMKtt0Gso0hfzS/jtO4wCx22kg61ap7oSJX9amkqusQON5EjsZqM2q03uHC
	aon3yxWu8445Sc+ngxc00b9l5BVR5ZZfZMbKo79XB5waQamavroOhUbta7VEEmFGHtRdawY6UyT
	FSwlL3siDP2z4BMECo4eZDnRIHKOnZuFlDoUKXK63lH3I2sYJQmGyUrYN4EScAc3PmMmLy7WrN2
	bzmCxSyyNFds47DYNxN++zCroildpp/zEI6yuMTVhUDKmEpi48qYHxfP3yh9floGPKnNO5nu+t6
	rqBRHIA0zw8N2kT6JV9zLAUcjDqQI/foAu16OeQKW5QIGlYbK6vUx5ztGPJqR3ZNQhFpCg==
X-Google-Smtp-Source: AGHT+IFqQLaqdVWxc8waBGwgBaSF4yEsnQkEr61vpanM2YcoX/7/V0zwkd6V54Vs2QrQ3ETgd2DUJA==
X-Received: by 2002:a05:600c:5618:b0:439:8739:b82b with SMTP id 5b1f17b1804b1-43ba6edd7bbmr333605e9.4.1740697960527;
        Thu, 27 Feb 2025 15:12:40 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm3254105f8f.88.2025.02.27.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:12:39 -0800 (PST)
Date: Thu, 27 Feb 2025 23:12:37 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	suzuki.poulose@arm.com, vdonnefort@google.com, will@kernel.org,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 2/4] KVM: arm64: Move the ffa_to_linux definition to
 the ffa header
Message-ID: <Z8DxZY-09R6lwEW3@google.com>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-3-sebastianene@google.com>
 <20250227202557.d3fd6ylzbaho4pvx@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227202557.d3fd6ylzbaho4pvx@bogus>

On Thu, Feb 27, 2025 at 08:25:57PM +0000, Sudeep Holla wrote:
> On Thu, Feb 27, 2025 at 06:17:47PM +0000, Sebastian Ene wrote:
> > Keep the ffa_to_linux error map in the header and move it away
> > from the arm ffa driver to make it accessible for other components.
> 
> Do you plan to push/target these changes for v6.15 ? If not, I can take
> this patch with other FF-A changes in my tree for v6.15. Otherwise, it
> is must go along with other changes.
> 

Yes, feel free to pick them with your changes and we can push them
later.

> --
> Regards,
> Sudeep

Thanks,
Sebastian

