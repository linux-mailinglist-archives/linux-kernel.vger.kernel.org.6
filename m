Return-Path: <linux-kernel+bounces-414587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583809D2A78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074971F23243
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE711D0B91;
	Tue, 19 Nov 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl/V/S7d"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872ED1D07BC;
	Tue, 19 Nov 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032392; cv=none; b=NkXv/wGMbP33mZ0zGAYwQjShWvsC1YG6nhGPFfvggN+8nSVPjSYsIHzqu5iKmaD33WJaV7Kw5YmJsa4AcXeKHJ+obMkRU1zGmqUMydEWj37iOzo1QU0hgnF/yo6BSc8DoHOBEt1bamp1IdWSE/aXJWzbhCGkJ2WGo9jWTQjB+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032392; c=relaxed/simple;
	bh=ZKv5GtAk1wlTkweJCLorjjjdX9tct0ggHi3t7wulTZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvltldACGU30RsrLQEwXCGUmIUcf78XbIKCE1dN2Be30AOpn5C6MBxiBZoIegikLC/VgVDURw/k0kl98KxkI9iFWtQLNoRJE8rNyPEgU/BlXmOjhxEOixqdZXvE0CdynBnAClHOCKU4Km1gLJ//FrjEosvJuCtfsvSgUbKiCC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl/V/S7d; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea6f821decso945646a91.1;
        Tue, 19 Nov 2024 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732032391; x=1732637191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3cjPDRFVyQh9VSAHKzpHS7rRWTaCmgtsTMq+Ic7zEWc=;
        b=Sl/V/S7dHiavgMlbv23NtbuHk0Qo+VpVXq+NFHf/hrgqBVGRXPw/f2jXMng488bnkn
         GR0PuaoMl74MxFhTkWR8jnZpUusPlFefs3YqgV6nvT4hV8MT6nxMqHt6HdFFsmMPFV8G
         7rOikbYC43o8T8xOd3Ju6XrmyS5TkF+g3ekSnpJ8bnuvozkgm8iAdrEkJHM3VvbAL+lP
         TSx3eIKhWNtSGkXeCJ4MV28oFCBuljDP6n8eNBwoDVHDRe9YkMepfL6Y/N5LPKJrmmhX
         Kc/m4xRTCmClQha9yb1EES1PjzHJqkOG/v390XOH3+B+02EYmFowaJ0tJovuiDXmOOXN
         xbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732032391; x=1732637191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cjPDRFVyQh9VSAHKzpHS7rRWTaCmgtsTMq+Ic7zEWc=;
        b=uhAUaQABSb7PDjrk5Umv4aaKLACu089n3QC6UL2WYQLtHLU+PeC4ZShZ1fnyh+tkwp
         EVUAWuKAHNSr35sX1gCjbBPLZOLL9N8fNfiAHaxeCI24ArGYhs5ftWu+qImCTkzL5Rbo
         PWJ8hiR9e3duoLLgxXhyMhYYv2lGg2Oc/zvH4MgvAmLSiF0NGJ2SyfMBtT+MBDYk3jsK
         oYFWflEUM9h5ytxnuEp3XQE3/TjxvmInyI0CLf4lylPP7SdNGPOw0+7itFEu278e3RaX
         dmV9LKvy4ubSRKGG3+JkAxeHuK2IyGlgiAmzER6fV5qe37JbppiFnIyJmOrDohtgJXwm
         0xBw==
X-Forwarded-Encrypted: i=1; AJvYcCXYr2n1ladgu2fSyDeSIZamlZAcg5tZZslQCqZVtprPzq1iAnJA5C9UFvO6mv24eezChov+i+rXpiNwFpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBSLyFtkTFfqjcYvRZ+0q1EoXyFZzOq7VYsbYQhAtzI1xb8ny
	cHMsiGA/k4MSKcH0GKN5RtjpB+fMjxFZ9H93HmRIWXBtxcSVqKKt
X-Google-Smtp-Source: AGHT+IEgFKyYzpGsxHNa+y/3u3eTy8XtyQMDwlKuSTIiYbN5ggfTJzeiWGCrGV9pHejHB8ReTGQ2Qw==
X-Received: by 2002:a17:90b:4ad2:b0:2ea:670c:c6a2 with SMTP id 98e67ed59e1d1-2ea670cc714mr11009755a91.16.1732032390694;
        Tue, 19 Nov 2024 08:06:30 -0800 (PST)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea47642a22sm5685269a91.8.2024.11.19.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 08:06:30 -0800 (PST)
Date: Tue, 19 Nov 2024 13:06:27 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	LKML <linux-kernel@vger.kernel.org>, Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 4/5] alienware-wmi: Fix module init error handling
Message-ID: <tuqhdoqturo2yjqcxgood3xagjloctouuxc4unqwdy3uqnvjau@xqqgw6jb7ztv>
References: <20241119043523.25650-1-kuurtb@gmail.com>
 <940b49da-cbca-42d4-9a80-501465bc8cbe@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <940b49da-cbca-42d4-9a80-501465bc8cbe@web.de>

On Tue, Nov 19, 2024 at 03:55:08PM +0100, Markus Elfring wrote:
> > Propagate led_classdev_register return value in case of error.
> > Call led_classdev_unregister in case sysfs_create_group fails.
> >
> > If alienware_zone_init fails, alienware_zone_exit should not be called
> > because the latter unregisters/removes the led class and the sysfs
> > group, which may not be registered/created if the former failed
> > prematurely.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12#n145

Sure! I will on v2.

This might be kind of obvious but, if I add the Fixes tag, do I have to
make the patch over that commit, over stable trees or leave it as is?

Regards,
Kurt

> 
> Regards,
> Markus

