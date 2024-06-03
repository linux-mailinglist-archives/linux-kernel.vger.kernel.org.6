Return-Path: <linux-kernel+bounces-198579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29098D7A82
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC61B20FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12F11CA0;
	Mon,  3 Jun 2024 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eGaCZplo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26408BE6F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386274; cv=none; b=Q/pvBLOOlX4ikB5gzm+qk5W050jB6CcPNpdXbRau9bYDWPikd7w2awWXowdHXuIVpGSCt0K48emZslaRur0kfSTT+6XcqkhXYiO8QCp/K65vp7CYQ9EYHnDRRCBTpZR+SJPKt+vR8Ys2jNv77l0+NUhbe8fzuBjbXL+TXoT81hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386274; c=relaxed/simple;
	bh=znFUGbYpRKAlegfSqWeeerRuiWkBOnNlC4iet/74b3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKYm/x55D09RDg6vvjKoidAaBgcjDnVmoBunlCGB0t6qf74ZOd43Bg7aZMQiwf1n5B3zxFT0xVg/7oJ/JZdeWVeyvzuwqVuu0y2zZRTr1Pmg/7uTOFboKwnLGcbDmWE9/6o1INBc+DjRVnik0wZx1F16py/ub7zsjEvVUN0pSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eGaCZplo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dceef4227so2654768f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717386268; x=1717991068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgIMR7lAAGh4J+AqGFWxYeNeH793OpA5LlJvujR3wfc=;
        b=eGaCZploXdlrjtV+3jhEwrX/NgSrok4Ztac4JIz/b54urfrKMEA5KjulwhNHMQXJwj
         LP4gUabkCDK305GE4XaW8ouT9Z5ggyFK5XFtJV0+St5j66EI7edzShv+p1Fv6kmRy714
         +uX5Otq2CvPzFtDo89NNl/eUdV3rJT4xCCXUM2zoRkgc3om2o5o/T5ilJTHTUoKmO3pL
         Hpjy3s3nKJCCgCqGru4TaKXdcktfA0hdZTmPlA5+Lo4m7T34v8dMe/jIeK/vPtZeG/WG
         fIC5ueI99pe5noOZJyrWYJKjxSqZMaP+XDkoQyYJ8PqGPInik3nNUmT2i2KLAZtvaxx6
         FKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717386268; x=1717991068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgIMR7lAAGh4J+AqGFWxYeNeH793OpA5LlJvujR3wfc=;
        b=YoxQDVuV80j125fXF0kRPFzWJpAvXjMxMpaqL3qoAaTp9OZeO3ou6cQtFUnr3HrqZV
         CIWX3INQfWVWqJrCOy/2kfi6Fc4hMPLTuzu3Ck9sfHdM13C0QaUgK8J4XEg0GgqOtaYv
         mHH/fy96qUoU5TZ2w2clbFWPohQM8b3UxtdPj/33aazDDXVxT2R2c1sGunNA4bcV4wa7
         JzpQJmuUh7ob5Lw7UltyYrtlw0MFMcn5s+exXGSVHx6lsQjNjh/MeBxsthh2LisL3UZo
         bfCHNK9yiEkTYGwb5zUzgzKV+CMluzWqTuSWClT+of/+YN7+YuhL8IFRmrLH993r/rDi
         YYuA==
X-Forwarded-Encrypted: i=1; AJvYcCUbnXpzBB2M4ddrU6aSlvlc2u6ppxraDP8cAsnwxrTyPAbObP76bgKhF668ww67FnLINf7f/MO9kFPHY4R/klONBnOUYoT7DHOpKRhw
X-Gm-Message-State: AOJu0YzEV9j6MG/LOyFZ+yimh5Wplydqwptj21GAxJ3XU0PARGQT4trB
	/g6N67132c1ajWo4LqsXAbWeTjmJMYRCtv0DSmToyfjho7CB1kVEiGR0N4T4uEA=
X-Google-Smtp-Source: AGHT+IEVPWP7Wosv23ZOs/1YIyxVB/64i2JEuUthOQGdc4d/s+Q+tt0bNEjje8lRLexZFB/pQyBmQg==
X-Received: by 2002:a5d:4642:0:b0:354:fb1a:25f5 with SMTP id ffacd0b85a97d-35e0f3186fbmr5274091f8f.52.1717386268435;
        Sun, 02 Jun 2024 20:44:28 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca9b0sm7465038f8f.26.2024.06.02.20.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 20:44:28 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Mon, 3 Jun 2024 05:44:26 +0200
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] mm: sparse: Consistently use _nr
Message-ID: <Zl08GhHQuCHqQhho@localhost.localdomain>
References: <20240531124144.240399-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531124144.240399-1-dev.jain@arm.com>

On Fri, May 31, 2024 at 06:11:44PM +0530, Dev Jain wrote:
> Consistenly name the return variable with an _nr suffix, whenever calling
> pfn_to_section_nr(), to avoid confusion with a (struct mem_section *).
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

