Return-Path: <linux-kernel+bounces-348971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB698EE9C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8AD1C211FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F40155330;
	Thu,  3 Oct 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dvWdm/8b"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FE15573B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956620; cv=none; b=C4dQEKDtDbCFLqCCJ9+0cLZZY0puvnheuxndUfUPOxx2idCgNy4LJrY02kmKduNUyyq97F5tqEDsfj6SsBlYRGBxpMgGXLyR4RW2+m8LMRkBSSgF8GuDB8WHGfu85mBM4vGAmgtKzW+gIaFGl0G6ZPa0PcMHhINWgi9MciBu0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956620; c=relaxed/simple;
	bh=/gi9qlrt440LOzNu5Rf+lTXE2gSw7tDfJPv+GvPP9HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkUIaNIX/eZr8lN419IJh0/wQ38Kx1OGd2I+kT4DfXxP7StCyT7v3RcQzpViqXFirxjvgC8ufqeydjnhWUTKl/pu5CKZdM37dF9+s9l9d7kmBCfj7UO1xjTweXlWPfezg2Pwl0i/NQf+FILiLoMWwfRjEwN98tC7wdxoJCCJmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dvWdm/8b; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso13113781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727956617; x=1728561417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEIm+V0HVEumHxJE/X2zGEG++sznEkEVsJ4nCX5J6Rc=;
        b=dvWdm/8bgBaOOoxhkFNcVE71CQxutVaz2tHim8E4GJlMOa+fInwNPHsLn0jyvn4iSt
         CqN2SMn1Pb/aAgrhjsZRVWLGCuxTmeT2/wnfGGJZFEVykMXoxTcJc0nmUAW5D+YrG7ez
         bvm6v2GfcqBMQIEgwlEmoXw2hTBriW6xpvZD4lh/6PewMxXeDBxYKY4n9Ldtd/IK+iVz
         dBN4lbFCShllniujwleJt6bY1MHQZKFVN5ywdT7xMd2lxbErt7e5FADgi2VJpBWWUxIB
         8w77OOnV8Uh0uZQMP2Cog+d+HlahB/3eezy3rjEj9nGmBabxD1IKBMxdwWBAIXVtzmTD
         tgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956617; x=1728561417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEIm+V0HVEumHxJE/X2zGEG++sznEkEVsJ4nCX5J6Rc=;
        b=a2DRTpTtVQAP6LeByFWDIYD4BJZnWFdx3lodUgbwF1lnbXnRnXfvj4o03wQYy4rdA4
         ocBwCKt/0dzC+j0NcVU/MeUgrL5ebr48owqxoiguEjwOTe1knORgJ/aakAzXWjpgOCvd
         a8V4Gc5gIDthlNsHBiiRMVfJz344nW28eo/sCWgmrVcPwdAeFTj/YG3f9PEAu/XU6ByN
         BcvwmbGUTkZav+5vk8fIdk2GFERZxz62Qx4VOMfiBgn2AUIYsQj4J2MvwU3sQekD5rUm
         naPT09QtGDRH7mAfRBk6383k1RnmpSUxB2EdTBJZoY/uYRiBPsbGVXtdH+JALVxsdSjQ
         LtxA==
X-Forwarded-Encrypted: i=1; AJvYcCWz38rybWgTgcGMUFD9yqjIg83jyTSwPQzU2HiDXx7qpWClx/yuGArJe9FiVt99SLO9Oz7qDjdkJQAfTd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1K1232i98bd9des3bFPOiQkUBSB0p+2sZDU724MUXG+Xk8lI
	2HNCjk+lfraEMS3eNJytJRAkZRTYwO5j0VMpaRI96c+1+7TLzhNjswWuTodzt8o=
X-Google-Smtp-Source: AGHT+IGSqIGJXAgMoHGlqejYWmgnGglmufWBUzwpKHV0/qcOctHHorcg91PB3iu//oeluOcFV6pZWQ==
X-Received: by 2002:a2e:9907:0:b0:2fa:bd56:98c5 with SMTP id 38308e7fff4ca-2fae10a628cmr49809591fa.33.1727956616971;
        Thu, 03 Oct 2024 04:56:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a5d60sm76891866b.62.2024.10.03.04.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:56:56 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:56:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: zhang warden <zhangwarden@gmail.com>
Cc: Miroslav Benes <mbenes@suse.cz>, jpoimboe@kernel.org, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/1] livepatch: Add "stack_order" sysfs attribute
Message-ID: <Zv6Gh4c66aS-X1Fg@pathway.suse.cz>
References: <20240929144335.40637-1-zhangwarden@gmail.com>
 <alpine.LSU.2.21.2410021343570.19326@pobox.suse.cz>
 <CADDyLDU4Hsp-FCjocEyfEmY6-JOKeH+YjsBfUr+xbO=opOEhgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDyLDU4Hsp-FCjocEyfEmY6-JOKeH+YjsBfUr+xbO=opOEhgw@mail.gmail.com>

On Thu 2024-10-03 16:06:59, zhang warden wrote:
> Hi,Miroslav.
> 
> >  could you also include the selftests as discussed before, please?
> 
> Should I submit the selftests in one patch?

I would put it into a separate patch from the patch adding the
"stack_order" attribute.

You might split the selftests into more patches if many selftests
are added.

Best Regards,
Petr

