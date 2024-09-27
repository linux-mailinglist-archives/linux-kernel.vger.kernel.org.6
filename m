Return-Path: <linux-kernel+bounces-342159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA8988B11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BF7B21EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEF01C2457;
	Fri, 27 Sep 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6iooL1r"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E119308E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467725; cv=none; b=f/LF8AhkEOPeLUXctDDymq1uMt/FgpJgdRtuBo2aCqshdY8UyBS7NH7Za82BQ8fiRHB+wVIA1putBmx9KD0LizK86m/U/GfMFsclRzZZt5Lutzkg84V+ip0feL3xU3jqo0lbWrbSYwyk8KLPCm52PO0xtanVSEsSLU9nE2Iy9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467725; c=relaxed/simple;
	bh=g/yOOV/8vg6oPtmnXqPFUv3AwPqAR+aIy5ZSDdo8Zk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIitRVNabwpb3QT48YvWbjEBfA6GU20K6pE+YE+ijH9q50ttsGcFbED8HErFlz86mj+cv7wFBZ1BVQvj22amssE1D8X8rlZAaIAf7TybvdTQMO3I91sVhN3KUD5sg2rKhjF1RUX+bd9w2PK1E7Qp78k4W30oz0Py/B1oUFGVgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6iooL1r; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so2153846a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727467723; x=1728072523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFJgiEwrCpsgRDdb5MTnprnwy5n+/XQJCbRu6zFDiT8=;
        b=c6iooL1riBh/p5pqqxfgJA4qZQaIIM5cJYmbb/8+vD3BzBd5GLNKsUBO8FKpMAD9AO
         KgBPV5vQZVvjw+7/Fsbzn4k0GwQqWyhuQZ+N/U4mx/fynWcxf4uslhEkVJ+q4PrJVSDv
         jsezu1C3DWEuupiwRIJsec9cMmXazoegBtWW2VOvRiyP5pZ/vgykyIR4XdTFeIMopEqr
         g4j09lhj4SJ3BNtd4GDi+Wn+GYCxwokHuLZZzOWYj658u6D3t9iCFlypwIfj1PwqUoBJ
         f8NsjrQhL+DF5pmIdhUOmkJWESQH3GRyyckoydU9zUfX09EqOV6Jg6vUUFxKePpXUrYl
         9hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727467723; x=1728072523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFJgiEwrCpsgRDdb5MTnprnwy5n+/XQJCbRu6zFDiT8=;
        b=Ut5umw9Mikk4XALhtmKVTdCKQGI02gXGy2Dqhaayx8S7aEqvQeapzJIUMiZqITIyGy
         jCcsQh7qGCi4uL+747oAr/3gthgFONG/7csjmWvyo42ql9QleLHlPoGxyVJ3iZnU5phH
         9dzpwYvTKWarMvrBCQIDgvj6XaQqzFNzbdCKUSzyC4OP4hyz9GZT53FGVNNS6HTjjTJs
         JoohmrCT6lOQTjA5cCTjMbtU6YdfdT7CQJf8Oyjw03jJB0SPQoPXEC3bw16+GWSobGWP
         nZ6vsAm7gk+hNeyPNfwSGKoobyJ7tPtJAGkp2d/oKPV0CfNfD3O3IhmyOriYx65fAlgY
         3dlQ==
X-Gm-Message-State: AOJu0Yxb4vNiyy+K7zQK2k4qXM0HzOjczof7gvit3Ty/8mnrDDUaPtFb
	JfAmacBWidUVevHOl9n2n8QlpZ0bXgycgmcre2thN4DfwIJIG6ca
X-Google-Smtp-Source: AGHT+IHC8AvJnvJNqN/cPRr60BN41rOXyQy80hhw/Th7csYCCQ+sAP3C4/thTMMMu03x4OBwx/3JsA==
X-Received: by 2002:a05:6a20:e687:b0:1cf:42ab:5776 with SMTP id adf61e73a8af0-1d4fa78e8eamr7112978637.32.1727467722978;
        Fri, 27 Sep 2024 13:08:42 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2ba1cbsm2036710a12.35.2024.09.27.13.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:08:42 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:08:40 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [GIT PULL] bitmap changes for v6.12-rc1
Message-ID: <ZvcQyAw27hdRZw2B@yury-ThinkPad>
References: <ZvbeGKQMC1vFq8ei@yury-ThinkPad>
 <CAHk-=wjS9O67Ue9fZWG4ptc-MyZchqJmQFsMJkOchqpnxc-Dvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjS9O67Ue9fZWG4ptc-MyZchqJmQFsMJkOchqpnxc-Dvw@mail.gmail.com>

On Fri, Sep 27, 2024 at 12:37:06PM -0700, Linus Torvalds wrote:
> On Fri, 27 Sept 2024 at 09:32, Yury Norov <yury.norov@gmail.com> wrote:
> >
> > GENMASK_U128() is a prerequisite needed for arm64 development.
> 
> Note that at least right now, __int128 is marked as conditional for arm64:
> 
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> 
> which implies that we may have compiler versions that don't actually
> support it at all.
> 
> That said, I'm not sure what those compiler versions might be. Maybe
> this is historical copy-and-paste noise.

Thanks for pointing at this.

So, GCC documentation says that __int128 is an extension, and
CC_HAS_INT128 in init/Kconfig tests for it. All existing code that
uses 128-bit types is protected with the config you mentioned, or
directly with #ifdef __SIZEOF_INT128__. So the GENMASK_U128 should.

I'll drop GENMASK_U128() part from the request and send v2 later today.

Anshuman, can you please make GENMASK_U128() conditional based on
CONFIG_ARCH_SUPPORTS_INT128 and resend?

Thanks,
Yury

