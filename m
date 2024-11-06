Return-Path: <linux-kernel+bounces-398694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4E9BF4C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FF11C21EF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99182076DE;
	Wed,  6 Nov 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg9aux9y"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A38C11
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916221; cv=none; b=B4e1mlZHpWh75Y1UFA0hROXswDAM5I+/PsObHH69p+/BQAv0Ia+YE3hDcAuVApzq/FgtRjWtlHZmDrGFn8SqChBXIbn1+yEhbBHha3FQG+jCaMXkdq4+iVfL/hoDOFvwIFcUtRflHhaKFO7shf/WzjP9onjQ2ZYskO+4fC2PYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916221; c=relaxed/simple;
	bh=qAuG/+QhhuMH8j8haSuBEABsjenBJO10pfUr59anNVA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/kQtCRUMjEuLdigQ2BOlTPD3c/Kulh+fYxYye4v1Qf849+j4nKBbquqi+YIdymzceSqf8rBl6RG54b5dREYdcOUJIFxXeuCTSyLzrEas8QOqD7pHxhHbPFXChFcKL6xPfJBEtF4W215opDbqpr+7a72YHEXtM3VpMli6V1aC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg9aux9y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2110a622d76so770255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730916219; x=1731521019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0s4R/31TY/wNxzRn2H7C0FSZTWuftpk+I+0GmvGvJ8=;
        b=Hg9aux9yORq555Dq9WCOR8C3OcS2flyK9Vskpm159JfvpvUYBAdhTKzqjKWJ4rch2O
         tR5u+6GalHWsKeD17CtWnDSeo+ZBy7BeZYxkzbylHmn4hj2Eaodb6O0bpG7uUF7wE4Rg
         W/+QuQgsz/56/7Y/Tq4+PWFrQH0KSuootNxCrg+F5UDZfz8zDIK2swjxhonuKeFPrRlF
         uLtBBA2/g/+i/7sdLH2Nvo9g1u9WMbKhjHGwKd74pO+r3/hUV/5z549ypUuCdWtE7o7c
         cnzF1e7kUr7h3/mv5V0xrIg2+JHqi3uLKvv9RThbrdRSpVnhsevXr7oDXepP0Ac1loFV
         aexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916219; x=1731521019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0s4R/31TY/wNxzRn2H7C0FSZTWuftpk+I+0GmvGvJ8=;
        b=AZKXG6uaqXjMZwjrag/JqpkBJEnY1fAUgcCLcLP2g8tBCXg9MQBTb2ezKoDHzmt0bd
         SL90Ski4S3to4FUT260Hlwgs24kHvORIpdipXcJw+W0AMq+2pvAqmmpUyiQp8q9kpEwL
         th7norQm5Y04X28P61f3jiQLnx7idKFAyLkWJblNwt1VXE9tUvu6RG41j/XAfki5O64U
         T4Md2vYqILfr9tGWR6LbeFQw0hBqeM169v/5oelO9g9sNogQN6YupiV8IsZA9QtBKMnS
         53qVuFnKiQ5E9BDG8njeXwqONRa756ystJ4WkJECb+Zh6ouz12+9L445aQxbcejOq3wJ
         x37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm3RsnN8T4BnOTyyuO/+yEwfK/H34yXAHMhRSgWej2VY0nygG6UfeJQSlykHidnu7JqJ+19WYZ7DPfaT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10rI+HGk+fd56VrZdifEU+BC82YRKWDrfbtvSrzcpnaEGaQc/
	Jfrx9OG0vBkSHZOxhcYPbgOZcPIrRBrEHd5CPiNZ71tHAdEMFk69
X-Google-Smtp-Source: AGHT+IHnMMAPnytuvbpGlsb+8EfIZK4x15PFtNlnmvOVoWx1s9XK3zwUQQBnj/o0gR0RPooKbG+SfA==
X-Received: by 2002:a17:903:18e:b0:1fa:9c04:946a with SMTP id d9443c01a7336-210c68a9becmr506070205ad.1.1730916219230;
        Wed, 06 Nov 2024 10:03:39 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bfd38sm99290205ad.190.2024.11.06.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:03:38 -0800 (PST)
Date: Wed, 6 Nov 2024 10:03:36 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <ZyuveNYLqD1VXKM9@yury-ThinkPad>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
 <ZuW_0fMfPSix4qqX@yury-ThinkPad>
 <Zvr4s9ErpD9F81YH@yury-ThinkPad>
 <ZyuZJoD4hKa3hIvR@yury-ThinkPad>
 <14fd8032-51b2-4182-b74d-699df550ffec@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14fd8032-51b2-4182-b74d-699df550ffec@wanadoo.fr>

On Wed, Nov 06, 2024 at 06:58:23PM +0100, Christophe JAILLET wrote:
> Le 06/11/2024 à 17:28, Yury Norov a écrit :
> > Last reminder. If you guys don't care, I don't care either.
> 
> Hi Yury,
> 
> I'm the only one in the To: field, but I'm not a maintainer.
> 
> Maybe, try to move people in the Cc: field into the To: field, to increase
> visibility?

Sure, moving everyone into the To.

