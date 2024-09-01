Return-Path: <linux-kernel+bounces-310394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5411967C2B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E441C210ED
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17706F2FD;
	Sun,  1 Sep 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Avdcktai"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22C1E517
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725223582; cv=none; b=lSwTaTQrYeYXByZ/aHW4N2FLj2zNJWMOQiFIaYTAd0jLc7lAr2b7olC08PZ45GQcwmKOeu8tQURn8jwxixoqXAcu54a7Nh85day5Z9p6MWLo97DY8oU9hr/9gIYuH0QAF4Tv7css+fD0Yt1uZm1x5BDuIkhmWVE2grxzCs9t0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725223582; c=relaxed/simple;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj31m/J+9xmDbosG/LItob+gEtp/y7MN0c5X0UlYgHShtB74mVFELo9X4I2R1Nrv18Bxlaub2MFjHXM4JgYtYgr11WQ6pWZ6dIxQqFCq2vQf59fP15lVtBLy7PG0gvS6CWtpcKhyPDbLdHemRYHQjXZO/xx5LmakBFtn69nTP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Avdcktai; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d2044b522so13767245ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223580; x=1725828380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=Avdcktai2786NDYUQGwR4kIBxj+hobTYkciVjKxy/WhTDScF7LbbPQRbKw+qA19c23
         QBiAr2bj6tXyYVlHGwCiUPX4qu+eH6BbwoVbTwjkfSX5zbRIlWAVe3u5UtksGxBxlRAW
         X9TCwSPBxu6xCESoTLSs8ZQtgK4gQhMYXxfAqv0wdL58f10Aqqq92r16WKZtaAOkbMqk
         N1vYtc4B77pYre7SttohxjBcdUsJu6Lr4eUPUMyaXgYKSmyV3J1XEQZoKoBp+vuX2M+e
         prU7l1LJSbhWmeE5bn3iizYmSABl28qcSU4yi8FGWzupH27ASI58NM+AZaG78+kJ1pvz
         qbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223580; x=1725828380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=lISixOqykSOf/sYOWyn8UBe8eA2DDgLCOe3oZ0CD7U1bGRVYjnlj6jij6Q57gFsJ3T
         tGyLavtiVD7/bWy7JkwUwHDwKLeJArW8gDm0UNuHsEfWiBhIWFnmuxHRowVJaj+d/sj8
         4ZiXTUbulJwd7K+hOSvHxbeb/OrOiB+KwqMB2zP3ybfn3hmgZfp6Q/V/yL21G4XLziX7
         qWn0vbbtSg7LAlnpmhnbrtrJOT0tOS+gvJBULeWuCHJ8ev9QnS7nTgsO534l5m9/Ku0p
         G63pFmDfe9T8Lb20lA6Q1EqGfVmFbYMNRsq3xU5C2nquj9yyepZOUPJk759zUYfR0twb
         JrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4xcesnPAqEy+XPKsjXgVel6dMa05D294rLNKNa3MgS2I2uHESIyiaWdNjNF/TEWPD4+4orfdbEgKvRzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qxdkNBSCAPAEF/f+iLbhezm99q4Shalkz0uDdy6gxbGvL3Uc
	lrB8zFLBbYxwWFQt0UXXUrrQHdJ1eO1CdPCZr2+wI/jiMw5BWXvKY9fDqxYNV05C+4yVhT08eqp
	2eoXmLR7+cvVHDmVWMQE1o+whG8VEl3524xvIILpYY9pj9X6AVYqX
X-Google-Smtp-Source: AGHT+IHmnfShwtx6VepKHMM6i2yw906FV5rc7MZy74a6uTODE45wt5dnmbwXgTLwtQCGPRTV9m7U/TUt1B0c1PKxzLU=
X-Received: by 2002:a05:6e02:174f:b0:39e:78d9:ebfc with SMTP id
 e9e14a558f8ab-39f3786ba0cmr140636625ab.17.1725223579678; Sun, 01 Sep 2024
 13:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 1 Sep 2024 13:46:07 -0700
Message-ID: <CAB=BE-RHBO1XQWyRTJ1=rk+CLSTBrQcmmNONA3TaTshZKesYFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

