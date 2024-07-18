Return-Path: <linux-kernel+bounces-256344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C829934CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EF7282368
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE613BAD7;
	Thu, 18 Jul 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MkQd7xxZ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583201353FE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303145; cv=none; b=gfkKo09IujCpoJa2E/sfoj16YZOTIaWxrvdsAJKHVQjyRH9GdhuCzSPgtcWWyaAts84JXiGFr0QNgieEJJF7cwNTR3EJtA1hAHJ5EHZF2P8ILq3MmYVKdHrwnCJyX/tx/3OJ9bvu3/teVl/osghGrc9IhplJ60s5lwOvvgavONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303145; c=relaxed/simple;
	bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oblz8INMZD1Q3EWIxddh5L+PJ+7aSgw7oRSlhshUvXhUvvD4PdsjuUYaPpX3uJwIel88bSYyZ1DCGX+ZliGBu9NMGtbe6NR4WPojl/2Et9uX5VtUHgjU4IrarqUFN1PBUefi9+J+GvN2S2llaqLbUgXC/KY66qE36lpil3wFjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MkQd7xxZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77d876273dso37711766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721303141; x=1721907941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
        b=MkQd7xxZQy7BO1/2k57yNqJt97ibbZth6N1+FF2blJ4tkIL+i22Uad+AY9t+xb0plD
         Ela9CzJZ9Ep2UeVKtLm1bho613KEl9Yh0LYB4YH7aBphO1sJ8eHAW0R8QebTIyKO02Eg
         CScnQCo7ZqgwGD1VFgrgeiUgVi5/qJj/xiAPLC+vM8ThQorJBx2jJNVrqdToxwInLFEn
         CNgTs8XtYomkcIdfyEmtsMQH4SzONAJtkGqahsWDKdiN2l/uJYPaNiLoF6L+v35aOQPz
         BdRpSOIdBZkLtdetU+rhSbCuZgOVMgbii7F3PO4t66umlqO9KPsyT00bOcBD3kmLfYE2
         l0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303141; x=1721907941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OGPBmn7v1HT1nS9fhahCKmtj5g7KxEYk27uNk2Dx/k=;
        b=tyJdTMrfw67XQQd2ATS2QesJvlVYHlN6Yh57Mt4jDI4uB2Sb7krugiuzkQKyKos9Aa
         SJDyMzZCRDgAlRcgaHARncDyC5JvzCE16gXuJ4a80bzLhUvlESxe4yXgD3M1Ci1dx8xt
         MdTVWGSL987Qj8/T+aNgOqKId/dP2B5hlrig++46cfwHr482Wo2Sd4SdwAmLFdvH0jMt
         LAKybgpJGnWKR2TN21XuinBeF4Qzc1Mt0hCN94sFtq9P4IdUfc0v9vzm0BSfGzOzJDCc
         BJC81wwg5zceBQyHLZWmmEbaM/37pAjGhkwTUx19CZV+OgYhbKu//0fq92zerlNDloul
         AjBA==
X-Forwarded-Encrypted: i=1; AJvYcCUF5wZjTWYOM4vDA1gHZPve03YTzqRci5ASrOqCLsZPXyR+HrGImzNJDRrD+SwxfZ37Yk0yujm0LjwKzBFbmRDvnQ/uHrh/V42ngQ9I
X-Gm-Message-State: AOJu0Yw9tkykZDfSY95Rcc1snc8pKanm3D3UYkr9lLnVpBbIqO3dF/4N
	LXwlAUY0fGj3lEs+Yo3HnGC4RGANbTStiZzlFFIuDwPSf/iDQ3EaqO779rSip1U=
X-Google-Smtp-Source: AGHT+IHPdu4zw1VmdZAGMAnb4mmwfuXfp/AC8jcealqbCQKkuxjd+WBHJME8aDdWWPj2OW016A3tIQ==
X-Received: by 2002:a05:6402:2108:b0:58c:7c01:2763 with SMTP id 4fb4d7f45d1cf-5a05d2e006amr4622062a12.33.1721303141413;
        Thu, 18 Jul 2024 04:45:41 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59e663e4a6esm5066623a12.80.2024.07.18.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:39 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:45:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, michal.simek@amd.com,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com,
	Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
Message-ID: <ZpkAYdubmlv0jOiZ@nanopsycho.orion>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240717170043.45aaf7e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717170043.45aaf7e2@kernel.org>

Thu, Jul 18, 2024 at 02:00:43AM CEST, kuba@kernel.org wrote:
>On Thu, 18 Jul 2024 00:24:43 +0530 Radhey Shyam Pandey wrote:
>> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
>> "CHECK" output "Prefer using the BIT macro".
>
>FWIW the BIT() thing is a matter of preference, we don't enforce it
>strictly in networking, it may not be worth patching. Up to you.

In the past, I recall we did.

