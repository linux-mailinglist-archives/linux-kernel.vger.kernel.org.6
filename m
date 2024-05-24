Return-Path: <linux-kernel+bounces-188843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AA8CE7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3BA1F215FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C112DDB4;
	Fri, 24 May 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f5sjtkeQ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA512DD99
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564025; cv=none; b=asPeeR+B3zBZwwVD4ijKtxefxjOM+zAfFgejRMflNkUYV0LXr3XgOY4X/sEkqQH8IWLrHjMREG+ocUYtPZvtRorbwUdbTqhWfohEwk+BPOW5Nh/oIZGeTHo72jvvJrdR/tG75diSSJ7si43Jt62+6yiVvaJbMkohMQ++I6+6hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564025; c=relaxed/simple;
	bh=RV6GVQYfwTsyL7UPNTTHnloYfII7Z62+QtP4agNDYW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz8wlj8M/w0WP0hTpcsQWuZMPk5PxAl2KlI+vQXqOebSWcEMXylGPiZcKm0LylCQQvb4+ThrRLY+10H05+pO4MV6hN5ErAzk3bJzaOaaxT2fnJdWmvRConO+d6YJ/+02XRs9qvmi2LUeAPHHpeGW1O4jr+JH1yAfH17SBUc5o+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f5sjtkeQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5d67064885so867572066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716564021; x=1717168821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=f5sjtkeQljeuKygolaCrvo1ieYGe61qKr40rwcvnMvlo0xbxDEk6GstMyMy5wMrisf
         TE3bh4R6QF01+yc2CmRF49s2yNCW3q5+6HX3QFW0ezYTaqgZoH1z0O4CvMMeimKztdOM
         4N+Yb2cv2tWzBJB3YoVlArqs6jBMlEIkyjT6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564021; x=1717168821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANScwS6KgdmEu/PK27HSIOzuKwtA30ga/nb++C3vkQ8=;
        b=FV288xRo1TtuaqH0uw9p6mqil+hHeOttl5rBl7iAr8hU9BmaS3gfF90p3agMmNs8vb
         Ro8jvsOhU1Efz+uo0/X+JlhgihelgZh9dteztCvNK4LTeA9zHTkV9qt1l6gAZw5pPOp6
         8+rDg8v2fZoK3PDEL0QuOVkulhW1RuZou7ByGG80yOvO6km9wlHmMCAu+oCxU21oosET
         vn8eYgJp3c2YXy+oMDtzOz0jZcsIqQ+TSNGiVbjxfZODdOEsM+LFfNWbiV0NbZquoy09
         pANsFxfQ+bLtZ93vdXUNNqaOoE34v6bZ1dbtN0c8zylSEHubE0nkVc4dGumY+XZsjBM2
         SFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUSU4WiYfZ3h58Fpe1lBd2LneokLvs05b3XcpsO+PLVZNjhkgW9qEz59L3LmuN4AH5LEAwxS5CUdwIjOYF5dt4jhj8UB4np4M1wTLsC
X-Gm-Message-State: AOJu0YzPV7ICXrzxQn+tliugD2e4kL9Rmsjq+Rv8KPJal+E74kspULuT
	m8fpws12AmCNwbgVgsq9ohQXJi/kRLG+xaCHNAEWpphsiKZS23mabQh2gmCTldD4FY9rnWUwdAg
	Zbwu2Vg==
X-Google-Smtp-Source: AGHT+IHySnu4KObhpY0m+xiqD6NPW53OpmdWUOZQvYvPCVjYavvHlw48VNYpQuNJPMyjA/yaslhQzg==
X-Received: by 2002:a17:906:37cb:b0:a61:42ce:bbe4 with SMTP id a640c23a62f3a-a62642e92acmr278091566b.27.1716564021660;
        Fri, 24 May 2024 08:20:21 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda446fsm143814666b.198.2024.05.24.08.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:20:20 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5d67064885so867564466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhAfRt2p/CRLVsnYfBbkLQYFIqMAKzrYRk/cZljFsgFc+k2H4hPBO3hSdRekQ//0YV+DPfSNAICy4Z/IjxetQFFeZ5VB0lsJL0yJZw
X-Received: by 2002:a17:907:bd1:b0:a5a:893a:a73a with SMTP id
 a640c23a62f3a-a62641c2e68mr221556166b.10.1716564019461; Fri, 24 May 2024
 08:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook> <202405231628.BBBB9787F@keescook> <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
In-Reply-To: <20240523165418.242555ffc2372e59f88cabbf@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 08:19:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Message-ID: <CAHk-=wiKNsQck3eGc37Da7hAKDNL6S9viwV8ir8BFTu7dsig6g@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, jeffxu@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 16:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The testing and implementation review seem OK.  But from a higher-level
> perspective Linus doesn't seem to be on board(?).

Oh, I'm fine with mseal.

I wasn't fine with the insane "m*() system calls should be atomic"
discussion where Theo was just making shit up. I honestly don't think
mseal() needs it either.

               Linus

