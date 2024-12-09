Return-Path: <linux-kernel+bounces-436910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4759E8C86
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB883188646C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586F2147F6;
	Mon,  9 Dec 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRbvYERj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC315573D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730349; cv=none; b=UMvDC8NCQKERUzySmVIFkAIqj3CXMuOa/anm7hOedN1vUxD1NGVkeqpSQLk4gfSoz+eKGABBpTgcnwbC0UYUH3svgQNPt8QxjY7XyRA8ZrAzsy0/ARRd0ODNMhnAfIJumTdeWejMf86b8ioyHNY6RQhsf8/mKU8p5oqwNDORak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730349; c=relaxed/simple;
	bh=wS4LPcc/u+NnlnkZkGYnfx6MpJK7FoHRFQxSj4AUpgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7gQ/ZJC6YhM3KvJZVttg70nV/gsJ6QVN9Lakj0/sxGjYeKPHsSi+kAuqj6XgwHP8d9X1f6e959CKeDhPoqXUALdFIdXQXHb81ZUPHG6BXohtt1Ir1hIzs1TyCBes28744BgpD3FKvMkMINeWBagYO6AyfksPe9PugIuXNfk4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hRbvYERj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so906476e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733730345; x=1734335145; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=95zALzZ9C1moiqNGj+0dTUHzbbBeCCJ9ZsiPoJT1Hrc=;
        b=hRbvYERjX+OkgTcSer6snkIb2YceeDf3xNGj2deh1cYaexU0qGrHgyrBuwiTevvAqw
         5Yb69mqK09gd5P2h5c/MwfXLRtcgwaTXLtiICEarSnJE/Sqfcf8BNle7IvzOo6/VRccf
         5jqQxhJM9KhSqOBedN/Fm1i4vd0JaMmnwEipq3k90pX9NeXktG8oPKr4T5frbVx57C+H
         xvnZgr9AiMvEJtG3jwuhfcEd7RzU1+St6nv2yn/FB2zK+Fe73zkxOTtFXxP1mJojHeFG
         g6hIycCkxb91Q/F169Yg2l3HFeCfAZNqXWmKSzkAtVRwqRSwWtLqrdtMCaA7ukGVkQvc
         SiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733730345; x=1734335145;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95zALzZ9C1moiqNGj+0dTUHzbbBeCCJ9ZsiPoJT1Hrc=;
        b=o5Vqm44uwFVbm477fW4+EjhjMSbR50xuLrrIWo2n1gFh24kT28WU7PSNQSZEsU5p9l
         A1lOndFRUa5Vl5eNi901Zz6mvvu8z/iNMa2AeQvLB2LupWFatfn0NnuegLfhwcR+UEqa
         cRc68e5qVhvQgJSiUh6NVEKYH5uRhaBMISJB7oFNHlfh4HSD1ZhZAl2PcApau6qXi+8z
         ncqfYdpbjbOl6pXbhf68cC0/pHWoyA/5p/Q/7lHwD9nL6n1ntAyAiBHkrtG1g/SUmP2Q
         MXeJL6l+J4nMoiukW1T4BUWmYNWk1b7KW+3//6S6x59BolG87T8hoaUCdST93akhSUed
         ntFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYX7Q4KCPZfEBL9FVRO1frSjLQUrvreGbdKZAeYD51d/hsUwnGfFw1TsXCgrSliQ5eAxh9ABRDRY/bc58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRDFU9kaMBg3drql5mghl1g6pyUXOJg4CFmD6888XO3Z+VFOG
	ZBeMfG93DmrtBdZizASsOrJLJWYeu6M/z/03tS10MN6jlk2Xh54yieJLDWr1BFpm8DefhT0BowL
	2
X-Gm-Gg: ASbGncvCG0ttZTessJURbMg4+lRGN1BAxa0NDjkfkIjJOIdfFDdNCi0SYY2ROiGojFl
	qKTrNwNzUtSai+BQ2Mf/KxHwnt9GaUTVdqykGPuww0Rdtx1pOggXvlZLNyJKn6ROCbQ8cybEcXP
	uw4E4VMhfSbmkid3Lc7RGJK3cPK3ipngQkeLYesjso0BuJBlgUdOtSgVovzibTOy7GM26Rxbr5p
	jjWeMer5zK0ilYdTLnrLNr+a04QmvnWl0GtWXB+abbtmCwg4noH3Os=
X-Google-Smtp-Source: AGHT+IENr6dXfV5Cj+7nBYzPXMOegzBfhEhe3lfd7H0VOqbFt4Ej3IU9BHMTxGGVa/FF5Ki/41qtuQ==
X-Received: by 2002:a05:600c:3ca3:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-434ddecb0f7mr84483155e9.23.1733729858220;
        Sun, 08 Dec 2024 23:37:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f7ec35b0sm25804105e9.1.2024.12.08.23.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:37:37 -0800 (PST)
Date: Mon, 9 Dec 2024 10:37:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtdchar: fix integer overflow in read/write ioctls
Message-ID: <0bc9812c-135a-49b8-aed8-67ee4e3d6d6d@stanley.mountain>
References: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
 <e3da1bba-9740-6b6f-385a-1bdf25f056a9@huawei.com>
 <6b4f7a14-297f-4fc7-bc4b-a9e7d822fb23@stanley.mountain>
 <fabbceb3-90a3-2cc8-c664-e53fcd504393@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fabbceb3-90a3-2cc8-c664-e53fcd504393@huawei.com>

On Mon, Dec 09, 2024 at 02:27:58PM +0800, Zhihao Cheng wrote:
> 在 2024/12/8 1:05, Dan Carpenter 写道:
> > On Sat, Dec 07, 2024 at 12:17:33PM +0800, Zhihao Cheng wrote:
> > > 在 2024/12/7 4:26, Dan Carpenter 写道:
> > > > The "req.start" and "req.len" variables are u64 values that come from the
> > > > user at the start of the function.  We mask away the high 32 bits of
> > > > "req.len" so that's capped at U32_MAX but the "req.start" variable can go
> > > > up to U64_MAX.
> > > > 
> > > > Use check_add_overflow() to fix this bug.
> > > > 
> > > > Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
> > > 
> > > Hi, Dan. Why this fix tag? I think the adding result('req.start' and
> > > 'req.len') could be overflow too before this commit.
> > > 
> > 
> > I've looked at this again, and I still don't see the bug before the
> > commit.  Secondly, commit a1eda864c04c ("mtdchar: prevent integer
> > overflow in a safety check") is missing a Fixes tag but the message says
> > that it's this commit which introduced the bug.
> 
> Ah, I see. There is not an addition operation for 'req.start' and 'req.len'
> until commit 6420ac0af95d("mtdchar: prevent unbounded allocation in MEMWRITE
> ioctl") and 095bb6e44eb1("mtdchar: add MEMREAD ioctl"), so I guess the there
> should be two fix tags?

Ah, sure.  I can tag both those commits.

regards,
dan carpenter


