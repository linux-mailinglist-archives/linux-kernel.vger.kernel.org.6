Return-Path: <linux-kernel+bounces-221543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4E90F530
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C555B23CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E9770FC;
	Wed, 19 Jun 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="afYRtueJ"
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB21465BD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818468; cv=none; b=HRyGG0hf0pgxOBOLcDjLNU+hKam2FPhvAGnzQPEbcsfDI/bnPW3o2zmOg8ZsbhEoypugHFVWukSKxGrQDikJUXN0xvgUYUlqdjrTyGC8J+sq86wDfXksSloavlS7iL5a4vMeG2puzJLkpPxTHTH59eMx5UqurSY+itC57znfVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818468; c=relaxed/simple;
	bh=PlLIbdgzHrTh195wF5bpGy1UJbDEpvaT/xSOVcbmE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvKplhtXEAxIoRUtlSQsRixc90T2XB4k5PQ30NpSR2n8zHz73BN3WcxOyOk5G+6/G09Mi2A7reiahK6eJHBrFJLA9ikbdl0KTQLHQ3Qx/NzyfncovXa0DQ/K0WPVULj4ZqrZGGl6CLDv0fqIIkJ9KZo31QEagvyNL3XKNIQwj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=afYRtueJ; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5baeab9fd60so1835eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718818466; x=1719423266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BypG17i57qT8XQws+/rRKdqbhl8JQ2/+ZrhM9EyBYt4=;
        b=afYRtueJU99fGkCHwsbEfhTDennGz1fStqKiMRqJY0iBfWmwZhzvXFpRJ2/7v4XPFy
         DeZhcsHdwxJ/WTD5WVpyMhGK5KyOzZUzYDD4NJJj/zMH0G3AmMPx4/+v06sTQRnn9/GG
         7+G5BSD8UnmfHheZs3LONhxAFBLmCfXgiTAG9dpFsvedWprlfgn4tJqzi6AZmK+DNQZn
         kXPtiNvb8r0ekkjAxkAb3IpIE4VDx3Qd7EQ34j44QO6xdz6wdXL2quXNecrUhE02HOq3
         QphJZjBL3ajr0Hl6WPj/fJEmLXx3xV+Fdd8tkomiLgHiIjxGzb7jeXfnEL5bVWnmdYyD
         zZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718818466; x=1719423266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BypG17i57qT8XQws+/rRKdqbhl8JQ2/+ZrhM9EyBYt4=;
        b=cNSdKSflDTvchgaZVKW9vyqLR8oosVzM863YHnUOnmU0ozU4V7HPLNKSSiVfOZ3wfO
         rn4omNOyUBlDfY9RQ1tVpRjoAw84PMY4gWHo2Mz1f2Xp4CrZIgWrn5pEL/tVT9S7cbCW
         2HLwc8sQrQtku9ltWYFvd9txO4V2ZtJSEez8bLZmPRBar39wRAFipIWjWhhRikh3TjeN
         M9bMKKrSMA0nLuUNdQpe2msnyxW3YMCrST/3gKvtgtOqTGEqspvsEXvGI8zqBwMxJ55c
         wN7IgJjPyu4KgzqSRyx+B4r3JN9Y0EZDs+Lf+ZOFEJvRYBlaQDHlmkfEQmamXLUL49zC
         laeg==
X-Forwarded-Encrypted: i=1; AJvYcCVA8xa5/Pu4xvvT9PuqvOpVGMzD+j6+oJ9gJeF9wLDOiokZ2gtycgss1zzAjSMyLVJCiJjBDDktZ+9kZwbyimirCABwAIng8/ltcjxV
X-Gm-Message-State: AOJu0YwjibNKBvEgHXCoxuCSXbKFKYBrlmhyODSO//v++x4mglmZObed
	DL7LsPWFNvG8VA59xjCcB0Nn6VLWmAMQ1299dKxXnbeFALqSoDOjrYAbn/jkEXs=
X-Google-Smtp-Source: AGHT+IE1e4lPPBTUe6KHIxVVQdIZAN8ko277rdl1epOPRqqAKX7Pxk81ZlvHJ+JvK7AsVQ+/w9oyyQ==
X-Received: by 2002:a4a:240f:0:b0:5bd:c651:eef2 with SMTP id 006d021491bc7-5c1adc0d673mr3781128eaf.6.1718818466098;
        Wed, 19 Jun 2024 10:34:26 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1a3e7291esm477776eaf.19.2024.06.19.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:34:25 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:34:22 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnMWnkR64Q-iq-4L@kf-XE>
References: <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
 <ZnIAX9P5XSco4cZw@kf-XE>
 <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>

On Wed, Jun 19, 2024 at 07:09:35PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2024 at 6:33 AM Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> >
> > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> >
> > The _OSC is supposed to contain a bit indicating whether the hardware
> > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > be considered absent. This results in severe single-core performance
> > issues with the EEVDF scheduler on heterogenous-core Intel processors.
> 
> While some things can be affected by this, I don't immediately see a
> connection between CPPC v2, Intel hybrid processors and EEVDF.
> 
> In particular, why would EEVDF alone be affected?
> 
> Care to explain this?

From what I understand, the EEVDF scheduler requires ITMT (which in turn
requires CPPC v2) in order to determine which cores are performance cores
and which cores are efficiency cores. When CPPC v2 is missing, ITMT is
also missing, and the scheduler no longer can figure out which cores are
which. Thus on a system with many efficiency cores and a few performance
cores, there's a pretty decent chance the scheduler will put an intensive
single-threaded load on an efficiency core rather than on a performance
core, which has obvious performance implications since efficiency cores
are slower than performance cores by design.

A good example of someone else hitting this issue can be seen here:
https://bugzilla.kernel.org/show_bug.cgi?id=218195 This issue was brought
onto the LKML here:
https://lore.kernel.org/lkml/a106fb4733d0a3f0d6d5792705cdb5cee13731f8.camel@linux.intel.com/T/
Srinivas would have more info here, but I do not have his email so I can't
CC him on this.
 
> > To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
> > which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
> > enabled. This allows CPPC to be properly detected even if not "enabled" by
> > _OSC, allowing users with problematic hardware to obtain decent single-core
> > performance.

