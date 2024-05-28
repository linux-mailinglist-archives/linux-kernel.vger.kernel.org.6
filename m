Return-Path: <linux-kernel+bounces-192488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B28D1DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65651285826
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FB916F28D;
	Tue, 28 May 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHgndbKa"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FF16DEA5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905174; cv=none; b=L/ow7b+O3yxUTp8ntCCbJHiw3LKc4OqH8DVwFgHGZKvsbNiQ4TgIonimthxYDbF3PW5DVlOjvmhia4OUf6e0wVGvy+zZHPaF8x3YvhnWoIJxiCRKJavHmoeJDRGBv+Sy1SiwT5o7x4FUtIoyywclY7PV9uWyy9mtnqKL1/wimvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905174; c=relaxed/simple;
	bh=ZN452joR8cCq0gYvyT5tZ9k04wcDCQaSxNmtOAl/gzI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaqYjipNFX8ngpxDRbRd09fxpXMFMHGlEzbSLynDpWPsL5+RN5AgMiEux3UmjTm+u65IfHKJKExP8nlbbsf85G7ncnumgXMYXNzZpH1rDzq7Rgz5HZW9bn3YugcXQAdEoNyGdL1L0NO+85K0PNpX+7ojwiZXERdjcyyFILY/3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHgndbKa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52961b77655so1057408e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905171; x=1717509971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYW5c0SqQbiRCDOIP27l8OTzCGV5wqVGx+nbqnS3eew=;
        b=iHgndbKaXkpcmN1XYxOabDty3eoAt1WScxd2+6gynZufCcnpPcz5+zAkYyz9N0tifG
         cAdLGRyx3xyAPGELhZ3RMDIR3ZYgtBHxXn6cXbg8vJnYWOBYNpFGXcuUjKEnzPHB5lOB
         eZOkIlI8doALUIdrA1u43rc7Ysg5MGjSS6Wr5N/lafL0NIZF2twaMt3itm+197ymRHmf
         8CzjbZ4qWCXnXTElK9LUEfHSH+8J3lNNh2lctpxDHeeW3Gz/g5unkGy4/bYBxPSjbNHD
         pxf7hBzsPprBVRasmMsA2Iwa4Sg8nyfs4zJfay/i9Vqrgo/7CF/eXtooSpusRFjh3Rj9
         tg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905171; x=1717509971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYW5c0SqQbiRCDOIP27l8OTzCGV5wqVGx+nbqnS3eew=;
        b=eIB79Qf++Wt/RGFniVVUHfVstjY0T3/qJFTWhJnOQ+tQ5b9OR+OtIubFsy/kywz41D
         eWrWYrmlx4Z8ekytAHNFh9M3ptaniKhCFHoXCQGWLAK/QCYae5D1BN0bLHs0SRGLfH42
         Oa3usRIT4O/BAekwvZxMlIWGRKYOUgTTISuh5GND4Sn2Z5XvqAZuNtIuPd+pieT+h5+o
         AupSgPj3cPIyw077+fEu9wYQcppWMRgB8bLB1dD1DDvyvIYaYljLAB2VZPDRtS6R317o
         DJ8T3a380KJ8qCtZvWxuRCtw6JqcMzELgzGDHegbzVySBs+XHTvwk5zd2dypPBBD9Qfu
         314w==
X-Forwarded-Encrypted: i=1; AJvYcCUF8+ve7yxrcBOVSGJqUasDB1vKNGIggZLBMsYYp3BuJcYMURPEjU9SZk2xGMgMxGiPVj/Ud/vQgAegFcmWy4o7e6qBC4e7s1H2hG0I
X-Gm-Message-State: AOJu0YwlkAxIxS5+GUCpAaQtBZGVd3cRf1e1CVWIjQPmlFoy1nt3Ut+p
	4XDcRHp6bQPFgK5+3dSUKZ1rDE53lrwI2HkiVcnm0LGsBzI71det
X-Google-Smtp-Source: AGHT+IGudBhWVmM4V0/6WOrMTk8kNuQ3UqybpJ6HjSxLuQNDu2Z1TX4Z93aBTAL4Dau38a0BOOB0vQ==
X-Received: by 2002:a05:6512:2350:b0:529:b6b4:7e3c with SMTP id 2adb3069b0e04-529b6b48032mr2679995e87.45.1716905171335;
        Tue, 28 May 2024 07:06:11 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a640ac48sm703269e87.119.2024.05.28.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:06:10 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 May 2024 16:06:08 +0200
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: Use __this_cpu_try_cmpxchg() in
 preload_this_cpu_lock()
Message-ID: <ZlXk0EyoGDf80Ild@pc636>
References: <20240523080136.9863-1-ubizjak@gmail.com>
 <20240523080136.9863-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523080136.9863-2-ubizjak@gmail.com>

> Use __this_cpu_try_cmpxchg() instead of
> __this_cpu_cmpxchg (*ptr, old, new) == old in
> preload_this_cpu_lock().  x86 CMPXCHG instruction returns
> success in ZF flag, so this change saves a compare after cmpxchg.
> 
Just a small note. Can you also add a tiny difference in assembly
language where it is visible? I mean update a commit message.

--
Uladzislau Rezki

