Return-Path: <linux-kernel+bounces-557807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78FEA5DE13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9208716FBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966002475C7;
	Wed, 12 Mar 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+pPJSw0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADD24501D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786369; cv=none; b=KcubNDg/CB0iHrOiKTvXiXY9m3fg6sCrCR99HWdVquyf1uyUGgcjAWjVL56Sq8j85N0LqX2Y40XYERdPhWRNayxMZBWrKyJvwfW5XCsG1duMxePl5DcrYAPn8+e+Hp03dSWzOf02Lt2eQHjVqNHie7uufQACSGG+xz0mHejg8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786369; c=relaxed/simple;
	bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIGdVf/pZRQ6vPYK3xNxtL7DNQ5KG8DkGkD90K+MKHLFAQhwN9i7bjYaiL056G775yUPKgl9t6wccuJtuns+wa4J9B8pSfFNn7xJiuSWdfc4Hxvd5uA5b0KBeM2jAenvLosm1ql6ZqLpnUBzYNcskSYIotVdoCuHgpCjM0vWCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+pPJSw0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
	b=H+pPJSw0MAsBx6VtH+hf2JRVjWgjQHSLvr4Pbc8wh5X2QpKp3uDJwS8fHicwuv7dbmApP9
	vXJG1Sp5LaoycI+orr6zPwkCoossU89hp1ui3y2oOGbYpxpZqiF/ZfUdyBpEcLg8slCvhy
	6WeCjcoLNFUw4faZHMAT5S/F1HhlFSE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-DOZ926roMtyakiUIhXH1rQ-1; Wed, 12 Mar 2025 09:32:43 -0400
X-MC-Unique: DOZ926roMtyakiUIhXH1rQ-1
X-Mimecast-MFC-AGG-ID: DOZ926roMtyakiUIhXH1rQ_1741786362
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so21881375e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786362; x=1742391162;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0HQy0k5w53qyMHQeW87mKrINhCTs1ce/60tyzHSvj4=;
        b=nWK4MFynELrJGpnCjh1Vh2e8bbdX5xFmC1JVZBMDJ0JFlBxLXJGlkbTZye6mFjf1ih
         Dhw8z1eJd1y/m0AgxLu/tXMfOm35peC+Yn+ibg053Xcw/ej4kuR5pWmTbPx7YKiWUoEI
         jn69fxC1jolzKL3vrZoxLbX4uQ9MDkPs2fYZweNHHsZPQkWyQFUKQW9xvFKWN9UqLBjg
         S39jeFwnYZxYzjTY09sCl1c38Fua3ebwAStkgsST3Ttz719R3xCGFAXENVaEn/03ycNQ
         2PvxjY2tZ9YIfMZh/ZgNus6vh8CVceIla56yRtkyDOIYOXSj/3ofwmi/PEfDwgcr4CPF
         P5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjEhwH4vFrdMg13ltqjqbGo2rTIJWkzzBs+hHRnzjdS2X65qccTjp9vWZT6n+xDyxiTwxK1icLddDu2PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxynqhw40kc0a5x0JfWwmiY6ip8FI37PXST3GgYChnVvZ9GpU50
	soZBaRsdLGHXcQJXO1OssRkLTS3uX3/TkUrDsYmeoJhHdWhsdCbODG4qQjwy2frR3p02zqmPCVU
	K94epEt2eLp2AbDb62GSrp2/Zufh2n98F2zSp9OzuRv+eWScL06bzgWdS98cCkQ==
X-Gm-Gg: ASbGncuVKuve9cit9CeroScfKfdbMHb7c3I2uPcUfmQmv2VSYtoi1x8mFvRzgZhCmFo
	6cHCHVG6PBuKDX1dd9YedpTb8fHFSUnTNRu+DmDbPR5EKo4xbNqbTRRg0WYhe9A0+OIEMd/q86E
	3LNMAqm2h6KfrQuraPRwMp+Tp77F9LGpVoPkIpdjcot5pVqG32MBPhyL4Yzq/vzPOv7df3vhdtT
	LHOaMjwXvQlLBOq7MeQLlF1Ul6zGHdOFklYHfratkj1PUMb5SqBBH6FsV7+Vz6UMbM5a3/FfTyC
	yAUf362lSxaoWr3878CCwD44uXK92yxtnOrthE5ggM/DilbaIz2UfYTWkmy3d/VoDOW9EDCU+PB
	y
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id ffacd0b85a97d-39132d05bb7mr18256099f8f.3.1741786361776;
        Wed, 12 Mar 2025 06:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBmYHadL05QdCXMwWJyreltC2sDc+Ii43t+J7joC9A2cXjFamelnxdyrEIk6da1YZ5loRJYQ==
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id ffacd0b85a97d-39132d05bb7mr18256073f8f.3.1741786361444;
        Wed, 12 Mar 2025 06:32:41 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm20982120f8f.0.2025.03.12.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:40 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
In-Reply-To: <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zp5ej0shjk-rT@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:40 +0100
Message-ID: <xhsmhikoepe6f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:40, Juri Lelli wrote:
> dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
> sense to move related declarations to cpuset.h.
>
> Implement the move.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Reviewed-by: Waiman Long <llong@redhat.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


