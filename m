Return-Path: <linux-kernel+bounces-547052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BCA50247
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A247A5A61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FB24CEF1;
	Wed,  5 Mar 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHAcsRTA"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AB24BC17
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185517; cv=none; b=o/nbG6z6Q5I09V0xtN/MrpndhLF+3HY3gpt+jo8t9aJD8z5JUXt0hg3hJX6tyop7/dQSp6JaU76g/jJALuvQYb9ib8ziIVv/uSeBvXj9p3Dxxj4H3ME5i/L02iWA+USE+TOwwfAeID2vDLht2ZqJ9EBhXY+Cp+DynhnXSJTUNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185517; c=relaxed/simple;
	bh=YvS57e8ESu3hNAzBGbxJcfZx+xnKhbMdFMO3xzI2/y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2hSekKHxWiXAlcHPq7RPeMwGQ5uWHc6zRIMY4dUthwmVKHXsnDE8V1/wXkaIagAveg3Ovkn25D1Rf/NcRlWq49AfFe1uy5eNAelFMxztkO5jlnOB5yn9L7WiRg+0eokovSzhR2Z+dX9OqDwmx/jrg9gnEp3+ignwTxfE3rHgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHAcsRTA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso1372289a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185515; x=1741790315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHAZgZUTDFwSbGDNSh6zOBEYSG38f9voYXlfP6pI9Oc=;
        b=IHAcsRTAkfRayep7MJ5UsmDWYXEkV5MJWtzKTDwJyavLfK2paA67B9AfTt/NHEhXrW
         rHBW+80AGRJDBK28YhRgJmkHxc6hKpTfSQCa5l6xBttQaJL+C4opwXou9GX5SqXkcqKg
         l4hfQ53NONFNBjKivt9zmroPJHK8DLbMes/Wq7cb9th33KGvFb0xlYQ3xvr8FvJ+Zacd
         LocIv7emWryfOID37MQT69i/t8qaYoxWE531ewc2VLVJ4Nqta+BYuPwRPEm4xAcxQVHi
         NMLPolqHCgMXi8ty4dZVHtke6t71CFn9exOqeP7tOCwSRqZz5HAlrdWPNCDjtBJkg/Jz
         kMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185515; x=1741790315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHAZgZUTDFwSbGDNSh6zOBEYSG38f9voYXlfP6pI9Oc=;
        b=IBrNqzf2XK+E0wBxH0lMGNpdfKpdC10SPcYyEQvnq2rCQWIzMsY8DLs0nug+2JC16b
         8H9RYNoyUWl3Evm+f70wmKyVgfb5jPpmUvZxw0O7Y6id/uEzXmT5YJOMiFMPovU9JxfQ
         24B+yfrdDNGYqTtPiWfYaKGT7GKNd0n0LNGsehPdxFPEuND2l97fofZ8q/j1hTvYgqQW
         aifnd2Mk4AwnPmj1rERRIyRjHCs8lHucP6obHe6aSDTo2d29mqtiinoBAuxMmCojODU5
         VgR2rw7b34GXIyIiQK3xzBPMrrMYPyx9Jqk9RNj3KzMZy7ggyJ4D6yjje0Hnom/LuVSi
         KMlw==
X-Forwarded-Encrypted: i=1; AJvYcCUDGk+lQGO90TwiriUjzTktHJTeJ9DEDouMrfxTNmgB4xJL/Sd+uWCt4fv06wz1yfLGQtKqdjEN8whhDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJQjeVVCyyIxZmyqD6H7oKEpaioq39yd3n9TtvATl3kprl6l/
	/Ym49kVYfg7hY4rZPVgNabFHy9QCG9oY4LzJ1v6XDXo6gVNJT+dq
X-Gm-Gg: ASbGncur0gomshoN9osIfS6vjy4aQ96QP/p9pr6Rk/0H+k6AhQbc8WEyMjSoRLuWWVS
	CTXawnZR8wt2pLpH8WXvJOSHzEGdnm2DOPnU8SeUjq14BF1EoZAA8auPavev+m5gRWLrUSJzinJ
	Fl+/kuCWPuOCQs2aDA78h248mtCHdgiwuBewhxapbqWWrMv02Mr90rAUbGu35btiUZPkPmvELEK
	KvV5Xx3mlD7V8/ZLDMYbwgxjqCLJSxehADhP5eqEFz4UwuvIBDDaIU/dbEPULdTqAXnm8aJJ8NH
	OdSE6jsRgMFZor/yF+50pcIEQIOLF3gxsqeLS3LyEp3m
X-Google-Smtp-Source: AGHT+IFsZODIVTdy4Yu9YdJ48Ff3wL9QVGH26zYvwfX2f1Hy2D8uL4un//uW6Hr678bpVZApdOSPXw==
X-Received: by 2002:a05:6a21:329f:b0:1f3:3e91:fac0 with SMTP id adf61e73a8af0-1f3494b6b33mr5017332637.11.1741185515467;
        Wed, 05 Mar 2025 06:38:35 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec49f1sm12031704a12.58.2025.03.05.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:38:34 -0800 (PST)
Date: Wed, 5 Mar 2025 09:38:32 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mailhol.vincent@wanadoo.fr, Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 1/8] bits: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
Message-ID: <Z8hh6BZgD3lmyBKp@thinkpad>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
 <Z8hf_MNL3MeoXW5O@thinkpad>
 <Z8hhXHporoJ6Y39X@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hhXHporoJ6Y39X@smile.fi.intel.com>

On Wed, Mar 05, 2025 at 04:36:12PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 05, 2025 at 09:30:20AM -0500, Yury Norov wrote:
> > On Wed, Mar 05, 2025 at 10:00:13PM +0900, Vincent Mailhol via B4 Relay wrote:
> > > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > 
> > > "int" was misspelled as "init" in GENMASK_U128() comments. Fix the typo.
> > 
> > Thanks for respinning the series. I'll take this fix in bitmap-for-next, so
> > if you need v2, you'll not have to bear this thing too.
> 
> Before doing that, please read my comment first.

Already did. Yes, you're right.

Vincent, can you send the fix separately, so I'll move it in the
upcoming merge window?

